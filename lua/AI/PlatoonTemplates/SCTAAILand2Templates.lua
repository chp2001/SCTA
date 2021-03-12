#***************************************************************************
#*
#**  File     :  /lua/ai/LandPlatoonTemplates.lua
#**
#**  Summary  : Global platoon templates
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************
-----SecondaryLand

PlatoonTemplate {
    Name = 'T1LandDFBotSCTA2',
    FactionSquads = {
        Arm = {
            { 'armck', 1, 1, 'support', 'None' }, 
            { 'armflash', 1, 3, 'attack', 'none' },
        },
        Core = {
            { 'corcv', 1, 1, 'support', 'None' },
            { 'corak', 1, 3, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandScoutSCTA2',
    FactionSquads = {
        Arm = {
            { 'armfav', 1, 1, 'scout', 'none' }
        },
        Core = {
            { 'corfast', 1, 1, 'scout', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandArtillerySCTA2',
    FactionSquads = {
        Arm = {
            { 'armsam', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corthud', 1, 1, 'attack', 'none' }
        },
    }
}


PlatoonTemplate {
    Name = 'T1LandAASCTA2',
    FactionSquads = {
        Arm = {
            { 'armsam', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corstorm', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandDFTankSCTA2',
    FactionSquads = {
        Arm = {
            { 'armck', 1, 1, 'support', 'none' },
            { 'armstump', 1, 6, 'attack', 'none' },
        },
        Core = {
            { 'corcv', 1, 1, 'support', 'none' },
            { 'corstorm', 1, 6, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandAuxFact2',
    FactionSquads = {
        Arm = {
            { 'armjam', 1, 1, 'attack', 'none' },
            { 'armfark', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'corspec', 1, 1, 'attack', 'none' },
            { 'cornecro', 1, 1, 'support', 'None' },
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandMissileSCTA2',
    FactionSquads = {
        Arm = {
            { 'armmerl', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corhrk', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandAASCTA2',
    FactionSquads = {
        Arm = {
            { 'armyork', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corcrash', 1, 1, 'attack', 'none' }
        },
    }
}


PlatoonTemplate {
    Name = 'T2LandDFTank2SCTA',
    FactionSquads = {
        Arm = {
            { 'armlatnk', 1, 2, 'attack', 'none' },
            { 'armspid', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corcan', 1, 2, 'attack', 'none' },
            { 'corpyro', 1, 1, 'attack', 'none' },
        },
    }
}

PlatoonTemplate {
    Name = 'T3LandDFTank2SCTA',
    FactionSquads = {
        Arm = {
            { 'armbull', 1, 2, 'attack', 'none' },
            { 'armmart', 1, 1, 'attack', 'none' },
        },
        Core = {
            { 'corsumo', 1, 2, 'attack', 'none' },
            { 'cormort', 1, 1, 'attack', 'none' },
        },
    }
}
