UPDATE `creature_template` SET `minlevel`= 85, `maxlevel`= 85, `faction`= 16, `unit_flags`= 33554432, `flags_extra`= 128 WHERE `entry`= 41144;

REPLACE INTO `creature_template_addon` (`entry`, `auras`) VALUES
(41194 ,'77121'),
(41144, '');

REPLACE INTO `spell_script_names` (`spell_id`, `scriptname`) VALUES
(77437, 'spell_anraphet_destruction_protocol');
