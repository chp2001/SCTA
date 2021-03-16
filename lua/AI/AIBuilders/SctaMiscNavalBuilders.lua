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
    BuilderGroupName = 'SCTAAIEngineerNavalMiscBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTA T1 Naval Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 95,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB * categories.NAVAL } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.PLANT * categories.NAVAL} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
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
        Priority = 105,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
                DesiresAssist = true,
                NumAssistees = 2,
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
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3,  categories.FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.25, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
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
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
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
        Priority = 100,
        InstanceCount = 2,
        BuilderConditions = { -- Stop after 10 facs have been built.
        { EBC, 'LessThanEconEfficiencyOverTime', { 0.9, 0.75 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
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
        Priority = 95,
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
        Priority = 95,
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
        Priority = 95,
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISUB * categories.LEVEL2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T2NavalDefense',
                }
            }
        }
    },
}