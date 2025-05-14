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
		with (_targets[0]) hp = max(0, hp - _damage);
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
	  sprites: {idle: spr_player_right, attack: spr_player_attack},
	  actions : []
		
	}

]

global.enemies =
{
   Slime:
   {
	name: "Slime",
	hp: 20,
	hpMax: 20,
	mp: 0,
	mpMax: 0,
	strength: 2,
	sprites: {idle: spr_slime, attack: spr_slime_attack},
	actions: [],
	xpValue: 15,
	AIScript: function()
	{
		
	}
	
   }
}
