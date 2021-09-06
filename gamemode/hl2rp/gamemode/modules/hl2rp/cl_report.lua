net.Receive( "PA", function( len )
	name_read = net.ReadString()
	model_read = net.ReadString()
	report_read = net.ReadString()
end )

SoundsRadio = {
"npc/overwatch/radiovoice/off4.wav",
"npc/overwatch/radiovoice/off2.wav",
"npc/overwatch/radiovoice/on1.wav",
"npc/overwatch/radiovoice/on3.wav"
}



function PoliceAlert(  )
	math.randomseed(os.time())
	surface.PlaySound(SoundsRadio[math.random(1,4)])
	local dP = vgui.Create( "DFrame" )
	dP:SetPos( (4/5)*ScrW(),ScrH()/8 )
	dP:SetSize( 300, 135 )
	timer.Create( "TimerN",10, 1, function() dP:Close() end )
	dP:SetTitle( "Dispatch" )
	dP:SetVisible( true )
	dP:SetDraggable( false )
	dP:ShowCloseButton( false )
	dP:SetKeyboardInputEnabled(false)
	dP:SetMouseInputEnabled(true)
	dP:SetVisible(true)
	dP.Paint = function()
		surface.SetDrawColor(0,0,0,150)
		dP:DrawFilledRect()
		surface.SetDrawColor(0,0,0)
		dP:DrawOutlinedRect()
	end

	local mdlImg = vgui.Create( "SpawnIcon", dP )
	mdlImg:SetPos( 5, 30 )
	mdlImg:SetModel(model_read)

	local title = vgui.Create( "DLabel",dP )
	title:SetPos(65, 30)
	title:SetText(name_read.." reports:")
	title:SetFont("Trebuchet24")
	title:SetSize(200,50)
	title:SetColor(Color(236, 240, 241))

	local subtitle = vgui.Create( "DLabel",dP )
	subtitle:SetPos(62, 55)
	subtitle:SetText(report_read)
	subtitle:SetFont("Trebuchet18")
	subtitle:SetColor(Color(236, 240, 241))
	subtitle:SetSize(250,50)

	local ask = vgui.Create( "DLabel",dP )
	ask:SetPos(25, 85)
	ask:SetText("Respond?")
	ask:SetColor(Color(236, 240, 241))
	ask:SetFont("Trebuchet24")
	ask:SetSize(250,50)

	local yes = vgui.Create( "DButton",dP )
	yes:SetPos(135, 100)
	yes:SetText("   Yes")
	yes:SetSize(60,20)
	yes:SetImage("icon16/accept.png")
	yes.Paint = function()
		draw.RoundedBox( 8, 0, 0, yes:GetWide(), yes:GetTall(), Color( 236, 240, 241, 230 ) )
	end
	yes.DoClick = function()
		timer.Destroy("TimerN")
		RunConsoleCommand( "say", "/g Unit responding to 10-33." )
		surface.PlaySound("ambient/levels/prison/radio_random1.wav")
		dP:Close()
	end

	local no = vgui.Create( "DButton",dP )
	no:SetPos(210, 100)
	no:SetText("   No")
	no:SetSize(60,20)
	no:SetImage("icon16/delete.png")
	no.DoClick = function() dP:Close() timer.Destroy("TimerN")  end
	no.Paint = function()
		draw.RoundedBox( 8, 0, 0, yes:GetWide(), yes:GetTall(), Color( 236, 240, 241, 230 ) )
	end

end
usermessage.Hook( "PoliceAlert", PoliceAlert )
