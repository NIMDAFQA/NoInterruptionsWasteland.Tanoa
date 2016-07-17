//Client Function for Airstrikes
//This takes values from command menu, and some passed variables, and interacts with client and sends commands to server
//Author: NIMDA
//Starts off much the same as the client start.  This is to find information from config arrays


private ["_type","_selection","_player","_amount","_position"]; //Variables coming from command menu and client side APOC_cli_startAirdrop
_type 				= _this select 0;
_selectionNumber 	= _this select 1;
_player 			= _this select 2;
_amount 			= _this select 3;
_position			= _this select 4;

diag_log format ["SERVER - Airstrikes - Player: %1, Drop Type: %2, Selection #: %3",name _player,_type,_selectionNumber];
//hint format ["Well we've made it this far! %1, %2, %3,",_player,_type,_selectionNumber];
_selectionArray = [];

switch (_type) do {
	case "artillery": {_selectionArray = Airstrikes_Artillery};
	case "missiles": 	{_selectionArray = Airstrikes_Missiles};
	case "bombs":	{_selectionArray = Airstrikes_Bombs};
	default 		{_selectionArray = Airstrikes_Artillery; diag_log "Airstrikes - Default Array Selected - Something's broken";};
};

_selectionName 	= (_selectionArray select _selectionNumber) select 0;
_selectionClass = (_selectionArray select _selectionNumber) select 1;
_price 			= (_selectionArray select _selectionNumber) select 2;
_amount 		= (_selectionArray select _selectionNumber) select 3;

//OK, now the real fun


 _planetype = "B_Plane_CAS_01_F";
 _center = createCenter civilian;
_grp = createGroup civilian;
if(isNil("_grp2"))then{_grp2 = createGroup civilian;}else{_grp2 = _grp2;};
_flyHeight = 750;
_dropSpot = [(_position select 0),(_position select 1),_flyHeight];
_planeDirection = random 360;
_flyHeight = 350;  //Distance from ground that plane will fly at
_planeStartDistance = 5000;
_spos=[(_dropSpot select 0) - (sin _planeDirection) * _planeStartDistance, (_dropSpot select 1) - (cos _planeDirection) * _planeStartDistance, (_flyHeight+200)];

diag_log format ["Airstrikes - Airplane Spawned at %1", _spos];
_plane = createVehicle [_planetype, _spos, [], 0, "FLY"];
_plane allowDamage true;
_plane setVariable ["R3F_LOG_disabled", true, true];
[_plane] call vehicleSetup;

_crew = [_grp, _spos] call createRandomSoldierC;
_crew moveInDriver _plane;
_crew allowDamage true;

_plane setCaptive true;

_planeDistance = 5000;
_dir = ((_dropSpot select 0) - (_spos select 0)) atan2 ((_dropSpot select 1) - (_spos select 1));
_flySpot = [(_dropSpot select 0) + (sin _dir) * _planeDistance, (_dropSpot select 1) + (cos _dir) * _planeDistance, _flyHeight];

_grp setCombatMode "BLUE";
_grp setBehaviour "CARELESS";

{_x disableAI "AUTOTARGET"; _x disableAI "TARGET";} forEach units _grp;

_wp0 = _grp addWaypoint [_dropSpot, 0, 1];
[_grp,1] setWaypointBehaviour "CARELESS";
[_grp,1] setWaypointCombatMode "BLUE";
[_grp,1] setWaypointCompletionRadius 20;
_wp1 = _grp addWaypoint [_flySpot, 0, 2];
[_grp,2] setWaypointBehaviour "CARELESS";
[_grp,2] setWaypointCombatMode "BLUE";
[_grp,2] setWaypointCompletionRadius 20;
_plane flyInHeight _flyHeight;

//////// Create Purchased Object //////////////////////////////////////////////
/*_object = switch (_type) do {
	case "vehicle":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle [_selectionClass, _objectSpawnPos, [], 0, "None"];
		diag_log format ["Apoc's Airdrop Assistance - Object Spawned at %1", position _object];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["A3W_purchasedVehicle", true, true];
		_object setVariable ["ownerUID", getPlayerUID _player, true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		[_object, false] call vehicleSetup;
		if (_object getVariable ["A3W_purchasedVehicle", false] && !isNil "fn_manualVehicleSave") then
		{
			_object call fn_manualVehicleSave;
		};
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
	};
	case "supply":
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		[_object, _selectionClass] call fn_refillbox;
		_object setVariable ["A3W_inventoryLockR3F", false, true];
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
	};
	case "picnic":  //Beware of Bears!
	{
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
		diag_log format ["Apoc's Airdrop Assistance - Object Spawned at %1", position _object];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
	};
	default {
		_objectSpawnPos = [(_spos select 0), (_spos select 1), (_spos select 2) - 5];
		_object = createVehicle ["B_supplyCrate_F", _objectSpawnPos, [], 0, "None"];
		_object setVariable ["A3W_purchasedStoreObject", true];
		_object setVariable ["R3F_LOG_Disabled", false, true];
		[_object, "mission_USSpecial"] call fn_refillbox;
		_object setVariable ["A3W_inventoryLockR3F", false, true];
		_object attachTo [_heli, [0,0,-5]]; //Attach Object to the heli
		_object
		};
};*/
//_object allowDamage false; //Let's not let these things get destroyed on the way there, shall we?

//diag_log format ["Airstrikes - Object at %1", position _object];  //A little log love to confirm the location of this new creature

//Wait until the plane completes the drop waypoint, then move on to dropping the cargo and all of that jazz

While {true} do {
	sleep 0.1;
	if (currentWaypoint _grp >= 2) exitWith {};  //Completed Strike Waypoint
};
// Let's handle the money after this tricky spot - This way players won't be charged for non-delivered goods!
_playerMoney = _player getVariable ["bmoney", 0];
		if (_price > _playerMoney) exitWith{
			{ _x setDamage 1; } forEach units _grp;
			_plane setDamage 1;
			diag_log format [" Airstrikes - Player Account Too Low, Drop Aborted. %1. Bank:$%2. Cost: $%3", _player, _playerMoney, _price];
			};  //Thought you'd be tricky and not pay, eh?

//Server Style Money handling
_balance = _player getVariable ["bmoney", 0];
_newBalance = _balance - _price;
_player setVariable ["bmoney", _newBalance, true];
[getPlayerUID _player, [["BankMoney", _newBalance]], []] call fn_saveAccount;

//  Now on to the fun stuff:

diag_log format ["Airstrikes - Plane at %1", _position];  //A little log love to confirm the location of this new creature
if (alive _plane) then	//in case the plane gets shot down
{
	_plane fire "CMFlareLauncher";
	_plane fire "CMFlareLauncher";
	for "_i" from 1 to _amount do
	{
		_shell = _selectionClass createvehicle [(_position select 0), (_position select 1), (_position select 2) + 200];
		_shell setVectorDirandUp [[0,0,-1],[0.1,0.1,1]];
		_shell setvelocity[random 50 - 25, random 50 - 25, -100];
		sleep 0.5;
	};


//Delete plane once it has proceeded to end point
	[_plane,_grp,_flySpot,_dropSpot,_planeDistance] spawn {
		private ["_plane","_grp","_flySpot","_dropSpot","_planeDistance"];
		_plane = _this select 0;
		_grp = _this select 1;
		_flySpot = _this select 2;
		_dropSpot = _this select 3;
		_planeDistance = _this select 4;
		while{([_plane, _flySpot] call BIS_fnc_distance2D)>200}do{
			if(!alive _plane || !canMove _plane)exitWith{};
			sleep 5;
		};
		waitUntil{([_plane, _dropSpot] call BIS_fnc_distance2D)>(_planeDistance * .5)};
		{ deleteVehicle _x; } forEach units _grp;
		deleteVehicle _plane;
	};

//Time based deletion of the plane, in case it gets distracted
	[_plane,_grp] spawn {
		private ["_plane","_grp"];
		_plane = _this select 0;
		_grp = _this select 1;
		sleep 30;
		if (alive _plane) then
		{
			{ deleteVehicle _x; } forEach units _grp;
			deleteVehicle _plane;
			diag_log "Airstrikes - Deleted Plane";
		};
	};
};