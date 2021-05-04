--[[
    File    :   /lua/AI/PlattonTemplates/SCTAAITemplates.lua
    Author  :   SoftNoob
    Summary :
        Responsible for defining a mapping from AIBuilders keys -> Plans (Plans === platoon.lua functions)
]]
local RAIDER = (categories.armpw + categories.corak + categories.armflash + categories.corgator + categories.armspid + categories.armflea)
local SPECIAL = (RAIDER + categories.EXPERIMENTAL + categories.ENGINEER + categories.SCOUT)
local GROUND = categories.MOBILE * categories.LAND
local TACATS = (categories.ANTISHIELD + categories.AMPHIBIOUS)
local RANGE = (categories.ARTILLERY + categories.SILO + categories.ANTIAIR)

PlatoonTemplate {
    Name = 'T1LandScoutFormSCTA',
    Plan = 'ScoutingAI',
    BuilderType = 'Scout',
    GlobalSquads = {
        { GROUND * categories.SCOUT, 1, 1, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'GuardSCTA',
    Plan = 'None',
    BuilderType = 'Scout',
    GlobalSquads = {
        { GROUND - SPECIAL, 1, 1, 'guard', 'none' }
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTATerrain',
    Plan = 'SCTAArtyHuntAI', -- The platoon function to use.
    BuilderType = 'Scout',
    GlobalSquads = {
        { categories.AMPHIBIOUS * categories.LAND - SPECIAL, -- BuilderType of units.
          1, -- Min number of units.
          5, -- Max number of units.
          'attack', -- platoon BuilderTypes: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTALaser',
    Plan = 'HuntSCTAAI', -- The platoon function to use.
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND * (categories.ANTISHIELD + categories.FIELDENGINEER) - categories.AMPHIBIOUS - categories.EXPERIMENTAL, -- BuilderType of units.
          2, -- Min number of units.
          10, -- Max number of units.
          'attack', -- platoon BuilderTypes: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'LABSCTA',
    Plan = 'HuntAILABSCTA', -- The platoon function to use.
    BuilderType = 'Scout',
    GlobalSquads = {
        {RAIDER, -- BuilderType of units.
          1, -- Min number of units.
          1, -- Max number of units.
          'attack', -- platoon BuilderTypes: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

----Aggressive Platoons.

PlatoonTemplate {
    Name = 'LandRocketAttackSCTA',
    Plan = 'HuntSCTAAI',
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND * (RANGE + categories.FIELDENGINEER) - TACATS, 2, 10, 'attack', 'none' }
    },
}


PlatoonTemplate {
    Name = 'LandAttackSCTAMid',
    Plan = 'AttackSCTAForceAI',
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND - SPECIAL - TACATS, 5, 20, 'attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'LandAttackSCTAEndGame',
    Plan = 'AttackSCTAForceAIEndGame',
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND - SPECIAL - categories.BOMB, 15, 30, 'attack', 'none' }
    },
}

----Primary 'Defense' Platoon Protect Bases and Scout Around Mexes
PlatoonTemplate {
    Name = 'AntiAirSCTA',
    Plan = 'SCTAAntiAirAI', -- The platoon function to use.
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND * categories.ANTIAIR - categories.ANTISHIELD, 2, 10, 'attack', 'none' },
    },
}

---SCTA "Unique" Formations

PlatoonTemplate {
    Name = 'StrikeForceSCTAHover',
    Plan = 'SCTAStrikeForceAI', -- The platoon function to use.
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND * (categories.HOVER + categories.AMPHIBIOUS) - SPECIAL, 2, 10, 'attack', 'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}



PlatoonTemplate {
    Name = 'StrikeForceSCTAEarly',
    Plan = 'SCTAStrikeForceAIEarly',
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND * categories.TECH1 - SPECIAL - TACATS - RANGE, 5, 10, 'attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTAMid',
    Plan = 'SCTAStrikeForceAI',
    BuilderType = 'LandForm',
    GlobalSquads = {
        { GROUND - SPECIAL - RANGE - TACATS, 10, 20, 'attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTAEndgame',
    Plan = 'SCTAStrikeForceAIEndgame', 
    BuilderType = 'LandForm',-- The platoon function to use.
    GlobalSquads = {
        { GROUND - SPECIAL - categories.BOMB, 15, 30, 'attack', 'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}


PlatoonTemplate {
    Name = 'T4ExperimentalSCTA',
    Plan = 'ExperimentalAIHubSorian', 
    BuilderType = 'Scout',
    GlobalSquads = {
        { categories.EXPERIMENTAL * categories.MOBILE - categories.SUBCOMMANDER, 1, 1, 'attack', 'none' }
    },
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

PlatoonTemplate {
    Name = 'T1LandAntiArtySCTA',
    FactionSquads = {
        Arm = {
            { 'armjeth', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corlevlr', 1, 1, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandAuxTerrain',
    FactionSquads = {
        Arm = {
            { 'armspid', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'coramph', 1, 1, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T3LandDFBotSCTA',
    FactionSquads = {
        Arm = {
            { 'armsnipe', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'cormort', 1, 1, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T3LandHOVERSCTA',
    FactionSquads = {
        Arm = {
            { 'armanac', 1, 1, 'attack', 'none' },
            { 'armsh', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corsnap', 1, 1, 'attack', 'none' },
            { 'corsh', 1, 1, 'attack', 'none' },
        },
    }
}


PlatoonTemplate {
    Name = 'T3HOVERAASCTA',
    FactionSquads = {
        Arm = {
            { 'armah', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corah', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T3HOVERMISSILESCTA',
    FactionSquads = {
        Arm = {
            { 'armmh', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'cormh', 1, 1, 'attack', 'none' }
        },
    }
}


