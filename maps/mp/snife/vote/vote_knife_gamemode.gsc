#include maps\mp\_utility;

init()
{	
	game[ "vote_knife_gamemode" ] = "vote_knife_gamemode";
	precacheMenu( game[ "vote_knife_gamemode" ] );
	
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

		if(response == "vote_gamemode_knife_ffa")
		{
			level.vote_gamemode_knife_ffa++;
			iprintln(self.name+" voted FFA");
			self closemenu();
			// self OpenMenu(game[ "vote_knife_map" ]);
		}
		else if(response == "vote_gamemode_knife_ctf")
		{
			level.vote_gamemode_knife_ctf++;
			iprintln(self.name+" voted CTF");
			self closemenu();
			// self OpenMenu(game[ "vote_knife_map" ]);
		}
		else if(response == "vote_gamemode_knife_snd")
		{
			level.vote_gamemode_knife_snd++;
			iprintln(self.name+" voted SnD");
			self closemenu();
			// self OpenMenu(game[ "vote_knife_map" ]);
		}
				
	}
}