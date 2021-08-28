#library "Movement"
#include "zcommon.acs"

script "PlayerMovement" ENTER
{
	While (TRUE)
	{
		int X, Y, Z, Speed, ZVelocity, MoveForce;
		bool WalkSwitch;
		
		X = GetActorVelX(0);
		Y = GetActorVelY(0);
		Z = GetActorVelZ(0);
		Speed = FixedMul(X, X) + FixedMul(Y, Y) + FixedMul(Z, Z);
		ZVelocity = z >> 16;
		MoveForce = GetPlayerInput(-1,MODINPUT_FORWARDMOVE);
		
		if (MoveForce <= 6400 && MoveForce >= -6400)
			WalkSwitch = TRUE;
		else
			WalkSwitch = FALSE;
			
		if( !GetUserVariable(0, "user_isdead")==1 && !GetUserVariable(0, "user_isplayerbusy")==1 )
		{
			if (WalkSwitch)
			{
				if (GetUserVariable(0, "user_isrunningback")==1)
					SetUserVariable(0, "user_isrunningback",0);
				if (GetUserVariable(0, "user_isrunningforward")==1)
					SetUserVariable(0, "user_isrunningforward",0);

				if ( MoveForce > 1 && !GetUserVariable(0, "user_iswalkingforward")==1 )
				{
					SetActorState(0,"See.Walk");
					SetUserVariable(0, "user_iswalkingforward",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if (MoveForce < -1 && !GetUserVariable(0, "user_iswalkingback")==1 )
				{
					SetActorState(0,"RunBack.Walk");
					SetUserVariable(0, "user_iswalkingback",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( MoveForce > 1 && GetUserVariable(0, "user_iswalkingback")==1 )
				{
					SetActorState(0,"See.Walk");
					SetUserVariable(0, "user_iswalkingback",0);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( Speed < 1.0 && !GetUserVariable(0, "user_istaunting")==1 )
				{
					SetActorState(0,"Spawn",1);
					SetUserVariable(0, "user_iswalkingback",0);
					SetUserVariable(0, "user_iswalkingforward",0);
				}
			}
			
			else
			{
				if (GetUserVariable(0, "user_iswalkingback")==1)
					SetUserVariable(0, "user_iswalkingback",0);
				if (GetUserVariable(0, "user_iswalkingforward")==1)
					SetUserVariable(0, "user_iswalkingforward",0);
					
				if ( MoveForce > 1 && !GetUserVariable(0, "user_isrunningforward")==1 )
				{
					SetActorState(0,"See");
					SetUserVariable(0, "user_isrunningforward",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if (MoveForce < -1 && !GetUserVariable(0, "user_isrunningback")==1 )
				{
					SetActorState(0,"RunBack");
					SetUserVariable(0, "user_isrunningback",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( MoveForce > 1 && GetUserVariable(0, "user_isrunningback")==1 )
				{
					SetActorState(0,"See");
					SetUserVariable(0, "user_isrunningback",0);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( Speed < 4.0 && !GetUserVariable(0, "user_istaunting")==1 )
				{
					SetActorState(0,"Spawn",1);
					SetUserVariable(0, "user_isrunningback",0);
					SetUserVariable(0, "user_isrunningforward",0);
				}
			}

			if ( ZVelocity > 1 )
			{
				SetUserVariable(0, "user_istaunting",0);
				
				if (MoveForce < -1)
				{
					SetActorState(0,"JumpLoop.Back",1);
					SetUserVariable(0, "user_isplayerbusy",1);
				}
				
				else
				{
					SetActorState(0,"JumpLoop");
					SetUserVariable(0, "user_isplayerbusy",1);
				}
			}
			
			if ( ZVelocity < -6 )
			{
				SetUserVariable(0, "user_istaunting",0);
				
				if (MoveForce < -1)
				{
					SetActorState(0,"JumpLoop.Back",1);
					SetUserVariable(0, "user_isplayerbusy",1);
				}
				
				else
				{
					SetActorState(0,"JumpLoop");
					SetUserVariable(0, "user_isplayerbusy",1);
				}
			}

			if ( GetActorProperty(0,APROP_Waterlevel)>=2 )
			{
				SetActorState(0,"Swim");
				SetUserVariable(0, "user_isplayerbusy",1);
				SetUserVariable(0, "user_istaunting",0);
			}
		}

		Delay(1);
	}
}

script "HubPlayerMovement" RETURN
{
	While (TRUE)
	{
		int X, Y, Z, Speed, ZVelocity, MoveForce;
		bool WalkSwitch;
		
		X = GetActorVelX(0);
		Y = GetActorVelY(0);
		Z = GetActorVelZ(0);
		Speed = FixedMul(X, X) + FixedMul(Y, Y) + FixedMul(Z, Z);
		ZVelocity = z >> 16;
		MoveForce = GetPlayerInput(-1,MODINPUT_FORWARDMOVE);
		
		if (MoveForce <= 6400 && MoveForce >= -6400)
			WalkSwitch = TRUE;
		else
			WalkSwitch = FALSE;
			
		if( !GetUserVariable(0, "user_isdead")==1 && !GetUserVariable(0, "user_isplayerbusy")==1 )
		{
			if (WalkSwitch)
			{
				if (GetUserVariable(0, "user_isrunningback")==1)
					SetUserVariable(0, "user_isrunningback",0);
				if (GetUserVariable(0, "user_isrunningforward")==1)
					SetUserVariable(0, "user_isrunningforward",0);

				if ( MoveForce > 1 && !GetUserVariable(0, "user_iswalkingforward")==1 )
				{
					SetActorState(0,"See.Walk");
					SetUserVariable(0, "user_iswalkingforward",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if (MoveForce < -1 && !GetUserVariable(0, "user_iswalkingback")==1 )
				{
					SetActorState(0,"RunBack.Walk");
					SetUserVariable(0, "user_iswalkingback",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( MoveForce > 1 && GetUserVariable(0, "user_iswalkingback")==1 )
				{
					SetActorState(0,"See.Walk");
					SetUserVariable(0, "user_iswalkingback",0);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( Speed < 1.0 && !GetUserVariable(0, "user_istaunting")==1 )
				{
					SetActorState(0,"Spawn",1);
					SetUserVariable(0, "user_iswalkingback",0);
					SetUserVariable(0, "user_iswalkingforward",0);
				}
			}
			
			else
			{
				if (GetUserVariable(0, "user_iswalkingback")==1)
					SetUserVariable(0, "user_iswalkingback",0);
				if (GetUserVariable(0, "user_iswalkingforward")==1)
					SetUserVariable(0, "user_iswalkingforward",0);
					
				if ( MoveForce > 1 && !GetUserVariable(0, "user_isrunningforward")==1 )
				{
					SetActorState(0,"See");
					SetUserVariable(0, "user_isrunningforward",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if (MoveForce < -1 && !GetUserVariable(0, "user_isrunningback")==1 )
				{
					SetActorState(0,"RunBack");
					SetUserVariable(0, "user_isrunningback",1);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( MoveForce > 1 && GetUserVariable(0, "user_isrunningback")==1 )
				{
					SetActorState(0,"See");
					SetUserVariable(0, "user_isrunningback",0);
					SetUserVariable(0, "user_istaunting",0);
				}
				
				if ( Speed < 4.0 && !GetUserVariable(0, "user_istaunting")==1 )
				{
					SetActorState(0,"Spawn",1);
					SetUserVariable(0, "user_isrunningback",0);
					SetUserVariable(0, "user_isrunningforward",0);
				}
			}

			if ( ZVelocity > 1 )
			{
				SetUserVariable(0, "user_istaunting",0);
				
				if (MoveForce < -1)
				{
					SetActorState(0,"JumpLoop.Back",1);
					SetUserVariable(0, "user_isplayerbusy",1);
				}
				
				else
				{
					SetActorState(0,"JumpLoop");
					SetUserVariable(0, "user_isplayerbusy",1);
				}
			}
			
			if ( ZVelocity < -6 )
			{
				SetUserVariable(0, "user_istaunting",0);
				
				if (MoveForce < -1)
				{
					SetActorState(0,"JumpLoop.Back",1);
					SetUserVariable(0, "user_isplayerbusy",1);
				}
				
				else
				{
					SetActorState(0,"JumpLoop");
					SetUserVariable(0, "user_isplayerbusy",1);
				}
			}

			if ( GetActorProperty(0,APROP_Waterlevel)>=2 )
			{
				SetActorState(0,"Swim");
				SetUserVariable(0, "user_isplayerbusy",1);
				SetUserVariable(0, "user_istaunting",0);
			}
		}

		Delay(1);
	}
}

//On death and respawn, ensure to not bug states causing the player to "die standing still"
Script "PlayDying" DEATH
{
	SetUserVariable(0, "user_isrunningback",0);
	SetUserVariable(0, "user_isrunningforward",0);
	SetUserVariable(0, "user_iswalkingback",0);
	SetUserVariable(0, "user_iswalkingforward",0);
	SetUserVariable(0, "user_isplayerbusy",0);
	SetUserVariable(0, "user_istaunting",0);
	SetUserVariable(0, "user_isdead", 1);
}

script "PlayRespawn" RESPAWN
{
	SetUserVariable(0, "user_isdead", 0);
}