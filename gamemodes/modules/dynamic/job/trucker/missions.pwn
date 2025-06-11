#define MAX_TRUCKER_MISSIONS (10)

new bool:DialogMissions[MAX_TRUCKER_MISSIONS];
new TrailerMission[MAX_PLAYERS];
new PlayerMissions[MAX_PLAYERS];

enum truckerMissions {
  issuerName[32],
  salaryCost,
  Float:takeTrailerX,
  Float:takeTrailerY,
  Float:takeTrailerZ,
  Float:trailerAngle,
  Float:sendTrailerX,
  Float:sendTrailerY,
  Float:sendTrailerZ
};

new const TruckerMissions[MAX_TRUCKER_MISSIONS][truckerMissions] = {
  {"Valley Docks Import", 600, 2791.4016, -2494.5452, 14.2522, 89.5366, -2471.2942, 783.0248, 35.1719},
  {"Valley Docks Import", 500, 2784.3132, -2456.6299, 14.2415, 89.4938, -576.2687, 2569.0842, 53.5156},
  {"Angel Pine Export", 300, -1963.0142, -2436.3079, 31.2311, 226.1548, 1424.8624, 2333.4939, 10.8203},
  {"Angel Pine Export", 350, -1966.5603, -2439.9380, 31.2306, 225.5799, 1198.7153, 165.4331, 20.5056},
  {"Chilliad Deport", 550, -1863.1541, -1720.5603, 22.3558, 122.1463, 1201.5385, 171.6184, 20.5035},
  {"Chilliad Deport", 200, -1855.7255, -1726.0389, 22.3566, 124.4187, 2786.8313, -2417.9558, 13.6339},
  {"Easter Import", 550, -1053.6145, -658.6473, 32.6319, 260.6392, 1613.7815, 2236.2046, 10.3787},
  {"Blueberry Export", 580, -459.3511, -48.3457, 60.5507, 182.7280, 2415.7803, -2470.1309, 13.6300},
  {"Las Venturas Deport", 450, 847.0450, 921.0422, 13.9579, 201.2555, -980.1684, -713.3505, 32.0078},
  {"Las Venturas Fuel & Gas", 250, 249.6713, 1395.7150, 11.1923, 269.0699, -2226.1292, -2315.1055, 30.6045}
};

#include <YSI\y_hooks>
hook OnPlayerEnterRaceCP(playerid) {
  if (PlayerData[playerid][pMissions] != 0 && !PlayerData[playerid][pTrailer]) {
    new index = PlayerMissions[playerid];

    DisablePlayerRaceCheckpoint(playerid);
    SendCustomMessage(playerid, "MISSIONS","Attach the trailer to your vehicle to order");
    PlayerData[playerid][pTrailer] = 1;
    SetPlayerRaceCheckpoint(playerid, 1, TruckerMissions[index][sendTrailerX], TruckerMissions[index][sendTrailerY], TruckerMissions[index][sendTrailerZ], 0.0, 0.0, 0.0, 10.0);
    return 1;
  }
  
  if (PlayerData[playerid][pTrailer] != 0 && PlayerData[playerid][pMissions] && !IsPlayerShowWaypoint(playerid)) {
    if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) {
      new index = PlayerMissions[playerid];
      DisablePlayerRaceCheckpoint(playerid);
      DestroyVehicle(TrailerMission[playerid]);
      TrailerMission[playerid] = INVALID_VEHICLE_ID;
      PlayerData[playerid][pTrailer] = 0;
      PlayerData[playerid][pMissions] = 0;
      PlayerData[playerid][pMissionsDelay] = 1800;
      DialogMissions[index] = false;
      AddPlayerSalary(playerid, TruckerMissions[index][salaryCost], "Trucker Missions");
      PlayerMissions[playerid] = -1;
    }
    return 1;
  }
  return 1;
}


hook OnPlayerConnect(playerid) {
  PlayerData[playerid][pTrailer] = 0;
  PlayerData[playerid][pMissions] = 0;
  TrailerMission[playerid] = INVALID_VEHICLE_ID;
  PlayerMissions[playerid] = -1;
  return 1;
}


hook OnPlayerDisconnectEx(playerid) {
  if (PlayerData[playerid][pMissions]) {
    if (IsValidVehicle(TrailerMission[playerid]))
      DestroyVehicle(TrailerMission[playerid]);

    PlayerData[playerid][pTrailer] = 0;
    PlayerData[playerid][pMissions] = 0;

    if (PlayerMissions[playerid] != -1)
      DialogMissions[PlayerMissions[playerid]] = false;
      
    PlayerMissions[playerid] = -1;
  }
  return 1;
}

CMD:missions(playerid) {
  if (GetPlayerJob(playerid, 0) != JOB_COURIER && GetPlayerJob(playerid, 1) != JOB_COURIER)
    return SendErrorMessage(playerid, "You're not a trucker.");

  if(!PlayerData[playerid][pTruckerLicenseExpired])
    return SendErrorMessage(playerid, "You don't have any valid trucker license.");

  if (PlayerData[playerid][pMissionsDelay])
    return SendErrorMessage(playerid, "You must wait for %d minutes to take missions again!", (PlayerData[playerid][pMissionsDelay]/60));

  if (!IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    return SendErrorMessage(playerid, "You must to be driver to use this command!");

  if (!IsATruck(GetPlayerVehicleID(playerid)))
    return SendErrorMessage(playerid, "You must use truck mission to doing missions!");

  if (PlayerData[playerid][pMissions] != 0)
    return SendErrorMessage(playerid, "You already taken truck missions!");

  new str[640];

  format(str, sizeof(str), "Order\tPrice\n");
  for (new i = 0; i < MAX_TRUCKER_MISSIONS; i ++) {
    format(str, sizeof(str), "%s%s\t"GREEN"%s\n", str, TruckerMissions[i][issuerName], (DialogMissions[i] == true) ? (RED"TAKEN") : (FormatNumber(TruckerMissions[i][salaryCost])));
  }
  Dialog_Show(playerid, TruckMissions, DIALOG_STYLE_TABLIST_HEADERS, "Missions", str, "Take", "Close");
  return 1;
}

SetPlayerMissionsCP(playerid) {
  if ((GetPlayerJob(playerid, 0) == JOB_COURIER || GetPlayerJob(playerid, 1) == JOB_COURIER) && PlayerData[playerid][pMissions]) {
    new index = PlayerMissions[playerid];

    SetPlayerRaceCheckpoint(playerid, 1, TruckerMissions[index][takeTrailerX], TruckerMissions[index][takeTrailerY], TruckerMissions[index][takeTrailerZ], 0.0, 0.0, 0.0, 10.0);
    TrailerMission[playerid] = CreateVehicle(435, TruckerMissions[index][takeTrailerX], TruckerMissions[index][takeTrailerY], TruckerMissions[index][takeTrailerZ], TruckerMissions[index][trailerAngle], 1, 1, -1);
  }
  return 1;
}

CMD:attachtrailer(playerid, params[]) {
  if (GetPlayerJob(playerid, 0) != JOB_COURIER && GetPlayerJob(playerid, 1) != JOB_COURIER) return SendErrorMessage(playerid, "You're not a trucker.");

  if (!PlayerData[playerid][pMissions]) return SendErrorMessage(playerid, "Kamu tidak sedang melakukan truck missions!");
  new vehicleid = TrailerMission[playerid], Float:vPos[3];
  GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
  if (!IsPlayerInRangeOfPoint(playerid, 10.0, vPos[0], vPos[1], vPos[2])) return SendErrorMessage(playerid, "Trailer truck kamu tidak berada didekatmu!");
  if (!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Kamu harus di kendaraan untuk menggunakan perintah ini!");

  AttachTrailerToVehicle(vehicleid, GetPlayerVehicleID(playerid));
  SendCustomMessage(playerid, "TRAILER", "You has successfully attach your trailer!");
  return 1;
}

CMD:findtrailer(playerid) {
  if (GetPlayerJob(playerid, 0) != JOB_COURIER && GetPlayerJob(playerid, 1) != JOB_COURIER) return SendErrorMessage(playerid, "You're not a trucker.");

  if (!PlayerData[playerid][pMissions]) return SendErrorMessage(playerid, "Kamu tidak sedang melakukan truck missions!");

  new vehicleid = TrailerMission[playerid], Float:vPos[3];

  if (IsValidVehicle(vehicleid)) {
    if (IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
      return SendErrorMessage(playerid, "Your Trailer has already attached to your truck");

    GetVehiclePos(vehicleid, vPos[0], vPos[1], vPos[2]);
    SetPlayerWaypoint(playerid, "Missions Trailer", vPos[0], vPos[1], vPos[2]);
    SendCustomMessage(playerid, "FINDTRAILER", "Your trailer is on marked location");
  }
  return 1;
}

public OnTrailerAttach(trailerid, vehicleid) {
  foreach (new i : Player) {
    if ((GetPlayerJob(i, 0) == JOB_COURIER || GetPlayerJob(i, 1) == JOB_COURIER) && PlayerData[i][pMissions]) {
      if (TrailerMission[i] == trailerid) {
        new index = PlayerMissions[i];

        DisablePlayerRaceCheckpoint(i);
        SendCustomMessage(i, "MISSIONS","Please send the trailer to order");
        SetPlayerRaceCheckpoint(i, 1, TruckerMissions[index][sendTrailerX], TruckerMissions[index][sendTrailerY], TruckerMissions[index][sendTrailerZ], 0.0, 0.0, 0.0, 10.0);
      }
    }
  }
  return 1;
}

Dialog:TruckMissions(playerid, response, listitem, inputtext[]) {
  if (response && listitem != -1) {
    if (DialogMissions[listitem] == true)
      return SendErrorMessage(playerid, "This Trucking Missions has already taken by someone!");

    DialogMissions[listitem] = true;
    PlayerMissions[playerid] = listitem;
    PlayerData[playerid][pMissions] = 1;

    SetPlayerMissionsCP(playerid);
    SendCustomMessage(playerid, "MISSIONS", "Go to marked checkpoint on your map");
  }
  return 1;
}