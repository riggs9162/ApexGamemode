AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.
	
	self:SetModel( "models/dpfilms/metropolice/police_bt.mdl" ) -- Sets the model of the NPC.
	self:SetHullType( HULL_HUMAN ) -- Sets the hull type, used for movement calculations amongst other things.
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
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
			if not string.match(Caller:Nick(), "CP") then
				Caller:SetPData( "cname", Caller:Nick() )
			end
		end
		if Caller:Team() == TEAM_CP then
			umsg.Start("ShopNPCUsed", Caller) -- Prepare the usermessage to that same player to open the menu on his side.
			umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
		else
			Caller:notify("You are not part of the Civil Protection." )

		end
	end
	
end

function giveWeapons(ply, weapons)
	for i, weapon in ipairs(weapons) do
		ply:Give(weapon)
	end
end

concommand.Add( "rp_division", function( ply, cmd, args )

	local SteamID = ply:SteamID64()

	if CPMenuPlyTable == nil then
		CPMenuPlyTable = {}
--	print("CP Table Created")
end

if CPMenuPlyTable[SteamID] == nil then
	CPMenuPlyTable[SteamID] = {}
--	print("PLY Table Created")
end

if not ply:IsAdmin() then

	if ply:getDarkRPVar("LastCPSet") and 120 - (CurTime() - ply:getDarkRPVar("LastCPSet")) >= 0 then
		ply:notify("You must wait ".. math.ceil(120 - (CurTime() - ply:getDarkRPVar("LastCPSet"))) .. " second('s) before changing rank or division.")
		return false
	end

end

for id, ent in pairs( ents.FindInSphere( ply:GetPos(), 64 ) ) do
	if ( ent:GetClass() == "cp_npc" ) then

		if args[1] and args[2]then
			local RankID = tonumber(args[1])
			local DivisionID = tonumber(args[2])
			if CPRanks[RankID] and CPDivisions[DivisionID] and ply:Team() == TEAM_CP then
				
				local RankInfo = CPRanks[RankID]
				local DivisionInfo = CPDivisions[DivisionID]
				
				local PlayerXP = ply:GetNetworkedInt( "Xp" )
				print(PlayerXP)
				local jobdelay = 120

--print(tostring(ply:GetPData("LastCPSet")))

if ply:IsAdmin() or (RankInfo.xp <= PlayerXP) then
				--			print("Rank Enough XP")
			else
				ply:notify("You do not have enough XP to be this rank.")
				return false
			end

			if ply:IsAdmin() or (DivisionInfo.xp <= PlayerXP)then
				--			print("Division Enough XP")
			else
				ply:notify("You do not have enough XP to join this division.")
				return false
			end
			baseWeapons = {"weapon_physcannon", "gmod_tool", "weapon_physgun", "keys", "pocket", "weaponchecker"}

	--					print(tostring(ply:Team()))
	
	if DivisionID == 6 or DivisionID == 7 then

						--CHeck if a leader already exists

						for k, v in pairs(player.GetAll()) do
							local SteamIDList = v:SteamID64()
							if v:Team() == 3 and CPMenuPlyTable[SteamIDList] and CPMenuPlyTable[SteamIDList]["Division"] and CPMenuPlyTable[SteamIDList]["Division"] == CPDivisions[DivisionID].id then
								ply:notify("Somebody already has that rank.")
								return false
							end
						end

						ply:StripWeapons()
						giveWeapons(ply, baseWeapons)
						giveWeapons(ply, DivisionInfo.weapons)
						ply:SetArmor( 40 )
						ply:UpdateJob("Civil Protection ("..DivisionInfo.name..")")
						ply:SetModel(DivisionInfo.model)

						local id = math.random(1002, 9900)
						local name = "CP:C17-"..DivisionInfo.name.."-"..id

						CPMenuPlyTable[SteamID]["Division"] = CPDivisions[DivisionID].id;
						ply:SetDarkRPVar( "Division", CPDivisions[DivisionID].id)

						DB.StoreRPName(ply, name)

						ply:SetDarkRPVar("LastCPSet", CurTime() )
						ply:notify("You have set your division as "..DivisionInfo.name)

					else

						if CPMenuPlyTable[SteamID] and CPMenuPlyTable[SteamID]["Division"] and CPMenuPlyTable[SteamID]["Rank"] and CPMenuPlyTable[SteamID]["Division"] == CPDivisions[DivisionID].id and CPMenuPlyTable[SteamID]["Rank"] == CPRanks[RankID].id then
							ply:notify("You are already a part of that division and rank.")
							return false
						end

						if(RankID == 9)then
							for k, v in pairs(player.GetAll()) do
								local SteamID = v:SteamID64()
								if CPMenuPlyTable[SteamID] and CPMenuPlyTable[SteamID]["Division"] and CPMenuPlyTable[SteamID]["Rank"] and CPMenuPlyTable[SteamID]["Division"] == CPDivisions[DivisionID].id and CPMenuPlyTable[SteamID]["Rank"] == CPRanks[RankID].id and v:Team() == TEAM_CP then
									ply:notify("There is already a DvL for this Divison.")
									return false
								end
							end
						else
							local CurrDiv = 0;
							local maxDiv = DivisionInfo.max;


							for k, v in pairs(player.GetAll()) do
								local SteamID = v:SteamID64()
								if CPMenuPlyTable[SteamID] and CPMenuPlyTable[SteamID]["Division"] and CPMenuPlyTable[SteamID]["Division"] == CPDivisions[DivisionID].id and "v:Team() == TEAM_CP" then
									CurrDiv = CurrDiv + 1;
								end
							end

							if CurrDiv >= maxDiv then
								ply:notify("This Division is full!.")
								return false
							end

						end

						local TotalDivision = 0

						if true then

						end


						ply:StripWeapons()
						giveWeapons(ply, baseWeapons)
						ply:UpdateJob("Civil Protection ("..DivisionInfo.name.."-"..RankInfo.name..")")
						ply:SetModel(DivisionInfo.model)
						local id = math.random(1002, 9900)
						local name = "CP:C17-"..DivisionInfo.name.."-"..RankInfo.name.."-"..id

						CPMenuPlyTable[SteamID]["Division"] = CPDivisions[DivisionID].id;
						ply:SetDarkRPVar( "Division", CPDivisions[DivisionID].id)
						CPMenuPlyTable[SteamID]["Rank"] = CPRanks[RankID].id;
						ply:SetDarkRPVar( "Rank", CPRanks[RankID].id)


						DB.StoreRPName(ply, name)
						--ply:SetRPName(name, false)

						--Weapons


						ply:notify("You are now a "..DivisionInfo.name.." "..RankInfo.name)

						for i=1,RankID do 

							if(DivisionInfo.weapons[i])then
								giveWeapons(ply, DivisionInfo.weapons[i])
								--print("Valid Weapons found")
							end
						end 
					end


					if DivisionID == 5 then

						ply:UpdateJob("Civil Protection ("..DivisionInfo.name..")")
						local id = math.random(1002, 9900)
						local name2 = "CP:C17-"..DivisionInfo.name.."-OfC-"..id
						ply:SetRPName(name2, false)
					end

					local CurTime = CurTime()
					ply:SetDarkRPVar("LastCPSet", CurTime)
					--print("Success!")

				end
			end
		end
	end

	end)