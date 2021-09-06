SWEP.HoldType = "ar2"

SWEP.ViewModelFOV = 70

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.ViewModel = "models/apexwep/weapons/v_smg4.mdl"

SWEP.WorldModel = "models/apexwep/weapons/w_smg4.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = true

SWEP.ViewModelBoneMods = {}





SWEP.IronSightsPos = Vector(-4.2, 0, 1.559)

SWEP.IronSightsAng = Vector(0, 0, 0)





include ( 'ironsight_base.lua' )



if SERVER then

    SWEP.Weight = 5

	SWEP.AutoSwitchTo = false

	SWEP.AutoSwitchFrom = false

end



if CLIENT then

	SWEP.PrintName = "M4A1 Assault Rifle"

	SWEP.Slot = 2

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





SWEP.Primary.ClipSize = 30

SWEP.Primary.DefaultClip = 40

SWEP.Primary.Automatic = true

SWEP.Primary.Ammo = "smg1"



SWEP.Secondary.ClipSize = -1

SWEP.Secondary.DefaultClip = -1

SWEP.Secondary.Automatic = false

SWEP.Secondary.Ammo = "none"

SWEP.UseHands = true





SWEP.Primary.Cone = 0.01





function SWEP:Precache()



	util.PrecacheSound( "Weapon_Pistol.Empty" )

	util.PrecacheSound( "Weapon_M4A1.Single" )

	util.PrecacheSound( "Weapon_SMG1.Reload" )

	util.PrecacheSound( "Weapon_SMG1.Burst" )



end



function SWEP:Initialize()

	self:SetWeaponHoldType( "ar2" )

end



function SWEP:Reload()

	self:SetIronsights( false )

	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then

		self:DefaultReload( ACT_VM_RELOAD )

		self:EmitSound( "Weapon_SMG1.Reload" )

	end

end



function SWEP:ShootBullet(damage, num_bullets, aimcone)



	local bullet = {}

	bullet.Num 	= num_bullets

	bullet.Src 	= self.Owner:GetShootPos() -- Source

	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet

	bullet.Spread 	= Vector(0.02, 0.02, 0)	 -- Aim Cone

	bullet.TracerName = "Tracer"

	bullet.Tracer	= 1 -- Show a tracer on every x bullets

	bullet.Force	= 1 -- Amount of force to give to phys objects

	bullet.Damage	= 18

	bullet.AmmoType = "smg1"



	self:TakePrimaryAmmo(1)

	self.Owner:FireBullets( bullet )

	self:ShootEffects()

end



function SWEP:Think()



end



function SWEP:CanPrimaryAttack()

	if ( self:Clip1() <= 0 ) then

		self:EmitSound( "Weapon_Pistol.Empty" )

		self:SetIronsights( false )

		self:Reload()

		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )

		return false

	end

	return true

end



function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack() ) then return end



		self:SetNextPrimaryFire(CurTime() + .17)

		self:EmitSound( "Weapon_AUG.Single" )

		self:ShootBullet(30, 1, .01)



	if (self.Owner:Crouching()) then

		self.Owner:ViewPunch( Angle( -.5, 0, 0 ) )

	else

		self.Owner:ViewPunch( Angle( -.9, 0, 0 ) )

	end

end

