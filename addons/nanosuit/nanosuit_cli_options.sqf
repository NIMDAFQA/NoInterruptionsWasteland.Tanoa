// ******************************************************************************************
// *This project is licensed under the GNU Affero GPL v3. Copyright © 2015 Poisonous Shadows*
// ******************************************************************************************
//	@file Name: nanosuit_cli_options.sqf
//	@file Author: NIMDA

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Setup
////////////////////////////////////////////////////////////////////////////////////////////////////////////
#define debugMenu_option 60003
#define NanoSuitMenu_option 60007
disableSerialization;
private ["_displayNano","_displayDebug","_nanoSelect"];
_displayNano = uiNamespace getVariable ["NanosuitMenu", displayNull];
_nanoSelect = _displayNano displayCtrl NanoSuitMenu_option;
_timer = 240;
_cooldown = 30;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Menu Scripts
////////////////////////////////////////////////////////////////////////////////////////////////////////////
switch (lbCurSel _nanoSelect) do
{
	case 0: //Cloaking
	{
		disableSerialization;
		_display = uiNamespace getVariable "POWERMETER";
	    _setProgress = _display displayCtrl 60009;
	    _powerRemaining = progressPosition _setProgress;
		cloakToggle = !cloakToggle;
		[[[player,cloakToggle,_powerRemaining],"addons\nanosuit\cloak.sqf"],"BIS_fnc_execVM",false,true] call BIS_fnc_MP;
		[_timer,cloakToggle,_cooldown] execVM "addons\nanosuit\cloak_cli.sqf";
	};
	case 1: //Power Armor
	{
		paToggle = !paToggle;
		if (paToggle) then
		{
			player groupChat "Power Armor Enabled";
			playSound "maximum_armor";
			while {paToggle} do
			{
				if (!alive player) then {paToggle = false};
				disableSerialization;
				_display = uiNamespace getVariable "POWERMETER";
	    		_setProgress = _display displayCtrl 60009;
	    		_powerRemaining = progressPosition _setProgress;
				_damageAmt = damage player;
				if (_damageAmt > 0) then
				{
					if (_powerRemaining > _damageAmt) then
					{
						_powerRemaining = _powerRemaining - _damageAmt;
						_setProgress progressSetPosition _powerRemaining;
						player setDamage 0;
						if (player getVariable ["FAR_isUnconscious", 0] == 1) then
						{
							player setVariable ["FAR_isUnconscious", 0, true];
						};
						(findDisplay 27910) closeDisplay 0; // ReviveBlankGUI_IDD
						(findDisplay 27911) closeDisplay 0; // ReviveGUI_IDD
					}
					else
					{
						_dmgRemaining = _damageAmt - _powerRemaining;
						player setDamage _dmgRemaining;
						_powerRemaining = 0;
						_setProgress progressSetPosition _powerRemaining;
					};
				};
			};
		}
		else
		{
			player groupChat "Power Armor Disabled";
			[_timer,_cooldown] execVM "addons\nanosuit\power_regen.sqf";
		};
		/*if(paToggle) then
		{
			powerArmor = player addEventHandler ["Dammaged",{[_this select 2]execVM "addons\nanosuit\power_armor.sqf"}];
			playSound "maximum_armor";
			player systemChat "Power Armor Enabled";
		}
		else
		{
			player removeEventHandler["Dammaged",powerArmor];
			[[[_timer,false,_cooldown],"addons\nanosuit\cloak_cli.sqf"],"BIS_fnc_execVM",_player] call BIS_fnc_MP;
			player systemChat "Power Armor Disabled"
		};*/
		//hint "Coming in a future update!";
	};
	case 2: //Night Vision
	{
		nightVision = !nightVision;
		if(nightVision) then
		{
			setAperture 0.65;
			playSound "nanovision_enabled";
			player groupChat "Night Vision Enabled";
		}
		else
		{
			setAperture -1;
			player groupChat "Night Vision Disabled";
		};
	};
	case 3: //ESP
	{
		closeDialog 0;
		hint "Coming in a future update!";
	};
	case 4: //Power Sprint
	{
		closeDialog 0;
		hint "Coming in a future update!";
	};
	case 5: //KeyBindings
	{
		closeDialog 0;
		hint "Coming in a future update!";
	};
	case 6: //Credits
	{
		closeDialog 0;
		hint "Nanosuits for A3Wasteland Copyright © 2015 Poisonous Shadows. Written by NIMDA.";
	};
	case 7: //Exit
	{
		closeDialog 0;
	};
};
////////////////////////////////////////////////////////////////////////////////////////////////////////////