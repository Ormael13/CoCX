package classes.Scenes.Dungeons.DesertCave
{
	import classes.*;

	public class SandWitchMob extends Monster
	{
		public function sandWitchMobAI():void {
			if (findStatusEffect(StatusEffects.Sandstorm) < 0) sandStormAttack();
			else if (HPRatio() < .5) drankSomeMialk();
			else if (findStatusEffect(StatusEffects.Sandstorm) >= 0 && rand(2) == 0 && player.findStatusEffect(StatusEffects.LustStones) < 0) sandstonesAreCool();
			else if (rand(3) == 0) headbuttABitch();
			else gangrush();
		}
		
		//Sand Witch Mob Attacks:
		//Swarm
		//-Mob gangrushes the PC; multiple hits, light damage
		public function gangrush():void {
			outputText("The witches close ranks and advance with raised fists, intent on beating you into submission!\n");
			//3-5 attacks.at half strength
			str -= 10;
			createStatusEffect(StatusEffects.Attacks,2 + rand(3),0,0,0);
			eAttack();
			str += 10;
			
		}

		//Headbutt
		//Single, high damage attack
		//High hit chance
		public function headbuttABitch():void {
			outputText("The crowd parts, and a stockier, sturdier sorceress ambles out, fists up and head cocked back.  She makes to punch at you before pulling her fist at the last second, snapping her head forward in a powerful headbutt!  You barely have time to react!");
			var damage:int = Math.round((str + weaponAttack + 10) - rand(player.tou) - player.armorDef);
			//Dodge
			if (player.getEvasionRoll()) {
				outputText("\nThrowing yourself out of the way, you manage to avoid the hit.  Your foe doesn't seem nearly as pleased while she fades back in between her sisters.");
			}
			//Block
			else if (damage <= 0) {
				outputText("\nYou catch the hit on your forearm, stopping her cold.  The thuggish woman snarls as she fades back in between her sisters, disappointed at doing so little damage.");
			}
			//Hit
			else {
				outputText("\nShe hits you square in the face, bloodying your face and sending you stumbling back in agony. ");
				damage = player.takeDamage(damage, true);
			}
			combatRoundOver();
		}

		//Sand Stones
		//-Mob summons vibrating sands sands to  lust increase PCs lust
		//- Lust gained each round they use it is determined by how many naughty bits a PC has.
		//-For every dick, set of breast(nips?), cunts and ass-hole on a PC, the lust gain is increased by 3, Not accounting for lust resistance.
		//-Goo bodies will gain 30 Lust by default, not accounting lust resistance.
		//-Stones will randomly vibrate throughout the battle if they get the PC.

		public function sandstonesAreCool():void {
			outputText("The sandstorm whirling around the room suddenly ceases, and all the tiny sand particles gather together into balls, growing into several smooth stones.  Then, all the sand stones fall to the ground and slither towards you.");
			
			var bonus:int = 0;
			//[If they attack lands]
			if (!player.getEvasionRoll()) {
				//[IF PC has solid body]
				if (!player.isGoo()) {
					outputText("\n\nThey crawl up your [legs].  You try to swat them all off, but there are too many.");
					//If PC has 1 cock:
					if (player.cockTotal() == 1) outputText("  A stone crawls onto your [cock].");
					//[If PC has multi-cocks: 
					if (player.cockTotal() > 1) outputText("  A bunch of the stones crawl onto your " + player.multiCockDescriptLight() + ".");
					if (player.hasCock()) bonus++;
					//[If PC has cunt]
					if (player.hasVagina()) {
						outputText("  One stone slides up your inner thigh");
						if (player.balls > 0) outputText(" behind your [sack]");
						outputText(" and pops itself right into your [vagina]");
						if (player.hasVirginVagina()) outputText(", robbing you of your virginity as a trickle of blood runs down your [leg].");
						bonus++;
					}
					//[If PC has balls:
					if (player.balls > 0) {
						outputText("  A small set of stones settle on your [balls].");
						bonus++;
					}
					outputText("  " + num2Text(player.totalNipples()) + " crawl up to your chest and over your top " + player.nippleDescript(0) + "s");
					if (player.bRows() > 1) {
						if (player.bRows() == 2) outputText(" and");
						else outputText(",");
						outputText(" your middle " +  player.nippleDescript(1) + "s");
						bonus++;
					}
					if (player.bRows() > 2) {
						outputText(", and your bottom " + player.nippleDescript(2) + "s");
						bonus++;
					}
					outputText(".");
					outputText("  The last stone travels up the back of your [legs] and slides right into your [asshole].");
					outputText("\n\nYou try to get the stones off and out of you, but some kind of magic is keeping them stuck to you like glue.  One sand-witch snaps her fingers, and all the of the smooth stones begin vibrating, making numbing waves of pleasure that rattle your body.  <b>You have to end this quick, or else!</b>");
				}
				//[IF PC has goo body]
				else {
					outputText("\n\nThe stones launch themselves into your gooey body.  You try your best to dislodge these foreign objects from your insides, but some-kind of magic is holding them in place.  A sand-witch snaps her fingers and all the stones begin vibrating, sending ripples throughout your sentative gooey body.  It feels like your whole body is one, big pleasure-bomb right now.  You had better end this fight soon!");
					bonus = 5;
					
				}
				player.createStatusEffect(StatusEffects.LustStones,bonus,0,0,0);
				game.dynStats("lus", bonus * 2 + 5 + player.sens/7);
			}
			//[If attack misses]
			else {
				outputText("\nThe stones then make a ninety degree turn into the purple fire, and then nothing.  One sand-witch smacks another upside the head, yelling something about focusing.");
			}
			removeStatusEffect(StatusEffects.Sandstorm);
			combatRoundOver();
		}
		
		//Milk is Good
		//-Mob's members start sucking on each other's tits. Arouses PC and restores health to mob, decreases (increases?) mob's lust.
		public function drankSomeMialk():void {
			outputText("One of the blonde beauties turns to another and asks, \"<i>A drink, sister?  Fighting this intruder has given me a powerful thirst.</i>\"  The other woman wordlessly opens her robe, baring her breasts, exposing four heaving, milk-fueled mounds to the air before the other woman claims a nipple for herself.  Three others crowd in on the exposed teats, their rumps shaking contentedly as they grab a quick snack.");
			outputText("\n\nAfter wiping the excess from their lips, they close their robes and resume a fighting stance, seeming healthier than before.");
			game.dynStats("lus", 4 + player.lib/10);
			//+ 30 HP, +light lust damage to PC and mob
			addHP(30);
			combatRoundOver();
		}
		
		//*Sandstorm
		//Creates a sandstorm that blinds the PC one out of every 3 rounds.  Used first turn. Deals light HP damage every turn.  Reduces breath attacks damage by 80%.  Makes bow miss 50% of the time.
		public function sandStormAttack():void {
			outputText("The witches link their hands together and begin to chant together, lifting their voices high as loose sand trickles in from every corner, every doorway, even the ceiling.  \"<i>Enevretni llahs tresed eht!</i>\"  Swirling around the chamber, a cloud of biting, stinging sand clouds your vision and bites into your skin.  It's going to keep blinding you and hurting you every round!");
			createStatusEffect(StatusEffects.Sandstorm,0,0,0,0);
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			sandWitchMobAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.dungeons.desertcave.yoYouBeatUpSomeSandWitchesYOUMONSTER();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.dungeons.desertcave.loseToSammitchMob();
		}
		
		public function SandWitchMob()
		{
			this.a = "the ";
			this.short = "sand witches";
			this.imageName = "sandwitchmob";
			this.long = "You are surrounded by a veritable tribe of sand witches.  Like the ones that roam the sands, they have simple robes, blond hair, and four big breasts that push at the concealing cloth immodestly.  Glowering at you hatefully, the pack of female spellcasters readies itself to drag you down with sheer numbers.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createVagina(false, VAGINA_WETNESS_WET, VAGINA_LOOSENESS_LOOSE);
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(12) + 55;
			this.hipRating = HIP_RATING_CURVY;
			this.buttRating = BUTT_RATING_LARGE;
			this.skinTone = "bronzed";
			this.hairColor = "sandy-blonde";
			this.hairLength = 15;
			initStrTouSpeInte(25, 25, 35, 45);
			initLibSensCor(55, 40, 30);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.weaponAttack = 0;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "robes";
			this.armorDef = 1;
			this.armorPerk = "";
			this.armorValue = 5;
			this.bonusHP = 80;
			this.lust = 30;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 4;
			this.gems = rand(15) + 5;
			this.drop = NO_DROP;
			checkMonster();

		}
		
	}

}