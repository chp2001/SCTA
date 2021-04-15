local WEIRD = (categories.NAVAL + categories.COMMAND + categories.FIELDENGINEER + categories.AIR)
local TA = (categories.ARM + categories.CORE)

PlatoonTemplate {
    Name = 'CommanderBuilderSCTA',
    Plan = 'EngineerBuildAISCTACommand',
    GlobalSquads = {
        { categories.COMMAND * TA, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'CommanderSCTAAssist',
    Plan = 'ManagerEngineerAssistAI',
    GlobalSquads = {
        { categories.COMMAND * TA, 1, 1, 'support', 'None' },
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTA123Assist',
    Plan = 'ManagerEngineerAssistAI',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH1 + categories.TECH2 + categories.TECH3) - categories.NAVAL, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTA123',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH1 + categories.TECH2 + categories.TECH3) * TA - WEIRD, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTAALL',
    Plan = 'SCTAEngineerTypeAI',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH1 + categories.TECH2 + categories.TECH3) * TA - categories.NAVAL - categories.FIELDENGINEER, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTA23',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * (categories.TECH2 + categories.TECH3) * TA - WEIRD, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH1 * TA - WEIRD, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTAEco123',
    Plan = 'EngineerBuildAISCTAAir',
    GlobalSquads = {
        { categories.ENGINEER * categories.AIR * (categories.TECH1 + categories.TECH2 + categories.TECH3) * TA, 1, 1, 'support', 'None' }
    },
}


PlatoonTemplate {
    Name = 'EngineerBuilderSCTAEco23',
    Plan = 'EngineerBuildAISCTAAir',
    GlobalSquads = {
        { categories.ENGINEER * categories.AIR * (categories.TECH2 + categories.TECH3) * TA, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTAEco',
    Plan = 'EngineerBuildAISCTAAir',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH1 * categories.AIR * TA, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTANaval2',
    Plan = 'EngineerBuildAISCTANaval',
    GlobalSquads = {
        { categories.NAVAL * categories.ENGINEER * categories.TECH2 * TA, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTANaval',
    Plan = 'EngineerBuildAISCTANaval',
    GlobalSquads = {
        { categories.NAVAL * categories.ENGINEER * TA, 1, 1, 'support', 'None' }
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
    Plan = 'SCTAReclaimAI',
    GlobalSquads = {
        {categories.FIELDENGINEER, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTAFieldFinish',
    Plan = 'ManagerEngineerFindUnfinished',
    GlobalSquads = {
        {categories.FIELDENGINEER, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA3',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.TECH3 * TA, 1, 1, 'support', 'None' }
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
            { 'armpw', 1, 2, 'attack', 'none' },
            { 'armck', 1, 4, 'support', 'None' },
            { 'armpw', 1, 1, 'attack', 'none' },
            { 'armck', 1, 3, 'support', 'None' },
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
            { 'corgator', 1, 2, 'attack', 'none' },
            { 'corcv', 1, 4, 'support', 'None' },
            { 'corgator', 1, 1, 'attack', 'none' },
            { 'corcv', 1, 3, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 2, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 4, 'support', 'None' },
            { 'corraid', 1, 1, 'guard', 'none' },
            { 'corcv', 1, 2, 'support', 'None' },
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
    Name = 'T2EngineerSCTANaval',
    FactionSquads = {
        Arm = {
            { 'armacsub', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'coracsub', 1, 1, 'support', 'None' }
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
    Name = 'T3BuildEngineerAirSCTA',
    FactionSquads = {
        Arm = {
            { 'armcsa', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'corcsa', 1, 1, 'support', 'None' }
        },
    }
}

PlatoonTemplate {
    Name = 'T2BuildEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armack', 1, 2, 'support', 'None' },
            { 'armfark', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'coracv', 1, 2, 'support', 'None' },
            { 'cornecro', 1, 1, 'support', 'None' },
        },
    }
}
PlatoonTemplate {
    Name = 'T2BuildFieldEngineerSCTA',
    FactionSquads = {
        Arm = {
            { 'armfark', 1, 1, 'support', 'None' }
        },
        Core = {
            { 'cornecro', 1, 1, 'support', 'None' }
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

