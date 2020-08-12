local oldPosition={1,1,1}

local unitOld=Unit
Unit=Class(unitOld){

    OnStartReclaim = function(self, target)
        if EntityCategoryContains(categories.NECRO,self) then
            if not target.ReclaimInProgress then
                --LOG('* Necro: OnStartReclaim:  I am a necro! no ReclaimInProgress; starting Necroing')
                target.NecroingInProgress = true
                self.RecBP = target.AssociatedBP
                self.ReclaimLeft = target.ReclaimLeft
                self.RecPosition = target:GetPosition()
            else
                --LOG('* Necro: OnStartReclaim:  I am a necro and ReclaimInProgress; Stopped!')
                self.RecBP = nil
                self.ReclaimLeft = nil
                self.RecPosition = nil
                IssueStop({self})
                IssueClearCommands({self})
                return
            end
        else
            if not target.NecroingInProgress then
                --LOG('* Necro: OnStartReclaim:  I am engineer, no NecroingInProgress, starting Reclaim')
                target.ReclaimInProgress = true
            else
                --LOG('* Necro: OnStartReclaim:  I am engineer and NecroingInProgress; Stopped!')
                IssueStop({self})
                IssueClearCommands({self})
                return
            end
        end
        unitOld.OnStartReclaim(self, target)
    end,

    OnStopReclaim = function(self, target)
        unitOld.OnStopReclaim(self, target)
        if not target then
            if self.RecBP and EntityCategoryContains(categories.NECRO,self) and oldPosition ~= self.RecPosition then
                --LOG('* Necro: OnStopReclaim:  I am a necro! and RecBP = true ')
                oldPosition = self.RecPosition
                self:ForkThread( self.RespawnUnit, self.RecBP, self:GetArmy(), self.RecPosition, self.ReclaimLeft )
            else
                --LOG('* Necro: OnStopReclaim: no necro or no RecBP')
            end
        else
            if EntityCategoryContains(categories.NECRO,self) then
                --LOG('* Necro: OnStopReclaim:  Wreck still exist. Removing target data from Necro')
                self.RecBP = nil
                self.ReclaimLeft = nil
                self.RecPosition = nil
            else
                --LOG('* Necro: OnStopReclaim: Wreck still exist. no necro')
            end
        end
    end,

    RespawnUnit = function(self, RecBP, army, pos, ReclaimLeft)
        --LOG('* Necro: RespawnUnit: ReclaimLeft '..ReclaimLeft)
        WaitTicks(3)
        local newUnit = CreateUnitHPR(RecBP,army,pos[1],pos[2],pos[3],0,0,0)
        newUnit:SetHealth(nil, newUnit:GetMaxHealth() * ReclaimLeft )
    end,

}
