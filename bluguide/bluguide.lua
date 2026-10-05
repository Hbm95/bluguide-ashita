-- SPDX-License-Identifier: GPL-3.0-or-later
-- Ashita v4 adaptation of Anissa's bluGuide. See README.md and THIRD-PARTY.txt.
addon.name = 'bluguide'
addon.author = "Originally for Windower by Anissa; ported to Ashita by Geforce's Astra AI"
addon.version = '2.1.0'
addon.desc = 'Blue magic spell and trait guide for Ashita v4 / level 75.'
addon.link = 'https://github.com/Windower/Lua/tree/live/addons/bluguide'
require 'common'
local imgui = require 'imgui'
local model = require 'model'
local backend = require 'backend'
local spells = require 'res.spellinfo'
local traits = require 'res.traits'
local profile = require 'profile'
local open, search, known_only, level_only = { true }, { '' }, { false }, { false }
local state = { ready = false, selected = {}, raw = {}, level = 0 }
local notice, backend_error = '', nil
local last_poll, pending, last_write = 0, nil, 0
local ordered, trait_names, effects, chains = {}, {}, {}, {}
local elements = { [0]='Fire', 'Ice', 'Wind', 'Earth', 'Thunder', 'Water', 'Light', 'Dark', [15]='Physical' }

for id, patch in pairs(profile.spells) do
    if spells[id] then for key, value in pairs(patch) do spells[id][key] = value end end
end
for _, spell in pairs(spells) do
    ordered[#ordered + 1] = spell
    for effect in pairs(spell.effect) do effects[effect] = true end
    if spell.SCA then chains[spell.SCA] = true end
    if spell.SCB then chains[spell.SCB] = true end
end
table.sort(ordered, function(a,b) return a.level < b.level or (a.level == b.level and a.name < b.name) end)
for name in pairs(traits) do trait_names[#trait_names + 1] = name end
table.sort(trait_names)
local function keys(t)
    local result = {}
    for k in pairs(t) do result[#result + 1] = k end
    table.sort(result)
    return result
end
local effect_names, chain_names = keys(effects), keys(chains)

local function refresh()
    local data, err = backend.read()
    if not data then
        state = { ready = false, selected = {}, raw = {}, level = 0 }
        pending = nil
        notice = backend_error or err
        return
    end
    data.selected, data.count, data.points, data.unknown = model.selection(data.raw, spells)
    data.max_slots, data.max_points = model.limits(data.level, data.assimilation)
    data.ready = true
    state = data
    if pending then
        if state.main ~= pending.main or state.level ~= pending.level then
            pending = nil
            notice = 'Job changed; spell selection refreshed.'
        elseif (state.raw[pending.slot] or 0) == pending.id then
            pending = nil
            notice = 'Client spell list updated.'
        elseif os.time() - pending.time >= 5 then
            pending = nil
            notice = 'Change not observed. Check the in-game set-spells menu and retry.'
        end
    end
end

local function toggle(id)
    if pending or os.time() - last_write < 2 then
        notice = 'Wait for the previous change before clicking again.'
        return
    end
    refresh()
    local learned = state.ready and state.player:HasSpell(id)
    local slot, raw_id = model.action(id, state, spells, learned)
    if not slot then notice = raw_id; return end
    if backend.set(slot, raw_id, state.main) then
        last_write = os.time()
        pending = { slot = slot, id = raw_id, time = last_write, main = state.main, level = state.level }
        notice = 'Requested spell change; waiting for the client list.'
    else notice = 'The game did not accept the spell change. Check your current state.' end
end

local function visible(s)
    if s.disabled or s.level > profile.level_cap then return false end
    if state.ready then
        if known_only[1] and not state.player:HasSpell(s.id) then return false end
        if level_only[1] and s.level > state.level then return false end
    end
    return search[1] == '' or s.name:lower():find(search[1]:lower(), 1, true) ~= nil
end

local function row(s, suffix, contribution)
    local selected = state.selected[s.id] ~= nil
    local learned = state.ready and state.player:HasSpell(s.id)
    local trait_label = contribution and (' | +' .. tostring(contribution.points or '?') .. ' trait pts') or ''
    local label = string.format('%s Lv.%02d  %-22s  %s BP%s%s##spell%d%s',
        selected and '[SET]' or '[   ]', s.level, s.name, tostring(s.cost or '?'),
        trait_label, state.ready and not learned and ' (unlearned)' or '', s.id, suffix or '')
    if imgui.Selectable(label, selected) then toggle(s.id) end
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.Text(string.format('%s | ID %d', elements[s.element] or 'Unknown', s.id))
        if s.SCA then imgui.Text('Skillchain: ' .. s.SCA .. (s.SCB and (' / ' .. s.SCB) or '')) end
        local names = keys(s.effect)
        if #names > 0 then imgui.Text('Effects: ' .. table.concat(names, ', ')) end
        if contribution and contribution.points == nil then
            imgui.Text('Trait contribution is blank on the source wiki page.')
        end
        imgui.Text('Click to set / unset. Normal game restrictions apply.')
        imgui.EndTooltip()
    end
end

local function group(title, match, contributions)
    local found = false
    for _, s in ipairs(ordered) do if visible(s) and match(s) then found = true; break end end
    if found and imgui.CollapsingHeader(title) then
        local row_key = title:match('###(.+)$') or title
        for _, s in ipairs(ordered) do
            if visible(s) and match(s) then row(s, row_key, contributions and contributions[s.id]) end
        end
    end
end

ashita.events.register('load', 'bluguide_load', function()
    local ok, err = backend.init()
    if not ok then backend_error = err end
    refresh()
end)

ashita.events.register('command', 'bluguide_command', function(e)
    local args = e.command:args()
    local cmd = args[1] and args[1]:lower()
    if cmd ~= '/bluguide' and cmd ~= '/blug' then return end
    e.blocked = true
    local action = args[2] and args[2]:lower() or 'toggle'
    if action == 'show' then open[1] = true
    elseif action == 'hide' then open[1] = false
    elseif action == 'refresh' then refresh()
    elseif action == 'toggle' then open[1] = not open[1]
    else print('[bluGuide] /bluguide [show|hide|refresh|help] - click a spell to set or unset it.') end
end)

ashita.events.register('d3d_present', 'bluguide_present', function()
    if not open[1] then return end
    if os.time() ~= last_poll then last_poll = os.time(); refresh() end
    imgui.SetNextWindowSize({ 840, 650 }, ImGuiCond_FirstUseEver)
    if imgui.Begin('bluGuide - Ashita / Lv.75', open) then
        imgui.Text('Traits, listed levels and BP: Horizon wiki; three BP costs verified in-game by user.')
        if state.ready then
            imgui.Text(string.format('BLU %d (%s) | Slots %d/%d | BP %d/%d%s', state.level,
                state.main and 'main' or 'support', state.count, state.max_slots,
                state.points, state.max_points, state.unknown and ' (unknown spell cost)' or ''))
        end
        if notice ~= '' then imgui.TextWrapped(notice) end
        if imgui.Button('Refresh') then notice = ''; refresh() end
        imgui.SameLine(); imgui.Checkbox('Learned only', known_only)
        imgui.SameLine(); imgui.Checkbox('My level only', level_only)
        imgui.InputText('Search spell name', search, 128)
        imgui.Separator()
        if imgui.BeginTabBar('guide_tabs') then
            if imgui.BeginTabItem('Spells') then
                imgui.BeginChild('spells_scroll', { 0, 0 })
                for _, s in ipairs(ordered) do if visible(s) then row(s) end end
                imgui.EndChild(); imgui.EndTabItem()
            end
            if imgui.BeginTabItem('Equipped') then
                imgui.BeginChild('equipped_scroll', { 0, 0 })
                for slot = 1, 20 do
                    local id = (state.raw[slot] or 0) + 512
                    if id ~= 512 then
                        if spells[id] then row(spells[id], 'equipped')
                        else imgui.Text(string.format('Slot %d: unknown spell ID %d (use game menu)', slot, id)) end
                    end
                end
                imgui.EndChild(); imgui.EndTabItem()
            end
            if imgui.BeginTabItem('Traits') then
                imgui.TextWrapped('Wiki traits: 8 points per tier. Non-refresh LSB weight 1 = 4 trait points; Auto Refresh uses listed points.')
                imgui.TextWrapped('BLU contributions only; no support-job stacking. ? = missing wiki value. Wiki is under construction.')
                imgui.BeginChild('traits_scroll', { 0, 0 })
                for _, name in ipairs(trait_names) do
                    local t = traits[name]
                    local points, value, unknown = model.trait(t, state.selected)
                    local members = {}
                    for _, s in ipairs(t.spells) do members[s.id] = s end
                    local status = value and ('Tier ' .. value) or 'Inactive'
                    if unknown then status = value and (status .. ' confirmed; total unknown') or 'Unknown (missing contribution)' end
                    group(string.format('%s | %d%s trait points | %s###trait_%s', name, points,
                        unknown and ' + ?' or '', status, name), function(s) return members[s.id] end, members)
                end
                imgui.EndChild(); imgui.EndTabItem()
            end
            if imgui.BeginTabItem('Utility') then
                imgui.BeginChild('utility_scroll', { 0, 0 })
                for _, effect in ipairs(effect_names) do group(effect, function(s) return s.effect[effect] end) end
                imgui.EndChild(); imgui.EndTabItem()
            end
            if imgui.BeginTabItem('Damage') then
                imgui.BeginChild('damage_scroll', { 0, 0 })
                for _, sc in ipairs(chain_names) do group(sc, function(s) return s.SCA == sc or s.SCB == sc end) end
                for element = 0, 7 do group(elements[element] .. ' magic', function(s) return s.Nuke and s.element == element end) end
                imgui.EndChild(); imgui.EndTabItem()
            end
            if imgui.BeginTabItem('Retail procs') then
                imgui.TextWrapped('Legacy retail reference only; this does not indicate Horizon content availability.')
                imgui.BeginChild('procs_scroll', { 0, 0 })
                group('Abyssea', function(s) return s.Abyssea end)
                for element = 0, 7 do group('Voidwatch - ' .. elements[element], function(s) return s.Voidwatch and s.element == element end) end
                imgui.EndChild(); imgui.EndTabItem()
            end
            imgui.EndTabBar()
        end
    end
    imgui.End()
end)
