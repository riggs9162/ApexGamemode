
HOLDTYPE_TRANSLATOR = {}
HOLDTYPE_TRANSLATOR[""] = "normal"
HOLDTYPE_TRANSLATOR["keys"] = "normal"
HOLDTYPE_TRANSLATOR["physgun"] = "smg"
HOLDTYPE_TRANSLATOR["ar2"] = "smg"
HOLDTYPE_TRANSLATOR["crossbow"] = "shotgun"
HOLDTYPE_TRANSLATOR["rpg"] = "shotgun"
HOLDTYPE_TRANSLATOR["slam"] = "normal"
HOLDTYPE_TRANSLATOR["grenade"] = "normal"
HOLDTYPE_TRANSLATOR["fist"] = "normal"
HOLDTYPE_TRANSLATOR["melee2"] = "melee"
HOLDTYPE_TRANSLATOR["passive"] = "normal"
HOLDTYPE_TRANSLATOR["knife"] = "melee"
HOLDTYPE_TRANSLATOR["duel"] = "pistol"
HOLDTYPE_TRANSLATOR["camera"] = "smg"
HOLDTYPE_TRANSLATOR["magic"] = "normal"
HOLDTYPE_TRANSLATOR["revolver"] = "pistol"

PLAYER_HOLDTYPE_TRANSLATOR = {}
PLAYER_HOLDTYPE_TRANSLATOR[""] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["keys"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["fist"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["pistol"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["grenade"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["melee"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["slam"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["melee2"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["passive"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["knife"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["duel"] = "normal"
PLAYER_HOLDTYPE_TRANSLATOR["bugbait"] = "normal"

local getModelClass = hl2rp.anim.getModelClass
local IsValid = IsValid
local string = string
local type = type

local PLAYER_HOLDTYPE_TRANSLATOR = PLAYER_HOLDTYPE_TRANSLATOR
local HOLDTYPE_TRANSLATOR = HOLDTYPE_TRANSLATOR

function GM:TranslateActivity(client, act)
	local model = string.lower(client.GetModel(client))
	local class = getModelClass(model)
	local weapon = client.GetActiveWeapon(client)

	if (class == "player") then
		if (IsValid(weapon) and !client.isWepRaised(client) and client.OnGround(client)) then
			if (string.find(model, "zombie")) then
				local tree = hl2rp.anim.zombie

				if (string.find(model, "fast")) then
					tree = hl2rp.anim.fastZombie
				end

				if (tree[act]) then
					return tree[act]
				end
			end

			local holdType = weapon.HoldType or weapon.GetHoldType(weapon)
			holdType = PLAYER_HOLDTYPE_TRANSLATOR[holdType] or "passive"

			local tree = hl2rp.anim.player[holdType]

			if (tree and tree[act]) then
				return tree[act]
			end
		end

		return self.BaseClass.TranslateActivity(self.BaseClass, client, act)
	end



	local tree = hl2rp.anim[class]

	if (tree) then
		local subClass = "normal"

		if (client.InVehicle(client)) then
			local vehicle = client.GetVehicle(client)
			local class = vehicle:GetClass()

			if (tree.vehicle and tree.vehicle[class]) then
				local act = tree.vehicle[class][1]
				local fixvec = tree.vehicle[class][2]
				--local fixang = tree.vehicle[class][3]

				if (fixvec) then
					client.ManipulateBonePosition(client, 0, fixvec)
				end

				if (type(act) == "string") then
					client.CalcSeqOverride = client.LookupSequence(client, act)

					return
				else
					return act
				end
			else
				act = tree.normal[ACT_MP_CROUCH_IDLE][1]

				if (type(act) == "string") then
					client.CalcSeqOverride = client:LookupSequence(act)
				end

				return
			end
		elseif (client.OnGround(client)) then
			client.ManipulateBonePosition(client, 0, vector_origin)

			if (IsValid(weapon)) then
				subClass = weapon.HoldType or weapon.GetHoldType(weapon)
				subClass = HOLDTYPE_TRANSLATOR[subClass] or subClass
			end



			if class == "vort" then
				subClass = "smg";
			end

			if (tree[subClass] and tree[subClass][act]) then
				local act2 = tree[subClass][act][client.isWepRaised(client) and 2 or 1]

			if class == "vort" then
				act2 = tree[subClass][act][1]
			end

							

				if (type(act2) == "string") then


					client.CalcSeqOverride = client.LookupSequence(client, act2)

					return
				end

				return act2
			end
		elseif (tree.glide) then
			return tree.glide
		end
	end
end

