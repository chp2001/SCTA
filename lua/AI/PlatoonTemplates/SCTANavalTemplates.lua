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
    Plan = 'NavalHuntAI',
    GlobalSquads = {
        { categories.OCEAN * categories.SCOUT, 1, 3, 'Attack', 'GrowthFormation' },
    }
}

PlatoonTemplate {
    Name = 'SCTANavalAssault',
    Plan = 'NavalForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.OCEAN - categories.ENGINEER - categories.CARRIER, 4, 100, 'Attack', 'GrowthFormation' }
    },
}

PlatoonTemplate {
    Name = 'T1ScoutShipSCTA',
    FactionSquads = {
        Arm = {
            { 'armpt', 1, 4, 'Attack', 'GrowthFormation'}
        },
        Core = {
            { 'corpt', 1, 4, 'Attack', 'GrowthFormation' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1FrigateSCTA',
    FactionSquads = {
        Arm = {
            { 'armroy', 1, 2, 'Attack', 'GrowthFormation'},
        },
        Core = {
            { 'corroy', 1, 2, 'Attack', 'GrowthFormation'},
        },
    }
}