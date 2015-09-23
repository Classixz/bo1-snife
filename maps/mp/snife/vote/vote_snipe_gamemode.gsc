#include maps\mp\_utility;

init()
{	
	game[ "vote_snipe_gamemode" ] = "vote_snipe_gamemode";
	precacheMenu( game[ "vote_snipe_gamemode" ] );
	
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

		if(response == "vote_gamemode_snipe_dem")
		{
			level.vote_gamemode_snipe_dem++;
			iprintln(self.name+" voted on Demolition");
			self closemenu();
			// self OpenMenu(game[ "vote_snipe_map" ]);
		}
		else if(response == "vote_gamemode_snipe_ctf")
		{
			level.vote_gamemode_snipe_ctf++;
			iprintln(self.name+" voted on Capture the Flag");
			self closemenu();
			self OpenMenu(game[ "vote_snipe_map" ]);
		}
		else if(response == "vote_gamemode_snipe_koth")
		{
			level.vote_gamemode_snipe_koth++;
			iprintln(self.name+" voted on Headquaters");
			self closemenu();
			// self OpenMenu(game[ "vote_snipe_map" ]);
		}
		else if(response == "vote_gamemode_snipe_dom")
		{
			level.vote_gamemode_snipe_dom++;
			iprintln(self.name+" voted on Domination");
			self closemenu();
			// self OpenMenu(game[ "vote_snipe_map" ]);
		}
		else if(response == "vote_gamemode_snipe_snd")
		{
			level.vote_gamemode_snipe_snd++;
			iprintln(self.name+" voted on Search and Destroy");
			self closemenu();
			// self OpenMenu(game[ "vote_snipe_map" ]);
		}
	}
}