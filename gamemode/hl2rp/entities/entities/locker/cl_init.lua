include('shared.lua') -- At this point the contents of shared.lua are ran on the client only.

function ChangeOutfit()
		OutfitMenu = vgui.Create("DFrame")
		OutfitMenu:SetSize(500, 400)
		OutfitMenu:Center()
		OutfitMenu:SetVisible( true )
		OutfitMenu:MakePopup()
		OutfitMenu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame


		end
		OutfitMenu:SetTitle("Change Outfit")
		modelpanel = vgui.Create("DModelPanel", OutfitMenu)

				local plyModel = LocalPlayer():GetModel()
				model = plyModel
				if string.match(plyModel, "group01") then
					model = string.Replace( plyModel, "group01", "group03" )
				else
					model = string.Replace( plyModel, "group03", "group01" )
				end
				modelpanel:SetModel(model)
				modelpanel:SetSize(280,300)
				modelpanel:SetAnimated(false)
				modelpanel:SetFOV(60)
				modelpanel:SetAnimSpeed(2)
				modelpanel:SetPos( 110, 10)
		local Button = vgui.Create( "DButton", OutfitMenu )
		Button:SetFont("Trebuchet24")
		Button:SetText( "Change Outfit" )
		Button:SetTextColor( Color( 255, 255, 255 ) )
		Button:SetPos( 20, 320 )
		Button:SetSize( 460, 60 )
		Button.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 100 ) ) -- Draw a blue button
		end
		Button.DoClick = function()
			print( "I was clicked!" )
			LocalPlayer():ConCommand("rp_citizensuitup")
			OutfitMenu:Close()
		end
end

function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then	
		hook.Add("PreDrawHalos", "Halo", function()
			if LocalPlayer():Team() == TEAM_CITIZEN then
				halo.Add({ self }, Color(0, 0, 255), 0, 0, 0)
				end
		end)
	end
end

usermessage.Hook("ChangeOutfit", ChangeOutfit) --Hook to messages from the server so we know when to display the menu.