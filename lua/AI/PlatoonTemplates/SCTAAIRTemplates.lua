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
    Name = 'SCTABomberAttack',
    Plan = 'BomberAISCTA',
    ---PlatoonType = 'Scout',
    GlobalSquads = {
        { SKY * (((categories.ANTIAIR + categories.GROUNDATTACK) * categories.TECH2) + categories.BOMBER), 1, 100, 'Attack', 'GrowthFormation' },
    }
}

PlatoonTemplate {
    Name = 'IntieAISCTA',
    Plan = 'InterceptorAISCTA',
    ---PlatoonType = 'AirForm',
    GlobalSquads = {
        { SKY * categories.ANTIAIR * (categories.TECH1 + categories.TECH3) - categories.BOMBER, 2, 100, 'attack', 'none' },
    }
}


PlatoonTemplate {
    Name = 'T1AirScoutFormSCTA',
    Plan = 'ScoutingAISorian',
    ---PlatoonType = 'Scout',
    GlobalSquads = {
        { SKY * categories.SCOUT * categories.OVERLAYRADAR, 1, 1, 'scout', 'None' },
    }
}

PlatoonTemplate {
    Name = 'T1AirScoutSCTA',
    FactionSquads = {
        Arm = {
            { 'armpeep', 1, 1, 'scout', 'GrowthFormation' },
            { 'armfig', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corfink', 1, 1, 'scout', 'GrowthFormation' },
            { 'corveng', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armfig', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corveng', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1AirBomberSCTA',
    FactionSquads = {
        Arm = {
            { 'armthund', 1, 1, 'attack', 'GrowthFormation' },
            { 'armca', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'corshad', 1, 1, 'attack', 'GrowthFormation' },
            { 'corca', 1, 1, 'support', 'None' },
        },
    }
}


PlatoonTemplate {
    Name = 'T2AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armhawk', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corvamp', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2GunshipSCTA',
    FactionSquads = {
        Arm = {
            { 'armbrawl', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corape', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T3AirBomberSCTA',
    FactionSquads = {
        Arm = {
            { 'armpnix', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corhurc', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2AirScoutSCTA',
    FactionSquads = {
        Arm = {
            { 'armawac', 1, 1, 'scout', 'GrowthFormation' },
            { 'armaca', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'corawac', 1, 1, 'scout', 'GrowthFormation' },
            { 'coraca', 1, 1, 'support', 'None' },
        },
    }
}

PlatoonTemplate {
    Name = 'T3AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armsfig', 1, 1, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corsfig', 1, 1, 'attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'SCTATransport',
    FactionSquads = {
        Arm = {
            { 'armatlas', 1, 1, 'support', 'GrowthFormation' }
        },
        Core = {
            { 'corvalk', 1, 1, 'support', 'GrowthFormation' }
        },
    }
}