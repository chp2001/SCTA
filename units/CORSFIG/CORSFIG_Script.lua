#CORE Avenger - Fighter
#ARMSFIG
#
#Script created by Raevn

local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSFIG = Class(TAair) {
	moving = false,

	OnCreate = function(self)
		TAair.OnCreate(self)
		self:SetMaintenanceConsumptionActive()
		self.Spinners = {
			base = CreateRotator(self, 0, 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.Sliders = {
			winga = CreateSlider(self, 'wing1'),
			wing2 = CreateSlider(self, 'wing2'),
		}
		for k, v in self.Sliders do
			self.Trash:Add(v)
		end
	end,

	OnMotionVertEventChange = function(self, new, old )
		if (new == 'Down' or new == 'Bottom') then
                	self:PlayUnitSound('Landing')
			self:CloseWings(self)
		elseif (new == 'Up' or new == 'Top') then
                	self:PlayUnitSound('TakeOff')
			self:OpenWings(self)
		end
	end,	

	OpenWings = function(self)
		--MOVE winga to x-axis <5.59> SPEED <5.00>;
		self.Sliders.winga:SetGoal(-5,0,0)
		self.Sliders.winga:SetSpeed(5)

		--MOVE wing2 to x-axis <-5.65> SPEED <5.00>;
		self.Sliders.wing2:SetGoal(-5,0,0)
		self.Sliders.wing2:SetSpeed(5)

		self.moving = true
	end,

	CloseWings = function(self)
		self.moving = false

		--MOVE winga to x-axis <5.59> SPEED <5.00>;
		self.Sliders.winga:SetGoal(0,0,0)
		self.Sliders.winga:SetSpeed(5)

		--MOVE wing2 to x-axis <-5.65> SPEED <5.00>;
		self.Sliders.wing2:SetGoal(0,0,0)
		self.Sliders.wing2:SetSpeed(5)
	end,

	Weapons = {
		CORVTOL_MISSILE = Class(TAweapon) {},
		
	},
}

TypeClass = ARMSFIG