#ARM Zipper - Fast Attack Kbot
#ARMFAST
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSNIPE = Class(TAWalking) {
    OnStopBeingBuilt = function(self, builder, layer)
		TAWalking.OnStopBeingBuilt(self, builder, layer)
		self.Spinners = {
			lgunbase = CreateRotator(self, 'gun', 'x', nil, 0, 0, 0),
		}
		self.Sliders = {
			sleave = CreateSlider(self, 'sleave'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
        self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_CloakToggle', true)
        self:RequestRefreshUI()
    end,

	Weapons = {
		ARM_FAST = Class(TAweapon) {
			OnWeaponFired = function(self)
				TAweapon.OnWeaponFired(self)
			end,

			PlayFxWeaponUnpackSequence = function(self)
				TAweapon.PlayFxWeaponUnpackSequence(self)
				self.unit.Spinners.lgunbase:SetGoal(90)
				self.unit.Spinners.lgunbase:SetSpeed(90)

				--MOVE barrel to z-axis <0> SPEED <22.00>;
				self.unit.Sliders.sleave:SetGoal(0,0,1)
				self.unit.Sliders.sleave:SetSpeed(1)
			end,	
	
			PlayFxWeaponPackSequence = function(self)
				TAweapon.PlayFxWeaponPackSequence(self)
				self.unit.Spinners.lgunbase:SetGoal(0)
				self.unit.Spinners.lgunbase:SetSpeed(90)

				
				--MOVE barrel to z-axis <0> SPEED <22.00>;
				self.unit.Sliders.sleave:SetGoal(0,0,0)
				self.unit.Sliders.sleave:SetSpeed(1)
			end,		
		},
	},
}
TypeClass = ARMSNIPE