PlatoonTemplate {
    Name = 'T2MassExtractorUpgrade',
    Plan = 'UnitUpgradeAI',
    GlobalSquads = {
        { categories.MASSEXTRACTION * categories.TECH2 - categories.ARM - categories.CORE, 1, 1, 'support', 'none' }
    },
}
