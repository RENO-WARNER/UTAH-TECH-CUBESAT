Papers

* [
Empirical Analysis of Common Subgraph
Isomorphism Approaches to the Lost-in-Space Star
Identification Problem](https://arxiv.org/pdf/1808.08686)
```
The Angle strategy is the simplest of the six and has the fastest query step, but its runtime is heavily impacted by the |R| = 1 criterion and DMT process.
The Interior Angle strategy is the fastest running strategy under no noise, but its accuracy is the most sensitive to varying Gaussian noise and it has the slowest query step.
The Spherical Triangle strategy's accuracy is the least sensitive to varying Gaussian noise, but is the most sensitive to varying amounts of false stars.
The Planar Triangle is on average faster than the Spherical Triangle strategy, but is also very sensitive to varying amounts of false stars.
The Pyramid strategy is the fastest strategy given varying amounts of Gaussian noise \& false stars and is also the most accurate given varying amounts of spikes.
The Composite Pyramid strategy attempts to simplify the candidate retrieval process of the Pyramid method, but does not achieve the same consistent performance of the Pyramid or the triangle strategies due to the number of filters implemented.

Overall, the Pyramid strategy handles both Gaussian noise and false stars the best in a reasonable amount of time.
```

Extract Features > Transform them through Function > Identify

Extract
* Convert to GrayScale
* Blur Image iwht normalized Box Filter
* Convert to Binary Black/White Scale
* Find Contours
* Compute Moment of Contour
* Compute Center of Mass from Moment
* Translate pixels so that (0,0) is centered
* Inverse Mercator Projection with ellipsoid
* Project to Vector3D
Identify
* Repeat over every pair of Star(i,j)
	* Return if too many comparisons(e.g. Lose Hope)

	* Find possible pair(A B)
		* Compute theta between two stars
		* If angle is too wide(> FOV) continue
		* Search Database for two stars that match angle with epsilon
		* If no pair is found continue

	* Generate possible neably stars
		* Loop through Database
		* Add within Angle of FOV(Could be improvd)

	* DMT(Direct Match Test) List of possible candiate stars along with the possible pair
		* Repeat by flipping which star is at what position(e.g. STAR A == position 1 || STAR B == position 2)
		* Compute Quaternion between A/B

		* For every possible nearby stars
			* Rotate star by quarternion
			
			* Repeat for every star in the image
				* If Star is with epsilon angle of possible nearby stars
				


