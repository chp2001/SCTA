local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory
local MoreProduct = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsInCategoryBeingBuilt
local LessProduct = import('/lua/editor/UnitCountBuildConditions.lua').HaveLessThanUnitsInCategoryBeingBuilt
local LessTime = import('/lua/editor/MiscBuildConditions.lua').LessThanGameTime
local RAIDAIR = categories.armfig + categories.corveng + categories.GROUNDATTACK
local RAIDER =  categories.armpw + categories.corak + categories.armflash + categories.corgator + categories.AMPHIBIOUS - categories.COMMAND
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

AirCarrierExist = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.NAVALCARRIER) then 
        return 200
    else
        return 0
    end
end

AirProduction = function(self, aiBrain)
    if Factory(aiBrain,  4, LAB) then 
        return 10
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 0
    else
        return 105
    end
end

AssistProduction = function(self, aiBrain)
    if Factory(aiBrain,  12, PLANT) then 
        return 100
    elseif Factory(aiBrain,  0, LAB) then 
        return 50
    else
        return 0
    end
end


---TECHUPPRoduction

ProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  6, LAB)  then 
        return 90
    elseif Factory(aiBrain,  0, PLATFORM) then
        return 95
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 105
    else
        return 0
    end
end

UnitProduction = function(self, aiBrain)
    if Factory(aiBrain,  1, PLATFORM) then
        return 80
    elseif Factory(aiBrain,  1, LAB) then
        return 125
    elseif Factory(aiBrain,  12, PLANT) then 
        return 110
    else
        return 0
    end
end

StructureProductionT2 = function(self, aiBrain)
    if Factory(aiBrain,  2, LAB)  then 
        return 120
    elseif Factory(aiBrain,  0, LAB) then
        return 10
    else
        return 0
    end
end

FactoryReclaim = function(self, aiBrain)
    if Factory(aiBrain,  1, PLATFORM) then
        return 100
    elseif Factory(aiBrain,  12, PLANT) then 
        return 10
    else
        return 0
    end
end





---WithinTechProduction








----TECH1 PRODUCTION

UnitProductionT1 = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.GATE) then
          return 0
    elseif Factory(aiBrain,  4, LAB) then
              return 5
    elseif Factory(aiBrain,  0, LAB) then 
              return 50
      else
          return 100
      end
  end


HighTechEnergyProduction = function(self, aiBrain)
    if Factory(aiBrain,  2, FUSION) then 
        return 0
    else
        return 80
    end
end


----GANTRYSPECIFIC




GateBeingBuilt = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, categories.GATE) then 
        return 125
    else
        return 0
    end
end

HydroBeingBuiltACU = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, categories.HYDROCARBON) then 
        return 950
    else
        return 0
    end
end

--ENERGYMIDTECH

NothingBuilt = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, FUSION) then 
        return 200
    else
        return 0
    end
end

PlatformBeingBuilt = function(self, aiBrain)
    if LessProduct(aiBrain,  1, PLATFORM) and Factory(aiBrain,  6, LAB) then 
        return 200
    else
        return 0
    end
end


TechEnergyExist = function(self, aiBrain)
    if Factory(aiBrain,  1, FUSION) then 
        return 125
    else
        return 0
    end
end

GantryConstruction = function(self, aiBrain)
    if Factory(aiBrain,  1, PLATFORM)  then
        return 125
    elseif Factory(aiBrain,  6, LAB) then
        return 10
    else
        return 0
    end
end


UnitProductionField = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.FIELDENGINEER) then
        return 200
    else
        return 0
    end
end

UnitProductionLab = function(self, aiBrain)
    if Factory(aiBrain,  0, RAIDER) then
        return 200
    else
        return 0
    end
end

GantryProduction = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.GATE) then
        return 200
    else
        return 0
    end
end