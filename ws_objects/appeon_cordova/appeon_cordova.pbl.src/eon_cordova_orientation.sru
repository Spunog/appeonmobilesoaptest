$PBExportHeader$eon_cordova_orientation.sru
forward
global type eon_cordova_orientation from eon_cordova_base
end type
end forward

global type eon_cordova_orientation from eon_cordova_base
end type
global eon_cordova_orientation eon_cordova_orientation

type variables
eon_str_cordova_orientation  ieon_str_orientation
end variables

forward prototypes
public function integer of_init ()
public subroutine of_getcurrentheading ()
public function string of_watchheading (long al_frequency, decimal ad_filter)
public subroutine of_clearwatch (string as_watchid)
end prototypes

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

ll_return = of_init("navigator.compass")

return ll_return

end function

public subroutine of_getcurrentheading ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_getcurrentheading()
//------------------------------------------------------------------------------
// Description: 
//                Gets the device's current heading/direction.
//	              Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  None	
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================


ieon_ole.getcurrentheading("@oe_success","@oe_error")

end subroutine

public function string of_watchheading (long al_frequency, decimal ad_filter);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_watchheading()
//------------------------------------------------------------------------------
// Description: 
//               Gets the device's current heading/direction at a regular interval.
//	             Supported on mobile client only.
//                
// Arguments: 
//               long  al_frequency   	How often to retrieve the device's heading in milliseconds (default: 100)
//               decimal  ad_filter        The change in degrees required to retrieve the heading. It is supported in iOS only.
//				                                When this parameter is set, al_frequency is ignored.
//
// Returns:  string
//				Watch ID is returned and can be used by of_clearwatch.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

string ls_watchid
eon_cjsonnode  leon_node
leon_node = create eon_cjsonnode
leon_node.of_addkey("frequency",al_frequency)
if	of_isios() then
	leon_node.of_addkey( "filter", ad_filter)
end if
ieon_ole.watchHeading("@oe_success","@oe_error",leon_node.of_tostring())
ls_watchid = of_getlastreturn()

destroy leon_node

return ls_watchid



end function

public subroutine of_clearwatch (string as_watchid);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_clearwatch()
//------------------------------------------------------------------------------
// Description: 
//                Stops watching the device's heading according to the specified watch ID.
//	              Supported on mobile client only.
//                
// Arguments: 
//               string  as_watchid      Watch ID returned by of_watchheading.
//
// Returns:  None	
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_watchid

ls_watchid = "'"+as_watchid+"'"

ieon_ole.clearwatch(ls_watchid)

end subroutine

on eon_cordova_orientation.create
call super::create
end on

on eon_cordova_orientation.destroy
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
//                 The success callback event, triggered when the device's heading is retrieved successfully.
//	               Supported on mobile client only.
//
// Arguments: 
//		value  string as_message		A JSON-format string which contains the heading information.
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
		case 0
			ls_data = "NULL"
	end choose
	choose case lower(ls_key)
		case "magneticheading"
			if ls_data = 'NULL' then
				ieon_str_orientation.magneticheading = 0
			else
				ieon_str_orientation.magneticheading = dec(ls_data)
			end if
		case "timestamp"
			if ls_data = 'NULL' then
				ieon_str_orientation.timestamp = 0
			else
				ieon_str_orientation.timestamp = dec(ls_data)
			end if
		case "trueheading"
			if ls_data = 'NULL' then
				ieon_str_orientation.trueheading = 0
			else
				ieon_str_orientation.trueheading = dec(ls_data)
			end if
		case "headingaccuracy"
			if ls_data = 'NULL' then
				ieon_str_orientation.headingaccuracy = 0
			else
				ieon_str_orientation.headingaccuracy = long(ls_data)
			end if
	end choose
next
ieon_ole.finish()

destroy leon_js
end event

