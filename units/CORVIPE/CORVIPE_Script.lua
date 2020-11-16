#ARM Ambusher - Pop-up Heavy Cannon
#ARMAMB
#
#Script created by Raevn

local TAPop = import('/mods/SCTA-master/lua/TAunit.lua').TAPop
local TAHide = import('/mods/SCTA-master/lua/TAweapon.lua').TAHide

CORVIPE = Class(TAPop) {

	OnCreate = function(self)
		TAPop.OnCreate(self)
		self:SetWeaponEnabledByLabel('ARMAMB_GUN', false)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAPop.OnStopBeingBuilt(self,builder,layer)
		ForkThread(self.Pack,self)
	end,

	OnDamage = function(self, instigator, amount, vector, damageType)
		TAPop.OnDamage(self, instigator, amount * self.damageReduction, vector, damageType)
	end,

	Pack = function(self)
		TAPop.Pack(self)
		self:SetWeaponEnabledByLabel('ARMAMB_GUN', true)
	end,

	Weapons = {
		ARMAMB_GUN = Class(TAHide) {
			OnWeaponFired = function(self)
				TAHide.OnWeaponFired(self)	
			end,

			PlayFxWeaponUnpackSequence = function(self)
				TAHide.PlayFxWeaponUnpackSequence(self)
			end,	

			PlayFxWeaponPackSequence = function(self)
				TAHide.PlayFxWeaponPackSequence(self)
			end,	
		},
	},
}

TypeClass = CORVIPE
