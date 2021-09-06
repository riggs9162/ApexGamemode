AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")




function ENT:Initialize()


self:SetModel('models/spitball_medium.mdl') 

self:SetColor(Color(0, 96, 255, 255))
self:SetMaterial('models/prop_combine/prtl_sky_sheet')


	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(SOLID_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
	local phys = self:GetPhysicsObject()

	phys:Wake()





end




function ENT:Use(a,ply)

if ply:Team()== TEAM_VORT then 


if ply:GetModel()=='models/vortigaunt.mdl' then

ply:SetColor(Color(186,129,251,255))
ply:SendLua('StartVortessence()')
ply:notify('You have consumed the Larval Extract. 600 seconds until it expires.')

timer.Simple(600, function()
if IsValid(ply) then
if ply:Team()==TEAM_VORT then
ply:notify('The effects of the Larval Extract have expired.')
ply:SetColor(Color(255,255,255,255))
end
end
end)


self:Remove()


else


ply:notify('You must unchained to use the Larval Extract.')
end
else


ply:notify('You must be a vortigaunt to use the Larval Extract.')
end

end
