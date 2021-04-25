local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory
local EnProduct = import('/lua/editor/UnitCountBuildConditions.lua').HaveLessThanUnitsInCategoryBeingBuilt
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE


---T3Production
StructureProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  4, PLATFORM)  then 
        return 150
    elseif Factory(aiBrain,  2, PLATFORM) then
        return 85
    else
        return 0
    end
end


ProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  12, LAB)  then 
        return 150
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 180
    else
        return 0
    end
end

LandProductionT3Tank = function(self, aiBrain)
    if Factory(aiBrain,  12, LAB)  then 
        return 135
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 130
    else
        return 0
    end
end

EngineerProductionT3 = function(self, aiBrain)
    if Factory(aiBrain,  12, LAB)  then 
        return 150
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 135
    else
        return 0
    end
end
---T2Production

UnitProduction = function(self, aiBrain)
    if Factory(aiBrain,  1, LAB) then
        return 111
    elseif Factory(aiBrain,  1, PLATFORM) then
        return 50
    elseif Factory(aiBrain,  12, PLANT) then 
            return 110
    else
        return 0
    end
end

StructureProductionT2 = function(self, aiBrain)
    if Factory(aiBrain,  4, LAB)  then 
        return 95
    elseif Factory(aiBrain,  2, LAB) then
        return 10
    else
        return 0
    end
end

EngineerProduction = function(self, aiBrain)
    if Factory(aiBrain,  6, LAB) then 
        return 0
    elseif Factory(aiBrain,  0, LAB) then 
        return 10
    else
        return 101
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
          return 110
      end
  end
  


----GANTRYSPECIFIC
AirProduction = function(self, aiBrain)
    if Factory(aiBrain,  4, LAB) then 
        return 10
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 0
    else
        return 105
    end
end


GantryConstruction = function(self, aiBrain)
    if Factory(aiBrain,  2, PLATFORM)  then
        return 175
    elseif Factory(aiBrain,  4, LAB) then
        return 75
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


HighTechEnergyProduction = function(self, aiBrain)
    if Factory(aiBrain,  0, FUSION) then 
        return 5
    elseif Factory(aiBrain,  2, FUSION) then 
        return 0
    else
        return 80
    end
end

TechEnergyExist = function(self, aiBrain)
    if Factory(aiBrain,  2, FUSION) then 
        return 110
    else
        return 0
    end
end

EnergyBeingBuilt = function(self, aiBrain)
    if EnProduct(aiBrain,  1, FUSION) then 
        return 150
    else
        return 0
    end
end