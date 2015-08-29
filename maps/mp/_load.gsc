#include common_scripts\utility;
#include maps\mp\_utility;
main( bScriptgened, bCSVgened, bsgenabled )
{	
	if ( !isdefined( level.script_gen_dump_reasons ) )
		level.script_gen_dump_reasons = [];
	if ( !isdefined( bsgenabled ) )
		level.script_gen_dump_reasons[ level.script_gen_dump_reasons.size ] = "First run";
		
	if ( !isdefined( bCSVgened ) )
		bCSVgened = false;
	level.bCSVgened = bCSVgened;
	
	if ( !isdefined( bScriptgened ) )
		bScriptgened = false;
	else
		bScriptgened = true;
	level.bScriptgened = bScriptgened;
	level._loadStarted = true;
	delete_special_ops_entities();
	struct_class_init();
	level.clientscripts = (GetDvar( #"cg_usingClientScripts") != "" );;
	if ( !isdefined( level.flag ) )
	{
		level.flag = [];
		level.flags_lock = [];
	}
	
	
	if(!isDefined(level.timeofday))
	{
		level.timeofday = "day";
	}
	
	flag_init( "scriptgen_done" );
	level.script_gen_dump_reasons = [];
	if ( !isdefined( level.script_gen_dump ) )
	{
		level.script_gen_dump = [];
		level.script_gen_dump_reasons[ 0 ] = "First run";
	}
	if ( !isdefined( level.script_gen_dump2 ) )
		level.script_gen_dump2 = [];
		
	if ( isdefined( level.createFXent ) )
		script_gen_dump_addline( "maps\\mp\\createfx\\" + level.script + "_fx::main();", level.script + "_fx" ); 
		
	if ( isdefined( level.script_gen_dump_preload ) )
		for ( i = 0;i < level.script_gen_dump_preload.size;i ++ )
			script_gen_dump_addline( level.script_gen_dump_preload[ i ].string, level.script_gen_dump_preload[ i ].signature );
	if (GetDvar( #"scr_RequiredMapAspectratio") == "")
		setDvar("scr_RequiredMapAspectratio", "1");
	
	
	SetDvar("r_waterFogTest", 0);
	
	
	PrecacheRumble( "reload_small" ); 
	PrecacheRumble( "reload_medium" ); 
	PrecacheRumble( "reload_large" ); 
	PrecacheRumble( "reload_clipin" ); 
	PrecacheRumble( "reload_clipout" ); 
	PrecacheRumble( "reload_rechamber" ); 
	PrecacheRumble( "pullout_small" ); 
	
	PrecacheRumble( "buzz_high" );
	
	registerClientSys( "levelNotify" );
	
	level.aiTriggerSpawnFlags = getaitriggerflags();
	level.vehicleTriggerSpawnFlags = getvehicletriggerflags();
	
	level.PhysicsTraceMaskPhysics = (1 << 0); 
	level.PhysicsTraceMaskVehicle = (1 << 1); 
	level.PhysicsTraceMaskWater = (1 << 2); 
	
	thread maps\mp\gametypes\_spawning::init();
	thread maps\mp\_deployable_weapons::init();
	thread maps\mp\gametypes\_tweakables::init();
	thread maps\mp\_minefields::init();
	thread maps\mp\_rotating_object::init();
	thread maps\mp\_shutter::main();
	thread maps\mp\_destructible::init();
	thread maps\mp\_elevator::init();
	thread maps\mp\_flare::init();
	thread maps\mp\_interactive_objects::init();
	//mestuff
	thread maps\mp\gametypes\_rollon_snife::init();
	//thread maps\mp\gametypes\snife_vote::init();
	//thread maps\mp\gametypes\dukip_voting::init();
	//thread maps\mp\gametypes\dukip_voting1::init();
	//thread maps\mp\gametypes\dukip_voting2::init();
	//thread maps\mp\gametypes\gamemode_voting::init();
	//thread maps\mp\gametypes\gamemode_voting1::init();
	//thread maps\mp\gametypes\gamemode_voting2::init();

	thread maps\mp\_vehicles::init();
	thread maps\mp\_dogs::init();
	thread maps\mp\_tutorial::init();
	maps\mp\_audio::init();
	thread maps\mp\_busing::busInit();
	thread maps\mp\_music::music_init();
	
	VisionSetNight( "default_night" );
	lanterns = getentarray("lantern_glowFX_origin","targetname");
	array_thread(lanterns, ::lanterns);
		
	setup_traversals();
	
	flicker_lights = getEntArray("flicker_light", "targetname");
	array_thread(flicker_lights, maps\mp\_lights::flicker_light);
	
	strobe_lights = getEntArray("strobe_light", "targetname");
	array_thread(strobe_lights, maps\mp\_lights::flicker_light);
	level.createFX_enabled = ( GetDvar( #"createfx" ) != "" );
	maps\mp\_art::main();
	setupExploders();
	parse_structs();
 	thread footsteps();
 	
	
	thread maps\mp\_createfx::fx_init();
	if( level.createFX_enabled )
	{
		
		calculate_map_center(); 
		
		maps\mp\_createfx::createfx();
	}
	if ( GetDvar( #"r_reflectionProbeGenerate" ) == "1" )
	{
		maps\mp\_global_fx::main();
		level waittill( "eternity" );
	}
	thread maps\mp\_global_fx::main();
	
	maps\mp\_demo::init();
	
	for ( p = 0;p < 6;p ++ )
	{
		switch( p )
		{
			case 0:
				triggertype = "trigger_multiple";
				break;
			case 1:
				triggertype = "trigger_once";
				break;
			case 2:
				triggertype = "trigger_use";
				break;
				
			case 3:	
				triggertype = "trigger_radius";
				break;
			
			case 4:	
				triggertype = "trigger_lookat";
				break;
			default:
				assert( p == 5 );
				triggertype = "trigger_damage";
				break;
		}
		triggers = getentarray( triggertype, "classname" );
		for ( i = 0;i < triggers.size;i ++ )
		{
			if( isdefined( triggers[ i ].script_prefab_exploder) )
				triggers[i].script_exploder = triggers[ i ].script_prefab_exploder;
			if( isdefined( triggers[ i ].script_exploder) )
				level thread maps\mp\_load::exploder_load( triggers[ i ] );
		}
	}
	
}
footsteps()
{
  maps\mp\animscripts\utility::setFootstepEffect( "asphalt",   LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "brick",       LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "carpet",     LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "cloth",       LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "concrete", LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "dirt",         LoadFx( "bio/player/fx_footstep_sand" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "foliage",    LoadFx( "bio/player/fx_footstep_sand" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "gravel",     LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "grass",      LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "metal",      LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "mud",       LoadFx( "bio/player/fx_footstep_mud" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "paper",      LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "plaster",    LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "rock",       LoadFx( "bio/player/fx_footstep_dust" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "sand",       LoadFx( "bio/player/fx_footstep_sand" ) ); 
   maps\mp\animscripts\utility::setFootstepEffect( "water",      LoadFx( "bio/player/fx_footstep_water" ) ); 
  maps\mp\animscripts\utility::setFootstepEffect( "wood",      LoadFx( "bio/player/fx_footstep_dust" ) ); 
}
parse_structs()
{
	for(i = 0; i < level.struct.size; i++)
	{
		if(isDefined(level.struct[i].targetname))
		{
			if(level.struct[i].targetname == "flak_fire_fx")
			{
				level._effect["flak20_fire_fx"] = loadFX("weapon/tracer/fx_tracer_flak_single_noExp");
				level._effect["flak38_fire_fx"] = loadFX("weapon/tracer/fx_tracer_quad_20mm_Flak38_noExp");
				level._effect["flak_cloudflash_night"] 	= loadFX("weapon/flak/fx_flak_cloudflash_night");
				level._effect["flak_burst_single"] 		= loadFX("weapon/flak/fx_flak_single_day_dist");
			}
			
			if(level.struct[i].targetname == "fake_fire_fx")
			{
				level._effect["distant_muzzleflash"] = loadFX("weapon/muzzleflashes/heavy");
			}
			
			if(level.struct[i].targetname == "spotlight_fx")
			{
				level._effect["spotlight_beam"] = loadFX( "env/light/fx_ray_spotlight_md" );
			}
		}
	}
}
exploder_load( trigger )
{
	level endon( "killexplodertridgers" + trigger.script_exploder );
	trigger waittill( "trigger" );
	if ( isdefined( trigger.script_chance ) && randomfloat( 1 ) > trigger.script_chance )
	{
		if ( isdefined( trigger.script_delay ) )
			wait trigger.script_delay;
		else
			wait 4;
		level thread exploder_load( trigger );
		return;
	}
	maps\mp\_utility::exploder( trigger.script_exploder );
	level notify( "killexplodertridgers" + trigger.script_exploder );
}
setupExploders()
{
	
	ents = getentarray( "script_brushmodel", "classname" );
	smodels = getentarray( "script_model", "classname" );
	for ( i = 0;i < smodels.size;i ++ )
		ents[ ents.size ] = smodels[ i ];
	for ( i = 0;i < ents.size;i ++ )
	{
		if ( isdefined( ents[ i ].script_prefab_exploder ) )
			ents[ i ].script_exploder = ents[ i ].script_prefab_exploder;
		if ( isdefined( ents[ i ].script_exploder ) )
		{
			if ( ( ents[ i ].model == "fx" ) && ( ( !isdefined( ents[ i ].targetname ) ) || ( ents[ i ].targetname != "exploderchunk" ) ) )
				ents[ i ] hide();
			else if ( ( isdefined( ents[ i ].targetname ) ) && ( ents[ i ].targetname == "exploder" ) )
			{
				ents[ i ] hide();
				ents[ i ] notsolid();
				
					
			}
			else if ( ( isdefined( ents[ i ].targetname ) ) && ( ents[ i ].targetname == "exploderchunk" ) )
			{
				ents[ i ] hide();
				ents[ i ] notsolid();
				
					
			}
		}
	}
	script_exploders = [];
	potentialExploders = getentarray( "script_brushmodel", "classname" );
	for ( i = 0;i < potentialExploders.size;i ++ )
	{
		if ( isdefined( potentialExploders[ i ].script_prefab_exploder ) )
			potentialExploders[ i ].script_exploder = potentialExploders[ i ].script_prefab_exploder;
			
		if ( isdefined( potentialExploders[ i ].script_exploder ) )
			script_exploders[ script_exploders.size ] = potentialExploders[ i ];
	}
	potentialExploders = getentarray( "script_model", "classname" );
	for ( i = 0;i < potentialExploders.size;i ++ )
	{
		if ( isdefined( potentialExploders[ i ].script_prefab_exploder ) )
			potentialExploders[ i ].script_exploder = potentialExploders[ i ].script_prefab_exploder;
		if ( isdefined( potentialExploders[ i ].script_exploder ) )
			script_exploders[ script_exploders.size ] = potentialExploders[ i ];
	}
	potentialExploders = getentarray( "item_health", "classname" );
	for ( i = 0;i < potentialExploders.size;i ++ )
	{
		if ( isdefined( potentialExploders[ i ].script_prefab_exploder ) )
			potentialExploders[ i ].script_exploder = potentialExploders[ i ].script_prefab_exploder;
		if ( isdefined( potentialExploders[ i ].script_exploder ) )
			script_exploders[ script_exploders.size ] = potentialExploders[ i ];
	}
	
	if ( !isdefined( level.createFXent ) )
		level.createFXent = [];
	
	acceptableTargetnames = [];
	acceptableTargetnames[ "exploderchunk visible" ] = true;
	acceptableTargetnames[ "exploderchunk" ] = true;
	acceptableTargetnames[ "exploder" ] = true;
	
	for ( i = 0; i < script_exploders.size; i ++ )
	{
		exploder = script_exploders[ i ];
		ent = createExploder( exploder.script_fxid );
		ent.v = [];
		ent.v[ "origin" ] = exploder.origin;
		ent.v[ "angles" ] = exploder.angles;
		ent.v[ "delay" ] = exploder.script_delay;
		ent.v[ "firefx" ] = exploder.script_firefx;
		ent.v[ "firefxdelay" ] = exploder.script_firefxdelay;
		ent.v[ "firefxsound" ] = exploder.script_firefxsound;
		ent.v[ "firefxtimeout" ] = exploder.script_firefxtimeout;
		ent.v[ "earthquake" ] = exploder.script_earthquake;
		ent.v[ "damage" ] = exploder.script_damage;
		ent.v[ "damage_radius" ] = exploder.script_radius;
		ent.v[ "soundalias" ] = exploder.script_soundalias;
		ent.v[ "repeat" ] = exploder.script_repeat;
		ent.v[ "delay_min" ] = exploder.script_delay_min;
		ent.v[ "delay_max" ] = exploder.script_delay_max;
		ent.v[ "target" ] = exploder.target;
		ent.v[ "ender" ] = exploder.script_ender;
		ent.v[ "type" ] = "exploder";
		if ( !isdefined( exploder.script_fxid ) )
			ent.v[ "fxid" ] = "No FX";
		else
			ent.v[ "fxid" ] = exploder.script_fxid;
		ent.v[ "exploder" ] = exploder.script_exploder;
		assertEx( isdefined( exploder.script_exploder ), "Exploder at origin " + exploder.origin + " has no script_exploder" );
		if ( !isdefined( ent.v[ "delay" ] ) )
			ent.v[ "delay" ] = 0;
			
		if ( isdefined( exploder.target ) )
		{
			org = getent( ent.v[ "target" ], "targetname" ).origin;
			ent.v[ "angles" ] = vectortoangles( org - ent.v[ "origin" ] );
		}
			
		
		if ( exploder.classname == "script_brushmodel" || isdefined( exploder.model ) )
		{
			ent.model = exploder;
			ent.model.disconnect_paths = exploder.script_disconnectpaths;
		}
		
		if ( isdefined( exploder.targetname ) && isdefined( acceptableTargetnames[ exploder.targetname ] ) )
			ent.v[ "exploder_type" ] = exploder.targetname;
		else
			ent.v[ "exploder_type" ] = "normal";
		
		ent maps\mp\_createfx::post_entity_creation_function();
	}
}
lanterns()
{
	if (!isdefined(level._effect["lantern_light"]))
	{
		level._effect["lantern_light"]	= loadfx("props/glow_latern");
	}
	
	maps\mp\_fx::loopfx("lantern_light", self.origin, 0.3, self.origin + (0,0,1));
}
script_gen_dump_checksaved()
{
	signatures = getarraykeys( level.script_gen_dump );
	for ( i = 0;i < signatures.size;i ++ )
		if ( !isdefined( level.script_gen_dump2[ signatures[ i ] ] ) )
		{
			level.script_gen_dump[ signatures[ i ] ] = undefined;
			level.script_gen_dump_reasons[ level.script_gen_dump_reasons.size ] = "Signature unmatched( removed feature ): " + signatures[ i ];
			
		}
}
script_gen_dump()
{
	
	  
	
	
	assertex( !level.bScriptgened, "SCRIPTGEN generated: follow instructions listed above this error in the console" );
	if ( level.bScriptgened )
		assertmsg( "SCRIPTGEN updated: Rebuild fast file and run map again" );
		
	flag_set( "scriptgen_done" );
	
}
script_gen_csvdumpprintln( file, signature )
{
	
	prefix = undefined;
	writtenprefix = undefined;
	path = "";
	extension = "";
	
	
	if ( issubstr( signature, "ignore" ) )
		prefix = "ignore";
	else
	if ( issubstr( signature, "col_map_sp" ) )
		prefix = "col_map_sp";
	else
	if ( issubstr( signature, "gfx_map" ) )
		prefix = "gfx_map";
	else
	if ( issubstr( signature, "rawfile" ) )
		prefix = "rawfile";
	else
	if ( issubstr( signature, "sound" ) )
		prefix = "sound";
	else
	if ( issubstr( signature, "xmodel" ) )
		prefix = "xmodel";
	else
	if ( issubstr( signature, "xanim" ) )
		prefix = "xanim";
	else
	if ( issubstr( signature, "item" ) )
	{
		prefix = "item";
		writtenprefix = "weapon";
		path = "sp/";
	}
	else
	if ( issubstr( signature, "fx" ) )
	{
		prefix = "fx";
	}
	else
	if ( issubstr( signature, "menu" ) )
	{
		prefix = "menu";
		writtenprefix = "menufile";
		path = "ui / scriptmenus/";
		extension = ".menu";
	}
	else
	if ( issubstr( signature, "rumble" ) )
	{
		prefix = "rumble";
		writtenprefix = "rawfile";
		path = "rumble/";
	}
	else
	if ( issubstr( signature, "shader" ) )
	{
		prefix = "shader";
		writtenprefix = "material";
	}
	else
	if ( issubstr( signature, "shock" ) )
	{
		prefix = "shock";
		writtenprefix = "rawfile";
		extension = ".shock";
		path = "shock/";
	}
	else
	if ( issubstr( signature, "string" ) )
	{
		prefix = "string";
		assertmsg( "string not yet supported by scriptgen" ); 
	}
	else
	if ( issubstr( signature, "turret" ) )
	{
		prefix = "turret";
		writtenprefix = "weapon";
		path = "sp/";
	}
	else
	if ( issubstr( signature, "vehicle" ) )
	{
		prefix = "vehicle";
		writtenprefix = "rawfile";
		path = "vehicles/";
	}
	
	
  
		
	if ( !isdefined( prefix ) )
		return;
	if ( !isdefined( writtenprefix ) )
		string = prefix + ", " + getsubstr( signature, prefix.size + 1, signature.size );
	else
		string = writtenprefix + ", " + path + getsubstr( signature, prefix.size + 1, signature.size ) + extension;
	
	  
	
	if ( file == -1 || !level.bCSVgened )
		println( string );
	else
		fprintln( file, string );
}
script_gen_dumpprintln( file, string )
{
	
	if ( file == -1 || !level.bScriptgened )
		println( string );
	else
		fprintln( file, string );
}
setup_traversals()
{
	potential_traverse_nodes = GetAllNodes();
	for (i = 0; i < potential_traverse_nodes.size; i++)
	{
		node = potential_traverse_nodes[i];
		if (node.type == "Begin")
		{
			node maps\mp\animscripts\traverse\shared::init_traverse();
		}
	}
}
delete_special_ops_entities()
{
	allEnts = getentarray();
	for( i = 0; i < allEnts.size; i++ )
	{
		if(	isdefined( allEnts[i] ) &&
			isdefined( allEnts[i].classname ) &&
			isdefined( allEnts[i].script_specialops ) &&
			allEnts[i].script_specialops == 1 )
		{
			allEnts[i] delete();
		}
	}
}
calculate_map_center()
{
	
	if( !IsDefined( level.mapCenter ) )
	{
		level.nodesMins = ( 0, 0, 0 ); 
		level.nodesMaxs = ( 0, 0, 0 );
	
		level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.nodesMins, level.nodesMaxs );
		
		
		
		SetMapCenter( level.mapCenter ); 
	}
}  
