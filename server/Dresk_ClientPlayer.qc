// DRESK - Client / Player Functions

// Definitions
#define CLIENTPLAYER_CENTERPRINTTIME_MINIMUM							4.5
#define CLIENTPLAYER_CONSOLEWIDTH_MINIMUM								800
#define CLIENTPLAYER_CONSOLEHEIGHT_MINIMUM								600

// Fields
.float bIgnoreDamage;
.float fPlayerModelInheritViewAngleMultiplier;
.float tClientCheckCVarTime;

// Additional Client CVars
.float cvar_vid_conwidth;
.float cvar_vid_conheight;

// LongJump Frame Support
.float bIsInLongJump;

// Support Long Jump Entities
.entity enLongJump_LeftFoot;
.entity enLongJump_RightFoot;

// Functions
float GetIsClientDresk(entity enClient)
{ // Check If Client is Dresk
	if(enClient.netname == "^2Dresk")
		return TRUE;
	else
		return FALSE;
}
void CheckReservedDreskAesthetic(entity enClient)
{ // Check Reserved Dresk Aesthetic
	if( !GetIsClientDresk(enClient) )
	{ // Not Dresk
		if(enClient.playermodel == "models/player/lurk.zym")
		{ // Using Lurk Model; No Good
			enClient.playermodel = GetRandomPlayerModelString();
			/*
			if(enClient.playerskin == "0")
			{ // Using Lurk Skin; No Good
				// Send Client Command to Override Skin
				enClient.playerskin = "1";
				// stuffcmd(enClient, "playerskin 1\n");
			}
			*/
		}
	}
}
entity SpawnLongJumpFootEntity(entity enPlayer)
{ // Spawn Long Jump Foot Entity
	local entity enFoot;
		enFoot = spawn();
		
		enFoot.effects = EF_LOWPRECISION;
		setmodel(enFoot, "");
		
		enFoot.glow_color = 46;
		
	return enFoot;
}
void LongJumpFootEntityThink()
{ // Long Jump Foot Entity Think
	// Remove Glow Trail
	self.glow_trail = 0;
}
void SpawnLongJumpFootEntities(entity enPlayer)
{ // Spawn Long Jump Foot Entities
	// Left Foot
	enPlayer.enLongJump_LeftFoot = SpawnLongJumpFootEntity(enPlayer);
	setattachment(enPlayer.enLongJump_LeftFoot, enPlayer, "bip01 l foot");
	enPlayer.enLongJump_LeftFoot.think = LongJumpFootEntityThink;
	// Right Foot
	enPlayer.enLongJump_RightFoot = SpawnLongJumpFootEntity(enPlayer);
	setattachment(enPlayer.enLongJump_RightFoot, enPlayer, "bip01 r foot");
	enPlayer.enLongJump_RightFoot.think = LongJumpFootEntityThink;
}
void ToggleLongJump(entity enPlayer, float bEnabled)
{ // Toggle Long Jump
	if( cvar(CVAR_PLAYER_LONGJUMPANIMATION_ENABLED) )
	{ // Long Jump Enabled
		if(bEnabled && !enPlayer.bIsInLongJump)
		{ // Enable Long Jump
			if( cvar(CVAR_PLAYER_LONGJUMPANIMATION_GLOWTRAILSONFEETTIME) > 0 )
			{ // Long Jump Glow Trails Enabled
				if(!enPlayer.enLongJump_LeftFoot)
					// Spawn Foot Entities
					SpawnLongJumpFootEntities(enPlayer);
					
				// Update Glow Color (DEBUG)
				/*
				enPlayer.enLongJump_LeftFoot.glow_color = cvar("nomonsters");
				enPlayer.enLongJump_RightFoot.glow_color = cvar("nomonsters");
				*/
				// Assign Glow Trail
				if(!enPlayer.enLongJump_LeftFoot.glow_trail)
				{
					// enPlayer.enLongJump_LeftFoot.glow_color = (enPlayer.clientcolors & 15) * 16 + 8;
					// enPlayer.enLongJump_LeftFoot.glow_color = cvar("nomonsters");
					enPlayer.enLongJump_LeftFoot.glow_trail = 1;
					enPlayer.enLongJump_LeftFoot.nextthink = time + cvar(CVAR_PLAYER_LONGJUMPANIMATION_GLOWTRAILSONFEETTIME);
					// enPlayer.enLongJump_RightFoot.glow_color = (enPlayer.clientcolors & 15) * 16 + 8;
					// enPlayer.enLongJump_RightFoot.glow_color = cvar("nomonsters");
					enPlayer.enLongJump_RightFoot.glow_trail = 1;
					enPlayer.enLongJump_RightFoot.nextthink = time + cvar(CVAR_PLAYER_LONGJUMPANIMATION_GLOWTRAILSONFEETTIME);
				}
			}
			
			// Assign Is In Long Jump
			enPlayer.bIsInLongJump = TRUE;
		}
		else
		if(!bEnabled && enPlayer.bIsInLongJump)
		{ // Disable Long Jump
			if( cvar(CVAR_PLAYER_LONGJUMPANIMATION_GLOWTRAILSONFEETTIME) > 0)
			{ // Long Jump Glow Trails Enabled
				// Remove Glow Trail
				if(enPlayer.enLongJump_LeftFoot)
				{
					if(enPlayer.enLongJump_LeftFoot.glow_trail)
					{
						enPlayer.enLongJump_LeftFoot.glow_trail = 0;
						enPlayer.enLongJump_RightFoot.glow_trail = 0;
					}
				}
			}
			
			// Remove Is In Long Jump
			enPlayer.bIsInLongJump = FALSE;
		}
	}
}
string GetRandomPlayerModelString()
{ // Return Random Player Model String
	local string strModel;
	// Acquire Random Number
	local float nRandom;
	nRandom = rint( random() * 14);
	
	// Acquire Random Skin
	local float nSkin;
	nSkin = rint( random() * 2);
	
	if(nRandom == 0)
		strModel = "models/player/carni.zym";
	else
	if(nRandom == 1)
		strModel = "models/player/crash.zym";
	else
	if(nRandom == 2)
		strModel = "models/player/grunt.zym";
	else
	if(nRandom == 3)
		strModel = "models/player/headhunter.zym";
	else
	if(nRandom == 4)
		strModel = "models/player/insurrectionist.zym";
	else
	if(nRandom == 5)
		strModel = "models/player/jeandarc.zym";
	else
	if(nRandom == 6)
		strModel = "models/player/lurk.zym";
	else
	if(nRandom == 7)
		strModel = "models/player/lycanthrope.zym";
	else
	if(nRandom == 8)
		strModel = "models/player/marine.zym";
	else
	if(nRandom == 9)
		strModel = "models/player/nexus.zym";
	else
	if(nRandom == 10)
		strModel = "models/player/pyria.zym";
	else
	if(nRandom == 11)
		strModel = "models/player/shock.zym";
	else
	if(nRandom == 12)
		strModel = "models/player/skadi.zym";
	else
	if(nRandom == 13)
		strModel = "models/player/specop.zym";
	else
		strModel = "models/player/visitant.zym";
		
	return strModel;
}
void AssignRandomPlayerCharacter(entity enClient)
{ // Assign Random Player Character
	// Acquire Random Player Model
	local string strModel;
		strModel = GetRandomPlayerModelString();
	
	// Acquire Random Skin
	local float nSkin;
	nSkin = rint( random() * 2);
		
	// DEBUG
	/*
	local string strMessage;
		strMessage = strcat("Random Model : '", strModel, "'\nRandom Skin : '", ftos(nSkin), "'\n");
		sprint(enClient, strMessage);
	return;
	*/
	
	// Assign Model and Skin through Stuff Commands
	local string strCommand;
	// Generate Model String
	strCommand = strcat("playermodel ", strModel, "\n");
		stuffcmd(enClient, strCommand);
	// Generate Skin String
	strCommand = strcat("playerskin ", ftos(nSkin), "\n");
		stuffcmd(enClient, strCommand);
}
void CheckDefaultPlayerCharacterSettings(entity enClient)
{ // Check Default Player Character Settings
	if( cvar(CVAR_CLIENT_RANDOMIZEONDEFAULTPLAYERCHARACTER) )
	{ // Check Settings
		if(enClient.clientcolors == 0)
		{ // Default, Bland Colors
			if(enClient.playermodel == "models/player/marine.zym")
				// Default Colors AND Player Model; Assign Random Player Model
				AssignRandomPlayerCharacter(enClient);
			// Acquire Random Color Combination
			local float nPantsColor;
				nPantsColor = rint(random() * 15);
			local float nShirtColor;
				nShirtColor = rint(random() * 15);
				
			// Generate Command String
			local string strColors;
			strColors = strcat("color ", ftos(nPantsColor), " ", ftos(nShirtColor), "\n");
			
			// Send Command
			stuffcmd(enClient, strColors);
		}
	}
}
void SendSpidfliskRandomCustomizedCVarsAndAliases(entity enClient)
{ // Send Spidflisk Random Customized CVars and Aliases
	// Send Item Bobheight
	stuffcmd(self, "cl_itembobheight 15\n");
	// Send Item Bob Speed
	stuffcmd(self, "cl_itembobspeed 1\n");
	// Send Weapon Bob Changes
	stuffcmd(self, "cl_bobmodel_side 0.6\n");
	stuffcmd(self, "cl_bobmodel_up 0.2\n");
	// Send Printspeed
	stuffcmd(self, "scr_printspeed 1000000\n");
	// Send Hitsound Alias (useful for saving bandwidth)
	stuffcmd(self, "alias hsnd play2 misc/hit.wav\n");
	// Send Ricochet Sound for Shotgun (but not for Crylink!)
	stuffcmd(self, "cl_sound_ric_gunshot 1\n");
	// Send CHSpeed Alias (useful for saving bandwidth)
	stuffcmd(self, "alias chspeed \"cl_forwardspeed $1; cl_backspeed $1; cl_sidespeed $1; cl_upspeed $1\"\n");
}
void CheckSpidfliskClientCVars(entity enClient)
{ // Check Spidflisk Client CVars
	// Reset CVar Check Time
	enClient.tClientCheckCVarTime = 0;
	
	local string strCommand;
	if(enClient.cvar_scr_centertime < CLIENTPLAYER_CENTERPRINTTIME_MINIMUM)
	{ // Update Client CenterPrint Time
		// bprint("Centertime Needed Update!\n");
		
		strCommand = strcat("scr_centertime ", ftos(CLIENTPLAYER_CENTERPRINTTIME_MINIMUM), "\n");
		stuffcmd(enClient, strCommand);
		// Update Stored CVar
		enClient.cvar_scr_centertime = CLIENTPLAYER_CENTERPRINTTIME_MINIMUM;
	}
	if(enClient.cvar_vid_conwidth < CLIENTPLAYER_CONSOLEWIDTH_MINIMUM)
	{ // Update Console Width
		// bprint("Console Width Needed Update!\n");
		
		strCommand = strcat("vid_conwidth ", ftos( rint(CLIENTPLAYER_CONSOLEWIDTH_MINIMUM) ), "\n");
		stuffcmd(enClient, strCommand);
		// Update Stored CVar
		enClient.cvar_vid_conwidth = CLIENTPLAYER_CONSOLEWIDTH_MINIMUM;
	}
	if(enClient.cvar_vid_conheight < CLIENTPLAYER_CONSOLEHEIGHT_MINIMUM)
	{ // Update Console Height
		// bprint("Console Height Needed Update!\n");
		
		strCommand = strcat("vid_conheight ", ftos( rint(CLIENTPLAYER_CONSOLEHEIGHT_MINIMUM) ), "\n");
		stuffcmd(enClient, strCommand);
		// Update Stored CVar
		enClient.cvar_vid_conheight = CLIENTPLAYER_CONSOLEHEIGHT_MINIMUM;
	}
	
	// Assign SuccessiveCenterprint Time
	enClient.scp_tPrintTime = enClient.cvar_scr_centertime;
}
void PrepareClient_Spectating(entity enClient)
{ // Prepare Client - Spectating
	// Modified Message Feedback
	if(time != enClient.jointime)
	{ // Client did not just join; Display Message
		bprint (strcat(enClient.netname, "^7 is ^5SPECTATING^7 now\n"));
		sound(world, CHAN_AUTO, "misc/menu2.wav", 1, ATTN_NONE);
	}
	// Assign Backup Frags
	enClient.nClientScore_BackupFrags = enClient.frags;
	// Reset Client Stats Scores
	// ResetClientStatsScore(enClient);
}
float GetPlayerModelSex(entity enPlayer)
{ // Return Player Model Sex
	local float nSex;
	switch(enPlayer.model)
	{ // Parse Player Model
		// Parse Females
		case "models/player/visitant.zym":
		case "models/player/jeandarc.zym":
		case "models/player/lycanthrope.zym":
		case "models/player/pyria.zym":
		case "models/player/skadi.zym":
		case "models/player/specop.zym":
			nSex = SEX_FEMALE;
			break;
		// Parse Robots
		case "models/player/crash.zym":
		case "models/player/nexus.zym":
			nSex = SEX_ROBOT;
		// Parse Its
		case "models/player/lurk.zym":
			nSex = SEX_OTHER;
			break;
		// Otherwise Male!
		default:
			nSex = SEX_MALE;
			break;
	}
	
	return nSex;
}
string GetPlayerModelSexVerbiage(entity enPlayer, string strBaseMaleString)
{ // Return Player Model Sex Verbiage
	local string strReturn;
	// Acquire Player Model Sex
	local float nSex;
		nSex = GetPlayerModelSex(enPlayer);
		
	switch(strBaseMaleString)
	{ // Parse Main String
		case "his":
			switch(nSex)
			{
				case SEX_MALE:
					strReturn = "his";
					break;
				case SEX_FEMALE:
					strReturn = "her";
					break;
				case SEX_ROBOT:
				case SEX_OTHER:
					strReturn = "its";
					break;
			}
			break;
		case "himself":
			switch(nSex)
			{
				case SEX_MALE:
					strReturn = "himself";
					break;
				case SEX_FEMALE:
					strReturn = "herself";
					break;
				case SEX_ROBOT:
				case SEX_OTHER:
					strReturn = "itself";
					break;
			}
			break;
		case "he":
			switch(nSex)
			{
				case SEX_MALE:
					strReturn = "he";
					break;
				case SEX_FEMALE:
					strReturn = "she";
					break;
				case SEX_ROBOT:
				case SEX_OTHER:
					strReturn = "it";
					break;
			}
			break;
	}
	
	// Return Verbiage
	return strReturn;
}
void CheckClientAppearanceCustomizationSettings(entity enClient)
{ // Check Client Appearance Customization Settings
	// Check for Dresk Reserved Aesthetic
	CheckReservedDreskAesthetic(enClient);
	
	if( GetIsClientDresk(enClient) )
	{ // Dresk
		// Apply Colormod
		enClient.colormod = '0.5 0.5 0.6';
	}
	else
	{ // Check for Global Colormod Decrement Amount
		local float fColormod;
			fColormod = cvar(CVAR_PLAYER_GLOBALCOLORMODDECREMENTAMOUNT);
		if(fColormod)
		{ // Valid Decrement
			local vector vColormod;
				vColormod = '1.0 1.0 1.0';
			// Decrement Vector
				vColormod_x = vColormod_x - fColormod;
				vColormod_y = vColormod_y - fColormod;
				vColormod_z = vColormod_z - fColormod;
				
			// Assign Colormod
			enClient.colormod = vColormod;
		}
	}
}
void CheckClientSpidfliskSpawnEvents(entity enClient, entity enSpawnPoint)
{ // Check Client Spidflisk Spawn Events
	// Remove Touch Function; Necessary for Corpse Bouncing
	enClient.touch = SUB_Null;
	
	// Remove Potential Bloody Skull Glow
	enClient.glow_size = 0;
	enClient.glow_trail = 0;
	
	// Check for Hassle Default Name
	if( (enClient.netname == "Player" || enClient.netname == "NexPlayer") && cvar(CVAR_CLIENT_HASSLEDEFAULTPLAYERNAME) )
		centerprint(enClient, "^1CHANGE YOUR NAME\nTHIS MESSAGE WILL SHOW UNTIL\nYOU DO SO");
	
	// Check Client Appearance Customization Settings
	CheckClientAppearanceCustomizationSettings(enClient);
	
	// Check for Spawn Effects
	CheckSpidfliskSpawnPointEffects(enClient, enSpawnPoint);
}
void CheckClientSpidfliskObserverEvents(entity enClient)
{ // Check Client Spidflisk Observer Events
	// Remove Negative Health (do NOT kill)
	enClient.health = 1;
	
	// Remove Hide Welcome Message
	enClient.bHideWelcomeMessage = FALSE;
}
void CheckClientSpidfliskConnectEvents(entity enClient)
{ // Check Client Spidflisk Connect Events
	// New Join Message
	bprint (enClient.netname);
	bprint("^7 joined the ^1fray^7");
	
	// Play Local Ambient Joining Sound
	stuffcmd(enClient, "play2 ambient/air.wav\n");
	
	// Play Joining Sound
	if(bUsingSpidfliskSoundPack)
		sound(world, CHAN_AUTO, "Spidflisk/misc/PlayerJoin.ogg", 1, ATTN_NONE);
	else
		sound(world, CHAN_AUTO, "misc/invshot.wav", 1, ATTN_NONE);
	
	// Prepare Handicap
	Handicap_PrepareNewClient(enClient);
	
	// Check Default Player Character Settings
	CheckDefaultPlayerCharacterSettings(enClient);
	
	// Check Default Player Name
	if( (enClient.netname == "Player") && cvar(CVAR_CLIENT_HASSLEDEFAULTPLAYERNAME) > 1)
	{ // Default Player Name
		// Open up Player Menu
		stuffcmd(enClient, "set scmenu_directmenu Options\n");
		stuffcmd(enClient, "togglemenu\n");
	}
	
	// Check for Dresk Reserved Aesthetic
	CheckReservedDreskAesthetic(enClient);
	
	// Assign Check CVar Time
	enClient.tClientCheckCVarTime = time + 2.0;
	
	// Send Customized CVars and Aliases
	SendSpidfliskRandomCustomizedCVarsAndAliases(enClient);
	
	// Reset Client Stats Scores
	ResetClientStatsScore(enClient);
	
	// Check for Disable Version Nagging
	if( cvar(CVAR_CLIENT_DISABLEVERSIONNAGGING) )
		enClient.version_nagtime = 0;
}
void CheckClientSpidfliskDisconnectEvents(entity enClient)
{ // Check ClientSpidflisk Disconnect Events
	// New Leave Message
	bprint (enClient.netname);
	bprint ("^7 left the ^1fray^7");
	if(self.frags != -666)
	{ // Display Frags (not spectator)
		bprint (" with ^2");
		bprint (ftos(enClient.frags));
		bprint ("^7 frags");
	}
	// Print Return
	bprint("\n");
	
	// Play Leaving Sound
	if(bUsingSpidfliskSoundPack)
		sound(world, CHAN_AUTO, "Spidflisk/misc/PlayerLeave.ogg", 1, ATTN_NONE);
	else
		sound(world, CHAN_AUTO, "misc/gib.wav", 1, ATTN_NONE);
	
	// Check for Weapon Laser
	if(self.exteriorweaponentity.enExteriorWeaponLaser)
		remove(self.exteriorweaponentity.enExteriorWeaponLaser);
		
	// Check for Long Jump Foot Entities
	if(self.enLongJump_LeftFoot)
		remove(self.enLongJump_LeftFoot);
	if(self.enLongJump_RightFoot)
		remove(self.enLongJump_RightFoot);
		
	// Reset Backup Frags
	self.nClientScore_BackupFrags = 0;
		
	// Reset Additional Client CVars
	GetCvars_handleFloat(-1, cvar_vid_conwidth, "vid_conwidth");
	GetCvars_handleFloat(-1, cvar_vid_conheight, "vid_conheight");
}
void CheckSpidfliskPlayerPreThinkEvents(entity enPlayer)
{ // Check Spidflisk Player PreThink Events
	// Check for Client CVars
	if(enPlayer.tClientCheckCVarTime > 0 && time >= enPlayer.tClientCheckCVarTime)
		CheckSpidfliskClientCVars(enPlayer);
		
	if(enPlayer.classname == "spectator" || enPlayer.classname == "observer")
	{ // Spectating; Disable Movement Prediction
		enPlayer.disableclientprediction = TRUE;
	}
	
	if(enPlayer.classname == "player")
	{ // Player
		if(enPlayer.health <= cvar(CVAR_PLAYER_BLEEDBELOWHEALTHLEVEL) )
			// Bleed
			enPlayer.modelflags = MF_GIB;
		else
			enPlayer.modelflags = 0;
	}
	
	if(enPlayer.classname == "observer")
	{ // Observer
		if(enPlayer.flags & FL_JUMPRELEASED)
		{ // Input Processing
			if(enPlayer.button5)
			{ // Crouch Pressed; Toggle Welcome Message
				// Suppress Additional Buttons
				enPlayer.flags = enPlayer.flags - FL_JUMPRELEASED;
				
				if(enPlayer.bHideWelcomeMessage)
				{ // Display Welcome Message
					enPlayer.bHideWelcomeMessage = FALSE;
					enPlayer.welcomemessage_time = 0;
				}
				else
				{ // Hide Welcome Message
					enPlayer.bHideWelcomeMessage = TRUE;
					// Purge Centerprint
					centerprint(enPlayer, "");
				}
			}
		}
		/*
		// NOTE: This must unfortunately be performed in the native PlayerPreThink function.
		else
		{ // Check for Input Reset
			if(!enPlayer.button5)
				// Reset Input
				enPlayer.flags = enPlayer.flags | FL_JUMPRELEASED;
		}
		*/
	}
}
void CheckSpidfliskJumpPadEvents(entity enJumpingEntity)
{ // Check Spidflisk Player JumpPad Events
	if(enJumpingEntity.classname == "player")
	{ // Player Events
		// Support Feedback Effect
		if( cvar(CVAR_JUMPPAD_PLAYERLIGHTFLASH) )
			te_smallflash(enJumpingEntity.origin);
			
		// Forcing LongJump on Jumppads
		ToggleLongJump(enJumpingEntity, TRUE);
			
		// Update Client Stats Score
		UpdateClientStatsScoreAward(enJumpingEntity, CLIENTSCORE_AWARD_NUMJUMPPADS, 1);
	}
	else
	{ // Not Player
		// Convert Flying Projectiles to Bouncing on Impact
		if(enJumpingEntity.movetype == MOVETYPE_FLY && cvar(CVAR_JUMPPAD_CONVERTFLYTOBOUNCE) )
		{ // Valid Projectile
			// Modify Movetype
			enJumpingEntity.movetype = MOVETYPE_BOUNCE;
			// Report Feature
			if(enJumpingEntity.owner.classname == "player")
				// Valid Player Owner
				HelpText_CustomFeature_JumppadConvertFlyToBounce(enJumpingEntity.owner);
		}
	
		// Check for "Stuck" Entity
		if( cvar(CVAR_JUMPPAD_STUCKOBJECTTRIGGERCOUNT) )
		{ // Valid Stuck Object Trigger Count
			// Increment Trigger Count
			enJumpingEntity.nNumJumppadTriggers = enJumpingEntity.nNumJumppadTriggers + 1;
			
			if(enJumpingEntity.nNumJumppadTriggers > cvar(CVAR_JUMPPAD_STUCKOBJECTTRIGGERCOUNT) )
			{ // Object is stuck; Remove
				if(enJumpingEntity.movetype == MOVETYPE_BOUNCE && enJumpingEntity.think)
				{ // Bounces and has Think Function; Call
					enJumpingEntity.nextthink = time;
				}
				else
					// Remove Entity
					remove(enJumpingEntity);
			}
		}
	}
}
void CheckSpidfliskPlayerPhysicsEvents(entity enClient)
{ // Check Spidflisk Player Physics Events
	if(enClient.fPlayerModelInheritViewAngleMultiplier != 0)
		// Inherit All View Angles
		enClient.angles = enClient.v_angle * enClient.fPlayerModelInheritViewAngleMultiplier;
}
float CheckSpidfliskPlayerSpeedMods(entity enPlayer, float fCurrentSpeed)
{ // Check Speed Mods
	if(enPlayer.FunFunc_nPlayerForm == FUNFORM_DEATHSPECTRE)
	{ // Death Spectre; Provide More Speed
		fCurrentSpeed = fCurrentSpeed * 2.0;
	}
	
	// Return Modded Speed
	return fCurrentSpeed;
}
void CheckSpidfliskPostPlayerJumpEvents(entity enPlayer)
{ // Check Spidflisk Post Player Jump Events
	// Report Help Text
	HelpText_Tip_BunnyHop(enPlayer);
	
	// Purge LongJump to Prevent Bunny Hopping Looking Stupid
	ToggleLongJump(enPlayer, FALSE);
	
	// Update Client Score
	UpdateClientStatsScore(enPlayer, CLIENTSCORE_NUMJUMPS, 1);
	
	// Play Footstep Sound for Jump
	if( cvar(CVAR_PLAYER_FOOTSTEPFORJUMP) )
	{ // Footstep for Jump
		local float steprandom;
		steprandom = random() * 2;
		if (steprandom < 1)
			sound (enPlayer, CHAN_AUTO, "misc/footstep01.wav", 1, ATTN_NORM);
		else
			sound (enPlayer, CHAN_AUTO, "misc/footstep02.wav", 1, ATTN_NORM);
	}
}