local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerEcoBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex 50',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 105,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 50, -500, 100, 0, 'AntiSurface', 1 }},
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
        Priority = 95,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 100, 0, 'AntiSurface', 1 }},
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
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 150, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
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
        Priority = 85,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 450, -500, 200, 0, 'AntiSurface', 1 }},         
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
        BuilderName = 'SCTAAI T1Engineer 750 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 80,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 750, -500, 200, 0, 'AntiSurface', 1}},
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
        BuilderName = 'SCTAAI T1Engineer Air Mex 250',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 120,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 100, 0, 'AntiAir', 1 }},
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
        BuilderName = 'SCTAAI T1Engineer Air 400 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 95,
        InstanceCount = 2,
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 400, -500, 150, 0, 'AntiAir', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer 550 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 550, -500, 200, 0, 'AntiAir', 1 }},
                { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
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
        BuilderName = 'SCTAAI T1Engineer Air 850 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 85,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 850, -500, 200, 0, 'AntiAir', 1 }},
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
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 100,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 100, -500, 100, 0, 'AntiSurface', 1 }},
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
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 100,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 100, 0, 'AntiSurface', 1 }},
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
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 170,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 50}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = true,
            DesiresAssist = true,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 90,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 150}},
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
        BuilderName = 'SCTAAI T1Engineer Hydro3',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 75,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 300}},
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
        BuilderName = 'SCTAAI T1Engineer Air Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 130,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.25 }},
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
        BuilderName = 'SCTAAI T1Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 85,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.25 }},
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
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 50,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, FUSION} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.25 }},
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
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 130,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, FUSION} },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 1000 } },
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
        BuilderName = 'SCTAAI T2Engineer2 Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 125,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.TECH3 * categories.ENERGYPRODUCTION * categories.STRUCTURE} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.15 }},
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
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.15 }},
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
    Builder {
        BuilderName = 'SCTAAI T1Engineer MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 120,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2,  FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.25, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
            { EBC, 'LessThanEconStorageRatio', { 0.75, 1.1}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1MassCreation',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Hover MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1,  FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.25, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
            { EBC, 'LessThanEconStorageRatio', { 0.3, 1.1}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1MassCreation',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Air MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        Priority = 110,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3,  FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.25, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
            { EBC, 'LessThanEconStorageRatio', { 0.3, 1.1}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1MassCreation',
                }
            }
        }
    },
}