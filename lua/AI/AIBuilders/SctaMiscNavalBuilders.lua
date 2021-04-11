local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
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
        Priority = 132,
        InstanceCount = 1,
        BuilderConditions = { 
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Naval'} },
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T1SeaFactory',
                },
            },
        },
    },
    Builder {
        BuilderName = 'SCTAAI T2Naval Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 141,
        InstanceCount = 1,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Naval'} },
            { MIBC, 'GreaterThanGameTime', { 900 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
                Construction = {
                    Location = 'LocationType',
                    BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                    BaseTemplate = 'NavalBaseTemplates',
                    NearMarkerType = 'Naval Area',
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
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1,  FUSION} }, 
            { TAutils, 'GreaterThanEconEnergyTAEfficiency', {1.05 }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
        },
        BuilderType = 'Any',
        BuilderData = {
                Construction = {
                    Location = 'LocationType',
                    BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                    BaseTemplate = 'NavalBaseTemplates',
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
        InstanceCount = 1,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Naval'} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ANTINAVY - categories.MOBILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = false,
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                NearMarkerType = 'Naval Area',
                MarkerRadius = 20,
                LocationRadius = 75,
                LocationType = 'LocationType',
                ThreatMin = 0,
                ThreatMax = 1,
                ThreatRings = 2,
                ThreatType = 'AntiSurface',
                MarkerUnitCount = 2,
                MarkerUnitCategory = 'DEFENSE TECH2 ANTINAVY',
                BuildStructures = {
                    'T1NavalDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI Naval T1Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 131,
        InstanceCount = 2,
        BuilderConditions = {
        { UCBC, 'HaveLessThanUnitsWithCategory', { 4, FUSION } },  -- Stop after 10 facs have been built.
        { TAutils , 'LessThanEconEnergyTAEfficiency', {1.15 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T1EnergyProduction3',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval Mex 150',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 121,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 100, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval 300 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 97,
        InstanceCount = 2,
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 150, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                NearMarkerType = 'Naval Area',
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
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Naval', 1 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISUB * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                BuildClose = true,
                NearMarkerType = 'Naval Area',
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                MarkerRadius = 20,
                LocationRadius = 75,
                LocationType = 'LocationType',
                ThreatMin = 0,
                ThreatMax = 1,
                ThreatRings = 2,
                ThreatType = 'AntiSurface',
                MarkerUnitCount = 2,
                MarkerUnitCategory = 'DEFENSE TECH2 ANTINAVY',
                BuildStructures = {
                    'T2NavalDefense',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 111,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.ENERGYPRODUCTION * categories.NAVAL}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, FUSION} },
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
            },
        BuilderData = {
            NearMarkerType = 'Naval Area',
            BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
            BaseTemplate = 'NavalBaseTemplates',
            Location = 'LocationType',
            Reclaim = {'ENERGYPRODUCTION NAVAL TECH1'},
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
}