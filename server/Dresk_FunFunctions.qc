// Dresk - Cmds
// Provides Support for Random Fun Functions

// Definitions
#define FUNFUNCTION_TOGGLEPLAYERBLOODSHOWERTHINK_CMD_NAME					"FunFunc_TogglePlayerBloodShowerThink"
#define FUNFUNCTION_TOGGLEPLAYERFORM_CMD_NAME								"FunFunc_TogglePlayerForm"

#define FUNFORM_UNKNOWN														-1
#define FUNFORM_NONE														0
#define FUNFORM_NONE_NAME													"none"
#define FUNFORM_GHOST														2
#define FUNFORM_GHOST_NAME													"ghost"
#define FUNFORM_DEATHSPECTRE												3
#define FUNFORM_DEATHSPECTRE_NAME											"deathspectre"
#define FUNFORM_HEALTHANGEL													4
#define FUNFORM_HEALTHANGEL_NAME											"healthangel"

#define FUNFORM_GHOST_FLAGS													FL_GODMODE | FL_NOTARGET

#define FUNFORM_DEATHSPECTRE_FLAGS											FL_GODMODE | FL_NOTARGET
#define FUNFORM_DEATHSPECTRE_EFFECTS										EF_FLAME | EF_STARDUST

#define FUNFORM_HEALTHANGEL_FLAGS											FL_NOTARGET | FL_GODMODE
#define FUNFORM_HEALTHANGEL_EFFECTS											EF_STARDUST | EF_BRIGHTFIELD | EF_DIMLIGHT


// Fields
.float FunFunc_tPlayerBloodShowerNextThinkTime;
.float FunFunc_bPlayerBloodShowerThinkEnabled;
.float FunFunc_nPlayerForm;
.void(entity) FunFunc_fpToggleForm;

.string FunFunc_strPreviousModel;

// Prototypes
void FunFunction_ToggleForm_Ghost(entity enPlayer);
void FunFunction_ToggleForm_DeathSpectre(entity enPlayer);
void FunFunction_ToggleForm_HealthAngel(entity enPlayer);

// Functions
void ExteriorWeaponLaserDraw(entity enPlayer, float bDraw)
{
	if(enPlayer.exteriorweaponentity.enExteriorWeaponLaser)
	{ // Laser Entity Exists
		if(bDraw)
			enPlayer.exteriorweaponentity.enExteriorWeaponLaser.effects = enPlayer.exteriorweaponentity.enExteriorWeaponLaser.effects - (enPlayer.exteriorweaponentity.enExteriorWeaponLaser.effects & EF_NODRAW);			
		else
			enPlayer.exteriorweaponentity.enExteriorWeaponLaser.effects = enPlayer.exteriorweaponentity.enExteriorWeaponLaser.effects | EF_NODRAW;
	}
}
void FunFunction_SendFunFunctionAliases(entity enClient)
{ // Send Fun Function Aliases
	stuffcmd(enClient, "alias Fun_TogglePlayerBloodShower \"cmd FunFunc_TogglePlayerBloodShowerThink\"\n");
	stuffcmd(enClient, "alias Fun_TogglePlayerForm \"cmd FunFunc_TogglePlayerForm $*\"\n");
}
string FunFunction_GetFormStringFromFormID(float nFormID)
{ // Return Form String from Form ID
	local string strReturn;
	switch(nFormID)
	{
		case FUNFORM_NONE:
			strReturn = "None";
		break;
		case FUNFORM_GHOST:
			strReturn = "Ghost";
		break;
		case FUNFORM_DEATHSPECTRE:
			strReturn = "DeathSpectre";
		break;
		case FUNFORM_HEALTHANGEL:
			strReturn = "HealthAngel";
		break;
		default:
			strReturn = "Unknown";
		break;
	}
	
	return strReturn;
}
float FunFunction_GetFormIDFromFormString(string strForm)
{ // Return FormID from String
	local float nReturn;
	switch(strForm)
	{
		case FUNFORM_NONE_NAME:
			nReturn = FUNFORM_NONE;
		break;
		case FUNFORM_GHOST_NAME:
			nReturn = FUNFORM_GHOST;
		break;
		case FUNFORM_DEATHSPECTRE_NAME:
			nReturn = FUNFORM_DEATHSPECTRE;
		break;
		case FUNFORM_HEALTHANGEL_NAME:
			nReturn = FUNFORM_HEALTHANGEL;
		break;
		default:
			nReturn = FUNFORM_UNKNOWN;
		break;
	}
	
	return nReturn;
}
void FunFunction_TogglePlayerForm(entity enPlayer, string strForm)
{ // Toggle Player Form
	local float bTogglingForm;
	local void(entity) fpOldToggleForm;
	local void(entity) fpToggleForm;
		bTogglingForm = TRUE;
	local string strMessage;
	
	if( GetClientIsAdministrator(enPlayer) )
	{ // Admin; Allowed
		// Check Currently Player and Alive
		if(enPlayer.classname == "player" && enPlayer.deadflag == DEAD_NO)
		{ // Valid Alive Player
			
			// Backup Old Toggle Form
			fpOldToggleForm = enPlayer.FunFunc_fpToggleForm;
				
			switch(strForm)
			{
				case FUNFORM_NONE_NAME:
					fpToggleForm = enPlayer.FunFunc_fpToggleForm;
				break;
				case FUNFORM_GHOST_NAME:
					fpToggleForm = FunFunction_ToggleForm_Ghost;
				break;
				case FUNFORM_DEATHSPECTRE_NAME:
					fpToggleForm = FunFunction_ToggleForm_DeathSpectre;
				break;
				case FUNFORM_HEALTHANGEL_NAME:
					fpToggleForm = FunFunction_ToggleForm_HealthAngel;
				break;
				default:
					bTogglingForm = FALSE;
					// Report Message
					if(strForm == "")
					{ // No Form Provided; List Forms
						strMessage = "^1AVAILABLE FORMS :^2";
						strMessage = strcat(strMessage, " ", FUNFORM_NONE_NAME, " ", FUNFORM_GHOST_NAME, " ", FUNFORM_DEATHSPECTRE_NAME);
						strMessage = strcat(strMessage, " ", FUNFORM_HEALTHANGEL_NAME);
						strMessage = strcat(strMessage, "\n");
					}
					else
						// Print Unknown Form
						strMessage = strcat("^1UNKNOWN FORM : ^2", strForm, "\n");
						
					// Display Message
					sprint(enPlayer, strMessage);
				break;
			}
			
			if(bTogglingForm)
			{ // Toggling Form
				if(enPlayer.FunFunc_nPlayerForm == FUNFORM_NONE)
				{ // Shifting from None Form
					// Assign Previous Player Model
					enPlayer.FunFunc_strPreviousModel = enPlayer.model;
					
					// Report Form Removal
					strMessage = strcat(enPlayer.netname, "^7 Switched from ^2", FunFunction_GetFormStringFromFormID(enPlayer.FunFunc_nPlayerForm), "^7 Form ");
				}
				if(enPlayer.FunFunc_nPlayerForm)
				{ // Remove Current Form
					// Report Form Removal
					strMessage = strcat(enPlayer.netname, "^7 Switched from ^2", FunFunction_GetFormStringFromFormID(enPlayer.FunFunc_nPlayerForm), "^7 Form ");
					// Remove Form
					fpOldToggleForm(enPlayer);
				}
				if(fpToggleForm == enPlayer.FunFunc_fpToggleForm)
				{ // Same Toggle Form
					// Assign NULL Form
					enPlayer.FunFunc_fpToggleForm = SUB_Null;
					enPlayer.FunFunc_nPlayerForm = FUNFORM_NONE;
				}
				else
				{ // New Form
					// Invoke Toggle Form
					fpToggleForm(enPlayer);
					// Assign Form
					enPlayer.FunFunc_fpToggleForm = fpToggleForm;
				}
				// Report Form Toggle
				strMessage = strcat(strMessage, "to ^2", FunFunction_GetFormStringFromFormID(enPlayer.FunFunc_nPlayerForm), "^7 Form!\n");
					bprint(strMessage);
				// Play Sound
				if(bUsingSpidfliskSoundPack)
					sound(world, CHAN_AUTO, "Spidflisk/misc/FunForm_ChangeForm.ogg", 1, ATTN_NONE);
				else
					sound(world, CHAN_AUTO, "misc/menu2.wav", 1, ATTN_NONE);
			}
		}
		else
			sprint(enPlayer, "^1ERROR: ^7You must be ^2ALIVE^7 to change forms!\n");
	}
}
// ---------------------------------------------------
// TOGGLE FORM FUNCTIONS
float FunFunction_Form_CheckSpecialAttackAvailable(float fAttackTime)
{ // Check Special Attack Available
	local float bReturn;
		bReturn = TRUE;
	if(self.tSpecialWeaponActionAttackTime < time)
	{ // Attack Allowed
		// Update Attack Time
		self.tSpecialWeaponActionAttackTime = time + fAttackTime;
	}
	else
		bReturn = FALSE;
		
	return bReturn;
}
void FunFunction_Form_Ghost_AttackFunction()
{ // Attack Function
	if(self.tSpecialWeaponActionAttackTime < time)
	{ // Attack Allowed
		// Update Attack Time
		self.tSpecialWeaponActionAttackTime = time + 0.2;
		
		if(self.button0)
			// Primary Attack
			te_smallflash(self.origin);
		if(self.button2)
			// Jump
			te_lavasplash(self.origin);
		if(self.button3)
			// Secondary Attack
			te_customflash(self.origin, 500, 50, '0.4 0 0');
	}
}
void FunFunction_Form_DeathSpectre_AttackFunction()
{ // Attack Function
	if(self.tSpecialWeaponActionAttackTime < time)
	{ // Attack Allowed
		// Update Attack Time
		self.tSpecialWeaponActionAttackTime = time + 0.2;
		
		if(self.button0)
			// Primary Attack
			PlayerBloodshowerDamage(self, 5000);
		if(self.button2)
		{ // Jump
			// Light Flash!
			te_customflash(self.origin, 2000, 300, '1 1 1');
			sound(self, CHAN_AUTO, "weapons/neximpact.wav", 1, ATTN_NORM);
		}
		if(self.button3)
			// Secondary Attack
			LaunchProjectileGib_ExplosiveFlamingSkull(self);
	}
}
void LaunchHealthAngelHealthEntity(float nItemType)
{ // Launch Health Angel Health Entity
	local entity enOldSelf;
		enOldSelf = self;
	local entity enHealth;
		enHealth = spawn();
		self = enHealth;
		
	// self.owner = enOldSelf;
	self.classname = "droppedweapon";
	
	setorigin(self, enOldSelf.origin);
		
	// Invoke Item Function
	if(nItemType == 1)
		item_health25();
	else
	if(nItemType == 2)
		item_armor25();
	
	// Assign Different Values
	self.colormod = '0 0 1';
	self.glow_trail = 1;
	self.glow_color = 500;
	self.movetype = MOVETYPE_BOUNCE;
	self.effects = self.effects | EF_STARDUST;
	
	// Restore Old Self
	self = enOldSelf;
	
	// Prepare Velocity
	W_SetupShot(self, '15 3 -8', FALSE, 0, "");
		
	enHealth.velocity = w_shotdir * 2000;
}
void FunFunction_Form_HealthAngel_AttackFunction()
{ // Attack Function
	if(self.tSpecialWeaponActionAttackTime < time)
	{ // Attack Allowed
		if(self.button0)
			// Primary Attack
			LaunchHealthAngelHealthEntity(1);
		if(self.button2)
		{ // Jump
		}
		if(self.button3)
			// Secondary Attack
			LaunchHealthAngelHealthEntity(2);
			
		// Update Attack Time
		self.tSpecialWeaponActionAttackTime = time + 0.5;
	}
}
void FunFunction_ToggleForm_Ghost(entity enPlayer)
{ // Toggle Ghost Form
	if(enPlayer.FunFunc_nPlayerForm == FUNFORM_GHOST)
	{ // Remove Form
		enPlayer.FunFunc_nPlayerForm = FUNFORM_NONE;
		enPlayer.alpha = 1.0;
		setmodel(enPlayer, enPlayer.FunFunc_strPreviousModel);
		setsize(enPlayer, PL_MIN, PL_MAX);
		enPlayer.movetype = MOVETYPE_WALK;
		enPlayer.solid = SOLID_SLIDEBOX;
		enPlayer.flags = enPlayer.flags - (enPlayer.flags & FUNFORM_GHOST_FLAGS);
		enPlayer.bIgnoreDamage = FALSE;
		enPlayer.takedamage = DAMAGE_AIM;
		enPlayer.bDisableWeaponActions = FALSE;
		enPlayer.fpWeaponActionFunction = SUB_Null;
		
		ExteriorWeaponLaserDraw(enPlayer, TRUE);
	}
	else
	{ // Grant Form
		enPlayer.FunFunc_nPlayerForm = FUNFORM_GHOST;
		enPlayer.alpha = 0.001;
		setmodel(enPlayer, "");
		enPlayer.movetype = MOVETYPE_NOCLIP;
		enPlayer.solid = SOLID_NOT;
		enPlayer.flags = enPlayer.flags | FUNFORM_GHOST_FLAGS;

		enPlayer.bIgnoreDamage = TRUE;
		enPlayer.takedamage = DAMAGE_NO;
		
		enPlayer.bDisableWeaponActions = TRUE;
		
		enPlayer.fpWeaponActionFunction = FunFunction_Form_Ghost_AttackFunction;
		
		ExteriorWeaponLaserDraw(enPlayer, FALSE);
	}
}
void FunFunction_DeathSpectre_Touch()
{ // Death Spectre - Touch
	if(other.classname == "player")
	{ // Valid Touch Target
		Damage(other, self, self, 500000, DEATH_DEATHSPECTRETOUCH, '0 0 0', '0 0 0');
	}
}
void FunFunction_ToggleForm_DeathSpectre(entity enPlayer)
{ // Toggle Death Spectre
	if(enPlayer.FunFunc_nPlayerForm == FUNFORM_DEATHSPECTRE)
	{ // Remove Form
		enPlayer.FunFunc_nPlayerForm = FUNFORM_NONE;
		enPlayer.alpha = 1.0;
		setmodel(enPlayer, enPlayer.FunFunc_strPreviousModel);
		setsize(enPlayer, PL_MIN, PL_MAX);
		enPlayer.movetype = MOVETYPE_WALK;
		enPlayer.flags = enPlayer.flags - (enPlayer.flags & FUNFORM_DEATHSPECTRE_FLAGS);
		enPlayer.effects = enPlayer.effects - (enPlayer.effects & FUNFORM_DEATHSPECTRE_EFFECTS);
		enPlayer.touch = SUB_Null;
		enPlayer.glow_trail = 0;
		enPlayer.glow_color = 0;
		

		enPlayer.exteriorweaponentity.glow_trail = 0;
		enPlayer.exteriorweaponentity.glow_color = 0;
		
		enPlayer.bIgnoreDamage = FALSE;
		enPlayer.bDisableWeaponActions = FALSE;
		
		enPlayer.fpWeaponActionFunction = SUB_Null;
		enPlayer.bCannotTouchItems = FALSE;
		
		ExteriorWeaponLaserDraw(enPlayer, TRUE);
	}
	else
	{ // Grant Form
		enPlayer.FunFunc_nPlayerForm = FUNFORM_DEATHSPECTRE;
		enPlayer.alpha = 0.001;
		
		setmodel(enPlayer, "");
		setsize(enPlayer, PL_MIN, PL_MAX);
		enPlayer.movetype = MOVETYPE_FLY;
		enPlayer.flags = enPlayer.flags | FUNFORM_DEATHSPECTRE_FLAGS;
		enPlayer.effects = enPlayer.effects | FUNFORM_DEATHSPECTRE_EFFECTS;
		
		enPlayer.touch = FunFunction_DeathSpectre_Touch;

		enPlayer.glow_trail = 1;
		enPlayer.glow_color = 75;
		
		enPlayer.exteriorweaponentity.glow_trail = 1;
		enPlayer.exteriorweaponentity.glow_color = 75;
		
		enPlayer.bIgnoreDamage = TRUE;
		enPlayer.bDisableWeaponActions = TRUE;
		
		enPlayer.fpWeaponActionFunction = FunFunction_Form_DeathSpectre_AttackFunction;
		enPlayer.bCannotTouchItems = TRUE;
		
		ExteriorWeaponLaserDraw(enPlayer, FALSE);
	}
}
void FunFunction_ToggleForm_HealthAngel(entity enPlayer)
{ // Toggle Health Angel
	if(enPlayer.FunFunc_nPlayerForm == FUNFORM_HEALTHANGEL)
	{ // Remove Form
		enPlayer.FunFunc_nPlayerForm = FUNFORM_NONE;
		enPlayer.alpha = 1.0;
		setmodel(enPlayer, enPlayer.FunFunc_strPreviousModel);
		setsize(enPlayer, PL_MIN, PL_MAX);
		enPlayer.movetype = MOVETYPE_WALK;
		
		enPlayer.flags = enPlayer.flags - (enPlayer.flags & FUNFORM_HEALTHANGEL_FLAGS);
		enPlayer.effects = enPlayer.effects - (enPlayer.effects & FUNFORM_HEALTHANGEL_EFFECTS);
		
		enPlayer.glow_trail = 0;
		enPlayer.glow_color = 0;
		
		enPlayer.exteriorweaponentity.glow_trail = 0;
		enPlayer.exteriorweaponentity.glow_color = 0;
		
		enPlayer.bDisableWeaponActions = FALSE;
		enPlayer.fpWeaponActionFunction = SUB_Null;
		enPlayer.bCannotTouchItems = FALSE;
		
		ExteriorWeaponLaserDraw(enPlayer, TRUE);
	}
	else
	{ // Grant Form
		enPlayer.FunFunc_nPlayerForm = FUNFORM_HEALTHANGEL;
		enPlayer.alpha = 0.001;
		setmodel(enPlayer, "");
		setsize(enPlayer, PL_MIN, PL_MAX);

		enPlayer.movetype = MOVETYPE_FLY;
		
		enPlayer.flags = enPlayer.flags | FUNFORM_HEALTHANGEL_FLAGS;
		enPlayer.effects = enPlayer.effects | FUNFORM_HEALTHANGEL_EFFECTS;
		
		enPlayer.glow_trail = 1;
		enPlayer.glow_color = 500;
		
		enPlayer.exteriorweaponentity.glow_trail = 1;
		enPlayer.exteriorweaponentity.glow_color = 500;
		
		enPlayer.bDisableWeaponActions = TRUE;
		enPlayer.fpWeaponActionFunction = FunFunction_Form_HealthAngel_AttackFunction;
		enPlayer.bCannotTouchItems = TRUE;
		
		ExteriorWeaponLaserDraw(enPlayer, FALSE);
	}
}
void FunFunction_PlayerBloodShowerThink()
{ // Player Blood Shower Think - For Fun!			
	// Spawn Blood Shower
	PlayerBloodshowerDamage(self, 5000);
	
	// Play Sound
	// sound(self, CHAN_AUTO, "misc/gib.wav", 1, ATTN_NORM);
	
	// Assign Thinks
	self.nextthink = time + self.FunFunc_tPlayerBloodShowerNextThinkTime;
}
void FunFunction_TogglePlayerBloodShowerThink()
{ // Toggle Player Blood Shower Think
	if( GetClientIsAdministrator(self) )
	{ // Command Allowed
		if(self.FunFunc_bPlayerBloodShowerThinkEnabled)
		{ // Enabled; Disable
			// Display Message
			sprint(self, "Player BloodShower Think ^1DISABLED\n");
			
			// Remove Thinks
			self.nextthink = 0;
			self.think = SUB_Null;
			
			// Toggle Think Disabled
			self.FunFunc_bPlayerBloodShowerThinkEnabled = FALSE;
		}
		else
		{ // Enable
			// Display message
			sprint(self, "Player BloodShower Think ^1ENABLED\n");
				
			// Toggle Think Enabled
			self.FunFunc_bPlayerBloodShowerThinkEnabled = TRUE;
			
			// Assign Default Next Think Time
			if(self.FunFunc_tPlayerBloodShowerNextThinkTime == 0)
				self.FunFunc_tPlayerBloodShowerNextThinkTime = 0.3;
			
			// Assign Thinks
			self.nextthink = time + self.FunFunc_tPlayerBloodShowerNextThinkTime;
			self.think = FunFunction_PlayerBloodShowerThink;
		}
	}
}