-- HorizonXI wiki trait membership / levels / set costs, revision 123880 (2026-09-15).
-- https://horizonffxi.wiki/Blue_Mage/Job_Traits
-- Updated 2026-10-03. Blank wiki cells remain unknown, not zero.
-- Non-refresh LSB weight 1 is normalized to 4 trait points (two spells -> 8).
-- This normalization reconciles the page's unlock examples and 8-point rule.
-- Auto Refresh uses its listed point weights directly. Tier labels only.
return {
    ["Clear Mind"] = {
        name = "Clear Mind",
        spells = {
            { name = "Poison Breath", id = 536, points = 4, wiki_weight = 1, cost = 1 },
            { name = "Soporific", id = 598, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Venom Shell", id = 513, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Awful Eye", id = 606, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Filamented Hold", id = 548, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Maelstrom", id = 515, points = 4, wiki_weight = 1, cost = 5 },
            { name = "Feather Tickle", id = 573, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Sandspray", id = 621, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Corrosive Ooze", id = 651, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Warm-Up", id = 636, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Lowing", id = 588, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Mind Blast", id = 644, points = 4, wiki_weight = 1, cost = 4 },
        },
        tiers = { [8] = "I", [16] = "II", [24] = "III", [32] = "IV" },
    },
    ["Attack Bonus"] = {
        name = "Attack Bonus",
        spells = {
            { name = "Battle Dance", id = 620, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Uppercut", id = 594, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Death Scissors", id = 554, points = 4, wiki_weight = 1, cost = 5 },
            { name = "Spinal Cleave", id = 540, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Temporal Shift", id = 616, points = 4, wiki_weight = 1, cost = 5 },
        },
        tiers = { [8] = "I", [16] = "II" },
    },
    ["Conserve MP"] = {
        name = "Conserve MP",
        spells = {
            { name = "Chaotic Eye", id = 582, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Zephyr Mantle", id = 647, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Frost Breath", id = 608, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Firespit", id = 637, points = 4, wiki_weight = 1, cost = 5 },
        },
        tiers = { [8] = "I", [16] = "II" },
    },
    ["Accuracy Bonus"] = {
        name = "Accuracy Bonus",
        spells = {
            { name = "Dimensional Death", id = 589, points = 4, wiki_weight = 1, cost = 5 },
            { name = "Frenetic Rip", id = 560, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Disseverment", id = 611, points = 4, wiki_weight = 1, cost = 5 },
        },
        tiers = { [8] = "I" },
    },
    ["Counter"] = {
        name = "Counter",
        spells = {
            { name = "Enervation", id = 633, points = 4, wiki_weight = 1, cost = 5 },
            { name = "Asuran Claws", id = 653, points = 4, wiki_weight = 1, cost = 2 },
        },
        tiers = { [8] = "I" },
    },
    ["Store TP"] = {
        name = "Store TP",
        spells = {
            { name = "Sickle Slash", id = 545, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Tail Slap", id = 640, points = 4, wiki_weight = 1, cost = 4 },
        },
        tiers = { [8] = "I" },
    },
    ["Auto Refresh"] = {
        name = "Auto Refresh",
        spells = {
            { name = "Stinking Gas", id = 537, points = 1, wiki_weight = 1, cost = 2 },
            { name = "Geist Wall", id = 605, points_unknown = true, cost = 3 },
            { name = "Blood Saber", id = 541, points_unknown = true, cost = 3 },
            { name = "Frightful Roar", id = 561, points = 2, wiki_weight = 2, cost = 3 },
            { name = "Self-Destruct", id = 533, points = 2, wiki_weight = 2, cost = 3 },
            { name = "Cold Wave", id = 535, points = 1, wiki_weight = 1, cost = 1 },
            { name = "Winds of Promyvion", id = 681, points_unknown = true, cost = 4 },
            { name = "Light of Penance", id = 634, points = 2, wiki_weight = 2, cost = 5 },
            { name = "Voracious Trunk", id = 579, points = 3, wiki_weight = 3, cost = 4 },
            { name = "Actinic Burst", id = 612, points = 4, wiki_weight = 4, cost = 4 },
            { name = "Plasma Charge", id = 615, points = 4, wiki_weight = 4, cost = 5 },
        },
        tiers = { [8] = "I" },
    },
    ["Beast Killer"] = {
        name = "Beast Killer",
        spells = {
            { name = "Wild Oats", id = 603, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Sprout Smack", id = 597, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Seedspray", id = 650, points = 4, wiki_weight = 1, cost = 2 },
            { name = "1000 Needles", id = 595, points = 4, wiki_weight = 1, cost = 5 },
        },
        tiers = { [8] = "I", [16] = "II" },
    },
    ["Defense Bonus"] = {
        name = "Defense Bonus",
        spells = {
            { name = "Grand Slam", id = 622, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Terror Touch", id = 539, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Saline Coat", id = 614, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Vertical Cleave", id = 617, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I", [16] = "II" },
    },
    ["Max HP Boost"] = {
        name = "Max HP Boost",
        spells = {
            { name = "Flying Hip Press", id = 629, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Body Slam", id = 564, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Frypan", id = 628, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I" },
    },
    ["Lizard Killer"] = {
        name = "Lizard Killer",
        spells = {
            { name = "Foot Kick", id = 577, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Claw Cyclone", id = 587, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Ram Charge", id = 585, points = 4, wiki_weight = 1, cost = 4 },
        },
        tiers = { [8] = "I" },
    },
    ["Evasion Bonus"] = {
        name = "Evasion Bonus",
        spells = {
            { name = "Screwdriver", id = 519, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Hysteric Barrage", id = 641, points = 4, wiki_weight = 1, cost = 5 },
        },
        tiers = { [8] = "I" },
    },
    ["Undead Killer"] = {
        name = "Undead Killer",
        spells = {
            { name = "Bludgeon", id = 529, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Smite of Rage", id = 527, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I" },
    },
    ["Magic Attack Bonus"] = {
        name = "Magic Attack Bonus",
        spells = {
            { name = "Cursed Sphere", id = 544, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Sound Blast", id = 572, points = 4, wiki_weight = 1, cost = 1 },
            { name = "Eyes On Me", id = 557, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Memento Mori", id = 538, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Heat Breath", id = 591, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Magic Hammer", id = 646, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Reactor Cool", id = 613, points = 4, wiki_weight = 1, cost = 5 },
        },
        tiers = { [8] = "I", [16] = "II", [24] = "III" },
    },
    ["Resist Sleep"] = {
        name = "Resist Sleep",
        spells = {
            { name = "Pollen", id = 549, points = 4, wiki_weight = 1, cost = 1 },
            { name = "Wild Carrot", id = 578, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Magic Fruit", id = 593, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Yawn", id = 576, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Exuviation", id = 645, points = 4, wiki_weight = 1, cost = 4 },
        },
        tiers = { [8] = "I", [16] = "II" },
    },
    ["Max MP Boost"] = {
        name = "Max MP Boost",
        spells = {
            { name = "Metallic Body", id = 517, points = 4, wiki_weight = 1, cost = 1 },
            { name = "Mysterious Light", id = 534, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Hecatomb Wave", id = 563, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I" },
    },
    ["Plantoid Killer"] = {
        name = "Plantoid Killer",
        spells = {
            { name = "Power Attack", id = 551, points = 4, wiki_weight = 1, cost = 1 },
            { name = "Mandibular Bite", id = 543, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Spiral Spin", id = 652, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I" },
    },
    ["Rapid Shot"] = {
        name = "Rapid Shot",
        spells = {
            { name = "Feather Storm", id = 638, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Jet Stream", id = 569, points = 4, wiki_weight = 1, cost = 4 },
            { name = "Hydro Shot", id = 631, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I" },
    },
    ["Auto Regen"] = {
        name = "Auto Regen",
        spells = {
            { name = "Sheep Song", id = 584, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Healing Breeze", id = 581, points = 4, wiki_weight = 1, cost = 4 },
        },
        tiers = { [8] = "I" },
    },
    ["Fast Cast"] = {
        name = "Fast Cast",
        spells = {
            { name = "Bad Breath", id = 604, points = 4, wiki_weight = 1, cost = 5 },
            { name = "Sub-Zero Smash", id = 654, points = 4, wiki_weight = 1, cost = 4 },
        },
        tiers = { [8] = "0" },
    },
    ["Magic Defense Bonus"] = {
        name = "Magic Defense Bonus",
        spells = {
            { name = "Magnetite Cloud", id = 555, points = 4, wiki_weight = 1, cost = 3 },
            { name = "Ice Break", id = 531, points = 4, wiki_weight = 1, cost = 3 },
        },
        tiers = { [8] = "I" },
    },
    ["Resist Gravity"] = {
        name = "Resist Gravity",
        spells = {
            { name = "Feather Barrier", id = 574, points = 4, wiki_weight = 1, cost = 2 },
            { name = "Regurgitation", id = 648, points = 4, wiki_weight = 1, cost = 1 },
        },
        tiers = { [8] = "I" },
    },
}
--Copyright © 2015, Anissa
--All rights reserved.

--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:

--    * Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--    * Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in the
--      documentation and/or other materials provided with the distribution.
--    * Neither the name of bluGuide nor the
--      names of its contributors may be used to endorse or promote products
--      derived from this software without specific prior written permission.

--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL ANISSA BE LIABLE FOR ANY
--DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

