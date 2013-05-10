	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "ar2"

if (CLIENT) then
	
	SWEP.PrintName			= "ACF Shotgun"
	SWEP.Author				= "Bubbus"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= false
	SWEP.Purpose		= "Make holes in nearby dudes."
	SWEP.Instructions       = "Reload at 12.7mm MG Ammo-boxes!"

end

util.PrecacheSound( "weapons/launcher_fire.wav" )

SWEP.Base				= "weapon_acf_base"
SWEP.ViewModelFlip			= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ACF"
SWEP.ViewModel 			= "models/weapons/v_shot_xm1014.mdl";
SWEP.WorldModel 		= "models/weapons/w_shot_xm1014.mdl";
SWEP.ViewModelFlip		= true

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Recoil			= 2
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Delay			= 0.6
SWEP.Primary.DefaultClip	= 100
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "XBowBolt"
SWEP.Primary.Sound 			= "Weapon_XM1014.Single"

SWEP.ReloadTime				= 0.8

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AimOffset = Vector(32, 8, -1)

SWEP.ScopeChopPos = false
SWEP.ScopeChopAngle = false
SWEP.WeaponBone = false//"v_weapon.aug_Parent"

SWEP.MinInaccuracy = 0.5
SWEP.MaxInaccuracy = 4
SWEP.Inaccuracy = SWEP.MaxInaccuracy
SWEP.InaccuracyDecay = 0.15
SWEP.AccuracyDecay = 0.3
SWEP.InaccuracyPerShot = 2
SWEP.InaccuracyCrouchBonus = 2
SWEP.InaccuracyDuckPenalty = 1

SWEP.ShotSpread = 3

SWEP.Stamina = 1
SWEP.StaminaDrain = 0.004
SWEP.StaminaJumpDrain = 0.1

SWEP.Class = "MG"
SWEP.FlashClass = "MG"
SWEP.Launcher = false




function SWEP:ThinkBefore()
	if self.Owner:KeyDown(IN_ATTACK) and self.Weapon:GetNetworkedBool( "reloading", false ) then
		if self.Weapon:Clip1() > 0 and self.Weapon:Clip1() < self.Primary.ClipSize then
			//print("cancelled")
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
			self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
			self.Weapon:SetNetworkedBool( "reloading", false )
		end
	end
end




function SWEP:Reload()
	if self.Weapon:GetNetworkedBool( "reloading", false ) then return end
	
	if self.Zoomed then return false end

	if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
		if SERVER then
			self.Weapon:SetNetworkedBool( "reloading", true )
			timer.Simple(self.ReloadTime, function() self:ReloadShell() end)
			self.Owner:DoReloadEvent()
		end

		//print("do shotgun reload!")
		
		self.Weapon:SetNetworkedBool( "reloading", true )
		//self.Weapon:SetVar( "reloadtimer", CurTime() + self.ReloadTime )
		self.Owner:DoReloadEvent()
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
		
		self.Inaccuracy = self.MaxInaccuracy
	end
end


function SWEP:ReloadShell()
	if not self.Weapon:GetNetworkedBool( "reloading", false ) then return end
	
	if self.Weapon:Clip1() >= self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 then
		self.Weapon:SetNetworkedBool( "reloading", false )
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH )
		self.Owner:DoReloadEvent()
		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		return
	end

	timer.Simple(self.ReloadTime, function() self:ReloadShell() end)
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
	self.Owner:DoReloadEvent()

	if SERVER then
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
		self.Weapon:SetClip1( self.Weapon:Clip1() + 1 )
	end
end