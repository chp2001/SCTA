local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/TAutils.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerNavalMiscBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTA T1 Naval Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 104,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, LAB * categories.NAVAL } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, PLANT * categories.NAVAL} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            BuildClose = true,
            Construction = {
                BuildStructures = {
                    'T1SeaFactory',
                },
            },
        },
    },
    Builder {
        BuilderName = 'SCTAAI T2Naval Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 108,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            BuildClose = true,
            DesiresAssist = true,
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T2SeaFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3,  FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.25, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            BuildClose = true,
            Construction = {
                BuildStructures = {
                    'T1MassCreation',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTATorpedo',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 50,
        InstanceCount = 3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ANTINAVY - categories.MOBILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            BuildClose = true,
            Construction = {
                BuildStructures = {
                    'T1NavalDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Naval T1Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 111,
        InstanceCount = 1,
        BuilderConditions = { -- Stop after 10 facs have been built.
        { EBC, 'LessThanEconEfficiencyOverTime', { 1.0, 1.15 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            NeedGuard = false,
            DesiresAssist = false,
            BuildClose = true,
            Construction = {
                BuildStructures = {
                    'T1EnergyProduction3',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval Mex 150',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 120,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 100, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            DesiresAssist = false,
            NeedGuard = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval 300 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 94,
        InstanceCount = 2,
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 150, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            DesiresAssist = false,
            NeedGuard = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval Mex 450',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 96,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 450, -500, 200, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
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
        BuilderName = 'SCTAAI T1Engineer Naval Mex 750',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 97,
        InstanceCount = 1,
        BuilderConditions = {
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 750, -500, 200, 0, 'AntiSurface', 1 }},
            },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
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
        BuilderName = 'SCTAT2Torpedo',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 75,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISUB * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            BuildClose = true,
            Construction = {
                BuildStructures = {
                    'T2NavalDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { TAutils, 'TAReclaimablesInArea', { 'LocationType', }},
            { EBC, 'LessThanEconStorageRatio', { 0.3, 1.1}},
            },
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            ReclaimTime = 30,
            Terrain = true,
        },
        BuilderType = 'Any',
    },
}