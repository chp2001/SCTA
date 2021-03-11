#***************************************************************************
#*
#**  File     :  /lua/ai/LandPlatoonTemplates.lua
#**
#**  Summary  : Global platoon templates
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
local SKY = categories.AIR * categories.MOBILE

PlatoonTemplate {
    Name = 'AirHuntAISCTA',
    Plan = 'HuntAirAISCTA',
    GlobalSquads = {
        { SKY * (categories.BOMBER + categories.ANTIAIR) * categories.LEVEL1, 2, 4, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'IntieAISCTA',
    Plan = 'InterceptorAISCTA',
    GlobalSquads = {
        { SKY * categories.ANTIAIR * (categories.LEVEL1 + categories.LEVEL3) - categories.BOMBER - categories.TRANSPORTFOCUS, 2, 100, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'StealthFightersAISCTA',
    Plan = 'StealthIntieAISCTA',
    GlobalSquads = {
        { SKY * categories.ANTIAIR * categories.LEVEL2 - categories.BOMBER, 2, 100, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'SCTAT2AirScouting',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { SKY * categories.SCOUT * (categories.LEVEL1 + categories.LEVEL2), 1, 1, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'T1AirScoutFormSCTA',
    Plan = 'ScoutingAI',
    GlobalSquads = {
        { SKY * categories.SCOUT * categories.LEVEL1, 1, 1, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'T1AirScoutSCTA',
    FactionSquads = {
        Arm = {
            { 'armpeep', 1, 1, 'scout', 'GrowthFormation' },
            { 'armca', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'corfink', 1, 1, 'scout', 'GrowthFormation' },
            { 'corca', 1, 1, 'support', 'None' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armfig', 1, 2, 'attack', 'GrowthFormation' }
        },
        Core = {
            { 'corveng', 1, 2, 'attack', 'GrowthFormation' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirBomberSCTA',
    FactionSquads = {
        Arm = {
            { 'armpeep', 1, 1, 'scout', 'GrowthFormation' },
            { 'armthund', 1, 2, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corfink', 1, 1, 'scout', 'GrowthFormation' },
            { 'corshad', 1, 2, 'attack', 'GrowthFormation' },
        },
    }
}


PlatoonTemplate {
    Name = 'T2AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armhawk', 1, 2, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corvamp', 1, 2, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2AirBomberSCTA',
    FactionSquads = {
        Arm = {
            { 'armpnix', 1, 2, 'attack', 'GrowthFormation' },
            { 'armhawk', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corhurc', 1, 2, 'attack', 'GrowthFormation' },
            { 'corvamp', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2AirScoutSCTA',
    FactionSquads = {
        Arm = {
            { 'armawac', 1, 1, 'scout', 'GrowthFormation' },
            { 'armpnix', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corawac', 1, 1, 'scout', 'GrowthFormation' },
            { 'corhurc', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T3AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armsfig', 1, 2, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corsfig', 1, 2, 'attack', 'GrowthFormation' },
        },
    }
}