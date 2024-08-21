### Active Components
* 
* RF Connectors
* sadf
* asdf

Bus


RF Connectors


Quetzal Uses 3mm standoffs


SPV1040 -> Battery Charger -> SPMP -> Fuse -> Power
						   -> SPMP -> Fuse
Enable of the SPMP or Fuse could prevent power from being transmitted except for a simple low quisient LDO for RTC. 100mA
No Need for current monitoring. Just for battery, then use software to fix it.

Why choosing a Backplane
* Allow communications to get throuhgh dense MicroU confiurations such as CONTROL
* Ignore the need to buy sepetate stack heigh connectors
* Avoid having super long unshielded wires
* We already are going to have to line up RF and solar panel connectors so why not make it simpler

### Choosing Rail Voltage
* Oresat 6/7.2/8.4 V with SPMS on every board
* Queztal Dual Rail 3.3V / 5V
### Choosing Protocols
* CAN
	* Bad: Each board needs its own microcontroller
		* More Code
		* Mode Complexity
		* More Cost
* UART
	* 2 Wire
* I2C
	* Slow over long distances
* SPI
	* Multiple peripherals

Power
5V Heavy Duty 2
3.3V Lower Duty 2
3.3V Always on 1 
10xGPIO
2xSPI 6
1xUART 3
Reserved 4
56

Pitch?

MicroU
11.6mm
composed of 
10mm standoff
1.6mm PCB or 1.6mm Washer





# SOLAR
What ever Bus uses
# BUS
Samtec 
* Flexible Stacking
* ELP High Mating Cycle

### How many pins?
Functions
UART


# RF

Jack: Female
Plug: Male

Possibly Use SMPM Oresat uses it.

Shared Bullet Jack
SMPM: 4 mm edge-edge thickness Possible Spring Loaded
SMP: 6.4 mm edge-edge thickness 

Integrated Plug/Jack
SMB: X
MCX: 6 mm
MMCX: 3.4 mm 

Either SMPM/MMCX

MMCX: $5 7.6 G 
MCX: $5
SMPM: $15 20 G BAD FOOTPRINT ALLOWS FOR X Y COMPENSATION

BUS will have Jack Connections Female


Fuse 
WITH REVERSE CURRENT PROTECTION
to prevent it from effecting the bus.


Isolation
[SPI]

Use digital Isolators
Make sure that it either has high impedance or floating when not enabled.
Have enabled when connected to GPIO
IMPORTANT connect other side on using the fused 3v3.

Use SPI

Notes
Queztal uses a rotating carousel

