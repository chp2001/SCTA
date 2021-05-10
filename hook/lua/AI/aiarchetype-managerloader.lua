--WARN('['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] * AI-Uveso: offset aiarchetype-managerloader.lua' )
--200

SCTALocationRangeManagerThread = LocationRangeManagerThread
function LocationRangeManagerThread(aiBrain)
   if not aiBrain.SCTAAI then
    return SCTALocationRangeManagerThread(aiBrain)
   end
end
