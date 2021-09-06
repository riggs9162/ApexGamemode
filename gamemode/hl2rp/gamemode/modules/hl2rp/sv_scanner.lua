local antiSpam = {}

scannerSounds = {
	"npc/scanner/scanner_scan1.wav",
	"npc/scanner/scanner_scan2.wav",
	"npc/scanner/scanner_scan4.wav",
	"npc/scanner/scanner_scan5.wav"
}

angryScannerSounds = {
    "npc/scanner/cbot_servoscared.wav",
    "npc/scanner/scanner_siren1.wav",
    "npc/scanner/scanner_alert1.wav"
}


function MakeScanner(ply)

	if not ScnWep then

		ScnWep = {}

	end

	if not ScnAmmo then

		ScnAmmo = {}

	end



		if IsValid(ply:getDarkRPVar("Scanner")) and IsEntity(ply:getDarkRPVar("Scanner")) then

			ply:getDarkRPVar("Scanner"):Remove()

			return

		end

		local ply = ply

		class =  "npc_cscanner"





		if not ply:IsCP() then

			ply:notify("You must be a CCA GRID Unit to deploy a scanner!")

			return

		end



		if not (ply.DarkRPVars.Division and ply.DarkRPVars.Division == 3) then

			ply:notify("You must be a GRID Unit to deploy a scanner!")

			return

		end



		local waittime = 60*10

	 	if CurTime() - (antiSpam[ply:UniqueID()] or 0) < waittime and not ply:IsAdmin() then

	 		local waittimes = math.ceil(waittime- (CurTime() - (antiSpam[ply:UniqueID()] or 0)))

			ply:notify("You must wait "..waittimes.." second('s) before using /scanner again!")

			return

	 	end

	 		antiSpam[ply:UniqueID()] = CurTime();



		local entity = ents.Create(class)



		if (!IsValid(entity)) then

			return

		end



		entity:SetPos(ply:GetPos() + Vector(0, 0, 110))

		entity:SetAngles(ply:GetAngles())

		entity:SetColor(ply:GetColor())

		entity:Spawn()

		entity:Activate()

		entity.player = ply

		entity:SetNWEntity("player", ply) -- Draw the player info when looking at the scanner.

		entity:CallOnRemove("nutRestore", function()

			if (IsValid(ply)) then

				local position = entity.spawn or ply:GetPos()

				ply:SetRunSpeed(255)

				ply:SetWalkSpeed(100)

				ply:SetCrouchedWalkSpeed(50)

				ply:UnSpectate()

				ply:SetViewEntity(NULL)

				ply:Freeze( false )

				if (entity:Health() > 0) then

				--	ply:Spawn()

				--else

				--	ply:KillSilent()

				end



				timer.Simple(0, function()

				if ply:IsCP() then

					for k,v in pairs(ScnWep[ply]) do

			--			print(v)

						ply:Give(tostring(v), true)

					end

					for k,v in pairs(ScnAmmo[ply]) do

			--			print(v)

						ply:SetAmmo(v["amount"], v["id"])

						ply:SetAmmo(v["amount2"], v["id2"])

					end
                end
				end)

			end

		end)



		local name = "nutScn"..os.clock()

		entity.name = name



		local target = ents.Create("path_track")

		target:SetPos(entity:GetPos())

		target:Spawn()

		target:SetName(name)



		entity:Fire("setfollowtarget", name)

		entity:Fire("inputshouldinspect", false)

		entity:Fire("setdistanceoverride", "48")

		entity:SetKeyValue("spawnflags", 8208)







		ply.nutScn = entity

		ScnWep[ply] = {}

		ScnAmmo[ply] = {}

		for k,v in pairs(ply:GetWeapons()) do

			table.insert( ScnWep[ply] , v:GetClass() )

		end



		for k,v in pairs(ply:GetWeapons()) do

			local ammoName = v:GetPrimaryAmmoType()

			local ammoAmount = ply:GetAmmoCount(v:GetPrimaryAmmoType())

			local ammoName2 = v:GetSecondaryAmmoType()

			local ammoAmount2 = ply:GetAmmoCount(v:GetSecondaryAmmoType())

			addammo = {

			 	id = ammoName,

				amount = ammoAmount,

				id2 = ammoName2,

				amount2 = ammoAmount2

			}

			table.insert( ScnAmmo[ply] , addammo)

		end





		--PrintTable(ply:GetWeapons())

		ply:StripWeapons()

	--	ply:Freeze( true )

		ply:SetRunSpeed(1)

		ply:SetWalkSpeed(1)

		ply:SetCrouchedWalkSpeed(1)

	--	ply:Spectate(OBS_MODE_CHASE)

	--	ply:SpectateEntity(entity)

		ply:SetViewEntity(entity)

		ply:SetDarkRPVar("Scanner", entity)

		local uniqueID = "nut_Scanner"..ply:UniqueID()



		timer.Create(uniqueID, 0.33, 0, function()

			if (!IsValid(ply) or !IsValid(entity)) then

				if (IsValid(entity)) then

					entity:Remove()

				end



				return timer.Remove(uniqueID)

			end



			local factor = 128



			if (ply:KeyDown(IN_SPEED)) then

				factor = 64

			end



			if (ply:KeyDown(IN_FORWARD)) then

				target:SetPos((entity:GetPos() + ply:GetAimVector()*factor) - Vector(0, 0, 64))

				entity:Fire("setfollowtarget", name)

			elseif (ply:KeyDown(IN_BACK)) then

				target:SetPos((entity:GetPos() + ply:GetAimVector()*-factor) - Vector(0, 0, 64))

				entity:Fire("setfollowtarget", name)

			elseif (ply:KeyDown(IN_JUMP)) then

				target:SetPos(entity:GetPos() + Vector(0, 0, factor))

				entity:Fire("setfollowtarget", name)

			elseif (ply:KeyDown(IN_DUCK)) then

				target:SetPos(entity:GetPos() - Vector(0, 0, factor))

				entity:Fire("setfollowtarget", name)

		--	elseif (ply:KeyDown(IN_RELOAD)) then

		--		entity:Remove()

		--		timer.Remove(uniqueID)

			end



			--ply:SetPos(entity:GetPos())

		end)



	--	return entity

	end



AddChatCommand("/scanner", MakeScanner)

concommand.Add( "MakeScanner", function( ply )

--MakeScanner(ply, "npc_cscanner")

end)



concommand.Add( "rp_removescanners", function( ply )

	if ( !ply:IsSuperAdmin() ) then return end

	for k, v in pairs( ents.FindByClass( "npc_cscanner" ) ) do v:Remove() end

end )









util.AddNetworkString("nutScannerData")
util.AddNetworkString("apexScannerEmote")
util.AddNetworkString("apexScannerAngry")

net.Receive("apexScannerAngry", function(length, client)
    		local scanangry = net.ReadBool()
			local scanner = net.ReadEntity()
			
			if scanangry == true then
                client:GetViewEntity():EmitSound( angryScannerSounds[ math.random( #angryScannerSounds) ],140 )
                scanner:EmitSound( angryScannerSounds[ math.random( #angryScannerSounds) ],140 )
                scanangry = false
            end
end)

net.Receive("apexScannerEmote", function(length, client)
    		local scanemote = net.ReadBool()
			local scanner = net.ReadEntity()
			
			if scanemote == true then
                client:GetViewEntity():EmitSound( scannerSounds[ math.random( #scannerSounds) ], 140 )
                scanner:EmitSound( scannerSounds[ math.random( #scannerSounds) ], 140 )
                scanemote = false
            end
end)


net.Receive("nutScannerData", function(length, client)

		if (IsValid(client.nutScn) and client:GetViewEntity() == client.nutScn and (client.nutNextPic or 0) < CurTime()) then

			client.nutNextPic = CurTime() + (4 - 1)

			client:GetViewEntity():EmitSound("npc/scanner/scanner_photo1.wav", 140)

			client:EmitSound("npc/scanner/combat_scan5.wav")



			local length = net.ReadUInt(16)

			local data = net.ReadData(length)

			local scanner = net.ReadEntity()

			scanner:EmitSound("npc/scanner/scanner_photo1.wav", 140)



			if (length != #data) then

				return

			end



			local receivers = {}



			for k, v in ipairs(player.GetAll()) do

				if v:IsCP() then

					receivers[#receivers + 1] = v

					v:EmitSound("npc/overwatch/radiovoice/preparevisualdownload.wav", 20)

					v:notify("Prepare to receive visual download...")

				end

			end



			if (#receivers > 0) then

				net.Start("nutScannerData")

					net.WriteUInt(#data, 16)

					net.WriteData(data, #data)

				net.Send(receivers)









			end

		end

end)



AddChatCommand("/photocache",function(ply)

if ply:IsCP() then

ply:ConCommand("nut_photocache")

end

end)



local ScnGib = {

["models/gibs/scanner_gib01.mdl"] = true,

["models/gibs/scanner_gib02.mdl"] = true,

["models/gibs/scanner_gib03.mdl"] = true,

["models/gibs/scanner_gib04.mdl"] = true,

["models/gibs/scanner_gib05.mdl"] = true

}



timer.Create("CLEANUPG",60,0,function()

for v,k in pairs(ents.GetAll()) do

if ScnGib[k:GetModel()] then

k:Remove()

end



end





end)