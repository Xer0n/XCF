	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType			= "grenade"

if (CLIENT) then
	
	SWEP.PrintName			= "ACF Smoke Grenade"
	SWEP.Author				= "Bubbus"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.IconLetter			= "f"
	SWEP.DrawCrosshair		= false
	SWEP.Purpose		= "420 blaze it #yolo"
	SWEP.Instructions       = "Reload at Bomb Ammo-boxes!"

end

util.PrecacheSound( "weapons/launcher_fire.wav" )

SWEP.Base				= "weapon_acf_grenade"
SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV       = 65

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.Category			= "ACF"
SWEP.ViewModel 			= "models/weapons/v_eq_smokegrenade.mdl"
SWEP.WorldModel 		= "models/weapons/w_eq_smokegrenade.mdl"
SWEP.ThrowModel 		= "models/weapons/w_eq_smokegrenade_thrown.mdl"
SWEP.ViewModelFlip		= true

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Recoil			= 5
SWEP.Primary.ClipSize		= -1
SWEP.Primary.Delay			= 3
SWEP.Primary.DefaultClip	= 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Grenade"
SWEP.Primary.Sound 			= "Weapon_Grenade.Fire"

SWEP.ReloadTime				= 3

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.AimOffset = Vector(32, 8, -1)

SWEP.ScopeChopPos = false
SWEP.ScopeChopAngle = false
SWEP.WeaponBone = false//"v_weapon.aug_Parent"

SWEP.MinInaccuracy = 4
SWEP.MaxInaccuracy = 16
SWEP.Inaccuracy = SWEP.MaxInaccuracy
SWEP.InaccuracyDecay = 0.2
SWEP.AccuracyDecay = 0.7
SWEP.InaccuracyPerShot = 12
SWEP.InaccuracyCrouchBonus = 1
SWEP.InaccuracyDuckPenalty = 4

SWEP.Stamina = 1
SWEP.StaminaDrain = 0.004
SWEP.StaminaJumpDrain = 0.07

SWEP.Class = "MG"
SWEP.FlashClass = "MG"
SWEP.Launcher = false