-- SPDX-License-Identifier: GPL-3.0-or-later
-- Pure guide logic; no game memory access.
local M = {}

function M.limits(level, assimilation)
    if level < 1 then return 0, 0 end
    local band = math.ceil(math.min(level, 75) / 10)
    return math.min(20, band * 2 + 4), band * 5 + 5 +
        (level >= 75 and math.max(0, math.min(5, assimilation or 0)) or 0)
end

function M.selection(raw, spells)
    local selected, count, points, unknown = {}, 0, 0, false
    for slot = 1, 20 do
        local id = raw[slot] or 0
        if id ~= 0 then
            id = id + 512
            selected[id] = slot
            count = count + 1
            if spells[id] and spells[id].cost and not spells[id].cost_unknown then
                points = points + spells[id].cost
            else unknown = true end
        end
    end
    return selected, count, points, unknown
end

function M.action(id, state, spells, learned)
    if not state.ready then return nil, 'Character spell data is not ready.' end
    if state.selected[id] then return state.selected[id], 0 end
    local s = spells[id]
    if not s or s.disabled then return nil, 'This spell is unavailable in this profile.' end
    if s.cost_unknown or not s.cost then return nil, 'Set point cost is not known; use the game menu.' end
    if not learned then return nil, 'You have not learned this spell.' end
    if s.level > state.level then return nil, 'Your BLU level is too low.' end
    if state.unknown then return nil, 'Unknown equipped spell: point total cannot be verified.' end
    if state.count >= state.max_slots then return nil, 'No spell slots remain.' end
    if state.points + s.cost > state.max_points then return nil, 'Not enough blue magic points.' end
    for slot = 1, state.max_slots do
        if (state.raw[slot] or 0) == 0 then return slot, id - 512 end
    end
    return nil, 'No free spell slot was found.'
end

function M.trait(trait, selected)
    local points, threshold, value, unknown = 0, 0, nil, false
    for _, spell in ipairs(trait.spells) do
        if selected[spell.id] then
            if spell.points ~= nil then points = points + spell.points else unknown = true end
        end
    end
    for required, bonus in pairs(trait.tiers) do
        if points >= required and required > threshold then threshold, value = required, bonus end
    end
    return points, value, unknown
end

return M
