
local TAAntiRocketProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TAAntiRocketProjectile

CORABM_WEAPON = Class(TAAntiRocketProjectile) 
{
    OnImpact = function(self,type,other)
        if type == 'Terrain' or type == 'Water' then
            TAAntiRocketProjectile.OnImpact(self,type,other)
        end
    end,
}


TypeClass = CORABM_WEAPON
