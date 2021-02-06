#***************************************************************************
#*
#**  File     :  /lua/ai/AIBaseTemplates/TurtleExpansion.lua
#**
#**  Summary  : Manage engineers for a location
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAI Expansion',
    Builders = {
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
        'SCTAAIExpansionBuilder',
    },
    NonCheatBuilders = {

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
        if markerType != 'Start Location' then
            return 0
        end

        local personality = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        if not ( personality == 'sctaaiarm' or personality == 'sctaaicore' ) then
            return -1
        end

        return 10
    end,
}