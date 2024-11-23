import numpy as np
from sgp4.api import Satrec
from sgp4.api import WGS72
from datetime import datetime, timedelta
from astropy.time import Time
from astropy.coordinates import EarthLocation, ITRS, GCRS, CartesianRepresentation
from astropy import units as u
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
import cartopy.feature as cfeature
from astropy import constants
import geopandas as gpd


# Sample TLE data (replace with real TLE data for accurate results)
line1 = "1 25544U 98067A   24318.40073414  .00018836  00000-0  32023-3 0  9990"
line2 = "2 25544  51.6381 296.1395 0008363 170.0219 190.0938 15.51437269481692"

# Initialize satellite with TLE data
satellite = Satrec.twoline2rv(line1, line2, WGS72)

# Set simulation parameters
start_time = datetime.utcnow()
end_time = start_time + timedelta(minutes=60 * 24 * 5)  # 90-minute simulation for one orbit
time_step = timedelta(seconds=30)

# Store Nadir point coordinates
nadir_lats = []
nadir_lons = []
timestamps = []

# Run simulation
current_time = start_time
while current_time <= end_time:
    # Convert datetime to Julian date for SGP4 propagation
    jd, fr = Time(current_time).jd1, Time(current_time).jd2
    e, r, v = satellite.sgp4(jd, fr)  # ECI coordinates (km)
    
    if e != 0:
        print("Propagation error", e)
        break

    # Convert satellite ECI position to ECEF by transforming to GCRS and then to ITRS
    gcrs = GCRS(CartesianRepresentation(r * u.km), obstime=Time(current_time))
    itrs = gcrs.transform_to(ITRS(obstime=Time(current_time)))
    
    # Calculate the Nadir point (lat, lon) on Earth's surface
    nadir = EarthLocation(itrs.x, itrs.y, itrs.z - 0)  # Adjust to Earth's surface
    nadir_lat = nadir.geodetic.lat.deg
    nadir_lon = nadir.geodetic.lon.deg
    
    # Append results to lists
    nadir_lats.append(nadir_lat)
    nadir_lons.append(nadir_lon)
    timestamps.append(current_time)
    
    # Advance the time step
    current_time += time_step

# Plot ground track of Nadir point with Cartopy
fig, ax = plt.subplots(figsize=(12, 6), subplot_kw={'projection': ccrs.PlateCarree()})
ax.set_global()
ax.stock_img()  # Add Earth image background
ax.coastlines(resolution="50m")  # Coastlines for reference
ax.add_feature(cfeature.BORDERS, linestyle=':', color='gray')  # Country borders

# Plot satellite ground track
track = ax.plot(nadir_lons, nadir_lats, marker='o', markersize=2, linestyle='-', color='blue', transform=ccrs.Geodetic())

# Zoom into the area of interest
lat_margin, lon_margin = 5, 5
#ax.set_extent([-114.0 - lon_margin, -109.0 + lon_margin, 37.0 - lat_margin, 42.0 + lat_margin], crs=ccrs.PlateCarree())

# Highlight Utah specifically by overlaying the boundary
# Load the US states dataset using GeoPandas for more specific access to state boundaries
#us_states = gpd.read_file("https://www.naturalearthdata.com/downloads/110m-cultural-vectors/")
#utah = us_states[(us_states.name == "United States") & (us_states.subregion == "Utah")]

# Utah border coordinates (approximate)
utah_coords = np.array([
    # Starting from northwest corner, moving clockwise
    [-114.052998, 42.001633],  # Northwest corner
    [-111.047063, 42.001633],  # Northern border
    [-111.047063, 41.000659],  # Northeast corner
    [-109.051090, 41.000659],  # Northern border
    [-109.051090, 37.000263],  # Southeast corner
    [-114.052998, 37.000263],  # Southern border
    [-114.052998, 42.001633],  # Back to start
])

ax.plot(utah_coords[:, 0], utah_coords[:, 1], 'b-', linewidth=2)


# Plot Utah's outline
#for geometry in utah.geometry:
  #  ax.plot(*geometry.exterior.xy, color="red", linewidth=2, transform=ccrs.PlateCarree())

# Customize the map view
ax.set_title("Satellite Nadir Point Ground Track with Utah Outline")
ax.gridlines(draw_labels=True, linestyle="--", color="gray")

plt.show()
