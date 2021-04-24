local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)


---T3Production

ProductionT3 = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  12, LAB)  then 
        return 130
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 125
    else
        return 0
    end
end

LandProductionT3Tank = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  12, LAB)  then 
        return 135
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 130
    else
        return 0
    end
end

EngineerProductionT3 = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  12, LAB)  then 
        return 150
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 135
    else
        return 0
    end
end
---T2Production

UnitProduction = function(self, aiBrain, builderManager)
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

EngineerProduction = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  6, LAB) then 
        return 0
    elseif Factory(aiBrain,  0, LAB) then 
        return 10
    else
        return 101
    end
end



UnitProductionT1 = function(self, aiBrain, builderManager)

    if Factory(aiBrain,  0, categories.GATE) then
          return 0
    elseif Factory(aiBrain,  6, LAB) then
              return 5
    elseif Factory(aiBrain,  1, LAB) then 
              return 50
      else
          return 101
      end
  end
  


----GANTRYSPECIFIC
AirProduction = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  4, LAB) then 
        return 10
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 0
    else
        return 105
    end
end


GantryConstruction = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  2, PLATFORM)  then
        return 175
    elseif Factory(aiBrain,  4, LAB) then
        return 75
    else
        return 0
    end
end

GantryProduction = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  0, categories.GATE) then
        return 200
    else
        return 0
    end
end



