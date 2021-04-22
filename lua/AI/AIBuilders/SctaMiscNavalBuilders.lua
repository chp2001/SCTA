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
local TIDAL = (categories.cortide + categories.armtide)
local BaseRestrictedArea, BaseMilitaryArea, BaseDMZArea, BaseEnemyArea = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').GetMOARadii()
local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory


local UnitProduction = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  12, PLANT) then 
        return 110
    elseif Factory(aiBrain,  1, LAB) then
        return 111
    elseif Factory(aiBrain,  1, PLATFORM) then
        return 100
    else
        return 0
    end
end


BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerNavalMiscBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTA T1 Naval Factory Builder',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 115,
        InstanceCount = 1,
        BuilderConditions = { 
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Sea' } },
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, (categories.NAVAL * categories.FACTORY) + categories.xsl0103 + categories.ual0201, 'Enemy'}},		
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                BuildStructures = {
                    'T1SeaFactory',
                },
            },
        },
    },
    Builder {
        BuilderName = 'SCTAAI T2NavalEarly Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PriorityFunction = UnitProduction,
        Priority = 125,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 900 } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
                Construction = {
                    BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                    BaseTemplate = 'NavalBaseTemplates',
                    BuildStructures = {
                    'T2SeaFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Engineer Naval 250 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 101,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Mex2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mex2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 100, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Naval Factory',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PriorityFunction = UnitProduction,
        Priority = 141,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 900 } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
            { TASlow,   'TAAttackNaval', {true}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
                Construction = {
                    BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                    BaseTemplate = 'NavalBaseTemplates',
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
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Air' } },
            { TAutils, 'EcoManagementTA', { 0.5, 0.9, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                BuildStructures = {
                    'T3AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3LAND Hover Factory Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 143,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'FactoryCapCheck', { 'LocationType', 'Land' } },
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 100, 300 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
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
        Priority = 102,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1,  FUSION} }, 
            { TAutils, 'GreaterThanEconEnergyTAEfficiency', {0.9 }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
        },
        BuilderType = 'Any',
        BuilderData = {
            BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
            BaseTemplate = 'NavalBaseTemplates',
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
                Construction = {
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
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
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
        Priority = 101,
        InstanceCount = 2,
        BuilderConditions = {
        { UCBC, 'HaveLessThanUnitsWithCategory', { 4, FUSION } },  -- Stop after 10 facs have been built.
        { TAutils , 'LessThanEconEnergyTAEfficiency', {1.15 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                BuildClose = true,
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
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 100, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
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
        Priority = 97,
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'MexLand2', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'MexLand2' }},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 150, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Construction = {
                Location = 'LocationType',
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
            --{ TASlow, 'TAEnemyUnitsGreaterAtLocationRadius', { BaseEnemyArea, 'LocationType', 0, categories.FACTORY * categories.NAVAL}},	
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},	
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISUB * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.33, 0.75}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            LocationType = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
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
        BuilderName = 'SCTAAI Naval Hydro',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        Priority = 99,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        DelayEqualBuildPlattons = {'Hydro', 1},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Hydro' }},
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 300}},
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
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
        BuilderName = 'SCTAAI T2 Naval PGen',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 127,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, FUSION} },
            { TAutils , 'LessThanEconEnergyTAEfficiency', {1.05 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            DesiresAssist = false,
            NeedGuard = false,
            Construction = {
                BaseTemplateFile = '/mods/SCTA-master/lua/AI/TAMiscBaseTemplates/NavalBaseTemplates.lua',
                BaseTemplate = 'NavalBaseTemplates',
                BuildStructures = {
                    'T2EnergyProduction',
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
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, TIDAL}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, FUSION} },
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
            },
        BuilderData = {
            NearMarkerType = 'Naval Area',
            Location = 'LocationType',
            Reclaim = {'cortide, armtide,'},
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Defensive Point Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval2',
        Priority = 76,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, FUSION} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.ANTISHIELD * categories.TECH2 - categories.MOBILE} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.75}}, 
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Location = 'LocationType',
            NearMarkerType = 'Naval Area',
            Construction = {
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