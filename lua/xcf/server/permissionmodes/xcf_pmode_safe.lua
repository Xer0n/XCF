/**
	XCF Permission mode: Safe
		This mode completely disables damage upon everything.
//*/


// the name for this mode used in commands and identification
local modename = "safe"

// a short description of what the mode does
local modedescription = "Completely disables damage upon everything."


/*
	Defines the behaviour of XCF damage protection under this protection mode.
	This function is called every time an entity can be affected by potential ACF damage.
	Args;
		owner		Player:	The owner of the potentially-damaged entity
		attacker	Player:	The initiator of the ACF damage event
		ent			Entity:	The entity which may be damaged.
	Return: boolean
		true if the entity should be damaged, false if the entity should be protected from the damage.
//*/
local function modepermission(owner, attacker, ent)	
	return false
end


if not XCF or not XCF.Permissions or not XCF.Permissions.RegisterMode then error("XCF: Tried to load the " .. modename .. " permission-mode before the permission-core has loaded!") end
XCF.Permissions.RegisterMode(modepermission, modename, modedescription)