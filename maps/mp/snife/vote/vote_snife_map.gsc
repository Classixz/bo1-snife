#include maps\mp\_utility;

init()
{	
	game[ "vote_snife_map" ] = "vote_snife_map";
	precacheMenu( game[ "vote_snife_map" ] );
	
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

		if(response == "vote_map_snife_summit")
		{
			level.vote_map_snife_summit++;
			iprintln(self.name+" voted Summit");
			self closemenu();
		}
		else if(response == "vote_map_snife_firingrange")
		{
			level.vote_map_snife_firingrange++;
			iprintln(self.name+" voted Firing Range");
			self closemenu();
		}
		else if(response == "vote_map_snife_nuketown")
		{
			level.vote_map_snife_nuketown++;
			iprintln(self.name+" voted Nuketown");
			self closemenu();
		}
	}
}