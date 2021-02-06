#***************************************************************************
#*
#**  File     :  /lua/ai/LandPlatoonTemplates.lua
#**
#**  Summary  : Global platoon templates
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

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
    Name = 'T2AirScoutSCTA',
    FactionSquads = {
        Arm = {
            { 'armawac', 1, 1, 'scout', 'none' }
        },
        Core = {
            { 'corawac', 1, 1, 'scout', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T3AirFighterSCTA',
    FactionSquads = {
        Arm = {
            { 'armsfig', 1, 3, 'attack', 'GrowthFormation' },
        },
        Core = {
            { 'corsfig', 1, 3, 'attack', 'GrowthFormation' },
        },
    }
}