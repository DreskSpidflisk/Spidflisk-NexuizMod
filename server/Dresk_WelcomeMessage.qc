// DRESK - Welcome Message
// Provides definitions and default values for the Welcome Message System.

// Definitions

#define WELCOMEMESSAGE_CVARNAME_WIDTH										50
#define WELCOMEMESSAGE_CVARDESCRIPION_WIDTH									40

#define WELCOMEMESSAGE_CVARCHECK_GREATER									1
#define WELCOMEMESSAGE_CVARCHECK_LESSER										2
#define WELCOMEMESSAGE_CVARCHECK_EQUIVALENT									3

// Fields
.float bHideWelcomeMessage;

string AppendCVarStringToWelcomeMessage(string strWelcomeMessage, string strCVar, float nCheckType, string strHelpMessage, float nCheckEquivalentValue)
{ // Append CVarString to Welcome Message
	local float nSpacingNeeded;
	local float nSpacingCnt;
	// Acquire CVar Value
	local float fCVar;
		fCVar = cvar(strCVar);
		
	// Utilize New Default CVar Value Function
	local float fDefaultCVarValue;
	fDefaultCVarValue = stof(cvar_defstring(strCVar) );
	// Check if CVar is Different
	if(fCVar != fDefaultCVarValue)
	{ // CVar Different
		// Check Qualifying Condition
		if( (nCheckType == WELCOMEMESSAGE_CVARCHECK_GREATER && fCVar > fDefaultCVarValue)
		|| (nCheckType == WELCOMEMESSAGE_CVARCHECK_LESSER && fCVar < fDefaultCVarValue)
		|| (nCheckType == WELCOMEMESSAGE_CVARCHECK_EQUIVALENT && fCVar == nCheckEquivalentValue)
		)
		{ // Condition Qualified
			// Calculate Award Text Spacing Needed
			nSpacingNeeded = WELCOMEMESSAGE_CVARNAME_WIDTH - (strlen(strCVar) + strlen( cvar_string(strCVar) ) + 1);
			
			// Append Return
			strWelcomeMessage = strcat(strWelcomeMessage, "\n");
			
			for(nSpacingCnt = 0; nSpacingCnt < nSpacingNeeded; nSpacingCnt++)
				// Append Space
				strWelcomeMessage = strcat(strWelcomeMessage, " ");
			
			strWelcomeMessage = strcat(strWelcomeMessage, "^7", strCVar, " ^5", cvar_string(strCVar), "");
			
			// Append Help Message Spacing (Always)
			strWelcomeMessage = strcat(strWelcomeMessage, "^7 : ");
			
			if(strHelpMessage != "")
			{ // Append Help Message
				// Calculate Award Text Spacing Needed
				nSpacingNeeded = WELCOMEMESSAGE_CVARDESCRIPION_WIDTH - (strlen(strHelpMessage) );
					
				strWelcomeMessage = strcat(strWelcomeMessage, strHelpMessage);
				
				for(nSpacingCnt = 0; nSpacingCnt < nSpacingNeeded; nSpacingCnt++)
					// Append Space
					strWelcomeMessage = strcat(strWelcomeMessage, " ");
			}
			
		}
	}	
	
	// Return Modified Welcome Message
	return strWelcomeMessage;
}

string AppendModifiedGameRules(string strWelcomeMessage)
{ // Append Modified Game Rules
	strWelcomeMessage = strcat(strWelcomeMessage, "\n\n\n\n^7\bTHIS SERVER HAS MODIFIED GAME RULES\n\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_fullbrightplayers", WELCOMEMESSAGE_CVARCHECK_GREATER, "Players are 100% Bright", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_forced_respawn", WELCOMEMESSAGE_CVARCHECK_GREATER, "Automatic Respawn", 0);
		
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_weaponswitchdelay", WELCOMEMESSAGE_CVARCHECK_LESSER, "Quicker Weapon Switching", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_armor_stable", WELCOMEMESSAGE_CVARCHECK_GREATER, "Greater Base Armor Capacity", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_pickup_healthmega", WELCOMEMESSAGE_CVARCHECK_EQUIVALENT, "150 Health for Megahealth", 150);		
		
		// Weapons
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_nex_damage", WELCOMEMESSAGE_CVARCHECK_LESSER, "Less Nex Damage", 0);
		/*
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_crylink_primary_shots", WELCOMEMESSAGE_CVARCHECK_GREATER, "More Primary Crylink Shots");
		*/
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_throughfloor", WELCOMEMESSAGE_CVARCHECK_LESSER, "No Radius Damage Through Walls", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_projectiles_newton_style", WELCOMEMESSAGE_CVARCHECK_EQUIVALENT, "Simple Quake-Style Projectiles", 0);
		
		
		
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		// strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_grenadelauncher_secondary_damage", WELCOMEMESSAGE_DEFAULTCVARVALUE_MORTAR_SECONDARY_DAMAGE, "More Mortar #2 Damage");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_grenadelauncher_secondary_speed", WELCOMEMESSAGE_CVARCHECK_LESSER, "Slower #2 Mortars", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_grenadelauncher_secondary_refire", WELCOMEMESSAGE_CVARCHECK_LESSER, "Faster Mortar #2 Refire", 0);
		// strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "g_balance_grenadelauncher_secondary_ammo", , "Less Mortar #2 Ammo");
		
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "sv_gravity", WELCOMEMESSAGE_CVARCHECK_GREATER, "Stronger Gravity (more speed result)", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "sv_jumpvelocity", WELCOMEMESSAGE_CVARCHECK_GREATER, "Higher Jumping", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "sv_maxspeed", WELCOMEMESSAGE_CVARCHECK_GREATER, "More Running Speed", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "sv_maxairspeed", WELCOMEMESSAGE_CVARCHECK_GREATER, "Faster Bunny Hopping", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "sv_airaccelerate", WELCOMEMESSAGE_CVARCHECK_GREATER, "More Air Manipulation", 0);
		
		strWelcomeMessage = strcat(strWelcomeMessage, "\n");
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "sv_friction", WELCOMEMESSAGE_CVARCHECK_LESSER, "More Variety of Motion", 0);
		strWelcomeMessage = AppendCVarStringToWelcomeMessage(strWelcomeMessage, "edgefriction", WELCOMEMESSAGE_CVARCHECK_LESSER, "Unhindered Reduced Friction", 0);
		
	// Return String
	return strWelcomeMessage;
}

string AppendSpidfliskWelcomeMessageLines(string strWelcomeMessage, string strMutator, string strGameMode_Name)
{ // Append Spidflisk Welcome Message Lines
	// Output Host Information
		// Acquire Decolorized Hostname
		local string strHostname;
			strHostname = cvar_string("hostname");
			strHostname = strdecolorize(strHostname);
		strWelcomeMessage = strcat(strWelcomeMessage, "\nWelcome to ^1", strHostname, "^7");
		strWelcomeMessage = strcat(strWelcomeMessage, "\n(Server Nexiuz Version ^5", cvar_string("g_nexuizversion"), "^7)");
		// Display Potential Legacy Information
		#ifdef SPIDFLISK_SUPPORTLEGACYCLIENTS
		strWelcomeMessage = strcat(strWelcomeMessage, "\n\n^6THIS SERVER IS CURRENTLY RUNNING IN SPIDFLISK LEGACY MODE\nTO FULLY SUPPORT 2.2.3 CLIENTS^7");
		#endif
		// Output Returns
		strWelcomeMessage = strcat(strWelcomeMessage, "\n\n");
	// Output Modification Information
		strWelcomeMessage = strcat(strWelcomeMessage, "This Server is Running ^5", SPIDFLISK_VERSION, "^7 Modification by ^2Dresk");
	// Output Main Header
		strWelcomeMessage = strcat(strWelcomeMessage, "\n\n^1-------------------------------------------------------------");
	// Output Match Information
		strWelcomeMessage = strcat(strWelcomeMessage, "^8\n\nCurrent Game is '^1", strMutator, strGameMode_Name, "^8'\n");
	// Output Limit Information
		strWelcomeMessage = strcat(strWelcomeMessage, "^8Fraglimit '^1", cvar_string("fraglimit"), "^8', Timelimit '^1", cvar_string("timelimit"), "^8'\n");
	// Output Ticrate
		strWelcomeMessage = strcat(strWelcomeMessage, "^8\nServer Ticrate is '^1", ftos( rint(1 / cvar("sys_ticrate")) ), "^8' FPS");
	// Output Modified Game Rules
		strWelcomeMessage = AppendModifiedGameRules(strWelcomeMessage);
	// Output Suggestion
		strWelcomeMessage = strcat(strWelcomeMessage, "\n\n\n^1THE GOAL IS FASTER, MORE BALANCED GAMEPLAY");
		// strWelcomeMessage = strcat(strWelcomeMessage, "\nDO NOT BE AFRAID TO PLAY SERIOUSLY");
	// Output Footer
		strWelcomeMessage = strcat(strWelcomeMessage, "\n\n^7Questions?  Comments?\nSend Email to : ^2dresk@comcast.net");
		strWelcomeMessage = strcat(strWelcomeMessage, "\n\n\n");
		
	// Return String
	return strWelcomeMessage;
}