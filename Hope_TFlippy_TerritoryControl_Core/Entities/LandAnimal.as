
//script for an land animal - attach to:
// blob
// movement
// 		vars:		f32 swimspeed f32 swimforce


#define SERVER_ONLY

#include "Hitters.as";
#include "AnimalConsts.as";


//blob
void onInit(CBlob@ this)
{
	AnimalVars vars;
	//walking vars
	vars.walkForce.Set(250.0f, -100.0f);
	vars.runForce.Set(150.0f, -50.0f);
	vars.slowForce.Set(50.0f, 0.0f);
	vars.jumpForce.Set(0.0f, -800.0f);
	vars.maxVelocity = 2.0f;
	this.set("vars", vars);

	// force no team
	this.server_setTeamNum(-1);

	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag	= "dead";
}


//movement

void onInit(CMovement@ this)
{
	this.getCurrentScript().runFlags |= Script::tick_not_attached;
	this.getCurrentScript().removeIfTag	= "dead";
}

void onTick(CMovement@ this)
{
	CBlob@ blob = this.getBlob();

	AnimalVars@ vars;
	if (!blob.get("vars", @vars))
		return;

	bool left = blob.isKeyPressed(key_left);
	bool right = blob.isKeyPressed(key_right);
	bool up = blob.isKeyPressed(key_up);
	bool ride = false;

	if (blob.hasTag("tameable"))
	{
		AttachmentPoint@ ap = blob.getAttachments().getAttachmentPointByName("SADDLE");
    	if (ap !is null && ap.getOccupied() !is null)
    	{
    	    CBlob@ saddle = ap.getOccupied();
    	    //saddle.SetFacingLeft(blob.isFacingLeft());
    	    AttachmentPoint@ pilot = saddle.getAttachments().getAttachmentPointByName("PILOT");
    	    if (pilot !is null && pilot.getOccupied() !is null)
    	    {
    	        CBlob@ pilotblob = pilot.getOccupied();

				left = pilotblob.isKeyPressed(key_left);
				right = pilotblob.isKeyPressed(key_right);
				up = pilotblob.isKeyPressed(key_down);
				
    	        //blob.setKeyPressed(key_left, pilotblob.isKeyPressed(key_left));
    	        //blob.setKeyPressed(key_right, pilotblob.isKeyPressed(key_right));
    	        //blob.setKeyPressed(key_up, pilotblob.isKeyPressed(key_down));
				//if (left) saddle.SetFacingLeft(true); // TODO: fix constant rotating loop
				//else if (right) saddle.SetFacingLeft(false);

				if (blob.getName() != "bison") ride = true;
    	    }
    	}
	}

	//AttachmentPoint@ ap = blob.getAttachments().getAttachmentPointByName("SADDLE");
	//if (ap !is null && ap.getOccupied() !is null && ap.getOccupied().getName() == "saddle")
	//{
	//	left = false;
	//	right = false;
	//	up = false;
	//}

	Vec2f vel = blob.getVelocity();
	if (left)
	{
		blob.AddForce(Vec2f(-1.25f * vars.walkForce.x, vars.walkForce.y));
	}
	if (right)
	{
		blob.AddForce(Vec2f(1.25f * vars.walkForce.x, vars.walkForce.y));
	}

	// jump at target

	CBrain@ brain = blob.getBrain();
	if (brain !is null)
	{
		CBlob@ target = brain.getTarget();
		if (target !is null)
		{
			if ((target.getPosition() - blob.getPosition()).getLength() < blob.getRadius() * 2.0f && target.getPosition().y < blob.getPosition().y - blob.getRadius())
			{
				up = true;
			}
		}
	}

	// jump if blocked
	f32 mody = 0.75f;
	if (blob.getName() == "piglet") mody = 3.5f;
	if (left || right || up)
	{
		Vec2f pos = blob.getPosition();
		CMap@ map = blob.getMap();
		const f32 radius = blob.getRadius();
		if ((blob.isOnGround() || blob.isInWater()) && (up || (right && map.isTileSolid(Vec2f(pos.x + radius, pos.y + 0.45f * radius))) || (left && map.isTileSolid(Vec2f(pos.x - radius, pos.y + 0.45f * radius)))
		                                               )
		   )
		{
			f32 mod = blob.isInWater() ? 0.23f : 0.75f;
			blob.AddForce(Vec2f(mod * vars.jumpForce.x, mod * vars.jumpForce.y * (ride ? 1.5f : 1.0f) * mody));
		}
	}


	CShape@ shape = blob.getShape();

	// too fast - slow down
	if (shape.vellen > vars.maxVelocity)
	{
		Vec2f vel = blob.getVelocity();
		blob.AddForce(Vec2f(-vel.x * vars.slowForce.x, -vel.y * vars.slowForce.y));
	}
}
