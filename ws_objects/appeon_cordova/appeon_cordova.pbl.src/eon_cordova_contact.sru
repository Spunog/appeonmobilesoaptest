$PBExportHeader$eon_cordova_contact.sru
forward
global type eon_cordova_contact from eon_cordova_base
end type
end forward

global type eon_cordova_contact from eon_cordova_base
end type
global eon_cordova_contact eon_cordova_contact

type variables
eon_cjsonnode		iec_contactPro

eon_cjsonnode		iec_contactName

eon_cjsonnodearray		iec_phoneNumberarray
eon_cjsonnodearray		iec_emailsarray
eon_cjsonnodearray		iec_photoarray

eon_cjsonnodearray		iec_organizationarray
eon_cjsonnodearray		iec_addressarray
eon_cjsonnodearray		iec_urlsarray

String		is_navigatorcontacts	=	'navigator.contacts'
end variables

forward prototypes
public function integer of_init ()
public subroutine of_save (string as_contactobjectname)
public function string of_create_jsonpar (string as_contact_infor)
public subroutine of_init_jsonobject ()
public subroutine of_setcontactname (string as_contactname)
public subroutine of_addcontactemail (string as_email, string as_emailtype, boolean abl_emailpref)
public subroutine of_addcontactphonenumber (string as_phonenumber, string as_phonetype, boolean abl_phonepref)
public function eon_cjsonnode of_setcontactfield (string as_value, string as_type, boolean abl_pref)
public subroutine of_addcontactphoto (string as_photopath, string as_phototype, boolean abl_photopref)
public function eon_cjsonnode of_setcontactfield (string as_value)
public function string of_create (string as_contactname, string as_phonenumber)
public function string of_setcontactoptions (string as_contactopt_filter, boolean abl_contactopt_multiple, string as_contactopt_desiredfields, boolean abl_contactopt_hasphonenumber)
public subroutine of_find_event (string as_contactfield, string as_contactopt_filter, boolean abl_contactopt_multiple, string as_contactopt_desiredfields, boolean abl_contactopt_hasphonenumber)
public subroutine of_find_event (string as_contactfield, string as_contactopt_filter)
public subroutine of_find_event (string as_contactfield, string as_contactopt_filter, string as_contactopt_desiredfields)
public subroutine of_associatejswithpb (string as_contactobjectname)
public function string of_find (string as_contactfield, string as_contactopt_filter, boolean abl_contactopt_multiple, string as_contactopt_desiredfields, boolean abl_contactopt_hasphonenumber)
public function any of_find (string as_contactopt_filter)
public function string of_getcontactfieldtype ()
public function integer of_delete (string as_nameorphone)
public subroutine of_remove (string as_contact_id)
public subroutine of_destroy_object ()
public subroutine of_clear_jsonarray (eon_cjsonnodearray aeon_cjsonarray)
public function string of_create (string as_contactname, string as_phonenumber, string as_phonenumbertype, string as_email, string as_emailtype)
public function eon_cjsonnode of_setcontactorganization (string as_name, string as_department, string as_title, string as_type)
public function eon_cjsonnode of_setcontactaddress (string as_type, string as_formatted, string as_streetaddress, string as_locality, string as_region, string as_postalcode, string as_country)
public subroutine of_addcontactaddress (string as_type, string as_formatted, string as_streetaddress, string as_locality, string as_region, string as_postalcode, string as_country)
public function string of_getphoto_android (string as_photo)
public function integer of_delete_contactid (string as_id)
public subroutine of_addcontactname (string as_contactname, string as_givenname, string as_familyname, string as_middlename, boolean abl_pref)
public function eon_cjsonnode of_setcontactname (string as_givenname, string as_familyname, string as_formatted, string as_middlename, string as_honorificprefix, string as_honorificsuffix, boolean abl_pref)
public subroutine of_addcontactorganization (string as_name, string as_department, string as_title, string as_type, boolean abl_pref)
public subroutine of_addcontactorganization (string as_name, string as_department, string as_title, string as_type)
public subroutine of_addcontacturls (string as_value, string as_type, boolean abl_pref)
public function string of_create (string as_contactname, eon_str_cordova_contact_name astr_contact_name, eon_str_cordova_contact_address astr_address[], eon_str_cordova_contact_organization astr_organization[], eon_str_cordova_contact_urls astr_urls[], eon_str_cordova_contact_field astr_phone[], eon_str_cordova_contact_field astr_email[], string as_note)
public function string of_create (string as_contactname, string as_givenname, string as_familyname, string as_middlename, string as_phonenumber, string as_phonenumbertype, string as_email, string as_emailtype)
public function any of_find_contactname (string as_contactopt_filter)
end prototypes

public function integer of_init ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
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

If appeongetclienttype()<>'MOBILE' Then
	return -1
End if

ll_return = of_init(is_navigatorcontacts)

return ll_return
end function

public subroutine of_save (string as_contactobjectname);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_save
//------------------------------------------------------------------------------
// Description: 
//				Saves the newly created contact to the device.
//				The contact information will be returned to the success event.
//	             Supported on mobile client only.
//               
// Arguments: 
//               as_contactobjectname	string		Name of the contact.
//
// Returns:  None			
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
of_associatejswithpb(as_contactobjectname) //connect to the Contact object that you want to save
ieon_ole.save('@oe_success','@oe_error') //save the information
end subroutine

public function string of_create_jsonpar (string as_contact_infor);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_create_jsonpar
//------------------------------------------------------------------------------
// Description: 
//				Creates a contact using a JSON-format string and saves the information.
// 				The contact information will be returned as a JSON string to the parameter of the success event.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contact_infor 	string		A JSON-format string that contains the contact information
//
// Returns:  string
//				0: Success
//				error text: Error returned when failing to create the contact.
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
String		ls_ErrorText
ieon_ole.ExecJavaScript('var contact = navigator.contacts.create('+as_contact_infor+');')
ls_ErrorText	=	of_getlasterror()
If	Trim(ls_ErrorText)=''	Or	IsNull (ls_ErrorText)	Then
	of_Save('contact')
	return	'0'
Else
	Return	ls_ErrorText
End	If



end function

public subroutine of_init_jsonobject ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_init_jsonobject()
//------------------------------------------------------------------------------
// Description: 
//				Creates a JSON object, to help add the contact's property.
//	             Supported on mobile client only.
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

iec_contactPro				=	Create	eon_cjsonnode

iec_contactName			=	Create	eon_cjsonnode
iec_phoneNumberarray	=	Create	eon_cjsonnodearray
iec_emailsarray			=	Create	eon_cjsonnodearray
iec_photoarray				=	Create	eon_cjsonnodearray
iec_organizationarray		=	Create	eon_cjsonnodearray
iec_addressarray			=	Create	eon_cjsonnodearray
iec_urlsarray				=	Create	eon_cjsonnodearray
end subroutine

public subroutine of_setcontactname (string as_contactname);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactname
//------------------------------------------------------------------------------
// Description: 
//				Sets the contact's name.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contactname 	string 	The contact's name you want to set.
//
// Returns:  None
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode	
End	If

iec_contactPro.of_addkey( 'nickname', as_ContactName)
end subroutine

public subroutine of_addcontactemail (string as_email, string as_emailtype, boolean abl_emailpref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactemail
//------------------------------------------------------------------------------
// Description: 
//				Adds an email to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_email			string	 	Email address.
//				as_emailtype 	string		Email type. Values: home, work, mobile, iPhone, or any other value that is supported by a particular device platform's contact database.
//				abl_emailpref	boolean	Whether used as the preference email. Values: true, false. It is unsupported on some platform.
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
If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode	
End	If
If	Not	IsValid(iec_emailsarray)	Then
	iec_emailsarray	=	Create eon_cjsonnodearray
End	If

iec_emailsarray.of_append(of_setcontactfield(as_email, as_emailtype,	abl_emailpref))

iec_contactPro.of_addkey( 'emails', iec_emailsarray)
end subroutine

public subroutine of_addcontactphonenumber (string as_phonenumber, string as_phonetype, boolean abl_phonepref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactphonenumber
//------------------------------------------------------------------------------
// Description: 
//				Adds a phone number to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_phonenumber		string		Phone number.
//				as_phonetype			string		Phone number type. Values: home, work, mobile, iPhone, or any other value that is supported by a particular device platform's contact database.
//				as_phonepref			string		Whether used as the preference number. It is unsupported on some platform.
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

If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode	
End	If
If	Not	IsValid(iec_phoneNumberarray)	Then
	iec_phoneNumberarray	=	Create eon_cjsonnodearray
End	If

iec_phoneNumberarray.of_append(of_setcontactfield(as_phoneNumber, as_phonetype,	abl_phonepref))

iec_contactPro.of_addkey( 'phoneNumbers', iec_phoneNumberarray)
end subroutine

public function eon_cjsonnode of_setcontactfield (string as_value, string as_type, boolean abl_pref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactfield
//------------------------------------------------------------------------------
// Description: 
//				Creates a contactfield JSON node and sets the value.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_value 		string 	The value of the field, such as a phone number or email address.
//				as_type 		string		In most instances, there are no pre-determined values for this parameter. 
//											For example, a phone number can specify type values of home, work, mobile, iPhone, or any other value that is supported by a particular device platform's contact database. 
//											However, for the Contact photos field, the type indicates the format of the returned image: url when the value attribute contains a URL to the photo image, or base64 when the value contains a base64-encoded image string.
//				as_pref		boolean	Whether used as the preference value. It is unsupported on some platform.
//
// Returns:  eon_cjsonnode		The JSON node with the values.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

eon_cjsonnode		lec_ContactField

lec_ContactField	=	Create	eon_cjsonnode

lec_ContactField.of_addkey('value',as_value)
lec_ContactField.of_addkey('type',as_type)
lec_ContactField.of_addkey('pref',abl_pref)

Return	lec_ContactField
end function

public subroutine of_addcontactphoto (string as_photopath, string as_phototype, boolean abl_photopref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactphoto
//------------------------------------------------------------------------------
// Description: 
//				Adds a photo to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_photopath		string		Photo URL/path.
//				as_phototype		string	     Format of the returned image: url (when the value attribute contains a URL to the photo image), 
//                                                                                                     or base64 (when the value contains a base64-encoded image string).
//				abl_photopref		boolean	Whether used as the preference photo. It is unsupported on some platform.
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
If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode	
End	If
If	Not	IsValid(iec_photoarray)	Then
	iec_photoarray	=	Create	eon_cjsonnodearray
End	If

iec_photoarray.of_append(of_setcontactfield(as_photopath, as_phototype,	abl_photopref))

iec_contactPro.of_addkey( 'photos', iec_photoarray)
end subroutine

public function eon_cjsonnode of_setcontactfield (string as_value);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactfield
//------------------------------------------------------------------------------
// Description: 
//				Creates a contactfield JSON node and sets the value.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_value 		string 	The value of the field, such as a phone number or email address.
//
// Returns:  eon_cjsonnode		The JSON node with the values.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

eon_cjsonnode		lec_ContactField

lec_ContactField	=	Create	eon_cjsonnode

lec_ContactField.of_addkey('value',as_value)

Return	lec_ContactField
end function

public function string of_create (string as_contactname, string as_phonenumber);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_create
//------------------------------------------------------------------------------
// Description: 
//				Creates a new contact and saves the contact to the device contacts database.
// 				The contact information will be returned as a JSON string to the parameter of the success event.
//	             Supported on mobile client only.
//                 
// Arguments: 
//               as_contactName 	string		Name of the new contact.
//				as_phoneNumber 	string		Phone number of the new contact.
//
// Returns:  string
//				0: Success
//				error text: Error returned when failing to create the contact.
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

String		ls_ErrorText

of_setcontactname(as_contactname)

of_clear_JSONArray(iec_phoneNumberarray)
of_addcontactphonenumber(as_phonenumber, 'Home',	false)

ls_ErrorText	=	of_create_jsonPar(iec_contactPro.of_tostring( ) )
Return	ls_ErrorText
end function

public function string of_setcontactoptions (string as_contactopt_filter, boolean abl_contactopt_multiple, string as_contactopt_desiredfields, boolean abl_contactopt_hasphonenumber);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactoptions
//------------------------------------------------------------------------------
// Description: 
//				Sets the options' value for the find parameter.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_ContactOPT_filter 			string 	The search string used to find navigator.contacts.
//				abl_ContactOPT_multiple 	boolean 	Whether the find operation returns multiple navigator.contacts (default: false).
//				as_ContactOPT_desiredFields 			string 	Contact fields to be returned.
//				as_ContactOPT_hasPhoneNumber 	boolean 	(Android only) Search only returns contacts with a phone number. It is unsupported on some platform (default: false).
//
// Returns:  string
//				Returns the JSON string with the options.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

String		ls_ReturnValue
eon_cjsonnode		lec_options
eon_cjsonnodearray	lec_DesireFieldsArray

lec_options	=	Create	eon_cjsonnode
lec_DesireFieldsArray	=	Create	eon_cjsonnodearray

lec_DesireFieldsArray.of_Load( as_ContactOPT_desiredFields	)
lec_options.of_addkey( 'desiredFields',	lec_DesireFieldsArray )
lec_options.of_addkey( 'filter', as_ContactOPT_filter)
lec_options.of_addkey( 'multiple', abl_ContactOPT_multiple)


ls_ReturnValue	=	lec_options.of_ToString( )

If	IsValid(lec_options)	Then	Destroy	lec_options
If	IsValid(lec_DesireFieldsArray)	Then	Destroy	lec_DesireFieldsArray

Return	ls_ReturnValue
end function

public subroutine of_find_event (string as_contactfield, string as_contactopt_filter, boolean abl_contactopt_multiple, string as_contactopt_desiredfields, boolean abl_contactopt_hasphonenumber);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_find_event
//------------------------------------------------------------------------------
// Description: 
//				Finds a contact.
//				This function executes asynchronously, and returns the result to the success event or error event.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contactfield 	string 	Contact fields used as a search qualifier.
//				as_contactopt_filter 	string 	Search string used to find navigator.contacts.
//				abl_contactopt_multiple 	boolean 	Whether the find operation returns multiple navigator.contacts (default: false).
//				as_contactopt_desiredfields  string	Contact fields to be returned. If specified, the returned result only contains values for these fields.
//				abl_contactopt_hasphonenumber 	boolean 	(Android only) Search only returns contacts with a phone number.	
//
// Returns:  none
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

String		ls_optionJSON
of_associatejswithpb(is_navigatorcontacts)
ls_optionJSON	=	of_Setcontactoptions(as_contactopt_filter,	abl_contactopt_multiple,as_contactopt_desiredfields,	abl_contactopt_hasphonenumber)

ieon_ole.find(as_contactField, '@oe_success', '@oe_error', ls_optionJSON )
end subroutine

public subroutine of_find_event (string as_contactfield, string as_contactopt_filter);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_find_event
//------------------------------------------------------------------------------
// Description: 
//				Finds a contact.
//				This function executes asynchronously, and returns the result to the success event or error event.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contactfield 			string		The contact fields used as a search qualifier.
//				as_contactopt_filter	string 	The search string used to find navigator.contacts.
//
// Returns:  none
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================


of_find_event(as_contactField,	as_ContactOPT_filter,true,'',false)
end subroutine

public subroutine of_find_event (string as_contactfield, string as_contactopt_filter, string as_contactopt_desiredfields);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_find_event
//------------------------------------------------------------------------------
// Description: 
//				Finds a contact.
//				This function executes asynchronously, and returns the result to the success event or error event.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contactfield 					string 	Contact fields used as a search qualifier.
//				as_contactopt_filter 			string 	Search string used to find navigator.contacts.
//				as_contactopt_desiredfields string		Contact fields to be returned. If specified, the returned result only contains values for these fields.
//
// Returns:  none
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

of_find_event(as_contactField,	as_ContactOPT_filter,true,as_ContactOPT_desiredFields,false)
end subroutine

public subroutine of_associatejswithpb (string as_contactobjectname);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_associatejswithpb
//------------------------------------------------------------------------------
// Description: 
//				Associates the current PowerBuilder object with a JavaScript object.
//	             Supported on mobile client only.
//               
// Arguments: 
//               as_contactobjectname	string		Name of the JavaScript object.
//
// Returns:  None
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
ieon_ole.AssociateJSwithPB(	as_contactobjectname,	This	) 
end subroutine

public function string of_find (string as_contactfield, string as_contactopt_filter, boolean abl_contactopt_multiple, string as_contactopt_desiredfields, boolean abl_contactopt_hasphonenumber);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_find
//------------------------------------------------------------------------------
// Description: 
//				Finds a contact.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contactfield 					string 	The contact fields used as a search qualifier.
//				as_contactopt_filter 			string 	The search string used to find navigator.contacts.
//				abl_contactopt_multiple 		boolean 	Whether the find operation returns multiple navigator.contacts (default: false).
//				as_contactopt_desiredfields 		string 	The contact fields to be returned. If specified, the returned result only contains values for these fields.
//				abl_contactopt_hasphonenumber 	boolean 	Search only returns contacts with a phone number. It is supported on Android only.
//
// Returns:  string
//				Returns a JSON-format string with the found contacts.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

String		ls_optionJSON,ls_ReturnJSON
String		ls_ErrorText

of_associatejswithpb(is_navigatorcontacts)
ls_optionJSON	=	of_Setcontactoptions(as_contactopt_filter,	abl_contactopt_multiple,as_contactopt_desiredfields,	abl_contactopt_hasphonenumber)
ls_ReturnJSON	=	ieon_ole.find(as_contactField, '@', '@', ls_optionJSON )

ls_ErrorText	=	of_getlasterror()
If	Trim(ls_ErrorText)	=	''	Or	IsNull(ls_ErrorText)	Then
	Return	ls_ReturnJSON
Else
	MessageBox ('failed','find contact failed,please check the script.~r~nError Message is:'+ls_ErrorText)
	Return	'error'
End	If


end function

public function any of_find (string as_contactopt_filter);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_find
//------------------------------------------------------------------------------
// Description: 
//				Finds a contact.
//	             Supported on mobile client only.
//
// Arguments: 
//				as_contactopt_filter 	string 	The search string used to find navigator.contacts.
//
// Returns:  any
//				eon_str_cordova_contact_find[]:if successful, the structure stores the contact name, ID, note, URL, phone number, email, address, organization, and photo.
//														  if not found, eon_str_cordova_contact_find.s_errortext = notfind.
//													       if error occurs, eon_str_cordova_contact_find.s_errortext = error.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
String		ls_ReturnJSON
String		ls_ContactField

eon_str_cordova_contact_find		lestr_contact_find[] //存储返回值

//设置过滤的时比较的属性列 all of the Set name's property and phonenumbers property
eon_cjsonnodearray		lec_ContactFieldArray
lec_ContactFieldArray	=	Create	eon_cjsonnodearray

lec_ContactFieldArray.of_append( 'id')									//id new ?
lec_ContactFieldArray.of_append( 'displayName')
lec_ContactFieldArray.of_append( 'honorificPrefix')
lec_ContactFieldArray.of_append( 'honorificSuffix')
lec_ContactFieldArray.of_append( 'middleName')
lec_ContactFieldArray.of_append( 'name')
lec_ContactFieldArray.of_append( 'nickname')
lec_ContactFieldArray.of_append( 'formatted')
lec_ContactFieldArray.of_append( 'phoneNumbers')
lec_ContactFieldArray.of_append( 'emails')
lec_ContactFieldArray.of_append( 'addresses')
lec_ContactFieldArray.of_append( 'photos')
lec_ContactFieldArray.of_append( 'organizations')
lec_ContactFieldArray.of_append( 'birthday')								//new
lec_ContactFieldArray.of_append( 'urls')			
lec_ContactFieldArray.of_append( 'note')										//need it
				
ls_ContactField	=	lec_ContactFieldArray.of_Tostring( )
//find the contact like user input
ls_ReturnJSON	=	of_find(ls_ContactField,	as_ContactOPT_filter,	true,	ls_ContactField,	false)

//if	Find contact failed the return error
If	Trim(ls_ReturnJSON)	=	'error'		Then
	lestr_contact_find[1].s_errortext	=	'error'
	If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
	Return	lestr_contact_find
End	If
//check the return JSON string wether have phoneNumbers Property, if not have the find function execute failed,maybe have some error trigger the failed event
If	Pos(ls_ReturnJSON,	'phoneNumbers')	<	1	Then
	lestr_contact_find[1].s_errortext	=	'notfind'
	If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
	Return	lestr_contact_find
End	If

//from the JSON String Get the contact name and phoneNumber
eon_cjsonnodearray		leca_findContacts
eon_cjsonnodearray		leca_findContact_phoneNUMS
eon_cjsonnode			lec_Contact
eon_cjsonnode			lec_Contact_name
eon_cjsonnode			lec_findContact_phoneNUM
Integer		li_For,	li_For_2
Integer		li_type,	li_Contact_ID_Type
String			ls_displayName,	ls_nickname,	ls_formatted,	ls_Name,		ls_firstname, 	ls_lastname, ls_nameformatted, ls_note, ls_id 
eon_str_cordova_contact_field			lestr_phoneNumbers[],lestr_field_Temp[]
Boolean		lbl_Return

leca_findContacts	=	Create	eon_cjsonnodearray

lbl_Return	=	leca_findContacts.of_Load( ls_ReturnJSON)
If	Not	lbl_Return	Then
	lestr_contact_find[1].s_errortext	=	'error'
	If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
	If	IsValid(leca_findContacts)	Then	Destroy	leca_findContacts
	Return	lestr_contact_find
End	If

eon_cjsonnodearray	leca_findcontact_photos
eon_cjsonnode	lec_findcontact_photo
String		ls_photos[],	ls_ArrayTemp[]

eon_cjsonnodearray	leca_findcontact_Addresses
eon_cjsonnode	lec_findcontact_Address
eon_str_cordova_contact_address		lestr_contact_address[],	lestr_contact_address_Null[]

eon_cjsonnodearray	leca_findcontact_organizations
eon_cjsonnode	lec_findcontact_organization
eon_str_cordova_contact_organization		lestr_contact_organization[],lestr_contact_organization_Null[]

eon_cjsonnodearray	leca_findcontact_emails
eon_cjsonnode	lec_findcontact_email
eon_str_cordova_contact_field	lestr_contact_emails[]

eon_cjsonnodearray	leca_findcontact_urls
eon_cjsonnode	lec_findcontact_url
eon_str_cordova_contact_urls	lestr_contact_urls[],	lestr_contact_urls_null[]

lec_Contact	=	Create	eon_cjsonnode
lec_Contact_name	=	Create	eon_cjsonnode
leca_findContact_phoneNUMS	=	Create	eon_cjsonnodearray
lec_findContact_phoneNUM	=	Create	eon_cjsonnode
leca_findcontact_photos	=	Create	eon_cjsonnodearray
lec_findcontact_photo	=	Create	eon_cjsonnode
leca_findcontact_Addresses	=	Create	eon_cjsonnodearray
lec_findcontact_Address	=	Create	eon_cjsonnode

leca_findcontact_organizations	=	Create	eon_cjsonnodearray
lec_findcontact_organization	=	Create	eon_cjsonnode

leca_findcontact_emails	=	Create	eon_cjsonnodearray
lec_findcontact_email	=	Create	eon_cjsonnode

leca_findcontact_urls	=	Create	eon_cjsonnodearray
lec_findcontact_url	=	Create	eon_cjsonnode

For	li_For	=1	To	leca_findContacts.of_size(	)
	li_type	=	leca_findContacts.of_gettypebyindex( li_For	)
	If	li_Type	<>	5	Then
		lestr_contact_find[li_For].s_errortext	=	'error the JSON format is incorrect please check!'
	Else
		lec_Contact	=	leca_findContacts.of_getnodebyindex(	li_For	)
		
		//Get the contact name from the property( nickname、displayName、formatted)
		ls_nickname	=	lec_Contact.of_valuestring( 'nickname')
		ls_displayName	=	lec_Contact.of_valuestring( 'displayName')
		lec_Contact_name	=	lec_Contact.of_Valuenode( 'name')
		ls_note		=	lec_Contact.of_valuestring( 'note')
		
		li_Contact_ID_Type	=	lec_Contact.of_Gettypebykey('id')
		If	li_Contact_ID_Type	=	1	Then
			ls_id	=	lec_Contact.of_valuestring( "id")
		ElseIf	li_Contact_ID_Type	=	2	Then
			ls_id	=	String(lec_Contact.of_valuedouble( "id"))
		else
			ls_id = ''
		end if 

		//check the contact.name node isvalid
		If	Not IsValid(lec_Contact_name)	Then
			SetNull(ls_formatted)
			ls_lastname =""
			ls_firstname =""
			ls_nameformatted =""
		Else
			ls_formatted	=	lec_Contact_name.of_valuestring( 'formatted'	)
			ls_lastname =	lec_Contact_name.of_valuestring( 'familyName')
			ls_firstname =	lec_Contact_name.of_valuestring( 'givenName')
			ls_nameformatted = lec_Contact_name.of_valuestring( 'formatted')
		End	If
		
		If	Not (IsNull( ls_nickname) Or Trim(ls_nickname)=''	)	Then
			ls_Name	=	ls_nickname
		ElseIf	Not (	IsNull(ls_DisplayName)	Or Trim(ls_displayName)='') Then
			ls_Name	=	ls_DisplayName
		Else
			ls_Name	=	ls_formatted
		End	If
		lestr_contact_find[li_For].id	=ls_id
		lestr_contact_find[li_For].s_contactname	=ls_Name
		lestr_contact_find[li_For].s_note = ls_note
		lestr_contact_find[li_For].str_contactname.s_givenname		=ls_firstname					//add new
		lestr_contact_find[li_For].str_contactname.s_familyname	=ls_lastname
		lestr_contact_find[li_For].str_contactname.s_formatted		=ls_nameformatted
				
		//Get phoneNumbers		
		leca_findContact_phoneNUMS	=	lec_Contact.of_Valuearray( 'phoneNumbers')
		If	IsValid(leca_findContact_phoneNUMS)	Then //如果为空不再执行获取phoneNumber
			lestr_phoneNumbers=	lestr_field_Temp //init next contact's phoneNumber array
			For	li_For_2	=	1	To	leca_findContact_phoneNUMS.of_Size( )
				lec_findContact_phoneNUM	=	leca_findContact_phoneNUMS.of_Getnodebyindex( li_For_2	)
				If	Not	IsValid(lec_findContact_phoneNUM)	Then	Continue	//如果对象无效不再执行获取电话号码				
				lestr_phoneNumbers[li_For_2].s_value	=	lec_findContact_phoneNUM.of_ValueString( 'value')
				lestr_phoneNumbers[li_For_2].s_type	=	lec_findContact_phoneNUM.of_ValueString( 'type')
			Next
			If	upperbound(lestr_phoneNumbers) > 0	Then
				lestr_contact_find[li_For].str_phonenumbers	=	lestr_phoneNumbers
			End	If
		End	If
		//Get emails
		leca_findcontact_emails	=	lec_Contact.of_Valuearray( 'emails')
		If	IsValid(leca_findcontact_emails)	Then
			lestr_contact_emails=	lestr_field_Temp
			For	li_For_2	=	1	To	leca_findcontact_emails.of_Size( )
				lec_findcontact_email	=	leca_findcontact_emails.of_Getnodebyindex( li_For_2	)
				If	Not	IsValid(lec_findcontact_email)	Then	Continue	//如果对象无效不再执行获取电话号码				
				lestr_contact_emails[li_For_2].s_value	=	lec_findcontact_email.of_ValueString( 'value')
				lestr_contact_emails[li_For_2].s_type	=	lec_findcontact_email.of_ValueString( 'type')
			Next
			If	upperbound(lestr_phoneNumbers) > 0	Then
				lestr_contact_find[li_For].str_emails	=	lestr_contact_emails
			End	If
		End	If
		
		//Get photos ContactField[] value
		leca_findcontact_photos	=	lec_Contact.of_Valuearray( 'photos'	)
		If	IsValid(leca_findcontact_photos)	Then
			ls_photos	=	ls_ArrayTemp
			For	li_For_2	=	1	To	leca_findcontact_photos.of_size( )
				lec_findcontact_photo	=	leca_findcontact_photos.of_Getnodebyindex( li_For_2	)
				If	Not	IsValid(lec_findcontact_photo)	Then	Continue
				ls_photos[li_For_2]	=	lec_findcontact_photo.of_Valuestring( 'value')
			Next
			If	upperbound(ls_photos) > 0	Then
				lestr_contact_find[li_For].s_photos	=	ls_photos
			End	If
		End	If
		//get addresses ContactAddress[] type, streetAddress, locality, region, postalcode,country
		leca_findcontact_Addresses	=	lec_Contact.of_Valuearray( 'addresses')
		If	IsValid(leca_findcontact_Addresses)	Then
			lestr_contact_address		=	lestr_contact_address_Null
			For	li_For_2	=	1	To	leca_findcontact_Addresses.of_size( )
				lec_findcontact_Address	=	leca_findcontact_Addresses.of_Getnodebyindex( li_For_2	)
				If	Not	IsValid(lec_findcontact_Address)	Then	Continue
				lestr_contact_address[li_For_2].s_type	=	lec_findcontact_Address.of_ValueString( 'type')
				lestr_contact_address[li_For_2].s_streetaddress	=	lec_findcontact_Address.of_ValueString( 'streetAddress')
				lestr_contact_address[li_For_2].s_locality	=	lec_findcontact_Address.of_ValueString( 'locality')
				lestr_contact_address[li_For_2].s_region	=	lec_findcontact_Address.of_ValueString( 'region')
				lestr_contact_address[li_For_2].s_postalcode	=	lec_findcontact_Address.of_ValueString( 'Postalcode')
				lestr_contact_address[li_For_2].s_country	=	lec_findcontact_Address.of_ValueString( 'country')
				lestr_contact_address[li_For_2].s_formatted	=	lec_findcontact_Address.of_ValueString( 'formatted')				
			Next
			If	upperbound(lestr_contact_address) > 0	Then
				lestr_contact_find[li_For].str_address	=	lestr_contact_address
			End	If
		End	If
		//organizations ContactOrganization[] type IOS不支持,name,department,title IOS是部分支持，android全支持
		leca_findcontact_organizations	=	lec_Contact.of_Valuearray( 'organizations')
		If	IsValid(leca_findcontact_organizations)	Then		
			lestr_contact_organization	=	lestr_contact_organization_Null
			For	li_For_2	=	1	To	leca_findcontact_organizations.of_size( )
				lec_findcontact_organization	=	leca_findcontact_organizations.of_Getnodebyindex( li_For_2	)
				If	Not	IsValid(lec_findcontact_organization)	Then	Continue
				lestr_contact_organization[li_For_2].s_name	=	lec_findcontact_organization.of_ValueString( 'name')
				lestr_contact_organization[li_For_2].s_department	=	lec_findcontact_organization.of_ValueString( 'department')
				lestr_contact_organization[li_For_2].s_title	=	lec_findcontact_organization.of_ValueString( 'title')
				lestr_contact_organization[li_For_2].s_type	=	lec_findcontact_organization.of_ValueString( 'type')
			Next
			If	upperbound(lestr_contact_organization) > 0	Then
				lestr_contact_find[li_For].str_organizations	=	lestr_contact_organization
			End	If
		End	If
		
		//get Urls [] value
		leca_findcontact_urls	=	lec_Contact.of_Valuearray( 'urls')
		If	IsValid(leca_findcontact_urls)	Then 	
			lestr_contact_urls=	lestr_contact_urls_null 	
			For	li_For_2	=	1	To	leca_findcontact_urls.of_Size( )
				lec_findcontact_url	=	leca_findcontact_urls.of_Getnodebyindex( li_For_2	)
				If	Not	IsValid(lec_findcontact_url)	Then	Continue	//如果对象无效不再执行 		
				lestr_contact_urls[li_For_2].s_value	=	lec_findcontact_url.of_ValueString( 'value')
				lestr_contact_urls[li_For_2].s_type	=	lec_findcontact_url.of_ValueString( 'type')
			Next
			If	upperbound(lestr_contact_urls) > 0	Then
				lestr_contact_find[li_For].str_urls	=	lestr_contact_urls
			End	If
		End	If
		
	End	If
Next

If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
If	IsValid(leca_findContacts)	Then	Destroy	leca_findContacts
If	IsValid(leca_findContact_phoneNUMS)	Then	Destroy	leca_findContact_phoneNUMS
If	IsValid(lec_Contact)	Then	Destroy	lec_Contact
If	IsValid(lec_Contact_name)	Then	Destroy	lec_Contact_name
If	IsValid(lec_findContact_phoneNUM)	Then	Destroy	lec_findContact_phoneNUM
If	IsValid(leca_findcontact_Addresses)	Then	Destroy	leca_findcontact_Addresses
If	IsValid(leca_findcontact_emails)	Then	Destroy	leca_findcontact_emails
If	IsValid(lec_findcontact_email)	Then	Destroy	lec_findcontact_email
If	IsValid(lec_findcontact_organization)	Then	Destroy	lec_findcontact_organization
If	IsValid(leca_findcontact_organizations)	Then	Destroy	leca_findcontact_organizations
If	IsValid(lec_findcontact_Address)	Then	Destroy	lec_findcontact_Address
If	IsValid(leca_findcontact_urls)	Then	Destroy	leca_findcontact_urls
If	IsValid(lec_findcontact_url)	Then	Destroy	lec_findcontact_url

Return		lestr_contact_find

end function

public function string of_getcontactfieldtype ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_getcontactfieldtype
//------------------------------------------------------------------------------
// Description: 
//				Gets the contact field type. This can get all of the properties of a contact.
//	             Supported on mobile client only.
//                
// Arguments: None
//              		
// Returns:  string
//				Returns a JSON array format string. If failed, returns the error.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
String		ls_Return
String		ls_fieldTypeJSON
Boolean		lbl_Return
Integer		li_For
eon_cjsonnodearray		leca_fieldType_Return
eon_cjsonnode		lec_fieldType

of_associatejswithpb(is_navigatorcontacts)

ls_return = ieon_ole.ExecJavaScriptWithReturn('typeof navigator.contacts.fieldType')

If	Lower(ls_return) <> 'object'	Then	Return	'error'
ls_fieldTypeJSON	=	ieon_ole.ExecJavaScriptWithReturn('navigator.contacts.fieldType')

lec_fieldType	=	Create	eon_cjsonnode
lbl_Return	=	lec_fieldType.of_Load( ls_fieldTypeJSON)
If	Not	(lbl_Return)	Then
	If	IsValid(lec_fieldType)	Then	Destroy	lec_fieldType
	Return	'error'
End	If

leca_fieldType_Return	=	Create	eon_cjsonnodearray

For	li_For	=	1	To	lec_fieldType.of_size( )
	leca_fieldType_Return.of_append( 	lec_fieldType.of_getkeybyindex(li_For)	)
Next

ls_return	=	leca_fieldType_Return.of_ToString()

If	IsValid(lec_fieldType)	Then	Destroy	lec_fieldType
If	IsValid(leca_fieldType_Return)	Then	Destroy	leca_fieldType_Return

Return	ls_return
end function

public function integer of_delete (string as_nameorphone);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_delete
//------------------------------------------------------------------------------
// Description: 
//				Deletes the contact according to the specified name or phone number.
//	             Supported on mobile client only.
//                
// Arguments: 
//          		as_nameorphone		string		Name or phone number of the contact to be deleted.
//														If there are multiple contacts found, only the first one on the list will be deleted.
//
// Returns:  Integer
//				1 - Success. 
//				-1 - Failure (due to errors or other problems, or failing to find the contact).
//				0 - Not found.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

String		ls_Return
String		ls_ReturnJSON
Boolean		lbl_Load	
Integer		li_For,	li_For_2
eon_cjsonnodearray		leca_findcontact
eon_cjsonnodearray		leca_phoneNumbers
eon_cjsonnode		lec_contact,lec_contact_name,	lec_phoneNumber

String			ls_displayName,	ls_nickname,	ls_formatted
String			ls_phoneNumber
String			ls_Contact_ID
Integer		li_Contact_ID_Type
String			ls_ContactField

//find the contacts includ the as_nameorphone
ls_ContactField	=	of_getcontactfieldtype()
If	ls_ContactField = 'error'	Then return -1
ls_ReturnJSON	=	of_find(ls_ContactField,	as_nameorphone,	true,	ls_ContactField,	false)

//if	Find contact failed the return error
If	Trim(ls_ReturnJSON)	=	'error'		Then	return 	-1

//check the return JSON string wether have phoneNumbers Property, if not have the find function execute failed,maybe have some error trigger the failed event
If	Pos(ls_ReturnJSON,	'phoneNumbers')	<	1	Then 	Return	0

leca_findcontact	=	Create	eon_cjsonnodearray

lbl_Load	=	leca_findcontact.of_load(ls_ReturnJSON)
If	Not	lbl_Load	Then
	If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
	Return	-1
End	If

lec_contact	=	Create	eon_cjsonnode
leca_phoneNumbers	=	Create	eon_cjsonnodearray
lec_phoneNumber	=	Create	eon_cjsonnode
lec_contact_name	=	Create	eon_cjsonnode
//find the contact
For	li_For	=	1	To	leca_findcontact.of_Size( )
	lec_contact	=	leca_findcontact.of_Getnodebyindex( li_For	)	
	If	Not	Isvalid(lec_contact)	Then	
		If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
		If	IsValid(lec_contact)	Then	Destroy	lec_contact
		If	IsValid(leca_phoneNumbers)	Then	Destroy	leca_phoneNumbers
		If	IsValid(lec_phoneNumber)	Then	Destroy	lec_phoneNumber
		Return	-1
	End	If	
	ls_displayName		=	lec_contact.of_ValueString( 'displayName'	)	
	ls_nickname		=	lec_contact.of_ValueString( 'nickname'	)	
	lec_contact_name	=	lec_contact.of_valuenode(	'name'	)	
	If	Not	IsValid(lec_contact_name)	Then		
		SetNull(ls_formatted)
	Else		
		ls_formatted	=	lec_contact_name.of_ValueString( 'formatted'	)
	End	If
	
	If	as_nameorphone	=	ls_displayName	Or	as_nameorphone	=	ls_nickname	Or	as_nameorphone	=	ls_formatted	Then		
		li_Contact_ID_Type	=	lec_contact.of_Gettypebykey('id')
		If	li_Contact_ID_Type	=	1	Then
			ls_Contact_ID	=	lec_contact.of_valuestring( "id")
		ElseIf	li_Contact_ID_Type	=	2	Then
			ls_Contact_ID	=	String(lec_contact.of_valuedouble( "id"))
		Else
			If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
			If	IsValid(lec_contact)	Then	Destroy	lec_contact
			If	IsValid(leca_phoneNumbers)	Then	Destroy	leca_phoneNumbers
			If	IsValid(lec_phoneNumber)	Then	Destroy	lec_phoneNumber
			Return	-1
		End	If
		of_remove(ls_Contact_ID)
		If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
		If	IsValid(lec_contact)	Then	Destroy	lec_contact
		If	IsValid(leca_phoneNumbers)	Then	Destroy	leca_phoneNumbers
		If	IsValid(lec_phoneNumber)	Then	Destroy	lec_phoneNumber
		Return	1
	End	If
	//当姓名无法匹配到时匹配电话号码
	leca_phoneNumbers	=	lec_contact.of_ValueArray ( 'phoneNumbers'	)
	If	Not	IsValid(leca_phoneNumbers)	Then	Continue
	For	li_For_2	=	1	To	leca_phoneNumbers.of_Size( )		
		lec_phoneNumber	=	leca_phoneNumbers.of_Getnodebyindex( li_For_2)
		If	Not	IsValid(lec_phoneNumber)	Then	Continue
		ls_phoneNumber	=	lec_phoneNumber.of_Valuestring( 'value')
		If	as_nameorphone	=	ls_phoneNumber	Then
			//Get the contact's id value
			li_Contact_ID_Type	=	lec_contact.of_Gettypebykey('id')
			If	li_Contact_ID_Type	=	1	Then
				ls_Contact_ID	=	lec_contact.of_valuestring( "id")
			ElseIf	li_Contact_ID_Type	=	2	Then
				ls_Contact_ID	=	String(lec_contact.of_valuedouble( "id"))
			Else
				If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
				If	IsValid(lec_contact)	Then	Destroy	lec_contact
				If	IsValid(leca_phoneNumbers)	Then	Destroy	leca_phoneNumbers
				If	IsValid(lec_phoneNumber)	Then	Destroy	lec_phoneNumber
				Return	-1
			End	If
			//remove the contact
			of_remove(ls_Contact_ID)
			If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
			If	IsValid(lec_contact)	Then	Destroy	lec_contact
			If	IsValid(leca_phoneNumbers)	Then	Destroy	leca_phoneNumbers
			If	IsValid(lec_phoneNumber)	Then	Destroy	lec_phoneNumber
			Return	1
		End	If
	Next
Next

Return	0
end function

public subroutine of_remove (string as_contact_id);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_remove
//------------------------------------------------------------------------------
// Description: 
//				Deletes a contact.
//	             Supported on mobile client only.
//                
// Arguments: 
//          		as_contact_id 	string 	ID of the contact that you want to remove.
//
// Returns:  None
//				If successful, the success event will be triggered.
//				If failed, the error event will be triggered.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
ieon_ole.ExecJavaScript('var contact = navigator.contacts.create()') //分号写不写都可以
of_associatejswithpb('contact')
ieon_ole.id = as_contact_id
ieon_ole.remove('@oe_success','@oe_error')

end subroutine

public subroutine of_destroy_object ();//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_destroy_object
//------------------------------------------------------------------------------
// Description: 
//				Destroys the JSON object.
//	             Supported on mobile client only.
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


If	IsValid(iec_contactPro)	Then	Destroy	iec_contactPro
If	IsValid(iec_contactName)	Then	Destroy	iec_contactName
If	IsValid(iec_phoneNumberarray)	Then	Destroy	iec_phoneNumberarray
If	IsValid(iec_emailsarray)	Then	Destroy	iec_emailsarray
If	IsValid(iec_photoarray)	Then	Destroy	iec_photoarray
If	IsValid(iec_organizationarray)	Then	Destroy	iec_organizationarray
If	IsValid(iec_addressarray)	Then	Destroy	iec_addressarray
If	IsValid(iec_urlsarray)	Then	Destroy	iec_urlsarray
end subroutine

public subroutine of_clear_jsonarray (eon_cjsonnodearray aeon_cjsonarray);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_clear_jsonarray
//------------------------------------------------------------------------------
// Description: 
//				Clears the values of the JSON array.
//	             Supported on mobile client only.
//                
// Arguments: 
//            	aeon_cjsonarray		eon_cjsonnodearray		Name of the JSON array.
//
// Returns:  None
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

If	Not	IsValid(aeon_cjsonarray)		Then	Return

aeon_cjsonarray.of_cleararray()
end subroutine

public function string of_create (string as_contactname, string as_phonenumber, string as_phonenumbertype, string as_email, string as_emailtype);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_create
//------------------------------------------------------------------------------
// Description: 
//				Creates a new contact and saves the contact to the device contacts database.
// 				The contact information will be returned as a JSON string to the parameter of the success event.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_contactName 			string		Name of the new contact.
//				as_phoneNumber		 	string		Phone number of the new contact.
//				as_phoneNumberType 	string		Phone number type. Values: home, work, fax, mobile
//				as_email						string		Email address
//				as_emailType				string		Email type.
//
// Returns:  string
//				0: Success
//				error text: Error returned when failing to create the contact.
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

String		ls_ErrorText

of_setcontactname(as_contactname)

of_clear_JSONArray(iec_phoneNumberarray)
of_addcontactphonenumber(as_phonenumber, as_phonenumbertype,	false)

of_clear_JSONArray(iec_emailsarray)
of_addcontactemail(as_email, as_emailType,	false)

ls_ErrorText	=	of_create_jsonPar(iec_contactPro.of_tostring( ) )
Return	ls_ErrorText
end function

public function eon_cjsonnode of_setcontactorganization (string as_name, string as_department, string as_title, string as_type);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactorganization
//------------------------------------------------------------------------------
// Description: 
//				Creates a contactorganization JSON node and sets the value.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_name 			string		The name of the organization. It is partially supported on iOS.	
//				as_department		string		The department the contact works for. It is partially supported on iOS.	
//				as_title				string	 	The contact's title at the organization. It is partially supported on iOS.	
//				as_type				string		A string that indicates what type of field this is, home for example. It is unsupported on iOS.	
//
// Returns:  eon_cjsonnode		The JSON node with the values.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

eon_cjsonnode		lec_Contactorganization

lec_Contactorganization	=	Create	eon_cjsonnode

lec_Contactorganization.of_addkey('name',as_name)
lec_Contactorganization.of_addkey('department',as_department)
lec_Contactorganization.of_addkey('title',as_title)
lec_Contactorganization.of_addkey('type',as_type)

Return	lec_Contactorganization
end function

public function eon_cjsonnode of_setcontactaddress (string as_type, string as_formatted, string as_streetaddress, string as_locality, string as_region, string as_postalcode, string as_country);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactaddress
//------------------------------------------------------------------------------
// Description: 
//				Creates a contactaddress JSON node and sets the value.
//	             Supported on mobile client only.
//                
// Arguments: 
//				as_type			string		A string indicating what type of field this is, home for example. 
//               as_formatted	string		The full address formatted for display.
//				as_streetaddress	string	The full street address. 
//				as_locality		string		The city or locality.
//				as_region		string		The state or region. 
//				as_postalcode	string	 	The zip code or postal code.
//				as_country		string	 	The country name. 
//
// Returns:  eon_cjsonnode		The JSON node with the values.
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-05
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================

eon_cjsonnode		lec_Contactorganization

lec_Contactorganization	=	Create	eon_cjsonnode

lec_Contactorganization.of_addkey('type',as_type)
lec_Contactorganization.of_addkey('formatted',as_formatted)
lec_Contactorganization.of_addkey('streetAddress',as_streetaddress)
lec_Contactorganization.of_addkey('locality',as_locality)
lec_Contactorganization.of_addkey('region',as_region)
lec_Contactorganization.of_addkey('postalCode',as_postalcode)
lec_Contactorganization.of_addkey('country',as_country)

Return	lec_Contactorganization
end function

public subroutine of_addcontactaddress (string as_type, string as_formatted, string as_streetaddress, string as_locality, string as_region, string as_postalcode, string as_country);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactaddress
//------------------------------------------------------------------------------
// Description:
//				Adds an address to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//
// Arguments:
//               as_type				string		A string indicating what type of field this is, home for example.
//				as_formatted		string		The full address formatted for display. It is unsupported on iOS.
//				streetaddress		string		The full street address.
//				as_locality			string		The city or locality.
//				as_region			string		The state or region.
//				as_postalcode		string		The zip code or postal code.
//				as_country			string	 	The country name.
//
// Returns:  None				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode	
End	If
If	Not	IsValid(iec_addressarray)	Then
	iec_addressarray	=	Create eon_cjsonnodearray
End	If

iec_addressarray.of_append(of_setcontactaddress(as_type, as_formatted,	as_streetaddress,	as_locality,	as_region,	as_postalcode,	as_country))

iec_contactPro.of_addkey( 'addresses', iec_addressarray)
end subroutine

public function string of_getphoto_android (string as_photo);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_getphoto_android	
//------------------------------------------------------------------------------
// Description: 
//				Gets the photo from the device's contact database and creates a copy under the Appeon application folder.
//	             Supported on Android only.
//                
// Arguments: 
//          		string as_photo The location of photo in the device's contact database
//				
// Returns:  string
//				The directory of the photo in the plugin folder of the Appeon application.
//				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
string ls_return
string ls_director
eon_cjsonnodearray  leon_array
leon_array = create eon_cjsonnodearray
ls_director = appeongetcachedir()+"/plugin/"
leon_array.of_append(ls_director)
leon_array.of_append(as_photo)
ieon_ole.AssociateJSwithPB(is_navigatorcontacts,this)
ls_return = ieon_ole.getphotobuf(leon_array.of_tostring(),"@","@")

destroy leon_array
return ls_return
end function

public function integer of_delete_contactid (string as_id);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_delete_contactid
//--------------------------------------------------------------------
// Description:
//				Deletes the contact according to the specified contact ID.
//				Supported on mobile client only.
//--------------------------------------------------------------------
// Arguments:
// 				as_id    string    		The unique ID of the contact to be deleted.     
//
//--------------------------------------------------------------------
// Returns:  integer
//				1 - Success. 
//				-1 - Failure (due to errors or other problems, or failing to find the contact).
//				0 - Not found.
//				
//--------------------------------------------------------------------
// Author:	APPEON		Date: 2016-11
//--------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//====================================================================

String							ls_Return
String							ls_ReturnJSON
Boolean						lbl_Load	
Integer						li_For
String							ls_displayName,	ls_nickname,	ls_formatted
String							ls_phoneNumber
String							ls_Contact_ID
Integer						li_Contact_ID_Type
String							ls_ContactField
eon_cjsonnodearray		leca_findcontact
eon_cjsonnode				lec_contact


//find the contacts includ the as_nameorphone
ls_ContactField	=	of_getcontactfieldtype()
If	ls_ContactField = 'error'	Then return -1
ls_ReturnJSON	=	of_find(ls_ContactField,	'',	true,	ls_ContactField,	false)

//if	Find contact failed the return error
If	Trim(ls_ReturnJSON)	=	'error'		Then	return 	-1

leca_findcontact	=	Create	eon_cjsonnodearray
lbl_Load	=	leca_findcontact.of_load(ls_ReturnJSON)
If	Not	lbl_Load	Then
	If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
	Return	-1
End	If

lec_contact	=	Create	eon_cjsonnode
//find the contact
For	li_For	=	1	To	leca_findcontact.of_Size( )
	lec_contact	=	leca_findcontact.of_Getnodebyindex( li_For	)	
	If	Not	Isvalid(lec_contact)	Then	
		If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
		If	IsValid(lec_contact)	Then	Destroy	lec_contact
		Return	-1
	End	If	
	
	li_Contact_ID_Type	=	lec_contact.of_Gettypebykey('id')
	If	li_Contact_ID_Type	=	1	Then
		ls_Contact_ID	=	lec_contact.of_valuestring( "id")
	ElseIf	li_Contact_ID_Type	=	2	Then
		ls_Contact_ID	=	String(lec_contact.of_valuedouble( "id"))
	else
		If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
		If	IsValid(lec_contact)	Then	Destroy	lec_contact
		Return	-1
	end if 
	
	if not isnull(ls_Contact_ID) and ls_Contact_ID = as_id then 
		of_remove(ls_Contact_ID)
		If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
		If	IsValid(lec_contact)	Then	Destroy	lec_contact
		Return	1
	end if 		
Next

If	IsValid(leca_findcontact)	Then	Destroy	leca_findcontact
If	IsValid(lec_contact)	Then	Destroy	lec_contact		
Return	0
end function

public subroutine of_addcontactname (string as_contactname, string as_givenname, string as_familyname, string as_middlename, boolean abl_pref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactname
//------------------------------------------------------------------------------
// Description:
//				Adds a contact name to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//------------------------------------------------------------------------------
// Arguments:
//                 as_contactname    	string     			The contact's name you want to set.
//                 as_givenname    		string     			The contact's first name you want to set.
//                 as_familyname    	string     			The contact's last name you want to set.
//                 as_middlename    	string     			The contact's middle name you want to set.
//                 abl_pref    				boolean     		Whether used as the preference name. Values: true, false. It is unsupported on some platform.            
//
//------------------------------------------------------------------------------
// Returns:  (none)
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode
End	If

If	Not	IsValid(iec_contactName)	Then
	iec_contactName	=	Create	eon_cjsonnode
End	If

iec_contactPro.of_addkey( 'nickname', as_ContactName)

iec_contactName = of_setcontactname(as_givenname, as_familyname,	as_ContactName,	as_middleName,'','', abl_pref)

iec_contactPro.of_addkey( 'name', iec_contactName)

end subroutine

public function eon_cjsonnode of_setcontactname (string as_givenname, string as_familyname, string as_formatted, string as_middlename, string as_honorificprefix, string as_honorificsuffix, boolean abl_pref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_setcontactname
//------------------------------------------------------------------------------
// Description:
//				Sets the contact's name.
//	             Supported on mobile client only.
//				//Overloads the of_setcontactname function for adding the other name related information.
//------------------------------------------------------------------------------
// Arguments:
//                 as_givenname    		string     The contact's first name.  
//                 as_familyname    	string     The contact's last name. 
//                 as_formatted    		string     The complete name of the contact. 
//                 as_middlename    	string     The contact's middle name. 
//                 as_honorificprefix    	string     The contact's prefix (example Mr. or Dr.) 
//                 as_honorificsuffix    	string     	The contact's suffix (example Esq.). 
//                 abl_pref    				boolean  	Whether used as the preference name. Values: true, false. It is unsupported on some platform. It is unsupported on some platform   
//
//------------------------------------------------------------------------------
// Returns:  eon_cjsonnode		The JSON node with the values.
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
eon_cjsonnode		lec_name

If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode
End	If

lec_name	=	Create	eon_cjsonnode
lec_name.of_addkey( 'givenName', as_givenname)
lec_name.of_addkey( 'formatted', as_formatted)
lec_name.of_addkey( 'familyName', as_familyname)
lec_name.of_addkey( 'middleName', as_middleName)
lec_name.of_addkey( 'honorificPrefix', as_honorificPrefix)
lec_name.of_addkey( 'honorificSuffix', as_honorificSuffix)

Return	lec_name

end function

public subroutine of_addcontactorganization (string as_name, string as_department, string as_title, string as_type, boolean abl_pref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactorganization
//------------------------------------------------------------------------------
// Description:
//				Adds an organization to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//------------------------------------------------------------------------------
// Arguments:
//               as_name				string	 	The name of the organization.
//				as_department		string		The department the contact works for.
//				as_title				string		The contact's title at the organization.
//				as_type				string		A string that indicates what type of field this is, home for example.
//               abl_pref    			boolean  It is unsupported on some platform.       	
//
//------------------------------------------------------------------------------
// Returns:  (none)
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode
End	If
If	Not	IsValid(iec_organizationarray)	Then
	iec_organizationarray	=	Create	eon_cjsonnodearray
End	If

iec_organizationarray.of_append(of_setcontactorganization(as_name, as_department,	as_title,	as_type))
										 
iec_contactPro.of_addkey( 'organizations', iec_organizationarray)
end subroutine

public subroutine of_addcontactorganization (string as_name, string as_department, string as_title, string as_type);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontactorganization
//------------------------------------------------------------------------------
// Description: 
//				Adds an organization to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//                
// Arguments: 
//               as_name				string	 	The name of the organization.
//				as_department		string		The department the contact works for.
//				as_title				string		The contact's title at the organization.
//				as_type				string		A string that indicates what type of field this is, home for example.
//
// Returns:  None				
//				
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-06
//------------------------------------------------------------------------------
// Revision History: 
//                                  1.0   Initial version
//==============================================================================
of_addcontactorganization(as_name, as_department, as_title, as_type, false)
end subroutine

public subroutine of_addcontacturls (string as_value, string as_type, boolean abl_pref);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_addcontacturls
//------------------------------------------------------------------------------
// Description:
//				Adds a URL to the JSON node. It will be used when creating a new contact.
//	             Supported on mobile client only.
//------------------------------------------------------------------------------
// Arguments:
//                 as_value    string     		The URL to be added.
//                 as_type    	string     		The type of the URL.
//                 abl_pref    	boolean     	Whether used as the preference URL. It is unsupported on some platform.                                                        
//
//------------------------------------------------------------------------------
// Returns:  (none)
//
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
If	Not	IsValid(iec_contactPro)	Then
	iec_contactPro	=	Create	eon_cjsonnode
End	If
If	Not	IsValid(iec_urlsarray)	Then
	iec_urlsarray	=	Create eon_cjsonnodearray
End	If

iec_urlsarray.of_append(of_setcontactfield(as_value, as_type,	abl_pref))

iec_contactPro.of_addkey( 'urls', iec_urlsarray)

end subroutine

public function string of_create (string as_contactname, eon_str_cordova_contact_name astr_contact_name, eon_str_cordova_contact_address astr_address[], eon_str_cordova_contact_organization astr_organization[], eon_str_cordova_contact_urls astr_urls[], eon_str_cordova_contact_field astr_phone[], eon_str_cordova_contact_field astr_email[], string as_note);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_create
//------------------------------------------------------------------------------
// Description:
//				Creates a new contact and saves the contact to the device contacts database.
// 				The contact information will be returned as a JSON string to the parameter of the success event.
//	             Supported on mobile client only.	
//               This function is for adding a complete contact including the first name, middle name, last name,
//                one or more addresses/organizations/URLs/phone numbers/email addresses, and note.
//------------------------------------------------------------------------------
// Arguments:
//                 as_contactname			string                                  						Name of the new contact.
//                 astr_contact_name    	eon_str_cordova_contact_name            			Structure for the contact name information such as first name, last name, middle name etc. 
//                 astr_address[]    			eon_str_cordova_contact_address         			Structure array for the contact address information such as multiple addresses.
//                 astr_organization[]    	eon_str_cordova_contact_organization   			Structure array for the contact organization information such as multiple organizations.
//                 astr_urls[]    				eon_str_cordova_contact_urls            			Structure array for the contact URL such as multiple URLs.
//                 astr_phone[]    			eon_str_cordova_contact_field           			Structure array for the contact phone number such as smart phone number, family phone number etc.
//                 astr_email[]    			eon_str_cordova_contact_field           			Structure array for the contact email such as multiple email addresses.
//                 as_note    					string                                   						Note of the new contact.
//
//------------------------------------------------------------------------------
// Returns:  string
//				0: Success
//				error text: Error returned when failing to create the contact.
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
String		ls_ErrorText,	ls_temp
long		ll_num

this.of_addcontactname( as_contactName, astr_contact_name.s_givenname, astr_contact_name.s_familyname, astr_contact_name.s_middlename, false)
iec_contactPro.of_addkey( 'note', as_note)


of_clear_JSONArray(iec_phoneNumberarray)
if upperbound(astr_phone) > 0 then
	for ll_num = 1 to upperbound(astr_phone)
		ls_temp =astr_phone[ll_num].s_value
		if not isnull(ls_temp ) and trim(ls_temp) <> '' then 
			of_addcontactphonenumber(astr_phone[ll_num].s_value, astr_phone[ll_num].s_type,	false)
		end if 
	next
end if 

of_clear_JSONArray(iec_emailsarray)
if upperbound(astr_email) > 0 then
	for ll_num = 1 to upperbound(astr_email)
		ls_temp =astr_phone[ll_num].s_value
		if not isnull(ls_temp ) and trim(ls_temp) <> '' then 
			of_addcontactemail(astr_email[ll_num].s_value, astr_email[ll_num].s_type,	false)
		end if 
	next
end if 

of_clear_JSONArray(iec_urlsarray)
if upperbound(astr_urls) > 0 then
	for ll_num = 1 to upperbound(astr_urls)
		ls_temp =astr_urls[ll_num].s_value
		if not isnull(ls_temp ) and trim(ls_temp) <> '' then 
			of_addcontacturls(astr_urls[ll_num].s_value, astr_urls[ll_num].s_type,	false)
		end if 
	next
end if 

of_clear_JSONArray(iec_organizationarray)
if upperbound(astr_organization) > 0 then
	for ll_num = 1 to upperbound(astr_organization)				
		of_addcontactorganization( astr_organization[ll_num].s_name, astr_organization[ll_num].s_department, astr_organization[ll_num].s_title, astr_organization[ll_num].s_type, false)
	next
end if 

of_clear_JSONArray(iec_addressarray)
if upperbound(astr_address) > 0 then
	for ll_num = 1 to upperbound(astr_address)
		of_addcontactaddress(astr_address[ll_num].s_type, astr_address[ll_num].s_formatted,astr_address[ll_num].s_streetaddress, astr_address[ll_num].s_locality,	astr_address[ll_num].s_region,astr_address[ll_num].s_postalcode,astr_address[ll_num].s_country)
	next
end if 


ls_ErrorText	=	of_create_jsonPar(iec_contactPro.of_tostring( ) )
Return	ls_ErrorText
end function

public function string of_create (string as_contactname, string as_givenname, string as_familyname, string as_middlename, string as_phonenumber, string as_phonenumbertype, string as_email, string as_emailtype);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_create
//------------------------------------------------------------------------------
// Description:
//				Creates a new contact and saves the contact to the device contacts database.
// 				The contact information will be returned as a JSON string to the parameter of the success event.
//	             Supported on mobile client only.
//               This function is for quickly adding a contact with only basic information.
//------------------------------------------------------------------------------
// Arguments:
//                 as_contactname    		string    						Name of the new contact.
//                 as_givenname    			string    						First name of the new contact.
//                 as_familyname    		string    						Last name of the new contact.
//                 as_middlename    		string    						Middle name of the new contact.
//                 as_phonenumber    		string    						Phone number of the new contact.
//                 as_phonenumbertype    string    						Phone number type. Values: home, work, fax, mobile.
//                 as_email    				string    						Email address of the new contact.
//                 as_emailtype    			string     						Email type of the new contact.
//
//------------------------------------------------------------------------------
// Returns:  string
//				0: Success
//				error text: Error returned when failing to create the contact.
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
String		ls_ErrorText

//of_setcontactname(as_contactname)
//of_clear_JSONArray(iec_namearray)
this.of_addcontactname( as_contactName, as_givenname, as_familyname, as_middlename, false)

of_clear_JSONArray(iec_phoneNumberarray)
of_addcontactphonenumber(as_phonenumber, as_phonenumbertype,	false)

of_clear_JSONArray(iec_emailsarray)
of_addcontactemail(as_email, as_emailType,	false)

ls_ErrorText	=	of_create_jsonPar(iec_contactPro.of_tostring( ) )
Return	ls_ErrorText
end function

public function any of_find_contactname (string as_contactopt_filter);//==============================================================================
// 
// Copyright ? 2001-2016 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: of_find_contactname
//------------------------------------------------------------------------------
// Description:
//				Finds a contact's name, ID, display name, and nick name.
//	             Supported on mobile client only.
//
//------------------------------------------------------------------------------
// Arguments:
//                 as_contactopt_filter    string     				The search string used to find navigator.contacts.
//
//------------------------------------------------------------------------------
// Returns:  any
//				eon_str_cordova_contact_find[]:if successful, the structure stores the contact name, phone number, email, address, organization, and photo.
//														  if not found, eon_str_cordova_contact_find.s_errortext = notfind.
//													       if error occurs, eon_str_cordova_contact_find.s_errortext = error.
//------------------------------------------------------------------------------
// Author:         APPEON            Date: 2016-11
//------------------------------------------------------------------------------
// Revision History:
//                                       1.0   Initial version
//==============================================================================
String		ls_ReturnJSON
String		ls_ContactField

eon_str_cordova_contact_find		lestr_contact_find[] //存储返回值

//设置过滤的时比较的属性列 all of the Set name's property and phonenumbers property
eon_cjsonnodearray		lec_ContactFieldArray
lec_ContactFieldArray	=	Create	eon_cjsonnodearray
lec_ContactFieldArray.of_append( 'id')										
lec_ContactFieldArray.of_append( 'displayName')
lec_ContactFieldArray.of_append( 'name')
lec_ContactFieldArray.of_append( 'nickname')
lec_ContactFieldArray.of_append( 'formatted')
				
ls_ContactField	=	lec_ContactFieldArray.of_Tostring( )
//find the contact like user input
ls_ReturnJSON	=	of_find(ls_ContactField,	as_ContactOPT_filter,	true,	ls_ContactField,	false)

//if	Find contact failed the return error
If	Trim(ls_ReturnJSON)	=	'error'		Then
	lestr_contact_find[1].s_errortext	=	'error'
	If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
	Return	lestr_contact_find
End	If

//from the JSON String Get the contact name and phoneNumber
eon_cjsonnodearray		leca_findContacts
eon_cjsonnode			lec_Contact
eon_cjsonnode			lec_Contact_name
Integer		li_For,	li_For_2
Integer		li_type, 	li_Contact_ID_Type
String			ls_displayName,	ls_nickname,	ls_formatted,	ls_Name, ls_id
Boolean		lbl_Return

leca_findContacts	=	Create	eon_cjsonnodearray

lbl_Return	=	leca_findContacts.of_Load( ls_ReturnJSON)
If	Not	lbl_Return	Then
	lestr_contact_find[1].s_errortext	=	'error'
	If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
	If	IsValid(leca_findContacts)	Then	Destroy	leca_findContacts
	Return	lestr_contact_find
End	If

lec_Contact	=	Create	eon_cjsonnode
lec_Contact_name	=	Create	eon_cjsonnode

For	li_For	=1	To	leca_findContacts.of_size(	)
	li_type	=	leca_findContacts.of_gettypebyindex( li_For	)
	If	li_Type	<>	5	Then
		lestr_contact_find[li_For].s_errortext	=	'error the JSON format is incorrect please check!'
	Else
		lec_Contact	=	leca_findContacts.of_getnodebyindex(	li_For	)
		
		//Get the contact name from the property( nickname、displayName、formatted)
		ls_nickname	=	lec_Contact.of_valuestring( 'nickname')
		ls_displayName	=	lec_Contact.of_valuestring( 'displayName')
		lec_Contact_name	=	lec_Contact.of_Valuenode( 'name')

		li_Contact_ID_Type	=	lec_Contact.of_Gettypebykey('id')
		If	li_Contact_ID_Type	=	1	Then
			ls_id	=	lec_Contact.of_valuestring( "id")
		ElseIf	li_Contact_ID_Type	=	2	Then
			ls_id	=	String(lec_Contact.of_valuedouble( "id"))
		else
			ls_id = ''
		end if 
		//check the contact.name node isvalid
		If	Not IsValid(lec_Contact_name)	Then
			SetNull(ls_formatted)
		Else
			ls_formatted	=	lec_Contact_name.of_valuestring( 'formatted'	)
		End	If
		
		If	Not (IsNull( ls_nickname) Or Trim(ls_nickname)=''	)	Then
			ls_Name	=	ls_nickname
		ElseIf	Not (	IsNull(ls_DisplayName)	Or Trim(ls_displayName)='') Then
			ls_Name	=	ls_DisplayName
		Else
			ls_Name	=	ls_formatted
		End	If
		lestr_contact_find[li_For].s_contactname	=ls_Name
		lestr_contact_find[li_For].id	=ls_id
	End	If
Next

If	IsValid(lec_Contact)	Then	Destroy	lec_Contact
If	IsValid(lec_Contact_name)	Then	Destroy	lec_Contact_name
If	IsValid(lec_ContactFieldArray)	Then	Destroy	lec_ContactFieldArray
If	IsValid(leca_findContacts)	Then	Destroy	leca_findContacts


Return		lestr_contact_find

end function

on eon_cordova_contact.create
call super::create
end on

on eon_cordova_contact.destroy
call super::destroy
end on

event constructor;call super::constructor;/**************************************************************************************
Description about this object:
1. Use this object to create or find contact. You should first call the of_register() function to bind with the success event 
    and error event.

***************************************************************************************/

//of_init_jsonobject() //create the JSON object, use it to set the contact's property
end event

event destructor;call super::destructor;of_Destroy_object()
end event

