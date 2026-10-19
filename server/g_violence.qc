void GibDamage (entity inflictor, entity attacker, float damage, float deathtype, vector hitloc, vector force)
{
	float r;
	r = random ();
	if (r < 0.60)
		sound (self, CHAN_IMPACT, "misc/gib_splat01.wav", 1, ATTN_NORM);
	else if (r < 0.65)
		sound (self, CHAN_IMPACT, "misc/gib_splat02.wav", 1, ATTN_NORM);
	else if (r < 0.70)
		sound (self, CHAN_IMPACT, "misc/gib_splat03.wav", 1, ATTN_NORM);
	else if (r < 0.75)
		sound (self, CHAN_IMPACT, "misc/gib_splat04.wav", 1, ATTN_NORM);
		
	// DRESK - 5/19/06
	// Disable Blood Splash for Performance Reasons
	// te_blood (self.origin + '0 0 1', '0 0 30', 10);
	
	// DRESK - 5/18/06
	// Disable Gib Death
	/*
	self.health = self.health - damage;
	if (self.health <= -1000)
	{
		self.event_damage = SUB_Null;
		SUB_VanishOrRemove (self);
	}
	*/
}


void GibTouch ()
{
	if (trace_dphitq3surfaceflags & Q3SURFACEFLAG_NOIMPACT)
	{
		SUB_VanishOrRemove(self);
		return;
	}
	GibDamage (other, other, 1000, 0, self.origin, '0 0 0');
}


.float gibrandom;
.float gibmodelindex;
float() Gib_customizeentityforclient =
{
	if(self.classname == "player") // the eye
	{
		if(self.gibrandom > other.cvar_cl_nogibs)
			self.model = self.mdl;
		else
			self.model = "";
		return TRUE;
	}
	else // other gibs - don't even need to send them
		return (self.gibrandom > other.cvar_cl_nogibs);
};

// changes by LordHavoc on 03/30/04
// TossGib now takes a gib entity so it can be used for tossing heads
// gib.velocity now uses randomvec() instead of a bunch of manual random calls
// merged Gib() into PlayerGib()
void TossGib (entity gib, string mdlname, vector org, vector v, float destroyontouch)
{
	if (gib == world)
	{
		// DRESK - 5/18/06
		// Support Low-Bandwidth Complete Suppression
		if( cvar(CVAR_MISC_LOWBANDWIDTHLEVEL) > 3)
			return;
			
		gib = spawn ();
		gib.deadflag = DEAD_DEAD;
	}

	// don't set his classname to something else or it'll screw up a lot of stuff
	if(gib.classname != "player")
		gib.classname = "gib";
	gib.iscreature = FALSE; // not a creature, because lava sounds on gibs are annoying
	gib.movetype = MOVETYPE_BOUNCE;
	// DRESK - 3/25/2007
	// Assign SOLID_NOT
	gib.solid = SOLID_NOT;
	// gib.solid = SOLID_CORPSE;
	gib.skin = 0;
	gib.effects = 0;
	gib.gibrandom = random(); // used for customize function to reduce gibs
	gib.customizeentityforclient = Gib_customizeentityforclient;
	// DRESK - 5/19/06
	// Applying NoShadow for Performance
	gib.effects = EF_LOWPRECISION | EF_NOSHADOW;
	// gib.effects = EF_LOWPRECISION; // use less bandwidth

	gib.mdl = mdlname;
	setmodel (gib, mdlname); // precision set above
	gib.gibmodelindex = gib.modelindex;
	setsize (gib, '-8 -8 -8', '8 8 8');
	setorigin (gib, org);

	gib.health = -1;
	gib.takedamage = DAMAGE_YES;
	gib.damageforcescale = 3.5;
	gib.event_damage = GibDamage;
	if (destroyontouch == 1)
		gib.touch = GibTouch;

	gib.velocity = v + randomvec() * 450;
	gib.avelocity = randomvec() * 300;
	gib.oldvelocity = gib.velocity;

	// DRESK - 3/9/06
	// Support Configurable Gib FadeTime
	SUB_SetFade (gib, time + cvar(CVAR_GIB_FADETIME), 1);
	// SUB_SetFade (gib, time + 12 + random () * 4, 1);
}
