// ******************************************************************************************
// *This project is licensed under the GNU Affero GPL v3. Copyright © 2015 Poisonous Shadows*
// ******************************************************************************************
//  @file Name: hud.hpp
//  @file Author: NIMDA

class RscProgress 
{ 
    type = 8; 
    style = 0; 
    shadow = 2; 
    colorFrame[] = {0,0,0,1}; 
    colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};  
    texture = "\A3\ui_f\data\GUI\RscCommon\RscProgress\progressbar_ca.paa";  
    w = 0.25; 
    h = 0.03; 
};     
class POWER_METER
{ 
    idd = 10000; 
    onload ="((_this select 0) displayCtrl 60009) progressSetPosition 1;uiNamespace setVariable [""POWERMETER"", _this select 0];_this ExecVM 'addons\nanosuit\powermeter.sqf';"; 
    duration = 10000000; 
    class Controls 
    { 
        class Progress: RscProgress  
            { 
                idc = 60009; 
                x = 0.849 * safezoneW + safezoneX; 
                y = 0.9350 * safezoneH + safezoneY; 
            }; 
    }; 
}; 