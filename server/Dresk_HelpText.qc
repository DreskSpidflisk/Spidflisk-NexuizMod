// DRESK - Help Text
// Provides Help Text functions and variables

// HelpText Definitions
#define HELPTEXT_TIP_ROCKETALTFIRE_DEFAULT_DISPLAYS							0
#define HELPTEXT_TIP_BUNNYHOP_DEFAULT_DISPLAYS								0
#define HELPTEXT_CUSTOMFEATURE_CROUCHROF_DEFAULT_DISPLAYS					2
#define HELPTEXT_CUSTOMFEATURE_NEXDAMAGE_DEFAULT_DISPLAYS					1
#define HELPTEXT_CUSTOMFEATURE_LASERALTFIRE_DEFAULT_DISPLAYS				2
#define HELPTEXT_CUSTOMFEATURE_ELECTRONEWALTFIRE_DEFAULT_DISPLAYS			2
#define HELPTEXT_CUSTOMFEATURE_JPADCONVERTFLYTOBOUNCE_DEFAULT_DISPLAYS		2
#define HELPTEXT_CUSTOMFEATURE_UZIALTFIREPUSH_DEFAULT_DISPLAYS				2
#define HELPTEXT_CUSTOMFEATURE_ROCKETALTFIREDAMAGE_DEFAULT_DISPLAYS			2

#define HELPTEXT_SUPPRESSIONTIME											5
#define HELPTEXT_SPECTATEREPORT_SUPPRESSIONTIME								2

#define HELPTEXT_FEATURE_PRETEXT											"^5SPIDFLISK FEATURE^7 : "
#define HELPTEXT_TIP_PRETEXT												"^5TIP^7 : "

#define HELPTEXT_JUMP_TOPLAY												"^7Press ^5JUMP^7 to ^1Play"

#define HELPTEXT_ATTACK_TOSPECTATE											"^7Press ^5ATTACK^7 to ^1Spectate"
#define HELPTEXT_ATTACK_FORNEXTPLAYER										"^7Press ^5ATTACK^7 for ^1Next Player"

#define HELPTEXT_ATTACK2_FORFREEFLYMODE										"^7Press ^5ATTACK2^7 for ^1Free-Fly Mode"

#define HELPTEXT_CROUCH_TOGGLEWELCOMEMESSAGE								"^7Press ^5CROUCH^7 to ^1Toggle the Welcome Message"

// Field / Global Definitions
.float nHelpText_Tip_RocketAltFire;
.float nHelpText_Tip_BunnyHop;

.float nHelpText_CustomFeature_CrouchROF;
.float nHelpText_CustomFeature_NexDamage;
.float nHelpText_CustomFeature_LaserAltFire;
.float nHelpText_CustomFeature_ElectroNewAltFire;
.float nHelpText_CustomFeature_JumppadConvertFlyToBounce;
.float nHelpText_CustomFeature_UziAltFirePush;
.float nHelpText_CustomFeature_RocketAltFireDamage;

.float tHelpText_SuppressionTime;
.float tHelpText_SpectateReportSuppressionTime;

// HelpText Functions
void HelpText_ReportSpectateToTarget(entity enSpectator, entity enTarget, float bSpectatingNew)
{ // Report Spectate to Target
	// Acquire CVar
	local float nReportSpectate;
		nReportSpectate = cvar(CVAR_CLIENT_REPORTSPECTATETOTARGET);
		
	if(nReportSpectate)
	{ // Report Spectate Enabled
		// Check for Spectate Suppression Time
		if(time > enTarget.tHelpText_SpectateReportSuppressionTime)
		{ // Suppression Time Passed; Display
			// Generate Message
			local string strMessage;
			
			if(bSpectatingNew)
				strMessage = strcat(enSpectator.netname, "^7 is ^5SPECTATING^7 you");
			else
				strMessage = strcat(enSpectator.netname, "^7 is ^5NO LONGER SPECTATING^7 you");
				
			// Play Sound to Target
			stuffcmd(enTarget, "play2 weapons/tink1.ogg\n");
			
			// Determine Print Type
			if(nReportSpectate == 1)
			{ // sprint
				// Append Return
				strMessage = strcat(strMessage, "\n");
				
				// Print
				sprint(enTarget, strMessage);
			}
			else
				// centerprint
				SuccessiveCenterprint(enTarget, strMessage);
				
			// Update Suppression Time
			enTarget.tHelpText_SpectateReportSuppressionTime = time + HELPTEXT_SPECTATEREPORT_SUPPRESSIONTIME;
		}
	}
}
float HelpText_Message(entity enEntity, float nHelpTextCnt, float nHelpTextTotal, string strHelpText)
{ // Help Text - Message
	float nReturn;
	
	if(nHelpTextCnt < nHelpTextTotal)
	{ // Display HelpText
		if(time > enEntity.tHelpText_SuppressionTime)
		{ // Suppression Time Passed; Display
			SuccessiveCenterprint(enEntity, strHelpText);
			nReturn = nHelpTextCnt + 1;
			
			// Update Suppression Time
			enEntity.tHelpText_SuppressionTime = time + HELPTEXT_SUPPRESSIONTIME;
		}
		else
			// Suppression Time Still Existant
			nReturn = nHelpTextCnt;
	}
	else
		// Total Reached; No HelpText
		nReturn = nHelpTextTotal;
		
	// Return Updated HelpText Count
	return nReturn;
}
// ----------------------------------
//
// BEGIN HELPTEXT SPECIFIC FUNCTIONS
//
// ----------------------------------
void HelpText_CustomFeature_NexDamage(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "The Nex's damage\nhas been reduced from ^1140^7 to ^1");
		strHelp = strcat(strHelp, cvar_string("g_balance_nex_damage"));
		strHelp = strcat(strHelp, "^7!");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_NexDamage = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_NexDamage,
	HELPTEXT_CUSTOMFEATURE_NEXDAMAGE_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_Tip_BunnyHop(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_TIP_PRETEXT, "If you keep ^1jumping^7 when you land,\nyou will ^1gain velocity^7!");
		
	// Display HelpText
	enEntity.nHelpText_Tip_BunnyHop = HelpText_Message(enEntity, enEntity.nHelpText_Tip_BunnyHop,
	HELPTEXT_TIP_BUNNYHOP_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_CustomFeature_CrouchROF(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "Crouching on the ground ^1increases^7\nyour refire rate by ^1");
		strHelp = strcat(strHelp, cvar_string(CVAR_PLAYER_CROUCHATTACKREDUCTIONPERCENTILE), "%^7!");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_CrouchROF = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_CrouchROF,
	HELPTEXT_CUSTOMFEATURE_CROUCHROF_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_CheckCrouchROFDisplay(entity enEntity)
{ // Help Text - Check Crouch ROF Display
	if(enEntity.flags & FL_ONGROUND)
	{ // Client is On Ground
		if( cvar(CVAR_PLAYER_CROUCHATTACKREDUCTIONPERCENTILE) > 0)
		{ // Valid Reduction Time
			HelpText_CustomFeature_CrouchROF(enEntity);
		}
	}
}
void HelpText_CustomFeature_LaserAltFire(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "Laser Alternate Fire travels ^1");
		strHelp = strcat(strHelp, cvar_string(CVAR_WEAPON_LASER_ALTFIRESPEEDDIVISOR), "x^7 slower,\nbut has a ^1");
		strHelp = strcat(strHelp, cvar_string(CVAR_WEAPON_LASER_ALTFIRERADIUSMULTIPLIER), "x^7 greater radius and force!");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_LaserAltFire = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_LaserAltFire,
	HELPTEXT_CUSTOMFEATURE_LASERALTFIRE_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_Tip_RocketAltFire(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_TIP_PRETEXT, "You can ^1detonate^7 your Rockets\nin mid-air using ^2Alt-Fire^7!");
		
	// Display HelpText
	enEntity.nHelpText_Tip_RocketAltFire = HelpText_Message(enEntity, enEntity.nHelpText_Tip_RocketAltFire,
	HELPTEXT_TIP_ROCKETALTFIRE_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_CustomFeature_ElectroNewAltFire(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "The Electro Alternate Fire now\nfires at a ^1constant rate^7!^");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_ElectroNewAltFire = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_ElectroNewAltFire,
	HELPTEXT_CUSTOMFEATURE_ELECTRONEWALTFIRE_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_CustomFeature_JumppadConvertFlyToBounce(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "Projectiles now follow a\njumppad's ^1exact player path^7!");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_JumppadConvertFlyToBounce = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_JumppadConvertFlyToBounce,
	HELPTEXT_CUSTOMFEATURE_JPADCONVERTFLYTOBOUNCE_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_CustomFeature_UziAltFirePush(entity enEntity)
{ // Help Text Specific
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "Uzi Alternate Fire now\npushes you by ^1", ftos( cvar(CVAR_WEAPON_UZI_ALTFIREPUSHAMOUNT) ), "^7 when not crouching against your aim!");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_UziAltFirePush = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_UziAltFirePush,
	HELPTEXT_CUSTOMFEATURE_UZIALTFIREPUSH_DEFAULT_DISPLAYS, strHelp);
}
void HelpText_CustomFeature_RocketAltFireDamage(entity enEntity)
{ // Help Text Specific
	// Calculate CVar Displays
	local string strDamage;
		strDamage = ftos( rint( cvar(CVAR_WEAPON_ROCKETLAUNCHER_TRIGGER_DAMAGEMULTIPLIER) * 100) );
	local string strRadius;
		strRadius = ftos( rint( cvar(CVAR_WEAPON_ROCKETLAUNCHER_TRIGGER_RADIUSMULTIPLIER) * 100) );
	// Generate String
	local string strHelp;
		strHelp = strcat(HELPTEXT_FEATURE_PRETEXT, "Rocket ^2Alt-Fire^7 Explosions\nnow have ^1");
		strHelp = strcat(strHelp, strDamage, "%^7 Damage and ^1");
		strHelp = strcat(strHelp, strRadius, "%^7 Radius!");
		
	// Display HelpText
	enEntity.nHelpText_CustomFeature_RocketAltFireDamage = HelpText_Message(enEntity, enEntity.nHelpText_CustomFeature_RocketAltFireDamage,
	HELPTEXT_CUSTOMFEATURE_ROCKETALTFIREDAMAGE_DEFAULT_DISPLAYS, strHelp);
}