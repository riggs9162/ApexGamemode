AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/props_lab/keypad.mdl" ) -- Sets the model of the NPC. //
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
	self:SetNoDraw( false )
end

function ENT:OnTakeDamage()
	return false
end

function ENT:Use( Activator, Caller )
if Caller.CMDCD and Caller.CMDCD > CurTime() then return end
Caller.CMDCD = CurTime() + 2
if Caller:Team() == TEAM_CWU and Caller:getDarkRPVar("citopt") == 5 then
for k, burn in pairs (ents.FindInBox( Vector(5005.293457, 4285.753906, 191.000549), Vector(4853.596680, 4099.340820, 315.150360) ) ) do
if burn:GetClass() == "spawned_trash" then
self:EmitSound( "buttons/button3.wav" )
Caller:notify "Incinerating trash..."
Entity( 3284 ):Fire( "Use" )
timer.Simple( 1.5, function()
Entity( 3285 ):Fire( "Use" )
end)
timer.Simple( 4, function()
if burn:IsValid() and burn:GetClass() == "spawned_trash" then
burn:Remove()
end
Caller:AddMoney( 4 )
Caller:notify "You have been rewarded 4 credits for incinerating trash."
print "reward"
end)
elsestate = 0
break
else
elsestate = 1
end
end

if elsestate == 1 then
self:EmitSound( "buttons/button8.wav" )
Caller:notify "There is no trash in the chamber."
end

else
self:EmitSound( "buttons/button8.wav" )
Caller:notify "You are not a Standard CWU worker."
end


end
