package classes.Scenes.Areas.Forest
{
	import classes.CoC;
	import classes.Cock;
	import classes.Creature;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.CockTypesEnum;

	/**
	 * ...
	 * @author Fake-Name
	 */


	public class Akbal extends Monster
	{

		override public function eAttack():void
		{
			//Chances to miss:
			var damage:Number = 0;
			//Blind dodge change
			if (hasStatusAffect("Blind") >= 0) {
				outputText(capitalA + short + " seems to have no problem guiding his attacks towards you, despite his blindness.\n", false);
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (player.spe - spe < 8)
					outputText("You narrowly avoid " + a + short + "'s " + weaponVerb + "!", false);
				if (player.spe - spe >= 8 && player.spe - spe < 20)
					outputText("You dodge " + a + short + "'s " + weaponVerb + " with superior quickness!", false);
				if (player.spe - spe >= 20)
					outputText("You deftly avoid " + a + short + "'s slow " + weaponVerb + ".", false);
				game.combatRoundOver();
				return;
			}
			//Determine if evaded
			if (player.hasPerk("Evade") >= 0 && rand(100) < 10) {
				outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s attack.", false);
				game.combatRoundOver();
				return;
			}
			//Determine if flexibilitied
			if (player.hasPerk("Flexibility") >= 0 && rand(100) < 10) {
				outputText("Using your cat-like agility, you twist out of the way of " + a + short + "'s attack.", false);
				game.combatRoundOver();
				return;
			}
			//Determine damage - str modified by enemy toughness!
			//*Normal Attack A - 
			if (rand(2) == 0) {
				//(medium HP damage)
				damage = int((str + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage <= 0) {
					outputText("Akbal lunges forwards but with your toughness", false);
					if (player.armorDef > 0)
						outputText(" and " + player.armorName + ", he fails to deal any damage.", false);
					else
						outputText(" he fails to deal any damage.", false);
				}
				else {
					outputText("Akbal rushes at you, his claws like lightning as they leave four red-hot lines of pain across your stomach.", false);
					player.takeDamage(damage);
				}
			} else { //*Normal Attack B
				//(high HP damage)
				damage = int((str + 25 + weaponAttack) - Math.random() * (player.tou) - player.armorDef);
				if (damage == 0) {
					outputText("Akbal lunges forwards but between your toughness ", false);
					if (player.armorDef > 0)
						outputText("and " + player.armorName + ", he fails to deal any damage.", false);
				}
				else {
					outputText("Akbal snarls as he flies towards you, snapping his ivory teeth on your arm. You scream out in pain as you throw him off.", false);
					player.takeDamage(damage);
				}
			}
			game.combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.forest.akbalScene.akbalDefeated(hpVictory);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.forest.akbalScene.akbalWon(hpVictory,pcCameWorms);
			game.cleanupAfterCombat();
		}
		
		public function akbalLustAttack():void
		{
			//*Lust Attack - 
			if (player.hasStatusAffect("Whispered") < 0)
			{
				outputText("You hear whispering in your head. Akbal begins speaking to you as he circles you, telling all the ways he'll dominate you once he beats the fight out of you.", false);
				//(Lust increase)
				game.dynStats("lus", 7 + (100 - player.inte) / 10);
			}
			//Continuous Lust Attack - 
			else
			{
				outputText("The whispering in your head grows, many voices of undetermined sex telling you all the things the demon wishes to do to you. You can only blush.", false);
				//(Lust increase)
				game.dynStats("lus", 12 + (100 - player.inte) / 10);
			}
			game.combatRoundOver();
		}
		
		public function akbalSpecial():void
		{
			//*Special Attack A - 
			if (rand(2) == 0 && player.spe > 20)
			{
				var speedChange:Number = player.spe / 5 * -1;
				outputText("Akbal's eyes fill with light, and a strange sense of fear begins to paralyze your limbs.", false);
				//(Speed decrease)
				game.dynStats("spe", speedChange);
				if (player.hasStatusAffect("Akbal Speed") >= 0)
					player.addStatusValue("Akbal Speed", 1, speedChange);
				else
					player.createStatusAffect("Akbal Speed", speedChange, 0, 0, 0);
			}
			//*Special Attack B - 
			else
			{
				outputText("Akbal releases an ear-splitting roar, hurling a torrent of emerald green flames towards you.\n", false);
				//(high HP damage)
				//Determine if dodged!
				if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80)
				{
					if (player.spe - spe < 8)
						outputText("You narrowly avoid " + a + short + "'s fire!", false);
					if (player.spe - spe >= 8 && player.spe - spe < 20)
						outputText("You dodge " + a + short + "'s fire with superior quickness!", false);
					if (player.spe - spe >= 20)
						outputText("You deftly avoid " + a + short + "'s slow fire-breath.", false);
					game.combatRoundOver();
					return;
				}
				//Determine if evaded
				if (player.hasPerk("Evade") >= 0 && rand(100) < 20)
				{
					outputText("Using your skills at evading attacks, you anticipate and sidestep " + a + short + "'s fire-breath.", false);
					game.combatRoundOver();
					return;
				}
				//Determine if flexibilitied
				if (player.hasPerk("Flexibility") >= 0 && rand(100) < 10)
				{
					outputText("Using your cat-like agility, you contort your body to avoid " + a + short + "'s fire-breath.", false);
					game.combatRoundOver();
					return;
				}
				outputText("You are burned badly by the flames! ("+player.takeDamage(40)+")", false);
				;
			}
			game.combatRoundOver();
		}
		
		//*Support ability - 
		public function akbalHeal():void
		{
			if (HPRatio() >= 1)
				outputText("Akbal licks himself, ignoring you for now.", false);
			else
				outputText("Akbal licks one of his wounds, and you scowl as the injury quickly heals itself.", false);
			addHP(30);
			lust += 10;
			game.combatRoundOver();
		}

		public function Akbal()
		{
			trace("Akbal Constructor!");
			init01Names("", "Akbal", "akbal", "Akbal, 'God of the Terrestrial Fire', circles around you. His sleek yet muscular body is covered in tan fur, with dark spots that seem to dance around as you look upon them.  His mouth holds two ivory incisors that glint in the sparse sunlight as his lips tremble to the sound of an unending growl.  Each paw conceals lethal claws capable of shredding men and demons to ribbons.  His large and sickeningly alluring bright green eyes promise unbearable agony as you look upon them.");
			init02Male([new Cock(15,2.5,CockTypesEnum.DOG)],2,4,6,400);
			init03BreastRows([0],[0],[0],[0]);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_NORMAL);
			init05Body("4'",HIP_RATING_SLENDER,BUTT_RATING_TIGHT);
			init06Skin("spotted",SKIN_TYPE_FUR);
			init07Hair("black",5);
			init08Face();
			init09PrimaryStats(55,53,50,75,50,50,100);
			init10Weapon("claws","claw-slash",5);
			init11Armor("shimmering pelt",5);
			init12Combat(20,30,0.8,TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(6,15);
			init14WeightedDrop().
					add(consumables.INCUBID,6).
					add(consumables.W_FRUIT,3).
					add(weapons.PIPE,1);
			initX_Specials(akbalLustAttack,akbalSpecial,akbalHeal);
			initX_Tail(TAIL_TYPE_DOG);
		}

	}

}