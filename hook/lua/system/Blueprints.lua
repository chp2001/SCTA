local TAExtractBuildMeshBlueprint = ExtractBuildMeshBlueprint

function ExtractBuildMeshBlueprint(bp)
	TAExtractBuildMeshBlueprint(bp)
	local FactionName = bp.General.FactionName
	if FactionName == 'ARM' or FactionName == 'CORE' then 
		local meshid = bp.Display.MeshBlueprint
		if not meshid then return end

		local meshbp = original_blueprints.Mesh[meshid]
		if not meshbp then return end

		local shadername = 'TABuild'
		-- local secondaryname = '/textures/effects/' .. FactionName .. 'BuildSpecular.dds'

		local buildmeshbp = table.deepcopy(meshbp)
		if buildmeshbp.LODs then
			for i,lod in buildmeshbp.LODs do
				lod.ShaderName = shadername
				-- lod.SecondaryName = secondaryname
			end
		end
		buildmeshbp.BlueprintId = meshid .. '_build'
		bp.Display.BuildMeshBlueprint = buildmeshbp.BlueprintId
		MeshBlueprint(buildmeshbp)
	end
end