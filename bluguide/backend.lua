-- Derived from AshitaXI/Ashita-v4beta addons/blusets/blu.lua.
-- Addons - Copyright (c) 2025 Ashita Development Team
-- Contact: https://www.ashitaxi.com/ ; https://discord.gg/Ashita
-- SPDX-License-Identifier: GPL-3.0-or-later
-- Modified 2026-10-03: guarded pointers, read-only snapshot, native setter only.
-- Distributed without warranty; see COPYING.txt for the GNU GPL v3.
local ffi = require 'ffi'
ffi.cdef[[typedef uint8_t (__cdecl *bluguide_equipex_t)(uint8_t, uint16_t, uint16_t, uint8_t);]]
local M = {}
local offset, setter

function M.init()
    local p = ashita.memory.find(0, 0, 'C1E1032BC8B0018D????????????B9????????F3A55F5E5B', 10, 0)
    local fn = ashita.memory.find(0, 0, '8B0D????????81EC9C00000085C95356570F??????????8B', 0, 0)
    if not p or p == 0 or not fn or fn == 0 then
        return false, 'Unsupported game client: BLU signatures not found. Guide is read-only.'
    end
    offset = ashita.memory.read_uint32(p)
    setter = ffi.cast('bluguide_equipex_t', fn)
    return true
end

function M.read()
    if not GetPlayerEntity() then return nil, 'Log in and finish zoning to read BLU spells.' end
    local player = AshitaCore:GetMemoryManager():GetPlayer()
    local main = player:GetMainJob() == 16
    if not main and player:GetSubJob() ~= 16 then return nil, 'Set BLU as your main or support job.' end
    if not offset or not setter then return nil, 'Spell-setting backend unavailable.' end
    local root = AshitaCore:GetPointerManager():Get('inventory')
    if not root or root == 0 then return nil, 'Inventory data is not ready.' end
    local ptr = ashita.memory.read_uint32(root)
    if ptr == 0 then return nil, 'Inventory data is not ready.' end
    ptr = ashita.memory.read_uint32(ptr)
    if ptr == 0 then return nil, 'Inventory data is not ready.' end
    local base = ptr + offset + (main and 0 or 0x9C)
    -- Private servers may not initialize this buffer until a menu is opened.
    if ashita.memory.read_uint8(base) ~= 16 or ashita.memory.read_uint8(base + 1) ~= (main and 0 or 1) then
        return nil, 'Open the in-game Blue Magic set-spells menu once, then Refresh.'
    end
    local raw = ashita.memory.read_array(base + 4, 20)
    return { raw = raw, level = main and player:GetMainJobLevel() or player:GetSubJobLevel(),
        assimilation = main and player:GetAssimilationPoints() or 0, main = main, player = player }
end

function M.set(slot, spell, main)
    if not setter then return false end
    return setter(main and 0 or 1, 0x1000, slot - 1, spell) ~= 0
end

return M
