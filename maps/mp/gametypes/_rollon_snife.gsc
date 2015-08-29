#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	
	level.DevMode = true; //Cheats
	
	level thread onPlayerConnect();
	level thread randomNextGame();
	level thread doDvars();
}

doDvars()
{
	
	setDvar("g_allowvote", 0); 
	setDvar("scr_disable_cac", 1);
	//setDvar("scr_disable_weapondrop", 1);
	setDvar("scr_showperksonspawn", 0);
	setDvar("g_allow_teamchange", 0);
	
	if(level.DevMode) {
		setDvar("sv_cheats", 1);
		setdvar("sv_vac", 0); 
		setDvar( "g_password", "fuckaina" ); 
	} else setDvar("sv_cheats", 0);	setdvar("sv_vac", 1);
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		//iPrintLnBold("kek");
		self takeAllWeapons();
		self clearPerks();
		self maps\mp\gametypes\_class::setKillstreaks( "none", "none", "none" );

		cur_gm = GetDvar("g_gametype");

		if(cur_gm == "dm_knife" || cur_gm == "ctf_knife" || cur_gm == "sd_knife")//knife
		{
			self giveWeapon("m1911_mp");
			self SetWeaponAmmoClip("m1911_mp", 0);
			self SetWeaponAmmoStock("m1911_mp", 0);
		}
		else if(cur_gm == "sd_snipe" || cur_gm == "dem_snipe" || cur_gm == "dm_snipe" || cur_gm == "dom_snipe" || cur_gm == "koth_snipe")//snipe
		{
			self giveWeapon("psg1_mp");
		}
		else if(cur_gm == "ctf_snife" || cur_gm == "dem_snife" || cur_gm == "koth_snife")//snife
		{
			self giveWeapon("m1911_mp");
			self giveWeapon("psg1_mp");
			self SetWeaponAmmoClip("m1911_mp", 0);
			self SetWeaponAmmoStock("m1911_mp", 0);
		}
 
		self giveWeapon("knife_mp");
		self giveWeapon("hatchet_mp");
		self setPerk("specialty_sprintrecovery");
		self setPerk("specialty_bulletpenetration");
		//self setPerk("specialty_fastreload");
		self setPerk("specialty_unlimitedsprint");
		setDvar("perk_bulletPenetrationMultiplier", 4);
	}
}

randomNextGame()
{
	level waittill("select_snife");
	iPrintLnBold("Selecting next weapon set...");
	wait 3;
	weapon = [];
	weapon[0] = "knife";
	weapon[1] = "snife";
	weapon[2] = "snipe";

	weaponSelected = weapon[RandomInt(weapon.size)];

	if(weaponSelected == "knife")
	{
		iPrintLnBold("Knife selected");
		wait 1;
		iPrintLnBold("Selecting next game mode...");
		wait 3;
		gm = [];
		gm[0] = "dm_knife";
		gm[1] = "ctf_knife";
		gm[2] = "sd_knife";

		gmSelected = gm[RandomInt(gm.size)];

		wait 0.1;

		if(gmSelected == "dm_knife")
			iPrintLnBold("Free-For-All selected");
		else if(gmSelected == "ctf_knife")
			iPrintLnBold("Capture the Flag selected");
		else if(gmSelected == "sd_knife")
			iPrintLnBold("Search & Destroy selected");

		setDvar("g_gametype", gmSelected);

		wait 1;

		iPrintLnBold("Selecting next map...");
		wait 3;

		map = [];
		map[0] = "mp_mountain";
		map[1] = "mp_firingrange";
		map[2] = "mp_nuked";

		mapSelected = map[RandomInt(map.size)];

		if(mapSelected == "mp_mountain")
			iPrintLnBold("Summit selected");
		else if(mapSelected == "mp_firingrange")
			iPrintLnBold("Firing Range selected");
		else if(mapSelected == "mp_nuked")
			iPrintLnBold("Nuketown selected");

		setDvar("sv_maprotation", "map " + mapSelected);
    	setDvar("sv_maprotationcurrent", "map " + mapSelected);
	}
	else if(weaponSelected == "snife")
	{
		iPrintLnBold("Sniper & Knife selected");
		wait 1;
		iPrintLnBold("Selecting next game mode...");
		wait 3;
		gm = [];
		gm[0] = "dm_snife";
		gm[1] = "ctf_snife";
		gm[2] = "koth_snife";

		gmSelected = gm[RandomInt(gm.size)];

		wait 0.1;

		if(gmSelected == "dem_snife")
			iPrintLnBold("Demolition selected");
		else if(gmSelected == "ctf_snife")
			iPrintLnBold("Capture the Flag selected");
		else if(gmSelected == "koth_snife")
			iPrintLnBold("Headquarters selected");

		setDvar("g_gametype", gmSelected);

		wait 1;

		iPrintLnBold("Selecting next map...");
		wait 3;

		map = [];
		map[0] = "mp_mountain";
		map[1] = "mp_firingrange";
		map[2] = "mp_nuked";
		map[3] = "mp_cosmodrome";
		map[4] = "mp_hanoi";
		map[5] = "mp_cairo";
		map[6] = "mp_duga";
		map[7] = "mp_radiation";

		mapSelected = map[RandomInt(map.size)];

		if(mapSelected == "mp_mountain")
			iPrintLnBold("Summit selected");
		else if(mapSelected == "mp_firingrange")
			iPrintLnBold("Firing Range selected");
		else if(mapSelected == "mp_nuked")
			iPrintLnBold("Nuketown selected");
		else if(mapSelected == "mp_cosmodrome")
			iPrintLnBold("Launch selected");
		else if(mapSelected == "mp_hanoi")
			iPrintLnBold("Hanoi selected");
		else if(mapSelected == "mp_cairo")
			iPrintLnBold("Havana selected");
		else if(mapSelected == "mp_duga")
			iPrintLnBold("Grid selected");
		else if(mapSelected == "mp_radiation")
			iPrintLnBold("Radiation selected");

		setDvar("sv_maprotation", "map " + mapSelected);
    	setDvar("sv_maprotationcurrent", "map " + mapSelected);
	}
	else if(weaponSelected == "snipe")
	{
		iPrintLnBold("Sniper selected");
		wait 1;
		iPrintLnBold("Selecting next game mode...");
		wait 3;
		gm = [];
		gm[0] = "dm_snipe";
		gm[1] = "dom_snipe";
		gm[2] = "koth_snipe";
		gm[3] = "sd_snipe";
		gm[4] = "dem_snipe";

		gmSelected = gm[RandomInt(gm.size)];

		wait 0.1;

		if(gmSelected == "dem_snipe")
			iPrintLnBold("Demolition selected");
		else if(gmSelected == "dm_snipe")
			iPrintLnBold("Capture the Flag selected");
		else if(gmSelected == "koth_snipe")
			iPrintLnBold("Headquarters selected");
		else if(gmSelected == "dom_snipe")
			iPrintLnBold("Domination selected");
		else if(gmSelected == "sd_snipe")
			iPrintLnBold("Search & Destroy selected");

		setDvar("g_gametype", gmSelected);

		wait 1;

		iPrintLnBold("Selecting next map...");
		wait 3;

		map = [];
		map[0] = "mp_mountain";
		map[1] = "mp_firingrange";
		map[2] = "mp_nuked";
		map[3] = "mp_cosmodrome";
		map[4] = "mp_hanoi";
		map[5] = "mp_cairo";
		map[6] = "mp_duga";
		map[7] = "mp_radiation";

		mapSelected = map[RandomInt(map.size)];

		if(mapSelected == "mp_mountain")
			iPrintLnBold("Summit selected");
		else if(mapSelected == "mp_firingrange")
			iPrintLnBold("Firing Range selected");
		else if(mapSelected == "mp_nuked")
			iPrintLnBold("Nuketown selected");
		else if(mapSelected == "mp_cosmodrome")
			iPrintLnBold("Launch selected");
		else if(mapSelected == "mp_hanoi")
			iPrintLnBold("Hanoi selected");
		else if(mapSelected == "mp_cairo")
			iPrintLnBold("Havana selected");
		else if(mapSelected == "mp_duga")
			iPrintLnBold("Grid selected");
		else if(mapSelected == "mp_radiation")
			iPrintLnBold("Radiation selected");

		setDvar("sv_maprotation", "map " + mapSelected);
    	setDvar("sv_maprotationcurrent", "map " + mapSelected);
	}
	wait 3;
	level notify("new_map_selected");
}
