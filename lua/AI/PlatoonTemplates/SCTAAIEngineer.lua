PlatoonTemplate {
    Name = 'CommanderBuilderSCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.COMMAND, 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderT12SCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * (categories.LEVEL1 + categories.LEVEL2) - categories.ENGINEERSTATION , 1, 1, 'support', 'None' }
    },
}

PlatoonTemplate {
    Name = 'EngineerBuilderSCTA',
    Plan = 'EngineerBuildAISCTA',
    GlobalSquads = {
        { categories.ENGINEER * categories.LEVEL1, 1, 1, 'support', 'None' }
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
            { 'armack', 1, 1, 'support', 'None' },
        },
        Core = {
            { 'coracv', 1, 1, 'support', 'None' },
        },
    }
}

