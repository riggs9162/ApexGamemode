AddCSLuaFile( "shared.lua" )



include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.





function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.



modles = { "models/props_junk/garbage_metalcan001a.mdl", "models/props_junk/garbage_metalcan002a.mdl", "models/props_junk/garbage_takeoutcarton001a.mdl", "models/props_junk/Shoe001a.mdl", "models/props_junk/garbage_milkcarton002a.mdl" }

	self:SetModel( table.Random(modles) ) -- Sets the model of the NPC. //

    self:PhysicsInit(SOLID_VPHYSICS)

    self:SetMoveType(MOVETYPE_VPHYSICS)

    self:SetSolid(SOLID_VPHYSICS)

    self:SetUseType(SIMPLE_USE)

    self:SetColor(230, 2, 4)
    maxtrash = maxtrash + 1

    timer.Simple( 500, function() if self:IsValid() then self:Remove() end end )

end



function ENT:OnTakeDamage()

	return false

end



function ENT:OnRemove()

    maxtrash = maxtrash - 1

    print "trash removed for timer"

end