#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
	
	level.DevMode = true; //Cheats
	
	level thread maps\mp\snife\_precache::precacheWeapons();
	
	level thread checkGametype();
	
	
	level thread onPlayerConnect();
	level thread randomNextGame();
	level thread doDvars();
	level thread maps\mp\snife\_vips::PlayerList();
	
	level thread maps\mp\gametypes\_classixz_stuff::spawnBots(0);
}

checkGametype()
{
	level.currentGT = getdvar("g_gametype");
	if(level.currentGT == "tdm" || level.currentGT == "dm" || 
		 level.currentGT == "ctf" || level.currentGT == "dom" || 
		 level.currentGT == "koth" || level.currentGT == "dem")
		{
			
		wait 5;
		iPrintLnBold("Looks like the right gamemode is not loaded..");
		wait 2;
		iPrintLnBold("Reselecting gamemode.");
		wait 2;
		
		gm = [];
		gm[0] = "dm_knife";
		gm[1] = "ctf_knife";
		gm[2] = "sd_knife";
		gm[3] = "dem_snife";
		gm[4] = "ctf_snife";
		gm[5] = "koth_snife";
		gm[6] = "dm_snipe";
		gm[7] = "dom_snipe";
		gm[8] = "koth_snipe";
		gm[9] = "sd_snipe";
		gm[10] = "dem_snipe";
		
		
		gmSelected = gm[RandomInt(gm.size)];

		wait 0.1;

		if(gmSelected == "dm_knife")
			iPrintLnBold("Free-For-All Knife selected");
		else if(gmSelected == "ctf_knife")
			iPrintLnBold("Capture the Flag Knife selected");
		else if(gmSelected == "sd_knife")
			iPrintLnBold("Search & Destroy Knife selected");
		else if(gmSelected == "dem_snife")
			iPrintLnBold("Demolition Snife selected");
		else if(gmSelected == "ctf_snife")
			iPrintLnBold("Capture the Flag Snife selected");
		else if(gmSelected == "koth_snife")
			iPrintLnBold("Headquarters Snife selected");
		else if(gmSelected == "dem_snipe")
			iPrintLnBold("Demolition Snipe selected");
		else if(gmSelected == "dm_snipe")
			iPrintLnBold("Capture the Flag Snipe selected");
		else if(gmSelected == "koth_snipe")
			iPrintLnBold("Headquarters Snipe selected");
		else if(gmSelected == "dom_snipe")
			iPrintLnBold("Domination Snipe selected");
		else if(gmSelected == "sd_snipe")
			iPrintLnBold("Search & Destroy Snipe selected");

		setDvar("g_gametype", gmSelected);
		
		wait 2;
		SetDvar("sv_mapRotationCurrent", "map "+getdvar("mapname"));
		exitlevel(false);
		}
}

doDvars()
{
	
	setDvar("g_allowvote", 0); 
	setDvar("scr_disable_cac", 1);
	setDvar("scr_disable_weapondrop", 1);
	setDvar("scr_showperksonspawn", 0);
	setDvar("g_allow_teamchange", 0);
	
	if(level.DevMode) {
		setDvar("sv_cheats", 1);
		setdvar("sv_vac", 0); 
		//setDvar( "g_password", "fuckaina" ); 
	} else setDvar("sv_cheats", 0);	setdvar("sv_vac", 1);
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.primary = "none";
		player.secondary = "none";
		player.vip = 0;
		player.vip_greeted = 0;
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.custom_killstreak = 0;
		//iPrintLnBold("kek");
		self takeAllWeapons();
		self clearPerks();
		self maps\mp\gametypes\_class::setKillstreaks( "none", "none", "none" );
		self maps\mp\gametypes\_classixz_stuff::doClientDvars(); //Some client dvars, makes it look kinda cool
		self thread maps\mp\snife\_vips::LoadOuts();

		cur_gm = GetDvar("g_gametype");

		if(cur_gm == "dm_knife" || cur_gm == "ctf_knife" || cur_gm == "sd_knife")//knife
		{
			//self giveWeapon("m1911_mp");
			//self SetWeaponAmmoClip("m1911_mp", 0);
			//self SetWeaponAmmoStock("m1911_mp", 0);
			if(self.primary == "none")
				self OpenMenu(game[ "KnifeSelection_Menu" ]);
			else
			{
				self GiveWeapon(self.primary);
				self SetWeaponAmmoClip(self.primary, 0);
				self SetWeaponAmmoStock(self.primary, 0);
				self SwitchToWeapon(self.primary);
			}
			self giveWeapon("knife_mp");
		}
		else if(cur_gm == "sd_snipe" || cur_gm == "dem_snipe" || cur_gm == "dm_snipe" || cur_gm == "dom_snipe" || cur_gm == "koth_snipe")//snipe
		{
			//self giveWeapon("psg1_mp");
			if(self.primary == "none")
				self OpenMenu(game[ "SniperSelection_Menu" ]);
			else
			{
				self GiveWeapon(self.primary);
				self GiveMaxAmmo(self.primary);
				self SwitchToWeapon(self.primary);
			}
		}
		else if(cur_gm == "ctf_snife" || cur_gm == "dem_snife" || cur_gm == "koth_snife")//snife
		{
			//self giveWeapon("m1911_mp");
			//self giveWeapon("psg1_mp");
			//self SetWeaponAmmoClip("m1911_mp", 0);
			//self SetWeaponAmmoStock("m1911_mp", 0);
			if(self.primary == "none" && self.secondary == "none")
				self OpenMenu(game[ "SnifeSelection_Menu" ]);
			else
			{
				self GiveWeapon(self.primary);
				self GiveMaxAmmo(self.primary);
				self GiveWeapon(self.secondary);
				self SetWeaponAmmoClip(self.secondary, 0);
				self SetWeaponAmmoStock(self.secondary, 0);
				self SwitchToWeapon(self.primary);
			}
			self giveWeapon("knife_mp");
		}

		self giveWeapon("hatchet_mp");
		self setPerk("specialty_sprintrecovery");
		self setPerk("specialty_bulletpenetration");
		//self setPerk("specialty_fastreload");
		self setPerk("specialty_unlimitedsprint");
		setDvar("perk_bulletPenetrationMultiplier", 4);

		self thread tip();
		self thread reset_class();
	}
}

custom_killstreaks()
{
	self endon("disconnect");
	self endon("death");

	self.custom_killstreak++;
	switch(self.custom_killstreak)
	{
		case 3:
			self setPerk("specialty_movefaster");
			self iPrintLnBold("^83 ^7Killstreak - ^5Lightweight");
		break;
		case 5:
			self setPerk("specialty_bulletaccuracy");
			self setPerk("specialty_sprintrecovery");
			self setPerk("specialty_fastmeleerecovery");
			self iPrintLnBold("^85 ^7Killstreak - ^5Steady Aim Pro");
		break;
		case 7:
			self setPerk("specialty_scavenger");
			self iPrintLnBold("^87 ^7Killstreak - ^5Scavenger");
		break;
		case 9:
			self setPerk("specialty_bulletdamage");
			self setPerk("specialty_bulletflinch");
			self setPerk("specialty_shellshock");
			self iPrintLnBold("^89 ^7Killstreak - ^5Hardened Pro");
		break;
		case 11:
			self setPerk("specialty_fallheight");
			self iPrintLnBold("^811 ^7Killstreak - ^5Lightweight Pro");
		break;
		case 13:
			self setPerk("specialty_quieter");
			self setPerk("specialty_loudenemies");
			self iPrintLnBold("^813 ^7Killstreak - ^5Ninja Pro");
		break;
		case 15:
			self setPerk("specialty_nottargetedbyai");
			self setPerk("specialty_noname");
			self iPrintLnBold("^815 ^7Killstreak - ^5Ghost Pro");
		break;
		case 17:
			self setPerk("specialty_fastweaponswitch");
			self iPrintLnBold("^817 ^7Killstreak - Scout Pro");
		break;
		case 20:
			self iPrintLnBold("^520 kills? ^7Damn, stop hacking bruh.");
		break;
		case 30:
			self iPrintLnBold("^530 kills? ^7Watafaq");
		break;
		case 40:
			self iPrintLnBold("^540 kills? ^7FaZe on PC confirmed.");
		break;
		case 50:
			self iPrintLnBold("^550 kills? ^7I'm done. I can't even...");
		break;
	}
}

reset_class()
{
	self endon("disconnect");
	self endon("death");
	self endon("weaponResetDone");
	while(1)
	{
		if(self SecondaryOffhandButtonPressed())
		{
			self.primary = "none";
			self.secondary = "none";
			self iPrintLnBold("Weapons are Reset for Next Life");
			self notify("weaponResetDone");
		}
		wait .01;
	}
}

tip()
{
	self endon("disconnect");
	self endon("death");

	self.tip destroy();
	self.tip = createFontString( "objective", 1 );
	self.tip setPoint( "TOP", "TOP", 0, 0 );
	self.tip.sort = 1001;
	self.tip setText("Press ^8[{+smoke}]^7 to Change Weapons");
	wait 10;
	self.tip destroy();
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
		gm[0] = "dem_snife";
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
