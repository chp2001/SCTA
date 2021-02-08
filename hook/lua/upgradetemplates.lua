    if __blueprints['xnl0001'] then
        if not StructureUpgradeTemplates[6] then StructureUpgradeTemplates[6] = {
        {'armlab', 'armdlab'},
        {'armdlab', 'armadlab'},
    
        -- air factory
        {'armvp', 'armdvp'},
        {'armdvp', 'armadvp'},
    
        -- naval factory
        {'armsy', 'armdsy'},
        {'armdsy', 'armadsy'},
    
        -- air factory
        {'armap', 'armdap'},
        {'armdap', 'armadap'},
    
    
        -- radar
        {'armrad', 'armarad'},
        {'armarad', 'armtarg'},
    
        -- sonar
        {'armsonar', 'armason'},
        {'armmex', 'armmass'},
        }
    end
        if not StructureUpgradeTemplates[7] then StructureUpgradeTemplates[7] = {
        {'corlab', 'cordlab'},
        {'cordlab', 'coradlab'},
    
        -- air factory
        {'corvp', 'cordvp'},
        {'cordvp', 'coradvp'},
    
        -- naval factory
        {'corsy', 'cordsy'},
        {'cordsy', 'coradsy'},
    
        -- air factory
        {'corap', 'cordap'},
        {'cordap', 'coradap'},
    
    
        -- radar
        {'corrad', 'corarad'},
        {'corarad', 'cortarg'},
    
        -- sonar
        {'corsonar', 'corason'},
    
        {'cormex', 'cormass'},
        }
    end
    else
        if not StructureUpgradeTemplates[5] then StructureUpgradeTemplates[5] = {
        {'armlab', 'armdlab'},
        {'armdlab', 'armadlab'},
    
        -- air factory
        {'armvp', 'armdvp'},
        {'armdvp', 'armadvp'},
    
        -- naval factory
        {'armsy', 'armdsy'},
        {'armdsy', 'armadsy'},
    
        -- air factory
        {'armap', 'armdap'},
        {'armdap', 'armadap'},
    
    
        -- radar
        {'armrad', 'armarad'},
        {'armarad', 'armtarg'},
    
        -- sonar
        {'armsonar', 'armason'},
        {'armmex', 'armmass'},
        }
    end
        if not StructureUpgradeTemplates[6] then StructureUpgradeTemplates[6] = {
        {'corlab', 'cordlab'},
        {'cordlab', 'coradlab'},
    
        -- air factory
        {'corvp', 'cordvp'},
        {'cordvp', 'coradvp'},
    
        -- naval factory
        {'corsy', 'cordsy'},
        {'cordsy', 'coradsy'},
    
        -- air factory
        {'corap', 'cordap'},
        {'cordap', 'coradap'},
    
    
        -- radar
        {'corrad', 'corarad'},
        {'corarad', 'cortarg'},
    
        -- sonar
        {'corsonar', 'corason'},
    
        {'cormex', 'cormass'},
        }
    end
end
---LOG('Resulting Table'..repr(StructureUpgradeTemplates))