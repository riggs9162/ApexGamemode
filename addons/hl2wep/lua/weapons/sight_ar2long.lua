include ( 'ironsight_base.lua' )

if SERVER then
	AddCSLuaFile( "sight_ar2long.lua" )
    SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if CLIENT then
	SWEP.PrintName = "Overwatch Specialist Issue Pulse Rifle"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = false
	SWEP.BounceWeaponIcon = false
	SWEP.WElements = {
	["sight2"] = { type = "Model", model = "models/Items/battery.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, -0.519, -5.715), angle = Angle(-10.52, 10.519, 180), size = Vector(0.367, 0.367, 0.367), color = Color(52, 57, 42, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight"] = { type = "Model", model = "models/Items/Flare.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.791, 0.518, -8.832), angle = Angle(1.169, -57.273, -24.546), size = Vector(0.95, 0.95, 0.95), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} }
}

    SWEP.VElements = {
	["sight2"] = { type = "Model", model = "models/Items/Flare.mdl", bone = "Base", rel = "", pos = Vector(0.518, -3.201, 2.596), angle = Angle(40.909, -3.507, 54.935), size = Vector(0.432, 0.172, 0.497), color = Color(166, 190, 253, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
	["sight"] = { type = "Model", model = "models/Items/battery.mdl", bone = "Base", rel = "", pos = Vector(0, -0.519, 1.557), angle = Angle(94.675, -174.157, 82.986), size = Vector(0.237, 0.237, 0.301), color = Color(19, 57, 85, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

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
	bullet.TracerName = "AR2Tracer"
	bullet.Force	= 1 -- Amount of force to give to phys objects
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
		self:ShootBullet(12, 1, .02)

	if (self.Owner:Crouching()) then
		self.Owner:ViewPunch( Angle( -.5, 0, 0 ) )
	else
		self.Owner:ViewPunch( Angle( -.9, 0, 0 ) )
	end
end
