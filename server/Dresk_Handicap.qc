// DRESK - Handicap
// Provides Handicap functions and variables

// Handicap Definitions
#define HANDICAP_ALIAS_STRING								"spidflisk_handicap"

// Field / Global Definitions
.float fHandicap;
.float fHandicapChangeTime;

// Handicap Functions
float Handicap_GetModifiedDamage(entity enAttacker, entity enTarget, float fDamage)
{ // Return Modified Damage
	local float fDamageMultiplier;
	
	if(enAttacker.classname == "player" && enTarget.classname == "player")
	{ // Attacker and Target are Player; Calculate Handicap Damage
		if(enAttacker == enTarget)
		{ // Attacker is Target
			if(enAttacker.fHandicap > 100)
				// Self Damage and Greater Handicap; Cap to 100%
				fDamageMultiplier = 1;
			else
				// Handicap Performs Reduced Damage; Utilize Handicap
				fDamageMultiplier = (enAttacker.fHandicap / 100);
		}
		else
			// Standard Handicap Modifier
			fDamageMultiplier = (enAttacker.fHandicap / 100);
			
		// DEBUG
		/*
		local string strDebug;
			strDebug = strcat("Handicap Damage Multiplier : ", ftos(fDamageMultiplier), "\n");
		sprint(enAttacker, strDebug);
		*/
	}
	else
		// Standard Multiplication
		fDamageMultiplier = 1;
	
	// Return New Damage
	return(fDamage * fDamageMultiplier);
}
void Handicap_PrepareNewClient(entity enClient)
{ // Prepare New Client
	// Assign Default Handicap Value
	enClient.fHandicap = HANDICAP_DEFAULT_VALUE;
	enClient.fHandicapChangeTime = 0;
	
	// Assign Handicap Alias
	local string strHandicapAlias;
		strHandicapAlias = strcat("alias ", HANDICAP_ALIAS_STRING, " \"cmd ", HANDICAP_ALIAS_STRING, " $*\"\n");
	stuffcmd(enClient, strHandicapAlias);
}
float Handicap_GetPercentileHandicap()
{ // Return Percentile Handicap
	// NOTE: Assumed scope is player.
	
	return(self.fHandicap * 1);
}
void Handicap_CheckNewHandicap(string strHandicap)
{ // Check New Handicap
	local string strHandicapMessage;
	local string strBroadcastMessage;
	local float fPreviousHandicap;
	// Convert Handicap to Float
	local float fNewHandicap;
		fNewHandicap = stof(strHandicap);
		
	if( cvar(CVAR_PLAYER_HANDICAP_ALLOW) )
	{ // Handicap Allowed; Parse
		if(strHandicap == "")
		{ // No Handicap Provided; Report Usage
			strHandicapMessage = "Spidflisk Handicap : ^1Multiplies your total damage^7 by (Handicap / 100).\nTo specify Handicap, enter : spidflisk_handicap ^1MyDesiredHandicap";
			strHandicapMessage = strcat(strHandicapMessage, "\nYour Current Handicap is '^1", ftos(self.fHandicap), "^7'");
			strHandicapMessage = strcat(strHandicapMessage, "\nCurrent Minimum Handicap is '^1", cvar_string(CVAR_PLAYER_HANDICAP_MINIMUM), "^7'");
			strHandicapMessage = strcat(strHandicapMessage, "\nCurrent Maximum Handicap is '^1", cvar_string(CVAR_PLAYER_HANDICAP_MAXIMUM), "^7'\n");
		}
		else
		if(fNewHandicap < cvar(CVAR_PLAYER_HANDICAP_MINIMUM) )
			// Handicap Too Low; Report
			strHandicapMessage = strcat("Specified Handicap ^1TOO LOW^7; Current Minimum is '^1", cvar_string(CVAR_PLAYER_HANDICAP_MINIMUM), "^7'\n");
		else
		if(fNewHandicap > cvar(CVAR_PLAYER_HANDICAP_MAXIMUM) )
			// Handicap Too High; Report
			strHandicapMessage = strcat("Specified Handicap ^1TOO HIGH^7; Current Maximum is '^1", cvar_string(CVAR_PLAYER_HANDICAP_MAXIMUM), "^7'\n");
		else
		if(fNewHandicap == self.fHandicap)
			// Handicap is the Same; Report
			strHandicapMessage = "Specified Handicap ^1EQUIVALENT TO CURRENT^7\n";
		else
		{ // Handicap Valid
			if(time >= self.fHandicapChangeTime)
			{ // Handicap Change Allowed
				strHandicapMessage = strcat("New Handicap Assigned : ^2", strHandicap, "%^7\n");
				// Assign Previous Handicap
				fPreviousHandicap = self.fHandicap;
				// Assign Handicap
				self.fHandicap = fNewHandicap;
				// Update Handicap Change Time
				self.fHandicapChangeTime = time + cvar(CVAR_PLAYER_HANDICAP_CHANGETIME);
				
				// Broadcast Handicap Modification
				strBroadcastMessage = strcat(self.netname, "^7 HAS A ^1NEW HANDICAP^7 : ^2", strHandicap, "%^7");
				strBroadcastMessage = strcat(strBroadcastMessage, " (from ^2", ftos(fPreviousHandicap), "%^7)\n");
					bprint(strBroadcastMessage);
					
					// Play Broadcast Sound
					PlayBroadcastMessageSound();
			}
			else
			{ // Handicap Change Not Allowed
				strHandicapMessage = strcat("Handicap Modification Not Allowed; Please Wait '^1", ftos( rint(self.fHandicapChangeTime - time) ), "^7' Seconds\n");
			}
		}
	}
	else
		// Handicap Disabled
		strHandicapMessage = "Handicap Support is ^1DISABLED^7\n";
	
	// Report Message
	sprint(self, strHandicapMessage);
	// SuccessiveCenterprint(self, strHandicapMessage);
}
void CheckHandicapHelpBroadcast()
{ // Check Handicap Help Broadcast
	// Acquire Handicap Help Time
	local float nHandicapHelpTime;
		nHandicapHelpTime = cvar(CVAR_PLAYER_HANDICAP_DISPLAYHELPMESSAGETIME);
		
	if(nHandicapHelpTime > 0)
	{ // Valid Display Time
		if( math_mod(time, nHandicapHelpTime) == 0)
		{ // Display Necessary
			// Generate Display Message
			local string strDisplay;
				strDisplay = "Try the ^2Spidflisk Handicap System^7!\nEnter ^1spidflisk_handicap^7 in the console for more info\n";
				
			// Broadcast
			bprint(strDisplay);
			
			// Play Broadcast Sound
			PlayBroadcastMessageSound();
		}
	}
}