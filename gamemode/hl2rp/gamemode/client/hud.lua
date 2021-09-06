/*---------------------------------------------------------------------------
HUD ConVars
---------------------------------------------------------------------------*/
local ConVars = {}
local HUDWidth
local HUDHeight

local Color = Color
local cvars = cvars
local draw = draw
local GetConVar = GetConVar
local Lerp = Lerp
local localplayer
local pairs = pairs
local SortedPairs = SortedPairs
local string = string
local surface = surface
local table = table
local tostring = tostring

CreateClientConVar("weaponhud", 0, true, false)

local function ReloadConVars()
	ConVars = {
		background = {0,0,0,20},
		Healthbackground = {0,0,0,200},
		Healthforeground = {140,0,0,180},
		HealthText = {255,255,255,200},
		Job1 = {0,0,150,200},
		Job2 = {0,0,0,255},
		salary1 = {0,150,0,200},
		salary2 = {0,0,0,255}
	}

	for name, Colour in pairs(ConVars) do
		ConVars[name] = {}
		for num, rgb in SortedPairs(Colour) do
			local CVar = GetConVar(name..num) or CreateClientConVar(name..num, rgb, true, false)
			table.insert(ConVars[name], CVar:GetInt())

			if not cvars.GetConVarCallbacks(name..num, false) then
				cvars.AddChangeCallback(name..num, function() timer.Simple(0,ReloadConVars) end)
			end
		end
		ConVars[name] = Color(unpack(ConVars[name]))
	end


	HUDWidth = 260
	HUDHeight = 115

	if not cvars.GetConVarCallbacks("HudW", false) and not cvars.GetConVarCallbacks("HudH", false) then
		cvars.AddChangeCallback("HudW", function() timer.Simple(0,ReloadConVars) end)
		cvars.AddChangeCallback("HudH", function() timer.Simple(0,ReloadConVars) end)
	end
end
ReloadConVars()

local function formatNumber(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    local sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end


local Scrw, Scrh, RelativeX, RelativeY
/*---------------------------------------------------------------------------
HUD Seperate Elements
---------------------------------------------------------------------------*/
local Health = 0

local function DrawName()

end
local function DrawHealth()
	Health = math.min(100, (Health == localplayer:Health() and Health) or Lerp(0.1, Health, localplayer:Health()))

	local DrawHealth = math.Min(Health / GAMEMODE.Config.startinghealth, 1)
	local Border = math.Min(6, math.pow(2, math.Round(3*DrawHealth)))
	draw.RoundedBox(Border, RelativeX + 4, RelativeY - 30, HUDWidth - 8, 20, ConVars.Healthbackground)
	draw.RoundedBox(Border, RelativeX + 5, RelativeY - 29, (HUDWidth - 9) * DrawHealth, 18, ConVars.Healthforeground)

	draw.DrawText(math.Max(0, math.Round(localplayer:Health())), "DarkRPHUD2", RelativeX + 4 + (HUDWidth - 8)/2, RelativeY - 32, ConVars.HealthText, 1)

	-- Armor
	local armor = localplayer:Armor()
	if armor ~= 0 then
		draw.RoundedBox(2, RelativeX + 4, RelativeY - 15, (HUDWidth - 8) * armor / 100, 5, Color(0, 0, 255, 255))
	end
end

local Page = Material("icon16/page_white_text.png")
local function GunLicense()
	if localplayer:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(Page)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(RelativeX + HUDWidth, ScrH() - 34, 32, 32)
	end
end

local function Agenda()

end

local VoiceChatTexture = surface.GetTextureID("voice/icntlk_pl")
local function DrawVoiceChat()
	if localplayer.DRPIsTalking then
		local chbxX, chboxY = chat.GetChatBoxPos()

		local Rotating = math.sin(CurTime()*3)
		local backwards = 0
		if Rotating < 0 then
			Rotating = 1-(1+Rotating)
			backwards = 180
		end
		surface.SetTexture(VoiceChatTexture)
		surface.SetDrawColor(ConVars.Healthforeground)
		surface.DrawTexturedRectRotated(ScrW() - 100, chboxY, Rotating*96, 96, backwards)
	end
end

local function LockDown()
	local chbxX, chboxY = chat.GetChatBoxPos()
	if util.tobool(GetConVarNumber("DarkRP_LockDown")) then
		draw.RoundedBox(0, Scrw/2-120, Scrh - 65, 240, 30, Color( 0, 0, 0, 230 ) )
		local cin = (math.sin(CurTime()) + 1) / 2
		local chatBoxSize = math.floor(ScrH() / 4)
		draw.DrawText("Lockdown in progress!", "NameFont", Scrw/2-65, Scrh - 58, Color(255, 255, 255, 255), 0)

	end
end

local Arrested = function() end

usermessage.Hook("GotArrested", function(msg)
	local StartArrested = CurTime()
	local ArrestedUntil = msg:ReadFloat()

	Arrested = function()
		if CurTime() - StartArrested <= ArrestedUntil and localplayer:getDarkRPVar("Arrested") then
		draw.DrawText(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "DarkRPHUD2", ScrW()/2, ScrH() - ScrH()/12, Color(255,255,255,255), 1)
		elseif not localplayer:getDarkRPVar("Arrested") then
			Arrested = function() end
		end
	end
end)

local AdminTell = function() end

usermessage.Hook("AdminTell", function(msg)
	local Message = msg:ReadString()

	AdminTell = function()
		draw.RoundedBox(4, 10, 10, ScrW() - 20, 100, Color(0, 0, 0, 200))
		draw.DrawText(DarkRP.getPhrase("listen_up"), "GModToolName", ScrW() / 2 + 10, 10, Color(255, 255, 255, 255), 1)
		draw.DrawText(Message, "ChatFont", ScrW() / 2 + 10, 80, Color(200, 30, 30, 255), 1)
	end

	timer.Simple(10, function()
		AdminTell = function() end
	end)
end)

local function DrawPlayerModel()
	if !DermaShown then
		PlayerIcon = vgui.Create("SpawnIcon")
		PlayerIcon:SetPos( 25, ScrH() - 125 )
		PlayerIcon:SetSize(60, 60)
		PlayerIcon:SetToolTip("")
		PlayerIcon:SetModel(LocalPlayer():GetModel())

		DermaShown = true

	end
	PlayerIcon:SetModel(LocalPlayer():GetModel() or "models/noesis/dohl2rp.mdl")
end

local function DrawInfo()

	if not HL2RP_texCache then HL2RP_texCache = {} end
	if not HL2RP_texCache["SilkUser"] then HL2RP_texCache["SilkUser"] = Material("icon16/user.png") end
	if not HL2RP_texCache["SilkShield"] then HL2RP_texCache["SilkShield"] = Material("icon16/shield.png") end
	if not HL2RP_texCache["SilkJob"] then HL2RP_texCache["SilkJob"] = Material("icon16/group.png") end
	if not HL2RP_texCache["SilkHeart"] then HL2RP_texCache["SilkHeart"] = Material("icon16/heart.png") end
	if not HL2RP_texCache["SilkMoney"] then HL2RP_texCache["SilkMoney"] = Material("icon16/money.png") end
	if not HL2RP_texCache["SilkSalary"] then HL2RP_texCache["SilkSalary"] = Material("icon16/money_add.png") end
	if not HL2RP_texCache["StrawberryIcon"] then HL2RP_texCache["StrawberryIcon"] = Material("hl2rp/strawberryicon.vtf") end
	if not HL2RP_texCache["SilkWarning"] then HL2RP_texCache["SilkWarning"] = Material("icon16/exclamation.png") end

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(HL2RP_texCache["SilkUser"])
	surface.DrawTexturedRect(18,ScrH() - 173,16,16)
	draw.DrawText("Name: " .. LocalPlayer():Nick(), "NameFont", RelativeX + 40, RelativeY - HUDHeight - 57, Color(255, 255, 255, 255), 0)


	local job = localplayer:getDarkRPVar("job") or ""
	local money = localplayer:getDarkRPVar("money") or ""
	if LocalPlayer():getDarkRPVar("Energy") then
		energy = math.Round(LocalPlayer():getDarkRPVar("Energy")) or 0
	else
		energy = 0
	end

	local salery = localplayer:getDarkRPVar("salary") or 0
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(HL2RP_texCache["SilkJob"])
	surface.DrawTexturedRect(18,ScrH() - 31,16,16)
	draw.DrawText("Job: " .. job, "NameFont", RelativeX + 40, RelativeY - HUDHeight + 85, Color(255, 255, 255, 255), 0)

	surface.SetMaterial(HL2RP_texCache["SilkHeart"])
	surface.DrawTexturedRect( RelativeX + 100,ScrH() - 140,16,16)
	draw.DrawText("Health: " .. LocalPlayer():Health() or "", "NameFont", RelativeX + 125, ScrH() - 140, Color(255, 255, 255, 255), 0)

	surface.SetMaterial(HL2RP_texCache["SilkShield"])
	surface.DrawTexturedRect( RelativeX + 100,ScrH() - 120,16,16)
	draw.DrawText("Armour: " .. LocalPlayer():Armor() or "", "NameFont", RelativeX + 125, ScrH() - 120, Color(255, 255, 255, 255), 0)

	surface.SetMaterial(HL2RP_texCache["SilkMoney"])
	surface.DrawTexturedRect( RelativeX + 100,ScrH() - 100,16,16)
	draw.DrawText("Tokens: " .. "T" .. money or 0, "NameFont", RelativeX + 125, ScrH() - 100, Color(255, 255, 255, 255), 0)

	surface.SetMaterial(HL2RP_texCache["SilkSalary"])
	surface.DrawTexturedRect( RelativeX + 100,ScrH() - 80,16,16)
	draw.DrawText("Salary: " .. "T" .. salery, "NameFont", RelativeX + 125, ScrH() - 80, Color(255, 255, 255, 255), 0)

	surface.SetMaterial(HL2RP_texCache["StrawberryIcon"])
	surface.DrawTexturedRect( RelativeX + 100,ScrH() - 60,16,16)
	draw.DrawText("Food: " .. energy .. "%", "NameFont", RelativeX + 125, ScrH() - 60, Color(255, 255, 255, 255), 0)


end

local function DrawWarningBox(weaponName)
	draw.RoundedBox(0, 10, Scrh - HUDHeight - 136, HUDWidth, 70, Color( 40, 0, 0, 240 ) )
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(HL2RP_texCache["SilkWarning"])
	surface.DrawTexturedRect(20,ScrH() - 220,16,16)
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(HL2RP_texCache["SilkWarning"])
	surface.DrawTexturedRect(245,ScrH() - 220,16,16)
	draw.DrawText("You should only use the "..weaponName.."\n    while building. Using it in a RP \n situation is FailRP and punishable.",  "NameFont", RelativeX + 30, RelativeY -  235, Color(255, 255, 255, 255), 0)
end

local function DrawWarning()
	if LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass()  and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then
		DrawWarningBox("physgun")
	elseif LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass()  and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" then
		DrawWarningBox("tool gun")
	elseif LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass()  and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physcannon" then
		DrawWarningBox("gravity gun ")
	end

end

local function DrawSide()

	local xp = LocalPlayer():GetNetworkedInt( "Xp" ) or 0

	draw.RoundedBox(0, ScrW() - 120, 80, 140, 30, Color( 0, 0, 0, 230 ) )
	draw.DrawText("XP: " .. xp, "NameFont", ScrW() - 110, 87, Color(255, 255, 255, 255), 0)

	draw.RoundedBox(0, ScrW() - 120, 120, 140, 50, Color( 0, 0, 0, 230 ) )
	draw.DrawText("Time: " .. os.date( "%H:%M" ), "NameFont", ScrW() - 110, 127, Color(255, 255, 255, 255), 0)
	local ICTime = GetGlobalString( "ICTime" ) or ""
	draw.DrawText("IC-Time: " .. ICTime, "NameFont", ScrW() - 110, 147, Color(255, 255, 255, 255), 0)

end

local function RecvSTime( data )
		STime = data:ReadString();
end
usermessage.Hook( "STime", RecvSTime );

/*---------------------------------------------------------------------------
Drawing the HUD elements such as Health etc.
---------------------------------------------------------------------------*/
local function DrawHUD()

	localplayer = localplayer and IsValid(localplayer) and localplayer or LocalPlayer()
	if not IsValid(localplayer) then return end

	local shouldDraw = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_HUD")
	if shouldDraw == false then return end

	Scrw, Scrh = ScrW(), ScrH()
	RelativeX, RelativeY = 0, Scrh

	--Background
	draw.RoundedBox(0, 10, Scrh - HUDHeight - 65, HUDWidth, 30, Color( 0, 0, 0, 230 ) )
	draw.RoundedBox(0, 10, Scrh - HUDHeight - 34, HUDWidth, 110, Color( 0, 0, 0, 230 ) )
	draw.RoundedBox(0, 10, Scrh - HUDHeight + 77, HUDWidth, 30, Color( 0, 0, 0, 230 ) )

	--draw.RoundedBox(2, 20, 20, 530, 30, Color( 0, 0, 0, 140 ) )
	--draw.DrawText("Apex Roleplay was founded one year ago today. Happy anniversary! | Double XP has been activated.", "NameFont", 27, 29, Color(255, 255, 255, 255), 0)


	DrawName()
	DrawInfo()
	DrawWarning()
	DrawPlayerModel()
	DrawVoiceChat()
	LockDown()

	Arrested()
	AdminTell()

	DrawSide()
end

/*---------------------------------------------------------------------------
Entity HUDPaint things
---------------------------------------------------------------------------*/
local function DrawPlayerInfo(ply)
	local pos = ply:EyePos()

	pos.z = pos.z + 5 -- The position we want is a bit above the position of the eyes
	pos = pos:ToScreen()
	pos.y = pos.y - 50 -- Move the text up a few pixels to compensate for the height of the text

	if GAMEMODE.Config.showname and not ply:getDarkRPVar("wanted") and ply:GetNoDraw() == true then return else
	--	draw.DrawText(ply:Nick(), "TargetID", pos.x + 1, pos.y + 1, Color(0, 0, 0, 255), 1)
		draw.DrawText(ply:Nick(), "TargetID", pos.x, pos.y, team.GetColor(ply:Team()), 1)
	--	draw.DrawText(DarkRP.getPhrase("health", ply:Health()), "DarkRPHUD2", pos.x + 1, pos.y + 21, Color(0, 0, 0, 255), 1)
	--	draw.DrawText(DarkRP.getPhrase("health", ply:Health()), "DarkRPHUD2", pos.x, pos.y + 20, Color(255,255,255,200), 1)
		--end
	end

	if ply:Health() < 35 then
		draw.DrawText("Seriously injured", "DermaDefaultBold", pos.x + 1, pos.y + 12, Color(204, 0, 0, 255), 1)        
        elseif ply:Health() < 70 then
		draw.DrawText("Injured", "DermaDefaultBold", pos.x + 1, pos.y + 12, Color(255, 153, 51, 255), 1)
	end

	if ply:getDarkRPVar("HasGunlicense") then
		surface.SetMaterial(Page)
		surface.SetDrawColor(255,255,255,255)
		surface.DrawTexturedRect(pos.x-16, pos.y + 60, 32, 32)
	end
end

/*---------------------------------------------------------------------------
The Entity display: draw HUD information about entities
---------------------------------------------------------------------------*/
local function DrawEntityDisplay()
	local shouldDraw = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_EntityDisplay")
	if shouldDraw == false then return end

	local shootPos = localplayer:GetShootPos()
	local aimVec = localplayer:GetAimVector()

	for k, ply in pairs(player.GetAll()) do
		if not ply:Alive() then continue end
		local hisPos = ply:GetShootPos()
		if ply:getDarkRPVar("wanted") then DrawWantedInfo(ply) end

		if GAMEMODE.Config.globalshow and ply ~= localplayer then
			DrawPlayerInfo(ply)
		-- Draw when you're (almost) looking at him
		elseif not GAMEMODE.Config.globalshow and hisPos:Distance(shootPos) < 400 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()
			if unitPos:Dot(aimVec) > 0.95 then
				local trace = util.QuickTrace(shootPos, pos, localplayer)
				if trace.Hit and trace.Entity ~= ply then return end
				if not ply:FAdmin_GetGlobal("FAdmin_cloaked") then
					DrawPlayerInfo(ply)
				end
			end
		end
	end

	local tr = localplayer:GetEyeTrace()

	if IsValid(tr.Entity) and tr.Entity:IsOwnable() and tr.Entity:GetPos():Distance(localplayer:GetPos()) < 200 then
		tr.Entity:DrawOwnableInfo()
	end
end

local function DrawDead()

	local function RecvMyUmsg( data )
		deathcause = data:ReadString() or "";
	end
	usermessage.Hook( "KilledBy", RecvMyUmsg);

	if not deathcause then
		deathcause = ""
	end

	if LocalPlayer():Alive() == false then



		if spawntime == nil then spawntime = 30 end
		draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(10,10,10,200))
		draw.RoundedBox(0, ScrW() /2 - 200, ScrH() /2 - 10, 400, 100, Color(0, 0, 0, 252))
		draw.DrawText("YOU ARE DEAD!", "DermaLarge", ScrW() / 2, ScrH() / 2, Color(255,255,255),TEXT_ALIGN_CENTER)
		draw.DrawText("You were killed by " .. deathcause, "DermaDefault", ScrW() / 2, ScrH() / 2 + 35, Color(255,255,255),TEXT_ALIGN_CENTER)


		if sspawntime == 1 then
			draw.DrawText("Click your mouse to respawn", "DermaDefault", ScrW() / 2, ScrH() / 2 + 55, Color(255,255,255),TEXT_ALIGN_CENTER)
		else
			draw.DrawText("You are able to respawn in "..spawntime.." seconds", "DermaDefault", ScrW() / 2, ScrH() / 2 + 55, Color(255,255,255),TEXT_ALIGN_CENTER)
		end

		function HideThings( name )
        if (name == "CHudCrosshair" ) then
        return false
        end
	if (name == "CHudDamageIndicator" ) then
		if LocalPlayer():Alive() == false then
		return false else return true
		end
	else
	--	spawntime = 0
	end
end
hook.Add( "HUDShouldDraw", "HideThings", HideThings )

	end
end

function DrawScanner(entity)

	local PICTURE_WIDTH, PICTURE_HEIGHT = 580, 420
	local PICTURE_WIDTH2, PICTURE_HEIGHT2 = PICTURE_WIDTH * 0.5, PICTURE_HEIGHT * 0.5

	local view = {}
	local zoom = 0
	local deltaZoom = zoom
	local nextClick = 0

	local scrW, scrH = surface.ScreenWidth() * 0.5, surface.ScreenHeight() * 0.5
			local x, y = scrW - PICTURE_WIDTH2, scrH - PICTURE_HEIGHT2

			local position = entity:GetPos()
			local angle = LocalPlayer():GetAimVector():Angle()

			draw.SimpleText("POS ("..math.floor(position[1])..", "..math.floor(position[2])..", "..math.floor(position[3])..")", "nutScannerFont", x + 8, y + 8, color_white)
			draw.SimpleText("ANG ("..math.floor(angle[1])..", "..math.floor(angle[2])..", "..math.floor(angle[3])..")", "nutScannerFont", x + 8, y + 24, color_white)
			draw.SimpleText("ID  ("..LocalPlayer():Name()..")", "nutScannerFont", x + 8, y + 40, color_white)
		--	draw.SimpleText("ZM  ("..(math.Round(zoom / 40, 2) * 100).."%)", "nutScannerFont", x + 8, y + 56, color_white)

			surface.SetDrawColor(235, 235, 235, 230)

			surface.DrawLine(0, scrH, x - 128, scrH)
			surface.DrawLine(scrW + PICTURE_WIDTH2 + 128, scrH, ScrW(), scrH)
			surface.DrawLine(scrW, 0, scrW, y - 128)
			surface.DrawLine(scrW, scrH + PICTURE_HEIGHT2 + 128, scrW, ScrH())

			surface.DrawLine(x, y, x + 128, y)
			surface.DrawLine(x, y, x, y + 128)
--
			x = scrW + PICTURE_WIDTH2

			surface.DrawLine(x, y, x - 128, y)
			surface.DrawLine(x, y, x, y + 128)

			x = scrW - PICTURE_WIDTH2
			y = scrH + PICTURE_HEIGHT2

			surface.DrawLine(x, y, x + 128, y)
			surface.DrawLine(x, y, x, y - 128)

			x = scrW + PICTURE_WIDTH2

			surface.DrawLine(x, y, x - 128, y)
			surface.DrawLine(x, y, x, y - 128)

			surface.DrawLine(scrW - 48, scrH, scrW - 8, scrH)
			surface.DrawLine(scrW + 48, scrH, scrW + 8, scrH)
			surface.DrawLine(scrW, scrH - 48, scrW, scrH - 8)
			surface.DrawLine(scrW, scrH + 48, scrW, scrH + 8)
end

/*---------------------------------------------------------------------------
Actual HUDPaint hook
---------------------------------------------------------------------------*/
function GM:HUDPaint()
		local entity = LocalPlayer():GetViewEntity()

		if (IsValid(entity) and entity:GetClass():find("scanner")) then
			DrawScanner(entity)
		end
	DrawHUD()
	DrawEntityDisplay()

	self.BaseClass:HUDPaint()
	DrawDead()
end

	hl2rp.util = hl2rp.util or {}

function hl2rp.util.getMaterial(materialPath)
	-- Cache the material.
	hl2rp.util.cachedMaterials = hl2rp.util.cachedMaterials or {}
	hl2rp.util.cachedMaterials[materialPath] = hl2rp.util.cachedMaterials[materialPath] or Material(materialPath)

	return hl2rp.util.cachedMaterials[materialPath]
end

	HL2RP_CVAR_CHEAP = CreateClientConVar("hl2rp_cheapblur", 0, true)

	local useCheapBlur = HL2RP_CVAR_CHEAP:GetBool()
	local blur = hl2rp.util.getMaterial("pp/blurscreen")

	cvars.AddChangeCallback("hl2rp_cheapblur", function(name, old, new)
		useCheapBlur = (tonumber(new) or 0) > 0
	end)

	-- Draws a blurred material over the screen, to blur things.
	function hl2rp.util.drawBlur(panel, amount, passes)
		-- Intensity of the blur.
		amount = amount or 5

		if (useCheapBlur) then
			surface.SetDrawColor(50, 50, 50, amount * 20)
			surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
		else
			surface.SetMaterial(blur)
			surface.SetDrawColor(255, 255, 255)

			local x, y = panel:LocalToScreen(0, 0)

			for i = -(passes or 0.2), 1, 0.2 do
				-- Do things to the blur material to make it blurry.
				blur:SetFloat("$blur", i * amount)
				blur:Recompute()

				-- Draw the blur material over the screen.
				render.UpdateScreenEffectTexture()
				surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
			end
		end
	end

	function hl2rp.util.drawBlurAt(x, y, w, h, amount, passes)
		-- Intensity of the blur.
		amount = amount or 5

		if (useCheapBlur) then
			surface.SetDrawColor(30, 30, 30, amount * 20)
			surface.DrawRect(x, y, w, h)
		else
			surface.SetMaterial(blur)
			surface.SetDrawColor(255, 255, 255)

			local scrW, scrH = ScrW(), ScrH()
			local x2, y2 = x / scrW, y / scrH
			local w2, h2 = (x + w) / scrW, (y + h) / scrH

			for i = -(passes or 0.2), 1, 0.2 do
				blur:SetFloat("$blur", i * amount)
				blur:Recompute()

				render.UpdateScreenEffectTexture()
				surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
			end
		end
	end
