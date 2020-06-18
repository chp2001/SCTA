do
    table.insert(Factions, {
        {
            Key = 'core',
            Category = 'CORE',            
            FactionInUnitBp = 'CORE',
            IsCustomFaction = 'true',
            DisplayName = "CORE",
            SoundPrefix = 'ta',
            InitialUnit = 'CORCOM',
            CampaignFileDesignator = 'K',
            TransmissionLogColor = 'ffff0000',
            Icon = "/mods/SCTA/textures/ui/common/widgets/faction-icons-alpha_bmp/core_ico.dds",
            VeteranIcon = "/mods/SCTA/textures/ui/common/game/veteran-logo_bmp/core-veteran_bmp.dds",
            SmallIcon = "/mods/SCTA/textures/ui/common/faction_icon-sm/core_ico.dds",
            LargeIcon = "/mods/SCTA/textures/ui/common/faction_icon-lg/core_ico.dds",
            TooltipID = 'lob_core',
            DefaultSkin = 'cybran',
            loadingMovie = '/movies/cybran_load.sfd',
            loadingColor = 'FFe24f2d',
            loadingTexture = '/cybran_load.dds',
            IdleEngTextures = {
                T1 = '/mods/SCTA/textures/ui/common/icons/units/corck_icon.dds',
                T2 = '/mods/SCTA/textures/ui/common/icons/units/corack_icon.dds',
            },
            IdleFactoryTextures = {
                LAND = {
                    '/mods/SCTA/textures/ui/common/icons/units/corlab_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/coralab_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/corhp_icon.dds',
                },
                AIR = {
                    '/mods/SCTA/textures/ui/common/icons/units/corap_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/coraap_icon.dds',
                },
                NAVAL = {
                    '/mods/SCTA/textures/ui/common/icons/units/corsy_icon.dds',
                    '/mods/SCTA/textures/ui/common/icons/units/corasy_icon.dds',
                },
            },
            GAZ_UI_Info = {
                BuildingIdPrefixes = { 'cor', },
            },
        },
    })
end