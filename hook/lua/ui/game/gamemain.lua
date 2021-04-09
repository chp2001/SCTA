-- save original CreateUI function.
local DragunTACreateUI = CreateUI 

-- overwrite original CreateUI function.
function CreateUI(isReplay) 
	-- call original function first.
	DragunTACreateUI(isReplay) 

	ForkThread(function()
        WaitSeconds(3)
        ConExecute('d3d_windowscursor true')  
    end)
end