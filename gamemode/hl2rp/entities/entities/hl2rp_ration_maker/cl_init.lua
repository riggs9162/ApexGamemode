include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]


function ENT:Draw()

	// Draw model.
	self.Entity:DrawModel()

	local vec = self:GetPos()+Vector(8.2,-21.1,20)

    p = p or tdui.Create()

    if p:Button("+", "DermaLarge", 0, 0, 52, 52) then
        net.Start("RationMaker")
        net.SendToServer()
    end

    -- Draws a simple crosshair cursor at current mouse position
    p:Cursor()

    -- Renders all the queued draw commands at given 3D location (this one's near gm_construct wall)
    p:Render(vec, Angle(0, 90, 0), 0.1)

end