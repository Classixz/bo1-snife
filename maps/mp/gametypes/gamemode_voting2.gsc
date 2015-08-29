#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level.gm_selection_1 = 0;
    level.gm_selection_2 = 0;
    level.gm_selection_3 = 0;

    PrecacheMenu("dukip_gm_selection2");
    //call this when your match 'ends'
    level thread onPlayerConnect();
    level waittill("snipe_won");
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
        players[i] OpenMenu("dukip_gm_selection2");
    }
    wait 10;
    winner = DetermineWinner();
    wait 0.05;
    setDvar("g_gametype", winner);//dm dom sd koth ctf dem

    mapIGN = "defuq";
    if(winner == "dm_snipe")
        mapIGN = "Free-For-All";
    else if(winner == "dom_snipe")
        mapIGN = "Domination";
    else if(winner == "koth_snipe")
        mapIGN = "Headquarters";
    else if(winner == "sd_snipe")
        mapIGN = "Search and Destroy";
    else if(winner == "dem_snipe")
        mapIGN = "Demolition";

    IPrintLnBold(mapIGN + " won!");

    wait 3;
    level notify("gm_snipe_selected");
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

        if(menu != "dukip_gm_selection2")
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
    gmList[0] = StrTok("sd_snipe dem_snipe dm_snipe", " ");
    gmList[1] = StrTok("dem_snipe dm_snipe dom_snipe", " ");
    gmList[2] = StrTok("dm_snipe dom_snipe koth_snipe", " ");
    gmList[3] = StrTok("sd_snipe dm_snipe koth_snipe", " ");//dm dom sd koth ctf dem
    currentGamemode = GetDvar("g_gametype");
    filteredList = removeExistingMapGroup(gmList, currentGamemode);
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

removeExistingMapGroup(mapArray, mapToCut)
{
    //Generate array
    goodList = [];
    //Initialize the string
    addToArray = "";
    for(i = 0; i < mapArray.size; i ++)
    {
        //If our map array contains the current map we're already on ignore it.
        if(mapArray[i][0] == mapToCut || mapArray[i][1] == mapToCut || mapArray[i][2] == mapToCut)
            continue;
        //Now combine the string and add it to our array.
        addToArray = mapArray[i][0] + " " + mapArray[i][1] + " " + mapArray[i][2];
        goodList[goodList.size] = addToArray;
    }
    return goodList;
}