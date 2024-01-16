package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.Scenes.Combat.CombatAbility;
import classes.Scenes.Combat.SpellsWhite.BlindSpell;

/**
	 * ...
	 * @author ...
	 */
	public class Shouldra extends Monster
	{

		private function shouldrattack():void {
			var damage:Number = 0;
			//return to combat menu when finished
			doNext(EventParser.playerMenu);
			//Determine if dodged!
			if(player.getEvasionRoll()) {
				outputText("The girl wades in for a swing, but you deftly dodge to the side. She recovers quickly, spinning back at you.");
				return;
			}
			//Determine damage - str modified by enemy toughness!
			damage = int((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if(damage <= 0) {
				damage = 0;
				//Due to toughness or amor...
				if(rand(player.armorDef + player.tou) < player.armorDef) outputText("You absorb and deflect every " + weaponVerb + " with your [armor].");
				else outputText("You deflect and block every " + weaponVerb + " " + a + short + " throws at you.");
			}
			//everyone else
			else {
				var choice:Number = rand(3);
				//(regular attack 1)
				if(choice == 0) outputText("Ducking in close, the girl thunders a punch against your midsection, leaving a painful sting. ");
				//(regular attack 2)
				else if(choice == 1) outputText("The girl feints a charge, leans back, and snaps a kick against your " + Appearance.hipDescription(player) + ". You stagger, correct your posture, and plunge back into combat. ");
				//(regular attack 3)
				else if(choice == 2) outputText("You momentarily drop your guard as the girl appears to stumble. She rights herself as you step forward and lands a one-two combination against your torso. ");
				damage = player.takePhysDamage(damage, true);
			}
			if(damage > 0) {
				if(lustVuln > 0 && player.armorName == "barely-decent bondage straps") {
					outputText("\n" + capitalA + short + " brushes against your exposed skin and jerks back in surprise, coloring slightly from seeing so much of you revealed.");
					lust += 5 * lustVuln;
				}
			}
			statScreenRefresh();
			outputText("\n");
		}

		//(lust attack 1)
		private function shouldraLustAttack():void {
			if(rand(2) == 0) outputText("The girl spins away from one of your swings, her tunic flaring around her hips. The motion gives you a good view of her firm and moderately large butt. She notices your glance and gives you a little wink.\n");
			else outputText("The girl's feet get tangled on each other and she tumbles to the ground. Before you can capitalize on her slip, she rolls with the impact and comes up smoothly. As she rises, however, you reel back and raise an eyebrow in confusion; are her breasts FILLING the normally-loose tunic? She notices your gaze and smiles, performing a small pirouette on her heel before squaring up to you again. Your confusion only heightens when her torso comes back into view, her breasts back to their normal proportions. A trick of the light, perhaps? You shake your head and try to fall into the rhythm of the fight.\n");
			player.takeLustDamage((8+player.effectiveLibido()/10), true);
		}
		//(magic attack)
		private function shouldraMagicLazers():void {
			outputText("Falling back a step, the girl raises a hand and casts a small spell. From her fingertips shoot four magic missiles that slam against your skin and cause a surprising amount of discomfort. ");
			var damage:Number = this.inte + rand(11);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			player.takeMagicDamage(damage, true);
			if (player.hasStatusEffect(StatusEffects.ChargeWeapon) || player.hasStatusEffect(StatusEffects.ChargeArmor) || player.statStore.hasBuff("Might") || player.statStore.hasBuff("Blink")) {
				if (player.hasStatusEffect(StatusEffects.ChargeWeapon)) player.removeStatusEffect(StatusEffects.ChargeWeapon);
				else if (player.hasStatusEffect(StatusEffects.ChargeArmor)) player.removeStatusEffect(StatusEffects.ChargeArmor);
				else if (player.statStore.hasBuff("Might")) player.statStore.removeBuffs("Might");
				else player.statStore.removeBuffs("Blink");
			}
			outputText("\n");
		}

		override public function postPlayerAbility(ability:CombatAbility, display:Boolean = true):void {
			if (ability is BlindSpell && hasStatusEffect(StatusEffects.Blind)) {
				if (display) {
					outputText("\n\nRemarkably however, it seems as if your spell has had no effect on her, and you nearly get clipped by a roundhouse as you stand, confused." + 
						" The girl flashes a radiant smile at you, and the battle continues.");
				}
				removeStatusEffect(StatusEffects.Blind);
			}
		}

		override public function midDodge():void{
			outputText("You wait patiently for your opponent to drop her guard. She ducks in and throws a right cross, which you roll away from before smacking your [weapon] against her side. Astonishingly, the attack appears to phase right through her, not affecting her in the slightest. You glance down to your [weapon] as if betrayed.\n");
		}

		override protected function performCombatAction():void
		{
			var attack:Number = rand(3);
			if(attack == 0) shouldrattack();
			else if(attack == 1) shouldraLustAttack();
			else shouldraMagicLazers();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.shouldraScene.defeatDannyPhantom();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.shouldraScene.loseToShouldra();
		}

		public function Shouldra()
		{
			this.a = "the ";
			this.short = "plain girl";
			this.imageName = "shouldra";
			this.long = "Her face has nothing overly attractive about it; a splash of freckles flits across her cheeks, her brows are too strong to be considered feminine, and her jaw is a tad bit square. Regardless, the features come together to make an aesthetically pleasing countenance, framed by a stylish brown-haired bob. Her breasts are obscured by her grey, loose-fitting tunic, flowing down to reach the middle of her thigh. Her legs are clad in snug, form-fitting leather breeches, and a comfortable pair of leather shoes shield her soles from the potentially harmful environment around her.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 65;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.bodyColor = "white";
			this.hairColor = "white";
			this.hairLength = 3;
			initStrTouSpeInte(55, 40, 10, 140);
			initWisLibSensCor(140, 120, 1, 33);
			this.weaponName = "fists";
			this.weaponVerb="punches";
			this.weaponAttack = 14;
			this.armorName = "comfortable clothes";
			this.armorDef = 1;
			this.armorMDef = 1;
			this.bonusHP = 30;
			this.bonusLust = 133;
			this.lust = 10;
			this.level = 12;
			this.gems = 0;
			this.drop = new ChainedDrop().add(consumables.ECTOPLS, 1 / 3);
			this.createPerk(PerkLib.EnemyGhostType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
