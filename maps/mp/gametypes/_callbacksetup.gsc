
CodeCallback_StartGameType()
{
	
	if(!isDefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[level.callbackStartGameType]]();
		level.gametypestarted = true; 
	}
}
CodeCallback_PlayerConnect()
{
	self endon("disconnect");
	
	
	self thread maps\mp\_audio::monitor_player_sprint();
	[[level.callbackPlayerConnect]]();
}
CodeCallback_PlayerDisconnect()
{
	self notify("disconnect");
	
	
	
	client_num = self getentitynumber();
	[[level.callbackPlayerDisconnect]]();
}
CodeCallback_HostMigration()
{
	PrintLn("****CodeCallback_HostMigration****");
	[[level.callbackHostMigration]]();
}
CodeCallback_HostMigrationSave()
{
	PrintLn("****CodeCallback_HostMigrationSave****");
	[[level.callbackHostMigrationSave]]();
}
CodeCallback_PlayerMigrated()
{
	PrintLn("****CodeCallback_PlayerMigrated****");
	[[level.callbackPlayerMigrated]]();
}
CodeCallback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	self endon("disconnect");
	
		if(sWeapon == "awp_mp" ) { iDamage = 666; }	
		if(sWeapon == "barrett_mp" ) { iDamage = 666; }	
		if(sWeapon == "intervention_3k_zam" ) { iDamage = 666; }	
		if(sWeapon == "l118a_mp" ) { iDamage = 666; }	
		if(sWeapon == "m40a3_mp" ) { iDamage = 666; }	
		if(sWeapon == "msr_mp" ) { iDamage = 666; }	
		if(sWeapon == "storm_mp" ) { iDamage = 666; }	
		if(sWeapon == "r700_zam" ) { iDamage = 666; }	
	
	[[level.callbackPlayerDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}
CodeCallback_PlayerKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration)
{
	self endon("disconnect");
	[[level.callbackPlayerKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);
}
CodeCallback_PlayerLastStand(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration )
{
	self endon("disconnect");
	[[level.callbackPlayerLastStand]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration );
}
CodeCallback_ActorDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset)
{
	[[level.callbackActorDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
}
CodeCallback_ActorKilled(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset)
{
	[[level.callbackActorKilled]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset);
}
CodeCallback_VehicleDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, damageFromUnderneath, modelIndex, partName)
{
	[[level.callbackVehicleDamage]](eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, damageFromUnderneath, modelIndex, partName);
}
CodeCallback_VehicleRadiusDamage(eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, timeOffset)
{
	[[level.callbackVehicleRadiusDamage]](eInflictor, eAttacker, iDamage, fInnerDamage, fOuterDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, fRadius, fConeAngleCos, vConeDir, timeOffset);
}
CodeCallback_LevelNotify(level_notify, param1, param2)
{
	level thread Callback_DoLevelNotify( level_notify, param1, param2 );
}
Callback_DoLevelNotify( level_notify, param1, param2 )
{
	wait ( 0.05 );
	if ( isdefined( param1 ) && isdefined( param2 ) )
	{
		level notify( level_notify, param1, param2 );
	}
	else if( isdefined( param1 ) )
	{
		level notify( level_notify, param1 );
	}
	else
	{
		level notify ( level_notify );
	}
}
CodeCallback_FaceEventNotify( notify_msg, ent )
{
	if( IsDefined( ent ) && IsDefined( ent.do_face_anims ) && ent.do_face_anims )
	{
		if( IsDefined( level.face_event_handler ) && IsDefined( level.face_event_handler.events[notify_msg] ) )
		{
			ent SendFaceEvent( level.face_event_handler.events[notify_msg] );
		}
	}
}
SetupCallbacks()
{
	SetDefaultCallbacks();
	
	
	level.iDFLAGS_RADIUS			= 1;
	level.iDFLAGS_NO_ARMOR			= 2;
	level.iDFLAGS_NO_KNOCKBACK		= 4;
	level.iDFLAGS_PENETRATION		= 8;
	level.iDFLAGS_NO_TEAM_PROTECTION = 16;
	level.iDFLAGS_NO_PROTECTION		= 32;
	level.iDFLAGS_PASSTHRU			= 64;
}
SetDefaultCallbacks()
{
	level.callbackStartGameType = maps\mp\gametypes\_globallogic::Callback_StartGameType;
	level.callbackPlayerConnect = maps\mp\gametypes\_globallogic_player::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = maps\mp\gametypes\_globallogic_player::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = maps\mp\gametypes\_globallogic_player::Callback_PlayerDamage;
	level.callbackPlayerKilled = maps\mp\gametypes\_globallogic_player::Callback_PlayerKilled;
	level.callbackPlayerLastStand = maps\mp\gametypes\_globallogic_player::Callback_PlayerLastStand;
	level.callbackActorDamage = maps\mp\gametypes\_globallogic_actor::Callback_ActorDamage;
	level.callbackActorKilled = maps\mp\gametypes\_globallogic_actor::Callback_ActorKilled;
	level.callbackVehicleDamage = maps\mp\gametypes\_globallogic_vehicle::Callback_VehicleDamage;
	level.callbackVehicleRadiusDamage = maps\mp\gametypes\_globallogic_vehicle::Callback_VehicleRadiusDamage;
	level.callbackPlayerMigrated = maps\mp\gametypes\_globallogic_player::Callback_PlayerMigrated;
	level.callbackHostMigration = maps\mp\gametypes\_hostmigration::Callback_HostMigration;
	level.callbackHostMigrationSave = maps\mp\gametypes\_hostmigration::Callback_HostMigrationSave;
}
AbortLevel()
{
	println("Aborting level - gametype is not supported");
	level.callbackStartGameType = ::callbackVoid;
	level.callbackPlayerConnect = ::callbackVoid;
	level.callbackPlayerDisconnect = ::callbackVoid;
	level.callbackPlayerDamage = ::callbackVoid;
	level.callbackPlayerKilled = ::callbackVoid;
	level.callbackPlayerLastStand = ::callbackVoid;
	level.callbackActorDamage = ::callbackVoid;
	level.callbackActorKilled = ::callbackVoid;
	level.callbackVehicleDamage = ::callbackVoid;
	setdvar("g_gametype", "dm");
	exitLevel(false);
}
CodeCallback_GlassSmash(pos, dir)
{
	level notify("glass_smash", pos, dir);
}
callbackVoid()
{
} 
 
