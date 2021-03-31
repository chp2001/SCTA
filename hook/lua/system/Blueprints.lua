do

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

local TAExtractCloakMeshBlueprint = ExtractCloakMeshBlueprint

function ExtractCloakMeshBlueprint(bp)
	TAExtractCloakMeshBlueprint(bp)
	local FactionName = bp.General.FactionName
	if FactionName == 'ARM' or FactionName == 'CORE' then 
	local meshid = bp.Display.MeshBlueprint
    if not meshid then return end

    local meshbp = original_blueprints.Mesh[meshid]
    if not meshbp then return end

    local cloakmeshbp = table.deepcopy(meshbp)
    if cloakmeshbp.LODs then
        for i, cat in bp.Categories do
            if cat == 'ARM' or cat == 'CORE' then
                for i, lod in cloakmeshbp.LODs do
                    lod.ShaderName = 'TACloak'
                end
            end
        end
    end
    cloakmeshbp.BlueprintId = meshid .. '_cloak'
    bp.Display.CloakMeshBlueprint = cloakmeshbp.BlueprintId
    MeshBlueprint(cloakmeshbp)
	end
end

local TAExtractWreckageBlueprint = ExtractWreckageBlueprint

function ExtractWreckageBlueprint(bp)
	local FactionName = bp.General.FactionName
	if FactionName == 'ARM' or FactionName == 'CORE' then 
		local meshid = bp.Display.MeshBlueprint
		if not meshid then return end
	
		local meshbp = original_blueprints.Mesh[meshid]
		if not meshbp then return end
	
		local wreckbp = table.deepcopy(meshbp)
		if wreckbp.LODs then
			for i,lod in wreckbp.LODs do
				if lod.ShaderName == 'TMeshAlpha' or lod.ShaderName == 'NormalMappedAlpha' or lod.ShaderName == 'UndulatingNormalMappedAlpha' then
					lod.ShaderName = 'BlackenedNormalMappedAlpha'
				else
					lod.ShaderName = 'Wreckage'
					lod.SpecularName = '/env/common/props/wreckage_noise.dds'
					lod.NormalName = '/mods/SCTA-master/meshes/Wreck_NormalsTS.dds'
					lod.AlbedoName = '/mods/SCTA-master/meshes/Wreck_Albedo.dds'
				end
			end
		end
		wreckbp.BlueprintId = meshid .. '_wreck'
		bp.Display.MeshBlueprintWrecked = wreckbp.BlueprintId
		MeshBlueprint(wreckbp)
		else
		TAExtractWreckageBlueprint(bp)
	end
end


    local SCTAModBlueprints = ModBlueprints

    function ModBlueprints(all_blueprints)
        SCTAModBlueprints(all_blueprints)
	---SCTAFootprints(all_blueprints.Unit)
        TAGiveVet(all_blueprints.Unit)
    end

	function TAGiveVet(all_bps)
		for id, bp in all_bps do
			if bp.Weapon and bp.Categories then
				-- #9 CB Comment: we don't need to assign to 10 then reassign to 1-4. Only assign to 10 if there's not a match.
				local mul
				if table.find(bp.Categories, 'TECH1') then
					mul = 1
				elseif table.find(bp.Categories, 'TECH2') then
					mul = 2
				elseif table.find(bp.Categories, 'TECH3') then
					mul = 3
				elseif table.find(bp.Categories, 'EXPERIMENTAL') then
					mul = 4
				else
					mul = 10
				end
				-- #8 CB Comment: bp.Buffs.Regen won't exist if bp.Buffs doesn't, so don't double check it.
				if not bp.Buffs then
					bp.Buffs = {}
				elseif not bp.Buffs.Regen then
					bp.Buffs.Regen = {
						Level1 = 1 * mul,
						Level2 = 2 * mul,
						Level3 = 3 * mul,
						Level4 = 4 * mul,
						Level5 = 5 * mul,
					}
				end
				if not bp.Veteran then
					bp.Veteran =  {
						Level1 = 3 * mul,
						Level2 = 6 * mul,
						Level3 = 9 * mul,
						Level4 = 12 * mul,
						Level5 = 15 * mul,
					}
				end
			end
		end
	end
end