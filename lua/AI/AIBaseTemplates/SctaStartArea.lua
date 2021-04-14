
BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAISTARTEXPANSION',
    Builders = {
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
        'SCTAAIEngineerMiscBuilder',
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
        --LOG('Ai Personality is '..per)
        if not per == 'SCTAAI' then
            return -1
        end
        --LOG('IEXIST')
        if markerType != 'Start Location' then
            ---LOG('IEXISTSTART')
            return 20, 'SCTAAISTARTEXPANSION'
        end
        --LOG('IEXISTFAILSTART')
        --LOG('Return sctaai personality')
        return 10, 'SCTAAI'
    end,
}

