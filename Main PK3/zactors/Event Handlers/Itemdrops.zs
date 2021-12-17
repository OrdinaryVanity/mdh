Class MonsterDrops : EventHandler
{
    override void WorldThingDied(WorldEvent e) 
    {
		let plr = players[e.Player].mo;
		if((e.Thing.bISMONSTER) && !e.Thing.bBOSS)
		{
			//e.Thing.ACS_NamedExecute("TempDropState",0,0,0);
			e.Thing.A_SpawnItemEx("EnemyDropSpawner",random(-100,100),random(-100,100),random(10,100),0,0,0,0,32,32);
		}
		
		if(e.Thing.bBOSS)
		{
			if(plr.FindInventory("SuperMissileAcquired"))
			{
				for(int i = 15; i > 0; i--)
				{
					e.Thing.A_SpawnItemEx("EnemyDropSpawnerB",random(-100,100),random(-100,100),random(10,100),0,0,0,0,32,32);
				}
				return;
			}
				
			else if(plr.FindInventory("PowerBombAcquired"))
			{
				for(int i = 15; i > 0; i--)
				{
					e.Thing.A_SpawnItemEx("EnemyDropSpawnerB",random(-100,100),random(-100,100),random(10,100),0,0,0,0,32,32);
				}
				return;
			}
			
			else if(plr.FindInventory("PowerBombAcquired") && plr.FindInventory("SuperMissileAcquired"))
			{
				for(int i = 15; i > 0; i--)
				{
					e.Thing.A_SpawnItemEx("EnemyDropSpawnerC",random(-100,100),random(-100,100),random(10,100),0,0,0,0,32,32);
				}
				return;
			}
			
			else
			{
				for(int i = 15; i > 0; i--)
				{
					e.Thing.A_SpawnItemEx("EnemyDropSpawner",random(-100,100),random(-100,100),random(10,100),0,0,0,0,32,32);
				
				}
				return;
			}
		}
	}
}