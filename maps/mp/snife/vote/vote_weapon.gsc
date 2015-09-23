#include maps\mp\_utility;

init()
{	
	game[ "vote_weapon" ] = "vote_weapon";
	precacheMenu( game[ "vote_weapon" ] );
	
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

		if(response == "vote_weapon_snife")
		{
			level.vote_weapon_snife++;
			iprintln(self.name+" voted snife");
			self closemenu();
			// self OpenMenu(game[ "vote_snife_gamemode" ]);
		}
		else if(response == "vote_weapon_snipers")
		{
			level.vote_weapon_snipers++;
			iprintln(self.name+" voted snipe");
			self closemenu();
			// self OpenMenu(game[ "vote_snipe_gamemode" ]);
		}
		else if(response == "vote_weapon_knifes")
		{
			level.vote_weapon_knifes++;
			iprintln(self.name+" voted knife");
			self closemenu();
			// self OpenMenu(game[ "vote_knife_gamemode" ]);
		}
	}
}