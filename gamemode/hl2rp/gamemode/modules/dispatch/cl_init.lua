function DispatchMain()

-- gui.EnableScreenClicker(true)
local DispatchMainframe = vgui.Create( "DFrame" )
DispatchMainframe:SetSize( ScrW(), ScrH() )
DispatchMainframe:SetPos( 0, 0 )
DispatchMainframe:SetTitle( "Dispatch System" )
DispatchMainframe:SetDraggable( false )
-- DispatchMainframe:MakePopup()
DispatchMainframe:SetSkin( "Cortex" )
 -- DispatchMainframe:ParentToHUD()
-- DispatchMainframe:InvalidateParent( false ) 
function DispatchMainframe:OnClose()
	LocalPlayer():ChatPrint "You have quit."
	surface.PlaySound("buttons/combine_button1.wav")
	LocalPlayer():ConCommand("say /citizen")
end

-- Image panel of Dr. Breen
local breen_img = vgui.Create( "DImage", DispatchMainframe )	-- Add image to Frame
breen_img:SetPos( 0, 20 )	-- Move it into frame
breen_img:SetSize( ScrW(), ScrH() )	-- Size it to 150x150 ScrW(), ScrH() - 30

-- Set material relative to "garrysmod/materials/"
breen_img:SetImage( "apex/dispatch/dispatch_ui.png" )


local CitLabel = vgui.Create( "DLabel", DispatchMainframe )


CitLabel:SetPos( 1829, 237 )
CitLabel:SetSize( 300, 100 )
CitLabel:SetText( "Time: ", ictime )
CitLabel:SetFont( "ChatFont" )



local CitLabel = vgui.Create( "DLabel", DispatchMainframe )
citcount = 0
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_CITIZEN then
    citcount = citcount + 1

end
end


CitLabel:SetPos( 1404, 920 )
CitLabel:SetSize( 300, 100 )
CitLabel:SetText( "Citizen count:".. citcount )
CitLabel:SetFont( "ChatFont" )

local CPLabel = vgui.Create( "DLabel", DispatchMainframe )
cpcount = 0
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_CP then
    cpcount = cpcount + 1

end
end

CPLabel:SetPos( 1404, 940 )
CPLabel:SetSize( 300, 100 )
CPLabel:SetText( "Civil Protection count:".. cpcount )
CPLabel:SetFont( "ChatFont" )

local OWLabel = vgui.Create( "DLabel", DispatchMainframe )
owcount = 0
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_OVERWATCH then
    owcount = owcount + 1

end
end

OWLabel:SetPos( 1404, 960 )
OWLabel:SetSize( 300, 100 )
OWLabel:SetText( "Overwatch count:".. cpcount )
OWLabel:SetFont( "ChatFont" )


local BodyCamOpen = vgui.Create( "DButton", DispatchMainframe )
BodyCamOpen:SetPos( ScrW() - 220, 430 )
BodyCamOpen:SetText( "Open Bodycam Database" )
BodyCamOpen:SetSize( 210, 90 )
BodyCamOpen:SetSkin( "Cortex" )
BodyCamOpen.DoClick = function()
	print( "Button was clicked!" )
	surface.PlaySound("buttons/combine_button1.wav")
	BdyCam()
end




local DispatchCOpen = vgui.Create( "DButton", DispatchMainframe )
DispatchCOpen:SetPos( ScrW() - 220, 525 ) -- 95
DispatchCOpen:SetText( "Dispatch to Citzen Notification" )
DispatchCOpen:SetSize( 210, 90 )
DispatchCOpen:SetSkin( "Cortex" )
DispatchCOpen.DoClick = function()
	print( "Button was clicked!" )
	surface.PlaySound("buttons/combine_button1.wav")
	DtoC()
end

local jwtgl = "yep"
local DispatchJWTggl = vgui.Create( "DButton", DispatchMainframe )
DispatchJWTggl:SetPos( ScrW() - 220, 525 + 95 ) -- 95
DispatchJWTggl:SetText( "Toggle JW" )
DispatchJWTggl:SetSize( 210, 90 )
DispatchJWTggl:SetSkin( "Cortex" )
DispatchJWTggl.DoClick = function()
	surface.PlaySound("buttons/combine_button1.wav")
if jwtgl == "yep" then
LocalPlayer():ConCommand("dispatch_mapmanage jwon")
jwtgl = "nop"
else
LocalPlayer():ConCommand("dispatch_mapmanage jwoff")
	end
end
local lktgl = "yep"
local DispatchLDTggl = vgui.Create( "DButton", DispatchMainframe )
DispatchLDTggl:SetPos( ScrW() - 220, 525 + 190 ) -- 95
DispatchLDTggl:SetText( "Activate Lockdown" )
DispatchLDTggl:SetSize( 210, 90 )
DispatchLDTggl:SetSkin( "Cortex" )
DispatchLDTggl.DoClick = function()
	surface.PlaySound("buttons/combine_button1.wav")
if lktgl == "yep" then
LocalPlayer():ConCommand("dispatch_mapmanage lockdownon")
lktgl = "nop"
else
LocalPlayer():ConCommand("dispatch_mapmanage lockdownoff")
end
end

local DispatchuuOpen = vgui.Create( "DButton", DispatchMainframe )
DispatchuuOpen:SetPos( ScrW() - 220, 525 + 285 ) -- 95
DispatchuuOpen:SetText( "Dispatch to Unit Notification" )
DispatchuuOpen:SetSize( 210, 90 )
DispatchCOpen:SetSkin( "Cortex" )
DispatchuuOpen.DoClick = function()
	print( "Button was clicked!" )
	DtoCP()
end

-- gate 2 1253	500 gate 3 1269	370 gate 4 931 356 cam 2 1257	462


local gatecheck1 = "no"
local gatecheck2 = "no"
local gatecheck3 = "no"
local gatecheck4 = "no"

Gate1Btn = vgui.Create( "DImageButton", DispatchMainframe )
Gate1Btn:SetPos( 814, 614 )								// Set position
Gate1Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Gate1Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Gate1Btn.DoClick = function()
if gatecheck1 == "no" then
Gate1Btn:SetImage( "apex/dispatch/dispatch_gate_closed.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate4")
gatecheck1 = "yes"
surface.PlaySound( "buttons/button5.wav" )
else
Gate1Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate4")
gatecheck1 = "no"
surface.PlaySound( "buttons/button6.wav" )
end

end

Gate2Btn = vgui.Create( "DImageButton", DispatchMainframe )
Gate2Btn:SetPos( 1253, 485 )								// Set position
Gate2Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Gate2Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Gate2Btn.DoClick = function()
if gatecheck2 == "no" then
Gate2Btn:SetImage( "apex/dispatch/dispatch_gate_closed.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate2")
gatecheck2 = "yes"
surface.PlaySound( "buttons/button5.wav" )
else
Gate2Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate2")
gatecheck2 = "no"
surface.PlaySound( "buttons/button6.wav" )
end
end

Gate3Btn = vgui.Create( "DImageButton", DispatchMainframe )
Gate3Btn:SetPos( 1265, 365 )								// Set position
Gate3Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Gate3Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Gate3Btn.DoClick = function()
if gatecheck3 == "no" then
Gate3Btn:SetImage( "apex/dispatch/dispatch_gate_closed.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate1")
gatecheck3 = "yes"
surface.PlaySound( "buttons/button5.wav" )
else
Gate3Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate1")
surface.PlaySound( "buttons/button6.wav" )
gatecheck3 = "no"
end

end

Gate4Btn = vgui.Create( "DImageButton", DispatchMainframe )
Gate4Btn:SetPos( 931, 347 )								// Set position
Gate4Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Gate4Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Gate4Btn.DoClick = function()
if gatecheck4 == "no" then
Gate4Btn:SetImage( "apex/dispatch/dispatch_gate_closed.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate3")
gatecheck4 = "yes"
surface.PlaySound( "buttons/button5.wav" )
else
Gate4Btn:SetImage( "apex/dispatch/dispatch_gate_open.png" )
LocalPlayer():ConCommand("dispatch_mapmanage gate3")
gatecheck4 = "no"
surface.PlaySound( "buttons/button6.wav" )
end
end

Cam1Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam1Btn:SetPos( 955, 492 )								// Set position
Cam1Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam1Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam1Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
	CCTV1()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam2Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam2Btn:SetPos( 958, 450 )								// Set position
Cam2Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam2Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam2Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
	CCTV2()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam3Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam3Btn:SetPos( 1165, 494 )								// Set position
Cam3Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam3Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam3Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
CCTV3()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam4Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam4Btn:SetPos( 1230, 365 )								// Set position
Cam4Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam4Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam4Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
CCTV4()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam5Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam5Btn:SetPos( 984, 394 )								// Set position
Cam5Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam5Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam5Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
CCTV5()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam6Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam6Btn:SetPos( 822, 301 )								// Set position
Cam6Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam6Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam6Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
CCTV6()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam7Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam7Btn:SetPos( 798, 678 )								// Set position
Cam7Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam7Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam7Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
CCTV7()
	surface.PlaySound("buttons/combine_button1.wav")
end

Cam8Btn = vgui.Create( "DImageButton", DispatchMainframe )
Cam8Btn:SetPos( 744, 586 )								// Set position
Cam8Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Cam8Btn:SetImage( "apex/dispatch/dispatch_camera.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Cam8Btn.DoClick = function()
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocoverlay" )
CCTV8()
	surface.PlaySound("buttons/combine_button1.wav")
end

Way1Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way1Btn:SetPos( 993, 489 )								// Set position
Way1Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way1Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way1Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
	Way1Btn:SetImage( "apex/dispatch/dispatch_rally_on.png" )
	timer.Simple( 120, function() Way1Btn:SetImage( "apex/dispatch/dispatch_rally_on.png" ) end )
end

Way2Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way2Btn:SetPos( 598, 637 )								// Set position
Way2Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way2Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way2Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

Way3Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way3Btn:SetPos( 794, 624 )								// Set position
Way3Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way3Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way3Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

Way4Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way4Btn:SetPos( 761, 397 )								// Set position
Way4Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way4Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way4Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

Way5Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way5Btn:SetPos( 793, 848 )								// Set position
Way5Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way5Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way5Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

Way6Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way6Btn:SetPos( 1220, 488 )								// Set position
Way6Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way6Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory						 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way6Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

Way7Btn = vgui.Create( "DImageButton", DispatchMainframe )
Way7Btn:SetPos( 983, 366 )								// Set position
Way7Btn:SetSize( 22, 22 )							// OPTIONAL: Use instead of SizeToContents() if you know/want to fix the size
Way7Btn:SetImage( "apex/dispatch/dispatch_rally.png" )		 // Set the material - relative to /materials/ directory
--Gate1Btn:SizeToContents()							 // OPTIONAL: Use instead of SetSize if you want to resize automatically ( without stretching )
Way7Btn.DoClick = function()
	Msg( "You clicked the image!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

local ToggleCCTV = vgui.Create( "DButton", DispatchMainframe )
ToggleCCTV:SetPos( ScrW() - 199, 40 )
ToggleCCTV:SetText( "Toggle CCTV" )
ToggleCCTV:SetSize( 180, 60 )
ToggleCCTV:SetSkin( "Cortex" )
tgglcctv = "yes"
ToggleCCTV.DoClick = function()
	surface.PlaySound("buttons/combine_button1.wav")
	if tgglcctv == "yes" then
	Cam3Btn:Hide()
	Cam2Btn:Hide()
	Cam1Btn:Hide()
	Cam3Btn:Hide()
	Cam4Btn:Hide()
	Cam5Btn:Hide()
	Cam6Btn:Hide()
	Cam7Btn:Hide()
	Cam8Btn:Hide()
	tgglcctv = "no"
	else
	ResetCam()
	Cam3Btn:Show()
	Cam2Btn:Show()
	Cam1Btn:Show()
	Cam4Btn:Show()
	Cam5Btn:Show()
	Cam6Btn:Show()
	Cam7Btn:Show()
	Cam8Btn:Show()
	tgglcctv = "yes"


	end

end

local ToggleGATE = vgui.Create( "DButton", DispatchMainframe )
ToggleGATE:SetPos( ScrW() - 199, 105 )
ToggleGATE:SetText( "Toggle Gates" )
ToggleGATE:SetSize( 180, 60 )
ToggleGATE:SetSkin( "Cortex" )
tgglgate = "yes"
ToggleGATE.DoClick = function()
	surface.PlaySound("buttons/combine_button1.wav")
	print( "Button was clicked!" )
	if tgglgate == "yes" then
	Gate3Btn:Hide()
	Gate2Btn:Hide()
	Gate1Btn:Hide()
	Gate4Btn:Hide()
	tgglgate = "no"
	else
	Gate3Btn:Show()
	Gate2Btn:Show()
	Gate1Btn:Show()
	Gate4Btn:Show()
	tgglgate = "yes"



end
end

local ToggleUNIT = vgui.Create( "DButton", DispatchMainframe )
ToggleUNIT:SetPos( ScrW() - 199, 170 )
ToggleUNIT:SetText( "Toggle Units" )
ToggleUNIT:SetSize( 180, 60 )
ToggleUNIT:SetSkin( "Cortex" )
ToggleUNIT.DoClick = function()
	print( "Button was clicked!" )
	surface.PlaySound("buttons/combine_button1.wav")
end

local ToggleREQ = vgui.Create( "DButton", DispatchMainframe )
ToggleREQ:SetPos( ScrW() - 199, 235 )
ToggleREQ:SetText( "Toggle Waypoints" )
ToggleREQ:SetSize( 180, 60 )
ToggleREQ:SetSkin( "Cortex" )
tgglreq = "yes"
ToggleREQ.DoClick = function()
	surface.PlaySound("buttons/combine_button1.wav")
	print( "Button was clicked!" )
	if tgglreq == "yes" then
	Way7Btn:Hide()
	Way6Btn:Hide()
	Way5Btn:Hide()
	Way4Btn:Hide()
	Way3Btn:Hide()
	Way2Btn:Hide()
	Way1Btn:Hide()
	tgglreq = "no"
	else
	Way7Btn:Show()
	Way6Btn:Show()
	Way5Btn:Show()
	Way4Btn:Show()
	Way3Btn:Show()
	Way2Btn:Show()
	Way1Btn:Show()
	tgglreq = "yes"



end
end

-- ADDITIONAL PANELS BELOW THIS LINE:

-- ** BDYCAM SYSTEM **
function BdyCam()
local DispatchBdyCamFrame = vgui.Create( "DFrame" )
DispatchBdyCamFrame:SetSize( 500,700 )
DispatchBdyCamFrame:Center()
DispatchBdyCamFrame:SetTitle( "Bodycam Database" )
DispatchBdyCamFrame:SetDraggable( true )
DispatchBdyCamFrame:MakePopup()
DispatchBdyCamFrame:SetSkin( "Cortex" )
--DispatchBdyCamFrame:Hide()


local DComboBox44 = vgui.Create( "DComboBox", DispatchBdyCamFrame )
DComboBox44:SetPos( 95, 50 )
DComboBox44:SetSize( 300, 35 )
DComboBox44:SetValue( "Units" )
DComboBox44.OnSelect = function( panel, index, value )
	print( value .." was selected!" )
	bdycamval = value
end

selfid = LocalPlayer():SteamID()
for k,v in pairs(player.GetAll()) do
if v:Team() == TEAM_CP or v:Team() == TEAM_OVERWATCH  then
    DComboBox44:AddChoice(v:Nick()) -- Add linese

end
end

local DButton33 = vgui.Create( "DButton", DispatchBdyCamFrame )
DButton33:SetPos( 70, 600 )
DButton33:SetText( "Connect to Bodycam" )
DButton33:SetSize( 350, 60 )
DButton33.DoClick = function()

LocalPlayer():ConCommand( "dispatch_bodycam_on " .. bdycamval )
BdyCamUI()
print(LocalPlayer():GetPData( "waypos", 1 ))

end
end

function BdyCamUI()


local CPDButton34 = vgui.Create( "DButton" )
CPDButton34:SetPos( 0, 30 )
CPDButton34:SetText( "Dispatch To Unit Notification" )
CPDButton34:SetSize( 170, 30 )
CPDButton34:SetSkin( "Cortex" )
CPDButton34.DoClick = function()
DtoCP()


end

local CPDButton24 = vgui.Create( "DButton" )
CPDButton24:SetPos( 0, 0 )
CPDButton24:SetText( "Exit Bodycam" )
CPDButton24:SetSize( 170, 30 )
CPDButton24:SetSkin( "Cortex" )
DispatchMainframe:Hide()
CPDButton24.DoClick = function()
CPDButton24:Remove()
	LocalPlayer():ConCommand( "dispatch_bodycam_off" )
DispatchMain()
	CPDButton24:Remove()
CPDButton34:Remove()

end
end




function DtoC()
-- ** DISPATCH TO CITIZEN SYSTEM **
local DispatchCFrame = vgui.Create( "DFrame" )
DispatchCFrame:SetSize( 500,300 )
DispatchCFrame:Center()
DispatchCFrame:SetTitle( "Dispatch Annoucement System" )
DispatchCFrame:SetDraggable( true )
DispatchCFrame:MakePopup()
DispatchCFrame:SetSkin( "Cortex" )
--DispatchBdyCamFrame:Hide()
textentry = "no"
comboentry = "no"

local DComboBox = vgui.Create( "DComboBox", DispatchCFrame )
val1 = ""
DComboBox:SetPos( 45, 30 )
DComboBox:SetSize( 400, 50 )
DComboBox:SetValue( "Options" )
DComboBox:AddChoice( "ANTI-CITIZEN" )
DComboBox:AddChoice( "ASSUME POSITIONS" )
DComboBox:AddChoice( "AUTONOMOUS JUDGEMENT" )
DComboBox:AddChoice( "CITIZEN RELOCATION" )
DComboBox:AddChoice( "CONSPIRACY" )
DComboBox:AddChoice( "CONVICTED" )
DComboBox:AddChoice( "DEDUCTED" )
DComboBox:AddChoice( "EVASION BEHAVIOR" )
DComboBox:AddChoice( "INSPECTION" )
DComboBox:AddChoice( "MISCOUNT DETECTED" )
DComboBox:AddChoice( "MISSION FAILURE" )
DComboBox:AddChoice( "OVERWATCH ACKNOWLEDGES" )
DComboBox:AddChoice( "POTENTIAL INFECTION" )
DComboBox:AddChoice( "RECEIVE YOUR VERDICT" )
DComboBox:AddChoice( "STATUS EVASION" )
DComboBox:AddChoice( "UNIDENTIFIED" )
DComboBox:AddChoice( "UNREST PROCEDURE" )
DComboBox:AddChoice( "UNREST STRUCTURE" )
DComboBox.OnSelect = function( panel, index, value )
val1 = value
comboentry = "yep"
end

local TextEntry = vgui.Create( "DTextEntry", DispatchCFrame ) -- create the form as a child of frame
TextEntry:SetPos( 45, 180 )
TextEntry:SetSize( 400, 20 )
TextEntry:SetText( "(optional) Custom Message (press enter when done)" )
TextEntry.OnEnter = function( self )
	val2 = self:GetValue()
	textentry = "yep"
end

local DButton = vgui.Create( "DButton", DispatchCFrame )
DButton:SetPos( 70, 220 )
DButton:SetText( "Send" )
DButton:SetSize( 350, 60 )
DButton.DoClick = function()
if textentry == "yep" then
LocalPlayer():ConCommand( "say /dispatch ".. val2 )

elseif comboentry == "yep" then
	LocalPlayer():ConCommand( "say /dispatch ".. val1 )
end

end

end


function DtoCP()
-- ** DISPATCH TO CITIZEN SYSTEM **
local CPDispatchCFrame = vgui.Create( "DFrame" )
CPDispatchCFrame:SetSize( 1650,250 )
CPDispatchCFrame:Center()
CPDispatchCFrame:SetTitle( "Dispatch Radio System" )
CPDispatchCFrame:SetDraggable( true )
CPDispatchCFrame:MakePopup()
CPDispatchCFrame:SetSkin( "Cortex" )
--DispatchBdyCamFrame:Hide()
textentry = "no"
comboentry = "no"

local CPComboBox = vgui.Create( "DComboBox", CPDispatchCFrame )
val1 = ""
CPComboBox:SetPos( 1120, 30 )
CPComboBox:SetSize( 500, 30 )
CPComboBox:SetValue( "1" )
CPComboBox:AddChoice( "None" )
CPComboBox:AddChoice( "10-103m, disturbance by mentally unfit" )
CPComboBox:AddChoice( "10-0, begin scanning" )
CPComboBox:AddChoice( "148, Resisting arrest" )
CPComboBox:AddChoice( "243, assualt on protection team" )
CPComboBox:AddChoice( "50% reproduction credits" )
CPComboBox:AddChoice( "27, attempted crime" )
CPComboBox:AddChoice( "507, public non-complicance" )
CPComboBox:AddChoice( "603, unlawful entry" )
CPComboBox:AddChoice( "94, weapon" )
CPComboBox:AddChoice( "Airwatch reports no activity" )
CPComboBox:AddChoice( "All protection team units, complete sentencing at will" )
CPComboBox:AddChoice( "All teams respond code 3" )
CPComboBox:AddChoice( "All units deliver terminal verdict immediatley" )
CPComboBox:AddChoice( "All units apply forward pressure" )
CPComboBox:AddChoice( "All units: Verdict Code is" )
CPComboBox:AddChoice( "Attention, you have been charged with" )
CPComboBox:AddChoice( "Capital Malcompliance" )
CPComboBox:AddChoice( "Immediate amputation" )
CPComboBox:AddChoice( "In progress" )
CPComboBox:AddChoice( "Investigate and report" )
CPComboBox:AddChoice( "Level 5 anti-civil activity" )
CPComboBox:AddChoice( "Officer closing on suspect" )
CPComboBox:AddChoice( "Permanent off-world service assignment" )
CPComboBox:AddChoice( "Protection team, be adivsed: Accomplices operating in area" )
CPComboBox:AddChoice( "Protection team, lock down your location. Sacrifice code" )
CPComboBox:AddChoice( "Reinforcement teams code 3" )
CPComboBox:AddChoice( "Remaining units contain" )
CPComboBox:AddChoice( "Reminder: Memory replacement is the first step towards rank privileges" )
CPComboBox:AddChoice( "Report please" )
CPComboBox:AddChoice( "Respond" )
CPComboBox:AddChoice( "Socio-stabilization restored" )
CPComboBox:AddChoice( "Remaining units contain" )
CPComboBox:AddChoice( "Suspend negotiations" )
CPComboBox:AddChoice( "Unit deserviced" )
CPComboBox:AddChoice( "You are judged guilty by Civil Protection teams" ) 
CPComboBox:AddChoice( "Unit down at" ) 
CPComboBox:AddChoice( "404 zone" )
CPComboBox:AddChoice( "Industrial zone" )
CPComboBox:AddChoice( "Zero" )
CPComboBox:AddChoice( "One" )
CPComboBox:AddChoice( "Two" )
CPComboBox:AddChoice( "Three" )
CPComboBox:AddChoice( "Four" )
CPComboBox:AddChoice( "Five" )
CPComboBox:AddChoice( "Six" )
CPComboBox:AddChoice( "Seven" )
CPComboBox:AddChoice( "Eight" )
CPComboBox:AddChoice( "Nine" )
CPComboBox:AddChoice( "Administer" )
CPComboBox:AddChoice( "Amputate" )
CPComboBox:AddChoice( "Anti-Citizen" )

CPComboBox.OnSelect = function( panel, index, value )
surface.PlaySound("buttons/combine_button1.wav")
if value == "Unit down at" then
valcp3 = "Unit down"
elseif value == "You are judged guilty by Civil Protection teams" then
valcp3 = "judged guilty"
elseif value == "Remaining units contain" then
valcp3 = "Remaining units"
elseif value == "Socio-stabilization restored" then
valcp3 = "Socio-stabilization"
elseif value == "Reminder: Memory replacement is the first step towards rank privileges" then
valcp3 = "Memory"
elseif value == "Remaining units contain" then
valcp3 = "Units contain"
elseif value == "Reinforcement teams code 3" then
valcp3 = "Reinforcement teams"
elseif value == "Protection team, lock down your location. Sacrifice code" then
valcp3 = "lock down"
elseif value == "Protection team, be adivsed: Accomplices operating in area" then
valcp3 = "Accomplices operating"
elseif value == "Permanent off-world service assignment" then
valcp3 = "off-world service"
elseif value == "Officer closing on suspect" then
valcp3 = "Officer closing"
elseif value == "Level 5 anti-civil activity" then
valcp3 = "Level 5"
elseif value == "Investigate and report" then
valcp3 = "Investigate report"
elseif value == "Attention, you have been charged with" then
valcp3 = "charged with"
elseif value == "All units: Verdict Code is" then
valcp3 = "Verdict Code"
elseif value == "All protection team units, complete sentencing at will" then
valcp3 = "sentencing"
elseif value == "Airwatch reports no activity" then
valcp3 = "No activity"
elseif value == "10-103m, disturbance by mentally unfit" then
valcp3 = "10-103m"
elseif value == "10-0, begin scanning" then
valcp3 = "10-0"
elseif value == "148, Resisting arrest" then
valcp3 = "148"
elseif value == "243, assualt on protection team" then
valcp3 = "243"
elseif value == "50% reproduction credits" then
valcp3 = "50%"
elseif value == "27, attempted crime" then
valcp3 = "27"
elseif value == "507, public non-complicance" then
valcp3 = "507"
elseif value == "603, unlawful entry" then
valcp3 = "603"
elseif value == "94, weapon" then
valcp3 = "94"
elseif value == "Respond" then
valcp1 = "Respond111"
elseif value == "None" then
valcp3 = ""

else
valcp3 = value
end
end

local CPComboBox2 = vgui.Create( "DComboBox", CPDispatchCFrame )
val1 = ""
CPComboBox2:SetPos( 570, 30 )
CPComboBox2:SetSize( 500, 30 )
CPComboBox2:SetValue( "2" )
CPComboBox2:AddChoice( "None" )
CPComboBox2:AddChoice( "10-103m, disturbance by mentally unfit" )
CPComboBox2:AddChoice( "10-0, begin scanning" )
CPComboBox2:AddChoice( "148, Resisting arrest" )
CPComboBox2:AddChoice( "243, assualt on protection team" )
CPComboBox2:AddChoice( "50% reproduction credits" )
CPComboBox2:AddChoice( "27, attempted crime" )
CPComboBox2:AddChoice( "507, public non-complicance" )
CPComboBox2:AddChoice( "603, unlawful entry" )
CPComboBox2:AddChoice( "94, weapon" )
CPComboBox2:AddChoice( "Airwatch reports no activity" )
CPComboBox2:AddChoice( "All protection team units, complete sentencing at will" )
CPComboBox2:AddChoice( "All teams respond code 3" )
CPComboBox2:AddChoice( "All units deliver terminal verdict immediately" )
CPComboBox2:AddChoice( "All units apply forward pressure" )
CPComboBox2:AddChoice( "All units: Verdict Code is" )
CPComboBox2:AddChoice( "Attention, you have been charged with" )
CPComboBox2:AddChoice( "Capital Malcompliance" )
CPComboBox2:AddChoice( "Immediate amputation" )
CPComboBox2:AddChoice( "In progress" )
CPComboBox2:AddChoice( "Investigate and report" )
CPComboBox2:AddChoice( "Level 5 anti-civil activity" )
CPComboBox2:AddChoice( "Officer closing on suspect" )
CPComboBox2:AddChoice( "Permanent off-world service assignment" )
CPComboBox2:AddChoice( "Protection team, be adivsed: Accomplices operating in area" )
CPComboBox2:AddChoice( "Protection team, lock down your location. Sacrifice code" )
CPComboBox2:AddChoice( "Reinforcement teams code 3" )
CPComboBox2:AddChoice( "Remaining units contain" )
CPComboBox2:AddChoice( "Reminder: Memory replacement is the first step towards rank privileges" )
CPComboBox2:AddChoice( "Report please" )
CPComboBox2:AddChoice( "Respond" )
CPComboBox2:AddChoice( "Socio-stabilization restored" )
CPComboBox2:AddChoice( "Remaining units contain" )
CPComboBox2:AddChoice( "Suspend negotiations" )
CPComboBox2:AddChoice( "Unit deserviced" )
CPComboBox2:AddChoice( "You are judged guilty by Civil Protection teams" )
CPComboBox2:AddChoice( "Unit down at" )
CPComboBox2:AddChoice( "404 zone" )
CPComboBox2:AddChoice( "Industrial zone" )
CPComboBox2:AddChoice( "Zero" )
CPComboBox2:AddChoice( "One" )
CPComboBox2:AddChoice( "Two" )
CPComboBox2:AddChoice( "Three" )
CPComboBox2:AddChoice( "Four" )
CPComboBox2:AddChoice( "Five" )
CPComboBox2:AddChoice( "Six" )
CPComboBox2:AddChoice( "Seven" )
CPComboBox2:AddChoice( "Eight" )
CPComboBox2:AddChoice( "Nine" )
CPComboBox2:AddChoice( "Administer" )
CPComboBox2:AddChoice( "Amputate" )
CPComboBox2:AddChoice( "Anti-Citizen" )

CPComboBox2.OnSelect = function( panel, index, value )
surface.PlaySound("buttons/combine_button1.wav")
if value == "Unit down at" then
valcp2 = "Unit down"
elseif value == "You are judged guilty by Civil Protection teams" then
valcp2 = "judged guilty"
elseif value == "Remaining units contain" then
valcp2 = "Remaining units"
elseif value == "Socio-stabilization restored" then
valcp2 = "Socio-stabilization"
elseif value == "Reminder: Memory replacement is the first step towards rank privileges" then
valcp2 = "Memory"
elseif value == "Remaining units contain" then
valcp2 = "Units contain"
elseif value == "Reinforcement teams code 3" then
valcp2 = "Reinforcement teams"
elseif value == "Protection team, lock down your location. Sacrifice code" then
valcp2 = "lock down"
elseif value == "Protection team, be adivsed: Accomplices operating in area" then
valcp2 = "Accomplices operating"
elseif value == "Permanent off-world service assignment" then
valcp2 = "off-world service"
elseif value == "Officer closing on suspect" then
valcp2 = "Officer closing"
elseif value == "Level 5 anti-civil activity" then
valcp2 = "Level 5"
elseif value == "Investigate and report" then
valcp2 = "Investigate report"
elseif value == "Attention, you have been charged with" then
valcp2 = "charged with"
elseif value == "All units: Verdict Code is" then
valcp2 = "Verdict Code"
elseif value == "All protection team units, complete sentencing at will" then
valcp2 = "sentencing"
elseif value == "Airwatch reports no activity" then
valcp2 = "No activity"
elseif value == "10-103m, disturbance by mentally unfit" then
valcp2 = "10-103m"
elseif value == "10-0, begin scanning" then
valcp2 = "10-0"
elseif value == "148, Resisting arrest" then
valcp2 = "148"
elseif value == "243, assualt on protection team" then
valcp2 = "243"
elseif value == "50% reproduction credits" then
valcp2 = "50%"
elseif value == "27, attempted crime" then
valcp2 = "27"
elseif value == "507, public non-complicance" then
valcp2 = "507"
elseif value == "603, unlawful entry" then
valcp2 = "603"
elseif value == "94, weapon" then
valcp2 = "94"
elseif value == "Respond" then
valcp1 = "Respond111"
elseif value == "None" then
valcp2 = ""


else
valcp2 = value
end
end

local CPComboBox3 = vgui.Create( "DComboBox", CPDispatchCFrame )
val1 = ""
CPComboBox3:SetPos( 20, 30 )
CPComboBox3:SetSize( 500, 30 )
CPComboBox3:SetValue( "1" )
CPComboBox3:AddChoice( "None" )
CPComboBox3:AddChoice( "10-103m, disturbance by mentally unfit" )
CPComboBox3:AddChoice( "10-0, begin scanning" )
CPComboBox3:AddChoice( "148, Resisting arrest" )
CPComboBox3:AddChoice( "243, assualt on protection team" )
CPComboBox3:AddChoice( "50% reproduction credits" )
CPComboBox3:AddChoice( "27, attempted crime" )
CPComboBox3:AddChoice( "507, public non-complicance" )
CPComboBox3:AddChoice( "603, unlawful entry" )
CPComboBox3:AddChoice( "94, weapon" )
CPComboBox3:AddChoice( "Airwatch reports no activity" )
CPComboBox3:AddChoice( "All protection team units, complete sentencing at will" )
CPComboBox3:AddChoice( "All teams respond code 3" )
CPComboBox3:AddChoice( "All units deliver terminal verdict immediately" )
CPComboBox3:AddChoice( "All units apply forward pressure" )
CPComboBox3:AddChoice( "All units: Verdict Code is" )
CPComboBox3:AddChoice( "Attention, you have been charged with" )
CPComboBox3:AddChoice( "Capital Malcompliance" )
CPComboBox3:AddChoice( "Immediate amputation" )
CPComboBox3:AddChoice( "In progress" )
CPComboBox3:AddChoice( "Investigate and report" )
CPComboBox3:AddChoice( "Level 5 anti-civil activity" )
CPComboBox3:AddChoice( "Officer closing on suspect" )
CPComboBox3:AddChoice( "Permanent off-world service assignment" )
CPComboBox3:AddChoice( "Protection team, be adivsed: Accomplices operating in area" )
CPComboBox3:AddChoice( "Protection team, lock down your location. Sacrifice code" )
CPComboBox3:AddChoice( "Reinforcement teams code 3" )
CPComboBox3:AddChoice( "Remaining units contain" )
CPComboBox3:AddChoice( "Reminder: Memory replacement is the first step towards rank privileges" )
CPComboBox3:AddChoice( "Report please" )
CPComboBox3:AddChoice( "Respond" )
CPComboBox3:AddChoice( "Socio-stabilization restored" )
CPComboBox3:AddChoice( "Remaining units contain" )
CPComboBox3:AddChoice( "Suspend negotiations" )
CPComboBox3:AddChoice( "Unit deserviced" )
CPComboBox3:AddChoice( "You are judged guilty by Civil Protection teams" )
CPComboBox3:AddChoice( "Unit down at" )
CPComboBox3:AddChoice( "404 zone" )
CPComboBox3:AddChoice( "Industrial zone" )
CPComboBox3:AddChoice( "Zero" )
CPComboBox3:AddChoice( "One" )
CPComboBox3:AddChoice( "Two" )
CPComboBox3:AddChoice( "Three" )
CPComboBox3:AddChoice( "Four" )
CPComboBox3:AddChoice( "Five" )
CPComboBox3:AddChoice( "Six" )
CPComboBox3:AddChoice( "Seven" )
CPComboBox3:AddChoice( "Eight" )
CPComboBox3:AddChoice( "Nine" )
CPComboBox3:AddChoice( "Administer" )
CPComboBox3:AddChoice( "Amputate" )
CPComboBox3:AddChoice( "Anti-Citizen" )

CPComboBox3.OnSelect = function( panel, index, value )
surface.PlaySound("buttons/combine_button1.wav")
if value == "Unit down at" then
valcp1 = "Unit down"
elseif value == "You are judged guilty by Civil Protection teams" then
valcp1 = "judged guilty"
elseif value == "Remaining units contain" then
valcp1 = "Remaining units"
elseif value == "Socio-stabilization restored" then
valcp1 = "Socio-stabilization"
elseif value == "Reminder: Memory replacement is the first step towards rank privileges" then
valcp1 = "Memory"
elseif value == "Remaining units contain" then
valcp1 = "Units contain"
elseif value == "Reinforcement teams code 3" then
valcp1 = "Reinforcement teams"
elseif value == "Protection team, lock down your location. Sacrifice code" then
valcp1 = "lock down"
elseif value == "Protection team, be adivsed: Accomplices operating in area" then
valcp1 = "Accomplices operating"
elseif value == "Permanent off-world service assignment" then
valcp1 = "off-world service"
elseif value == "Officer closing on suspect" then
valcp1 = "Officer closing"
elseif value == "Level 5 anti-civil activity" then
valcp1 = "Level 5"
elseif value == "Investigate and report" then
valcp1 = "Investigate report"
elseif value == "Attention, you have been charged with" then
valcp1 = "charged with"
elseif value == "All units: Verdict Code is" then
valcp1 = "Verdict Code"
elseif value == "All protection team units, complete sentencing at will" then
valcp1 = "sentencing"
elseif value == "Airwatch reports no activity" then
valcp1 = "No activity"
elseif value == "10-103m, disturbance by mentally unfit" then
valcp1 = "10-103m"
elseif value == "10-0, begin scanning" then
valcp1 = "10-0"
elseif value == "148, Resisting arrest" then
valcp1 = "148"
elseif value == "243, assualt on protection team" then
valcp1 = "243"
elseif value == "50% reproduction credits" then
valcp1 = "50%"
elseif value == "27, attempted crime" then
valcp1 = "27"
elseif value == "507, public non-complicance" then
valcp1 = "507"
elseif value == "603, unlawful entry" then
valcp1 = "603"
elseif value == "94, weapon" then
valcp1 = "94"
elseif value == "Respond" then
valcp1 = "Respond111"
elseif value == "None" then
valcp1 = ""

else
valcp1 = value
end
end


local CPDButton = vgui.Create( "DButton", CPDispatchCFrame )
CPDButton:SetPos( 650, 220 )
CPDButton:SetText( "Send" )
CPDButton:SetSize( 350, 30 )
CPDButton.DoClick = function()
	LocalPlayer():ConCommand( "say /dispatchradio ".. valcp1 .. " " .. valcp2 .. " " .. valcp3)

end

end

function CCTVBtn()

local CPDButton3 = vgui.Create( "DButton" )
CPDButton3:SetPos( 0, 30 )
CPDButton3:SetText( "Dispatch To Unit Notification" )
CPDButton3:SetSize( 170, 30 )
CPDButton3:SetSkin( "Cortex" )
CPDButton3.DoClick = function()
DtoCP()


end

local CPDButton2 = vgui.Create( "DButton" )
CPDButton2:SetPos( 0, 0 )
CPDButton2:SetText( "Exit CCTV Camera" )
CPDButton2:SetSize( 170, 30 )
CPDButton2:SetSkin( "Cortex" )
DispatchMainframe:Hide()
CPDButton2.DoClick = function()
ResetCam()
CPDButton2:Remove()
DispatchMain()
CPDButton3:Remove()

end

end

function CCTV1()
CCTVBtn()


hook.Add( "CalcView", "CCTV1", function( ply, pos, angles, fov )
	local view = {}
firstpos = pos
firstangle = angles
	view.origin = Vector( 2318.770508, 3565.911621, 438.446686 )
	view.angles = Angle ( 14.424819, -179.576904, -0.002604 )
	view.fov = fov
	view.drawviewer = true

	return view

end)

end

function ResetCam()

hook.Remove ( "CalcView", "CCTV1" )
hook.Remove ( "CalcView", "CCTV2" )
hook.Remove ( "CalcView", "CCTV3" )
hook.Remove ( "CalcView", "CCTV4" )
hook.Remove ( "CalcView", "CCTV5" )
hook.Remove ( "CalcView", "CCTV6" )
hook.Remove ( "CalcView", "CCTV7" )
hook.Remove ( "CalcView", "CCTV8" )
LocalPlayer():ConCommand( "pp_mat_overlay effects/combine_binocover" )

end


function CCTV2()
CCTVBtn()
hook.Add( "CalcView", "CCTV2", function( ply, pos, angles, fov ) -- 2406.075928 3112.826904 805.132263;setang 33.000011 135.960052 0.000000
	local view = {}
	view.origin = Vector( 2406.075928, 3112.826904, 805.132263 )
	view.angles = Angle ( 33.000011, 135.960052, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end


function CCTV3()
CCTVBtn()
hook.Add( "CalcView", "CCTV3", function( ply, pos, angles, fov ) -- -539.151855 3795.026367 263.986786;setang 6.719985 -129.219467 0.000000
	local view = {}
	view.origin = Vector( 539.151855, 3795.026367, 263.986786 )
	view.angles = Angle ( 6.719985, -129.219467, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end

function CCTV4()
CCTVBtn()
hook.Add( "CalcView", "CCTV4", function( ply, pos, angles, fov ) -- -971.124878 2284.763916 271.148804;setang 6.499994 -40.779217 0.000000
	local view = {}
	view.origin = Vector( -971.124878, 2284.763916, 271.148804 )
	view.angles = Angle ( 6.499994, -40.779217, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end


function CCTV5()
CCTVBtn()
hook.Add( "CalcView", "CCTV5", function( ply, pos, angles, fov ) -- 1888.166260 2514.974609 363.669159;setang 20.359962 -55.079292 0.000000
	local view = {}
	view.origin = Vector( 1888.166260, 2514.974609, 363.669159 )
	view.angles = Angle ( 20.359962, -55.079292, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end


function CCTV7()
CCTVBtn()
hook.Add( "CalcView", "CCTV7", function( ply, pos, angles, fov ) -- 3503.306641 5592.089355 501.004822;setang 6.940013 -69.459518 0.000000
	local view = {}
	view.origin = Vector( 3503.306641, 5592.089355, 501.004822 )
	view.angles = Angle ( 6.940013, -69.459518, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end


function CCTV6()
CCTVBtn()
hook.Add( "CalcView", "CCTV6", function( ply, pos, angles, fov ) -- 3319.010742 1262.248291 489.858307;setang 11.120006 84.620193 0.000000
	local view = {}
	view.origin = Vector( 3319.010742, 1262.248291, 489.858307 )
	view.angles = Angle ( 11.120006, 84.620193, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end


function CCTV8()
CCTVBtn()
hook.Add( "CalcView", "CCTV8", function( ply, pos, angles, fov ) -- 3998.959717 4610.964355 607.412720;setang 34.660034 -0.019470 0.000000

	local view = {}
	view.origin = Vector( 3998.959717, 4610.964355, 607.412720 )
	view.angles = Angle ( 34.660034, -0.019470, 0.000000 )
	view.fov = fov
	view.drawviewer = true

	return view

end)
end
end

net.Receive ( "open_dispatch", DispatchMain ) 


