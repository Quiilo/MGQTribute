global.party =
[
    {
	  name: "Questy",
	  hp: 10,
	  hpMax: 10,
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
