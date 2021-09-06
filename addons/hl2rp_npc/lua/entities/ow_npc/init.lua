AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files

AddCSLuaFile( "shared.lua" )



include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.





function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.



	self:SetModel( "models/Combine_Super_Soldier.mdl" ) -- Sets the model of the NPC.

	self:SetHullType( HULL_HUMAN ) -- Sets the hull type, used for movement calculations amongst other things.

	self:SetHullSizeNormal( )

	self:SetNPCState( NPC_STATE_IDLE )

	self:SetSolid(  SOLID_BBOX ) -- This entity uses a solid bounding box for collisions.

	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD ) -- Adds what the NPC is allowed to do ( It cannot move in this case ).

	self:SetUseType( SIMPLE_USE ) -- Makes the ENT.Use hook only get called once at every use.

	self:DropToFloor()

	self:SetPersistent( false )

	self:SetMaxYawSpeed( 90 ) --Sets the angle by which an NPC can rotate at once.



end



function ENT:OnTakeDamage()

	return false -- This NPC won't take damage from anything.

end



function ENT:AcceptInput( Name, Activator, Caller )



	if Name == "Use" and Caller:IsPlayer() then

		if not Caller:HasWeapon("weaponchecker")then

			if not string.match(Caller:Nick(), "OTA") then

				Caller:SetPData( "cname", Caller:Nick() )

			end

		end

		if Caller:Team() == TEAM_OVERWATCH then

			umsg.Start("OWShopNPCUsed", Caller) -- Prepare the usermessage to that same player to open the menu on his side.

			umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.

		else

			Caller:notify("You are not a member of the Overwatch Transhuman Arm." )



		end

	end



end



function giveWeapons(ply, weapons)
	
	for i, weapon in ipairs(weapons) do

		ply:Give(weapon)

	end

end



concommand.Add( "rp_owDivision", function( ply, cmd, args )



	local SteamID = ply:SteamID64()



	if OWMenuPlyTable == nil then

		OWMenuPlyTable = {}

--	print("OW Table Created")

end



if OWMenuPlyTable[SteamID] == nil then

	OWMenuPlyTable[SteamID] = {}

--	print("PLY Table Created")

end



if not ply:IsAdmin() then



	if ply:getDarkRPVar("LastOWSet") and 120 - (CurTime() - ply:getDarkRPVar("LastOWSet")) >= 0 then

		ply:notify("You must wait ".. math.ceil(120 - (CurTime() - ply:getDarkRPVar("LastOWSet"))) .. " second('s) before changing Rank or Division.")

		return false

	end



end



for id, ent in pairs( ents.FindInSphere( ply:GetPos(), 64 ) ) do

	if ( ent:GetClass() == "ow_npc" ) then



		if args[1] and args[2]then

			local OWRankID = tonumber(args[1])

			local OWDivisionID = tonumber(args[2])

			if OWRanks[OWRankID] and OWDivisions[OWDivisionID] and ply:Team() == TEAM_OVERWATCH then



				local RankInfo = OWRanks[OWRankID]

				local OWDivisionInfo = OWDivisions[OWDivisionID]



				local PlayerXP = ply:GetNetworkedInt( "Xp" )

				print(PlayerXP)

				local jobdelay = 120



--print(tostring(ply:GetPData("LastOWSet")))



if ply:IsAdmin() or (RankInfo.xp <= PlayerXP) then

				--			print("Rank Enough XP")

			else

				ply:notify("You do not have enough XP to be this rank.")

				return false

			end



			if ply:IsAdmin() or (OWDivisionInfo.xp <= PlayerXP)then

				--			print("OWDivision Enough XP")

			else

				ply:notify("You do not have enough XP to join this Division.")

				return false

			end

			baseWeapons = {"weapon_physcannon", "gmod_tool", "weapon_physgun", "keys", "pocket", "door_ram", "weaponchecker"}



	--					print(tostring(ply:Team()))



	if OWDivisionID == 8  then



						--CHeck if a leader already exists



						for k, v in pairs(player.GetAll()) do

							local SteamIDList = v:SteamID64()

							if v:Team() == 3 and OWMenuPlyTable[SteamIDList] and OWMenuPlyTable[SteamIDList]["OWDivision"] and OWMenuPlyTable[SteamIDList]["OWDivision"] == OWDivisions[OWDivisionID].id then

								ply:notify("Somebody already has that rank.")

								return false

							end

						end



						ply:StripWeapons()

						giveWeapons(ply, baseWeapons)

						giveWeapons(ply, OWDivisionInfo.weapons)

ply:SetSkin(0)

if OWDivisionInfo.name =="MACE" then 

ply:SetSkin(1)

end

						ply:UpdateJob("Overwatch Transhuman Arm ("..OWDivisionInfo.name..")")

						ply:SetModel(OWDivisionInfo.model)



						local id = math.random(100002, 990000)

						local name = "OTA:"..OWDivisionInfo.name.."-"..id



						OWMenuPlyTable[SteamID]["OWDivision"] = OWDivisions[OWDivisionID].id;

						ply:SetDarkRPVar( "OWDivision", OWDivisions[OWDivisionID].id)



						DB.StoreRPName(ply, name)



						ply:SetDarkRPVar("LastOWSet", CurTime() )

						ply:notify("You have set your Overwatch Division as "..OWDivisionInfo.name)

						ply:SetArmor(0)



					else



						if OWMenuPlyTable[SteamID] and OWMenuPlyTable[SteamID]["OWDivision"] and OWMenuPlyTable[SteamID]["Rank"] and OWMenuPlyTable[SteamID]["OWDivision"] == OWDivisions[OWDivisionID].id and OWMenuPlyTable[SteamID]["Rank"] == OWRanks[OWRankID].id then

							ply:notify("You are already a part of that Overwatch Division and rank.")

							return false

						end



						if(OWRankID == 9)then

							for k, v in pairs(player.GetAll()) do

								local SteamID = v:SteamID64()

								if OWMenuPlyTable[SteamID] and OWMenuPlyTable[SteamID]["OWDivision"] and OWMenuPlyTable[SteamID]["Rank"] and OWMenuPlyTable[SteamID]["OWDivision"] == OWDivisions[OWDivisionID].id and OWMenuPlyTable[SteamID]["Rank"] == OWRanks[OWRankID].id and v:Team() == TEAM_OW then

									ply:notify("There is already a DvL for this Overwatch Division.")

									return false

								end

							end

						else

							local CurrDiv = 0;

							local maxDiv = OWDivisionInfo.max;





							for k, v in pairs(player.GetAll()) do

								local SteamID = v:SteamID64()

								if OWMenuPlyTable[SteamID] and OWMenuPlyTable[SteamID]["OWDivision"] and OWMenuPlyTable[SteamID]["OWDivision"] == OWDivisions[OWDivisionID].id and "v:Team() == TEAM_OVERWATCH" then

									CurrDiv = CurrDiv + 1;

								end

							end



							if CurrDiv >= maxDiv then

								ply:notify("This Overwatch Division is full!.")

								return false

							end



						end



						local TotalOWDivision = 0



						if true then



						end





						ply:StripWeapons()

						giveWeapons(ply, baseWeapons)



ply:SetSkin(0)

if OWDivisionInfo.name =="MACE" then 

ply:SetSkin(1)

end



						ply:UpdateJob("Overwatch Transhuman Arm ("..OWDivisionInfo.name.." - "..RankInfo.name..")")

						ply:SetModel(OWDivisionInfo.model)

						local id = math.random(100002, 990000)

						local name = "OTA:"..OWDivisionInfo.name.."-"..RankInfo.name.."-"..id



						OWMenuPlyTable[SteamID]["OWDivision"] = OWDivisions[OWDivisionID].id;

						ply:SetDarkRPVar( "OWDivision", OWDivisions[OWDivisionID].id)

						OWMenuPlyTable[SteamID]["OWRank"] = OWRanks[OWRankID].id;

						ply:SetDarkRPVar( "OWRank", OWRanks[OWRankID].id)





						DB.StoreRPName(ply, name)

						--ply:SetRPName(name, false)



						--Weapons





						ply:notify("You are now a "..OWDivisionInfo.name.." "..RankInfo.name)

						ply:SetArmor(0)

						for i=1,OWRankID do



							if(OWDivisionInfo.weapons[i])then

								giveWeapons(ply, OWDivisionInfo.weapons[i])

								--print("Valid Weapons found")

							end

						end

					end



					local CurTime = CurTime()

					ply:SetDarkRPVar("LastOWSet", CurTime)

					--print("Success!")



				end

			end

		end

	end



	end)

