do

local TAupgrades =
{
    -- TAs
    ['armlab'] = 'armdlab',
    ['armdlab'] = 'armadlab',
    ['corlab'] = 'cordlab', 
    ['cordlab'] = 'coradlab',
    ['armap'] = 'armdap',
    ['armdap'] = 'armadap',
    ['corap'] = 'cordap',
    ['cordap'] = 'coradap',
    ['armsy'] = 'armdsy',
    ['armdsy'] = 'armadsy',
    ['corsy'] = 'cordsy',  
    ['cordsy'] = 'coradsy',
    ['armvp'] = 'armdvp',
    ['armdvp'] = 'armadvp',
    ['corvp'] = 'cordvp',
    ['cordvp'] = 'coradvp',
    ['armmex'] = 'armmoho', 
    ['cormex'] = 'cormoho',
    ['armrad'] = 'armarad',
    ['corrad'] = 'corarad',
    ['armarad'] = 'armtarg',
    ['corarad'] = 'cortarg',
    ['armsonar'] = 'armason',
    ['corsonar'] = 'corason',
}

upgradeTab = table.merged(upgradeTab, TAupgrades)

end
