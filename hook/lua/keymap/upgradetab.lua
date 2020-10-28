do

local TAupgrades =
{
    -- TAs
    ['armlab'] = 'armdlab',
    ['armdlab'] = 'armadlab',
    ['corlab'] = 'cordlab', 
    ['cordlab'] = 'coradlab',
    ['armap'] = 'armdap',
    ['corap'] = 'cordap',
    ['armsy'] = 'armdsy',
    ['corsy'] = 'cordsy',  
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
