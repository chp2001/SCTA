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
        { categories.OCEAN * categories.SCOUT, 1, 2, 'Attack', 'GrowthFormation' },
    }
}

PlatoonTemplate {
    Name = 'SCTANavalAssault',
    Plan = 'NavalForceAI',
    GlobalSquads = {
        { categories.LEVEL1 * categories.OCEAN - categories.ENGINEER, 4, 10, 'Attack', 'GrowthFormation' }
    },
}

PlatoonTemplate {
    Name = 'SCTANavalAssaultT2',
    Plan = 'NavalForceAI',
    GlobalSquads = {
        {categories.OCEAN - categories.ENGINEER, 10, 20, 'Attack', 'GrowthFormation' }
    },
}

PlatoonTemplate {
    Name = 'T1ScoutShipSCTA',
    FactionSquads = {
        Arm = {
            { 'armpt', 1, 2, 'Attack', 'GrowthFormation'},
        },
        Core = {
            { 'corpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1FrigateSCTA',
    FactionSquads = {
        Arm = {
            { 'armroy', 1, 1, 'Attack', 'GrowthFormation'},
            { 'armpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
        Core = {
            { 'corroy', 1, 1, 'Attack', 'GrowthFormation'},
            { 'corpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2DestroyerSCTA',
    FactionSquads = {
        Arm = {
            { 'armcrus', 1, 1, 'Attack', 'GrowthFormation'},
            { 'armpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
        Core = {
            { 'corcrus', 1, 1, 'Attack', 'GrowthFormation'},
            { 'corpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2CrusSCTA',
    FactionSquads = {
        Arm = {
            { 'armaas', 1, 1, 'Attack', 'GrowthFormation'},
            { 'armpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
        Core = {
            { 'corarch', 1, 1, 'Attack', 'GrowthFormation'},
            { 'corpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
    }
}

PlatoonTemplate {
    Name = 'BattleshipSCTA',
    FactionSquads = {
        Arm = {
            { 'armbats', 1, 1, 'Attack', 'GrowthFormation'},
            { 'armpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
        Core = {
            { 'corbats', 1, 1, 'Attack', 'GrowthFormation'},
            { 'corpt', 1, 2, 'Attack', 'GrowthFormation' },
        },
    }
}