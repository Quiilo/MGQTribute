instance_deactivate_all(true);
units = [];
turn = 0;
unitTurnOrder = [];
unitRenderOrder = [];

//targetting cursor 
cursor =
{
	activeUser: noone,
	activeTarget: noone,
	activeAction: -1,
	targetSide: -1,
	targetIndex: 0,
	targetAll: false,
	confirmDelay: 0,
	active: false
};

turnCount = 0;
roundCount = 0;
battleWaitTimeFrames = 30;
battleWaitTimeRemaining = 0;
battleText= "";
currentUser = noone;
currentAction = -1;
currentTargets = noone;


for (var i = 0; i < array_length(enemies); i++)
{
  enemyUnits[i] = instance_create_depth(x+250 + (i*10), y+68+(i*20), depth-10, obj_battle_unitsEnemy, enemies[i]);
  array_push(units, enemyUnits[i]);
}

for (var i = 0; i < array_length(global.party); i++)
{
  partyUnits[i] = instance_create_depth(x+70+(i*10), y+68+(i*15), depth - 10, obj_battle_unitsPC, global.party[i]);
  array_push(units, partyUnits[i]);
  
}
//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
  unitRenderOrder = [];
  array_copy(unitRenderOrder,0,units,0,array_length(units));
  array_sort(unitRenderOrder,function(_1,_2)
  {
	  return _1. y - _2.y;
  });
}
RefreshRenderOrder();

function BattleStateSelectAction()
{
    if (!instance_exists(obj_battle_menu))
	{
		//Current unit
		var _unit = unitTurnOrder[turn];
	
		//check unit dead or alive
		if (!instance_exists(_unit)) || (_unit.hp <= 0)
		{
			battleState = BattleStateVictoryCheck;
			exit;
		}
	
		//Select an action
		//BeginAction(_unit.id, global.actionLibrary.attack, _unit.id);
	
		//if unit is player controlled
		if (_unit.object_index == obj_battle_unitsPC)
		{
			var _menuOptions = [];
			var _subMenus = {};
			
			var _actionList = _unit.actions;
			
			for (var i = 0; i < array_length(_actionList); i++)
			{
				var _action = _actionList[i];
				var _available = true; //mp check
				var _nameAndCount = _action.name;
				if (_action.subMenu == -1)
				{
					array_push(_menuOptions, [_nameAndCount, MenuSelectAction, [_unit, _action], _available]);
				}
				else
				{
					//create or add to a submenu
					if (is_undefined(_subMenus[$ _action.subMenu]))
					{
						variable_struct_set(_subMenus, _action.subMenu, [[_nameAndCount, MenuSelectAction, [_unit, _action], _available]]);
					}
					else
					{
						array_push(_subMenus[$ _action.subMenu], [_nameAndCount, MenuSelectAction, [_unit, _action], _available]);
					}
				}		
			}
			// turn sub menus into an array
				var _subMenusArray = variable_struct_get_names(_subMenus);
				for (var i = 0; i < array_length(_subMenusArray); i++)
				{
					//sort submenu if needed
					//(here)
					
					//add back option at the end
					array_push(_subMenus[$ _subMenusArray[i]], ["Back", MenuGoBack, -1, true]);
					//add submenu into main menu
					array_push(_menuOptions, [_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true]);
				}
			battleMenu(x+10, y+110, _menuOptions, ,74, 60); 
			//var _action = global.actionLibrary.attack;
			//var _possibleTargets = array_filter(obj_battle.enemyUnits, function(_unit, _index)
			//{
			//  return (_unit.hp > 0);
			//});
			//var _target = _possibleTargets[irandom(array_length(_possibleTargets) -1)];
			//BeginAction(_unit.id,_action,_target);
		}
		//if unit is AI controlled
		else
		{
			 var _enemyAction = _unit.AIscript();
			 if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]);
		}
	}
}

function BeginAction(_user, _action, _targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	battleText = string_ext(_action.description, [_user.name]);
	if (!is_array(currentTargets)) currentTargets = [currentTargets];
	battleWaitTimeRemaining = battleWaitTimeFrames;
	with (_user)
	{
	  acting = true;
	  //play user animation if the current action has a animation
	  if(!is_undefined(_action[$ "userAnimation"])) && (!is_undefined(_user.sprites[$ _action.userAnimation]))
	  {
		sprite_index = sprites[$ _action.userAnimation];
		image_index = 0;
	  }
	}
	battleState = BattleStatePerformAction;
}

function BattleStatePerformAction()
{
	 //if animation is still playing
	 if (currentUser.acting)
	 {
		//when it ends, perform action effect
		if (currentUser.image_index >= currentUser.image_number -1)
		{
		  with(currentUser)
		  {
			  sprite_index = sprites.idle;
			  image_index = 0;
			  acting = false;
		  }
		  
		  if (variable_struct_exists(currentAction, "effectSprite"))
		  {
			 if (currentAction.effectOnTarget == MODE.ALWAYS) || ( (currentAction.effectOnTarget == MODE.VARIES) && (array_length(currentTargets) <= 1) )
			 {
				
				for (var i = 0; i < array_length(currentTargets); i++)
				{
				 instance_create_depth(currentTargets[i].x,currentTargets[i].y,currentTargets[i].depth -1, obj_battle_effect,{sprite_index : currentAction.effectSprite});
				}	
				
			 }
			 else
			 {
				
			  var _effectSprite = currentAction.effectSprite;
			  if (variable_strut_exists(currentAction, "effectSpriteNoTarget")) _effectSprite = currentAction.effectSpriteNoTarget;
			  instance_create_depth(x,y,depth-100,obj_battle_effect,{sprite_index : _effectSprite});
			 
			 }
		  }
		   currentAction.func(currentUser, currentTargets);
		}
		
	 }
	 else //wait for delay and end turn
	 {
		 if (!instance_exists(obj_battle_effect))
		 {
		   battleWaitTimeRemaining--;
		   if (battleWaitTimeRemaining == 0)
		   {
			battleState = BattleStateVictoryCheck;   
		   }
		 }
	 }
}

function BattleStateVictoryCheck()
{
if (
	battleState = BattleStateTurnProgression;
	//instance_destroy();
	//instance_activate_all();

}

function BattleStateTurnProgression()
{
	battleText= "";//reset
	turnCount++;
	turn++;
	//Loop
	if (turn > array_length(unitTurnOrder) - 1)
	{
		turn = 0;
		roundCount++;
	}
	battleState = BattleStateSelectAction;
}

battleState = BattleStateSelectAction;