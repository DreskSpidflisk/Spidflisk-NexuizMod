// DRESK - Gore and Corpses
// Provides Functions for Gore and Corpses

// Player Damage Bloodshower
#define PLAYERDAMAGE_BLOODSHOWER_PARTICLEMULTIPLIER							7
#define PLAYERDAMAGE_BLOODSHOWER_MAXPARTICLES								1000

// Fields
// Support Suppress Corpse Gib
.float nSuppressCorpseGibCnt;
// Number of Corpse Bounces
.float nNumCorpseBounces;
.float bRemoveCorpseOnCopy;

// Functions
float CheckSpidfliskSelfDeathMessage(entity enVictim, float nDeathType)
{ // Check Spidflisk Self Death Message
	local float bReturn;
		bReturn = TRUE;
	
	if (nDeathType == IT_GRENADE_LAUNCHER)
		bprint ("^1 ate ", GetPlayerModelSexVerbiage(enVictim, "his"), " own mortar\n");
	else if (nDeathType == IT_ELECTRO)
		bprint ("^1 sucked on ", GetPlayerModelSexVerbiage(enVictim, "his"), " own electro\n");
	else if (nDeathType == IT_ROCKET_LAUNCHER)
		bprint ("^1 raped ", GetPlayerModelSexVerbiage(enVictim, "himself"), " with a rocket\n");
	else if(nDeathType == IT_HAGAR)
		bprint ("^1 poetically pummeled ", GetPlayerModelSexVerbiage(enVictim, "himself"), "\n");
	else if(nDeathType == IT_CRYLINK)
		bprint ("^1 proliferated ", GetPlayerModelSexVerbiage(enVictim, "himself"), " with energy\n");
	else if(nDeathType == IT_LASER)
	{
		bprint ("^1 toasted ", GetPlayerModelSexVerbiage(enVictim, "himself"), " with ");
		bprint (GetPlayerModelSexVerbiage(enVictim, "his"), " own laser\n");
	}
	else if (nDeathType == DEATH_KILL)
		bprint ("^1 ended ", GetPlayerModelSexVerbiage(enVictim, "his"), " own life through suicide\n");
	else if (nDeathType == DEATH_CAMP)
		bprint ("^1 thought ", GetPlayerModelSexVerbiage(enVictim, "he"), " found a nice camping ground\n");
	else
		// No Death Message Used
		bReturn = FALSE;
		
	return bReturn;
}
float CheckSpidfliskDeathMessage(entity enAttacker, entity enVictim, float nDeathType)
{ // Check Spidflisk Death Message
	local float bReturn;
		bReturn = TRUE;
		
	if (nDeathType == IT_LASER)
		bprint("^1 was laser-fried by ");
	else if (nDeathType == IT_SHOTGUN)
		bprint ("^1 was gunned down by ");
	else if (nDeathType == IT_GRENADE_LAUNCHER)
		bprint ("^1 was mortared by ");
	else if (nDeathType == IT_ELECTRO)
		bprint ("^1 was electrified by ");
	else if (nDeathType == IT_CRYLINK)
		bprint ("^1 ate a face full of energized jizz from ");
	else if (nDeathType == IT_NEX)
		bprint ("^1 was railed by ");
	else if (nDeathType == IT_ROCKET_LAUNCHER)
		bprint ("^1 was rocket-raped by ");
	else if (nDeathType == DEATH_FALL)
	{
		bprint ("^1 had ", GetPlayerModelSexVerbiage(enVictim, "his"), " legs cracked into ");
		bprint (GetPlayerModelSexVerbiage(enVictim, "his"), " chest by ");
	}
	else if (nDeathType == DEATH_HURTTRIGGER)
		bprint ("^1 was ejected from the Garden of Eden by ");
	else if (nDeathType == DEATH_DEATHSPECTRETOUCH)
		bprint ("^1 succumbed to the Death Spectre's Touch of ");
	else if (nDeathType == DEATH_DEATHSPECTREFLAMINGSKULL)
		bprint ("^1 was exploded by a flaming skull summoned by ");
	else if (nDeathType == DEATH_LAVA)
		bprint ("^1 was forcibly thrown into lava by ");
	else if (nDeathType == DEATH_DROWN)
		bprint ("^1 drowned due to the actions of ");
	else if (nDeathType == DEATH_SLIME)
		bprint ("^1 was denied exit from the slime due to ");
	else
		// No Death Message Used
		bReturn = FALSE;
		
	if(bReturn)
	{ // Append Attacker Name
		bprint("^7", enAttacker.netname, "\n");
	}
		
	return bReturn;
}
float CheckSpidfliskWorldDeathMessage(entity enVictim, entity enWorldAttacker, float nDeathType)
{ // Check Spidflisk World Death Message
	local float bReturn;
		bReturn = TRUE;
		
	if (nDeathType == DEATH_FALL)
	{
		bprint ("^1 forced ", GetPlayerModelSexVerbiage(enVictim, "his"), " legs into ");
		bprint ( GetPlayerModelSexVerbiage(enVictim, "his"), " chest\n");
	}
	else if (nDeathType == DEATH_SLIME)
		bprint ("^1 drew ", GetPlayerModelSexVerbiage(enVictim, "his"), " last breath in the slime\n");
	else if (nDeathType == DEATH_LAVA)
		bprint ("^1 unwillingly scorched ", GetPlayerModelSexVerbiage(enVictim, "his"), " body in lava\n");
	else if (enWorldAttacker.message == "was in the wrong place.")
		// Replace Default Crappy Message
		bprint ("^1 submitted ", GetPlayerModelSexVerbiage(enVictim, "himself"), " to the void\n");
	else
		// No Death Message Used
		bReturn = FALSE;
		
	return bReturn;
}
void PerformDreskDeath(entity enPlayer)
{ // Perform Dresk Death
	// Play Sound
	sound (enPlayer, CHAN_VOICE, "misc/gib.wav", 1, ATTN_NORM);
	// Apply Additional Force
	enPlayer.velocity_x = enPlayer.velocity_x * 2;
	enPlayer.velocity_y = enPlayer.velocity_y * 2;
	// Spawn Flash
	// te_smallflash(enPlayer.origin);
	te_explosionrgb(enPlayer.origin, '0.75 0 0');
	// te_customflash(enPlayer.origin, 500, 0.4, '0.50 0 0');
	
	TossGib (world, "models/gibs/gib1.md3", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/gib1.mdl", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/gib3.mdl", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/gib3.mdl", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/gib5.md3", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/chunk.mdl", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/eye.md3", enPlayer.origin, enPlayer.velocity,0);
	TossGib (world, "models/gibs/eye.md3", enPlayer.origin, enPlayer.velocity,0);
	
	te_bloodshower (enPlayer.origin + enPlayer.mins, enPlayer.origin + enPlayer.maxs, 1500, 1500);
	/*
	te_bloodshower (enPlayer.origin + enPlayer.mins, enPlayer.origin + enPlayer.maxs, 300, 1200);
	te_bloodshower (enPlayer.origin + enPlayer.mins, enPlayer.origin + enPlayer.maxs, 400, 1100);
	te_bloodshower (enPlayer.origin + enPlayer.mins, enPlayer.origin + enPlayer.maxs, 500, 1400);
	*/
}
void Spidflisk_Corpse_Touch()
{ // Corpse Touch Function
	// NOTE: Assumed scope is corpse.
	
	// Increment Number of Corpse Bounces
	self.nNumCorpseBounces += 1;
	
	// Check for Void Touch
	if(trace_dphitq3surfaceflags & Q3SURFACEFLAG_NOIMPACT)
		// Remove Corpse on Copy
		self.bRemoveCorpseOnCopy = TRUE;
	
	// bprint(strcat(self.netname, " on my ", ftos(self.nNumCorpseBounces), " bounce!\n"));
	
	if(self.nNumCorpseBounces > cvar(CVAR_CORPSE_CORPSEBOUNCES) )
	{ // Corpse Bouncing Exceeded
		// bprint(strcat(self.netname, " done bouncing with ", ftos(self.nNumCorpseBounces), " bounces!\n"));
		// Modify Movetype
		self.movetype = MOVETYPE_TOSS;
		// Remove Touch Function
		self.touch = SUB_Null;
	}
}
// Support Bloody Skull Death
void TossBloodySkullDeath(entity gib, vector org, vector v)
{ // Toss Bloody Skull Death
	// don't set his classname to something else or it'll screw up a lot of stuff
	if(gib.classname != "player")
		gib.classname = "gib";
	gib.iscreature = TRUE;
	gib.movetype = MOVETYPE_BOUNCE;
	// DRESK - 3/25/2007
	// Assign SOLID_NOT
	gib.solid = SOLID_NOT;
	// gib.solid = SOLID_CORPSE;
	gib.skin = 0;
	
	// DRESK - 5/19/06
	// Although EF_FLAME is hilarious, the performance detriment
	// is too much for PPL users.
	if(gib.effects & EF_FULLBRIGHT)
		gib.effects = EF_LOWPRECISION | EF_FULLBRIGHT;
	else
		gib.effects = EF_LOWPRECISION;
		
	// Assign Glow Trail (hah!)
	gib.glow_color = 233;
	gib.glow_size = 0;
	gib.glow_trail = 1;

	setmodel (gib, "models/gibs/bloodyskull.md3");
	setsize (gib, '-8 -8 -8', '8 8 8');
	setorigin (gib, org);

	gib.health = -1;
	
	gib.takedamage = DAMAGE_YES;
	
	gib.damageforcescale = 6.0;
	gib.event_damage = GibDamage;

	gib.velocity = '0 0 200';
	gib.velocity_z = gib.velocity_z + random() * 1000;
	// gib.velocity = v + randomvec() * 1250;
	gib.avelocity = randomvec() * 1200;
	gib.oldvelocity = gib.velocity;
	
	SUB_SetFade (gib, time + cvar(CVAR_GIB_FADETIME), 1);
}
// Provide Function for Gibbing
void GibCorpse(entity enCorpse, entity enGibber)
{ // Gib Corpse
	// NOTE: Logic copied from PlayerCorpseDamage
	
	// don't use any animations as a gib
	enCorpse.frame = 0;
	enCorpse.dead_frame = 0;
	enCorpse.die_frame = 0;
	// view just above the floor
	enCorpse.view_ofs = '0 0 4';

	// make a juicy mess
	te_bloodshower (enCorpse.origin + enCorpse.mins, enCorpse.origin + enCorpse.maxs, 800, 1000);
	te_bloodshower (enCorpse.origin + enCorpse.mins, enCorpse.origin + enCorpse.maxs, 400, 1000);

	// make a meaty mess
	// DRESK - 5/18/06
	// Support Bloody Skull Death
	if( cvar(CVAR_PLAYERDEATH_BLOODYSKULLDEATH) )
	{
		TossBloodySkullDeath(enCorpse, enCorpse.origin, enCorpse.velocity);
		TossGib (world, "models/gibs/eye.md3", enCorpse.origin, enCorpse.velocity,0);
	}
	else
	{
		TossGib (enCorpse, "models/gibs/eye.md3", enCorpse.origin, enCorpse.velocity,0);
		TossGib (world, "models/gibs/bloodyskull.md3", enCorpse.origin, '0 0 600',0);
	}

	TossGib (world, "models/gibs/gib1.md3", enCorpse.origin, enCorpse.velocity,0);
	TossGib (world, "models/gibs/gib2.mdl", enCorpse.origin, enCorpse.velocity,0);
	TossGib (world, "models/gibs/gib1.mdl", enCorpse.origin, enCorpse.velocity,0);
	//TossGib (world, "models/gibs/gib3.md3", enCorpse.origin, enCorpse.velocity,0);
	
	// DRESK - 3/9/06
	// Support Low Bandwidth Levels
	if( cvar(CVAR_MISC_LOWBANDWIDTHLEVEL) < 2)
	{ // Toss More Gibs
		//TossGib (world, "models/gibs/gib4.md3", enPlayer.origin, enPlayer.velocity,0);
		TossGib (world, "models/gibs/gib3.mdl", enCorpse.origin, enCorpse.velocity,0);

		// these destory on impact
		TossGib (world, "models/gibs/gib5.md3", enCorpse.origin, '-500 0 450',1);
		//TossGib (world, "models/gibs/gib6.md3", enCorpse.origin, '0 500 450',1);
		TossGib (world, "models/gibs/chunk.mdl", enCorpse.origin, '0 -500 450',1);
		TossGib (world, "models/gibs/chunk.mdl", enCorpse.origin, '500 0 450',1);
		TossGib (world, "models/gibs/chunk.mdl", enCorpse.origin, enCorpse.velocity,1);
		TossGib (world, "models/gibs/chunk.mdl", enCorpse.origin, '0 0 450',1);
	}

	// Play Sound
	sound (enCorpse, CHAN_VOICE, "misc/gib.wav", 1, ATTN_NORM);
	
	// Update Client Stats Score
	if(enGibber.classname == "player" && enGibber != enCorpse)
		UpdateClientStatsScoreAward(enGibber, CLIENTSCORE_AWARD_NUMCORPSEGIBS, 1);
}
void PlayerBloodshowerDamage(entity enPlayer, float fDamage)
{ // Player Bloodshower Damage
	local float fBloodShowerAmount;
		fBloodShowerAmount = fDamage * PLAYERDAMAGE_BLOODSHOWER_PARTICLEMULTIPLIER;
	if(fBloodShowerAmount > PLAYERDAMAGE_BLOODSHOWER_MAXPARTICLES)
		fBloodShowerAmount = PLAYERDAMAGE_BLOODSHOWER_MAXPARTICLES;
	te_bloodshower (enPlayer.origin + enPlayer.mins, enPlayer.origin + enPlayer.maxs, 600, fBloodShowerAmount);
}
void Spidflisk_PlayerCorpseDamage(entity inflictor, entity attacker, float damage, float deathtype, vector hitloc, vector force)
{ // Spidflisk Specific Player Corpse Damage
	local float bGib;
		bGib = FALSE;
		
	// Produce Bloodshower
	PlayerBloodshowerDamage(self, damage);
	
	if(deathtype == DEATH_FALL)
	{ // Apply Impact Sound
		if (random() < 0.5)
			sound (self, CHAN_IMPACT, "misc/bodyimpact1.wav", 1, ATTN_NORM);
		else
			sound (self, CHAN_IMPACT, "misc/bodyimpact2.wav", 1, ATTN_NORM);
	}
	
	// Check for Immediate Corpse Exposion
	if( cvar(CVAR_PLAYERDEATH_CORPSEGIBONLYONEXPLOSIVES) )
	{ // Explosions Only Gib Corpse
		if(deathtype == IT_ROCKET_LAUNCHER
		|| deathtype == IT_GRENADE_LAUNCHER
		|| deathtype == IT_HAGAR
		|| deathtype == IT_LASER
		|| deathtype == IT_ELECTRO
		|| deathtype == IT_CRYLINK
		|| deathtype == DEATH_TELEFRAG
		|| deathtype == DEATH_LAVA
		|| deathtype == DEATH_SLIME)
			// Gib Immediately
			bGib = TRUE;
		else
			// No Gib
			bGib = FALSE;
	}
	else
	{ // Standard Corpse Gibbing
		// Simplified to Reduce Health Directly
		self.health = self.health - damage;
		
		if(self.health <= -600)
			// Corpse Gib Damage Reached
			bGib = TRUE;
	}
	
	if(bGib && self.nSuppressCorpseGibCnt == 0)
	{ // Corpse to Gib
		// Gib Player
		GibCorpse(self, attacker);
	}
	
	// Reduce Suppress Corpse Gib Count
	self.nSuppressCorpseGibCnt = self.nSuppressCorpseGibCnt - 1;
	if(self.nSuppressCorpseGibCnt < 0)
		self.nSuppressCorpseGibCnt = 0;
}
float CheckSpidfliskCopyBodyEventsAndRemove(entity enCorpse, entity enPlayer)
{ // Check Spidflisk Copy Body Events And Remove
	local float bRemove;
	
	if(enPlayer.bRemoveCorpseOnCopy)
	{ // Remove Corpse
		bRemove = TRUE;
		// Reset Remove Corpse on Copy
		enPlayer.bRemoveCorpseOnCopy = FALSE;
	}
	else
	{ // Keep Corpse
		//Assign Low-Bandwidth Effect
		// NOTE: Although set in PlayerDeath as well, double-setting
		// to be sure.
		enCorpse.effects = (enCorpse.effects | EF_LOWPRECISION);
		// Assign Old Number of Corpse Bounces
		enCorpse.nNumCorpseBounces = enPlayer.nNumCorpseBounces;
		
		// Assign Solidity
		enCorpse.solid = enPlayer.solid;
		// Assign Touch Function
		enCorpse.touch = enPlayer.touch;
		
		// Copy Glow Information
		enCorpse.glow_color = enPlayer.glow_color;
		enCorpse.glow_size = enPlayer.glow_size;
		enCorpse.glow_trail = enPlayer.glow_trail;
		// Copy Colormod
		enCorpse.colormod = enPlayer.colormod;
		// Copy Modelflags
		enCorpse.modelflags = enPlayer.modelflags;
	}
	
	return bRemove;
}
void PreCheckPlayerDamageDeathEvents(entity enKiller)
{ // Pre Check Player Damage Death Events
	// NOTE: Assumed scope is dying player.
	// This is called before event_damage.
	
	// Update Client Scores
	UpdateClientStatsScore(self, CLIENTSCORE_NUMDEATHS, 1);
	if(self != enKiller && enKiller.classname == "player")
		UpdateClientStatsScore(enKiller, CLIENTSCORE_NUMKILLS, 1);
	
	// Clear Effects; Remove Shadow for Performance; Apply Low Precision
	if(self.effects & EF_FULLBRIGHT)
		self.effects = (EF_FULLBRIGHT | EF_NOSHADOW | EF_LOWPRECISION);
	else
		self.effects = (EF_NOSHADOW | EF_LOWPRECISION);
		
	// Assign Additional Damage Force Scale
	self.damageforcescale = 4.0;
		
	// Spawn Thrown Powerups
	if( cvar(CVAR_PLAYERDEATH_DROPPOWERUPS) )
		SpawnThrownPowerups (self.origin + (self.mins + self.maxs) * 0.5);
	// Spawn Thrown Armor
	if( cvar(CVAR_PLAYERDEATH_DROPARMOR) )
		SpawnThrownArmor(self.origin + (self.mins + self.maxs) * 0.5);
		
	// Remove Armor value
	self.armorvalue = 0;
	
	// Apply Lifting Force
	self.velocity_z += 200 + (random() * 600);
	
	// Apply Additional Blood
	te_bloodshower (self.origin + self.mins, self.origin + self.maxs, 900, PLAYERDAMAGE_BLOODSHOWER_MAXPARTICLES);
	
	// Check for Dresk Death
	if( GetIsClientDresk(self) )
		PerformDreskDeath(self);
		
	// Check for Corpse Bouncing
	if( cvar(CVAR_CORPSE_CORPSEBOUNCES) > 0 )
	{ // Corpse Bouncing Enabled
		// Reset Number of Corpse Bounces
		self.nNumCorpseBounces = 0;
		// Apply Initial Bouncing Corpses
		self.movetype = MOVETYPE_BOUNCE;
		// Apply Touching Function
		self.touch = Spidflisk_Corpse_Touch;
	}
	
	// Support SOLID_TRIGGER Corpse
	if( cvar(CVAR_PLAYERDEATH_CORPSEGIBONLYONEXPLOSIVES) )
		self.solid = SOLID_TRIGGER;
	else
		self.solid = SOLID_CORPSE;
		
	// Assign Spidflisk Corpse Damage
	self.event_damage = Spidflisk_PlayerCorpseDamage;
	
	// Suppress Corpse Gib Count of 1
	self.nSuppressCorpseGibCnt = 1;
	
	// Assign Bleeding Corpses
	self.modelflags = MF_GIB;
}
void PostCheckPlayerDamageDeathEvents()
{ // Post Check Player Damage Death Events
	// NOTE: Assumed scope is dying player.
	// This is called after event_damage, at the end of the damage function entirely.
	
	// Corpse FadeTime Increased
	SUB_SetFade (self, time + cvar(CVAR_CORPSE_CORPSEFADETIME), 1);
}
entity LaunchProjectileGib(entity enOwner, string strModel, string strLaunchSound, float nMoveType, float fVelocity, void() fpTouchFunc, float fLifeTime)
{ // Launch Projectile Gib
	local entity enGib;
		// Spawn Gib
		enGib = spawn();
		// Assign Owner
		enGib.owner = enOwner;
		// Assign Origin of Gib
		setorigin(enGib, enGib.owner.origin);
		// Assign Model
		if(strModel)
			setmodel(enGib, strModel);
		// Assign Movetype
		enGib.movetype = nMoveType;
		// Assign Solid
		enGib.solid = SOLID_BBOX;
		// Assign Effects
		enGib.effects = EF_LOWPRECISION;
		
		// Produce Launch Sound
		/*
		if(strLaunchSound)
			sound (enGib, CHAN_AUTO, strLaunchSound, 1, ATTN_NORM);
		*/
			
		// Determine Touch and Think
		if(fpTouchFunc)
		{ // Touch Function Provided
			// Assign Touch Function
			enGib.touch = fpTouchFunc;
		}
		
		if(fLifeTime)
		{ // Life Time Provided
			enGib.nextthink = time + fLifeTime;
			enGib.think = SUB_Remove;
		}
		
		// Prepare Velocity
		W_SetupShot(enOwner, '15 3 -8', FALSE, 0, strLaunchSound);
		
		enGib.velocity = w_shotdir * fVelocity;
		
	// Return Gib
	return enGib;
}
void ExplosiveFlamingSkullProjectileTouch()
{ // Explosive Flaming Skull Projectile Touch
	// Produce Explosion and Sound
	te_explosion(self.origin);
	sound (self, CHAN_AUTO, "weapons/grenade_impact.wav", 1, ATTN_NORM);
	
	// Produce Bloodshower
	PlayerBloodshowerDamage(self, 5000);
	
	// Produce Lava Explosion
	te_lavasplash(self.origin);
	
	// Produce Radius Damage
	RadiusDamage(self, self.owner, 75, 30, 170, world, 1200, DEATH_DEATHSPECTREFLAMINGSKULL);
	
	// Remove Self
	remove(self);
}
entity LaunchProjectileGib_ExplosiveFlamingSkull(entity enOwner)
{ // Launch Projectile Gib - Explosive Flaming Skull
	local entity enGib;
		enGib = LaunchProjectileGib(enOwner, "models/gibs/bloodyskull.md3", "", MOVETYPE_FLY, 3000, ExplosiveFlamingSkullProjectileTouch, 10);
		
		// Add Additional Effects
		enGib.effects = enGib.effects | EF_FULLBRIGHT | EF_FLAME;
		// Add Glow Trail
		enGib.glow_trail = 1;
		enGib.glow_color = 79;
		
	// Return Gib
	return enGib;
}