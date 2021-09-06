AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent. 
include('shared.lua')
 
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
 
	self:SetModel( "models/sprops/rectangles/size_4_5/rect_42x192x3.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(SOLID_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetMaterial( "sprops/trans/misc/ls_m1" )
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end
 
function ENT:Touch( hitEnt )
		 local speedamount = 40
		 if !IsValid( hitEnt ) then return end

		 if hitEnt:GetPos().z < self:GetPos().z then return end

		 if IsValid( hitEnt ) && hitEnt:IsPlayer() then

		hitEnt:SetVelocity(self:GetForward() * (speedamount/10) * -1+ Vector(0, 0, 180))
		 elseif !IsValid( hitEnt ) || !hitEnt:GetPhysicsObject():IsValid() then return end
		 if hitEnt:GetClass() == "sent_conveyorbelt" then return end

		 hitEnt:GetPhysicsObject():SetVelocity(self:GetForward() * speedamount * -1)

		 local angel = self:GetAngles()

		 local AwayVector = Vector(100, 0, 0)

		 AwayVector:Rotate(angel)

end

function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end