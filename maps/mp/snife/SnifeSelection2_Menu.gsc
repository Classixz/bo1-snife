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
			self DisableInvulnerability();
		}
		else if(response == "snife_b23rk")
		{
			self giveWeapon("b23r_tactical_zam");
			self SetWeaponAmmoClip("b23r_tactical_zam", 0);
			self SetWeaponAmmoStock("b23r_tactical_zam", 0);
			self.secondary = "b23r_tactical_zam";
			self DisableInvulnerability();
		}
		else if(response == "snife_deaglek")
		{
			if(self.vip == 1)
			{
				self giveWeapon("deagle_tactical");
				self SetWeaponAmmoClip("deagle_tactical", 0);
				self SetWeaponAmmoStock("deagle_tactical", 0);
				self.secondary = "deagle_tactical";
				self DisableInvulnerability();
			}
			else
				self openMenu(game[ "SnifeSelection2_Menu" ]);
		}
		else if(response == "snife_sog")
		{
			self giveWeapon("creek_knife_mp");
			self.secondary = "creek_knife_mp";
			self DisableInvulnerability();
		}
		else if(response == "snife_karambit")
		{
			self giveWeapon("karambit_knife_mp");
			self.secondary = "karambit_knife_mp";
			self DisableInvulnerability();
		}
		else if(response == "snife_vorkuta")
		{
			if(self.vip == 1)
			{
				self giveWeapon("vorkuta_knife_mp");
				self.secondary = "vorkuta_knife_mp";
				self DisableInvulnerability();
			}
			else
				self openMenu(game[ "SnifeSelection2_Menu" ]);
		}
	}
}