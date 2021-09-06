-- How to use:
-- If a player uses /afk, they go into AFK mode, they will not be autofired and their salary is set to $0 (you can still be killed/vote fired though!).
-- If a player does not use /afk, and they don't do anything for the fire time specified, they will be automatically fired to hobo.

local function AFKDemote(ply)
	local rpname = ply:Nick()

		GAMEMODE:NotifyAll(0, 5, rpname .. " is now AFK.")
end

local function SetAFK(ply)
ServerPlayers = 0
	ply:SetDarkRPVar("AFK", not ply:getDarkRPVar("AFK"))

	if ply:getDarkRPVar("AFK") then

for k, v in pairs(player.GetAll()) do
   ServerPlayers = ServerPlayers + 1
end
		DB.RetrieveSalary(ply, function(amount) ply.OldSalary = amount end)
	--	ply.OldJob = ply:getDarkRPVar("job")
		ply:ChatPrint("Seems like you are AFK, you will not get any salary/XP before you are back." )
		GAMEMODE:NotifyAll(0, 5, ply:Nick() .. " is now AFK.")
		ply:SetDarkRPVar("salary", 0)
if ServerPlayers > 60 then
ply:Kick("AFK on full server.")
elseif ply:IsCP() then
ply:ChangeTeam( TEAM_CITIZEN, true )
ply:ConCommand("say /adminhelp AUTOMATED MESSAGE: I was demoted for being AFK as CP.")


end
	else
		GAMEMODE:NotifyAll(1, 5, ply:Nick() .. " is no longer AFK.")
		ply:ChatPrint("You are not AFK anymore, you should be starting to get salary/XP again." )
		ply:SetDarkRPVar("salary", ply.OldSalary or 0)
		GAMEMODE:Notify(ply, 0, 5, "Welcome back, your salary has now been restored.")
	end
	--ply:SetDarkRPVar("job", ply:getDarkRPVar("AFK") and "AFK" or ply.OldJob)
	--ply:SetDarkRPVar("salary", ply:getDarkRPVar("AFK") and 0 or ply.OldSalary or 0)
end
AddChatCommand("/afk", SetAFK)

local function StartAFKOnPlayer(ply)
	ply.AFKDemote = CurTime() + GAMEMODE.Config.afkfiretime


end
hook.Add("PlayerInitialSpawn", "StartAFKOnPlayer", StartAFKOnPlayer)






local function AFKTimer(ply, key)
	if ply:getDarkRPVar("AFK") then
		ply:SetDarkRPVar("AFK", false)
		ply:SetDarkRPVar("salary", ply.OldSalary or 0)
		ply:ChatPrint("You are not AFK anymore, you should be starting to get salary/XP again." )
		GAMEMODE:NotifyAll(1, 5, ply:Nick() .. " is no longer AFK.")
	end
	ply.AFKDemote = CurTime() + GAMEMODE.Config.afkfiretime
end
hook.Add("KeyPress", "DarkRPKeyReleasedCheck", AFKTimer)

local function KillAFKTimer()
	for id, ply in pairs(player.GetAll()) do
		if ply.AFKDemote and CurTime() > ply.AFKDemote and not ply:getDarkRPVar("AFK") then
			SetAFK(ply)
			AFKDemote(ply)
			ply.AFKDemote = math.huge
		end
	end
end
hook.Add("Think", "DarkRPKeyPressedCheck", KillAFKTimer)
