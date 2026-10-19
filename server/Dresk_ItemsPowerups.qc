// DRESK - Items and Powerups
// Provides Functions for Items and Powerups

// Prototypes

// Fields
.float bIsFadedItem;
.float item_bOriginalEffect_Additive;

.float pre_strength_finished;
.float pre_invincible_finished;

// Support Cannot Touch Items
.float bCannotTouchItems;

// Support Items in Map
float nItemsInMap;

// Functions
float GetIsGlobalSoundItem(entity enItem)
{ // Return Is Global Sound Item
	local float fReturn;
	
	if( cvar(CVAR_ITEM_POWERUPGLOBALPICKUPSOUNDS) )
	{ // Global Pickup Sounds Enabled
		if( (enItem.flags & FL_POWERUP)
			|| (enItem.netname == "100 Health")
		)
			fReturn = TRUE;
		else
			fReturn = FALSE;
	}
	else
		fReturn = FALSE;
		
	// Return Results
	return fReturn;
}
void DisplayAdvancedPowerupAcquisitionMessage(entity enClient, float nItem)
{ // Display Advanced Powerup Acquisition Message
		local string strPowerupTime;
		local string strPowerupValue;
		local string strPowerupMessage;
		
		local string strItemName;
		local string strItemBonus;
		local float fTime;
		local string strValue;
		
		// Determine Time and Values
		if(nItem == IT_STRENGTH)
		{ // Strength Powerup
			fTime = enClient.strength_finished;
			strValue = cvar_string("g_balance_powerup_strength_damage");
			
			strItemName = "Strength";
			strItemBonus = "Damage";
		}
		else
		if(nItem == IT_INVINCIBLE)
		{ // Shield Powerup
			fTime = enClient.invincible_finished;
			strValue = cvar_string("g_balance_powerup_invincible_takedamage");
			
			strItemName = "Shield";
			strItemBonus = "Protection";
		}
		
		// Zone Value String
		strValue = strzone(strValue);
		
		// Calculate Appends
		strPowerupTime = ftos(rint( (fTime - time) ) );
			strPowerupTime = strzone(strPowerupTime);
		strPowerupValue = strValue;
			strPowerupValue = strzone(strPowerupValue);
		
		// Generate Message
		strPowerupMessage = strcat("^3", strItemName, " Provides ^1", strPowerupValue);
		strPowerupMessage = strcat(strPowerupMessage , "x^3 ", strItemBonus, " for ^1", strPowerupTime, "^3 seconds\n");
		sprint(enClient, strPowerupMessage);
		
		// Unzone Strings
		strunzone(strPowerupTime);
		strunzone(strPowerupValue);
		strunzone(strValue);
}
void CheckRespawningItemSound(entity enItem)
{ // Check Respawning Item Sound
	local float bPlayStandard;
		bPlayStandard = TRUE;
	if( cvar(CVAR_ITEM_POWERUPGLOBALRESPAWNSOUNDS) )
	{ // Powerup Global Respawn Sounds Enabled
		if(enItem.flags & FL_POWERUP || enItem.netname == "100 Health")
		{ // Powerup
			bPlayStandard = FALSE;
			// Play Combo Sounds!  More of the same means louder!
			sound(enItem, CHAN_AUTO, "misc/medplat2.wav", 1, ATTN_NONE);
			sound(enItem, CHAN_AUTO, "misc/medplat2.wav", 1, ATTN_NONE);
			sound(enItem, CHAN_AUTO, "misc/medplat2.wav", 1, ATTN_NONE);
			
			// Additional Subtle Sound
			sound(enItem, CHAN_AUTO, "misc/outwater.wav", 1, ATTN_NONE);
		}
	}
	// Play Standard
	if(bPlayStandard)
		sound(enItem, CHAN_AUTO, "misc/itemrespawn.wav", 1, ATTN_NORM);
}
void CheckVerticalTiltWeapon(entity enItem)
{ // Vertical Check item
	local float fVerticalTiltWeapons;
		fVerticalTiltWeapons = cvar(CVAR_ITEM_VERTICALTILTWEAPONS);
	if(fVerticalTiltWeapons)
	{ // Valid Vertical Tilt
		enItem.angles_z = 0 - fVerticalTiltWeapons;
		// Modify Origin
		local vector vOrigin;
			vOrigin = enItem.origin;
			vOrigin_z = vOrigin_z + 15;
		setorigin(enItem, vOrigin);
	}
}
void PostCheckItemStart(entity enItem, float nItemID)
{ // Post Check Item Start
	// Check if Dropped Weapon
	local float bDroppedWeapon;
	if(enItem.classname == "droppedweapon")
		bDroppedWeapon = TRUE;
	else
		bDroppedWeapon = FALSE;
		
	// Original Item Effect Support
	if(enItem.effects & EF_ADDITIVE)
		enItem.item_bOriginalEffect_Additive = TRUE;
	else
		enItem.item_bOriginalEffect_Additive = FALSE;
		
	// Low Bandwidth Support (Low Precision)
	if( cvar(CVAR_MISC_LOWBANDWIDTHLEVEL) )
	{ // Low Bandwidth
		if( !(enItem.effects & EF_LOWPRECISION))
			//Low Precision Required
			enItem.effects = enItem.effects | EF_LOWPRECISION;
	}
	
	// Check for Modified 100 Health
	// NOTE: Feature Suppressed Due to Nexuiz 2.3 Support
	/*
	if(enItem.netname == "100 Health" && enItem.health == 100)
		// Base 100 Health; Modify
		enItem.health = cvar(CVAR_ITEM_MEGAHEALTH_HEALTH);
	*/
	
	if(enItem.flags & FL_WEAPON)
	{ // Item is Weapon
		// Support Items in Map
		if(!bDroppedWeapon)
			nItemsInMap = nItemsInMap | nItemID;
		
		// Vertical Tilt Weapons Support
		CheckVerticalTiltWeapon(enItem);
	}
	
	if(enItem.flags & FL_POWERUP)
		// Support Items in Map
		nItemsInMap = nItemsInMap | nItemID;
		
	// Support CVar-Based Powerup Times
	if(enItem.items & IT_STRENGTH && enItem.classname != "droppedweapon")
		enItem.strength_finished = cvar("g_balance_powerup_strength_time");
	else
	if(enItem.items & IT_INVINCIBLE && enItem.classname != "droppedweapon")
		enItem.invincible_finished = cvar("g_balance_powerup_invincible_time");
	
	// Additional Ambient Sound Support
	if(!bDroppedWeapon && cvar(CVAR_MISC_SPAWNADDITIONALAMBIENTSOUNDS) )
		SpawnAdditionalAmbientSound(enItem);
}
float CheckWillFadeUnavailableItem(entity enItem)
{ // Check Will Fade Unavailable Item
	local float bReturn;
		bReturn = TRUE;
		enItem.bIsFadedItem = FALSE;
	// Modified Items to Render Deferred Status
	if( cvar(CVAR_ITEM_FADEUNAVAILABLEITEMS) )
	{ // Fade Items Support
		enItem.colormod = '0.3 1.0 0.3';
		enItem.effects = (enItem.effects | EF_ADDITIVE);
		if(enItem.flags & FL_POWERUP)
			// Fade Powerups Exceedingly
			enItem.alpha = 0.03;
		else
			enItem.alpha = 0.12;
			
		// Assign Faded Item
		enItem.bIsFadedItem = TRUE;
	}
	else
		bReturn = FALSE;
		
	return bReturn;
}
void CheckRespawningFadedItem(entity enItem)
{ // Check Respawning Faded Item
	// Modified Items to Render Deferred Status
	if(enItem.bIsFadedItem)
	{ // Faded Item
		enItem.colormod = '1.0 1.0 1.0';
		enItem.alpha = 1.0;
		// Remove Additive Rendering
		if(!enItem.item_bOriginalEffect_Additive)
			enItem.effects = enItem.effects - (enItem.effects & EF_ADDITIVE);
		// Remove Faded Item Flag
		enItem.bIsFadedItem = FALSE;
	}
	else
	if(enItem.model == string_null)
		// Item Model Disabled; Enable
		enItem.model = enItem.mdl;
}
void CheckItemRespawnEffects(entity enItem)
{ // Check Item Respawn Effects
	// Check Sound
	CheckRespawningItemSound(enItem);
	// Check Respawning Faded Item
	CheckRespawningFadedItem(enItem);
	
	// Check for Respawn Effect Uses Sparks
	if( cvar(CVAR_ITEM_RESPAWNEFFECTUSESSPARKS) )
		te_spark(enItem.origin + '0 0 15', '0 0 127', 300);
	else
		// LordHavoc: replaced respawn stardust effect with a custom te_wizspike
		te_wizspike(enItem.origin + enItem.mins_z * '0 0 1' + '0 0 48');
}
// Dynamic Armor Value Support
void item_armorVar (float fArmorValue) {
	self.armorvalue = fArmorValue;
	self.max_armorvalue = g_pickup_armor_max;
	StartItem ("models/items/g_a25.md3", "misc/armor25.wav", 30, "Armor", IT_ARMOR, 0, commodity_pickupevalfunc, 0);
}
// Spawn Thrown Armor Support
void SpawnThrownArmor(vector vOrigin)
{
	local entity enPlayer;
	
	// Backup Player Entity
	enPlayer = self;
	
	if(enPlayer.armorvalue > 0)
	{ // Valid Armor Value
		// Spawn Armor
		self = spawn();
		
		// this will cause it to be removed later
		self.classname = "droppedweapon";

		setorigin(self, vOrigin);
		self.velocity = randomvec() * 200 + '0 0 400';
		SUB_SetFade(self, time + 20, 1);
		
		// Calculate Armor Value
		local float fArmorValue;
			fArmorValue = enPlayer.armorvalue;
		// Add Additional Armor
		local float fArmorAdd;
			fArmorAdd = cvar(CVAR_PLAYERDEATH_DROPARMOR_ARMORADDITIONAMOUNT);
			
		if(fArmorAdd > 0)
			// Additional Armor to Add
			fArmorValue = fArmorValue + fArmorAdd;
		
		// Create Armor
		item_armorVar(fArmorValue);
	}
	
	// Restore Player Entity
	self = enPlayer;
}
// Configurable Powerup Finished Item Support
void item_strength_finished (float fFinishedTime)
{
	if(!cvar("g_powerup_strength"))
		return;
	
	if(cvar("g_minstagib")) {
		minstagib_items(IT_STRENGTH);
	} else {
		self.strength_finished = fFinishedTime;
		self.effects = EF_ADDITIVE;
		StartItem ("models/items/g_strength.md3", "misc/powerup.wav", 120, "Strength Powerup", IT_STRENGTH, FL_POWERUP, generic_pickupevalfunc, 0);
	}
}
void item_invincible_finished (float fFinishedTime)
{
	if(!cvar("g_powerup_shield"))
		return;
		
	if(cvar("g_minstagib")) {
		minstagib_items(IT_INVINCIBLE);
	} else {
		self.invincible_finished = fFinishedTime;
		self.effects = EF_ADDITIVE;
		StartItem ("models/items/g_invincible.md3", "misc/powerup_shield.wav", 120, "Invulnerability", IT_INVINCIBLE, FL_POWERUP, generic_pickupevalfunc, 0);
	}
}
// Spawn Thrown Powerup Support
void SpawnThrownPowerups(vector vOrigin)
{
	local entity enPlayer;
	local float fTime;
	
	if (!cvar("g_pickup_items"))
	if (!cvar("g_minstagib"))
		return;
		
	// Backup Player Entity
	enPlayer = self;
	
	if(enPlayer.items & IT_STRENGTH)
	{ // Strength Powerup Applicable
		self = spawn();
		// this will cause it to be removed later
		self.classname = "droppedweapon";

		setorigin(self, vOrigin);
		self.velocity = randomvec() * 200 + '0 0 400';
		SUB_SetFade(self, time + 20, 1);
		
		// Calculate Time
		fTime = (enPlayer.strength_finished - time) + cvar(CVAR_PLAYERDEATH_DROPPOWERUPS_POWERUPTIMEADDITION);
		
		item_strength_finished(fTime);
		
		// bprint("New Dropped Strength Time : ", ftos(fTime), "\n");

		// making absolutely sure...
		self.classname = "droppedweapon";
	}
	
	// if(enPlayer.invincible_finished > 0)
	if(enPlayer.items & IT_INVINCIBLE)
	{ // Invincible Powerup Applicable
		self = spawn();
		// this will cause it to be removed later
		self.classname = "droppedweapon";

		setorigin(self, vOrigin);
		self.velocity = randomvec() * 200 + '0 0 400';
		SUB_SetFade(self, time + 20, 1);
		
		// Calculate Time
		fTime = (enPlayer.invincible_finished - time) + cvar(CVAR_PLAYERDEATH_DROPPOWERUPS_POWERUPTIMEADDITION);
		
		item_invincible_finished(fTime);
		
		// bprint("New Dropped Invicibility Time : ", ftos(fTime), "\n");

		// making absolutely sure...
		self.classname = "droppedweapon";
	}
	
	// Restore Player Entity
	self = enPlayer;
}
float SpidfliskPreCheckItemTouchEventsAndCheckAllowItemTouch(entity enItem, entity enToucher)
{ // Pre Check Item Touch Events And Allow Item Touch
	local float bReturn;
		bReturn = TRUE;
	// Check for Cannot Touch Items
	if(enToucher.bCannotTouchItems)
		bReturn = FALSE;
	else
	{ // More Work to Perform
		// Backup Strength and Invisible Finished Timers
		enToucher.pre_strength_finished = enToucher.strength_finished;
		enToucher.pre_invincible_finished = enToucher.invincible_finished;
	}
	
	// Return Allow Item Touch
	return bReturn;
}
float SpidfliskPostCheckItemTouchEventsAndIsGlobalSoundItem(entity enItem, entity enToucher)
{ // Post Check Item Touch Events And Is Global Sound Item
	local float bReturn;
		bReturn = TRUE;
		
	// Perform Updated Powerup Logic
	// NOTE: Use pre_strength and pre_invincible times, as the base times have already been modified with the false logic
	if (enItem.strength_finished)
		enToucher.strength_finished = max(enToucher.pre_strength_finished, time) + enItem.strength_finished;
	if (enItem.invincible_finished)
		enToucher.invincible_finished = max(enToucher.pre_invincible_finished, time) + enItem.invincible_finished;
		
	// Update Client Stats Score - Item Touch
	CheckAndUpdateClientStatsScores_ItemTouch(enToucher, enItem);
	
	// Check Global Sound Item
	if( GetIsGlobalSoundItem(enItem) )
		sound(world, CHAN_AUTO, enItem.item_pickupsound, 1, ATTN_NONE);
	else
		bReturn = FALSE;
		
	// Return Is Global Sound Item
	return bReturn;
}
void SpidfliskItemRespawn()
{ // Spidflisk Item Respawn
	// NOTE: Assumed scope is item.
	// Allow Item to be Touched
	self.solid = SOLID_TRIGGER;
	
	// Check Item Respawn Effects
	CheckItemRespawnEffects(self);
	
	// Assign Origin
	setorigin (self, self.origin);
}