package classes.Scenes.Quests.UrtaQuest
{
	import classes.Cock;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Monster;
	import classes.Scenes.Areas.Desert.Naga;
import classes.StatusAffects;

/**
	 * ...
	 * @author aimozg
	 */
	public class Sirius extends Naga
	{

		override public function eAttack():void
		{
			outputText("Sirius readies his hands, undulating his body erratically with quick motions in order to catch you off-guard and strike at you.\n");
			super.eAttack();
		}


		override protected function outputPlayerDodged(dodge:int):void
		{
			outputText("With your trained eyes, you see through his feints and effectively block his first swipe, then quickly twist your body to kick him away.  He clutches his belly where you kicked him, but recovers quickly, eyes fixated on yours.\n");
		}

		override public function outputAttack(damage:int):void
		{
			if (damage<=0) {
				super.outputAttack(damage);
			} else {
				outputText("You misjudge his pattern and wind up getting slashed by a series of swipes from his sharpened nails.  He distances himself from you in order to avoid retaliation and glares at you with his piercing yellow eyes, a hint of a smile on his face. (" + damage + ")");
			}
		}

		override protected function performCombatAction():void
		{
			var attack:int = rand(4);
			if (player.findStatusAffect(StatusAffects.Blind) >= 0) attack = rand(3);
			if (attack == 0) eAttack();
			if (attack == 1) poisonBite();
			if (attack == 2) manNagaTease();
			if (attack == 3) nagaSpitAttack();
		}

		private function manNagaTease():void
		{
			outputText("The snake-man stares deeply into your eyes, seemingly looking past them, and for a moment your body goes numb.");
//Miss:
			if (rand(10) == 0) {
				outputText("  You blink and shake yourself free of the effects of the snake-man's penetrating gaze.");
				combatRoundOver();
			}
//Hit (Blind):
			if (findStatusAffect(StatusAffects.Blind) >= 0) {
				outputText("  Though your vision is still blurry, you feel yourself being sucked into the golden depths of those pupils, making you forget all your worries, if only for an instant.  All you can focus on is your growing arousal as you sink deeper into his gaze.  You shake your head, clearing your mind of the hypnotising effects the snake-man's eyes seem to possess, though the arousal remains.");
				kGAMECLASS.dynStats("lus", (5 + player.lib / 10 - player.inte / 20));
			}
			//Hit:
			else {
				outputText("  Those pools of yellow suck you into their golden depths, making you forget all your worries, if only for an instant.  All you can focus on is your growing arousal as you sink deeper into his gaze.  You shake your head, clearing your mind of the hypnotising effects the snake-man's eyes seem to possess, though the arousal remains.");
				kGAMECLASS.dynStats("lus", (10 + player.lib / 7 - player.inte / 20));
			}
			combatRoundOver();
		}

		private function nagaSpitAttack():void
		{
			outputText("Hissing loudly, Sirius suddenly curls his lips and spits at your eyes!  ");
//{Hit:
			if (spe / 20 + rand(20) + 1 > player.spe / 20 + 10) {
				outputText("The vile spray hits your eyes and you scream in pain, clawing fiercely at your burning, watering, weeping eyes.  <b>You can't see!  It'll be much harder to fight in this state, but at the same time, his hypnosis won't be so effective...</b>");
				player.createStatusAffect(StatusAffects.Blind, 3, 0, 0, 0);
			}
			//Miss:
			else outputText("You quickly lean to the side, narrowly avoiding being blinded by the snake-man's spit!");
			combatRoundOver();
		}

		private function poisonBite():void
		{
			outputText("With a loud and vicious hiss, Sirius suddenly lunges at you, mouth distended impossibly wide and revealing four needle-like fangs dripping with venom!  ");
//Miss:
			if (combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect()) {
				outputText("You dodge just in the nick of time, and deliver a punishing blow with the butt of your halberd as Sirius soars past, forcing him to slither past you to make himself ready to defend himself again.");
				combatRoundOver();
			}
//Hit:
			outputText("The snake-man moves too quickly for you to evade and he sinks long fangs into your flesh, leaving a wound that burns with horrific pain.");
			var damage:Number = 40 + rand(20);
			damage = player.takeDamage(damage);
			outputText(" (" + damage + ")");
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.urtaQuest.urtaBeatsUpSiriusRadio();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.urtaQuest.urtaLosesToSirriusSnakeRadio();
		}

		public function Sirius()
		{
			super(true);
			init01Names("", "Sirius, a naga hypnotist", "sirius", "A strange being with the upper torso of a human man topped with the head of a giant serpent stands before you, hissing in anger and occasionally letting a long, fork-tipped tongue flicker out past his lips.  An imperial-featured masculine human face regards you with an indifferent expression.  A ponytail of deep orange - almost bright red - hair falls down between his shoulders, held together by snake-styled circlets of silver, and matching bracelets of the same material and design adorn his wrists. Scales begin at his lower waist, concealing his manhood from you; he's completely naked otherwise.  His snake body is long and slender, covered in finely meshing scales of a rich orange-red shade, the red broken by a pattern of randomly thick or thin stripes of black.  His burning yellow eyes stare directly into yours, vertical slits of pupils fixated on your own as he undulates and coils in an eerily seductive manner.");
			init02Male(new Cock(14,2));
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,10);
			init05Body("5'10",HIP_RATING_AMPLE+2,BUTT_RATING_LARGE,LOWER_BODY_TYPE_NAGA);
			init06Skin("mediterranean-toned");
			init07Hair("orange",16);
			init08Face();
			init09PrimaryStats(75,70,75,92,45,35,40);
			init10Weapon("fangs","bite",25);
			init11Armor("scales",30);
			init12Combat(400,30,1,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(12,rand(5) + 8);
			init14NoDrop();
			initX_Specials(nagaPoisonBiteAttack,nagaConstrict,nagaTailWhip);

		}

	}

}