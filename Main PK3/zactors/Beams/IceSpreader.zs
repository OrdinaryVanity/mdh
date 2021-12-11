Class IceComboMissile : Actor
{
	Default
	{
		Radius 12;
		Height 8;
		Speed 40;
		Damage (150);
		Projectile;
		+FORCERADIUSDMG;
		+NODAMAGETHRUST;
		+FORCEXYBILLBOARD;
		+HITTRACER
		Scale 1.25;
		DeathSound "combo/icefreeze";
		Obituary "%k crushed %o with the Ice Spreader.";
		DamageType "IceCombo";
		Decal "Scorch";
	}
	States
    {
    Spawn:
        CICM A 1 Bright A_SpawnItemEx("IceTrail",0,0,0,random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,0,160,0);
        Loop;
    Death:
        TNT1 A 0;
        TNT1 A 0 A_Scream;
        //TNT1 A 0 A_PlaySoundEx("missile/hit",5);
		TNT1 A 0
		{
				if (tracer && (tracer.bISMONSTER || tracer.player) && !tracer.bBOSS) 
				{
					if(tracer.FindInventory("FreezeTokenChargeCombo"))
					{
						tracer.TakeInventory("FreezeTokenChargeCombo",1);
						tracer.GiveInventory("FreezeTokenChargeCombo",1);
					}
					tracer.GiveInventory("FreezeTokenChargeCombo",1);
					let frz = FreezeTokenChargeCombo(tracer.FindInventory("FreezeTokenChargeCombo"));
					if (frz)
					{
						frz.fcounter+=256;
					}
				}
				if (tracer && (tracer.bISMONSTER || tracer.player) && tracer.bBOSS)
				{
					if(tracer.FindInventory("FreezeTokenChargeCombo"))
					{
						tracer.TakeInventory("FreezeTokenChargeCombo",1);
						tracer.GiveInventory("FreezeTokenChargeCombo",1);
					}
					tracer.GiveInventory("FreezeTokenChargeCombo",1);
					let frz = FreezeTokenChargeCombo(tracer.FindInventory("FreezeTokenChargeCombo"));
					if (frz)
					{
						frz.fcounter+=256;
					}
				}
			}
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrail",0,0,Random(-200,200),3,Random(-200,200));
        TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrailFlicker",0,0,Random(-200,200),3,Random(-200,200));
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("MissileTrail",random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,128);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceComboPuff",0,0,0,0,0,0,0,160);
        TNT1 A 0 A_SpawnItemEx("IceComboPuff2",0,0,0,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff3",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff4",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff3",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff4",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff3",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff4",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff3",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff4",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff3",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff4",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff3",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AA 0 A_SpawnItemEx("IceComboPuff4",random(-10000,10000)/100.00,random(-10000,10000)/100.00,random(-10000,10000)/100.00,0,0,0,0,160);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 4 A_Explode(random(1,20),256,0);
        TNT1 AAAAAAAAAA 0 A_SpawnItemEx("IceSpark",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuff",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-500,500)/100.00,random(-180,180),160);
        TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-14000,14000)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-250,250)/100.00,random(-180,180),160);
        TNT1 A 0;
        TNT1 A 0;
        Stop;
    }
}

Class IceComboMissileCoop : IceComboMissile 
{ 
	Default
	{
		+THRUSPECIES; 
		Species "Player"; 
	}
}

Class IceComboPuff : Actor
{ 
	Default
	{
		Alpha 0.75;
		Scale 1.95;
		+NOINTERACTION;
		+CLIENTSIDEONLY;
		+FORCEXYBILLBOARD;
		RenderStyle "Add";
	}
    States
    {
    Spawn:
        TNT1 A 0;
        IPFF ABCDEFGHIJKL 10 BRIGHT;
        Stop;
    }
}

Class IceComboPuff2 : IceComboPuff 
{ 
	Default
	{
		Alpha 0.45; 
		Scale 2.75; 
		+FORCEXYBILLBOARD; 
	}
}

Class IceComboPuff3 : Actor
{
	Default
	{
		Alpha 0.65;
		Scale 1.55;
		+NOINTERACTION;
		+CLIENTSIDEONLY;
		+FORCEXYBILLBOARD;
		RenderStyle "Add";
	}
    States
    {
    Spawn:
        TNT1 A 0;
        IPFF ABCDEFGHIJKL 5 BRIGHT;
        Stop;
    }
}

Class IceComboPuff4 : IceComboPuff3 
{ 
	Default
	{
		Alpha 0.55;
		Scale 1.95;
		+FORCEXYBILLBOARD;
	}
}