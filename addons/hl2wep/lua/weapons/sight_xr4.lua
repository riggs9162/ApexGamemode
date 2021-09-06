SWEP.HoldType = "ar2"

SWEP.ViewModelFOV = 70

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.ViewModel = "models/apexwep/weapons/v_xrifle.mdl"

SWEP.WorldModel = "models/apexwep/weapons/w_xrifle.mdl"

SWEP.ShowViewModel = true

SWEP.ShowWorldModel = true

SWEP.ViewModelBoneMods = {}





SWEP.IronSightsPos = Vector(-3.36, 0, 0.75)

SWEP.IronSightsAng = Vector(0, 0, 0)







include ( 'ironsight_base.lua' )



if SERVER then

    SWEP.Weight = 5

	SWEP.AutoSwitchTo = false

	SWEP.AutoSwitchFrom = false

end



if CLIENT then

	SWEP.PrintName = "Overwatch Standard Issue XR - 4" 

	SWEP.Slot = 2

	SWEP.SlotPos = 3

	SWEP.DrawAmmo = true

	SWEP.DrawCrosshair = false

	SWEP.BounceWeaponIcon = false

end



SWEP.Author = "TheVingard, Nova"

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

SWEP.Primary.Automatic = false

SWEP.Primary.Ammo = "ar2"



SWEP.Secondary.ClipSize = -1

SWEP.Secondary.DefaultClip = -1

SWEP.Secondary.Automatic = false

SWEP.Secondary.Ammo = "none"

SWEP.UseHands = true





SWEP.Primary.Cone = 3

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



	util.PrecacheSound( "Weapon_AR2.Empty" )

	util.PrecacheSound( "Weapon_AR2.Single" )

	util.PrecacheSound( "Weapon_AR2.Reload" )

	util.PrecacheSound( "Weapon_AR2.Burst" )

	util.PrecacheSound("jaanus/ep2sniper_reload.wav")





end



function SWEP:Initialize()

	--self:SetWeaponHoldType( "ar2" )

end



function SWEP:Reload()

	self:SetIronsights( false )

	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then

		self:DefaultReload( ACT_VM_RELOAD )

		self:EmitSound( "jaanus/ep2sniper_reload.wav" )

	end

end

--Bullet code

function SWEP:ShootBullet(damage, num_bullets, aimcone)



	local bullet = {}

	bullet.Num 	= num_bullets

	bullet.Src 	= self.Owner:GetShootPos() -- Source

	bullet.Dir 	= self.Owner:GetAimVector() -- Dir of bullet

	bullet.Spread 	= Vector(0.02, 0.02, 0)	 -- Aim Cone

	bullet.TracerName = "AR2Tracer"

	bullet.Tracer	= 1 -- Show a tracer on every x bullets

	bullet.Force	= 1 -- Amount of force to give to phys objects

	bullet.Damage	= damage

	bullet.AmmoType = "ar2"



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

	elseif self.NextFire and self.NextFire > CurTime() then
		return false

	end

	return true

end

local function Shoot(self)
		if self and IsValid(self) then
		self:EmitSound( "Weapon_AR2.single" )
		self:ShootBullet(28, 1, .01)
	if (self.Owner:Crouching()) then

		self.Owner:ViewPunch( Angle( -.9, 0, 0 ) )

	else

		self.Owner:ViewPunch( Angle( -1, 0, 0 ) )

	end
	    end


end


function SWEP:PrimaryAttack()

	if ( !self:CanPrimaryAttack() ) then return end





		Shoot(self)

		timer.Create("BURSTFIRE-XR4",0.09,2,function()
			Shoot(self)

		end)
		self.NextFire= CurTime() + 0.5




end

