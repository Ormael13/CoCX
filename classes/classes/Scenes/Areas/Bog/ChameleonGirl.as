package classes.Scenes.Areas.Bog
{
	import classes.Appearance;
	import classes.Monster;
	import classes.internals.Utils;

	/**
	 * ...
	 * @author aimozg
	 */
	public class ChameleonGirl extends Monster
	{

		public function chameleonTongueAttack():void
		{
			setWeaponName("tongue");
			setWeaponVerb("tongue-slap");
			setWeaponAttack(10);
			createStatusAffect("attacks", 1, 0, 0, 0);
			eAttack();
			setWeaponAttack(30);
			setWeaponName("claws");
			setWeaponVerb("claw");
			combatRoundOver();
		}

		//Ignores armor
		public function chameleonClaws():void
		{
			//Blind dodge change
			if (hasStatusAffect("Blind") >= 0 && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind claw-attack!\n", false);
			}
			//Evade:
			else if (game.combatMiss() || game.combatEvade() || game.combatFlexibility() || game.combatMisdirect()) outputText("The chameleon girl's claws slash towards you, but you lean away from them and they fly by in a harmless blur.");
			//Get hit
			else {
				var damage:Number = int((str + weaponAttack) - rand(player.tou));
				if (damage > 0) {
					damage = player.takeDamage(damage);
					outputText("The chameleon swings her arm at you, catching you with her claws.  You wince as they scratch your skin, leaving thin cuts in their wake. (" + damage + ")");
				}
				else outputText("The chameleon swings her arm at you, catching you with her claws.  You defend against the razor sharp attack.");
			}
			combatRoundOver();
		}

		//Attack 3:
		public function rollKickClawWhatTheFuckComboIsThisShit():void
		{
			//Blind dodge change
			if (hasStatusAffect("Blind") >= 0 && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind roll-kick!\n", false);
			}
			//Evade:
			else if (game.combatMiss() || game.combatEvade() || game.combatFlexibility() || game.combatMisdirect()) {
				var damage2:Number = 1 + rand(10);
				damage2 = game.doDamage(damage2);
				outputText("The chameleon girl leaps in your direction, rolls, and kicks at you.  You sidestep her flying charge and give her a push from below to ensure she lands face-first in the bog. (" + damage2 + ")");

			}
			//Get hit
			else {
				var damage:Number = int((str + weaponAttack) - rand(player.tou) - player.armorDef) + 25;
				if (damage > 0) {
					damage = player.takeDamage(damage);
					outputText("The chameleon leaps in your direction, rolls, and kicks you square in the shoulder as she ascends, sending you reeling.  You grunt in pain as a set of sharp claws rake across your chest. (" + damage + ")");
				}
				else outputText("The chameleon rolls in your direction and kicks up at your chest, but you knock her aside without taking any damage..");
			}
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			game.spriteSelect(89);
			var select:int = rand(3);
			if (select == 0) rollKickClawWhatTheFuckComboIsThisShit();
			else if (select == 1) chameleonTongueAttack();
			else chameleonClaws();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.bog.chameleonGirlScene.defeatChameleonGirl();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe chameleon girl recoils.  \"<i>Ew, gross!</i>\" she screetches as she runs away, leaving you to recover from your defeat alone.");
				game.cleanupAfterCombat();
			} else {
				game.bog.chameleonGirlScene.loseToChameleonGirl();
			}
		}

		override protected function outputPlayerDodged(dodge:int):void
		{
			outputText("The chameleon girl whips her head and sends her tongue flying at you, but you hop to the side and manage to avoid it.  The pink blur flies back into her mouth as quickly as it came at you, and she looks more than a bit angry that she didn't find her target.\n");
		}

		override public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				outputText("The Chameleon Girl lashes out with her tongue, but you deflect the sticky projectile off your arm, successfully defending against it.  She doesn't look happy about it when she slurps the muscle back into her mouth.");
			} else {
				outputText("The chameleon whips her head forward and sends her tongue flying at you.  It catches you in the gut, the incredible force behind it staggering you.  The pink blur flies back into her mouth as quickly as it came at you, and she laughs mockingly as you recover your footing. (" + damage + ")");
			}
		}

		/**
		 * Pairs of skinTone/skinAdj
		 */
		private const SKIN_VARIATIONS:Array = [
			["red", "black"],
			["green", "yellowish"],
			["blue", "lighter blue"],
			["purple", "bright yellow"],
			["orange", "brown"],
			["tan", "white"]
		];

		public function ChameleonGirl()
		{
			var skinToneAdj:Array = randomChoice(SKIN_VARIATIONS);
			init01Names("the ", "chameleon girl", "chameleongirl", "You're faced with a tall lizard-like girl with smooth " + skinToneAdj[0] + " skin and long, " + skinToneAdj[1] + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.");
			init02Female(VAGINA_WETNESS_SLAVERING, VAGINA_LOOSENESS_LOOSE);
			init03BreastRows("B");
			init04Ass(ANAL_LOOSENESS_NORMAL, ANAL_WETNESS_DRY);
			init05Body(rand(2) + 68, HIP_RATING_AMPLE + 2, BUTT_RATING_LARGE);
			init06Skin(skinToneAdj[0], SKIN_TYPE_PLAIN, "skin", skinToneAdj[1]);
			init07Hair("black", 15);
			init08Face();
			init09PrimaryStats(65, 65, 95, 85, 50, 45, 50);
			init10Weapon("claws", "claw", 30);
			init11Armor("skin", 20);
			init12Combat(350, 30, .25, TEMPERMENT_LOVE_GRAPPLES);
			init13Level(14, 10 + rand(50));
		}

	}

}