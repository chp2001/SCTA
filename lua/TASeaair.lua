#Generic TA Air unit
local TAair = import('/mods/SCTA-master/lua/TAair.lua').TAair

TASeaair = Class(TAair) 
{
	OnCreate = function(self)
		TAair.OnCreate(self)
		self:DisableIntel('RadarStealth')
    end,

	OnMotionVertEventChange = function(self, new, old )
		---TAair.OnMotionVertEventChange(self, new, old)
			if (new == 'Down' or new == 'Bottom') then
						self:PlayUnitSound('Landing')
				self:CloseWings(self)
				ForkThread(self.OnLayerChange, self, new, old)
			elseif (new == 'Up' or new == 'Top') then
						self:PlayUnitSound('TakeOff')
				self:OpenWings(self)
			end
		end,

	OnLayerChange = function(self, new, old)
		--TAair.OnLayerChange(self, new, old)
		if( old != 'None' ) then
            if( self.AT1 ) then
                self.AT1:Destroy()
                self.AT1 = nil
			end
            local myBlueprint = self:GetBlueprint()
			if( new == 'Water' ) then
				self:EnableIntel('Vision')
                self:EnableIntel('WaterVision')
				self:EnableIntel('RadarStealth')
				self.Sliders.chassis:SetSpeed(10)
				self.Sliders.chassis:SetGoal(0,-10,0)
			elseif( new == 'Air' ) then
				self:EnableIntel('Vision')
                self:DisableIntel('WaterVision')
				self.Sliders.chassis:SetSpeed(10)
				self.Sliders.chassis:SetGoal(0,0,0)
				self:DisableIntel('RadarStealth')
				--ForkThread(self.OnMotionVertEventChange, self, new, old)
			end
		end
    end,

}


TypeClass = TASeaair
