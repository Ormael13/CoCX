package classes.Scenes.Areas.Mountain
{
	import classes.CoC;
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class HellHound extends Monster
	{
		protected function hellhoundFire():void {
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0) {
				outputText(capitalA + short + " completely misses you with a wave of dark fire! Thank the gods it's blind!", false);
				combatRoundOver();
				return;
			}
			/*if(player.hasStatusAffect("Web-Silence") >= 0) {
				outputText("You reach inside yourself to breathe flames, but as you ready to release a torrent of fire, it backs up in your throat, blocked by the webbing across your mouth.  It causes you to cry out as the sudden, heated force explodes in your own throat.\n", false);
				changeFatigue(10);
				takeDamage(10+rand(20));
				enemyAI();
				return;
			}*/
			if(player.hasPerk("Evade") >= 0 && player.spe >= 35 && rand(3) != 0) {
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you.  You easily avoid the wave, diving to the side and making the most of your talents at evasion.", false);
			}
			else if(player.hasPerk("Misdirection") >= 0 && rand(100) < 20 && player.armorName == "red, high-society bodysuit") {
				outputText("Using Raphael's teachings and the movement afforded by your bodysuit, you anticipate and sidestep " + a + short + "'s fire.\n", false);
			}
			else if(player.hasPerk("Flexibility") >= 0 && player.spe > 30 && rand(10) != 0) {
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you.  You twist and drop with incredible flexibility, watching the fire blow harmlessly overhead.", false);
			}
			else {
				//Determine the damage to be taken
				var temp:Number = 15 + rand(10);
				temp = player.takeDamage(temp);
				outputText("Both the hellhound's heads breathe in deeply before blasting a wave of dark fire at you. While the flames don't burn much, the unnatural heat fills your body with arousal. (" + temp + " damage)", false);
				game.dynStats("lus", 20-(player.sens/10));
				statScreenRefresh();
				if(player.HP <= 0) {
					doNext(game.endHpLoss);
					return;
				}
				if(player.lust >= 100) {
					doNext(game.endLustLoss);
					return;
				}		
			}
			doNext(1);	
		}
		protected function hellhoundScent():void {
			if(player.hasStatusAffect("NoFlee") >= 0) {
				if(spe == 100) {
					hellhoundFire();
					return;
				}
				else {
					outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.", false);
					spe = 100;	
				}
			}
			else {
				spe += 40;
				outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a fiery grin - he seems to have acquired your scent!  It'll be hard to get away now...", false);
				player.createStatusAffect("NoFlee",0,0,0,0);
			}
			combatRoundOver();
			/*if(spe >= 80) {
				if(spe == 100) {
					hellhoundFire();
					return;
				}
				else {
					outputText("The hellhound sniffs your scent again, seemingly gaining more and more energy as he circles faster around you.", false);
					spe = 100;	
				}
			}
			else {
				spe += 40;
				outputText("The hellhound keeps his four eyes on you as he sniffs the ground where you were moments ago. He raises his heads back up and gives you a firey grin - He seems to have aquired you scent!  Running away will now be much more difficult...", false);
			}
			if(player.HP <= 0) {
				doNext(endHpLoss);
				return;
			}
			if(player.lust > 100) {
				doNext(endLustLoss);
				return;
			}
			doNext(1);*/
		}
		

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated and nearly unconscious.", true);
				//Rape if not naga, turned on, and girl that can fit!
				if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
					outputText("  You find yourself musing that you could probably take advantage of the poor 'doggy'.  Do you fuck it?", false);
					game.simpleChoices("Fuck it", game.mountain.hellHoundScene.hellHoundPropahRape, "", 0, "", 0, "", 0, "Leave", game.cleanupAfterCombat);
				} else {
					game.cleanupAfterCombat();
				}
			} else {
				outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
				var temp2:Function =null;
				if (player.gender > 0 && player.lust >= 33) {
					outputText("You realize your desires aren't quite sated.  You could let it please you", false);
					//Rape if not naga, turned on, and girl that can fit!
					if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
						outputText(" or make it fuck you", false);
						temp2 = game.mountain.hellHoundScene.hellHoundPropahRape;
					}
					outputText(".  What do you do?", false);
					game.simpleChoices("Lick", game.mountain.hellHoundScene.hellHoundGetsRaped, "Fuck", temp2, "", 0, "", 0, "Leave", game.cleanupAfterCombat);
				}
				else {
					outputText("You turn away, not really turned on enough to be interested in such an offer.", false);
					game.cleanupAfterCombat();
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nThe hellhound snorts and leaves you to your fate.", false);
				doNext(game.cleanupAfterCombat);
			} else {
				game.eventParser(game.mountain.hellHoundScene.hellhoundRapesPlayer);
			}
		}

		public function HellHound(noInit:Boolean=false)
		{
			if (noInit) return;
			trace("HellHound Constructor!");
			init01Names("the ", "hellhound", "hellhound", "It looks like a large demon on all fours with two heads placed side-by-side. The heads are shaped almost like human heads, but they have dog ears on the top and have a long dog snout coming out where their mouths and noses would be.  Its eyes and mouth are filled with flames and its hind legs capped with dog paws, but its front ones almost look like human hands.  Its limbs end in large, menacing claws. A thick layer of dark fur covers his entire body like armor.  Both heads look at you hungrily as the hellhound circles around you. You get the feeling that reasoning with this beast will be impossible.");
			init02Male([new Cock(8,2,CockTypesEnum.DOG),new Cock(8,2,CockTypesEnum.DOG)],2,4,5);
			init03BreastRows([0],[0],[0]);
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_NORMAL);
			init05Body(47,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_DOG);
			init06Skin("black",SKIN_TYPE_FUR);
			init07Hair("red",3);
			init08Face();
			init09PrimaryStats(55,60,40,1,95,20,100);
			init10Weapon("claws","claw",10);
			init11Armor("thick fur");
			init12Combat(0,25,1,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(5,10+rand(10));
			init14WeightedDrop()
					.add(consumables.CANINEP, 3)
					.addMany(1, consumables.BULBYPP,
							consumables.KNOTTYP,
							consumables.BLACKPP,
							consumables.DBLPEPP,
							consumables.LARGEPP);
			initX_Tail(TAIL_TYPE_DOG);
			initX_Specials(hellhoundFire,hellhoundScent);
		}

	}

}