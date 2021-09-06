AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent. 
include('shared.lua')
 

function ENT:Initialize()
 
	self:SetModel( "models/weapons/w_packatp.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(SOLID_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
timer.Simple( 120, function() if self:IsValid() then
self:Remove() end end )
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		timer.Simple(1.4,function() phys:Wake() end)
	end
end

function ENT:Use(ply)

if ply:Team() == TEAM_CITIZEN then
		ply:SetSelfDarkRPVar("Energy", math.Clamp((ply:getDarkRPVar("Energy") or 100) + (100), 0, 100))
                                ply:AddMoney(500)
                                ply:notify("Because you are have been awared loyalty points you have recived a bonus ration.")


	umsg.Start("AteFoodIcon", ply)
	umsg.End()

	ply:EmitSound("Eat.mp3", 100, 100)
	self:Remove()

elseif ply:Team() == TEAM_CWU then
		ply:SetSelfDarkRPVar("Energy", math.Clamp((ply:getDarkRPVar("Energy") or 100) + (100), 0, 100))
                                ply:AddMoney(1000)
                                ply:notify("Because you are have been awared loyalty points you have recived a bonus ration.")


	umsg.Start("AteFoodIcon", ply)
	umsg.End()

	ply:EmitSound("Eat.mp3", 100, 100)
	self:Remove()

end

end