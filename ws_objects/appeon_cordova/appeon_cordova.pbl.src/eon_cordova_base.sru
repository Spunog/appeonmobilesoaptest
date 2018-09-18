$PBExportHeader$eon_cordova_base.sru
forward
global type eon_cordova_base from nonvisualobject
end type
end forward

global type eon_cordova_base from nonvisualobject
event oe_success ( string as_message )
event oe_error ( string as_error )
event oe_execjserror ( string as_error )
end type
global eon_cordova_base eon_cordova_base

type variables

string is_errorText, is_successText, is_jserrorText
// is_errortext stores the error information when the error event occurs.
// is_successtext stores the success information when the success event occurs.
// is_jseerortext stores the JavaScript error information when JavaScript call fails.

string is_successevent, is_errorevent//Success and error events of the PowerBuilder object

powerobject ipo_bindevent //PowerBuilder object to be bound with the JavaScript object.

oleobject ieon_ole //PowerBuilder OLEObject object to be connected with the Cordova plugin.

end variables

forward prototypes
public function integer of_init (string as_pluginname)
public function integer of_init ()
public function integer of_register (powerobject apb_bind, string as_successevent, string as_errorevent)
public function boolean of_isios ()
public function string of_getlasterror ()
public function string of_getlastreturn ()
public function string of_getvaluefromkey (string as_json, string as_key)
public subroutine of_settimeout (long al_timeout)
end prototypes

event oe_success(string as_message);//==============================================================================
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
//		value  string as_message		A JSON-format string which contains values returned by the function.
//
// Returns:  (None)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
is_successText = as_message

if isvalid(ipo_bindevent) and len(is_successevent) > 0 then
	ipo_bindevent.dynamic postevent(is_successevent)
end if

end event

event oe_error(string as_error);//==============================================================================
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
//		value  string as_error		A JSON-format string which contains detailed error information.
//
// Returns:  (None)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

is_errortext = as_error

if isvalid(ipo_bindevent) and len(is_errorevent) > 0 then
	ipo_bindevent.dynamic postevent(is_errorevent)
end if
end event

event oe_execjserror(string as_error);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: oe_execjserror
//------------------------------------------------------------------------------
// Description: 
//                 Occurs when there is a syntax error during the function call. However, this event cannot capture all of the errors.
//                 Supported on mobile client only.
//
// Arguments: 
//		value  string as_error 	The error information of the last function call. It can also be obtained via of_getlasterror function.
//
// Returns:  (None)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
is_jserrorText = as_error
end event

public function integer of_init (string as_pluginname);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_init()
//------------------------------------------------------------------------------
// Description: 
//				Connects with the Cordova plugin, detects if the plugin is available to call, and binds with the Cordova object.
//	              Supported on mobile client only.
//
// Arguments: 
//               string  as_pluginname    Name of the Cordova plugin.
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
string  ls_return

If appeongetclienttype()<>"MOBILE" Then
	return -1
End if

ieon_ole.connecttonewobject( "AppeonMobile.CordovaPlugin")

ls_return = ieon_ole.ExecJavaScriptWithReturn("typeof "+as_pluginname)

ieon_ole.AssociateJSwithPB(as_pluginname,this)


if ls_return = "object" then
	is_errortext = ''
	return 1
else
	is_errortext = ls_return
	return -1
end if


end function

public function integer of_init ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_init()
//------------------------------------------------------------------------------
// Description: 
//				Connects with the Cordova plugin, detects if the plugin is available to call, and binds with the Cordova object.
//	              Supported on mobile client only.
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


return ll_return

end function

public function integer of_register (powerobject apb_bind, string as_successevent, string as_errorevent);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_register
//------------------------------------------------------------------------------
// Description: 
//	                Registers the object and the event to be bound with the oe_error and oe_success events.
//	                Supported on mobile client only.		
// 
// Arguments:
//		value    powerobject    apb_bind
//				    The object to be bound with the oe_error and oe_success event.
//		value    string         as_successevent
//					The event to be bound with the oe_success event.
//		value    string         as_errorevent	
//					The event to be bound with the oe_error event.
//	
// Returns:  integer. 
//					 1 - Success.
//					-1 - It is called in PowerBuilder or Appeon Web, or there is an error.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
integer li_return

if isvalid(apb_bind)= false or isnull(apb_bind) then	
		li_return =  -1		
else		
		ipo_bindevent = apb_bind
		is_successevent = as_successevent
		is_errorevent = as_errorevent
		li_return =  1		
end if

return li_return
end function

public function boolean of_isios ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_isios()
//------------------------------------------------------------------------------
// Description:
//                Detects if the current platform is iOS or Android.
//	              Supported on mobile client only.
//                
// Arguments:
//               None
//
// Returns:  boolean
//				True - iOS
//                False - Android
//				Null - It is called in PowerBuilder or Appeon Web, or there is an error.
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
boolean  lb_return
string ls_platform
eon_mobile_deviceex  leon_device
leon_device = create eon_mobile_deviceex
If appeongetclienttype()<>"MOBILE" Then
	setnull(lb_return)
	return lb_return
End if

leon_device.of_getplatform( ls_platform)

destroy leon_device
if pos(lower(ls_platform),"android") > 0 then
	return false
else
	return true
end if

end function

public function string of_getlasterror ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_getlasterror()
//------------------------------------------------------------------------------
// Description: 	
//               Gets the error information of the last function call.
//	             Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  string
//				Error information.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_error

ls_error = ieon_ole.GetLastErrorExecJS()

return  ls_error
end function

public function string of_getlastreturn ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_getlastreturn()
//------------------------------------------------------------------------------
// Description: 
//              Gets the return value of the last function call if that call returns any value.
//	            Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  string
//				Return value of the last call.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return

ls_return = ieon_ole.ExecJavaScriptGetLastFuncCallRetVal()

return  ls_return
end function

public function string of_getvaluefromkey (string as_json, string as_key);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_getvaluefromkey()
//------------------------------------------------------------------------------
// Description: 
//                Gets the key value from a JSON-format string for the specified key name.
//	              Supported on mobile client only.
//                
// Arguments: 
//               string as_json  A JSON-format string.
//				string as_key  Key name. It is case sensitive.
//
// Returns:  string
//				Key value
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
eon_cjsonnode  leon_node,leon_node1
eon_cjsonnodearray leon_array
string ls_data
leon_node = create eon_cjsonnode
leon_node1 = create eon_cjsonnode
leon_array = create eon_cjsonnodearray
leon_node.of_clearnode( )

if leon_node.of_load( as_json) then
	choose case leon_node.of_gettypebykey(as_key)
		case 1
			ls_data = leon_node.of_valuestring( as_key)
		case 2
			ls_data = string(leon_node.of_valuedouble(as_key))
		case 3
			ls_data = string(leon_node.of_valueboolean(as_key))
		case 4
			leon_array.of_cleararray( )
			leon_array =  leon_node.of_valuearray(as_key)
			ls_data = leon_array.of_tostring( )
		case 5
			leon_node1.of_clearnode( )
			leon_node1 = leon_node.of_valuenode(as_key)
			ls_data = leon_node1.of_tostring( )
		case 0
			ls_data = 'NULL'
	end choose
else
	ls_data =''
end if

destroy leon_node
destroy leon_node1
destroy leon_array

return ls_data
end function

public subroutine of_settimeout (long al_timeout);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_settimeout()
//------------------------------------------------------------------------------
// Description: 
//                Sets the timeout value for the function call.
//	              Supported on mobile client only.
//               
// Arguments: 
//               long  al_timeout   Milliseconds for the timeout value.
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

ieon_ole.settimeout(al_timeout)
end subroutine

on eon_cordova_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on eon_cordova_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ieon_ole = create oleobject

of_init()
end event

event destructor;ieon_ole.disconnectobject( )

destroy ieon_ole
end event

