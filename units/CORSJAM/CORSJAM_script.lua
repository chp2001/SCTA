#CORE Deleter - Mobile Radar Jammer
#CORETER
#
#Script created by Raevn

local TASeaCounter = import('/mods/SCTA-master/lua/TAMotion.lua').TASeaCounter
local DefaultWeapon = import('/lua/sim/DefaultWeapons.lua').DefaultProjectileWeapon

CORSJAM = Class(TASeaCounter) {
	OnCreate = function(self)
		TASeaCounter.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'fork', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TASeaCounter.OnStopBeingBuilt(self,builder,layer)
		--spin fork around z-axis speed <100>
		self.Spinners.fork:SetSpeed(100)
	end,


	OnIntelDisabled = function(self)
		self.Spinners.fork:SetSpeed(0)
	TASeaCounter.OnIntelDisabled(self)
end,


OnIntelEnabled = function(self)
	self.Spinners.fork:SetSpeed(100)
	TASeaCounter.OnIntelEnabled(self)
end,

Weapons = {
	Turret01 = Class(DefaultWeapon) {
	},
},
}
TypeClass = CORSJAM