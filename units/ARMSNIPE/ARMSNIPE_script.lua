#ARM Zipper - Fast Attack Kbot
#ARMFAST
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSNIPE = Class(TAunit) {
	cloakOn = false,
	cloakSet = false,

	OnCreate = function(self)
		TAunit.OnCreate(self)
		self:SetScriptBit('RULEUTC_CloakToggle', true)
		ForkThread(self.CloakDetection, self)
	end,

	CloakDetection = function(self)
		while not IsDestroyed(self) and self:IsDead() do
			WaitSeconds(1)
			local pos = self:GetPosition()
			local area = Rect(pos.x - 4, pos.z - 4, pos.x + 4, pos.z + 4)
			local unitsInRect = GetUnitsInRect(area)
			local enemyClose = false
			for k, v in unitsInRect do
				if v != self and v:GetArmy() != self:GetArmy() then
					if self.cloakOn == true then
						self.cloakOn = false
						self:DisableIntel('Cloak')
						self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
					end
					enemyClose = true
				end
			end
			if enemyClose == false then
				if self.cloakSet == true then
					self.cloakOn = true
					self:EnableIntel('Cloak')
					self:SetMesh('/mods/SCTA-master/units/ARMSNIPE/ARMSNIPE_cloak_mesh', true)
				end
			end
		end
	end,

	OnIntelDisabled = function(self)
		self:SetMesh(self:GetBlueprint().Display.MeshBlueprint, true)
	end,

	OnIntelEnabled = function(self)
		self:SetMesh('/mods/SCTA-master/units/ARMSNIPE/ARMSNIPE_cloak_mesh', true)
	end,

	Weapons = {
		ARM_FAST = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
			end,
		},
	},
}
TypeClass = ARMSNIPE