--[[
    File    :   /lua/AI/PlattonTemplates/SCTAAITemplates.lua
    Author  :   SoftNoob
    Summary :
        Responsible for defining a mapping from AIBuilders keys -> Plans (Plans === platoon.lua functions)
]]

PlatoonTemplate {
    Name = 'StrikeForceSCTA',
    Plan = 'StrikeForceAI', -- The platoon function to use.
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER, -- Type of units.
          2, -- Min number of units.
          20, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'LandAttackSCTA',
    Plan = 'AttackForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER, 2, 20, 'Attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'T1AirScoutFormSCTA',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { categories.AIR * categories.SCOUT * categories.TECH1, 1, 1, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'CommanderBuilderSCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.COMMAND, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH1 - categories.COMMAND , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T1LandScoutSCTA',
    FactionSquads = {
        UEF = {
            { 'uel0101', 1, 1, 'scout', 'none' }
        },
        Aeon = {
            { 'ual0101', 1, 1, 'scout', 'none' }
        },
        Cybran = {
            { 'url0101', 1, 1, 'scout', 'none' }
        },
        Seraphim = {
            { 'xsl0101', 1, 1, 'scout', 'none' }
        },
        Arm = {
            { 'armflea', 1, 1, 'scout', 'none' }
        },
        Core = {
            { 'corfav', 1, 1, 'scout', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirScoutSCTA',
    FactionSquads = {
        UEF = {
            { 'uea0101', 1, 1, 'scout', 'none' }
        },
        Aeon = {
            { 'uaa0101', 1, 1, 'scout', 'none' }
        },
        Cybran = {
            { 'ura0101', 1, 1, 'scout', 'none' }
        },
        Seraphim = {
            { 'xsa0101', 1, 1, 'scout', 'none' }
        },
        Arm = {
            { 'armpeep', 1, 1, 'scout', 'none' }
        },
        Core = {
            { 'corfink', 1, 1, 'scout', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirFighterSCTA',
    FactionSquads = {
        UEF = {
            { 'uea0102', 1, 1, 'attack', 'GrowthFormation' }
        },
        Aeon = {
            { 'uaa0102', 1, 1, 'attack', 'GrowthFormation' }
        },
        Cybran = {
            { 'ura0102', 1, 1, 'attack', 'GrowthFormation' }
        },
        Seraphim = {
            { 'xsa0102', 1, 1, 'attack', 'GrowthFormation' }
        },
        Arm = {
            { 'armfig', 1, 1, 'attack', 'GrowthFormation' }
        },
        Core = {
            { 'corveng', 1, 1, 'attack', 'GrowthFormation' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirBomberSCTA',
    FactionSquads = {
        UEF = {
            { 'uea0103', 1, 1, 'attack', 'GrowthFormation' }
        },
        Aeon = {
            { 'uaa0103', 1, 1, 'attack', 'GrowthFormation' }
        },
        Cybran = {
            { 'ura0103', 1, 1, 'attack', 'GrowthFormation' }
        },
        Seraphim = {
            { 'xsa0103', 1, 1, 'attack', 'GrowthFormation' }
        },
        Arm = {
            { 'armthund', 1, 1, 'attack', 'GrowthFormation' }
        },
        Core = {
            { 'corshad', 1, 1, 'attack', 'GrowthFormation' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandDFBotSCTA',
    FactionSquads = {
        UEF = {
            { 'uel0106', 1, 1, 'attack', 'None' }
        },
        Aeon = {
            { 'ual0106', 1, 1, 'attack', 'None' }
        },
        Cybran = {
            { 'url0106', 1, 1, 'attack', 'None' }
        },
        Seraphim = {
            { 'xsl0201', 1, 1, 'attack', 'None' }
        },
        Nomads = {
            { 'xnl0106', 1, 1, 'Attack', 'none' }
        },
        Arm = {
            { 'armpw', 1, 3, 'attack', 'none' }
        },
        Core = {
            { 'corgator', 1, 3, 'attack', 'none' }
        },
    }
}


PlatoonTemplate {
    Name = 'T1LandArtillerySCTA',
    FactionSquads = {
        UEF = {
            { 'uel0103', 1, 1, 'Attack', 'none' }
        },
        Aeon = {
            { 'ual0103', 1, 1, 'Attack', 'none' }
        },
        Cybran = {
            { 'url0103', 1, 1, 'Attack', 'none' }
        },
        Seraphim = {
            { 'xsl0103', 1, 1, 'Attack', 'none' }
        },
        Arm = {
            { 'armham', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corlevlr', 1, 1, 'attack', 'none' }
        },
    }
}


PlatoonTemplate {
    Name = 'T1BuildEngineerSCTA',
    FactionSquads = {
        UEF = {
            { 'uel0105', 1, 1, 'support', 'None' }
        },
        Aeon = {
            { 'ual0105', 1, 1, 'support', 'None' }
        },
        Cybran = {
            { 'url0105', 1, 1, 'support', 'None' }
        },
        Seraphim = {
            { 'xsl0105', 1, 1, 'support', 'None' }
        },
        Arm = {
            { 'armck', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corcv', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandAASCTA',
    FactionSquads = {
        UEF = {
            { 'uel0104', 1, 1, 'Attack', 'none' }
        },
        Aeon = {
            { 'ual0104', 1, 1, 'attack', 'none' }
        },
        Cybran = {
            { 'url0104', 1, 1, 'attack', 'none' }
        },
        Seraphim = {
            { 'xsl0104', 1, 1, 'attack', 'none' }
        },
        Arm = {
            { 'armjeth', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'cormist', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandDFTankSCTA',
    FactionSquads = {
        UEF = {
            { 'uel0201', 1, 1, 'attack', 'none' }
        },
        Aeon = {
            { 'ual0201', 1, 1, 'attack', 'none' }
        },
        Cybran = {
            { 'url0107', 1, 1, 'attack', 'none' }
        },
        Seraphim = {
            { 'xsl0201', 1, 1, 'attack', 'none' }
        },
        Arm = {
            { 'armwar', 1, 2, 'attack', 'none' },
            { 'armrock', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corraid', 1, 1, 'attack', 'none' }
        },
    }
}



PlatoonTemplate {
    Name = 'T1LandDFBotSCTA2',
    FactionSquads = {
        Arm = {
            { 'armflash', 1, 3, 'attack', 'none' }
        },
        Core = {
            { 'corak', 1, 3, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandScoutSCTA2',
    FactionSquads = {
        Arm = {
            { 'armfav', 1, 1, 'scout', 'none' }
        },
        Core = {
            { 'corvoyr', 1, 1, 'scout', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandArtillerySCTA2',
    FactionSquads = {
        Arm = {
            { 'armsam', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corthud', 1, 1, 'attack', 'none' }
        },
    }
}


PlatoonTemplate {
    Name = 'T1LandAASCTA2',
    FactionSquads = {
        Arm = {
            { 'armsam', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corcrash', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandDFTankSCTA2',
    FactionSquads = {
        Arm = {
            { 'armstump', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corstorm', 1, 1, 'attack', 'none' }
        },
    }
}

------LANDT2

PlatoonTemplate {
    Name = 'T2LandMissileSCTA',
    FactionSquads = {
        Arm = {
            { 'armmerl', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corvroc', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2BuildEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armack', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'coracv', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandAASCTA',
    FactionSquads = {
        Arm = {
            { 'armyork', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corsent', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandDFTankSCTA',
    FactionSquads = {
        Arm = {
            { 'armfido', 1, 3, 'attack', 'none' }
        },
        Core = {
            { 'correap', 1, 3, 'attack', 'none' }
        },
    }
}