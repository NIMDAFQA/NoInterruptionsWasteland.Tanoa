//Client Function for Airstrikes
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: NIMDA

scriptName "airstrikes_cli_start";
private ["_amount","_type","_selectionNumber","_player"]; //Variables coming frofm command menu
_amount 			= _this select 0;
_selectionNumber 	= _this select 1;
_type				= _this select 2;
_player 			= _this select 3;

//diag_log format ["Player %1, Drop Number %2, Selection # %3",_player,_type,_selectionNumber];
//hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
_selectionArray = [];
switch (_type) do {
	case "artillery": {_selectionArray = Airstrikes_Artillery};
	case "missiles": 	{_selectionArray = Airstrikes_Missiles};
	case "bombs":	{_selectionArray = Airstrikes_Bombs};
	default 		{_selectionArray = Airstrikes_Artillery; diag_log "Airstrikes - Default Array Selected - Something's broken";};
};
_selectionName 	= (_selectionArray select _selectionNumber) select 0;
_price 			= (_selectionArray select _selectionNumber) select 2;

/////////////  Cooldown Timer ////////////////////////
if (!isNil "Airstrikes_lastUsedTime") then
{
diag_log format ["Airstrikes - Last Used Time: %1; CoolDown Set At: %2; Current Time: %3",Airstrikes_lastUsedTime, Airstrikes_coolDownTime, diag_tickTime];
_timeRemainingReuse = Airstrikes_coolDownTime - (diag_tickTime - Airstrikes_lastUsedTime); //time is still in s
if ((_timeRemainingReuse) > 0) then 
	{
		hint format["You need to wait %1 seconds before using this service again!", ceil _timeRemainingReuse];
		playSound "FD_CP_Not_Clear_F";
		breakOut "airstrikes_cli_start";
	};
};
////////////////////////////////////////////////////////

_playerMoney = _player getVariable ["bmoney", 0];
if (_price > _playerMoney) exitWith
	{
		hint format["You don't have enough money in the bank to request this airstrike!"];
		playSound "FD_CP_Not_Clear_F";
	};
			
_confirmMsg = format ["This airstrike will deduct $%1 from your bank account<br/>",_price];
_confirmMsg = _confirmMsg + format ["<br/><t font='EtelkaMonospaceProBold'>1</t> x %1",_selectionName];
	// Display confirm message
	if ([parseText _confirmMsg, "Confirm", "Request Airstrike!", true] call BIS_fnc_guiMessage) then
	{
		openMap true;
		//[[_type,_selectionNumber,_player,_amount],"airstrikes_srv_start",false,false,false] call BIS_fnc_MP;
		hint "Click on the map where you would like the airstrike!";
		[_type,_selectionNumber,_player,_amount] onMapSingleCLick {[[_this select 0,_this select 1,_this select 2,_this select 3,_pos],"airstrikes_srv_start",false,false,false] call BIS_fnc_MP; openMap false; onMapSingleClick{}; true;};
		Airstrikes_lastUsedTime = diag_tickTime;
		diag_log format ["Airstrikes - Just Used Time: %1; CoolDown Set At: %2; Current Time: %3",Airstrikes_lastUsedTime, Airstrikes_coolDownTime, diag_tickTime];
	};