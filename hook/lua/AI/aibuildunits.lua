local SCTAUnitBuildCheck = UnitBuildCheck

function UnitBuildCheck( bp )
    if not self.SCTAAI then
        SCTAUnitBuildCheck(bp)
    end
    local lowest = 4
    for k,v in bp.Categories do
        if ( v == 'LEVEL1') then
            return 1
        elseif ( v == 'LEVEL2' )and lowest > 2 then
            lowest = 2
        elseif ( v == 'LEVEL3' )and lowest > 3 then
            lowest = 3
        end
    end
    return lowest
end

