local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerMiscBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex 150',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 120,
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
        Priority = 95,
        InstanceCount = 2,
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
        Priority = 95,
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
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 750, -500, 200, 0, 'AntiSurface', 1 }},
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
        BuilderName = 'SCTAAI T1Engineer Air Mex 250',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 120,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
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
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 550, -500, 200, 0, 'AntiAir', 1 }},
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
        Priority = 95,
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
        BuilderName = 'SCTAAI T1Engineer MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTANaval12',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3,  categories.FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.25, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
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
        BuilderName = 'SCTAAI T2Engineer Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 100,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 100, -500, 100, 0, 'AntiSurface', 1 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
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
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 170,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 50}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
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
        Priority = 120,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 150}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
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
        Priority = 80,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 300}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
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
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 130,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FUSION} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 0.9, 0.75 }},
            { EBC, 'LessThanEconStorageRatio',  { 1.1, 0.75}},
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
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 120,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FUSION} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 0.9, 0.75 }},
            { EBC, 'LessThanEconStorageRatio',  { 1.1, 0.75}},
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FUSION} },
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
            --{ MIBC, 'GreaterThanGameTime', {600} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FUSION} },
            { EBC, 'GreaterThanEconStorageCurrent', { 500, 1000 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.FUSION} },
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.LEVEL3 * categories.FUSION} },
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.15 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.FUSION} },
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LEVEL3 * categories.FUSION} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.FUSION} },
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
        BuilderName = 'SCTAMissileTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.ROCKET - categories.MOBILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaserTower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 60,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {480} }, -- Don't make tanks if we have lots of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.LASER * categories.LEVEL1 - categories.MOBILE } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.7}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileDefense',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 70,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ANTIMISSILE * categories.LEVEL2} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.7}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2MissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileDefense2',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 70,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.ANTIMISSILE * categories.LEVEL3} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.7}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T3StrategicMissileDefense',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser2Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 75,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.LASER * categories.LEVEL2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.FUSION} }, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTALaser3Tower',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 80,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.DEFENSE * categories.LEVEL3 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.4, 0.25}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T3GroundDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAMissileTower Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 10,
        InstanceCount = 15,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {480} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AADefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAGameEnder',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 70,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {2400} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.STRUCTURE * categories.EXPERIMENTAL * categories.ARTILLERY} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildStructures = {
                    'T4Artillery',
                },
                Location = 'LocationType',
            }
        }
    },
    Builder {
        BuilderName = 'SCTATorpedo',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 50,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ROCKET - categories.MOBILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1NavalDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Naval T1Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 60,
        InstanceCount = 2,
        BuilderConditions = { -- Stop after 10 facs have been built.
            { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1EnergyProduction3',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAStaging',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.AIRSTAGINGPLATFORM} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2AirStagingPlatform',
                }
            }
        }
    },
}