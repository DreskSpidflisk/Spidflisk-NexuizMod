// DRESK - Weapon - Laser Functions

// Support New Laser Alternate Fire
void W_Laser_Touch_NewAlternate (void)
{
	vector	dir;
	vector org2;

	if (trace_dphitq3surfaceflags & Q3SURFACEFLAG_NOIMPACT)
	{
		remove(self);
		return;
	}

	if (other == self.owner)
		return;

	dir = normalize (self.owner.origin - self.origin);
	org2 = findbetterlocation (self.origin, 8);

	// te_knightspike(org2);
	te_wizspike(org2);
	te_customflash(org2, 320, 0.4, '0 1 0');


	self.event_damage = SUB_Null;
	RadiusDamage (self, self.owner, cvar("g_balance_laser_primary_damage"), cvar("g_balance_laser_primary_edgedamage"), cvar("g_balance_laser_primary_radius") * cvar(CVAR_WEAPON_LASER_ALTFIRERADIUSMULTIPLIER), world, cvar("g_balance_laser_primary_force") * cvar(CVAR_WEAPON_LASER_ALTFIRERADIUSMULTIPLIER), IT_LASER);
	sound (self, CHAN_BODY, "weapons/laserimpact.wav", 1, ATTN_NORM);

	remove (self);
}
// Support New Laser Alternate Attack
void W_Laser_Attack_NewAlternate()
{ // New Laser Alternate Fire Attack
	local entity missile;

	W_SetupShot (self, '15 8 -8', FALSE, 3, "weapons/lasergun_fire.wav");
	//te_customflash(w_shotorg, 160, 0.2, '1 0 0');

	missile = spawn ();
	missile.owner = self;
	missile.classname = "laserbolt_alternate";
	missile.bot_dodge = TRUE;
	missile.bot_dodgerating = cvar("g_balance_laser_primary_damage");

	missile.movetype = MOVETYPE_FLY;
	missile.solid = SOLID_BBOX;

	setmodel (missile, "models/laser.mdl");
	setsize (missile, '0 0 0', '0 0 0');
	setorigin (missile, w_shotorg);

	missile.velocity = w_shotdir * ( cvar("g_balance_laser_primary_speed") / cvar(CVAR_WEAPON_LASER_ALTFIRESPEEDDIVISOR) );
	missile.angles = vectoangles (missile.velocity);
	//missile.glow_color = 250; // 244, 250
	//missile.glow_size = 120;
	missile.touch = W_Laser_Touch_NewAlternate;
	missile.think = SUB_Remove;
	missile.nextthink = time + cvar("g_balance_laser_primary_lifetime");

	missile.effects = EF_NOSHADOW | EF_FULLBRIGHT | EF_LOWPRECISION;
	missile.flags = FL_PROJECTILE;
	
	// Help Text
	HelpText_CustomFeature_LaserAltFire(self);
	// Modify Missile Color
	missile.colormod = '0.0 1.0 0.0';
	// Modify Missile Glow
	missile.glow_color = 177;
	// missile.glow_size = 25;
	missile.glow_trail = 1;
}
float CheckLaserAlternateFire()
{ // Check Laser Alternate Fire
	// NOTE: Assumed scope is player
	local float bUsed;
		bUsed = TRUE;
	
	// Alternate Laser Fire Addition
	if( cvar(CVAR_WEAPON_LASER_ALLOWALTFIRE) )
	{ // New Alternate Fire
		if (weapon_prepareattack(0, cvar("g_balance_laser_primary_refire")))
		{
			W_Laser_Attack_NewAlternate();
			weapon_thinkf(WFRAME_FIRE1, cvar("g_balance_laser_primary_animtime"), w_ready);
		}
	}
	else
		bUsed = FALSE;
		
	// Return Status
	return bUsed;
}