local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local WIND = (categories.armwin + categories.corwin)
local SOLAR = (categories.armsolar + categories.corsolar)
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerEcoBuilder',
    BuildersType = 'EngineerBuilder',
    ---LandEco
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex 25',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 105,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 25, -500, 1000, 0, 'StructuresNotMex', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex 150',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 150,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 1000, 0, 'StructuresNotMex', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer 300 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 125,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 500, 0, 'StructuresNotMex', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer 450 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 100,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 450, -500, 250, 0, 'StructuresNotMex', 1 }},         
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T2Engineer Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 110,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Mex2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mex2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 100, -500, 500, 0, 'StructuresNotMex', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Engineer 250 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 106,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Mex2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mex2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 500, 0, 'StructuresNotMex', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        Priority = 190,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Hydro', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Hydro' }},
            { MIBC, 'LessThanGameTime', {120} }, 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 50}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro Far',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 175,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Hydro', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Hydro' }},
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 500}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 75,
        PriorityFunction = TAPrior.HighTechEnergyProduction,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, SOLAR} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {0.9}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T1Engineer Pgen2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 100,
        PriorityFunction = TAPrior.HighTechEnergyProduction,
        InstanceCount = 1,
        BuilderConditions = {
            { TAutils , 'LessThanEconEnergyTAEfficiency', {0.9 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T2Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        PriorityFunction = TAPrior.EnergyBeingBuilt,
        Priority = 125,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.TECH3 * categories.ENERGYPRODUCTION * categories.STRUCTURE} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            NeedGuard = false,
            Construction = {
                BuildStructures = {
                    'T2EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 175,
        PriorityFunction = TAPrior.EnergyBeingBuilt,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3EnergyProduction',
                }
            }
        }
    },
    ---AIREco
    Builder {
        BuilderName = 'SCTAAI T1Engineer Air 850 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 105,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 1000, -500, 500, 0, 'AntiAir', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Air Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'Mini Nuke Launcher SCTA', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        PriorityFunction = TAPrior.StructureProductionT2,
        Priority = 65,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.TACTICALMISSILEPLATFORM} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2StrategicMissile',
                }
            }
        }
    },
    Builder {
        BuilderName = 'T2ArtillerySCTA', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 50,
        PriorityFunction = TAPrior.StructureProductionT2,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ARTILLERY * categories.STRUCTURE * categories.TECH2} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2Artillery',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA Engineer Finish',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
                { UCBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssistUntilFinished = true,
                AssisteeType = 'Engineer',
                Time = 20,
            },
        },
        BuilderType = 'Any',
    },
}