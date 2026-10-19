// DRESK - CTF
// Provides CTF functions

// Definitions

// Fields

// Prototypes

// Functions
void CheckCTFItemFlagPostSpawn()
{ // Check CTF Item Flag Post Spawn
	// NOTE: Assumed scope is Flag Item.
	if(self.noise2 == "ctf/capture.wav")
		// Sound Modification
		self.noise2 = "misc/invshot.wav";
		
	// Flag Glow Trail Support
	if( cvar(CVAR_GAME_CTF_FLAGGLOWTRAILS) )
	{ // Provide Flag Glow Trail
		if(self.team == COLOR_TEAM1)
			// Red
			self.glow_color = 233;
		else
		if(self.team == COLOR_TEAM2)
			// Blue
			self.glow_color = 215;
			
		self.glow_size = 25;
		self.glow_trail = 1;
	}
	
	// Support NoDepth Test Flags
	if( cvar(CVAR_GAME_CTF_NODEPTHTESTFLAGS) )
		self.effects = self.effects | EF_NODEPTHTEST;
}