//Client Menu Building for Airstrikes
//Builds client commanding menus dynamically based on config file arrays
//Author: NIMDA

AirstrikesMenu = 
[
	["Airstrikes",true],
			["Artillery", [2], "#USER:Airstrikes_ArtilleryMenu", -5, [["expression", ""]], "1", "1"],
			["Missile", [3], "#USER:Airstrikes_MissilesMenu", -5, [["expression", ""]], "1", "1"],
			["Bomb", [4], "#USER:Airstrikes_BombsMenu", -5, [["expression", ""]], "1", "1"],
			["Cancel Airstrikes", [5], "", -3, [["expression", ""]], "1", "1"]
];
//////////////////////////////////////////////////////
//Setting up the Artillery Menu //////////////////////
//////////////////////////////////////////////////////
Airstrikes_ArtilleryMenu = [];
_startArtMenu = ["Artillery",true];
Airstrikes_ArtilleryMenu pushback _startArtMenu;

_i=0;
{
_optionArtMenu = [];
_lineElement1=format ["%1 ($%2)",(Airstrikes_Artillery select _i) select 0, (Airstrikes_Artillery select _i) select 2];
_amount = (Airstrikes_Artillery select _i) select 3;
_artyType = (Airstrikes_Artillery select _i) select 4;
_optionArtMenu pushback _lineElement1;

_optionArtMenu append [[_i+2], "", -5];

_optionArtMenu pushback [["expression", format ['["%1",%2,"%3",player] execVM "addons\airstrikes\airstrikes_cli_start.sqf"',_amount,_i,_artyType]]];

_optionArtMenu append ["1","1"];
Airstrikes_ArtilleryMenu pushback _optionArtMenu;
//diag_log format["Here's the menu structure: %1",Airstrikes_ArtilleryMenu];
_i=_i+1;
}forEach Airstrikes_Artillery;

_endArtMenu = ["Back", [_i+2], "", -3, [["expression", ""]], "1", "1"];
Airstrikes_Artillery pushback _endArtMenu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Missiles Menu ///////////////////////
//////////////////////////////////////////////////////
Airstrikes_MissilesMenu = [];
_startMisMenu = ["Missiles",true];
Airstrikes_MissilesMenu pushback _startMisMenu;

_i=0;
{
_optionMisMenu = [];
_lineElement1=format ["%1 ($%2)",(Airstrikes_Missiles select _i) select 0, (Airstrikes_Missiles select _i) select 2];
_amount = (Airstrikes_Missiles select _i) select 3;
_artyType = (Airstrikes_Missiles select _i) select 4;
_optionMisMenu pushback _lineElement1;

_optionMisMenu append [[_i+2], "", -5];

_optionMisMenu pushback [["expression", format ['["%1",%2,"%3",player] execVM "addons\airstrikes\airstrikes_cli_start.sqf"',_amount,_i, _artyType]]];

_optionMisMenu append ["1","1"];

Airstrikes_MissilesMenu pushback _optionMisMenu;
//diag_log format["Here's the menu structure: %1",Airstrikes_MissilesMenu];
_i=_i+1;
}forEach Airstrikes_Missiles;

_endMisMenu = ["Back", [_i+2], "", -3, [["expression", ""]], "1", "1"];
Airstrikes_MissilesMenu pushback _endMisMenu;
///////////////////////////////////////////////////////

//////////////////////////////////////////////////////
//Setting up the Bombs Menu //////////////////////////
//////////////////////////////////////////////////////
Airstrikes_BombsMenu = [];
_startBomMenu = ["Bombs",true];
Airstrikes_BombsMenu pushback _startBomMenu;

_i=0;
{
_optionBomMenu = [];
_lineElement1=format ["%1 ($%2)",(Airstrikes_Bombs select _i) select 0, (Airstrikes_Bombs select _i) select 2];
_amount = (Airstrikes_Bombs select _i) select 3;
_artyType = (Airstrikes_Bombs select _i) select 4;
_optionBomMenu pushback _lineElement1;

_optionBomMenu append [[_i+2], "", -5];

_optionBomMenu pushback [["expression", format ['["%1",%2,"%3",player] execVM "addons\airstrikes\airstrikes_cli_start.sqf"',_amount,_i,_artyType]]];

_optionBomMenu append ["1","1"];

Airstrikes_BombsMenu pushback _optionBomMenu;
//diag_log format["Here's the menu structure: %1",Airstrikes_BombsMenu];
_i=_i+1;
}forEach Airstrikes_Bombs;

_endBomMenu = ["Back", [_i+2], "", -3, [["expression", ""]], "1", "1"];
Airstrikes_BombsMenu pushback _endBomMenu;
///////////////////////////////////////////////////////

showCommandingMenu "#USER:AirstrikesMenu";