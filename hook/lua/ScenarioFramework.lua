
SCTASpawnCommander = SpawnCommander
function SpawnCommander(brain, unit, effect, name, PauseAtDeath, DeathTrigger, enhancements)
   local ABrain = GetArmyBrain(brain);
    ScenarioUtils.CreateWind()
    if(ABrain.BrainType == 'Human') then
        local ACU = ScenarioUtils.CreateInitialArmyUnit(brain, 'mas0001')
        if PauseAtDeath then
            PauseUnitDeath(ACU)
        end
        if DeathTrigger then
            CreateUnitDeathTrigger(DeathTrigger, ACU)
        end
        return ACU
    else
        return SCTASpawnCommander(brain, unit, effect, name, PauseAtDeath, DeathTrigger, enhancements)
    end
end