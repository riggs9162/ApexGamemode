local deathSounds = {
	Sound("npc/metropolice/die1.wav"),
	Sound("npc/metropolice/die2.wav"),
	Sound("npc/metropolice/die3.wav")
}

local fireSounds = {
	Sound("npc/metropolice/fire_scream1.wav "),
	Sound("npc/metropolice/fire_scream2.wav "),
	Sound("npc/metropolice/fire_scream3.wav ")
}

local hurtSounds = {
	Sound("npc/metropolice/pain1.wav"),
	Sound("npc/metropolice/pain2.wav"),
	Sound("npc/metropolice/pain3.wav")
}

local vorthurtSounds = {
	Sound("vo/npc/vortigaunt/vortigese07.wav"),
	Sound("vo/npc/vortigaunt/vortigese04.wav"),
	Sound("vo/npc/vortigaunt/vortigese03.wav")
}

local citizenpainSounds = {

	Sound("vo/npc/male01/pain01.wav"),
	Sound("vo/npc/male01/pain02.wav"),
	Sound("vo/npc/male01/pain03.wav"),
	Sound("vo/npc/male01/pain04.wav"),
	Sound("vo/npc/male01/pain05.wav"),
	Sound("vo/npc/male01/pain06.wav"),
	Sound("vo/npc/male01/pain07.wav"),
	Sound("vo/npc/male01/pain08.wav"),
	Sound("vo/npc/male01/pain09.wav")

}


function deathsound(client, inflictor, attacker)
                if client:IsCP() then
	client:SetDarkRPVar("Division", 0)
	local plySteamID = client:SteamID64()
	if IsValid(CPMenuPlyTable)then
		CPMenuPlyTable[plySteamID]["Division"] = 0;
		CPMenuPlyTable[plySteamID]["Rank"] = 0;
	end

	client:SetDarkRPVar( "Division", 0)
	client:SetDarkRPVar( "Rank", 0)

// Overwatch:
	client:SetDarkRPVar("Division", 0)
	local plySteamID = client:SteamID64()

	if IsValid(OWMenuPlyTable)then
		OWMenuPlyTable[plySteamID]["OWDivision"] = 0;
		OWMenuPlyTable[plySteamID]["OWRank"] = 0;
	end

	client:SetDarkRPVar( "OWDivision", 0)
	client:SetDarkRPVar( "OWRank", 0)
 end
	if client:IsCP() and attacker == "env_fire" then
	    local fireSound = hook.Run("GetPlayerDeathFireSound", client) or table.Random(fireSounds)
		client:EmitSound(fireSound)
	end

	if client:IsCP() and attacker == "entityFlame" then
	    local fireSound = hook.Run("GetPlayerDeathFireSound", client) or table.Random(fireSounds)
		client:EmitSound(fireSound)
	end


	if client:IsCP() and attacker == "entityflame" then
	    local fireSound = hook.Run("GetPlayerDeathFireSound", client) or table.Random(fireSounds)
		client:EmitSound(fireSound)
	end

	if client:IsCP() then
	    local deathSound = hook.Run("GetPlayerDeathSound", client) or table.Random(deathSounds)
		client:EmitSound(deathSound)
	end

end
hook.Add("PlayerDeath", "myhook323", deathsound)
function pain(client, attacker, health, damage)
if client:IsCP() and damage > 3 then
	    local hurtSound = hook.Run("GetPlayerPainSound", client) or table.Random(hurtSounds)
		client:EmitSound(hurtSound)
end

if client:Team() == TEAM_VORT and damage > 3 then
	    local hurtvortSound = hook.Run("GetPlayerPainSound", client) or table.Random(vorthurtSounds)
		client:EmitSound(hurtvortSound)
else

if damage > 3 then
	    local painSound = hook.Run("GetPlayerCitizenPainSound", client) or table.Random(citizenpainSounds)
		client:EmitSound(painSound)
	end
end

end
hook.Add("PlayerHurt", "myhook43", pain)
