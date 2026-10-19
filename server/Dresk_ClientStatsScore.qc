// DRESK - Client Statistics / Scoring
// Provides definitions and default values for client scoring / statistics.

#define CLIENTSCORE_NUMKILLS												0
#define CLIENTSCORE_NUMDEATHS												1
#define CLIENTSCORE_BEGINPLAYTIME											2
#define CLIENTSCORE_NUMJUMPS												3
#define CLIENTSCORE_NUMFLAGCAPTURES											4

#define CLIENTSCORE_AWARD_NUMJUMPPADS										0
#define CLIENTSCORE_AWARD_SELFDAMAGE										1
#define CLIENTSCORE_AWARD_FALLINGDAMAGE										2
#define CLIENTSCORE_AWARD_LIQUIDDAMAGE										3
#define CLIENTSCORE_AWARD_NUMCHARACTERSSPOKEN								4
#define CLIENTSCORE_AWARD_NUMELECTROBALLSFIRED								5
#define CLIENTSCORE_AWARD_NUMTELEPORTS										6
#define CLIENTSCORE_AWARD_NUMMEGAHEALTHS									7
#define CLIENTSCORE_AWARD_CHATDAMAGE										8
#define CLIENTSCORE_AWARD_NUMHITSBYMORTAR									9
#define CLIENTSCORE_AWARD_NUMWEAPONSWITCHES									10
#define CLIENTSCORE_AWARD_ROCKETWHORE										11
#define CLIENTSCORE_AWARD_NUMHURTTRIGGERDEATHS								12
#define CLIENTSCORE_AWARD_NUMWEAPONPICKUPS									13
#define CLIENTSCORE_AWARD_NUMAMMOPICKUPS									14
#define CLIENTSCORE_AWARD_HEALTHPICKEDUP									15
#define CLIENTSCORE_AWARD_ARMORPICKEDUP										16
#define CLIENTSCORE_AWARD_RADIUSDAMAGE										17
#define CLIENTSCORE_AWARD_LONGESTNEXSHOT									18
#define CLIENTSCORE_AWARD_NUMCORPSEGIBS										19

#define CLIENTSCORE_NUMBEROFAWARDS											20

#define CLIENTSCORE_ALIGNMENT_LEFT											1
#define CLIENTSCORE_ALIGNMENT_RIGHT											2

#define CLIENTSCORE_COLUMNNAME_1											"\bClient"
#define CLIENTSCORE_COLUMNWIDTH_1											24

#define CLIENTSCORE_COLUMNNAME_2											"\bPing"
#define CLIENTSCORE_COLUMNWIDTH_2											7

#define CLIENTSCORE_COLUMNNAME_3											"\bTime"
#define CLIENTSCORE_COLUMNWIDTH_3											7

#define CLIENTSCORE_COLUMNNAME_4											"\bScore"
#define CLIENTSCORE_COLUMNWIDTH_4											7

#define CLIENTSCORE_COLUMNNAME_5											"\bKills"
#define CLIENTSCORE_COLUMNWIDTH_5											7

#define CLIENTSCORE_COLUMNNAME_6											"\bDeaths"
#define CLIENTSCORE_COLUMNWIDTH_6											7

#define CLIENTSCORE_COLUMNNAME_7											"\bJumps"
#define CLIENTSCORE_COLUMNWIDTH_7											7
#define CLIENTSCORE_COLUMNNAME_7_CTF										"\bFlags"
#define CLIENTSCORE_COLUMNWIDTH_7_CTF										7

#define CLIENTSCORE_COLUMNNAME_8											"\bFav. Weapon"
#define CLIENTSCORE_COLUMNWIDTH_8											16

#define CLIENTSCORE_AWARDSTRING_WIDTH										25
#define CLIENTSCORE_PLAYERNAMESTRING_WIDTH									24

// Field / Global Definitions
.float		nClientScore_NumKills;
.float		nClientScore_NumDeaths;
.float		nClientScore_NumJumps;
.float		nClientScore_NumFlagCaptures;
.float		tClientScore_BeginPlayTime;

.float		nClientScore_Award_SelfDamage;
.float		nClientScore_Award_FallingDamage;
.float		nClientScore_Award_LiquidDamage;
.float		nClientScore_Award_NumJumpPads;
.float		nClientScore_Award_NumCharactersSpoken;
.float		nClientScore_Award_NumElectroBallsFired;
.float		nClientScore_Award_NumTeleports;
.float		nClientScore_Award_NumMegaHealths;
.float		nClientScore_Award_ChatDamage;
.float		nClientScore_Award_NumHitsByMortar;
.float		nClientScore_Award_NumWeaponSwitches;
.float		nClientScore_Award_NumHurtTriggerDeaths;
.float		nClientScore_Award_NumWeaponPickups;
.float		nClientScore_Award_NumAmmoPickups;
.float		nClientScore_Award_HealthPickedUp;
.float		nClientScore_Award_ArmorPickedUp;
.float		nClientScore_Award_RadiusDamage;
.float		nClientScore_Award_LongestNexShot;
.float		nClientScore_Award_NumCorpseGibs;

// Weapon Damage Variables (pain in the ass because I can't use field arrays)
.float		nClientScore_WeaponDamage_Laser;
.float		nClientScore_WeaponDamage_Shotgun;
.float		nClientScore_WeaponDamage_Uzi;
.float		nClientScore_WeaponDamage_GrenadeLauncher;
.float		nClientScore_WeaponDamage_Electro;
.float		nClientScore_WeaponDamage_Crylink;
.float		nClientScore_WeaponDamage_Nex;
.float		nClientScore_WeaponDamage_Hagar;
.float		nClientScore_WeaponDamage_RocketLauncher;

// Backup Variables (for clients that go to spectator)
.float		nClientScore_BackupFrags;

// Sorted Score Array
entity		enClientScores_SortedArray[64];
float		enClientScores_SortedArraySize;

// Client Score Award Entity Fields
.string		strClientScoreAwardEntity_ScoreLabel;
.float		nClientScoreAwardEntity_ScoreID;
.float		nClientScoreAwardEntity_CurrentScore;
.entity		enClientScoreAwardEntity_CurrentAwardPlayer;
.float		bClientScoreAwardEntity_AwardAlreadyDisplayed;

.entity		enClientScoreAwardEntity_LinkedList_NextAwardEntity;
.entity		enClientScoreAwardEntity_LinkedList_PreviousAwardEntity;

float		bClientScoreAwardEntitesSpawned;
entity		enClientScoreAwardEntities[CLIENTSCORE_NUMBEROFAWARDS];

// Function Prototypes
float GetClientStatsScore_TotalWeaponDamage(entity enClient);
float GetClientStatsScore_WeaponDamageRatio(entity enClient, float nWeaponDamageToCheck);
string GetFormattedTimeStringZoned(float tTime);

void UpdateClientStatsScore_WeaponDamage(entity enClient, float nWeapon, float fMod)
{ // Update Clients Stats Score - Weapon Damage
	if(nWeapon == IT_LASER)
		enClient.nClientScore_WeaponDamage_Laser = enClient.nClientScore_WeaponDamage_Laser + fMod;
	else
	if(nWeapon == IT_SHOTGUN)
		enClient.nClientScore_WeaponDamage_Shotgun = enClient.nClientScore_WeaponDamage_Shotgun + fMod;
	else
	if(nWeapon == IT_UZI)
		enClient.nClientScore_WeaponDamage_Uzi = enClient.nClientScore_WeaponDamage_Uzi + fMod;
	else
	if(nWeapon == IT_GRENADE_LAUNCHER)
		enClient.nClientScore_WeaponDamage_GrenadeLauncher = enClient.nClientScore_WeaponDamage_GrenadeLauncher + fMod;
	else
	if(nWeapon == IT_ELECTRO)
		enClient.nClientScore_WeaponDamage_Electro = enClient.nClientScore_WeaponDamage_Electro + fMod;
	else
	if(nWeapon == IT_CRYLINK)
		enClient.nClientScore_WeaponDamage_Crylink = enClient.nClientScore_WeaponDamage_Crylink + fMod;
	else
	if(nWeapon == IT_NEX)
		enClient.nClientScore_WeaponDamage_Nex = enClient.nClientScore_WeaponDamage_Nex + fMod;
	else
	if(nWeapon == IT_HAGAR)
		enClient.nClientScore_WeaponDamage_Hagar = enClient.nClientScore_WeaponDamage_Hagar + fMod;
	else
	if(nWeapon == IT_ROCKET_LAUNCHER)
		enClient.nClientScore_WeaponDamage_RocketLauncher = enClient.nClientScore_WeaponDamage_RocketLauncher + fMod;
}

string GetClientStatsScore_MostDamagingWeapon(entity enClient)
{ // Return Client Stats Score - Most Damage Weapon
	local float nHighestDamage;
	local float nHighestWeapon;
	
	// Begin with Laser
	nHighestDamage = enClient.nClientScore_WeaponDamage_Laser;
	nHighestWeapon = IT_LASER;
	
	// Check Items
	if(enClient.nClientScore_WeaponDamage_Shotgun > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_Shotgun;
		nHighestWeapon = IT_SHOTGUN;
	}
	if(enClient.nClientScore_WeaponDamage_Uzi > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_Uzi;
		nHighestWeapon = IT_UZI;
	}
	if(enClient.nClientScore_WeaponDamage_GrenadeLauncher > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_GrenadeLauncher;
		nHighestWeapon = IT_GRENADE_LAUNCHER;
	}
	if(enClient.nClientScore_WeaponDamage_Electro > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_Electro;
		nHighestWeapon = IT_ELECTRO;
	}
	if(enClient.nClientScore_WeaponDamage_Crylink > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_Crylink;
		nHighestWeapon = IT_CRYLINK;
	}
	if(enClient.nClientScore_WeaponDamage_Nex > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_Nex;
		nHighestWeapon = IT_NEX;
	}
	if(enClient.nClientScore_WeaponDamage_Hagar > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_Hagar;
		nHighestWeapon = IT_HAGAR;
	}
	if(enClient.nClientScore_WeaponDamage_RocketLauncher > nHighestDamage)
	{
		nHighestDamage = enClient.nClientScore_WeaponDamage_RocketLauncher;
		nHighestWeapon = IT_ROCKET_LAUNCHER;
	}
	
	// Return Weapon Name
	return W_Name( Item_WeaponCode(nHighestWeapon) );
}
float GetClientStatsScore_TotalWeaponDamage(entity enClient)
{ // Return Client Stats Score - Total Weapon Damage
	// Add Up All Weapon Damages
	local float nTotalWeaponDamage;
	
	nTotalWeaponDamage = enClient.nClientScore_WeaponDamage_Laser
	+ enClient.nClientScore_WeaponDamage_Shotgun
	+ enClient.nClientScore_WeaponDamage_Uzi
	+ enClient.nClientScore_WeaponDamage_GrenadeLauncher
	+ enClient.nClientScore_WeaponDamage_Electro
	+ enClient.nClientScore_WeaponDamage_Crylink
	+ enClient.nClientScore_WeaponDamage_Nex
	+ enClient.nClientScore_WeaponDamage_Hagar
	+ enClient.nClientScore_WeaponDamage_RocketLauncher;
	
	return nTotalWeaponDamage;
}
float GetClientStatsScore_WeaponDamageRatio(entity enClient, float nWeaponDamageToCheck)
{ // Return Client Stats Score - Weapon Damage Ratio
	// Add Up All Weapon Damages
	local float nTotalWeaponDamage;
		nTotalWeaponDamage = GetClientStatsScore_TotalWeaponDamage(enClient);
	
	// Calculate Ratio
	local float fRatio;
		fRatio = nWeaponDamageToCheck / nTotalWeaponDamage;
		
	// DEBUG
	// bprint( strcat("Ratio : ", ftos(fRatio), "\n" ) );
		
	// Return Ratio
	return fRatio;
}

void ResetClientStatsScore(entity enClient)
{ // Reset Client Stats Score
	// Reset Base Scores
	enClient.nClientScore_NumKills = 0;
	enClient.nClientScore_NumDeaths = 0;
	enClient.nClientScore_NumJumps = 0;
	enClient.nClientScore_NumFlagCaptures = 0;
	enClient.tClientScore_BeginPlayTime = 0;
	
	// Reset Base Awards
	enClient.nClientScore_Award_NumJumpPads = 0;
	enClient.nClientScore_Award_SelfDamage = 0;
	enClient.nClientScore_Award_FallingDamage = 0;
	enClient.nClientScore_Award_LiquidDamage = 0;
	enClient.nClientScore_Award_NumCharactersSpoken = 0;
	enClient.nClientScore_Award_NumElectroBallsFired = 0;
	enClient.nClientScore_Award_NumTeleports = 0;
	enClient.nClientScore_Award_NumMegaHealths = 0;
	enClient.nClientScore_Award_ChatDamage = 0;
	enClient.nClientScore_Award_NumHitsByMortar = 0;
	enClient.nClientScore_Award_NumWeaponSwitches = 0;
	enClient.nClientScore_Award_NumHurtTriggerDeaths = 0;
	enClient.nClientScore_Award_NumWeaponPickups = 0;
	enClient.nClientScore_Award_NumAmmoPickups = 0;
	enClient.nClientScore_Award_HealthPickedUp = 0;
	enClient.nClientScore_Award_ArmorPickedUp = 0;
	enClient.nClientScore_Award_RadiusDamage = 0;
	enClient.nClientScore_Award_LongestNexShot = 0;
	enClient.nClientScore_Award_NumCorpseGibs = 0;
	
	// Reset Weapons
	enClient.nClientScore_WeaponDamage_Laser = 0;
	enClient.nClientScore_WeaponDamage_Shotgun = 0;
	enClient.nClientScore_WeaponDamage_Uzi = 0;
	enClient.nClientScore_WeaponDamage_GrenadeLauncher = 0;
	enClient.nClientScore_WeaponDamage_Electro = 0;
	enClient.nClientScore_WeaponDamage_Crylink = 0;
	enClient.nClientScore_WeaponDamage_Nex = 0;
	enClient.nClientScore_WeaponDamage_Hagar = 0;
	enClient.nClientScore_WeaponDamage_RocketLauncher = 0;
}
void UpdateClientStatsScore(entity enClient, float nScoreType, float fMod)
{ // Update Clients Stats Score
	if(nScoreType == CLIENTSCORE_NUMKILLS)
		enClient.nClientScore_NumKills = enClient.nClientScore_NumKills + fMod;
	else
	if(nScoreType == CLIENTSCORE_NUMDEATHS)
		enClient.nClientScore_NumDeaths = enClient.nClientScore_NumDeaths + fMod;
	else
	if(nScoreType == CLIENTSCORE_BEGINPLAYTIME)
		enClient.tClientScore_BeginPlayTime = fMod;
	else
	if(nScoreType == CLIENTSCORE_NUMJUMPS)
		enClient.nClientScore_NumJumps = enClient.nClientScore_NumJumps + fMod;
	else
	if(nScoreType == CLIENTSCORE_NUMFLAGCAPTURES)
		enClient.nClientScore_NumFlagCaptures = enClient.nClientScore_NumFlagCaptures + fMod;
}
void UpdateClientStatsScoreAward(entity enClient, float nAwardType, float fMod)
{ // Update Client Stats Score Award
	if(nAwardType == CLIENTSCORE_AWARD_NUMJUMPPADS)
		enClient.nClientScore_Award_NumJumpPads = enClient.nClientScore_Award_NumJumpPads + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_SELFDAMAGE)
		enClient.nClientScore_Award_SelfDamage = enClient.nClientScore_Award_SelfDamage + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_FALLINGDAMAGE)
		enClient.nClientScore_Award_FallingDamage = enClient.nClientScore_Award_FallingDamage + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_LIQUIDDAMAGE)
		enClient.nClientScore_Award_LiquidDamage = enClient.nClientScore_Award_LiquidDamage + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMCHARACTERSSPOKEN)
		enClient.nClientScore_Award_NumCharactersSpoken = enClient.nClientScore_Award_NumCharactersSpoken + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMELECTROBALLSFIRED)
		enClient.nClientScore_Award_NumElectroBallsFired = enClient.nClientScore_Award_NumElectroBallsFired + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMTELEPORTS)
		enClient.nClientScore_Award_NumTeleports = enClient.nClientScore_Award_NumTeleports + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMMEGAHEALTHS)
		enClient.nClientScore_Award_NumMegaHealths = enClient.nClientScore_Award_NumMegaHealths + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_CHATDAMAGE)
		enClient.nClientScore_Award_ChatDamage = enClient.nClientScore_Award_ChatDamage + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMHITSBYMORTAR)
		enClient.nClientScore_Award_NumHitsByMortar = enClient.nClientScore_Award_NumHitsByMortar + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMWEAPONSWITCHES)
		enClient.nClientScore_Award_NumWeaponSwitches = enClient.nClientScore_Award_NumWeaponSwitches + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMHURTTRIGGERDEATHS)
		enClient.nClientScore_Award_NumHurtTriggerDeaths = enClient.nClientScore_Award_NumHurtTriggerDeaths + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMWEAPONPICKUPS)
		enClient.nClientScore_Award_NumWeaponPickups = enClient.nClientScore_Award_NumWeaponPickups + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMAMMOPICKUPS)
		enClient.nClientScore_Award_NumAmmoPickups = enClient.nClientScore_Award_NumAmmoPickups + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_HEALTHPICKEDUP)
		enClient.nClientScore_Award_HealthPickedUp = enClient.nClientScore_Award_HealthPickedUp + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_ARMORPICKEDUP)
		enClient.nClientScore_Award_ArmorPickedUp = enClient.nClientScore_Award_ArmorPickedUp + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_RADIUSDAMAGE)
		enClient.nClientScore_Award_RadiusDamage = enClient.nClientScore_Award_RadiusDamage + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_LONGESTNEXSHOT)
		enClient.nClientScore_Award_LongestNexShot = enClient.nClientScore_Award_LongestNexShot + fMod;
	else
	if(nAwardType == CLIENTSCORE_AWARD_NUMCORPSEGIBS)
		enClient.nClientScore_Award_NumCorpseGibs = enClient.nClientScore_Award_NumCorpseGibs + fMod;
}
void CheckAndUpdateClientStatsScores_ItemTouch(entity enClient, entity enItem)
{ // Check and Update Client Stats Scores - Item Touch
	// Check for Weapon Pickups
	if(enItem.flags & FL_WEAPON)
		UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_NUMWEAPONPICKUPS, 1);
		
	// Check for Ammo Pickups
	if(enItem.ammo_shells || enItem.ammo_nails || enItem.ammo_rockets || enItem.ammo_cells)
			UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_NUMAMMOPICKUPS, 1);
			
	// Check for Mega Health Pickups
	// NOTE: Classsname check necessary in case map authors adjust health
	if(enItem.items & IT_HEALTH && enItem.netname == "100 Health")
		UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_NUMMEGAHEALTHS, 1);

	// Check for Health Pickups
	if(enItem.max_health)
		UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_HEALTHPICKEDUP, enItem.max_health);
		
	// Check for Health Cap Pickups
	if(enItem.health && enClient.health < enClient.max_health)
		UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_HEALTHPICKEDUP, min(enClient.health + enItem.health, enClient.max_health) );
		
	// Check for Armor Pickups
	if(enItem.armorvalue)
		UpdateClientStatsScoreAward(enClient, CLIENTSCORE_AWARD_ARMORPICKEDUP, enItem.armorvalue);
}
void CheckAndUpdateClientStatsScores_PlayerDamage(entity enAttacker, entity enReceiver, float nDeathType, float fDamage)
{ // Check and Update Client Stats Scores - Player Damage
	if(enReceiver.classname == "player")
	{ // Valid Player
		if(nDeathType == IT_GRENADE_LAUNCHER)
			UpdateClientStatsScoreAward(enReceiver, CLIENTSCORE_AWARD_NUMHITSBYMORTAR, 1);
		else
		if(nDeathType == DEATH_FALL)
			UpdateClientStatsScoreAward(enReceiver, CLIENTSCORE_AWARD_FALLINGDAMAGE, fDamage);
		else
		if(nDeathType == DEATH_DROWN || nDeathType == DEATH_LAVA || nDeathType == DEATH_SLIME)
			UpdateClientStatsScoreAward(enReceiver, CLIENTSCORE_AWARD_LIQUIDDAMAGE, fDamage);
	}
	if(enAttacker.classname == "player" && enReceiver.classname == "player")
	{ // Valid Player Damage
		if(enAttacker == enReceiver)
			// Self Damage
			UpdateClientStatsScoreAward(enAttacker, CLIENTSCORE_AWARD_SELFDAMAGE, fDamage);
		else
		{ // Standard Weapon Damage
			UpdateClientStatsScore_WeaponDamage(enAttacker, nDeathType, fDamage);
		
			// Update Chat Damage (if applicable)
			if(enReceiver.buttonchat)
				UpdateClientStatsScoreAward(enAttacker, CLIENTSCORE_AWARD_CHATDAMAGE, fDamage);
		}
	}
}
void AssignSpecialClientScoreAwardEntityProperties(entity enClientScoreAward, float nCnt)
{ // Assign Special Client Score Entity Properties
	local string strScoreLabel;
	
	switch(nCnt)
	{
		case CLIENTSCORE_AWARD_NUMJUMPPADS:
			strScoreLabel = "\bJump Pad Evangelist";
		break;
		case CLIENTSCORE_AWARD_SELFDAMAGE:
			strScoreLabel = "\bRolemodel Masochist";
		break;
		case CLIENTSCORE_AWARD_FALLINGDAMAGE:
			strScoreLabel = "\bGround Humper";
		break;
		case CLIENTSCORE_AWARD_LIQUIDDAMAGE:
			strScoreLabel = "\bHostile Liquid Lover";
		break;
		case CLIENTSCORE_AWARD_NUMCHARACTERSSPOKEN:
			strScoreLabel = "\bChattiest Motherfucker";
		break;
		case CLIENTSCORE_AWARD_NUMELECTROBALLSFIRED:
			strScoreLabel = "\bElectro Ball Spewer";
		break;
		case CLIENTSCORE_AWARD_NUMTELEPORTS:
			strScoreLabel = "\bTeleport Fanatic";
		break;
		case CLIENTSCORE_AWARD_NUMMEGAHEALTHS:
			strScoreLabel = "\bMega Health Fanboi";
		break;
		case CLIENTSCORE_AWARD_CHATDAMAGE:
			strScoreLabel = "\bChat Damaging DoucheBag";
		break;
		case CLIENTSCORE_AWARD_NUMHITSBYMORTAR:
			strScoreLabel = "\bMortar Pinball";
		break;
		case CLIENTSCORE_AWARD_NUMWEAPONSWITCHES:
			strScoreLabel = "\bWeapon Switcher";
		break;
		case CLIENTSCORE_AWARD_ROCKETWHORE:
			strScoreLabel = "\bRocket Whore";
		break;
		case CLIENTSCORE_AWARD_NUMHURTTRIGGERDEATHS:
			strScoreLabel = "\bVoid Rapist";
		break;
		case CLIENTSCORE_AWARD_NUMWEAPONPICKUPS:
			strScoreLabel = "\bFirearms Collector";
		break;
		case CLIENTSCORE_AWARD_NUMAMMOPICKUPS:
			strScoreLabel = "\bAmmo Asshole";
		break;
		case CLIENTSCORE_AWARD_HEALTHPICKEDUP:
			strScoreLabel = "\bCreature of Health";
		break;
		case CLIENTSCORE_AWARD_ARMORPICKEDUP:
			strScoreLabel = "\bLord of Armor";
		break;
		case CLIENTSCORE_AWARD_RADIUSDAMAGE:
			strScoreLabel = "\bExplosives Demigod";
		break;
		case CLIENTSCORE_AWARD_LONGESTNEXSHOT:
			strScoreLabel = "\bLongest Nex Shot";
		break;
		case CLIENTSCORE_AWARD_NUMCORPSEGIBS:
			strScoreLabel = "\bCorpse Gibber";
		break;
		
		default:
			strScoreLabel = "\bUnknown Award";
		break;
	}
	
	// Assign Label
	enClientScoreAward.strClientScoreAwardEntity_ScoreLabel = strScoreLabel;
	// Assign Score ID
	enClientScoreAward.nClientScoreAwardEntity_ScoreID = nCnt;
}
void CheckClientScoreAwardEntityUpdate(entity enClientScoreAward, entity enCheck)
{ // Check Client Score Award Entity Update
	local float nCheckValue;
	
	switch(enClientScoreAward.nClientScoreAwardEntity_ScoreID)
	{
		case CLIENTSCORE_AWARD_NUMJUMPPADS:
			nCheckValue = enCheck.nClientScore_Award_NumJumpPads;
		break;
		case CLIENTSCORE_AWARD_SELFDAMAGE:
			nCheckValue = enCheck.nClientScore_Award_SelfDamage;
		break;
		case CLIENTSCORE_AWARD_FALLINGDAMAGE:
			nCheckValue = enCheck.nClientScore_Award_FallingDamage;
		break;
		case CLIENTSCORE_AWARD_LIQUIDDAMAGE:
			nCheckValue = enCheck.nClientScore_Award_LiquidDamage;
		break;
		case CLIENTSCORE_AWARD_NUMCHARACTERSSPOKEN:
			nCheckValue = enCheck.nClientScore_Award_NumCharactersSpoken;
		break;
		case CLIENTSCORE_AWARD_NUMELECTROBALLSFIRED:
			nCheckValue = enCheck.nClientScore_Award_NumElectroBallsFired;
		break;
		case CLIENTSCORE_AWARD_NUMTELEPORTS:
			nCheckValue = enCheck.nClientScore_Award_NumTeleports;
		break;
		case CLIENTSCORE_AWARD_NUMMEGAHEALTHS:
			nCheckValue = enCheck.nClientScore_Award_NumMegaHealths;
		break;
		case CLIENTSCORE_AWARD_CHATDAMAGE:
			nCheckValue = enCheck.nClientScore_Award_ChatDamage;
		break;
		case CLIENTSCORE_AWARD_NUMHITSBYMORTAR:
			nCheckValue = enCheck.nClientScore_Award_NumHitsByMortar;
		break;
		case CLIENTSCORE_AWARD_NUMWEAPONSWITCHES:
			nCheckValue = enCheck.nClientScore_Award_NumWeaponSwitches;
		break;
		case CLIENTSCORE_AWARD_ROCKETWHORE:
			// Special Code for Rocket Whore
			nCheckValue = GetClientStatsScore_WeaponDamageRatio(enCheck, enCheck.nClientScore_WeaponDamage_RocketLauncher);
		break;
		case CLIENTSCORE_AWARD_NUMHURTTRIGGERDEATHS:
			nCheckValue = enCheck.nClientScore_Award_NumHurtTriggerDeaths;
		break;
		case CLIENTSCORE_AWARD_NUMWEAPONPICKUPS:
			nCheckValue = enCheck.nClientScore_Award_NumWeaponPickups;
		break;
		case CLIENTSCORE_AWARD_NUMAMMOPICKUPS:
			nCheckValue = enCheck.nClientScore_Award_NumAmmoPickups;
		break;
		case CLIENTSCORE_AWARD_HEALTHPICKEDUP:
			nCheckValue = enCheck.nClientScore_Award_HealthPickedUp;
		break;
		case CLIENTSCORE_AWARD_ARMORPICKEDUP:
			nCheckValue = enCheck.nClientScore_Award_ArmorPickedUp;
		break;
		case CLIENTSCORE_AWARD_RADIUSDAMAGE:
			// Special Code for Radius Damage
			nCheckValue = enCheck.nClientScore_Award_RadiusDamage / GetClientStatsScore_TotalWeaponDamage(enCheck);
		break;
		case CLIENTSCORE_AWARD_LONGESTNEXSHOT:
			nCheckValue = enCheck.nClientScore_Award_LongestNexShot;
		break;
		case CLIENTSCORE_AWARD_NUMCORPSEGIBS:
			nCheckValue = enCheck.nClientScore_Award_NumCorpseGibs;
		break;
		
		
		default:
			nCheckValue = 0;
		break;
	}	
	
	if(nCheckValue > enClientScoreAward.nClientScoreAwardEntity_CurrentScore)
	{ // New Score
		enClientScoreAward.nClientScoreAwardEntity_CurrentScore = nCheckValue;
		enClientScoreAward.enClientScoreAwardEntity_CurrentAwardPlayer = enCheck;
	}
}
void SpawnClientScoreAwardEntities()
{ // Spawn Client Score Award Entities
	local float nCnt;
	if(!bClientScoreAwardEntitesSpawned)
	{ // Entities Not Spawned; Spawn
		for(nCnt = 0; nCnt < CLIENTSCORE_NUMBEROFAWARDS; nCnt++)
		{
			// Spawn Entity
			enClientScoreAwardEntities[nCnt] = spawn();
			// Assign Effects
			enClientScoreAwardEntities[nCnt].effects = EF_NODRAW;
			
			// Assign Special Score Entity Properties
			AssignSpecialClientScoreAwardEntityProperties(enClientScoreAwardEntities[nCnt], nCnt);
		}
		
		// Flag Score Entities Spawned
		bClientScoreAwardEntitesSpawned = TRUE;
	}
}

// -------------------------------------------
// Scoreboard Functions

void PrepareClientScoresSortedArray()
{ // Prepare Client Scores Sorted Array
	local entity enPlayerFind;
	local float nCnt;
		nCnt = 0;
	
	// Insert Players into Array
	enPlayerFind = find(world, classname, "player");
	while(enPlayerFind != world)
	{ // Valid Player
		// Place Player in Array
		enClientScores_SortedArray[nCnt] = enPlayerFind;
		// Inrement Counter
		nCnt = nCnt + 1;
		
		// Acquire Next Player
		enPlayerFind = find(enPlayerFind, classname, "player");
	}
	// Void Latest Entry
	enClientScores_SortedArray[nCnt] = world;
	// Assign Array Size
	enClientScores_SortedArraySize = nCnt;
	
	// bprint("Client Scores Array Size : '", ftos(enClientScores_SortedArraySize), "'\n");
	
	// -------------------------------------------------------------
	// SELECTION SORT ARRAY
		local float nPos;
		local float nSearchPos;
		local entity enSwapBackup;
		local float nHighestElement;
		local float nHighestElementPos;
		
		for(nPos = 0; nPos < enClientScores_SortedArraySize; nPos = nPos + 1)
		{ // Cycle through Array
			// Reset Highest Elements
			nHighestElement = -9999;
			nHighestElementPos = nPos;
			
			// bprint("Main Iteration '", ftos(nPos), "'\n");
			
			for(nSearchPos = nPos; nSearchPos < enClientScores_SortedArraySize; nSearchPos = nSearchPos + 1)
			{ // Acquire Highest Element
				// bprint("Checking Frags of '", enClientScores_SortedArray[nSearchPos].netname, "'\n");
				if( enClientScores_SortedArray[nSearchPos].frags > nHighestElement)
				{ // New Highest Element
					nHighestElement = enClientScores_SortedArray[nSearchPos].frags;
					nHighestElementPos = nSearchPos;
					
					// bprint("Found New Highest Element '", ftos(nHighestElement), "' at Position '", ftos(nHighestElementPos), "'\n");
				}
			}
			
			// Perform Swap
			// Backup Current First Value
			enSwapBackup = enClientScores_SortedArray[nPos];
			// bprint("Swap Backup Name : ", enSwapBackup.netname, "\n");
			// Swap
			enClientScores_SortedArray[nPos] = enClientScores_SortedArray[nHighestElementPos];
			enClientScores_SortedArray[nHighestElementPos] = enSwapBackup;
			
			// bprint("POST Swap Backup Name : ", enSwapBackup.netname, "\n");
		}
	
}

string AppendRowElement(string strMessage, string strRowElement, float nAlignment, float nColumnSize, float bUseColors)
{ // Append Row Element
	local float nSpacingCnt;
	local float nSpacingNeeded;
	
	// Calculate Spacing Needed
	if(bUseColors)
	{ // Retain Color
		nSpacingNeeded = nColumnSize - (strlennocol(strRowElement));
	}
	else
	{ // Kill Color; Utilize Simple Length
		strRowElement = strdecolorize(strRowElement);
		nSpacingNeeded = nColumnSize - (strlen(strRowElement));
	}
		
	// Check for Negative Spacing (Padding)
	if(nSpacingNeeded < 1)
	{ // Utilize Substring of Row Element
		strRowElement = substring(strRowElement, 0, nColumnSize - 4);
		nSpacingNeeded = 4;
	}
	
	if(nAlignment == CLIENTSCORE_ALIGNMENT_RIGHT)
	{ // Left Alignment
		// Append Spacing
		for(nSpacingCnt = 0; nSpacingCnt < nSpacingNeeded; nSpacingCnt++)
			strMessage = strcat(strMessage, " ");
	}
	// Append Content
	strMessage = strcat(strMessage, strRowElement);
	if(nAlignment == CLIENTSCORE_ALIGNMENT_LEFT)
	{ // Right Alignment
		// Append Spacing
		for(nSpacingCnt = 0; nSpacingCnt < nSpacingNeeded; nSpacingCnt++)
			strMessage = strcat(strMessage, " ");
	}
	
	// Return Appended String
	return strMessage;
}

string AppendClientScoringRow(string strMessage, entity enPlayer, float nScorePlace)
{ // Append Client Scoring Row	
	// Append Return
	strMessage = strcat(strMessage, "\n");
	
	local string strElement;
	local float nShift;
	local float bUseColors;
		nShift = 0;
		bUseColors = TRUE;
	
	// Name
	strElement = enPlayer.netname;
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_1, bUseColors);
	
	// Ping
	if( clienttype(enPlayer) == CLIENTTYPE_BOT)
		strElement = "^7BOT";
	else
		strElement = strcat("^7", ftos( rint(enPlayer.ping) ) );
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_2, bUseColors);
	
	// Time
	local string strTime;
		strTime = GetFormattedTimeStringZoned(time - enPlayer.tClientScore_BeginPlayTime);
	strElement = strcat("^7", strTime);
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_3, bUseColors);
	
	// Unzone Time
	strunzone(strTime);
	
	// Score
	strElement = strcat("^7", ftos(enPlayer.frags) );
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_4, bUseColors);
	
	// Kills
	strElement = strcat("^7", ftos(enPlayer.nClientScore_NumKills) );
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_5, bUseColors);
	
	// Deaths
	strElement = strcat("^7", ftos(enPlayer.nClientScore_NumDeaths) );
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_6, bUseColors);
	
	if( cvar("g_ctf") )
	{ // CTF Enabled
		// Flag Captures
		strElement = strcat("^7", ftos(enPlayer.nClientScore_NumFlagCaptures) );
		strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_7_CTF, bUseColors);
	}
	else
	{ // Non-CTF
		// Jumps
		strElement = strcat("^7", ftos(enPlayer.nClientScore_NumJumps) );
		strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_7, bUseColors);
	}
	
	// Favorite Weapon
	strElement = strcat("^7", GetClientStatsScore_MostDamagingWeapon(enPlayer) );
	strMessage = AppendRowElement(strMessage, strElement, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_8, bUseColors);
	
	// Return Appended String
	return strMessage;
}

string AppendClientScoringRowHeaders(string strMessage)
{ // Append Client Scoring Row Headers	
	// Append Return
	strMessage = strcat(strMessage, "\n^2");
	
	local float bUseNoColorLength;
		bUseNoColorLength = FALSE;
		
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_1, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_1, bUseNoColorLength);
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_2, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_2, bUseNoColorLength);
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_3, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_3, bUseNoColorLength);
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_4, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_4, bUseNoColorLength);
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_5, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_5, bUseNoColorLength);
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_6, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_6, bUseNoColorLength);
	
	if( cvar("g_ctf") )
	{ // CTF Enabled
		strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_7_CTF, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_7_CTF, bUseNoColorLength);
	}
	else
	{ // Non-CTF
		strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_7, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_7, bUseNoColorLength);
	}
	strMessage = AppendRowElement(strMessage, CLIENTSCORE_COLUMNNAME_8, CLIENTSCORE_ALIGNMENT_LEFT, CLIENTSCORE_COLUMNWIDTH_8, bUseNoColorLength);
	
	// Append Color Code Removal
	strMessage = strcat(strMessage, "^7");
	
	// Return New String
	return strMessage;
}
string AppendAwardScore(string strMessage, string strAwardText, entity enAwardPlayer, float bUseColors)
{ // Append Award Score
	local float nSpacingNeeded;
	local float nSpacingCnt;
	
	// Append Return(s)
	strMessage = strcat(strMessage, "\n^7\n");
	
	// Acquire Player Name
	local float bStringZoned;
		bStringZoned = FALSE;
	local string strPlayerName;
	if(enAwardPlayer)
	{
		if(bUseColors)
			strPlayerName = strzone(enAwardPlayer.netname);
		else			
			strPlayerName = strzone( strdecolorize(enAwardPlayer.netname) );
		bStringZoned = TRUE;
	}
	else
		strPlayerName = "N/A";
	
	// Calculate Award Text Spacing Needed
	nSpacingNeeded = CLIENTSCORE_AWARDSTRING_WIDTH - strlen(strAwardText);
	
	// DEBUG
	// bprint( strcat("Spacing Needed for '", strAwardText, "' : ", ftos(nSpacingNeeded), "\n" ) );
	
	for(nSpacingCnt = 0; nSpacingCnt < nSpacingNeeded; nSpacingCnt++)
		// Append Space
		strMessage = strcat(strMessage, " ");
	
	// Append Award Text
	strMessage = strcat(strMessage, "^3", strAwardText, "^7");
	
	// Append Separator
	strMessage = strcat(strMessage, " : ");
		
	// Calculate Award Text Spacing Needed
	if(bUseColors)
		nSpacingNeeded = CLIENTSCORE_PLAYERNAMESTRING_WIDTH - strlennocol(strPlayerName);
	else
		nSpacingNeeded = CLIENTSCORE_PLAYERNAMESTRING_WIDTH - strlen(strPlayerName);
		
	// Append Award Player
	strMessage = strcat(strMessage, strPlayerName);
	
	for(nSpacingCnt = 0; nSpacingCnt < nSpacingNeeded; nSpacingCnt++)
		// Append Space
		strMessage = strcat(strMessage, " ");
		
	// Free String
	if(bStringZoned)
		strunzone(strPlayerName);
	
	// Return Modified Message
	return strMessage;
}
string AppendClientScoringAwards(string strMessage, float nNumAwardsDisplay)
{ // Append Client Scoring Awards
	local entity enPlayerFind;
	
	// NEW SYSTEM
	local float nCnt;
	
	// Reset Current Entities
	for(nCnt = 0; nCnt < CLIENTSCORE_NUMBEROFAWARDS; nCnt++)
	{ // Cycle through Awards
		// Reset Award Already Displayed
		enClientScoreAwardEntities[nCnt].bClientScoreAwardEntity_AwardAlreadyDisplayed = FALSE;
		// Reset Linked List Next / Previous Entities
		enClientScoreAwardEntities[nCnt].enClientScoreAwardEntity_LinkedList_NextAwardEntity = world;
		enClientScoreAwardEntities[nCnt].enClientScoreAwardEntity_LinkedList_PreviousAwardEntity = world;
		
		// Reset Score and Award Player
		enClientScoreAwardEntities[nCnt].nClientScoreAwardEntity_CurrentScore = 0;
		enClientScoreAwardEntities[nCnt].enClientScoreAwardEntity_CurrentAwardPlayer = world;
	}
	
	// Acquire First Player
	enPlayerFind = find(world, classname, "player");
	while(enPlayerFind != world)
	{ // Valid Player
		for(nCnt = 0; nCnt < CLIENTSCORE_NUMBEROFAWARDS; nCnt++)
		{ // Cycle through Awards
			// Check for Score Update
			CheckClientScoreAwardEntityUpdate(enClientScoreAwardEntities[nCnt], enPlayerFind);
		}
		// Acquire Next Player
		enPlayerFind = find(enPlayerFind, classname, "player");
	}
	
	// Print Separator
	strMessage = strcat(strMessage, "\n^5\b----------------------------------------------------------------------------------\n\n");
	// Print Header Line
	if(nNumAwardsDisplay == -1)
		strMessage = strcat(strMessage, "^5\bSPECIAL AWARDS (DISPLAYING \bALL\b AWARDS)\n");
	else
		strMessage = strcat(strMessage, "^5\bSPECIAL AWARDS (DISPLAYING ", ftos(nNumAwardsDisplay), "\b of ", ftos(CLIENTSCORE_NUMBEROFAWARDS), "\b AWARDS)\n");
	
	if(nNumAwardsDisplay == -1 || nNumAwardsDisplay >= CLIENTSCORE_NUMBEROFAWARDS)
	{ // Display All Awards
		for(nCnt = 0; nCnt < CLIENTSCORE_NUMBEROFAWARDS; nCnt++)
		{ // Cycle through Awards
			strMessage = AppendAwardScore(strMessage, enClientScoreAwardEntities[nCnt].strClientScoreAwardEntity_ScoreLabel, enClientScoreAwardEntities[nCnt].enClientScoreAwardEntity_CurrentAwardPlayer, TRUE);
		}
	}
	else
	{ // Random Awards to Display
		// LINKED LIST SYSTEM
		local entity enHead;
		local entity enCurrent;
		local entity enPrevious;
		local float nNumLinkedEntities;
		local float nRandom;
		
		// *****************************************
		// Prepare Linked List
			for(nCnt = 0; nCnt < CLIENTSCORE_NUMBEROFAWARDS; nCnt++)
			{ // Cycle through Awards
				if(enClientScoreAwardEntities[nCnt].enClientScoreAwardEntity_CurrentAwardPlayer)
				{ // Valid Award
					if(!enHead)
					{ // Assign Head Entity
						enHead = enClientScoreAwardEntities[nCnt];
						enCurrent = enHead;
					}
						
					// Assign Next Award Entity
					enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity = enClientScoreAwardEntities[nCnt];
					// Backup Current
					enPrevious = enCurrent;
					// Assign New Current
					enCurrent = enClientScoreAwardEntities[nCnt];
					// Assign Previous
					enCurrent.enClientScoreAwardEntity_LinkedList_PreviousAwardEntity = enPrevious;
					// Increment Number of Linked Entities
					nNumLinkedEntities = nNumLinkedEntities + 1;
				}
			}
			
			// End of List; Loop to Front
			if(nNumLinkedEntities)
			{
				enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity = enHead;
				// Assign Head Previous
				enHead.enClientScoreAwardEntity_LinkedList_PreviousAwardEntity = enCurrent;
			}
		// *****************************************
		
		// DEBUG - Display Linked List Contents
		/*
		enCurrent = enHead;
		local string strLinkedPrint;
		for(nCnt = 0; nCnt < nNumLinkedEntities; nCnt++)
		{
			strLinkedPrint = strcat("Linked List ", ftos(nCnt), " : ", enCurrent.enClientScoreAwardEntity_LinkedList_PreviousAwardEntity.strClientScoreAwardEntity_ScoreLabel, " <- ");
			strLinkedPrint = strcat(strLinkedPrint, enCurrent.strClientScoreAwardEntity_ScoreLabel, " -> ", enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity.strClientScoreAwardEntity_ScoreLabel, "\n");
			bprint(strLinkedPrint);
			enCurrent = enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity;
		}
		*/
		
		if(nNumLinkedEntities < nNumAwardsDisplay)
			// Linked Entity Count Less than Desired; Display All
			nNumAwardsDisplay = nNumLinkedEntities;
			
		local float nLinkPosCnt;
			
		for(nCnt = 0; nCnt < nNumAwardsDisplay; nCnt++)
		{ // Display Awards
			// Acquire Random Number
			nRandom = rint( random() * (nNumLinkedEntities) );
			
			// Assign Current to Head
			enCurrent = enHead;
			
			// DEBUG
			// bprint("Random Linked List Acquisition : ", ftos(nRandom), "\n");
			
			for(nLinkPosCnt = 0; nLinkPosCnt < nRandom; nLinkPosCnt++)
			{ // Acquire Linked List Entity
				// Acquire Next Entity
				enCurrent = enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity;
			}
				
			// Display Award
			strMessage = AppendAwardScore(strMessage, enCurrent.strClientScoreAwardEntity_ScoreLabel, enCurrent.enClientScoreAwardEntity_CurrentAwardPlayer, TRUE);
			
			// Decrement Number of Linked Entities
			nNumLinkedEntities = nNumLinkedEntities - 1;
			
			if(nNumLinkedEntities)
			{ // Shift Linked List
				enCurrent.enClientScoreAwardEntity_LinkedList_PreviousAwardEntity.enClientScoreAwardEntity_LinkedList_NextAwardEntity = enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity;
				enCurrent.enClientScoreAwardEntity_LinkedList_NextAwardEntity.enClientScoreAwardEntity_LinkedList_PreviousAwardEntity = enCurrent.enClientScoreAwardEntity_LinkedList_PreviousAwardEntity;
				
				if(enCurrent == enHead)
					enHead = enHead.enClientScoreAwardEntity_LinkedList_NextAwardEntity;
			}
		}
		
		// RANDOM ARRAY SYSTEM
		/*
		local float bNotFound;
		local float nRandom;
		local float nSanityCheck;
		local float nInvalidAwardCnt;
		
		for(nCnt = 0; nCnt < nNumAwardsDisplay; nCnt++)
		{ // Append Awards
			// Reset Not Found
			bNotFound = TRUE;
			// Reset Sanity Check
			nSanityCheck = 0;
			
			while(bNotFound)
			{ // Find New Award
				// Increment Sanity Check
				nSanityCheck = nSanityCheck + 1;
				
				// Acquire Random Number
				nRandom = rint( random() * (CLIENTSCORE_NUMBEROFAWARDS - 1) );
				
				if( !enClientScoreAwardEntities[nRandom].bClientScoreAwardEntity_AwardAlreadyDisplayed)
				{ // New Award Found
					// Flag Award Already Displayed
					enClientScoreAwardEntities[nRandom].bClientScoreAwardEntity_AwardAlreadyDisplayed = TRUE;
					
					if(enClientScoreAwardEntities[nRandom].enClientScoreAwardEntity_CurrentAwardPlayer)
					{ // Valid Award Player
						// Display Award
						strMessage = AppendAwardScore(strMessage, enClientScoreAwardEntities[nRandom].strClientScoreAwardEntity_ScoreLabel, enClientScoreAwardEntities[nRandom].enClientScoreAwardEntity_CurrentAwardPlayer);
						
						// Assign Found
						bNotFound = FALSE;
					}
					else
					{ // Invalid Award Player
						// Increment Invalid Award Count
						nInvalidAwardCnt = nInvalidAwardCnt + 1;
					}
				}
				
				// Check for Potential Overflow due to more invalid awards than possible to display
				if( (nInvalidAwardCnt + nCnt) > (CLIENTSCORE_NUMBEROFAWARDS - 1) )
				{ // Awards Overflowed; Stop
					// Assign not Found
					bNotFound = FALSE;
					// End Loop
					nCnt = nNumAwardsDisplay;
				}
				
				// Check Sanity
				if(nSanityCheck > 200)
				{ // Sanity Failed!
					bprint("^1WARNING : ^2AppendClientScoringAwards^7 Loop Failed Sanity!\n");
					bNotFound = FALSE;
				}
			}
		}
		*/
	}
	
	/*
	// Self Damage Award
	local entity enCurrentAwardPlayer_SelfDamage;
	local float nCurrentMax_SelfDamage;
	// Num Jump Pads Award
	local entity enCurrentAwardPlayer_NumJumpPads;
	local float nCurrentMax_NumJumpPads;
	// Rocket Damage Ratio Award
	local float nRocketDamageRatio;
	local entity enCurrentAwardPlayer_RocketDamageRatio;
	local float nCurrentMax_RocketDamageRatio;
	// Electro Balls Fired Award
	local entity enCurrentAwardPlayer_ElectroBallsFired;
	local float nCurrentMax_ElectroBallsFired;
	// Num Teleports Award
	local entity enCurrentAwardPlayer_NumTeleports;
	local float nCurrentMax_NumTeleports;
	// Num Says Award
	local entity enCurrentAwardPlayer_NumSays;
	local float nCurrentMax_NumSays;
	// Num Mega Healths Award
	local entity enCurrentAwardPlayer_NumMegaHealths;
	local float nCurrentMax_NumMegaHealths;
	// Num Chat Kills Award
	local entity enCurrentAwardPlayer_NumChatKills;
	local float nCurrentMax_NumChatKills;
	// Num Hits by Mortar Award
	local entity enCurrentAwardPlayer_NumHitsByMortar;
	local float nCurrentMax_NumHitsByMortar;
	
	// Acquire Awards through single loop for performance reasons
	
	// Acquire First Player
	enPlayerFind = find(world, classname, "player");
	while(enPlayerFind != world)
	{ // Valid Player
		// Check Self Damage
		if(enPlayerFind.nClientScore_SelfDamage > nCurrentMax_SelfDamage)
		{ // New Score
			nCurrentMax_SelfDamage = enPlayerFind.nClientScore_SelfDamage;
			enCurrentAwardPlayer_SelfDamage = enPlayerFind;
		}
		
		// Check Num Jump Pads
		if(enPlayerFind.nClientScore_NumJumpPads > nCurrentMax_NumJumpPads)
		{ // New Score
			nCurrentMax_NumJumpPads = enPlayerFind.nClientScore_NumJumpPads;
			enCurrentAwardPlayer_NumJumpPads = enPlayerFind;
		}
		
		// Check Rocket Damage Ratio
		nRocketDamageRatio = GetClientStatsScore_WeaponDamageRatio(enPlayerFind, enPlayerFind.nClientScore_WeaponDamage_RocketLauncher);
		if(nRocketDamageRatio > nCurrentMax_RocketDamageRatio)
		{ // New Score
			nCurrentMax_RocketDamageRatio = nRocketDamageRatio;
			enCurrentAwardPlayer_RocketDamageRatio = enPlayerFind;
		}
		
		// Check Electro Balls Fired
		if(enPlayerFind.nClientScore_NumElectroBallsFired > nCurrentMax_ElectroBallsFired)
		{ // New Score
			nCurrentMax_ElectroBallsFired = enPlayerFind.nClientScore_NumElectroBallsFired;
			enCurrentAwardPlayer_ElectroBallsFired = enPlayerFind;
		}
		
		// Check Num Teleports
		if(enPlayerFind.nClientScore_NumTeleports > nCurrentMax_NumTeleports)
		{ // New Score
			nCurrentMax_NumTeleports = enPlayerFind.nClientScore_NumTeleports;
			enCurrentAwardPlayer_NumTeleports = enPlayerFind;
		}
		
		// Check Num Mega Healths
		if(enPlayerFind.nClientScore_NumMegaHealths > nCurrentMax_NumMegaHealths)
		{ // New Score
			nCurrentMax_NumMegaHealths = enPlayerFind.nClientScore_NumMegaHealths;
			enCurrentAwardPlayer_NumMegaHealths = enPlayerFind;
		}
		
		// Check Num Says
		if(enPlayerFind.nClientScore_NumSays > nCurrentMax_NumSays)
		{ // New Score
			nCurrentMax_NumSays = enPlayerFind.nClientScore_NumSays;
			enCurrentAwardPlayer_NumSays = enPlayerFind;
		}
		
		// Check Num Chat Kills
		if(enPlayerFind.nClientScore_NumChatKills > nCurrentMax_NumChatKills)
		{ // New Score
			nCurrentMax_NumChatKills = enPlayerFind.nClientScore_NumChatKills;
			enCurrentAwardPlayer_NumChatKills = enPlayerFind;
		}
		
		// Check Num Hits by Mortar
		if(enPlayerFind.nClientScore_NumHitsByMortar > nCurrentMax_NumHitsByMortar)
		{ // New Score
			nCurrentMax_NumHitsByMortar = enPlayerFind.nClientScore_NumHitsByMortar;
			enCurrentAwardPlayer_NumHitsByMortar = enPlayerFind;
		}
		
		// Acquire Next Player
		enPlayerFind = find(enPlayerFind, classname, "player");
	}
	
	// Print Separator
	strMessage = strcat(strMessage, "\n^5\b---------------------------------------------------------------------------\n\n");
	// Print Header Line
	strMessage = strcat(strMessage, "^5\bSPECIAL AWARDS\n");
	
	
	// Print Awards
	strMessage = AppendAwardScore(strMessage, "\bRolemodel Masochist", enCurrentAwardPlayer_SelfDamage);
	strMessage = AppendAwardScore(strMessage, "\bJump Pad Evangelist", enCurrentAwardPlayer_NumJumpPads);
	strMessage = AppendAwardScore(strMessage, "\bChatKill DoucheBag", enCurrentAwardPlayer_NumChatKills);
	strMessage = AppendAwardScore(strMessage, "\bRocket Whore", enCurrentAwardPlayer_RocketDamageRatio);
	strMessage = AppendAwardScore(strMessage, "\bElectro Ball Spewer", enCurrentAwardPlayer_ElectroBallsFired);
	strMessage = AppendAwardScore(strMessage, "\bMortar Pinball", enCurrentAwardPlayer_NumHitsByMortar);
	strMessage = AppendAwardScore(strMessage, "\bMega Health Fanboi", enCurrentAwardPlayer_NumMegaHealths);
	strMessage = AppendAwardScore(strMessage, "\bTeleport Fanatic", enCurrentAwardPlayer_NumTeleports);
	strMessage = AppendAwardScore(strMessage, "\bChattiest Motherfucker", enCurrentAwardPlayer_NumSays);
	
	*/
	
	// Return Message
	return strMessage;
}
void PrintClientScoring(entity enPlayer, float bIntermission)
{ // Print Client Scoring
	local string strMessage;

	// Print Title
	strMessage = "^5\bSPIDFLISK CLIENT SCORING\n";
	// Print Sorting Method
	strMessage = strcat(strMessage, "\n");
	// strMessage = strcat(strMessage, "SORTED BY FRAGS\n");
	
	// Print Row Headers
	strMessage = AppendClientScoringRowHeaders(strMessage);
	
	// Append Return
	strMessage = strcat(strMessage, "\n");
	
	// Print Client Rows
	
	// Utilize Sorted Array
	local float nCnt;
	
	// Prepare Sorted Array
	PrepareClientScoresSortedArray();
	
	// Determine Number of Returns
	local string strReturns;
	if(enClientScores_SortedArraySize > 5)
		strReturns = "\n^7";
	else
		strReturns = "\n^7";
		// strReturns = "\n^7\n";
	
	for(nCnt = 0; nCnt < enClientScores_SortedArraySize; nCnt = nCnt + 1)
	{ // Cycle through Sorted Array
		// Append Client Scoring Raw
		strMessage = AppendClientScoringRow(strMessage, enClientScores_SortedArray[nCnt], nCnt + 1);
		
		// Append Return(s)
		strMessage = strcat(strMessage, strReturns);
	}
	
	// Acquire Number of Awards to Display
	local float nNumAwardsDisplay;
		nNumAwardsDisplay = cvar(CVAR_INTERMISSION_ADVANCEDCLIENTSCORES_NUMBEROFAWARDSTODISPLAY);
	
	// Append Awards
	if(nNumAwardsDisplay != 0)
		strMessage = AppendClientScoringAwards(strMessage, nNumAwardsDisplay);
	
	// Utilize Standard Searching
	/*
	local entity enPlayerFind;
	// Acquire First Player
	enPlayerFind = find(world, classname, "player");
	while(enPlayerFind != world)
	{ // Valid Player
		// Append Client Scoring Raw
		strMessage = AppendClientScoringRow(strMessage, enPlayerFind);
		
		// Append Two Returns
		strMessage = strcat(strMessage, "\n^7\n");
		
		// Acquire Next Player
		enPlayerFind = find(enPlayerFind, classname, "player");
	}
	*/
	
	// Display to Entity
	if(bIntermission)
		WriteString(MSG_ALL, strMessage);
	else
	{
		// Centerprint
		centerprint(enPlayer, strMessage);
		// Play Sound
		stuffcmd(enPlayer, "play2 sound/misc/menu2\n");
	}
}