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
			wing1 = CreateRotator(self, 'wing1', 'z', nil, 0, 0, 0),
			wing2 = CreateRotator(self, 'wing2', 'z', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
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
		self.Spinners.wing1:SetGoal(50)
		self.Spinners.wing1:SetSpeed(50)

		--MOVE wing2 to x-axis <-5.65> SPEED <5.00>;
		self.Spinners.wing2:SetGoal(-50)
		self.Spinners.wing2:SetSpeed(50)

		self.moving = true
	end,

	CloseWings = function(self)
		self.moving = false

		--MOVE winga to x-axis <5.59> SPEED <5.00>;
		self.Spinners.wing1:SetGoal(0)
		self.Spinners.wing1:SetSpeed(50)

		--MOVE wing2 to x-axis <-5.65> SPEED <5.00>;
		self.Spinners.wing2:SetGoal(0)
		self.Spinners.wing2:SetSpeed(50)
	end,

	Weapons = {
		CORVTOL_MISSILE = Class(TAweapon) {},
		
	},
}

TypeClass = ARMSFIG