#***************************************************************************
#*
#**  File     :  /lua/ai/StructurePlatoonTemplates.lua
#**
#**  Summary  : Global platoon templates
#**
#**  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
#*


# ==== Extractor Upgrades === #
PlatoonTemplate {
    Name = 'SctaExtractorUpgrades',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        { categories.MASSEXTRACTION * categories.STRUCTURE * categories.LEVEL1, 1, 1, 'support', 'none' }
    },
}

PlatoonTemplate {
    Name = 'SctaIntelUpgrades',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        { categories.INTELLIGENCE * categories.STRUCTURE * categories.LEVEL1, 1, 1, 'support', 'none' }
    },
}

PlatoonTemplate {
    Name = 'SctaRadar2Upgrades',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        { categories.RADAR * categories.STRUCTURE * categories.LEVEL2, 1, 1, 'support', 'none' }
    },
}