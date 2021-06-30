TAEngineerBuildStructure = EngineerBuildStructure

function EngineerBuildStructure(aiBrain, builder, building, brainBaseTemplate, buildingTemplate)
    if not aiBrain.SCTAAI then
        return EngineerBuildStructure(aiBrain, builder, building, brainBaseTemplate, buildingTemplate)
    end
    local structureCategory
    if not buildingTemplate then
        buildingTemplate = BuildingTemplates[aiBrain:GetFactionIndex()]
    end
    for k,v in buildingTemplate do
        if building == v[1] then
            structureCategory = v[2]
            break
        end
    end
    if building == 'Resource' or building == 'T1HydroCarbon' then
        for l,type in brainBaseTemplate.Template do
            if type[1][1] == building.StructureType then
                for m,location in type do
                    if m > 1 then
                        if aiBrain:CanBuildStructureAt(structureCategory, {location[1], 0, location[2]}) then
                            IssueStop({builder})
                            IssueClearCommands({builder})
                            local result = aiBrain:BuildStructure(builder, structureCategory, location, false)
                            if result then
                                return true
                            end
                        end
                    end
                end
            end
        end
    else
        if aiBrain:FindPlaceToBuild( building, structureCategory, brainBaseTemplate, false, nil ) then
            IssueStop({builder})
            IssueClearCommands({builder})
            if AIBuildStructures.AIExecuteBuildStructureSCTAAI(aiBrain, builder, building, builder, false,
                                                         buildingTemplate, brainBaseTemplate) then
                return true
            end
        end
    end
    return false
end