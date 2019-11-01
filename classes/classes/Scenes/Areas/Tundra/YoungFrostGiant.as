package classes.Scenes.Areas.Tundra 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.GlacialRift.FrostGiantScene;
import classes.internals.WeightedDrop;

	public class YoungFrostGiant extends Monster
	{
		public var giantScene:FrostGiantScene = new FrostGiantScene();
		
		public function youngGiantAttackPunch():void {
			var damage:int = 0;
			outputText("Young giant strides toward you, closing the distance faster than you can run. He rears back and strikes at you!  ");
			if (player.getEvasionRoll()) {
				outputText("You deftly dodge the jumbo Jotun's paltry punch, spinning swiftly to charge your [weapon] at his hand, leaving what looks like a crack. The giant roars in outrage, shaking snow from trees and making your [armor] vibrate. He appears angrier than before.");
			}
			else {
				if (rand(player.spe + 40) < spe) {
					outputText("You take the full force of his grand slam, sending you flying a good 30 feet, plunging through a snowdrift. As you right yourself, his laugh shakes the ground, \"<i>Puny! Haaaa!</i>\" ");
					damage = ((str + 150) + rand(100));
					if (damage < 40) damage = 40;
					player.takePhysDamage(damage, true);
				}
				else {
					outputText("You nearly avoid young giant's fist, stumbling as you regain your footing. The giant's growl is a deep bass as he bellows, \"<i>Bah! Luck!</i>\" ");
					damage = 50 + rand(str);
					player.takePhysDamage(damage, true);
				}
			}
		}
		
		public function youngGiantGrab():void {
			outputText("Young giant yells something you don't understand and charges at you, hands outstretched!  ");
			if (player.getEvasionRoll()) {
				outputText("You ");
				if (rand(player.spe) < spe) outputText("barely"); 
				else outputText("ably"); 
				outputText(" avoid his charge, jumping just in time to avoid his hands, and then his feet. He's unable to stop himself in time and collides head first with a boulder slightly smaller than his head. ");
				var giantDmg:Number = 30 + rand(30);
				HP -= giantDmg;
				outputText("Young giant takes <b><font color=\"#800000\">" + giantDmg + "</font></b> damage from his impact.  ");
				outputText("<b>Young giant is stunned!</b>");
				createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			else {
				outputText("Your attempt to make way fails, and young giant grabs you in his very large, very cold, very strong hands. \"<i>Now, you die!</i>\"");
				player.createStatusEffect(StatusEffects.GiantGrabbed, 2, 0, 0, 0);
			}
		}
		public function youngGiantGrabStruggle():void {
			if (rand(200) >= player.str || rand(10) == 0) youngGiantGrabFail();
			else if (player.hasPerk(PerkLib.FluidBody)) youngGiantGrabSuccess();
			else youngGiantGrabSuccess();
		}
		public function youngGiantGrabFail(struggle:Boolean = true):void {
			var damage:int = 0;
			if (struggle) {
				clearOutput();
				if (player.str >= 80) {
					outputText("You push and pull and squeeze and worm with all your might, but all that does is make young giant's grip harder. ");
				}
				else if (player.str >= 60 && player.str < 80) {
					outputText("Your strength fails to help you escape this frosty situation, though the heat from the struggle is nice enough in this wasteland to nearly doze in it. Young giant makes sure that doesn't happen, though. ");
					player.addCombatBuff('str', -1);
				}
				else if (player.str >= 40 && player.str < 60) {
					outputText("Try as you might, young giant's grip is too much for your weak body; the best you can do is a few squirms and a shake. His grip remains as tough as ever. ");
					player.addCombatBuff('str', -2);
				}
				else if (player.str >= 20 && player.str < 40) {
					outputText("Young giant's grip nearly crushes you to bits right there; sheer force of will allows you to struggle and resist, though it proves futile. ");
					if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {damage = 10 + rand(str * 0.5);
					player.takePhysDamage(damage, true);
					}
				}
				else if (player.str < 20) {
					outputText("Young giant squeezes you mercilessly, the pressure on your body reaching critical levels. Young giant doesn't seem to want to murder you, fortunately, so he lessens his grip slightly. No dice escaping it though. ");
					if (player.findPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {damage = 20 + rand(str * 0.75);
					player.takePhysDamage(damage, true);
					}
				}
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("The thought of being constricted turns you on a bit. ");
					player.dynStats("lust", 5);
				}
				outputText("\n\n");
			}
			else {
				if (flags[kFLAGS.PC_FETISH] >= 2) {
					outputText("The thought of being constricted turns you on a bit. ");
					player.dynStats("lust", 5);
				}
				outputText("\n\n");
			}
			switch(rand(6)) {
				case 0:
				case 1:
				case 2: //Taunt
					outputText("\"<i>Ha, ha, ha! Puny little [race]! You cannot escape my grasp!</i>\" He flicks your head, nearly snapping your neck, and you see stars for a moment. ");
					player.removeStatusEffect(StatusEffects.GiantGrabbed);
					damage = 50 + rand(str * 0.4);
					player.takePhysDamage(damage, true);
					break;
				case 3:
				case 4: //Ground Pound
					outputText("Young giant brings you to his face to yell at you. His scream is probably the loudest thing you've ever heard, and while your ears are still ringing he raises you up, and up, and up and then punches the ground with all his might. ");
					outputText("The force of the punch leaves you reeling for a time; you come to your senses before he tries to do anything else. ");
					player.removeStatusEffect(StatusEffects.GiantGrabbed);
					damage = 180 + rand(str * 1.2);
					player.takePhysDamage(damage, true);
					break;
				case 5: //Throw
					outputText("\"<i>Oh, little [race] wants to be let go? Ha! Then GO!</i>\" He rears back and chucks you as hard as he can against the nearest rock face. Fortunately, his aim is off and he throws you into a patch of snow. The snow helps cushion the impact, but you're still very disoriented. ");
					player.removeStatusEffect(StatusEffects.GiantGrabbed);
					player.createStatusEffect(StatusEffects.Stunned, 1 + rand(3), 0, 0, 0);
					damage = 50 + rand(str * 0.8);
					if (damage < 50) damage = 50;
					player.takePhysDamage(damage, true);
					break;
				default:
			}
		}
		public function youngGiantGrabSuccess():void {
			clearOutput();
			if (player.str >= 200) outputText("You roar and force young giant's hand open. He gasps in surprise, using his other hand to close you in, but it's too late by then. You jump to the ground and roll away, readying for your next attack. ");
			if (player.str >= 160 && player.str < 200) outputText("You push, pull, squeeze, squirm and finally you escape young giant's grasp. You drop and roll and make distance before readying your weapon. ");
			if (player.str >= 120 && player.str < 160) outputText("With no small effort, you  pop out from young giant's clench. You run up his arm and jump down his back, making distance. ");
			if (player.str >= 80 && player.str < 120) outputText("Despite the cold, hard confines of young giant's hand, you manage to slip out of his hand and fall to the ground before scrambling up and running from the angry giant. ");
			if (player.str >= 40 && player.str < 80) outputText("Body aching, you exploit a light grip for a moment and drop to the ground with a hard thud. Forcing yourself to get up and MOVE, you run as quickly as your throbbing [ass] can handle. ");
			if (player.str < 40) {
				outputText("Struggling with every fiber of your being, you manage to tickle young giant into dropping you. Slightly embarrassed, you get as far away from the giant without running away as you can, and ready your weapon. You think it wise to try to escape. ");
			}
			player.removeStatusEffect(StatusEffects.GiantGrabbed);
		}
		
		public function youngGiantBoulderThrow():void {
			outputText("Young giant walks over to a boulder much larger than you and hefts it up. You had better wait and be ready to dodge, or this could be very bad. ");
			outputText("<b>With a grunt and a shove, the giant throws the boulder directly at you!</b>");
			if (!player.hasStatusEffect(StatusEffects.GiantBoulder)) player.createStatusEffect(StatusEffects.GiantBoulder, 0, 0, 0, 0);
		}
		public function youngGiantBoulderFantasize():void {
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
			youngGiantBoulderHit(1);
		}
		public function youngGiantBoulderHit(mode:int = 0):void {
			clearOutput();
			if (mode == 0) outputText("You charge at young giant, running as fast as you can, hoping to get to him before he can throw the huge rock. However, you getting closer just makes it easier for him to hit you, and he does, the full force of the boulder hitting your upper body square-on, whipping you directly down into the snow while the boulder mercifully lands some yards away. ");
			else if (mode == 1) outputText(", but you do look up just in time to nearly avoid the large boulder he chucked your way. Scrambling to react, you jump to the side, only to realize you chose the wrong side. The boulder hits you in the back, propelling you.  Battered, beaten, bruised, you struggle to stand, when young giant picks you up, laughs in his deep, mighty bellow, and punts you over a tree. You land several feet deep in a dirt, and see something flying toward you before passing out. ");
			else outputText("You begin to cast, focusing intently on summoning your magic. Too focused, though, as young giant propels the boulder in an arc to you. You notice the boulder just in time to not be crushed by it, though it still hits you and you fly several dozen yards before hitting a nice, jagged rock face. ");
			if (player.hasStatusEffect(StatusEffects.GiantBoulder)) player.removeStatusEffect(StatusEffects.GiantBoulder);
			var damage:int = (str * 2) + 200 + rand(100);
			if (damage < 200) damage = 200;
			player.takePhysDamage(damage, true);
			outputText("\n\n");
		}
		public function youngGiantBoulderMiss():void {
			clearOutput();
			outputText("His aim was perfect, if you had stood still. Watching him throw it at you gave you all the time you needed to avoid the large rock, though the debris from the impact might leave some bruises. ");
			if (player.hasStatusEffect(StatusEffects.GiantBoulder)) player.removeStatusEffect(StatusEffects.GiantBoulder);
			var damage:int = 10 + rand(str / 2);
			player.takePhysDamage(damage, true);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			var chooser:Number = 0;
			chooser = rand(10);
			if (chooser < 6) youngGiantAttackPunch(); //60% chance
			if (chooser >= 6 && chooser < 9) youngGiantGrab(); //30% chance
			if (chooser >= 9) youngGiantBoulderThrow(); //10% chance
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			giantScene.winAgainstYoungGiant();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			cleanupAfterCombat();
		}
		
		public function YoungFrostGiant() 
		{
			this.a = " ";
			this.short = "young frost giant";
			this.imageName = "frost-giant";
			this.long = "The giant reminds you of the stories you heard as a child in Ingnam, at least eighteen feet tall and wider than your height. The giant's skin is a deep, icy blue with patches of frost and ice covering his body in place of armor. Fortunately for you, he's unarmed. Unfortunately for you, being as large as a house has the added benefit of boulders, trees, and handfuls of dirt being ready weapons, all of which is abundant in the area. Plus those hands could probably crush you like a bug. Your battle instincts are definitely going to be tested.";
			// this.plural = false;
			this.createCock(36, 4, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 2;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 18*12;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"deep blue"});
			this.hairColor = "white";
			this.hairLength = 8;
			initStrTouSpeInte(295, 230, 105, 80);
			initWisLibSensCor(80, 20, 15, 35);
			this.weaponName = "fists";
			this.weaponVerb="punch";
			this.weaponAttack = 96;
			this.armorName = "ice";
			this.armorDef = 90;
			this.armorMDef = 30;
			this.bonusHP = 900;
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = 0.3;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 49;
			this.gems = 45 + rand(25);
			this.drop = new WeightedDrop()
					.add(consumables.ICICLE_, 1)
					.add(null, 3);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			checkMonster();
		}
	}
}