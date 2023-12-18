/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.Monster;

import coc.view.CoCButton;

public class Tyrantia extends Monster
	{
		private function lustFromHits():Number {
			return (25 + int(player.effectiveLibido() / 5 + player.effectiveSensitivity() / 5 + player.cor / 5));
		}
		private function lustzerkerBoost():Number {
			return (150 + (30 * player.newGamePlusMod()));
		}
		
		private function tyrantiaLustAura():void {
			outputText("Tyrantia’s eyes close momentarily, and a wave of energy pulses from her, in sickening pink and black waves. Lust and pain intermingled fills your senses for a split second, and she groans. The energy stops, leaving you hornier, and feeling a little dirtier, than before.\n\n");
			player.dynStats("cor", 1, "lus", (lustFromHits() * 2));
		}
		
		private function tyrantiaBasicAttack():void {
			outputText("The Giantess Drider stabs toward you, her phallus-spear glistening. Your body feels warmer wherever the thing touches you, blood flowing faster than usual. ");
			var lust0:Number = lustFromHits();
			var dmg0:Number = 0;
			dmg0 += this.str * 3;
			dmg0 += eBaseStrengthDamage() * 2;
			dmg0 += this.weaponAttack * 3;
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 2) dmg0 *= (1 + (0.1 * (flags[kFLAGS.TYRANTIA_LVL_UP] - 1)));
			dmg0 = Math.round(dmg0);
			lust0 *= 3;
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takeLustDamage(lust0, true);
		}
		
		private function tyrantiaWebbing():void {
			if ((rand(player.spe) > this.spe / 2)) outputText("You flatten yourself to the ground as Tyrantia spins. A thin glob of ebony goo flies over your head, hissing as it hits the ground behind you. You turn back, catching a glimpse of the grass and dirt around the point of impact. The plants around the glob die, fading from vibrant green to an odd brown-black. It’s a good thing it missed!");
			else {
				outputText("Tyrantia turns, exposing her spinnerets. You brace yourself, expecting webbing, but instead, a viscous goop strikes you in the chest. It burns!");
				var dmg1:Number = this.inte * 0.2;
				dmg1 += eBaseIntelligenceDamage() * 0.2;
				dmg1 = Math.round(dmg1);
				dmg1 = player.takeAcidDamage(dmg1, true);
				if (!player.immuneToAcid()) {
					if (player.hasStatusEffect(StatusEffects.AcidDoT)) player.addStatusValue(StatusEffects.AcidDoT, 1, 1);
					else player.createStatusEffect(StatusEffects.AcidDoT, 5, 10, 0, 0);
				}
				player.buff("Goop Web").addStats( {"spe":-25} ).withText("Goop Web").combatPermanent();
			}
		}
		
		private function tyrantiaCharge():void {
			if ((rand(player.spe) > this.spe / 2)) outputText("As the giantess backs up, you brace yourself. She charges, and you throw yourself to one side, narrowly avoiding her charge.");
			else {
				outputText("Tyrantia scuttles backward, then lunges forward, more like an oversized horse than a spider. Her Dick strikes you square in the chest.");
				if (!player.hasPerk(PerkLib.Resolute)) {
					outputText(" The blow sends you sprawling to the ground, stunned.");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				var dmg2:Number = 0;
				var crit:Boolean = false;
				var critChance:int = 15;
				var critMulti:Number = 1.75;
				if (hasPerk(PerkLib.GrandTactician) && this.inte >= 150) {
					if (this.inte <= 300) critChance += (this.inte - 150) / 5;
					if (this.inte > 300) critChance += 30;
				}
				dmg2 += this.str * 4;
				dmg2 += eBaseStrengthDamage() * 3;
				dmg2 += this.weaponAttack * 4;
				if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 2) dmg2 *= (1 + (0.2 * (flags[kFLAGS.TYRANTIA_LVL_UP] - 1)));
				if (rand(100) < critChance) {
					crit = true;
					dmg2 *= critMulti;
				}
				if (hasPerk(PerkLib.Naturaljouster)) {
					if (hasPerk(PerkLib.NaturaljousterMastergrade)) dmg2 *= 5;
					else dmg2 *= 3;
				}
				dmg2 = Math.round(dmg2);
				player.takePhysDamage(dmg2, true);
				if (crit) outputText("<b> Critical!</b>");
				player.takeLustDamage(lustFromHits(), true);
			}
		}
		
		private function tyrantiaPounce():void {
			outputText("As you finish your attack, the violet eyes of the spider-girl flash with sudden anger. The shaft of her Dick flashes in your vision before nailing you in the side of the head. As you reel in pain, her front legs strike you in the shoulder. Before you can react, you’re on the ground, and all you can see are her bladed limbs. <b>You’ve been pinned!</b>");
			player.createStatusEffect(StatusEffects.Pounced, 2, 0, 0, 0);
		}
		public function tyrantiaPouncedStruggle():void {
			if ((rand(player.str) > this.str / 2) || player.hasPerk(PerkLib.FluidBody)) tyrantiaPounceSuccess();
			else tyrantiaPounceFail();
			SceneLib.combat.enemyAIImpl();
		}
		public function tyrantiaPouncedWait():void {
			tyrantiaPounceFail();
			SceneLib.combat.enemyAIImpl();
		}
		private function tyrantiaPounceSuccess():void {
			player.removeStatusEffect(StatusEffects.Pounced);
			clearOutput();
			outputText("You notice a single weak point in her armor, the single metal flap on the front of her spider half. You surge up, jamming your fist as hard as you can into it. The metal and leather slide aside...and your fist enters a surprisingly warm, wet crevasse. The drider on top of you wails in surprise...and something else. Well, if you didn’t know what you’d entered before, you do now. She bucks, your fist exiting with a moist *pop*, and the giantess backs up, her tan cheeks bright red.\n\n");
			outputText("\"<i>Fighting Dirty like that?!</i>\" She hisses. \"<i>I’ll show you.</i>\"\n");
			var lustDang:Number = 15 + rand(15);
			player.takeLustDamage(lustDang, true);
			if (player.armor == armors.ELFDRES && player.isElf()) lustDang *= 2;
			if (player.armor == armors.FMDRESS && player.isWoodElf()) lustDang *= 2;
			teased(lustDang);
		}
		private function tyrantiaPounceFail():void {
			player.addStatusValue(StatusEffects.Pounced, 1, -1);
			if (player.getStatusValue(StatusEffects.Pounced, 1) == 0)
				player.removeStatusEffect(StatusEffects.Pounced);
			clearOutput();
			outputText("Unable to throw the giant Drider off of you, she sinks two of her bladed limbs into your body, seemingly at random. You buck, the cold steel sending rippling pain through you, to no effect. ");
			var dmg3:Number = 0;
			dmg3 += this.str * 4;
			dmg3 += eBaseStrengthDamage() * 3;
			dmg3 += this.weaponAttack;
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 2) dmg3 *= (1 + (0.1 * (flags[kFLAGS.TYRANTIA_LVL_UP] - 1)));
			dmg3 = Math.round(dmg3);
			player.takePhysDamage(dmg3, true);
			player.takePhysDamage(dmg3, true);
		}
		
		private function tyrantiaLustzerk():void {
			wrath -= 50;
			outputText("Tyrantia makes no motion towards you, but her smile grows. She licks her arm, where one of your strikes had injured her. The wound doesn’t seem to phase her, and her five functioning eyes narrow. \"<i>You’re a tricky one, aren’t you?</i>\" She coos, and you can feel the skin on your back crawling. \"<i>I know exactly how I’m paying you back.</i>\" The black aura around her thickens, and a small pink layer forms underneath.\n\n");
			this.weaponAttack += lustzerkerBoost();
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		private function tyrantiaFangs():void {
			outputText("The massive Drider charges at you. You sidestep her Dick, but that proved to be a feint. She rams you with her shoulder, then grabs you in her furry arms. You squirm, but her fangs sink into your exposed neck, leaving you both flushed and in pain. Blood squirts from your neck, and as you push, getting out from her grip, you can feel your muscles slackening.\n\n");
			player.takeLustDamage((lustFromHits() * 4), true);
			player.buff("Goop Web").addStats( {"spe":-20} ).withText("Goop Web").combatPermanent();
		}
		override public function changeBtnWhenBound(btnStruggle:CoCButton, btnBoundWait:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.Pounced)) {
				outputText("\n<b>You’re trapped underneath the giant Drider, and all you can see is her armored undercarriage. Eight legs jab down at you, steel glinting dangerously. You need to get out of here, or you’ll end up crushed!</b>");
				btnStruggle.call(tyrantiaPouncedStruggle);
				btnBoundWait.call(tyrantiaPouncedWait);
			}
		}
		protected override function outputDefaultTeaseReaction(lustDelta:Number):void {
			if (lustDelta == 0) outputText("\n" + capitalA + short + " seems unimpressed.");
			if (lustDelta > 0 && lustDelta < 4) outputText("\n" + capitalA + short + " looks intrigued by what " + pronoun1 + " sees.");
			if (lustDelta >= 4 && lustDelta < 10) outputText("\n" + capitalA + short + " definitely seems to be enjoying the show.");
			if (lustDelta >= 10) outputText("\nYou notice a clear liquid dripping from a small hatch on the armored Drider’s front, right where her snatch should be. Her black aura intensifies as you look. Clearly, this Giantess isn’t as cold as she pretends to be!");
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= lustzerkerBoost();
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			if (TyrantiaFollower.TyrantiaFollowerStage < 2 || (player.hasStatusEffect(StatusEffects.SparingTyrantia) && player.statusEffectv1(StatusEffects.SparingTyrantia) > 0)) tyrantiaLustAura();
			//if ()
			//else {
				var choice0:Number = rand(6);
				switch (choice0) {
					case 0:
						tyrantiaBasicAttack();
						break;
					case 1:
						tyrantiaWebbing();
						break;
					case 2:
						tyrantiaCharge();
						break;
					case 3:
						tyrantiaPounce();
						break;
					case 4:
						if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) tyrantiaLustzerk();
						else tyrantiaBasicAttack();
						break;
					case 5:
						tyrantiaFangs();
						break;
					default:
						tyrantiaBasicAttack();
				}
			//}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SparingTyrantia)) SceneLib.tyrantia.TyrantiaLostSparring(hpVictory);
			else SceneLib.tyrantia.postFightOptions(hpVictory);
		}
		
		override public function get long():String
		{
			var str:String = "";
			str += "The Drider Giantess stands off, her Dick held firmly in both hands. The spear quivers as she keeps it level, the tip and long shaft between you and her. The giantess’s fangs quiver, clear liquid beading on the ends. Her black lips are drawn into a tight smile, her five functioning eyes glaring, and you see the razor-sharp boot-spikes on her eight legs glinting in the sunlight. She stands 14 feet tall, and the air around her starts to darken as you approach. Maybe this wasn’t the best idea.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at her posture and gaze indicates that she's currently under effect of some sort of berserking state.</b>";
			}
			return str;
		}
		
		public function Tyrantia()
		{
			if (flags[kFLAGS.TYRANTIA_LVL_UP] < 2) {
				initStrTouSpeInte(295, 310, 190, 150);
				initWisLibSensCor(100, 280, 100, 100);
				this.weaponAttack = 150;
				this.armorDef = 300;
				this.armorMDef = 300;
				this.bonusHP = 2000;
				this.bonusLust = 438;
				this.level = 58;
			}
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 2 && flags[kFLAGS.TYRANTIA_LVL_UP] < 4) {
				var mod:int = (flags[kFLAGS.TYRANTIA_LVL_UP] - 1);
				initStrTouSpeInte(295 + 20*mod, 310 + 25*mod, 190 + 15*mod, 150 + 10*mod);
				initWisLibSensCor(100 + 5*mod, 280 + 20*mod, 100 + 20*mod, 100);
				this.weaponAttack = 150 + 10*mod;
				this.armorDef = 300 + 20*mod;
				this.armorMDef = 300 + 20*mod;
				this.bonusHP = 2000 + 1000*mod;
				this.bonusLust = 438 + 46*mod;
				this.level = 58 + 6*mod;
			}
			if (flags[kFLAGS.TYRANTIA_LVL_UP] == 4) {
				initStrTouSpeInte(355, 385, 235, 180);
				initWisLibSensCor(115, 340, 160, 100);
				this.weaponAttack = 180;
				this.armorDef = 360;
				this.armorMDef = 360;
				this.bonusHP = 5000;
				this.bonusLust = 576;
				this.level = 76;
			}
			this.a = "";
			this.short = "Tyrantia";
			this.imageName = "corrupteddrider";
			this.long = "";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,100,0,0,0);
			this.tallness = 14*12;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_JIGGLY;
			this.bodyColor = "brown";
			this.hairColor = "black";
			this.hairLength = 24;
			this.weaponName = "Dick";
			this.weaponVerb="piercing stab";
			this.armorName = "carapace";
			this.lustVuln = .2;
			this.gems = rand(10) + 40;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,1)
					.add(consumables.UNICORN,1)
					.add(useables.T_SSILK,3)
					.add(null,5);
			this.ears.type = Ears.HORSE;
			this.horns.type = Horns.BICORN;
			this.horns.count = 6;
			this.lowerBody = LowerBody.DRIDER;
			this.createPerk(PerkLib.EnemyHugeType,0,0,0,0);
			this.createPerk(PerkLib.TankI,0,0,0,0);
			this.createPerk(PerkLib.GoliathI,0,0,0,0);
			this.createPerk(PerkLib.CheetahI,0,0,0,0);
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 2) {
				this.createPerk(PerkLib.EpicStrength,0,0,0,0);
				this.createPerk(PerkLib.EpicSpeed,0,0,0,0);
				this.createPerk(PerkLib.Naturaljouster,0,0,0,0);
			}
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 3) {
				this.createPerk(PerkLib.EpicToughness,0,0,0,0);
				this.createPerk(PerkLib.GrandTactician,0,0,0,0);
				this.createPerk(PerkLib.ImmovableObject,0,0,0,0);
			}
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 4) {
				this.createPerk(PerkLib.Juggernaut,0,0,0,0);
				this.createPerk(PerkLib.JobWarrior,0,0,0,0);
				this.createPerk(PerkLib.InhumanDesireI,0,0,0,0);
			}
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 5) {
				this.createPerk(PerkLib.LegendaryStrength,0,0,0,0);
				this.createPerk(PerkLib.LegendarySpeed,0,0,0,0);
				this.createPerk(PerkLib.NaturaljousterMastergrade,0,0,0,0);
			}
			if (flags[kFLAGS.TYRANTIA_LVL_UP] >= 6) {
				this.createPerk(PerkLib.LegendaryToughness,0,0,0,0);
				this.createPerk(PerkLib.DemonicDesireI,0,0,0,0);
				//this.createPerk(PerkLib.,0,0,0,0);
			}
			checkMonster();
		}
	}
}
