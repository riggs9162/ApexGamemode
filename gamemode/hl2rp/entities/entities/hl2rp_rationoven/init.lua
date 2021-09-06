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
 
	self:SetModel( "models/sprops/rectangles/size_4_5/rect_42x144x3.mdl" )
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

		 local endpoint = self:GetPos()+AwayVector

		 		--print(hitEnt:GetPos():Distance(endpoint))
		 	if hitEnt:GetPos():Distance(endpoint) > 160 then

					local vPoint = hitEnt:GetPos()-Vector(0,0-8)
					local effectdata = EffectData()
					effectdata:SetOrigin( vPoint )
					effectdata:SetRadius(6)
					effectdata:SetScale(3)
					util.Effect( "MuzzleEffect", effectdata )

					sound.Play( "ambient/fire/ignite.wav", hitEnt:GetPos() )

					if not hitEnt:IsPlayer() and hitEnt:GetClass() == "hl2rp_rawration" then
						timer.Simple(12, function()
							local SpawnedFood = ents.Create("spawned_food")
							SpawnedFood.ShareGravgun = true
							SpawnedFood:SetPos(Vector(3285.406250, 5464.437500, 373.656250))
							SpawnedFood.onlyremover = true
							SpawnedFood:SetModel("models/weapons/w_package.mdl")
							SpawnedFood.FoodEnergy = 20
							SpawnedFood:Spawn()
						end)
					end

		 			if not hitEnt:IsPlayer() then hitEnt:Remove() end
		 		--print("Done")
		 	end
end

function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end

/*
Pos1

Ang: 

0.000 -135.000 0.000
Pos: 

3181.656250 5793.531250 342.062500

Pos2

Ang: 

0.000 180.000 0.000
Pos: 

3204.468750 5463.343750 341.937500


Factory:

Ang: 

0.000 180.000 0.000
Pos: 

2949.250000 5929.062500 354.343750


*/