--#****************************************************************************
--# UserMusic
--# Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
--#
--#****************************************************************************

--#****************************************************************************
--# Config options
--#****************************************************************************

-- List of battle cues to cycle through
local TABattleCues = {
    Sound({Cue = 'Battle', Bank = 'TA_Music'}),
}

-- List of peace cues to cycle through
local TAPeaceCues = {
    Sound({Cue = 'Building', Bank = 'TA_Music'}),
}

function StartTAMusic()
    TAPlayMusic(TABattleCues[BattleCueIndex], 0)
end


function TAPlayMusic(cue, delay)
    if(musicThread) then KillThread(musicThread) end

    musicThread = ForkThread(
        function()
            local delay = delay or 0

            if currentMusic then
                StopSound(currentMusic, delay == 0)
                if delay > 0 then
                    WaitFor(currentMusic)
                    WaitSeconds(delay)
                end

                currentMusic = nil
            end


            currentMusic = PlaySound(cue)
            WaitSeconds(10)
            StopSound(currentMusic)
            StartPeaceMusic()
            if paused then
                WaitSeconds(1)
                PauseSound("Music", true)
            end
        end)
end


function StartBattleMusic()
    BattleStart = GameTick()
    local coinFlip = math.random(2)
    if coinFlip == 1 then
    PlayMusic(TABattleCues[BattleCueIndex], 0)
    elseif coinFlip == 2 then
    PlayMusic(BattleCues[BattleCueIndex], 0) -- immediately
    end
    BattleCueIndex = math.mod(BattleCueIndex,table.getn(BattleCues)) + 1

    if battleWatch then KillThread(battleWatch) end
    battleWatch = ForkThread(
        function ()
            while GameTick() - LastBattleNotify < PeaceTimer do
                WaitSeconds(1)
            end

            StartPeaceMusic()
        end
)
end

function StartPeaceMusic()
    BattleStart = 0
    BattleEventCounter = 0
    LastBattleNotify = GameTick()
    local coinFlip = math.random(2)
    if coinFlip == 1 then
    PlayMusic(TAPeaceCues[PeaceCueIndex], 3)
    elseif coinFlip == 2 then
    PlayMusic(PeaceCues[PeaceCueIndex], 3)
    end
    PeaceCueIndex = math.mod(PeaceCueIndex, table.getsize(PeaceCues)) + 1
end