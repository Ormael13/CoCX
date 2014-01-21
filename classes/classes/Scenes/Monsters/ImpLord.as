package classes.Scenes.Monsters
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class ImpLord extends Imp
	{
		//Heavy Attack
		protected function impLordHeavyEncounter():void
		{
			var damage:int = int((str + weaponAttack + 20) - rand(player.tou) - player.armorDef);
			outputText("The demonic creature slashes a clawed hand towards your stomach,");
			if (combatMiss() && combatEvade() && combatFlexibility() && combatMisdirect()) outputText(" but you handily avoid it.");
			else if (damage <= 0) outputText(" but the attack proves ineffectual.");
			else {
				outputText("leaving a large gash. The attack leaves you slightly stunned, but you recover. ");
				damage = player.takeDamage(damage);
				outputText("(" + damage + ")");
			}
			combatRoundOver();
		}

		//Lust Attack
		protected function impLordLustAttack():void
		{
			outputText("Lowering his loincloth the imp reveals his inhumanly thick shaft.  He smirks and licks his lips as he gives his cock a squeeze, milking a few beads of clear pre from the tip.  You shake your head and try to ignore your growing need.");
			//[+Lust]
			game.dynStats("lus", 5 + player.lib / 5 + player.cor / 5);
			combatRoundOver();
		}

		//Lust and Light Attack
		protected function impLordLustAttack2():void
		{
			outputText("Reaching into his satchel the devilish creature pulls out a leather riding crop.  He quickly rushes forward, but somehow manages to get behind you.  Before you can react the imp lashes out, striking your [butt] twice with the riding crop.  The strikes leave a slight burning feeling, as well as a strange sense of arousal.");
			var damage:int = 3 + rand(10);
			damage = player.takeDamage(damage);
			outputText(" (" + damage + ")");
			//[-HP(minor) // +Lust]
			game.dynStats("lus", 5 + player.sens / 4 + player.cor / 10);
			combatRoundOver();
		}
        override protected function performCombatAction():void
		{
			var choices:Array = [impFire, impLordLustAttack2, impLordLustAttack, impLordHeavyEncounter, eAttack];
			choices[rand(choices.length)]();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.impScene.defeatImpLord();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.impScene.loseToAnImpLord();
		}

		public function ImpLord()
		{
			super(true);
			init01Names("the ", "imp lord", "implord", "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, lust-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works it's way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe greater imp, like most imps wears very little clothing, only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.");
			// Imps now only have demon dicks.
			// Not sure if I agree with this, I can imagine the little fuckers abusing the
			// shit out of any potions they can get their hands on.
			init02Male(new Cock(rand(2)+11,2.5,CockTypesEnum.DEMON),2,1,3,20);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL);
			init05Body(rand(14) + 40,HIP_RATING_BOYISH,BUTT_RATING_TIGHT,LOWER_BODY_TYPE_HOOFED);
			init06Skin("red");
			init07Hair();
			init08Face();
			init09PrimaryStats(55,40,75,42,55,35,100);
			init10Weapon("fist","punch",10);
			init11Armor("leathery skin",5);
			init12Combat(100,30,.65,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(7,rand(15) + 25);
			init14WeightedDrop().
					add(consumables.MINOBLO,1).
					add(consumables.LABOVA_,1).
					add(consumables.INCUBID,6);
			initX_Wings(WING_TYPE_IMP);
			initX_Specials(5019);

		}
		
	}

}