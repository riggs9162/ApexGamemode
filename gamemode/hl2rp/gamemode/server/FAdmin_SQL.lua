/*---------------------------------------------------------------------------
Create the tables used for banning
---------------------------------------------------------------------------*/
hook.Add("DatabaseInitialized", "FAdmin_CreateMySQLTables", function()
	MySQL.query("CREATE TABLE IF NOT EXISTS FAdminBans(SteamID VARCHAR(25) NOT NULL PRIMARY KEY, Nick VARCHAR(40), BanDate DATETIME, UnbanDate DATETIME, Reason VARCHAR(100), AdminName VARCHAR(40), Admin_steam VARCHAR(25));", function()

		hook.Call("FAdmin_RetrieveBans", nil)
	end)
end)

/*---------------------------------------------------------------------------
Store a ban in the MySQL tables
---------------------------------------------------------------------------*/
hook.Add("FAdmin_StoreBan", "MySQLBans", function(SteamID, Nick, Duration, Reason, AdminName, Admin_steam)
	local steam = MySQL.SQLStr(SteamID)
	local nick = Nick and MySQL.SQLStr(Nick) or "NULL"
	local bandate = MySQL.CONNECTED_TO_MYSQL and "NOW()" or "datetime('now')"
	local reason = Reason and MySQL.SQLStr(Reason) or "NULL"
	local admin = AdminName and MySQL.SQLStr(AdminName) or "NULL"
	local adminsteam = Admin_steam and MySQL.SQLStr(Admin_steam) or "NULL"

	local duration
	if MySQL.CONNECTED_TO_MYSQL then
		duration = Duration == 0 and "NULL" or "DATE_ADD(NOW(), INTERVAL ".. tonumber(Duration or 60) .. " MINUTE)"
	else
		duration = Duration == 0 and "NULL" or "datetime('now', '+".. tonumber(Duration or 60) .. " minutes')"
	end

	MySQL.query("REPLACE INTO FAdminBans VALUES(".. steam .. ", ".. nick .. ", " .. bandate .. ", " .. duration .. ", ".. reason .. ", ".. admin .. ", ".. adminsteam .. ");")

	return true
end)

/*---------------------------------------------------------------------------
Unban someone
---------------------------------------------------------------------------*/
hook.Add("FAdmin_UnBan", "FAdmin_MySQLUnban", function(ply, steamID)
	MySQL.query("DELETE FROM FAdminBans WHERE steamID = ".. MySQL.SQLStr(steamID))
end)

/*---------------------------------------------------------------------------
Retrieve the bans from the MySQL server and put them into effect

Note: Must be called more than two seconds after InitPostEntity, because
thats when the database initializes
---------------------------------------------------------------------------*/
hook.Add("FAdmin_RetrieveBans", "getMySQLBans", function()
	FAdmin.BANS = FAdmin.BANS or {}

	-- Small SQLite and MySQL syntax difference
	local diffSeconds = MySQL.CONNECTED_TO_MYSQL and "TIMESTAMPDIFF(SECOND, NOW(), UnbanDate)" or
		"strftime('%s', UnbanDate) - strftime('%s','now')"

	local now = MySQL.CONNECTED_TO_MYSQL and "NOW()" or "datetime('now')"

	MySQL.query("SELECT SteamID, Nick, " .. diffSeconds .. " AS duration, Reason, AdminName, Admin_steam FROM FAdminBans WHERE (UnbanDate > " .. now .. " OR UnbanDate IS NULL);", function(data)
		if not data then return end

		for k, v in pairs(data) do
			if tonumber(v.SteamID) or not v.SteamID then continue end
			local duration = (not v.duration or v.duration == "NULL") and 0 or (os.time() + v.duration)

			FAdmin.BANS[string.upper(v.SteamID)] = {
				time = duration,
				name = v.Nick,
				reason = v.Reason,
				adminname = v.AdminName,
				adminsteam = v.Admin_steam
			}

			--game.ConsoleCommand("banid ".. duration * 60 .." " .. v.SteamID.. " kick\n")
		end
	end)
end)