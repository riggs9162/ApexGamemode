AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent. 
include('shared.lua')
 

function ENT:Initialize()
 
	self:SetModel( "models/props/de_inferno/wine_barrel.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType(SOLID_VPHYSICS)   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
	--self:SetMaterial( "sprops/trans/misc/ls_m1" )
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.damage = 100;
	self.IsBrewing = false;
	self.Percent = 0;
	self.hasYeast = false;
	self.hasWater = false;

end

function ENT:Use(ply)
	if self.IsBrewing then
		ply:notify("Alcohol brewing is currently at "..self.Percent.."%")
		return
	end

	if not (self.hasYeast or self.hasWater) then
		ply:notify("You have to add yeast and some special water.")
		return
	end
	if not self.hasYeast then
		ply:notify("You have to add yeast to start brewing.")
		return
	end
	if not self.hasWater then
		ply:notify("You have to add some special water start brewing.")
		return
	end

end

function ENT:OnTakeDamage(dmg)
	if self.burningup then return end

	self.damage = (self.damage or 100) - dmg:GetDamage()
	if self.damage <= 0 then
--		local rnd = math.random(1, 10)
			self:BurstIntoFlames()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:BurstIntoFlames()
	self.burningup = true
	local burntime = math.random(8, 18)
	self:Ignite(burntime, 0)
	timer.Simple(burntime, function() self:Fireball() end)
end

function ENT:Fireball()
	if not self:IsOnFire() then self.burningup = false return end
	local dist = math.random(5, 50) -- Explosion radius
	if self.IsBrewing then
	self:Destruct()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
		if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v.IsMoneyPrinter then
			v:Ignite(math.random(5, 22), 0)
		elseif v:IsPlayer() then
			local distance = v:GetPos():Distance(self:GetPos())
			v:TakeDamage(distance / dist * 100, self, self)
		end
	end
	end
	self:Remove()
end

function ENT:Touch( hitEnt )
	if not self.hasYeast then
		if IsValid(hitEnt) and hitEnt:GetClass() == "hl2rp_yeast" then
			self.hasYeast = true;
			SafeRemoveEntity(hitEnt);
			self:CheckBrewing();
			return

		end

	end
	if not self.hasWater then
		if IsValid(hitEnt) and hitEnt:GetClass() == "spawned_food" and hitEnt:GetModel() == "models/props_junk/popcan01a.mdl" and hitEnt:GetTable().FoodEnergy and hitEnt:GetTable().FoodEnergy ==5 then
			self.hasWater = true;
			SafeRemoveEntity(hitEnt);
			self:CheckBrewing();
		end
	end

end

function ENT:CheckBrewing()
	if not self.IsBrewing and self.hasYeast and self.hasWater then
			self.IsBrewing = true;
	end
end

function ENT:Think()
	if self.Percent >= 100 and self.IsBrewing then
			self.IsBrewing = false;
			self.Percent = 0;
			self.hasYeast = false;
			self.hasWater = false;

				local SpawnedFood = ents.Create("hl2rp_alcohol")
				SpawnedFood:SetPos(self:GetPos()+Vector(0,0,60))
				SpawnedFood:Spawn();

	end
	if self.IsBrewing and self.Percent != 100 then
		self.Percent = self.Percent+0.5;
		--print(self.Percent)
	end
	self:NextThink( CurTime() + 1 )
	return true -- Note: You need to return true to override the default next think time
end