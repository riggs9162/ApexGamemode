include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
	local draw_SimpleText = draw.SimpleText
	local glowMaterial = Material("sprites/glow04_noz")

	local color_green = Color(0, 255, 0, 255)
	local color_red = Color(255, 0, 0, 255)
	local color_orange = Color(255, 125, 0, 255)

	function ENT:Initialize()
		self.buttons = {}

		local position = self:GetPos()
		local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

		self.buttons[1] = position + f*18 + r*-24.4 + u*5.3
		self.buttons[2] = position + f*18 + r*-24.4 + u*3.35
		self.buttons[3] = position + f*18 + r*-24.4 + u*1.35
	end

	function ENT:Draw()
		self:DrawModel()

		local position = self:GetPos()
		local angles = self:GetAngles()
		angles:RotateAroundAxis(angles:Up(), 90)
		angles:RotateAroundAxis(angles:Forward(), 90)

		local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

		cam.Start3D2D(position + f*17.33 + r*-19.5 + u*5.75, angles, 0.06)
			draw_SimpleText("Regular", "ChatFont", 0, 0, color_white, 0, 0)
			draw_SimpleText("Sparkling", "ChatFont", 0, 36, color_white, 0, 0)
			draw_SimpleText("Special", "ChatFont", 0, 72, color_white, 0, 0)
		cam.End3D2D()

		render.SetMaterial(glowMaterial)

		if (self.buttons) then
			local position = self:GetPos()
			local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

			self.buttons[1] = position + f*18 + r*-24.4 + u*5.3
			self.buttons[2] = position + f*18 + r*-24.4 + u*3.35
			self.buttons[3] = position + f*18 + r*-24.4 + u*1.35

			local closest = self:getNearestButton()
			local stocks = util.JSONToTable(self:GetStocks());

			for k, v in pairs(self.buttons) do
				local color = color_green

				if (self:GetActive()) then
					if (stocks and stocks[k] and stocks[k] < 1) then
						color = color_red
						color.a = 200
					end

					if (closest != k) then
						color.a = color == color_red and 100 or 75
					else
						color.a = 230 + (math.sin(RealTime() * 7.5) * 25)
					end

					if (LocalPlayer():KeyDown(IN_USE) and closest == k) then
						color = table.Copy(color)
						color.r = math.min(color.r + 100, 255)
						color.g = math.min(color.g + 100, 255)
						color.b = math.min(color.b + 100, 255)
					end
				else
					color = color_orange
				end

				render.DrawSprite(v, 4, 4, color)
			end
		end
	end