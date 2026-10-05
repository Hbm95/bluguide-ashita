# bluGuide for Ashita v4

Originally for Windower by Anissa; ported to Ashita by Geforce's Astra AI.

Configured for level-75 use on HorizonXI. Version 2.1.0, October 3, 2026.

**Status: passes local LuaJIT and mocked Ashita tests; not yet tested inside HorizonXI.** This is an unofficial port. It requires Ashita v4, its bundled `common` and `imgui` libraries, and the normal 32-bit FFXI client. Ashita v3 is not supported.

## Install

1. Close the game or unload an existing `bluguide` addon.
2. Extract the ZIP. Copy the entire `bluguide` folder into the `addons` folder of the Ashita installation that your Horizon launcher actually uses.
3. Check the result is `addons/bluguide/bluguide.lua`, with `backend.lua`, `model.lua`, `profile.lua`, and the `res` folder beside it. Avoid an extra nested `bluguide` folder.
4. Log in, switch to BLU main or support job, and enter:

   ```text
   /addon load bluguide
   ```

5. If prompted, open the game's Blue Magic set-spells menu once and click **Refresh**. Some private-server clients do not initialize the job buffer until that menu is opened.

Optional: add `/addon load bluguide` to your existing Ashita startup script after confirming the addon works.

## Use

- `/bluguide` or `/blug`: toggle the window.
- `/bluguide show`, `/bluguide hide`, `/bluguide refresh`, `/bluguide help`.
- `/addon unload bluguide`: unload.
- Click a spell to set it; click an equipped spell to unset it. Changes use the game's native spell-setting function, with one request at a time and at least two seconds between requests. Normal spell-setting restrictions and cooldowns still apply.
- **Spells**: search, level and learned filters. Hover for element, effects, and skillchain properties.
- **Equipped**: shows current spells independently of filters, including spells outside the default level cap.
- **Traits**: all 22 traits and 86 spell entries from the supplied Horizon wiki page. Expand a trait to see each spell's separate BP cost and trait contribution. The display shows active tiers, not unverified retail bonus magnitudes.
- **Utility / Damage**: spells grouped by effect, skillchain, or magic element.
- **Retail procs**: preserves the original Abyssea/Voidwatch reference, explicitly labeled as retail data.

The display refreshes while open and before a click is applied. It reads actual equipped spells; it does not pretend a requested change succeeded. “Client spell list updated” confirms the local client list, not a separate server acknowledgement. Unknown equipped spell costs block additions until resolved in the game menu.

## Horizon-specific limits

The trait membership, listed spell levels, and nonblank set costs now follow [Blue Mage/Job Traits](https://horizonffxi.wiki/Blue_Mage/Job_Traits), revision 123880, checked October 3, 2026. Every one of its 86 spell entries is included, even when its individual wiki link is red. This includes custom level-56 Winds of Promyvion. Seedspray costs 2 BP and Reactor Cool is level 75 according to that table.

The user verified these costs in-game: Geist Wall **3 BP**, Winds of Promyvion **4 BP**, Blood Saber **3 BP**. These replace blank Set cells in the supplied page. Their **Auto Refresh contributions remain unknown**, because the page leaves those cells blank; no values were imported from other wiki pages. They can be set/unset normally, but an equipped unknown contribution makes the trait total display `known points + ?`. A tier reached by known contributions is still shown as confirmed. Unknown values never count as zero in a definitive total.

The source mixes LSB weights and trait points. For non-refresh traits, the addon normalizes LSB weight 1 to 4 trait points. This is an interpretation reconciling the page's two-spell unlock examples with its stated 8-point activation rule. Auto Refresh uses the listed weights directly. Tier caps follow the tiers listed in the page's unlock table; Fast Cast is labeled tier 0 as listed there. Numerical trait bonus magnitudes are not inferred.

The wiki itself is under construction and warns some entries may not reflect Horizon changes. Unlisted spells and other metadata (effects, elements, skillchains, retail proc flags) retain their previous reference data. The level-75 filter is not an expansion/era whitelist. Learned-only and My-level-only filters are initially off so all listed trait components, including custom ones, can be browsed. Unknown/unlearned spells cannot be set; normal level checks still apply.

Slot/BP limits use the level-75 progression, including main-job Assimilation (up to five points). No job-point gifts or level-99 bonuses are applied. Traits show BLU spell contributions only, without adding support-job traits; the wiki says identical traits do not stack. The guide stays open but cannot change spells on a non-BLU job.

To correct known Horizon differences, edit `profile.lua` and reload with `/addon reload bluguide`. For example:

```lua
spells = {
    [623] = { cost = 3, level = 12 }, -- full spell ID, not the ID minus 512
    [650] = { disabled = true },
},
```

These examples explain the format; they are not claims about Horizon changes. Trait corrections belong in `res/traits.lua`. Keep the level cap at 75; higher-level point/gift logic is not implemented. Window filter selections reset on addon reload.

## Troubleshooting and first in-game check

- “BLU signatures not found”: your client differs from the signature patterns used by the official Ashita BluSets backend. The guide remains readable, but setting is disabled. Record your Ashita version and this message.
- “Open the in-game Blue Magic set-spells menu”: do that after login, zoning, or a job change, then refresh.
- “Change not observed”: wait, check the game's own menu and any game error, then retry. Do not repeatedly click while a request is pending.
- For an addon load error, copy the full error including filename and line number.

For the first live check, compare the equipped list and BP/slot totals with the game menu. Set one learned low-cost spell into a free slot, verify it in the game menu, then remove it. Check a trait pair and, if relevant, repeat with BLU as support job. Live UI layout, the game-client signatures, server-specific spell rules, and server acceptance remain unverified here.

## Source and licenses

Original: https://github.com/Windower/Lua/tree/live/addons/bluguide

Ashita backend reference: https://github.com/AshitaXI/Ashita-v4beta/blob/main/addons/blusets/blu.lua

The port replaces Windower's event, text, and mouse APIs with Ashita events and ImGui. Its backend is a reduced, guarded adaptation of Ashita's native setter/read path; no fast packet mode or batch reset is included. It also fixes the original main-job slot calculation's use of subjob level. Version 2.1.0 replaces the retail trait list with the supplied Horizon wiki list, updates listed spell data and user-verified costs, and makes incomplete trait totals explicit.

All runtime source is included. New port code and the Ashita-derived backend are GPL-3.0-or-later; see `COPYING.txt`. The original Windower data retains Anissa's copyright and BSD-style license notices. See `THIRD-PARTY.txt` and `ASHITA-LICENSE.md`.
