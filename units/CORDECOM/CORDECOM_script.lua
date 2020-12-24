
local TACommander = import('/mods/SCTA-master/lua/TAconstructor.lua').TACommander
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local TADGun = import('/mods/SCTA-master/lua/TAweapon.lua').TADGun

CORDECOM = Class(TACommander) {

	Weapons = {
		COMLASER = Class(TAweapon) {
		},
		DGun = Class(TADGun) {
			OnWeaponFired = function(self)
				self.unit:SetWeaponEnabledByLabel('AutoDGun', false)
				TADGun.OnWeaponFired(self)
			end,
		},		
		AutoDGun = Class(TADGun) {
			OnWeaponFired = function(self)
				self.unit:SetWeaponEnabledByLabel('DGun', false)
				TADGun.OnWeaponFired(self)
			end,
		},
	},
}

TypeClass = CORDECOM