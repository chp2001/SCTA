local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local BaseRestrictedArea, BaseMilitaryArea, BaseDMZArea, BaseEnemyArea = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').GetMOARadii()
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerNavalMiscBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTA T1 Naval Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PriorityFunction = TAPrior.FactoryProductionT1,
        Priority = 115,
        InstanceCount = 1,
        BuilderConditions = { 
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, (categories.NAVAL * categories.FACTORY) + categories.xsl0103 + categories.ual0201, 'Enemy'}},	
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T1SeaFactory',
                },
            },
        },
    },
    Builder {
        BuilderName = 'SCTAAI T2NavalEarly Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 125,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                    BuildStructures = {
                    'T2SeaFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Naval Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 141,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},		
            { TASlow,   'TAAttackNaval', {true}},
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                    BuildStructures = {
                    'T2SeaFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3AirFactory Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 135,
        PriorityFunction = TAPrior.ProductionT3,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T3AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3LAND Hover Factory Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 150,
        PriorityFunction = TAPrior.ProductionT3,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
                BuildStructures = {
                    'T3LandFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Naval MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 120,
        PriorityFunction = TAPrior.TechEnergyExist,
        InstanceCount = 2,
        BuilderConditions = {
            { TAutils, 'GreaterThanEconEnergyTAEfficiency', {0.9 }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                    BuildClose = true,
                    BuildStructures = {
                    'T2MassCreation',
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
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ANTINAVY - categories.MOBILE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.5}},
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = false,
                MarkerRadius = 20,
                LocationRadius = 75,
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
        PriorityFunction = TAPrior.HighTechEnergyProduction,
        Priority = 135,
        InstanceCount = 2,
        BuilderConditions = {
        { TAutils , 'LessThanEconEnergyTAEfficiency', {1.15 }},
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction3',
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
            --{ TASlow, 'TAEnemyUnitsGreaterAtLocationRadius', { BaseEnemyArea, 'LocationType', 0, categories.FACTORY * categories.NAVAL}},	
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},	
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISUB * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildClose = true,
                MarkerRadius = 20,
                LocationRadius = 75,
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
        BuilderName = 'SCTAAI T2 Naval PGen',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        PriorityFunction = TAPrior.NothingBuilt,
        Priority = 150,
        InstanceCount = 1,
        BuilderConditions = {
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            DesiresAssist = false,
            NeedGuard = false,
            Construction = {
                Location = 'LocationType',
                NearMarkerType = 'Naval Area',
                BuildStructures = {
                    'T2EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA Defensive Point Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 76,
        PriorityFunction = TAPrior.TechEnergyExist,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ANTISHIELD * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}}, 
        },
        BuilderType = 'SeaTA',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            BuildClose = true,
            OrderedTemplate = true,
            NearBasePatrolPoints = false,
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/TA2TowerTemplates.lua',
                BaseTemplate = 'T2TowerTemplate',
                BuildStructures = {
                    'T2GroundDefense',
                    'Wall2',
                    'Wall2',
                    'Wall2',
                    'Wall2',
                    'Wall2',
                    'Wall2',
                    'Wall2',
                    'Wall2',
                },
            },
        }
    },
}