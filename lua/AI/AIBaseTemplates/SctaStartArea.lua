
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
            Land = 8,
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
        --local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        --LOG('Ai Personality is '..per)
        if not aiBrain.SCTAAI then
            return -1
        end
        --LOG('IEXIST')
        if markerType ~= 'Start Location' then
            ---LOG('IEXISTSTART')
            return -1
        end
        --LOG('IEXISTFAILSTART')
        --LOG('Return sctaai personality')
        return 20
    end,
}

