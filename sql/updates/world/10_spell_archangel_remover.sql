DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = '-87117';
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = '-87118';
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (-81660, -87154, 'Evangelism -> Remove Archangel Trigger');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (-81661, -87154, 'Evangelism -> Remove Archangel Trigger');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (-87117, -94709, 'Dark Evangelism -> Remove Archangel Trigger');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (-87118, -87154, 'Dark Evangelism -> Remove Archangel Trigger');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-87118 AND `spell_effect`=-94709 AND `type`=0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-87117 AND `spell_effect`=-94709 AND `type`=0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-81661 AND `spell_effect`=-94709 AND `type`=0;
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=-81660 AND `spell_effect`=-94709 AND `type`=0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-87118, -94709, 0, 'Dark Evangelism -> Remove Archangel!');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-87117, -94709, 0, 'Dark Evangelism -> Remove Archangel!');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-81661, -94709, 0, 'Evangelism -> Remove Archangel!');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (-81660, -94709, 0, 'Evangelism -> Remove Archangel!');