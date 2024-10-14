Power Providers
	* Overvoltage Protection

Power consumers
	* Overcurrent Protection

Multiple Power Providers
	* ORed together 

SPI bus design:

No isolation (due to 3.3V operation)
Considering tristate buffers to remove components from the bus

a. Tristate buffers:
Implement these as planned. They allow you to disconnect devices from the bus when not in use, reducing the risk of a failed device affecting the entire bus.
b. Series resistors:
Add small series resistors (e.g., 22-33 ohms) on each SPI line. This can help limit current in case of short circuits and reduce reflections on the bus.
c. TVS (Transient Voltage Suppression) diodes:
Although you're operating at 3.3V, adding low-capacitance TVS diodes can protect against ESD events and other transient voltages that might occur during operation or handling.
d. Watchdog timers:
Implement watchdog timers for critical SPI devices. If a device becomes unresponsive, the watchdog can reset it or notify the main controller.
e. Error detection:
Implement CRC or other error detection mechanisms in your SPI communication protocol. This can help identify data corruption.
f. Multiple SPI buses:
Consider using multiple independent SPI buses for critical subsystems. This provides redundancy and isolation between different parts of your CubeSat.
g. Pull-up/Pull-down resistors:
Ensure proper pull-up or pull-down resistors are in place to define the state of the bus when devices are tristated.
h. Fault-tolerant architecture:
Implement a fault-tolerant SPI controller that can detect and recover from communication errors.
i. Redundant controllers:
For critical systems, consider implementing redundant SPI controllers that can take over if the primary controller fails.
j. Current-limiting buffers:
Use current-limiting buffers on the SPI lines to protect against overcurrent situations.
k. Power sequencing:
Implement proper power sequencing to ensure SPI devices are powered up and down in the correct order, preventing potential bus contention issues.
l. EMI protection:
While not directly related to the SPI bus, ensure proper EMI shielding and filtering for your entire CubeSat design to minimize interference that could affect SPI communication.

EFUSES
* LM25069

	* MOSFET
	* 19.5 V > Gate

EFuses
	50 mA -> 10 Amps
	Enable
	Fault-Preferablly

	* STM32
		3.3 V
		1 - 1.75 A
		Tri State Enable/Fault which is nice but hard to use.

	INTERNAL FET 
	* TPS24700 
		* Enable is Active high
		* Fast Trip!
		* Adjustable
		* 8 pins
		* Pgb Active-low used to determine status.
		* No overvoltage
		
	* TPS2471X
		* Active-high enable
		* No overvoltage
		* Adjustable Current

	* LM25069/LM25061
		* 0.25 - Inf Amps
		* Overvoltage
		* Pull Down needed to shut off. So turn on allows every component, which could cause infinite loop?





	



* ANALOG


IDEAL DIODE
	Enable Preffered
	30 mA max reverse current
	Prefer Overvoltage Protection
	ORing
	> 10 Amps