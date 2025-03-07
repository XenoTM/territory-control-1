﻿// A script by TFlippy

#include "Requirements.as";
#include "ShopCommon.as";
#include "Descriptions.as";
#include "CheckSpam.as";
#include "CTFShopCommon.as";
#include "MakeMat.as";

Random traderRandom(Time());

void onInit(CBlob@ this)
{
	this.set_TileType("background tile", CMap::tile_castle_back);

	//this.Tag("upkeep building");
	//this.set_u8("upkeep cap increase", 0);
	//this.set_u8("upkeep cost", 5);

	this.getSprite().SetZ(-50); //background
	this.getShape().getConsts().mapCollisions = false;

	this.Tag("remote_storage");
	this.Tag("builder always hit");
	this.Tag("change team on fort capture");

	this.getCurrentScript().tickFrequency = 300;

	// getMap().server_SetTile(this.getPosition(), CMap::tile_wood_back);

	this.inventoryButtonPos = Vec2f(-8, 0);
	this.addCommandID("sv_store");

	addTokens(this); //colored shop icons

	this.set_Vec2f("shop offset", Vec2f(0,0));
	this.set_Vec2f("shop menu size", Vec2f(6, 6));
	this.set_string("shop description", "Armory");
	this.set_u8("shop icon", 15);

	{
		ShopItem@ s = addShopItem(this, "Combat Helmet", "$icon_militaryhelmet$", "militaryhelmet", "A light combat helmet.\nCheap and practical. Good against all bullets.\n\nOccupies the Head slot");
		AddRequirement(s.requirements, "blob", "mat_steelingot", "Steel Ingot", 2);
		AddRequirement(s.requirements, "coin", "", "Coins", 50);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Helmet", "$icon_militaryhelmet$", "militaryhelmet", "Repair combat helmet.");
		AddRequirement(s.requirements, "blob", "militaryhelmet", "Combat Helmet", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 35);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Carbon Helmet", "$icon_carbonhelmet$", "carbonhelmet", "A heavy combat helmet.\nVery durable. Good against low caliber bullets and explosions,\nbut worse against high caliber and power rounds.\n\nOccupies the Head slot");
		AddRequirement(s.requirements, "blob", "mat_carbon", "Carbon", 60);
		AddRequirement(s.requirements, "coin", "", "Coins", 200);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Carbon Helmet", "$icon_carbonhelmet$", "carbonhelmet", "Repair carbon helmet.");
		AddRequirement(s.requirements, "blob", "carbonhelmet", "Carbon Helmet", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 175);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Wilmet Helmet", "$icon_wilmethelmet$", "wilmethelmet", "An universal combat helmet.\nModerately durable. Very good against plasma, electricity, radiation,\nbut moderately good against everything else.\n\nOccupies the Head slot");
		AddRequirement(s.requirements, "blob", "mat_wilmet", "Wilmet", 85);
		AddRequirement(s.requirements, "coin", "", "Coins", 400);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Wilmet Helmet", "$icon_wilmethelmet$", "wilmethelmet", "Repair wilmet helmet.");
		AddRequirement(s.requirements, "blob", "wilmethelmet", "Wilmet Helmet", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 300);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Ballistic Vest", "$icon_bulletproofvest$", "bulletproofvest", "A resilient ballistic armor.\nCheap and practical. Good against all bullets.\n\nOccupies the Torso slot");
		AddRequirement(s.requirements, "blob", "mat_steelingot", "Steel Ingot", 4);
		AddRequirement(s.requirements, "coin", "", "Coins", 100);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Vest", "$icon_bulletproofvest$", "bulletproofvest", "Repair ballistic vest.");
		AddRequirement(s.requirements, "blob", "bulletproofvest", "Ballistic Vest", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 75);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Carbon Vest", "$icon_carbonvest$", "carbonvest", "A heavy combat vest.\nVery durable. Good against low caliber bullets and explosions,\nbut worse against high caliber and power rounds.\n\nOccupies the Torso slot");
		AddRequirement(s.requirements, "blob", "mat_carbon", "Carbon", 70);
		AddRequirement(s.requirements, "coin", "", "Coins", 200);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Carbon Vest", "$icon_carbonvest$", "carbonvest", "Repair carbon vest.");
		AddRequirement(s.requirements, "blob", "carbonvest", "Carbon vest", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 100);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Wilmet Vest", "$icon_wilmetvest$", "wilmetvest", "An universal combat vest.\nModerately durable. Very good against plasma, electricity, radiation,\nbut moderately good against everything else.\n\nOccupies the Torso slot");
		AddRequirement(s.requirements, "blob", "mat_wilmet", "Wilmet", 85);
		AddRequirement(s.requirements, "coin", "", "Coins", 500);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Wilmet Vest", "$icon_wilmetvest$", "wilmetvest", "Repair wilmet vest.");
		AddRequirement(s.requirements, "blob", "wilmetvest", "Wilmet vest", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 300);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Combat Boots", "$icon_combatboots$", "combatboots", "A pair of light military boots.\nSlightly protects against all bullets and increases your mobility.\nModerately decreases fall damage.\nIncreases stomp damage.\n\nOccupies the Boots slot");
		AddRequirement(s.requirements, "coin", "", "Coins", 50);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Boots", "$icon_combatboots$", "combatboots", "Repair combat boots.");
		AddRequirement(s.requirements, "blob", "combatboots", "Combat Boots", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 35);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Carbon Boots", "$icon_carbonboots$", "carbonboots", "A pair of heavy and sturdy boots.\nSlightly protects you against all bullets and explosions.\nSlightly decreases running speed and fall damage.\n\nOccupies the Boots slot");
		AddRequirement(s.requirements, "blob", "mat_carbon", "Carbon", 20);
		AddRequirement(s.requirements, "coin", "", "Coins", 125);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Carbon Boots", "$icon_carbonboots$", "carbonboots", "Repair carbon boots.");
		AddRequirement(s.requirements, "blob", "carbonboots", "Carbon Boots", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 100);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Wilmet Boots", "$icon_wilmetboots$", "wilmetboots", "A pair of alien-tech boots.\nGreatly protects you from fall damage and increases jump height.\nIncreases running speed.\n\nOccupies the Boots slot");
		AddRequirement(s.requirements, "blob", "mat_wilmet", "Wilmet", 125);
		AddRequirement(s.requirements, "coin", "", "Coins", 300);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Wilmet Boots", "$icon_wilmetboots$", "wilmetboots", "Repair wilmet boots.");
		AddRequirement(s.requirements, "blob", "wilmetboots", "Combat Boots", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 300);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Bushy Helm", "$bush$", "bushyhelm", "Add bush camo to helm.");
		AddRequirement(s.requirements, "blob", "militaryhelmet", "Combat Helmet", 1);
	
		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Night Vision Device (NVD)", "$nvd$", "nvd", "Night vision googles fixed on a military helmet.\nRequires mithril.\n\nHold mithril and press [E]\nYou can also toggle it.");
		AddRequirement(s.requirements, "blob", "militaryhelmet", "Combat Helmet", 1);
		AddRequirement(s.requirements, "blob", "mat_mithril", "Mithril", 50);
		AddRequirement(s.requirements, "coin", "", "Coins", 250);
	
		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Night Vision Device", "$nvd$", "nvd", "Repair NVD.");
		AddRequirement(s.requirements, "blob", "nvd", "Night Vision Device", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 75);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Jump Shoes", "$jumpshoes$", "jumpshoes", "Makes you better, faster, stronger.");
		AddRequirement(s.requirements, "blob", "combatboots", "Combat Boots", 1);
		AddRequirement(s.requirements, "blob", "mat_ironingot", "Iron Ingot", 5);
			AddRequirement(s.requirements, "blob", "mat_copperwire", "Copper Wire", 10);
		AddRequirement(s.requirements, "coin", "", "Coins", 1000);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Repair Jump Shoes", "$jumpshoes$", "jumpshoes", "Repair jump shoes.");
		AddRequirement(s.requirements, "blob", "jumpshoes", "Jump Shoes", 1);
		AddRequirement(s.requirements, "coin", "", "Coins", 150);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Money Generating Boots", "$moneygenboots$", "moneygenboots", "Boots that produce money while walking.\nOccupies the boots slot.\nNeeds coal or wood to make money.");
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 150);
		AddRequirement(s.requirements, "blob", "mat_coal", "Coal", 25);
		AddRequirement(s.requirements, "blob", "kitten", "Kitten", 2);
		AddRequirement(s.requirements, "coin", "", "Coins", 500);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Parachute Pack", "$icon_parachute$", "parachutepack", "A piece of fabric to let you fall slowly.\nPress [E] while falling to activate.\n\nOccupies the Torso slot.");
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 80);
		AddRequirement(s.requirements, "coin", "", "Coins", 125);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Truncheon", "$icon_nightstick$", "nightstick", "A traditional tool used by seal clubbing clubs.");
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 100);
		AddRequirement(s.requirements, "coin", "", "Coins", 75);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Slavemaster's Kit", "$icon_shackles$", "shackles", "A kit containing shackles, shiny iron ball, elegant striped pants, noisy chains and a slice of cheese.");
		AddRequirement(s.requirements, "blob", "mat_ironingot", "Iron Ingot", 4);
		AddRequirement(s.requirements, "coin", "", "Coins", 250);

		s.spawnNothing = true;
	}
	//{
	//	ShopItem@ s = addShopItem(this, "Master's Slavemaster's Kit", "$goldenshackles$", "goldenshackles", "Just shackles, but the slave will work hard.");
	//	AddRequirement(s.requirements, "blob", "mat_goldingot", "Gold Ingot", 8);
	//	AddRequirement(s.requirements, "coin", "", "Coins", 750);
//
	//	s.spawnNothing = true;
	//}
	{
		ShopItem@ s = addShopItem(this, "Arrows (30)", "$mat_arrows$", "mat_arrows-30", "Arrows for crossbows.", true);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 50);
		AddRequirement(s.requirements, "coin", "", "Coins", 75);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Fire Arrow (2)", "$mat_firearrows$", "mat_firearrows-2", descriptions[32], true);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 10);
		AddRequirement(s.requirements, "coin", "", "Coins", 30);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Water Arrow (2)", "$mat_waterarrows$", "mat_waterarrows-2", descriptions[50], true);
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 15);
		AddRequirement(s.requirements, "coin", "", "Coins", 50);

		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Rendezook", "$icon_rendezook$", "rendezook", "A replica of a rocket launcher found behind the UPF shop in a trash can.\nDoes not seem to hurt anybody.");
		AddRequirement(s.requirements, "coin", "", "Coins", 350);

		s.customButton = true;
		s.buttonwidth = 2;
		s.buttonheight = 1;
		
		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Katana", "$katana$", "katana", "Japanese melee weapon.\nPerfect for introducing enemies' organs to themselves.");
		AddRequirement(s.requirements, "blob", "mat_steelingot", "Steel ingot", 16);
		AddRequirement(s.requirements, "coin", "", "Coins", 500);

		s.customButton = true;
		s.buttonwidth = 2;
		s.buttonheight = 1;
		
		s.spawnNothing = true;
	}
	{
		ShopItem@ s = addShopItem(this, "Crossbow", "$crossbow$", "crossbow", "A hand-made ranged weapon.\nUses arrows to shoot.\nYou can set arrow type while holding different arrows near it.");
		AddRequirement(s.requirements, "blob", "mat_wood", "Wood", 150);
		AddRequirement(s.requirements, "coin", "", "Coins", 250);

		s.customButton = true;
		s.buttonwidth = 2;
		s.buttonheight = 1;
		
		s.spawnNothing = true;
	}
}

void onChangeTeam(CBlob@ this, const int oldTeam)
{
	// reset shop colors
	addTokens(this);
}

void addTokens(CBlob@ this)
{
	int teamnum = this.getTeamNum();
	if (teamnum > 6) teamnum = 7;

	AddIconToken("$icon_parachute$", "Parachutepack.png", Vec2f(16, 16), 0, teamnum);
	AddIconToken("$jumpshoes$", "JumpShoes.png", Vec2f(16, 16), 0, teamnum);
	AddIconToken("$icon_royalarmor$", "RoyalArmor.png", Vec2f(16, 8), 0, teamnum);
	AddIconToken("$icon_suitofarmor$", "SuitOfArmor.png", Vec2f(16, 16), 0, teamnum);
}

bool canPickup(CBlob@ blob)
{
	return blob.hasTag("weapon") || blob.hasTag("ammo") || blob.hasTag("armor");
}

void onTick(CBlob@ this)
{
	if (this.getInventory().isFull()) return;

	CBlob@[] blobs;
	if (getMap().getBlobsInBox(this.getPosition() + Vec2f(128, 96), this.getPosition() + Vec2f(-128, -96), @blobs))
	{
		for (uint i = 0; i < blobs.length; i++)
		{
			CBlob@ blob = blobs[i];

			if ((canPickup(blob)) && !blob.isAttached())
			{
				if (isClient() && this.getInventory().canPutItem(blob)) blob.getSprite().PlaySound("/PutInInventory.ogg");
				if (isServer()) this.server_PutInInventory(blob);
			}
		}
	}
}

bool isInventoryAccessible(CBlob@ this, CBlob@ forBlob)
{
	if (forBlob is null || this is null) return false;
	CBlob@ carried = forBlob.getCarriedBlob();
	return forBlob.isOverlapping(this) && (carried is null ? true : canPickup(carried));
}

void GetButtonsFor(CBlob@ this, CBlob@ caller)
{
	if (this.getDistanceTo(caller) > 96.0f) return;
	if (isInventoryAccessible(this, caller))
	{
		this.set_Vec2f("shop offset", Vec2f(8, 0));
		this.set_bool("shop available", this.isOverlapping(caller));

		CBitStream params;
		params.write_u16(caller.getNetworkID());

		CInventory @inv = caller.getInventory();
		if (inv is null) return;
		
		CBlob@ carried = caller.getCarriedBlob();
		if(carried is null && this.isOverlapping(caller))
		{
			if (inv.getItemsCount() > 0)
			{
				for (int i = 0; i < inv.getItemsCount(); i++)
				{
					CBlob @item = inv.getItem(i);
					if (canPickup(item))
					{
						params.write_u16(caller.getNetworkID());
						CButton@ buttonOwner = caller.CreateGenericButton(28, Vec2f(0, -10), this, this.getCommandID("sv_store"), "Store", params);
						break;
					}
				}
			}
		}
	}
	else
	{
		this.set_Vec2f("shop offset", Vec2f(0, 0));
		this.set_bool("shop available", this.isOverlapping(caller));
	}
}

void onCommand(CBlob@ this, u8 cmd, CBitStream @params)
{
	if (cmd == this.getCommandID("shop made item"))
	{
		this.getSprite().PlaySound("ConstructShort");

		u16 caller, item;

		if (!params.saferead_netid(caller) || !params.saferead_netid(item))
			return;

		string name = params.read_string();
		CBlob@ callerBlob = getBlobByNetworkID(caller);

		if (callerBlob is null) return;

		if (isServer())
		{
			string[] spl = name.split("-");

			if (spl[0] == "coin")
			{
				CPlayer@ callerPlayer = callerBlob.getPlayer();
				if (callerPlayer is null) return;

				callerPlayer.server_setCoins(callerPlayer.getCoins() +  parseInt(spl[1]));
			}
			else if (name.findFirst("mat_") != -1 && spl.length > 1)
			{
				CPlayer@ callerPlayer = callerBlob.getPlayer();
				if (callerPlayer is null) return;

				MakeMat(callerBlob, this.getPosition(), spl[0], parseInt(spl[1]));

				// CBlob@ mat = server_CreateBlob(spl[0]);

				// if (mat !is null)
				// {
					// mat.Tag("do not set materials");
					// mat.server_SetQuantity(parseInt(spl[1]));
					// if (!callerBlob.server_PutInInventory(mat))
					// {
						// mat.setPosition(callerBlob.getPosition());
					// }
				// }
			}
			else
			{
				string blobName = spl[0];
				bool mask = false;
				if (blobName == "bushyhelm")
				{
					blobName = "militaryhelmet";
					mask = true;
				}

				CBlob@ blob = server_CreateBlob(blobName, callerBlob.getTeamNum(), this.getPosition());
				if (mask) blob.Tag("bushy");

				if (blob is null && callerBlob is null) return;

				if (!blob.canBePutInInventory(callerBlob))
				{
					callerBlob.server_Pickup(blob);
				}
				else if (callerBlob.getInventory() !is null && !callerBlob.getInventory().isFull())
				{
					callerBlob.server_PutInInventory(blob);
				}
			}
		}
	}
	if (cmd == this.getCommandID("sv_store"))
	{
		if (isServer())
		{
			CBlob@ caller = getBlobByNetworkID(params.read_u16());
			if (caller !is null)
			{
				CInventory @inv = caller.getInventory();
				if (caller.getName() == "builder")
				{
					CBlob@ carried = caller.getCarriedBlob();
					if (carried !is null)
					{
						if (carried.hasTag("temp blob"))
						{
							carried.server_Die();
						}
					}
				}
				if (inv !is null)
				{
					for (int i = 0; i < inv.getItemsCount(); i++)
					{
						CBlob @item = inv.getItem(i);
						if (canPickup(item))
						{
							caller.server_PutOutInventory(item);
							this.server_PutInInventory(item);
							i--;
						}
					}
				}
			}
		}
	}
}
