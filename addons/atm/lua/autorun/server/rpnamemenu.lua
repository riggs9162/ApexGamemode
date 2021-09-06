// Made by Tomasas http://steamcommunity.com/id/tomasas/

local BlackList = {"nigga", "fag", "gayboy", "penis", "lol", "swag", "yolo", "420", "hack", "cock", "monkey", "dog", "admin", "poop", "nigger", "Gordon Freeman", "meme", "BBC"} //simply insert a name encased in quotes and seperate it with a comma

concommand.Add("c_rpname", function(ply, cmd, args)

	if !ply.ForcedNameChange and (!ply.DarkRPVars or ply.DarkRPVars and (ply.DarkRPVars.rpname and ply.DarkRPVars.rpname != ply:SteamName() and ply.DarkRPVars.rpname != "NULL")) then return end
	
	for i=1, #BlackList do
		if string.find(string.lower(args[1]), string.lower(BlackList[i])) then
			umsg.Start("_Notify", ply)
				umsg.String("This name not allowed!")
				umsg.Short(1)
				umsg.Long(10)
			umsg.End()
			umsg.Start("openRPNameMenu", ply)
			umsg.End()
			return
		end
	end
	
DB.RetrieveRPNames(ply, args[1], function(taken)
/*			if taken and ply:IsValid() then
			umsg.Start("_Notify", ply)
				umsg.String("This name is already being used!")
				umsg.Short(1)
				umsg.Long(10)
			umsg.End()
			umsg.Start("openRPNameMenu", ply)
			umsg.End() */
--		elseif 
		if ply:IsValid() then
			ply.ForcedNameChange = nil
			DB.StoreRPName(ply, args[1])
		end
	end)
end)


hook.Add("PlayerAuthed", "RPNameChecking", function(ply)
	timer.Simple(9, function() //let darkrp load their name before checking
		if !ply:IsValid() then return end
		if ply.DarkRPVars and (!ply.DarkRPVars.rpname or ply.DarkRPVars.rpname == ply:SteamName() or ply.DarkRPVars.rpname == "NULL") then
			umsg.Start("openRPNameMenu", ply)
			umsg.End()
		end
	end) 
end)
//©Tomasas 2013