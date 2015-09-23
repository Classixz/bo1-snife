#include maps\mp\_utility;

init()
{	
	game[ "vote_snife_gamemode" ] = "vote_snife_gamemode";
	precacheMenu( game[ "vote_snife_gamemode" ] );
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	while(true)
	{
		level waittill("connected", player);
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );
	
	while( true )
	{
		self waittill( "spawned_player" );
		self thread onMenuResponse();
	}	
}

onMenuResponse()
{
	self endon( "death" );
	self endon( "disconnect" );

	while( true )
	{
		self waittill("menuresponse", menu, response);

		if(response == "vote_gamemode_snife_dem")
		{
			level.vote_gamemode_snife_dem++;
			iprintln(self.name+" voted DEM "+level.vote_gamemode_snife_dem);
			self closemenu();
			// self OpenMenu(game[ "vote_snife_map" ]);
		}
		else if(response == "vote_gamemode_snife_ctf")
		{
			level.vote_gamemode_snife_ctf++;
			iprintln(self.name+" voted CTF "+level.vote_gamemode_snife_ctf);
			self closemenu();
			// self OpenMenu(game[ "vote_snife_map" ]);
		}
		else if(response == "vote_gamemode_snife_koth")
		{
			level.vote_gamemode_snife_koth++;
			iprintln(self.name+" voted KOTH "+level.vote_gamemode_snife_koth);
			self closemenu();
			// self OpenMenu(game[ "vote_snife_map" ]);
		}
	}
}