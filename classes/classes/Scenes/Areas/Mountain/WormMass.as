package classes.Scenes.Areas.Mountain
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Combat.General.TeaseSkill;

public class WormMass extends Monster
	{
		public function wormAttack():void {
			//Dodged!
			if(player.getEvasionRoll()) {
				outputText("The worm colony flails at you with its simulated arms, but its lack of coordination allows you to easily dodge its attack.\n");
				return;
			}
			var temp:int = int((str + weaponAttack) - Math.random()*(player.tou+player.armorDef));
			if(temp <= 0) temp = 1;
			if(temp > 0) player.takePhysDamage(temp);
			outputText("The worm colony strikes at you with its makeshift limbs. It strikes you for ");
			outputText(String(temp));
			outputText(" damage and the limb splatters, dispersing the worms comprising the false arm.");
			statScreenRefresh();
			outputText("\n");
			return;
		}
		
		public function wormsEntice():void {
			//FAIL
			if(rand(2) == 0) {
				if(player.lust < 50) outputText("The worm colony stands before you and begins secreting a significant amount of slime. You are perplexed as to why the worms have done this. You shrug your shoulders and remain on guard.\n");
				else outputText("The worm colony shambles over to you and attempts to grapple you. Quickly sidestepping the clumsy movements of the creature, you avoid what could have been a horrible fate as the mass falls over and splatters in its failed attempt to engulf you.\n");
				return;
			}
			//SUCCESS
			if(player.lust < 50) {
				outputText("The worm colony stands before you and begins secreting a significant amount of slime. Inexplicably, you find that your [cock] is already erect and is throbbing. The erection is quite meddlesome and you find yourself distracted by the unwanted arousal.\n");
				player.takeLustDamage(10+player.lib/20+player.cor/20, true);
			}
			else {
				outputText("The worm colony shambles over to you and attempts to grapple you. Attempting to dodge, you fail to get away fast enough and fall to the ground engulfed by the mass. You are completely covered in the slimy worms!!! Incapable of avoiding any of their movements, you feel their slime coat every inch of your body and you feel the struggle and strain of each individual worm as they crawl all over you. You immediately begin flailing wildly as you cannot even breathe!");
				//Chance of insta-loss if infested twice
				if(player.hasStatusEffect(StatusEffects.InfestAttempted)) {
					outputText("  Struggle as you might, the creatures overwhelm your body and prevent you from any conceivable opportunity to get them off you, Your head quickly becomes visible, allowing you to breathe as you stare helplessly at the cocoon of worms trapping you.\n\n");
					SceneLib.mountain.wormsScene.infest1();
					return;
				}
				//Escaped!
				else {
					outputText("\n\nYou struggle wildly as you fight the worm colony for both air and to get the things off you. The sticky slime secreted by the individual worms greatly increases your task. After freeing one of your arms, you uncover your face, allowing you to breathe, and begin sweeping the beasts from your body. Stunned by your renewed vigor, the mass loses its cohesion, allowing your to quickly clear the worms from your body. The disbanded colony retreats a distance from you and begins reforming itself as you purge your body of the annelids.");
					player.createStatusEffect(StatusEffects.InfestAttempted,0,0,0,0);
				}
			}
		}

		override public function midAttackSeal():Boolean{
			var dam:int = int(player.str / 5 - rand(5));
			if (dam == 0) dam = 1;
			outputText("You strike at the amalgamation, crushing countless worms into goo, dealing <b>[font-damage]" + dam + "[/font]</b> damage.\n\n");
			this.HP -= dam;
			return false;
		}

		override public function interceptPlayerAbility(ability:CombatAbility):Boolean {
			if (ability is TeaseSkill) {
				outputText("Thinking to take advantage of its humanoid form, you wave your cock and slap your ass. However, the creature fails to react to your suggestive actions.\n\n");
				return true;
			}

			return false;
		}

		override protected function performCombatAction():void
		{
			//Worms have different AI
			if (rand(2) == 0)
				special1();
			else special2();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			outputText("Overcome by your "+(hpVictory?"wounds":"lust")+", you sink to your knees as the colony of worms swarms all over your body...\n\n", true);
			SceneLib.mountain.wormsScene.infest1();
		}
		
		override public function maxHP():Number
		{
			return 40 + (player.newGamePlusMod() * 20);
		}

		public function WormMass()
		{
			trace("WormMass Constructor!");
			this.a = "the ";
			this.short = "worms";
			this.imageName = "worms";
			this.long = "Before you stands the horrid mass of worms. It has shifted itself and now takes the shape of a humanoid composed completely of the worms in the colony. Its vaguely human shape lumbers towards you in a clearly aggressive manner.";
			this.plural = true;
			initGenderless();
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createBreastRow(0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 1;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.bodyColor = "white";
			initStrTouSpeInte(110, 240, 30, 1);
			initWisLibSensCor(1, 90, 60, 90);
			this.weaponName = "worm";
			this.weaponVerb="slap";
			this.weaponAttack = 10;
			this.armorName = "skin";
			this.armorDef = 50;
			this.armorMDef = 10;
			this.bonusLust = 185;
			this.lust = 30;
			this.lustVuln = 0.01;
			this.level = 35;
			this.gems = 0;
			this.special1 = wormAttack;
			this.special2 = wormsEntice;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
