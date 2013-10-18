DELETE FROM `creature_template` WHERE `entry` IN (34485, 34486);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`,
 `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `exp_unk`, `faction_A`, `faction_H`,
 `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`,
 `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`,
  `type`, `type_flags`, `type_flags2`, `lootid`, `pickpocketloot`,
 `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`,
 `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`,
 `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Mana_mod_extra`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`,
 `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`,
 `flags_extra`, `ScriptName`, `WDBVerified`) VALUES
(34485, 0, 0, 0, 0, 0, 32710, 0, 0, 0, 'Avatar of Soggoth', '', '', 0, 20, 20, 0, 0, 1801, 1801, 0, 1, 1.14286, 1, 1, 24, 36, 0, 9, 2, 2000, 2000, 1, 0, 2048, 0, 0, 19, 29, 7, 7, 0, 0, 34485, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 126, 126, '', 0, 3, 1, 8, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 15595),
(34486, 0, 0, 0, 0, 0, 1921, 29238, 29239, 0, 'Awakened Ancient', '', '', 0, 19, 20, 0, 0, 1802, 1802, 0, 1, 1.14286, 1, 0, 24, 36, 0, 9, 1, 2000, 2000, 1, 0, 2048, 0, 0, 19, 29, 7, 7, 256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26281, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', 15595);

DELETE FROM `spell_script_names` WHERE `spell_id` = '80230';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(80230, 'spell_horn_of_the_ancients');

-- Avatar of Soggoth
SET @ENTRY := 34485;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,54,0,100,0,0,0,0,0,49,0,0,0,0,0,0,11,34486,100,0,0.0,0.0,0.0,0.0,"Just Summoned - Attack Start ");

-- Awakened Ancient
SET @ENTRY := 34486;
SET @SOURCETYPE := 0;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=@SOURCETYPE;
UPDATE creature_template SET AIName="SmartAI" WHERE entry=@ENTRY LIMIT 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES 
(@ENTRY,@SOURCETYPE,0,0,0,0,100,0,5000,9000,15000,22000,11,26281,0,0,0,0,0,11,34485,100,0,0.0,0.0,0.0,0.0,"Cast Taunt");

DELETE FROM `creature_loot_template` WHERE `entry` = '34485';
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
(34485, 789, 0.2832, 1, 0, 1, 1),
(34485, 790, 0.3347, 1, 0, 1, 1),
(34485, 856, 0.1545, 1, 0, 1, 1),
(34485, 858, 2.8321, 1, 0, 1, 1),
(34485, 935, 0.0257, 1, 0, 1, 1),
(34485, 1179, 5.793, 1, 0, 1, 1),
(34485, 1206, 0.5312, 1, 0, 1, 1),
(34485, 1210, 2.3172, 1, 0, 1, 1),
(34485, 1738, 0.3347, 1, 0, 1, 1),
(34485, 1739, 1.725, 1, 0, 1, 1),
(34485, 1740, 0.4634, 1, 0, 1, 1),
(34485, 1742, 0.309, 1, 0, 1, 1),
(34485, 1743, 0.309, 1, 0, 1, 1),
(34485, 1744, 0.7981, 1, 0, 1, 1),
(34485, 1745, 0.9526, 1, 0, 1, 1),
(34485, 1764, 1.1329, 1, 0, 1, 1),
(34485, 1766, 0.5922, 1, 0, 1, 1),
(34485, 1767, 0.3605, 1, 0, 1, 1),
(34485, 1768, 1.9567, 1, 0, 1, 1),
(34485, 1769, 0.4634, 1, 0, 1, 1),
(34485, 1770, 0.4892, 1, 0, 1, 1),
(34485, 1787, 0.6437, 1, 0, 1, 1),
(34485, 1788, 0.5922, 1, 0, 1, 1),
(34485, 1789, 0.8239, 1, 0, 1, 1),
(34485, 1791, 0.3862, 1, 0, 1, 1),
(34485, 1792, 0.8754, 1, 0, 1, 1),
(34485, 1793, 0.2832, 1, 0, 1, 1),
(34485, 1794, 0.6694, 1, 0, 1, 1),
(34485, 1811, 1.1329, 1, 0, 1, 1),
(34485, 1812, 0.5664, 1, 0, 1, 1),
(34485, 1813, 0.9526, 1, 0, 1, 1),
(34485, 1814, 0.7981, 1, 0, 1, 1),
(34485, 1815, 1.1071, 1, 0, 1, 1),
(34485, 1816, 0.5407, 1, 0, 1, 1),
(34485, 1817, 0.5922, 1, 0, 1, 1),
(34485, 2216, 0.6437, 1, 0, 1, 1),
(34485, 2217, 0.4892, 1, 0, 1, 1),
(34485, 2406, 0.0257, 1, 0, 1, 1),
(34485, 2408, 0.1287, 1, 0, 1, 1),
(34485, 2409, 0.0515, 1, 0, 1, 1),
(34485, 2455, 1.2873, 1, 0, 1, 1),
(34485, 2589, 26.1, 1, 0, 1, 5),
(34485, 2592, 32.6, 1, 0, 1, 4),
(34485, 2657, 0.0515, 1, 0, 1, 1),
(34485, 2764, 1.0814, 1, 0, 1, 1),
(34485, 2780, 0.7981, 1, 0, 1, 1),
(34485, 2781, 0.8754, 1, 0, 1, 1),
(34485, 3039, 0.0443, 1, 0, 1, 1),
(34485, 3040, 0.2317, 1, 0, 1, 1),
(34485, 3184, 0.3605, 1, 0, 1, 1),
(34485, 3193, 0.0515, 1, 0, 1, 1),
(34485, 3198, 0.103, 1, 0, 1, 1),
(34485, 3199, 0.1802, 1, 0, 1, 1),
(34485, 3376, 0.7981, 1, 0, 1, 1),
(34485, 3377, 2.3429, 1, 0, 1, 1),
(34485, 4292, 0.1802, 1, 0, 1, 1),
(34485, 4346, 0.0257, 1, 0, 1, 1),
(34485, 4348, 0.0257, 1, 0, 1, 1),
(34485, 4408, 0.1802, 1, 0, 1, 1),
(34485, 4409, 0.0257, 1, 0, 1, 1),
(34485, 4568, 0.4634, 1, 0, 1, 1),
(34485, 4575, 0.5149, 1, 0, 1, 1),
(34485, 4576, 0.1287, 1, 0, 1, 1),
(34485, 4605, 9.5263, 1, 0, 1, 1),
(34485, 5207, 0.4892, 1, 0, 1, 1),
(34485, 5573, 0.2317, 1, 0, 1, 1),
(34485, 5574, 0.0515, 1, 0, 1, 1),
(34485, 6271, 0.0257, 1, 0, 1, 1),
(34485, 6342, 0.0257, 1, 0, 1, 1),
(34485, 6344, 0.0515, 1, 0, 1, 1),
(34485, 6347, 0.1802, 1, 0, 1, 1),
(34485, 6348, 0.0772, 1, 0, 1, 1),
(34485, 6391, 0.0257, 1, 0, 1, 1),
(34485, 6716, 0.1545, 1, 0, 1, 1),
(34485, 7288, 0.0515, 1, 0, 1, 1),
(34485, 9766, 0.1545, 1, 0, 1, 1),
(34485, 9767, 0.103, 1, 0, 1, 1),
(34485, 9768, 0.0772, 1, 0, 1, 1),
(34485, 9770, 0.2317, 1, 0, 1, 1),
(34485, 11081, 0.0772, 1, 0, 1, 1),
(34485, 11965, 0.1545, 1, 0, 1, 1),
(34485, 11967, 0.0257, 1, 0, 1, 1),
(34485, 11981, 0.1287, 1, 0, 1, 1),
(34485, 11993, 0.0515, 1, 0, 1, 1),
(34485, 12006, 0.0257, 1, 0, 1, 1),
(34485, 12052, 0.103, 1, 0, 1, 1),
(34485, 12053, 0.103, 1, 0, 1, 1),
(34485, 12976, 0.0257, 1, 0, 1, 1),
(34485, 12977, 0.103, 1, 0, 1, 1),
(34485, 12978, 0.0257, 1, 0, 1, 1),
(34485, 12983, 0.0257, 1, 0, 1, 1),
(34485, 12984, 0.0257, 1, 0, 1, 1),
(34485, 13136, 0.0257, 1, 0, 1, 1),
(34485, 14120, 0.1802, 1, 0, 1, 1),
(34485, 14121, 0.2832, 1, 0, 1, 1),
(34485, 14124, 0.4377, 1, 0, 1, 1),
(34485, 14125, 0.2575, 1, 0, 1, 1),
(34485, 14126, 0.0257, 1, 0, 1, 1),
(34485, 14129, 0.3347, 1, 0, 1, 1),
(34485, 14131, 0.3347, 1, 0, 1, 1),
(34485, 14159, 0.103, 1, 0, 1, 1),
(34485, 14160, 0.2832, 1, 0, 1, 1),
(34485, 14162, 0.0257, 1, 0, 1, 1),
(34485, 14164, 0.3862, 1, 0, 1, 1),
(34485, 14169, 0.2832, 1, 0, 1, 1),
(34485, 14367, 0.3862, 1, 0, 1, 1),
(34485, 14368, 0.206, 1, 0, 1, 1),
(34485, 14370, 0.0515, 1, 0, 1, 1),
(34485, 14371, 1.1329, 1, 0, 1, 1),
(34485, 14376, 0.0515, 1, 0, 1, 1),
(34485, 14560, 0.1802, 1, 0, 1, 1),
(34485, 14562, 0.0515, 1, 0, 1, 1),
(34485, 14564, 0.3347, 1, 0, 1, 1),
(34485, 14565, 0.206, 1, 0, 1, 1),
(34485, 14567, 0.0257, 1, 0, 1, 1),
(34485, 14568, 0.0257, 1, 0, 1, 1),
(34485, 14569, 0.0772, 1, 0, 1, 1),
(34485, 14571, 0.206, 1, 0, 1, 1),
(34485, 14727, 0.2317, 1, 0, 1, 1),
(34485, 14728, 0.0515, 1, 0, 1, 1),
(34485, 14729, 0.2317, 1, 0, 1, 1),
(34485, 14730, 0.1287, 1, 0, 1, 1),
(34485, 14743, 0.0772, 1, 0, 1, 1),
(34485, 14745, 0.1287, 1, 0, 1, 1),
(34485, 14746, 0.103, 1, 0, 1, 1),
(34485, 14747, 0.2317, 1, 0, 1, 1),
(34485, 15017, 0.3605, 1, 0, 1, 1),
(34485, 15018, 0.5149, 1, 0, 1, 1),
(34485, 15019, 0.206, 1, 0, 1, 1),
(34485, 15110, 0.1287, 1, 0, 1, 1),
(34485, 15111, 0.0257, 1, 0, 1, 1),
(34485, 15112, 0.3605, 1, 0, 1, 1),
(34485, 15113, 0.0772, 1, 0, 1, 1),
(34485, 15114, 0.309, 1, 0, 1, 1),
(34485, 15115, 0.0257, 1, 0, 1, 1),
(34485, 15222, 0.2317, 1, 0, 1, 1),
(34485, 15248, 0.3347, 1, 0, 1, 1),
(34485, 15307, 0.206, 1, 0, 1, 1),
(34485, 15311, 0.0772, 1, 0, 1, 1),
(34485, 15312, 0.2575, 1, 0, 1, 1),
(34485, 15331, 0.0515, 1, 0, 1, 1),
(34485, 15333, 0.0515, 1, 0, 1, 1),
(34485, 15488, 0.0515, 1, 0, 1, 1),
(34485, 15496, 0.0772, 1, 0, 1, 1),
(34485, 15497, 0.103, 1, 0, 1, 1),
(34485, 15498, 0.4377, 1, 0, 1, 1),
(34485, 15502, 0.3347, 1, 0, 1, 1),
(34485, 15503, 0.103, 1, 0, 1, 1),
(34485, 15504, 0.0257, 1, 0, 1, 1),
(34485, 15505, 0.0772, 1, 0, 1, 1),
(34485, 15506, 0.103, 1, 0, 1, 1),
(34485, 15507, 0.1802, 1, 0, 1, 1),
(34485, 15508, 0.0515, 1, 0, 1, 1),
(34485, 15509, 0.1802, 1, 0, 1, 1),
(34485, 15510, 0.2832, 1, 0, 1, 1),
(34485, 15512, 0.0772, 1, 0, 1, 1),
(34485, 15946, 0.0515, 1, 0, 1, 1),
(34485, 15971, 0.103, 1, 0, 1, 1);