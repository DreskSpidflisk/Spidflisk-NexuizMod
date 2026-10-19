// DRESK - Bots
// Provides extended functions for bots.

void PlayBroadcastMessageSound();

/*
void BroadcastPlayerCountInformation()
{ // Print Player Count Information
	local entity enPlayer;
	local float nEntityBotCount;
	local float nEntityClientCount;
		nEntityBotCount = 0;
		nEntityClientCount = 0;
		
	// Acquire Initial Player
	enPlayer = find(world, classname, "player");
	while (enPlayer)
	{ // Traverse Players
		if ( clienttype(enPlayer) == CLIENTTYPE_BOT)
			// Bot Located; Increment
			nEntityBotCount++;
		else
		if( clienttype(enPlayer) == CLIENTTYPE_REAL)
			// Client Located; Increment
			nEntityClientCount++;
			
		// Acquire Next Player
		enPlayer = find(enPlayer, classname, "player");
	}
	
	// Generate String
	local string strMessage;
	strMessage = strcat("Entity Bot Count : ", ftos(nEntityBotCount), "\nEntity Client Count : ", ftos(nEntityClientCount), "\n");
	strMessage = strcat(strMessage, "Global Bot Count : ", ftos(nBotCount), "\nGlobal Player Count : ", ftos(player_count), "\n");
	strMessage = strcat(strMessage, "nSpectatorCount : ", ftos(nSpectatorCount), "\nnNonSpectatorCount : ", ftos(nNonSpectatorCount), "\n");
	
	sprint(self, strMessage);
	// bprint(strMessage);
}
float GetCurrentBotCountFromEntities()
{ // Return Current Bot Count
	local entity enPlayer;
	local float nEntityBotCount;
	
	// Acquire Initial Player
	enPlayer = find(world, classname, "player");
	while (enPlayer)
	{ // Traverse Players
		if ( clienttype(enPlayer) == CLIENTTYPE_BOT)
			// Bot Located; Increment
			nEntityBotCount++;
			
		// Acquire Next Player
		enPlayer = find(enPlayer, classname, "player");
	}
	
	// Return Bot Count
	return nEntityBotCount;
}
float GetRequiredBotsCount()
{ // Return Required Bots Count
	// NOTE: Integrated logic into one function for performance reasons.
	/*
	local entity enPlayer;
	local float nBotCount;
	local float nClientCount;
		nBotCount = 0;
		nClientCount = 0;
		
	// Acquire Initial Player
	enPlayer = find(world, classname, "player");
	while (enPlayer)
	{ // Traverse Players
		if ( clienttype(enPlayer) == CLIENTTYPE_BOT)
			// Bot Located; Increment
			nBotCount++;
		else
		if( clienttype(enPlayer) == CLIENTTYPE_REAL)
			// Client Located; Increment
			nClientCount++;
			
		// Acquire Next Player
		enPlayer = find(enPlayer, classname, "player");
	}
	// * / GOES HERE
	
	
	
	// Acquire Required Bot Count
	local float nRequiredBots;
	
	if( cvar(CVAR_BOT_BASECOUNTINCLUDESSPECTATORS) )
		// Base Count Includes Spectators
		// nRequiredBots = cvar(CVAR_BOT_FILLBOTSBASECOUNT) - ( (nSpectatorCount + nNonSpectatorCount) - nBotCount);
		nRequiredBots = cvar(CVAR_BOT_FILLBOTSBASECOUNT) - (player_count - nBotCount);
	else
		// Base Count ONLY Non-Spectators
		nRequiredBots = cvar(CVAR_BOT_FILLBOTSBASECOUNT) - (nNonSpectatorCount - nBotCount);
		
		if(nRequiredBots < 0)
			nRequiredBots = 0;
			
	
	// local string strDebug;
		// strDebug = strcat("'", ftos(nBotCount), "' Bots, '", ftos(player_count), "' Total Players, '", ftos(nRequiredBots), "' Required\n");
		// bprint(strDebug);
			
	// Return Required Bots
	return nRequiredBots;
}
void CheckBotFill()
{ // Check Bot Fill
	if( cvar(CVAR_BOT_FILLBOTSBASECOUNT) > 0)
	{ // Valid FillBotsBase Count; Parse
		/*
		// Acquire Current Bot Count
		local float nBotCount;
			nBotCount = GetCurrentBotCount();
			
		// Acquire Actual Player Count (non bots)
		local float nActualPlayerCount;
			nActualPlayerCount = player_count - nBotCount;
			
		// Acquire Required Bot Count
		local float nRequiredBots;
			nRequiredBots = cvar(CVAR_BOT_FILLBOTSBASECOUNT) - nActualPlayerCount;
		if(nRequiredBots < 0)
			nRequiredBots = 0;
		// * / GOES HERE
		
		// Spawn / Despawn Bots
			// Assign Skill
			cvar_set("skill", cvar_string(CVAR_BOT_FILLBOTSSKILL) );
			// Spawn Bots
			cvar_set("bot_number", ftos( GetRequiredBotsCount() ) );
	}
}
void PrintBotInformation()
{ // Print Bot Information
	local string strDebug;
	
	// Acquire Normal Required Bot Count
	strDebug = strcat("Required Bot Count : ", ftos(GetRequiredBotsCount()), "\n");
	// Acquire Current Bot Count	
		local float nEntityBotCount;
			nEntityBotCount = GetCurrentBotCountFromEntities();
		strDebug = strcat(strDebug, "Entity Bot Count : ", ftos(nEntityBotCount), "\n");
			
	// Acquire Actual Player Count (non bots)
		local float nActualPlayerCount;
			nActualPlayerCount = player_count - nEntityBotCount;
			
			strDebug = strcat(strDebug, "Total Player Count : ", ftos(nActualPlayerCount), "\n");
			
	// Acquire Required Bot Count
		local float nRequiredBots;
			nRequiredBots = cvar(CVAR_BOT_FILLBOTSBASECOUNT) - nActualPlayerCount;
		if(nRequiredBots < 0)
			nRequiredBots = 0;
			
			strDebug = strcat(strDebug, "Required Bots : ", ftos(nRequiredBots), "\n");
		
		bprint(strDebug);
}
float CheckClientCommandBotSay(string strCommand)
{ // Check Client Command Bot Say
	// NOTE: Scope assumed under issuer of command.
	local float fReturn;
		// Default to Suppress Say
		fReturn = 0;
		
	// Tokenize Command
	tokenize(strCommand);
	
	if(argv(1) == "playercount")
		BroadcastPlayerCountInformation();
	else
	if(argv(1) == "botinfo")
		PrintBotInformation();
	else
		// Do NOT Suppress Say
		fReturn = 1;
		
	return fReturn;
	
	/*
	if(time >= self.fClientNextBotModificationTime)
	{ // Modification Allowed
		if(argv(1) == "bots")
		{ // Bot Statement Issued
			// Acquire Number of Bots
			local float nNumBots;
				nNumBots = rint( stof( argv(2) ) );
				
			// Validate Number of Bots
			if(nNumBots < 0)
				nNumBots = 0;
			else
			if(nNumBots > 4)
				nNumBots = 4;
				
			// Update Bot Modification Time
			self.fClientNextBotModificationTime = time + 30;
				
			cvar_set("bot_number", ftos(nNumBots) );
		}
	}
	else
	{ // Modification Not Allowed
		// Report Message to Client
		sprint(self, "You may not modify the bots at this time.\n");
	}
	// * / GOES HERE
}
*/
void CheckBotsFillBroadcast()
{ // Check Bots Fill Broadcast
	// Acquire Display Bots Fill Time
	local float nDisplayBotsFillTime;
		nDisplayBotsFillTime = cvar(CVAR_BOT_DISPLAYBOTSFILLTIME);
		
	if(nDisplayBotsFillTime > 0)
	{ // Valid Display Time
		if( math_mod(time, nDisplayBotsFillTime) == 0)
		{ // Display Necessary
			// Generate Display Message
			local string strDisplay;
				strDisplay = strcat("Bots Filling at Skill '^1", cvar_string("skill"), "^7' for '^1", cvar_string("minplayers"), "^7' Base Player Count\n");
				
			// Broadcast
			bprint(strDisplay);
			
			// Play Broadcast Sound
			PlayBroadcastMessageSound();
		}
	}
}