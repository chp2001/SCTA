
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
        Priority = 102,
        InstanceCount = 1,
BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 90 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, PLANT} },
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH1} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 200 } },
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
        BuilderName = 'SCTAAI T1Engineer LandFac2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 96,
        InstanceCount = 1,
BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 120 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, PLANT } },
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH1} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 200 } },
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
    ---UPPERTECHLAND
    Builder {
        BuilderName = 'SCTAAI T2LAND Vehicle Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 108,
        PriorityFunction = TAPrior.UnitProduction,
        InstanceCount = 1,
        BuilderConditions = {
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH2} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, LAB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 200 } },
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
BuilderConditions = {
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH2} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, LAB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 200 } },
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
    ---V
    ---AirFacts
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 103,
        PriorityFunction = TAPrior.UnitProductionT1,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4,  PLANT } }, -- Don't build air fac immediately.
            { TASlow, 'TAFactoryCapCheck', { 'LocationType', categories.TECH1} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.AIR * PLANT} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4,  categories.FACTORY * categories.AIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 1000 } },
        },
        BuilderType = 'Any',
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
        Priority = 119,
        TAPrior.UnitProduction,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, LAB * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, LAB * categories.AIR } }, -- Stop after 10 facs have been built.
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 750 } },
        },
        BuilderType = 'Any',
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
        BuilderName = 'SCTAAI T3AirFactory',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 140,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, PLATFORM * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, PLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
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
    Builder {
        BuilderName = 'SCTAAI T3LAND Hover Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 143,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, PLATFORM} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, PLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
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
        BuilderName = 'SCTAAI T3LAND Hover Factory T2',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 143,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, PLATFORM * categories.LAND} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, PLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
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
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, PLATFORM * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, PLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
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
        PriorityFunction = TAPrior.StructureProductionT3,
        Priority = 160,
        InstanceCount = 1,
        BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
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
        BuilderName = 'SCTA Engineer Assist Gantry Production',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        Plan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.GateBeingBuilt,
        Priority = 200,
        InstanceCount = 12,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.GATE }},
            { TAutils, 'EcoManagementTA', { 0.5, 0.5, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'GATE'},                                                   
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Assist Gantry',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        Plan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 200,
        InstanceCount = 12,
        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.BUILTBYQUANTUMGATE}},
            { TAutils, 'EcoManagementTA', { 0.5, 0.5, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                PermanentAssist = false,
                BeingBuiltCategories = {'BUILTBYQUANTUMGATE'},                                                       
                Time = 60,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTAAI Gantry Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 150,
        InstanceCount = 1,
        PriorityFunction = TAPrior.GantryConstruction,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.GATE} }, -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.GATE} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3QuantumGate',
                }
            }
        }
    },
    Builder {
        BuilderName = 'Decoy Commander Gateway', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'CommanderBuilderSCTADecoy', -- Specify what platoon template to use, see the PlatoonTemplates folder.	
        PlatoonAddBehaviors = { 'CommanderBehaviorSCTA' },
        Priority = 150, -- Make this super high priority.  The AI chooses the highest priority builder currently available.	
        InstanceCount = 1,
        BuilderConditions = { 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.GATE} },-- The build conditions determine if this builder is available to be used or not.	
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.GATE} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            },		
        BuilderType = 'Any',	-- Add a behaviour to the Commander unit once its done with it's BO.	 -- Flag this builder to be only run once.	
        BuilderData = {	
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 4,
            Construction = {
                BuildStructures = { -- The buildings to make	
                'T3QuantumGate',
                }	
            }	
        }	
    },
    Builder {
        BuilderName = 'Decoy Commander Game Ender SCTA', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'CommanderBuilderSCTADecoy',
        Priority = 210,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2,  categories.GATE} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.EXPERIMENTAL * categories.ARTILLERY} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 6,  FUSION} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 10,
            Construction = {
                BuildStructures = {
                    'T4Artillery',
                }
            }
        }
    },
    Builder {
        BuilderName = 'Nuclear Missile SCTA', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'CommanderBuilderSCTADecoy',
        PriorityFunction = TAPrior.StructureProductionT3,
        Priority = 210,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4,  FUSION} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.NUKE * categories.STRUCTURE * categories.TECH3} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 10,
            Construction = {
                BuildStructures = {
                    'T3StrategicMissile',
                }
            }
        }
    },
}