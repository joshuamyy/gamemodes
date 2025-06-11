/*	Prison Script Module	*/
#include <YSI\y_hooks>

stock const Float:prisonArrays[][4] = {
    {-1988.1528,-528.2183,35.4219,359.8591},
    {-1994.3698,-528.4446,35.4219,359.4436},
    {-1994.7557,-513.0927,35.4219,180.5914},
    {-1987.9823,-512.9295,35.4219,180.3408},
    {-1988.6240,-509.2596,39.1119,181.0697},
    {-1995.6881,-508.9132,39.1119,180.4199},
    {-2001.3065,-509.2215,39.1119,184.0314},
    {-2001.1552,-532.0347,39.1119,1.7125},
    {-1995.0599,-532.5840,39.1119,355.1324},
    {-1988.0988,-532.3127,39.1119,1.2739}
};

CMD:arrest(playerid, params[])
{
    static
        userid,
        times,
        fine;

    if(GetFactionType(playerid) != FACTION_POLICE) return SendErrorMessage(playerid, "You must be a police officer.");
    if(!PlayerData[playerid][pOnDuty]) return SendErrorMessage(playerid, "You must duty first.");
    if(sscanf(params, "udd", userid, times, fine)) return SendSyntaxMessage(playerid, "/arrest [playerid/PartOfName] [minutes] [fine]");
    if(userid == INVALID_PLAYER_ID || !IsPlayerNearPlayer(playerid, userid, 5.0)) return SendErrorMessage(playerid, "The player is disconnected or not near you.");
    if(times < 1 || times > 120) return SendErrorMessage(playerid, "The specified time can't be below 1 or above 120.");
    if(!PlayerData[userid][pCuffed]) return SendErrorMessage(playerid, "The player must be cuffed before an arrest is made.");
    if(!IsPlayerNearArrest(playerid)) return SendErrorMessage(playerid, "You must be near an arrest point.");
    if(fine < 1 || fine > 50000) return SendErrorMessage(playerid, "Fine must be between 0 -  50,000$");

    PlayerData[userid][pPrisoned] = 1;
    PlayerData[userid][pJailTime] = times * 60;
    format(PlayerData[userid][pJailReason], 32, "Arrest");
    GiveMoney(userid, -fine);

    FactionData[PlayerData[playerid][pFaction]][factionMoney] += fine;
    Faction_Save(PlayerData[playerid][pFaction]);

    StopDragging(userid);

    new idx = random(sizeof(prisonArrays));
    SetPlayerPosEx(userid, prisonArrays[idx][0], prisonArrays[idx][1], prisonArrays[idx][2] + 0.3);
    SetPlayerFacingAngle(userid, prisonArrays[idx][3]);

    SetPlayerInterior(userid, 16);
    SetPlayerVirtualWorld(userid, PRISON_WORLD);

    ResetPlayer(userid);
    ResetNameTag(userid);

    PlayerData[userid][pWarrants] = 0;
    PlayerData[userid][pCuffed] = 0;

    PlayerTextDrawShow(userid, PlayerTextdraws[userid][textdraw_prison]);
    SetPlayerSpecialAction(userid, SPECIAL_ACTION_NONE);

    SendCustomMessage(userid, "ARREST", "You have been prisoned by "YELLOW"%s "WHITE"for "RED"%d days "WHITE"at San Andreas Prison.", ReturnName(playerid, 0), times);
    SendCustomMessage(userid, "ARREST", "You have fined for "COL_RED"%s.", FormatNumber(fine));
    return 1;
}