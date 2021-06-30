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
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.MASSEXTRACTION * categories.STRUCTURE * categories.TECH1, 1, 1, 'support', 'none' }
    },
}

PlatoonTemplate {
    Name = 'SctaIntelUpgrades',
    Plan = 'UnitUpgradeAI',
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.INTELLIGENCE * categories.STRUCTURE * categories.TECH1, 1, 1, 'support', 'none' }
    },
}

PlatoonTemplate {
    Name = 'SctaRadar2Upgrades',
    Plan = 'UnitUpgradeAI',
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.RADAR * categories.STRUCTURE * categories.TECH2, 1, 1, 'support', 'none' }
    },
}

PlatoonTemplate {
    Name = 'FabricationSCTA',
    Plan = 'TAPauseAI',
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.STRUCTURE * categories.MASSFABRICATION, 1, 1, 'support', 'none' },
    }
}

PlatoonTemplate {
    Name = 'SCTAIntel',
    Plan = 'PauseAI',
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.STRUCTURE * (categories.OPTICS + categories.RADAR), 1, 1, 'support', 'none' },
    }
}

PlatoonTemplate {
    Name = 'ArtillerySCTA',
    Plan = 'ArtilleryAI',
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.ARTILLERY * categories.STRUCTURE, 1, 1, 'artillery', 'None' }
    },
}

PlatoonTemplate {
    Name = 'TacticalMissileSCTA',
    Plan = 'NukeAISAI',
    ---PlatoonType = 'StructureForm',
    GlobalSquads = {
        { categories.TACTICALMISSILEPLATFORM * categories.STRUCTURE, 1, 1, 'attack', 'None' }
    },
}

PlatoonTemplate {
    Name = 'NuclearMissileSCTA',
    Plan = 'NukeAISAI',
    ---PlatoonType = 'CommandTA',
    GlobalSquads = {
        { categories.NUKE * categories.STRUCTURE * categories.TECH3, 1, 1, 'attack', 'None' }
    },
}

PlatoonTemplate {
    Name = 'AntiNuclearMissileSCTA',
    Plan = 'AntiNukeAI',
    ---PlatoonType = 'CommandTA',
    GlobalSquads = {
        { categories.ANTIMISSILE * categories.STRUCTURE * categories.TECH3, 1, 1, 'attack', 'None' }
    },
}