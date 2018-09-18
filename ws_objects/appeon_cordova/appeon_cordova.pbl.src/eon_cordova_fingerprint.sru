$PBExportHeader$eon_cordova_fingerprint.sru
forward
global type eon_cordova_fingerprint from eon_cordova_base
end type
end forward

global type eon_cordova_fingerprint from eon_cordova_base
end type
global eon_cordova_fingerprint eon_cordova_fingerprint

type variables
boolean ib_ios  //whether the platform is iOS.



end variables

forward prototypes
public function integer of_init ()
public subroutine of_verifyfingerprint_ios ()
public subroutine of_show ()
public function boolean of_isavailable ()
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
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
long  ll_return
ib_ios = of_isios()


If appeongetclienttype()<>"MOBILE"Then
	return -1
End if

if not ib_ios then
	ll_return = of_init("FingerprintAuth")
else
	ll_return = of_init("window.plugins.touchid")
end if

return ll_return

end function

public subroutine of_verifyfingerprint_ios ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_verifyfingerprint_ios()
//------------------------------------------------------------------------------
// Description: 
//				Verifies the fingerprint function. When successful, oe_success will be triggered; when failed, oe_error will be triggered.
//                Supported on iOS only.
//               
// Arguments: None
//				
// Returns:  None
//					
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
ieon_ole.verifyFingerprint("'Scan your fingerprint please'","@oe_success","@oe_error")



end subroutine

public subroutine of_show ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_show()
//------------------------------------------------------------------------------
// Description: 
//				Opens a native dialog to use the device hardware fingerprint scanner to authenticate against fingerprints registered for the device.
//                Supported on Android only.
//                
// Arguments: None
//               		
// Returns:  None
//						
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
eon_cjsonnode leon_node
leon_node = create eon_cjsonnode
leon_node.of_clearnode( )
leon_node.of_addkey( "clientId", "MyAppName")
leon_node.of_addkey( "clientSecret","12345")
ieon_ole.show(leon_node.of_tostring(),"@oe_success","@oe_error")
destroy leon_node


end subroutine

public function boolean of_isavailable ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_isavailable()
//------------------------------------------------------------------------------
// Description: 
//                Detects if the fingerprint sensor works on the device.
//	              Supported on mobile client only.
//                
// Arguments: 
//               None
//
// Returns:  
//			True - Fingerprint sensor is working.
//			False - Fingerprint sensor is not working.
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

boolean lb_return
string ls_return 

ls_return = ieon_ole.isAvailable("@","@")
if of_isios() then
	if lower(ls_return) = 'null' then
		lb_return = true
	else
		is_errortext = ls_return
		lb_return = false
	end if
else
	if lower(of_getvaluefromkey(ls_return,"isAvailable")) = "true" then
		lb_return = true
		is_successtext = ls_return
	else
		lb_return = false
		is_errortext = ls_return
	end if
end if
return lb_return

end function

on eon_cordova_fingerprint.create
call super::create
end on

on eon_cordova_fingerprint.destroy
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
//		value  string as_message
//		A JSON-format string which contains values returned by the function.
//      If the function called is of_isavailable, the returned value indicates the fingerprint sensor is working or not.
//
// Returns:  (None)
//
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

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
//		value  string as_error		JSON-format string which contains error information returned by the function.
//
// Returns:  (None)
//
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

end event

