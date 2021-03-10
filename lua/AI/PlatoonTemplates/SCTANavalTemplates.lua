#***************************************************************************
#*
#**  File     :  /lua/ai/LandPlatoonTemplates.lua
#**
#**  Summary  : Global platoon templates
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

PlatoonTemplate {
    Name = 'SCTAPatrolBoatAttack',
    Plan = 'NavalForceAI',
    GlobalSquads = {
        { categories.NAVAL * categories.MOBILE * categories.SCOUT, 2, 8, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'SCTANavalAssault',
    Plan = 'NavalForceAI',
    GlobalSquads = {
        { categories.NAVAL * categories.MOBILE * (categories.SCOUT + categories.FRIGATE), 10, 20, 'attack', 'none' },
    }
}

PlatoonTemplate {
    Name = 'T1ScoutShipSCTA',
    FactionSquads = {
        Arm = {
            { 'armpt', 1, 4, 'attack', 'none' }
        },
        Core = {
            { 'corpt', 1, 4, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1FrigateSCTA',
    FactionSquads = {
        Arm = {
            { 'armroy', 1, 2, 'attack', 'none' },
        },
        Core = {
            { 'corroy', 1, 2, 'attack', 'none' },
        },
    }
}