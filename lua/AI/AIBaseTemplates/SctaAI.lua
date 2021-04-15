--[[
    File    :   /lua/AI/AIBaseTemplates/SCTAAI.lua
    Author  :   SoftNoob
    Summary :
        Lists AIs to be included into the lobby, see /lua/AI/CustomAIs_v2/SorianAI.lua for another example.
        Loaded in by /lua/ui/lobby/aitypes.lua, this loads all lua files in /lua/AI/CustomAIs_v2/
]]

BaseBuilderTemplate {
    BaseTemplateName = 'SCTAAI',
    Builders = {
        -- List all our builder grous here
        -- ACU
        'SCTAAICommanderBuilder',
        -- Unit Builders
        'SCTAAIEngineerBuilder',
        'SCTAAILandBuilder',
        'SCTAAIAirBuilder',
        'SCTAAILandFormers',
        'SCTAAIAirFormers',
        'SCTAAIUniversalFormers',

        'SCTAAIEngineerMiscBuilder',
        'SCTAAIEngineerEcoBuilder',
        'SCTAAIFactoryBuilders',
        'SCTAUpgrades',
        'SCTAExpansionBuilders',
        --MiscFunctions
        'SCTAAssisters',
    },
    NonCheatBuilders = {
        -- Specify builders that are _only_ used by non-cheating AI (e.g. scouting)
    },
    BaseSettings = { },
    ExpansionFunction = function(aiBrain, location, markerType)
        --LOG('MAIN')
        return -1
    end,
    
    FirstBaseFunction = function(aiBrain)

        local per = ScenarioInfo.ArmySetup[aiBrain.Name].AIPersonality
        if per == 'sctaaiarm' or per == 'sctaaicore' or per == 'sctaaiarmcheat' or per == 'sctaaicorecheat' then
            --LOG('Return sctaai personality')
            return 1000, 'SCTAAI'
        end
        return -1
    end,
}