do

    skins = table.merged( skins, {
    arm = {
        default = "uef",
        texturesPath = "/textures/ui/uef",
        imagerMesh = "/meshes/game/map-border_squ_uef_mesh",
        imagerMeshHorz = "/meshes/game/map-border_hor_uef_mesh",
        fontColor = "5effe9",
    },
    core = {
        default = "cybran",
        texturesPath = "/textures/ui/cybran",
        imagerMesh = "/meshes/game/map-border_squ_cybran_mesh",
        imagerMeshHorz = "/meshes/game/map-border_hor_cybran_mesh",
        fontColor = "ff9400",
    },
})
-- Do this again since now nomads isn't flattened yet and we added things to default.
-- Flatten skins for performance. Note that this doesn't avoid the need to scan texture paths.
for k, v in skins do
    local default = skins[v.default]
    while default do
        -- Copy the entire default chain into the toplevel skin.
        table.assimilate(v, default)

        default = skins[default.default]
    end
end

end