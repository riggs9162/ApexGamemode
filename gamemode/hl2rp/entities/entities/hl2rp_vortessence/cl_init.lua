include("shared.lua")

local glowThingie = Material("sprites/glow04_noz")

function ENT:Draw()
	self:DrawModel()
	local lightPos = self:LocalToWorld(Vector(0, 0, 0))
	render.SetMaterial( glowThingie )
	render.DrawSprite(lightPos, 16, 16, Color(0, 96, 255, 144))
end