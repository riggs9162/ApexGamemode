AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()

	phys:Wake()
	timer.Simple(.13, function()
		if IsValid(self) then phys:SetVelocity( Vector(0,0,0) ) end
	end)
end

function ENT:OnTakeDamage(dmg)
	self:Remove()
end

function ENT:Use(activator,caller)

	if activator:getDarkRPVar("Energy") >= 99 then
		return;
	end

/*
	if self:GetModel()=="models/weapons/w_package.mdl" then
		if activator:KeyDown(KEY_LALT) then
			if ( self:IsPlayerHolding() ) then activator:DropObject(self) end
			activator:PickupObject( self )
			return;
		end
	end
*/
	activator:SetSelfDarkRPVar("Energy", math.Clamp((activator:getDarkRPVar("Energy") or 100) + (self:GetTable().FoodEnergy or 1), 0, 100))

	umsg.Start("AteFoodIcon", activator)
	umsg.End()

	if self:GetModel()=="models/props_junk/popcan01a.mdl" then
		activator:EmitSound("Drink.mp3", 100, 100)
	else
		activator:EmitSound("Eat.mp3", 100, 100)
	end
	self:Remove()

end
