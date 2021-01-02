local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua')

function SpawnCommander(brain, unit, effect, name, PauseAtDeath, DeathTrigger, enhancements)
	local ABrain = GetArmyBrain(brain);
	if(ABrain.BrainType == 'Human') then
	local ACU = ScenarioUtils.CreateInitialArmyUnit(brain, 'mas0001')
	if PauseAtDeath then
		PauseUnitDeath(ACU)
	end
	if DeathTrigger then
		CreateUnitDeathTrigger(DeathTrigger, ACU)
	end
	ScenarioUtils.CreateWind()
	return ACU
	else
	local ACU = ScenarioUtils.CreateArmyUnit(brain, unit)
    local bp = ACU:GetBlueprint()
    local bonesToHide = bp.WarpInEffect.HideBones
    local delay = 0

    local function CreateEnhancements(unit, enhancements, delay)
        if delay then
            WaitSeconds(delay)
        end

        for _, enhancement in enhancements do
            unit:CreateEnhancement(enhancement)
        end
    end

    local function GateInEffect(unit, effect, bonesToHide)
        if effect == 'Gate' then
            delay = 0.75
            ForkThread(FakeGateInUnit, unit, nil, bonesToHide)
        elseif effect == 'Warp' then
            delay = 2.1
            unit:PlayCommanderWarpInEffect(bonesToHide)
        else
            WARN('*WARNING: Invalid effect type: ' .. effect .. '. Available types: Gate, Warp.')
        end
    end

    if enhancements and effect then
        -- Don't hide upgrade bones that we want add on the command unit
        for _, enh in enhancements do
            if bp.Enhancements[enh].ShowBones then
                for _, bone in bp.Enhancements[enh].ShowBones do
                    table.removeByValue(bonesToHide, bone)
                end
            end
        end

        GateInEffect(ACU, effect, bonesToHide)
        -- Creating upgrades needs to be delayed until the effect plays, else the upgrade bone would show up before the rest of the unit
        ForkThread(CreateEnhancements, ACU, enhancements, delay)
    elseif enhancements then
        CreateEnhancements(ACU, enhancements)
    elseif effect then
        GateInEffect(ACU, effect)
    end

    -- If true is passed as parameter then it uses default name.
    if name == true then
        ACU:SetCustomName(GetArmyBrain(brain).Nickname)
    elseif type(name) == 'string' then
        ACU:SetCustomName(name)
    end

    if PauseAtDeath then
        PauseUnitDeath(ACU)
    end

    if DeathTrigger then
        CreateUnitDeathTrigger(DeathTrigger, ACU)
    end

    return ACU
end
end