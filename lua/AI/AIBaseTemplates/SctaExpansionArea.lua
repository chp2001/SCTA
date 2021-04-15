
BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAIExpansion',
    Builders = {

        -- Unit Builders
        'SCTAAILandBuilder',
        'SCTAAIAirBuilder',
        'SCTAAILandFormers',
        'SCTAAIAirFormers',

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
        if not aiBrain.SCTAAI then   
            return -1
        elseif markerType != 'Expansion Area' then
                --LOG('Ai Personality is '..per)
                --LOG('IEXISTEXPAND')
            return 25, 'SCTAAIExpansion'
        else
            --LOG('Return sctaai personality')
        return -1
        end
    end,

}

