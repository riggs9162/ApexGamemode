CreateClientConVar("rp_playermodel", "", true, true)
BColor =  Color( 255, 255, 255 )

local function MayorOptns()
	local MayCat = vgui.Create("DCollapsibleCategory")
	function MayCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	MayCat:SetLabel("Administrator options")
		local maypanel = vgui.Create("DListLayout")
		maypanel:SetSize(740,170)

/*		local Lockdown = maypanel:Add("DButton")
			Lockdown:SetText(DarkRP.getPhrase("initiate_lockdown"))
			Lockdown.DoClick = function()
				LocalPlayer():ConCommand("darkrp /lockdown")
			end


			local UnLockdown = maypanel:Add("DButton")
			UnLockdown:SetText(DarkRP.getPhrase("stop_lockdown"))
			UnLockdown.DoClick = function()
				LocalPlayer():ConCommand("darkrp /unlockdown")
			end

			local Lottery = maypanel:Add("DButton")
			Lottery:SetText(DarkRP.getPhrase("start_lottery"))
			Lottery.DoClick = function()
				LocalPlayer():ConCommand("darkrp /lottery")
			end
*/
	MayCat:SetContents(maypanel)
	MayCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
	return MayCat
end

local function CPOptns()
	local CPCat = vgui.Create("DCollapsibleCategory")
	function CPCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	CPCat:SetLabel("Police options")
		local CPpanel = vgui.Create("DListLayout")
		CPpanel:SetSize(740,170)
			local SearchWarrant = CPpanel:Add("DButton")
			SearchWarrant:SetText(DarkRP.getPhrase("request_warrant"))
			SearchWarrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if not LocalPlayer():getDarkRPVar("warrant") and ply ~= LocalPlayer() then
						menu:AddOption(LocalPlayer():Nick(), function()
							Derma_StringRequest("Warrant", "Why would you warrant "..LocalPlayer():Nick().."?", nil,
								function(a)
									RunConsoleCommand("darkrp", "/warrant", LocalPlayer():SteamID(), a)
								end,
							function() end )
						end)
					end
				end
				menu:Open()
			end

			local Warrant = CPpanel:Add("DButton")
			Warrant:SetText(DarkRP.getPhrase("searchwarrantbutton"))
			Warrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if not LocalPlayer():getDarkRPVar("wanted") and ply ~= LocalPlayer() then
						menu:AddOption(LocalPlayer():Nick(), function()
							Derma_StringRequest("wanted", "Why would you make "..LocalPlayer():Nick().." wanted?", nil,
								function(a)
									if not IsValid(ply) then return end
									RunConsoleCommand("darkrp", "/wanted", LocalPlayer():SteamID(), a)
								end,
							function() end )
						end)
					end
				end
				menu:Open()
			end

			local UnWarrant = CPpanel:Add("DButton")
			UnWarrant:SetText(DarkRP.getPhrase("unwarrantbutton"))
			UnWarrant.DoClick = function()
				local menu = DermaMenu()
				for _,ply in pairs(player.GetAll()) do
					if LocalPlayer():getDarkRPVar("wanted") and ply ~= LocalPlayer() then
						menu:AddOption(LocalPlayer():Nick(), function() LocalPlayer():ConCommand("darkrp /unwanted \"" .. LocalPlayer():SteamID() .. "\"") end)
					end
				end
				menu:Open()
			end

			if LocalPlayer():Team() == TEAM_CHIEF and GAMEMODE.Config.chiefjailpos or LocalPlayer():IsAdmin() then
				local SetJailPos = CPpanel:Add("DButton")
				SetJailPos:SetText(DarkRP.getPhrase("set_jailpos"))
				SetJailPos.DoClick = function() LocalPlayer():ConCommand("darkrp /jailpos") end

				local AddJailPos = CPpanel:Add("DButton")
				AddJailPos:SetText(DarkRP.getPhrase("add_jailpos"))
				AddJailPos.DoClick = function() LocalPlayer():ConCommand("darkrp /addjailpos") end
			end

			local ismayor -- Firstly look if there's a mayor
			local ischief -- Then if there's a chief
			for k,v in pairs(player.GetAll()) do
				if v:Team() == TEAM_MAYOR then
					ismayor = true
					break
				end
			end

			if not ismayor then
				for k,v in pairs(player.GetAll()) do
					if v:Team() == TEAM_CHIEF then
						ischief = true
						break
					end
				end
			end

			local Team = LocalPlayer():Team()
			if not ismayor and (Team == TEAM_CHIEF or (not ischief and Team == TEAM_POLICE)) then
				local GiveLicense = CPpanel:Add("DButton")
				GiveLicense:SetText(DarkRP.getPhrase("give_license_lookingat"))
				GiveLicense.DoClick = function()
					LocalPlayer():ConCommand("darkrp /givelicense")
				end
			end
	CPCat:SetContents(CPpanel)
	CPCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
	return CPCat
end


local function CitOptns()
	local CitCat = vgui.Create("DCollapsibleCategory")
	function CitCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	CitCat:SetLabel("Citizen options")
		local Citpanel = vgui.Create("DListLayout")
		Citpanel:SetSize(740,110)

/*		local joblabel = Citpanel:Add("DLabel")
		joblabel:SetText(DarkRP.getPhrase("set_custom_job"))

		local jobentry = Citpanel:Add("DTextEntry")
		jobentry:SetAllowNonAsciiCharacters(true)
		jobentry:SetValue(LocalPlayer():getDarkRPVar("job") or "")
		jobentry.OnEnter = function()
			RunConsoleCommand("DarkRP", "/job", tostring(jobentry:GetValue()))
		end
*/

	if LocalPlayer():getDarkRPVar("inSpawn") == true then
				local GoLoyalist = Citpanel:Add("DButton")
				GoLoyalist:SetText("Go Normal Citizen - 0 XP Requirement")
				GoLoyalist:SetTextColor(BColor)
				GoLoyalist.DoClick = function()
					LocalPlayer():ConCommand("rp_citopt 1")
				end

				local GoBlackMarket = Citpanel:Add("DButton")
				GoBlackMarket:SetText("Go Black Market - 80 XP Requirement")
				GoBlackMarket:SetTextColor(BColor)
				GoBlackMarket.DoClick = function()
					LocalPlayer():ConCommand("rp_citopt 3")
				end
	end
	CitCat:SetContents(Citpanel)
	CitCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
	return CitCat
end

local function CWUOptns()
	local CWUCat = vgui.Create("DCollapsibleCategory")
	function CWUCat:Paint()
		self:SetBGColor(team.GetColor(LocalPlayer():Team()))
	end
	CWUCat:SetLabel("CWU options")
		local CWUpanel = vgui.Create("DListLayout")
		CWUpanel:SetSize(740,110)

/*		local joblabel = CWUpanel:Add("DLabel")
		joblabel:SetText(DarkRP.getPhrase("set_custom_job"))

		local jobentry = CWUpanel:Add("DTextEntry")
		jobentry:SetAllowNonAsciiCharacters(true)
		jobentry:SetValue(LocalPlayer():getDarkRPVar("job") or "")
		jobentry.OnEnter = function()
			RunConsoleCommand("DarkRP", "/job", tostring(jobentry:GetValue()))
		end
*/

	if LocalPlayer():getDarkRPVar("inSpawn") == true then
				local GoLoyalist = CWUpanel:Add("DButton")
				GoLoyalist:SetText("Go Standard Worker - 0 XP Requirement")
				GoLoyalist:SetTextColor(BColor)
				GoLoyalist.DoClick = function()
					LocalPlayer():ConCommand("rp_citopt 5")
				end

				local GoCook = CWUpanel:Add("DButton")
				GoCook:SetText("Go Cook - 10 XP Requirement")
				GoCook:SetTextColor(BColor)
				GoCook.DoClick = function()
					LocalPlayer():ConCommand("rp_citopt 2")
				end
				local GoMedic = CWUpanel:Add("DButton")
				GoMedic:SetText("Go Medic - 35 XP Requirement")
				GoMedic:SetTextColor(BColor)
				GoMedic.DoClick = function()
					LocalPlayer():ConCommand("rp_citopt 4")
				end

				local GoMedic = CWUpanel:Add("DButton")
				GoMedic:SetText("Go Scientist - VIP & 100 XP Requirement")
				GoMedic:SetTextColor(BColor)
				GoMedic.DoClick = function()
					LocalPlayer():ConCommand("rp_citopt 6")
				end
	end
	CWUCat:SetContents(CWUpanel)
	CWUCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
	return CWUCat
end

function GM:MoneyTab()

	local FirstTabPanel = vgui.Create("DPanelList")

	FirstTabPanel:EnableVerticalScrollbar( true )
		function FirstTabPanel:Update()
			self:Clear(true)
			local MoneyCat = vgui.Create("DCollapsibleCategory")
			MoneyCat:SetLabel("Tokens")
				local MoneyPanel = vgui.Create("DListLayout")
				MoneyPanel:SetSize(740,60)

				local GiveMoneyButton = MoneyPanel:Add("DButton")
				GiveMoneyButton:SetText(DarkRP.getPhrase("give_money"))
				GiveMoneyButton:SetTextColor(BColor)
				GiveMoneyButton.DoClick = function()
					Derma_StringRequest("Amount of tokens", "How many tokens do you want to give?", "", function(a) LocalPlayer():ConCommand("darkrp /give " .. tostring(a)) end)
				end

				local SpawnMoneyButton = MoneyPanel:Add("DButton")
				SpawnMoneyButton:SetText(DarkRP.getPhrase("drop_money"))
				SpawnMoneyButton:SetTextColor(BColor)
				SpawnMoneyButton.DoClick = function()
					Derma_StringRequest("Amount of tokens", "How many tokens do you want to drop?", "", function(a) LocalPlayer():ConCommand("darkrp /dropmoney " .. tostring(a)) end)
				end

			MoneyCat:SetContents(MoneyPanel)
			MoneyCat:SetSkin(GAMEMODE.Config.DarkRPSkin)


			local Commands = vgui.Create("DCollapsibleCategory")
			Commands:SetLabel("Actions")
				local ActionsPanel = vgui.Create("DListLayout")
				ActionsPanel:SetSize(740,210)
					local rpnamelabel = ActionsPanel:Add("DLabel")
					rpnamelabel:SetText("Change your Roleplay name:")

					local rpnameTextbox = ActionsPanel:Add("DTextEntry")
					--/rpname does not support non-ASCII characters
					rpnameTextbox:SetText(LocalPlayer():Nick())
					rpnameTextbox.OnEnter = function() RunConsoleCommand("darkrp", "/rpname", tostring(rpnameTextbox:GetValue())) end

					local Drop = ActionsPanel:Add("DButton")
					Drop:SetText(DarkRP.getPhrase("drop_weapon"))
					Drop:SetTextColor(BColor)
					Drop.DoClick = function() LocalPlayer():ConCommand("darkrp /drop") end
/*
				local Demote = ActionsPanel:Add("DButton")
				Demote:SetText(DarkRP.getPhrase("demote_player_menu"))
				Demote:SetTextColor(BColor)
				Demote.DoClick = function()
					local menu = DermaMenu()
					for _,ply in pairs(player.GetAll()) do
						if ply ~= LocalPlayer() and IsValid(ply) then
							menu:AddOption(LocalPlayer():Nick(), function()
								Derma_StringRequest("Demote reason", "Why would you demote "..LocalPlayer():Nick().."?", nil,
									function(a)
										RunConsoleCommand("darkrp", "/demote", LocalPlayer():SteamID(), a)
									end,
								function() end )
							end)
						end
					end
					menu:Open()
				end
*/
				local UnOwnAllDoors = ActionsPanel:Add("DButton")
						UnOwnAllDoors:SetText("Sell all of your doors")
						UnOwnAllDoors.DoClick = function() LocalPlayer():ConCommand("darkrp /unownalldoors") end
						UnOwnAllDoors:SetTextColor(BColor)
			Commands:SetContents(ActionsPanel)
		FirstTabPanel:AddItem(MoneyCat)
		Commands:SetSkin(GAMEMODE.Config.DarkRPSkin)
		FirstTabPanel:AddItem(Commands)

		if LocalPlayer():Team() == TEAM_ADMINISTRATOR then
			FirstTabPanel:AddItem(MayorOptns())
		elseif LocalPlayer():Team() == TEAM_CITIZEN then
			FirstTabPanel:AddItem(CitOptns())
		elseif LocalPlayer():IsCP() then
	--		FirstTabPanel:AddItem(CPOptns())
		elseif LocalPlayer():Team() == TEAM_CWU then
			FirstTabPanel:AddItem(CWUOptns())
		end
	end
	FirstTabPanel:Update()
	return FirstTabPanel
end

function GM:JobsTab()
	local hordiv = vgui.Create("DHorizontalDivider")
	hordiv:SetLeftWidth(390)
	function hordiv.m_DragBar:OnMousePressed() end
	hordiv.m_DragBar:SetCursor("none")

	local JobTab
	JobTab = vgui.Create("DPanelList")

	local JobCat

	JobCat = vgui.Create("DCollapsibleCategory", JobTab)
	JobCat:SetLabel("Available Jobs")
	JobCat:SetSize(390, 540)

	local JobCat2
	JobCat2 = vgui.Create("DCollapsibleCategory", JobTab)
	JobCat2:SetLabel("Unavailable Jobs")
	JobCat2:SetPos(0, 148)
	JobCat2:SetSize(390, 540)

	local Panel
	local Information
	function hordiv:Update()
		if Panel and Panel:IsValid() then
			Panel:Remove()
		end

		if Panel2 and Panel2:IsValid() then
			Panel2:Remove()
		end
		Panel = vgui.Create("DPanelList")
		Panel:SetSize(390, 540)
		Panel:EnableHorizontal( true )
		Panel:EnableVerticalScrollbar( true )
		Panel:SetSkin(GAMEMODE.Config.DarkRPSkin)

		Panel2 = vgui.Create("DPanelList")
		Panel2:SetSize(390, 540)
		Panel2:EnableHorizontal( true )
		Panel2:EnableVerticalScrollbar( true )
		Panel2:SetSkin(GAMEMODE.Config.DarkRPSkin)

		local Info = {}
		local model
		local modelpanel
		local function UpdateInfo(a)
			if Information and Information:IsValid() then
				Information:Remove()
			end
			Information = vgui.Create("DPanelList")
			Information:SetPos(378,0)
			Information:SetSize(370, 540)
			Information:SetSpacing(10)
			Information:EnableHorizontal( false )
			Information:EnableVerticalScrollbar( true )
			Information:SetSkin(GAMEMODE.Config.DarkRPSkin)
			function Information:Rebuild() -- YES IM OVERRIDING IT AND CHANGING ONLY ONE LINE BUT I HAVE A FUCKING GOOD REASON TO DO IT!
				local Offset = 0
				if ( self.Horizontal ) then
					local x, y = self.Padding, self.Padding;
					for k, panel in pairs( self.Items ) do
						local w = panel:GetWide()
						local h = panel:GetTall()
						if ( x + w  > self:GetWide() ) then
							x = self.Padding
							y = y + h + self.Spacing
						end
						panel:SetPos( x, y )
						x = x + w + self.Spacing
						Offset = y + h + self.Spacing
					end
				else
					for k, panel in pairs( self.Items ) do
						if not panel:IsValid() then return end
						panel:SetSize( self:GetCanvas():GetWide() - self.Padding * 2, panel:GetTall() )
						panel:SetPos( self.Padding, self.Padding + Offset )
						panel:InvalidateLayout( true )
						Offset = Offset + panel:GetTall() + self.Spacing
					end
					Offset = Offset + self.Padding
				end
				self:GetCanvas():SetTall( Offset + (self.Padding) - self.Spacing )
			end

			if type(Info) == "table" and #Info > 0 then
				for k,v in ipairs(Info) do
					local label = vgui.Create("DLabel")
					label:SetText(v)
					label:SizeToContents()
					if label:IsValid() then
						Information:AddItem(label)
					end
				end
			end

			if model and type(model) == "string" and a ~= false then
				modelpanel = vgui.Create("DModelPanel")
				modelpanel:SetModel(model)
				modelpanel:SetSize(90,230)
				modelpanel:SetAnimated(true)
				modelpanel:SetFOV(90)
				modelpanel:SetAnimSpeed(1)
				if modelpanel:IsValid() then
					Information:AddItem(modelpanel)
				end
			end
			JobCat:SetContents(Panel)
			JobCat2:SetContents(Panel2)
			hordiv:SetLeft(JobTab)
			hordiv:SetRight(Information)
		end
		UpdateInfo()

		local function AddIcon(Model, name, description, Weapons, command, special, specialcommand, XPR)
			local icon = vgui.Create("SpawnIcon")
			local IconModel = Model
			if type(Model) == "table" then
				IconModel = Model[math.random(#Model)]
			end
			icon:SetModel(IconModel)

			icon:SetSize(64, 64)
			icon:SetToolTip()
			icon.OnCursorEntered = function()
				icon.PaintOverOld = icon.PaintOver
				icon.PaintOver = icon.PaintOverHovered
				Info[1] = DarkRP.getPhrase("job_name") .. name
				Info[2] = DarkRP.getPhrase("job_description") .. description
				Info[3] = ""
				model = IconModel
				UpdateInfo()
			end
			icon.OnCursorExited = function()
				if ( icon.PaintOver == icon.PaintOverHovered ) then
					icon.PaintOver = icon.PaintOverOld
				end
				Info = {}
				if modelpanel and modelpanel:IsValid() and icon:IsValid() then
					modelpanel:Remove()
					UpdateInfo(false)
				end
			end

			icon.DoClick = function()
				local function DoChatCommand(frame)
					if special then
						local menu = DermaMenu()
						menu:AddOption("Vote", function() LocalPlayer():ConCommand("darkrp "..command) frame:Close() end)
						menu:AddOption("Do not vote", function() LocalPlayer():ConCommand("darkrp " .. specialcommand) frame:Close() end)
						menu:Open()
					else
						LocalPlayer():ConCommand("darkrp " .. command)
						frame:Close()
					end
				end

				if type(Model) == "table" and #Model > 0 then
					hordiv:GetParent():GetParent():Close()
					local frame = vgui.Create("DFrame")
					frame:SetTitle("Choose model")
					frame:SetVisible(true)
					frame:MakePopup()

					local levels = 1
					local IconsPerLevel = math.floor(ScrW()/64)

					while #Model * (64/levels) > ScrW() do
						levels = levels + 1
					end
					frame:SetSize(math.Min(#Model * 64, IconsPerLevel*64), math.Min(90+(64*(levels-1)), ScrH()))
					frame:Center()

					local CurLevel = 1
					for k,v in pairs(Model) do
						local icon = vgui.Create("SpawnIcon", frame)
						if (k-IconsPerLevel*(CurLevel-1)) > IconsPerLevel then
							CurLevel = CurLevel + 1
						end
						icon:SetPos((k-1-(CurLevel-1)*IconsPerLevel) * 64, 25+(64*(CurLevel-1)))
						icon:SetModel(v)
						icon:SetSize(64, 64)
						icon:SetToolTip()
						icon.DoClick = function()
							RunConsoleCommand("rp_playermodel", v)
							RunConsoleCommand("_rp_ChosenModel", v)
							DoChatCommand(frame)
						end
					end
				else
					DoChatCommand(hordiv:GetParent():GetParent())
				end
			end

			if icon:IsValid() then
				Panel:AddItem(icon)
			end
		end

		local function UnAddIcon(Model, name, description, Weapons, command, special, specialcommand, XPR)
			local unicon = vgui.Create("SpawnIcon")
			local IconModel = Model
			if type(Model) == "table" then
				IconModel = Model[math.random(#Model)]
			end
			unicon:SetModel(IconModel)

			unicon:SetSize(64, 64)
			unicon:SetToolTip()
			unicon.OnCursorEntered = function()
				unicon.PaintOverOld = unicon.PaintOver
				unicon.PaintOver = unicon.PaintOverHovered
				Info[1] = DarkRP.getPhrase("job_name") .. name
				Info[2] = DarkRP.getPhrase("job_description") .. description
				Info[3] = ""
				model = IconModel
				UpdateInfo()
			end
			unicon.OnCursorExited = function()
				if ( unicon.PaintOver == unicon.PaintOverHovered ) then
					unicon.PaintOver = unicon.PaintOverOld
				end
				Info = {}
				if modelpanel and modelpanel:IsValid() and unicon:IsValid() then
					modelpanel:Remove()
					UpdateInfo(false)
				end
			end

			unicon.DoClick = function()
				local function DoChatCommand(frame)
					if special then
						local menu = DermaMenu()
						menu:AddOption("Vote", function() LocalPlayer():ConCommand("darkrp "..command) frame:Close() end)
						menu:AddOption("Do not vote", function() LocalPlayer():ConCommand("darkrp " .. specialcommand) frame:Close() end)
						menu:Open()
					else
						LocalPlayer():ConCommand("darkrp " .. command)
						frame:Close()
					end
				end

				if type(Model) == "table" and #Model > 0 then
					hordiv:GetParent():GetParent():Close()
					local frame = vgui.Create("DFrame")
					frame:SetTitle("Choose model")
					frame:SetVisible(true)
					frame:MakePopup()

					local levels = 1
					local IconsPerLevel = math.floor(ScrW()/64)

					while #Model * (64/levels) > ScrW() do
						levels = levels + 1
					end
					frame:SetSize(math.Min(#Model * 64, IconsPerLevel*64), math.Min(90+(64*(levels-1)), ScrH()))
					frame:Center()

					local CurLevel = 1
					for k,v in pairs(Model) do
						local unicon = vgui.Create("SpawnIcon", frame)
						if (k-IconsPerLevel*(CurLevel-1)) > IconsPerLevel then
							CurLevel = CurLevel + 1
						end
						unicon:SetPos((k-1-(CurLevel-1)*IconsPerLevel) * 64, 25+(64*(CurLevel-1)))
						unicon:SetModel(v)
						unicon:SetSize(64, 64)
						unicon:SetToolTip()
						unicon.DoClick = function()
							RunConsoleCommand("rp_playermodel", v)
							RunConsoleCommand("_rp_ChosenModel", v)
							DoChatCommand(frame)
						end
					end
				else
					DoChatCommand(hordiv:GetParent():GetParent())
				end
			end

			if unicon:IsValid() then
				Panel2:AddItem(unicon)
			end
		end


		for k,v in ipairs(RPExtraTeams) do
			if LocalPlayer():Team() ~= k and GAMEMODE:CustomObjFitsMap(v) then
				local nodude = true
				if v.admin == 1 and not LocalPlayer():IsAdmin() then
					nodude = false
				end
				if v.admin > 1 and not LocalPlayer():IsSuperAdmin() then
					nodude = false
				end
				if v.customCheck and not v.customCheck(LocalPlayer()) then
					nodude = false
				end

				if (type(v.NeedToChangeFrom) == "number" and LocalPlayer():Team() ~= v.NeedToChangeFrom) or (type(v.NeedToChangeFrom) == "table" and not table.HasValue(v.NeedToChangeFrom, LocalPlayer():Team())) then
					nodude = false
				end

				xp = LocalPlayer():GetNetworkedInt( "Xp" ) or 0
				XPR = v.xp

				bypassXP = false


				if(XPR > xp)then
					nodude = false
				end

				if(LocalPlayer():IsAdmin() or LocalPlayer():IsSuperAdmin())then
		--	Remove this when finished	nodude = true
				end

				if nodude then
					local weps = "no extra weapons"
					if #v.weapons > 0 then
						weps = table.concat(v.weapons, "\n")
					end
					if (not v.RequiresVote and v.vote) or (v.RequiresVote and v.RequiresVote(LocalPlayer(), k)) then
						local condition = ((v.admin == 0 and LocalPlayer():IsAdmin()) or (v.admin == 1 and LocalPlayer():IsSuperAdmin()) or LocalPlayer().DarkRPVars["Priv"..v.command])
						if not v.model or not v.name or not v.description or not v.command then chat.AddText(Color(255,0,0,255), "Incorrect team! Fix your shared.lua!") return end
						AddIcon(v.model, v.name, v.description, weps, "/vote"..v.command, condition, "/"..v.command)
					else
						if not v.model or not v.name or not v.description or not v.command then chat.AddText(Color(255,0,0,255), "Incorrect team! Fix your shared.lua!") return end
						AddIcon(v.model, v.name, v.description, weps, "/"..v.command)
					end
				else
						UnAddIcon(v.model, v.name, v.description, weps, "/"..v.command)
				end
			end


		end
	end
	hordiv:Update()
	return hordiv
end

function GM:InformationTab()
	local InformationTab = vgui.Create("DPanelList")

	InformationTab:EnableVerticalScrollbar( true )
	function InformationTab:Update()
		self:Clear(true)
	end

	local heading = vgui.Create("DLabel", InformationTab)
	heading:SetText("Welcome to Apex-Roleplay HL2RP Server")
	heading:SetFont("Trebuchet24")
	heading:SizeToContents()


	local text = vgui.Create("DLabel", InformationTab)
	text:SetText("\n\nSemi-Serious HL2RP is a gamemode is inspired by the one Aerolite had. We are trying to continue their work as good as we can.")
	text:SizeToContents()

	local heading2 = vgui.Create("DLabel", InformationTab)
	heading2:SetText("\n\n\nChat Commands")
	heading2:SetFont("Trebuchet24")
	heading2:SizeToContents()

	local text = vgui.Create("DLabel", InformationTab)
	text:SetText("\n\n\n\n\n\n\n\n// - Type in OOC Chat\n/w - Whisper\n/y - Yell\n/apply - Show your ID to a player.\n/job - Set a customised job role.\n/name - Change your in-game roleplay name.\n/scanner - Deploy a scanner as GRID unit.\n/request - Calls the CCA.\n/reward Will reward a citizen. \n/vortcall Will call all vorts. \n/photocache Will show all scanner images.")
	text:SizeToContents()

	local heading2 = vgui.Create("DLabel", InformationTab) 
	heading2:SetText("\n\n\n\n\n\n\n\n\n\n\n\n\nXP System")
	heading2:SetFont("Trebuchet24")
	heading2:SizeToContents()


	local text3 = vgui.Create("DLabel", InformationTab)
	text3:SetText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nXP is used to unlock jobs, the more you play, the more jobs you can play, XP is earned by playing on the server, you gain 5 XP every 10 minutes.")
	text3:SizeToContents()

	InformationTab:Update()
	return InformationTab
end

function GM:RulesTab()
	local RulesTab = vgui.Create("DPanelList")
	RulesTab:EnableVerticalScrollbar( true )
	function RulesTab:Update()
		self:Clear(true)
	end
local html = vgui.Create( "HTML", RulesTab )
html:Dock( FILL )
html:OpenURL( "https://docs.google.com/document/d/e/2PACX-1vRj6UdoV2d9JR2FJD_lAIUR3wBWxIHimUcPU1amWmFacIgdj_U8LPe37vXOn7erZCcczsOKGT6HHFjA/pub" )


	RulesTab:Update()
	return RulesTab
end

function GM:EntitiesTab()
	local EntitiesPanel = vgui.Create("DPanelList")
	EntitiesPanel:EnableVerticalScrollbar( true )
		function EntitiesPanel:Update()
			self:Clear(true)
			local AmmCat = vgui.Create("DCollapsibleCategory")
			AmmCat:SetLabel("Ammo")
				local AmmPanel = vgui.Create("DPanelList")
				AmmPanel:SetSize(470, 100)
				AmmPanel:SetAutoSize(true)
				AmmPanel:SetSpacing(1)
				AmmPanel:EnableHorizontal(true)
				AmmPanel:EnableVerticalScrollbar(true)
					local function AddAmmoIcon(Model, description, command)
						local icon = vgui.Create("SpawnIcon")
						icon:InvalidateLayout( true )
						icon:SetModel(Model)
						icon:SetSize(64, 64)
						icon:SetToolTip(description)
						icon.DoClick = function() LocalPlayer():ConCommand("darkrp "..command) end
						AmmPanel:AddItem(icon)
					end

					local ammnum = 0
					for k,v in pairs(GAMEMODE.AmmoTypes) do
						if not v.customCheck or v.customCheck(LocalPlayer()) then
							AddAmmoIcon(v.model, DarkRP.getPhrase("buy_a", v.name, GAMEMODE.Config.currency .. v.price), "/buyammo " .. v.ammoType)
							ammnum = ammnum + 1
						end
					end

			if ammnum ~= 0 then
				AmmCat:SetContents(AmmPanel)
				AmmCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
				self:AddItem(AmmCat)
			else
				AmmPanel:Remove()
				AmmCat:Remove()
			end

			local WepCat = vgui.Create("DCollapsibleCategory")
			WepCat:SetLabel("Weapons / Utilities")
				local WepPanel = vgui.Create("DPanelList")
				WepPanel:SetSize(470, 100)
				WepPanel:SetAutoSize(true)
				WepPanel:SetSpacing(1)
				WepPanel:EnableHorizontal(true)
				WepPanel:EnableVerticalScrollbar(true)
					local function AddIcon(Model, description, command)
						local icon = vgui.Create("SpawnIcon")
						icon:InvalidateLayout( true )
						icon:SetModel(Model)
						icon:SetSize(64, 64)
						icon:SetToolTip(description)
						icon.DoClick = function() LocalPlayer():ConCommand("darkrp "..command) end
						WepPanel:AddItem(icon)
					end

					local wepnum = 0
					for k,v in pairs(CustomShipments) do
						if not GAMEMODE:CustomObjFitsMap(v) then continue end
						if (v.seperate and (not GAMEMODE.Config.restrictbuypistol or
							(GAMEMODE.Config.restrictbuypistol and (not v.allowed[1] or table.HasValue(v.allowed, LocalPlayer():Team())))))
							and (not v.customCheck or v.customCheck and v.customCheck(LocalPlayer())) then
							AddIcon(v.model, DarkRP.getPhrase("buy_a", "a "..v.name, GAMEMODE.Config.currency..(v.pricesep or "")), "/buy "..v.name)
							wepnum = wepnum + 1
						end
					end

				if wepnum ~= 0 then
					WepCat:SetContents(WepPanel)
					WepCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
					self:AddItem(WepCat)
				else
					WepPanel:Remove()
					WepCat:Remove()
				end

			local ShipCat = vgui.Create("DCollapsibleCategory")
			ShipCat:SetLabel("Shipments")
				local ShipPanel = vgui.Create("DPanelList")
				ShipPanel:SetSize(470, 200)
				ShipPanel:SetAutoSize(true)
				ShipPanel:SetSpacing(1)
				ShipPanel:EnableHorizontal(true)
				ShipPanel:EnableVerticalScrollbar(true)
					local function AddShipIcon(Model, description, command)
						local icon = vgui.Create("SpawnIcon")
						icon:InvalidateLayout( true )
						icon:SetModel(Model)
						icon:SetSize(64, 64)
						icon:SetToolTip(description)
						icon.DoClick = function() LocalPlayer():ConCommand("darkrp "..command) end
						ShipPanel:AddItem(icon)
					end

					local shipnum = 0
					for k,v in pairs(CustomShipments) do
						if not GAMEMODE:CustomObjFitsMap(v) then continue end
						if not v.noship and table.HasValue(v.allowed, LocalPlayer():Team())
							and (not v.customCheck or (v.customCheck and v.customCheck(LocalPlayer()))) then
							AddShipIcon(v.model, DarkRP.getPhrase("buy_a", "a "..v.name .." shipment", GAMEMODE.Config.currency .. tostring(v.price)), "/buyshipment "..v.name)
							shipnum = shipnum + 1
						end
					end
				if shipnum ~= 0 then
					ShipCat:SetContents(ShipPanel)
					ShipCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
					self:AddItem(ShipCat)
				else
					ShipPanel:Remove()
					ShipCat:Remove()
				end

			local EntCat = vgui.Create("DCollapsibleCategory")
			EntCat:SetLabel("Entities")
				local EntPanel = vgui.Create("DPanelList")
				EntPanel:SetSize(470, 200)
				EntPanel:SetAutoSize(true)
				EntPanel:SetSpacing(1)
				EntPanel:EnableHorizontal(true)
				EntPanel:EnableVerticalScrollbar(true)
					local function AddEntIcon(Model, description, command)
						local icon = vgui.Create("SpawnIcon")
						icon:InvalidateLayout( true )
						icon:SetModel(Model)
						icon:SetSize(64, 64)
						icon:SetToolTip(description)
						icon.DoClick = function() LocalPlayer():ConCommand("darkrp "..command) end
						EntPanel:AddItem(icon)
					end
					local entnum = 0
					for k,v in pairs(DarkRPEntities) do
						if not v.allowed or (type(v.allowed) == "table" and table.HasValue(v.allowed, LocalPlayer():Team()))
							and (not v.customCheck or (v.customCheck and v.customCheck(LocalPlayer()))) then
							local cmdname = string.gsub(v.ent, " ", "_")

							AddEntIcon(v.model, "Buy a " .. v.name .." " .. GAMEMODE.Config.currency .. v.price, v.cmd)
							entnum = entnum + 1
						end
					end

function CanBuyFood(ply)
	if ply:Team() == TEAM_CP and ply.DarkRPVars.Division and ply.DarkRPVars.Division == 2 then
		return true
	elseif ply:Team() == TEAM_CWU and ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == 2 then
		return true
        elseif ply:Team() == TEAM_VORT and ply:GetModel()=="models/vortigaunt.mdl" then
                return true
	else
		return false
	end
end

					if FoodItems and CanBuyFood(LocalPlayer()) then
						for k,v in pairs(FoodItems) do
							if v.team == LocalPlayer():Team() then
								AddEntIcon(v.model, DarkRP.getPhrase("buy_a", "a "..k, "T"..v.price..""), "/buyfood "..k)
								entnum = entnum + 1
							end
						end
					end
				if entnum ~= 0 then
					EntCat:SetContents(EntPanel)
					EntCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
					self:AddItem(EntCat)
				else
					EntPanel:Remove()
					EntCat:Remove()
				end


			if #CustomVehicles <= 0 then return end
			local VehicleCat = vgui.Create("DCollapsibleCategory")
			VehicleCat:SetLabel("Vehicles")
				local VehiclePanel = vgui.Create("DPanelList")
				VehiclePanel:SetSize(470, 200)
				VehiclePanel:SetAutoSize(true)
				VehiclePanel:SetSpacing(1)
				VehiclePanel:EnableHorizontal(true)
				VehiclePanel:EnableVerticalScrollbar(true)
				local function AddVehicleIcon(Model, skin, description, command)
					local icon = vgui.Create("SpawnIcon")
					icon:InvalidateLayout( true )
					icon:SetModel(Model)
					icon:SetSkin(skin)
					icon:SetSize(64, 64)
					icon:SetToolTip(description)
					icon.DoClick = function() LocalPlayer():ConCommand("darkrp "..command) end
					VehiclePanel:AddItem(icon)
				end

				local founds = 0
				for k,v in pairs(CustomVehicles) do
					if (not v.allowed or table.HasValue(v.allowed, LocalPlayer():Team())) and (not v.customCheck or v.customCheck(LocalPlayer())) then
						local Skin = (DarkRP.getAvailableVehicles()[v.name] and DarkRP.getAvailableVehicles()[v.name].KeyValues and DarkRP.getAvailableVehicles()[v.name].KeyValues.Skin) or "0"
						AddVehicleIcon(v.model or "models/buggy.mdl", Skin, "Buy a "..v.name.." for "..GAMEMODE.Config.currency..v.price, "/buyvehicle "..v.name)
						founds = founds + 1
					end
				end
			if founds ~= 0 then
				VehicleCat:SetContents(VehiclePanel)
				VehicleCat:SetSkin(GAMEMODE.Config.DarkRPSkin)
				self:AddItem(VehicleCat)
			else
				VehiclePanel:Remove()
				VehicleCat:Remove()
			end
		end
	EntitiesPanel:SetSkin(GAMEMODE.Config.DarkRPSkin)
	EntitiesPanel:Update()
	return EntitiesPanel
end

local DefaultWeapons = {
{name = "GravGun",class = "weapon_physcannon"},
{name = "Physgun",class = "weapon_physgun"},
{name = "Crowbar",class = "weapon_crowbar"},
{name = "Stunstick",class = "weapon_stunstick"},
{name = "Pistol",class = "weapon_pistol"},
{name = "357",	class = "weapon_357"},
{name = "SMG", class = "weapon_smg1"},
{name = "Shotgun", class = "weapon_shotgun"},
{name = "Crossbow", class = "weapon_crossbow"},
{name = "AR2", class = "weapon_ar2"},
{name = "BugBait",	class = "weapon_bugbait"},
{name = "RPG", class = "weapon_rpg"}
}