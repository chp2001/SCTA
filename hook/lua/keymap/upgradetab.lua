do

local TAupgrades =
{
    -- TAs
    ['armlab'] = 'armdlab', 
    ['corlab'] = 'cordlab', 
    ['armap'] = 'armdap',
    ['corap'] = 'cordap',
    ['armsy'] = 'armdsy',
    ['corsy'] = 'cordsy',  
    ['armvp'] = 'armdvp',  
    ['corvp'] = 'cordvp',
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
