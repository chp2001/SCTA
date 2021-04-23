local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

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
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 1000}},
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
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {0.9}},
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
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
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
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
        Priority = 130,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 1000 } },
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
        BuilderName = 'SCTAAI T2Engineer2 Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA23All',
        Priority = 125,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.TECH3 * categories.ENERGYPRODUCTION * categories.STRUCTURE} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
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
}