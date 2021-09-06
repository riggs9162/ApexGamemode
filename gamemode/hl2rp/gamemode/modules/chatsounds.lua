
-- This module will make voice sounds play when certain words are typed in the chat
-- You can add/remove sounds as you wish, just follow the format used here
-- To disble them completey, use the command rp_chatsounds 0 or delete this file.
-- TODO: Add female sounds & detect gender of model, Use combine sounds for CPs.

-- DaCoolboy: I sorted the entries alphabetically for better overview
-- Sorry for messing up custom entries, you can now add them near the end of the file

local function LocalOOC(ply, args)
    local DoSay = function(text)
        if text == "" then return "" end
		for v,k in pairs(ents.FindInSphere(ply:GetPos(),300)) do
		if k:IsPlayer() then
		k:ApexChat([[Color( 200, 0, 0 ), "[LOOC] ", prefixc, steamNAME, teamCOL, " (", plyNAME, ")", ": ", Color( 255, 220, 220 ), message]], ply, args)
		end
		end
    end
    return args, DoSay
end
AddChatCommand("///", LocalOOC)
AddChatCommand(".//", LocalOOC)
AddChatCommand("/looc", LocalOOC)
AddChatCommand("/local", LocalOOC)

local function Roll( ply, args )
	local DoSay = function( text )

		local roll = math.random( 0, 100 )
		local col = team.GetColor(ply:Team())
		local col2 = Color(255,255,255,255)
		 	GAMEMODE:TalkToRange(ply, "** " .. ply:Nick() .. " rolled " .. roll .. " out of 100.", "", 300)
	end
	return args, DoSay
end
AddChatCommand("/roll", Roll, true, 1.5)

local function ShowID(ply, args)
	/*if args == "" then
		GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end*/

	local DoSay = function(text)
		/*if text == "" then
			GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
			return ""
		end*/
		if GAMEMODE.Config.alltalk then
			for _, target in pairs(player.GetAll()) do
				GAMEMODE:TalkToPerson(target, team.GetColor(ply:Team()), ply:Nick() .. " " .. text)
			end
		else
			--local currentteamname = ply:Team()
			local currentteamname = ply:getDarkRPVar("job")
			GAMEMODE:TalkToRange(ply, ply:Nick() .. " shows their ID containing: Name: " .. ply:GetName() .. " Job: " .. currentteamname, "", 250)
		end
	end
	return args, DoSay
end
AddChatCommand("/apply", ShowID, 1.5)

local function Mes(ply, args)
	if args == "" then return "" end

	local DoSay = function(text)
		if text == "" then return "" end
		if GAMEMODE.Config.alltalk then
			for _, target in pairs(player.GetAll()) do
				GAMEMODE:TalkToPerson(target, team.GetColor(ply:Team()), ply:Nick() .. "" .. text)
			end
		else
			GAMEMODE:TalkToRange(ply, ply:Nick() .. "'s " .. text, "", 250)
		end
	end
	return args, DoSay
end
AddChatCommand("/mes", Mes)

local function It(ply, args)
	if args == "" then return "" end

	local DoSay = function(text)
		if text == "" then return "" end
		if GAMEMODE.Config.alltalk then
			for _, target in pairs(player.GetAll()) do
				GAMEMODE:TalkToPerson(target, (ply:Team()), ply:Nick() .. " " .. text)
			end
		else
		for v,k in pairs(ents.FindInSphere(ply:GetPos(),250)) do
		if k:IsPlayer() then
		k:ApexChat([[Color(253,0,0), "**** ", message]], ply, args)
		end
		end
		end
	end
	return args, DoSay
end
AddChatCommand("/it", It, 1.5)
