$PBExportHeader$eon_cordova_vibration.sru
forward
global type eon_cordova_vibration from eon_cordova_base
end type
end forward

global type eon_cordova_vibration from eon_cordova_base
end type
global eon_cordova_vibration eon_cordova_vibration

forward prototypes
public function integer of_init ()
public subroutine of_vibrate (long al_time)
public subroutine of_vibrate (long al_time[])
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

ll_return = of_init("navigator")

return ll_return

end function

public subroutine of_vibrate (long al_time);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_vibrate()
//------------------------------------------------------------------------------
// Description: 
//				Vibrates the device for a given amount of time.
//	             Supported on mobile client only.
//                
// Arguments: 
//               long  al_time   Milliseconds to vibrate the device.
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

ieon_ole.vibrate(string(al_time))


end subroutine

public subroutine of_vibrate (long al_time[]);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_vibrate()
//------------------------------------------------------------------------------
// Description: 
//				Vibrates the devices with a given array.
//                Supported on Android only.
//
// Arguments: 
//               long  al_time   Sequence of durations (in milliseconds) for which to turn on or off the vibrator.
//
// Returns:  None
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
long ll_loop
eon_cjsonnodearray  leon_jsarray

leon_jsarray = create eon_cjsonnodearray
leon_jsarray.of_cleararray( )
for ll_loop = 1 to upperbound(al_time)
	leon_jsarray.of_append( al_time[ll_loop])
next

ieon_ole.vibrate(leon_jsarray.of_tostring())

destroy leon_jsarray


end subroutine

on eon_cordova_vibration.create
call super::create
end on

on eon_cordova_vibration.destroy
call super::destroy
end on

