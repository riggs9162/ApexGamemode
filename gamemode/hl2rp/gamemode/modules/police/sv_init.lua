local plyMeta = FindMetaTable("Player")
local finishWarrantRequest
local arrestedPlayers = {}

/*---------------------------------------------------------------------------
Interface functions
---------------------------------------------------------------------------*/
function plyMeta:warrant(warranter, reason)	if self.warranted then return end

end

function plyMeta:unWarrant(unwarranter)

end

function plyMeta:requestWarrant(suspect, actor, reason)

end

function plyMeta:wanted(actor, reason)

end

function plyMeta:unWanted(actor)

end

function plyMeta:arrest(time, arrester)
	time = time or GAMEMODE.Config.jailtimer or 120

	hook.Call("playerArrested", DarkRP.hooks, self, time, arrester)
	self:SetDarkRPVar("Arrested", true)
	arrestedPlayers[self:SteamID()] = true

	-- Always get sent to jail when Arrest() is called, even when already under arrest
	if GAMEMODE.Config.teletojail and DB.CountJailPos() ~= 0 then
		self:Spawn()
	end
end

function plyMeta:unArrest(unarrester)
	if not self:isArrested() then return end



	self:SetDarkRPVar("Arrested", false)
	arrestedPlayers[self:SteamID()] = nil

                self:CleanUpRHC(true)
	hook.Call("playerUnArrested", DarkRP.hooks, self)
end

/*---------------------------------------------------------------------------
Chat commands
---------------------------------------------------------------------------*/
local function CombineRequest(ply, args)
	if args == "" then
		GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local t = ply:Team()

	local DoSay = function(text)
		if text == "" then
			GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
			return
		end
		for k, v in pairs(player.GetAll()) do
			if v:IsCP() or v == ply then
				GAMEMODE:TalkToPerson(v, team.GetColor(ply:Team()), DarkRP.getPhrase("request") ..ply:Nick(), Color(255,0,0,255), text, ply)
			end
		end
	end
	return args, DoSay
end
AddChatCommand("/ccp", CombineRequest, 1.5)


/*---------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------*/
function DarkRP.hooks:playerArrested(ply, time, arrester)
	if ply:isWanted() then ply:unWanted(arrester) end
	ply:unWarrant(arrester)
	ply:SetSelfDarkRPVar("HasGunlicense", false)

	-- UpdatePlayerSpeed won't work here as the "Arrested" DarkRPVar is set AFTER this hook
	GAMEMODE:SetPlayerSpeed(ply, GAMEMODE.Config.arrestspeed, GAMEMODE.Config.arrestspeed)
	ply:StripWeapons()

	if ply:isArrested() then return end -- hasn't been arrested before

/*	ply:PrintMessage(HUD_PRINTCENTER, DarkRP.getPhrase("youre_arrested", time))
	for k, v in pairs(player.GetAll()) do
		if v == ply then continue end
		v:PrintMessage(HUD_PRINTCENTER, DarkRP.getPhrase("hes_arrested", ply:Name(), time))
	end

	local steamID = ply:SteamID()
	timer.Create(ply:UniqueID() .. "jailtimer", time, 1, function()
		if IsValid(ply) then ply:unArrest() end
		arrestedPlayers[steamID] = nil
	end)
	umsg.Start("GotArrested", ply)
		umsg.Float(time)
	umsg.End() */
	ply:notify("You have been arrested!")
end

function DarkRP.hooks:playerUnArrested(ply, actor)
	if ply.Sleeping and GAMEMODE.KnockoutToggle then
		GAMEMODE:KnockoutToggle(ply, "force")
	end

	-- "Arrested" DarkRPVar is set to false BEFORE this hook however, so it is safe here.
	hook.Call("UpdatePlayerSpeed", GAMEMODE, ply)
	GAMEMODE:PlayerLoadout(ply)
	if GAMEMODE.Config.telefromjail and (not FAdmin or not ply:FAdmin_GetGlobal("fadmin_jailed")) then
		local _, pos = GAMEMODE:PlayerSelectSpawn(ply)
		ply:SetPos(pos)
	elseif FAdmin and ply:FAdmin_GetGlobal("fadmin_jailed") then
		ply:SetPos(ply.FAdminJailPos)
	end

	timer.Destroy(ply:SteamID() .. "jailtimer")
	ply:notify("You have been unarrested!")
	--GAMEMODE:NotifyAll(0, 4, DarkRP.getPhrase("hes_unarrested", ply:Name()))
end

hook.Add("PlayerInitialSpawn", "Arrested", function(ply)
	if not arrestedPlayers[ply:SteamID()] then return end
	local time = GAMEMODE.Config.jailtimer
	ply:arrest(time)
	GAMEMODE:Notify(ply, 0, 5, DarkRP.getPhrase("jail_punishment", time))
end)
