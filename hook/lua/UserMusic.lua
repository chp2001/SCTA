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

local TABattleCueIndex = 1
local TAPeaceCueIndex = 1
function StartBattleMusic()
    local coinFlip = math.random(2)
    if coinFlip == 1 then
    PlayMusic(TABattleCues[TABattleCueIndex], 0)
    TABattleCueIndex = math.mod(TABattleCueIndex,table.getn(TABattleCues))
else
    TAStartBattleMusic()
    end
end

function StartPeaceMusic()
    local coinFlip = math.random(2)
    if coinFlip == 1 then
    PlayMusic(TAPeaceCues[TAPeaceCueIndex], 1)
    TAPeaceCueIndex = math.mod(TAPeaceCueIndex, table.getsize(TAPeaceCues))
    else
    TAStartPeaceMusic()
    end
end