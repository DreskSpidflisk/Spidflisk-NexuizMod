// DRESK - Weapons - Detailed Projectiles
// Provides Functions for Detailed Projectiles

// Fields

// Detailed Project Explode
void DetailedProjectile_Explode(void)
{	
	// Remove Self
	remove(self);
}
void DetailedProjectile_Nex(entity enOwner, float fSpeed, vector vOrigin, vector vEndOrigin, vector vDirection)
{
	local entity enBullet;
	
	// Spawn Bullet
	enBullet = spawn();
	enBullet.owner = enOwner;
	enBullet.classname = "spike";
	
	// Assign Physical Properties
	enBullet.movetype = MOVETYPE_FLY;
	enBullet.solid = SOLID_NOT;
	setsize (enBullet, '0 0 0', '0 0 0');
	
	// Assign Aesthetics
	setmodel(enBullet, "models/plasmatrail.mdl");
	enBullet.scale = 5.0;
	enBullet.effects = EF_NOSHADOW | EF_LOWPRECISION | EF_STARDUST | EF_FLAME;
	enBullet.alpha = 0.5;
	enBullet.colormod = '0.6 0.2 0.2';
	
	// Assign Flags
	enBullet.flags = FL_PROJECTILE;
	
	// Assign Velocity
	setorigin(enBullet, vOrigin + (vDirection * 150) );
	enBullet.velocity = (vDirection * fSpeed);
	
	enBullet.angles = vectoangles(enBullet.velocity);
	
	// Assign Think
	enBullet.think = DetailedProjectile_Explode;
	
	// Calculate Explosion Time
	local float fTime;
		fTime = vlen(enBullet.origin - vEndOrigin) / fSpeed;
		// fTime = fSpeed / ( vlen(vOrigin - vEndOrigin) );
	enBullet.nextthink = time + fTime;
}
void DetailedProjectile_Crylink(entity enOwner, float fTime, vector vOrigin, vector vDirection)
{
	local entity enBullet;
	
	// Spawn Bullet
	enBullet = spawn();
	enBullet.owner = enOwner;
	enBullet.classname = "spike";
	
	// Assign Physical Properties
	enBullet.movetype = MOVETYPE_FLY;
	enBullet.solid = SOLID_NOT;
	setsize (enBullet, '0 0 0', '0 0 0');
	
	// Assign Aesthetics
	setmodel(enBullet, "models/plasmatrail.mdl");
	enBullet.scale = 3.0;
	enBullet.effects = EF_NOSHADOW | EF_BLUE | EF_RED | EF_LOWPRECISION | EF_FLAME;
	enBullet.colormod = '0.4 0 0.4';
	
	// Assign Flags
	enBullet.flags = FL_PROJECTILE;
	
	// Assign Velocity
	setorigin(enBullet, vOrigin);
	enBullet.velocity = (vDirection * cvar("g_balance_crylink_primary_speed") );
	
	enBullet.angles = vectoangles(enBullet.velocity);
	
	// Assign Touch and Think
	enBullet.think = DetailedProjectile_Explode;
	enBullet.nextthink = time + fTime;
}