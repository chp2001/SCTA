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
        { categories.MOBILE * categories.LAND - categories.RAIDER - categories.ENGINEER - categories.EXPERIMENTAL, -- Type of units.
          2, -- Min number of units.
          20, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'LABSCTA',
    Plan = 'ScoutingAI', -- The platoon function to use.
    GlobalSquads = {
        { categories.MOBILE * categories.RAIDER, -- Type of units.
          1, -- Min number of units.
          2, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}


PlatoonTemplate {
    Name = 'LandAttackSCTA',
    Plan = 'AttackForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.ROCKET, 2, 20, 'Attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'LandRocketAttackSCTA',
    Plan = 'AttackForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * (categories.ROCKET + categories.ARTILLERY) - categories.EXPERIMENTAL - categories.ENGINEER, 6, 20, 'Attack', 'none' }
    },
}


PlatoonTemplate {
    Name = 'T1AirScoutFormSCTA',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { categories.AIR * categories.SCOUT, 1, 1, 'scout', 'None' },
    }
}


PlatoonTemplate {
    Name = 'T4ExperimentalSCTA',
    Plan = 'ExperimentalAIHubSorian', 
    GlobalSquads = {
        #DUNCAN - removed the sera lightning unit
        { categories.EXPERIMENTAL * categories.LAND * categories.MOBILE, 1, 1, 'attack', 'none' }
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
    Name = 'T1LandRocketSCTA',
    FactionSquads = {
        Arm = {
            { 'armrock', 1, 2, 'attack', 'none' }
        },
        Core = {
            { 'corstorm', 1, 2, 'attack', 'none' }
        },
    }
}
