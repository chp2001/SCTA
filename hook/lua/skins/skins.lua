do

    skins = table.merged( skins, {
    arm = {
        default = "default",
        texturesPath = "/textures/ui/uef",
        imagerMesh = "/meshes/game/map-border_squ_uef_mesh",
        imagerMeshHorz = "/meshes/game/map-border_hor_uef_mesh",
        buttonFont = "Zeroes Three",
        factionFont = "Zeroes Three",
        bodyFont = "Arial",
        fixedFont = "Arial",
        titleFont = "Zeroes Three",
        bodyColor = "FFE24F2D",
        factionFontOverColor = "FFff0000",
        factionFontDownColor = "FFFFFFFF",
        factionTextColor = "FF9BCBDF",
        factionBackColor = "FFD68E00",
        fontOverColor = "FFFFFFFF",
        fontDownColor = "FF513923",
        fontColor = "FFE24F2D",
        dialogCaptionColor = "FFD6C6BC",
        dialogColumnColor = "FFAD976E",
        dialogButtonColor = "FF4EAA7F",
        dialogButtonFont = "Zeroes Three",
        highlightColor = "FFA59075",
        disabledColor = "FF3D3630",
        tooltipBorderColor = "FF436EEE",
        tooltipTitleColor = "FF3F1700",
        tooltipBackgroundColor = "FF000000",
        dialogColumnColor = "FFC1782A",
        menuFontSize = 18,
        layouts = {
            "bottom",
            "left",
            "right"
        },
    },
    core = {
        default = "default",
        texturesPath = "/textures/ui/cybran",
        imagerMesh = "/meshes/game/map-border_squ_cybran_mesh",
        imagerMeshHorz = "/meshes/game/map-border_hor_cybran_mesh",
        buttonFont = "Zeroes Three",
        factionFont = "Zeroes Three",
        bodyFont = "Arial",
        fixedFont = "Arial",
        titleFont = "Zeroes Three",
        bodyColor = "FFC7E98A",
        factionFontOverColor = "FFff0000",
        factionFontDownColor = "FFFFFFFF",
        factionTextColor = "FFABAB83",
        factionBackColor = "FFD68E00",
        fontOverColor = "FFFFFFFF",
        fontDownColor = "FF513923",
        fontColor = "FFC7E98A",
        dialogCaptionColor = "FFD6C6BC",
        dialogColumnColor = "FFAD976E",
        dialogButtonColor = "FF4EAA7F",
        dialogButtonFont = "Zeroes Three",
        highlightColor = "FFA59075",
        disabledColor = "FF3D3630",
        tooltipBorderColor = "FF901427",
        tooltipTitleColor = "FF3F1700",
        tooltipBackgroundColor = "FF000000",
        dialogColumnColor = "FFC1782A",
        menuFontSize = 18,
        layouts = {
            "bottom",
            "left",
            "right"
        },
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
