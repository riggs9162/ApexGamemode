function RappelUse(player)
if player.CMDCD4 and player.CMDCD4 > CurTime() then return end
player.CMDCD4 = CurTime() + 3
if player.IsRappeling then return end
	if player:IsCP() then
if player:GetModel()=="models/dpfilms/metropolice/playermodels/pm_hdpolice.mdl" then return player:notify("Get a rank first.") end
if player:GetModel()=="models/player/soldier_stripped.mdl" then return player:notify("Get a rank first.") end
if player:Team()==TEAM_ADMINISTRATOR then return player:notify("You're the CA, not spiderman.") end
		local playerweapon = player:GetActiveWeapon():GetClass()

		if ( playerweapon ~= "weapon_physgun" or playerweapon ~= "weapon_physcannon" or playerweapon ~= "gmod_tool") then

			if player:OnGround() then

				if PlayerRappel then

 					return PlayerRappel(player,entity,self)

 				end

 			else

 				player:notify("You can't rappel whilst falling.");

 				return false;

			end

    	else

        	player:notify("Don't rappel with the physgun or toolgun.");

        	return false;

		end

	else

		player:notify("You are unable to use this!");

		return false;

	end

end



concommand.Add("hl2rp_rappel",RappelUse)
