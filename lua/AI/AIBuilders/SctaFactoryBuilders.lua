
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIFactoryBuilders',
    BuildersType = 'EngineerBuilder',
    --[[Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 150,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.AIR} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2,  categories.PLANT } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T1AirFactory',
                }
            }
        }
    },]]
    Builder {
        BuilderName = 'SCTAAI T1Engineer LandFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 145,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB * categories.LAND } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.PLANT} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
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
        Priority = 150,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB * categories.LAND } }, -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.PLANT} }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer AirFac',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 135,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4,  categories.PLANT } }, -- Don't build air fac immediately.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4,  categories.FACTORY * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  categories.LAB * categories.AIR} }, -- Stop after 5 facs have been built.
            { MIBC, 'LessThanGameTime', {1200} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.9 } },
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
        BuilderName = 'SCTAAI T2LAND Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 160,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.LAB * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 1,
            Construction = {
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2LAND2 Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 155,
        InstanceCount = 1,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3LAND Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 170,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.PLATFORM * categories.LAND} }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
    --[[Builder {
        BuilderName = 'SCTAAI T2AirFactory',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        Priority = 160,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.LAB * categories.AIR } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
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
    },]]
    Builder {
        BuilderName = 'SCTAAI T2AirFactory2',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        Priority = 120,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, categories.FUSION} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.LAB * categories.AIR } }, -- Stop after 10 facs have been built.
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
        BuilderName = 'SCTAAI Gantry Factory',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 200,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.GANTRY} }, -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.GANTRY} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
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
        BuilderName = 'SCTAAI LandFac Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        Priority = 500,
        InstanceCount = 4,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {180} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
            { MIBC, 'LessThanGameTime', {900} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac2 Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 600,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { MIBC, 'LessThanGameTime', {1500} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.PLATFORM} }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac2 Emergency2',
        PlatoonTemplate = 'EngineerBuilderSCTA12',
        Priority = 600,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { MIBC, 'LessThanGameTime', {1500} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.PLATFORM} }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI LandFac3 Emergency',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 800,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.PLATFORM} },
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
        BuilderName = 'SCTA T1 Naval Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.LAB * categories.NAVAL } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.PLANT * categories.NAVAL} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.3, 0.5}}, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
                BuildStructures = {
                    'T1SeaFactory',
                },
            },
        },
    },
    Builder {
        BuilderName = 'SCTAAI T2Naval Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 120,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
                BuildStructures = {
                    'T2SeaFactory',
                }
            }
        }
    },
}