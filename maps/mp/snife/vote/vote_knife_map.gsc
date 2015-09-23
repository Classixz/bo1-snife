#include maps\mp\_utility;

init()
{	
	game[ "vote_knife_map" ] = "vote_knife_map";
	precacheMenu( game[ "vote_knife_map" ] );
	
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
			//iprintln(self.name+" voted on Snife")
		}
		else if(response == "vote_weapon_snipers")
		{
			//iprintln(self.name+" voted on Sniper")
		}
		else if(response == "vote_weapon_knifes")
		{
			//iprintln(self.name+" voted on Knifes")
		}
	}
}