AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent. 
include('shared.lua')
 

function ENT:Initialize()
 
	self:SetModel( "models/weapons/w_package.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(SOLID_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
	self:SetMaterial("phoenix_storms/pack2/chrome")
	--self:SetMaterial( "sprops/trans/misc/ls_m1" )
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(ply)
	if ( self:IsPlayerHolding() ) then ply:DropObject(self) end
	ply:PickupObject( self )

end

function ENT:Think()
		

		if self:GetPos():Distance(Vector(3049.688232, 5610.471680, 384.133270)) > 400 then
					local effectdata = EffectData()
					effectdata:SetOrigin( self:GetPos() )
					effectdata:SetRadius(6)
					effectdata:SetScale(3)
					util.Effect( "TeslaZap", effectdata )
					sound.Play( "ambient/energy/zap5.wav", self:GetPos() )
					self:Remove()
		end

end