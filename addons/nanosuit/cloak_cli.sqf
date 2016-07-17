// ******************************************************************************************
// *This project is licensed under the GNU Affero GPL v3. Copyright © 2015 Poisonous Shadows*
// ******************************************************************************************
//  @file Name: cloak_cli.sqf
//  @file Author: NIMDA

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Setup
////////////////////////////////////////////////////////////////////////////////////////////////////////////
_timer = _this select 0;
_toggle = _this select 1;
_cooldown = _this select 2;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

if(_toggle) then
{
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Cloak Active
////////////////////////////////////////////////////////////////////////////////////////////////////////////
	playSound "cloak_engaged";
	player groupChat "Cloak Engaged";
	[_timer] spawn
	{
	    disableSerialization;
	    _number = _this select 0;
	    _display = uiNamespace getVariable "POWERMETER";
	    _setProgress = _display displayCtrl 60009;
	    _powerRemaining = progressPosition _setProgress;
	    //_setProgress progressSetPosition 1;
	    _numberInv = (1/_number);
	    _BarTimer = _powerRemaining;
	    _timeRemaining = (_number * _powerRemaining);
	    while {!(_timeRemaining < 0) && cloakToggle} do
	    {
	    	_setProgress progressSetPosition _BarTimer;
	    	_BarTimer = _BarTimer - (_numberInv);
	    	_timeRemaining = _timeRemaining - 1;
	    	sleep 1;
	    };
	};
////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
else
{
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//										Cloak Inactive
////////////////////////////////////////////////////////////////////////////////////////////////////////////
	player groupChat "Cloak Deactivated";
	[_cooldown,_timer] spawn
	{
	    disableSerialization;
	    _number = _this select 0;
	    _full = _this select 1;
	    _display = uiNamespace getVariable "POWERMETER";
	    _setProgress = _display displayCtrl 60009;
	    //_setProgress progressSetPosition 1;
	    _powerRemaining = progressPosition _setProgress;
	    _numberINV = (1/_number);
	    _BarTimer = _powerRemaining;
	    _timeRemaining = (_number * _powerRemaining);
	    while {!(_timeRemaining >= _full) && !(cloakToggle)} do
	    {
	    	_setProgress progressSetPosition _BarTimer;
	    	_BarTimer = _BarTimer + (_numberInv);
	    	_timeRemaining = _timeRemaining + 1;
	    	sleep 1;
		};
	};
////////////////////////////////////////////////////////////////////////////////////////////////////////////
};