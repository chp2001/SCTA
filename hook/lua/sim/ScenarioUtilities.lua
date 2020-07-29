function CreateInitialArmyGroup(strArmy, createCommander)
	local tblGroup, cdrUnit = doGateSpawn(strArmy, createCommander)
    return tblGroup, cdrUnit
end

function doGateSpawn(strArmy, createCommander)
    local tblGroup = CreateArmyGroup(strArmy, 'INITIAL')
    local cdrUnit = false
    if createCommander and ( tblGroup == nil or 0 == table.getn(tblGroup) ) then
		local ABrain = GetArmyBrain(strArmy);
		if(ABrain.BrainType == 'Human') then
			
				
			local factionIndex = GetArmyBrain(strArmy):GetFactionIndex()
			local initialUnitName = 'mas0001'
			cdrUnit = CreateInitialArmyUnit(strArmy, initialUnitName)
			--cdrUnit:SetUnSelectable(true)
			cdrUnit:SetBusy(false)
			--cdrUnit:SetBlockCommandQueue(true)
			ForkThread(ControlDelay, cdrUnit, 3)
			--UISelectAndZoomTo(cdrUnit,0.1)
			
			ABrain.PreBuilt = true
		else
			local tblGroup = CreateArmyGroup( strArmy, 'INITIAL')
			local cdrUnit = false
		
			if createCommander and ( tblGroup == nil or 0 == table.getn(tblGroup) ) then
				local factionIndex = GetArmyBrain(strArmy):GetFactionIndex()
				local initialUnitName = import('/lua/factions.lua').Factions[factionIndex].InitialUnit
				cdrUnit = CreateInitialArmyUnit(strArmy, initialUnitName)
				if EntityCategoryContains(categories.COMMAND, cdrUnit) then
					if ScenarioInfo.Options['PrebuiltUnits'] == 'Off' then
						cdrUnit:HideBone(0, true)
						ForkThread(CommanderWarpDelay, cdrUnit, 3)
					end
				end
			end
		
		end
		local focusarmy = GetFocusArmy()
		LOG('*DEBUG----------------------: InitializeArmies, army = ', string.sub(strArmy, 6,-1))
		for aK, aV in pairs(GetArmyBrain(strArmy)) do
			LOG(aK,aV)
		end
		if(focusarmy == tonumber(string.sub(strArmy, 6,-1))) then
			local cam = import('/lua/simcamera.lua').SimCamera('WorldCamera')
			local position = cdrUnit:GetPosition()
			local heading = cdrUnit:GetHeading()
			local marker = {
				orientation = VECTOR3( heading + 3.14, 1.2, 0 ),
				position = { position[1] + 0, position[2] + 1, position[3] + 0 },
				zoom = FLOAT( 65 ),
			}
			cam:MoveToMarker(marker, 1)
		end
    end
    return tblGroup , cdrUnit
end


function ControlDelay(cdrUnit, delay)
    WaitSeconds(delay)
		--cdrUnit:SetUnSelectable(false)
		cdrUnit:SetBusy(false)
		--cdrUnit:SetBlockCommandQueue(false)
end