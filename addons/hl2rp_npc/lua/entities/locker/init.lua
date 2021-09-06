AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files

AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.





function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	

	self:SetModel( "models/props_wasteland/controlroom_storagecloset001a.mdl" ) -- Sets the model of the NPC.

	self:SetSolid( SOLID_VPHYSICS ) 

	self:SetUseType( SIMPLE_USE )

end

function ENT:OnTakeDamage()

	return false

end 



function ENT:AcceptInput( Name, Activator, Caller )	



	if Name == "Use" and Caller:IsPlayer() then

		if Caller:Team() == TEAM_CITIZEN or Caller:Team() == TEAM_VORT then

			umsg.Start("ChangeOutfit", Caller) -- Prepare the usermessage to that same player to open the menu on his side.

			umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.

		end

	end

	

end



concommand.Add( "rp_citizensuitup", function( ply, cmd, args )

if ply:Team() == TEAM_VORT then

ply:SetModel("models/vortigaunt.mdl")

end

	if ply:Team() == TEAM_CITIZEN then
		for id, ent in pairs( ents.FindInSphere( ply:GetPos(), 100 ) ) do
			if ( ent:GetClass() == "locker" ) then
				--if not ply.oldmodel then
					--ply:SetPData("suitedup", "0")
				--end
				if string.match( ply:GetModel(), "group03" ) and ply.oldmodel then --ply:GetPData("suitedup") == "1"
					ply:notify("You are no longer wearing a rebel outfit.")
					ply:SetModel( ply.oldmodel )
					ply:UpdateJob("Citizen")					
					ply:SetPData("suitedup", "0")
					ply:SetArmor(0)
                                                                                DB.Log(ply:Nick().." ("..ply:SteamID()..") is no longer a rebel.", nil, Color(0, 255, 255))
					return
				else 
					--	ply:SetPData("suitedup", "1")
					ply.oldmodel = ply:GetModel()
					suitedModel = string.Replace( ply:GetModel(), "group01", "group03" )
					ply:SetModel(suitedModel)
					ply:UpdateJob("Rebel")
					ply:SetArmor(30)
					ply:notify("You are now wearing a rebel outfit.")
                                                                                DB.Log(ply:Nick().." ("..ply:SteamID()..") is now a rebel.", nil, Color(0, 255, 255))
					return
				end
			end
		end
		
		ply:notify("You are not close enough to a locker.")
	else
		ply:notify("You sneaky bastard.")
	end

end)