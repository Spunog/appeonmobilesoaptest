$PBExportHeader$eon_cordova_bluetooth.sru
forward
global type eon_cordova_bluetooth from eon_cordova_base
end type
end forward

global type eon_cordova_bluetooth from eon_cordova_base
event oe_finish ( string as_message )
end type
global eon_cordova_bluetooth eon_cordova_bluetooth

type variables
eon_str_cordova_bluetooth  ieon_str_bluetooth[]
//stores the information of the found bluetooth device including address and name

long il_type   //functionality extension for developers: 1 - isenabled  2 - search

boolean ib_enabled, ib_search, ib_exist
//ib_enabled indicates whether bluetooth is turned on
//ib_search indicates whether search is successful
//ib_exist indicates whether the device exists in the search list
end variables

forward prototypes
public function integer of_init ()
public subroutine of_enable ()
public subroutine of_disable ()
public subroutine of_startdiscovery ()
public subroutine of_pair (string as_address)
public subroutine of_unpair (string as_address)
public function boolean of_isenable ()
end prototypes

event oe_finish(string as_message);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: oe_finish
//------------------------------------------------------------------------------
// Description: 
//                Occurs when scanning for bluetooth devices is successful. It can be used to scan for bluetooth devices in a loop.
//	              Supported on Android only.
//
// Arguments: 
//		value  string as_message 	A JSON-format string which contains the address and name of the found bluetooth device.
//
// Returns:  (None)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
ieon_ole.stopDiscovery("@","@")
if ib_search then
	il_type = 2
	 ieon_ole.startDiscovery("@oe_success","@oe_finish","@oe_error")
end if
end event

public function integer of_init ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_init()
//------------------------------------------------------------------------------
// Description: 
//				Connects with the Cordova plugin, detects if the plugin is available to call, and binds with the Cordova object.
//	              Supported on Android only.
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


ll_return = of_init("bluetooth")

return ll_return

end function

public subroutine of_enable ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_enable()
//------------------------------------------------------------------------------
// Description: 
//				Turns on bluetooth on the device.
//	             Supported on Android only.            
//                
// Arguments: 
//               None
//
// Returns: None
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
ieon_ole.enable("@oe_success","@oe_error")



end subroutine

public subroutine of_disable ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_disable()
//------------------------------------------------------------------------------
// Description: 
//				Turns off bluetooth on the device.
//	             Supported on Android only.             
//                
// Arguments: 
//               None
//
// Returns: None
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
ieon_ole.disable("@oe_success","@oe_error")



end subroutine

public subroutine of_startdiscovery ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_startdiscovery()
//------------------------------------------------------------------------------
// Description: 
//				Scans for the available bluetooth devices.
//	             Supported on Android only.           
//                
// Arguments: 
//               None
//
// Returns: None
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
il_type = 2
ieon_ole.startDiscovery("@oe_success","@oe_finish","@oe_error")



end subroutine

public subroutine of_pair (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_pair()
//------------------------------------------------------------------------------
// Description: 
//				Pairs your device with a bluetooth device.
//	             Supported on Android only.           
//                
// Arguments: 
//               string  as_address   The address of the bluetooth device you want to pair with your device.
//
// Returns: None
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_address
ls_address = '"'+as_address+'"'
ieon_ole.pair("@oe_success","@oe_error",ls_address)



end subroutine

public subroutine of_unpair (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_unpair()
//------------------------------------------------------------------------------
// Description: 
//				Unpairs a bluetooth device with your device.
//	             Supported on Android only.   
//                
// Arguments: 
//               string as_address   The address of the bluetooth device you want to unpair with your device.
//
// Returns: None
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_address
ls_address = '"'+as_address+'"'
ieon_ole.unpair("@oe_success","@oe_error",ls_address)



end subroutine

public function boolean of_isenable ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_isenable()
//------------------------------------------------------------------------------
// Description: 
//				Detects if bluetooth is turned on or not on the device.
//	             Supported on Android only.           
//                
// Arguments: 
//               None
//
// Returns: boolean
//               True - Bluetooth is turned on.
//				False - Bluetooth is turned off.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
il_type = 1
string ls_return

ls_return = ieon_ole.isenabled("@","@")

if upper(ls_return) = 'TRUE' then
	return true
else
	is_errortext = ls_return
	return false
end if



end function

on eon_cordova_bluetooth.create
call super::create
end on

on eon_cordova_bluetooth.destroy
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
//                The success callback event, triggered when the function call is successful.
//	              Supported on Android only.
//
// Arguments: 
//		value  string as_message
//		A JSON-format string which contains values returned by the function such as the address and name of the found bluetooth device.
//
// Returns:  (None)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
eon_cjsonnode  leon_node
long ll_loop1,ll_loop2,ll_upperbound
string ls_address,ls_key,ls_name
leon_node = create eon_cjsonnode


if il_type = 2 then
	il_type = 0
	ib_search = true
	leon_node.of_clearnode( )
	leon_node.of_load( as_message)
	ll_upperbound = upperbound(ieon_str_bluetooth)
	for ll_loop1 = 1 to leon_node.of_size( )
		ls_key = leon_node.of_getkeybyindex(ll_loop1)
		choose case lower(ls_key)
			case "address"
				ls_address = leon_node.of_valuestring(ls_key)
			case "name"
				ls_name = leon_node.of_valuestring(ls_key)
		end choose
	next
	for ll_loop2 = 1 to ll_upperbound
		if ls_address = ieon_str_bluetooth[ll_loop2].address  then
			ib_exist = true
			exit
		end if
	next
	
	if not ib_exist and len(ls_address) > 1 then
		ieon_str_bluetooth[ll_upperbound+1].address = ls_address
		ieon_str_bluetooth[ll_upperbound+1].name = ls_name
	end if
	ib_exist = false
end if

destroy leon_node
end event

