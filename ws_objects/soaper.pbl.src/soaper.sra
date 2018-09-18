$PBExportHeader$soaper.sra
$PBExportComments$Generated SDI Application Object
forward
global type soaper from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type soaper from application
string appname = "soaper"
end type
global soaper soaper

on soaper.create
appname = "soaper"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on soaper.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

event open;//*-----------------------------------------------------------------*/
//*    open:  Application Open Script
//*           1) Opens Main window
//*-----------------------------------------------------------------*/
Open ( w_soaper_main )
end event

