$PBExportHeader$w_soaper_main.srw
$PBExportComments$Generated SDI Main Window
forward
global type w_soaper_main from window
end type
type cb_soap_test_two from commandbutton within w_soaper_main
end type
type cb_soap_test_one from commandbutton within w_soaper_main
end type
type st_title from statictext within w_soaper_main
end type
end forward

global type w_soaper_main from window
integer width = 1490
integer height = 1820
boolean titlebar = true
string title = "Main Window"
windowstate windowstate = maximized!
long backcolor = 79416533
string icon = "test.ico"
boolean toolbarvisible = false
boolean center = true
cb_soap_test_two cb_soap_test_two
cb_soap_test_one cb_soap_test_one
st_title st_title
end type
global w_soaper_main w_soaper_main

on w_soaper_main.create
this.cb_soap_test_two=create cb_soap_test_two
this.cb_soap_test_one=create cb_soap_test_one
this.st_title=create st_title
this.Control[]={this.cb_soap_test_two,&
this.cb_soap_test_one,&
this.st_title}
end on

on w_soaper_main.destroy
destroy(this.cb_soap_test_two)
destroy(this.cb_soap_test_one)
destroy(this.st_title)
end on

event open;/*
	Open Event
*/

Long ll_bg_colour, ll_fg_colour

ll_bg_colour 					= 		RGB(60,90,153)
ll_fg_colour					=		RGB(255,255,255)

This.st_title.textcolor 	= 		ll_fg_colour
This.st_title.backcolor 	= 		ll_bg_colour
This.backcolor 				= 		ll_bg_colour
end event

event resize;/*
	Resize Event
*/

// Title
this.st_title.width = newwidth

// Test Buttons
this.cb_soap_test_one.X = (newwidth / 2) - (this.cb_soap_test_one.width/2)
this.cb_soap_test_two.X = this.cb_soap_test_one.X
end event

type cb_soap_test_two from commandbutton within w_soaper_main
integer x = 370
integer y = 700
integer width = 672
integer height = 276
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Soap Test Two"
end type

event clicked;appeonwebservicecomponent 	caller
integer 							IRet
any 								paralist[]
String 							ls_message

// Create Appeon Webservic Component
caller= create appeonwebservicecomponent
caller.calltype			=	"1"
caller.proxydllorurl		=	"http://azurehelloworldappeonmobiletest.azurewebsites.net/AzureService.svc?wsdl"
caller.classdescript		=	""

// Call End Point
IRet							=	caller.of_callwebservice("GetHelloWorld")
if IRet=0 then
	ls_message = String(caller.ReturnValue)
	MessageBox('Success',ls_message)
else
	MessageBox('CUSTOM ERROR',caller.ErrorText)
end if





end event

type cb_soap_test_one from commandbutton within w_soaper_main
integer x = 370
integer y = 332
integer width = 672
integer height = 276
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Soap Test One"
end type

event clicked;appeonwebservicecomponent 	caller
integer 							IRet
any 								paralist[]
String 							ls_message

// Create Appeon Webservic Component
caller= create appeonwebservicecomponent
caller.calltype			=	"1"
caller.proxydllorurl		=	"http://www.dneonline.com/calculator.asmx?wsdl" 
caller.classdescript		=	""

// Add parameters, 2+3
paralist[1]=2
paralist[2]=3
IRet=caller.of_callwebservice("Add",paralist)

// Call End Point
if IRet=0 then
	ls_message = String(caller.ReturnValue)
	MessageBox('Success',ls_message)
else
	MessageBox('CUSTOM ERROR',caller.ErrorText)
end if





end event

type st_title from statictext within w_soaper_main
integer y = 64
integer width = 1481
integer height = 120
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Soap Test"
alignment alignment = center!
boolean focusrectangle = false
end type

