
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
  

BuilderGroup {
    BuilderGroupName = 'SCTAAIFactoryExpansions',
    BuildersType = 'EngineerBuilder',
    ----BotsFacts
    Builder {
        BuilderName = 'SCTAAI Expansion LandFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 104,
        PriorityFunction = TAPrior.UnitProductionT1,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, PLANT} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            LocationType = 'LocationType',
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Expansion Vehicle LandFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 106,
        PriorityFunction = TAPrior.UnitProductionT1,
        InstanceCount = 1,
BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, PLANT} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            LocationType = 'LocationType',
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND Expansion',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 112,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, LAB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            LocationType = 'LocationType',
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND Vehicle Expansion',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 112,
        InstanceCount = 1,
BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, LAB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            LocationType = 'LocationType',
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    ---VEHICLEFact
    ---AirFacts
    Builder {
        BuilderName = 'SCTAAI T1Expansion AirFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 91,
        PriorityFunction = TAPrior.UnitProductionT1,
        InstanceCount = 1,
BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, PLANT * categories.AIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 200, 1000 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            LocationType = 'LocationType',
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Air Expansion',
        PlatoonTemplate = 'EngineerBuilderSCTAEco123',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 111,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, LAB * categories.AIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            LocationType = 'LocationType',
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Expansion MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PriorityFunction = TAPrior.TechEnergyExist,
        Priority = 120,
        InstanceCount = 1,
        BuilderConditions = {
            { TAutils, 'GreaterThanEconEnergyTAEfficiency', {1.05 }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2MassCreation',
                }
            }
        }
    },
}