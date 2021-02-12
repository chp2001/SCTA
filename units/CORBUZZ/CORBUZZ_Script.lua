local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TIFArtilleryWeapon = import('/lua/terranweapons.lua').TIFArtilleryWeapon

CORBUZZ = Class(TAStructure) {
	

	OnCreate = function(self)
		TAStructure.OnCreate(self)
		self.Spinners = {
			Spindle = CreateRotator(self, 'Spindle', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.currentBarrel = 0
	end,

	Weapons = {
		CORBUZZ_WEAPON = Class(TIFArtilleryWeapon) {
			OnWeaponFired = function(self)
				TIFArtilleryWeapon.OnWeaponFired(self)
				
				self.unit.currentBarrel = self.unit.currentBarrel + 1
				if self.unit.currentBarrel == 6 then
					self.unit.currentBarrel = 0
				end
				self.unit:CreateProjectileAtBone('/mods/SCTA-master/effects/entities/Shells/ARMVULC_Shell/ARMVULC_Shell_proj.bp','Turret')
			end,

			PlayFxRackReloadSequence = function(self)
				self.unit.Spinners.Spindle:SetGoal(-60 * (self.unit.currentBarrel + 1))
				self.unit.Spinners.Spindle:SetSpeed(600)
				TIFArtilleryWeapon.PlayFxRackReloadSequence(self)
			end,

		},
	},
}
TypeClass = CORBUZZ
