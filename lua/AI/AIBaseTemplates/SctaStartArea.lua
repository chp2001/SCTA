
BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAISTARTEXPANSION',
    Builders = {
        -- List all our builder grous here
        -- ACU
        'SCTAAICommanderBuilder',
       
        'SCTAAILandBuilder',
        'SCTAAIAirBuilder',
        'SCTAAILandFormers',
        'SCTAAIAirFormers',

        -- Buildings etc
        
        'SCTAExpansionBuilders',
        'SCTAAIEngineerEcoBuilder',
        'SCTAAIFactoryExpansions',
        'SCTAAssisters',
    },
    BaseSettings = {
        EngineerCount = {
            Tech1 = 2, 
            Tech2 = 1, 
            Tech3 = 1, 
            SCU = 0,
        },
        FactoryCount = {
            Land = 4,
            Air = 2,
            Sea = 1,
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
        LOG('Ai Personality is '..per)
        if not per == 'SCTAAI' then
            return -1
        end
        if markerType != 'Start Location' then
            return 10, 'SCTAAISTARTEXPANSION'
        end
        --LOG('Return sctaai personality')
        return 1000, 'SCTAAISTARTEXPANSION'
    end,
}

