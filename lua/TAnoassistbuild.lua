local TAunit = import('TAunit.lua').TAunit

TAnoassistbuild = Class(TAunit)
{
    noassistbuild = true,


    
    OnDamage = function(self, instigator, amount, vector, damageType)
        TAunit.OnDamage(self, instigator, amount, vector, damageType)

        for _, v in self:GetGuards() do
            if not v.Dead then
                IssueClearCommands({v})
                IssueGuard({v},self)
            end
        end
    end,

}
