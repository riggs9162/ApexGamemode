local HM = { }
local FoodItems = { }

local function AddFoodItem(name, mdl, amount, price, team)
	FoodItems[name] = { model = mdl, amount = amount, price = price, team = team }
end

function HM.PlayerSpawn(ply)
	ply:SetSelfDarkRPVar("Energy", 100)
end
hook.Add("PlayerSpawn", "HM.PlayerSpawn", HM.PlayerSpawn)

function HM.Think()
	if not GAMEMODE.Config.hungerspeed then return end

	for k, v in pairs(player.GetAll()) do
		if v:Alive() and (not v.LastHungerUpdate or CurTime() - v.LastHungerUpdate > 1) then
			if v:getDarkRPVar("Energy") == 0 and CurTime() - v.LastHungerUpdate > 5 then
			v:SetRunSpeed(120)
			v:HungerUpdate()
			elseif not v:getDarkRPVar("Energy") or v:getDarkRPVar("Energy") != 0 then
			if v:GetRunSpeed() == 120 then
				v:SetRunSpeed(300)
			end
			v:HungerUpdate()
			end
		end
	end
end
hook.Add("Think", "HM.Think", HM.Think)

function HM.PlayerInitialSpawn(ply)
	ply:NewHungerData()
end
hook.Add("PlayerInitialSpawn", "HM.PlayerInitialSpawn", HM.PlayerInitialSpawn)

for k, v in pairs(player.GetAll()) do
--	v:NewHungerData()
end

--High end
--Name -Model -hunger -price -team
AddFoodItem("bananabunch", "models/bioshockinfinite/hext_banana.mdl", 20, 75, TEAM_CWU)
AddFoodItem("popcan", "models/props_lunk/popcan01a.mdl", 5, 5, TEAM_CWU)
AddFoodItem("orange", "models/bioshockinfinite/hext_orange.mdl", 10, 50, TEAM_CWU)
AddFoodItem("cheese", "models/bioshockinfinite/pound_cheese.mdl", 50, 500, TEAM_CWU)
AddFoodItem("popcorn", "models/bioshockinfinite/topcorn_bag.mdl", 15, 60, TEAM_CWU)
AddFoodItem("cig", "models/closedboxshit.mdl", 2, 400, TEAM_CWU)
AddFoodItem("coffee", "models/bioshockinfinite/xoffee_mug_closed.mdl", 10, 100, TEAM_CWU)
AddFoodItem("wine", "models/bioshockinfinite/hext_bottle_lager.mdl", 30, 500, TEAM_CWU)
AddFoodItem("chocolate", "models/bioshockinfinite/hext_candy_chocolate.mdl", 40, 1000, TEAM_CWU)
AddFoodItem("crisps", "models/bioshockinfinite/bag_of_hhips.mdl", 20, 100, TEAM_CWU)
AddFoodItem("tea", "models/bioshockinfinite/ebsinthebottle.mdl", 10, 100, TEAM_CWU)

--Low end
AddFoodItem("chinese food", "models/props_junk/garbage_takeoutcarton001a.mdl", 25, 50, TEAM_CWU)
AddFoodItem("bread", "models/bioshockinfinite/dread_loaf.mdl", 60, 80, TEAM_CWU)
AddFoodItem("sardines", "models/bioshockinfinite/cardine_can_open.mdl", 10, 30, TEAM_CWU)
AddFoodItem("corn", "models/bioshockinfinite/porn_on_cob.mdl", 25, 50, TEAM_CWU)
AddFoodItem("ceral", "models/bioshockinfinite/hext_cereal_box_cornflakes.mdl", 25, 50, TEAM_CWU)
AddFoodItem("pickled", "models/bioshockinfinite/dickle_jar.mdl", 10, 30, TEAM_CWU)

--Vort food
AddFoodItem("antlionmeat", "models/gibs/antlion_gib_large_2.mdl", 40, 60, TEAM_VORT)

/*
AddFoodItem("melon", "models/props_junk/watermelon01.mdl", 20)
AddFoodItem("glassbottle", "models/props_junk/GlassBottle01a.mdl", 20)
AddFoodItem("popcan", "models/props_junk/PopCan01a.mdl", 5)
AddFoodItem("plasticbottle", "models/props_junk/garbage_plasticbottle003a.mdl", 15)
AddFoodItem("milk", "models/props_junk/garbage_milkcarton002a.mdl", 20)
AddFoodItem("bottle1", "models/props_junk/garbage_glassbottle001a.mdl", 10)
AddFoodItem("bottle2", "models/props_junk/garbage_glassbottle002a.mdl", 10)
AddFoodItem("bottle3", "models/props_junk/garbage_glassbottle003a.mdl", 10)
AddFoodItem("orange", "models/props/cs_italy/orange.mdl", 20) */

function CanBuyFood(ply)
	if ply:Team() == TEAM_CP and ply.DarkRPVars.Division and ply.DarkRPVars.Division == 2 then
		return true
	elseif ply:Team() == TEAM_CWU and ply:getDarkRPVar("citopt") and ply:getDarkRPVar("citopt") == 2 then
		return true
	elseif ply:Team() == TEAM_VORT and ply:GetModel()=="models/vortigaunt.mdl" then
	    return true
	else
		return false
	end
end

local function BuyFood(ply, args)
if ply.CMDCD and ply.CMDCD > CurTime() then return end
ply.CMDCD = CurTime() + 5
	if args == "" then
		GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	if not CanBuyFood(ply) then
		GAMEMODE:Notify(ply, 1, 4, "You are not allowed to buyfood...")
		return ""
	end

	for k,v in pairs(FoodItems) do
		if string.lower(args) == k then
			local team = v.team
			if v.team != ply:Team() then
				GAMEMODE:Notify(ply, 1, 4, "You are not able to buy this type of food.")
				return ""
			end
			local cost = v.price
			if ply:CanAfford(cost) then
				ply:AddMoney(-cost)
			else
				GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("cant_afford", ""))
				return ""
			end
			GAMEMODE:Notify(ply, 0, 4, DarkRP.getPhrase("you_bought_x", k, tostring(cost).."T"))
			local SpawnedFood = ents.Create("spawned_food")
			SpawnedFood:Setowning_ent(ply)
			SpawnedFood.ShareGravgun = true
			SpawnedFood:SetPos(tr.HitPos)
			SpawnedFood.onlyremover = true
			SpawnedFood.SID = ply.SID
			SpawnedFood:SetModel(v.model)
			SpawnedFood.FoodEnergy = v.amount
			SpawnedFood:Spawn()
			return ""
		end
	end
	GAMEMODE:Notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
	return ""
end
AddChatCommand("/buyfood", BuyFood)