#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

startVote()
{
			level.voteMenu = "vote_weapon";
			level.WinningGameType = "";
			voteCounter(3, 0, "Weapon vote ends in...", level.voteMenu);
			
			level.snife = level.vote_weapon_snife;
			level.knife = level.vote_weapon_knifes;
			level.snipe = level.vote_weapon_snipers;
			
			/* ======= SNIFE =======*/
			if(level.snife > level.knife && level.snife > level.snipe )	
			{
				level.voteMenu = "vote_snife_gamemode";
				level.WinningGamemode = "Snife";
			}
			else if(level.knife == level.snipe || level.snipe == level.knife )	
			{
				level.voteMenu = "vote_snife_gamemode";
				level.WinningGamemode = "Snife";
			}
			/* ======= KNIFE =======*/
			else if(level.knife > level.snife && level.knife > level.snipe )	
			{
				level.voteMenu = "vote_knife_gamemode";
				level.WinningGamemode = "Knife";
			}
			else if(level.snife == level.snipe || level.snipe == level.snife )	
			{
				level.voteMenu = "vote_knife_gamemode";
				level.WinningGamemode = "Knife";
			}
			/* ======= SNIPE =======*/
			else if(level.snipe > level.knife && level.snipe > level.snife )	
			{
				level.voteMenu = "vote_snipe_gamemode";
				level.WinningGamemode = "Snipe";
			}
			else if(level.knife == level.snife || level.knife == level.snife )	
			{
				level.voteMenu = "vote_snipe_gamemode";
				level.WinningGamemode = "Snipe";
			}
			/* ======= FAIL =======*/
			else winnerDisplay("SYSTEM ERROR! 404");
	
			winnerDisplay(level.WinningGamemode+" Won!");
	
			voteCounter(3, 0, "Gamemode vote ends in...", level.voteMenu);
			
			level.VoteGametypeFFA = level.vote_gamemode_knife_ffa;
			level.VoteGametypeCTF = level.vote_gamemode_knife_ctf+level.vote_gamemode_snife_ctf+level.vote_gamemode_snipe_ctf;
			level.VoteGametypeSnD = level.vote_gamemode_knife_snd+level.vote_gamemode_snipe_snd;
			level.VoteGametypeDEM = level.vote_gamemode_snife_dem+level.vote_gamemode_snipe_dem;
			level.VoteGametypeKOTH = level.vote_gamemode_snife_koth+level.vote_gamemode_snipe_koth;
			level.VoteGametypeDOM = level.vote_gamemode_snipe_dom;
			
	if(level.WinningGamemode == "Snife" )		
	{
			/* ======= DEM =======*/
			if(level.VoteGametypeDEM > level.VoteGametypeCTF && level.VoteGametypeDEM > level.VoteGametypeKOTH )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Demolition";
				setDvar("g_gametype", "dem_snife");
			}
			else if(level.VoteGametypeCTF == level.VoteGametypeKOTH || level.VoteGametypeKOTH == level.VoteGametypeCTF )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Demolition";
				setDvar("g_gametype", "dem_snife");
			}
			/* ======= CTF =======*/
			else if(level.VoteGametypeCTF > level.VoteGametypeDEM && level.VoteGametypeCTF > level.VoteGametypeKOTH )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Capture the Flag";
				setDvar("g_gametype", "ctf_snife");
			}
			else if(level.VoteGametypeDEM == level.VoteGametypeKOTH || level.VoteGametypeKOTH == level.VoteGametypeDEM )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Capture the Flag";
				setDvar("g_gametype", "ctf_snife");
			}
			/* ======= KOTH =======*/
			else if(level.VoteGametypeKOTH > level.VoteGametypeCTF && level.VoteGametypeKOTH > level.VoteGametypeDEM )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Headquarters";
				setDvar("g_gametype", "koth_snife");
			}
			else if(level.VoteGametypeCTF == level.VoteGametypeDEM || level.VoteGametypeCTF == level.VoteGametypeDEM )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Headquarters";
				setDvar("g_gametype", "koth_snife");
			}
			/* ======= FAIL =======*/
			else winnerDisplay("SYSTEM ERROR! 404");
			
			// iprintln("DEM: "+level.VoteGametypeDEM+", CTF:"+level.VoteGametypeCTF+" & KOTH: "+level.VoteGametypeKOTH);
	}
	else if(level.WinningGamemode == "Knife" )		
	{
			/* ======= FFA =======*/
			if(level.VoteGametypeFFA > level.VoteGametypeCTF && level.VoteGametypeFFA > level.VoteGametypeSnD )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Free-For-All";
				setDvar("g_gametype", "dm_knife");
			}
			else if(level.VoteGametypeCTF == level.VoteGametypeSnD || level.VoteGametypeSnD == level.VoteGametypeCTF )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Free-For-All";
				setDvar("g_gametype", "dm_knife");
			}
			/* ======= CTF =======*/
			else if(level.VoteGametypeCTF > level.VoteGametypeFFA && level.VoteGametypeCTF > level.VoteGametypeSnD )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Capture the Flag";
				setDvar("g_gametype", "ctf_knife");
			}
			else if(level.VoteGametypeFFA == level.VoteGametypeSnD || level.VoteGametypeSnD == level.VoteGametypeFFA )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Capture the Flag";
				setDvar("g_gametype", "ctf_knife");
			}
			/* ======= SnD =======*/
			else if(level.VoteGametypeSnD > level.VoteGametypeCTF && level.VoteGametypeSnD > level.VoteGametypeFFA )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Search & Destroy";
				setDvar("g_gametype", "sd_knife");
			}
			else if(level.VoteGametypeCTF == level.VoteGametypeFFA || level.VoteGametypeCTF == level.VoteGametypeFFA )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Search & Destroy";
				setDvar("g_gametype", "sd_knife");
			}
			/* ======= FAIL =======*/
			else winnerDisplay("SYSTEM ERROR! 404");
			
			// iprintln("FFA: "+level.VoteGametypeFFA+", CTF:"+level.VoteGametypeCTF+" & SnD: "+level.VoteGametypeSnD);
	}
	else if(level.WinningGamemode == "Snipe" )		
	{
			/* ======= DOM =======*/
			if(level.VoteGametypeDOM > level.VoteGametypeCTF && level.VoteGametypeDOM > level.VoteGametypeSnD )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Domination";
				setDvar("g_gametype", "dom_snipe");
			}
			else if(level.VoteGametypeCTF == level.VoteGametypeSnD || level.VoteGametypeSnD == level.VoteGametypeCTF )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Domination";
				setDvar("g_gametype", "dom_snipe");
			}
			/* ======= CTF =======*/
			else if(level.VoteGametypeCTF > level.VoteGametypeDOM && level.VoteGametypeCTF > level.VoteGametypeSnD )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Capture the Flag";
				setDvar("g_gametype", "ctf_snipe");
			}
			else if(level.VoteGametypeDOM == level.VoteGametypeSnD || level.VoteGametypeSnD == level.VoteGametypeDOM )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Capture the Flag";
				setDvar("g_gametype", "ctf_snipe");
			}
			/* ======= SnD =======*/
			else if(level.VoteGametypeSnD > level.VoteGametypeCTF && level.VoteGametypeSnD > level.VoteGametypeDOM )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Search & Destroy";
				setDvar("g_gametype", "sd_snipe");
			}
			else if(level.VoteGametypeCTF == level.VoteGametypeDOM || level.VoteGametypeCTF == level.VoteGametypeDOM )	
			{
				level.voteMenu = "vote_snife_map";
				level.WinningGameType = "Search & Destroy";
				setDvar("g_gametype", "sd_snipe");
			}
			/* ======= FAIL =======*/
			else winnerDisplay("SYSTEM ERROR! 404");
			
			// iprintln("FFA: "+level.VoteGametypeDOM+", CTF:"+level.VoteGametypeCTF+" & SnD: "+level.VoteGametypeSnD);
	}

			
			winnerDisplay(level.WinningGameType+" Won!");
			voteCounter(3, 0, "Map vote ends in...", level.voteMenu);
			
			level.summit = level.vote_map_snife_summit;
			level.firingrange = level.vote_map_snife_firingrange;
			level.nuketown = level.vote_map_snife_nuketown;
			
			/* ======= SUMMIT =======*/
			if(level.summit > level.firingrange && level.summit > level.nuketown )	
			{
				level.WinningMap = "Summit";
				setDvar("sv_maprotation", "map mp_mountain");
				setDvar("sv_maprotationcurrent", "map mp_mountain");
			}
			else if(level.firingrange == level.nuketown || level.nuketown == level.firingrange )	
			{
				level.WinningMap = "Summit";
				setDvar("sv_maprotation", "map mp_mountain");
				setDvar("sv_maprotationcurrent", "map mp_mountain");
			}
			/* ======= FIRINGRANGE =======*/
			else if(level.firingrange > level.summit && level.firingrange > level.nuketown )	
			{
				level.WinningMap = "Firing Range";
				setDvar("sv_maprotation", "map mp_firingrange");
				setDvar("sv_maprotationcurrent", "map mp_firingrange");
			}
			else if(level.summit == level.nuketown || level.nuketown == level.summit )	
			{
				level.WinningMap = "Firing Range";
				setDvar("sv_maprotation", "map mp_firingrange");
				setDvar("sv_maprotationcurrent", "map mp_firingrange");
			}
			/* ======= NUKETOWN =======*/
			else if(level.nuketown > level.firingrange && level.nuketown > level.summit )	
			{
				level.WinningMap = "Nuketown";
				setDvar("sv_maprotation", "map mp_nuked");
				setDvar("sv_maprotationcurrent", "map mp_nuked");
			}
			else if(level.firingrange == level.summit || level.firingrange == level.summit )	
			{
				level.WinningMap = "Nuketown";
				setDvar("sv_maprotation", "map mp_nuked");
				setDvar("sv_maprotationcurrent", "map mp_nuked");
			}
			/* ======= FAIL =======*/
			else winnerDisplay("SYSTEM ERROR! 404");
			
			winnerDisplay(level.WinningMap+" Won!");
			
			nextGame(level.WinningGamemode, level.WinningMap, level.WinningGameType);
			wait 2;
			level notify("new_map_selected");
}

voteCounter(time2go, timePased, text, menu)
{	
		for(i = 0; i < level.players.size; i++)
			level.players[i] OpenMenu(game[ menu ]);
		level.timerText = createServerFontString( "hudbig", 2 );
		level.timerText setPoint( "CENTER", "CENTER", 0, -30 );
		level.timerText.color = (0,1,1);
		level.timerText.sort = 1001;
		level.timerText setText( text );
		
		level.counter = createServerFontString( "extrabig", 1.5 );
		level.counter setPoint( "CENTER", "CENTER", 0, 0 );
		level.counter.color = (255, 255, 255);
		level.counter.sort = 1001;
		level.counter maps\mp\gametypes\_hud::fontPulseInit();
		
		for(timePased = time2go; timePased > -1; timePased--)
		{
			level.counter setValue(timePased);
			level.counter thread maps\mp\gametypes\_hud::fontPulse( level );
			level.counter.color = (0,1,1);
			wait 1;
		}
			level.timerText destroy();
			level.counter destroy();
}

winnerDisplay(winner)
{
		for(i = 0; i < level.players.size; i++)
			level.players[i] closemenu();
		level.winnerText = createServerFontString( "hudbig", 3 );
		level.winnerText setPoint( "CENTER", "CENTER", 0, 0 );
		level.winnerText.color = (0,1,1);
		level.winnerText.sort = 1001;
		level.winnerText setText( winner );
		
		wait 2;
			level.winnerText destroy();
}

nextGame(weapons,mapName,gameType)
{	
	if(weapons == "") weapons = "---";
	else if(gameType == "") gameType = "---";
	else if(mapName == "") mapName = "---";
	
	level.nextgame_text = newHudElem();
	level.nextgame_text.font = "objective";
	level.nextgame_text.fontScale = 2.4;
	level.nextgame_text SetText("Next match is "+weapons+" on "+mapName+" ("+gameType+")");
	level.nextgame_text.alignX = "center";
	level.nextgame_text.alignY = "top";
	level.nextgame_text.horzAlign = "center";
	level.nextgame_text.vertAlign = "top";
	level.nextgame_text.x = 0;
	level.nextgame_text.y = 96;
	level.nextgame_text.sort = -1; //-3
	level.nextgame_text.alpha = 1;
	level.nextgame_text.color = (255, 255, 255);
	level.nextgame_text.glowColor = (0,.8,1);
	level.nextgame_text.glowAlpha = 1;
	level.nextgame_text.foreground = true;
	level.nextgame_text setPulseFX( 150, int(10000), 1000 );
		
	level.nextgame_voteshow_weapon = newHudElem();
	level.nextgame_voteshow_weapon.font = "objective";
	level.nextgame_voteshow_weapon.fontScale = 1.2;
	level.nextgame_voteshow_weapon SetText(level.vote_weapon_snife+" vote(s) on Snife, "+level.vote_weapon_snipers+" vote(s) on Snipe & "+level.vote_weapon_knifes+" vote(s) on Knife");
	level.nextgame_voteshow_weapon.alignX = "center";
	level.nextgame_voteshow_weapon.alignY = "top";
	level.nextgame_voteshow_weapon.horzAlign = "center";
	level.nextgame_voteshow_weapon.vertAlign = "top";
	level.nextgame_voteshow_weapon.x = 0;
	level.nextgame_voteshow_weapon.y = 150;
	level.nextgame_voteshow_weapon.sort = -1; //-3
	level.nextgame_voteshow_weapon.alpha = 1;
	level.nextgame_voteshow_weapon.color = (255, 255, 255);
	level.nextgame_voteshow_weapon.glowColor = (0.8,0,0);
	level.nextgame_voteshow_weapon.glowAlpha = 1;
	level.nextgame_voteshow_weapon.foreground = true;
	level.nextgame_voteshow_weapon setPulseFX( 150, int(10000), 1000 );

	level.nextgame_voteshow_map = newHudElem();
	level.nextgame_voteshow_map.font = "objective";
	level.nextgame_voteshow_map.fontScale = 1;

	level.nextgame_voteshow_map SetText("Summit: "+level.vote_map_snife_summit+", Firing Range: "+level.vote_map_snife_firingrange+" & Nuketown: "+level.vote_map_snife_nuketown);
	
	level.nextgame_voteshow_map.alignX = "center";
	level.nextgame_voteshow_map.alignY = "top";
	level.nextgame_voteshow_map.horzAlign = "center";
	level.nextgame_voteshow_map.vertAlign = "top";
	level.nextgame_voteshow_map.x = 0;
	level.nextgame_voteshow_map.y = 175;
	level.nextgame_voteshow_map.sort = -1; //-3
	level.nextgame_voteshow_map.alpha = 1;
	level.nextgame_voteshow_map.color = (255, 255, 255);
	level.nextgame_voteshow_map.glowColor = (0.8,0,0);
	level.nextgame_voteshow_map.glowAlpha = 1;
	level.nextgame_voteshow_map.foreground = true;
	level.nextgame_voteshow_map setPulseFX( 150, int(10000), 1000 );	
	
	level.nextgame_voteshow_gamemode = newHudElem();
	level.nextgame_voteshow_gamemode.font = "objective";
	level.nextgame_voteshow_gamemode.fontScale = 1;
		
	if(level.WinningGamemode == "Snife") level.nextgame_voteshow_gamemode SetText("Demolition: "+level.VoteGametypeDEM+", Capture the Flag: "+level.VoteGametypeCTF+" & Headquarters: "+level.VoteGametypeKOTH); //Snife
	else if(level.WinningGamemode == "Snipe") level.nextgame_voteshow_gamemode SetText("Demolition: "+level.VoteGametypeDEM+", Capture the Flag: "+level.VoteGametypeCTF+" & Headquarters: "+level.VoteGametypeKOTH); //Snipe
	else if(level.WinningGamemode == "Knife") level.nextgame_voteshow_gamemode SetText("Free-For-All: "+level.VoteGametypeFFA+", Capture the Flag: "+level.VoteGametypeCTF+" & Search & Destroy: "+level.VoteGametypeSnD); //Knife
	
	level.nextgame_voteshow_gamemode.alignX = "center";
	level.nextgame_voteshow_gamemode.alignY = "top";
	level.nextgame_voteshow_gamemode.horzAlign = "center";
	level.nextgame_voteshow_gamemode.vertAlign = "top";
	level.nextgame_voteshow_gamemode.x = 0;
	level.nextgame_voteshow_gamemode.y = 200;
	level.nextgame_voteshow_gamemode.sort = -1; //-3
	level.nextgame_voteshow_gamemode.alpha = 1;
	level.nextgame_voteshow_gamemode.color = (255, 255, 255);
	level.nextgame_voteshow_gamemode.glowColor = (0.8,0,0);
	level.nextgame_voteshow_gamemode.glowAlpha = 1;
	level.nextgame_voteshow_gamemode.foreground = true;
	level.nextgame_voteshow_gamemode setPulseFX( 150, int(10000), 1000 );	
}