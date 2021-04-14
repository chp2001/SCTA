function UnitBuildCheck( bp )
    local lowest = 4
    for k,v in bp.Categories do
        if (v == 'CORE' or v == 'ARM') then
            if ( v == 'TECH1' ) then
                return 1
            elseif ( v == 'TECH2' ) and lowest > 2 then
                lowest = 2
            elseif ( v == 'TECH3' ) and lowest > 3 then
                lowest = 3
            end
        else
        if ( v == 'BUILTBYTIER1FACTORY' or v == 'TRANSPORTBUILTBYTIER1FACTORY' ) then
            return 1
        elseif ( v == 'BUILTBYTIER2FACTORY' or v == 'TRANSPORTBUILTBYTIER2FACTORY' )and lowest > 2 then
            lowest = 2
        elseif ( v == 'BUILTBYTIER3FACTORY' or v == 'TRANSPORTBUILTBYTIER3FACTORY' )and lowest > 3 then
            lowest = 3
        end
    end
    end
    return lowest
end

