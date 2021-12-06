Class IceBeam : Weapon
{
	Default 
	{
		Inventory.Icon "WEAPICBM";
		Inventory.PickupMessage "Got the Ice Beam!";
		Obituary "%k left %o in the cold.";
		
		Weapon.SelectionOrder 2000;
		Weapon.AmmoType "MissileAmmo";
		Weapon.AmmoType2 "SuperMissileAmmo";
		Weapon.AmmoUse1 0;
		Weapon.AmmoUse2 0;
		Weapon.SlotNumber 5;
		Weapon.BobRangeX 0.4;
		Weapon.BobRangeY 0.4;
		Weapon.BobSpeed 2.8;
		Weapon.BobStyle "Inverse";

		//+NOALERT;
		+Weapon.NOAUTOAIM;
		+Weapon.NOAUTOFIRE;
		+Weapon.NO_AUTO_SWITCH;
		+Inventory.UNDROPPABLE
		
	}

    States
    {
      Spawn:
        SOUL B -1;
        Stop;
		
	  Ready:
        IBEM A 0 ACS_ExecuteWithResult(476, 1);
		TNT1 A 0 A_SetCrosshair(13);
        goto Ready2;
      Ready2:
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID A 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID A 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID A 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID B 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID B 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID B 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID C 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID C 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID C 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID D 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID E 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID F 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID E 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID F 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID E 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID F 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID E 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID F 1 A_WeaponReady;
		TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 0), "Missile");
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594, 28, 1), "SuperMissile");
		IBID E 1 A_WeaponReady;
		TNT1 A 0 A_JumpIfInventory("IsShinesparking",1,"ShineBright");
        TNT1 A 0 A_JumpIfInventory("SpeedBoosterActive",  1, "D_RUNNIN");
        Goto Ready;

	  Select:
        TNT1 AAAAAAAAAAAAAAAAAAAA 0 A_Raise;
        IBEM A 1 A_Raise;
        loop;

	  Deselect:
        IBEM A 0 ACS_ExecuteWithResult(476, 0);
        TNT1 A 0 A_PlaySoundEx("beam/deselect","soundslot5");
      Deselect2:
        IBEM RSTUVW 1 A_WeaponReady(WRF_NOFIRE | WRF_NOSWITCH);
        TNT1 A 0 A_JumpIfHealthLower(1, "DeadLower");
        XBEM A 5 A_WeaponReady(WRF_NOFIRE | WRF_NOSWITCH);
        TNT1 AAAAAAAAAAAAAAAAAAAA 0 A_Lower;
        XBEM A 0 A_Lower;
        loop;

      DeadLower:
        XBEM A 1 A_Lower;
        loop;

	  Fire:
        IBEM A 0 ACS_ExecuteWithResult(476, 0);
        TNT1 A 0 A_JumpIfInventory("IceBeamChilled",1,"FireChilled");
        TNT1 A 0 A_PlayWeaponSound("ibeam/fire");
        TNT1 A 0 A_Recoil(0.05);
        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"FireCoop");
        TNT1 A 0 A_FireCustomMissile("IceBolt",0,0,12,-2,0,0);
        goto FireFinish;

	  PreHold:
		TNT1 A 0;
		TNT1 A 0 A_Refire;
		Goto Ready;
		
	  FireCoop:
        TNT1 A 0 A_FireCustomMissile("IceBoltCoop",0,0,12,-2,0,0);
      FireFinish:
        TNT1 A 0 A_AlertMonsters;
		TNT1 A 0 A_GiveInventory("MissileStateCounter", 100);
        TNT1 A 0 A_Light2;
        IBEM B 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        IBEM C 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        IBEM D 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEFFF 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEGHAAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 4 A_WeaponReady(WRF_NOSWITCH);
        IBEM A 6 A_WeaponReady(WRF_NOSWITCH);
		TNT1 A 0 A_JumpIfInventory("ChargeBeamAcquired", 1, "PreHold");
        Goto Ready;

	  FireChilled:
        TNT1 A 0 A_PlayWeaponSound("ibeam/fire");
        TNT1 A 0 A_Recoil(0.05);
        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"ChilledCoop");
        TNT1 A 0 A_FireCustomMissile("IceBolt",0,0,12,-2,0,0);
        goto ChilledFinish;

	  ChilledCoop:
        TNT1 A 0 A_FireCustomMissile("IceBoltCoop",0,0,12,-2,0,0);
      ChilledFinish:
        TNT1 A 0 A_AlertMonsters;
        TNT1 A 0 A_Light2;
        IBEM B 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        IBEM C 2 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        IBEM D 2 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEEFFFF 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEEGGHHAAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 4 A_WeaponReady(WRF_NOSWITCH);
        TNT1 A 0 A_Refire;
        IBEM A 6 A_WeaponReady(WRF_NOSWITCH);
        Goto Ready;

	  Hold:
        TNT1 A 0 A_JumpIfInventory("PowerBeamCharged",1,"HoldFinal2");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",26,"Hold7");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",21,"Hold6");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",16,"Hold5");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",11,"Hold4");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",6,"Hold3");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",1,"Hold2");
        TNT1 A 0 A_PlaySoundEx("pbeam/charge","soundslot5");
      Hold2:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHold2");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHold2");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM KK 1 BRIGHT A_SpawnItemEx("IceBeamCharging1",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner1",0,0,0,0,0,0)
        TNT1 A 0 A_Refire;
      HoldFire:
        TNT1 A 0;
		TNT1 A 0 A_JumpIfInventory("PowerBeamHalfCharged",1,"HalfShotHoldFinish");
        TNT1 A 0 A_PlaySoundEx("silence","soundslot5");
        TNT1 A 0 A_TakeInventory("PowerBeamChargeLevel",25);
        TNT1 A 0 A_ClearRefire;
        TNT1 A 0 A_PlayWeaponSound("ibeam/fire");
        TNT1 A 0 A_Recoil(0.05);
        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"UnholdCoop");
        TNT1 A 0 A_FireCustomMissile("IceBolt",0,0,12,-2,0,0);
        goto UnholdFinish;

	  UnholdCoop:
        TNT1 A 0 A_FireCustomMissile("IceBoltCoop",0,0,12,-2,0,0);
      UnholdFinish:
        TNT1 A 0 A_AlertMonsters;
        TNT1 A 0 A_Light2;
        IBEM B 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        IBEM C 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        IBEM D 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEFFF 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEGHAAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 4 A_WeaponReady(WRF_NOSWITCH);
        TNT1 A 0 A_Refire;
        IBEM A 6 A_WeaponReady(WRF_NOSWITCH);
        Goto Ready;

	  Hold3:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHold3");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHold3");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM LL 1 BRIGHT A_SpawnItemEx("IceBeamCharging2",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner2",0,0,0,0,0,0)
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  Hold4:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHold4");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHold4");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
		TNT1 A 0 A_GiveInventory("PowerBeamHalfCharged",1);
        IBEM MM 1 BRIGHT A_SpawnItemEx("IceBeamCharging3",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner3",0,0,0,0,0,0)
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  Hold5:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHold5");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHold5");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM NN 1 BRIGHT A_SpawnItemEx("IceBeamCharging4",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner4",0,0,0,0,0,0)
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  Hold6:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHold6");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHold6");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM OO 1 BRIGHT A_SpawnItemEx("IceBeamCharging5",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner5",0,0,0,0,0,0)
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  Hold7:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHold7");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHold7");
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM PP 1 BRIGHT A_SpawnItemEx("IceBeamCharging6",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner6",0,0,0,0,0,0)
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHold2:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM KK 1 BRIGHT A_SpawnItemEx("IceBeamCharging1",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHold3:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM LL 1 BRIGHT A_SpawnItemEx("IceBeamCharging2",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHold4:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
		TNT1 A 0 A_GiveInventory("PowerBeamHalfCharged",1);
        IBEM MM 1 BRIGHT A_SpawnItemEx("IceBeamCharging3",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHold5:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM NN 1 BRIGHT A_SpawnItemEx("IceBeamCharging4",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHold6:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM OO 1 BRIGHT A_SpawnItemEx("IceBeamCharging5",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHold7:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM PP 1 BRIGHT A_SpawnItemEx("IceBeamCharging6",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	  CrouchHoldFinal2:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("SpeedBoosterActive",1,"D_RUNNIN");
        TNT1 A 0 A_JumpIfInventory("PowerBeamIdle",26,"HoldFinal3");
        TNT1 A 0 A_GiveInventory("PowerBeamIdle",1);
        IBEM QQ 1 BRIGHT A_SpawnItemEx("IceBeamCharging7",-15,64,(sin(pitch)*-63)+8,0,0,0,-270,32);
        TNT1 A 0 A_JumpIfInventory("ISSynthFireRight",1,"ChargeCombo");
        TNT1 A 0 A_Refire;
        goto HoldFinish;

	OldHold2:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM KK 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner1",0,0,0,0,0,0);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	OldHold3:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM LL 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner2",0,0,0,0,0,0);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	OldHold4:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
		TNT1 A 0 A_GiveInventory("PowerBeamHalfCharged",1);
        IBEM MM 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner3",0,0,0,0,0,0);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	OldHold5:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM NN 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner4",0,0,0,0,0,0);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	OldHold6:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM OO 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner5",0,0,0,0,0,0);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	OldHold7:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("PowerBeamChargeLevel",25,"HoldFinal");
        TNT1 A 0 A_GiveInventory("PowerBeamChargeLevel",1);
        IBEM PP 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner6",0,0,0,0,0,0);
        TNT1 A 0 A_Refire;
        goto HoldFire;

	OldHoldFinal2:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("SpeedBoosterActive",1,"D_RUNNIN");
        TNT1 A 0 A_JumpIfInventory("PowerBeamIdle",26,"HoldFinal3");
        TNT1 A 0 A_GiveInventory("PowerBeamIdle",1);
        IBEM QQ 1 BRIGHT A_FireCustomMissile("IceBeamChargingSpawner7",0,0,0,0,0,0);
        TNT1 A 0 A_JumpIfInventory("ISSynthFireRight",1,"ChargeCombo");
        TNT1 A 0 A_Refire;
        goto HoldFinish;

	  HoldFinal:
        TNT1 A 0;
        TNT1 A 0 A_GiveInventory("PowerBeamCharged",1);
        TNT1 A 0 A_PlaySoundEx("pbeam/idle","soundslot7");
      HoldFinal2:
        TNT1 A 0;
        TNT1 A 0 A_JumpIfInventory("CustomMissileCharge",1,"OldHoldFinal2");
        TNT1 A 0 A_JumpIfInventory("WhyCantMetroidCrawl",1,"CrouchHoldFinal2");
        TNT1 A 0 A_JumpIfInventory("SpeedBoosterActive",1,"D_RUNNIN");
        TNT1 A 0 A_JumpIfInventory("PowerBeamIdle",26,"HoldFinal3");
        TNT1 A 0 A_GiveInventory("PowerBeamIdle",1);
        IBEM QQ 1 BRIGHT A_SpawnItemEx("IceBeamCharging7",-15,64,(sin(pitch)*-63)+26,0,0,0,-270,32);//A_FireCustomMissile("IceBeamChargingSpawner7",0,0,0,0,0,0)
        TNT1 A 0 A_JumpIfInventory("ISSynthFireRight",1,"ChargeCombo");
        TNT1 A 0 A_Refire;
      HoldFinish:
        TNT1 A 0 A_PlaySoundEx("silence","soundslot7");//A_StopSoundEx("soundslot7")
        TNT1 A 0 A_PlayWeaponSound("ibeam/chfire");
        TNT1 A 0 A_TakeInventory("PowerBeamCharged",1);
        TNT1 A 0 A_TakeInventory("PowerBeamChargeLevel",25);
        TNT1 A 0 A_TakeInventory("PowerBeamIdle",34);
		TNT1 A 0 A_TakeInventory("PowerBeamHalfCharged",1);
        TNT1 A 0 A_ClearRefire;
        TNT1 A 0 A_Recoil(2);
        TNT1 A 0 A_ZoomFactor(0.95,ZOOM_INSTANT);
        TNT1 A 0 Radius_Quake(4,8,0,1,0);
        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"ChargedCoop");
        TNT1 A 0 A_FireCustomMissile("IceBoltCharged",0,0,12,-2,0,0);
        goto ChargedFinish;

	  HalfShotHoldFinish:
        TNT1 A 0 A_StopSoundEx("soundslot5");
        TNT1 A 0 A_PlayWeaponSound("ibeam/fire");
        TNT1 A 0 A_TakeInventory("PowerBeamCharged",1);
        TNT1 A 0 A_TakeInventory("PowerBeamChargeLevel",25);
        TNT1 A 0 A_TakeInventory("PowerBeamIdle",34);
		TNT1 A 0 A_TakeInventory("PowerBeamHalfCharged",1);
        TNT1 A 0 A_ClearRefire;
        TNT1 A 0 A_Recoil(2);
        TNT1 A 0 A_ZoomFactor(0.95,ZOOM_INSTANT);
        TNT1 A 0 Radius_Quake(1,8,0,1,0);
		TNT1 A 0 A_FireCustomMissile("IceBoltHalfCharged",0,0,12,-2,0,0);
        goto ChargedFinish;

	  ChargedCoop:
        TNT1 A 0 A_FireCustomMissile("IceBoltChargedCoop",0,0,12,-2,0,0);
      ChargedFinish:
        TNT1 A 0 A_AlertMonsters;
        TNT1 A 0 A_Light2;
        IBEM B 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        TNT1 A 0 A_ZoomFactor(0.975,ZOOM_INSTANT);
        IBEM C 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        TNT1 A 0 A_ZoomFactor(1.00,ZOOM_INSTANT);
        IBEM D 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEFFFEEGHAAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 8 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        Goto Ready;

	  HoldFinal3:
        TNT1 A 0;
        TNT1 A 0 A_TakeInventory("PowerBeamIdle",99);
        TNT1 A 0 A_PlaySoundEx("pbeam/idle","soundslot7");
        goto HoldFinal2;

      Missile:
        TNT1 A 0 ACS_ExecuteWithResult(476, 0);
        TNT1 A 0 ACS_ExecuteWithResult(594, 29, 0, 1);
        TNT1 A 0 A_PlayWeaponSound("missile/fire");
        TNT1 A 0 A_AlertMonsters;

        TNT1 A 0 A_ZoomFactor(0.95,ZOOM_INSTANT);

        TNT1 A 0 A_Recoil(2);
        TNT1 A 0 Radius_Quake(1,8,0,1,0);

        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"Missile_Coop");
        goto Missile_DM;

      Missile_DM:
        TNT1 A 0 A_FireCustomMissile("PowerMissile",0,1,12,-2,0,0);
        goto MissileAnim;

      Missile_Coop:
        TNT1 A 0 A_FireCustomMissile("PowerMissileCoop",0,1,12,-2,0,0);
        goto MissileAnim;

	  MissileAnim:
        IBEM A 0 A_JumpIfInventory("IceBeamChilled", 1, "MissileAnim_Chilled");
        IBEM A 0 A_Light2;
        IBEM I 1 BRIGHT A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
        IBEM A 0 A_Light1;
        IBEM A 0 A_ZoomFactor(0.975,ZOOM_INSTANT);
        IBEM J 1 BRIGHT A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
        IBEM A 0 A_Light0;
        IBEM A 0 A_ZoomFactor(1.00,ZOOM_INSTANT);
        IBEM E 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
        IBEM EEFFFEEGGHH 1 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
        IBEM A 2 A_WeaponReady(WRF_NOFIRE|WRF_NOSWITCH);
        goto Ready;

	  MissileAnim_Chilled:
        TNT1 A 0 A_Light2;
        IBEM I 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        TNT1 A 0 A_ZoomFactor(0.975,ZOOM_INSTANT);
        IBEM J 2 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        TNT1 A 0 A_ZoomFactor(1.00,ZOOM_INSTANT);
        IBEM E 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEEFFFFEEEGGGHHHAAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 2 A_WeaponReady(WRF_NOSECONDARY|WRF_NOSWITCH);
        Goto Ready;

      SuperMissile:
        TNT1 A 0 ACS_ExecuteWithResult(476, 0);
        TNT1 A 0 ACS_ExecuteWithResult(594, 29, 1, 1);
        TNT1 A 0 A_PlayWeaponSound("supermissile/fire");
        TNT1 A 0 A_AlertMonsters;

        TNT1 A 0 A_ZoomFactor(0.925,ZOOM_INSTANT);

        TNT1 A 0 A_Recoil(5);
        TNT1 A 0 Radius_Quake(2,8,0,1,0);

        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"SuperCoop");
        goto SuperDM;

      SuperDM:
        TNT1 A 0 A_FireCustomMissile("SuperMissile",0,0,12,-2,0,0);
        goto SuperAnim;

      SuperCoop:
        TNT1 A 0 A_FireCustomMissile("SuperMissileCoop",0,0,12,-2,0,0);
        goto SuperAnim;

	  SuperAnim:
        TNT1 A 0 A_SetAngle(angle+(random(-200,200)/100.00));
        TNT1 A 0 A_SetPitch(pitch-(random(300,500)/100.00));
        TNT1 A 0 A_AlertMonsters;
        TNT1 A 0 A_Light2;
        IBEM I 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        TNT1 A 0 A_ZoomFactor(0.95,ZOOM_INSTANT);
        IBEM J 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        TNT1 A 0 A_ZoomFactor(1.00,ZOOM_INSTANT);
        IBEM E 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEFFFEEGGHHAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 8 A_WeaponReady(WRF_NOSECONDARY|WRF_NOSWITCH);
        Goto Ready;
		
	  ChargeCombo:
		TNT1 A 0 A_JumpIfInventory("IceSpreaderAcquired",1,1);
        TNT1 A 0 A_JumpIfInventory("MissileAmmo",10,1);
        goto HoldFinal2;
        TNT1 A 0;
        IBEM R 20 BRIGHT A_PlaySoundEx("combo/ready","soundslot7");
        TNT1 A 0 A_PlayWeaponSound("combo/ice");
        TNT1 A 0 A_TakeInventory("PowerBeamCharged",1);
        TNT1 A 0 A_TakeInventory("PowerBeamChargeLevel",25);
        TNT1 A 0 A_TakeInventory("PowerBeamIdle",34);
        TNT1 A 0 A_ClearRefire;
        TNT1 A 0 A_Recoil(10);
        TNT1 A 0 A_ZoomFactor(0.9,ZOOM_INSTANT);
        TNT1 A 0 Radius_Quake(2,8,0,1,0);
        TNT1 A 0 A_JumpIfInventory("CoopModeOn",1,"ComboCoop");
        TNT1 A 0 A_FireCustomMissile("IceComboMissile",0,0,12,-2,0,0);
        goto ComboFinish;

	  ComboCoop:
        TNT1 A 0 A_FireCustomMissile("IceComboMissileCoop",0,0,12,-2,0,0);
      ComboFinish:
        TNT1 A 0 A_TakeInventory("MissileAmmo",10);
        TNT1 A 0 A_SetAngle(angle+(random(-200,200)/100.00));
        TNT1 A 0 A_SetPitch(pitch-(random(300,500)/100.00));
        TNT1 A 0 A_AlertMonsters;
        TNT1 A 0 A_Light2;
        IBEM I 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light1;
        TNT1 A 0 A_ZoomFactor(0.975,ZOOM_INSTANT);
        IBEM J 1 BRIGHT A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        TNT1 A 0 A_Light0;
        TNT1 A 0 A_ZoomFactor(1.00,ZOOM_INSTANT);
        IBEM E 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM EEFFFEEGGHHAA 1 A_WeaponReady(WRF_NOSECONDARY|WRF_NOPRIMARY|WRF_NOSWITCH);
        IBEM A 8 A_WeaponReady(WRF_NOSECONDARY|WRF_NOSWITCH);
        Goto Ready;

	  D_RUNNIN:
        IBEM A 0 ACS_ExecuteWithResult(476, 0);
        TNT1 A 0 A_TakeInventory("PowerBeamCharged",1);
        TNT1 A 0 A_TakeInventory("PowerBeamChargeLevel",25);
        TNT1 A 0 A_TakeInventory("PowerBeamIdle",34);
        TNT1 A 0 A_TakeInventory("MissileCharged",1);
        TNT1 A 0 A_TakeInventory("MissileChargeLevel",34);
        TNT1 A 0 A_ClearRefire;
        TNT1 A 0 Offset(0,32);
        IBEM A 1 Offset(0,40);
        IBEM A 1 Offset(0,50);
        IBEM A 1 Offset(0,60);
        IBEM A 1 Offset(0,70);
        IBEM A 1 Offset(0,80);
        IBEM A 1 Offset(0,90);
        IBEM A 1 Offset(0,100);
        IBEM A 1 Offset(0,110);
        IBEM A 1 Offset(0,120);
        IBEM A 1 Offset(0,130);
        IBEM A 1 Offset(0,140);
      IdleLoop:
        TNT1 A 1;
		TNT1 A 0 A_JumpIfInventory("ShinesparkCharge",1,"PreShine");
        TNT1 A 0 A_JumpIfInventory("SpeedBoosterActive",1,"IdleLoop");
        goto BackToNormal;
		
	  PreShine:
		TNT1 A 1;
		TNT1 A 0 A_JumpIfInventory("ShinesparkCharge",1,"PreShine");
		Goto Ready;
		
	  ShineBright:
		TNT1 A 0 Offset(0,32);
        IBEM A 1 Offset(0,40);
        IBEM A 1 Offset(0,50);
        IBEM A 1 Offset(0,60);
        IBEM A 1 Offset(0,70);
        IBEM A 1 Offset(0,80);
        IBEM A 1 Offset(0,90);
        IBEM A 1 Offset(0,100);
        IBEM A 1 Offset(0,110);
        IBEM A 1 Offset(0,120);
        IBEM A 1 Offset(0,130);
        IBEM A 1 Offset(0,140);
	  ShineLoop:
        TNT1 A 1;
		TNT1 A 0 A_JumpIfInventory("IsShinesparking",1,"ShineLoop");
		Goto BackToNormal;

      BackToNormal:
        IBEM A 1 Offset(0,140);
        IBEM A 1 Offset(0,130);
        IBEM A 1 Offset(0,120);
        IBEM A 1 Offset(0,110);
        IBEM A 1 Offset(0,100);
        IBEM A 1 Offset(0,90);
        IBEM A 1 Offset(0,80);
        IBEM A 1 Offset(0,70);
        IBEM A 1 Offset(0,60);
        IBEM A 1 Offset(0,50);
        IBEM A 1 Offset(0,40);
        TNT1 A 0 Offset(0,32);
        Goto Ready;
    }
}

// == THIS IS WHAT ACTUALLY COMES OUT! ==
Class IceBolt : Actor {
	Default
	{
		Radius 8;
		Height 10;
		Projectile;
		+NOGRAVITY;
		+FORCEXYBILLBOARD;
		+HITTRACER;
		Speed 30;
		Damage (20);
		Scale 0.25;
		RenderStyle "Add";
		Alpha 0.95;
		DeathSound "ibeam/hit";
		Decal "DoomImpScorch";
		DamageType "IceBeam";
	}
	
	States
    {
      Spawn:
        TNT1 A 0;
        TNT1 AA 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_SpawnItemEx("IceTrailFlicker2",0,0,0,random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,random(-180,180),160,0);
        ISHT A 1 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,0,160,0);
        loop;

      Death:
        ISHT B 1
		{
			if (tracer && (tracer.bISMONSTER || tracer.player) && !tracer.bBOSS) 
			{
				tracer.GiveInventory("FreezeToken",1);
				let frz = FreezeToken(tracer.FindInventory("FreezeToken"));
				if (frz)
				{
					frz.fcounter+=64;
				}
			}
			
		}
        TNT1 A 0 A_Stop;
        //ISHT B 1 A_SpawnItemEx("IceBoltExplosion",0,0,0,0,0,0,0,32);
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
        TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrailFlicker",0,0,Random(-200,200),3,Random(-200,200));
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("MissileTrail",random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,128);
        ISHT B 1 A_SpawnItemEx("IceBoltPuff",0,0,0,0,0,0,0,160);
        ISHT B 4; // Linger a while so it'll register with doors
        stop;
    }
}

Class IceBoltExplosion : Actor {
	Default
	{
		Radius 1;
		Height 1;
		Speed 0;
		DamageType "IceBeamExplode";
		+NOCLIP;
		+FORCEXYBILLBOARD;
		-SOLID;
		Obituary "%k left %o in the cold.";
	}
		
    States
    {
      Spawn:
        TNT1 A 1;
        TNT1 A 1 A_Explode(8,32,0);
        Stop;
    }
}

Class IceBoltCoop : IceBolt
{
	Default
	{
		Damage (20);
		Species "Player";
		DamageType "IceBeam";
		+THRUSPECIES;
		+FORCEXYBILLBOARD;
	}
	
    States {
		Death:
			ISHT B 0
			{
				if (tracer && (tracer.bISMONSTER || tracer.player) && !tracer.bBOSS) 
				{
					tracer.GiveInventory("FreezeToken",1);
					let frz = FreezeToken(tracer.FindInventory("FreezeToken"));
					if (frz)
					{
						frz.fcounter+=64;
					}
				}
			
			}
			ISHT B 0 A_Stop;
			//ISHT B 0 A_SpawnItemEx("IceBoltExplosionCoop",0,0,0,0,0,0,0,32);
			TNT1 BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
			TNT1 BBBBBBBBBBBBB 0 A_CustomMissile("IceTrailFlicker",0,0,Random(-200,200),3,Random(-200,200));
			TNT1 BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB 0 A_SpawnItemEx("MissileTrail",random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,128);
			ISHT B 0 A_SpawnItemEx("IceBoltPuff",0,0,0,0,0,0,0,160);
			ISHT B 4; // Linger a while so it'll register with doors
			stop;
	}
}

Class IceBoltExplosionCoop : IceBoltExplosion
{
	Default
	{
		+FORCEXYBILLBOARD;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1 A_Explode(8,32,0);
        Stop;
    }
}

Class IceTrail : Actor 
{
	Default
	{
		Alpha 0.95;
		Scale 0.4;
		+NOINTERACTION;
		+FORCEXYBILLBOARD;
		+CLIENTSIDEONLY;
		RenderStyle "Add";
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
      Spawn1:
        TNT1 A 0;
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594,0,0,0) == 1,"Nope");
        TNT1 AA 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
        FRZS ABCDEFGHIJKLMNO 1 BRIGHT A_SpawnItemEx("IceTrailFlicker",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        FRZS PQRSTUVWXYZ 1 BRIGHT A_FadeOut(0.05); //A_SpawnItemEx("IceTrailFlicker",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0)
        stop;

      Nope:
        TNT1 A 1;
        stop;
    }
}

Class IceBoltPuff : Actor 
{
	Default
	{
		Alpha 0.95;
		Scale 0.15;
		+NOINTERACTION;
		+CLIENTSIDEONLY;
		+FORCEXYBILLBOARD;
		RenderStyle "Add";
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        IPFF ABCDEFGHIJKL 2 BRIGHT;
        stop;
    }
}

Class IceTrailFlicker : IceTrail
{
	Default
	{
		+FORCEXYBILLBOARD;
		Scale 0.02;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594,0,0,0) == 1,"Nope");
        ICHK ABC 2 BRIGHT A_FadeOut(0.15);
        stop;

      Nope:
        TNT1 A 1;
        stop;
    }
}

Class IceTrailFlicker2 : IceTrail
{
	Default
	{
		+FORCEXYBILLBOARD;
		Scale 0.1;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594,0,0,0) == 1,"Nope");
        FRZS ACEGIKM 1 BRIGHT A_SpawnItemEx("IceTrailFlicker",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        FRZS OQSUWY 1 BRIGHT A_FadeOut(0.1);//A_SpawnItemEx("IceTrailFlicker",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0)
        stop;

      Nope:
        TNT1 A 1;
        stop;
    }
}

Class IceTrailFlicker3 : IceTrail { 
	Default 
	{
		Alpha 0.5; 
	}
}

Class IceSpark : Actor 
{
	Default
	{
		Radius 1;
		Scale 0.01;
		Gravity 0.25;
		Speed 2;
		Renderstyle "Add";
		Projectile;
		+CLIENTSIDEONLY;
		+RANDOMIZE;
		+NOTELEPORT;
		+FORCEXYBILLBOARD;
		//+EXPLODEONWATER;
		//-CANBOUNCEWATER;
		//+DONTSPLASH;
		//+THRUACTORS;
		//-NOGRAVITY;
		//+DOOMBOUNCE;
		+NOINTERACTION;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594,0,0,0) == 1,"Nope");
        TNT1 A 0 A_Jump(64,3);
        TNT1 A 0 A_Jump(64,1);
        ICHK ABC 2 BRIGHT A_FadeOut(0.1);
        loop;

      Nope:
        TNT1 A 1;
        stop;
    }
}

Class IceBeamChargingSpawner1 : Actor 
{
	Default
	{
		-SOLID;
		+NOINTERACTION;
		+CLIENTSIDEONLY;
		+NOTIMEFREEZE;
		Radius 0;
		Height 0;
		Speed 24;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging1",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamChargingSpawner2 : IceBeamChargingSpawner1
{
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging2",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamChargingSpawner3 : IceBeamChargingSpawner1
{
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging3",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamChargingSpawner4 : IceBeamChargingSpawner1
{
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging4",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamChargingSpawner5 : IceBeamChargingSpawner1
{
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging5",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamChargingSpawner6 : IceBeamChargingSpawner1
{
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging6",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamChargingSpawner7 : IceBeamChargingSpawner1
{
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 A_SpawnItemEx("IceBeamCharging7",-14,0,-3,0,0,0,-270,32);
        stop;
    }
}

Class IceBeamCharging1 : Actor 
{
	Default
	{
		RenderStyle "Add";
		Alpha 0.75;
		Scale 0.07;
		+CLIENTSIDEONLY;
		+NOINTERACTION;
		+NOTIMEFREEZE;
		+FORCEXYBILLBOARD;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594,0,0,0) == 1,"Simple");
        TNT1 A 0 A_Jump(256,"Spawn1","Spawn2","Spawn3","Spawn4");
        TNT1 A 1;
        loop;

      Spawn1:
        IBCH ABCDA 1 bright A_FadeOut(0.15);
        stop;

      Spawn2:
        IBCH BCDAB 1 bright A_FadeOut(0.15);
        stop;

      Spawn3:
        IBCH CDABC 1 bright A_FadeOut(0.15);
        stop;

      Spawn4:
        IBCH DABCD 1 bright A_FadeOut(0.15);
        stop;

      Simple:
        TNT1 A 0;
        TNT1 A 0 A_Jump(256,"Spawn1B","Spawn2B","Spawn3B","Spawn4B");
        TNT1 A 1;
        loop;

      Spawn1B:
        IBCH A 2 bright;
        stop;

      Spawn2B:
        IBCH B 2 bright;
        stop;

      Spawn3B:
        IBCH C 2 bright;
        stop;

      Spawn4B:
        IBCH D 2 bright;
        stop;
    }
}

Class IceBeamCharging2 : IceBeamCharging1 
{
	Default
	{
		Scale 0.08;
		+FORCEXYBILLBOARD; 
	}
}
Class IceBeamCharging3 : IceBeamCharging1 
{
	Default
	{
		Scale 0.09;
		+FORCEXYBILLBOARD; 
	}
}
Class IceBeamCharging4 : IceBeamCharging1
{
	Default
	{
		Scale 0.105;
		+FORCEXYBILLBOARD; 
	}
}
Class IceBeamCharging5 : IceBeamCharging1
{
	Default
	{
		Scale 0.12;
		+FORCEXYBILLBOARD; 
	}
}
Class IceBeamCharging6 : IceBeamCharging1
{
	Default
	{
		Scale 0.135;
		+FORCEXYBILLBOARD; 
	}
}
Class IceBeamCharging7 : IceBeamCharging1
{
	Default
	{
		Scale 0.15;
		+FORCEXYBILLBOARD; 
	}
}

Class IceBoltCharged : Actor 
{
	Default
	{
		Radius 10;
		Height 10;
		Projectile;
		+NOGRAVITY;
		+FORCEXYBILLBOARD;
		Speed 45;
		Damage (40);
		Scale 0.35;
		RenderStyle "Add";
		Alpha 0.95;
		DeathSound "ibeam/chit";
		Decal "Scorch";
		DamageType "IceCharged";
	}
	
    States {
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
			ISHT B 1 BRIGHT A_SpawnItemEx("IceTrailCharged",0,0,0,0,0,0,0,160);
			loop;

		Death:
			ISHT B 0;
			TNT1 A 0 A_Stop;
			TNT1 A 0 A_SpawnItemEx("IceBoltChargedExplosion",0,0,0,0,0,0,0,32);
			TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
			TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrail",0,0,Random(-200,200),3,Random(-200,200));
			TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrailFlicker",0,0,Random(-200,200),3,Random(-200,200));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("MissileTrail",random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,128);
			TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",0,0,0,0,0,0,0,160);
			ISHT B 4; // Linger a while so it'll register with doors
			stop;
    }
}

Class IceBoltChargedCoop : IceBoltCharged {
	Default
	{
		Damage (40);
		Species "Player";
		DamageType "IceCharged";
		+THRUSPECIES;
		+FORCEXYBILLBOARD;
	}
	
	States {
		Death:
			TNT1 A 0;
			TNT1 A 0 A_Stop;
			TNT1 A 0 A_SpawnItemEx("IceBoltChargedExplosionCoop",0,0,0,0,0,0,0,32);
			TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceSpark",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,400)/100.00,random(-180,180),160,0);
			TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrail",0,0,Random(-200,200),3,Random(-200,200));
			TNT1 AAAAAAAAAAAAA 0 A_CustomMissile("IceTrailFlicker",0,0,Random(-200,200),3,Random(-200,200));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("MissileTrail",random(-100,100)/100.00,random(-100,100)/100.00,random(-100,100)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,128);
			TNT1 A 0 A_SpawnItemEx("IceBoltPuffCharged",0,0,0,0,0,0,0,160);
			ISHT B 4; // Linger a while so it'll register with doors
			stop;
	}
}

Class IceBoltChargedExplosion : Actor 
{
	Default
	{
		Radius 1;
		Height 1;
		Speed 0;
		DamageType "IceChargedExplode";
		+NOCLIP;
		+FORCEXYBILLBOARD;
		-SOLID;
		Obituary "%k left %o in the cold.";
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1 A_Explode(16,112,0);
        Stop;
    }
}

Class IceBoltChargedExplosionCoop : IceBoltChargedExplosion
{
	Default
	{
		+FORCEXYBILLBOARD;
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 1 A_Explode(16,192,0);
        Stop;
    }
}

Class IceBoltPuffCharged : IceBoltPuff 
{ 
	Default
	{
		Scale 0.7;
	}
}

Class IceTrailCharged : Actor 
{
	Default
	{
		Alpha 0.95;
		Scale 0.45;
		+NOINTERACTION;
		+CLIENTSIDEONLY;
		+FORCEXYBILLBOARD;
		RenderStyle "Add";
	}
	
    States
    {
      Spawn:
        TNT1 A 0;
        TNT1 A 0 A_JumpIf(ACS_ExecuteWithResult(594,0,0,0) == 1,"Nope");
        ISHT A 2 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0);
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT; //A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0)
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT; //A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0)
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT; //A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0)
        TNT1 A 0 A_FadeOut(0.1);
        ISHT A 2 BRIGHT; //A_SpawnItemEx("IceTrail",0,0,0,random(-200,200)/100.00,random(-200,200)/100.00,random(-200,200)/100.00,random(-180,180),160,0)
        TNT1 A 0 A_FadeOut(0.1);
        stop;

      Nope:
        TNT1 A 1;
        stop;
    }
}

//Half Shot Actors
Class IceBoltHalfCharged : IceBoltCharged
{
	Default
	{
		+FORCEXYBILLBOARD;
		Radius 8;
		Height 8;
		Damage (30);
		DamageType "IceHalfCharged";
		Scale 0.15;
	}
}

Class IceTrailHalfCharged : IceTrailCharged
{
	Default
	{
		+FORCEXYBILLBOARD;
		Scale 0.15;
	}
}

Class FreezeToken : Inventory {
	int fcounter;
	uint ownertrans;
	bool grav;
	
	override void AttachToOwner(actor other) {
		super.AttachToOwner(other);
		if (!owner)
			return;
		grav = owner.bNOGRAVITY;
		if (grav)
			owner.bNOGRAVITY = false;
		owner.bNOPAIN = true;
		ownertrans = owner.translation;
		owner.A_SetTranslation("Ice");
		owner.A_StartSound("ibeam/freeze");
		let layer = Spawn("FrozenLayer",owner.pos);
		if (layer) {
			layer.master = owner;
			layer.sprite = owner.sprite;
			layer.frame = owner.frame;
			layer.angle = owner.angle;
			layer.scale.x = owner.scale.x*1.32;
			layer.scale.y = owner.scale.y*1.07;
			layer.bSPRITEFLIP = owner.bSPRITEFLIP;
			layer.bYFLIP = owner.bYFLIP;
		}
	}
	override void DoEffect() {
		super.DoEffect();
		if (level.isFrozen() || !owner)
			return;
		owner.A_SetTics(fcounter);
		fcounter--;
		//console.printf("owner: %s, counter: %d",owner.GetclassName(),fcounter);
		if (fcounter <= 0) {
			DepleteOrDestroy();
			return;
		}
		if (owner.health <= 0) {
			for (int i = 7; i >= 0; i--)
				owner.A_SoundVolume(i,0);
			int rad = owner.radius;
			for (int i = random[sfx](5,8); i > 0; i--) {
				let ice = Spawn("IceChunk",owner.pos + (frandom[sfx](-rad,rad),frandom[sfx](-rad,rad),frandom[sfx](0,owner.default.height)));
				if (ice) {
					ice.vel = (frandom[sfx](-3,3),frandom[sfx](-3,3),frandom[sfx](2,6));
					ice.master = owner;
					ice.gravity = 0.7;
				}
			}
			for (int i = random[sfx](12,16); i > 0; i--) {
				let ice = Spawn("IceChunk",owner.pos + (frandom[sfx](-rad,rad),frandom[sfx](-rad,rad),frandom[sfx](0,owner.default.height)));
				if (ice) {
					ice.vel = (frandom[sfx](-3.5,3.5),frandom[sfx](-3.5,3.5),frandom[sfx](3,7));
					ice.master = owner;
					ice.gravity = 0.5;
					ice.A_SetRenderstyle(1.0,Style_AddShaded);
					ice.SetShade("08caed");
					ice.A_SetScale(frandom[sfx](0.4,0.75));
				}
			}
			owner.A_StartSound("ibeam/freeze");
			owner.gravity = 0.4;
			//owner.vel = (frandom[sfx](-2,2),frandom[sfx](-2,2),frandom[sfx](3,6));
			owner.vel *= 0.15;
			owner.A_NoBlocking();
			owner.A_SetScale(Clamp(owner.radius*0.04,0.1,1));
			owner.SetOrigin(owner.pos + (0,0,owner.default.height*0.5),false);
			owner.bSPRITEFLIP = random[sfx](0,1);
			//owner.sprite = GetSpriteIndex("IGIB");
			owner.frame = 0;
			owner.A_SetTranslation("Ice");
			owner.A_SetTics(1000);
			owner.deathsound = "";
			owner.bDONTTHRUST = true;
			DepleteOrDestroy();
			return;
		}
	}
	override void DetachFromOwner() {
		if (!owner)
			return;
		owner.bNOPAIN = owner.default.bNOPAIN;
		owner.bNOGRAVITY = grav;
		if (owner.health > 0)
			owner.translation = ownertrans;
		super.DetachFromOwner();
	}
}

Class FrozenLayer : Actor 
{
	Default 
	{
		+NOINTERACTION;
		RenderStyle "Shaded";
		StencilColor "08CAED";
	}
	override void Tick() {
		if (master && master.FindInventory("FreezeToken")) {
			SetOrigin(master.pos,true);
		}
		else
			destroy();
	}
	states {
	Spawn:
		#### # -1;
		stop;
	}
}

Class FrozenDummy : Actor
{
	Default
	{
		+SHOOTABLE;
		+SOLID;
		+NOBLOOD;
		Height 56;
		Radius 16;
		Health 15;
		Speed 0;
		Mass 0x7fffffff;
		Translation "Ice";
		DamageFactor "NoDamage", 0.0;
		DamageFactor "Normal", 0.75;
		DamageFactor "IceBeamExplode", 0.0;
		DamageFactor "IceChargedExplode", 0.0;
		DamageFactor "IceCombo", 0.0;
	}
	
    States
    {
    Spawn:
        PLAY G 2100;
        PLAY G 1 A_Jump(128, "Death");
        Loop;
    Death:
        TNT1 A 0;
        TNT1 A 0 A_PlaySound("misc/icebreak");
        TNT1 A 0 A_PlaySoundEx("ibeam/break","soundslot6");
        TNT1 AAAAAA 0 A_SpawnItemEx("IceChunk2",random(-1,1),random(-1,1),random(16,46),random(-2,2),random(-2,2),random(2,9),random(-180,180),160);
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceTrailFlicker",random(-1,1),random(-1,1),random(16,46),random(-500,500)/100.00,random(-500,500)/100.00,random(-200,500)/100.00,random(-180,180),161);
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceTrailFlicker",random(-1,1),random(-1,1),random(16,46),random(-500,500)/100.00,random(-500,500)/100.00,random(-200,500)/100.00,random(-180,180),161);
        TNT1 AAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceTrailFlicker3",random(-1,1),random(-1,1),random(16,46),random(-400,400)/100.00,random(-400,400)/100.00,random(10,500)/100.00,random(-180,180),161);
        TNT1 AAAAAAAAAAAAAAAA 0 A_SpawnItemEx("IceTrailFlicker3",random(-1,1),random(-1,1),random(16,46),random(-400,400)/100.00,random(-400,400)/100.00,random(10,500)/100.00,random(-180,180),161);
        TNT1 A 0 A_FreezeDeathChunks;
        TNT1 A 0 A_NoBlocking;
		TNT1 A 0 A_SpawnItemEx("EnemyDropSpawner",0,0,0);
		TNT1 A 0 ACS_ExecuteAlways(594,0,31);
        TNT1 A 1;
        Stop;
    }
}