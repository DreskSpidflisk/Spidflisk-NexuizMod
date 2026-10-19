// DRESK - Weapon Functions
// Provides New Weapon Functions

// Field Definitions
.entity enExteriorWeaponLaser;

// Support LastHitSoundTime
// .float tLastHitSoundTime;
// Support LastRicochetSoundTime
// .float tLastRicochetSoundTime;
.float bDisableWeaponActions;
.void() fpWeaponActionFunction;
.float tSpecialWeaponActionAttackTime;

.float nRapidWeaponSwitchCnt;
.float tRapidWeaponSwitchResetTime;

#define PRECHECKWEAPONEVENT_NONE										0
#define PRECHECKWEAPONEVENT_DISABLEWEAPONS								1

// Functions
void PostCheckViewWeaponModelEffects(entity enClient, entity enWeapon)
{ // Post Check View Weapon Model Effects
	// Support Origin Modification for Shotgun (Nexuiz 2.2.1 model; don't like it too much)
	if(enClient.weapon == WEP_SHOTGUN)
		setorigin(enWeapon, '10 5 0');
	else
	if(enClient.weapon == WEP_NEX)
		setorigin(enWeapon, '2 -5 0');
	else
		setorigin(enWeapon, '0 0 0');
	
	// Use All Effects EXCEPT EF_FULLBRIGHT, EF_NODEPTHTEST
	enWeapon.effects = enClient.effects - (enClient.effects & EF_FULLBRIGHT);
	enWeapon.effects = enWeapon.effects - (enWeapon.effects & EF_NODEPTHTEST);
	
	// Support Intermission NoDraw
	if(enWeapon.bIntermissionViewModel_NoDraw)
		enWeapon.effects  = enWeapon.effects | EF_NODRAW;
		
	// Provide Upward Weapon Holster During Chatting
	if(enClient.buttonchat && enClient.attack_finished <= time)
	{ // Chatting and Not Attacking
		enWeapon.angles_y += 10;
		if(enWeapon.angles_y > 50)
			enWeapon.angles_y = 50;
		enWeapon.angles_z = 5;
	}
	else
	{ // Standard Angles
		// Remove Potential Holster Angles
		if(enWeapon.angles_y > 0)
		{ // Holster Angles Exist; Remove
			enWeapon.angles_z = 0;
			enWeapon.angles_y -= 10;
		}
		else
			// Holster Angles Gone; Reset Angles to Default
			enWeapon.angles = '0 0 0';
	}
}
void PostCheckExteriorWeaponModelEffects(entity enClient, entity enWeapon)
{ // Post Check Exterior Weapon Model Effects
	// Use All Effects EXCEPT EF_FULLBRIGHT,
	enWeapon.effects = enWeapon.effects - (enWeapon.effects & EF_FULLBRIGHT);
	
	// Suppress Duplicate Lighting from Strength and Invincibility Powerups
	// NOTE: Nexuiz 2.3 now disables these effects
	// enWeapon.effects = enWeapon.effects - (enWeapon.effects & EF_BLUE);
	// enWeapon.effects = enWeapon.effects - (enWeapon.effects & EF_RED);
	
	// Support Exterior Weapon Model Faces Owner View Angle
	if( cvar(CVAR_WEAPON_EXTERIORWEAPONINHERITSOWNERVERTICALANGLE) )
		enWeapon.angles_x = enClient.v_angle_x * -1;
	else
		enWeapon.angles = '0 0 0';
}
float PreCheckWeaponFrameEvents(entity enClient)
{ // PreCheck Weapon Frame Events
	local float nReturn;
	if(enClient.bDisableWeaponActions)
		// Disable Weapon Actions
		nReturn = PRECHECKWEAPONEVENT_DISABLEWEAPONS;
	else
		nReturn = PRECHECKWEAPONEVENT_NONE;
		
	// Check for Custom Weapon Handling Function
	if(enClient.fpWeaponActionFunction)
		// Invoke Function
		enClient.fpWeaponActionFunction();
		
	// Check for Reset Rapid Weapon Fire
	if(enClient.nRapidWeaponSwitchCnt > 0)
	{ // Reset Needed
		if(enClient.weaponentity.state == WS_READY && enClient.attack_finished <= time)
		{ // Weapon Ready
			if(!enClient.tRapidWeaponSwitchResetTime)
				// Assign New Reset Timer
				enClient.tRapidWeaponSwitchResetTime = time + 0.25;
			else
			if(enClient.tRapidWeaponSwitchResetTime < time)
			{ // Reset Rapid Weapon Switch Counter
				// sprint(enClient, "Resetting Weapon Fire!\n");
				enClient.nRapidWeaponSwitchCnt = 0;
			}
		}
		else
			// Weapon NOT Ready; Assign Timer to 0
			enClient.tRapidWeaponSwitchResetTime = 0;
	}
		
	// Return Status
	return nReturn;
}
float CheckSpawnExteriorWeaponEntityLaser(entity enClient)
{ // Check Spawn Exterior Weapon Entity
	local float bEntityCreated;
		bEntityCreated = FALSE;
		
	if( cvar(CVAR_WEAPON_EXTERIORWEAPONHASLASERSIGHT) && !enClient.exteriorweaponentity.enExteriorWeaponLaser)
	{ // Spawn Exterior Weapon Laser Entity
		// Assign Entity Created
		bEntityCreated = TRUE;
		enClient.exteriorweaponentity.enExteriorWeaponLaser = spawn();
		enClient.exteriorweaponentity.enExteriorWeaponLaser.owner = enClient.exteriorweaponentity;
		enClient.exteriorweaponentity.enExteriorWeaponLaser.scale = 0.9;
		enClient.exteriorweaponentity.enExteriorWeaponLaser.alpha = 0.3;
		enClient.exteriorweaponentity.enExteriorWeaponLaser.effects = EF_FULLBRIGHT | EF_NOSHADOW | EF_LOWPRECISION;
		
		// Determine Color Based on CVar
		if( cvar(CVAR_WEAPON_EXTERIORWEAPONHASLASERSIGHT) == 1)
			enClient.exteriorweaponentity.enExteriorWeaponLaser.colormod = '0.8 0 0';
		else
			enClient.exteriorweaponentity.enExteriorWeaponLaser.colormap = enClient.colormap;
		
		setmodel(enClient.exteriorweaponentity.enExteriorWeaponLaser, "models/misc/line-81-1.mdl");
		setattachment(enClient.exteriorweaponentity.enExteriorWeaponLaser, enClient.exteriorweaponentity, "");
		setorigin(enClient.exteriorweaponentity.enExteriorWeaponLaser, '50 0 5');
	}
	
	// Return Entity Created
	return bEntityCreated;
}
void CheckWeaponSwitchSpidfliskEvents(entity enClient)
{ // Check Weapon Switch Spidflisk Events
	// Update Client Stats Score
	UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_NUMWEAPONSWITCHES, 1);
	
	if(enClient.nRapidWeaponSwitchCnt < cvar(CVAR_WEAPON_RAPIDWEAPONSWITCHES) )
	{ // Rapid Weapon Switch Valid
		// Reset Attack Time
		enClient.attack_finished = time;
		// Increment Rapid Weapon Switch
		enClient.nRapidWeaponSwitchCnt = enClient.nRapidWeaponSwitchCnt + 1;
	}
}
void CheckGrenadeLauncherExtendedEffects(entity enGrenade, float nGrenadeType)
{ // Check Grenade Launcher Extended Effects
	// New Effects
	if( cvar(CVAR_WEAPON_GRENADELAUNCHER_EXTENDEDEFFECTS) )
	{ // Extended Effects
		enGrenade.effects = enGrenade.effects | EF_FULLBRIGHT;
		enGrenade.glow_trail = 1;
		if(nGrenadeType == 1)
			enGrenade.glow_color = 500;
		else
		if(nGrenadeType == 2)
		{
			enGrenade.glow_color = 5;
			enGrenade.avelocity = '-1200 0 0';
		}
	}
}
void CheckNexSetupShotCustomizations(entity enClient)
{ // Check Nex Setup Shot Customizations
	// Report Help Text
	HelpText_CustomFeature_NexDamage(enClient);
	
	// Support Additional Punchangle
	local float fPunchAngle;
	if( (enClient.crouch) && (enClient.flags & FL_ONGROUND) )
		// Crouching on the Ground; Nice Punchangle
		fPunchAngle = 3;
	else
		fPunchAngle = 8;
		
	// Invoke Setup Shot Here
	W_SetupShot(enClient, '5 14 -8', TRUE, fPunchAngle, "weapons/nexfire.wav");
		
	// Use Small Flush
	te_smallflash (w_shotorg + w_shotdir * 24);
	
	// Support Detailed Projectile
	local float fDetailedProjectileSpeed;
		fDetailedProjectileSpeed = cvar(CVAR_WEAPON_NEX_DETAILEDPROJECTILESPEED);
	if(fDetailedProjectileSpeed)
		DetailedProjectile_Nex(enClient, fDetailedProjectileSpeed, w_shotorg, trace_endpos, w_shotdir);
}
void CheckCrylinkDetailedProjectile(entity enClient)
{ // Check Crylink Detailed Projectile
	local float fDetailedProjectileTime;
		fDetailedProjectileTime = cvar(CVAR_WEAPON_CRYLINK_DETAILEDPROJECTILETIME);
	if(fDetailedProjectileTime)
		DetailedProjectile_Crylink(enClient, fDetailedProjectileTime, w_shotorg, w_shotdir);
	else
		te_smallflash(w_shotorg);
}
float CheckWeaponAdvancedOwnershipMessage(entity enClient, float nItemCode, float nWeapon)
{ // Check Weapon Advanced Ownership Message
	local float bReturn;
		bReturn = TRUE;
	/*
	if( cvar(CVAR_WEAPON_USEADVANCEDOWNERSHIPMESSAGES) )
	{ // Advanced Ownership Messages Used
		if(nItemsInMap & nItemCode)
			sprint(enClient, strcat("You do not have the ^2", W_Name(nWeapon), "\n") );
		else
			sprint(enClient, strcat("The ^2", W_Name(nWeapon), "^7 is ^1NOT AVAILABLE^7 in this map\n") );
	}
	else
		bReturn = FALSE;
		
	*/
	// Return Status
	return bReturn;
}
float CheckWeaponCrouchROFMod(entity enClient, float fAttackTime)
{ // Check Weapon Crouch ROF Mod
	local float fReduction;
		// Default Reduction is 0
		fReduction = 0;
	if( (enClient.crouch) && (enClient.flags & FL_ONGROUND) )
	{ // Attack Delay Reduction
		// Acquire Percentile Reduction
		fReduction = fAttackTime * ( cvar(CVAR_PLAYER_CROUCHATTACKREDUCTIONPERCENTILE) / 100);
	}
	
	// Assign New Attack Time
	fAttackTime = fAttackTime - fReduction;
	
	// Return Reduction
	return fAttackTime;
}