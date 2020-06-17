do
    table.insert(Factions, {
        {
            Key = 'arm',
            Category = 'ARM',
            FactionInUnitBp = 'arm',
            IsCustomFaction = true,
            DisplayName = "ARM",
            SoundPrefix = 'ta',
            InitialUnit = 'ARMCOM',
            CampaignFileDesignator = 'M',
            TransmissionLogColor = 'ff0000ff',
            Icon = "/mods/SCTA/textures/ui/common/widgets/faction-icons-alpha_bmp/arm_ico.dds",
            VeteranIcon = "/mods/SCTA/textures/ui/common/game/veteran-logo_bmp/arm-veteran_bmp.dds",
            SmallIcon = "/mods/SCTA/textures/ui/common/faction_icon-sm/arm_ico.dds",
            LargeIcon = "/mods/SCTA/textures/ui/common/faction_icon-lg/arm_ico.dds",
            TooltipID = 'lob_arm',
            DefaultSkin = 'uef',
            loadingMovie = '/movies/UEF_load.sfd',
            loadingColor = 'FFbadbdb',
            loadingTexture = '/UEF_load.dds',
            IdleEngTextures = {
                T1 = '/mods/SCTA/textures/ui/common/icons/units/armck_icon.dds',
                T2 = '/mods/SCTA/textures/ui/common/icons/units/armack_icon.dds',
            },
            IdleFactoryTextures = {
                LAND = {
                    '/mods/SCTA/textures/ui/common/icons/units/armlab_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/armalab_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/armhp_icon.dds',
                },
                AIR = {
                    '/mods/SCTA/textures/ui/common/icons/units/armap_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/armaap_icon.dds',
                },
                NAVAL = {
                    '/mods/SCTA/textures/ui/common/icons/units/armsy_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/armasy_icon.dds',
                },
            },
            GAZ_UI_Info = {
                BuildingIdPrefixes = { 'arm', },
            },
        },
    })
end