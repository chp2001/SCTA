function CreateIdleTab(unitData, id, expandFunc)
    local bg = Bitmap(controls.avatarGroup, UIUtil.SkinnableFile('/game/avatar/avatar-s-e-f_bmp.dds'))
    bg.id = id
    bg.tooltipKey = 'mfd_idle_'..id

    bg.allunits = unitData
    bg.units = unitData

    bg.icon = Bitmap(bg)
    LayoutHelpers.AtLeftTopIn(bg.icon, bg, 7, 8)
    bg.icon:SetSolidColor('00000000')
    LayoutHelpers.SetDimensions(bg.icon, 34, 34)
    bg.icon:DisableHitTest()

    bg.count = UIUtil.CreateText(bg.icon, '', 18, UIUtil.bodyFont)
    bg.count:DisableHitTest()
    bg.count:SetDropShadow(true)
    LayoutHelpers.AtBottomIn(bg.count, bg.icon)
    LayoutHelpers.AtRightIn(bg.count, bg.icon)

    bg.expandCheck = Checkbox(bg,
        UIUtil.SkinnableFile('/game/avatar-arrow_btn/tab-open_btn_up.dds'),
        UIUtil.SkinnableFile('/game/avatar-arrow_btn/tab-close_btn_up.dds'),
        UIUtil.SkinnableFile('/game/avatar-arrow_btn/tab-open_btn_over.dds'),
        UIUtil.SkinnableFile('/game/avatar-arrow_btn/tab-close_btn_over.dds'),
        UIUtil.SkinnableFile('/game/avatar-arrow_btn/tab-open_btn_dis.dds'),
        UIUtil.SkinnableFile('/game/avatar-arrow_btn/tab-close_btn_dis.dds'))
    LayoutHelpers.AnchorToLeft(bg.expandCheck, bg, -4)
    LayoutHelpers.AtVerticalCenterIn(bg.expandCheck, bg)
    bg.expandCheck.OnCheck = function(self, checked)
        if checked then
            if expandedCheck and expandedCheck ~= bg.id and GetCheck(expandedCheck) then
                GetCheck(expandedCheck):SetCheck(false)
            end
            expandedCheck = bg.id
            self.expandList = expandFunc(self, bg.units)
        else
            expandedCheck = false
            if self.expandList then
                self.expandList:Destroy()
                self.expandList = nil
            end
        end
    end
    bg.curIndex = 1
    bg.HandleEvent = ClickFunc
    bg.Update = function(self, units)
        self.allunits = units
        self.units = {}
        if self.id == 'engineer' then
            local sortedUnits = {}
            sortedUnits[8] = EntityCategoryFilterDown(categories.SUBCOMMANDER, self.allunits)
            sortedUnits[7] = EntityCategoryFilterDown(categories.TECH3 - categories.SUBCOMMANDER, self.allunits)
            sortedUnits[6] = EntityCategoryFilterDown(categories.FIELDENGINEER * categories.TECH2, self.allunits)
            sortedUnits[5] = EntityCategoryFilterDown(categories.VTOL * categories.TECH2 * categories.AIR, self.allunits)
            sortedUnits[4] = EntityCategoryFilterDown(categories.TECH2 * categories.LAND - categories.FIELDENGINEER, self.allunits)
            sortedUnits[3] = EntityCategoryFilterDown(categories.OCEANENGINEER * categories.TECH1, self.allunits)
            sortedUnits[2] = EntityCategoryFilterDown(categories.VTOL * categories.TECH1 * categories.AIR, self.allunits)
            sortedUnits[1] = EntityCategoryFilterDown(categories.TECH1 * categories.LAND - categories.OCEANENGINEER, self.allunits)

            local keyToIcon = {'T1', 'T1A', 'T1F', 'T2', 'T2A', 'T2F', 'T3', 'SCU'}

            local i = table.getn(sortedUnits)
            local needIcon = true
            while i > 0 do
                if table.getn(sortedUnits[i]) > 0 then
                    if needIcon then
                        -- Idle engineer icons
                        if Factions[currentFaction].IdleEngTextures[keyToIcon[i]] and UIUtil.UIFile(Factions[currentFaction].IdleEngTextures[keyToIcon[i]],true) then
                            self.icon:SetTexture(UIUtil.UIFile(Factions[currentFaction].IdleEngTextures[keyToIcon[i]],true))
                        else
                            self.icon:SetTexture(Factions[currentFaction].IdleEngTextures[keyToIcon[i]])
                        end
                        needIcon = false
                    end
                    for _, unit in sortedUnits[i] do
                        table.insert(self.units, unit)
                    end
                end
                i = i - 1
            end
        elseif self.id == 'factory' then
            local categoryTable = {'LAND','AIR','NAVAL'}
            local sortedFactories = {}
            for i, cat in categoryTable do
                sortedFactories[i] = {}
                sortedFactories[i][1] = EntityCategoryFilterDown(categories.TECH1 * categories[cat], self.allunits)
                sortedFactories[i][2] = EntityCategoryFilterDown(categories.TECH2 * categories[cat], self.allunits)
                sortedFactories[i][3] = EntityCategoryFilterDown(categories.TECH3 * categories[cat], self.allunits)
            end

            local i = 3
            local needIcon = true
            while i > 0 do
                for curCat = 1, 3 do
                    if table.getn(sortedFactories[curCat][i]) > 0 then
                        if needIcon then
                            -- Idle factory icons
                            if UIUtil.UIFile(Factions[currentFaction].IdleFactoryTextures[categoryTable[curCat]][i],true) then
                                self.icon:SetTexture(UIUtil.UIFile(Factions[currentFaction].IdleFactoryTextures[categoryTable[curCat]][i],true))
                            else
                                self.icon:SetTexture(UIUtil.UIFile('/icons/units/default_icon.dds'))
                            end
                            needIcon = false
                        end
                        for _, unit in sortedFactories[curCat][i] do
                            table.insert(self.units, unit)
                        end
                    end
                end
                i = i - 1
            end
           if needIcon == true then
               local ExpFactories = EntityCategoryFilterDown(categories.EXPERIMENTAL, self.allunits)
               if table.getn(ExpFactories) > 0 then
                   local FactoryUnitId = ExpFactories[1]:GetUnitId()
                   if UIUtil.UIFile('/icons/units/' .. FactoryUnitId .. '_icon.dds', true) then
                       self.icon:SetTexture(UIUtil.UIFile('/icons/units/' .. FactoryUnitId .. '_icon.dds', true))
                   else
                       self.icon:SetTexture(UIUtil.UIFile('/icons/units/default_icon.dds'))
                   end
               end
           end
        end
        self.count:SetText(table.getsize(self.allunits))

        if self.expandCheck.expandList then
            self.expandCheck.expandList:Update(self.allunits)
        end
    end

    return bg
end

function CreateIdleEngineerList(parent, units)
    local group = Group(parent)

    local bgTop = Bitmap(group, UIUtil.SkinnableFile('/game/avatar-engineers-panel/panel-eng_bmp_t.dds'))
    local bgBottom = Bitmap(group, UIUtil.SkinnableFile('/game/avatar-engineers-panel/panel-eng_bmp_b.dds'))
    local bgStretch = Bitmap(group, UIUtil.SkinnableFile('/game/avatar-engineers-panel/panel-eng_bmp_m.dds'))

    group.Width:Set(bgTop.Width)
    LayoutHelpers.SetHeight(group, 1)

    bgTop.Bottom:Set(group.Top)
    bgBottom.Top:Set(group.Bottom)
    bgStretch.Top:Set(group.Top)
    bgStretch.Bottom:Set(group.Bottom)

    LayoutHelpers.AtHorizontalCenterIn(bgTop, group)
    LayoutHelpers.AtHorizontalCenterIn(bgBottom, group)
    LayoutHelpers.AtHorizontalCenterIn(bgStretch, group)

    group.connector = Bitmap(group, UIUtil.SkinnableFile('/game/avatar-engineers-panel/bracket_bmp.dds'))
    LayoutHelpers.AnchorToLeft(group.connector, parent, -8)
    LayoutHelpers.AtVerticalCenterIn(group.connector, parent)

    LayoutHelpers.LeftOf(group, parent, 10)
    group.Top:Set(function() return math.max(controls.avatarGroup.Top()+10, (parent.Top() + (parent.Height() / 2)) - (group.Height() / 2)) end)

    group:DisableHitTest(true)

    group.icons = {}

    group.Update = function(self, unitData)
        local function CreateUnitEntry(techLevel, userUnits, icontexture)
            local entry = Group(self)

            entry.icon = Bitmap(entry)
            -- Iddle engineer icons groupwindow
            if UIUtil.UIFile(icontexture,true) then
                entry.icon:SetTexture(UIUtil.UIFile(icontexture,true))
            else
                entry.icon:SetTexture(UIUtil.UIFile('/icons/units/default_icon.dds'))
            end
            LayoutHelpers.SetDimensions(entry.icon, 34, 34)
            LayoutHelpers.AtRightIn(entry.icon, entry, 22)
            LayoutHelpers.AtVerticalCenterIn(entry.icon, entry)

            entry.iconBG = Bitmap(entry, UIUtil.SkinnableFile('/game/avatar-factory-panel/avatar-s-e-f_bmp.dds'))
            LayoutHelpers.AtCenterIn(entry.iconBG, entry.icon)
            LayoutHelpers.DepthUnderParent(entry.iconBG, entry.icon)

            entry.techIcon = Bitmap(entry, UIUtil.SkinnableFile('/game/avatar-engineers-panel/tech-'..techLevel..'_bmp.dds'))
            LayoutHelpers.AtLeftIn(entry.techIcon, entry)
            LayoutHelpers.AtVerticalCenterIn(entry.techIcon, entry.icon)

            entry.count = UIUtil.CreateText(entry, '', 20, UIUtil.bodyFont)
            entry.count:SetColor('ffffffff')
            entry.count:SetDropShadow(true)
            LayoutHelpers.AtRightIn(entry.count, entry.icon)
            LayoutHelpers.AtBottomIn(entry.count, entry.icon)

            entry.countBG = Bitmap(entry)
            entry.countBG:SetSolidColor('77000000')
            LayoutHelpers.AtLeftTopIn(entry.countBG, entry.count, -1, -1)
            LayoutHelpers.AtRightBottomIn(entry.countBG, entry.count, -1, -1)

            LayoutHelpers.DepthOverParent(entry.countBG, entry)
            LayoutHelpers.DepthOverParent(entry.count, entry.countBG)

            entry.Height:Set(function() return entry.iconBG.Height() end)
            entry.Width:Set(self.Width)

            entry.icon:DisableHitTest()
            entry.iconBG:DisableHitTest()
            entry.techIcon:DisableHitTest()
            entry.count:DisableHitTest()
            entry.countBG:DisableHitTest()

            entry.curIndex = 1
            entry.units = userUnits
            entry.HandleEvent = ClickFunc

            return entry
        end
        local engineers = {}
        engineers[8] = EntityCategoryFilterDown(categories.SUBCOMMANDER, unitData)
        engineers[7] = EntityCategoryFilterDown(categories.TECH3 - categories.SUBCOMMANDER, unitData)
        engineers[6] = EntityCategoryFilterDown(categories.FIELDENGINEER * categories.TECH2, unitData)
        engineers[5] = EntityCategoryFilterDown(categories.VTOL * categories.TECH2 * categories.AIR, unitData)
        engineers[4] = EntityCategoryFilterDown(categories.TECH2 * categories.LAND - categories.FIELDENGINEER, unitData)
        engineers[3] = EntityCategoryFilterDown(categories.OCEANENGINEER * categories.TECH1, unitData)
        engineers[2] = EntityCategoryFilterDown(categories.VTOL * categories.TECH1 * categories.AIR, unitData)
        engineers[1] = EntityCategoryFilterDown(categories.TECH1 * categories.LAND - categories.OCEANENGINEER - categories.FIELDENGINEER, unitData)

        local indexToIcon = {'1', '1', '1', '2', '2', '2', '3', '3'}
        local keyToIcon = {'T1', 'T1A', 'T1F', 'T2', 'T2A', 'T2F', 'T3', 'SCU'}
        for index, units in engineers do
            local i = index
            if false then
                continue
            end
            if not self.icons[i] then
                self.icons[i] = CreateUnitEntry(indexToIcon[i], units, Factions[currentFaction].IdleEngTextures[keyToIcon[index]])
                self.icons[i].priority = i
            end
            if table.getn(units) > 0 and not self.icons[i]:IsHidden() then
                self.icons[i].units = units
                self.icons[i].count:SetText(table.getn(units))
                self.icons[i].count:Show()
                self.icons[i].countBG:Show()
                self.icons[i].icon:SetAlpha(1)
            else
                self.icons[i].units = {}
                self.icons[i].count:Hide()
                self.icons[i].countBG:Hide()
                self.icons[i].icon:SetAlpha(.2)
            end
        end
        local prevGroup = false
        local groupHeight = 0
        for index, engGroup in engineers do
            local i = index
            if not self.icons[i] then continue end
            if prevGroup then
                LayoutHelpers.Above(self.icons[i], prevGroup)
            else
                LayoutHelpers.AtLeftIn(self.icons[i], self, 7)
                LayoutHelpers.AtBottomIn(self.icons[i], self, 2)
            end
            groupHeight = groupHeight + self.icons[i].Height()
            prevGroup = self.icons[i]
        end
        group.Height:Set(groupHeight)
    end

    group:Update(units)

    return group
end