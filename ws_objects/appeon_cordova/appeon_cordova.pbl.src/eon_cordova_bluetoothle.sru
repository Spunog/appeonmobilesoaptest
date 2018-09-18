$PBExportHeader$eon_cordova_bluetoothle.sru
forward
global type eon_cordova_bluetoothle from eon_cordova_base
end type
end forward

global type eon_cordova_bluetoothle from eon_cordova_base
event oe_enable ( string as_message )
end type
global eon_cordova_bluetoothle eon_cordova_bluetoothle

type variables
eon_str_cordova_bluetooth  ieon_str_bluetooth[]

long il_type //functionality extension for developers: 1 - scan, 2 - connect, 3 - read

string is_connectinfo//stores the success or error information when establishing a connection

boolean ib_exist//whether the newly scanned device exists in the scan result list.
boolean ib_enable
end variables

forward prototypes
public function integer of_init ()
public subroutine of_initialize (boolean ab_request)
public subroutine of_startscan ()
public subroutine of_stopscan ()
public subroutine of_connect (string as_address)
public subroutine of_disconnect (string as_address)
public subroutine of_close (string as_address)
public function string of_encode (string as_data)
public function string of_decode (string as_data)
public subroutine of_read (string as_address, string as_service, string as_characteristic)
public subroutine of_discover (string as_address)
public subroutine of_write (string as_address, string as_service, string as_characteristic, string as_data)
public subroutine of_services (string as_address)
public subroutine of_characteristics (string as_address, string as_service)
public function boolean of_isconnected ()
public function string of_base64tojson (string as_data)
public function string of_services_no_event (string as_address)
public subroutine of_close_no_event (string as_address)
public subroutine of_isenabled ()
end prototypes

event oe_enable(string as_message);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: oe_enable
//--------------------------------------------------------------------
// Description:
//				 Occurs when the of_isenabled function is executed; asks to turn on bluetooth if it is not turned on.
//                Supported on the Android device only.    
//--------------------------------------------------------------------
// Arguments:
// 				as_message    string    	A JSON-format string which contains values returned by the function.
//
//--------------------------------------------------------------------
// Returns:  (none)
//
//--------------------------------------------------------------------
// Author:	APPEON		Date: 2016-11
//--------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//====================================================================
integer li_return

ib_enable = (pos(lower(as_message),"true") > 0)
if not ib_enable then
	li_return = messagebox("alert","Application is requesting permission to turn on Bluetooth. Allow?", Exclamation!, YesNo!)
	if li_return = 1 then
		ieon_ole.enable("@oe_success", "@oe_error")
	end if
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

ll_return = of_init("bluetoothle")

return ll_return

end function

public subroutine of_initialize (boolean ab_request);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_initialize()
//------------------------------------------------------------------------------
// Description: 
//				Initializes bluetooth on the device. This function must be called before any others and it should only be called once.
//	             Supported on mobile client only.
//                
// Arguments: 
//               boolean  ab_request  Whether to prompt the user to enable bluetooth.
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
long  ll_return
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "request", ab_request)
leon_node.of_addkey( "statusReceiver", false)
leon_node.of_addkey( "restoreKey", "bluetoothleplugin")
ieon_ole.initialize("@oe_success","@oe_error",leon_node.of_tostring())

destroy leon_node

end subroutine

public subroutine of_startscan ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_startscan()
//------------------------------------------------------------------------------
// Description: 
//				Scans for bluetooth LE devices.
//	             Supported on mobile client only.
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
long  ll_return
il_type = 1
eon_cjsonnode leon_node
eon_cjsonnodearray leon_array
leon_node = create eon_cjsonnode
leon_array = create eon_cjsonnodearray
leon_array.of_cleararray( )
leon_node.of_clearnode( )
leon_node.of_addkey( "services", leon_array.of_tostring())
leon_node.of_addkey( "allowDuplicates", true)
leon_node.of_addkey( "scanMode", ieon_ole.SCAN_MODE_LOW_LATENCY)
leon_node.of_addkey( "matchMode", ieon_ole.MATCH_MODE_AGGRESSIVE)
leon_node.of_addkey( "matchNum", ieon_ole.MATCH_NUM_MAX_ADVERTISEMENT)
leon_node.of_addkey( "callbackType", ieon_ole.CALLBACK_TYPE_ALL_MATCHES)
ieon_ole.startScan("@oe_success","@oe_error",leon_node.of_tostring())

destroy leon_array
destroy leon_node

end subroutine

public subroutine of_stopscan ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_stopscan()
//------------------------------------------------------------------------------
// Description: 
//				Stops scanning for bluetooth LE devices.
//	             Supported on mobile client only.
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
il_type = 0
ieon_ole.stopScan("@oe_success","@oe_error")

end subroutine

public subroutine of_connect (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_connect()
//------------------------------------------------------------------------------
// Description: 
//				Connects to a bluetooth LE device.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_address  The address/identifier provided by the scan's return object
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
long  ll_return
il_type = 2
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "address",as_address)
ieon_ole.connect("@oe_success","@oe_error",leon_node.of_tostring())


destroy leon_node

end subroutine

public subroutine of_disconnect (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_disconnect()
//------------------------------------------------------------------------------
// Description: 
//				Disconnects from a bluetooth LE device.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_address		The address/identifier provided by the scan's return object.
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
long  ll_return
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "address",as_address)
ieon_ole.disconnect("@oe_success","@oe_error",leon_node.of_tostring())


destroy leon_node

end subroutine

public subroutine of_close (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_close()
//------------------------------------------------------------------------------
// Description: 
//				Closes the connection with a bluetooth LE device. 
//               This function is asynchronous. The success event and error event will be triggered.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_address   The address/identifier provided by the scan's return object.
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
long  ll_return
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "address",as_address)
ieon_ole.close("@oe_success","@oe_error",leon_node.of_tostring())


destroy leon_node

end subroutine

public function string of_encode (string as_data);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_encode()
//------------------------------------------------------------------------------
// Description: 
//				Encodes the data before it is written to the device.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_data		The decoded data.
//
// Returns:  string
//				The encoded data.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return

ieon_ole.ExecJavaScriptWithReturn( "JSArray = bluetoothle.stringToBytes('" + as_data + "');" )
ls_return = ieon_ole.ExecJavaScriptWithReturn( "bluetoothle.bytesToEncodedString(JSArray);" )

return ls_return

end function

public function string of_decode (string as_data);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_decode()
//------------------------------------------------------------------------------
// Description: 
//				Decodes the data after it is read.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_data 		The encoded data.
//
// Returns:  string
//				The decoded data.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return

ieon_ole.ExecJavaScript( "JSArray = bluetoothle.encodedStringToBytes('" + as_data + "');" )
ls_return = ieon_ole.ExecJavaScriptWithReturn("bluetoothle.bytesToString(JSArray);")


return ls_return

end function

public subroutine of_read (string as_address, string as_service, string as_characteristic);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_read()
//------------------------------------------------------------------------------
// Description: 
//				Reads a particular service's characteristics.
//	             Supported on mobile client only.
//                
// Arguments: 
//              string as_address  The address/identifier provided by the scan's return object.
//			   string as_service   The service's UUID.
//			   string as_characteristic  The characteristic's UUID.
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
long  ll_return
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
il_type = 3
leon_node.of_clearnode( )
leon_node.of_addkey( "address", as_address)
leon_node.of_addkey( "service", as_service)
leon_node.of_addkey( "characteristic",as_characteristic)
ieon_ole.read("@oe_success","@oe_error",leon_node.of_tostring())



destroy leon_node

end subroutine

public subroutine of_discover (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_discover()
//------------------------------------------------------------------------------
// Description: 
//				Discovers all the device's services, characteristics, and descriptors after connecting with a device successfully.
//                Supported on Android only (use of_services and of_characteristics instead on iOS)
//
// Arguments: 
//               string  as_address		The address/identifier provided by the scan's return object.
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
long  ll_return
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "address",as_address)
ieon_ole.discover("@oe_success","@oe_error",leon_node.of_tostring())


destroy leon_node

end subroutine

public subroutine of_write (string as_address, string as_service, string as_characteristic, string as_data);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_write()
//------------------------------------------------------------------------------
// Description: 
//				Writes a particular service's characteristic.
//	             Supported on mobile client only.
//                
// Arguments: 
//              string as_address  The address/identifier provided by the scan's return object.
//			   string as_service   The service's UUID.
//			   string as_characteristic  The characteristic's UUID.
//			   string as_data  Base64 encoded string.
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
string  ls_data
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
ls_data = of_encode(as_data)
leon_node.of_addkey( "address", as_address)
leon_node.of_addkey( "service",as_service)
leon_node.of_addkey( "characteristic",as_characteristic)
leon_node.of_addkey( "type","noResponse")
leon_node.of_addkey( "value",ls_data)
ieon_ole.write("@oe_success","@oe_error",leon_node.of_tostring())
destroy leon_node

end subroutine

public subroutine of_services (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_services()
//------------------------------------------------------------------------------
// Description: 
//				Discovers the device's services. The UUID of the service can be used by of_characteristics.
//				This function is asynchronous. The success event or error event will be triggered.
//                Supported on iOS only.
//                
// Arguments: 
//               string  as_address 		The address/identifier provided by the scan's return object.
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
long  ll_return
eon_cjsonnode leon_node
eon_cjsonnodearray leon_array
leon_array = create eon_cjsonnodearray
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_array.of_cleararray( )
leon_node.of_addkey( "address",as_address)
leon_node.of_addkey( "services", leon_array.of_tostring())
//ieon_ole.services("@oe_success","@oe_error",leon_node.of_tostring())
ieon_ole.services("@","@",leon_node.of_tostring())


destroy leon_node
destroy leon_array
end subroutine

public subroutine of_characteristics (string as_address, string as_service);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_characteristics()
//------------------------------------------------------------------------------
// Description: 
//				 Discovers the service's characteristics.
//                Supported on iOS only.
//                
// Arguments: 
//               string  as_address  The address/identifier provided by the scan's return object.
//			    string  as_service    Service UUID
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
long  ll_return
eon_cjsonnode leon_node
eon_cjsonnodearray leon_array
leon_array = create eon_cjsonnodearray
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_array.of_cleararray( )
leon_node.of_addkey( "address",as_address)
leon_node.of_addkey( "service", as_service)
leon_node.of_addkey( "characteristics", leon_array.of_tostring())
ieon_ole.characteristics("@oe_success","@oe_error",leon_node.of_tostring())

destroy leon_node
destroy leon_array
end subroutine

public function boolean of_isconnected ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_isconnected()
//------------------------------------------------------------------------------
// Description: 
//				Determines whether the device is connected.
//	             Supported on mobile client only.
//               
// Arguments: 
//               None
//
// Returns: boolean
//			    True - Connected.	
//				False - Not connected.
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_status
ls_status = of_getvaluefromkey(is_connectinfo,'status')
if ls_status = 'connected' then
	return true
else
	return false
end if


end function

public function string of_base64tojson (string as_data);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_base64tojson()
//------------------------------------------------------------------------------
// Description: 
//				Converts a base64 encoded string to a JSON array.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_data		The base64 encoded string.
//
// Returns:  string
//				Decoded data.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return


ls_return = ieon_ole.base64toJSon(as_data)


return ls_return

end function

public function string of_services_no_event (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_services_no_event()
//------------------------------------------------------------------------------
// Description: 
//				 Discovers the device's services. The UUID of the service can be used by of_characteristics.
//                This function is synchronous. No success event or error event will be triggered.
//                Supported on iOS only.
//
// Arguments: 
//               string  as_address		The address/identifier provided by the scan's return object.
//
// Returns:  string
//				The service UUID.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return
eon_cjsonnode leon_node
eon_cjsonnodearray leon_array
leon_array = create eon_cjsonnodearray
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_array.of_cleararray( )
leon_node.of_addkey( "address",as_address)
leon_node.of_addkey( "services", leon_array.of_tostring())
ls_return = ieon_ole.services("@","@",leon_node.of_tostring())

destroy leon_node
destroy leon_array

return ls_return
end function

public subroutine of_close_no_event (string as_address);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_close_no_event()
//------------------------------------------------------------------------------
// Description: 
//				Closes the connection with a bluetooth LE device. 
//                This function is synchronous. No success event or error event will be triggered.
//	             Supported on mobile client only.
//                
// Arguments: 
//               string  as_address  The address/identifier provided by the scan's return object.
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
long  ll_return
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "address",as_address)
ieon_ole.close("@","@",leon_node.of_tostring())


destroy leon_node

end subroutine

public subroutine of_isenabled ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_isenabled()
//------------------------------------------------------------------------------
// Description: 
//				Detects if bluetooth is turned on or not on the device. The oe_enable event will be triggered.
//	             Supported on the Android device only.
//                
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
long  ll_return

ieon_ole.isEnabled("@oe_enable")



end subroutine

on eon_cordova_bluetoothle.create
call super::create
end on

on eon_cordova_bluetoothle.destroy
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
//                 The success callback event, triggered when the function call is successful.
//	               Supported on mobile client only.
//
// Arguments: 
//		value  string as_message	A JSON-format string which contains values returned by the function.
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
if il_type = 1 then
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
		if ls_address = ieon_str_bluetooth[ll_loop2].address then		
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

if il_type = 2 then
	is_connectinfo = as_message
end if

destroy leon_node
end event

event oe_error;call super::oe_error;//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: oe_error
//------------------------------------------------------------------------------
// Description: 
//                 The error callback event, triggered when an error occurs during the function call.
//	               Supported on mobile client only.
//
// Arguments: 
//		value  string as_error		A JSON-format string which contains error information returned by the function.
//
// Returns:  (None)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
if il_type = 2 then
	is_connectinfo = as_error
	il_type = 0
end if

end event

