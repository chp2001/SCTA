---local TACreateInitialArmyGroup = CreateInitialArmyGroup

function CreateInitialArmyGroup(strArmy, createCommander)
	CreateWind()
	--[[for index, moddata in __active_mods do
		if moddata.name == 'All factions FAF BlackOps Nomads' then
			TACreateInitialArmyGroup(strArmy, createCommander)
		end
	end]] ---Need To Decide How I want compatibility to work
	local tblGroup = CreateArmyGroup(strArmy, 'INITIAL')
	local cdrUnit = false
	local initialUnitName
    if createCommander and ( tblGroup == nil or 0 == table.getn(tblGroup) )  then
		local ABrain = GetArmyBrain(strArmy);
		if(ABrain.BrainType == 'Human') then
			local initialUnitName = 'mas0001'
			cdrUnit = CreateInitialArmyUnit(strArmy, initialUnitName)
			cdrUnit:SetUnSelectable(false)
			cdrUnit:SetBusy(true)
			cdrUnit:SetBlockCommandQueue(true)
			ForkThread(ControlDelay, cdrUnit, 8.75)
		else
			local tblGroup = CreateArmyGroup( strArmy, 'INITIAL')
			local cdrUnit = false
		
			if createCommander and ( tblGroup == nil or 0 == table.getn(tblGroup) ) then
				local per = ScenarioInfo.ArmySetup[ABrain.Name].AIPersonality
				if per == 'sctaaiarm' then
					initialUnitName = 'armcom'
				elseif per == 'sctaaicore' then
					initialUnitName = 'corcom'
				else
					local factionIndex = GetArmyBrain(strArmy):GetFactionIndex()
					initialUnitName = import('/lua/factions.lua').Factions[factionIndex].InitialUnit
				end
				cdrUnit = CreateInitialArmyUnit(strArmy, initialUnitName)
				if EntityCategoryContains(categories.COMMAND, cdrUnit) then
					if ScenarioInfo.Options['PrebuiltUnits'] == 'Off' then
						cdrUnit:HideBone(0, true)
						ForkThread(CommanderWarpDelay, cdrUnit, 3)
					end
				end
			end
		end
    end
    return tblGroup, cdrUnit
end


function ControlDelay(cdrUnit, delay)
    WaitSeconds(delay)
		cdrUnit:SetUnSelectable(false)
		cdrUnit:SetBusy(false)
		cdrUnit:SetBlockCommandQueue(false)
end

function CreateWind()
	if not ScenarioInfo.WindStats then
		ScenarioInfo.WindStats = {Thread = ForkThread(WindThread)}
	end
end

function WindThread()
	WaitTicks(26)
	--Declared locally for performance, since they are used a lot.
	local random = math.random
	local min = math.min
	local max = math.max
	local mod = math.mod
	while true do
		ScenarioInfo.WindStats.Power = min(max( (ScenarioInfo.WindStats.Power or 0.5) + 0.5 - random(),0),1)
		--Defines a real number, starting from 0.5, between 0 and 1 that randomly fluctuates by up to 0.5 either direction.
		--math.random() with no args returns a real number between 0 and 1
		ScenarioInfo.WindStats.Direction = mod((ScenarioInfo.WindStats.Direction or random(0,360)) + random(-5,5) + random(-5,5) + random(-5,5) + random(-5,5), 360)
		--Defines an int between 0 and 360, that fluctuates by up to 20 either direction, with a strong bias towards 0 fluctuation, that cylces around when 0 or 360 is exceeded.
		WaitTicks(30 + 1)
		--Wait ticks waits 1 less tick than it should. #timingissues
	end
end