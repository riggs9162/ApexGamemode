
include( "shared.lua" )

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self:DrawModel()
end

local function CommaTheCash( num )
	if ( !num ) then return end

	for i = string.len( num ) - 3, 1, -3 do 
		num = string.sub( num, 1, i ) .. "," .. string.sub( num, i + 1 )
	end 
	return num
end

local function AreWeNearATM()
	for id, ent in pairs( ents.FindInSphere( LocalPlayer():GetPos(), 100 ) ) do
		if ( ent:GetClass() == "atm_machine" ) then
			return true
		end
	end
	return false
end

concommand.Add( "rp_atm_nopin", function( ply, cmd, args )
	if ( !AreWeNearATM() ) then chat.AddText( "You must be near an ATM to use it!" ) return end
	if ( IsValid( DermaPanel5 ) ) then
		DermaPanel5:SetVisible( false )
		DermaPanel5:Close()
	end

	DermaPanel4 = vgui.Create( "DFrame" )
	DermaPanel4:SetSize( 150, 110 )
	DermaPanel4:SetTitle( "ATM" )
	DermaPanel4:Center()
	DermaPanel4:SetSkin("Cortex")
	DermaPanel4:MakePopup()
		DermaPanel4.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame
		end

	local DLabel5 = vgui.Create( "DLabel", DermaPanel4 )
	DLabel5:SetPos( 26, 25 )
	DLabel5:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel5:SetFont( "TabLarge" )
	DLabel5:SetText( "Please Create a PIN." )
	DLabel5:SizeToContents()
	DLabel5:SetSkin("Cortex")

	local DLabel6 = vgui.Create( "DLabel", DermaPanel4 )
	DLabel6:SetPos( 37, 40 )
	DLabel6:SetColor( Color( 255, 0, 0, 255 ) )
	DLabel6:SetFont( "TabLarge" )
	DLabel6:SetText( "*4 Digits Only!*" )
	DLabel6:SizeToContents()

	local myText5 = vgui.Create( "DTextEntry", DermaPanel4 )
	myText5:SetSize( 80, 20 )
	myText5:SetPos( 36, 60 )
	myText5:RequestFocus()

	local button5 = vgui.Create( "DButton", DermaPanel4 )
	button5:SetSize( 80, 18 )
	button5:SetPos( 36, 85 )
	button5:SetText( "Set PIN" )
	button5.DoClick = function()
		RunConsoleCommand( "rp_atm_setpin", myText5:GetValue() )
	end

end )

concommand.Add( "rp_atm_open", function( ply, cmd, args )
	if ( !AreWeNearATM() ) then chat.AddText( "You must be near an ATM to use it!" ) return end

	if ( IsValid( DermaPanel4 ) ) then
		DermaPanel4:SetVisible( false )
		DermaPanel4:Close()
	end

	DermaPanel5 = vgui.Create( "DFrame" )
	DermaPanel5:SetSize( 160, 250 )
	DermaPanel5:SetTitle( "ATM" )
	DermaPanel5:Center()
	DermaPanel5:MakePopup()
	DermaPanel5:SetSkin("Cortex")
		DermaPanel5.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame
		end	

	local PropertySheet = vgui.Create( "DPropertySheet", DermaPanel5 )
	PropertySheet:SetPos( 0, 25 )
	PropertySheet:SetSize( 160, 225 )

	local TabA = vgui.Create( "DPanelList", PropertySheet )

	local DLabel1 = vgui.Create( "DLabel", TabA )
	DLabel1:SetPos( 24, 20 )
	DLabel1:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel1:SetFont( "TabLarge" )
	DLabel1:SetText( "Select Account:" )
	DLabel1:SizeToContents()

	local List = vgui.Create( "DComboBox", TabA )
	List:SetPos( 22, 36 )
	List:SetSize( 100, 20 )
	List:SetText( LocalPlayer():Nick() )
	List.CurData = LocalPlayer():UniqueID()
	List.OnSelect = function( self, index, value, data )
		List.CurData = data
	end
	for k, v in pairs( player.GetAll() ) do
		List:AddChoice( v:Nick(), v:UniqueID() )
	end

	local DLabel2 = vgui.Create( "DLabel", TabA )
	DLabel2:SetPos( 24, 70  )
	DLabel2:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel2:SetFont( "TabLarge" )
	DLabel2:SetText( "Enter PIN:" )
	DLabel2:SizeToContents()

	local myText1 = vgui.Create( "DTextEntry", TabA )
	myText1:SetSize( 100, 20 )
	myText1:SetPos( 22, 85 )
	myText1:RequestFocus()
	myText1.OnEnter = function()
		RunConsoleCommand( "rp_atm_login", util.CRC( myText1:GetValue() ), List.CurData )
	end

	local button1 = vgui.Create( "DButton", TabA )
	button1:SetSize( 100, 18 )
	button1:SetPos( 22, 106 )
	button1:SetText( "Enter" )
	button1:SetTextColor(BColor)
	button1.DoClick = function()
		RunConsoleCommand( "rp_atm_login", util.CRC( myText1:GetValue() ), List.CurData )
	end

	local button2 = vgui.Create( "DButton", TabA )
	button2:SetSize( 100, 25 )
	button2:SetPos( 22, 150 )
	button2:SetText( "Change my PIN" )
	button2:SetTextColor(BColor)
	button2.DoClick = function()
		RunConsoleCommand( "rp_atm_nopin" )
		chat.AddText( color_white, "Security Note: DO NOT USE FREQUENTLY-USED, PERSONAL PASSWORDS." )
	end
	
	PropertySheet:AddSheet( "ATM", TabA, "icon16/shield.png", false, false, "ATM Security" )

	/******************************** ADMIN TAB ********************************/

	if ( !LocalPlayer():IsSuperAdmin() ) then return end

	local TabB = vgui.Create( "DPanelList", PropertySheet )

	local button1 = vgui.Create( "DButton", TabB )
	button1:SetSize( 120, 18 )
	button1:SetPos( 12, 5 )
	button1:SetText( "Print PIN Codes" )
	button1.DoClick = function()
		RunConsoleCommand( "rp_atm_pincodes_send" )
	end

	local button2 = vgui.Create( "DButton", TabB )
	button2:SetSize( 120, 18 )
	button2:SetPos( 12, 25 )
	button2:SetText( "Print Banked Money" )
	button2.DoClick = function()
		RunConsoleCommand( "rp_atm_money_send" )
	end

	local DLabel2 = vgui.Create( "DLabel", TabB )
	DLabel2:SetPos( 20, 48 )
	DLabel2:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel2:SetFont( "TabLarge" )
	DLabel2:SetText( "ATMs:" )
	DLabel2:SizeToContents()

	local button3 = vgui.Create( "DButton", TabB )
	button3:SetSize( 70, 18 )
	button3:SetPos( 0, 64 )
	button3:SetText( "Remove" )
	button3:SetTooltip( "Remove all ATMs on the map" )
	button3.DoClick = function()
		RunConsoleCommand( "rp_atm_removeall" )
	end

	local button4 = vgui.Create( "DButton", TabB )
	button4:SetSize( 70, 18 )
	button4:SetPos( 0, 84 )
	button4:SetText( "Respawn" )
	button4:SetTooltip( "Respawn ATMs from a saved file" )
	button4.DoClick = function()
		RunConsoleCommand( "rp_atm_respawnall" )
	end

	local DLabel2 = vgui.Create( "DLabel", TabB )
	DLabel2:SetPos( 86, 48 )
	DLabel2:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel2:SetFont( "TabLarge" )
	DLabel2:SetText( "Spawns:" )
	DLabel2:SizeToContents()

	local button3_add = vgui.Create( "DButton", TabB )
	button3_add:SetSize( 70, 18 )
	button3_add:SetPos( 72, 64 )
	button3_add:SetText( "Save" )
	button3_add:SetTooltip( "Save all ATM positions to a file" )
	button3_add.DoClick = function()
		RunConsoleCommand( "rp_atm_savespawns" )
	end
	
	local button4_add = vgui.Create( "DButton", TabB )
	button4_add:SetSize( 70, 18 )
	button4_add:SetPos( 72, 84 )
	button4_add:SetText( "Delete" )
	button4_add:SetTooltip( "Delete ATM positions for this map" )
	button4_add.DoClick = function()
		RunConsoleCommand( "rp_atm_removespawns" )
	end

	local List2 = vgui.Create( "DComboBox", TabB )
	List2:SetSize( 120, 18 )
	List2:SetPos( 12, 116 )
	List2:SetText( tostring( LocalPlayer():Nick() ) )
	List2.CurData = LocalPlayer():UniqueID()
	List2.OnSelect = function( self, index, value, data )
		List2.CurData = data
	end
	for k, v in pairs( player.GetAll() ) do
		List2:AddChoice( v:Nick(), v:UniqueID() )
	end

	local myText11 = vgui.Create( "DTextEntry", TabB )
	myText11:SetSize( 58, 16 )
	myText11:SetPos( 12, 136 )
	myText11.OnEnter = function()
		RunConsoleCommand( "rp_atm_admin_setpin", List2.CurData, myText11:GetValue() ) 
	end

	local button5 = vgui.Create( "DButton", TabB )
	button5:SetSize( 58, 16 )
	button5:SetPos( 74, 136 )
	button5:SetText( "Set PIN" )
	button5:SetTooltip( "Set PIN for selected account" )
	button5.DoClick = function()
		RunConsoleCommand( "rp_atm_admin_setpin", List2.CurData, myText11:GetValue() ) 
	end

	local button6 = vgui.Create( "DButton", TabB )
	button6:SetSize( 58, 16 )
	button6:SetPos( 12, 154 )
	button6:SetText( "Enter Valut" )
	button6:SetTooltip( "Enter selected account without entering PIN" )
	button6.DoClick = function()
		RunConsoleCommand( "rp_atm_admin_account", List2.CurData ) 
	end

	local button7 = vgui.Create( "DButton", TabB )
	button7:SetSize( 58, 16 )
	button7:SetPos( 74, 154 )
	button7:SetText( "Reset PIN" )
	button7:SetTooltip( "Reset PIN for selected account" )
	button7.DoClick = function()
		RunConsoleCommand( "rp_atm_admin_resetpin", List2.CurData )
	end
	
	local button8 = vgui.Create( "DButton", TabB )
	button8:SetSize( 120, 16 )
	button8:SetPos( 12, 172 )
	button8:SetText( "Reset Money" )
	button8:SetTooltip( "Reset money for selected account" )
	button8.DoClick = function()
		RunConsoleCommand( "rp_atm_admin_resetmoney", List2.CurData ) 
	end
	button1:SetTextColor(BColor)
	button2:SetTextColor(BColor)
	button3:SetTextColor(BColor)
	button4:SetTextColor(BColor)
	button3_add:SetTextColor(BColor)
	button4_add:SetTextColor(BColor)
	button5:SetTextColor(BColor)
	button6:SetTextColor(BColor)
	button7:SetTextColor(BColor)
	button8:SetTextColor(BColor)

	PropertySheet:AddSheet( "Admin", TabB, "icon16/shield_add.png", false, false, "ATM Admin Settings" )
	for k, v in pairs(PropertySheet.Items) do
    --		if (!v.Tab) then continue end
    
   		v.Tab.Paint = function(self,w,h)
         draw.RoundedBox(0, 0, 0, w, h, Color(34,34,34))
         if v.Tab == PropertySheet:GetActiveTab() then
            draw.RoundedBox( 0, 0, 0, w + 4, h + 4, Color( 51, 51, 51 ) )
        end
    end
end
end)

concommand.Add("rp_atm_account",function ( ply, cmd, args )
	if ( !AreWeNearATM() ) then chat.AddText( "You must be near an ATM to use it!" ) return end
	if ( IsValid( DermaPanel5 ) ) then
		DermaPanel5:SetVisible( false )
		DermaPanel5:Close()
	end

	if ( IsValid( DermaPanel ) ) then
		DermaPanel:SetVisible( false )
		DermaPanel:Close()
	end

	DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetSize( 160, 225 )
	DermaPanel:SetTitle( "ATM" )
	DermaPanel:Center()
	DermaPanel:MakePopup()
		DermaPanel:SetSkin("Cortex")
		DermaPanel.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame
		end	

	local DLabel7 = vgui.Create( "DLabel", DermaPanel )
	DLabel7:SetPos( 20, 30 )
	DLabel7:SetColor( Color( 255, 204, 51, 255 ) )
	DLabel7:SetFont( "TabLarge" )
	DLabel7:SetText( "-BANK ACCOUNT INFO-" )
	DLabel7:SizeToContents()

	local DLabel8 = vgui.Create( "DLabel", DermaPanel )
	DLabel8:SetPos( 20, 42 )
	DLabel8:SetColor( Color( 51, 204, 255, 255 ) )
	DLabel8:SetFont( "TabLarge" )
	for k, v in pairs( player.GetAll() ) do
		if tostring( v:UniqueID() ) == tostring( args[2] ) then
			DLabel8:SetText( v:Nick() )
		end
	end
	DLabel8:SizeToContents()

	local DLabel9 = vgui.Create( "DLabel", DermaPanel )
	DLabel9:SetPos( 20, 54 )
	DLabel9:SetColor( Color( 0, 255, 0, 255 ) )
	DLabel9:SetFont( "TabLarge" )
	DLabel9:SetText( "T" .. CommaTheCash( tonumber( args[3] ) ) )
	DLabel9:SizeToContents()

	local DLabel1 = vgui.Create( "DLabel", DermaPanel )
	DLabel1:SetPos( 20, 78 )
	DLabel1:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel1:SetFont( "TabLarge" )
	DLabel1:SetText( "Deposit:" )
	DLabel1:SizeToContents()

	local myText = vgui.Create( "DTextEntry", DermaPanel )
	myText:SetSize( 120, 20 )
	myText:SetPos( 19, 93 )
	myText:RequestFocus()
	myText.OnEnter = function()
		RunConsoleCommand("rp_atm_deposit", args[1], args[2], tonumber( myText:GetValue() ) )
	end

	local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 120, 18 )
	button:SetPos( 19, 114 )
	button:SetText( "Deposit" )
	button.DoClick = function()
		RunConsoleCommand("rp_atm_deposit", args[1], args[2], tonumber( myText:GetValue() ) )
	end
	button:SetTextColor(BColor)

	local DLabel2 = vgui.Create( "DLabel", DermaPanel )
	DLabel2:SetPos( 20, 144 )
	DLabel2:SetColor( Color( 255, 255, 255, 255 ) )
	DLabel2:SetFont( "TabLarge" )
	DLabel2:SetText( "Withdraw:" )
	DLabel2:SizeToContents()

	local myText2 = vgui.Create( "DTextEntry", DermaPanel )
	myText2:SetSize( 120, 20 )
	myText2:SetPos( 19, 159 )
	myText2.OnEnter = function()
		RunConsoleCommand("rp_atm_withdraw", args[1], args[2], tonumber( myText2:GetValue() ) )
	end

	local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 120, 20 )
	button:SetPos( 19, 180 )
	button:SetText( "Withdraw" )
	button.DoClick = function()
		RunConsoleCommand("rp_atm_withdraw", args[1], args[2], tonumber( myText2:GetValue() ) )
	end
	button:SetTextColor(BColor)
end )
