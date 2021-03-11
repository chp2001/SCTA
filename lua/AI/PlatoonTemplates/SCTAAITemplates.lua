--[[
    File    :   /lua/AI/PlattonTemplates/SCTAAITemplates.lua
    Author  :   SoftNoob
    Summary :
        Responsible for defining a mapping from AIBuilders keys -> Plans (Plans === platoon.lua functions)
]]
local SPECIAL = categories.RAIDER - categories.EXPERIMENTAL - categories.ENGINEER
local GROUND = categories.MOBILE * categories.LAND

PlatoonTemplate {
    Name = 'AntiAirSCTA',
    Plan = 'SCTAAntiAirAI', -- The platoon function to use.
    GlobalSquads = {
        { GROUND * categories.ANTIAIR, -- Type of units.
          5, -- Min number of units.
          10, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTA',
    Plan = 'SCTAStrikeForceAI', -- The platoon function to use.
    GlobalSquads = {
        { GROUND - SPECIAL - categories.LASER, -- Type of units.
          5, -- Min number of units.
          10, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTALaser',
    Plan = 'SCTAStrikeForceAI', -- The platoon function to use.
    GlobalSquads = {
        { GROUND * categories.LASER - SPECIAL, -- Type of units.
          5, -- Min number of units.
          10, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTATerrain',
    Plan = 'HuntAILABSCTA', -- The platoon function to use.
    GlobalSquads = {
        { categories.ALLTERRAIN * categories.LAND  - SPECIAL - categories.SCOUT, -- Type of units.
          5, -- Min number of units.
          10, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'LABSCTA',
    Plan = 'HuntAILABSCTA', -- The platoon function to use.
    GlobalSquads = {
        { categories.MOBILE * categories.RAIDER, -- Type of units.
          1, -- Min number of units.
          3, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}


PlatoonTemplate {
    Name = 'LandAttackSCTA',
    Plan = 'AttackSCTAForceAI',
    GlobalSquads = {
        { GROUND - SPECIAL, 5, 20, 'Attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'LandAttackSCTAEarly',
    Plan = 'SCTAStrikeForceAIEarly',
    GlobalSquads = {
        { GROUND * categories.LEVEL1 - SPECIAL, 5, 10, 'Attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'LandRocketAttackSCTA',
    Plan = 'AttackSCTAForceAI',
    GlobalSquads = {
        { GROUND * (categories.ROCKET + categories.ARTILLERY) - SPECIAL, 5, 20, 'Attack', 'none' }
    },
}


PlatoonTemplate {
    Name = 'T4ExperimentalSCTA',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        { categories.EXPERIMENTAL * categories.MOBILE - categories.SUBCOMMANDER, 1, 1, 'attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'FabricationSCTA',
    Plan = 'PauseAI',
    GlobalSquads = {
        { categories.STRUCTURE * categories.MASSFABRICATION, 1, 1, 'support', 'none' },
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

PlatoonTemplate {
    Name = 'T3LandHOVERSCTA',
    FactionSquads = {
        Arm = {
            { 'armanac', 1, 3, 'attack', 'none' }
        },
        Core = {
            { 'corsnap', 1, 3, 'attack', 'none' }
        },
    }
}


PlatoonTemplate {
    Name = 'THOVERAASCTA',
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
            { 'armmh', 1, 2, 'attack', 'none' }
        },
        Core = {
            { 'cormh', 1, 2, 'attack', 'none' }
        },
    }
}


