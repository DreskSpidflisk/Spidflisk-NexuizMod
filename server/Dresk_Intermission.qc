// DRESK - Intermission
// Provides definitions and default values for Intermission features.

// Support Intermission View Bubbles
// .entity enIntermissionViewBubbleHUD_1;
// .entity enIntermissionViewBubbleHUD_2;
.entity enIntermissionViewBubbleHUD_3;

// Support Intermission Winner
.entity enIntermissionWinner;

.float bIntermissionViewModel_NoDraw;

void IntermissionViewBubbleThink()
{ // Intermission View Bubble Think
	// Remove EF_NODRAW
	self.effects = self.effects - (self.effects & EF_NODRAW);
	// Increase Alpha
	self.alpha = self.alpha + 0.1;
	
	if(self.alpha >= 1)
	{ // Finished Fading In; Disable Think
		// Disable Weapon Draw of Owner
		if(self.owner.weaponentity)
			// Valid Weapon Entity
			self.owner.weaponentity.bIntermissionViewModel_NoDraw = TRUE;
		// Fully Render Bubble
		self.alpha = 1;
		// Disable Think Operations
		self.think = SUB_Null;
		self.nextthink = 0;
	}
	else
		// Assign Next Think Time
		self.nextthink = time + 0.1;
}
void IntermissionWinningPlayerThink()
{ // Intermission Winning Player Think
	// Decrease Alpha
	self.alpha = self.alpha - 0.1;
	// Shift Origin
	self.origin_x = self.origin_x + 4;
	// self.origin_y = self.origin_y - 11;
	self.origin_z = self.origin_z - 2;
	
	if(self.alpha < 0.4)
	{ // Fade Finished
		// Disable Think Operations
		self.think = SUB_Null;
		self.nextthink = 0;
		// Update
		self.frame = $duckidle;
	}
	else
		// Assign Next Think Time
		self.nextthink = time + 0.1;
}
entity SpawnIntermissionViewBubble(entity enClient, vector vOrigin)
{ // Spawn Intermission View Bubble
	local entity enBubble;
	// Spawn Entity
	enBubble = spawn();
	// Assign Alpha
	enBubble.alpha = 0;
	// Assign Model
	setmodel(enBubble, "models/domination/dom_unclaimed.md3");
	// Assign Solidity
	enBubble.solid = SOLID_NOT;
	// Assign Owner
	enBubble.owner = enClient;
	// Assign View Model
	enBubble.viewmodelforclient = enClient;
	// Assign Effects
	enBubble.effects = EF_FULLBRIGHT | EF_NODRAW;
	// Assign Origin
	enBubble.origin = vOrigin;
	// Assign Scale
	enBubble.scale = 16;
	// Assign Colormod
	enBubble.colormod = '0.01 0.01 0.01';
	
	// Assign Initial Next Think
	enBubble.nextthink = time + 3.0;
	// Assign Think
	enBubble.think = IntermissionViewBubbleThink;
	
	// Return Entity
	return enBubble;
}
void SpawnIntermissionViewBubbles(entity enClient)
{ // Spawn Intermission View Bubbles
	// Spawn Entities
	// enClient.enIntermissionViewBubbleHUD_1 = SpawnIntermissionViewBubble(enClient, '40 0 0');
	//enClient.enIntermissionViewBubbleHUD_2 = SpawnIntermissionViewBubble(enClient, '80 0 0');
	enClient.enIntermissionViewBubbleHUD_3 = SpawnIntermissionViewBubble(enClient, '210 0 0');
}
void SpawnIntermissionWinningPlayer(entity enClient)
{ // Check Intermission Winning Player
	// Determine Winning Player
	local entity enPlayerFind;
	local entity enWinner;
	local float nFrags;
		nFrags = -999;
	enPlayerFind = find(world, classname, "player");
	while(enPlayerFind)
	{ // Search Players
		if(enPlayerFind.frags > nFrags)
		{ // New Winner
			enWinner = enPlayerFind;
			// Update Frags
			nFrags = enPlayerFind.frags;
		}
		// Acquire Next Player
		enPlayerFind = find(enPlayerFind, classname, "player");
	}
	
	local entity enViewmodel;
	// Spawn Entity
	enViewmodel = spawn();
	// Assign Entity to Client
	enClient.enIntermissionWinner = enViewmodel;
	// Assign Model Aesthetics
	enViewmodel.model = enWinner.model;
	enViewmodel.modelindex = enWinner.modelindex;
	enViewmodel.skin = enWinner.skin;
	// Assign Alpha
	enViewmodel.alpha = 1.0;
	// Assign Frame
	enViewmodel.frame = $taunt;
	// Assign Solidity
	enViewmodel.solid = SOLID_NOT;
	// Assign Owner
	enViewmodel.owner = enClient;
	// Assign View Model
	enViewmodel.viewmodelforclient = enClient;
	// Assign Effects
	enViewmodel.effects = EF_FULLBRIGHT;
	// Assign Angles
	enViewmodel.angles = '0 180 0';
	// Assign Origin
	enViewmodel.origin = '85 0 -20';
	// Assign Colormod
	enViewmodel.colormod = enWinner.colormod;
	// Assign Colormap
	enViewmodel.colormap = enWinner.colormap;
	// Force Weapon Viewmodel Display Off
	if(enClient.weaponentity)
		enClient.weaponentity.bIntermissionViewModel_NoDraw = TRUE;
	
	// Assign Initial Next Think
	enViewmodel.nextthink = time + 3.0;
	// Assign Think
	enViewmodel.think = IntermissionWinningPlayerThink;
	
	// Attach Skull to Hand
	/*
	local entity enSkull;
	// Spawn Entity
	enSkull = spawn();
	// Assign Model
	enSkull.owner = enViewmodel;
	// Assign Model
	setmodel(enSkull, "models/gibs/bloodyskull.md3");
	// Assign Effects
	enSkull.effects = EF_FULLBRIGHT;
	// Attach Model
	setattachment(enSkull, enSkull.owner, "bip01 r hand");
	*/
}
void CheckIntermissionViewmodelEntities()
{ // Check Intermission Viewmodel Entities
	// Check for Supported Intermission Entities
	local float bFadeToBlack;
		bFadeToBlack = cvar(CVAR_INTERMISSION_FADETOBLACK);
	local float bDisplayWinner;
		bDisplayWinner = cvar(CVAR_INTERMISSION_DISPLAYWINNINGPLAYER);
	if(bFadeToBlack
		|| bDisplayWinner)
	{ // Intermission Entity Supported
		local entity enClient;
		
		// Acquire Initial Client
		// NOTE: Use findchainflags to apply to spectators as well
		enClient = world;
		enClient = findchainflags(flags, FL_CLIENT);
		
		while(enClient)
		{ // Print Client
			if( clienttype(enClient) == CLIENTTYPE_REAL)
			{ // Valid Client; Spawn Intermission View Bubbles
				if(bFadeToBlack)
					SpawnIntermissionViewBubbles(enClient);
				if(bDisplayWinner)
					SpawnIntermissionWinningPlayer(enClient);
			}
			
			// Acquire Next Client
			enClient = enClient.chain;
		}
	}
}
void CheckIntermissionPlayerGlow()
{ // Check Intermission Player Glow
	if( cvar(CVAR_INTERMISSION_PLAYERSGLOW) )
	{ // Players Glow Enabled
		local entity enPlayerFind;
		local vector vColor;
		// Utilize Random Glow Colors
			vColor_x = random();
			vColor_y = random();
			vColor_z = random();
		
		// Acquire First Player
		// NOTE: Use classname to suppress glowing of spectators
		enPlayerFind = find(world, classname, "player");
		
		while(enPlayerFind != world)
		{ // Valid Player
			// Apply Glow
			enPlayerFind.pflags = PFLAGS_NOSHADOW | PFLAGS_FULLDYNAMIC;
			enPlayerFind.light_lev = 5000;
			enPlayerFind.color = vColor;
			// enPlayerFind.color = '0.75 0.1 0.1';
			enPlayerFind.style = 6;
		
			// Acquire Next Player
			enPlayerFind = find(enPlayerFind, classname, "player");
		}
	}
}
void DisplayIntermissionVictoryMessage(entity enWinner)
{ // Display Intermission Victory Message
	local string strWinMessage;
	local string strFrags;
		strFrags = ftos(enWinner.frags);
		strFrags = strzone(strFrags);
	local string strKills;
		strKills = ftos(enWinner.nClientScore_NumKills);
		strKills = strzone(strKills);
	local string strDeaths;
		strDeaths = ftos(enWinner.nClientScore_NumDeaths);
		strDeaths = strzone(strDeaths);
	// Acquire Random Victory Word
	local string strVictoryWord;
	local float nRandom;
		nRandom = random() * 9;
		
	if(nRandom <= 1)
		strVictoryWord = "conquers";
	else
	if(nRandom <= 2)
		strVictoryWord = "reigns supreme";
	else
	if(nRandom <= 3)
		strVictoryWord = "destroys all";
	else
	if(nRandom <= 4)
		strVictoryWord = "stands upon all corpses";
	else
	if(nRandom <= 5)
		strVictoryWord = "flushes the competition";
	else
	if(nRandom <= 6)
		strVictoryWord = "devours all souls";
	else
	if(nRandom <= 7)
		strVictoryWord = "massacres all enemies";
	else
	if(nRandom <= 8)
		strVictoryWord = "defaces all foes";
	else
		strVictoryWord = "succeeds in Mortal Kombat";
		
	// Generate Win Message
	strWinMessage = strcat(enWinner.netname, "^7 ", strVictoryWord, " with ^2", strFrags, "^1 FRAGS^7");
	strWinMessage = strcat(strWinMessage, " (^2", strKills, " ^1KILLS^7");
	strWinMessage = strcat(strWinMessage, ", ^2", strDeaths, " ^1DEATHS^7");
	strWinMessage = strcat(strWinMessage, ")\n");
	/*
	strWinMessage = strcat(enWinner.netname, "^7 ", strVictoryWord, " with ^2", strKills, " ^1KILLS^7");
	strWinMessage = strcat(strWinMessage, " and ^2", strDeaths, " ^1DEATHS^7");
	strWinMessage = strcat(strWinMessage, ",  a total of ^2", strFrags, "^1 FRAGS\n");
	*/
	// Broadcast Message
	bprint(strWinMessage);
	
	// Unzone Strings
	strunzone(strFrags);
	strunzone(strDeaths);
	strunzone(strKills);
}
void PerformPostIntermissionProcesses()
{ // Perform Post Intermission Processes
	// Play Sound
	local string strSound;
	if(bUsingSpidfliskSoundPack)
	{ // Utilize Spidflisk Sound
		local float nRandom;
			nRandom = random() * 2;
			
		if(nRandom <= 1)
			strSound = "Spidflisk/misc/GameEnd1.ogg";
		else
			strSound = "Spidflisk/misc/GameEnd2.ogg";
	}
	else
		strSound = "misc/invshot.wav";	
	sound(world, CHAN_AUTO, strSound, 1, ATTN_NONE);
	
	// Check Intermission Viewmodel Entities
	CheckIntermissionViewmodelEntities();
		
	// Support Intermision Player Glows
	CheckIntermissionPlayerGlow();
	
	// Utilize Client Stats Scores
	if( cvar(CVAR_INTERMISSION_USEADVANCEDCLIENTSCORES) )
	{ // Advanced Client Scores Enabled
		WriteByte (MSG_ALL, SVC_FINALE);
		PrintClientScoring(world, TRUE);
	}
}