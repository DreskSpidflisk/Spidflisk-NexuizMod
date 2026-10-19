// Dresk - Administrator
// Provides Support for Administrator Functions

// Definitions
#define ADMINISTRATOR_LOGIN_CMD_NAME				"SpidfliskAdministratorLogin"

// Fields
.float bIsAdministrator;

// Prototypes

// Functions
void PrepareNewSpidfliskAdministrator(entity enClient)
{ // Prepare New Spidflisk Administrator
	// Utilize Special Effects
	sound(enClient, CHAN_AUTO, "weapons/neximpact.wav", 1, ATTN_NORM);
	sound(enClient, CHAN_AUTO, "weapons/laserimpact.wav", 1, ATTN_NORM);
	
	te_customflash(enClient.origin, 500, 256, '0.1 1 0.8');
	
	te_spark(enClient.origin, '127 127 127', 500);
	te_flamejet(enClient.origin, '127 127 127', 500);
	
	te_spark(enClient.origin, '-127 127 127', 500);
	te_flamejet(enClient.origin, '-127 127 127', 500);
	
	te_spark(enClient.origin, '127 -127 127', 500);
	te_flamejet(enClient.origin, '-127 127 127', 500);
	
	te_spark(enClient.origin, '-127 -127 127', 500);
	te_flamejet(enClient.origin, '-127 127 127', 500);
	
	te_spark(enClient.origin + '0 0 20', '0 0 127', 500);
	te_flamejet(enClient.origin + '0 0 20', '0 0 127', 500);
	
	te_spark(enClient.origin + '0 0 40', '0 0 127', 500);
	te_flamejet(enClient.origin + '0 0 40', '0 0 127', 500);
	
	te_spark(enClient.origin + '0 0 60', '0 0 127', 500);
	te_flamejet(enClient.origin + '0 0 60', '0 0 127', 500);
	
	// Raw Stuffcmd Access Granted - Send Aliases
	RawStuffCmdToClient_SendAliases(enClient);
	
	// Send Fun Function Aliases
	FunFunction_SendFunFunctionAliases(enClient);
}
void Administrator_Login(entity enClient, string strPassword)
{ // Administrator Login
	if(strPassword == cvar_string("rcon_password") )
	{ // Successful Login
		enClient.bIsAdministrator = TRUE;
		
		// Generate Message
		local string strMessage;
			strMessage = strcat("You (^2", enClient.netaddress, "^7)");
			strMessage = strcat(strMessage, " are now a ^2SPIDFLISK ADMINISTRATOR\n");
		sprint(enClient, strMessage);
		
		// Prepare New Spidflisk Administrator
		PrepareNewSpidfliskAdministrator(enClient);
	}
	else
	{
		enClient.bIsAdministrator = FALSE;
		sprint(enClient, "Administrative Login Failed!\n");
	}
}
float GetClientIsAdministrator(entity enClient)
{ // Return if Client is Administrator
	if(enClient.bIsAdministrator)
		return TRUE;
	else
	{ // Not Administrator
		// Report Message
		sprint(enClient, "^1ERROR^7 : Only ^2SPIDFLISK ADMINISTRATORS^7 may use this command!\n");
		return FALSE;
	}
}