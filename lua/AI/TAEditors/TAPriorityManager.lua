local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory
local MoreProduct = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsInCategoryBeingBuilt
local LessProduct = import('/lua/editor/UnitCountBuildConditions.lua').HaveLessThanUnitsInCategoryBeingBuilt
local LessTime = import('/lua/editor/MiscBuildConditions.lua').LessThanGameTime
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

---TECHUPPRoduction

ProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  12, LAB)  then 
        return 150
    elseif Factory(aiBrain,  0, PLATFORM) then
        return 140
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 180
    else
        return 0
    end
end

LandProductionT3Tank = function(self, aiBrain)
    if Factory(aiBrain,  12, LAB)  then 
        return 140
    elseif Factory(aiBrain,  0, PLATFORM) then
        return 135
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 130
    else
        return 0
    end
end

EngineerProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  12, LAB)  then 
        return 155
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 135
    else
        return 0
    end
end

UnitProduction = function(self, aiBrain)
    if Factory(aiBrain,  1, PLATFORM) then
        return 75
    elseif Factory(aiBrain,  1, LAB) then
        return 111
    elseif Factory(aiBrain,  12, PLANT) then 
        return 110
    else
        return 0
    end
end

AssistProduction = function(self, aiBrain)
    if Factory(aiBrain,  12, PLANT) then 
        return 15
    elseif Factory(aiBrain,  0, LAB) then 
        return 10
    else
        return 0
    end
end

---WithinTechProduction
PlatformBeingBuilt = function(self, aiBrain)
    if LessProduct(aiBrain,  2, PLATFORM) then 
        return 150
    elseif Factory(aiBrain,  12, LAB)  then 
        return 10
    else
        return 0
    end
end

StructureProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  4, PLATFORM)  then 
        return 155
    elseif Factory(aiBrain,  12, LAB) then
        return 10
    else
        return 0
    end
end

StructureProductionT2 = function(self, aiBrain)
    if Factory(aiBrain,  4, LAB)  then 
        return 120
    elseif Factory(aiBrain,  2, LAB) then
        return 10
    else
        return 0
    end
end

TechEnergyExist = function(self, aiBrain)
    if Factory(aiBrain,  1, FUSION) then 
        return 135
    else
        return 0
    end
end

----TECH1 PRODUCTION

EngineerProduction = function(self, aiBrain)
    if Factory(aiBrain,  6, LAB) then 
        return 0
    elseif Factory(aiBrain,  0, LAB) then 
        return 10
    else
        return 120
    end
end

UnitProductionT1 = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.GATE) then
          return 0
    elseif Factory(aiBrain,  6, LAB) then
              return 5
    elseif Factory(aiBrain,  1, LAB) then 
              return 50
      else
          return 100
      end
  end

  UnitProductionT1AIR = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.GATE) then
          return 0
    elseif Factory(aiBrain,  6, LAB) then
          return 5
    elseif Factory(aiBrain,  1, LAB) then 
          return 50
    elseif Factory(aiBrain,  0, PLANT * categories.AIR) then 
          return 100
    else
          return 0
      end
  end

  UnitProductionT1Aux = function(self, aiBrain)
    if Factory(aiBrain,  0, categories.GATE) then
          return 0
    elseif Factory(aiBrain,  6, LAB) then
              return 5
    elseif Factory(aiBrain,  1, LAB) then 
              return 45
      else
          return 90
      end
  end

  FactoryProductionT1 = function(self, aiBrain)
    if Factory(aiBrain,  3, LAB) then
              return 0
    elseif Factory(aiBrain,  1, LAB) then 
              return 25
    else
             return 110
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

HighTechEnergyProduction = function(self, aiBrain)
    if Factory(aiBrain,  0, FUSION) then 
        return 5
    elseif Factory(aiBrain,  2, FUSION) then 
        return 0
    else
        return 80
    end
end


----GANTRYSPECIFIC

GantryConstruction = function(self, aiBrain)
    if Factory(aiBrain,  2, PLATFORM)  then
        return 175
    elseif Factory(aiBrain,  6, LAB) then
        return 100
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

GateBeingBuilt = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, categories.GATE) then 
        return 125
    else
        return 0
    end
end

HydroBeingBuilt = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, categories.HYDROCARBON) then 
        return 300
    else
        return 0
    end
end

HydroBeingBuiltACU = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, categories.HYDROCARBON) then 
        return 975
    else
        return 0
    end
end

--ENERGYMIDTECH

EnergyBeingBuilt = function(self, aiBrain)
    if MoreProduct(aiBrain,  0, FUSION) then 
        return 120
    else
        return 0
    end
end

NothingBuilt = function(self, aiBrain)
    if MoreProduct(aiBrain,  2, FUSION) then 
        return 0
    elseif MoreProduct(aiBrain,  0, FUSION) then 
        return 125
    else
        return 150
    end
end

LessThanTime = function(self, aiBrain)
    if LessTime(aiBrain,  480) then 
        return 250
    else
        return 0
    end
end