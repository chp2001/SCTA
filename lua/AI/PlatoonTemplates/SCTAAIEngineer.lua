local WEIRD = categories.OCEANENGINEER - categories.COMMAND - categories.FIELDENGINEER

PlatoonTemplate {
    Name = 'CommanderBuilderSCTA',
    Plan = 'EngineerBuildAISCTACommand',
    GlobalSquads = {
        { categories.COMMAND, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'CommanderSCTAAssist',
    Plan = 'ManagerEngineerAssistAI',
    GlobalSquads = {
        { categories.COMMAND, 1, 1, 'support', 'None' },
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA123',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * (categories.LEVEL1 + categories.LEVEL2 + categories.LEVEL3) - WEIRD, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTA23',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * (categories.LEVEL2 + categories.LEVEL3) - WEIRD, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA12',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * (categories.LEVEL1 + categories.LEVEL2) - WEIRD, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTAEco12',
    Plan = 'EngineerBuildAISCTAAir',
    GlobalSquads = {
        { categories.ENGINEER * categories.AIR * (categories.LEVEL1 + categories.LEVEL2), 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.LEVEL1 - WEIRD, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTANaval',
    Plan = 'EngineerBuildAISCTANaval',
    GlobalSquads = {
        { categories.OCEANENGINEER * categories.LEVEL1, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTAEco',
    Plan = 'EngineerBuildAISCTAAir',
    GlobalSquads = {
        { categories.ENGINEER * categories.LEVEL1 * categories.AIR, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTAAssist',
    Plan = 'ManagerEngineerAssistAI',
    GlobalSquads = {
        {categories.FIELDENGINEER, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTAField',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        {categories.FIELDENGINEER, 1, 1, 'support', 'None' }
    },
}




PlatoonTemplate {
    Name = 'EngineerBuilderSCTA2',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.LEVEL2, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA3',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.LEVEL3, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'T1BuildEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armck', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corcv', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1BuildEngineerSCTAEarly',
    FactionSquads = {
        Arm = {
            { 'armck', 1, 1, 'support', 'None' },
            { 'armpw', 1, 3, 'attack', 'none' },
            { 'armck', 1, 4, 'support', 'None' },
            { 'armpw', 1, 1, 'attack', 'none' },
            { 'armck', 1, 2, 'support', 'None' },
            { 'armwar', 1, 1, 'guard', 'none' },
            { 'armck', 1, 2, 'support', 'None'},
            { 'armwar', 1, 1, 'guard', 'none' },
            { 'armck', 1, 4, 'support', 'None' },
            { 'armwar', 1, 1, 'guard', 'none' },
            { 'armck', 1, 2, 'support', 'None' },
            { 'armwar', 1, 1, 'guard', 'none' },
            { 'armck', 1, 2, 'support', 'None' },
        },
        Core = {
            { 'corcv', 1, 1, 'support', 'None' },
            { 'corgator', 1, 3, 'attack', 'none' },
            { 'corcv', 1, 4, 'support', 'None' },
            { 'corgator', 1, 1, 'attack', 'none' },
            { 'corcv', 1, 2, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 2, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 4, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 4, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 2, 'support', 'None' },
        },
    }
}

PlatoonTemplate {
    Name = 'T1EngineerSCTANaval',
    FactionSquads = {
        Arm = {
            { 'armcs', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corcs', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T1BuildEngineerAirSCTA',
    FactionSquads = {
        Arm = {
            { 'armca', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corca', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2BuildEngineerAirSCTA',
    FactionSquads = {
        Arm = {
            { 'armaca', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'coraca', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2BuildEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armack', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'coracv', 1, 1, 'support', 'None' }
        },
    }
}
PlatoonTemplate {
    Name = 'T2BuildFieldEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armfark', 1, 1, 'guard', 'None' }
        },
        Core = {
            { 'cornecro', 1, 1, 'guard', 'None' }
        },
    }
}


PlatoonTemplate {
    Name = 'T3BuildEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armch', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'corch', 1, 1, 'support', 'None' },
        },
    }
}

