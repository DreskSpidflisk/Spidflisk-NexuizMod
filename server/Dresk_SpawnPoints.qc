// DRESK - Spawn Point Functions
// Provides Spawn Point Functions

// Definitions

// Fields

// Prototypes

// Functions
float CheckIsBadSpawnpoint()
{ // Check Is Bad Spawnpoint
	// NOTE: Assumed scope is spawn point
	local float bReturn;
		bReturn = FALSE;
	// SUPPRESSED DUE TO NEXUIZ 2.3 FIXING BUG
	/*
	if(world.model == "maps/bleach.bsp")
	{ // Bleach
		if( vlen(self.origin - '2944 -1472 -154') < 0.5)
			// Bad Spawnpoint
			bReturn = TRUE;
	}
	*/
	
	if(bReturn)
		// Increment Bad Spawnpoints
		nNumBadSpawnpoints = nNumBadSpawnpoints + 1;

	return bReturn;
}
void PingSpawnpoints(entity enCaller)
{ // Ping Spawnpoints
	local entity enSpawnFind;
	local float nCnt;
	
	// Acquire First Spawnpoint
	enSpawnFind = find(world, classname, "info_player_deathmatch");
	
	while(enSpawnFind != world)
	{ // Valid Spawnpoint
		bprint("Spawnpoint ", ftos(nCnt), " : ", vtos(enSpawnFind.origin), "\n");
		
		// Increment Counter
		nCnt = nCnt + 1;
	
		// Acquire Next Spawnpoint
		enSpawnFind = find(enSpawnFind, classname, "info_player_deathmatch");
	}
}
void CreateSpawnPointModel()
{ // Create Spawn Point Model
	// NOTE: Assumed scope is creation of spawn point.
	// Acquire Create Spawn Point Models
	local float nCreatSpawnPointModels;
		nCreatSpawnPointModels = cvar(CVAR_MISC_CREATESPAWNPOINTMODELS);
	if(nCreatSpawnPointModels)
	{ // Spawn Point Models Enabled
		local float bCreate;
		// Determine Model Creation Necessity
		if(self.team == 0)
		{ // Death Match Spawn Point (or Domination)
			if( !cvar("g_ctf") )
			// if( !cvar("g_ctf") && !cvar("g_domination") )
				bCreate = 1;
			else
				bCreate = 0;
		}
		else
		{ // Team Game Spawn Point
			if( cvar("g_ctf") || cvar("g_domination") )
				bCreate = 1;
			else
				bCreate = 0;
		}
		
		if(bCreate)
		{ // Creation Necessary
		// Backup Current Spawn Point Entity
			local entity enSpawn;
				enSpawn = self;
				
			// Spawn Model
			self = spawn();
				// Assign Model
				setmodel(self, "models/domination/dom_unclaimed.md3");
				// Assign Classname
				self.classname = "spawnpoint_model";
				// Assign Size (item)
				setsize (self, '-12 -12 -12', '12 12 12');
				// Assign Angles
				self.angles_x = 90;
				self.angles_y = 90;
				// Assign Scale
				self.scale = 0.45;
				// Assign Effects
				self.effects = EF_NOSHADOW | EF_LOWPRECISION | EF_STARDUST;
				if(nCreatSpawnPointModels == 2)
				{ // Full Bright Spawn Models
					self.effects = self.effects | EF_FULLBRIGHT;
					self.alpha = 0.2;
				}
				else
					self.alpha = 0.5;
				// Assign Movetype
				self.movetype = MOVETYPE_NONE;
				// Assign Solid
				self.solid = SOLID_NOT;
				
				// Assign Color Modification
				if(enSpawn.team == COLOR_TEAM1)
					// Red Spawn
					self.colormod = '1.0 0.0 0.0';
				else
				if(enSpawn.team == COLOR_TEAM2)
					// Blue Spawn
					self.colormod = '0.0 0.0 1.0';
				else
					// Default Spawn
					self.colormod = '0.3 0.9 0.6';
				
				// Assign Origin
				// Step 1 : Set Spawn Origin
					vector vOrigin;
					vOrigin = enSpawn.origin;
					setorigin(self, vOrigin);
				// Step 2: Drop to Floor
					droptofloor();
				// Step 3 : Append Additional Drop
					setorigin(self, self.origin - '0 0 10');
					
				// Additional Ambient Sound Support
				if( cvar(CVAR_MISC_SPAWNADDITIONALAMBIENTSOUNDS) )
					SpawnAdditionalAmbientSound(self);
					
			// Restore Spawn Entity
			self = enSpawn;
		}
	}
}
float CheckSpidfliskSpawnPointEventsAndIsBadSpawnPoint()
{ // Check Spidflisk Spawn Point Events and is bad Spawn Point
	local float bBadSpawnPoint;
		bBadSpawnPoint = CheckIsBadSpawnpoint();
		
	if(!bBadSpawnPoint)
	{ // Valid Spawn Point
		// Support Spawn Point Model Creation
		CreateSpawnPointModel();
	}
	
	return bBadSpawnPoint;
}
void CheckSpidfliskSpawnPointEffects(entity enClient, entity enSpawnPoint)
{ // Check Spidflisk Spawn Point Effects
	if( cvar(CVAR_PLAYER_SPAWNEFFECT) )
	{ // Valid Spawn Effect
		// Display Particles
		te_teleport(enClient.origin);
		
		// Play Sound
		sound(enClient, CHAN_AUTO, "misc/spawn.wav", 1, ATTN_NORM);
	}
}