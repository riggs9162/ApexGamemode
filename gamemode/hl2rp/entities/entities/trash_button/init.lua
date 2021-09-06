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
self:EmitSound( "npc/attack_helicopter/aheli_megabomb_siren1.wav" )
Caller:notify "Sending trash down..."

randompos = { Vector(4675.952637, 3836.327637, 401.301270), Vector(4545.360840, 3855.265625, 420.552917) }

for k, trash in pairs (ents.FindInBox( Vector(4776.591309, 3918.406250, 498.306030), Vector(4470.874023, 3735.258057, 390.437012) ) ) do
if trash:GetClass() == "spawned_trash" then
--trash:SetMoveType(MOVETYPE_VPHYSICS)
local l = trash:GetPhysicsObject()
l:EnableMotion(true)
l:Wake()
l:EnableCollisions(true)
trash:SetNoDraw( false )
timer.Simple( 1, function()
trash:EmitSound( "physics/body/body_medium_impact_soft7.wav" )
end)
-- trash:SetPos(table.Random(randompos))
print "release worked"
end
break
end

else
Caller:notify "You must be a CWU Standard worker to use this machinery."




end
end

