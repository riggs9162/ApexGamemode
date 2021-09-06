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
local id = Caller:SteamID64()
local sequencedispense = self:LookupSequence("dispense_package")
local pos = self:GetPos() + self:GetForward()*15 + self:GetRight()*-6 + self:GetUp()*-6
local ang = self:GetAngles()
if Caller:getDarkRPVar("ration") == "yes" then
if Caller:Team() == TEAM_CITIZEN or Caller:Team() == TEAM_CWU or Caller:Team() == TEAM_VORT then
    Caller:SetDarkRPVar( "ration", "no" )
    Caller:notify( "Dispensing ration..." )
    self:EmitSound ( "ambient/machines/combine_terminal_idle4.wav" )
    self:ResetSequence( sequencedispense )
    self:SetSequence( sequencedispense )
    self:SequenceDuration( sequencedispense ) 

if Caller:Team() == TEAM_CWU then 
local ration = ents.Create( "ration_cwu" )
timer.Simple(1, function()
if ( !IsValid( ration ) ) then return end // Check whether we successfully made an entity, if not - bail
ration:SetPos(pos )
ration:SetAngles(ang )
ration:Spawn()
end)
end



if Caller:Team() == TEAM_CITIZEN then 
local ration = ents.Create( "ration_cit" )
timer.Simple(1, function()
if ( !IsValid( ration ) ) then return end // Check whether we successfully made an entity, if not - bail
ration:SetPos( pos)
ration:SetAngles(ang )
ration:Spawn()
end)
end



if Caller:Team() == TEAM_VORT then 
local ration = ents.Create( "ration_vort" )
timer.Simple(3, function()
if ( !IsValid( ration ) ) then return end // Check whether we successfully made an entity, if not - bail
ration:SetPos( pos)
ration:SetAngles(ang )
ration:Spawn()
end)
end


else
Caller:notify "Your team cannot retrieve rations from here."
self:EmitSound ( "buttons/combine_button2.wav" )
end

    timer.Simple(3600, function() if Caller:IsValid() then Caller:SetDarkRPVar( "ration", "yes" ) Caller:notify "You can now collect your hourly ration." Caller:ConCommand( "play buttons/blip1.wav" ) end end )

elseif Caller:getDarkRPVar("ration") == "reward" then
local ration3 = ents.Create( "ration_loyal" )
Caller:SetDarkRPVar( "ration", "no" )
timer.Simple(3, function()
if ( !IsValid( ration3 ) ) then return end // Check whether we successfully made an entity, if not - bail
ration3:SetPos( pos )
ration3:SetAngles(ang )
ration3:Spawn() 
end)



else

Caller:notify "You must wait an hour between each ration."
Caller:notify "If you have recently joined, you must wait 10 minutes."
self:EmitSound ( "buttons/combine_button2.wav" )
end
end