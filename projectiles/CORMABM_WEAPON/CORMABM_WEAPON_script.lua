local TAAntiRocketProjectile = import('/mods/SCTA-master/lua/TAprojectiles.lua').TAAntiRocketProjectile

CORMABM_WEAPON = Class(TAAntiRocketProjectile) 
{
    OnCreate = function(self)
        TAAntiRocketProjectile.OnCreate(self)
        self:SetCollisionShape('Sphere', 0, 0, 0, 1.0)
    end,
    
    OnImpact = function(self, TargetType, targetEntity)
            TAAntiRocketProjectile.OnImpact(self, TargetType, targetEntity)
            if TargetType == 'Terrain' or TargetType == 'Water' or TargetType == 'Prop' then
                if self.Trash then
                    self.Trash:Destroy()
                end
                self:Destroy()
            end
        end,
}



TypeClass = CORMABM_WEAPON
