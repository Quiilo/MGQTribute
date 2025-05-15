var _inst;
if (!instance_exists(obj_battle_transition))
{
 _inst = instance_create_depth(0,0, -9999, obj_battle_transition);
}
if (instance_exists(_inst)) NewEncounter([global.enemies.Slime, global.enemies.Slime], spr_bg_field);