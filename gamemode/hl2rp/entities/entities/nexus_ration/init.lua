AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua') -- At this point the contents of shared.lua are ran on the server only.


function ENT:Initialize( ) --This function is run when the entity is created so it's a good place to setup our entity.

	self:SetModel( "models/props_combine/combine_dispenser.mdl" ) -- Sets the model of the NPC. // 
	self:SetSolid( SOLID_BBOX ) 
	self:SetUseType( SIMPLE_USE )
    self:SetPlaybackRate( 1.0 )
end

function ENT:OnTakeDamage()
	return false
end

function ENT:Use( Activator, Caller ) 
local sequencedispense = self:LookupSequence("dispense_package")
local pos = self:GetPos() + self:GetForward()*15 + self:GetRight()*-6 + self:GetUp()*-6
local ang = self:GetAngles()
if Caller:getDarkRPVar("ration") == "yes" then
if Caller:IsCP() then
    self:ResetSequence( sequencedispense )
    self:SetSequence( sequencedispense )
    self:SequenceDuration( sequencedispense )   
    Caller:SetDarkRPVar( "ration", "no" )
    Caller:notify( "Dispensing ration..." )
    self:EmitSound ( "ambient/machines/combine_terminal_idle4.wav" )



if Caller:IsCP() then 
local rationcp = ents.Create( "ration_cp" )
timer.Simple(1, function()
if ( !IsValid( rationcp ) ) then return end // Check whether we successfully made an entity, if not - bail
rationcp:SetPos(pos )
rationcp:SetAngles(ang )
rationcp:Spawn()
end)
end
else
Caller:notify "Your team cannot retrieve rations from here."
self:EmitSound ( "buttons/combine_button2.wav" )
end

        timer.Simple(3600, function() if Caller:IsValid() then Caller:SetDarkRPVar( "ration", "yes" ) Caller:notify "You can now collect your hourly ration." Caller:ConCommand( "play buttons/blip1.wav" ) end end )
else
Caller:notify "You must wait an hour between each ration."
Caller:notify "If you have recently joined, you must wait 10 minutes."
self:EmitSound ( "buttons/combine_button2.wav" )

end
end