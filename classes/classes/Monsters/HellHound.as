package classes.Monsters
{
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

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("The hellhound's flames dim and the heads let out a whine before the creature slumps down, defeated and nearly unconscious.", true);
				//Rape if not naga, turned on, and girl that can fit!
				if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
					outputText("  You find yourself musing that you could probably take advantage of the poor 'doggy'.  Do you fuck it?", false);
					game.simpleChoices("Fuck it", game.hellHoundPropahRape, "", 0, "", 0, "", 0, "Leave", 5007);
				} else {
					game.eventParser(5007);
				}
			} else {
				outputText("Unable to bear hurting you anymore, the hellhound's flames dim as he stops his attack. The two heads look at you, whining plaintively.  The hellhound slowly pads over to you and nudges its noses at your crotch.  It seems he wishes to pleasure you.\n\n", true);
				var temp2:int = 0;
				if (player.gender > 0 && player.lust >= 33) {
					outputText("You realize your desires aren't quite sated.  You could let it please you", false);
					//Rape if not naga, turned on, and girl that can fit!
					if (player.hasVagina() && player.lust >= 33 && !player.isNaga()) {
						outputText(" or make it fuck you", false);
						temp2 = 2746;
					}
					outputText(".  What do you do?", false);
					game.simpleChoices("Lick", 5068, "Fuck", temp2, "", 0, "", 0, "Leave", 5007);
				}
				else {
					outputText("You turn away, not really turned on enough to be interested in such an offer.", false);
					game.eventParser(5007);
				}
			}
		}

		public function HellHound(mainClassPtr:*)
		{
			super(mainClassPtr);
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
			initX_Tail(TAIL_TYPE_DOG);
			initX_Specials(5066,5067);
		}

	}

}