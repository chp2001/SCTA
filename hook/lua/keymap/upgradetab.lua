do

local TAupgrades =
{
    -- TAs
    ['armlab'] = 'armdlab', 
    ['corlab'] = 'cordlab', 
    ['armap'] = 'armaap',
    ['corap'] = 'coraap',
    ['armsy'] = 'armasy',
    ['corsy'] = 'corasy',  
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
