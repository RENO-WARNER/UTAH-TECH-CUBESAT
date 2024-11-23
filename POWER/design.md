Battery Monitor
	Requirements
		Overcharging Protection
		Overdischarging Protection
		Prefer to control both discharging and Overdischarging
		Shutdown preffered
		Cell Balancing

	BQ76905

	 *Shutdown requires diodes to prevent everything from overvolting*


Ideal Diode
	LM7480 / LM7481
	
	

MPPT
	May need load resistors to calculate ideal experimentally?
	Curves change per conditions / temperature.
	Buck Converter or Boost converter.
	5.5 4.8
	Buck Con

	Requirements
		Input
			Voltage: 4 V ~ 6 V
			Power: 0.945
			Current: 5.75 W
			Efficiency: > 90%

		Needs to work regardless of power incoming.
		Needs to work solely from solar panel at least until it powers everything.
		As many amps as possible
		Output 3.2 V ~ 4.2 V

	Buck-Boost
		IN: 4 V ~ 6 V
		OUT: 3.2 V ~ 4.2 V
		Current: 2 A
		SHUT DOWN capability


	LED Driver?
		Input: 2.9 V ~ 18 V
		Output: < 40 V @ 3 A
		93% Efficient
		Set Frequency Nice
		LED Current is set
		Issue: Feedback is after the load, which would be hard.

	TPS92365X
		4.5 V ~ 

	LM5157
		BOOST
			2.9V ~ 18 V 
			Up to 6 Amps
			Adjustable Frequency
			OVP settable
			NOPE can't adjsut current
	TPS61376
		Overvoltage Adjustable
		Boost
		2.9 ~ 23 V
		1.2 Mhz
		Output 4.5 V to 25 V
		UVLO
		Enable Active High / Shutdown Pulled to ground
		High Efficiency at different currents
		Completely Isolated when Disabled
		Average Current Limit

		
	TPS61377
	TPS61376
	TPS61178
	TPS61089
	TPS61088





