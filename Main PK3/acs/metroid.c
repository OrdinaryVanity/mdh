#library "METROID"
#include "zcommon.acs"
#include "commonFuncs.h"

world int 0:MaxJumpCount;
world int 1:hp;
world int 2:spawnhp;
world int 3:armor;
world int 4:oarmor;

int playerOnFoot[PLAYERMAX];
int IsServer;

int playerJumps[PLAYERMAX] = {0};
int hasKicked[PLAYERMAX]   = {0};
int grabbing[PLAYERMAX]    = {0};
int dontGrab[PLAYERMAX]    = {0};
int oldLedgeVals[PLAYERMAX][2] = {{0}};

int CPlayerGrounds[PLAYERMAX][2];
int PlayerGrounds[PLAYERMAX][2];
int DidSpecials[PLAYERMAX];

int ClientEnterLocks[PLAYERMAX];

int array_custmischarg[PLAYERMAX];
int array_runrunruu[PLAYERMAX];
int array_doomHealth[PLAYERMAX];
int array_metpick[PLAYERMAX];
int array_hitindic[PLAYERMAX];

#include "met_const.h"
#include "met_msg.h"

#include "met_funcs.h"

#include "met_spacejump.h"
#include "met_longbeam.h"
#include "met_chroma.h"
#include "met_select.h"

//[R4L] To keep in line with DECORATE checks
int GotSpazer;
int GotPlasma;
int GotWave;
int GotIce;
int GotLong;
int GotCharge;
int GotDoom;
int GotChroma;
int GotMorph;
int GotSpeed;
int GotSpace;
int GotVaria;
int GotChargeBeam;
int GotMissiles;
int GotPowerBomb;
int GotPowerMissile;
int GotWaveMissile;
int GotSolarFlare;
int GotIceSpreader;
int GotNovaFlash;
int GotWideShot;
int GotHyperBeam;
int GotChainsawBeam;
int GotArmor;
int GotBombs;
int GotBoostBall;
int GotHiJump;
int GotScan;
int GotGravity;

// CVAR HANDLING SHIT
// ==================

script METROID_OPEN OPEN
{
    IsServer = 1;
    int cjumps, oldcjumps;

    if (M_GetCVar("met_runbefore") != METROID_SV_CVAR_VERSION)
    {
        M_SetCVar("met_runbefore", METROID_SV_CVAR_VERSION);
        M_DefaultCVar("met_noaircontrol",       0);
        M_DefaultCVar("met_spacejump",          0);
        M_DefaultCVar("met_loaded",             0);
        M_DefaultCVar("met_startingtanks",      0);
        M_DefaultCVar("met_nolevellimiter",     1);
        M_DefaultCVar("met_jumpcount",          2);
        M_DefaultCVar("met_nomorph",            0);
        M_DefaultCVar("met_noenemydrops",       0);
        M_DefaultCVar("met_doomcannon",         0);
        M_DefaultCVar("met_dropstay",           0);
        M_DefaultCVar("met_nobfg",              0);
        M_DefaultCVar("met_permabfg",           0);
        M_DefaultCVar("met_soultanks",          0);
        M_DefaultCVar("met_skulltagweapons",    0);
        M_DefaultCVar("met_dropgravity",        0);
		M_DefaultCVar("met_nomodels",           0);
    }

    while (1)
    {
        M_SetCVar_ZandOnly("compat_clientssendfullbuttoninfo", 1);

        if      (M_GetCVar("met_noaircontrol") == 0) { SetAirControl(0.225); }
        else if (M_GetCVar("met_noaircontrol") == 1) { SetAirControl(0.00390625); }

        oldcjumps = cjumps;
        cjumps = M_GetCVar("met_jumpcount");
        if (cjumps != oldcjumps) { MaxJumpCount = cjumps; }

        delay(1);
    }
}

script METROID_OPEN_CLIENT OPEN clientside
{
    if (M_GetCVar("met_cl_runbefore") != METROID_CL_CVAR_VERSION)
    {
        M_SetCVar("met_cl_runbefore", METROID_CL_CVAR_VERSION);
        M_DefaultCVar("met_cl_noeffects",           0);
        M_DefaultCVar("met_cl_nosiren",             0);
        M_DefaultCVar("met_cl_nomorphcamera",       0);
        M_DefaultCVar("met_cl_pickupmusic",         0);
        M_DefaultCVar("met_cl_nometroidpickups",    0);
        M_DefaultCVar("met_cl_doomhealth",          0);
        M_DefaultCVar("met_cl_chromabeamdensity",   0);
        M_DefaultCVar("met_cl_custommissilecharge", 0);
        M_DefaultCVar("met_cl_showallbeams",        0);
        M_DefaultCVar("met_cl_moremessages",        0);
        
        // [ijon] Deprecated CVar, remove from premises
        M_RemoveCVar("met_cl_morphcamera");
        // [TE13] Doesn't work due to A_GiveToTargetWonkiness, temporarily deprecated.
        //M_RemoveCVar("met_cl_hitindicator");
    }
}


// MORPH BALL CAMERA SHIT
// ========================

script METROID_MORPHCAMERA (int dist, int height) CLIENTSIDE
{
    if (PlayerNumber() != ConsolePlayerNumber()) { terminate; }
    int pNum = PlayerNumber();
    int tid = UniqueTID(40000, 50000);
    int fuckyocamera = 0;
    int fuckyoEVERYTHING = 0;

    while (!fuckyoEVERYTHING)
    {
        fuckyocamera = isDead(0) || !!M_GetCVar("met_cl_nomorphcamera");
        fuckyoEVERYTHING = !CheckInventory("PlayerMorphCamera") || (PlayerNumber() == -1);
    
        if (fuckyocamera || fuckyoEVERYTHING)
        {
            if (ThingCount(0, tid)) { Thing_Remove(tid); }
        }
        else
        {
            SetChasecam(dist, height, tid, 1);
        }

        Delay(1);
    }
}

// ENTER EXIT DEATH RESPAWN SHIT
// ========================

script METROID_UNLOADING UNLOADING
{
    SetPlayerProperty(0,0,PROP_TOTALLYFROZEN);
    SetActorProperty(0,APROP_SPEED,1.00);

    // Adjusts inventory
    TakeInventory("BorphMallAcquired",999);
    TakeInventory("PowerBeamChargeLevel",999);
    TakeInventory("PowerBeamCharged",999);
    TakeInventory("PowerBeamIdle",999);
    TakeInventory("Bombs",999);
    TakeInventory("BoostBallCount",999);
    TakeInventory("ETNotInThisLevel",999);
    TakeInventory("PBNotInThisLevel",999);
    TakeInventory("SMNotInThisLevel",999);
    TakeInventory("IceBeamChilled",999);
    TakeInventory("MissileChargeLevel",999);
    TakeInventory("MissileCharged",999);
    TakeInventory("SynthFireRight",999);
    TakeInventory("SpeedBooster",999);
    TakeInventory("SpeedBoosterPrepare",999);
    TakeInventory("SpeedBoostCounter",999);
    TakeInventory("SpeedBoosterActive",999);
    TakeInventory("SpeedWalker",999);
    TakeInventory("SpeedWalkerPrepare",999);
    TakeInventory("TheReturnOfSamusReturns",999);
    TakeInventory("BallBoosting",1);
	TakeInventory("ShinesparkCharge",0x7FFFFFFF);
    GiveInventory("BombCount",999);
    TakeInventory("PlayerMorphCamera", 0x7FFFFFFF);
}

script METROID_DEATH DEATH
{
    if (CheckInventory("BorphMallAcquired")) { TakeInventory("PlayerMorphCamera", 0x7FFFFFFF); }
    ACS_ExecuteAlways(589,0);
}

script METROID_DISCONNECT (int pln) DISCONNECT
{
    // [ijon] This being 1 was causing dudes to not be able to missile on spec/rejoin.
    MissileCheckStates[pln] = 0;
}

script METROID_ENTER ENTER
{
    int barhp;
	int aarmor;
    int israwenergy, wasrawenergy;
	int israwenergy2, wasrawenergy2;
    int pln = PlayerNumber();
    int frozen = 0, wasfrozen;
    int jumpz = GetActorProperty(0, APROP_JumpZ);
    int frozenjumpz = FixedDiv(jumpz, oldsqrt(2.0));
    int infinite;
    int i;

    Select_InMenu[pln] = 0;

    SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
    SetActorProperty(0, APROP_INVULNERABLE, 0);

    if (GameType () == GAME_TITLE_MAP) 
	{ 
		terminate; 
	}

    if (CheckInventory("MorphBallDeactivate") == 1) 
	{ 
		GiveInventory("MorphBallActivate", 1); 
		TakeInventory("MorphBallDeactivate", 1); 
		TakeInventory("PlayerMorphCamera", 0x7FFFFFFF); 
	}

    if (isFreeForAll() || isTeamgame()) 
	{
		//SetAmmoCapacity("MissileAmmo",10); 
		//GiveInventory("MissileAmmo",5); 
		//GiveInventory("MissileTankAcquired",1); 
	
	}
	
    if (isSinglePlayer() || isCoop()) 
	{ 
		if (CheckInventory("CoopModeOn") == 0) 
		{ 
			GiveInventory("CoopModeOn",1); 
			SetActorState(0,"CoopModeOn"); 
			SetAmmoCapacity("MissileAmmo",0); 
			SetAmmoCapacity("PowerBombAmmo",0); 
		}
	}

    ACS_ExecuteAlways(352,0,0,0); //Activates Space Jump mode.
    ACS_ExecuteAlways(351,0,0,0); //Yes, this one too.

    if (!CheckInventory("InGame")) //We aren't in-game yet.
	{
		//Metroid Loaded CVAR Shit.
        if (M_GetCVar("met_loaded") == 1) //All weaponry
        {
            if (M_GetCVar("met_doomcannon") == 1) //Spawn the Doom Cannon.
			{ 
				GiveInventory("DoomCannon",1); 
				GiveInventory("DoomCannonAcquired",1); 
			}
			
            if (M_GetCVar("met_skulltagweapons") == 1) //Spawn the Google Chrome beam.
			{ 
				GiveInventory("ChromaBeam",1); 
				GiveInventory("ChromaStormAcquired",1);
			}
			
            GiveInventory("SpazerBeam",1); 
			GiveInventory("SpazerBeamAcquired",1);
            GiveInventory("PlasmaBeam",1); 
			GiveInventory("PlasmaBeamAcquired",1);
            GiveInventory("WaveBeam",1); 
			GiveInventory("WaveBeamAcquired",1);
            GiveInventory("IceBeam",1); 
			GiveInventory("IceBeamAcquired",1);
            GiveInventory("LongBeam",1); 
			GiveInventory("LongBeamAcquired",1);
		    GiveInventory("ChargeBeamAcquired",1);
			GiveInventory("MorphBallActivate",1); 
			GiveInventory("MorphBallAcquired",1);
			GiveInventory("BombPickup",1);
			GiveInventory("BombsAcquired",1);
			GiveInventory("PowerMissilePickup",1);
			GiveInventory("WideShotPickup",1);
			GiveInventory("SolarFlarePickup",1);
			GiveInventory("WaveMissilePickup",1);
			GiveInventory("IceSpreaderPickup",1);
			GiveInventory("NovaFlashPickup",1);
			GiveInventory("ChainsawBeamPickup",1);
			GiveInventory("HyperBeamPickup",1);
        }

        if (M_GetCVar("met_loaded") == 2) 
		{ 
			SetAmmoCapacity("MissileAmmo",10); 
			GiveInventory("MissileAmmo",10); 
			GiveInventory("MissileTankAcquired",2); 
		}

        if (M_GetCVar("met_loaded") == 3) 
		{ 
			SetAmmoCapacity("MissileAmmo",20); 
			GiveInventory("MissileAmmo",20); 
			GiveInventory("MissileTankAcquired",2); 
		}

        if (M_GetCVar("met_loaded") == 4)
        {
            if (M_GetCVar("met_doomcannon") == 1) 
			{ 
				GiveInventory("DoomCannon",1); 
				GiveInventory("DoomCannonAcquired",1); 
			}
			
            if (M_GetCVar("met_skulltagweapons") == 1) 
			{ 
				GiveInventory("ChromaBeam",1); 
				GiveInventory("ChromaStormAcquired",1); 
			}
			
            GiveInventory("SpazerBeam",1); 
			GiveInventory("SpazerBeamAcquired",1);
            GiveInventory("PlasmaBeam",1); 
			GiveInventory("PlasmaBeamAcquired",1);
            GiveInventory("WaveBeam",1); 
			GiveInventory("WaveBeamAcquired",1);
            GiveInventory("IceBeam",1); 
			GiveInventory("IceBeamAcquired",1);
            GiveInventory("LongBeam",1); 
			GiveInventory("LongBeamAcquired",1);
			GiveInventory("ChargeBeamAcquired",1);
			GiveInventory("MorphBallActivate",1); 
			GiveInventory("MorphBallAcquired",1);
            SetAmmoCapacity("MissileAmmo",20); 
			GiveInventory("MissileAmmo",20); 
			GiveInventory("MissileTankAcquired",2);
        }

        if (M_GetCVar("met_loaded") == 5)
        {
            if (M_GetCVar("met_doomcannon") == 1)
			{ 
				GiveInventory("DoomCannon",1); 
				GiveInventory("DoomCannonAcquired",1); 
			}
			
            if (M_GetCVar("met_skulltagweapons") == 1) 
			{ 
				GiveInventory("ChromaBeam",1); 
				GiveInventory("ChromaStormAcquired",1); 
			}
			
            GiveInventory("SpazerBeam",1); 
			GiveInventory("SpazerBeamAcquired",1);
            GiveInventory("PlasmaBeam",1); 
			GiveInventory("PlasmaBeamAcquired",1);
            GiveInventory("WaveBeam",1); 
			GiveInventory("WaveBeamAcquired",1);
            GiveInventory("IceBeam",1); 
			GiveInventory("IceBeamAcquired",1);
            GiveInventory("LongBeam",1); 
			GiveInventory("LongBeamAcquired",1);
			GiveInventory("ChargeBeamAcquired",1);
			GiveInventory("MorphBallActivate",1); 
			GiveInventory("MorphBallAcquired",1);
            SetAmmoCapacity("MissileAmmo",20); 
			GiveInventory("MissileAmmo",20); 
			GiveInventory("MissileTankAcquired",2); 
            SetAmmoCapacity("SuperMissileAmmo",4); 
			GiveInventory("SuperMissileAmmo",4); 
			GiveInventory("SuperMissileAcquired",1); 
            SetAmmoCapacity("PowerBombAmmo",2); 
			GiveInventory("PowerBombAmmo",2); 
			GiveInventory("PowerBombAcquired",1);
        }

        if (M_GetCVar("met_loaded") == 6)
        {
            if (M_GetCVar("met_doomcannon") == 1) 
			{ 
				GiveInventory("DoomCannon",1); 
				GiveInventory("DoomCannonAcquired",1); 
			}
			
            if (M_GetCVar("met_skulltagweapons") == 1) 
			{ 
				GiveInventory("ChromaBeam",1); 
				GiveInventory("ChromaStormAcquired",1); }
				GiveInventory("SpazerBeam",1); 
				GiveInventory("SpazerBeamAcquired",1);
				GiveInventory("PlasmaBeam",1); 
				GiveInventory("PlasmaBeamAcquired",1);
				GiveInventory("WaveBeam",1); 
				GiveInventory("WaveBeamAcquired",1);
				GiveInventory("IceBeam",1); 
				GiveInventory("IceBeamAcquired",1);
				GiveInventory("LongBeam",1); 
				GiveInventory("LongBeamAcquired",1);
				GiveInventory("ChargeBeamAcquired",1);
				GiveInventory("MorphBallActivate",1); 
				GiveInventory("MorphBallAcquired",1);
				SetAmmoCapacity("MissileAmmo",20); 
				GiveInventory("MissileAmmo",20); 
				GiveInventory("MissileTankAcquired",2); 
				SetAmmoCapacity("SuperMissileAmmo",4); 
				GiveInventory("SuperMissileAmmo",4); 
				GiveInventory("SuperMissileAcquired",1); 
				SetAmmoCapacity("PowerBombAmmo",2); 
				GiveInventory("PowerBombAmmo",2); 
				GiveInventory("PowerBombAcquired",1); 
				GiveInventory("SpeedBoosterAcquired",1);
				GiveInventory("ChargeComboAcquired",1);
				GiveInventory("SpaceJumpAcquired",1); 
				GiveInventory("CanSpaceJump",1);
				GiveInventory("MorphBallAcquired",1); 
				GiveInventory("MorphBallActivate",1);
				GiveInventory("VariaSuitAcquired",1); 
				GiveInventory("IHateHeat",1);
			}
		//Energy Tank CVars - How many tanks to start with.
        if (M_GetCVar("met_startingtanks") == 1) 
		{ 
			GiveInventory("EnergyTankAcquired",1); 
			SetActorProperty(0,APROP_SPAWNHEALTH,200); 
			SetActorProperty(0,APROP_HEALTH,200); 
		}
		
        if (M_GetCVar("met_startingtanks") == 2) 
		{ 
			GiveInventory("EnergyTankAcquired",2); 
			SetActorProperty(0,APROP_SPAWNHEALTH,300); 
			SetActorProperty(0,APROP_HEALTH,300); 
		}
		
        if (M_GetCVar("met_startingtanks") == 3) 
		{ 
			GiveInventory("EnergyTankAcquired",3); 
			SetActorProperty(0,APROP_SPAWNHEALTH,400); 
			SetActorProperty(0,APROP_HEALTH,400); 
		}
		
        if (M_GetCVar("met_startingtanks") == 4) 
		{ 
			GiveInventory("EnergyTankAcquired",4); 
			SetActorProperty(0,APROP_SPAWNHEALTH,500); 
			SetActorProperty(0,APROP_HEALTH,500); 
		}
		
        if (M_GetCVar("met_startingtanks") == 5) 
		{ 
			GiveInventory("EnergyTankAcquired",5); 
			SetActorProperty(0,APROP_SPAWNHEALTH,600); 
			SetActorProperty(0,APROP_HEALTH,600); 
		}
		
        if (M_GetCVar("met_startingtanks") == 6) 
		{ 
			GiveInventory("EnergyTankAcquired",6); 
			SetActorProperty(0,APROP_SPAWNHEALTH,700); 
			SetActorProperty(0,APROP_HEALTH,700); 
		}
		
        if (M_GetCVar("met_startingtanks") == 7) 
		{ 
			GiveInventory("EnergyTankAcquired",7); 
			SetActorProperty(0,APROP_SPAWNHEALTH,800); 
			SetActorProperty(0,APROP_HEALTH,800); 
		}
		
        if (M_GetCVar("met_startingtanks") == 8) 
		{ 
			GiveInventory("EnergyTankAcquired",8); 
			SetActorProperty(0,APROP_SPAWNHEALTH,900);
			SetActorProperty(0,APROP_HEALTH,900); 
		}
		
        if (M_GetCVar("met_startingtanks") == 9) 
		{ 
			GiveInventory("EnergyTankAcquired",9); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1000); 
			SetActorProperty(0,APROP_HEALTH,1000); 
		}
		
        if (M_GetCVar("met_startingtanks") == 10) 
		{ 
			GiveInventory("EnergyTankAcquired",10); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1100); 
			SetActorProperty(0,APROP_HEALTH,1100); 
		}
		
		if (M_GetCVar("met_startingtanks") == 11) 
		{ 
			GiveInventory("EnergyTankAcquired",11); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1200); 
			SetActorProperty(0,APROP_HEALTH,1200); 
		}
		
		if (M_GetCVar("met_startingtanks") == 12) 
		{ 
			GiveInventory("EnergyTankAcquired",12); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1300); 
			SetActorProperty(0,APROP_HEALTH,1300); 
		}
		
		if (M_GetCVar("met_startingtanks") == 13) 
		{ 
			GiveInventory("EnergyTankAcquired",13); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1400); 
			SetActorProperty(0,APROP_HEALTH,1400); 
		}
		
		if (M_GetCVar("met_startingtanks") == 14) 
		{ 
			GiveInventory("EnergyTankAcquired",14); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1500); 
			SetActorProperty(0,APROP_HEALTH,1500); 
		}
		
		if (M_GetCVar("met_startingtanks") == 15) 
		{ 
			GiveInventory("EnergyTankAcquired",15); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1600); 
			SetActorProperty(0,APROP_HEALTH,1600); 
		}
		
		if (M_GetCVar("met_startingtanks") == 16) 
		{ 
			GiveInventory("EnergyTankAcquired",16); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1700); 
			SetActorProperty(0,APROP_HEALTH,1700); 
		}
		
		if (M_GetCVar("met_startingtanks") == 17) 
		{ 
			GiveInventory("EnergyTankAcquired",17); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1800); 
			SetActorProperty(0,APROP_HEALTH,1800); 
		}
		
		if (M_GetCVar("met_startingtanks") == 18) 
		{ 
			GiveInventory("EnergyTankAcquired",18); 
			SetActorProperty(0,APROP_SPAWNHEALTH,1900); 
			SetActorProperty(0,APROP_HEALTH,1900); 
		}
		
		if (M_GetCVar("met_startingtanks") == 19) 
		{ 
			GiveInventory("EnergyTankAcquired",19); 
			SetActorProperty(0,APROP_SPAWNHEALTH,2000); 
			SetActorProperty(0,APROP_HEALTH,2000); 
		}
		
		if (M_GetCVar("met_startingtanks") == 20) 
		{ 
			GiveInventory("EnergyTankAcquired",20); 
			SetActorProperty(0,APROP_SPAWNHEALTH,2100); 
			SetActorProperty(0,APROP_HEALTH,2100); 
		}
		
		//[R4L] Samus Fanfare script - I may try to get this working again someday
		/*if (GameType () != GAME_TITLE_MAP && isSinglePlayer())
        {		
				LocalAmbientSound("system/samusappear",127);
				Thing_Stop(0);
				SetPlayerProperty(0, 1, PROP_TOTALLYFROZEN);
				SetActorProperty(0, APROP_INVULNERABLE, 1);
				SetActorProperty(0, APROP_RENDERSTYLE, STYLE_None);
				//ACS_ExecuteAlways(METROID_DECORATECLIENT,0,3,0,0);
				SetMusicVolume(0.0);
				LocalSetMusic("M_NOTHNG");
				for (int f = 0; f < 180; f++)
                {
                    if (keyDown(BT_USE)) 
					{
				    LocalAmbientSound("silence", 127);
					SetActorProperty(0, APROP_RENDERSTYLE, STYLE_Normal);
					//FadeTo(0, 0, 0, 0.0, 1.0);
					SetMusicVolume(1.0);
					LocalSetMusic("*");
					SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
					SetActorProperty(0, APROP_INVULNERABLE, 0);
					GiveInventory("InGame", 1);
					continue;
					}		
                Delay(1);
				}
				FadeTo(0, 0, 0, 1.0, 1.0);
				Delay(40);
				SetActorProperty(0, APROP_RENDERSTYLE, STYLE_Normal);
				FadeTo(0, 0, 0, 0.0, 1.0);
				SetMusicVolume(1.0);
				LocalSetMusic("*");
				SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
				SetActorProperty(0, APROP_INVULNERABLE, 0);
				//ACS_ExecuteAlways(METROID_DECORATECLIENT,0,4,0,0);
			}*/
	}
    GiveInventory("InGame",1); //Token that says we're playing and displays the HUD.

    while (!(ClassifyActor(0) & ACTOR_WORLD)) //While we are a player and in the world.
    {
		
		//health bar shit
        if (GetActorProperty(0,APROP_Health) > 100) { GiveInventory("HealthOver100",1); } else { if (CheckInventory("HealthOver100") == 1) { TakeInventory("HealthOver100",1); }}
        if (GetActorProperty(0,APROP_Health) > 200) { GiveInventory("HealthOver200",1); } else { if (CheckInventory("HealthOver200") == 1) { TakeInventory("HealthOver200",1); }}
        if (GetActorProperty(0,APROP_Health) > 300) { GiveInventory("HealthOver300",1); } else { if (CheckInventory("HealthOver300") == 1) { TakeInventory("HealthOver300",1); }}
        if (GetActorProperty(0,APROP_Health) > 400) { GiveInventory("HealthOver400",1); } else { if (CheckInventory("HealthOver400") == 1) { TakeInventory("HealthOver400",1); }}
        if (GetActorProperty(0,APROP_Health) > 500) { GiveInventory("HealthOver500",1); } else { if (CheckInventory("HealthOver500") == 1) { TakeInventory("HealthOver500",1); }}
        if (GetActorProperty(0,APROP_Health) > 600) { GiveInventory("HealthOver600",1); } else { if (CheckInventory("HealthOver600") == 1) { TakeInventory("HealthOver600",1); }}
        if (GetActorProperty(0,APROP_Health) > 700) { GiveInventory("HealthOver700",1); } else { if (CheckInventory("HealthOver700") == 1) { TakeInventory("HealthOver700",1); }}
        if (GetActorProperty(0,APROP_Health) > 800) { GiveInventory("HealthOver800",1); } else { if (CheckInventory("HealthOver800") == 1) { TakeInventory("HealthOver800",1); }}
        if (GetActorProperty(0,APROP_Health) > 900) { GiveInventory("HealthOver900",1); } else { if (CheckInventory("HealthOver900") == 1) { TakeInventory("HealthOver900",1); }}
        if (GetActorProperty(0,APROP_Health) > 1000) { GiveInventory("HealthOver1000",1); } else { if (CheckInventory("HealthOver1000") == 1) { TakeInventory("HealthOver1000",1); }}
		if (GetActorProperty(0,APROP_Health) > 1100) { GiveInventory("HealthOver1100",1); } else { if (CheckInventory("HealthOver1100") == 1) { TakeInventory("HealthOver1100",1); }}
		if (GetActorProperty(0,APROP_Health) > 1200) { GiveInventory("HealthOver1200",1); } else { if (CheckInventory("HealthOver1200") == 1) { TakeInventory("HealthOver1200",1); }}
		if (GetActorProperty(0,APROP_Health) > 1300) { GiveInventory("HealthOver1300",1); } else { if (CheckInventory("HealthOver1300") == 1) { TakeInventory("HealthOver1300",1); }}
		if (GetActorProperty(0,APROP_Health) > 1400) { GiveInventory("HealthOver1400",1); } else { if (CheckInventory("HealthOver1400") == 1) { TakeInventory("HealthOver1400",1); }}
		if (GetActorProperty(0,APROP_Health) > 1500) { GiveInventory("HealthOver1500",1); } else { if (CheckInventory("HealthOver1500") == 1) { TakeInventory("HealthOver1500",1); }}
		if (GetActorProperty(0,APROP_Health) > 1600) { GiveInventory("HealthOver1600",1); } else { if (CheckInventory("HealthOver1600") == 1) { TakeInventory("HealthOver1600",1); }}
		if (GetActorProperty(0,APROP_Health) > 1700) { GiveInventory("HealthOver1700",1); } else { if (CheckInventory("HealthOver1700") == 1) { TakeInventory("HealthOver1700",1); }}
		if (GetActorProperty(0,APROP_Health) > 1800) { GiveInventory("HealthOver1800",1); } else { if (CheckInventory("HealthOver1800") == 1) { TakeInventory("HealthOver1800",1); }}
		if (GetActorProperty(0,APROP_Health) > 1900) { GiveInventory("HealthOver1900",1); } else { if (CheckInventory("HealthOver1900") == 1) { TakeInventory("HealthOver1900",1); }}
		if (GetActorProperty(0,APROP_Health) > 2000) { GiveInventory("HealthOver2000",1); } else { if (CheckInventory("HealthOver2000") == 1) { TakeInventory("HealthOver2000",1); }}
		if (GetActorProperty(0,APROP_Health) > 2100) { GiveInventory("HealthOver2100",1); } else { if (CheckInventory("HealthOver2100") == 1) { TakeInventory("HealthOver2100",1); }}
		
        if (GetActorProperty(0, APROP_Health) >= ((CheckInventory("EnergyTankAcquired")+1) * 100)) { barhp = GetActorProperty(0, APROP_Health); }
        else { barhp = GetActorProperty(0, APROP_Health) % 100; }

        TakeInventory("PlayerTotalHealth", 0x7FFFFFFF);
        GiveInventory("PlayerTotalHealth", oldmin(barhp, 99));

        if (isDead(0)) { break; }
		
        // Spacejump shit
        if (M_GetCVar("met_spacejump") == 1 || CheckInventory("CoopModeOn") == 0) { if (CheckInventory("CanSpaceJump") == 0) { GiveInventory("CanSpaceJump",1); }}
        else if (M_GetCVar("met_spacejump") == 0) { if (CheckInventory("SpaceJumpAcquired") == 0) { if (CheckInventory("CanSpaceJump") == 1) { TakeInventory("CanSpaceJump",1); }}}

        // Nomorph shit
        if (M_GetCVar("met_nomorph") == 1) { if (CheckInventory("DisableMorph") == 0) { GiveInventory("DisableMorph",1); }}
        else if (M_GetCVar("met_nomorph") == 0) { if (CheckInventory("DisableMorph") == 1) { TakeInventory("DisableMorph",1); }}

        // Clientside shit
        if (array_custmischarg[pln]) { GiveInventory("CustomMissileCharge", 1); }
        else { TakeInventory("CustomMissileCharge", 0x7FFFFFFF); }

        if (array_doomHealth[pln]) { GiveInventory("DoomHealthCounter", 1); }
        else { TakeInventory("DoomHealthCounter", 0x7FFFFFFF); }
        
        if (array_runrunruu[pln]) { GiveInventory("AlwaysRunIsOn", 1); }
        else { TakeInventory("AlwaysRunIsOn", 0x7FFFFFFF); }
        
        if (array_metpick[pln]) { GiveInventory("NoMetroidPickupSystem", 1); }
        else { TakeInventory("NoMetroidPickupSystem", 0x7FFFFFFF); }
        
		//if (CheckInventory("HiJumpAcquired") == 1) { SetPlayerProperty(0, APROP_JumpZ, ); }
		
        // Doesn't work. Need to figure out why.
        //if (array_hitindic[pln]) { GiveInventory("MetroidHitIndicatorActive", 1); }
        //else { TakeInventory("MetroidHitIndicatorActive", 0x7FFFFFFF); }

        // Armor shit
        oarmor = armor;
        armor = CheckInventory("Armor");
		aarmor = GetArmorType("RawEnergyShield", pln);

        wasrawenergy = israwenergy;
		wasrawenergy2 = israwenergy2;
        israwenergy = !!GetArmorType("RawEnergyShield", pln);
		israwenergy2 = !!GetArmorType("RawEnergyShield2", pln);

        if (((oarmor > armor) && (wasrawenergy)) || ((oarmor > armor) && (wasrawenergy2)))
        {
			//if ((israwenergy < 1) || (israwenergy2 < 1)) {
			if ((oarmor) || (armor) > 0) {
			GiveInventory("GotArmor", 1);
			}
			if (CheckInventory("GotArmor") > 0) { TakeInventory("GotArmor", 0x7FFFFFFF); }
            ActivatorSound("rawenergy/shieldhit", 127);
            FadeRange(255, 255, 255, oldmin(0.5, (oarmor - armor) * 0.015), 0, 0, 0, 0.0, oldmin(35.0, 1.5 * (oarmor - armor)) / 35);
        }

        // Charge combo shit
        /*if (CheckInventory("ChargeComboAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("SynthFireRight", 1); }
        else { TakeInventory("SynthFireRight", 0x7FFFFFFF); }
        }*/
		
		if (CheckInventory("PowerMissileAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("PMSynthFireRight", 1); }
        else { TakeInventory("PMSynthFireRight", 0x7FFFFFFF); }
        }
		
		if (CheckInventory("WaveMissileAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("WMSynthFireRight", 1); }
        else { TakeInventory("WMSynthFireRight", 0x7FFFFFFF); }
        }

		if (CheckInventory("SolarFlareAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("SFSynthFireRight", 1); }
        else { TakeInventory("SFSynthFireRight", 0x7FFFFFFF); }
        }
		
		if (CheckInventory("IceSpreaderAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("ISSynthFireRight", 1); }
        else { TakeInventory("ISSynthFireRight", 0x7FFFFFFF); }
        }
		
		if (CheckInventory("NovaFlashAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("NFSynthFireRight", 1); }
        else { TakeInventory("NFSynthFireRight", 0x7FFFFFFF); }
        }
		
		if (CheckInventory("WideShotAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("WSSynthFireRight", 1); }
        else { TakeInventory("WSSynthFireRight", 0x7FFFFFFF); }
        }
		
		if (CheckInventory("HyperBeamAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("HBSynthFireRight", 1); }
        else { TakeInventory("HBSynthFireRight", 0x7FFFFFFF); }
        }

		if (CheckInventory("ChainsawBeamAcquired") == 1)
        {
        if (keyDown(BT_ALTATTACK)) { GiveInventory("CBSynthFireRight", 1); }
        else { TakeInventory("CBSynthFireRight", 0x7FFFFFFF); }
        }

        // Crouching shit
        if (keyDown(BT_CROUCH)) { GiveInventory("WhyCantMetroidCrawl",1); }
        else { TakeInventory("WhyCantMetroidCrawl", 0x7FFFFFFF); }

        // FREEZE, MOFUCKA
        if (!CheckInventory("BorphMallAcquired"))
        {
            wasfrozen = frozen;
            frozen = CheckInventory("IceBeamChilled");

            if (!wasfrozen && frozen) { SetActorProperty(0, APROP_JumpZ, frozenjumpz); }
            if (!frozen && wasfrozen) { SetActorProperty(0, APROP_JumpZ, jumpz); }
        }

        // Clear pickup status
        for (i = 0; i < PICKUPTYPES; i++) { GotBigPickup[pln][i] = 0; }


        // Global variables
        if (isSinglePlayer())
        {
            if (CheckInventory("SpazerBeamAcquired") == 1) { GotSpazer = 1; }
            if (CheckInventory("PlasmaBeamAcquired") == 1) { GotPlasma = 1; }
            if (CheckInventory("WaveBeamAcquired") == 1) { GotWave = 1; }
            if (CheckInventory("IceBeamAcquired") == 1) { GotIce = 1; }
            if (CheckInventory("LongBeamAcquired") == 1) { GotLong = 1; }
            if (CheckInventory("DoomCannonAcquired") == 1) { GotDoom = 1; }
			if (CheckInventory("ChromaStormAcquired") == 1) { GotChroma = 1; }
            if (CheckInventory("ChargeComboAcquired") == 1) { GotCharge = 1; }
			if (CheckInventory("MorphBallAcquired") == 1) { GotMorph = 1; }
			if (CheckInventory("SpeedBoosterAcquired") == 1) { GotSpeed = 1; }
			if (CheckInventory("SpaceJumpAcquired") == 1) { GotSpace = 1; }
			if (CheckInventory("VariaSuitAcquired") == 1) { GotVaria = 1; }
			if (CheckInventory("GravitySuitAcquired") == 1) { GotGravity = 1; }
			if (CheckInventory("ChargeBeamAcquired") == 1) { GotChargeBeam = 1; }
			if (CheckInventory("MissileTankAcquired") == 1) { GotMissiles = 1; }
			if (CheckInventory("PowerBombAcquired") == 1) { GotPowerBomb = 1; }
			if (CheckInventory("PowerMissileAcquired") == 1) { GotPowerMissile = 1; }
			if (CheckInventory("WaveMissileAcquired") == 1) { GotWaveMissile = 1; }
			if (CheckInventory("SolarFlareAcquired") == 1) { GotSolarFlare = 1; }
			if (CheckInventory("IceSpreaderAcquired") == 1) { GotIceSpreader = 1; }
			if (CheckInventory("NovaFlashAcquired") == 1) { GotNovaFlash = 1; }
			if (CheckInventory("WideShotAcquired") == 1) { GotWideShot = 1; }
			if (CheckInventory("HyperBeamAcquired") == 1) { GotHyperBeam = 1;}
			if (CheckInventory("ChainsawBeamAcquired") == 1) { GotChainsawBeam = 1; }
			if (CheckInventory("GotArmor") > 0) { GotArmor = 1; } else { GotArmor = 0; }
			if (CheckInventory("BombsAcquired") == 1) { GotBombs = 1; }
			if (CheckInventory("BoostBallAcquired") == 1) { GotBoostBall = 1; }
			if (CheckInventory("HiJumpAcquired") == 1) { GotHiJump = 1; }
        }
        // You have no idea how much I'm trying to avoid GotMilk = 1;
        // WAIT SHIT I JUST DID IT

        // Infinite ammo item for DECORATE
        infinite = GetCVar("sv_infiniteammo");

        if (infinite && !CheckInventory("HasInfiniteAmmo")) { GiveInventory("HasInfiniteAmmo", 1); }
        else if (!infinite && CheckInventory("HasInfiniteAmmo")) { TakeInventory("HasInfiniteAmmo", 0x7FFFFFFF); }

        // Did we "give weapons"?

        if (CheckInventory("MetroodIDKFAHack"))
        {
            RaiseAmmoCapacity("MissileAmmo",      255, 1);
            RaiseAmmoCapacity("SuperMissileAmmo", 50,  1);
            RaiseAmmoCapacity("PowerBombAmmo",    10,   1);
			GiveInventory("PlayerTotalMissiles", 255);
			GiveInventory("PlayerTotalSuperMissiles", 50);
			GiveInventory("PlayerTotalPowerBombs", 10);

            if (CheckInventory("BasicArmor") && CheckInventory("MetroodIDKFAHack_Ammo"))
            {
                TakeInventory("BasicArmor", 0x7FFFFFFF);
                GiveInventory("RawEnergy", 1);
                TakeInventory("MetroodIDKFAHack_Ammo", 0x7FFFFFFF);
            }

			if (!CheckInventory("EnergyTankAcquired")) { GiveInventory("EnergyTankAcquired", 1); }
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
			GiveInventory("EnergyTankPickup", 1);
            if (!CheckInventory("SuperMissileAcquired")) { GiveInventory("SuperMissileAcquired", 1); }
            if (!CheckInventory("PowerBombAcquired")) { GiveInventory("PowerBombAcquired", 1); }
            if (!CheckInventory("SpazerBeamAcquired")) { GiveInventory("SpazerBeamAcquired", 1); }
            if (!CheckInventory("PlasmaBeamAcquired")) { GiveInventory("PlasmaBeamAcquired", 1); }
            if (!CheckInventory("WaveBeamAcquired")) { GiveInventory("WaveBeamAcquired", 1); }
            if (!CheckInventory("IceBeamAcquired")) { GiveInventory("IceBeamAcquired", 1); }
            if (!CheckInventory("LongBeamAcquired")) { GiveInventory("LongBeamAcquired", 1); }
			if (!CheckInventory("DoomCannonAcquired")) { GiveInventory("DoomCannonAcquired", 1); }
			if (GetCVar("met_skulltagweapons") > 0) { if (!CheckInventory("ChromaStormAcquired")) { GiveInventory("ChromaStormAcquired", 1); GiveInventory("ChromaBeam", 1); } }
			if (GetCVar("met_doomcannon") > 0) { if (!CheckInventory("DoomCannon")) { GiveInventory("DoomCannonAcquired", 1); GiveInventory("DoomCannon", 1); } }
			if (!CheckInventory("MorphBallAcquired")) { GiveInventory("MorphBallAcquired", 1); }
			if (!CheckInventory("HiJumpAcquired")) { GiveInventory("HiJumpAcquired", 1); } //GiveInventory("HiJump", 1); }
			if (!CheckInventory("SpaceJumpAcquired")) { GiveInventory("SpaceJumpAcquired", 1); GiveInventory("CanSpaceJump", 1); }
			if (!CheckInventory("SpeedBoosterAcquired")) { GiveInventory("SpeedBoosterAcquired", 1); }
			if (!CheckInventory("BoostBallAcquired")) { GiveInventory("BoostBallAcquired", 1); }
			if (!CheckInventory("BombAcquired")) { GiveInventory("BombsAcquired", 1); }
			//if (!CheckInventory("VariaSuitAcquired")) { GiveInventory("VariaSuitAcquired", 1); GiveInventory("IHateHeat", 1); }
			if (!CheckInventory("GravitySuitAcquired")) { GiveInventory("GravitySuitAcquired", 1); GiveInventory("GravityShield", 1); }
			if (!CheckInventory("ChargeBeamAcquired")) { GiveInventory("ChargeBeamAcquired", 1); }
			if (!CheckInventory("GrappleBeamAcquired")) { GiveInventory("GrappleBeamAcquired", 1); }
			if (CheckInventory("PowerBombAcquired") < 1) { GiveInventory("PowerBombAcquired", 2); }
			if (CheckInventory("MissileTankAcquired") < 1) { GiveInventory("MissileTankAcquired", 2); }
			if (!CheckInventory("PowerMissileAcquired")) { GiveInventory("PowerMissileAcquired", 1); }
			if (!CheckInventory("WideShotAcquired")) { GiveInventory("WideShotAcquired", 1); }
			if (!CheckInventory("WaveMissileAcquired")) { GiveInventory("WaveMissileAcquired", 1); }
			if (!CheckInventory("SolarFlareAcquired")) { GiveInventory("SolarFlareAcquired", 1); }
			if (!CheckInventory("NovaFlashAcquired")) { GiveInventory("NovaFlashAcquired", 1); }
			if (!CheckInventory("HyperBeamAcquired")) { GiveInventory("HyperBeamAcquired", 1); }
			if (!CheckInventory("IceSpreaderAcquired")) { GiveInventory("IceSpreaderAcquired", 1); }
			if (GetCVar("met_doomcannon") > 0) { if (!CheckInventory("ChainsawBeamAcquired")) { GiveInventory("ChainsawBeamAcquired", 1); } }
            Print(s:"You may want to use the metroid_loaded cvar in the future instead, this might break things.");

            TakeInventory("MetroodIDKFAHack", 0x7FFFFFFF);
        }

        if (CheckInventory("MetroodIDKFAHack_Ammo"))
        {
            TakeInventory("MetroodIDKFAHack_Ammo", 0x7FFFFFFF);
        }

        if (GameType() != GAME_SINGLE_PLAYER && GameType() != GAME_NET_COOPERATIVE && GameType() != GAME_NET_DEATHMATCH && GameType() != GAME_TITLE_MAP)
        // Could probably have just done if (GameType() > 3), but I'm sure if any of Zandro's gamemodes go under 0.
        {
            if (PlayerTeam() == 0) { GiveInventory("IsOnTeam0",1); TakeInventory("IsOnTeam1",1); TakeInventory("IsOnTeam2",1); TakeInventory("IsOnTeam3",1); }
            if (PlayerTeam() == 1) { TakeInventory("IsOnTeam0",1); GiveInventory("IsOnTeam1",1); TakeInventory("IsOnTeam2",1); TakeInventory("IsOnTeam3",1); }
            if (PlayerTeam() == 2) { TakeInventory("IsOnTeam0",1); TakeInventory("IsOnTeam1",1); GiveInventory("IsOnTeam2",1); TakeInventory("IsOnTeam3",1); }
            if (PlayerTeam() == 3) { TakeInventory("IsOnTeam0",1); TakeInventory("IsOnTeam1",1); TakeInventory("IsOnTeam2",1); GiveInventory("IsOnTeam3",1); }
        }

        Delay(1);
    }
}

// MORPH BALL SHIT
// =================
script METROID_MORPHBALL (int morphshit)
{
    int pNum = PlayerNumber();
    int CheckerTID = 1500+pNum;
    //int armor; //hp
    int velx, vely, velz;
    int i;
	
	if (CheckInventory("MorphBallAcquired") != 1) { terminate; }
	if ((GetActorClass(0) == "MorphBallPlayer") || (GetActorClass(0) == "MorphBallPlayerDM")) { ACS_Execute(METROID_MORPHBALL,0, 1); }
    switch (morphshit)
    {
    case 0:
        if (isDead(0)) { terminate; }
        if(CheckInventory("PowerInvulnerable") == 1) { ActivatorSound("morphball/denied", 127); /*Print(s:"Morphing while invulnerable is temporarily disabled due to a bug.\n\nSorry.");*/ terminate; } // Temporary my ass.
        if(CheckInventory("SpeedBoosterActive") == 1) { ActivatorSound("morphball/denied", 127); terminate; } //For the future for mockball...
        if(CheckInventory("RedFlag") == 1) { ActivatorSound("morphball/denied", 127); terminate; }
        if(CheckInventory("BlueFlag") == 1) { ActivatorSound("morphball/denied", 127); terminate; }
        // Play sound...
        ActivatorSound("morphball/morph", 127);
		TakeInventory("ShinesparkCharge",0x7FFFFFFF); //Take Shinespark away
		TakeInventory("ShinesparkFlashing",0x7FFFFFFF); //Take flashing effect away
		TakeInventory("ShinesparkChargeToken",0x7FFFFFFF);
		TakeInventory("IsShinesparking",0x7FFFFFFF);
		if(CheckInventory("HiJump") == 1) { TakeInventory("HiJump", 0x7FFFFFFF); }// Take hijump away for spring ball
		

        // Prepare for health transferring from old player to morphed player...
		hp = GetActorProperty(0, APROP_HEALTH);
		spawnhp = GetActorProperty(0, APROP_SPAWNHEALTH);
		armor = CheckInventory("Armor");
        int newTID = unusedTID(23000, 25000);
        int myTID  = defaultTID(-1);

        // Prepare velocities...
        velx = GetActorVelX(0);
        vely = GetActorVelY(0);
        velz = GetActorVelZ(0);
		
        // Transfer the player's translation from the old body to the new morph.
        Spawn("TranslationHolder", GetActorX(0), GetActorY(0), GetActorZ(0)+8.0, newTID);
        Thing_SetTranslation(newTID, -1);
        if (isSinglePlayer() || isCoop()) { MorphActor(0, "MorphBallPlayer", "", 0x7FFFFFFF, 194, "emptytelefog", "emptytelefog"); } //194 style
        else { MorphActor(0, "MorphBallPlayerDM", "", 0x7FFFFFFF, 194, "emptytelefog", "emptytelefog"); }
        //if (CheckInventory("SpaceJumpAcquired") == 1) { SetActorProperty(0,APROP_JumpZ,6.0); } //check for Space Jump, give Spring Ball
        Thing_ChangeTID(0, myTID);
        SetActivator(newTID);
        Thing_SetTranslation(myTID, -1);
        SetActivator(myTID);
        Thing_Remove(newTID);
        SetActorVelocity(0, velx,vely,velz, 0,0);

        if (isSinglePlayer() || isCoop()) { SetActorState(0,"CoopModeOn"); }

        // Transfer health and give inventory.
        SetActorProperty(0, APROP_HEALTH, hp);
		SetActorProperty(0, APROP_SPAWNHEALTH, spawnhp);
        GiveInventory("RawEnergyShield2", armor); //2
        GiveInventory("BorphMallAcquired", 1);
        TakeInventory("MorphBallActivate", 1);
        TakeInventory("IceBeamChilled",999);
        GiveInventory("MorphBallDeactivate", 1);

        TakeInventory("PowerBeamChargeLevel",999);
        //TakeInventory("PowerBeamCharged",999);
        TakeInventory("PowerBeamIdle",999);
        TakeInventory("TheReturnOfSamusReturns",999);
        TakeInventory("MissileChargeLevel",999);
        TakeInventory("MissileCharged",999);
        playerOnFoot[pNum] = 1;

        GiveInventory("PlayerMorphCamera", 1);
        ACS_ExecuteAlways(METROID_MORPHCAMERA,0,90,4);
        ACS_ExecuteAlways(METROID_BWEEBWEEMORPH,0);

        // [ijon] Force resync of health count, missile capacity,
        //  super missile capacity, and power bomb capacity.
        //  Turns out that information gets lost on morph. Who knows why?
		
        SetActorProperty(0, APROP_SpawnHealth, GetActorProperty(0, APROP_SpawnHealth));
        SetActorProperty(0, APROP_Health,      GetActorProperty(0, APROP_Health));
        
        SetAmmoCapacity("MissileAmmo",      GetAmmoCapacity("MissileAmmo"));
        SetAmmoCapacity("SuperMissileAmmo", GetAmmoCapacity("SuperMissileAmmo"));
        SetAmmoCapacity("PowerBombAmmo",    GetAmmoCapacity("PowerBombAmmo"));

        i = CheckInventory("MissileAmmo");
        TakeInventory("MissileAmmo", 0x7FFFFFFF);
        GiveAmmo("MissileAmmo", i);

        i = CheckInventory("SuperMissileAmmo");
        TakeInventory("SuperMissileAmmo", 0x7FFFFFFF);
        GiveAmmo("SuperMissileAmmo", i);

        i = CheckInventory("PowerBombAmmo");
        TakeInventory("PowerBombAmmo", 0x7FFFFFFF);
        GiveAmmo("PowerBombAmmo", i);
        break;

    case 1:
        if (Spawn("SpaceChecker", GetActorX(0), GetActorY(0), GetActorZ(0), CheckerTID))
        {
            if (isDead(0)) { terminate; }
            ActivatorSound("morphball/unmorph", 127);
            hp = GetActorProperty(0, APROP_HEALTH);
			spawnhp = GetActorProperty(0, APROP_SPAWNHEALTH);
            velx = GetActorVelX(0);
            vely = GetActorVelY(0);
            velz = GetActorVelZ(0);

            // [ijon] Having this after the unmorph line meant that, on unmorph,
            //  you wouldn't be able to fire missiles until you did something
            //  weapon-wise. So let's just do this first.
            TakeInventory("BorphMallAcquired", 1);
			//ACS_NamedExecute("JumpCheck",0);
			if(CheckInventory("HiJumpAcquired") == 1) { GiveInventory("HiJump", 1); }
            UnmorphActor(0, 1);

			//ACS_NamedExecute("JumpCheck", 0);
            SetActorProperty(0, APROP_HEALTH, hp);
			SetActorProperty(0, APROP_SPAWNHEALTH, spawnhp);
            SetActorProperty(0,APROP_SPEED,1.00);
            TakeInventory("BoostBallCount", 99);
            TakeInventory("MissileChargeLevel",999);
            TakeInventory("MissileCharged",999);
            GiveInventory("MorphBallActivate", 1);
            TakeInventory("MorphBallDeactivate", 1);
            TakeInventory("BallBoosting", 1);
            SetActorVelocity(0, velx,vely,velz, 0,0);
            playerOnFoot[pNum] = 0;

            TakeInventory("PlayerMorphCamera", 0x7FFFFFFF);

            ACS_ExecuteAlways(352,0,0,0);
            ACS_ExecuteAlways(351,0,0,0);
            ACS_ExecuteAlways(METROID_BWEEBWEEBWEEBWEE,0);

            // [ijon] DO IT HERE TOO

            SetActorProperty(0, APROP_SpawnHealth, GetActorProperty(0, APROP_SpawnHealth));
            SetActorProperty(0, APROP_Health,      GetActorProperty(0, APROP_Health));
            
            SetAmmoCapacity("MissileAmmo",      GetAmmoCapacity("MissileAmmo"));
            SetAmmoCapacity("SuperMissileAmmo", GetAmmoCapacity("SuperMissileAmmo"));
            SetAmmoCapacity("PowerBombAmmo",    GetAmmoCapacity("PowerBombAmmo"));

            i = CheckInventory("MissileAmmo");
            TakeInventory("MissileAmmo", 0x7FFFFFFF);
            GiveAmmo("MissileAmmo", i);

            i = CheckInventory("SuperMissileAmmo");
            TakeInventory("SuperMissileAmmo", 0x7FFFFFFF);
            GiveAmmo("SuperMissileAmmo", i);

            i = CheckInventory("PowerBombAmmo");
            TakeInventory("PowerBombAmmo", 0x7FFFFFFF);
            GiveAmmo("PowerBombAmmo", i);
        }
        else { ActivatorSound("morphball/denied", 127); }
        break;
    }
}

script METROID_BOOSTBALL (void) NET
{

    int vx, vy, vz,  mag, angle, pitch;
    int nx, ny, nz, nmag;
    int rx, ry, rz, rmag;
	int boost = GetCVar("met_boostvel");

    if (!(isCoop() || isSinglePlayer() || (GetCVar("sv_cheats") > 0) || CheckInventory("BoostReadied"))) { terminate; }
    TakeInventory("BoostReadied", 0x7FFFFFFF);

    vx = GetActorVelX(0); // Checks for the player's X velocity and assigns it to vx
    vy = GetActorVelY(0); // Same for Y
    vz = GetActorVelZ(0); // Same for Z
    angle = GetActorAngle(0); // Checks for the player's angle and assigns it to angle
    pitch = middle(-0.027, GetActorPitch(0), 0.25); // This checks for the middle ground of the player's pitch, and will register up to a certain height
    mag = magnitudeThree_f(vx, vy, vz);

    nx = FixedMul(boost * cos(angle), cos(pitch));
    ny = FixedMul(boost * sin(angle), cos(pitch));
    nz = boost * -sin(pitch);
    nmag = magnitudeThree_f(nx, ny, nz);
    
    rx = vx + nx; ry = vy + ny; rz = vz + nz;
    rmag = magnitudeThree_f(rx, ry, rz);

    ActivatorSound("boostball/launch",255);

    if (rmag < mag)  // if we're making a sharp turn
    {
        SetActorVelocity(0, nx, ny, nz, 0,0);
    }
    else
    {
        mag += (boost<<16);
        SetActorVelocity(0,
                FixedMul(FixedMul(mag, cos(angle)), cos(pitch)),
                FixedMul(FixedMul(mag, sin(angle)), cos(pitch)),
                FixedMul(mag, -sin(pitch)), 0, 0);
    }
    SetActorState(0,"BoostBall");
}

script METROID_ENTER_CLIENTSIDE ENTER clientside
{
    int execInt, oExecInt, execStr;
    int pln = PlayerNumber();

    while(1)
    {
        if (ConsolePlayerNumber() != PlayerNumber()) { Delay(1); continue; }

        oExecInt = execInt;
        execInt = MetroidClientVars();

        if (execInt != oExecInt)
        {
            if (!IsServer)
            {
                execStr = StrParam(s:"puke -", d:METROID_PUKE, s:" ", d:execInt, s:" ", d:pln);
                ConsoleCommand(execStr);
            }
            else
            {
                ACS_ExecuteWithResult(METROID_PUKE, execInt, pln);
            }
        }

        delay(1);
    }
}

script METROID_PUKE (int values) net
{
    int pln = PlayerNumber();

    array_runrunruu[pln]     = values & 1;
    array_doomHealth[pln]    = values & 2;
    array_metpick[pln]       = values & 4;
    array_hitindic[pln]      = values & 8;
    array_custmischarg[pln]  = values & 16;
}

   // [TE13] These are stupidly hacky and a wasteful pair of scripts, but I'm
   // really fucking tired of the multi-siren bug.
script METROID_BWEEBWEEBWEEBWEE ENTER clientside
{
    int endloop;
    if (PlayerNumber() != ConsolePlayerNumber()) { terminate; }

    while (!endloop)
    {
    if (isDead(0)) { terminate; }
    delay(2);
    if (CheckInventory("BorphMallAcquired") == 1) { terminate; }
    if (isDead(0)) { terminate; }
    if (GetActorProperty(0,APROP_HEALTH) > 0) {
        if (GetActorProperty(0,APROP_HEALTH) <= 30) {
            if (M_GetCVar("met_cl_nosiren") == 0) {
                LocalAmbientSound("system/healthsiren",96); }}}
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(1);
    }
}

script METROID_BWEEBWEEMORPH (void) clientside
{
    int endloop;
    if (PlayerNumber() != ConsolePlayerNumber()) { terminate; }

    while (!endloop)
    {
    if (isDead(0)) { terminate; }
    delay(2);
    if (CheckInventory("BorphMallAcquired") == 0) { terminate; }
    if (isDead(0)) { endloop = 1; }
    if (GetActorProperty(0,APROP_HEALTH) > 0) {
        if (GetActorProperty(0,APROP_HEALTH) <= 30) {
            if (M_GetCVar("met_cl_nosiren") == 0) {
                LocalAmbientSound("system/healthsiren",96); }}}
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(1);
    }
}

script METROID_RESPAWN RESPAWN
{
    ACS_ExecuteAlways(METROID_ENTER,0);
    ACS_ExecuteAlways(METROID_ENTER_CLIENTSIDE,0);
    ACS_ExecuteAlways(METROID_BWEEBWEEBWEEBWEE,0);
    ACS_ExecuteAlways(METROID_SPEEDBOOSTER,0);

    if (isSinglePlayer() || isCoop()) // This shouldn't ever matter in any PvP modes, since their inventory resets on death, but just in case.
    {
        if (CheckInventory("EnergyTankAcquired") == 1) { SetActorProperty(0,APROP_SPAWNHEALTH,200); SetActorProperty(0,APROP_HEALTH,200); }
        if (CheckInventory("EnergyTankAcquired") == 2) { SetActorProperty(0,APROP_SPAWNHEALTH,300); SetActorProperty(0,APROP_HEALTH,300); }
        if (CheckInventory("EnergyTankAcquired") == 3) { SetActorProperty(0,APROP_SPAWNHEALTH,400); SetActorProperty(0,APROP_HEALTH,400); }
        if (CheckInventory("EnergyTankAcquired") == 4) { SetActorProperty(0,APROP_SPAWNHEALTH,500); SetActorProperty(0,APROP_HEALTH,500); }
        if (CheckInventory("EnergyTankAcquired") == 5) { SetActorProperty(0,APROP_SPAWNHEALTH,600); SetActorProperty(0,APROP_HEALTH,600); }
        if (CheckInventory("EnergyTankAcquired") == 6) { SetActorProperty(0,APROP_SPAWNHEALTH,700); SetActorProperty(0,APROP_HEALTH,700); }
        if (CheckInventory("EnergyTankAcquired") == 7) { SetActorProperty(0,APROP_SPAWNHEALTH,800); SetActorProperty(0,APROP_HEALTH,800); }
        if (CheckInventory("EnergyTankAcquired") == 8) { SetActorProperty(0,APROP_SPAWNHEALTH,900); SetActorProperty(0,APROP_HEALTH,900); }
        if (CheckInventory("EnergyTankAcquired") == 9) { SetActorProperty(0,APROP_SPAWNHEALTH,1000); SetActorProperty(0,APROP_HEALTH,1000); }
        if (CheckInventory("EnergyTankAcquired") == 10) { SetActorProperty(0,APROP_SPAWNHEALTH,1100); SetActorProperty(0,APROP_HEALTH,1100); }
		if (CheckInventory("EnergyTankAcquired") == 11) { SetActorProperty(0,APROP_SPAWNHEALTH,1200); SetActorProperty(0,APROP_HEALTH,1200); }
		if (CheckInventory("EnergyTankAcquired") == 12) { SetActorProperty(0,APROP_SPAWNHEALTH,1300); SetActorProperty(0,APROP_HEALTH,1300); }
		if (CheckInventory("EnergyTankAcquired") == 13) { SetActorProperty(0,APROP_SPAWNHEALTH,1400); SetActorProperty(0,APROP_HEALTH,1400); }
		if (CheckInventory("EnergyTankAcquired") == 14) { SetActorProperty(0,APROP_SPAWNHEALTH,1500); SetActorProperty(0,APROP_HEALTH,1500); }
		if (CheckInventory("EnergyTankAcquired") == 15) { SetActorProperty(0,APROP_SPAWNHEALTH,1600); SetActorProperty(0,APROP_HEALTH,1600); }
		if (CheckInventory("EnergyTankAcquired") == 16) { SetActorProperty(0,APROP_SPAWNHEALTH,1700); SetActorProperty(0,APROP_HEALTH,1700); }
		if (CheckInventory("EnergyTankAcquired") == 17) { SetActorProperty(0,APROP_SPAWNHEALTH,1800); SetActorProperty(0,APROP_HEALTH,1800); }
		if (CheckInventory("EnergyTankAcquired") == 18) { SetActorProperty(0,APROP_SPAWNHEALTH,1900); SetActorProperty(0,APROP_HEALTH,1900); }
		if (CheckInventory("EnergyTankAcquired") == 19) { SetActorProperty(0,APROP_SPAWNHEALTH,2000); SetActorProperty(0,APROP_HEALTH,2000); }
		if (CheckInventory("EnergyTankAcquired") == 20) { SetActorProperty(0,APROP_SPAWNHEALTH,2100); SetActorProperty(0,APROP_HEALTH,2100); }
    }
}


// DECORATE CHECKS
// =====================

script METROID_DECORATE (int which, int a1, int a2)
{
    int burrshet;
    int result;
    int pln = PlayerNumber();
    int i;

    switch (which)
    {
    case 0:
        SetResultValue(!!M_GetCVar("met_cl_noeffects"));
        break;

    case 1:
        SetActorProperty(0,APROP_SPEED,(GetActorProperty(0,APROP_SPEED)*4/5)); // 80% of the current player speed. Stackable.
        GiveInventory("IceBeamChilled",1);
        delay(100);
        TakeInventory("IceBeamChilled",1);
        delay(75);
        SetActorProperty(0,APROP_SPEED,1.00);
        break;

    case 2:
        SetPlayerProperty(0,1,PROP_TOTALLYFROZEN);
        SetActorProperty(0,APROP_SPEED,(GetActorProperty(0,APROP_SPEED)*2/3)); // 66% of the current player speed. Stackable.
        GiveInventory("IceBeamChilled",1);
        delay(20);
        SetPlayerProperty(0,0,PROP_TOTALLYFROZEN);
        delay(85);
        TakeInventory("IceBeamChilled",1);
        delay(95);
        SetActorProperty(0,APROP_SPEED,1.00);
        break;

    case 3:
        SetResultValue(!!GetCVar("sv_weaponstay"));
        break;

    case 4:
        SetResultValue(!!GetCVar("sv_noweaponspawn"));
        break;

    case 5:
		if ((GetActorClass(0) != "MorphBallModel") || (GetActorClass(0) != "MorphBallModelDM")) {
        SetActorProperty(0, APROP_SpawnHealth,  (1 + CheckInventory("EnergyTankAcquired")) * 100);
        SetActorProperty(0, APROP_Health, oldmax(GetActorProperty(0, APROP_Health), (1 + CheckInventory("EnergyTankAcquired")) * 100)); //1 + 
        break;
		}
		else {
		SetActorProperty(0, APROP_SpawnHealth,  (1 + CheckInventory("EnergyTankAcquired")) * 100);
        SetActorProperty(0, APROP_Health, oldmax(GetActorProperty(0, APROP_Health), (1 + CheckInventory("EnergyTankAcquired")) * 100)); //1 + 
        break;
		}

    case 6:
		
		if(GetCVar("met_missilemax") > 0)
		{
			if(CheckInventory("PlayerTotalMissiles") >= 250) 
			{
				GiveInventory("MissileAmmo",5);
				break;
			}
				
			SetAmmoCapacity("MissileAmmo",GetAmmoCapacity("MissileAmmo")+5);
			delay(1);
			GiveInventory("MissileAmmo",5);
			GiveInventory("PlayerTotalMissiles", 5);
			break;
		}
		
		else 
		{
			SetAmmoCapacity("MissileAmmo",GetAmmoCapacity("MissileAmmo")+5);
			delay(1);
			GiveInventory("MissileAmmo",5);
			GiveInventory("PlayerTotalMissiles", 5);
			break;
		}

    case 7:
        if(M_GetCVar("met_nolevellimiter") == 0) { GiveInventory("ETNotInThisLevel",1); }
        break;

    case 8:
        SetActorProperty(0,APROP_SPEED,(GetActorProperty(0,APROP_SPEED)*1/2)); // 50% of the current monster's speed. Stackable.
        break;

    case 9:
		
		if(GetCVar("met_supermissilemax") > 0)
		{
			if(CheckInventory("PlayerTotalSuperMissiles") >= 50) 
			{
				GiveInventory("SuperMissileAmmo",2);
				break;
			}
				
			SetAmmoCapacity("SuperMissileAmmo",GetAmmoCapacity("SuperMissileAmmo")+2);
			delay(1);
			GiveInventory("SuperMissileAmmo",2);
			GiveInventory("PlayerTotalSuperMissiles", 2);
			break;
		}
		
		else
		{
        SetAmmoCapacity("SuperMissileAmmo",GetAmmoCapacity("SuperMissileAmmo")+2);
        delay(1);
        GiveInventory("SuperMissileAmmo",2);
		GiveInventory("PlayerTotalSuperMissiles", 2);
        break;
		}

    case 10:
        SetResultValue(!!M_GetCVar("met_noenergydrops"));
        break;

    case 11:
        SetResultValue(!!M_GetCVar("met_soultanks"));
        break;

    case 12:
		
		if(GetCVar("met_powerbombmax") > 0)
		{
			if(CheckInventory("PlayerTotalPowerBombs") >= 9) 
			{
				GiveInventory("PowerBombAmmo",1);
				break;
			}
				
			SetAmmoCapacity("PowerBombAmmo",GetAmmoCapacity("PowerBombAmmo")+1);
			delay(1);
			GiveInventory("PowerBombAmmo",1);
			GiveInventory("PlayerTotalPowerBombs", 1);
			break;
		}

		else
		{
        SetAmmoCapacity("PowerBombAmmo",GetAmmoCapacity("PowerBombAmmo")+1);
        delay(1);
        GiveInventory("PowerBombAmmo",1);
		GiveInventory("PlayerTotalPowerBombs", 1);
        break;
		}
		
    case 13:
        if(M_GetCVar("met_doomcannon") == 1)
        SetResultValue(1);
        else SetResultValue(0);
        break;

    case 14:
        if(M_GetCVar("met_nolevellimiter") == 0) { GiveInventory("SMNotInThisLevel",1); }
        break;

    case 15:
        if(M_GetCVar("met_nolevellimiter") == 0) { GiveInventory("PBNotInThisLevel",1); }
        break;

    case 16:
        SetResultValue(!!M_GetCVar("met_dropstay"));
        break;

    case 17:
        SetResultValue(!!M_GetCVar("met_nobfg"));
        break;

    case 18:
        SetResultValue(!!M_GetCVar("met_permabfg"));
        break;

    case 19:
        SetResultValue(!!M_GetCVar("met_skulltagweapons"));
        break;

    // [ijon] IT'S MOTHERFUCKING *ARRAY TIME*
    //      NOW WITH 200% MORE INDEXES FOR THAT ALL-NATURAL ASSKICKING TASTE

      case 20:
        if (a1 < 0 || a1 >= PICKUPTYPES) { break; }

        int forceNoPause    = !!a2;
        int whichPickup     = a1;
        int giveItem        = BigPickupItems[whichPickup];
        int message         = BigPickupMsgFonts[whichPickup];
        int giveSound       = BigPickupSounds[whichPickup][2];
        int hadItem         = !!CheckInventory(giveItem);

        GiveInventory(giveItem, 1);

        if (GotBigPickup[pln][whichPickup]) { break; }
        GotBigPickup[pln][whichPickup] = 1;

        if (!(CheckInventory("NoMetroidPickupSystem") || forceNoPause))
        {
            SetFont(message);

            if (!hadItem && isSinglePlayer())
            {
                Thing_Stop(0);
                GiveInventory("PowerTimeFreezer", 1);
                SetPlayerProperty(0, 1, PROP_TOTALLYFROZEN);
                if (!CheckInventory("PowerInvulnerable")) { SetActorProperty(0, APROP_INVULNERABLE, 1); }

                HudMessage(s:"A"; HUDMSG_PLAIN, 1, 0, 0.5, 0.3, 6);
                ACS_ExecuteAlways(METROID_DECORATECLIENT, 0, 3, whichPickup);

                for (i = 0; i < 210; i++)
                {
                    if (keyDown(BT_USE)) { break; }
                    Delay(1);
                }

                SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
                if (!CheckInventory("PowerInvulnerable")) { SetActorProperty(0, APROP_INVULNERABLE, 0); }
                ACS_ExecuteAlways(METROID_DECORATECLIENT, 0, 4);

                TakeInventory("PowerTimeFreezer",0x7FFFFFFF);
                GiveInventory("GrossSoundHackStop",1);
                HudMessage(s:""; HUDMSG_PLAIN, 1, 0, 0.5, 0.5, 0.01);
            }
            else
            {
                HudMessage(s:"A"; HUDMSG_PLAIN, 1, 0, 0.5, 0.25, 3);
                ActivatorSound(giveSound, 127);

                for(i = 0; i < 52; i++)
                {
                    if (keyDown(BT_USE)) { break; }
                    Delay(1);
                }

                HudMessage(s:""; HUDMSG_PLAIN, 1, 0, 0.5, 0.5, 0.01);
            }
        }
        else
        {
            ActivatorSound(giveSound, 127);
            ACS_ExecuteAlways(METROID_DECORATECLIENT, 0, 7, whichPickup);
        }
        break;

    // [TE13] These are a stupidly hacky and wasteful set of scripts.
    // If I could get GetActorInventory to work fine, they wouldn't be needed!
    case 21:
        if (isSinglePlayer() && GotSpazer == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

    case 22:
        if (isSinglePlayer() && GotPlasma == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

    case 23:
        if (isSinglePlayer() && GotWave == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

    case 24:
        if (isSinglePlayer() && GotIce == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

    case 25:
        if (isSinglePlayer() && GotLong == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

    case 26:
        if (isSinglePlayer() && GotDoom == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

    case 27:
        if (isSinglePlayer() && GotCharge == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
    // Chroma Storm probably won't be needed since I assume it'll only spawn on multiplayer maps. [R4L] THAT'S WHERE YOU'RE WRONG BUCKO
    
      case 28:
        switch (a1)
        {
            default: SetResultValue(CheckInventory("Metroid_CanMissile"));  break;
            case 1:  SetResultValue(CheckInventory("Metroid_CanSuper"));    break;
        }
        break;
     
      case 29:
        if (GetCVar("sv_infiniteammo")) { break; }
        a2 = oldmax(a2, 1);

        switch (a1)
        {
            default: TakeInventory("MissileAmmo",       a2);  break;
            case 1:  TakeInventory("SuperMissileAmmo",  a2);  break;
        }
        break;

    case 30:
        if (GetCVar("met_dropgravity") == 1) { SetActorState(0,"GiveGravity"); }
        break;

    case 31:
        delay(1);
        int myx = GetActorX(0);
        int myy = GetActorY(0);
        int myz = GetActorZ(0);
        delay(10);
        SetActivatorToTarget(0);

        int maxRoll = 0;
        a1 = oldmax(1, a1);

        // TempDropState is used to tell the shit below
        //  whether an item can be dropped or not
        for (i = 0; i < DROPCOUNT; i++)
        {
            int checkitem = MonsterDropItems[i][D_CHECKITEM];
            int checkammo = MonsterDropItems[i][D_CHECKAMMO];
            TempDropState[i] = 0;

            if (GameType() == GAME_SINGLE_PLAYER)
            {
				
                if (strcmp(checkitem, "InGame"))
                {
                    if (!CheckInventory(checkitem)) { continue; }
                }
				
				if (!strcmp(checkammo, "Health"))
                {
                    if (GetActorProperty(0, APROP_Health) >= getMaxHealth()) { continue; }
                }
				
				else if (strcmp(checkammo, ""))
					{
						if (CheckInventory(checkammo) >= GetAmmoCapacity(checkammo)) { continue; }
					}
            }
        
            maxRoll += MonsterDropChances[i][DN_PICKCHANCE];
            TempDropState[i] = 1;
        }

        maxRoll -= 1; // the range starts from 0, not 1

        if (maxRoll < 0) { break; }

        while (a1-- > 0)
        {
            int roll    = random(0, maxRoll);
            int curstep = 0;
            int item    = "";
            
            for (i = 0; i < DROPCOUNT; i++)
            {
                if (!TempDropState[i]) { continue; }

                curstep += MonsterDropChances[i][DN_PICKCHANCE];

                if (roll < curstep)
                {
                    if (random(0, 255) >= MonsterDropChances[i][DN_NOSPAWNCHANCE])
                    {
                        item = MonsterDropItems[i][D_DROPITEM];
                    }

                    break;
                }
            }

            if (strcmp(item, ""))
            {
                int mag   = 16 * a1;
                int ang, pitch;
                int nx, ny, nz;
                i = 0;

                do
                {
                    ang   = random(0, 1.0);
                    pitch = random(-0.25, 0.25);

                    nx = myx + (mag * FixedMul(cos(ang), cos(pitch)));
                    ny = myy + (mag * FixedMul(sin(ang), cos(pitch)));
                    nz = myz + (mag * sin(pitch));

                    i++;
                } while (!Spawn(item, nx, ny, nz) && (i < 16));
            }
        }
        break;

    case 32:
        delay(32);
        if (isCoop() || isSinglePlayer()) { 
			if(CheckInventory("BombCount") < 1 & CheckInventory("BombCount") != 3) //prime bomb mechanics
			{
				Delay(105);
				GiveInventory("BombCount", 3);
			}
			else
			{
			delay(20); GiveInventory("BombCount",1); }
			PlaySound(0, "morphball/pbomread");}
        else { delay(8); GiveInventory("BombCount",1); } //Delay(8)
        break;
		
	case 33:
        if (isSinglePlayer() && GotMorph == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

	case 34:
        if (isSinglePlayer() && GotVaria == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 35:
        if (isSinglePlayer() && GotChargeBeam == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 36:
		GiveInventory("MissileAmmo", 5);
		break;
		
    case 37:
		if (isSinglePlayer() && GotMissiles == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
		break;
		
	case 38:
		GiveInventory("PowerBombAmmo", 1);
		delay(1);
		break;
	
	case 39:
		if ((isSinglePlayer() == true) && (GotMissiles != 1)) { SetResultValue(1); }
		else { SetResultValue(0); }
	
	case 40:
		if (GetAmmoCapacity("MissileAmmo") <= 0){ SetResultValue(1); }
		else { SetResultValue(0); }
		
	case 41:
        if (isSinglePlayer() && GotPowerMissile == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 42:
        if (isSinglePlayer() && GotWaveMissile == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 43:
        if (isSinglePlayer() && GotSolarFlare == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 44:
        if (isSinglePlayer() && GotIceSpreader == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 45:
        if (isSinglePlayer() && GotNovaFlash == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
	
	case 46:
        if (isSinglePlayer() && GotWideShot == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 47:
        if (isSinglePlayer() && GotHyperBeam == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 48:
        if (isSinglePlayer() && GotChainsawBeam == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
	
	case 49:
        if (isSinglePlayer() && GotSpeed == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
	
	case 50:
        if (isSinglePlayer() && GotSpace == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 51:
        if (isSinglePlayer() && GotArmor == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 52:
        if (isSinglePlayer() && GotChroma == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 53:
        if (isSinglePlayer() && GotBombs == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 54:
		if (isSinglePlayer() && GotBoostBall == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 55:
		if (isSinglePlayer() && GotHiJump == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 56:
		if (isSinglePlayer() && GotScan == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;

	case 57:
		if (isSinglePlayer() && GotGravity == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
		
	case 58:
		if (isSinglePlayer() && GotPowerBomb == 1) { SetResultValue(1); }
        else { SetResultValue(0); }
        break;
    }
}

script METROID_DECORATECLIENT (int which, int a1, int a2) clientside
{
    int inZDoom = met_cvarinfo();  // [ijon] Hack!
    if (ConsolePlayerNumber() != PlayerNumber()) { terminate; }

    switch (which)
    {
      case 0:
        SetResultValue(!!M_GetCVar("met_cl_noeffects"));
        break;

      case 1:
        SetResultValue(!!M_GetCVar("met_cl_doomhealth"));
        break;

      case 2:
        SetResultValue(!!GetCVar("cl_run"));
        break;


      case 3:
        if (a1 < 0 || a1 >= PICKUPTYPES) { break; }
        int pickupMus = BigPickupSounds[a1][0];
        int soundItem = BigPickupSounds[a1][1];

        // [ijon] Sorry, ZDoom. SetMusicVolume doesn't exist yet, so you have to use LocalSetMusic.
        if (inZDoom || M_GetCVar("met_cl_pickupmusic") == 1) { SetMusicVolume(0.0); GiveInventory(soundItem, 1); }
        else
        {
            // [ijon] testmusicvol is safer than snd_musicvolume - it does no lasting damage.
            ConsoleCommand("testmusicvol 0");
            GiveInventory(soundItem, 1);
        }
        break;

      case 4:
        if (inZDoom || M_GetCVar("met_cl_pickupmusic") == 1) {SetMusicVolume(1.0); }//LocalSetMusic("*");
        else { ConsoleCommand("testmusicvol 1"); }
        break;

      case 5:
      if (CheckInventory("MetroidHitIndicatorActive") == 1)
      {
        LocalAmbientSound("system/hitindicator", 127);
        GiveInventory("MetroidHitOpponent",1);
        Delay(1);
        TakeInventory("MetroidHitOpponent",1);
      }
      break;

      case 7:
        if (a1 < 0 || a1 >= PICKUPTYPES) { break; }
        int message = chooseMessage(a1, 1);
        int pickupColor = msgColors[GetCVar("msg0color")];
        Log(s:pickupColor, s:strstr(message, "\c-", pickupColor));
        break;
    }
}

script METROID_POWERBOMB (int scaleI, int scaleF, int speedF)
{
    int scale, x, y, z, mag;
    x = GetActorVelX(0); y = GetActorVelY(0); z = GetActorVelZ(0);

    if (speedF == 0) { scale = itof(scaleI) + (scaleF * 0.01); }
    else
    {
        mag = magnitudeThree_f(x, y, z);

        if (mag == 0)
        {
            x = random(-10.0, 10.0);
            y = random(-10.0, 10.0);
            z = random(-10.0, 10.0);
            mag = magnitudeThree_f(x, y, z);
        }

        scale = FixedDiv(speedF * 1.0, mag);
    }

    SetActorVelocity(0, FixedMul(x, scale), FixedMul(y, scale), FixedMul(z, scale), 0, 0);
    // PrintBold(s:"(", f:x, s:", ", f:y, s:", ", f:z, s:"): ", f:scale, s:" -> (", f:GetActorVelX(0), s:", ", f:GetActorVelY(0), s:", ", f:GetActorVelZ(0), s:")");
    // printf("(%f, %f, %f): %f -> (%f, %f, %f)\n", x, y, z, scale, GetActorVelX(0), GetActorVelY(0), GetActorVelZ(0));
}

script METROID_SPEEDBOOSTER ENTER
{
    int buttons;
    int x;
    int y;
	int z;
    int xb;
    int yb;
	int zb;
	int justcrouched = 0;
	
    while (1)
    {
		buttons = GetPlayerInput(-1, INPUT_BUTTONS);
		if (CheckInventory("BorphMallAcquired") == 0 && CheckInventory("IsAFuckingSpaceshipBoyeeee") == 0)
		{
			if (CheckInventory("SpeedBoosterAcquired") == 1)
			{
				xb = x;
				yb = y;
				zb = z;
				x = GetActorX(0);
				y = GetActorY(0);
				z = GetActorZ(0);
			
				if ((buttons & (BT_SPEED | BT_FORWARD)) == (BT_SPEED | BT_FORWARD) && (xb != x) && (yb != y) && (z - GetActorFloorZ (0))<=8.0)//(buttons & BT_SPEED && buttons & BT_FORWARD)// (buttons & (BT_SPEED | BT_FORWARD) == (BT_SPEED | BT_FORWARD))
				{
			
					if (CheckInventory("SpeedBoostCounter") == 0) { ActivatorSound("speedboost/start",127); }
					if (CheckInventory("AlwaysRunIsOn") == 1 ) { TakeInventory("SpeedWalkerPrepare",1); GiveInventory("SpeedBoosterPrepare",1); }
					else { TakeInventory("SpeedBoosterPrepare",1); GiveInventory("SpeedWalkerPrepare",1); }
					GiveInventory("SpeedBoosterActive",1);
					GiveInventory("SpeedBoostCounter",1);
				
					if (CheckInventory("SpeedBoostCounter") > 8)
					{
						if ((buttons & (BT_CROUCH)) == (BT_CROUCH))
						{
							if ((GetActorZ(0) - GetActorFloorZ(0)) == 0.0)
							{
								justcrouched = 1;
								ActivatorSound("speedboost/loop1",127);
								GiveInventory("ShinesparkCharge", 1);
								GiveInventory("ShinesparkChargeToken", 1);
								//Print(s:"Shinespark charged");
								ACS_Execute(600,0);
							}
						}
						
					if (CheckInventory("AlwaysRunIsOn") == 1 ) { TakeInventory("SpeedWalkerPrepare",1); TakeInventory("SpeedWalker",1); GiveInventory("SpeedBoosterPrepare",1); GiveInventory("SpeedBooster",1); /*Print(s:"AlwaysRun is on.");*/ }
					else { TakeInventory("SpeedBoosterPrepare",1); TakeInventory("SpeedBooster",1); GiveInventory("SpeedWalkerPrepare",1); GiveInventory("SpeedWalker",1); /*Print(s:"AlwaysRun is off.");*/ }
					if (CheckInventory("ShinesparkCharge") == 1 | justcrouched == 1){ ActivatorSound("speedboost/loop1",127);}
					else { ActivatorSound("speedboost/loop",127);}
					GiveInventory("SpeedBoosterFlashing",1);
					}
				}
				else
				{	
					justcrouched = 0;
					TakeInventory("ShinesparkCharge", 0x7FFFFFFF);
					TakeInventory("ShinesparkFlashing",1);
					TakeInventory("SpeedBooster",1);
					TakeInventory("SpeedBoosterPrepare",1);
					TakeInventory("SpeedWalker",1);
					TakeInventory("SpeedWalkerPrepare",1);
					TakeInventory("SpeedBoostCounter",0x7FFFFFFF);
					if (CheckInventory("SpeedBoosterActive") == 1) { TakeInventory("SpeedBoosterActive",1); delay(105); } // If you were successfully speed boosting just before, you can't just spam it again as soon as the last one finished.
				}
			}
		}
		
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(2);
    if (isDead(0)) { terminate; }
    delay(1);
}
}

script METROID_SHINESPARK (void)
{
	int shine = CheckInventory("ShinesparkCharge");
	int buttons;
	int cooldown = 0;
	
	while(shine ) //While Samus has a shinespark charge
	{
		buttons = GetPlayerInput(-1, INPUT_BUTTONS); //buttons stores Player input
		if (CheckInventory("BorphMallAcquired") == 0 && CheckInventory("IsAFuckingSpaceshipBoyeeee") == 0) //If player isn't morphed
		{
			if(CheckInventory("ShinesparkChargeToken") == true) //Check for token item that actually allows Shinespark
			{
				while(cooldown <= 20) //Sets cooldown timer for charge
				{
					if(CheckInventory("SpeedBoosterActive") == 0) //If player has a charge and isn't speed boosting
					{
						if ((buttons & (BT_SPEED | BT_JUMP)) == (BT_SPEED | BT_JUMP)) //If player presses run and jump together
						{
						GiveInventory("IsShinesparking",1);
						ACS_Execute(601,0); //Execute METROID_SHINESPARK_LAUNCH
						terminate;
						}
						ActivatorSound("speedboost/loop1",127); //Play shinespark charge sound
						GiveInventory("ShinesparkFlashing",1); //Give flashing effect
					}
					cooldown++; //Raise the counter
					break;
				}
			}
			else
			{
				TakeInventory("ShinesparkCharge",0x7FFFFFFF); //Take shinespark charge away
				TakeInventory("ShinesparkChargeToken",0x7FFFFFFF);
				TakeInventory("ShinesparkFlashing",1); //Take flashing effect away
				//cooldown = 0;
				shine = false; //Break the while loop
				terminate;
			}
		}
		if (cooldown >= 20)
				{
				cooldown = 0; //Set cooldown to initial value so Shinespark doesn't instantly charge on next speed boost
				TakeInventory("ShinesparkCharge",0x7FFFFFFF); //Make sure your charge is gone
				TakeInventory("ShinesparkChargeToken",0x7FFFFFFF);
				TakeInventory("ShinesparkFlashing",1); //Make sure flashing effect is gone
				break;
				}
		delay(2);
		if (isDead(0)) { terminate; }
		delay(2);
		if (isDead(0)) { terminate; }
		delay(2);
		if (isDead(0)) { terminate; }
		delay(2);
		if (isDead(0)) { terminate; }
		delay(1);
	}
}

script METROID_SHINESPARK_LAUNCH (void) NET
{
	if(CheckInventory("ShinesparkChargeToken") != 0)
	{
	
    int vx, vy, vz,  mag, angle, pitch, absolute;
    int nx, ny, nz, nmag;
    int rx, ry, rz, rmag;
	int health = GetActorProperty(0, APROP_HEALTH);
	int shiny = GetCVar("met_shinevel");
	int pNum = PlayerNumber();
	int CheckerTID = 1500+pNum;

    vx = GetActorVelX(0); // Checks for the player's X velocity and assigns it to vx
    vy = GetActorVelY(0); // Same for Y
    vz = GetActorVelZ(0); // Same for Z
    angle = GetActorAngle(0); // Checks for the player's angle and assigns it to angle
    pitch = middle(-0.027,GetActorPitch(0), 0.25); // This checks for the middle ground of the player's pitch, and will register up to a certain height
	absolute = oldmin(GetActorPitch(0), 0.25); // This doesn't care about middle ground. Shine whereever.
    mag = magnitudeThree_f(vx, vy, vz);

    nx = FixedMul(shiny * cos(angle), cos(pitch));
    ny = FixedMul(shiny * sin(angle), cos(pitch));
    nz = shiny * -sin(pitch);
    nmag = magnitudeThree_f(nx, ny, nz);
    
    rx = vx + nx; ry = vy + ny; rz = vz + nz;
    rmag = magnitudeThree_f(rx, ry, rz);

	ACS_Terminate(600, 0);
	SetActorPosition(0,GetActorX(0),GetActorY(0),GetActorZ(0)+2,0);
    ActivatorSound("boostball/launch",255);

    if (rmag < mag)  // if we're making a sharp turn
    {
        SetActorVelocity(0, nx, ny, nz, 0,0);
    }
    else
    {
		SetActorFlag(0,"THRUACTORS",true); //Make Samus go through actors
		while (CheckActorState(0,"ShineSee") || CheckActorState(0,"ShineContinueOn") || CheckActorState(0,"ShineContinueOn2")) //Check if Samus is in any of these states
		{
			if((GetActorProperty(0, APROP_HEALTH) <= 31) || (Spawn("SpaceChecker", GetActorX(0), GetActorY(0), GetActorZ(0), CheckerTID) == FALSE) || ((GetActorZ (0) - GetActorFloorZ (0))==0.0)) //Check if Samus has 30 energy left, hits a wall, or a floor.
			{
				SetPlayerProperty(0, 0, PROP_TOTALLYFROZEN);
				SetActorFlag(0,"THRUACTORS",false); //Take THRUACTORS flag away
				SetActorVelocity(0,0,0,0,0,0); //Set Samus' velocity back to nothing
				TakeInventory("ShinesparkCharge",0x7FFFFFFF); //Take Shinespark away
				TakeInventory("ShinesparkFlashing",0x7FFFFFFF); //Take flashing effect away
				TakeInventory("ShinesparkChargeToken",0x7FFFFFFF);
				TakeInventory("IsShinesparking",0x7FFFFFFF);
				GiveInventory("MorphBallAcquired", 1);
				terminate;
			}
			else
			{
				TakeInventory("MorphBallAcquired", 1);
				SetPlayerProperty(0, 1, PROP_TOTALLYFROZEN);
				SetActorState(0,"ShineSee"); //Go to Shinespark state
				if (GetCVar("met_noshinesparkdrain") != 1){
					SetActorProperty(0,APROP_HEALTH,health--); //Drain energy
					SetActorProperty(0,APROP_HEALTH,health--); //One wasn't enough
					SetActorProperty(0,APROP_HEALTH,health--); //so I added six
					SetActorProperty(0,APROP_HEALTH,health--);
					SetActorProperty(0,APROP_HEALTH,health--);
					SetActorProperty(0,APROP_HEALTH,health--);
					mag += (shiny<<16);
					}
				else {
					mag += (shiny<<16);
					}
				SetActorVelocity(0,
                FixedMul(FixedMul(mag, cos(angle)), cos(absolute)),
                FixedMul(FixedMul(mag, sin(angle)), cos(absolute)),
                FixedMul(mag, -sin(absolute)), 0, 0);
			}
			Delay(1);
		}
    }
  }
}

script METROID_SHIPCONTROLS (void)
{
    int shipbuttons;
    int AnglePre;
    int PitchPre;
    int AnglePost;
    int PitchPost;
    int AngleResult;

    Delay(2);
    if (!CheckInventory("IsAFuckingSpaceshipBoyeeee")) { terminate; }
    ConsoleCommand("chase");
    if (ConsolePlayerNumber() != PlayerNumber()) { terminate; }
        
    while(1)
    {
        if (isDead(0)) { SetPlayerProperty(0,0,4); terminate; }

        shipbuttons = GetPlayerInput(-1,INPUT_BUTTONS);

        int Yaw = GetPlayerInput(-1,INPUT_YAW) * 500;
        int Pitch = GetPlayerInput(-1,INPUT_PITCH) * 500;

        if (Pitch > 0.2)
            { GiveInventory("GunshipLookUp",1); GiveInventory("LookUpCounter",1); TakeInventory("LookDownCounter",1); }
        else if (Pitch < -0.2)
            { GiveInventory("GunshipLookDown",1); GiveInventory("LookDownCounter",1); TakeInventory("LookUpCounter",1); }
        else
            { TakeInventory("LookUpCounter",1); TakeInventory("LookDownCounter",1); }

        if (Yaw > 0.2)
            { GiveInventory("GunshipLookRight",1); GiveInventory("LookRightCounter",1); TakeInventory("LookLeftCounter",2);  }
        else if (Yaw < -0.2)
            { GiveInventory("GunshipLookLeft",1); GiveInventory("LookLeftCounter",1); TakeInventory("LookRightCounter",2);  }
        else
            { TakeInventory("LookLeftCounter",2); TakeInventory("LookRightCounter",2); }

      AnglePre=getactorangle(0);
      PitchPre=getactorpitch(0);
      //Delay(1);
      if(AnglePre!=AnglePost)
      {
         AngleResult=AnglePre-((AnglePre-AnglePost)/5);
         
         if(AnglePre-AnglePost<(-50000)) //if the difference of the two is too big, and reached a big negative number
            SetActorAngle(0,65535);
         else if(AnglePre-AnglePost>50000)  //if the difference of the two is too big
            SetActorAngle(0,1);
         else
            SetActorAngle(0,AngleResult);
      }

      AnglePost=getactorangle(0);
      PitchPost=getactorpitch(0);

        if ( ((shipbuttons & BT_MOVELEFT)) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("GunshipLeft",1); }
                
        else if ( ((shipbuttons & BT_MOVERIGHT)) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("GunshipRight",1); }

        if( (shipbuttons & BT_ATTACK) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("SynthFireLeft",1); }
        else
            { TakeInventory("SynthFireLeft",0x7FFFFFFF); }
        if( (shipbuttons & BT_ALTATTACK) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("SynthFireRight",1); }
        else
            { TakeInventory("SynthFireRight",0x7FFFFFFF); }

        if( (shipbuttons & BT_JUMP) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("GunshipUp",1); }

        if( (shipbuttons & BT_Crouch) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("GunshipDown",1); }

        if( (shipbuttons & BT_FORWARD) && !(shipbuttons & BT_BACK) )
            { if (!(shipbuttons & BT_SPEED)) { GiveInventory("GunshipForward",1); GiveInventory("GoingForwardCounter",1); TakeInventory("GoingBackwardCounter",1); }
            else { GiveInventory("GunshipForwardDash",1); GiveInventory("GoingForwardCounter",1); TakeInventory("GoingBackwardCounter",2); }}
        else if( (shipbuttons & BT_BACK) && !(shipbuttons & BT_FORWARD) && !(shipbuttons & BT_SPEED) )
            { GiveInventory("GunshipBackward",1); GiveInventory("GoingBackwardCounter",1); TakeInventory("GoingForwardCounter",1); }
        else
            { TakeInventory("GoingForwardCounter",1); TakeInventory("GoingBackwardCounter",1); }

        Delay(1);
    }
}

// Hey, look at me be lazy and devote a whole script simply for Changelog stuff.
script METROID_CHANGELOG (int changelogshit) NET CLIENTSIDE
{
    switch (changelogshit)
    {
        case 1:
        Log(s:ChangelogString);
        break;
    }
}

script METROID_SCANVISOR (void)
{
//[R4L] Thanks ACS for adding strings to indexes so I can't directly access them through a switch/case block! Thanks
//		to Gutawer and boris for pointing this out.

	SetActivator(0, AAPTR_TRACER);

	str prefix;
	str mName;
	str message;
	int pn = PlayerNumber();
	
	for(int tid = 0; tid <= 33; tid++) //33
	{
		mName = GetActorClass(tid);
		
		//Enemies First :P
		
		if(StrICmp(mName, "Metroid_ZombieGuy") == 0)
		{
			//prefix = "ENEMY TYPE: ";
			//mName = "Former Trooper";
			//message = "These were your friends.";
			if (CheckActorInventory(0,"ZombiemanScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Former Trooper' logged.");
			GiveActorInventory(0, "ZombiemanScan", 1);
			GiveInventory("ZombiemanScan", 1);
			break;
		}
			
		else if(StrICmp(mName, "Metroid_ShotGuy") == 0)
		{
			//prefix = "ENEMY TYPE: ";
			//mName = "Former Sergeant";
			//message = "These were your friends but they have shotguns that really hurt.";
			if (CheckInventory("ShotgunGuyScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Former Sergeant' logged.");
			GiveActorInventory(0, "ShotgunGuyScan", 1);
			GiveInventory("ShotgunGuyScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_ChainGuy") == 0)
		{
			//prefix = "ENEMY TYPE: ";
			//mName = "Heavy Chaingunner";
			//message = "HAVE YOU PLAYED PLUTONIA?!";
			if (CheckActorInventory(pn, "HeavyChaingunnerScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Heavy Chaingunner' logged.");
			GiveActorInventory(0, "HeavyChaingunnerScan", 1);
			GiveInventory("HeavyChaingunnerScan", 1);
			break;
		}
	
		else if(StrICmp(mName, "Metroid_ImpGuy") == 0)
		{
			//prefix = "ENEMY TYPE: ";
			//mName = "Demonic Imp";
			//message = "The lieutenants of Hell. These monstrosities possess sharp claws for flaying the toughest opponents and can hurl scorching hot fireballs.";
			//PrintBold(s:prefix, s:mName, s:" , ", s:message);
			if (CheckInventory("DoomImpScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Imp' logged.");
			GiveActorInventory(0, "DoomImpScan", 1);
			GiveInventory("DoomImpScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_DemonGuy") == 0)
		{
			//prefix = "ENEMY TYPE: ";
			//mName = "Pinky Demon";
			//message = "Mindless beasts who only live to devour anything that stands in their way.";
			if (CheckInventory("DemonScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Demon' logged.");
			GiveActorInventory(0, "DemonScan", 1);
			GiveInventory("DemonScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_SpectreGuy") == 0)
		{
			if (CheckInventory("SpectreScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Spectre' logged.");
			GiveActorInventory(0, "SpectreScan", 1);
			GiveInventory("SpectreScan", 1);
			break;
		}
		
		
		else if(StrICmp(mName, "Metroid_CacoGuy") == 0)
		{
			if (CheckInventory("CacodemonScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Cacodemon' logged.");
			GiveActorInventory(0, "CacodemonScan", 1);
			GiveInventory("CacodemonScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_LostGuy") == 0)
		{
			if (CheckInventory("LostSoulScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Lost Soul' logged.");
			GiveActorInventory(0, "LostSoulScan", 1);
			GiveInventory("LostSoulScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_BaronGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Baron Of Hell";
			message = "High ranking for a reason. Incredibly formidible, with a high resistance to pain and possesses the ability to hurl hot plasma.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_KnightGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Hell Knight";
			message = "Underling to the mighty Baron, they still possess incredible strength.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_VileGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Archvile";
			message = "A monster that knows no boundaries of torment. Nightmarish in appearance, with the ability to ressurect the fallen.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_SpiderGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Arachnotron";
			message = "Cybernetic arachnid armed with a plasma rifle.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_FatGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Mancubus";
			message = "Bloated, infected monstrosity. Armed with two lethal fire cannons.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_PainGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Pain Elemental";
			message = "Devourer and conjourer of Lost Souls.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_CoolGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Revenant";
			message = "Re-animated remains of a terrible demon, outfitted with a homing rocket launcher AND A FUCKIN MEAN RIGHT HOOK AMIRITE?.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_CyberGuy") == 0)
		{
			prefix = "ENEMY TYPE: ";
			mName = "Cyberdemon";
			message = "Absolutely towering in size and stature, with thunderous foot steps that can be heard far and wide. The toughest Demon of them all, with a tri-launcher for a left arm. Not easily toppled.";
			PrintBold(s:prefix, s:mName, s:" , ", s:message);
			break;
		}
		
		else if(StrICmp(mName, "Metroid_MasterGuy") == 0)
		{
			//prefix = "ENEMY TYPE: ";
			//mName = "Cyberdemon";
			//message = "The first in command. Overwhelming in size and sports an upgraded chaingun to tear anything in its path apart.";
			if (CheckInventory("SpiderMastermindScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'The Spider Mastermind' logged.");
			GiveActorInventory(0, "SpiderMastermindScan", 1);
			GiveInventory("SpiderMastermindScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "SpacePirate") == 0)
		{
			PrintBold(s:"Scan complete; New data for 'Space Pirate' logged.");
			break;
		}
		
		//Items and Powerups
		
		else if(StrICmp(mName, "MissileAmmo_Dropped") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("MissileAmmoScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Missiles' logged.");
			GiveActorInventory(0, "MissileAmmoScan", 1); //Gives Samus the actual log
			GiveInventory("MissileAmmoScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "MissileTankPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("MissileTankScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Missile Tank' logged.");
			GiveActorInventory(0, "MissileTankScan", 1); //Gives Samus the actual log
			GiveInventory("MissileTankScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "SuperMissileTankPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff, BUT BIGGER AND STRONGER.";
			if (CheckInventory("SuperMissileTankScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Super Missiles' logged.");
			GiveActorInventory(0, "SuperMissileTankScan", 1);
			GiveInventory("SuperMissileTankScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "SuperMissileAmmo_Dropped") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("SuperMissileAmmoScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Super Missiles' logged.");
			GiveActorInventory(0, "SuperMissileAmmoScan", 1); //Gives Samus the actual log
			GiveInventory("SuperMissileAmmoScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "MorphBallModel") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("MorphBallScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Morph Ball' logged.");
			GiveActorInventory(0, "MorphBallScan", 1); //Gives Samus the actual log
			GiveInventory("MorphBallScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "BombPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("BombPickupScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Bombs' logged.");
			GiveActorInventory(0, "BombPickupScan", 1); //Gives Samus the actual log
			GiveInventory("BombPickupScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "BoostBallPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff, BUT BIGGER AND STRONGER.";
			if (CheckInventory("BoostBallScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Boost Ball' logged.");
			GiveActorInventory(0, "BoostBallScan", 1);
			GiveInventory("BoostBallScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "PowerBombTankPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff, BUT BIGGER AND STRONGER.";
			if (CheckInventory("BoostBallScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Power Bombs' logged.");
			GiveActorInventory(0, "PowerBombScan", 1);
			GiveInventory("PowerBombScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "EnergyTankPickup") == 0)
		{
			if (CheckInventory("EnergyTankScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			GiveActorInventory(0, "EnergyTankScan", 1); //Gives Samus the actual log
			GiveInventory("EnergyTankScan", 1); //Gives the activator the log to comply with above check
			PrintBold(s:"Scan complete; New data for 'Energy Tank' logged.");
			break;
		}
		
		else if(StrICmp(mName, "VariaSuitPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff, BUT BIGGER AND STRONGER.";
			if (CheckInventory("VariaSuitScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Varia Suit' logged.");
			GiveActorInventory(0, "VariaSuitScan", 1);
			GiveInventory("VariaSuitScan", 1);
			break;
		}
		
		else if(StrICmp(mName, "SpeedBoosterPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("SpeedBoosterScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Speed Booster / Shinespark' logged.");
			GiveActorInventory(0, "SpeedBoosterScan", 1); //Gives Samus the actual log
			GiveInventory("SpeedBoosterScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "SpaceJumpPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("SpaceJumpScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Space Jump / Spring Ball' logged.");
			GiveActorInventory(0, "SpaceJumpScan", 1); //Gives Samus the actual log
			GiveInventory("SpaceJumpScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "HiJumpPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("HiJumpBootsScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Hi-Jump Boots' logged.");
			GiveActorInventory(0, "HiJumpBootsScan", 1); //Gives Samus the actual log
			GiveInventory("HiJumpBootsScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "ChargeBeamPickup") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			if (CheckInventory("ChargeBeamScan") > 0)
			{
				PrintBold(s:"Scan complete; Please check scan logs.");
				break;
			}
			PrintBold(s:"Scan complete; New data for 'Charge Beam' logged.");
			GiveActorInventory(0, "ChargeBeamScan", 1); //Gives Samus the actual log
			GiveInventory("ChargeBeamScan", 1); //Gives the activator the log to comply with above check
			break;
		}
		
		else if(StrICmp(mName, "YllaSymbol") == 0)
		{
			//prefix = "ITEM TYPE: ";
			//mName = "Missiles";
			//message = "They explode and stuff.";
			//if (CheckInventory("ChargeBeamScan") > 0)
			//{
			//	PrintBold(s:"Scan complete; Please check scan logs.");
			//	break;
			//}
			
			PrintBold(s:"Scan complete; New data for 'Ylla Symbol' logged.");
			Delay(35);
			break;
		}
		
		else
		{
			PrintBold(s:"Unknown entity type!");
			//Log(s:prefix);
			//Log(s:mName);
			//Log(i:tid);
			break;
		}
	}
}

script METROID_SCANTEST (int which)
{
	switch (which)
	{
		
		case 0: //Zombieman
		PrintBold(s:"Scan complete; New data for 'Former Trooper' logged.");
		GiveActorInventory(0, "ZombiemanScan", 1);
		GiveInventory("ZombiemanScan", 1);
		break;
		
		default:
		PrintBold(s:"Redundant or unknown entity type. Data not logged!");
		break;
	}	
}

script METROID_RESERVETANK (void)
{
	
	if(CheckInventory("ReserveTankAcquired") < 0)
	{
	
	for (int r=0; r<99; r++)
	{	
		if(CheckInventory("ReserveTankAcquired") == 0)
		{
			break;
		}
		
		r = APROP_Health;
		hp = hp+r;
	}
	}
}

script METROID_SCANSELECT (int onoff)
{
	
	str curWeapon;
	str oldWeapon = GetWeapon();
	
	if (curWeapon == "ScanVisorWeapon") { ACS_Execute(METROID_SCANSELECT,0, 1); }
	
	switch (onoff)
	{
		case 0:
		SetWeapon("ScanVisorWeapon");
		oldWeapon = curWeapon;
		terminate;

		case 1:
		SetWeapon(oldWeapon);
		oldWeapon = curWeapon;
		terminate;
		
	}
}

script METROID_SCANHUDCAM (int onoff)
{	
	switch (onoff)
	{
		case 0:	
			SetCameraToTexture(0, "SCVSTEX1", 15);
			terminate;
		
		case 1:
			SetCameraToTexture(0, "SCVSTEX1", 90);
			terminate;
	}
}

script 888 (void)
{
	if(CheckWeapon("ScanVisorWeapon") == TRUE)
	{
		SetResultValue(1);
		terminate;
	}
	
	else
	{
		SetResultValue(0);
		terminate;
	}
}


script "JumpCheck" Enter
{	
	int buttons;
	int velx = GetActorVelX(0);
	int vely = GetActorVelX(0);
	int velz, prevvelz;
	int pln = PlayerNumber();
	SetActorProperty(0,APROP_JumpZ,0.0);
	
	//while(CheckInventory("health") > 0)
	while (!(ClassifyActor(0) & ACTOR_WORLD))
	{
		velz = GetActorVelZ(pln);
		buttons = GetPlayerInput(-1, INPUT_BUTTONS);
			
		//if (GetActorProperty(0,APROP_Waterlevel) < 3)
		//if (CheckInventory("GravitySuitAcquired"))
		//{
		if ((CheckInventory("InGame") == 1) || (GetCVar("sv_allowjump") != 0))
		{
		
			if (buttons & BT_JUMP || velz & prevvelz == 0)
			{
				
				if (((GetActorClass(0) == "MorphBallPlayer") || (GetActorClass(0) == "MorphBallPlayerDM")) && (!CheckInventory("SpaceJumpAcquired"))) //Don't jump if we're in Morph Ball and haven't gotten Spring Ball
				{
					TakeInventory("MetCanJumpHigh",1);
					TakeInventory("MetCanJumpHighDelay",1);
					SetActorVelocity(0,velx,vely,-1,TRUE,FALSE);
				}
		
				if (!CheckInventory("MetCanJumpHighDelay") && ((GetActorZ (0) - GetActorFloorZ (0)) == 0 || CheckInventory("MetCanJumpHigh")) && GetActorVelZ(0) == 0 ) //While we can jump and player velocity is none
				{
					if(CheckInventory("HiJumpAcquired") > 0)
					{
						if((GetActorProperty(0,APROP_Waterlevel) < 3) && (GetActorClass(0) == "MorphBallPlayer") || (GetActorClass(0) == "MorphBallPlayerDM")) //Smaller jump in Spring Ball unaffected by High Jump
						{
							TakeInventory("MetCanJumpHigh",1);
							GiveInventory("MetCanJumpHighDelay",1);
							SetAirControl(0.7);
							SetActorVelocity(0,0,0,95000,TRUE,FALSE); //450000
							prevvelz = velz;
						}
					
						else //High Jump
						{
							TakeInventory("MetCanJumpHigh",1);
							GiveInventory("MetCanJumpHighDelay",1);
							SetAirControl(0.7);
							SetActorVelocity(0,0,0,250000,TRUE,FALSE); //450000
							prevvelz = velz;
						}
					}
					
					else
					{
						SetActorProperty(0,APROP_JumpZ,0.0);
						TakeInventory("MetCanJumpHigh",1);
						GiveInventory("MetCanJumpHighDelay",1);
						SetAirControl(0.7);
						SetActorVelocity(0,0,0,95000,TRUE,FALSE); //450000
						prevvelz = velz;
					}
				}
					
				if (CheckInventory("MetCanJumpHighDelay") && GetActorVelZ(0) > 0)
				{
					SetActorVelocity(0,0,0,95000,TRUE,FALSE); //95000
					prevvelz = velz;
				}
			
				//if (GetActorVelZ(0))
				if((velz == 0 || !(GetActorClass(0) == "MorphBallPlayer") || (!GetActorClass(0) == "MorphBallPlayerDM")) || (velz != 0 && (GetActorClass(0) == "MorphBallPlayer") || (GetActorClass(0) == "MorphBallPlayerDM")))
				{
					GiveInventory("MetCanJumpHigh",1);	
				}
				
				//{
				//	GiveInventory("MetCanJumpHigh",1);
				//}
			}
		}
		
			
		prevvelz = velz;
		Delay(1);		
	}
}

script "TempDropState" (int which, int a1, int a2)
{
		delay(1);
        int myx = GetActorX(0);
        int myy = GetActorY(0);
        int myz = GetActorZ(0);
        delay(10);
        SetActivatorToTarget(0);

        int maxRoll = 0;
        a1 = oldmax(1, a1);

        // TempDropState is used to tell the shit below
        //  whether an item can be dropped or not
        for (int i = 0; i < DROPCOUNT; i++)
        {
            int checkitem = MonsterDropItems[i][D_CHECKITEM];
            int checkammo = MonsterDropItems[i][D_CHECKAMMO];
            TempDropState[i] = 0;

            if (GameType() == GAME_SINGLE_PLAYER)
            {
				
                if (strcmp(checkitem, "InGame"))
                {
                    if (!CheckInventory(checkitem)) { continue; }
                }
				
				if (!strcmp(checkammo, "Health"))
                {
                    if (GetActorProperty(0, APROP_Health) >= getMaxHealth()) { continue; }
                }
				
				else if (strcmp(checkammo, ""))
					{
						if (CheckInventory(checkammo) >= GetAmmoCapacity(checkammo)) { continue; }
					}
            }
        
            maxRoll += MonsterDropChances[i][DN_PICKCHANCE];
            TempDropState[i] = 1;
        }

        maxRoll -= 1; // the range starts from 0, not 1

        if (maxRoll < 0) { terminate; }

        while (a1-- > 0)
        {
            int roll    = random(0, maxRoll);
            int curstep = 0;
            int item    = "";
            
            for (i = 0; i < DROPCOUNT; i++)
            {
                if (!TempDropState[i]) { continue; }

                curstep += MonsterDropChances[i][DN_PICKCHANCE];

                if (roll < curstep)
                {
                    if (random(0, 255) >= MonsterDropChances[i][DN_NOSPAWNCHANCE])
                    {
                        item = MonsterDropItems[i][D_DROPITEM];
                    }

                    break;
                }
            }

            if (strcmp(item, ""))
            {
                int mag   = 16 * a1;
                int ang, pitch;
                int nx, ny, nz;
                i = 0;

                do
                {
                    ang   = random(0, 1.0);
                    pitch = random(-0.25, 0.25);

                    nx = myx + (mag * FixedMul(cos(ang), cos(pitch)));
                    ny = myy + (mag * FixedMul(sin(ang), cos(pitch)));
                    nz = myz + (mag * sin(pitch));

                    i++;
                } while (!Spawn(item, nx, ny, nz) && (i < 16));
            }
        }
        terminate;
	}
