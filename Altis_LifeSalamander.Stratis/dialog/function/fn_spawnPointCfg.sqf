/*
	File: fn_spawnPointCfg.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master configuration for available spawn points depending on the units side.
	
	Return:
	[Spawn Marker,Spawn Name,Image Path]
*/
private["_side","_return"];
_side = [_this,0,civilian,[civilian]] call BIS_fnc_param;

//Spawn Marker, Spawn Name, PathToImage
switch (_side) do {
	case west: 
	{
	_return = [
			["cop_spawn_1","Agia Maria HQ","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
		];
	};
	
	case civilian: 
	{
	    //if have reb license, only spawn here
		if(license_civ_rebel && playerSide == civilian) then {
		_return = [
			        ["reb_spawn","Camp Rebelle","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
		        ];
		};
		//if no rebel license, than can spawn normal loc
		
		if(!license_civ_rebel && playerSide == civilian) then {
		_return = [
					["civ_spawn_1","Agia Marina","\a3\ui_f\data\map\MapControl\watertower_ca.paa"],
                                        ["civ_spawn_2","Girna","\a3\ui_f\data\map\MapControl\watertower_ca.paa"]
				];
		};
		
	};
	
	case independent: 
	{
		_return = [
			["medic_spawn_1","Agia Marina Hopital","\a3\ui_f\data\map\MapControl\hospital_ca.paa"]
		];
	};
};

if(count life_houses > 0) then {
	{
		_pos = call compile format["%1",_x select 0];
		_house = nearestBuilding _pos;
		_houseName = getText(configFile >> "CfgVehicles" >> (typeOf _house) >> "displayName");
		
		_return set[count _return,[format["house_%1",_house getVariable "uid"],_houseName,"\a3\ui_f\data\map\MapControl\lighthouse_ca.paa"]];
	} foreach life_houses;
};

_return;