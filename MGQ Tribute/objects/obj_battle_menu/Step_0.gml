if (active)
{
	//control menu
	hover += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
	if (hover > array_length(options)-1) hover = 0;
	if (hover < 0) hover = array_length(options) -1;
	
	if (keyboard_check_pressed(vk_space))
	{
		if ((array_length(options[hover]) > 1) && (options[hover][3] == true))
		{
			var _func = options[hover][1];
			if (options[hover][2] != -1) script_execute_ext(_func,options[hover][2]); else _func(); 
		}
	}
	if (keyboard_check_pressed(vk_escape))
	{
		if (subMenuLevel > 0) MenuGoBack();
	}
}