ENT.Base = "base_ai" -- This entity is based on "base_ai"
ENT.Type = "anim" -- What type of entity is it, in this case, it's an AI.
ENT.PrintName		= "Antlion Meat"
ENT.Author			= "Vingard"
ENT.Contact			= "N/A"
ENT.Purpose			= "Change outfit"
ENT.Instructions	= "Press E"
ENT.Category 		= "Roleplay"

ENT.Spawnable = true
ENT.AdminOnly = true






function ENT:Initialize( )

self:SetMass(1)

end


function ENT:Think()

if self:IsOnFire() then

self:SetColor(255,165,0,255)
self.Cooked =true
end

end

function ENT:Use(a,ply)

ply:SetSelfDarkRPVar("Energy", math.Clamp((ply:getDarkRPVar("Energy") or 0) + 60, 0, 100))

umsg.Start("AteFoodIcon", ply)
umsg.Bool(isDrink);
umsg.End()
self:Remove()

end

-- Since this file is ran by both the client and the server, both will share this information.