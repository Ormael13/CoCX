package classes.Scenes.Dungeons.HelDungeon
{
	import classes.*;

	public class HarpyQueen extends Monster
	{
		public function harpyQueenAI():void {
			if (rand(4) == 0) eldritchRopes();
			else if (rand(2) == 0) lustSpikeAttack();
			else windSlamAttack();
		}
		//ATTACK ONE: ELDRITCH ROPES
		public function eldritchRopes():void {
			outputText("The Harpy Queen flicks her left wrist at you. Before you can blink, ropes of white-hot magic hurtle toward you. You manage to duck and dodge a few of them, but a pair still grab your wrists, pulling painfully at your arms.");
			//(Effect: Grab + Physical Damage)
			var damage:int = 25 + rand(10);
			damage = player.takeDamage(damage, true);
			createStatusEffect(StatusEffects.QueenBind,0,0,0,0);
			combatRoundOver();
		}

		public function ropeStruggles(wait:Boolean = false):void {
			clearOutput();
			//Struggle Fail: 
			if (rand(10) > 0 && player.str/5 + rand(20) < 23 || wait) {
				outputText("You give a mighty try, but cannot pull free of the magic ropes!  The Harpy Queen laughs uproariously, pulling at your arms harder.");
				if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {var damage:int = 25 + rand(10);
				damage = player.takeDamage(damage, true);
				}
			}
			else {
				outputText("With supreme effort, you pull free of the magic ropes, causing the queen to tumble to her hands and knees.");
				removeStatusEffect(StatusEffects.QueenBind);
			}
			combatRoundOver();
		}

		//ATTACK TWO: LUST SPIKE
		public function lustSpikeAttack():void {
			outputText("The Harpy Queen draws a strange arcane circle in the air, lines of magic remaining wherever the tip of her staff goes.  You try to rush her, but the circle seems to have created some kind of barrier around her.  You can only try to force it open - but too late!  A great pink bolt shoots out of the circle, slamming into your chest.  You suddenly feel light-headed and so very, very horny...");
			//(Effect: Heavy Lust Damage)
			game.dynStats("lus", 40);
			combatRoundOver();
		}

		//ATTACK THREE: Wind Slam!
		public function windSlamAttack():void {
			outputText("The queen swings her arm at you and, despite being a few feet away, you feel a kinetic wall slam into you, and you go flying - right into the harpy brood!  You feel claws, teeth and talons dig into you, but you're saved by a familiar pair of scaled arms.  \"<i>Get back in there!</i>\" Helia shouts, throwing you back into the battle!");
			//(Effect; Heavy Damage)
			var damage:Number = 100 + rand(50);
			damage = player.takeDamage(damage, true);
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			harpyQueenAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.heltower.harpyQueenDefeatedByPC();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.dungeons.heltower.harpyQueenBeatsUpPCBadEnd();
		}

		public function HarpyQueen()
		{
			this.a = "the ";
			this.short = "Harpy Queen";
			this.imageName = "harpyqueen";
			this.long = "You face the Harpy Queen, a broodmother of epic proportions - literally.  Her hips are amazingly wide, thrice her own width at the least, and the rest of her body is lushly voluptuous, with plush, soft thighs and a tremendous butt.  Her wide wings beat occasionally, sending ripples through her jiggly body.  She wields a towering whitewood staff in one hand, using the other to cast eldritch spells.";
			// this.plural = false;
			this.createVagina(false, VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.tallness = rand(8) + 70;
			this.hipRating = HIP_RATING_AMPLE+2;
			this.buttRating = BUTT_RATING_LARGE;
			this.lowerBody = LOWER_BODY_TYPE_HARPY;
			this.skinTone = "red";
			this.skinType = SKIN_TYPE_PLAIN;
			this.skinDesc = "feathers";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(70, 60, 120, 40);
			initLibSensCor(40, 45, 50);
			this.weaponName = "eldritch staff";
			this.weaponVerb="thwack";
			this.weaponAttack = 20;
			this.armorName = "armor";
			this.armorDef = 20;
			this.bonusHP = 1000;
			this.lust = 20;
			this.lustVuln = .15;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 20;
			this.gems = rand(25) +160;
			this.additionalXP = 50;
			this.tailType = TAIL_TYPE_HARPY;
			this.wingType = WING_TYPE_FEATHERED_LARGE;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.ImprovedSelfControl, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
