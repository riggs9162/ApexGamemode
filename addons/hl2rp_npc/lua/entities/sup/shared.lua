activator:SetSelfDarkRPVar("Energy", math.Clamp((activator:getDarkRPVar("Energy") or 100) + (self:GetTable().FoodEnergy or 1), 0, 100))
