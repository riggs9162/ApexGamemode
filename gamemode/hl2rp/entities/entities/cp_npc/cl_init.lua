include('shared.lua') -- At this point the contents of shared.lua are ran on the client only.


function ENT:Draw()
	self:DrawModel()
	if LocalPlayer():GetEyeTrace().Entity == self and EyePos():Distance( self:GetPos() ) < 512 then
		hook.Add("PreDrawHalos", "Halo", function()
			if LocalPlayer():Team() == TEAM_CP then
				halo.Add({ self }, Color(0, 0, 255), 0, 0, 0)
				end
		end)
	end
end

function NPCShopMenu()

	-- Small derma panel just for the example.
		CPMenu = vgui.Create("DFrame")
		CPMenu:SetSkin(GAMEMODE.Config.DarkRPSkin)
		CPMenu:SetSize(900, 400)
		CPMenu:Center()
		CPMenu:SetVisible( true )
		CPMenu:MakePopup()
		CPMenu.Paint = function( self, w, h ) -- 'function Frame:Paint( w, h )' works too
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0,0,0, 200 ) )
			draw.RoundedBox( 0, 0, 0, w, 25, Color( 73,147,197, 150 ) ) -- Draw a red box instead of the frame

			draw.RoundedBox( 0, 10, 35, w-20, 35, Color( 50,50,50, 150)) -- TOPBG

			draw.RoundedBox( 0, 10, 80, 370, 270, Color( 50,50,50, 150)) -- Rank Info

			draw.RoundedBox( 0, 520, 80, 370, 270, Color( 50,50,50, 150)) -- Division Info

			draw.RoundedBox( 0, 20, 43, 350, 20, Color( 100,100,100, 220)) -- RANK

			draw.RoundedBox( 0, 530, 43, 350, 20, Color( 100,100,100, 220)) --DIVISION


		end
		CPMenu:SetTitle("Civil Protection")

		Rank = ""
		Division = ""

		RankLabel = vgui.Create( "DLabel", CPMenu )
			RankLabel:SetPos( 25, 85 )
		if not RankLabel:GetText() or RankLabel:GetText("Label") then
			RankLabel:SetText("")
		end
			RankLabel:SetSize(250, 360)
			RankLabel:SizeToContents()


		DivisionLabel = vgui.Create( "DLabel", CPMenu )
			DivisionLabel:SetPos( 535, 85 )
		if not DivisionLabel:GetText() or DivisionLabel:GetText("Label") then
			DivisionLabel:SetText("")
		end
			DivisionLabel:SetSize(250, 360)
			DivisionLabel:SizeToContents()

--Division Block XP Requirement

		DivisionXPLabel = vgui.Create( "DLabel", CPMenu )
			DivisionXPLabel:SetPos( 535, 330 )
		if not DivisionXPLabel:GetText() or DivisionXPLabel:GetText("Label") then
			DivisionXPLabel:SetText("XP Requirement: ")
		end
			DivisionXPLabel:SizeToContents()

--Rank XP Requirement Corner
		RankXPLabel = vgui.Create( "DLabel", CPMenu )
			RankXPLabel:SetPos( 25, 330 )
		if not RankXPLabel:GetText() or RankXPLabel:GetText("Label") then
			RankXPLabel:SetText("XP Requirement: ")
		end
			RankXPLabel:SizeToContents()

		local DRankBox = vgui.Create( "DDropListBox", CPMenu )
				DRankBox:SetSkin(GAMEMODE.Config.DarkRPSkin)
				DRankBox:SetTextColor( Color( 255, 255, 255 ) )
				DRankBox:SetPos( 20, 43 )
				DRankBox:SetSize( 350, 20 )
				DRankBox:SetValue( "Choose a Rank" )
				DRankBox:AddChoice( "RCT - Recruit", 1 )
				DRankBox:AddChoice( "05  - Ground Unit 5", 2 )
				DRankBox:AddChoice( "04  - Ground Unit 4", 3 )
				DRankBox:AddChoice( "03  - Ground Unit 3", 4 )
				DRankBox:AddChoice( "02  - Ground Unit 2", 5 )
				DRankBox:AddChoice( "01  - Ground Unit 1", 6 )
				DRankBox:AddChoice( "OfC - Officer", 7 )
				DRankBox:AddChoice( "EpU - Elite Protection Unit", 8 )
				DRankBox:AddChoice( "DvL - Division Leader", 9 )

				DRankBox.OnSelect = function( panel, index, value )
					Rank = value
					RankI = index or 1
					updateButton()
				end

		local DDivisionBox = vgui.Create( "DDropListBox", CPMenu )
				DDivisionBox:SetTextColor( Color( 255, 255, 255 ) )
				DDivisionBox:SetPos( 530, 43 )
				DDivisionBox:SetSize( 350, 20 )
				DDivisionBox:SetValue( "Choose a Division" )
				DDivisionBox:AddChoice( "UNION - Specialist Patrol Unit", 1 )
				DDivisionBox:AddChoice( "HELIX - Specialist Medical Unit", 2 )
				DDivisionBox:AddChoice( "GRID  - Specialist Engineering Unit", 3 )
				DDivisionBox:AddChoice( "JURY  - Interrogation and Torture Unit", 4 )
				DDivisionBox:AddChoice( "SPEAR - Recon Unit", 5 )
				DDivisionBox:AddChoice( "COMMANDER", 6 )
				DDivisionBox:AddChoice( "SECTORAL COMMANDER", 7)
				DDivisionBox.OnSelect = function( panel, index, value )
					Division = value
					DivisionI = index or 1
					updateButton()
				end

		local icon = vgui.Create( "DModelPanel", CPMenu )
			icon:SetSize( 300, 300 )
			icon:SetPos( 290, 50)
			icon:SetModel( "models/player/police.mdl" ) -- you can only change colors on playermodels
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

		local Button = vgui.Create( "DButton", CPMenu )
			Button:SetFont("NameFont")
			Button:SetText( "Choose Rank ("..Rank..") and Division ("..Division..")" )
			Button:SetTextColor( Color( 255, 255, 255 ) )
			Button:SetPos( 10, 360 )
			Button:SetSize( 880, 30 )
			Button.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 9,102,3, 230 ) ) -- Draw a blue button
			end

			Button.DoClick = function()
				if RankI and DivisionI then
					LocalPlayer():ConCommand( "rp_division "..RankI.." "..DivisionI )
--					print("Rank:"..RankI.." Div: "..DivisionI)
					CPMenu:Close()
				end
			end
			function updateButton()

				if not RankI then
					RankI = 1
					DivisionI = 1
				end

				RankText = CPRanks[RankI].description

				local RankShort = CPRanks[RankI].name
				RankLabel:SetText(RankText)
				RankLabel:SizeToContents()

				DivisionText = CPDivisions[DivisionI].description
				local DivisionXP = CPDivisions[DivisionI].xp
				icon:SetModel(CPDivisions[DivisionI].model)
				icon:RunAnimation()

				--Rank XP Requirement
				local RankXP = CPRanks[RankI].xp
				RankXPLabel:SetText("XP Requirement: "..RankXP)

				RankXPLabel:SizeToContents()

--Division XP Requirement
				DivisionXPLabel:SetText("XP Requirement: "..DivisionXP)

				DivisionLabel:SetText(DivisionText)
				DivisionLabel:SizeToContents()
				DivisionXPLabel:SizeToContents()

				if DivisionI == 7 or DivisionI == 8 then
				Button:SetText( "Choose Division ("..Division..")" )
				else
				Button:SetText( "Choose Rank ("..RankShort..") and Division ("..Division..")" )
				end
			end
--icon.Entity:SetEyeTarget( headpos-Vector( -15, 0, 0 ) )
	updateButton()
	-- We can also do anything else the client can do, like using the chat!
	chat.AddText(Color(255,255,128), "CP Unit: ",Color(255,255,255), "What do you need help with?" )

end

usermessage.Hook("ShopNPCUsed", NPCShopMenu) --Hook to messages from the server so we know when to display the menu.







/*surface.CreateFont( "NPCName", {

    font = "Bebas Neue",

    size = 39,

    weight = 300,

    antialias = true,

} )



/*hook.Add("PostDrawOpaqueRenderables","CPNPCName",function()

		local LP = LocalPlayer()

		local LPos = LP:GetPos()

		local LPAng = LP:EyeAngles()

		for k,v in pairs(ents.FindByClass("cp_npc")) do



			local p = v:GetPos()
			if LPos:Distance(p) < 600 then
				cam.Start3D2D( p+Vector(0,0, 75), Angle(0, LPAng.y-90, 90), 0.18 )

					draw.SimpleText( "Commander", "NPCName", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				cam.End3D2D()

			end
	end

end)*/