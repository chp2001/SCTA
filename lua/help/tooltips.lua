TATooltips = {
    lob_arm = { 
        title = "<LOC ARM>", 
	description = "Faction devoted Human Conscious free of Machine"
    }, 
    lob_core = { 
        title = "<LOC CORE>", 
	description = "Faction goal of achieving immortality for mankind via transferring mind to machine"
    }, 
}
--since we are merging unordered tables that contain ordered tables, we need to merge them manually instead of table.merged or whatever
function MergeTables(Tooltips), TATooltips)
    local newKeyGroups = table.copy(TATooltips)
    local newTable = {}
    for k,v in Tooltips do
        if TATooltips[k] then
            newTable[k] = table.cat(Tooltips[k],TATooltips[k])
            newKeyGroups[k] = nil
        else
            newTable[k] = Tooltips[k]
        end
    end
    
    for k,v in newKeyGroups do
        if not newTable[k] then
            newTable[k] = TATooltips[k]
        end
    end
    return newTable
end

Tooltips = MergeTables(Tooltips, TATooltips)

