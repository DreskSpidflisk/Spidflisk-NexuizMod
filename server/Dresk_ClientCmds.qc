// Dresk - Cmds
// Provides Support for Cmd Functions

// Fields

// Functions
float CheckSpidfliskClientCmds(entity enClient, string strCommandString)
{ // Check Spidflisk Client Cmds
	// NOTE: Returns true if command parsed
	local float bParsed;
		bParsed = TRUE;
	
	if (argv(0) == HANDICAP_ALIAS_STRING)
		// Check New Handicap
		Handicap_CheckNewHandicap( argv(1) );
	else
	if( argv(0) == "playermodel")
	{ // Player Model
		// Execute Command
		clientcommand(enClient, strCommandString);
		
		// Check Reserved Dresk Aesthetic
		CheckReservedDreskAesthetic(enClient);
	}
	else
	if( argv(0) == RAWSTUFFCMDTOCLIENT_CMD_NAME)
		// Raw StuffCmd to Client
		RawStuffCmdToClient_SendStuffCmd();
	else
	if( argv(0) == ADMINISTRATOR_LOGIN_CMD_NAME)
		Administrator_Login(self, argv(1) );
	else
	if( argv(0) == FUNFUNCTION_TOGGLEPLAYERBLOODSHOWERTHINK_CMD_NAME)
		// Toggle Player Bloodshower Think
		FunFunction_TogglePlayerBloodShowerThink();
	else
	if( argv(0) == FUNFUNCTION_TOGGLEPLAYERFORM_CMD_NAME)
		// Toggle Player Form
		FunFunction_TogglePlayerForm(self, argv(1) );
	else
		bParsed = FALSE;
		
	// Return Parsed
	return bParsed;
}