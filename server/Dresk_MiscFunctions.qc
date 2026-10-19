// DRESK - MiscFunctions
// Provides new miscenallenous functions.

// Fields

// Functions
float GetShouldBPrintBeSuppressed(float nPlayerCnt, float nBotCnt)
{ // Return if BPrint Should be Suppressed
	if( cvar(CVAR_MISC_SUPPRESSBPRINTSWHENNOPLAYERSORONLYBOTS) && (nPlayerCnt == 0 || nPlayerCnt == nBotCnt) )
		return TRUE;
	else
		return FALSE;
}
void CheckChatBubbleThinkEvents()
{ // Check Chat Bubble Think Events
	// NOTE: Assumed scope is Chat Bubble.
	// Apply Owner Alpha
	self.alpha = self.owner.alpha;
}
// Successive Centerprint Support Functions
void SuccessiveCenterprint(entity enReceiver, string strMessage)
{ // Successive Centerprint
	local string strFinalCenterprint;

	// Check if Successive Print is Necessary
	if(time < enReceiver.scp_tEndTime)
	{ // Successive Print Necessary; Append Message to Current Centerprint
		strFinalCenterprint = strcat(enReceiver.scp_strCenterprint, "\n");
		strFinalCenterprint = strcat(strFinalCenterprint, strMessage);
	}
	else
		strFinalCenterprint = strMessage;
		
	if(enReceiver.scp_bNeedsFree)
		// Unzone String
		strunzone(enReceiver.scp_strCenterprint);
	// Update Entity Centerprint
	enReceiver.scp_strCenterprint = strFinalCenterprint;
		// Zone String
		enReceiver.scp_strCenterprint = strzone(enReceiver.scp_strCenterprint);
		// Flag Needs Free
		enReceiver.scp_bNeedsFree = 1;
	
	// Update End Time
	enReceiver.scp_tEndTime = (time + enReceiver.scp_tPrintTime);

	// Send Centerprint
	centerprint(enReceiver, strFinalCenterprint);
}
string GetFormattedTimeStringZoned(float tTime)
{ // Return Formatted Time
	// Acquire Int Version of Time
	local float nTime;
		nTime = rint(tTime);
		
	local string strTime;
	// Calculate Minutes
	local float nMinutes;
		nMinutes = floor(nTime / 60);
		
	// Append Minutes to String
	/*
	if(nMinutes < 10)
		// Append Additional 0
		strTime = strcat("0", ftos(nMinutes) );
	else
	*/
		strTime = ftos(nMinutes);
	// Append :
	strTime = strcat(strTime, ":");
	
	// Calculate Seconds
	local float nSeconds;
		nSeconds = math_mod(nTime, 60);
	// Append Seconds to String
	if(nSeconds < 10)
		// Append Additional 0
		strTime = strcat(strTime, "0", ftos(nSeconds) );
	else
		strTime = strcat(strTime, ftos(nSeconds) );
	
	// Zone String
	strTime = strzone(strTime);
	
	// Return String
	return strTime;
}
void PlayBroadcastMessageSound()
{ // Play Broadcast Message Sound
	if(bUsingSpidfliskSoundPack)
		sound(world, CHAN_AUTO, "Spidflisk/misc/BroadcastChime.ogg", 1, ATTN_NONE);
	else
		sound(world, CHAN_AUTO, "weapons/tink1.ogg", 1, ATTN_NONE);
}

void CheckGameSettingsBroadcast()
{ // Check Game Settings Broadcast
	// Acquire Display Game Settings Time
	local float nDisplayGameSettingsTime;
		nDisplayGameSettingsTime = cvar(CVAR_MISC_DISPLAYGAMESETTINGSTIME);
		
	if(nDisplayGameSettingsTime > 0)
	{ // Valid Display Time
		if( math_mod(time, nDisplayGameSettingsTime) == 0)
		{ // Display Necessary
			// Generate Display Message
			local string strDisplay;
				strDisplay = strcat("Current Game '^1", gamemode_name, "^7', Fraglimit '^1", cvar_string("fraglimit"), "^7', Timelimit '^1", cvar_string("timelimit"), "^7'\n");
				
			// Broadcast
			bprint(strDisplay);
			
			// Play Game Settings Sound
			if(bUsingSpidfliskSoundPack)
				sound(world, CHAN_AUTO, "Spidflisk/misc/ClockRing.ogg", 1, ATTN_NONE);
			else
				// Play Broadcast Sound
				PlayBroadcastMessageSound();
		}
	}
}
string GetRandomGenericAmbientSound(float nPercentChance)
{ // Return Random Generic Ambient Sound
	local string strAmbientSound;
		strAmbientSound = "";
	local float nRandom;
	
	if( (random() * 100) <= nPercentChance)
	{ // Chance Succeeded
		nRandom = random() * 9;
		
		if(nRandom < 1)
			strAmbientSound = "ambient/machine1.ogg";
		else
		if(nRandom < 2)
			strAmbientSound = "ambient/machine2.ogg";
		else
		if(nRandom < 3)
			strAmbientSound = "ambient/machine3.ogg";
		else
		if(nRandom < 4)
			strAmbientSound = "ambient/machine4.ogg";
		else
		if(nRandom < 5)
			strAmbientSound = "ambient/machinerydrone01.ogg";
		else
		if(nRandom < 6)
			strAmbientSound = "ambient/air.ogg";
		else
		if(nRandom < 7)
			strAmbientSound = "ambient/transformer.ogg";
		else
		if(nRandom < 8)
			strAmbientSound = "ambient/fan4.ogg";
		else
			strAmbientSound = "ambient/demonwind01.ogg";
	}
		
	return strAmbientSound;
}
void SpawnAdditionalAmbientSound(entity enEntity)
{ // Spawn Additional Ambient Sound
	// NOTE: Assumed scope is origin entity.
	local float fVolume;
		fVolume = 1.00;
	local string strAmbientSound;
		strAmbientSound = "";
	
	if(enEntity.classname == "item_health100")
		strAmbientSound = "ambient/water.ogg";
	else
	if(enEntity.classname == "weapon_nex")
	{
		strAmbientSound = "ambient/sparks.ogg";
		fVolume = 0.6;
	}
	else
	if(enEntity.classname == "weapon_crylink")
	{
		strAmbientSound = "ambient/sparks1.ogg";
		fVolume = 0.3;
	}
	else
	if(enEntity.classname == "weapon_rocketlauncher")
		strAmbientSound = "ambient/machine2.ogg";
	else
	if(enEntity.classname == "weapon_electro")
		strAmbientSound = "ambient/air.ogg";
	else
	if(enEntity.classname == "weapon_hagar")
		strAmbientSound = "ambient/machine3.ogg";
	else
	if(enEntity.classname == "weapon_grenadelauncher")
		strAmbientSound = "ambient/machinerydrone01.ogg";
	else
	if(enEntity.classname == "weapon_uzi")
		strAmbientSound = "ambient/fan4.ogg";
	else
	if(enEntity.classname == "item_armor25")
		strAmbientSound = "ambient/machine4.ogg";
	else
	if(enEntity.classname == "item_strength")
		strAmbientSound = "ambient/ambient_07.ogg";
	else
	if(enEntity.classname == "item_health25")
		strAmbientSound = GetRandomGenericAmbientSound(100);
	else
	if(enEntity.classname == "item_armor1")
		strAmbientSound = GetRandomGenericAmbientSound(45);
	else
	if(enEntity.classname == "item_health1")
		strAmbientSound = GetRandomGenericAmbientSound(45);
	else
	if(enEntity.classname == "spawnpoint_model")
		strAmbientSound = "ambient/machine1.ogg";
		
	// Spawn Ambient Sound
	if(strAmbientSound != "")
	{ // Valid Ambient Sound
		// Increment Number of Spawned Ambient Sounds
		nNumSpawnedAmbientSounds = nNumSpawnedAmbientSounds + 1;
		// Spawn Sound
		ambientsound(enEntity.origin + '0 0 15', strAmbientSound, fVolume, ATTN_NORM);
	}
}
void CheckAdvancedDeathReports(entity enAttacker, entity enVictim)
{ // Check Advanced Death Reports

	// -----------------------------------------------------
	// Report: Attacker
	
	local string strAttackerMessage;
	local string strVictimHandicap;
	local string strVictimPing;
	
	// Acquire Victim Handicap (as percentile)
	strVictimHandicap = ftos( rint(enVictim.fHandicap) );
		// Zone String
		strVictimHandicap = strzone(strVictimHandicap);
		
	// Acquire Victim Ping
	strVictimPing = ftos( rint(enVictim.ping) );
		// Zone String
		strVictimPing = strzone(strVictimPing);
		
	// Generate Attacker Message
	strAttackerMessage = strcat("^4You fragged ^7", enVictim.netname);
	if( cvar(CVAR_PLAYERDEATH_SHOWVICTIMPING) )
	{ // Show Victim Ping
		if( clienttype(enVictim) == CLIENTTYPE_BOT)
			// Bot : Display Name
			strAttackerMessage = strcat(strAttackerMessage, "\n^7(^2Bot");
		else
			// Player : Display Ping
			strAttackerMessage = strcat(strAttackerMessage, "\n^7(Ping ^2", strVictimPing);
		
		if( cvar(CVAR_PLAYER_HANDICAP_SHOWATTACKERVICTIMHANDICAP) )
			// Show Attacker Handicap
			strAttackerMessage = strcat(strAttackerMessage, "^7 / Handicap ^2", strVictimHandicap, "%");
			
		strAttackerMessage = strcat(strAttackerMessage, "^7)");
	}
		
	// Shift centerprint vertically
	strAttackerMessage = strcat(strAttackerMessage, "\n\n");
	
	// Print Message to Attacker
	SuccessiveCenterprint(enAttacker, strAttackerMessage);
	
	// Unzone Strings
	strunzone(strVictimHandicap);
	strunzone(strVictimPing);
	
	// -----------------------------------------------------
	// Report : Victim
	
	local string strTargetMessage;
	local string strAttackerHealth;
	local float nAttackerHealth;
	local string strAttackerArmor;
	local string strAttackerPing;
	local string strAttackerHandicap;
	
	// Acquire Attacker Health String
	nAttackerHealth = rint(enAttacker.health);
	if(nAttackerHealth < 0)
		nAttackerHealth = 0;
	strAttackerHealth = ftos(nAttackerHealth);
		// Zone String
		strAttackerHealth = strzone(strAttackerHealth);
	// Acquire Attacker Handicap (as percentile)
	strAttackerHandicap = ftos( rint(enAttacker.fHandicap) );
		// Zone String
		strAttackerHandicap = strzone(strAttackerHandicap);
	// Acquire Attacker Armor String
	strAttackerArmor = ftos( rint(enAttacker.armorvalue) );
		// Zone String
		strAttackerArmor = strzone(strAttackerArmor);
	// Acquire Attacker Ping
	strAttackerPing = ftos( rint(enAttacker.ping) );
		// Zone String
		strAttackerPing = strzone(strAttackerPing);
	
	strTargetMessage = strcat(strTargetMessage, "^1Fragged by ^7", enAttacker.netname, "\n");
	
	if( cvar(CVAR_PLAYERDEATH_SHOWATTACKERPING) )
	{ // Show Attacker Ping
		if( clienttype(enAttacker) == CLIENTTYPE_BOT)
			// Bot : Display Name
			strTargetMessage = strcat(strTargetMessage, " ^7(^2Bot");
		else
			// Player : Display Ping
			strTargetMessage = strcat(strTargetMessage, " ^7(Ping ^2", strAttackerPing);
	}
	if( cvar(CVAR_PLAYER_HANDICAP_SHOWATTACKERVICTIMHANDICAP) )
		// Show Attacker Handicap
		strTargetMessage = strcat(strTargetMessage, "^7 / Handicap ^2", strAttackerHandicap);
		
	strTargetMessage = strcat(strTargetMessage, "%^7)");
		
	if( cvar(CVAR_PLAYERDEATH_SHOWATTACKERHEALTHARMOR) )
	{ // Show Attacker Health / Armor
		strTargetMessage = strcat(strTargetMessage, "\n^7(Health ^2", strAttackerHealth);
		strTargetMessage = strcat(strTargetMessage, "^7 / Armor ^2");
		strTargetMessage = strcat(strTargetMessage, strAttackerArmor, "^7)");
	}
	
	// Print Message to Victim
	SuccessiveCenterprint(enVictim, strTargetMessage);
	
	// Unzone Strings
	strunzone(strAttackerHealth);
	strunzone(strAttackerArmor);
	strunzone(strAttackerHandicap);
	strunzone(strAttackerPing);
}
void CheckSpidfliskWorldSpawnEvents()
{ // Check Spidflisk World Spawn Events
	// Prepare Modification Custom CVars
	PrepareCustomCVars();
	
	// Spawn Client Score Award Entities
	SpawnClientScoreAwardEntities();
	
	// Precache Additional Sounds
	precache_sound ("misc/menu2.wav");
	precache_sound ("misc/invshot.wav");
	precache_sound ("weapons/tink1.ogg");
	precache_sound ("misc/outwater.wav");
	precache_sound ("misc/medplat2.wav");
	precache_sound ("misc/footstep01.wav");
	precache_sound ("misc/footstep02.wav");
	precache_sound ("weapons/neximpact.wav");
	
	// Precache Additional Models
	precache_model("models/plasmatrail.mdl");
	precache_model("models/misc/line-81-1.mdl");
	
	// Additional Ambient Sound Precaching
	if( cvar(CVAR_MISC_SPAWNADDITIONALAMBIENTSOUNDS) )
	{
		precache_sound ("ambient/air.ogg");
		precache_sound ("ambient/water.ogg");
		precache_sound ("ambient/sparks.ogg");
		precache_sound ("ambient/sparks1.ogg");
		precache_sound ("ambient/machine1.ogg");
		precache_sound ("ambient/machine2.ogg");
		precache_sound ("ambient/machine3.ogg");
		precache_sound ("ambient/machine4.ogg");
		precache_sound ("ambient/ambient_07.ogg");
		precache_sound ("ambient/machinerydrone01.ogg");
		precache_sound ("ambient/fan4.ogg");
		precache_sound ("ambient/demonwind01.ogg");
		precache_sound ("ambient/transformer.ogg");
	}
	
	// Spawn Point Models
	if( cvar(CVAR_MISC_CREATESPAWNPOINTMODELS) )
		precache_model("models/domination/dom_unclaimed.md3");
		
	if( cvar(CVAR_MISC_USESPIDFLISKSOUNDPACK) )
	{ // Spidflisk Sound Pack Utilized; Precache Additional Sounds
		// Assign Global Flag
		bUsingSpidfliskSoundPack = TRUE;
		
		// Precache Additional Sounds
		precache_sound("Spidflisk/misc/BroadcastChime.ogg");
		precache_sound("Spidflisk/misc/ClockRing.ogg");
		precache_sound("Spidflisk/misc/GameEnd1.ogg");
		precache_sound("Spidflisk/misc/GameEnd2.ogg");
		precache_sound("Spidflisk/misc/PlayerJoin.ogg");
		precache_sound("Spidflisk/misc/PlayerLeave.ogg");
		precache_sound("Spidflisk/misc/FunForm_ChangeForm.ogg");
	}
	else
		bUsingSpidfliskSoundPack = FALSE;
}
void CheckSpidfliskWorldRulesEvents()
{ // Check Spidflisk World Rules Events
	// Check for Potential Suppressed BPrints
	local float bNewBPrintsSuppressed;
		bNewBPrintsSuppressed = GetShouldBPrintBeSuppressed(player_count, currentbots);
		
	if(bNewBPrintsSuppressed != bBPrintsCurrentlySuppressed)
	{ // BPrints Suppressed Changed; Report
		if(bNewBPrintsSuppressed)
			bprint("^1NO PLAYERS / ONLY BOTS IN SERVER; SUPPRESSING BPRINTS...\n");
		else
			bprint("^1PLAYERS IN SERVER; ENABLING BPRINTS...\n");
			
		// Assign New BPrints Currently Suppressed
		bBPrintsCurrentlySuppressed = bNewBPrintsSuppressed;
	}
	
	// Report Game Fraglimit / Timelimit
	// Check for Potential Suppressed BPrints
	if(!bBPrintsCurrentlySuppressed)
	{ // Provide BPrints
		CheckGameSettingsBroadcast();
		// Report Bots Fill
		CheckBotsFillBroadcast();
		// Report Handicap Help
		CheckHandicapHelpBroadcast();
	}
}