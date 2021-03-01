--[[
    File    :   /lua/AI/PlattonTemplates/SCTAAITemplates.lua
    Author  :   SoftNoob
    Summary :
        Responsible for defining a mapping from AIBuilders keys -> Plans (Plans === platoon.lua functions)
]]

PlatoonTemplate {
    Name = 'StrikeForceSCTA',
    Plan = 'SCTAStrikeForceAI', -- The platoon function to use.
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * categories.LEVEL1 - categories.RAIDER - categories.ENGINEER - categories.EXPERIMENTAL, -- Type of units.
          5, -- Min number of units.
          10, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'StrikeForceSCTA2',
    Plan = 'SCTAStrikeForceAILate', -- The platoon function to use.
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.RAIDER - categories.ENGINEER - categories.EXPERIMENTAL, -- Type of units.
          10, -- Min number of units.
          20, -- Max number of units.
          'attack', -- platoon types: 'support', 'attack', 'scout',
          'none' }, -- platoon move formations: 'None', 'AttackFormation', 'GrowthFormation',
    },
}

PlatoonTemplate {
    Name = 'LABSCTA',
    Plan = 'SCTAStrikeForceAIEarly', -- The platoon function to use.
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
    Plan = 'SCTAStrikeForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND - categories.EXPERIMENTAL - categories.ENGINEER - categories.ROCKET - categories.RAIDER, 2, 20, 'Attack', 'none' }
    },
}

PlatoonTemplate {
    Name = 'LandRocketAttackSCTA',
    Plan = 'AttackForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * (categories.ROCKET + categories.ARTILLERY) - categories.EXPERIMENTAL - categories.ENGINEER - categories.RAIDER, 6, 20, 'Attack', 'none' }
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
    Name = 'SCTAGantry',
    Plan = 'PauseAI', 
    FactionSquads = {
        Arm = {
            { 'armgant', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corgant', 1, 1, 'attack', 'none' },
        },
    }
}


