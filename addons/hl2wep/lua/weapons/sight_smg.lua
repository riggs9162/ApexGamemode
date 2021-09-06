include ( 'ironsight_base.lua' )

if SERVER then
	AddCSLuaFile( "sight_smg.lua" )
    SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end

if CLIENT then
	SWEP.PrintName = "MP7 Submachine Gun"
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

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 66

SWEP.Primary.ClipSize = 45
SWEP.Primary.DefaultClip = 45
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Primary.Cone = 0.02

SWEP.IronSightsPos = Vector ( -6.4, -3, 1 )
SWEP.IronSightsAng = Vector ( 0, 0, 1 )

function SWEP:DrawHUD()

	if ( !self.Weapon:GetNetworkedBool( "Ironsights" ) ) then

		local x = ScrW() / 2.0
		local y = ScrH() / 2.0
		local scale = 10 * self.Primary.Cone

		// Scale the size of the crosshair according to how long ago we fired our weapon
		local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
		scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

		surface.SetDrawColor( 0, 255, 0, 255 )

		// Draw an awesome crosshair
		local gap = 40 * scale
		local length = gap + 20 * scale
		surface.DrawLine( x - length, y, x - gap, y )
		surface.DrawLine( x + length, y, x + gap, y )
		surface.DrawLine( x, y - length, x, y - gap )
		surface.DrawLine( x, y + length, x, y + gap )

	else

		local x = ScrW() / 2.0
		local y = ScrH() / 2.0
		local scale = 10 * self.Primary.Cone

		// Scale the size of the crosshair according to how long ago we fired our weapon
		local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
		scale = scale * (2 - math.Clamp( (CurTime() - LastShootTime) * 5, 0.0, 1.0 ))

		//surface.SetDrawColor( 255, 0, 0, 255 )

		// Draw an awesome crosshair
		local gap = 40 * scale
		local length = gap + 20 * scale
		surface.DrawCircle( x, y, 1, Color( 255, 0, 0, 200 ) )
		surface.DrawCircle( x, y, 2.5, Color( 255, 0, 0, 150 ) )
		surface.DrawCircle( x, y, 4, Color( 255, 0, 0, 100 ) )
	end

end

function SWEP:Precache()

	util.PrecacheSound( "Weapon_Pistol.Empty" )
	util.PrecacheSound( "Weapon_SMG1.Single" )
	util.PrecacheSound( "Weapon_SMG1.Reload" )
	util.PrecacheSound( "Weapon_SMG1.Burst" )

end

function SWEP:Initialize()
	self:SetWeaponHoldType( "smg" )
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
	bullet.Spread 	= Vector(aimcone, aimcone, 0)	 -- Aim Cone
	bullet.TracerName = "Tracer"
	bullet.Tracer	= 1 -- Show a tracer on every x bullets
	bullet.Force	= 1 -- Amount of force to give to phys objects
	bullet.Damage	= damage
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

		self:SetNextPrimaryFire(CurTime() + .07)
		self:EmitSound( "Weapon_SMG1.Single" )
		self:ShootBullet(4, 1, .04)

	if (self.Owner:Crouching()) then
		self.Owner:ViewPunch( Angle( -.5, 0, 0 ) )
	else
		self.Owner:ViewPunch( Angle( -.9, 0, 0 ) )
	end
end
