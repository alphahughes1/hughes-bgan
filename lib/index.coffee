
# Used to lock, unlock or interrogate a MT facility. Password is
# normally needed to do such actions.
# <fac>: string;
# "AD" Administrator Lock
# "RS" Remote SMS Lock Status
# <mode>: decimal (0-2);
# 0 unlock
# 1 lock
# 2 query status
# <password>: string
# <status>: decimal (0-1);
# 0 not active
_iclck = (facility, mode, password) -> #socket.write('at_iclck="ad",0,"admin"\r\n');

# Sets a new password for the facility lock function defined by command
# _ICLCK.
# <fac>: string;
# "AD" Administrator Lock
# "RS" Remote SMS Lock Status
# <oldpwd>: string (oldpwd)
# <newpwd>: string (newpwd)
_icpwd = (facility, oldPassword, newPassword) ->

# Used to enter/exit antenna pointing mode
# <exit_pointing>: decimal (0-1); Exit Pointing
# 0 Antenna Pointing Active
# 1 Antenna Pointing Terminated
# <ipoint_reporting>: decimal (0-1); Unsolicited Reports
# 0 Disable unsolicited result codes
# 1 Enable unsolicited result codes
_ipoint = ->

# Supports read/set operations on GPS location. Unsolicited results 
# <lat_deg>: decimal (-90.00-90.00); Latitude in decimal degrees (minutes & seconds 
# converted to decimal degrees)
# <lon_deg>: decimal (-180.00-180.00); Longitude, also in decimal
# <type>: string constant ("2D","3D","Stored","Acquiring"); Fix Quality
# "2D", GPS receiver has a 2D fix
# "3D", GPS receiver has a 3D fix
# "Stored", GPS receiver is off – Lat & Lon are stored
# values of latest fix
# "Acquiring", attempting to acquire a fix
# <status>: string constant ("allowed","barred","undetermined"); Fix status
# "allowed" Terminal is permitted to display GPS
# "barred" GPS operation barred at the location
# "undetermined" GPS network-policy not received
# <time>: decimal; Timestamp
_igps = ->

# Used to query the status of network interface. 
# <func>: string constant ("ETH","WLAN","USB","ISDN"); Interface
# "ETH" Ethernet
# "WLAN" Wireless LAN
# "USB" USB
# "ISDN" ISDN
# <dec-value>: decimal (0-1); Parameter Value
# 0 OFF
# 1 ON 
_inis = ->

# To query the MT temperature and for unsolicited temperature reports
# <mt_thermal_status>: decimal (0-4); MT Temperature Status
# <mt_thermal_scale>: decimal (20-40); MT Temperature Scale
_itemp = ->

# Retrieve syslog file from BGAN terminal. 
# <logfile>: string (syslog); log file name
# <lines>: decimal (0-65535); lines to items to return
# <action>: decimal (0-1); action command 
# 0 No action(default)
# 1 Erase log file(not supported)
# <start>: decimal (0-65535); start offset
_ilog = ->

# Indicates the sleep status information. Unsolicited reporting of sleep state 
# <mt_sleep_status>: decimal (0-1); MT Sleep Status
# <mt_sleep_timeout>: decimal (20-40); Time left for the MT to go to sleep
_isleep = ->

# Used for querying C/No values or request C/No reports. 
# <cn0_report>: decimal (0-1); C/No reports
# 0 Disable unsolicited result code
# 1 Enable unsolicited result code
# <interval>: decimal (0-255); Parameter Value
# <c_n0_value>: decimal (0-255); C/No Value
_isig = ->

# Alarm Category & Condition Indicator. 
# <rep_mode>: decimal (0-1); Reporting mode
# 0 Basic mode
# 1 Verbose mode
# <alarm_status>: decimal (0-1); Outstanding Alarms/Status
# 0 Alarm Inactive
# 1 Alarm Active
# <alarm_catg>: decimal (1-10); Alarms Category
# 1 SIM PIN Error
# 2 PCB Core Overheat
# 3 GPS HW Failure
# 4 GPS Communication Failure
# 5 Antenna Communication Failure
# 6 SIM Not Present
# 7 Battery Low (N/A some platforms)
# 8 Battery Overheat (N/A some platforms)
# 9 SIM Not Supported
# 10 BDE <-> Antenna Mismatch 
_ibalarm = ->

# CM satellite table information. 
# <sat_id>: decimal (1-32); Satellite ID
# <lon_deg>: decimal (0.0-359.9); Longitude-degrees
_isatinfo = ->

# CM satellite table information
# <sat_id>: decimal (1-32); Satellite ID
# <elevation>: decimal (0-90); Satellite elevation
_isatvis = ->

# CM satellite table information. 
# <sat_id>: decimal (1-255); Satellite ID
_isatcur = ->

# Control sending of unsolicited result codes for commands
# "_IGPS","_IPOINT","_ITEMP","_ISIG","_ISLEEP","_IMETER","+CBC","+
# CGEV","+CLCC","+CGPADDR","_IHGF","_IHREBOOT","_IHSTATUS","+
# CMTI" ,"_IHPIN","_IHPACKET","_IHSMS","_IHBEAM", and "_IBALARM". 
# <command_code>: string; Command codes 
# "_IGPS" unsolicited result code
# "_IPOINT" unsolicited result code
# "_ITEMP" unsolicited result code
# "_ISIG" unsolicited result code
# "_ISLEEP" unsolicited result code
# "_IMETER" unsolicited result code
# "+CBC" unsolicited result code
# "+CGEV" unsolicited result code
# "+CLCC" unsolicited result code
# "+CGPADDR" unsolicited result code
# "_IHGF" unsolicited result code
# "_IHREBOOT" unsolicited result code
# "_IHSTATUS" unsolicited result code
# "+CMTI" unsolicited result code
# "_IHPIN" unsolicited result code
# "_IHPACKET" unsolicited result code
# "_IHSMS" unsolicited result code
# "_IHBEAM" unsolicited result code
# "_IBALARM" unsolicited result code
# <status>: decimal (0-1); On/Off
# 0 Disable the sending of this unsolicited result code
# 1 Enable the sending of this unsolicited result code
_ibnotify = ->

# Unsolicited error reports
# <rejCode>: decimal (1-5); Rejection codes
# 1 ierror_code_rnc_failure
# 2 ierror_code_congestion
# 3 ierror_code_unsupported_lai
# 4 ierror_code_unsupported_ue_class
# 5 ierror_code_usim_required
# <deregCode>: decimal (11-20); Deregistration codes
# 11 ierror_code_reg_completion_failure
# 12 ierror_code_service_area_barred
# 13 ierror_code_gps_position_required
# 14 ierror_code_network_reset
# 15 ierror_code_ue_inactivity
# 16 ierror_code_pos_not_received
# 17 ierror_code_fix_old
# 18 ierror_code_decryption_error
# 19 ierror_code_invalid_gps_pos
# 20 ierror_code_oper_initialted_dereg 
_ierror = ->

# Returns information to identify the ME manufacturer. 
cgmi = ->

# Returns information to identify the ME model. 
cgmm = ->

# Returns information to identify the ME manufacturer name. 
cgmn = ->

# Returns information to identify the ME part number. 
cgmp = ->

# Returns information to identify the ME version, revision level or date. 
cgmr = ->

# Returns information to identify the ME serial number. 
cgms = ->

# Returns information to identify the individual ME. Typically IMEI
# (International Mobile station Equipment Identity). 
cgsn = ->

# Return IMSI to identify the individual SIM card 
cimi = ->

# Allows control of the Unstructured Supplementary Service Data(USSD)
# according to 3GPP TS 22.090 [23]. Both network and mobile initiated
# operations are supported. 
# <n>: decimal (0-2); Disable/Enable +CUSD Result Code
# <str>: string; USSD string
# <dcs>: decimal (0); Data Coding Scheme
# <m>: decimal (0-5); m value
cusd = ->

# Used to interrogate the ME before requesting action from the phone. 
# <pas>: decimal (0-5);
# 0 ready (ME allows commands from TA/TE)
# 1 unavailable (ME does not allow commands from TA/TE)
# 2 unknown
# 3 ringing (ready, but the ringer is active)
# 4 call in progress (ready, but a call is active)
# 5 asleep (ME is unable to process commands from TA/TE because it is
# in low functionality state) 
cpas = ->

# Selects the level of functionality in the ME. 
# <level>: decimal (0-5);
# 0 minimum functionality
# 1 full functionality
# 2 FUN_NO_TRANSMIT
# 3 FUN_NO_RECEIVE
# 4 FUN_NO_T_AND_R
# 5 FUN_RESERVED
# <reset>: decimal (0-1); Reset the ME before setting it to <level>
# 0 no
# 1 yes 
cfun = ->

# Sends to the ME a password which is necessary before it can be operated.
# If the PIN required is a PUK, a new PIN must also be given. 
# <pin>: string
# <newpin>: string
# <code>: alphanumeric
cpin = ->

# Returns battery connection status <bcs> and battery charge level <bcl> of
# the ME. 
# <bcs>: decimal (0-3);
# 0 ME is powered by the battery
# 1 ME has a battery connected, but is not powered by it
# 2 ME does not have a battery connected
# 3 Recognized power fault, calls inhibited
# <bcl>: decimal (0-100);
# 0 battery exhausted or not connected
# 1-100 percent of capacity remaining 
cbc = ->

# Defines the reporting of ME errors. See ERROR, +CME, +CMS. 
# <level>: decimal (0-2); +CME ERROR <err> result code
# 0 disabled - instead ERROR is used
# 1 enabled - numeric <err> values
# 2 enabled - verbose <err> values 
cmee = ->

# Activate or deactivate the specified PDP context(s). 
# <state>: decimal (0-1);
# 0 deactivated
# 1 activated
# <cid>: decimal (1-11); PDP Context Identifier
cgact = ->

# Specifies PDP address for specified context identification parameter <cid> 
# <cid>: decimal (1-11); PDP Context Identifier
# <pdp_address>: string; PDP address
cgpaddr = ->

# Allows TE to query terminal status. 
# <param>: string constant
# ("CIPH","CONN","TRAF","FLTS","MAC","GPS","WLAN","CSC","CLASS"
# ); BGAN Terminal Status Parameters
# "CIPH" Ciphering
# "CONN" Connectivity
# "TRAF" Traffic Monitor
# "FLTS" Faults
# "MAC" MAC Address
# "GPS" GPS Status & Position
# "WLAN" Wireless LAN Status
# "CSC" Circuit Switched Connection Status
# "CLASS" UE Class
# <dec_value>
# :
# decimal (0-1); Parameter Value
# 0 OFF
# 1 ON
# <str_value>: string; Parameter Value
_ihstatus = ->

# Allows TE to configure UT specific parameters. 
# <set
# >:
# string constant
# ("MSN_SPEECH","MSN_AUDIO","MSN_UDI","MSN_RDI","SAT_SELECT","MAN
# _NAME","MAN_ID","MODEL_NO","PART_NO","SERIAL_NO","REV_ID");
# BGAN terminal Parameters
# "MSN_SPEECH" ISDN MSN_SPEECH
# "MSN_AUDIO" ISDN MSN_AUDIO
# "MSN_UDI" ISDN MSN_UDI
# "MSN_RDI" ISDN MSN_RDI
# "SAT_SELECT" DEFAULT SATELLITE SELECTION
# "MAN_NAME" MANUFACTURER NAME
# "MAN_ID" MANUFACTURER ID
# "MODEL_NO" MANUFACTURER MODEL NUMBER
# "PART_NO" MANUFACTURER PART NUMBER
# "SERIAL_NO" MANUFACTURER SERIAL NUMBER
# "REV_ID" MANUFACTURER REVISION NUMBER
# <str
# -
# valu
# e>: 
_ihset = ->

# Allows TE to configure UT specific parameters. 
# <param>: string constant ("SW","FW","ROM","IMEI","PIC"); BGAN Terminal
# Version Info
# "SW" software version
# "FW" firmware version
# "ROM" ROM version
# "IMEI" IMEI of the unit
# "PIC" PIC version
# <str-value>: string; Parameter Value
_ihread = ->

# CM scans PSAB channel found by ADE and reports acquisition status. 
# <sat_id>: decimal (0-15); Satellite ID
# <desired_sat>: decimal (0-15); Desired Satellite ID
# <lon_deg>: decimal (0-180); Longitude-degrees
# <lon_min>: decimal (0-59); Longitude-minutes
# <lon_sense>: decimal (0-1); Longitude-sense
# 0 East (+)
# 1 West (-)
# <frequency>: decimal (6000-19600); Frequency
# <offset>: decimal (0-1); 1.25 kHz offset disable/enable
# <frequency>: decimal (6000-19600); Frequency
# <offset>: decimal (0-1); 1.25 kHz offset disable/enable
# <coverage_type>: decimal (0-2);
# 0 no coverage
# 1 1-satellite coverage
# 2 overlap coverage 
_ihgf = ->

# User may use to reboot terminal from handset menu (if applicable). 
_ihreboot = ->

# Report beam ID in which UT is operating. 
# <beam_report>: decimal (0-1);
# 0 Disable unsolicited result code
# 1 Enable unsolicited result code
# <beam_id>: decimal (0-255); spot beam ID
_ihbeam = ->

# Terminal initiated PING. 
# <ip_addr>: string (IP); Destination IP address
# <pkt_count>: decimal (1-255); Packet Count
# <pkt_size>: decimal (0-65535); Packet Size
# <pkt_ttl>: decimal (0-255); Packet Time to Live (hops)
# <rpt_mode>: decimal (0-1); Unsolicited reporting mode
# 0 Disable unsolicited result codes
# 1 Enable unsolicited result codes
# <ip_addr2>: string (IP); Second Destination IP address
# <ip_addr3>: string (IP); Third Destination IP address
# <wdog_mode>: decimal (0-1); Watchdog mode
# 0 Disable Watchdog
# 1 Enable Watchdog
# 2 [Status Only]: Watchdog Disabled and all 3 Ping addresses
# invalid
# <wdog_freq>: decimal (0-65535); Watchdog frequency, in minutes
# <wdog_ping_mode>: decimal (0-1); Watchdog Require Ping mode
# 0 Disable Require Ping receipt
# 1 Enable Require Ping receipt
# <status>: decimal (0-1); ihping success or failure
# 0 success
# 1 failure
# <time>: decimal; ihping packet trip time in milliseconds
_ihping = ->

# Perform Platform Built-in Test (BIT) on UT. 
# <param>: string constant
# ("POST","MEM","IMG","CNF","ETH","ASIC","DSP","USB","ALL");
# Command UT to perform BIT and check status
# "POST" POST RESULTS
# "MEM" MEMORY
# "IMG" IMAGE
# "CNF" CONFIG
# "ETH" ETHERNET
# "ASIC" ASIC
# "DSP" DSP
# "USB" USB
# "ALL" ALL TESTS
# <result>: decimal (0-2); result
_ihpbit = ->

# Configures whether certain events will be reported on the AT interface.
# This command configures whether the unsolicited events shown under
# <event_type> will appear on the AT (port 1829) interface or not. Note that
# when IHEVENTs are reported on the AT interface, they follow the syntax
# "IHEVENT: <event_type>,<event_code>[,<optional_str>]" 
# <report_mode>: decimal (0-1);
# 0 Disable Unsolicited Event Notifications
# 1 Enable Unsolicited Event Notifications
# <event_type>: decimal (1-255);
# 1 registration
# 2 deregistration
# 3 pdp_activation
# 4 pdp_deactivation
# 5 isdn
# 6 sms
# 7 usim
# 8 attach
# 9 detach
# <event_code>: decimal (1-255); event code
# <optional_str>: string; optional character string
_ihevent = ->

# Provides temperature readings. 
# <module>: string constant ("VGA", "PA", "PD", "VR", "ANT", "ALL"); Module
# "VGA" VGA temperature reading
# "PD" Power Detector temperature reading
# "VR" Board temperature reading
# "ALL" All temperature readings
# <value>: decimal; Temperature Value
_ihtemp = ->

