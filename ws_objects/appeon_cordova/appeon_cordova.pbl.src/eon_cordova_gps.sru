$PBExportHeader$eon_cordova_gps.sru
forward
global type eon_cordova_gps from eon_cordova_base
end type
end forward

global type eon_cordova_gps from eon_cordova_base
end type
global eon_cordova_gps eon_cordova_gps

type variables
eon_str_cordova_gps_info  ieon_gps_info  //Gets the location data.
end variables

forward prototypes
public subroutine of_start ()
public subroutine of_stop ()
public function integer of_init ()
public function string of_configure (eon_str_cordova_gps astr_gps)
end prototypes

public subroutine of_start ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_start()
//------------------------------------------------------------------------------
// Description: 
//				Enables location tracking.
//	             Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  None
//						
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return

ieon_ole.start()


end subroutine

public subroutine of_stop ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_stop()
//------------------------------------------------------------------------------
// Description: 
//				Disables location tracking.
//	             Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  None	
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return

ieon_ole.stop()

end subroutine

public function integer of_init ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_init()
//------------------------------------------------------------------------------
// Description: 
//				Connects with the Cordova plugin, detects if the plugin is available to call, and binds with the Cordova object.
//	             Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  integer
//				1 - Success.
//				-1 - It is called in PowerBuilder or Appeon Web, or there is an error.
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
long  ll_return

If appeongetclienttype()<>"MOBILE" Then
	return -1
End if

ll_return = of_init("backgroundGeoLocation")

return ll_return

end function

public function string of_configure (eon_str_cordova_gps astr_gps);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_configure()
//------------------------------------------------------------------------------
// Description: 
//				Configures the parameters for the GPS search.
//	              Supported on mobile client only.
//                
// Arguments: 
//               eon_str_cordova_gps  astr_gps
//               desiredAccuracy  The desired accuracy of the geolocation system. Values: 0 (highest power, highest accuracy), 10, 100, 1000 (lowest power, lowest accuracy). 
//			    stationaryRadius  When stopped, the minimum distance the device must move beyond the stationary location for aggressive background-tracking to engage.
//               distanceFilter       The minimum distance (measured in meters) a device must move horizontally before an update event is generated
//
// Returns:  (none)
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return

eon_cjsonnode  leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "desiredAccuracy", astr_gps.desiredaccuracy)
leon_node.of_addkey( "stationaryRadius",astr_gps.stationaryRadius)
leon_node.of_addkey( "distanceFilter", astr_gps.distanceFilter)
leon_node.of_addkey( "debug",false)
leon_node.of_addkey( "stopOnTerminate",true)
ls_return = ieon_ole.configure("@oe_success","@oe_error",leon_node.of_tostring( ))
destroy leon_node
return ls_return
end function

on eon_cordova_gps.create
call super::create
end on

on eon_cordova_gps.destroy
call super::destroy
end on

event oe_success;call super::oe_success;//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: oe_success
//------------------------------------------------------------------------------
// Description: 
//                  The success callback event, triggered when GPS successfully gets the location data.
//	                Supported on mobile client only.
//
// Arguments: 
//		value  	string		 as_message	JSON-format string which contains the location data.
//
// Returns:  (None)
//
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

long ll_loop
string ls_key,ls_data
boolean lb_data
eon_cjsonnode  leon_js
leon_js = create eon_cjsonnode
leon_js.of_clearnode( )
leon_js.of_load( as_message)
for ll_loop = 1 to leon_js.of_size()
	ls_key = leon_js.of_getkeybyindex(ll_loop)
	choose case leon_js.of_gettypebyindex(ll_loop)
		case 1
			ls_data = leon_js.of_valuestring( ls_key)
		case 2
			ls_data = string(leon_js.of_valuedouble(ls_key))
		case 3
			lb_data = leon_js.of_valueboolean(ls_key)
	end choose
	choose case lower(ls_key)
		case "latitude"
			ieon_gps_info.latitude = dec(ls_data)
		case "time"
			ieon_gps_info.time = long(ls_data)
		case "serviceprovider"
			ieon_gps_info.serviceProvider = ls_data
		case "debug"
			ieon_gps_info.debug = lb_data
		case "longitude"
			ieon_gps_info.longitude = dec(ls_data)
		case "accuracy"
			ieon_gps_info.accuracy = dec(ls_data)
		case "speed"
			ieon_gps_info.speed = dec(ls_data)
		case "altitude"
			ieon_gps_info.altitude = dec(ls_data)
		case "bearing"
			ieon_gps_info.bearing = dec(ls_data)
	end choose
next

ieon_ole.finish()

destroy leon_js
end event

