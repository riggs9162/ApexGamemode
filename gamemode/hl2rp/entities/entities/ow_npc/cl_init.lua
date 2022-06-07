include('shared.lua') -- At this point the contents of shared.lua are ran on the client only.


function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		hook.Add("PreDrawHalos", "Halo", function()
			if LocalPlayer():Team() == TEAM_OVERWATCH then
				halo.Add({ self }, Color(0, 0, 255), 0, 0, 0)
				end
		end)
	end
end

function OWNPCShopMenu()

	-- Small derma panel just for the example.
		OWMenu = vgui.Create("DFrame")
		OWMenu:SetSkin(GAMEMODE.Config.DarkRPSkin)
		OWMenu:SetSize(900, 400)
		OWMenu:Center()
		OWMenu:SetVisible( true )
		OWMenu:MakePopup()
		OWMenu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame

			draw.RoundedBox( 0, 10, 35, w-20, 35, Color( 50,50,50, 150)) -- TOPBG

			draw.RoundedBox( 0, 10, 80, 370, 270, Color( 50,50,50, 150)) -- Rank Info

			draw.RoundedBox( 0, 520, 80, 370, 270, Color( 50,50,50, 150)) -- OWDivision Info

			draw.RoundedBox( 0, 20, 43, 350, 20, Color( 100,100,100, 220)) -- RANK

			draw.RoundedBox( 0, 530, 43, 350, 20, Color( 100,100,100, 220)) --OWDivision


		end
		OWMenu:SetTitle("Overwatch Transhuman Arm - Rank and Division Selector")

		Rank = ""
		OWDivision = ""

		RankLabel = vgui.Create( "DLabel", OWMenu )
			RankLabel:SetPos( 25, 85 )
		if not RankLabel:GetText() or RankLabel:GetText("Label") then
			RankLabel:SetText("")
		end
			RankLabel:SetSize(250, 360)
			RankLabel:SizeToContents()


		OWDivisionLabel = vgui.Create( "DLabel", OWMenu )
			OWDivisionLabel:SetPos( 535, 85 )
		if not OWDivisionLabel:GetText() or OWDivisionLabel:GetText("Label") then
			OWDivisionLabel:SetText("")
		end
			OWDivisionLabel:SetSize(250, 360)
			OWDivisionLabel:SizeToContents()

--OWDivision Block XP Requirement

		OWDivisionXPLabel = vgui.Create( "DLabel", OWMenu )
			OWDivisionXPLabel:SetPos( 535, 330 )
		if not OWDivisionXPLabel:GetText() or OWDivisionXPLabel:GetText("Label") then
			OWDivisionXPLabel:SetText("XP Requirement: ")
		end
			OWDivisionXPLabel:SizeToContents()

--Rank XP Requirement Corner
		RankXPLabel = vgui.Create( "DLabel", OWMenu )
			RankXPLabel:SetPos( 25, 330 )
		if not RankXPLabel:GetText() or RankXPLabel:GetText("Label") then
			RankXPLabel:SetText("XP Requirement: ")
		end
			RankXPLabel:SizeToContents()

		local DRankBox = vgui.Create( "DDropListBox", OWMenu )
				DRankBox:SetSkin(GAMEMODE.Config.DarkRPSkin)
				DRankBox:SetTextColor( Color( 255, 255, 255 ) )
				DRankBox:SetPos( 20, 43 )
				DRankBox:SetSize( 350, 20 )
				DRankBox:SetValue( "Choose a Rank" )
				DRankBox:AddChoice( "OWS - Overwatch Solider", 1 )
				DRankBox:AddChoice( "EOW - Overwatch Elite Soldier", 2 )

				DRankBox.OnSelect = function( panel, index, value )
					Rank = value
					RankI = index or 1
					updateButton()
				end

		local DOWDivisionBox = vgui.Create( "DDropListBox", OWMenu )
				DOWDivisionBox:SetTextColor( Color( 255, 255, 255 ) )
				DOWDivisionBox:SetPos( 530, 43 )
				DOWDivisionBox:SetSize( 350, 20 )
				DOWDivisionBox:SetValue( "Choose an Overwatch Division" )
				DOWDivisionBox:AddChoice( "ECHO - Ground Soldier", 1 )
				DOWDivisionBox:AddChoice( "RANGER - Tactical Sniper", 2 )
				DOWDivisionBox:AddChoice( "MACE - Shotgunner Soldier", 3 )
				DOWDivisionBox:AddChoice( "KING - Elite Ground Soldier", 4 )
				DOWDivisionBox:AddChoice( "X-RAY - Heavy Medical Soldier", 5 )
				DOWDivisionBox:AddChoice( "SENTINEL - Administrator's Bodygaurd", 6 )
				DOWDivisionBox:AddChoice( "NOVA - Prison Guard", 7 )
				DOWDivisionBox:AddChoice( "OWC - Overwatch Commander", 8 )
				DOWDivisionBox.OnSelect = function( panel, index, value )
					OWDivision = value
					OWDivisionI = index or 1
					updateButton()
				end

		local icon = vgui.Create( "DModelPanel", OWMenu )
			icon:SetSize( 300, 300 )
			icon:SetPos( 290, 50)
			icon:SetModel( "models/player/soldier_stripped.mdl" ) -- you can only change colors on playermodels
		--	function icon:LayoutEntity( Entity ) return end -- disables default rotation
			function icon.Entity:GetPlayerColor() return Vector ( 0, 0, 0 ) end --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.

			local headpos = icon.Entity:GetBonePosition( icon.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
			icon:SetLookAt( headpos )

			icon:SetCamPos( headpos-Vector( -60, 0, 0 ) )	-- Move cam in front of face
	function icon:LayoutEntity(Entity)
			if ( self.bAnimated ) then
				self:RunAnimation()
			end
	end

		local Button = vgui.Create( "DButton", OWMenu )
			Button:SetFont("NameFont")
			Button:SetText( "Choose Rank ("..Rank..") and OWDivision ("..OWDivision..")" )
			Button:SetTextColor( Color( 255, 255, 255 ) )
			Button:SetPos( 10, 360 )
			Button:SetSize( 880, 30 )
			Button.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 9,102,3, 230 ) ) -- Draw a blue button
			end

			Button.DoClick = function()
				if RankI and OWDivisionI then
					LocalPlayer():ConCommand( "rp_OWDivision "..RankI.." "..OWDivisionI )
--					print("Rank:"..RankI.." Div: "..OWDivisionI)
					OWMenu:Close()
				end
			end
			function updateButton()

				if not RankI then
					RankI = 1
					OWDivisionI = 1
				end

				RankText = OWRanks[RankI].description

				local RankShort = OWRanks[RankI].name
				RankLabel:SetText(RankText)
				RankLabel:SizeToContents()

				OWDivisionText = OWDivisions[OWDivisionI].description
				local OWDivisionXP = OWDivisions[OWDivisionI].xp
				icon:SetModel(OWDivisions[OWDivisionI].model)
				if OWDivision == 7 then
				icon:SetSkin(1)
				end
				icon:RunAnimation()

				--Rank XP Requirement
				local RankXP = OWRanks[RankI].xp
				RankXPLabel:SetText("XP Requirement: "..RankXP)

				RankXPLabel:SizeToContents()

--OWDivision XP Requirement
				OWDivisionXPLabel:SetText("XP Requirement: "..OWDivisionXP)

				OWDivisionLabel:SetText(OWDivisionText)
				OWDivisionLabel:SizeToContents()
				OWDivisionXPLabel:SizeToContents()

				if OWDivision == 8 then
				Button:SetText( "Choose Division ("..OWDivision..")" )
				else
				Button:SetText( "Choose Rank ("..RankShort..") and Division ("..OWDivision..")" )
				end
			end
--icon.Entity:SetEyeTarget( headpos-Vector( -15, 0, 0 ) )
	updateButton()
	-- We can also do anything else the client can do, like using the chat!
	chat.AddText(Color(255,255,128), "OTA Unit: ",Color(255,255,255), "Unit?" )

end

usermessage.Hook("OWShopNPCUsed", OWNPCShopMenu) --Hook to messages from the server so we know when to display the menu.







/*surface.CreateFont( "NPCName", {

    font = "Bebas Neue",

    size = 39,

    weight = 300,

    antialias = true,

} )



/*hook.Add("PostDrawOpaqueRenderables","OWNPCName",function()

		local LP = LocalPlayer()

		local LPos = LP:GetPos()

		local LPAng = LP:EyeAngles()

		for k,v in pairs(ents.FindByClass("OW_npc")) do



			local p = v:GetPos()
			if LPos:Distance(p) < 600 then
				cam.Start3D2D( p+Vector(0,0, 75), Angle(0, LPAng.y-90, 90), 0.18 )

					draw.SimpleText( "Commander", "OWNPCName", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				cam.End3D2D()

			end
	end

end)*/
