AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent. 
include('shared.lua')
    	util.AddNetworkString("RationMaker")

ENT.LastSet = 0

function ENT:SpawnFunction(ply, trace)
	if !trace.Hit then return end
	
	local e = ents.Create(ClassName || self.ClassName || "ent_conveyorbelt")
	if !(e && IsValid(e)) then
		if e.Remove then e:Remove() end
		return
	end
	e:SetPos(trace.HitPos + trace.HitNormal * 16)
	e.Owner = ply
	e:SetAngles(Angle(0,ply:GetAngles().y,0))
	e:Spawn()
	e:Activate()
	
	return e
end

function ENT:Initialize()
 
	self:SetModel( "models/props_junk/PushCart01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	--self:SetMaterial( "sprops/trans/misc/ls_m1" )
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end

local function CreateEnt(ent, pos, ang )
	local ent = ents.Create(ent)
	ent:SetPos( pos )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
end 

net.Receive( "RationMaker", function( len, ply )


	local ent = ents.FindByClass( "hl2rp_ration_maker" )[1]
	local entPos = ent:GetPos()+Vector(8.2,-11.1,20)
	local spawnPos = Vector(2951.312500, 5942.750000, 419.218750)


	 if CurTime() - ent.LastSet > 3 then
	 	ent.LastSet = CurTime();

	 		local rations = 0
	 			local spawnedfood = ents.FindByClass("spawned_food")
	 			for k, v in pairs( spawnedfood ) do
					if v:GetModel() == "models/weapons/w_package.mdl" then
						rations = rations+1
					end
				end

	 		local rawrations = ents.FindByClass("hl2rp_rawration")
	 		if table.Count(rawrations) < 2 and  rations <= 2 and ply:Team() == TEAM_CWU then
	 				CreateEnt("hl2rp_rawration", spawnPos, Angle(180,180,0))
	 				sound.Play( "buttons/button17.wav", entPos )
	 				
	 		else
	 			sound.Play( "buttons/button2.wav", entPos )
	 		end
	 end
end )