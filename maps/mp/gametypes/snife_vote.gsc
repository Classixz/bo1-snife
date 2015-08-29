#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level.knife_votes = 0;
    level.snife_votes = 0;
    level.snipe_votes = 0;

    PrecacheMenu("snife_vote");
    level thread onPlayerConnect();
    level waittill("select_snife");
    level thread vote();
}

vote()
{
    players = level.players;
    for(i = 0; i < players.size; i++)
    {
        players[i] OpenMenu("snife_vote");
    }
    wait 10;
    winner = DetermineWinner();
    wait 0.05;

    gmIGN = "wat";
    if(winner == "knife")
        gmIGN = "Knife";
    else if(winner == "snife")
        gmIGN = "Snife";
    else if (winner == "snipe")
        gmIGN = "Snipe";

    IPrintLnBold(gmIGN + " won!");

    wait 3;
    if(winner == "knife")
        level notify("knife_won");
    else if(winner == "snife")
        level notify("snife_won");
    else if (winner == "snipe")
        level notify("snipe_won");
}

DetermineWinner()
{
    knife = level.knife_votes;
    snife = level.snife_votes;
    snipe = level.snipe_votes;
    level.winning_weapon = "none";

    if(knife > snife)
    {
        if(knife > snipe)
            level.winning_weapon = "knife";
        else
            level.winning_weapon = "snipe";
    }
    else if(snife > knife)
    {
        if(snife > snipe)
            level.winning_weapon = "snife";
        else
            level.winning_weapon = "snipe";
    }
    else if(snipe > knife)
    {
        if(snipe > snife)
            level.winning_weapon = "snipe";
        else
            level.winning_weapon = "snife";
    }
    else
    {
        if(knife == snife)
            if(cointoss())
                level.winning_weapon = "knife";
            else
                level.winning_weapon = "snife";
        if(snife == snipe)
            if(cointoss())
                level.winning_weapon = "snife";
            else
                level.winning_weapon = "snipe";
        if(snipe == knife)
            if(cointoss())
                level.winning_weapon = "snipe";
            else
                level.winning_weapon = "knife";
    }
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");

    for(;;)
    {
        self waittill("spawned_player");
        self thread onmapMenuResponse();
    }
}

onMapMenuResponse()
{
    self endon("death");
    self endon("disconnect");

    for(;;)
    {
        self waittill("menuresponse", menu, response);

        if(menu != "snife_vote")
            continue;

        level thread MapSelection_internal(response);
        self IPrintLnBold("Now waiting for ^2other votes^7...");
    }
}

MapSelection_internal(mapNum)
{
    switch(mapNum)
    {
        case "knife":
            level.knife_votes++;
            break;
        case "sniper":
            level.snipe_votes++;
            break;
        case "snife":
            level.snife_votes++;
            break;
    }
}