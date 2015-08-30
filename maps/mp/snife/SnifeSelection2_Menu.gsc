#include maps\mp\_utility;

init()
{	
	game[ "SnifeSelection2_Menu" ] = "SnifeSelection2_Menu";
	precacheMenu( game[ "SnifeSelection2_Menu" ] );
	
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
		
			if(self is_bot()) 
			{
			self giveWeapon("five_seven_tactical_zam");
			self switchToWeapon("five_seven_tactical_zam");
			self SetWeaponAmmoClip("five_seven_tactical_zam", 0);
			self SetWeaponAmmoStock("five_seven_tactical_zam", 0);
			}
			
	}	
}

onMenuResponse()
{
	self endon( "death" );
	self endon( "disconnect" );

	while( true )
	{
		self waittill("menuresponse", menu, response);

		if(response == "snife_fsk")
		{
			self giveWeapon("five_seven_tactical_zam");
			self SetWeaponAmmoClip("five_seven_tactical_zam", 0);
			self SetWeaponAmmoStock("five_seven_tactical_zam", 0);
			self.secondary = "five_seven_tactical_zam";
		}
	}
}