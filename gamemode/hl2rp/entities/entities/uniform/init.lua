AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/props_c17/Lockers001a.mdl" ) -- Sets the model of the NPC.
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
end

function ENT:OnTakeDamage()
	return false
end

function ENT:AcceptInput( Name, Activator, Caller )

	if Name == "Use" and Caller:IsPlayer() then
		if Caller:Team() == TEAM_CWU then
			umsg.Start("ChangeOutfitCWU", Caller) -- Prepare the usermessage to that same player to open the menu on his side.
			umsg.End() -- We don't need any content in the usermessage so we're sending it empty now.
		end
	end

end

concommand.Add( "rp_cwusuitup", function( ply, cmd, args )
	if ply:Team() == TEAM_CWU then
	if ply:getDarkRPVar("citopt") == 5 then
		for id, ent in pairs( ents.FindInSphere( ply:GetPos(), 100 ) ) do
			if ( ent:GetClass() == "uniform" ) then
				--if not ply.oldmodel then
					--ply:SetPData("suitedup", "0")
				--end
				if string.match( ply:GetModel(), "industrial" ) and ply.oldmodel1 then --ply:GetPData("suitedup") == "1"
					ply:notify("You are no longer wearing factory garments.")
					ply:SetModel( ply.oldmodel1 )
					return
				else
					--	ply:SetPData("suitedup", "1")
					ply.oldmodel1 = ply:GetModel()
					suitedModel = "models/industrial_uniforms/industrial_uniform2.mdl"
					ply:SetModel(suitedModel)
					ply:notify("You are now wearing factory garments.")
					return
				end
			end
		end

		ply:notify("You are not close enough to a locker.")
	else
		ply:notify("You sneaky bastard.")
	end
	end
end)
