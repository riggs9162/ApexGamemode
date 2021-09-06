-- copied from serverside
FoodItems = { }
local function AddFoodItem(name, mdl, amount, price, team)
	FoodItems[name] = { model = mdl, amount = amount, price = price, team = team }
end

--High end
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

local HM = { }

FoodAteAlpha = -1
FoodAteY = 0

surface.CreateFont("HungerPlus", {
	size = 70,
	weight = 500,
	antialias = true,
	shadow = false,
	font = "ChatFont"})

function HM.HUDPaint()
	local energy = LocalPlayer():getDarkRPVar("Energy") or 0

	local x = 5
	local y = ScrH() - 18
	--draw.RoundedBox(4, 25, ScrH() - 21, 250, 18, Color(0, 0, 0, 230))

	--draw.RoundedBox(4, x - 1, y - 1, GetConVarNumber("HudW") - 8, 9, Color(0, 0, 0, 255))

	if energy > 0 then
		--draw.RoundedBox(4, x, y, (GetConVarNumber("HudW") - 9) * (math.Clamp(energy, 0, 100) / 100), 7, Color(30, 30, 120, 255))
		--draw.DrawText(math.ceil(energy) .. "%", "UiBold", GetConVarNumber("HudW") / 2, y, Color(255, 255, 255, 255), 1)
	else
		--Msg("You are starving.")
		--draw.DrawText(DarkRP.getPhrase("starving"), "ChatFont", GetConVarNumber("HudW") / 2, y - 4, Color(200, 0, 0, 255), 1)
	end

	if FoodAteAlpha > -1 then
		local mul = 1
		if FoodAteY <= ScrH() - 100 then
			mul = -.5
		end

		draw.DrawText("++", "HungerPlus", 308, FoodAteY + 1, Color(0, 0, 0, FoodAteAlpha), 0)
		draw.DrawText("++", "HungerPlus", 307, FoodAteY, Color(20, 100, 20, FoodAteAlpha), 0)

		FoodAteAlpha = math.Clamp(FoodAteAlpha + 1000 * FrameTime() * mul, -1, 255)
		FoodAteY = FoodAteY - 150 * FrameTime()
	end
end
hook.Add("HUDPaint", "HM.HUDPaint", HM.HUDPaint)

local function AteFoodIcon(msg)
	FoodAteAlpha = 1
	FoodAteY = ScrH() - 8
end
usermessage.Hook("AteFoodIcon", AteFoodIcon)