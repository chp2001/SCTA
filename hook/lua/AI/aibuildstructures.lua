TAExecuteBuildStructure = AIExecuteBuildStructure
TAAIBuildAdjacency = AIBuildAdjacency

function AIExecuteBuildStructure(aiBrain, builder, buildingType, closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    if not aiBrain.SCTAAI then
        return TAExecuteBuildStructure(aiBrain, builder, buildingType, closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    end
    local FactionToIndex  = { UEF = 1, AEON = 2, CYBRAN = 3, SERAPHIM = 4, NOMADS = 5, ARM = 6, CORE = 7}
    local factionIndex = aiBrain:GetFactionIndex()
    local whatToBuild = aiBrain:DecideWhatToBuild( builder, buildingType, buildingTemplate)
    if not whatToBuild then
        return
    end
    local relativeTo
    if closeToBuilder then
        relativeTo = closeToBuilder:GetPosition()
    elseif builder.BuilderManagerData and builder.BuilderManagerData.EngineerManager then
        relativeTo = builder.BuilderManagerData.EngineerManager:GetLocationCoords()
    else
        local startPosX, startPosZ = aiBrain:GetArmyStartPos()
        relativeTo = {startPosX, 0, startPosZ}
    end
    local location = false
    if IsResource(buildingType) then
        location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, baseTemplate, relative, closeToBuilder, 'Enemy', relativeTo[1], relativeTo[3], 5)
    else
        location = aiBrain:FindPlaceToBuild(buildingType, whatToBuild, baseTemplate, relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
    end
    if not location and reference then
        for num,offsetCheck in RandomIter({1,2,3,4,5,6,7,8}) do
          Faction = FactionToIndex[builder.factionCategory] or factionIndex
            location = aiBrain:FindPlaceToBuild( buildingType, whatToBuild, BaseTmplFile['MovedTemplates'..offsetCheck][Faction], relative, closeToBuilder, nil, relativeTo[1], relativeTo[3])
            if location then
                break
            end
        end
    end
    
    if location then
        local relativeLoc = BuildToNormalLocation(location)
        if relative then
            relativeLoc = {relativeLoc[1] + relativeTo[1], relativeLoc[2] + relativeTo[2], relativeLoc[3] + relativeTo[3]}
        end

        AddToBuildQueue(aiBrain, builder, whatToBuild, NormalToBuildLocation(relativeLoc), false)
        return
    end
end

function AIBuildAdjacency( aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    if not aiBrain.SCTAAI then
        return TAAIBuildAdjacency( aiBrain, builder, buildingType , closeToBuilder, relative, buildingTemplate, baseTemplate, reference, NearMarkerType)
    end
    AIExecuteBuildStructure( aiBrain, builder, buildingType, builder, true,  buildingTemplate, baseTemplate )
end