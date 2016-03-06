package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.internals.WeightedDrop;
	import classes.GlobalFlags.kFLAGS;
	
	public class FrostGiant extends Monster
	{
		private function giantStrengthLoss(magnitude:int = 0):void {
			game.dynStats("str", -magnitude);
			player.addStatusValue(StatusEffects.GiantStrLoss, 2, magnitude);
		}
		
		public function giantAttackPunch():void {
			var damage:int = 0;
			outputText("The giant strides toward you, closing the distance faster than you can run. He rears back and strikes at you!  ");
			if (player.getEvasionRoll()) {
				outputText("You deftly dodge the jumbo Jotun's paltry punch, spinning swiftly to charge your " + player.weaponName + " at his hand, leaving what looks like a crack. The giant roars in outrage, shaking snow from trees and making your " + player.armorName + " vibrate. He appears angrier than before.");
			}
			else {
				if (rand(player.spe + 40) < spe) {
					outputText("You take the full force of his grand slam, sending you flying a good 40 feet, plunging through a snowdrift. As you right yourself, his laugh shakes the ground, \"<i>Puny! Haaaa!</i>\" ");
					damage = ((str + 50) + rand(100))
					damage = player.reduceDamage(damage);
					if (damage < 40) damage = 40;
					player.takeDamage(damage, true);
				}
				else {
					outputText("You nearly avoid the giant's fist, stumbling as you regain your footing. The giant's growl is a deep bass as he bellows, \"<i>Bah! Luck!</i>\" ");
					damage = rand(str);
					damage = player.reduceDamage(damage);
					player.takeDamage(damage, true);
				}
			}
			combatRoundOver();
		}
		
		public function giantGrab():void {
			outputText("The giant yells something you don't understand and charges at you, hands outstretched!  ");
			if (player.getEvasionRoll()) {
				outputText("You ");
				if (rand(player.spe) < spe) outputText("barely"); 
				else outputText("ably"); 
				outputText(" avoid his charge, jumping just in time to avoid his hands, and then his feet. He's unable to stop himself in time and collides head first with a boulder slightly smaller than his head. ");
				var giantDmg:Number = 10 + rand(20);
				HP -= giantDmg;
				outputText("The giant takes <b><font color=\"#800000\">" + giantDmg + "</font></b> damage from his impact.  ");
				outputText("<b>The giant is stunned!</b>");
				createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			else {
				outputText("Your attempt to make way fails, and the giant grabs you in his very large, very cold, very strong hands. \"<i>Now, you die!</i>\"");
				player.createStatusEffect(StatusEffects.GiantGrabbed, 2, 0, 0, 0);
				if (player.findStatusEffect(StatusEffects.GiantStrLoss) < 0) player.createStatusEffect(StatusEffects.GiantStrLoss, 0, 0, 0, 0);
			}
			combatRoundOver();
		}
		public function giantGrabStruggle():void {
			if (rand(100) >= player.str || rand(10) == 0) giantGrabFail();
			else giantGrabSuccess();
		}
		public function giantGrabFail(struggle:Boolean = true):void {
			var damage:int = 0
			if (struggle) {
				clearOutput();
				if (player.str >= 80) {
					outputText("You push and pull and squeeze and worm with all your might, but all that does is make the giant's grip harder. ");
				}
				else if (player.str >= 60 && player.str < 80) {
					outputText("Your strength fails to help you escape this frosty situation, though the heat from the struggle is nice enough in this wasteland to nearly doze in it. The giant makes sure that doesn't happen, though. ");
					giantStrengthLoss(1);
				}
				else if (player.str >= 40 && player.str < 60) {
					outputText("Try as you might, the giant's grip is too much for your weak body; the best you can do is a few squirms and a shake. His grip remains as tough as ever. ");
					giantStrengthLoss(2);
				}
				else if (player.str >= 20 && player.str < 40) {
					outputText("The giant's grip nearly crushes you to bits right there; sheer force of will allows you to struggle and resist, though it proves futile. ");
					if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {damage = 10 + rand(str * 0.5);
					player.takeDamage(damage, true);
					}
				}
				else if (player.str < 20) {
					outputText("The giant squeezes you mercilessly, the pressure on your body reaching critical levels. The giant doesn't seem to want to murder you, fortunately, so he lessens his grip slightly. No dice escaping it though. ");
					if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {damage = 20 + rand(str * 0.75);
					player.takeDamage(damage, true);
					}
				}
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("The thought of being constricted turns you on a bit. ")
					game.dynStats("lust", 5);
				}
				outputText("\n\n");
			}
			else {
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("The thought of being constricted turns you on a bit. ")
					game.dynStats("lust", 5);
				}
				outputText("\n\n");
			}
			switch(rand(6)) {
				case 0:
				case 1:
				case 2: //Taunt
					outputText("\"<i>Ha, ha, ha! Puny little " + player.race() + "! You cannot escape my grasp!</i>\" He flicks your head, nearly snapping your neck, and you see stars for a moment. ")
					player.removeStatusEffect(StatusEffects.GiantGrabbed);
					damage = 10 + rand(str * 0.5);
					damage = player.reduceDamage(damage);
					player.takeDamage(damage, true);
					combatRoundOver();
					break;
				case 3:
				case 4: //Ground Pound
					outputText("The giant brings you to his face to yell at you. His scream is probably the loudest thing you've ever heard, and while your ears are still ringing he raises you up, and up, and up and then punches the ground with all his might. ");
					outputText("The force of the punch leaves you reeling for a time; you come to your senses before he tries to do anything else. ");
					player.removeStatusEffect(StatusEffects.GiantGrabbed);
					damage = 100 + rand(str * 1.5);
					damage = player.reduceDamage(damage);
					player.takeDamage(damage, true);
					combatRoundOver();
					break;
				case 5: //Throw
					outputText("\"<i>Oh, little " + player.race() + " wants to be let go? Ha! Then GO!</i>\" He rears back and chucks you as hard as he can against the nearest rock face. Fortunately, his aim is off and he throws you into a patch of snow. The snow helps cushion the impact, but you're still very disoriented. ");
					player.removeStatusEffect(StatusEffects.GiantGrabbed);
					player.createStatusEffect(StatusEffects.Stunned, 1 + rand(2), 0, 0, 0);
					damage = 20 + rand(str);
					damage = player.reduceDamage(damage);
					if (damage < 20) damage = 20;
					player.takeDamage(damage, true);
					combatRoundOver();
					break;
				default:
					combatRoundOver();
			}
		}
		public function giantGrabSuccess():void {
			clearOutput();
			if (player.str >= 100) outputText("You roar and force the giant's hand open. He gasps in surprise, using his other hand to close you in, but it's too late by then. You jump to the ground and roll away, readying for your next attack. ");
			if (player.str >= 80 && player.str < 100) outputText("You push, pull, squeeze, squirm and finally you escape the giant's grasp. You drop and roll and make distance before readying your weapon. ");
			if (player.str >= 60 && player.str < 80) outputText("With no small effort, you  pop out from the giant's clench. You run up his arm and jump down his back, making distance. ")
			if (player.str >= 40 && player.str < 60) outputText("Despite the cold, hard confines of the giant's hand, you manage to slip out of his hand and fall to the ground before scrambling up and running from the angry giant. ");
			if (player.str >= 20 && player.str < 40) outputText("Body aching, you exploit a light grip for a moment and drop to the ground with a hard thud. Forcing yourself to get up and MOVE, you run as quickly as your throbbing [ass] can handle. ");
			if (player.str < 20) {
				outputText("Struggling with every fiber of your being, you manage to tickle the giant into dropping you. Slightly embarrassed, you get as far away from the giant without running away as you can, and ready your weapon. You think it wise to try to escape. ");
			}
			player.removeStatusEffect(StatusEffects.GiantGrabbed);
			combatRoundOver();
		}
		
		public function giantBoulderThrow():void {
			outputText("The giant walks over to a boulder much larger than you and hefts it up. You had better wait and be ready to dodge, or this could be very bad. ");
			outputText("<b>With a grunt and a shove, the giant throws the boulder directly at you!</b>")
			if (player.findStatusEffect(StatusEffects.GiantBoulder) < 0) player.createStatusEffect(StatusEffects.GiantBoulder, 0, 0, 0, 0);
			combatRoundOver();
		}
		public function giantBoulderFantasize():void {
			outputText("You wonder how you could fuck something so large. ");
			if (player.cocks.length > 0) {
				if (player.biggestCockArea() >= 24) {
					outputText("Oh wait, you could just fuck his ass with your ");
					if (player.cocks.length > 1) outputText("collection of dicks. ");
					else outputText(" one really big cock. "); 
					outputText("He might have a nice nose... You try to get a size of his nose. He’s too far away to gauge it");
				}
				else if (player.biggestCockArea() < 24) {
					outputText("You suppose you could try to fuck a smaller hole that's not usually used for sex... Maybe his nose? You can't quite make out the size of his nostrils from here")
				}
			}
			else {
				outputText("You could just crawl onto some part of him and rub, though he looks very cold to be doing something like that. You wonder if there's not a way to fuck something else... Maybe his nose? You can't tell if it has a prominent tip from here");
			}
			giantBoulderHit(1);
		}
		public function giantBoulderHit(mode:int = 0):void {
			clearOutput();
			if (mode == 0) outputText("You charge at the giant, running as fast as you can, hoping to get to him before he can throw the huge rock. However, you getting closer just makes it easier for him to hit you, and he does, the full force of the boulder hitting your upper body square-on, whipping you directly down into the snow while the boulder mercifully lands some yards away. ");
			else if (mode == 1) outputText(", but you do look up just in time to nearly avoid the large boulder he chucked your way. Scrambling to react, you jump to the side, only to realize you chose the wrong side. The boulder hits you in the back, propelling you.  Battered, beaten, bruised, you struggle to stand, when the giant picks you up, laughs in his deep, mighty bellow, and punts you over a mountain. You land several feet deep in a snowbank, and see something flying toward you before passing out. ");
			else outputText("You begin to cast, focusing intently on summoning your magic. Too focused, though, as the giant propels the boulder in an arc to you. You notice the boulder just in time to not be crushed by it, though it still hits you and you fly several dozen yards before hitting a nice, jagged rock face. ");
			if (player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) player.removeStatusEffect(StatusEffects.GiantBoulder);
			var damage:int = (str * 2) + 100 + rand(250);
			damage = player.reduceDamage(damage);
			if (damage < 200) damage = 200;
			player.takeDamage(damage, true);
			outputText("\n\n");
			combatRoundOver();
		}
		public function giantBoulderMiss():void {
			clearOutput();
			outputText("His aim was perfect, if you had stood still. Watching him throw it at you gave you all the time you needed to avoid the large rock, though the debris from the impact might leave some bruises. ");
			if (player.findStatusEffect(StatusEffects.GiantBoulder) >= 0) player.removeStatusEffect(StatusEffects.GiantBoulder);
			var damage:int = 10 + rand(str / 2);
			damage = player.reduceDamage(damage);
			player.takeDamage(damage, true);
			outputText("\n\n");
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			var chooser:Number = 0;
			chooser = rand(10);
			if (chooser < 6) giantAttackPunch(); //60% chance
			if (chooser >= 6 && chooser < 9) giantGrab(); //30% chance
			if (chooser >= 9) giantBoulderThrow(); //10% chance
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.glacialRift.giantScene.winAgainstGiant();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.combat.cleanupAfterCombat();
		}
		
		public function FrostGiant() 
		{
			this.a = "the ";
			this.short = "frost giant";
			this.imageName = "frost-giant";
			this.long = "The giant reminds you of the stories you heard as a child in Ingnam, at least twenty feet tall and wider than your height. The giant's skin is a deep, icy blue with patches of frost and ice covering his body in place of armor. Fortunately for you, he's unarmed. Unfortunately for you, being as large as a house has the added benefit of boulders, trees, and handfuls of frozen dirt being ready weapons, all of which is abundant in the area. Plus those hands could probably crush you like a bug. Your battle instincts are definitely going to be tested.";
			// this.plural = false;
			this.createCock(36, 4, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 2;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 20*12;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "deep blue";
			this.skinType = SKIN_TYPE_FUR;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_FUR];
			this.hairColor = "white";
			this.hairLength = 8;
			initStrTouSpeInte(120, 100, 60, 75);
			initLibSensCor(20, 15, 35);
			this.weaponName = "fists";
			this.weaponVerb="punch";
			this.weaponAttack = 27;
			this.armorName = "ice";
			this.armorDef = 17;
			this.bonusHP = 600;
			this.lust = 10;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 22;
			this.gems = 45 + rand(25);
			this.drop = new WeightedDrop()
					.add(consumables.ICICLE_, 1)
					.add(null, 3);
			this.createPerk(PerkLib.Tank, 0, 0, 0, 0);
			this.createPerk(PerkLib.Tank2, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
