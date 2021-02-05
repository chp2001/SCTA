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
        { categories.ENGINEER * categories.LEVEL1, 1, 3, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA2',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.LEVEL2, 1, 3, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T1AirScoutSCTA',
    FactionSquads = {
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
        Arm = {
            { 'armfig', 1, 3, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corveng', 1, 3, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirBomberSCTA',
    FactionSquads = {
        Arm = {
            { 'armthund', 1, 2, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corshad', 1, 2, 'attack', 'GrowthFormation' },
        },
    }
}

----PrimaryLand


PlatoonTemplate {
    Name = 'T1LandScoutSCTA',
    FactionSquads = {
        Arm = {
            { 'armflea', 1, 1, 'scout', 'none' }
        },
        Core = {
            { 'corfav', 1, 1, 'scout', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandDFBotSCTA',
    FactionSquads = {
        Arm = {
            { 'armpw', 1, 3, 'attack', 'none' },
            { 'armck', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'corgator', 1, 3, 'attack', 'none' },
            { 'corcv', 1, 1, 'support', 'None' },
        },
    }
}


PlatoonTemplate {
    Name = 'T1LandArtillerySCTA',
    FactionSquads = {
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
        Arm = {
            { 'armck', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corcv', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1BuildEngineerAirSCTA',
    FactionSquads = {
        Arm = {
            { 'armca', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corca', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2BuildEngineerAirSCTA',
    FactionSquads = {
        Arm = {
            { 'armaca', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'coraca', 1, 1, 'support', 'None' }
        },
    }
}


PlatoonTemplate {
    Name = 'T1LandAASCTA',
    FactionSquads = {
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
        Arm = {
            { 'armwar', 1, 6, 'attack', 'none' },
            { 'armrock', 1, 4, 'attack', 'none' },
        },
        Core = {
            { 'corraid', 1, 3, 'attack', 'none' },
        },
    }
}

-----SecondaryLand

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
            { 'armstump', 1, 2, 'attack', 'none' }
        },
        Core = {
            { 'corstorm', 1, 2, 'attack', 'none' }
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
            { 'armack', 1, 3, 'support', 'None' }
        },
        Core = {
            { 'coracv', 1, 3, 'support', 'None' }
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
            { 'armfido', 1, 2, 'attack', 'none' },
            { 'armzeus', 1, 4, 'attack', 'none' },
            { 'armspid', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'correap', 1, 4, 'attack', 'none' },
            { 'coreter', 1, 1, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armhawk', 1, 3, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corvamp', 1, 3, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2AirBomberSCTA',
    FactionSquads = {
        Arm = {
            { 'armpnix', 1, 2, 'attack', 'GrowthFormation' }
        },
        Core = {
            { 'corhurc', 1, 2, 'attack', 'GrowthFormation' }
        },
    }
}

PlatoonTemplate {
    Name = 'SCTAExperimental',
    FactionSquads = {
        Arm = {
            { 'armdrake', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corkrog', 1, 1, 'attack', 'none' },
        },
    }
}
