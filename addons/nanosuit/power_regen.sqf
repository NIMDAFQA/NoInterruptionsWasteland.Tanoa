// ******************************************************************************************
// *This project is licensed under the GNU Affero GPL v3. Copyright © 2015 Poisonous Shadows*
// ******************************************************************************************
//  @file Name: cloak_cli.sqf
//  @file Author: NIMDA

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Setup
////////////////////////////////////////////////////////////////////////////////////////////////////////////
_timer = _this select 0;
_cooldown = _this select 1;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//		Regenerate Power to _timer in _cooldown seconds (or less depending on existing power level)
////////////////////////////////////////////////////////////////////////////////////////////////////////////
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