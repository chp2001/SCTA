
BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAIExpansion',
    Builders = {

        -- Unit Builders
        'SCTAAILandBuilder',
        'SCTAAIAirBuilder',
        'SCTAAILandFormers',
        'SCTAAIAirFormers',
        'SCTAAIT3Formers',
        'SCTAAIT3Builder',

        'SCTAExpansionBuilders',
        'SCTAAIEngineerMiscBuilder',
        'SCTAAIFactoryExpansions',
        'SCTAAIEngineerEcoBuilder',
        --Misc Function
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
        --local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        --LOG('Ai Personality is '..per)
        if not aiBrain.SCTAAI then
            return -1
        end
        if markerType ~= 'Expansion Area' then
                ---LOG('IEXISTSTART')
                return -1
            end
        --LOG('IEXISTEXPANDFAIL')
        --LOG('Return sctaai personality')
        return 15
    end,
}

