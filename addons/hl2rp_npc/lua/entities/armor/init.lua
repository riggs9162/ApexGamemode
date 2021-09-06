AddCSLuaFile( "cl_init.lua" ) -- This means the client will download these files
AddCSLuaFile( "shared.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/props_combine/suit_charger001.mdl" ) -- Sets the model of the NPC.
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
end

function ENT:OnTakeDamage()
	return false
end

function ENT:Use( Name, Activator, Caller )

if Activator:Team() == TEAM_OVERWATCH then
if Activator:GetSkin()==1 then

    Activator:SetArmor( 200 )
    Activator:notify("Your armor has been restocked because you are an Overwatch unit (+MACE armor).")


elseif Activator:GetModel()== "models/Combine_Super_Soldier.mdl" then

    Activator:SetArmor( 180 )
    Activator:notify("Your armor has been restocked because you are an Overwatch unit (+KING armor).")
else


    Activator:SetArmor( 150 )
    Activator:notify("Your armor has been restocked because you are an Overwatch unit.")
end

end

if Activator:Team() == TEAM_CP then
    Activator:SetArmor( 40)
    Activator:notify("Your armor has been restocked because you are an Civil Protection unit.")


end



end