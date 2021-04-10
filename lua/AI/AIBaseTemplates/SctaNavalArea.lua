
BaseBuilderTemplate {
    BaseTemplateName = 'SCTANavalExpansion',
    Builders = {
        'SCTAAINavalBuilder',
        'SCTANavalFormer',

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
            Land = 0,
            Air = 0,
            Sea = 4,
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
        if not per == 'sctaaiarm' or per == 'sctaaicore' or per == 'sctaaiarmcheat' or per == 'sctaaicorecheat' then
            return -1
        end
        if markerType != 'Naval Area' then
            return 12
        end
        --LOG('Return sctaai personality')
        return 1000, 'SCTANavalExpansion'
    end,
}

