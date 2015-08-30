init()
{	
	game[ "SnifeSelection_Menu" ] = "SnifeSelection_Menu";
	precacheMenu( game[ "SnifeSelection_Menu" ] );
	
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

		if(response == "snife_m40a3")
		{
			self giveWeapon("m40a3_mp");
			self giveMaxAmmo("m40a3_mp");
			self switchToWeapon("m40a3_mp");
			self.primary = "m40a3_mp";
			self OpenMenu(game["SnifeSelection2_Menu"]);
		}
	}
}