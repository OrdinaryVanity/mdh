Class MonsterDrops : EventHandler
{
    override void WorldThingDied(WorldEvent e) 
    {
		if((e.Thing && e.Thing.bISMONSTER) && !e.Thing.bBOSS)
		{
			e.Thing.ACS_NamedExecute("TempDropState",0,0,0);
		}
		
		if(e.Thing && e.Thing.bBOSS)
		{
			for (int i = 32; i > 0; i--)
			{
				e.Thing.A_SpawnItemEx("EnemyDropSpawner",random(-100,100),random(-100,100),random(10,100),0,0,0,0,32,32);
			}
		}
	}
}