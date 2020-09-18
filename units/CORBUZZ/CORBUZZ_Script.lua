local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TABuzz = import('/mods/SCTA-master/lua/TAweapon.lua').TABuzz

CORBUZZ = Class(TAunit) {
	currentBarrel = 1,

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
				---LOG(_VERSION)
				self.unit.currentBarrel = math.mod(self.unit.currentBarrel, 6) + 1
				---LOG(self.unit.currentBarrel)
				self.unit:CreateProjectileAtBone('/mods/SCTA-master/effects/entities/Shells/ARMVULC_Shell/ARMVULC_Shell_proj.bp','Turret')
			end,

				PlayFxRackReloadSequence = function(self)
				local goal = 360 - 60 * self.unit.currentBarrel
				--TURN spindle to z-axis <90> SPEED <400.09>; (for each turn)
				self.unit.Spinners.Spindle:SetGoal(-60 * (self.unit.currentBarrel) + 15)
				---LOG(goal)
				self.unit.Spinners.Spindle:SetSpeed(120)
				WaitSeconds(0.5)
				TABuzz.PlayFxRackReloadSequence(self)
			end,
		},
	},
}
TypeClass = CORBUZZ
