AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
include('shared.lua')


	function ENT:Initialize()
		self.buttons = {}

		local position = self:GetPos()
		local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

		self.buttons[1] = position + f*18 + r*-24.4 + u*5.3
		self.buttons[2] = position + f*18 + r*-24.4 + u*3.35
		self.buttons[3] = position + f*18 + r*-24.4 + u*1.35

		self:SetModel("models/props_interiors/vendingmachinesoda01a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		self:SetStocks(util.TableToJSON({10, 5, 5}));
		self:SetActive(1);

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end

	end

	function ENT:Use(activator)
		activator:EmitSound("buttons/lightswitch2.wav", 55, 125)

		if ((self.nextUse or 0) < CurTime()) then
			self.nextUse = CurTime() + 2
		else
			return
		end

		local button = self:getNearestButton(activator)
		local stocks = util.JSONToTable(self:GetStocks());

		if (activator:IsCP()) then
			if (activator:KeyDown(IN_SPEED) and button and stocks[button]) then
				if (stocks[button] > 0) then
					return activator:notify("NO REFILL IS REQUIRED FOR THIS MACHINE.")
				end

				self:EmitSound("buttons/button5.wav")

				if (!activator:CanAfford(20)) then
					return activator:notify("INSUFFICIENT FUNDS (25 TOKENS) TO REFILL MACHINE.")
				else
					activator:notify("25 TOKENS HAVE BEEN TAKEN TO REFILL MACHINE.")
					activator:AddMoney(-20)
				end

				timer.Simple(1, function()
					if (!IsValid(self)) then return end

					stocks[button] = button == 1 and 10 or 5
					self:SetStocks(util.TableToJSON(stocks));
				end)

				return
			else

				self:EmitSound("buttons/combine_button1.wav" or "buttons/combine_button2.wav")

				return
			end
		end

		if (self:GetActive() == 0) then
			return
		end

		if (button and stocks and stocks[button] and stocks[button] > 0) then
			local item = "water"
			local price = 5
			local power = 1

			if (button == 2) then
				item = "water_sparkling"
				price = price + 10
				power = 3
			elseif (button == 3) then
				item = "water_special"
				price = price + 15
				power = 5
			end

			if (!activator:CanAfford(price)) then
				self:EmitSound("buttons/button2.wav")

				return activator:notify("You need "..price.." tokens to purchase this selection.")
			end

			local position = self:GetPos()
			local f, r, u = self:GetForward(), self:GetRight(), self:GetUp()

--			nut.item.spawn(item, position + f*19 + r*4 + u*-26, function(item, entity)

				local SpawnedFood = ents.Create("spawned_food")
				SpawnedFood.ShareGravgun = true
				SpawnedFood:SetPos(position + f*9 + r*4 + u*-12)
				SpawnedFood.onlyremover = true
				SpawnedFood:SetModel("models/props_junk/PopCan01a.mdl")
				SpawnedFood.FoodEnergy = power;
				SpawnedFood:Spawn();

				stocks[button] = stocks[button] - 1

				if (stocks[button] < 1) then
					self:EmitSound("buttons/button6.wav")
				end

				self:SetStocks(util.TableToJSON(stocks));
				self:EmitSound("buttons/button4.wav", Angle(0, 0, 90))

				activator:AddMoney(-price)
				activator:notify("You have spent "..price.." tokens on this vending machine.")

		end
	end
