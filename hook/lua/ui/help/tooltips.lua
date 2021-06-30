do

    -- TODO: make sure all tooltips are in
    
    local TATooltips = {
    lob_arm = { 
        title = "ARM", 
	description = "Faction devoted Human Conscious free of Machine"
    }, 
    lob_core = { 
        title = "CORE", 
	description = "Faction goal of achieving immortality for mankind via transferring mind to machine"
    }, 
    mfd_idle_fieldengineer = {
        title = "Idle Field Engineers",
        description = "Idle Field Engineers",
    },
    mfd_idle_terrainengineer = {
        title = "Idle Speciality Terrain Engineers",
        description = "Idle Speciality Terrain Engineers",
    },
}
Tooltips = table.merged( Tooltips, TATooltips )

end

