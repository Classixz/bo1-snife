#include maps\mp\gametypes\_rank;
#include maps\mp\gametypes\_hud_util;

PlayerList()
{
	addXUID("11000010a347d4e", "vip"); //Classixz
	addXUID("110000105b2226a", "vip"); //Rollonmath42
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
	self giveWeapon( "intervention_3k_zam" );
	self switchToWeapon( "intervention_3k_zam" );
	self giveMaxAmmo( "intervention_3k_zam" );
	
	self IPrintLnBold("Hello there little VIP guy :-)");
	}
}