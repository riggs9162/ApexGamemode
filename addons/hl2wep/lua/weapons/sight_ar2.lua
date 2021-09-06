include ( 'ironsight_base.lua' )

if SERVER then
	AddCSLuaFile( "sight_ar2.lua" )
    SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if CLIENT then
	SWEP.PrintName = "Overwatch Standard Issue Pulse Rifle"
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

SWEP.Category = "Apex Roleplay | HL2 Weapons"

SWEP.UseHands = true

SWEP.Base = "weapon_base"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/v_IRifle.mdl"
SWEP.WorldModel = "models/weapons/w_IRifle.mdl"
SWEP.ViewModelFOV = 66

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Primary.Cone = 0.02

SWEP.IronSightsPos = Vector(-5.829, -4.422, 2.21)
SWEP.IronSightsAng = Vector(0, 0, 0)


function SWEP:Precache()

	util.PrecacheSound( "Weapon_Pistol.Empty" )
	util.PrecacheSound( "Weapon_AR2.Single" )
	util.PrecacheSound( "Weapon_AR2.Reload" )
	util.PrecacheSound( "Weapon_AR2.Burst" )

end

function SWEP:Initialize()
	self:SetWeaponHoldType( "ar2" )
end

function SWEP:Reload()
	self:SetIronsights( false )
	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		self:DefaultReload( ACT_VM_RELOAD )
		self:EmitSound( "Weapon_AR2.Reload" )
	end
end

function SWEP:ShootBullet(damage, num_bullets, aimcone)

	local bullet = {}
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos() -- Source
	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet
	bullet.Spread 	= Vector(aimcone, aimcone, 0)	 -- Aim Cone
	bullet.Tracer	= 1 -- Show a tracer on every x bullets
	bullet.Force	= 1 -- Amount of force to give to phys objects
	bullet.TracerName = "AR2Tracer"
	bullet.Damage	= damage
	bullet.AmmoType = ""

	self:TakePrimaryAmmo(1)
	self.Owner:FireBullets( bullet )
	self:ShootEffects()
end

function SWEP:Think()

end

function SWEP:CanPrimaryAttack()
	if ( self:Clip1() <= 0 ) then
		self:EmitSound( "Weapon_AR2.Empty" )
		self:SetIronsights( false )
		self:Reload()
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		return false
	end
	return true
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

		self:SetNextPrimaryFire(CurTime() + .13)
		self:EmitSound( "Weapon_AR2.Single" )
		self:ShootBullet(10, 1, .03)

	if (self.Owner:Crouching()) then
		self.Owner:ViewPunch( Angle( -.5, 0, 0 ) )
	else
		self.Owner:ViewPunch( Angle( -.9, 0, 0 ) )
	end
end

