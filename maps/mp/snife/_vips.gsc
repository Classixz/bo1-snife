#include maps\mp\gametypes\_rank;
#include maps\mp\gametypes\_hud_util;

PlayerList()
{
	addXUID("11000010a347d4e", "vip"); //Classixz
	addXUID("110000105b2226a", "vip"); //Rollon
	addXUID("110000106a6db4c", "vip"); //Indy
	addXUID("11000010168afb4", "vip"); //Joker
}

isVip(special)
{
	return (issubstr(level.vips[self getxuid()], special) && isDefined(level.vips[self getxuid()]) && self.name != "");	
}

addXUID(xuid, privilage)
{
	if(!isDefined(level.vips)) level.vips = [];
	if(!isDefined(level.vips[xuid])) level.vips[xuid] = privilage;
}


LoadOuts()
{
	self thread VIPStuff();
}

VIPStuff()
{
	if(self isVip("vip"))
	{
		self.vip = 1;//let me know if there's a better way to do it or if the self isVipp works across all gsc's
		if(self.vip_greeted == 0)
		{
			self IPrintLnBold("Hello there little VIP guy :-)");
			self.vip_greeted = 1;
		}
	}

	//self giveWeapon( "intervention_3k_zam" );
	//self switchToWeapon( "intervention_3k_zam" );
	//self giveMaxAmmo( "intervention_3k_zam" );
	
	//self IPrintLnBold("Hello there little VIP guy :-)");
}