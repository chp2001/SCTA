    if __blueprints['xnl0001'] then
        if not StructureUpgradeTemplates[6] then StructureUpgradeTemplates[6] = {} end
        table.insert(StructureUpgradeTemplates[6], {'armmex', 'armmass'})
        if not StructureUpgradeTemplates[7] then StructureUpgradeTemplates[7] = {} end
        table.insert(StructureUpgradeTemplates[7], {'cormex', 'cormass'})
    else
        if not StructureUpgradeTemplates[5] then StructureUpgradeTemplates[5] = {} end
        table.insert(StructureUpgradeTemplates[5], {'armmex', 'armmass'})
        if not StructureUpgradeTemplates[6] then StructureUpgradeTemplates[6] = {} end
        table.insert(StructureUpgradeTemplates[6], {'cormex', 'cormass'})
    end
--LOG('Resulting Table'..repr(StructureUpgradeTemplates))