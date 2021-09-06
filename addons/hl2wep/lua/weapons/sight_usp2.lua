include ( 'ironsight_base.lua' )

if SERVER then
	AddCSLuaFile( "ironsight_pistol.lua" )
    SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if CLIENT then
	SWEP.PrintName = "USP Match Pistol 2"
	SWEP.Slot = 1
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

SWEP.HoldType = "pistol";

SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = 18
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Primary.Cone = 0.02


function SWEP:Precache()

	util.PrecacheSound( "Weapon_Pistol.Empty" )
	util.PrecacheSound( "Weapon_Pistol.Single" )
	util.PrecacheSound( "Weapon_Pistol.Reload" )

end

function SWEP:Initialize()

end

function SWEP:ShootBullet(damage, num_bullets, aimcone)
	local bullet = {}
	bullet.Num 	= num_bullets
	bullet.Src 	= self.Owner:GetShootPos() -- Source
	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet
	bullet.Spread 	= Vector(aimcone, aimcone, 0)	 -- Aim Cone
	bullet.Tracer	= 1 -- Show a tracer on every x bullets
	bullet.Force	= 1 -- Amount of force to give to phys objects
	bullet.Damage	= 12
	bullet.AmmoType = "pistol"
	bullet.TracerName = "Tracer"
	self.Owner:FireBullets( bullet )
	self:ShootEffects()
end

function SWEP:Think()
end

function SWEP:CanPrimaryAttack()
	if ( self:Clip1() <= 0 ) then
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:Reload()
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
		return false
	end
	return true
end

function SWEP:Reload()
	self:SetIronsights( false )
	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		self:DefaultReload( ACT_VM_RELOAD )
		self:EmitSound( "Weapon_Pistol.Reload" )
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	self:SetNextPrimaryFire( CurTime() + .01 )
	self:ShootBullet( 8.7, 1, .03 )
	self:EmitSound( "Weapon_USP.Single" )
	if (self.Owner:Crouching()) then
		self.Owner:ViewPunch( Angle(-.5, 0, 0 ) )
	else
		self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	end
	self:TakePrimaryAmmo(1)
end

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true

SWEP.ViewModel = "models/apexwep/weapons/v_zistol.mdl"
SWEP.WorldModel = "models/apexwep/weapons/w_zistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {}


SWEP.IronSightsPos = Vector(-3.881, 0, 2.24)
SWEP.IronSightsAng = Vector(0, 0, 0)

