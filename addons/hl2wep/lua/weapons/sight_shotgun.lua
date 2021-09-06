include ( 'ironsight_base.lua' )

if SERVER then
	AddCSLuaFile( "sight_shotgun.lua" )
    SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if CLIENT then
	SWEP.PrintName = "SPAS-12 Shotgun"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.BounceWeaponIcon = false
end

SWEP.Author = "TheVingard"
SWEP.Contact = "apex-roleplay.com"
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.HoldType = "shotgun";

SWEP.Category = "Apex Roleplay | HL2 Weapons"
SWEP.Primary.Sound = Sound( "weapon_Shotgun.Single" )

SWEP.UseHands = true

SWEP.Base = "weapon_base"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFOV = 66

SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Delay = 0.7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Recoil	= 6
SWEP.Primary.PumpSound = "weapons/shotgun/shotgun_cock.wav"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Primary.Cone = 30

SWEP.IronSightsPos = Vector(-9.051, -6.433, 4.219)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:Precache()

	util.PrecacheSound( "Weapon_Shotgun.Empty" )
	util.PrecacheSound( "Weapon_Shotgun.Single" )
	util.PrecacheSound( "Weapon_Shotgun.Reload" )

end

function SWEP:Initialize()



end

function SWEP:SetupDataTables()
   self:DTVar( "Bool", 0, "reloading" )

   --return self.BaseClass.SetupDataTables(self)
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
	local bullet = {}
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos() -- Source
	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet
	bullet.Spread 	= Vector(aimcone, aimcone, 0)	 -- Aim Cone
	bullet.Tracer	= 1 -- Show a tracer on every x bullets
	bullet.Force	= 1 -- Amount of force to give to phys objects
	bullet.Damage	= damage
	bullet.TracerName = "Tracer"
	bullet.AmmoType = "shotgun"
	self.Owner:FireBullets( bullet )
	self:ShootEffects()
end

function SWEP:Think()

	if self.dt.reloading and IsFirstTimePredicted() then
      if self.Owner:KeyDown( IN_ATTACK ) then
         self:FinishReload()
         return
      end

      if self.reloadtimer <= CurTime() then

         if self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
            self:FinishReload()
         elseif self:Clip1() < self.Primary.ClipSize then
            self:PerformReload()
         else
            self:FinishReload()
         end
         return
      end
   end

end

function SWEP:StartReload()
   if self.dt.reloading then
      return false
   end

   self:SetIronsights( false )

   if not IsFirstTimePredicted() then return false end

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   local ply = self.Owner

   if not ply or ply:GetAmmoCount( self.Primary.Ammo ) <= 0 then
      return false
   end

   local wep = self

   if wep:Clip1() >= self.Primary.ClipSize then
      return false
   end

   wep:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )

   self:EmitSound( "Weapon_Shotgun.Reload" )

   self.reloadtimer =  CurTime() + wep:SequenceDuration()

   --wep:SetNWBool( "reloading", true )
   self.dt.reloading = true

   return true
end

function SWEP:PerformReload()
   local ply = self.Owner

   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if not ply or ply:GetAmmoCount( self.Primary.Ammo ) <= 0 then return end

   if self:Clip1() >= self.Primary.ClipSize then return end

   self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
   self:SetClip1( self:Clip1() + 1 )

   self:SendWeaponAnim( ACT_VM_RELOAD )

   self.reloadtimer = CurTime() + self:SequenceDuration()
end

function SWEP:FinishReload()
   self.dt.reloading = false
   self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )

   self.reloadtimer = CurTime() + self:SequenceDuration()
end


function SWEP:CanPrimaryAttack()
	if ( self:Clip1() <= 0 ) then
		self:EmitSound( "Weapon_Shotgun.Empty" )
		self:Reload()
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		return false
	end
	return true
end

function SWEP:Reload()
   if self.dt.reloading then return end

   if not IsFirstTimePredicted() then return end

   if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

      if self:StartReload() then
         return
      end
   end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self:SetNextPrimaryFire( CurTime() + .01 )
	self:ShootBullet( 12.3, 7, .099 )
	self:EmitSound( "Weapon_Shotgun.Single" )
	if (self.Owner:Crouching()) then
		self.Owner:ViewPunch( Angle(-.5, 0, 0 ) )
	else
		self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	end


	pumpTime = CurTime() + 0.3
	pump = true

	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch(Angle( -self.Primary.Recoil, 0, 0 ))
	if (self.Primary.TakeAmmoPerBullet) then
		self:TakePrimaryAmmo(self.Primary.NumShots)
	else
		self:TakePrimaryAmmo(1)
	end
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )


end

function SWEP:Deploy()
   self.dt.reloading = false
   self.reloadtimer = 0
   return self.BaseClass.Deploy( self )
end
