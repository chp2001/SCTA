function SCTAUnitBuildCheck( bp )
    local lowest = 4
    for k,v in bp.Categories do
            if ( v == 'TECH1' ) then
                return 1
            elseif ( v == 'TECH2' ) and lowest > 2 then
                lowest = 2
            elseif ( v == 'TECH3' ) and lowest > 3 then
                lowest = 3
            end
    end
    return lowest
end

