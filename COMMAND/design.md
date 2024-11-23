### Active Components
* MCU
* Connectors
	* Peripherals
	* RF
* Memory


### BUS
Requirements:
* Redudant
* Universal

#### Voltage Selection
* Oresat 6/7.2/8.4 V with SPMS on every board
* Queztal Dual Rail 3.3V / 5V


Dual
* Simpler

### Choosing Protocols
* ~~CAN~~
	* Bad: Each board needs its own microcontroller
		* More Code
		* Mode Complexity
		* More Cost
* UART
	* 2 Wire
	* Asynchrounous
* ~~I2C~~
	* Bidirectional Makes it worse for communicating
	* Slow over long distances
* SPI
	* Multiple peripherals
	* Fast
	* Directional


### MCU
Requirements:
* FPU
* Low-Power
* AES
* SPI


LQFP64

Why STM32?
* Low-Power
* ECC(Error Correction Codes)
* Rust Support
* Rich Feature set of Peripherals


STM32 ECC lineup
* U5
* H5
* H7

STM32U5 with AES encryption support
* ~~45~~ NOT HS
* ~~85~~ NOT HS
* A5 HS
* A9 HS
* ~~G9 HS~~
* ~~G7 HS~~

FPU

STM32U5A5ZJ
STM32U5A5RJ

#### Debug
* USB pad
* UART connector
* SWD debug port
* Test points for bus.

TEST MODE
UART -> GPIO


### Connectors

Pitch
* 0.1"
	* Common
	* "Larger"
* 2.0 mm
	* Still Solderable
	* "Smaller"

### EFUSE
* Adjustable Overcurrent
* Enable Pin

* Reverse Current Prefered

### ISOLATOR
* Hi Z when not enabled




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

Power
GND 4
5V Heavy Duty 2
3.3V Lower Duty 2
3.3V Always on 1 
2xSPI 6
10xGPIO
Reserved 4
24

GND 2

5 V HEAVY DUTY 2


GND 2

Solar
	GND 2
	SOLAR 2 

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


Look At Tiger EYE
* 1.27 mm
* 2.00 mm

Tiger Eye
* High-Reliability
* High Mating-Cycles

Tiger Buy
* Cost Effective(More Worse)
* High Retention

Tiger Beam
* Best Cost(Worst)

E.L.P
~~BCS: Tiger Clas no SMD~~
TSW

CLM
* 1 mm Pitch
* Tiger Claw

FTMH
* 

CLP
* 0.05" Pitch
* Tiger Claw

FLE

TSM
* 0.1" Pitch
* SET

SSM
* 0.1" Pitch
* SET
* Tiger Claw

NNOOOOOO SILKSCREEN UNDER ANYYYY COMPONENTS
ok bye

* MMS
* SSM

* PROGRAMMER
	~~* ST-LINK V2-ISOL~~
		~~* ISOLATION~~
	* ~~STLINK-V3MODS~~

	* STLKINK-V3MINIE
		* 1.6 ~ 3.6 V
		* 1.27 mm pitch STDC14 debug connector
	* STLINK-V3SET
		* ~~3.0 ~ 3.6 V~~
		*  STDC14 to MIPI10/STDC14/MIPI20 
	* ~~STLINK-V3PWR~~
		* 1.6 ~ 3.6 V
		* 1.27 mm
		* Three STDC14 to MIPI10 / STDC14 / MIPI20 flat cables with 1.27 mm pitch connectors
		* 95

* Crystal

	* CL1
	* CL2


Reliability of Buses 
	https://ntrs.nasa.gov/api/citations/20000053469/downloads/20000053469.pdf



* UPDATED BUS
	* CAN
		* COMMUNICATED ALL DATA(EXCEPT POWER)

		* BOOTLOADING AND UPDATING FIRMWARE

* BOOTLOADING
	* BOOT = 
	* GLOBAL VS LOCAL RESET?

	STM32U5A5
	STM32U5A9

	Pattern 12
	boot model v3.1
	
	HSI 60 Mhz
		Derived 20 Mhz FDCAN
	HSE Enabled
		8 N < 32 Mhz uSBPHY ONLY if USB

	16 kBytes

	*FDCAN
		– Connection bit rate 250 kbit/s
– Data bit rate 1000 kbit/s
– FrameFormat = FDCAN_FRAME_FD_BRS
– Mode = FDCAN_MODE_NORMAL
– AutoRetransmission = ENABLE
– TransmitPause = DISABLE
– ProtocolException = ENABLE
		PB8 RX Recieve
		PB9 TX Output

	To Activate Bootloader
		BOOT0 - PH3-BOOT0

		* CAN FD
			* 64 Bytes
			
		* USB
	

	CAN Transcievers
		* Isolated
			* ISO1042
			* ISO1044
		* Not-Isolated




EXTERNAL
	PROGRAMMER
		STVLINK-V3

CARD
	BUS
		POWER
			GND 2 ~ 4
			VBAT 2 ~ 4
			ALWAYS ON 3.3V 1
			SOLAR 3
		SHUTDOWN 2
		CAN
			H 1
			L 1
		USB
			DP 1
			DM 1
		PHOTO DIODE
			5


	POWER
		SOLAR: SM811K08TF
		MONITOR: INA260
		EFUSE: 
		LDO: 
		SMPS: 

	COMMAND
		CAN: TCAN3413(Q possible)
		MCU: STM32U5A5(LQFP64) SYMBOL
		DEBUG: STC14 CONNECTOR
		BULK MEMORY: SD CARD / EMMC
		FRAM?
		RTC?
		CAMERA?
	COMMUNICATION
		TRANSCIEVER: E22-400M30S
		RF COUPLER: 
		RF DETECTOR: LMH2100 / LMV221

		-45 dbm to -5 dbm
	CONTROL
		MAGNETOMETER: LIS3DML
		IMU: LSM6DSO
		QUADRANT PHOTODIODE: K857PE
	GENERIC
		CAPACITORS: MURATA
		RESISTORS: Yaego
		Hardware(Standoffs / Nuts): RAF Electronic Hardware

8 Mhz
32.768 Khz

ECS-.327-6-34QCS-TR
	CL: 6 pf
	C0: 1.1pF
ECS-80-8-30BQ-JES-TR
	CL: 8pf
	C0: 7pf


ERROR CHECKING
	I REPEAT
	I REPEAT
	I REPEAT
	ALL INTERFACES NEED TIMEOUTS, THEY CAN BE LONG BUT THEY ARE NECESSARY
	PLEASE ABSTRACT FIRST
	THAT WAY WE CAN JUST HANDLE AN ERROR QUICKLY


RESET
BOOT MAYBE
EFUSE?
EFUSE STATUS?
CAN TRANSMIT?


DEPLOYMENT
	GYROSCOPE TESTING

NO BGA
NO CSP / WLCSP
NO THROUGH HOLE
	DIP / SIP / QIP
TOO BIG

QFP
QFN / VQFN / WQFN / UQFN

SOP


I2C EXPANDER: TCA9538 / TCAL9538
DROP IN REPLACEMENT
TSSOP

USB SWITCH: TS3USB221E

MEMORY
	Up To SDMMC 5.1
		1 bit
		4 bit 
		8 bit
		HS4000 not supported


BOOTLOADER IDS
	Don't Know?
	Let's just try
	Doesn't matter because boot0 determines it. I guess we could just use the one I2C but who cares.


Sorry for anyone reading this.