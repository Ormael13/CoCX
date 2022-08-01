package classes.Scenes.Dungeons.DemonLab 
{
	/**
	 * ...
	 * @author ...
	 */
	public class IncubusScientist 
	{
		
		public function IncubusScientist() 
		{
		this.short = "incubus Scientist";
		this.long = "This demon is clad in a heavy-looking lab coat, and wears a strange pistol at his hip. Weedy and thin, he doesn't look like he's much of a fighter, but the anger in his gaze is a clear indicator of his intent. He wears an odd contraption on his left hand, 
				initStrTouSpeInte(150, 100, 130, 305);
				initWisLibSensCor(105, 190, 110, 100);
				this.weaponAttack = 86;
				this.armorDef = 38;
				this.armorMDef = 23;
				this.bonusHP = 500;
				this.bonusLust = 206;
				this.level = 40;
				this.additionalXP = 50;
			    this.gems = rand(30) + 15;
				this.createPerk(PerkLib.OverMaxHP, 26, 0, 0, 0);	
		}
		private function ForHisNeutralSpecialHeWieldsAGun {
		outputText("The demon scientist lines you up in his sights, pulling the trigger several times.")
		//Miss:
			//Determine if evaded
			if(player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
				outputText("You dodge the bullets, and they fly past, taking small chunks out of the stone wall behind you.");
			}
			//("Misdirection"
			else if(player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
				outputText("Using your talent for misdirection, You dodge the bullets, and they fly past, taking small chunks out of the stone wall behind you.");
			}
			//Determine if cat'ed
			else if(player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
				outputText("Using your cat-like flexibility, you manage to bend your spine, dodging the bullets. They fly past, taking small chunks out of the stone wall behind you.");
				
			}
			else {
				var damage:Number = Math.round(90 + rand(10) + (player.newGamePlusMod() * 30));
				damage = finalizeDamage(damage);
				outputText("You can’t even see the projectile as it flies, striking you in the [chest].");
				createStatusEffect(StatusEffects.Attacks, 2 + rand(2),0,0,0);
				outputText("\n");
			}
		}
		private function ShieldsUp {
		outputText("(Priority if it is available and he has no shield) You notice the demon touch something in his lab coat. A thin veil of blue energy forms around him, and he smirks. “Break this, you primitive!” \n\n"); 
		var ShieldHits = 4;
		}
		private function ShieldsHitMelee {
		outputText("Your [weapon] slams hard into the blue light, sliding off it with a shower of sparks. \n\n"); 
		var ShieldHits --; 
		if ShieldHits = 3 {
		outputText("The shield is firm, it’s like hitting a wall! \n\n"); 
		}
		else if ShieldHits = 2 {
		outputText("The light bends to your attack, but springs right back into place. \n\n"); 
		}
		else if ShieldHits = 1 {
		outputText("The shield flashes red, and the demon scientist takes a half-step back, the ferocity of your strike seeming to get to him. \n\n"); 
		}
		else if ShieldHits = 0 {
		var ShieldCooldown:Number = 3
		outputText("You drive your [weapon] through the shield. The demon’s eyes are wide, and he inhales sharply. He presses the button in his coat, but no shield comes back into place. Smoke rises from his coat, and he plants his feet, grinding his teeth.  \n\n"); 
		}
		}

		private function ShieldsHitRanged {
		outputText("Your [weapon] slams hard into the blue light, sliding off it with a shower of sparks. \n\n"); 
		var ShieldHits --; 
		if ShieldHits = 3 {
		outputText("Your [projectile] strikes the demon scientist, but he doesn’t even seem to notice the strike. He laughs, raising his pistol and taking another shot at you. \n\n");
		createStatusEffect(StatusEffects.Attacks, 1,0,0,0);
		}
		else if ShieldHits = 2 {
		outputText("Your [projectile] strikes the demon scientist, but his shield flashes, blocking the attack. He frowns, raising his pistol and taking another shot at you.\n\n"); 
		createStatusEffect(StatusEffects.Attacks, 1,0,0,0);
		}
		else if ShieldHits = 1 {
		outputText("Your [projectile] strikes the demon scientist's shield, which is visibly cracking'. He sweats, raising his pistol and taking another shot at you.\n\n"); 
		createStatusEffect(StatusEffects.Attacks, 1,0,0,0);
		}
		else if ShieldHits = 0 {
		var ShieldCooldown:Number = 3
		outputText(" The shield shatters, and your (projectile) lands. He looks down at the (projectile) in his gut\n\n"); 
		}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.DemonLab.AfterLabGuardsVictory();
		}
override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.DemonLab.BadEndExperiment();
		}
		override protected function performCombatAction():void {
clearOutput();
if var ShieldCooldown > 0 {
	var ShieldCooldown --
}
				var choice0:Number = rand(2);
				switch (choice0) {
					case 0:
						ForHisNeutralSpecialHeWieldsAGun();
						break;
					case 1:
						ShieldsUp();
						break;
				}
		}
	}

}