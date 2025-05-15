global.actionLibrary = 
{
	attack:
	{
	  name: "Attack",
	  description: "{0} attacks!",
	  subMenu: -1,
	  targetRequired: true,
	  targetEnemyByDefault: true,
	  targetAll: MODE.NEVER,
	  userAnimation : "attack",
	  effectSprite : spr_attack_bonk,
	  effectOnTarget: MODE.ALWAYS,
	  func: function(_user, _targets)
	  {
		var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
		BattleChangeHP(_targets[0], -_damage, 0)
	  }
	  
	}
	
}

enum MODE
{
  NEVER = 0,
  ALWAYS = 1,
  VARIES = 2
}



global.party =
[
    {
	  name: "Questy",
	  hp: 20,
	  hpMax: 20,
	  mp: 5,
	  mpMax: 5,
	  strength: 5,
	  sprites: {idle: spr_player_right, attack: spr_player_attack, down: spr_player_down},
	  actions : []
		
	}

]

global.enemies =
{
   Slime:
   {
	name: "Slime",
	hp: 10,
	hpMax: 10,
	mp: 0,
	mpMax: 0,
	strength: 2,
	sprites: {idle: spr_slime, attack: spr_slime_attack},
	actions: [global.actionLibrary.attack],
	xpValue: 15,
	AIscript: function()
	{
		//attacks random party member
		var _action = actions[0];
		var _possibleTargets = array_filter(obj_battle.partyUnits, function(_unit, _index)
		{
		  return (_unit.hp > 0);
		});
		var _target = _possibleTargets[irandom(array_length(_possibleTargets) -1)];
		return [_action, _target];
	}
	
   }
}
