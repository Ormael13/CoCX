package classes.Scenes.Areas.Bog
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Skin;
import classes.Scenes.SceneLib;

public class ChameleonGirl extends Monster
	{

		public function chameleonTongueAttack():void
		{
			this.weaponName = "tongue";
			this.weaponVerb = "tongue-slap";
			this.weaponAttack = 10;
			createStatusEffect(StatusEffects.Attacks, 1, 0, 0, 0);
			eAttack();
			this.weaponAttack = 30;
			this.weaponName = "claws";
			this.weaponVerb = "claw";
		}

		//Ignores armor
		public function chameleonClaws():void
		{
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind claw-attack!\n");
			}
			//Evade:
			else if (player.getEvasionRoll()) outputText("The chameleon girl's claws slash towards you, but you lean away from them and they fly by in a harmless blur.");
			//Get hit
			else {
				var damage:Number = int((str + weaponAttack) - rand(player.tou));
				if (damage > 0) {
					outputText("The chameleon swings her arm at you, catching you with her claws.  You wince as they scratch your skin, leaving thin cuts in their wake. ");
					damage = player.takePhysDamage(damage, true);
				}
				else outputText("The chameleon swings her arm at you, catching you with her claws.  You defend against the razor sharp attack.");
			}
		}

		//Attack 3:
		public function rollKickClawWhatTheFuckComboIsThisShit():void
		{
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind roll-kick!\n");
			}
			//Evade:
			else if (player.getEvasionRoll()) {
				var damage2:Number = 1 + rand(10);
				outputText("The chameleon girl leaps in your direction, rolls, and kicks at you.  You sidestep her flying charge and give her a push from below to ensure she lands face-first in the bog. ");
				damage2 = SceneLib.combat.doDamage(damage2, true, true);
			}
			//Get hit
			else {
				var damage:Number = int((str + weaponAttack) - rand(player.tou) - player.armorDef) + 25;
				if (damage > 0) {
					outputText("The chameleon leaps in your direction, rolls, and kicks you square in the shoulder as she ascends, sending you reeling.  You grunt in pain as a set of sharp claws rake across your chest. ");
					damage = player.takePhysDamage(damage, true);
				}
				else outputText("The chameleon rolls in your direction and kicks up at your chest, but you knock her aside without taking any damage..");
			}
		}

		override protected function performCombatAction():void
		{
			var select:int = rand(3);
			if (select == 0) rollKickClawWhatTheFuckComboIsThisShit();
			else if (select == 1) chameleonTongueAttack();
			else chameleonClaws();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.bog.chameleonGirlScene.defeatChameleonGirl();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe chameleon girl recoils.  \"<i>Ew, gross!</i>\" she screetches as she runs away, leaving you to recover from your defeat alone.");
				SceneLib.combat.cleanupAfterCombatImpl();
			} else {
				SceneLib.bog.chameleonGirlScene.loseToChameleonGirl();
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
				outputText("The chameleon whips her head forward and sends her tongue flying at you.  It catches you in the gut, the incredible force behind it staggering you.  The pink blur flies back into her mouth as quickly as it came at you, and she laughs mockingly as you recover your footing. <b>([font-miss]" + damage + "[/font])</b>");
			}
		}

		/**
		 * Pairs of bodyColor/skinAdj
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
			this.a = "the ";
			this.short = "chameleon girl";
			this.imageName = "chameleongirl";
			this.long = "You're faced with a tall lizard-like girl with smooth " + skinToneAdj[0] + " skin and long, " + skinToneAdj[1] + " stripes that run along her body from ankle to shoulder.  An abnormally large tail swishes behind her, and her hands are massive for her frame, built for easily climbing the trees.  A pair of small, cute horns grow from her temples, and a pair of perky B-cups push out through her skimpy drapings.  Large, sharp claws cap her fingers, gesturing menacingly at you.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = rand(2) + 68;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skin.setBaseOnly({color:skinToneAdj[0],adj:skinToneAdj[1],type:Skin.PLAIN});
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(380, 380, 315, 285);
			initWisLibSensCor(300, 180, 135, 50);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 120;
			this.armorName = "skin";
			this.armorDef = 150;
			this.armorMDef = 60;
			this.bonusHP = 750;
			this.bonusLust = 363;
			this.lust = 30;
			this.lustVuln = .25;
			this.level = 48;
			this.gems = 50 + rand(60);
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
