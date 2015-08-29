#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level.map_selection_1 = 0;
    level.map_selection_2 = 0;
    level.map_selection_3 = 0;

    PrecacheMenu("dukip_map_selection");
    //call this when your match 'ends'
    level thread onPlayerConnect();
    level waittill("gm_knife_selected");
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
    daMaps = generateTheMaps();
    players = level.players;
    for(i = 0; i < players.size; i++)
    {
        players[i] setMapNames(daMaps);
        wait 0.05;
        players[i] OpenMenu("dukip_map_selection");
    }
    wait 10;
    winner = DetermineWinner();
    wait 0.05;
    setDvar("sv_maprotation", "map " + winner);
    setDvar("sv_maprotationcurrent", "map " + winner);

    mapIGN = "defuq";
    if(winner == "mp_hanoi")
        mapIGN = "Hanoi";
    else if(winner == "mp_firingrange")
        mapIGN = "Firing Range";
    else if(winner == "mp_nuked")
        mapIGN = "Nuketown";
    else if(winner == "mp_cracked")
        mapIGN = "Cracked";
    else if(winner == "mp_duga")
        mapIGN = "Grid";
    else if(winner == "mp_crisis")
        mapIGN = "Crisis";
    else if(winner == "mp_havoc")
        mapIGN = "Jungle";
    else if(winner == "mp_array")
        mapIGN = "Array";
    else if(winner == "mp_mountain")
        mapIGN = "Summit";
    else if(winner == "mp_russianbase")
        mapIGN = "WMD";
    else if(winner == "mp_cosmodrome")
        mapIGN = "Launch";
    else if(winner == "mp_cairo")
        mapIGN = "Havana";
    else if(winner == "mp_radiation")
        mapIGN = "Radiation";
    else if(winner == "mp_villa")
        mapIGN = "Villa";

    IPrintLnBold(mapIGN + " won!");

    wait 3;
    //level notify("map_selected_now_gm");
    level notify("new_map_selected");
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );

        player setClientDvar("ui_mapname_1", "");
        player setClientDvar("ui_mapname_2", "");
        player setClientDvar("ui_mapname_3", "");

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

        if(menu != "dukip_map_selection")
            continue;

        level thread MapSelection_internal(response);
        self IPrintLnBold("Now waiting for ^2other votes^7...");
    }
}

MapSelection_internal(mapNum)
{
    switch(mapNum)
    {
        case "1":
            level.map_selection_1++;
            break;
        case "2":
            level.map_selection_2++;
            break;
        case "3":
            level.map_selection_3++;
            break;
    }
}

DetermineWinner()
{
    map1 = level.map_selection_1;
    map2 = level.map_selection_2;
    map3 = level.map_selection_3;

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
    mapList = [];
    mapList[0] = StrTok("mp_mountain mp_firingrange mp_nuked", " ");
    //currentMap = GetDvar("mapname");
    //filteredList = removeExistingMapGroup(mapList, currentMap);
    goodList = StrTok(mapList, " ");
    return goodList;
}

setMapNames(mapArray)
{
    level.map_name_1 = mapArray[0];
    level.map_name_2 = mapArray[1];
    level.map_name_3 = mapArray[2];

    self setClientDvar("ui_mapname_1", mapArray[0]);
    self setClientDvar("ui_mapname_2", mapArray[1]);
    self setClientDvar("ui_mapname_3", mapArray[2]);
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