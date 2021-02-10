PlatoonTemplate {
    Name = 'T2MassExtractorUpgrade',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        { categories.MASSEXTRACTION * categories.TECH2 - categories.LEVEL2, 1, 1, 'support', 'none' }
    },
}
