// Private Farm System
// Created by Lukman on 26 August 2021
#define MAX_PRIVATE_FARM (22)
#define MAX_PLANTS_STORAGE (5000)

enum pFarm {
  farmID,
  farmOwner,
  farmOwnerName[MAX_PLAYER_NAME],
  farmName[32],
  farmPrice,
  Float:farmPos[3],
  farmPlant[4],
  farmSeeds[4],
  farmLastVisited,
  farmMoney,
  farmSeal,
  farmPickup,
  Text3D:farmLabel
};
new FarmData[MAX_PRIVATE_FARM][pFarm],
    Iterator:Farms<MAX_PRIVATE_FARM>;

new pvFarmZone[MAX_PRIVATE_FARM];

// Private Farmer Zone
new Float:farmzone_0[] = {
	-283.0,-40.0,-263.0,28.0,-234.0,103.0,-175.0,85.0,-121.0,62.0,-146.0,-2.0,-179.0,-84.0,-206.0,-88.0,-245.0,-79.0,-274.0,-63.0,-283.0,-40.0
};

new Float:farmzone_1[] = {
	-119.0,93.0,-99.0,152.0,-183.0,180.0,-203.0,180.0,-219.0,143.0,-198.0,124.0,-119.0,93.0
};

new Float:farmzone_2[] = {
	-52.0,-109.0,23.0,-122.0,46.0,-116.0,57.0,-95.0,44.0,-64.0,23.0,-34.0,-11.0,4.0,-31.0,-36.0,-52.0,-109.0
};

new Float:farmzone_3[] = {
	6.0,36.0,18.0,68.0,34.0,63.0,80.0,26.0,72.0,-48.0,6.0,36.0
};

new Float:farmzone_4[] = {
	-342.0,-940.0,-296.0,-893.0,-230.0,-951.0,-278.0,-1002.0,-342.0,-940.0
};

new Float:farmzone_5[] = {
	-1001.0,-1063.0,-1002.0,-907.0,-1161.0,-906.0,-1200.0,-931.0,-1200.0,-1067.0,-1001.0,-1063.0
};

new Float:farmzone_6[] = {
	1911.0,189.0,1994.0,169.0,2003.0,171.0,2003.0,236.0,1916.0,247.0,1909.0,225.0,1911.0,189.0
}; //(AREA) farm6
new Float:farmzone_7[] = {
	-1071.0,-1238.0,-1073.0,-1204.0,-1081.0,-1203.0,-1087.0,-1195.0,-1089.0,-1180.0,-1091.0,-1170.0,-1101.0,-1155.0,-1153.0,-1157.0,-1152.0,-1215.0,-1122.0,-1215.0,
	-1121.0,-1238.0,-1071.0,-1238.0
}; //(AREA) farm7
new Float:farmzone_8[] = {
	-1092.0,-2492.0,-1068.0,-2455.0,-1023.0,-2451.0,-992.0,-2471.0,-971.0,-2484.0,-970.0,-2515.0,-976.0,-2541.0,-1005.0,-2575.0,-1048.0,-2587.0,-1073.0,-2587.0,
	-1099.0,-2524.0,-1092.0,-2492.0
}; //(AREA) farm_8
new Float:farmzone_9[] = {
	-713.0,-84.0,-704.0,-137.0,-810.0,-165.0,-819.0,-125.0,-713.0,-84.0
}; //(AREA) farmzone_9
new Float:farmzone_10[] = {
	272.0,1120.0,268.0,1163.0,217.0,1162.0,214.0,1118.0,272.0,1120.0
}; //(AREA) farmzone_10
new Float:farmzone_11[] = {
	-1237.0,-1469.0,-1207.0,-1458.0,-1180.0,-1462.0,-1148.0,-1458.0,-1159.0,-1364.0,-1180.0,-1362.0,-1201.0,-1364.0,-1214.0,-1360.0,-1249.0,-1368.0,-1249.0,-1441.0,
	-1237.0,-1469.0
}; //(AREA) farmzone_11
new Float:farmzone_12[] = {
	2532.0,-892.0,2564.0,-902.0,2593.0,-903.0,2616.0,-886.0,2614.0,-870.0,2612.0,-858.0,2527.0,-800.0,2474.0,-800.0,2452.0,-817.0,2422.0,-828.0,
	2406.0,-854.0,2438.0,-900.0,2532.0,-892.0
}; //(AREA) farmzone_12
new Float:farmzone_13[] = {
	283.0,1032.0,236.0,1033.0,236.0,1101.0,283.0,1101.0,283.0,1032.0
}; //(AREA) farmzone_13
new Float:farmzone_14[] = {
	486.0,1075.0,440.0,1070.0,439.0,1129.0,482.0,1128.0,486.0,1075.0
}; //(AREA) farmzone_14
new Float:farmzone_15[] = {
	-1080.0,-1640.0,-987.0,-1640.0,-967.0,-1618.0,-941.0,-1601.0,-928.0,-1585.0,-937.0,-1572.0,-1080.0,-1575.0,-1080.0,-1640.0
}; //(AREA) farmzone_15
new Float:farmzone_16[] = {
	-409.0,-1097.0,-464.0,-1098.0,-465.0,-1186.0,-403.0,-1184.0,-409.0,-1097.0
}; //(AREA) farmzone_16
new Float:farmzone_18[] = {
	-1032.0,-1171.0,-1032.0,-1068.0,-964.0,-1068.0,-963.0,-1171.0,-1032.0,-1171.0
}; //(AREA) farmzone_18
new Float:farmzone_19[] = {
	-1138.0,-1232.0,-1064.0,-1234.0,-1065.0,-1318.0,-1141.0,-1318.0,-1138.0,-1232.0
}; //(AREA) farmzone_19
new Float:farmzone_20[] = {
	-1025.0,-1318.0,-964.0,-1301.0,-963.0,-1213.0,-1010.0,-1212.0,-1025.0,-1318.0
}; //(AREA) farmzone_20
new Float:farmzone_21[] = {
	-905.0,-491.0,-927.0,-489.0,-947.0,-488.0,-966.0,-494.0,-972.0,-510.0,-972.0,-534.0,-964.0,-549.0,-939.0,-551.0,-915.0,-553.0,-908.0,-543.0,
	-905.0,-491.0
}; //(AREA) farmzone_21

#include <YSI\y_hooks>
hook OnGameModeInitEx() {
  mysql_tquery(g_iHandle, "SELECT * FROM `farms`", "Farm_Load", "");
  pvFarmZone[0] = CreateDynamicPolygon(farmzone_0, _, _, _, 0, 0);
  pvFarmZone[1] = CreateDynamicPolygon(farmzone_1, _, _, _, 0, 0);
  pvFarmZone[2] = CreateDynamicPolygon(farmzone_2, _, _, _, 0, 0);
  pvFarmZone[3] = CreateDynamicPolygon(farmzone_3, _, _, _, 0, 0);
  pvFarmZone[4] = CreateDynamicPolygon(farmzone_4, _, _, _, 0, 0);
  pvFarmZone[5] = CreateDynamicPolygon(farmzone_5, _, _, _, 0, 0);
  pvFarmZone[6] = CreateDynamicPolygon(farmzone_6, _, _, _, 0, 0);
  pvFarmZone[7] = CreateDynamicPolygon(farmzone_7, _, _, _, 0, 0);
  pvFarmZone[8] = CreateDynamicPolygon(farmzone_8, _, _, _, 0, 0);
  pvFarmZone[9] = CreateDynamicPolygon(farmzone_9, _, _, _, 0, 0);
  pvFarmZone[10] = CreateDynamicPolygon(farmzone_10, _, _, _, 0, 0);
  pvFarmZone[11] = CreateDynamicPolygon(farmzone_11, _, _, _, 0, 0);
  pvFarmZone[12] = CreateDynamicPolygon(farmzone_12, _, _, _, 0, 0);
  pvFarmZone[13] = CreateDynamicPolygon(farmzone_13, _, _, _, 0, 0);
  pvFarmZone[14] = CreateDynamicPolygon(farmzone_14, _, _, _, 0, 0);
  pvFarmZone[15] = CreateDynamicPolygon(farmzone_15, _, _, _, 0, 0);
  pvFarmZone[16] = CreateDynamicPolygon(farmzone_16, _, _, _, 0, 0);
  pvFarmZone[17] = CreateDynamicCircle(1464.0, -76.0, 66.0, 0, 0);
  pvFarmZone[18] = CreateDynamicPolygon(farmzone_18, _, _, _, 0, 0);
  pvFarmZone[19] = CreateDynamicPolygon(farmzone_19, _, _, _, 0, 0);
  pvFarmZone[20] = CreateDynamicPolygon(farmzone_20, _, _, _, 0, 0);
  pvFarmZone[21] = CreateDynamicPolygon(farmzone_21, _, _, _, 0, 0);

  return 1;
}


hook OnGameModeExit() {
  foreach (new i : Farms) {
    Farm_Save(i);
  }
  return 1;
}

Function:Farm_Load() {
  new rows = cache_num_rows();

  for (new i = 0; i < rows; i ++) {
    cache_get_value_int(i, "ID", FarmData[i][farmID]);
    cache_get_value_int(i, "Owner", FarmData[i][farmOwner]);
    cache_get_value(i, "OwnerName", FarmData[i][farmOwnerName], MAX_PLAYER_NAME);
    cache_get_value(i, "Name", FarmData[i][farmName], 32);
    cache_get_value_int(i, "Price", FarmData[i][farmPrice]);
    cache_get_value_int(i, "LastVisited", FarmData[i][farmLastVisited]);
    cache_get_value_int(i, "Seal", FarmData[i][farmSeal]);

    cache_get_value_float(i, "Pos0", FarmData[i][farmPos][0]);
    cache_get_value_float(i, "Pos1", FarmData[i][farmPos][1]);
    cache_get_value_float(i, "Pos2", FarmData[i][farmPos][2]);
    
    cache_get_value_int(i, "Plant0", FarmData[i][farmPlant][0]);
    cache_get_value_int(i, "Plant1", FarmData[i][farmPlant][1]);
    cache_get_value_int(i, "Plant2", FarmData[i][farmPlant][2]);
    cache_get_value_int(i, "Plant3", FarmData[i][farmPlant][3]);
    
    cache_get_value_int(i, "Seed0", FarmData[i][farmSeeds][0]);
    cache_get_value_int(i, "Seed1", FarmData[i][farmSeeds][1]);
    cache_get_value_int(i, "Seed2", FarmData[i][farmSeeds][2]);
    cache_get_value_int(i, "Seed3", FarmData[i][farmSeeds][3]);

    cache_get_value_int(i, "Money", FarmData[i][farmMoney]);

    Iter_Add(Farms, i);
    Farm_Refresh(i);
  }
  printf("*** [R:RP Database: Loaded] private farm data loaded (%d count)", rows);
  return 1;
}

Function:OnFarmCreated(farmid) {
  if (!Iter_Contains(Farms, farmid))
    return 0;

  FarmData[farmid][farmID] = cache_insert_id();
  Farm_Save(farmid);
  return 1;
}

Farm_Save(id) {
  if (Iter_Contains(Farms, id)) {
    new query[1500];
    format(query,sizeof(query),"UPDATE `farms` SET `Owner`='%d', `Name`='%s', `OwnerName`='%s', `Price`='%d', `LastVisited`='%d', `Seal`='%d', `Pos0`='%.2f', `Pos1`='%.2f', `Pos2`='%.2f', `Plant0`='%d', `Plant1`='%d', `Plant2`='%d', `Plant3`='%d', `Seed0`='%d', `Seed1`='%d', `Seed2`='%d', `Seed3`='%d', `Money`='%d' WHERE `ID`='%d'",
    FarmData[id][farmOwner],
    SQL_ReturnEscaped(FarmData[id][farmName]),
    SQL_ReturnEscaped(FarmData[id][farmOwnerName]),
    FarmData[id][farmPrice],
    FarmData[id][farmLastVisited],
    FarmData[id][farmSeal],
    FarmData[id][farmPos][0],
    FarmData[id][farmPos][1],
    FarmData[id][farmPos][2],
    FarmData[id][farmPlant][0],
    FarmData[id][farmPlant][1],
    FarmData[id][farmPlant][2],
    FarmData[id][farmPlant][3],
    FarmData[id][farmSeeds][0],
    FarmData[id][farmSeeds][1],
    FarmData[id][farmSeeds][2],
    FarmData[id][farmSeeds][3],
    FarmData[id][farmMoney],
    FarmData[id][farmID]
    );
    return mysql_tquery(g_iHandle, query);
  }
  return 1;
}

Farm_Delete(id) {
  if (IsValidDynamicPickup(FarmData[id][farmPickup]))
    DestroyDynamicPickup(FarmData[id][farmPickup]);

  if (IsValidDynamic3DTextLabel(FarmData[id][farmLabel]))
    DestroyDynamic3DTextLabel(FarmData[id][farmLabel]);

  mysql_tquery(g_iHandle, sprintf("DELETE FROM `farms` WHERE `ID` = '%d'", FarmData[id][farmID]));
  FarmData[id][farmPickup] = INVALID_STREAMER_ID;
  FarmData[id][farmLabel] = Text3D:INVALID_3DTEXT_ID;
  FarmData[id][farmMoney] = 0;
  FarmData[id][farmID] = 0;
  Iter_Remove(Farms, id);
  return 1;
}

Farm_Create(price, Float:x, Float:y, Float:z) {
  new slot = cellmin;
  if ((slot = Iter_Free(Farms)) != cellmin) {
    FarmData[slot][farmOwner] = 0;
    format(FarmData[slot][farmOwnerName], MAX_PLAYER_NAME, "None");
    format(FarmData[slot][farmName], 32, "Private Farm");
    FarmData[slot][farmPrice] = price;
    FarmData[slot][farmPos][0] = x;
    FarmData[slot][farmPos][1] = y;
    FarmData[slot][farmPos][2] = z;
    FarmData[slot][farmPlant][0] = 0;
    FarmData[slot][farmPlant][1] = 0;
    FarmData[slot][farmPlant][2] = 0;
    FarmData[slot][farmPlant][3] = 0;
    FarmData[slot][farmSeeds][0] = 0;
    FarmData[slot][farmSeeds][1] = 0;
    FarmData[slot][farmSeeds][2] = 0;
    FarmData[slot][farmSeeds][3] = 0;
    FarmData[slot][farmMoney] = 0;
    Farm_RemoveAllEmployees(slot);

    Iter_Add(Farms, slot);
    Farm_Refresh(slot);

    mysql_tquery(g_iHandle, sprintf("INSERT INTO `farms` (`Owner`) VALUES ('%d')", FarmData[slot][farmOwner]), "OnFarmCreated", "d", slot);

    return slot;
  }
  return cellmin;
}

Farm_Refresh(id) {
  new label[512];
  if (IsValidDynamicPickup(FarmData[id][farmPickup]))
    DestroyDynamicPickup(FarmData[id][farmPickup]);

  if (IsValidDynamic3DTextLabel(FarmData[id][farmLabel]))
    DestroyDynamic3DTextLabel(FarmData[id][farmLabel]);

  FarmData[id][farmPickup] = CreateDynamicPickup(1239, 23, FarmData[id][farmPos][0], FarmData[id][farmPos][1], FarmData[id][farmPos][2], 0, 0, -1, 10);

  if (FarmData[id][farmOwner] > 0) {
    if (FarmData[id][farmSeal]) {
      format(label, sizeof(label), "[PF:%d]\n"GREEN"%s\n"YELLOW"Owner: "WHITE"%s\nThis farm is sealed by "RED"authority", id, FarmData[id][farmName], FarmData[id][farmOwnerName]);
    } else {
      format(label, sizeof(label), "[PF:%d]\n"GREEN"%s\n"YELLOW"Owner: "WHITE"%s", id, FarmData[id][farmName], FarmData[id][farmOwnerName]);
    }
  } else {
    format(label, sizeof(label), "[PF:%d]\n"GREEN"This farm is for sale\n"YELLOW"Price: "GREEN"%s\n"GREY"Type /buy to purchase it", id, FormatNumber(FarmData[id][farmPrice]));
  }

  FarmData[id][farmLabel] = CreateDynamic3DTextLabel(label, COLOR_CLIENT, FarmData[id][farmPos][0], FarmData[id][farmPos][1], FarmData[id][farmPos][2]+0.5, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
  return 1;
}

Farm_Nearest(playerid, Float:range = 3.0) {
	foreach(new id : Farms) if(Iter_Contains(Farms, id) && IsPlayerInRangeOfPoint(playerid, range, FarmData[id][farmPos][0], FarmData[id][farmPos][1], FarmData[id][farmPos][2])) {
		return id;
	}
	return -1;
}

Farm_GetCount(playerid) {
  new count = 0;
  foreach (new id : Farms) if (FarmData[id][farmOwner] == PlayerData[playerid][pID]) {
    count++;
  }
  return count;
}

Farm_GetID(playerid) {
  foreach (new i : Farms) if (Iter_Contains(Farms, i) && (Farm_IsOwner(playerid, i) || Farm_IsEmployee(playerid, i))) {
    return i;
  }

  return -1;
}

Farm_IsOwner(playerid, farmid) {
  if (Iter_Contains(Farms, farmid) && FarmData[farmid][farmOwner] == PlayerData[playerid][pID])
    return 1;

  return 0;
}

Farm_IsEmployee(playerid, farmid) {
	new str[128], Cache: cache;
	format(str, sizeof(str), "SELECT * FROM `farm_employe` WHERE `Name`='%s' AND `Farm`='%d'", NormalName(playerid), FarmData[farmid][farmID]);
	cache = mysql_query(g_iHandle, str);
	new result = cache_num_rows();
	cache_delete(cache);
	return result;
}

Farm_AddEmployee(playerid, farmid) {
	new str[128];
	format(str, sizeof(str), "INSERT INTO `farm_employe` SET `Name`='%s', `Farm`='%d', `Time`=UNIX_TIMESTAMP()", NormalName(playerid), FarmData[farmid][farmID]);
	mysql_tquery(g_iHandle, str);
	return 1;
}

Farm_RemoveEmployee(id)
{
	new query[200];
	format(query,sizeof(query),"DELETE FROM `farm_employe` WHERE `ID`='%d'", id);
	mysql_tquery(g_iHandle, query);
	return 1;
}

Farm_RemoveAllEmployees(id)
{
	new query[200];
	format(query,sizeof(query),"DELETE FROM `farm_employe` WHERE `Farm`='%d'", FarmData[id][farmID]);
	mysql_tquery(g_iHandle, query);
	return 1;
}

Farm_EmployeeCount(farmid)
{
	new query[144], Cache: check, count;
	mysql_format(g_iHandle, query, sizeof(query), "SELECT * FROM `farm_employe` WHERE `Farm` = '%d'", FarmData[farmid][farmID]);
	check = mysql_query(g_iHandle, query);
	new result = cache_num_rows();
	if(result) {
		for(new i; i != result; i++) {
			count++;
		}
	}
	cache_delete(check);
	return count;
}

Farm_ShowEmployees(playerid, id, type = 0)
{
	new query[255], Cache: cache;
	format(query, sizeof(query), "SELECT * FROM `farm_employe` WHERE `Farm`='%d'", FarmData[id][farmID]);
	cache = mysql_query(g_iHandle, query);

	if(!cache_num_rows()) return SendErrorMessage(playerid, "There are no one employee for this farm.");
	
	format(query, sizeof(query), "#\tName\tDate Added\n");
	for(new i; i < cache_num_rows(); i++) {
		new
      farm,
      time,
      name[24];

        cache_get_value_int(i, "ID", farm);
        cache_get_value_int(i, "Time", time);
        cache_get_value(i, "Name", name, sizeof(name));
        format(query, sizeof(query), "%s%d\t%s\t%s\n", query, farm, name, ConvertTimestamp(Time:time));
	}
	if (!type)
		Dialog_Show(playerid, ShowOnly, DIALOG_STYLE_TABLIST_HEADERS, "Farm Employees", query, "Close", "");
	else
		Dialog_Show(playerid, FarmRemoveEmployee, DIALOG_STYLE_TABLIST_HEADERS, "Remove Employees", query, "Remove", "Close");

	cache_delete(cache);
	return 1;
}

Plant_GetName(index) {
  static
    name[24];

  switch (index) {
    case 0: format(name,sizeof(name),"Pumpkin");
    case 1: format(name,sizeof(name),"Mushroom");
    case 2: format(name,sizeof(name),"Cucumber");
    case 3: format(name,sizeof(name),"Egg Plant");
  }

  return name;
}

Seed_GetName(index) {
  static
    name[24];

  switch (index) {
    case 0: format(name,sizeof(name),"Pumpkin Seeds");
    case 1: format(name,sizeof(name),"Mushroom Seeds");
    case 2: format(name,sizeof(name),"Cucumber Seeds");
    case 3: format(name,sizeof(name),"Egg Plant Seeds");
  }

  return name;
}

SSCANF:FarmMenu(string[]) {
  if (!strcmp(string, "create", true)) return 1;
  else if (!strcmp(string, "delete", true)) return 2;
  else if (!strcmp(string, "price", true)) return 3;
  else if (!strcmp(string, "sell", true)) return 4;
  else if (!strcmp(string, "location", true)) return 5;
  else if (!strcmp(string, "goto", true)) return 6;
  return 0;
}

CMD:farm(playerid, params[]) {
  if (CheckAdmin(playerid, 5))
    return PermissionError(playerid);

  new opt, value[64];
  if (sscanf(params, "k<FarmMenu>S()[64]", opt, value))
    return SendSyntaxMessage(playerid, "/farm [create/delete/price/sell/location/goto]");

  switch (opt) {
    case 1: {
      new farmid = cellmin, Float:x, Float:y, Float:z, price;

      if (sscanf(value, "d", price))
        return SendSyntaxMessage(playerid, "/farm create [price]");
      
      GetPlayerPos(playerid, x, y, z);
      farmid = Farm_Create(price, x, y, z);

      if (farmid == cellmin)
        return SendErrorMessage(playerid, "The server has reached maximum of Private Farm");

      SendCustomMessage(playerid, "FARM", "You've been successfully created private farm id: "YELLOW"%d", farmid);
    }
    case 2: {
      new farmid;

      if (sscanf(value, "d", farmid))
        return SendSyntaxMessage(playerid, "/farm delete [farm id]");

      if (!Iter_Contains(Farms, farmid))
        return SendErrorMessage(playerid, "Invalid private farm ID!");

      Farm_Delete(farmid);
      SendCustomMessage(playerid, "FARM", "You've been deleted private farm id: "YELLOW"%d", farmid);
    }
    case 3: {
      new farmid, newprice;

      if (sscanf(value, "dd", farmid, newprice))
        return SendSyntaxMessage(playerid, "/farm price [farm id] [new price]");

      if (!Iter_Contains(Farms, farmid))
        return SendErrorMessage(playerid, "Invalid private farm ID!");

      FarmData[farmid][farmPrice] = newprice;
      Farm_Refresh(farmid);
      Farm_Save(farmid);

      SendCustomMessage(playerid, "FARM", "You've been changed the price of private farm id: "YELLOW"%d "WHITE"to "GREEN"%s", farmid, FormatNumber(newprice));
    }
    case 4: {
      new farmid;

      if (sscanf(value, "d", farmid))
        return SendSyntaxMessage(playerid, "/farm sell [farm id]");

      if (!Iter_Contains(Farms, farmid))
        return SendErrorMessage(playerid, "Invalid private farm ID!");

      FarmData[farmid][farmOwner] = 0;
      format(FarmData[farmid][farmOwnerName], MAX_PLAYER_NAME, "None");
      format(FarmData[farmid][farmName], 32, "Private Farm");
      FarmData[farmid][farmPlant][0] = 0;
      FarmData[farmid][farmPlant][1] = 0;
      FarmData[farmid][farmPlant][2] = 0;
      FarmData[farmid][farmPlant][3] = 0;
      FarmData[farmid][farmSeeds][0] = 0;
      FarmData[farmid][farmSeeds][1] = 0;
      FarmData[farmid][farmSeeds][2] = 0;
      FarmData[farmid][farmSeeds][3] = 0;

      Farm_RemoveAllEmployees(farmid);

      Farm_Refresh(farmid);
      Farm_Save(farmid);

      SendCustomMessage(playerid, "FARM", "You've been sold the private farm id: "YELLOW"%d", farmid);
    }
    case 5: {
      new farmid;

      if (sscanf(value, "d", farmid))
        return SendSyntaxMessage(playerid, "/farm location [farm id]");

      if (!Iter_Contains(Farms, farmid))
        return SendErrorMessage(playerid, "Invalid private farm ID!");

      new Float:x, Float:y, Float:z;
      GetPlayerPos(playerid, x, y, z);
      FarmData[farmid][farmPos][0] = x;
      FarmData[farmid][farmPos][1] = y;
      FarmData[farmid][farmPos][2] = z;
      Farm_Refresh(farmid);
      Farm_Save(farmid);
      SendCustomMessage(playerid, "FARM", "You've been changed location of farm id: "YELLOW"%d", farmid);
    }
    case 6: {
      new farmid;

      if (sscanf(value, "d", farmid))
        return SendSyntaxMessage(playerid, "/farm goto [farm id]");

      if (!Iter_Contains(Farms, farmid))
        return SendErrorMessage(playerid, "Invalid private farm ID!");

      SetPlayerPos(playerid, FarmData[farmid][farmPos][0],FarmData[farmid][farmPos][1],FarmData[farmid][farmPos][2]);
      SetPlayerVirtualWorld(playerid, 0);
      SetPlayerInterior(playerid, 0);
      SendCustomMessage(playerid, "FARM", "You've been teleported to farm id: "YELLOW"%d", farmid);
    }
    default: SendSyntaxMessage(playerid, "/farm [create/delete/price/sell/location/goto]");
  }
  return 1;
}

CMD:farmmenu(playerid) {
  new id = -1;
  if ((id = Farm_Nearest(playerid)) != -1) {
    if (!Farm_IsOwner(playerid, id) && !Farm_IsEmployee(playerid, id))
      return SendErrorMessage(playerid, "This is not your farm or you're not employee members of this farm!");

    if (FarmData[id][farmSeal])
      return SendErrorMessage(playerid, "This farm is sealed by authority.");

    if (Farm_IsOwner(playerid, id)) Dialog_Show(playerid, FarmMenu, DIALOG_STYLE_LIST, sprintf("%s", FarmData[id][farmName]), "Plants\nSeeds\nGive\nEmployees\nChange Name\nVault", "Select", "Close"), SetPVarInt(playerid, "holdingFarmID", id);
    else Dialog_Show(playerid, FarmMenu, DIALOG_STYLE_LIST, sprintf("%s", FarmData[id][farmName]), "Plants\nSeeds\nVault", "Select", "Close"), SetPVarInt(playerid, "holdingFarmID", id);
  } else SendErrorMessage(playerid, "You're not nearest in any private farm or inside any private farm");
  return 1;
}
CMD:fm(playerid)
  return cmd_farmmenu(playerid);

Dialog:FarmMenu(playerid, response, listitem, inputtext[]) {
  if (response) {
    new id = GetPVarInt(playerid, "holdingFarmID");
    switch (listitem) {
      case 0: {
        new string[512];
        strcat(string, "Plant\tAmount\n");
        strcat(string, sprintf("Pumpkin\t%d gram(s)\n", FarmData[id][farmPlant][0]));
        strcat(string, sprintf("Mushroom\t%d gram(s)\n", FarmData[id][farmPlant][1]));
        strcat(string, sprintf("Cucumber\t%d gram(s)\n", FarmData[id][farmPlant][2]));
        strcat(string, sprintf("Egg Plant\t%d gram(s)", FarmData[id][farmPlant][3]));
        Dialog_Show(playerid, FarmPlant, DIALOG_STYLE_TABLIST_HEADERS, "Farm Plants", string, "Select", "Back");
      }
      case 1: {
        new string[512];
        strcat(string, "Seed\tAmount\n");
        strcat(string, sprintf("Pumpkin Seed\t%d gram(s)\n", FarmData[id][farmSeeds][0]));
        strcat(string, sprintf("Mushroom Seed\t%d gram(s)\n", FarmData[id][farmSeeds][1]));
        strcat(string, sprintf("Cucumber Seed\t%d gram(s)\n", FarmData[id][farmSeeds][2]));
        strcat(string, sprintf("Egg Plant Seed\t%d gram(s)", FarmData[id][farmSeeds][3]));
        Dialog_Show(playerid, FarmSeeds, DIALOG_STYLE_TABLIST_HEADERS, "Farm Seeds", string, "Select", "Back");
      }
      case 2: {
        if (Farm_IsOwner(playerid, id)) Dialog_Show(playerid, FarmGive, DIALOG_STYLE_INPUT, "Farm Transfer Ownership", "Please input the playerid or name to giving your private farm: "GREEN"(input below)", "Give", "Back");
        else Dialog_Show(playerid, FarmVault, DIALOG_STYLE_LIST, "Farm Vault", "Deposit", "Select", "Back");
      }
      case 3: {
        Dialog_Show(playerid, FarmShowEmployees, DIALOG_STYLE_LIST, "Employees Management", "Add Employee\nRemove Employee\nRemove All Employees\nEmployee Members", "Select", "Back");
      }
      case 4: {
        Dialog_Show(playerid, FarmChangeName, DIALOG_STYLE_INPUT, "Farm Change Name", "Please input the new your farmer name: "GREEN"(input below)", "Change", "Back");
      }
      case 5: {
        Dialog_Show(playerid, FarmVault, DIALOG_STYLE_LIST, "Farm Vault", "Deposit\nWithdraw", "Select", "Back");
      }
    }
  } else DeletePVar(playerid, "holdingFarmID");
  return 1;
}

Dialog:FarmPlant(playerid, response, listitem, inputtext[]) {
  if (!response)
    return cmd_farmmenu(playerid);

  SetPVarInt(playerid, "holdingPlantIndex", listitem);
  Dialog_Show(playerid, FarmPlantOption, DIALOG_STYLE_LIST, "Plant Option", "Store Plant\nTake Plant", "Select", "Close");
  return 1;
}

Dialog:FarmSeeds(playerid, response, listitem, inputtext[]) {
  if (!response)
    return cmd_farmmenu(playerid);

  SetPVarInt(playerid, "holdingSeedIndex", listitem);
  Dialog_Show(playerid, FarmSeedsOption, DIALOG_STYLE_LIST, "Seed Option", "Store Seed\nTake Seed", "Select", "Close");
  return 1;
}

Dialog:FarmSeedsOption(playerid, response, listitem, inputtext[]) {
  if (!response) DeletePVar(playerid, "holdingFarmID"), DeletePVar(playerid, "holdingSeedIndex");
  else {
    new id = GetPVarInt(playerid, "holdingFarmID"), plantIndex = GetPVarInt(playerid, "holdingSeedIndex"), plantName[24];
    format(plantName,sizeof(plantName),"%s",Seed_GetName(plantIndex));
    switch (listitem) {
      case 0: {
        if (!Inventory_Count(playerid, plantName))
          return SendErrorMessage(playerid, "You don't have any %s", plantName);

        if (FarmData[id][farmSeeds][plantIndex] >= MAX_PLANTS_STORAGE)
          return SendErrorMessage(playerid, "This farm is already have a maximum of "YELLOW"%s"WHITE", the maximum seeds is "YELLOW"%d grams", plantName, MAX_PLANTS_STORAGE);

        Dialog_Show(playerid, StoreSeedFarm, DIALOG_STYLE_INPUT, "Store Seeds", "Please input the amount of %s wish you store on farm, you have %d gram(s) of %s: "GREEN"(input below)", "Store", "Close", plantName, Inventory_Count(playerid, plantName), plantName);
      }
      case 1: {
        if (!FarmData[id][farmSeeds][plantIndex])
          return SendErrorMessage(playerid, "Your farm doesn't have any %s", plantName);

        Dialog_Show(playerid, TakeSeedFarm, DIALOG_STYLE_INPUT, "Take Plant", "Please input the amount of %s wish you want to take, your farm have %d gram(s) of %s: "GREEN"(input below)", "Take", "Close", plantName, FarmData[id][farmSeeds][plantIndex], plantName);
      }
    }
  }
  return 1;
}

Dialog:StoreSeedFarm(playerid, response, listitem, inputtext[]) {
  if (!response) DeletePVar(playerid, "holdingFarmID"), DeletePVar(playerid, "holdingSeedIndex");
  else {
    new id = GetPVarInt(playerid, "holdingFarmID"), plantIndex = GetPVarInt(playerid, "holdingSeedIndex"), plantName[24];
    format(plantName,sizeof(plantName),"%s",Seed_GetName(plantIndex));

    if (isnull(inputtext))
      return Dialog_Show(playerid, StoreSeedFarm, DIALOG_STYLE_INPUT, "Store Seeds", "Please input the amount of %s wish you store on farm, you have %d gram(s) of %s: "GREEN"(input below)", "Store", "Close", plantName, Inventory_Count(playerid, plantName), plantName);

    new amount = strval(inputtext), plantCount = Inventory_Count(playerid, plantName);
    
    if (amount < 1 || amount > plantCount)
      return Dialog_Show(playerid, StoreSeedFarm, DIALOG_STYLE_INPUT, "Store Seeds", "Please input the amount of %s wish you store on farm, you have %d gram(s) of %s: "GREEN"(input below)", "Store", "Close", plantName, Inventory_Count(playerid, plantName), plantName), SendErrorMessage(playerid, "You don't have that much!");

    FarmData[id][farmSeeds][plantIndex] += amount;
    Inventory_Remove(playerid, plantName, amount);
    SendCustomMessage(playerid, "FARM", "You've been stored "YELLOW"%d gram(s) "WHITE"of "GREEN"%s "WHITE"to your farm storage", amount, plantName);
  }
  return 1;
}

Dialog:TakeSeedFarm(playerid, response, listitem, inputtext[]) {
  if (!response) DeletePVar(playerid, "holdingFarmID"), DeletePVar(playerid, "holdingSeedIndex");
  else {
    new id = GetPVarInt(playerid, "holdingFarmID"), plantIndex = GetPVarInt(playerid, "holdingSeedIndex"), plantName[24];
    format(plantName,sizeof(plantName),"%s",Seed_GetName(plantIndex));

    if (isnull(inputtext))
      return Dialog_Show(playerid, TakeSeedFarm, DIALOG_STYLE_INPUT, "Take Seeds", "Please input the amount of %s wish you want to take, your farm have %d gram(s) of %s: "GREEN"(input below)", "Take", "Close", plantName, FarmData[id][farmSeeds][plantIndex], plantName);

    new amount = strval(inputtext), plantCount = FarmData[id][farmSeeds][plantIndex];
    
    if (amount < 1 || amount > plantCount)
      return Dialog_Show(playerid, TakeSeedFarm, DIALOG_STYLE_INPUT, "Take Seeds", "Please input the amount of %s wish you want to take, your farm have %d gram(s) of %s: "GREEN"(input below)", "Take", "Close", plantName, FarmData[id][farmSeeds][plantIndex], plantName), SendErrorMessage(playerid, "Your farm don't have that much");

    new itemid = Inventory_Add(playerid, plantName, 19320, amount);

    if(itemid == -1)
        return SendErrorMessage(playerid, "You don't have any room in your inventory.");

    FarmData[id][farmSeeds][plantIndex] -= amount;

    SendCustomMessage(playerid, "FARM", "You've been taken "YELLOW"%d gram(s) "WHITE"of "GREEN"%s "WHITE"from your farm storage", amount, plantName);
  }
  return 1;
}

Dialog:FarmPlantOption(playerid, response, listitem, inputtext[]) {
  if (!response) DeletePVar(playerid, "holdingFarmID"), DeletePVar(playerid, "holdingPlantIndex");
  else {
    new id = GetPVarInt(playerid, "holdingFarmID"), plantIndex = GetPVarInt(playerid, "holdingPlantIndex"), plantName[24];
    format(plantName,sizeof(plantName),"%s",Plant_GetName(plantIndex));
    switch (listitem) {
      case 0: {
        if (!Inventory_Count(playerid, plantName))
          return SendErrorMessage(playerid, "You don't have any %s", plantName);

        if (FarmData[id][farmPlant][plantIndex] >= MAX_PLANTS_STORAGE)
          return SendErrorMessage(playerid, "This farm is already have a maximum of "YELLOW"%s"WHITE", the maximum plants is "YELLOW"%d grams", plantName, MAX_PLANTS_STORAGE);

        Dialog_Show(playerid, StorePlantFarm, DIALOG_STYLE_INPUT, "Store Plant", "Please input the amount of %s wish you store on farm, you have %d gram(s) of %s: "GREEN"(input below)", "Store", "Close", plantName, Inventory_Count(playerid, plantName), plantName);
      }
      case 1: {
        if (!FarmData[id][farmPlant][plantIndex])
          return SendErrorMessage(playerid, "Your farm doesn't have any %s", plantName);

        Dialog_Show(playerid, TakePlantFarm, DIALOG_STYLE_INPUT, "Take Plant", "Please input the amount of %s wish you want to take, your farm have %d gram(s) of %s: "GREEN"(input below)", "Take", "Close", plantName, FarmData[id][farmPlant][plantIndex], plantName);
      }
    }
  }
  return 1;
}

Dialog:StorePlantFarm(playerid, response, listitem, inputtext[]) {
  if (!response) DeletePVar(playerid, "holdingFarmID"), DeletePVar(playerid, "holdingPlantIndex");
  else {
    new id = GetPVarInt(playerid, "holdingFarmID"), plantIndex = GetPVarInt(playerid, "holdingPlantIndex"), plantName[24];
    format(plantName,sizeof(plantName),"%s",Plant_GetName(plantIndex));

    if (isnull(inputtext))
      return Dialog_Show(playerid, StorePlantFarm, DIALOG_STYLE_INPUT, "Store Plant", "Please input the amount of %s wish you store on farm, you have %d gram(s) of %s: "GREEN"(input below)", "Store", "Close", plantName, Inventory_Count(playerid, plantName), plantName);

    new amount = strval(inputtext), plantCount = Inventory_Count(playerid, plantName);
    
    if (amount < 1 || amount > plantCount)
      return Dialog_Show(playerid, StorePlantFarm, DIALOG_STYLE_INPUT, "Store Plant", "Please input the amount of %s wish you store on farm, you have %d gram(s) of %s: "GREEN"(input below)", "Store", "Close", plantName, Inventory_Count(playerid, plantName), plantName), SendErrorMessage(playerid, "You don't have that much!");

    FarmData[id][farmPlant][plantIndex] += amount;
    Inventory_Remove(playerid, plantName, amount);
    SendCustomMessage(playerid, "FARM", "You've been stored "YELLOW"%d gram(s) "WHITE"of "GREEN"%s "WHITE"to your farm storage", amount, plantName);
  }
  return 1;
}

Dialog:TakePlantFarm(playerid, response, listitem, inputtext[]) {
  if (!response) DeletePVar(playerid, "holdingFarmID"), DeletePVar(playerid, "holdingPlantIndex");
  else {
    new id = GetPVarInt(playerid, "holdingFarmID"), plantIndex = GetPVarInt(playerid, "holdingPlantIndex"), plantName[24];
    format(plantName,sizeof(plantName),"%s",Plant_GetName(plantIndex));

    if (isnull(inputtext))
      return Dialog_Show(playerid, TakePlantFarm, DIALOG_STYLE_INPUT, "Take Plant", "Please input the amount of %s wish you want to take, your farm have %d gram(s) of %s: "GREEN"(input below)", "Take", "Close", plantName, FarmData[id][farmPlant][plantIndex], plantName);

    new amount = strval(inputtext), plantCount = FarmData[id][farmPlant][plantIndex];
    
    if (amount < 1 || amount > plantCount)
      return Dialog_Show(playerid, TakePlantFarm, DIALOG_STYLE_INPUT, "Take Plant", "Please input the amount of %s wish you want to take, your farm have %d gram(s) of %s: "GREEN"(input below)", "Take", "Close", plantName, FarmData[id][farmPlant][plantIndex], plantName), SendErrorMessage(playerid, "Your farm doesn't have that much");

    new itemid = Inventory_Add(playerid, plantName, 19320, amount);

    if(itemid == -1)
        return SendErrorMessage(playerid, "You don't have any room in your inventory.");

    FarmData[id][farmPlant][plantIndex] -= amount;

    SendCustomMessage(playerid, "FARM", "You've been taken "YELLOW"%d gram(s) "WHITE"of "GREEN"%s "WHITE"from your farm storage", amount, plantName);
  }
  return 1;
}

Dialog:FarmGive(playerid, response, listitem, inputtext[]) {
  if (!response)
    return cmd_farmmenu(playerid);

  new userid;
  if (sscanf(inputtext, "u", userid))
    return Dialog_Show(playerid, FarmGive, DIALOG_STYLE_INPUT, "Farm Transfer Ownership", "Please input the playerid or name to giving your private farm: "GREEN"(input below)", "Give", "Back");

  if (userid == INVALID_PLAYER_ID)
    return SendErrorMessage(playerid, "Invalid playerid or name!");

  if (userid == playerid)
    return SendErrorMessage(playerid, "You can't giving your farm to yourself!");

  if (!IsPlayerNearPlayer(playerid, userid, 3.0))
    return SendErrorMessage(playerid, "You are not nearest with that player!");
  
  if(!PlayerData[userid][pFarmLicenseExpired])
    return SendErrorMessage(playerid, "That player don't have farm licenses.");
  
  SetPVarInt(playerid, "holdingUserID", userid);
  Dialog_Show(playerid, FarmGiveConfirm, DIALOG_STYLE_MSGBOX, "Giving Confirmation", "Are you sure want to transfer your farm ownership to "YELLOW"%s?", "Sure", "Close", NormalName(userid));
  return 1;
}

Dialog:FarmGiveConfirm(playerid, response, listitem, inputtext[]) {
  if (response) {
    new id = GetPVarInt(playerid, "holdingFarmID"), userid = GetPVarInt(playerid, "holdingUserID");

    if (!PlayerData[userid][pStory])
      return SendErrorMessage(playerid, "That player must have accepted character story to owning any property");

    if (Farm_GetCount(userid))
      return SendErrorMessage(playerid, "That player has already have private farm!");

    FarmData[id][farmOwner] = PlayerData[userid][pID];
    format(FarmData[id][farmOwnerName], MAX_PLAYER_NAME, "%s", NormalName(userid));

    Farm_RemoveAllEmployees(id);

    Farm_Refresh(id);
    Farm_Save(id);
    SendCustomMessage(playerid, "FARM", "You've been transfered your private farm to "YELLOW"%s", NormalName(userid));
    SendCustomMessage(userid, "FARM", YELLOW"%s "WHITE"has transfered their private farm to you", NormalName(playerid));
  }
  return 1;
}

Dialog:FarmShowEmployees(playerid, response, listitem, inputtext[]) {
  if (!response)
    return cmd_farmmenu(playerid);

  new id = GetPVarInt(playerid, "holdingFarmID");
  switch (listitem) {
    case 0: {
      Dialog_Show(playerid, FarmAddEmployee, DIALOG_STYLE_INPUT, "Farm Add Employee", "Please input playerid or name whis you want hired as your employee: "GREEN"(input below)", "Hire", "Close");
    }
    case 1: {
      Farm_ShowEmployees(playerid, id, 1);
    }
    case 2: {
      Farm_RemoveAllEmployees(id);
      SendCustomMessage(playerid, "FARM", "You've been fired all your employees");
    }
    case 3: {
      Farm_ShowEmployees(playerid, id, 0);
    }
  }
  return 1;
}

Dialog:FarmAddEmployee(playerid, response, listitem, inputtext[]) {
  if (response) {
    new userid, id = GetPVarInt(playerid, "holdingFarmID");

    if (Farm_EmployeeCount(id) >= 3)
      return SendErrorMessage(playerid, "This Farm is limited 3 employees.");

    if (sscanf(inputtext, "u", userid))
      return Dialog_Show(playerid, FarmAddEmployee, DIALOG_STYLE_INPUT, "Farm Add Employee", "Please input playerid or name whis you want hired as your employee: "GREEN"(input below)", "Hire", "Close");

    if (userid == INVALID_PLAYER_ID)
      return Dialog_Show(playerid, FarmAddEmployee, DIALOG_STYLE_INPUT, "Farm Add Employee", "Please input playerid or name whis you want hired as your employee: "GREEN"(input below)", "Hire", "Close"), SendErrorMessage(playerid, "Invalid playerid or name!");

    if (userid == playerid)
      return Dialog_Show(playerid, FarmAddEmployee, DIALOG_STYLE_INPUT, "Farm Add Employee", "Please input playerid or name whis you want hired as your employee: "GREEN"(input below)", "Hire", "Close"), SendErrorMessage(playerid, "You doesn't hire yourself");

    if (Farm_IsEmployee(userid, id))
      return Dialog_Show(playerid, FarmAddEmployee, DIALOG_STYLE_INPUT, "Farm Add Employee", "Please input playerid or name whis you want hired as your employee: "GREEN"(input below)", "Hire", "Close"), SendErrorMessage(playerid, "That player is already employee of your farm");

    Farm_AddEmployee(userid, id);
    SendCustomMessage(playerid, "FARM", "You've been hired "YELLOW"%s "WHITE"as your farm employee", NormalName(userid));
    SendCustomMessage(userid, "FARM", YELLOW"%s "WHITE"has hired you as employee of his farm", NormalName(playerid));
  }
  return 1;
}

Dialog:FarmRemoveEmployee(playerid, response, listitem, inputtext[]) {
  if (response) {
    Farm_RemoveEmployee(strval(inputtext));
    SendCustomMessage(playerid,"FARM","You've remove list employe number #%d from your farm.", strval(inputtext));
  }
  return 1;
}

Dialog:FarmChangeName(playerid, response, listitem, inputtext[]) {
  if (response) {
    new id = GetPVarInt(playerid, "holdingFarmID");

    if (isnull(inputtext))
      return Dialog_Show(playerid, FarmChangeName, DIALOG_STYLE_INPUT, "Farm Change Name", "Please input the new your farmer name: "GREEN"(input below)", "Change", "Back");

    if (strlen(inputtext) > 32)
      return Dialog_Show(playerid, FarmChangeName, DIALOG_STYLE_INPUT, "Farm Change Name", "Please input the new your farmer name: "GREEN"(input below)", "Change", "Back"), SendErrorMessage(playerid, "Max farm name is 24 characters");

    format(FarmData[id][farmName], 32, "%s", ColouredText(inputtext));
    Farm_Refresh(id);
    Farm_Save(id);

    SendCustomMessage(playerid, "FARM", "You've been changed your farm name to "YELLOW"%s", FarmData[id][farmName]);
  }
  return 1;
}

Dialog:FarmVault(playerid, response, listitem, inputtext[]) {
  if (!response)
    return cmd_farmmenu(playerid), DeletePVar(playerid, "holdingFarmID");

  new id = GetPVarInt(playerid, "holdingFarmID");
  switch (listitem) {
    case 0: {
      Dialog_Show(playerid, FarmDeposit, DIALOG_STYLE_INPUT, "Farm Deposit Vault", "Please input the money wish you want to deposit to vault: "GREEN"(input below)\n"WHITE"Current balance: "GREEN"%s", "Deposit", "Back", FormatNumber(FarmData[id][farmMoney]));
    }
    case 1: {
      if (!Farm_IsOwner(playerid, id))
        return SendErrorMessage(playerid, "You don't have permission to access this option.");
      
      Dialog_Show(playerid, FarmWithdraw, DIALOG_STYLE_INPUT, "Farm Withdraw Vault", "Please input the money wish you want to withdraw from vault: "GREEN"(input below)\n"WHITE"Current balance: "GREEN"%s", "Withdraw", "Back", FormatNumber(FarmData[id][farmMoney]));
    }
  }
  return 1;
}

Dialog:FarmDeposit(playerid, response, listitem, inputtext[]) {
  if (response) {
    new id = GetPVarInt(playerid, "holdingFarmID"), money;

    if (isnull(inputtext))
      return Dialog_Show(playerid, FarmDeposit, DIALOG_STYLE_INPUT, "Farm Deposit Vault", "Please input the money wish you want to deposit to vault: "GREEN"(input below)", "Deposit", "Back");

    if (sscanf(inputtext, "d", money))
      return Dialog_Show(playerid, FarmDeposit, DIALOG_STYLE_INPUT, "Farm Deposit Vault", "Please input the money wish you want to deposit to vault: "GREEN"(input below)", "Deposit", "Back");
    
    if (money < 1)
      return Dialog_Show(playerid, FarmDeposit, DIALOG_STYLE_INPUT, "Farm Deposit Vault", "Please input the money wish you want to deposit to vault: "GREEN"(input below)", "Deposit", "Back"), SendErrorMessage(playerid, "You can't deposit less than 1$");
    
    if (GetMoney(playerid) < money)
      return Dialog_Show(playerid, FarmDeposit, DIALOG_STYLE_INPUT, "Farm Deposit Vault", "Please input the money wish you want to deposit to vault: "GREEN"(input below)", "Deposit", "Back"), SendErrorMessage(playerid, "You don't have enough money");
    
    FarmData[id][farmMoney] += money;
    GiveMoney(playerid, -money);
    Farm_Save(id);
    SendCustomMessage(playerid, "FARM", "You've deposited "GREEN"%s "WHITE"to your farm vault, current balance: "GREEN"%s", FormatNumber(money), FormatNumber(FarmData[id][farmMoney]));
  } else DeletePVar(playerid, "holdingFarmID"), cmd_farmmenu(playerid);
  return 1;
}

Dialog:FarmWithdraw(playerid, response, listitem, inputtext[]) {
  if (response) {
    new id = GetPVarInt(playerid, "holdingFarmID"), money;

    if (isnull(inputtext))
      return Dialog_Show(playerid, FarmWithdraw, DIALOG_STYLE_INPUT, "Farm Withdraw Vault", "Please input the money wish you want to withdraw from vault: "GREEN"(input below)", "Withdraw", "Back");
    
    if (sscanf(inputtext, "d", money))
      return Dialog_Show(playerid, FarmWithdraw, DIALOG_STYLE_INPUT, "Farm Withdraw Vault", "Please input the money wish you want to withdraw from vault: "GREEN"(input below)", "Withdraw", "Back");
    
    if (money < 1)
      return Dialog_Show(playerid, FarmWithdraw, DIALOG_STYLE_INPUT, "Farm Withdraw Vault", "Please input the money wish you want to withdraw from vault: "GREEN"(input below)", "Withdraw", "Back"), SendErrorMessage(playerid, "You can't withdraw less than 1$");
    
    if (FarmData[id][farmMoney] < money)
      return Dialog_Show(playerid, FarmWithdraw, DIALOG_STYLE_INPUT, "Farm Withdraw Vault", "Please input the money wish you want to withdraw from vault: "GREEN"(input below)", "Withdraw", "Back"), SendErrorMessage(playerid, "You don't have enough money in your farm vault");
    
    FarmData[id][farmMoney] -= money;
    GiveMoney(playerid, money);
    Farm_Save(id);
    SendCustomMessage(playerid, "FARM", "You've withdrawed "GREEN"%s "WHITE"from your farm vault, current balance: "GREEN"%s", FormatNumber(money), FormatNumber(FarmData[id][farmMoney]));
  } else DeletePVar(playerid, "holdingFarmID"), cmd_farmmenu(playerid);
  return 1;
}