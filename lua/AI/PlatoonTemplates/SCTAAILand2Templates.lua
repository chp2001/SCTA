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
            { 'armflash', 1, 3, 'attack', 'none' },
            { 'armck', 1, 1, 'support', 'None' }, 
        },
        Core = {
            { 'corak', 1, 3, 'attack', 'none' },
            { 'corcv', 1, 1, 'support', 'None' },
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
            { 'corvoyr', 1, 1, 'scout', 'none' }
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
            { 'corcrash', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1LandDFTankSCTA2',
    FactionSquads = {
        Arm = {
            { 'armstump', 1, 2, 'attack', 'none' }
        },
        Core = {
            { 'corstorm', 1, 2, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandAuxFact2',
    FactionSquads = {
        Arm = {
            { 'armjam', 1, 1, 'attack', 'none' }
        },
        Core = {
            { 'corspec', 1, 1, 'attack', 'none' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2LandDFTank2SCTA',
    FactionSquads = {
        Arm = {
            { 'armbull', 1, 4, 'attack', 'none' },
            { 'armlatnk', 1, 2, 'attack', 'none' },
        },
        Core = {
            { 'corcan', 1, 2, 'attack', 'none' },
            { 'corpyro', 1, 1, 'attack', 'none' },
        },
    }
}
