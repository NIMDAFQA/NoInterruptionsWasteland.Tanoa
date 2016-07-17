// ******************************************************************************************
// *This project is licensed under the GNU Affero GPL v3. Copyright © 2015 Poisonous Shadows*
// ******************************************************************************************
//	@file Name: power_armor.sqf
//	@file Author: NIMDA

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//											Setup
////////////////////////////////////////////////////////////////////////////////////////////////////////////
disableSerialization;
_display = uiNamespace getVariable "POWERMETER";
_setProgress = _display displayCtrl 60009;
_powerRemaining = progressPosition _setProgress;
_damageAmt = damage player;
////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//										Power Armor
////////////////////////////////////////////////////////////////////////////////////////////////////////////
while {paToggle} do
{
	if ((_damageAmt > 0.0) && (_powerRemaining > _damageAmt) then
	{
		_powerRemaining = _powerRemaining - _damageAmt;
		_setProgress progressSetPosition _powerRemaining;
		player setDamage 0;
	}
	else
	{
		_dmgRemaining = _damageAmt - _powerRemaining;
		player setDamage _dmgRemaining;
		_powerRemaining = 0;
		_setProgress progressSetPosition _powerRemaining;
	}
}




if(_powerRemaining >= _damageAmt) then
{
	_powerRemaining = _powerRemaining - _damageAmt;
	_setProgress progressSetPosition _powerRemaining;
	player setDamage 0;
}
else
{
	_damageRemaining = _damageAmt - _powerRemaining;
	_playerDmg = damage player;
	player setDamage (_playerDmg + _damageRemaining);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////