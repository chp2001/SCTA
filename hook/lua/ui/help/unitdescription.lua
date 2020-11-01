do

-- TODO: make sure all descriptions are up to date
-- TODO: reduce filesize a bit by removing all redundant texts in the LOC tags

Description = table.merged( Description, {

    -- Commanders
    ['corcom'] = "Towering Kbot with basic engineering suite, armed with the Disintigration Gun and a personal cloaking device. A Hero for Collective Conscious, who seeks to bring defeat to ARM Vermin",
    ['armcom'] = "Towering Kbot with basic engineering suite, armed with the Disintigration Gun and a personal cloaking device. A Freedom Fighter for Humanity, who seeks to take down the CORE Tyrants",
    
    -- Engineers
      -- T1 Con Kbot
    ['corck'] = "A CORE Engineering Kbot. Includes a Tech Level 2 military engineering suite, including the Advanced Kbot Lab.",
    ['armck'] = "An ARM Engineering Kbot. Includes a Tech Level 2 military engineering suite, including the Advanced Kbot Lab.",
    
      -- T2 Con Kbot
    ['corack'] = "A CORE Advanced Engineering Kbot. Builds Tech Level 2 and 3 structures, including the Krogoth Gantry",
    ['armack'] = "An ARM Advanced Engineering Kbot. Builds Tech Level 2 and 3 structures, including the Drake Gantry",
    
      -- T2 Specialist KBot
    ['cornecro'] = "An Advanced Engineer Unit. No engineering suite. Quickly rebuilds dead units instead of reclaiming them.",
    ['armfark'] = "An Advanced Engineer Unit. No engineering suite. The Fast Assist/Repair Kbot. Small, mobile frame for reclaiming wrecks and assisting factories",
    
      -- T1 Vehicle Con
    ['armcv'] = "An Engineering Vehicle. Includes a Tech Level 2 military engineering suite, including the Advanced Vehicle Plant.",
    ['corcv'] = "An Engineering Vehicle. Includes a Tech Level 2 military engineering suite, including the Advanced Vehicle Plant.",
    
      -- T2 Vehicle Con
    ['coracv'] = "An Advanced Engineering Vehicle. Includes a Tech Level 3 engineering suite, including the Krogoth Gantry",
    ['armacv'] = "An Advanced Engineering Vehicle. Includes a Tech Level 3 engineering suite, including the Drake Gantry",
    
      -- T1 Naval Con Ship
    ['corcs'] = "An Engineering Ship. Includes a naval engineering suite and may construct the Advanced Ship Yard",
    ['armcs'] = "An Engineering Ship. Includes a naval engineering suite and may construct the Advanced Ship Yard",
    
      -- T2 Naval Con Sub
    ['coracsub'] = "An Advanced Engineering Sub. Includes a T2 naval engineering suite and may construct the Seaplane Platform",
    ['armacsub'] = "An Advanced Engineering Sub. Includes a T2 naval engineering suite and may construct the Seaplane Platform",
    
      -- T1 Air Con
    ['armca'] = "An Engineering Aircraft Builds T1 Economic, and T2 Military",
    ['corca'] = "An Engineering Aircraft Builds T1 Economic, and T2 Military",
    
      -- T2 Air Con
    ['coraca'] = "An Advanced Engineering Aircraft can build T2 and T3 but not T1 building",
    ['armaca'] = "An Advanced Engineering Aircraft can build T2 and T3 but not T1 building",
    
      -- Hover Con
    ['corch'] = "An Engineering Hovercraft Builds T1 Economic, and T2 Military",
    ['armch'] = "An Engineering Hovercraft Builds T1 Economic, and T2 Military",
    
      -- Seaplane Con
    ['armcsa'] = "<LOC armcsa_help>."           ,
    ['corcsa'] = "<LOC corcsa_help>."           ,

    ['armaap'] = "<LOC armaap_help>."           ,
    ['armaas'] = "<LOC armaas_help>."           ,
    ['armah'] = "<LOC armah_help>."             ,
    ['armalab'] = "<LOC armalab_help>."         ,
    ['armamb'] = "<LOC armamb_help>."           ,
    ['armamd'] = "<LOC armamd_help>."           ,
    ['armamph'] = "<LOC armamph_help>."         ,
    ['armanac'] = "<LOC armanac_help>."         ,
    ['armanni'] = "<LOC armanni_help>."         ,
    ['armap'] = "<LOC armap_help>."             ,
    ['armarad'] = "<LOC armarad_help> With a much larger tranceiver, the advanced radar tower can detect approaching CORE forces far in advance, but is easily fooled by jamming and stealth."         ,
    ['armaser'] = "<LOC armaser_help>."         ,
    ['armason'] = "<LOC armason_help>."         ,
    ['armasp'] = "<LOC armasp_help>."           ,
    ['armasy'] = "<LOC armasy_help>."           ,
    ['armatl'] = "<LOC armatl_help>."           ,
    ['armatlas'] = "<LOC armatlas_help> Rapid air transport capable of ferrying ARM raiding forces deep within CORE territory. Carries 4 T1 land units.",
    ['armavp'] = "<LOC armavp_help>."           ,
    ['armawac'] = "<LOC armawac_help>."         ,
    ['armbats'] = "<LOC armbats_help>."         ,
    ['armbrawl'] = "<LOC armbrawl_help>."       ,
    ['armbrtha'] = "<LOC armbrtha_help>."       ,
    ['armbull'] = "<LOC armbull_help>."         ,
    ['armcarry'] = "<LOC armcarry_help>."       ,
    ['armckfus'] = "<LOC armckfus_help>."       ,
    ['armcroc'] = "<LOC armcroc_help>Capable of trundling the seabed, the Triton amphibious tank may take CORE coastal bases by surprise. Lacks any weaponry while beneath the water and is detectable by sonar."         ,
    ['armcrus'] = "<LOC armcrus_help>Armed with a twin plasma battery and depth charges, the Crusader is the mainstay ARM naval unit, capable of engaging ship and sub alike."         ,
    ['armdecom'] = "<LOC armdecom_help> When CORE forces detected the prescence of the lone ARM commander on their icy shores, a facimile commander had been constructed by the ARM in deception. Reclaims, repairs, and assists. No engineering suite nor Disintigration Gun. Explodes violently on death"       ,
    ['armdrag'] = "<LOC armdrag_help>."         ,
    ['armemp'] = "<LOC armemp_help>."           ,
    ['armestor'] = "<LOC armestor_help>."       ,
    ['armfast'] = "<LOC armfast_help>."         ,
    ['armfav'] = "<LOC armfav_help>."           ,
    ['armfido'] = "<LOC armfido_help>This four-legged friend of ARM packs a large main cannon atop its frame."         ,
    ['armfig'] = "<LOC armfig_help>."           ,
    ['armflak'] = "<LOC armflak_help>."         ,
    ['armflash'] = "<LOC armflash_help>Light tank armed with an EMG with devastating small-arms firepower. ARM's choice in disrupting CORE expansion."       ,
    ['armflea'] = "<LOC armflea_help>."         ,
    ['armfort'] = "<LOC armfort_help>."         ,
    ['armfus'] = "<LOC armfus_help>."           ,
    ['armgeo'] = "<LOC armgeo_help>."           ,
    ['armguard'] = "<LOC armguard_help>."       ,
    ['armham'] = "<LOC armham_help>."           ,
    ['armhawk'] = "<LOC armhawk_help>."         ,
    ['armhlt'] = "<LOC armhlt_help>."           ,
    ['armhp'] = "<LOC armhp_help>."             ,
    ['armjam'] = "<LOC armjam_help>."           ,
    ['armjeth'] = "<LOC armjeth_help>."         ,
    ['armlab'] = "<LOC armlab_help>."           ,
    ['armlance'] = "<LOC armlance_help>."       ,
    ['armlatnk'] = "<LOC armlatnk_help>."       ,
    ['armllt'] = "<LOC armllt_help>."           ,
    ['armmav'] = "<LOC armmav_help>."           ,
    ['armmark'] = "<LOC armmark_help>."           ,
    ['armmakr'] = "<LOC armmakr_help>Consumes energy to create metal. Useful in locations where deposits are scarce but requires immense energy to create and maintain."         ,
    ['armmanni'] = "<LOC armmanni_help>."       ,
    ['armmart'] = "<LOC armmart_help>."         ,
    ['armmerl'] = "<LOC armmerl_help>."         ,
    ['armmex'] = "<LOC armmex_help>."           ,
    ['armmh'] = "<LOC armmh_help>."             ,
    ['armmine1'] = "<LOC armmine1_help>."       ,
    ['armmine2'] = "<LOC armmine2_help>."       ,
    ['armmine3'] = "<LOC armmine3_help>."       ,
    ['armmine4'] = "<LOC armmine4_help>."       ,
    ['armmine5'] = "<LOC armmine5_help>."       ,
    ['armmine6'] = "<LOC armmine6_help>."       ,
    ['armmlv'] = "<LOC armmlv_help>."           ,
    ['armmmkr'] = "<LOC armmmkr_help>."         ,
    ['armmoho'] = "<LOC armmoho_help>."         ,
    ['armmship'] = "<LOC armmship_help>."       ,
    ['armmstor'] = "<LOC armmstor_help>."       ,
    ['armpeep'] = "<LOC armpeep_help>."         ,
    ['armpnix'] = "<LOC armpnix_help>."         ,
    ['armpt'] = "<LOC armpt_help>."             ,
    ['armpw'] = "<LOC armpw_help>."             ,
    ['armplat'] = "<LOC armplat_help>."           ,
    ['armrad'] = "<LOC armrad_help>."           ,
    ['armrl'] = "<LOC armrl_help>."             ,
    ['armrock'] = "<LOC armrock_help>."         ,
    ['armroy'] = "<LOC armroy_help>."           ,
    ['armsam'] = "<LOC armsam_help>."           ,
    ['armscab'] = "<LOC armscab_help>."         ,
    ['armscram'] = "<LOC armscram_help>."           ,
    ['armseer'] = "<LOC armseer_help>."         ,
    ['armsehak'] = "<LOC armsehak_help>."           ,
    ['armseap'] = "<LOC armseap_help>."           ,
    ['armsh'] = "<LOC armsh_help>."             ,
    ['armsilo'] = "<LOC armsilo_help>."         ,
    ['armsnipe'] = "<LOC armsnipe_help>."           ,
    ['armsolar'] = "<LOC armsolar_help>."       ,
    ['armsonar'] = "<LOC armsonar_help>."       ,
    ['armspid'] = "<LOC armspid_help>."         ,
    ['armspy'] = "<LOC armspy_help>."         ,
    ['armstump'] = "<LOC armstump_help>."       ,
    ['armsub'] = "<LOC armsub_help>."           ,
    ['armsjam'] = "<LOC armsjam_help>."           ,
    ['armsfig'] = "<LOC armsfig_help>."           ,
    ['armsubk'] = "<LOC armsubk_help>."         ,
    ['armsy'] = "<LOC armsy_help>."             ,
    ['armtarg'] = "<LOC armtarg_help>."         ,
    ['armthund'] = "<LOC armthund_help>."       ,
    ['armtide'] = "<LOC armtide_help>."         ,
    ['armtl'] = "<LOC armtl_help>."             ,
    ['armvader'] = "<LOC armvader_help>."       ,
    ['armvp'] = "<LOC armvp_help>."             ,
    ['armvulc'] = "<LOC armvulc_help>."         ,
    ['armwar'] = "<LOC armwar_help>."           ,
    ['armwin'] = "<LOC armwin_help>."           ,
    ['armyork'] = "<LOC armyork_help>."         ,
    ['armzeus'] = "<LOC armzeus_help>."         ,
    ['coraap'] = "<LOC coraap_help>."           ,
    ['corah'] = "<LOC corah_help>."             ,
    ['corak'] = "<LOC corak_help>."             ,
    ['coralab'] = "<LOC coralab_help>."         ,
    ['coramph'] = "<LOC coramph_help>."         ,
    ['corap'] = "<LOC corap_help>."             ,
    ['corape'] = "<LOC corape_help>."           ,
    ['corarad'] = "<LOC corarad_help>."         ,
    ['corarch'] = "<LOC corarch_help>."         ,
    ['corason'] = "<LOC corason_help>."         ,
    ['corasp'] = "<LOC corasp_help>."           ,
    ['corasy'] = "<LOC corasy_help>."           ,
    ['coratl'] = "<LOC coratl_help>."           ,
    ['coravp'] = "<LOC coravp_help>."           ,
    ['corawac'] = "<LOC corawac_help>."         ,
    ['corbats'] = "<LOC corbats_help>."         ,
    ['corbuzz'] = "<LOC corbuzz_help>."         ,
    ['corcan'] = "<LOC corcan_help>."           ,
    ['corsumo'] = "<LOC corsumo_help>."           ,
    ['corcarry'] = "<LOC corcarry_help>."       ,
    ['corckfus'] = "<LOC corckfus_help>."       ,
    ['corcrash'] = "<LOC corcrash_help>."       ,
    ['corcrus'] = "<LOC corcrus_help>."         ,
    ['cordecom'] = "<LOC cordecom_help>."       ,
    ['cordoom'] = "<LOC cordoom_help>."         ,
    ['cordrag'] = "<LOC cordrag_help>."         ,
    ['corestor'] = "<LOC corestor_help>."       ,
    ['coreter'] = "<LOC coreter_help>."         ,
    ['corfast'] = "<LOC corfast_help>."         ,
    ['corfav'] = "<LOC corfav_help>."           ,
    ['corfhlt'] = "<LOC corfhlt_help>."         ,
    ['corfink'] = "<LOC corfink_help>."         ,
    ['corflak'] = "<LOC corflak_help>."         ,
    ['corfmd'] = "<LOC corfmd_help>."           ,
    ['corfort'] = "<LOC corfort_help>."         ,
    ['corfus'] = "<LOC corfus_help>."           ,
    ['corgant'] = "<LOC corgant_help>."         ,
    ['corgator'] = "<LOC corgator_help>."       ,
    ['corgeo'] = "<LOC corgeo_help>."           ,
    ['corgol'] = "<LOC corgol_help>."           ,
    ['corhlt'] = "<LOC corhlt_help>."           ,
    ['corhp'] = "<LOC corhp_help>."             ,
    ['corhrk'] = "<LOC corhrk_help>."         ,
    ['corhurc'] = "<LOC corhurc_help>."         ,
    ['corhunt'] = "<LOC corhunt_help>."           ,
    ['corint'] = "<LOC corint_help>."           ,
    ['corkrog'] = "<LOC corkrog_help>."         ,
    ['corlab'] = "<LOC corlab_help>."           ,
    ['corlevlr'] = "<LOC corlevlr_help>."       ,
    ['corllt'] = "<LOC corllt_help>."           ,
    ['cormabm'] = "<LOC cormabm_help>."         ,
    ['cormakr'] = "<LOC cormakr_help>."         ,
    ['cormart'] = "<LOC cormart_help>."         ,
    ['cormex'] = "<LOC cormex_help>."           ,
    ['cormh'] = "<LOC cormh_help>."             ,
    ['cormine1'] = "<LOC cormine1_help>."       ,
    ['cormine2'] = "<LOC cormine2_help>."       ,
    ['cormine3'] = "<LOC cormine3_help>."       ,
    ['cormine4'] = "<LOC cormine4_help>."       ,
    ['cormine5'] = "<LOC cormine5_help>."       ,
    ['cormine6'] = "<LOC cormine6_help>."       ,
    ['cormist'] = "<LOC cormist_help>."         ,
    ['cormlv'] = "<LOC cormlv_help>."           ,
    ['cormmkr'] = "<LOC cormmkr_help>."         ,
    ['cormoho'] = "<LOC cormoho_help>."         ,
    ['cormort'] = "<LOC cormort_help>."         ,
    ['cormship'] = "<LOC cormship_help>."       ,
    ['cormstor'] = "<LOC cormstor_help>."       ,
    ['corplas'] = "<LOC corplas_help>."         ,
    ['corplat'] = "<LOC corplat_help>."           ,
    ['corpt'] = "<LOC corpt_help>."             ,
    ['corpun'] = "<LOC corpun_help>."           ,
    ['corpyro'] = "<LOC corpyro_help>."         ,
    ['corrad'] = "<LOC corrad_help>."           ,
    ['corraid'] = "<LOC corraid_help>."         ,
    ['correap'] = "<LOC correap_help>."         ,
    ['corrl'] = "<LOC corrl_help>."             ,
    ['corroach'] = "<LOC corroach_help>."       ,
    ['corroy'] = "<LOC corroy_help>."           ,
    ['corseal'] = "<LOC corseal_help>."         ,
    ['corsent'] = "<LOC corsent_help>."         ,
    ['corsh'] = "<LOC corsh_help>."             ,
    ['corshad'] = "<LOC corshad_help>."         ,
    ['corshark'] = "<LOC corshark_help>."       ,
    ['corsjam'] = "<LOC corsjam_help>."       ,
    ['corssub'] = "<LOC corssub_help>."       ,
    ['corsfig'] = "<LOC corsfig_help>."           ,
    ['corseap'] = "<LOC corseap_help>."           ,
    ['corsilo'] = "<LOC corsilo_help>."         ,
    ['corsnap'] = "<LOC corsnap_help>."         ,
    ['corsolar'] = "<LOC corsolar_help>."       ,
    ['corsonar'] = "<LOC corsonar_help>."       ,
    ['corspec'] = "<LOC corspec_help>."         ,
    ['corspy'] = "<LOC corspy_help>."         ,
    ['corstorm'] = "<LOC corstorm_help>."       ,
    ['corsub'] = "<LOC corsub_help>."           ,
    ['corsy'] = "<LOC corsy_help>."             ,
    ['cortarg'] = "<LOC cortarg_help>."         ,
    ['corthud'] = "<LOC corthud_help>."         ,
    ['cortide'] = "<LOC cortide_help>."         ,
    ['cortitan'] = "<LOC cortitan_help>."       ,
    ['cortl'] = "<LOC cortl_help>."             ,
    ['cortoast'] = "<LOC cortoast_help>."       ,
    ['cortron'] = "<LOC cortron_help>."         ,
    ['corvalk'] = "<LOC corvalk_help>."         ,
    ['corvamp'] = "<LOC corvamp_help>."         ,
    ['corveng'] = "<LOC corveng_help>."         ,
    ['corvipe'] = "<LOC corvipe_help>."         ,
    ['corvp'] = "<LOC corvp_help>."             ,
    ['corvrad'] = "<LOC corvrad_help>."         ,
    ['corvroc'] = "<LOC corvroc_help>."         ,
    ['corvoyr'] = "<LOC corvoyr_help>."         ,
    ['corwin'] = "<LOC corwin_help>.CORE Power Generator, energy generated varies unpredictably"           ,
    ['mas0001'] = "<LOC mas0001_help>."         ,
    ['mss0001'] = "<LOC mss0001_help>."         ,
    ['mss0002'] = "<LOC mss0002_help>."         ,
    ['mss0003'] = "<LOC mss0003_help>."         ,
    ['mss0004'] = "<LOC mss0004_help>."         ,
    ['mss0005'] = "<LOC mss0005_help>."         ,
    ['mss0006'] = "<LOC mss0006_help>."         ,
    ['mss0007'] = "<LOC mss0007_help>."         ,

    ['armdrake'] = "<LOC armdrake_help> ARM KBot invoking Dragons of Bygone Eras. SCTABalance Only",
    ['armgant'] = "<LOC armgant_help> ARM Factory, that build ARM Drakes. SCTABalance Only",
    ['armspdaa'] = "<LOC armspdaa_help> For SCTABalance, Spider KBot to help ARM Kbots defend against air threats",
    ['armdvp'] = "<LOC armdvp_help>. For SCTABalance, an upgrade from ARMVP to access T2.",
    ['armadvp'] = "<LOC armadvp_help>. For SCTABalance, an upgrade from ARMDVP to access T3.",
    ['armdsy'] = "<LOC armdsy_help>. For SCTABalance, an upgrade from ARMSY to access T2.",
    ['armadsy'] = "<LOC armadsy_help>. For SCTABalance, an upgrade from ARMDSY to access T3.",
    ['armdap'] = "<LOC armdap_help>. For SCTABalance, an upgrade from ARMAP to access T2.",
    ['armdlab'] = "<LOC armdlab_help>. For SCTABalance, an upgrade from ARMLAB, to access T2.",
    ['armadlab'] = "<LOC armadlab_help>. For SCTABalance, an upgrade from ARMDLAB to access T3.",
    ['armhrk'] = "<LOC armhrk_help>."         ,
    ['corsling'] = "<LOC corsling_help> For SCTABalance, Turtle KBot to help CORE Kbots defend against air threats",
    ['cordvp'] = "<LOC cordvp_help>. For SCTABalance, an upgrade from CORVP, to access T2",
    ['coradvp'] = "<LOC coradvp_help>. For SCTABalance, an upgrade from CORDVP to access T3.",
    ['cordap'] = "<LOC cordap_help>. For SCTABalance, an upgrade from CORAP to access T2.",
    ['cordsy'] = "<LOC cordsy_help>. For SCTABalance, an upgrade from CORSY to access T2.",
    ['coradsy'] = "<LOC coradsy_help>. For SCTABalance, an upgrade from CORDSY to access T3.",
    ['cordlab'] = "<LOC cordlab_help>. For SCTABalance, an upgrade from CORLAB, to access T2",
    ['coradlab'] = "<LOC coradlab_help>. For SCTABalance, an upgrade from CORDLAB to access T3.",
} )

end