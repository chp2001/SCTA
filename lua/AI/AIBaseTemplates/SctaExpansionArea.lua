BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAIExpansion',
    Builders = {
        -- List all our builder grous here
        -- ACU
        'SCTAAICommanderBuilder',
        
        -- Unit Builders
        'SCTAAILandBuilder',
        'SCTAAIAirBuilder',
        'SCTAAILandFormers',
        'SCTAAIAirFormers',
        
        -- Buildings etc
        'SCTAAIEnergyBuilder',
        'SCTAAIEngineerMassBuilder',
        'SCTAAIFactoryBuilders',
        'SCTAAIDefenseBuilder',
        'SctaExtractorUpgrades',
        'SCTAExpansionBuilders',
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
            Land = 3,
            Air = 1,
            Sea = 0,
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
        end
        if markerType ~= ('Expansion Area' or 'Start Location') then
            return -1
        end
        return 1000, 'SCTAAIExpansion'
    end,
}

