//Configuration for Airstrikes
//Author: NIMDA

//Airstrikes_coolDownTime = 1;	//debug cooldown time
Airstrikes_coolDownTime = 300; //Expressed in sec. 300 = 5 minutes

Airstrikes_Artillery = 
[//["Menu Name",		"Class_Name",				Cost,		DropAmount,	"type"]
["155MM HE SHELLS",		"Sh_155mm_AMOS",			25000,		10,			"artillery"],
["WHITE SMOKE",			"Smoke_120mm_AMOS_White",	5000,		30,			"artillery"],
["MINE CLUSTER",		"Mine_155mm_AMOS_range",	25000,		10,			"artillery"],
["AT MINE CLUSTER",		"AT_Mine_155mm_AMOS_range",	25000,		10,			"artillery"],
["HE SHELL CLUSTER",	"Cluster_155mm_AMOS",		40000,		10,			"artillery"]
];

Airstrikes_Missiles =
[//["Menu Name",		"Class_Name",				Cost, 		DropAmount,	"type"]
["230MM TITAN MISSILE",	"R_230mm_HE",				50000,		1,			"missiles"],
["SKALPEL ATGM",		"M_Scalpel_AT",				10000,		3,			"missiles"]
];

Airstrikes_Bombs =
[//["Menu Name",		"Class_Name",				Cost, 		DropAmount,	"type"]
["GBU-12",				"Bo_GBU12_LGB",				50000,		2,			"bombs"],
["MK82",				"Bo_Mk82",					50000,		2,			"bombs"],
["LOM-250G",			"Bomb_03_F",				50000,		2,			"bombs"]
];