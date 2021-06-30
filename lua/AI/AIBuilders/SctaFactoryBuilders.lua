
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')



BuilderGroup {
    BuilderGroupName = 'SCTAAIFactoryBuilders',
    BuildersType = 'EngineerBuilder',
    ----BotsFacts
    Builder {
        BuilderName = 'SCTAAI T1Engineer LandFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 110,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory' }},
            { MIBC, 'GreaterThanGameTime', { 90 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY} },
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH1} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'LandTA',
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
        BuilderName = 'SCTAAI T1Engineer LandFac2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 90,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory' }},
            { MIBC, 'GreaterThanGameTime', { 120 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY } },
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH1} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'LandTA',
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
    ---UPPERTECHLAND
    Builder {
        BuilderName = 'SCTAAI T2LAND Vehicle Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 108,
        PriorityFunction = TAPrior.UnitProduction,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory2' }},
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH2} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, LAB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'OmniLand',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            LocationType = 'LocationType',
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND KBot Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 107,
        PriorityFunction = TAPrior.UnitProduction,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory2' }},
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH2} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, LAB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'OmniLand',
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
    ---V
    ---AirFacts
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 100,
        PriorityFunction = TAPrior.UnitProductionT1,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2,  categories.FACTORY } }, -- Don't build air fac immediately.
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH1} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FACTORY} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4,  categories.FACTORY * categories.AIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'LandTA',
        BuilderData = {
            NeedGuard = false,
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
        BuilderName = 'SCTAAI T2AirFactory',
        PlatoonTemplate = 'EngineerBuilderSCTAEco123',
        Priority = 180,
        TAPrior.UnitProduction,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory2' }},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1,  LAB } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, LAB * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, LAB * categories.AIR } }, -- Stop after 10 facs have been built.
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'OmniAir',
        BuilderData = {
            NeedGuard = false,
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
        BuilderName = 'SCTAAI T3LAND Hover Factory T2',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 143,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory' }},
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH3} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.HOVER * PLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'OmniLand',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3AirFactory T2',
        PlatoonTemplate = 'EngineerBuilderSCTAEco23',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 140,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'Factory', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Factory' }},
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH3} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR * PLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'OmniAir',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3AirFactory',
                }
            }
        }
    },
    ---EmergencyFacts
    Builder {
        BuilderName = 'SCTAT3 Artillery',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        PriorityFunction = TAPrior.GantryConstruction,
        Priority = 160,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.ARTILLERY * categories.STRUCTURE} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75} },
        },
        BuilderType = 'T3TA',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 4,
            Construction = {
                BuildStructures = {
                    'T3Artillery',
                },
            }
        }
    },
    Builder {
        BuilderName = 'Nuclear Missile SCTA', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'CommanderBuilderSCTADecoy',
        PriorityFunction = TAPrior.GantryConstruction,
        Priority = 210,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.NUKE * categories.STRUCTURE * categories.TECH3} },
            { TAutils, 'EcoManagementTA', { 0.9, 0.75} },
        },
        BuilderType = 'T3TA',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 4,
            Construction = {
                BuildStructures = {
                    'T3StrategicMissile',
                }
            }
        }
    },
}