local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TABuzz = import('/mods/SCTA-master/lua/TAweapon.lua').TABuzz

CORBUZZ = Class(TAunit) {
	currentBarrel = 0,

	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			Spindle = CreateRotator(self, 'Spindle', 'x', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	end,

	Weapons = {
		CORBUZZ_WEAPON = Class(TABuzz) {
			OnWeaponFired = function(self)
				TABuzz.OnWeaponFired(self)
				
				self.unit.currentBarrel = self.unit.currentBarrel + 1
				if self.unit.currentBarrel == 1 then
					self.unit.currentBarrel = 6
				end
				self.unit:CreateProjectileAtBone('/mods/SCTA-master/effects/entities/Shells/ARMVULC_Shell/ARMVULC_Shell_proj.bp','Turret')
			end,

    			PlayFxRackReloadSequence = function(self)
				self.unit.Spinners.Spindle:SetGoal(-60 * (self.unit.currentBarrel + 1))
				self.unit.Spinners.Spindle:SetSpeed(480)
				TABuzz.PlayFxRackReloadSequence(self)
			end,
		},
	},
}
TypeClass = CORBUZZ
