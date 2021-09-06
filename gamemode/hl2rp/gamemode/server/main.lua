/*---------------------------------------------------------
 Flammable
 ---------------------------------------------------------*/
local FlammableProps = {drug = true,
drug_lab = true,
food = true,
gunlab = true,
letter = true,
microwave = true,
money_printer = true,
spawned_shipment = true,
spawned_weapon = true,
spawned_money = true}

local function IsFlammable(ent)
	return FlammableProps[ent:GetClass()] ~= nil
end

-- FireSpread from SeriousRP
local function FireSpread(e)
	if not e:IsOnFire() then return end

	if e:IsMoneyBag() then
		e:Remove()
	end

	local rand = math.random(0, 300)

	if rand > 1 then return end
	local en = ents.FindInSphere(e:GetPos(), math.random(20, 90))

	for k, v in pairs(en) do
		if not IsFlammable(v) then continue end

		if not v.burned then
			v:Ignite(math.random(5,180), 0)
			v.burned = true
		else
			local color = v:GetColor()
			if (color.r - 51) >= 0 then color.r = color.r - 51 end
			if (color.g - 51) >= 0 then color.g = color.g - 51 end
			if (color.b - 51) >= 0 then color.b = color.b - 51 end
			v:SetColor(color)
			if (color.r + color.g + color.b) < 103 and math.random(1, 100) < 35 then
				v:Fire("enablemotion","",0)
				constraint.RemoveAll(v)
			end
		end
		break -- Don't ignite all entities in sphere at once, just one at a time
	end
end

local function FlammablePropThink()
	for k, v in pairs(FlammableProps) do
		local ens = ents.FindByClass(k)

		for a, b in pairs(ens) do
			FireSpread(b)
		end
	end
end
timer.Create("FlammableProps", 0.1, 0, FlammablePropThink)

/*---------------------------------------------------------
 Shipments
 ---------------------------------------------------------*/

local function DropWeapon(ply)
	local ent = ply:GetActiveWeapon()
	if not IsValid(ent) then
		ply:notify( DarkRP.getPhrase("cannot_drop_weapon"))
		return ""
	end

	local canDrop = hook.Call("CanDropWeapon", GAMEMODE, ply, ent)
	if not canDrop then
		ply:notify( DarkRP.getPhrase("cannot_drop_weapon"))
		return ""
	end

	if ply:Team() == TEAM_CP or ply:Team() == TEAM_OVERWATCH or ply:Team() == TEAM_OVERWATCHELITE then
		ply:notify( DarkRP.getPhrase("cannot_drop_weapon"))
		return ""
	end

	local RP = RecipientFilter()
	RP:AddAllPlayers()

	umsg.Start("anim_dropitem", RP)
		umsg.Entity(ply)
	umsg.End()
	ply.anim_DroppingItem = true

	timer.Simple(1, function()
		if IsValid(ply) and IsValid(ent) and ent:GetModel() then
			ply:DropDRPWeapon(ent)
		end
	end)
	return ""
end
AddChatCommand("/drop", DropWeapon)
AddChatCommand("/dropweapon", DropWeapon)
AddChatCommand("/weapondrop", DropWeapon)

/*---------------------------------------------------------
Spawning
 ---------------------------------------------------------*/


function GM:ShowTeam(ply)
end

function GM:ShowHelp(ply)
end

local function LookPersonUp(ply, cmd, args)
	if not args[1] then
		ply:PrintMessage(2, DarkRP.getPhrase("invalid_x", "argument", ""))
		return
	end
	local P = GAMEMODE:FindPlayer(args[1])
	if not IsValid(P) then
		if ply:EntIndex() ~= 0 then
			ply:PrintMessage(2, DarkRP.getPhrase("could_not_find", "player: "..tostring(args[1])))
		else
			print(DarkRP.getPhrase("could_not_find", "player: "..tostring(args[1])))
		end
		return
	end
	if ply:EntIndex() ~= 0 then
		ply:PrintMessage(2, "Nick: ".. P:Nick())
		ply:PrintMessage(2, "Steam name: "..P:SteamName())
		ply:PrintMessage(2, "Steam ID: "..P:SteamID())
		ply:PrintMessage(2, "Job: ".. team.GetName(P:Team()))
		ply:PrintMessage(2, "Kills: ".. P:Frags())
		ply:PrintMessage(2, "Deaths: ".. P:Deaths())
		if ply:IsAdmin() then
			ply:PrintMessage(2, "Money: ".. P:getDarkRPVar("money"))
		end
	else
		print("Nick: ".. P:Nick())
		print("Steam name: "..P:SteamName())
		print("Steam ID: "..P:SteamID())
		print("Job: ".. team.GetName(P:Team()))
		print("Kills: ".. P:Frags())
		print("Deaths: ".. P:Deaths())

		print("Money: " .. GAMEMODE.Config.currency .. P:getDarkRPVar("money"))
	end
end
concommand.Add("rp_lookup", LookPersonUp)

/*---------------------------------------------------------
 Items
 ---------------------------------------------------------*/
local function MakeLetter(ply, args, type)
	if not GAMEMODE.Config.letters then
		ply:notify(DarkRP.getPhrase("disabled", "/write / /type", ""))
		return ""
	end

	if not ply:Alive() then
		ply:notify("You're dead you cannot use /write")
		return ""
	end

	if ply.maxletters and ply.maxletters >= GAMEMODE.Config.maxletters then
		ply:notify( DarkRP.getPhrase("limit", "letter"))
		return ""
	end

	if CurTime() - ply:GetTable().LastLetterMade < 3 then
		ply:notify(DarkRP.getPhrase("have_to_wait", math.ceil(3 - (CurTime() - ply:GetTable().LastLetterMade)), "/write / /type"))
		return ""
	end

	ply:GetTable().LastLetterMade = CurTime()

	-- Instruct the player's letter window to open

	local ftext = string.gsub(args, "//", "\n")
	ftext = string.gsub(ftext, "\\n", "\n") .. "\n\nYours,\n"..ply:Nick()
	local length = string.len(ftext)

	local numParts = math.floor(length / 39) + 1

	local tr = {}
	tr.start = ply:EyePos()
	tr.endpos = ply:EyePos() + 95 * ply:GetAimVector()
	tr.filter = ply
	local trace = util.TraceLine(tr)

	local letter = ents.Create("letter")
	letter:SetModel("models/props_c17/paper01.mdl")
	letter:Setowning_ent(ply)
	letter.ShareGravgun = true
	letter:SetPos(trace.HitPos)
	letter.nodupe = true
	letter:Spawn()

	letter:GetTable().Letter = true
	letter.type = type
	letter.numPts = numParts

	local startpos = 1
	local endpos = 39
	letter.Parts = {}
	for k=1, numParts do
		table.insert(letter.Parts, string.sub(ftext, startpos, endpos))
		startpos = startpos + 39
		endpos = endpos + 39
	end
	letter.SID = ply.SID

	GAMEMODE:PrintMessageAll(2, DarkRP.getPhrase("created_x", ply:Nick(), "mail"))
	if not ply.maxletters then
		ply.maxletters = 0
	end
	ply.maxletters = ply.maxletters + 1
	timer.Simple(600, function() if IsValid(letter) then letter:Remove() end end)
end

local function WriteLetter(ply, args)
	if args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	MakeLetter(ply, args, 1)
	return ""
end
AddChatCommand("/write", WriteLetter)

local function TypeLetter(ply, args)
	if args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	MakeLetter(ply, args, 2)
	return ""
end
AddChatCommand("/type", TypeLetter)

local function RemoveLetters(ply)
	for k, v in pairs(ents.FindByClass("letter")) do
		if v.SID == ply.SID then v:Remove() end
	end
	ply:Notify(DarkRP.getPhrase("cleaned_up", "mails"))
	return ""
end
AddChatCommand("/removeletters", RemoveLetters)

local function SetPrice(ply, args)
	if args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	local a = tonumber(args)
	if not a then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local b = math.Clamp(math.floor(a), GAMEMODE.Config.pricemin, (GAMEMODE.Config.pricecap ~= 0 and GAMEMODE.Config.pricecap) or 500)
	local trace = {}

	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	if not IsValid(tr.Entity) then ply:notify(DarkRP.getPhrase("must_be_looking_at", "gunlab / druglab / microwave")) return "" end

	local class = tr.Entity:GetClass()
	if IsValid(tr.Entity) and (class == "gunlab" or class == "microwave" or class == "drug_lab") and tr.Entity.SID == ply.SID then
		tr.Entity:Setprice(b)
	else
		ply:notify(ply, 1, 4, DarkRP.getPhrase("must_be_looking_at", "gunlab / druglab / microwave"))
	end
	return ""
end
AddChatCommand("/price", SetPrice)
AddChatCommand("/setprice", SetPrice)

local function BuyPistol(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	if ply:isArrested() then
		ply:notify( DarkRP.getPhrase("unable", "/buy", ""))
		return ""
	end

	if not GAMEMODE.Config.enablebuypistol then
		ply:notify( DarkRP.getPhrase("disabled", "/buy", ""))
		return ""
	end
	if GAMEMODE.Config.noguns then
		ply:notify( DarkRP.getPhrase("disabled", "/buy", ""))
		return ""
	end

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	local class = nil
	local model = nil

	local shipment
	local price = 0
	for k,v in pairs(CustomShipments) do
		if v.seperate and string.lower(v.name) == string.lower(args) and GAMEMODE:CustomObjFitsMap(v) then
			shipment = v
			class = v.entity
			model = v.model
			price = v.pricesep
			local canbuy = false

			if not GAMEMODE.Config.restrictbuypistol or
			(GAMEMODE.Config.restrictbuypistol and (not v.allowed[1] or table.HasValue(v.allowed, ply:Team()))) then
				canbuy = true
			end

			if v.customCheck and not v.customCheck(ply) then
				ply:notify( v.CustomCheckFailMsg or "You're not allowed to purchase this item")
				return ""
			end

			if not canbuy then
				ply:notify( DarkRP.getPhrase("incorrect_job", "/buy"))
				return ""
			end
		end
	end

	if not class then
		ply:notify( DarkRP.getPhrase("unavailable", "weapon"))
		return ""
	end

	if not ply:CanAfford(price) then
		ply:notify( DarkRP.getPhrase("cant_afford", "/buy"))
		return ""
	end
	if string.match( class, "hl2rp" ) then cclass = class else cclass = "spawned_weapon" end
	print(cclass)
	local weapon = ents.Create(cclass)
	weapon:SetModel(model)
	weapon.weaponclass = class
	weapon.ShareGravgun = true
	weapon.SID = ply:SteamID()
	weapon:SetPos(tr.HitPos)
	weapon.ammoadd = weapons.Get(class) and weapons.Get(class).Primary.DefaultClip
	weapon.nodupe = true
	weapon:Spawn()

	if shipment.onBought then
		shipment.onBought(ply, shipment, weapon)
	end
	hook.Call("playerBoughtPistol", nil, ply, shipment, weapon)

	if IsValid( weapon ) then
		ply:AddMoney(-price)
		ply:notify( DarkRP.getPhrase("you_bought_x", args, tostring(price)).." tokens.")
	else
		ply:notify( DarkRP.getPhrase("unable", "/buy", args))
	end

	return ""
end
AddChatCommand("/buy", BuyPistol, 0.2)

local function BuyShipment(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if ply.LastShipmentSpawn and ply.LastShipmentSpawn > (CurTime() - GAMEMODE.Config.ShipmentSpamTime) then
		ply:notify( "Please wait before spawning another shipment.")
		return ""
	end
	ply.LastShipmentSpawn = CurTime()

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	if ply:isArrested() then
		ply:notify( DarkRP.getPhrase("unable", "/buyshipment", ""))
		return ""
	end

	local found = false
	local foundKey
	for k,v in pairs(CustomShipments) do
		if string.lower(args) == string.lower(v.name) and not v.noship and GAMEMODE:CustomObjFitsMap(v) then
			found = v
			foundKey = k
			local canbecome = false
			for a,b in pairs(v.allowed) do
				if ply:Team() == b then
					canbecome = true
				end
			end

			if v.customCheck and not v.customCheck(ply) then
				ply:notify( v.CustomCheckFailMsg or "You're not allowed to purchase this item")
				return ""
			end

			if not canbecome then
				ply:notify( DarkRP.getPhrase("incorrect_job", "/buyshipment"))
				return ""
			end
		end
	end

	if not found then
		ply:notify( DarkRP.getPhrase("unavailable", "shipment"))
		return ""
	end

	local cost = found.price

	if not ply:CanAfford(cost) then
		ply:notify( DarkRP.getPhrase("cant_afford", "shipment"))
		return ""
	end
	print(found.shipmentClass)
	local crate = ents.Create(found.entity or "spawned_shipment")
	crate.SID = ply.SID
	crate:Setowning_ent(ply)
	--crate:SetContents(foundKey, found.amount)

	crate:SetPos(Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z))
	crate.nodupe = true
	crate:Spawn()
	crate:SetPlayer(ply)
	if found.shipmodel then
		crate:SetModel(found.shipmodel)
		crate:PhysicsInit(SOLID_VPHYSICS)
		crate:SetMoveType(MOVETYPE_VPHYSICS)
		crate:SetSolid(SOLID_VPHYSICS)
	end

	local phys = crate:GetPhysicsObject()
	phys:Wake()

	if CustomShipments[foundKey].onBought then
		CustomShipments[foundKey].onBought(ply, CustomShipments[foundKey], weapon)
	end
	hook.Call("playerBoughtShipment", nil, ply, CustomShipments[foundKey], weapon)

	if IsValid( crate ) then
		ply:AddMoney(-cost)
		ply:notify( DarkRP.getPhrase("you_bought_x", args, GAMEMODE.Config.currency .. tostring(cost)))
	else
		ply:notify( DarkRP.getPhrase("unable", "/buyshipment", arg))
	end

	return ""
end
AddChatCommand("/buyshipment", BuyShipment)

local function BuyVehicle(ply, args)
	if ply:isArrested() then
		ply:notify( DarkRP.getPhrase("unable", "/buyvehicle", ""))
		return ""
	end
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local found = false
	for k,v in pairs(CustomVehicles) do
		if string.lower(v.name) == string.lower(args) then found = CustomVehicles[k] break end
	end
	if not found then
		ply:notify( DarkRP.getPhrase("unavailable", "vehicle"))
		return ""
	end
	if found.allowed and not table.HasValue(found.allowed, ply:Team()) then ply:notify( DarkRP.getPhrase("incorrect_job", "/buyvehicle")) return "" end

	if found.customCheck and not found.customCheck(ply) then
		ply:notify( v.CustomCheckFailMsg or "You're not allowed to purchase this item")
		return ""
	end

	if not ply.Vehicles then ply.Vehicles = 0 end
	if GAMEMODE.Config.maxvehicles and ply.Vehicles >= GAMEMODE.Config.maxvehicles then
		ply:notify( DarkRP.getPhrase("limit", "vehicle"))
		return ""
	end

	if not ply:CanAfford(found.price) then ply:notify( DarkRP.getPhrase("cant_afford", "vehicle")) return "" end

	local Vehicle = DarkRP.getAvailableVehicles()[found.name]
	if not Vehicle then ply:notify( DarkRP.getPhrase("invalid_x", "argument", "")) return "" end

	ply:AddMoney(-found.price)
	ply:notify( DarkRP.getPhrase("you_bought_x", found.name, GAMEMODE.Config.currency .. found.price))

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply
	local tr = util.TraceLine(trace)

	local ent = ents.Create(Vehicle.Class)
	if not ent then
		ply:notify( DarkRP.getPhrase("unable", "/buyvehicle", ""))
		return ""
	end
	ent:SetModel(Vehicle.Model)
	if Vehicle.KeyValues then
		for k, v in pairs(Vehicle.KeyValues) do
			ent:SetKeyValue(k, v)
		end
	end

	local Angles = ply:GetAngles()
	Angles.pitch = 0
	Angles.roll = 0
	Angles.yaw = Angles.yaw + 180
	ent:SetAngles(Angles)
	ent:SetPos(tr.HitPos)
	ent.VehicleName = found.name
	ent.VehicleTable = Vehicle
	ent:Spawn()
	ent:Activate()
	ent.SID = ply.SID
	ent.ClassOverride = Vehicle.Class
	if Vehicle.Members then
		table.Merge(ent, Vehicle.Members)
	end
	ent:CPPISetOwner(ply)
	ent:Own(ply)
	hook.Call("PlayerSpawnedVehicle", GAMEMODE, ply, ent) -- VUMod compatability
	hook.Call("playerBoughtVehicle", nil, ply, found, ent)
	if found.onBought then
		found.onBought(ply, found, ent)
	end

	return ""
end
--AddChatCommand("/buyvehicle", BuyVehicle)

local function BuyAmmo(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if ply:isArrested() then
		ply:notify( DarkRP.getPhrase("unable", "/buyammo", ""))
		return ""
	end

	if GAMEMODE.Config.noguns then
		ply:notify( DarkRP.getPhrase("disabled", "ammo", ""))
		return ""
	end

	local found
	for k,v in pairs(GAMEMODE.AmmoTypes) do
		if v.ammoType == args then
			found = v
			break
		end
	end

	if not found or (found.customCheck and not found.customCheck(ply)) then
		ply:notify( found and found.CustomCheckFailMsg or DarkRP.getPhrase("unavailable", "ammo"))
		return ""
	end

	if not ply:CanAfford(found.price) then
		ply:notify( DarkRP.getPhrase("cant_afford", "ammo"))
		return ""
	end

	ply:notify( DarkRP.getPhrase("you_bought_x", found.name, GAMEMODE.Config.currency..tostring(found.price)))
	ply:AddMoney(-found.price)

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)

	local ammo = ents.Create("spawned_weapon")
	ammo:SetModel(found.model)
	ammo.ShareGravgun = true
	ammo:SetPos(tr.HitPos)
	ammo.nodupe = true
	function ammo:PlayerUse(user, ...)
		user:GiveAmmo(found.amountGiven, found.ammoType)
		self:Remove()
		return true
	end
	ammo:Spawn()

	return ""
end
AddChatCommand("/buyammo", BuyAmmo, 1)


/*---------------------------------------------------------
 Jobs
 ---------------------------------------------------------*/
local function CreateAgenda(ply, args)
	if DarkRPAgendas[ply:Team()] then
		ply:SetDarkRPVar("agenda", args)

		ply:notify( DarkRP.getPhrase("agenda_updated"))
		for k,v in pairs(DarkRPAgendas[ply:Team()].Listeners) do
			for a,b in pairs(team.GetPlayers(v)) do
				GAMEMODE:Notify(b, 2, 4, DarkRP.getPhrase("agenda_updated"))
			end
		end
	else
		ply:notify( DarkRP.getPhrase("unable", "agenda", "Incorrect team"))
	end
	return ""
end
--AddChatCommand("/agenda", CreateAgenda, 0.1)

local function ChangeJob(ply, args)
	if args == "" then
		ply:notify(DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if ply:isArrested() then
		ply:notify(DarkRP.getPhrase("unable", "/job", ""))
		return ""
	end

	if ply:GetNWString("usergroup") != "vip" and !ply:IsAdmin() then
		ply:notify("/job is a VIP only feature.")
		return ""
	end


	if ply.LastJob and 4 - (CurTime() - ply.LastJob) >= 0 then
	--	ply:notify( DarkRP.getPhrase("have_to_wait", math.ceil(4 - (CurTime() - ply.LastJob)), "/job"))
	--	return ""
	end
	--ply.LastJob = CurTime()

	if not ply:Alive() then
		ply:notify(DarkRP.getPhrase("unable", "/job", ""))
		return ""
	end

	if not GAMEMODE.Config.customjobs then
		ply:notify(DarkRP.getPhrase("disabled", "/job", ""))
		return ""
	end

	local len = string.len(args)

	if len < 3 then
		ply:notify(DarkRP.getPhrase("unable", "/job", ">2"))
		return ""
	end

	if len > 25 then
		ply:notify(DarkRP.getPhrase("unable", "/job", "<26"))
		return ""
	end

	local canChangeJob, message, replace = hook.Call("canChangeJob", nil, ply, args)
	if canChangeJob == false then
		ply:notify(message or DarkRP.getPhrase("unable", "/job", ""))
		return ""
	end

	local job = replace or args
	ply:UpdateJob(job)
	return ""
end
AddChatCommand("/job", ChangeJob)

local function FinishDemote(vote, choice)
	local target = vote.target

	target.IsBeingDemoted = nil
	if choice == 1 then
		target:TeamBan()
		if target:Alive() then
			target:ChangeTeam(GAMEMODE.DefaultTeam, true)
			if target:isArrested() then
				target:arrest()
			end
		else
			target.firedWhileDead = true
		end

		GAMEMODE:NotifyAll(0, 4, DarkRP.getPhrase("fired", target:Nick()))
	else
		GAMEMODE:NotifyAll(1, 4, DarkRP.getPhrase("fired_not", target:Nick()))
	end
end

local function Demote(ply, args)
	local tableargs = string.Explode(" ", args)
	if #tableargs == 1 then
		ply:notify(DarkRP.getPhrase("vote_specify_reason"))
		return ""
	end
	local reason = ""
	for i = 2, #tableargs, 1 do
		reason = reason .. " " .. tableargs[i]
	end
	reason = string.sub(reason, 2)
	if string.len(reason) > 99 then
		ply:notify(DarkRP.getPhrase("unable", "/fire", "<100"))
		return ""
	end
	local p = GAMEMODE:FindPlayer(tableargs[1])
	if p == ply then
		ply:notify("Can't fire yourself.")
		return ""
	end

	local canDemote, message = hook.Call("CanDemote", GAMEMODE, ply, p, reason)
	if canDemote == false then
		ply:notify(message or DarkRP.getPhrase("unable", "fire", ""))
		return ""
	end

	if p then
		if CurTime() - ply.LastVoteCop < 20 then
			ply:notify(DarkRP.getPhrase("have_to_wait", math.ceil(20 - (CurTime() - ply:GetTable().LastVoteCop)), "/fire"))
			return ""
		end
		if not RPExtraTeams[p:Team()] or RPExtraTeams[p:Team()].canfire == false then
			ply:notify(DarkRP.getPhrase("unable", "/fire", ""))
		else
			GAMEMODE:TalkToPerson(p, team.GetColor(ply:Team()), "(FIRE) "..ply:Nick(),Color(255,0,0,255), "Was fired, Reason: "..reason, p)
			DB.Log(DarkRP.getPhrase("fire_vote_started", ply:Nick(), p:Nick()) .. " (" .. reason .. ")",
				false, Color(255, 128, 255, 255))
			ply:ChangeTeam( TEAM_CITIZEN, true )


			ply:GetTable().LastVoteCop = CurTime()
		end
		return ""
	else
		GAMEMODE:Notify(DarkRP.getPhrase("could_not_find", "player: "..tostring(args)))
		return ""
	end
end
AddChatCommand("/fire", Demote)
/*
local function ExecSwitchJob(answer, ent, ply, target)
	ply.RequestedJobSwitch = nil
	if not tobool(answer) then return end
	local Pteam = ply:Team()
	local Tteam = target:Team()

	if not ply:ChangeTeam(Tteam) then return end
	if not target:ChangeTeam(Pteam) then
		ply:ChangeTeam(Pteam, true) -- revert job change
		return
	end
	ply:notify( DarkRP.getPhrase("team_switch"))
	GAMEMODE:Notify(target, 2, 4, DarkRP.getPhrase("team_switch"))
end

local function SwitchJob(ply) --Idea by Godness.
	if not GAMEMODE.Config.allowjobswitch then return "" end

	if ply.RequestedJobSwitch then return end

	local eyetrace = ply:GetEyeTrace()
	if not eyetrace or not eyetrace.Entity or not eyetrace.Entity:IsPlayer() then return "" end
	ply.RequestedJobSwitch = true
	GAMEMODE.ques:Create("Switch job with "..ply:Nick().."?", "switchjob"..tostring(ply:EntIndex()), eyetrace.Entity, 30, ExecSwitchJob, ply, eyetrace.Entity)
	ply:notify( DarkRP.getPhrase("created_x", "You", "job switch request."))
	return ""
end
AddChatCommand("/switchjob", SwitchJob)
AddChatCommand("/switchjobs", SwitchJob)
AddChatCommand("/jobswitch", SwitchJob)

*/
local function DoTeamBan(ply, args, cmdargs)
	if not args or args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "arguments", ""))
		return ""
	end

	args = cmdargs or string.Explode(" ", args)
	local ent = args[1]
	local Team = args[2]
	if cmdargs and not cmdargs[1]  then
		ply:PrintMessage(HUD_PRINTNOTIFY, "rp_teamban [player name/ID] [team name/id] Use this to ban a player from a certain team")
		return
	end

	local target = GAMEMODE:FindPlayer(ent)
	if not target or not IsValid(target) then
		ply:notify( DarkRP.getPhrase("could_not_find", "player!"))
		return ""
	end

	if (not FAdmin or not FAdmin.Access.PlayerHasPrivilege(ply, "rp_commands", target)) and not ply:IsAdmin() then
		ply:notify( DarkRP.getPhrase("need_admin", "/teamban"))
		return ""
	end

	local found = false
	for k,v in pairs(RPExtraTeams) do
		if string.lower(v.name) == string.lower(Team) or string.lower(v.command) == string.lower(Team) or k == tonumber(Team or -1) then
			Team = k
			found = true
			break
		end
	end

	if not found then
		ply:notify( DarkRP.getPhrase("could_not_find", "job!"))
		return ""
	end

	target:TeamBan(tonumber(Team), tonumber(args[3] or 0))
	GAMEMODE:NotifyAll(0, 5, ply:Nick() .. " has banned " ..target:Nick() .. " from being a " .. team.GetName(tonumber(Team)))
	return ""
end
AddChatCommand("/teamban", DoTeamBan)
concommand.Add("rp_teamban", DoTeamBan)

local function DoTeamUnBan(ply, args, cmdargs)
	if not ply:IsAdmin() then
		ply:notify( DarkRP.getPhrase("need_admin", "/teamunban"))
		return ""
	end

	local ent = args
	local Team = args
	if cmdargs then
		if not cmdargs[1] then
			ply:PrintMessage(HUD_PRINTNOTIFY, "rp_teamunban [player name/ID] [team name/id] Use this to unban a player from a certain team")
			return ""
		end
		ent = cmdargs[1]
		Team = cmdargs[2]
	else
		local a,b = string.find(args, " ")
		ent = string.sub(args, 1, a - 1)
		Team = string.sub(args, a + 1)
	end

	local target = GAMEMODE:FindPlayer(ent)
	if not target or not IsValid(target) then
		ply:notify( DarkRP.getPhrase("could_not_find", "player!"))
		return ""
	end

	local found = false
	for k,v in pairs(RPExtraTeams) do
		if string.lower(v.name) == string.lower(Team) or  string.lower(v.command) == string.lower(Team) then
			Team = k
			found = true
			break
		end
		if k == tonumber(Team or -1) then
			found = true
			break
		end
	end

	if not found then
		ply:notify( DarkRP.getPhrase("could_not_find", "job!"))
		return ""
	end
	if not target.bannedfrom then target.bannedfrom = {} end
	target.bannedfrom[tonumber(Team)] = nil
	GAMEMODE:NotifyAll(1, 5, ply:Nick() .. " has unbanned " ..target:Nick() .. " from being a " .. team.GetName(tonumber(Team)))
	return ""
end
AddChatCommand("/teamunban", DoTeamUnBan)
concommand.Add("rp_teamunban", DoTeamUnBan)

/*---------------------------------------------------------
Talking
 ---------------------------------------------------------*/
local function PM(ply, args)
	local namepos = string.find(args, " ")
	if not namepos then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	local name = string.sub(args, 1, namepos - 1)
	local msg = string.sub(args, namepos + 1)
	if msg == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	target = GAMEMODE:FindPlayer(name)

	if target then
	GAMEMODE:TalkToPerson(target, Color(45,154,6), "(PM) "..ply:Nick(), Color(45,154,6), msg, ply)
	ply:ApexChat([[Color(45,154,6), "(PM SENT) ", plyNAME, ": ", message ]], ply, msg)
	ply:ConCommand("play buttons/blip1.wav")
	target:ConCommand("play buttons/blip1.wav")
		--GAMEMODE:TalkToPerson(target, col, "(PM) "..ply:Nick(), Color(255,255,255,255), msg, ply)
		--GAMEMODE:TalkToPerson(ply, col, "(PM) "..ply:Nick(), Color(255,255,255,255), msg, ply)
	else
		ply:notify( DarkRP.getPhrase("could_not_find", "player: "..tostring(name)))
	end

	return ""
end
AddChatCommand("/pm", PM, 1.5)

local function Whisper(ply, args)
	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return ""
		end
		for v,k in pairs(ents.FindInSphere(ply:GetPos(),90)) do
		if k:IsPlayer() then
		k:ApexChat([[Color(0,102,204), plyNAME, " whispers",  ": ", message]], ply, args)
		--k:ApexChat([[Color(0,76,153), "[WHISPER] ", teamCOL, plyNAME, Color(255,255,255), ": ", Color(0,76,153), message]], ply, args)
		end
		end
	end
	return args, DoSay
end
AddChatCommand("/w", Whisper, 1.5)

local function Yell(ply, args)
	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return ""
		end
		--GAMEMODE:TalkToRange(ply, "(".. DarkRP.getPhrase("yell") .. ") " .. ply:Nick(), text, 550)
		for v,k in pairs(ents.FindInSphere(ply:GetPos(),550)) do
		if k:IsPlayer() then
		k:ApexChat([[Color(255,128,0), plyNAME, " yells",  ": ", message]], ply, args)
		--k:ApexChat([[Color(0,76,153), "[WHISPER] ", teamCOL, plyNAME, Color(255,255,255), ": ", Color(0,76,153), message]], ply, args)
		end
		end
	end
	return args, DoSay
end
AddChatCommand("/y", Yell, 1.5)

local function Me(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return ""
		end
		if GAMEMODE.Config.alltalk then
			for _, target in pairs(player.GetAll()) do
				GAMEMODE:TalkToPerson(target, team.GetColor(ply:Team()), ply:Nick() .. " " .. text)
			end
		else
				for v,k in pairs(ents.FindInSphere(ply:GetPos(),550)) do
		       if k:IsPlayer() then
		      k:ApexChat([[Color(255,255,102),"** ", plyNAME, " ", message]], ply, args)
		end
		end
			--GAMEMODE:TalkToRange(ply, ply:Nick() .. " " .. text, "", 250)
		end
	end
	return args, DoSay
end
AddChatCommand("/me", Me, 1.5)

local oocTags = {
	["superadmin"]	= "Super Admin",
	["admin"]		= "Admin",
	["developer"]	= "Developer",
	["moderator"]	= "Mod",
	["vip"]			= "VIP"
}

hook.Add("PlayerInitialSpawn", "ooc65546565", function(ply)
print("spawninf")
ply.OOCAmount = 10
timer.Create(ply:SteamID64() .. "OOCAmount", 1800, 0, function()
ply.OOCAmount = 10
end)
end)

local function OOC(ply, args)
timeLeft = math.floor(timer.TimeLeft(ply:SteamID64() .. "OOCAmount") / 60)
	if not GAMEMODE.Config.ooc then
		ply:notify( DarkRP.getPhrase("disabled", "OOC", ""))
		return ""
	end

	if GetGlobalInt( "OOCDisabled") and GetGlobalInt( "OOCDisabled") == 1 and not(ply:IsAdmin() or ply:GetNWString("usergroup") == "vip") then
		ply:notify( "OOC is currently disabled.")
		return ""
	end

	prefix = ""
	if (oocTags[ply:GetUserGroup()]) then prefix = ("(" .. oocTags[ply:GetUserGroup()] .. ")") end
if ply.OOCAmount < 1 and not ply:IsUserGroup("vip") and not ply:IsAdmin() then
ply:notify("You are out of OOC Messages for ".. timeLeft.. " minutes." )
return ""
end
	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return ""
		end
		local col = team.GetColor(ply:Team())
		local col2 = Color(255,255,255,255)
		if not ply:Alive() then
			col2 = Color(255,200,200,255)
			col = col2
		end

                                                if not ply:IsUserGroup("vip") and not ply:IsAdmin() then
                                                ply.OOCAmount = ply.OOCAmount - 1
                                                ply:notify("You have ".. tostring(ply.OOCAmount).. " OOC messages left for ".. timeLeft.. " minutes.")
                                                end
		--for k,v in pairs(player.GetAll()) do
		--	GAMEMODE:TalkToPerson(v, col, prefix.."(OOC) "..ply:Name().."", col2, text, ply)
		--end
		--ApexChat("hi")
		text = tostring(text)
		--ApexNetworkMessage()
		--ApexNetworkMessage(text)
		for k,v in pairs(player.GetAll()) do
		v:ApexChat([[Color( 200, 0, 0 ), "[OOC] ", prefixc, steamNAME, ": ", Color( 255, 220, 220 ), message]], ply, text)
		end
	end
	return args, DoSay
end
AddChatCommand("//", OOC, true, 1.5)
AddChatCommand("/a", OOC, true, 1.5)
AddChatCommand("/ooc", OOC, true, 1.5)



local function PlayerAdvertise(ply, args)
	if args == "" then return "" end
	local DoSay = function(text)
		if text == "" then return end
		ply:notify( string.format("Your announcement has been sent and will be displayed shortly."))
		for k,v in pairs(player.GetAll()) do
			local col = team.GetColor(ply:Team())
			timer.Simple( 15, function()

			v:ApexChat([[Color(226,162,13), "[ADVERT] ", teamCOL, plyNAME, Color(255,255,255),": ", message]], ply, text)
			end )
			--GAMEMODE:TalkToPerson(v, col, LANGUAGE.advert .." "..ply:Nick(), Color(255,255,0,255), text, ply)
		end
	end
	return args, DoSay
end
AddChatCommand("/announce", PlayerAdvertise)
AddChatCommand("/advert", PlayerAdvertise)

local function SetRadioChannel(ply,args)
	if tonumber(args) == nil or tonumber(args) < 0 or tonumber(args) > 100 then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", "0<channel<100"))
		return ""
	end
	ply:notify( "Channel set to "..args.."!")
	ply.RadioChannel = tonumber(args)
	return ""
end
AddChatCommand("/channel", SetRadioChannel)

local function MayorBroadcast(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local pos = ply:GetPos();
	local station = GetConfig().Broadcast
	if pos:Distance(station) > 100 then ply:notify( "You have to infront of the broadcast station.") return "" end
	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return
		end
		for k,v in pairs(player.GetAll()) do
			local col = Color(150, 20, 20, 255)
			GAMEMODE:TalkToPerson(v, col, "[Broadcast] " ..ply:Nick(), Color(170, 0, 0,255), text, ply)
		end
	end
	return args, DoSay
end
AddChatCommand("/broadcast", MayorBroadcast, 1.5)

local function SetRadioChannel(ply,args)
	if tonumber(args) == nil or tonumber(args) < 0 or tonumber(args) > 100 then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", "0<channel<100"))
		return ""
	end
	ply:notify( "Channel set to "..args.."!")
	ply.RadioChannel = tonumber(args)
	return ""
end
AddChatCommand("/channel", SetRadioChannel)

local function SayThroughRadio(ply,args)
if ply:IsCP() then ply:ConCommand("say_team "..args) return false end
	if not ply.RadioChannel then ply.RadioChannel = 1 end
	if not args or args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return
		end
		for k,v in pairs(player.GetAll()) do
			if v.RadioChannel == ply.RadioChannel then
				GAMEMODE:TalkToPerson(v, Color(180,180,180,255), "Radio ".. tostring(ply.RadioChannel), Color(180,180,180,255), text, ply)
			end
		end
	end
	return args, DoSay
end
AddChatCommand("/radio", SayThroughRadio, 1.5)

local function GroupMsg(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if not (ply:IsCP()) then
		ply:notify( "Only Civil Protection can use the radio.")
		return ""
	end

	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return
		end

		local t = ply:Team()
		local col = team.GetColor(ply:Team())

		local hasReceived = {}
		for _, func in pairs(GAMEMODE.DarkRPGroupChats) do
			-- not the group of the player
			if not func(ply) then continue end

			for _, target in pairs(player.GetAll()) do
				if func(target) and not hasReceived[target] then
					hasReceived[target] = true
					target:ApexChat([[Color(55,146,21),"[RADIO] ", plyNAME, ": ", message ]], ply, text)--GAMEMODE:TalkToPerson(target, col, "(Radio)" .. " " .. ply:Nick(), Color(255,255,255,255), text, ply)
				end
			end
		end
		if next(hasReceived) == nil then
			ply:notify( DarkRP.getPhrase("unable", "/g", ""))
		end
	end
	return args, DoSay
end
AddChatCommand("/g", GroupMsg, 1.5)


local function DispatchMsg(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if not (ply:IsDispatch()) then
		ply:notify( "Only Dispatch units can use the dispatch radio.")
		return ""
	end

	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return
		end

		local t = ply:Team()
		local col = team.GetColor(ply:Team())

		local hasReceived = {}
		for _, func in pairs(GAMEMODE.DarkRPGroupChats) do
			-- not the group of the player
			if not func(ply) then continue end

			for _, target in pairs(player.GetAll()) do
				if not hasReceived[target] then
					hasReceived[target] = true
					text2 = hook.Call("DispatchTalk", nil, ply, text)
					if text2 then text = text2 end

					GAMEMODE:TalkToPerson(target, col, "(Dispatch)" .. " " .. ply:Nick(), Color(255,255,255,255), text, ply)
				end
			end
		end
		if next(hasReceived) == nil then
			ply:notify( DarkRP.getPhrase("unable", "/g", ""))
		end
	end
	return args, DoSay
end
AddChatCommand("/dispatch", DispatchMsg, 1.5)

local function DispatchRadioMsg(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if not (ply:Team() == TEAM_DISPATCH) then
		ply:notify( "Only Dispatch units can use the dispatch radio.")
		return ""
	end

	local DoSay = function(text)
		if text == "" then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
			return
		end

		local t = ply:Team()
		local col = team.GetColor(ply:Team())

		local hasReceived = {}
		for _, func in pairs(GAMEMODE.DarkRPGroupChats) do
			-- not the group of the player
			if not func(ply) then continue end

			for _, target in pairs(player.GetAll()) do
			if target:Team() == TEAM_CP or target:Team() == TEAM_OVERWATCH or target:Team() == TEAM_ADMINISTRATOR or target:Team() == TEAM_DISPATCH then 
				if not hasReceived[target] then
					hasReceived[target] = true
					text2 = hook.Call("DispatchRadioTalk", nil, ply, text)
					if text2 then text = text2 end

					GAMEMODE:TalkToPerson(target, col, "(<Dispatch>)" .. " " .. ply:Nick(), Color(255,0,0,255), text, ply)
				end
				end
			end
		end
		if next(hasReceived) == nil then
			ply:notify( DarkRP.getPhrase("unable", "/g", ""))
		end
	end
	return args, DoSay
end
AddChatCommand("/dispatchRadio", DispatchRadioMsg, 1.5)

-- here's the new easter egg. Easier to find, more subtle, doesn't only credit FPtje and unib5
-- WARNING: DO NOT EDIT THIS
-- You can edit DarkRP but you HAVE to credit the original authors!
-- You even have to credit all the previous authors when you rename the gamemode.
local CreditsWait = true
local function GetDarkRPAuthors(ply, args)
	local target = GAMEMODE:FindPlayer(args); -- Only send to one player. Prevents spamming
	if not IsValid(target) then
		ply:notify( "Player does not exist")
		return ""
	end

	if not CreditsWait then ply:notify( "Wait with that") return "" end
	CreditsWait = false
	timer.Simple(60, function() CreditsWait = true end)--so people don't spam it

	local rf = RecipientFilter()
	rf:AddPlayer(target)
	if ply ~= target then
		rf:AddPlayer(ply)
	end

	umsg.Start("DarkRP_Credits", rf)
	umsg.End()

	return ""
end
AddChatCommand("/credits", GetDarkRPAuthors, 50)

/*---------------------------------------------------------
 Money
 ---------------------------------------------------------*/
local function GiveMoney(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if not tonumber(args) then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local trace = ply:GetEyeTrace()

	if IsValid(trace.Entity) and trace.Entity:IsPlayer() and trace.Entity:GetPos():Distance(ply:GetPos()) < 150 then
		local amount = math.floor(tonumber(args))

		if amount < 1 then
			ply:notify( DarkRP.getPhrase("invalid_x", "argument", ">=1"))
			return
		end

		if not ply:CanAfford(amount) then
			ply:notify( DarkRP.getPhrase("cant_afford", ""))
			return ""
		end

		local RP = RecipientFilter()
		RP:AddAllPlayers()

		umsg.Start("anim_giveitem", RP)
			umsg.Entity(ply)
		umsg.End()
		ply.anim_GivingItem = true

		timer.Simple(1.2, function()
			if IsValid(ply) then
				local trace2 = ply:GetEyeTrace()
				if IsValid(trace2.Entity) and trace2.Entity:IsPlayer() and trace2.Entity:GetPos():Distance(ply:GetPos()) < 150 then
					if not ply:CanAfford(amount) then
						ply:notify( DarkRP.getPhrase("cant_afford", ""))
						return ""
					end
					DB.PayPlayer(ply, trace2.Entity, amount)

					trace2.Entity:notify( DarkRP.getPhrase("has_given", ply:Nick(), GAMEMODE.Config.currency .. tostring(amount)))
					ply:notify( DarkRP.getPhrase("you_gave", trace2.Entity:Nick(), GAMEMODE.Config.currency .. tostring(amount)))
					DB.Log(ply:Nick().. " (" .. ply:SteamID() .. ") has given "..GAMEMODE.Config.currency .. tostring(amount).. " to "..trace2.Entity:Nick() .. " (" .. trace2.Entity:SteamID() .. ")")
				end
			else
				ply:notify( DarkRP.getPhrase("unable", "/give", ""))
			end
		end)
	else
		ply:notify( DarkRP.getPhrase("must_be_looking_at", "player"))
	end
	return ""
end
AddChatCommand("/give", GiveMoney, 0.2)

local function DropMoney(ply, args)
	if args == "" then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end

	if not tonumber(args) then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ""))
		return ""
	end
	local amount = math.floor(tonumber(args))

	if amount <= 1 then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", ">1"))
		return ""
	end

	if not ply:CanAfford(amount) then
		ply:notify( DarkRP.getPhrase("cant_afford", ""))
		return ""
	end

	ply:AddMoney(-amount)
	local RP = RecipientFilter()
	RP:AddAllPlayers()

	umsg.Start("anim_dropitem", RP)
		umsg.Entity(ply)
	umsg.End()
	ply.anim_DroppingItem = true

	timer.Simple(1, function()
		if IsValid(ply) then
			local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 85
			trace.filter = ply

			local tr = util.TraceLine(trace)
			DarkRPCreateMoneyBag(tr.HitPos, amount)
			DB.Log(ply:Nick().. " (" .. ply:SteamID() .. ") has dropped "..GAMEMODE.Config.currency .. tostring(amount))
		else
			ply:notify( DarkRP.getPhrase("unable", "/dropmoney", ""))
		end
	end)

	return ""
end
AddChatCommand("/dropmoney", DropMoney, 0.3)
AddChatCommand("/moneydrop", DropMoney, 0.3)
AddChatCommand("/droptokens", DropMoney, 0.3)


local function CreateCheque(ply, args)
	local argt = string.Explode(" ", args)
	local recipient = GAMEMODE:FindPlayer(argt[1])
	local amount = tonumber(argt[2]) or 0

	if not recipient then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", "recipient (1)"))
		return ""
	end

	if amount <= 1 then
		ply:notify( DarkRP.getPhrase("invalid_x", "argument", "amount (2)"))
		return ""
	end

	if not ply:CanAfford(amount) then
		ply:notify( DarkRP.getPhrase("cant_afford", ""))
		return ""
	end

	if IsValid(ply) and IsValid(recipient) then
		ply:AddMoney(-amount)
	end

	umsg.Start("anim_dropitem", RecipientFilter():AddAllPlayers())
		umsg.Entity(ply)
	umsg.End()
	ply.anim_DroppingItem = true

	timer.Simple(1, function()
		if IsValid(ply) and IsValid(recipient) then
			local trace = {}
			trace.start = ply:EyePos()
			trace.endpos = trace.start + ply:GetAimVector() * 85
			trace.filter = ply

			local tr = util.TraceLine(trace)
			local Cheque = ents.Create("darkrp_cheque")
			Cheque:SetPos(tr.HitPos)
			Cheque:Setowning_ent(ply)
			Cheque:Setrecipient(recipient)

			Cheque:Setamount(math.Min(amount, 2147483647))
			Cheque:Spawn()
		else
			ply:notify( DarkRP.getPhrase("unable", "/cheque", ""))
		end
	end)
	return ""
end
AddChatCommand("/cheque", CreateCheque, 0.3)
AddChatCommand("/check", CreateCheque, 0.3) -- for those of you who can't spell

local function MakeZombieSoundsAsHobo(ply)
	if not ply.nospamtime then
		ply.nospamtime = CurTime() - 2
	end
	if not RPExtraTeams[ply:Team()] or not RPExtraTeams[ply:Team()].hobo or CurTime() < (ply.nospamtime + 1.3) or (IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() ~= "weapon_bugbait") then
		return
	end
	ply.nospamtime = CurTime()
	local ran = math.random(1,3)
	if ran == 1 then
		ply:EmitSound("npc/zombie/zombie_voice_idle"..tostring(math.random(1,14))..".wav", 100,100)
	elseif ran == 2 then
		ply:EmitSound("npc/zombie/zombie_pain"..tostring(math.random(1,6))..".wav", 100,100)
	elseif ran == 3 then
		ply:EmitSound("npc/zombie/zombie_alert"..tostring(math.random(1,3))..".wav", 100,100)
	end
end
concommand.Add("_hobo_emitsound", MakeZombieSoundsAsHobo)

/*---------------------------------------------------------
 Mayor stuff
 ---------------------------------------------------------*/
local LotteryPeople = {}
local LotteryON = false
local LotteryAmount = 0
local CanLottery = CurTime()
local function EnterLottery(answer, ent, initiator, target, TimeIsUp)
	if tobool(answer) and not table.HasValue(LotteryPeople, target) then
		if not target:CanAfford(LotteryAmount) then
			GAMEMODE:Notify(target, 1,4, DarkRP.getPhrase("cant_afford", "lottery"))
			return
		end
		table.insert(LotteryPeople, target)
		target:AddMoney(-LotteryAmount)
		GAMEMODE:Notify(target, 0,4, DarkRP.getPhrase("lottery_entered", GAMEMODE.Config.currency..tostring(LotteryAmount)))
	elseif answer ~= nil and not table.HasValue(LotteryPeople, target) then
		GAMEMODE:Notify(target, 1,4, DarkRP.getPhrase("lottery_not_entered", "You"))
	end

	if TimeIsUp then
		LotteryON = false
		CanLottery = CurTime() + 60
		if table.Count(LotteryPeople) == 0 then
			GAMEMODE:NotifyAll(1, 4, DarkRP.getPhrase("lottery_noone_entered"))
			return
		end
		local chosen = LotteryPeople[math.random(1, #LotteryPeople)]
		chosen:AddMoney(#LotteryPeople * LotteryAmount)
		GAMEMODE:NotifyAll(0,10, DarkRP.getPhrase("lottery_won", chosen:Nick(), GAMEMODE.Config.currency .. tostring(#LotteryPeople * LotteryAmount) ))
	end
end

local function DoLottery(ply, amount)
	if not RPExtraTeams[ply:Team()] or not RPExtraTeams[ply:Team()].mayor then
		ply:notify( DarkRP.getPhrase("incorrect_job", "/lottery"))
		return ""
	end

	if not GAMEMODE.Config.lottery then
		ply:notify( DarkRP.getPhrase("disabled", "/lottery", ""))
		return ""
	end

	if #player.GetAll() <= 2 or LotteryON then
		ply:notify( DarkRP.getPhrase("unable", "/lottery", ""))
		return ""
	end

	if CanLottery > CurTime() then
		GAMEMODE:Notify(ply, 1, 5, DarkRP.getPhrase("have_to_wait", tostring(CanLottery - CurTime()), "/lottery"))
		return ""
	end

	amount = tonumber(amount)
	if not amount then
		GAMEMODE:Notify(ply, 1, 5, string.format("Please specify an entry cost ($%i-%i)", GAMEMODE.Config.minlotterycost, GAMEMODE.Config.maxlotterycost))
		return ""
	end

	LotteryAmount = math.Clamp(math.floor(amount), GAMEMODE.Config.minlotterycost, GAMEMODE.Config.maxlotterycost)

	GAMEMODE:NotifyAll(0, 4, "A lottery has started!")

	LotteryON = true
	LotteryPeople = {}
	for k,v in pairs(player.GetAll()) do
		if v ~= ply then
			GAMEMODE.ques:Create("There is a lottery! Participate for " ..GAMEMODE.Config.currency.. tostring(LotteryAmount) .. "?", "lottery"..tostring(k), v, 30, EnterLottery, ply, v)
		end
	end
	timer.Create("Lottery", 30, 1, function() EnterLottery(nil, nil, nil, nil, true) end)
	return ""
end
--AddChatCommand("/lottery", DoLottery, 1)


local function DisableOOC(ply)
	if ply:IsAdmin() then
		SetGlobalInt( "OOCDisabled", 1 )
		for k,v in pairs(player.GetAll()) do
			v:notify("OOC has been disabled.")
		end
	end
end
AddChatCommand("/disableooc", DisableOOC, 1)
concommand.Add("rp_disableooc", function(ply) DisableOOC(ply) end)

local function EnableOOC(ply)
	if ply:IsAdmin() then
		SetGlobalInt( "OOCDisabled", 0 )
		for k,v in pairs(player.GetAll()) do
			v:notify("OOC has been enabled again.")
		end
	end
end
AddChatCommand("/enableooc", EnableOOC, 1)
concommand.Add("rp_enableooc", function(ply) EnableOOC(ply) end)

local lstat = false
local wait_lockdown = false

local function WaitLock()
	wait_lockdown = false
	lstat = false
	timer.Destroy("spamlock")
end

function GM:Lockdown(ply)
	if lstat then
		ply:notify( DarkRP.getPhrase("unable", "/lockdown", ""))
		return ""
	end
	if RPExtraTeams[ply:Team()] and RPExtraTeams[ply:Team()].mayor or ply:IsAdmin() then
		for k,v in pairs(player.GetAll()) do
			v:ConCommand("play npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav\n")
		end
		lstat = true
		GAMEMODE:PrintMessageAll(HUD_PRINTTALK , DarkRP.getPhrase("lockdown_started"))
		RunConsoleCommand("DarkRP_LockDown", 1)
		GAMEMODE:NotifyAll(0, 3, DarkRP.getPhrase("lockdown_started"))
	else
		ply:notify( DarkRP.getPhrase("incorrect_job", "/lockdown", ""))
	end
	return ""
end
--concommand.Add("rp_lockdown", function(ply) GAMEMODE:Lockdown(ply) end)
--AddChatCommand("/lockdown", function(ply) GAMEMODE:Lockdown(ply) end)

function GM:UnLockdown(ply)
	if not lstat or wait_lockdown then
		ply:notify( DarkRP.getPhrase("unable", "/unlockdown", ""))
		return ""
	end
	if RPExtraTeams[ply:Team()] and RPExtraTeams[ply:Team()].mayor or ply:IsAdmin() then
		GAMEMODE:PrintMessageAll(HUD_PRINTTALK , DarkRP.getPhrase("lockdown_ended"))
		GAMEMODE:NotifyAll(1, 3, DarkRP.getPhrase("lockdown_ended"))
		wait_lockdown = true
		RunConsoleCommand("DarkRP_LockDown", 0)
		timer.Create("spamlock", 20, 1, function() WaitLock("") end)
	else
		ply:notify( DarkRP.getPhrase("incorrect_job", "/unlockdown", ""))
	end
	return ""
end
--concommand.Add("rp_unlockdown", function(ply) GAMEMODE:UnLockdown(ply) end)
--AddChatCommand("/unlockdown", function(ply) GAMEMODE:UnLockdown(ply) end)