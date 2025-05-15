function battleMenu(_x,_y, _options, _description = -1, _width = undefined, _height = undefined)
{
	with (instance_create_depth(_x,_y, -99999, obj_battle_menu))
	{
		options = _options;
		description = _description;
		var _optionsCount = array_length(_options);
		visibleOptionsMax = _optionsCount;
		
		
		//Size setup
		xmargin = 10;
		ymargin = 8;
		draw_set_font(fnM5x7);
		heightLine = 12;
		
		//Auto width;
		if (_width == undefined)
		{
		  width = 1;
		  if (description != -1) width = max(width, string_width(_description));
		  for (var i = 0; i < _optionsCount; i++)
		  {
			width = max(width, string_width(_options[i][0]));
		  }
		  widthFull = width + xmargin * 2;
		  
		}
		else widthFull = _width;
		
		//Auto height
		if(_height == undefined)
		{
			height = heightLine * (_optionsCount + !(description == -1));
			heightFull = height + ymargin * 2;
		}
		else
		{
			heightFull = _height;
			//scroll function
			if (heightLine * (_optionsCount + !(description == -1)) > _height - (ymargin * 2))
			{
				scrolling = true;
				visibleOptionsMax = (_height - ymargin * 2) div heightLine;
			}
		}
	}
}

function SubMenu(_options)
{
  //store current menu
  optionsAbove[subMenuLevel] = options;
  subMenuLevel++;
  options = _options;
  hover = 0;
}

function MenuGoBack()
{
  subMenuLevel--;
  options = optionsAbove[subMenuLevel];
  hover = 0;
}
function MenuSelectAction(_user, _action)
{
	with(obj_battle_menu) active = false;
	//cursor activation
	with (obj_battle) 
	{
		if (_action.targetRequired)
		{
			with(cursor)
			{
				active = true;
				activeAction = _action;
				targetAll = _action.targetAll;
				if (targetAll == MODE.VARIES) targetAll = true;
				activeUser = _user;
				
				//which side to target
				if (_action.targetEnemyByDefault)
				{
					targetIndex = 0;
					targetSide = obj_battle.enemyUnits;
					activeTarget = obj_battle.enemyUnits[targetIndex];
				}
				else
				{
					targetSide = obj_battle.partyUnits;
					activeTarget = activeUser;
					var _findSelf = function(_element)
					{
						return (_element == activeTarget);
					}
					targetIndex = array_find_index(obj_battle.partyUnits, _findSelf);
				}
			}
		}
		else
		{
			//No target needed
			BeginAction(_user,_action, -1);
			with(obj_battle_menu) instance_destroy();
		}
	}
}