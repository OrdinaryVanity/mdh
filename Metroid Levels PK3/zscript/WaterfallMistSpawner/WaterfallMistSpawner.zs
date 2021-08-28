Class WaterfallFogSpawner : Actor {
Default{ 
//$Category Metroid 
}
	int wwidth;
	override void PostBeginPlay() {
		super.PostBeginPlay();		
		wwidth = Clamp(args[0],0,1024) / 16;
	}
	override void Tick() {
		if (isFrozen())
			return;
		for (int steps = wwidth; steps >= 0; steps--) {
			//for (int i = random[fog](1,4); i > 0; i--) {
				let fog = Spawn("WaterfallFog",pos);
				if (fog) {
					fog.Warp(self,16 * steps);
					fog.SetOrigin(fog.pos + (frandom[fog](-8,8),frandom[fog](-8,8),frandom[fog](-8,8)),false);
					fog.vel = (frandom[fog](-1,1),frandom[fog](-1,1),frandom[fog](0.6,2));					
				}
			//}
		}
	}
}

Class WaterfallFog : Actor {
	Default {
		renderstyle 'Translucent';
		alpha 0.4;
		scale 0.2;
		gravity 0.2;
		+ROLLSPRITE
	}
	override void PostBeginPlay() {
		super.PostBeginPlay();
		roll = frandom[fog](-40,40);
		frame = random[fog](0,2);
	}
	override void Tick() {
		if (isFrozen())
			return;
		vel.z -= gravity;
		SetOrigin(pos+vel,true);
		scale *= 1.03;
		A_FadeOut(0.02);
	}
	states {
	Spawn:
		WFSP # 1;
		loop;
	}
}