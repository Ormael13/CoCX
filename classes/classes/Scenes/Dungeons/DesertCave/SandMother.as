package classes.Scenes.Dungeons.DesertCave
{
	import classes.*;

	public class SandMother extends Monster
	{
		//Notes:
		//Starts combat with sandstorm.  GigaFire's every fifth round.
		//Whispers every fourth.
		public function sandWitchMotherAI():void {
			if (findStatusEffect(StatusEffects.Sandstorm) < 0) {
				sandStormAttack();
				return;
			}
			if (findStatusEffect(StatusEffects.Gigafire) >= 0) {
				gigaFire2();
				return;
			}
			var choices:Array = [];
			if (player.findStatusEffect(StatusEffects.Whispered) < 0) choices[choices.length] = getWhispered;
			choices[choices.length] = eatALightningBolt;
			choices[choices.length] = sandMotherTelekinesis;
			choices[choices.length] = gigaFire;
			choices[choices.length] = earthShield;
			choices[rand(choices.length)]();
		}
		//Earthshield
		public function earthShield():void {
			//Surrounds the witch a vortex of stones, raising her defense greatly and conferring 25% block to standard attacks.
			outputText("Lowering her scepter towards the ground, the eight-foot tall sorceress suddenly grunts, lifting it as if carrying great weight.  As the small staff passes her chest, bits of stone and rock begin to lift out of the ground, accelerating into a vortex of earth that spins around her.  <b>It's going to be harder to hit her with physical attacks now!</b>");
			createStatusEffect(StatusEffects.Earthshield,0,0,0,0);
			combatRoundOver();
		}
		//*GigaFire
		public function gigaFire():void {
			//Begins focusing into her staff, which floats in front of her.  PC disrupt attack by attacking.  Attack hits at half strength if disrupted.
			outputText("Releasing the scepter, the Sand Mother spreads her hands, each glowing with eldritch, white flames.  Her heels slowly float up off the ground as she closes her eyes in concentration.  You can sense the power and heat rolling off her in waves, and if you don't do something to disrupt her, you'll likely be burned to a crisp.");
			if (player.inte > 40) outputText("  She's not even looking at you and seems steeled against lusty interruptions.  Perhaps you can hit her hard enough to shatter her concentration.");
			createStatusEffect(StatusEffects.Gigafire,0,0,0,0);
			combatRoundOver();
		}
		public function gigaFire2():void {
			var damage:int = 40 + rand(11);
			//Not interrupted:
			if (statusEffectv1(StatusEffects.Gigafire) < 10) {
				outputText("The Sand Mother grabs her scepter in both hands, combining the flames that wreath them into an immense, blinding conflagration.  She points at you, and the fire washes out in a wave like a serpent, twisting at you as you try to avoid it, doubling back on itself whenever it misses.  It's unavoidable!  You're enveloped in the consuming fire!");
				damage *= 3;
			}
			//Interrupted:
			else {
				outputText("Thumbling back to the ground from your damaging hit, the Sand Mother grabs at her head, one flame going out.  She recovers in time to grab the staff and fling it towards you, but it's at a fraction of the strength she intended.  Still, it burns all the same. ");
			}
			damage = player.takeDamage(damage, true);
			removeStatusEffect(StatusEffects.Gigafire);
			combatRoundOver();
		}
			
		//*Telekinesis
		//Throws the PC against the wall.  Does more damage to shorter, thinner PCs.
		public function sandMotherTelekinesis():void {
			outputText("She narrows her eyes at you, and an immense, magical pressure reaches out, taking hold of you.  It spins you in the air before slamming you into the walls!");
			
			var sizeMod:Number = 100;
			var thickMod:Number = player.thickness / 100 + 0.5;
			sizeMod += player.tallness * thickMod;
			if (sizeMod < 140) outputText("  You immediately wish you weren't so small, as you're sure she couldn't have flung a heavier champion nearly as easily. ");
			else if (sizeMod >= 200) outputText("  You're glad for your size, as she couldn't seem to accelerate you into the stone as fast as she'd like.  Sometimes eating plenty pays off. ");
			//0 thickness, 4' tall: 124
			//100 thickness, 4' tall: 172
			//0 thickness, 6' tall: 136
			//100 thickness, 6' tall: 208
			//0 thickness, 8' tall: 148
			//100 thickness, 8' tall: 244
			var multiplier:Number = sizeMod / 170;
			var damage:Number = 20;
			damage = multiplier * damage;
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}
		
		//*Lightning Bolt
		//Unavoidable magic damage.
		public function eatALightningBolt():void {
			outputText("Holding her staff back, she lifts her free hand with her fingers outstretched in a fan.  Sparks dance between her slender digits, coiling around them like snakes.  In a flash, they rush to her palm and erupt in a lightning bolt, striking you instantly and unavoidably! ");
			var damage:int = 30 + rand(10);
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}
		//*Whisper:
		//As ackbal, stuns the PC 1 round.  Cannot be resisted.
		public function getWhispered():void {
			outputText("Mouthing, \"<i>Can you hear me?</i>\" the witch's voice intrudes into your mind, matching her mouth word for word.  She floods your psyche with words and thoughts, all of your defeat or submission, each more degrading and more humiliating than the last.  Perhaps the worst are the ones where she turns you over to Lethice after you're broken...  The tumultous thoughts and emotions both stun and arouse you, preventing you from attacking while you try to clear your beleaguered consciousness.");
			player.createStatusEffect(StatusEffects.Whispered,0,0,0,0);
			game.dynStats("lus", 15);
			combatRoundOver();
		}
		public function sandStormAttack():void {
			outputText("With a smirk, the Sand Mother decrees, \"<i>You fight not just me, but the shifting sands as well.</i>\"  She casually flicks her wrist, and sand rises up from the floors, the walls, everywhere really.  It begins to spin about, blown by an unseen wind, and the entire chamber is wreathed in a shifting sandstorm.  The grit constantly tries to get into your eyes.  It's likely you're going to be blinded by it every now and then.");
			createStatusEffect(StatusEffects.Sandstorm,0,0,0,0);
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.desertcave.defeatTheSandMother();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.desertcave.loseToTheSandMother();
		}
		
		public function SandMother()
		{
			this.a = "the ";
			this.short = "Sand Mother";
			this.imageName = "sandmother";
			this.long = "The Sand Mother is a towering woman of imposing stature and bust.  She wears a much silkier, regal-looking robe than her sisters, and it barely serves to contain her four milk-laden breasts, straining under their jiggling weight.  Dangling around her in a way that reminds you oddly of a halo, the Sand Mother's blonde-white hair fans around her, hanging long behind her.  The queen witch is brandishing a pearly white scepter rather threateningly, though from the way she holds it, it's clear she doesn't intend to use it as a physical weapon.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 70, 0, 0, 0);
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,50,0,0,0);
			this.tallness = 8*12+6;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "bronzed";
			this.hairColor = "platinum-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(55, 55, 35, 45);
			initLibSensCor(55, 40, 30);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "robes";
			this.armorDef = 1;
			this.bonusHP = 130;
			this.lust = 20;
			this.lustVuln = .6;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 7;
			this.gems = rand(15) + 55;
			this.createPerk(PerkLib.Resolute,0,0,0,0);
			this.createPerk(PerkLib.Focused,0,0,0,0);
			this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			this.drop = NO_DROP;
			checkMonster();
		}
		
	}

}