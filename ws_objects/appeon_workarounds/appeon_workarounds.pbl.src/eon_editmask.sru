$PBExportHeader$eon_editmask.sru
forward
global type eon_editmask from editmask
end type
end forward

global type eon_editmask from editmask
integer width = 457
integer height = 128
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type
global eon_editmask eon_editmask

type variables
integer ii_vertical  //When ii_vertical is set to 1, eon_editmask is centered vertically; when set to 0, eon_editmask is consistent with PowerBuilder.
integer ii_keyboardtype //Sets the type of the keyboard when eon_editmask gets focus: 0 - alphabetical keyboard, 1 - numerical keyboard, 2 - URL keyboard. 2 is unsupported on Android devices, thus 0 will be used instead.
end variables

on eon_editmask.create
end on

on eon_editmask.destroy
end on

