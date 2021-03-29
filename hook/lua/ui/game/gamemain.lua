TAFirstUpdate = OnFirstUpdate

function OnFirstUpdate()
    TAFirstUpdate()
    import('/lua/UserMusic.lua').StartTAMusic()
end