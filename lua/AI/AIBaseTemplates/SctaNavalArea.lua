BaseBuilderTemplate {
    BaseTemplateName = 'SCTANavalExpansion',
    Builders = {
        'SCTAAINavalBuilder',
        'SCTANavalFormer',
        'SCTAUpgrades',
        'SCTAAIT3Builder',

        -- Buildings etc
        'SCTAExpansionBuilders',
        'SCTAAIEngineerNavalMiscBuilder',
    },
    BaseSettings = {
        EngineerCount = {
            Tech1 = 6, 
            Tech2 = 4, 
            Tech3 = 1, 
            SCU = 0,
        },
        FactoryCount = {
            Land = 1,
            Air = 1,
            Sea = 2,
            Gate = 0,
        },
        MassToFactoryValues = {
            T1Value = 4,
            T2Value = 12,
            T3Value = 18
        },
    },
    ExpansionFunction = function(aiBrain, location, markerType)   
        local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        --LOG('Ai Personality is '..per)
        if not per == 'SCTAAI' then
            return -1
        end
        if markerType != 'Naval Area' then
            return -1
        end
        --LOG('Return sctaai personality')
        --LOG('*TALtype2', location)
        return 55, 'SCTANavalExpansion'
    end,
}

