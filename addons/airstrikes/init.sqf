//Init for Airstrikes
//Author: NIMDA

#include "config.sqf"

if (isServer) then 
{
	Airstrikes_srv_start 	= compile preprocessFileLineNumbers "addons\airstrikes\airstrikes_srv_start.sqf"; 
};