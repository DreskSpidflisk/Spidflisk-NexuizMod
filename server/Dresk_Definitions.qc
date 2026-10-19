// DRESK - Definitions
// Provides definitions and default values for new features.

// Spidflisk Modification
#define SPIDFLISK_VERSION													"Spidflisk v0.9.5"

// Support Legacy Clients
// Current Legacy Support : < NONE
// #define SPIDFLISK_SUPPORTLEGACYCLIENTS										1

// Bots
// SUPPRESSED DUE TO NEXUIZ 2.0 IMPLEMENTATION
// #define SPIDFLISKBOTS_DEFAULT_FILLBOTSBASECOUNT								4
// #define SPIDFLISKBOTS_DEFAULT_FILLBOTSSKILL									2

#define SPIDFLISKBOTS_DEFAULT_DISPLAYBOTSFILL_TIMER							"133"

// Display Game Settings
#define DISPLAYGAMESETTINGS_DEFAULT_TIMER									"60"

// Corpse Bouncing
#define CORPSE_BOUNCING_DEFAULT_NUMBOUNCES									3
// Corpse FadeTime
#define CORPSE_FADETIME_DEFAULT_TIME										60

// Gib FadeTime
#define GIB_FADETIME_DEFAULT_TIME											7

// Handicap
#define HANDICAP_DEFAULT_VALUE												100
#define HANDICAP_DEFAULT_MINIMUM											"10"
#define HANDICAP_DEFAULT_MAXIMUM											"200"
#define HANDICAP_DEFAULT_CHANGETIME											"30"
#define HANDICAP_DEFAULT_DISPLAYHELPMESSAGE_TIMER							"211"

// Client

// Crouching
#define CROUCH_DEFAULT_ATTACKREDUCTIONPERCENT								"30"

// Long Jump
#define LONGJUMP_DEFAULT_VELOCITY_Z											650

// Weapons
#define WEAPONS_DEFAULT_VERTICALTILT										30

// Weapon Balance
#define WEAPONBALANCE_DEFAULT_LASERALTFIRE_SPEEDDIVISOR						"7.0"
#define WEAPONBALANCE_DEFAULT_LASERALTFIRE_RADIUSMULTIPLIER					"2.0"

// #define WEAPONBALANCE_DEFAULT_UZI_ALTFIREPUSHAMOUNT							"150"
#define WEAPONBALANCE_DEFAULT_UZI_ALTFIREPUSHAMOUNT							"0"

// Sexes
#define SEX_MALE															0
#define SEX_FEMALE															1
#define SEX_ROBOT															2
#define SEX_OTHER															3

// Rocket Launcher Explosion Types
#define ROCKETLAUNCHER_EXPLOSIONTYPE_TOUCH									1
#define ROCKETLAUNCHER_EXPLOSIONTYPE_DAMAGED								2
#define ROCKETLAUNCHER_EXPLOSIONTYPE_TIME									3
#define ROCKETLAUNCHER_EXPLOSIONTYPE_TRIGGERED								4

// Custom CVars
#define CVAR_MISC_USESPIDFLISKSOUNDPACK										"spidflisk_misc_UseSpidfliskSoundPack"
#define CVAR_MISC_LOWBANDWIDTHLEVEL											"spidflisk_misc_LowBandwidthLevel"
#define CVAR_MISC_PLAYERSONLYPLAYHITGROUNDSOUNDS							"spidflisk_misc_PlayersOnlyPlayHitGroundSounds"
#define CVAR_MISC_REMOVEKILLCOUNTREPORTS									"spidflisk_misc_RemoveKillCountReports"
#define CVAR_MISC_DISPLAYGAMESETTINGSTIME									"spidflisk_misc_DisplayGameSettingsTime"
#define CVAR_MISC_SPAWNADDITIONALAMBIENTSOUNDS								"spidflisk_misc_SpawnAdditionalAmbientSounds"
#define CVAR_MISC_CREATESPAWNPOINTMODELS									"spidflisk_misc_CreateSpawnPointModels"
#define CVAR_MISC_SUPPRESSBPRINTSWHENNOPLAYERSORONLYBOTS					"spidflisk_misc_SuppressBPrintsWhenNoPlayersOrOnlyBots"

#define CVAR_WORLD_ENTITYDETAILLEVEL_BOBBING								"spidflisk_world_EntityDetailLevel_Bobbing"
#define CVAR_WORLD_ENTITYDETAILLEVEL_ROTATING								"spidflisk_world_EntityDetailLevel_Rotating"

#define CVAR_INTERMISSION_DISABLEMUSIC										"spidflisk_intermission_DisableMusic"
#define CVAR_INTERMISSION_FADETOBLACK										"spidflisk_intermission_FadeToBlack"
#define CVAR_INTERMISSION_DISPLAYWINNINGPLAYER								"spidflisk_intermission_DisplayWinningPlayer"
#define CVAR_INTERMISSION_USEADVANCEDCLIENTSCORES							"spidflisk_intermission_UseAdvancedClientScores"
#define CVAR_INTERMISSION_ADVANCEDCLIENTSCORES_NUMBEROFAWARDSTODISPLAY		"spidflisk_intermission_AdvancedClientScores_NumberOfAwardsToDisplay"
#define CVAR_INTERMISSION_PLAYERSGLOW										"spidflisk_intermission_PlayersGlow"
#define CVAR_INTERMISSION_USEADVANCEDVICTORYMESSAGE							"spidflisk_intermission_UseAdvancedVictoryMessage"

// SUPPRESSED DUE TO NEXUIZ 2.0 IMPLEMENTATION
// #define CVAR_BOT_FILLBOTSBASECOUNT											"spidflisk_bot_FillBotsBaseCount"
// #define CVAR_BOT_BASECOUNTINCLUDESSPECTATORS								"spidflisk_bot_BaseCountIncludesSpectators"

#define CVAR_BOT_FILLBOTSSKILL												"spidflisk_bot_FillBotsSkill"
#define CVAR_BOT_DISPLAYBOTSFILLTIME										"spidflisk_bot_DisplayBotsFillTime"

#define CVAR_CORPSE_CORPSEFADETIME											"spidflisk_corpse_FadeTime"
#define CVAR_CORPSE_CORPSEBOUNCES											"spidflisk_corpse_Bounces"

#define CVAR_GIB_FADETIME													"spidflisk_gib_FadeTime"

#define CVAR_CLIENT_HASSLEDEFAULTPLAYERNAME									"spidflisk_client_HassleDefaultPlayerName"
#define CVAR_CLIENT_RANDOMIZEONDEFAULTPLAYERCHARACTER						"spidflisk_client_RandomizeOnDefaultPlayerCharacter"
#define CVAR_CLIENT_REPORTSPECTATETOTARGET									"spidflisk_client_ReportSpectateToClient"
#define CVAR_CLIENT_DISABLEVERSIONNAGGING									"spidflisk_client_DisableVersionNagging"
// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
// #define CVAR_CLIENT_LIMITONEHITSOUNDPERFRAME								"spidflisk_client_LimitOneHitSoundPerFrame"

#define CVAR_PLAYER_SPAWNEFFECT												"spidflisk_player_SpawnEffect"
#define CVAR_PLAYER_BLEEDBELOWHEALTHLEVEL									"spidflisk_player_BleedBelowHealthLevel"
#define CVAR_PLAYER_TAUNTANIMATIONDURINGCHAT								"spidflisk_player_TauntAnimationDuringChat"
#define CVAR_PLAYER_FOOTSTEPFORJUMP											"spidflisk_player_FootstepForJump"
#define CVAR_PLAYER_CROUCHATTACKREDUCTIONPERCENTILE							"spidflisk_player_CrouchAttackReductionPercentile"
#define CVAR_PLAYER_GLOBALCOLORMODDECREMENTAMOUNT							"spidflisk_player_GlobalColormodDecrementAmount"
#define CVAR_PLAYER_LONGJUMPANIMATION_ENABLED								"spidflisk_player_LongJumpAnimation_Enabled"
#define CVAR_PLAYER_LONGJUMPANIMATION_GLOWTRAILSONFEETTIME					"spidflisk_player_LongJumpAnimation_GlowTrailsOnFeetTime"

#define CVAR_PLAYER_HANDICAP_ALLOW											"spidflisk_player_Handicap_Allow"
#define CVAR_PLAYER_HANDICAP_CHANGETIME										"spidflisk_player_Handicap_ChangeTime"
#define CVAR_PLAYER_HANDICAP_SHOWATTACKERVICTIMHANDICAP						"spidflisk_player_Handicap_ShowAttackerVictimHandicap"
#define CVAR_PLAYER_HANDICAP_MINIMUM										"spidflisk_player_Handicap_Minimum"
#define CVAR_PLAYER_HANDICAP_MAXIMUM										"spidflisk_player_Handicap_Maximum"
#define CVAR_PLAYER_HANDICAP_DISPLAYHELPMESSAGETIME							"spidflisk_player_Handicap_DisplayHelpMessageTime"

#define CVAR_PLAYERDEATH_CORPSEGIBONLYONEXPLOSIVES							"spidflisk_playerdeath_CorpseGibOnlyOnExplosives"
#define CVAR_PLAYERDEATH_SHOWATTACKERPING									"spidflisk_playerdeath_ShowAttackerPing"
#define CVAR_PLAYERDEATH_SHOWVICTIMPING										"spidflisk_playerdeath_ShowVictimPing"
#define CVAR_PLAYERDEATH_SHOWATTACKERHEALTHARMOR							"spidflisk_playerdeath_ShowAttackerHealthArmor"
#define CVAR_PLAYERDEATH_BLOODYSKULLDEATH									"spidflisk_playerdeath_BloodySkullDeath"
#define CVAR_PLAYERDEATH_DROPPOWERUPS										"spidflisk_playerdeath_DropPowerups"
#define CVAR_PLAYERDEATH_DROPPOWERUPS_POWERUPTIMEADDITION					"spidflisk_playerdeath_DropPowerups_PowerupTimeAddition"
#define CVAR_PLAYERDEATH_DROPARMOR											"spidflisk_playerdeath_DropArmor"
#define CVAR_PLAYERDEATH_DROPARMOR_ARMORADDITIONAMOUNT						"spidflisk_playerdeath_DropArmor_ArmorAdditionAmount"

// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
// #define CVAR_WEAPON_FIXBULLETIRICOCHETSOUNDS								"spidflisk_weapon_FixBulletRicochetSounds"
#define CVAR_WEAPON_RAPIDWEAPONSWITCHES										"spidflisk_weapon_RapidWeaponSwitches"
#define CVAR_WEAPON_FIRINGSOUNDSUSEDYNAMICCHANNELS							"spidflisk_weapon_FiringSoundsUseDynamicChannels"
#define CVAR_WEAPON_EXTERIORWEAPONINHERITSOWNERVERTICALANGLE				"spidflisk_weapon_ExteriorWeaponInheritsOwnerVerticalAngle"
#define CVAR_WEAPON_EXTERIORWEAPONHASLASERSIGHT								"spidflisk_weapon_ExteriorWeaponHasLaserSight"
// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
// #define CVAR_WEAPON_USEADVANCEDOWNERSHIPMESSAGES							"spidflisk_weapon_UseAdvancedOwnershipMessages"
#define CVAR_WEAPON_GRENADELAUNCHER_EXTENDEDEFFECTS							"spidflisk_weapon_GrenadeLauncher_ExtendedEffects"
#define CVAR_WEAPON_LASER_ALLOWALTFIRE										"spidflisk_weapon_Laser_AllowAltFire"
#define CVAR_WEAPON_LASER_ALTFIRESPEEDDIVISOR								"spidflisk_weapon_Laser_AltFireSpeedDivisor"
#define CVAR_WEAPON_LASER_ALTFIRERADIUSMULTIPLIER							"spidflisk_weapon_Laser_AltFireRadiusMultiplier"
#define CVAR_WEAPON_ELECTRO_USEREDUCEDCOMBOEXPLOSION						"spidflisk_weapon_Electro_UseReducedComboExplosion"
// SUPPRESSED DUE TO NEXUIZ 2.0 IMPLEMENTATION
// #define CVAR_WEAPON_ELECTRO_USENEWALTFIRE									"spidflisk_weapon_Electro_UseNewAltFire"
#define CVAR_WEAPON_CRYLINK_DETAILEDPROJECTILETIME							"spidflisk_weapon_Crylink_DetailedProjectileTime"
#define CVAR_WEAPON_UZI_ALTFIREPUSHAMOUNT									"spidflisk_weapon_Uzi_AltFirePushAmount"
#define CVAR_WEAPON_HAGAR_USEMODIFIEDEXPLOSION								"spidflisk_weapon_Hagar_UseModifiedExplosion"
#define CVAR_WEAPON_NEX_PREVENTIMMEDIATEVELOCITYDAMAGETIME					"spidflisk_weapon_Nex_PreventImmediateVelocityDamageTime"
#define CVAR_WEAPON_NEX_DETAILEDPROJECTILESPEED								"spidflisk_weapon_Nex_DetailedProjectileSpeed"
#define CVAR_WEAPON_ROCKETLAUNCHER_TRIGGER_DAMAGEMULTIPLIER					"spidflisk_weapon_RocketLauncher_Trigger_DamageMultiplier"
#define CVAR_WEAPON_ROCKETLAUNCHER_TRIGGER_RADIUSMULTIPLIER					"spidflisk_weapon_RocketLauncher_Trigger_RadiusMultiplier"

#define CVAR_PLATFORM_LIGHTFLASH											"spidflisk_platform_LightFlash"

#define CVAR_JUMPPAD_CONVERTFLYTOBOUNCE										"spidflisk_jumppad_ConvertFlyToBounce"
#define CVAR_JUMPPAD_PLAYERLIGHTFLASH										"spidflisk_jumppad_PlayerLightFlash"
#define CVAR_JUMPPAD_STUCKOBJECTTRIGGERCOUNT								"spidflisk_jumppad_StuckObjectTriggerCount"

#define CVAR_ITEM_FADEUNAVAILABLEITEMS										"spidflisk_item_FadeUnavailableItems"
#define CVAR_ITEM_ALWAYSPICKUPITEMS											"spidflisk_item_AlwaysPickupItems"
#define CVAR_ITEM_RESPAWNEFFECTUSESSPARKS									"spidflisk_item_RespawnEffectUsesSparks"
#define CVAR_ITEM_POWERUPGLOBALPICKUPSOUNDS									"spidflisk_item_PowerupGlobalPickupSounds"
#define CVAR_ITEM_POWERUPGLOBALRESPAWNSOUNDS								"spidflisk_item_PowerupGlobalRespawnSounds"
#define CVAR_ITEM_VERTICALTILTWEAPONS										"spidflisk_item_VerticalTiltWeapons"
// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
// #define CVAR_ITEM_MEGAHEALTH_HEALTH											"spidflisk_item_MegaHealth_Health"
#define CVAR_ITEM_ARMOR_LARGERESPAWNTIME									"spidflisk_item_LargeArmor_RespawnTime"

#define CVAR_GAME_CTF_NODEPTHTESTFLAGS										"spidflisk_game_CTF_NoDepthTestFlags"
#define CVAR_GAME_CTF_GLOBALFLAGSOUNDS										"spidflisk_game_CTF_GlobalFlagSounds"
#define CVAR_GAME_CTF_FLAGGLOWTRAILS										"spidflisk_game_CTF_FlagGlowTrails"
#define CVAR_GAME_CTF_DISABLECAPTURERECORDREPORTS							"spidflisk_game_CTF_DisableCaptureRecordReports"

// DRESK - 3/7/06
// Jumppad Extensions
.float nNumJumppadTriggers;

// DRESK - 12/19/06
// Support BPrints Currently Suppressed
float bBPrintsCurrentlySuppressed;

// DRESK - 6/14/06
// Additional Ambient Sound Counter
float nNumSpawnedAmbientSounds;

// DRESK - 2/25/06
// Successive Centerprint Support
.string scp_strCenterprint;
.float scp_bNeedsFree;
.float scp_tEndTime;
.float scp_tPrintTime;
// .float scp_nNumCurrentPrints;

// DRESK - 2/19/06
// "GlobalSound" Item Pickup Support
// .float item_bIsGlobalSoundItem;

// Count Bad Spawnpoints
float nNumBadSpawnpoints;

// Utilize Global Variable Initialized at Map Loadtime
float bUsingSpidfliskSoundPack;

// DRESK - 12/22/06
// Support Suppressed Falling Damage Time
// UPDATE : 1/21/07
// NOTE: Suppressed due to Nexuiz 2.2.2 logic
// .float tSuppressedFallingDamage;

// Console Variables Support
void CheckEmptyCustomCVar(string strCVar, string strDefaultValue)
{ // Check Empty Custom CVar
	local string strCVarValue;
	local string strCommand;
	
	// Acquire CVar
	strCVarValue = cvar_string(strCVar);
	
	if(strCVarValue == "")
	{ // Blank CVar; Fill Value
		// Generate String
		// Assign Command for Dedicated Servers
		strCommand = strcat("set ", strCVar, " ", strDefaultValue, "\n");
		// Execute Command
		localcmd(strCommand);
		// Assign Command for Clients
		strCommand = strcat("seta ", strCVar, " ", strDefaultValue, "\n");
		// Execute Command
		localcmd(strCommand);
	}
		
}
void PrepareCustomCVars()
{ // Prepare Custom CVars
	// Misc
	CheckEmptyCustomCVar(CVAR_MISC_USESPIDFLISKSOUNDPACK, "0");
	CheckEmptyCustomCVar(CVAR_MISC_LOWBANDWIDTHLEVEL, "3");
	CheckEmptyCustomCVar(CVAR_MISC_PLAYERSONLYPLAYHITGROUNDSOUNDS, "1");
	CheckEmptyCustomCVar(CVAR_MISC_REMOVEKILLCOUNTREPORTS, "1");
	CheckEmptyCustomCVar(CVAR_MISC_DISPLAYGAMESETTINGSTIME, DISPLAYGAMESETTINGS_DEFAULT_TIMER);
	CheckEmptyCustomCVar(CVAR_MISC_SPAWNADDITIONALAMBIENTSOUNDS, "1");
	CheckEmptyCustomCVar(CVAR_MISC_CREATESPAWNPOINTMODELS, "2");
	CheckEmptyCustomCVar(CVAR_MISC_SUPPRESSBPRINTSWHENNOPLAYERSORONLYBOTS, "1");
	
	// World
	CheckEmptyCustomCVar(CVAR_WORLD_ENTITYDETAILLEVEL_BOBBING, "1");
	CheckEmptyCustomCVar(CVAR_WORLD_ENTITYDETAILLEVEL_ROTATING, "1");
	
	// Intermission
	CheckEmptyCustomCVar(CVAR_INTERMISSION_DISABLEMUSIC, "1");
	CheckEmptyCustomCVar(CVAR_INTERMISSION_FADETOBLACK, "1");
	CheckEmptyCustomCVar(CVAR_INTERMISSION_DISPLAYWINNINGPLAYER, "1");
	CheckEmptyCustomCVar(CVAR_INTERMISSION_USEADVANCEDCLIENTSCORES, "1");
	CheckEmptyCustomCVar(CVAR_INTERMISSION_ADVANCEDCLIENTSCORES_NUMBEROFAWARDSTODISPLAY, "10");
	CheckEmptyCustomCVar(CVAR_INTERMISSION_PLAYERSGLOW, "0");
	CheckEmptyCustomCVar(CVAR_INTERMISSION_USEADVANCEDVICTORYMESSAGE, "1");
	
	// Bots
	// SUPPRESSED DUE TO NEXUIZ 2.0 IMPLEMENTATION
	// CheckEmptyCustomCVar(CVAR_BOT_FILLBOTSBASECOUNT, ftos(SPIDFLISKBOTS_DEFAULT_FILLBOTSBASECOUNT) );
	// CheckEmptyCustomCVar(CVAR_BOT_BASECOUNTINCLUDESSPECTATORS, "0");
	// CheckEmptyCustomCVar(CVAR_BOT_FILLBOTSSKILL, ftos(SPIDFLISKBOTS_DEFAULT_FILLBOTSSKILL) );
	
	CheckEmptyCustomCVar(CVAR_BOT_DISPLAYBOTSFILLTIME, SPIDFLISKBOTS_DEFAULT_DISPLAYBOTSFILL_TIMER);
	
	// Client
	CheckEmptyCustomCVar(CVAR_CLIENT_HASSLEDEFAULTPLAYERNAME, "1");
	CheckEmptyCustomCVar(CVAR_CLIENT_RANDOMIZEONDEFAULTPLAYERCHARACTER, "1");
	CheckEmptyCustomCVar(CVAR_CLIENT_REPORTSPECTATETOTARGET, "2");
	CheckEmptyCustomCVar(CVAR_CLIENT_DISABLEVERSIONNAGGING, "0");
	// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
	// CheckEmptyCustomCVar(CVAR_CLIENT_LIMITONEHITSOUNDPERFRAME, "1");
	
	
	// Player
	CheckEmptyCustomCVar(CVAR_PLAYER_SPAWNEFFECT, "1");
	CheckEmptyCustomCVar(CVAR_PLAYER_BLEEDBELOWHEALTHLEVEL, "50");
	CheckEmptyCustomCVar(CVAR_PLAYER_TAUNTANIMATIONDURINGCHAT, "1");
	CheckEmptyCustomCVar(CVAR_PLAYER_FOOTSTEPFORJUMP, "1");
	CheckEmptyCustomCVar(CVAR_PLAYER_CROUCHATTACKREDUCTIONPERCENTILE, CROUCH_DEFAULT_ATTACKREDUCTIONPERCENT);
	CheckEmptyCustomCVar(CVAR_PLAYER_GLOBALCOLORMODDECREMENTAMOUNT, "0.3");
	CheckEmptyCustomCVar(CVAR_PLAYER_LONGJUMPANIMATION_ENABLED, "1");
	CheckEmptyCustomCVar(CVAR_PLAYER_LONGJUMPANIMATION_GLOWTRAILSONFEETTIME, "0.9");
		// Handicap Support
		CheckEmptyCustomCVar(CVAR_PLAYER_HANDICAP_ALLOW, "1");
		CheckEmptyCustomCVar(CVAR_PLAYER_HANDICAP_CHANGETIME, HANDICAP_DEFAULT_CHANGETIME);
		CheckEmptyCustomCVar(CVAR_PLAYER_HANDICAP_SHOWATTACKERVICTIMHANDICAP, "1");
		CheckEmptyCustomCVar(CVAR_PLAYER_HANDICAP_MINIMUM, HANDICAP_DEFAULT_MINIMUM);
		CheckEmptyCustomCVar(CVAR_PLAYER_HANDICAP_MAXIMUM, HANDICAP_DEFAULT_MAXIMUM);
		CheckEmptyCustomCVar(CVAR_PLAYER_HANDICAP_DISPLAYHELPMESSAGETIME, HANDICAP_DEFAULT_DISPLAYHELPMESSAGE_TIMER);
	
	// PlayerDeath
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_CORPSEGIBONLYONEXPLOSIVES, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_SHOWATTACKERPING, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_SHOWVICTIMPING, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_SHOWATTACKERHEALTHARMOR, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_BLOODYSKULLDEATH, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_DROPPOWERUPS, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_DROPPOWERUPS_POWERUPTIMEADDITION, "4");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_DROPARMOR, "1");
	CheckEmptyCustomCVar(CVAR_PLAYERDEATH_DROPARMOR_ARMORADDITIONAMOUNT, "35");
	
	// Game
	CheckEmptyCustomCVar(CVAR_GAME_CTF_NODEPTHTESTFLAGS, "1");
	CheckEmptyCustomCVar(CVAR_GAME_CTF_GLOBALFLAGSOUNDS, "1");
	CheckEmptyCustomCVar(CVAR_GAME_CTF_FLAGGLOWTRAILS, "1");
	CheckEmptyCustomCVar(CVAR_GAME_CTF_DISABLECAPTURERECORDREPORTS, "1");
	
	// Weapons
		// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
		// CheckEmptyCustomCVar(CVAR_WEAPON_FIXBULLETIRICOCHETSOUNDS, "1");
		CheckEmptyCustomCVar(CVAR_WEAPON_RAPIDWEAPONSWITCHES, "2");
		CheckEmptyCustomCVar(CVAR_WEAPON_FIRINGSOUNDSUSEDYNAMICCHANNELS, "1");
		CheckEmptyCustomCVar(CVAR_WEAPON_EXTERIORWEAPONINHERITSOWNERVERTICALANGLE, "1");
		CheckEmptyCustomCVar(CVAR_WEAPON_EXTERIORWEAPONHASLASERSIGHT, "1");
		// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
		// CheckEmptyCustomCVar(CVAR_WEAPON_USEADVANCEDOWNERSHIPMESSAGES, "1");
		// Grenade Launcher
		CheckEmptyCustomCVar(CVAR_WEAPON_GRENADELAUNCHER_EXTENDEDEFFECTS, "1");
		// Laser
		CheckEmptyCustomCVar(CVAR_WEAPON_LASER_ALLOWALTFIRE, "1");
		CheckEmptyCustomCVar(CVAR_WEAPON_LASER_ALTFIRESPEEDDIVISOR, WEAPONBALANCE_DEFAULT_LASERALTFIRE_SPEEDDIVISOR);
		CheckEmptyCustomCVar(CVAR_WEAPON_LASER_ALTFIRERADIUSMULTIPLIER, WEAPONBALANCE_DEFAULT_LASERALTFIRE_RADIUSMULTIPLIER);
		// Electro
		CheckEmptyCustomCVar(CVAR_WEAPON_ELECTRO_USEREDUCEDCOMBOEXPLOSION, "1");
		// SUPPRESSED DUE TO UPDATED OFFICIAL NEXUIZ FEATURE
		// CheckEmptyCustomCVar(CVAR_WEAPON_ELECTRO_USENEWALTFIRE, "1");
		// Crylink
		CheckEmptyCustomCVar(CVAR_WEAPON_CRYLINK_DETAILEDPROJECTILETIME, "0.1");
		// Uzi
		CheckEmptyCustomCVar(CVAR_WEAPON_UZI_ALTFIREPUSHAMOUNT, WEAPONBALANCE_DEFAULT_UZI_ALTFIREPUSHAMOUNT);
		// Hagar
		CheckEmptyCustomCVar(CVAR_WEAPON_HAGAR_USEMODIFIEDEXPLOSION, "1");
		// Nex
		CheckEmptyCustomCVar(CVAR_WEAPON_NEX_DETAILEDPROJECTILESPEED, "4000");
		CheckEmptyCustomCVar(CVAR_WEAPON_NEX_PREVENTIMMEDIATEVELOCITYDAMAGETIME, "0.1");
		// Rocket Launcher
		CheckEmptyCustomCVar(CVAR_WEAPON_ROCKETLAUNCHER_TRIGGER_DAMAGEMULTIPLIER, "0.60");
		CheckEmptyCustomCVar(CVAR_WEAPON_ROCKETLAUNCHER_TRIGGER_RADIUSMULTIPLIER, "0.85");
	
	// Platforms
	CheckEmptyCustomCVar(CVAR_PLATFORM_LIGHTFLASH, "1");
	
	// Jumppads
	CheckEmptyCustomCVar(CVAR_JUMPPAD_CONVERTFLYTOBOUNCE, "1");
	CheckEmptyCustomCVar(CVAR_JUMPPAD_PLAYERLIGHTFLASH, "1");
	CheckEmptyCustomCVar(CVAR_JUMPPAD_STUCKOBJECTTRIGGERCOUNT, "10");
	
	// Items
	CheckEmptyCustomCVar(CVAR_ITEM_FADEUNAVAILABLEITEMS, "1");
	CheckEmptyCustomCVar(CVAR_ITEM_ALWAYSPICKUPITEMS, "1");
	CheckEmptyCustomCVar(CVAR_ITEM_RESPAWNEFFECTUSESSPARKS, "1");
	CheckEmptyCustomCVar(CVAR_ITEM_POWERUPGLOBALPICKUPSOUNDS, "1");
	CheckEmptyCustomCVar(CVAR_ITEM_POWERUPGLOBALRESPAWNSOUNDS, "1");
	CheckEmptyCustomCVar(CVAR_ITEM_VERTICALTILTWEAPONS, ftos( rint(WEAPONS_DEFAULT_VERTICALTILT))  );
	// SUPPRESSED DUE TO NEXUIZ 2.3 IMPLEMENTATION
	// CheckEmptyCustomCVar(CVAR_ITEM_MEGAHEALTH_HEALTH, "150");
	CheckEmptyCustomCVar(CVAR_ITEM_ARMOR_LARGERESPAWNTIME, "20");
	
	
	// Corpses
	CheckEmptyCustomCVar(CVAR_CORPSE_CORPSEFADETIME, ftos(CORPSE_FADETIME_DEFAULT_TIME) );
	CheckEmptyCustomCVar(CVAR_CORPSE_CORPSEBOUNCES, ftos(CORPSE_BOUNCING_DEFAULT_NUMBOUNCES) );
	
	// Gibs
	CheckEmptyCustomCVar(CVAR_GIB_FADETIME, ftos(GIB_FADETIME_DEFAULT_TIME) );
}