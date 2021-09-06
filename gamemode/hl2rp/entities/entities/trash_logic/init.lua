AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" ) -- Sets the model of the NPC. //
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
end

function ENT:OnTakeDamage()
	return false
end

function ENT:Use( Activator, Caller )
Caller:notify "Place rubbish in me for 1 credit reward."




end

function ENT:Touch( entity )
print "touch reg"
spawnpos = { Vector(4671.787598, 3835.251953, 445.500092), Vector(4546.167480, 3863.473389, 455.026672) }
local mdl = entity:GetModel()
if entity:GetClass() == "spawned_trash" and entity.IsTrash == "yes" then

for id, targ in pairs( ents.FindInSphere( self:GetPos(), 48 ) ) do
if targ:IsPlayer() and !targ:IsCP() then
targ:AddMoney(2)
targ:notify "You have been rewarded 2 credits for keeping the streets clean."
entity:SetVar ( "IsTrash", "no" )
end
end



entity:SetNoDraw( true )
entity:SetPos( table.Random(spawnpos))
--entity:SetMoveType(MOVETYPE_NONE)
local l = entity:GetPhysicsObject()
l:EnableMotion(false)
l:EnableCollisions(false)
entity:EmitSound( "ambient/materials/rustypipes1.wav" )
entity:EmitSound( "npc/scanner/scanner_siren1.wav" )
--else

end
end
