#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level.gm_selection_1 = 0;
    level.gm_selection_2 = 0;
    level.gm_selection_3 = 0;

    PrecacheMenu("dukip_gm_selection1");
    //call this when your match 'ends'
    level thread onPlayerConnect();
    level waittill("snife_won");
    level thread startMapVoting();
}/*
mapList[0] = StrTok("mp_hanoi mp_firingrange mp_nuked", " ");
    mapList[1] = StrTok("mp_cracked mp_duga mp_crisis", " ");
    mapList[2] = StrTok("mp_havoc mp_array mp_mountain", " ");
    mapList[3] = StrTok("mp_russianbase mp_cosmodrome mp_cairo", " ");
    mapList[4] = StrTok("mp_cracked mp_radiation mp_mountain", " ");
    mapList[5] = StrTok("mp_array mp_villa mp_cairo", " ");*/

startMapVoting()
{
    players = level.players;
    for(i = 0; i < players.size; i++)
    {
        players[i] OpenMenu("dukip_gm_selection1");
    }
    wait 10;
    winner = DetermineWinner();
    wait 0.05;
    setDvar("g_gametype", winner);//dm dom sd koth ctf dem

    mapIGN = "defuq";
    if(winner == "dem_snife")
        mapIGN = "Demolition";
    else if(winner == "ctf_snife")
        mapIGN = "Capture the Flag";
    else if(winner == "koth_snife")
        mapIGN = "Headquarters";

    IPrintLnBold(mapIGN + " won!");

    wait 3;
    level notify("gm_snife_selected");
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );

        player setClientDvar("ui_gamemode_1", "");
        player setClientDvar("ui_gamemode_2", "");
        player setClientDvar("ui_gamemode_3", "");

        player thread onPlayerSpawned();
    }
}


onPlayerSpawned()
{
    self endon("disconnect");

    for(;;)
    {
        self waittill("spawned_player");
        self thread onMapMenuResponse();
        //self thread testing();
    }
}

onMapMenuResponse()
{
    self endon("death");
    self endon("disconnect");

    for(;;)
    {
        self waittill("menuresponse", menu, response);

        if(menu != "dukip_gm_selection1")
            continue;

        level thread MapSelection_internal(response);
        self IPrintLnBold("Now waiting for ^2other votes^7...");
    }
}

MapSelection_internal(mapNum)
{
    switch(mapNum)
    {
        case "gm1":
            level.gm_selection_1++;
            break;
        case "gm2":
            level.gm_selection_2++;
            break;
        case "gm3":
            level.gm_selection_3++;
            break;
    }
}

DetermineWinner()
{
    map1 = level.gm_selection_1;
    map2 = level.gm_selection_2;
    map3 = level.gm_selection_3;

    if(map1 > map2)
    {
        if(map1 > map3)
            return level.map_name_1;
        else
            return level.map_name_3;
    }
    else if(map2 > map1)
    {
        if(map2 > map3)
            return level.map_name_2;
        else
            return level.map_name_3;
    }
    else if(map3 > map1)
    {
        if(map3 > map2)
            return level.map_name_3;
        else
            return level.map_name_2;
    }
    else
    {
        if(map1 == map2)
            if(cointoss())
                return level.map_name_1;
            else
                return level.map_name_2;
        if(map2 == map3)
            if(cointoss())
                return level.map_name_2;
            else
                return level.map_name_3;
        if(map3 == map1)
            if(cointoss())
                return level.map_name_3;
            else
                return level.map_name_1;
    }
}

generateTheMaps()
{
    gmList = [];
    gmList[0] = StrTok("ctf_snife dem_snife koth_snife", " ");//dm dom sd koth ctf dem
    //currentGamemode = GetDvar("g_gametype");
    //filteredList = removeExistingMapGroup(gmList, currentGamemode);
    goodList = StrTok(gmList, " ");
    return goodList;
}

setMapNames(mapArray)
{
    level.map_name_1 = mapArray[0];
    level.map_name_2 = mapArray[1];
    level.map_name_3 = mapArray[2];

    self setClientDvar("ui_gamemode_1", mapArray[0]);
    self setClientDvar("ui_gamemode_2", mapArray[1]);
    self setClientDvar("ui_gamemode_3", mapArray[2]);
}