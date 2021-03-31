--#****************************************************************************
--# UserMusic
--# Copyright © 2006 Gas Powered Games, Inc.  All rights reserved.
--#
--#****************************************************************************

--#****************************************************************************
--# Config options
--#****************************************************************************
local TAStartBattleMusic = StartBattleMusic
local TAStartPeaceMusic = StartPeaceMusic
-- List of battle cues to cycle through
local TABattleCues = {
    Sound({Cue = 'Battle', Bank = 'TA_Music'}),
}

-- List of peace cues to cycle through
local TAPeaceCues = {
    Sound({Cue = 'Building', Bank = 'TA_Music'}),
}

function StartBattleMusic()
    local coinFlip = math.random(2)
    if coinFlip == 1 then
    PlayMusic(TABattleCues[BattleCueIndex], 0)
    BattleCueIndex = math.mod(BattleCueIndex,table.getn(TABattleCues)) + 1
    else
    TAStartBattleMusic()
    end
end

function StartPeaceMusic()
    local coinFlip = math.random(2)
    if coinFlip == 1 then
    PlayMusic(TAPeaceCues[PeaceCueIndex], 3)
    PeaceCueIndex = math.mod(PeaceCueIndex, table.getsize(TAPeaceCues)) + 1
    else
    TAStartPeaceMusic()
    end
end