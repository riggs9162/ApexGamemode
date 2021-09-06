


--APIKey required to deal with those family sharing.
--You may obtain your Steam API Key from here | http://steamcommunity.com/dev/apikey
APIKey = ""

--The message displayed to those who connect by a family shared account that has been banned.
kickmessage = "The account that lent you Garry's Mod is banned on this server. Boo hoo. :("

--Ban those who try to bypass a current ban by returning on a family shared account.
--Set true to enable | false to disable.
--If this is set to false it will only kick those bypassing bans.
banbypass = true

--The length to ban those who are trying to bypass a current / existing ban.
--This will also increase/change the ban length on the account that owns Garry's Mod. (They shouldn't attempt to bypass a current ban.)
--time is in minutes.
--0 is permanent.
banlength = 0

--The reason the player has been banned automaticly for connecting from a family shared account that already has a ban.
banreason = "attempting to bypass a current/existing ban."

--Enable banning users by IP address too.
--Makes it even harder for continuous offenders to return to the server.
--Set true to enable | false to disable.
banip = false

--Enable blocking anyone joining on a family shared account regardless if they are banned or not.
--Enabling this will allow only accounts that have bought and own Garry's Mod to join.
--Set true to enable | false to disable.
blockfamilysharing = false

--The message to display to those who have been blocked by "blockfamilysharing".
blockfamilysharingmessage = "Please connect to the server by a account that own's Garry's Mod."



--Makes the default ULX banned message more informative and pretty.
--Set true to enable | false to disable.
informative_ban_message = false

--The custom banned message to display to those who are banned.
--\n is for a new line.
custom_ban_message = "You're banned! \n\n Visit www.apex-roleplay.com to appeal it."



--Function to handle those who connect via family shared steam accounts.
local function HandleSharedPlayer(ply, lenderSteamID)
	--Log to server console who has been detected family sharing.
	print(string.format("FamilySharing: %s | %s has been lent Garry's Mod by %s",
		ply:Nick(),
		ply:SteamID(),
		lenderSteamID
	))


	if GExtension:IsBanned(lenderSteamID) then
			--Kick the player.
			ply:Kick(kickmessage)
		end
	end



local function CheckFamilySharing(ply)
	http.Fetch(
	string.format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000",
		APIKey,
		ply:SteamID64()
	),

	function(body)
		--Put the http response into a table.
		local body = util.JSONToTable(body)

		--If the response does not contain the following table items.
		if not body or not body.response or not body.response.lender_steamid then
			error(string.format("FamilySharing: Invalid Steam API response for %s | %s\n", ply:Nick(), ply:SteamID()))
		end

		--Set the lender to be the lender in our body response table.
		local lender = body.response.lender_steamid
		--If the lender is not 0 (Would contain SteamID64). Lender will only ever == 0 if the account owns the game.
		if lender ~= "0" then
			--Handle the player that is on a family shared account to decide their fate.
			HandleSharedPlayer(ply, util.SteamIDFrom64(lender))
		end
	end,

	function(code)
		error(string.format("FamilySharing: Failed API call for %s | %s (Error: %s)\n", ply:Nick(), ply:SteamID(), code))
	end
	)
end
hook.Add("PlayerAuthed", "CheckFamilySharing", CheckFamilySharing)
