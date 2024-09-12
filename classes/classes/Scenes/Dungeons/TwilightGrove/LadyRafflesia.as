/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.TwilightGrove 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class LadyRafflesia extends Monster
	{
		public function trapLevel(adjustment:Number = 0):Number {
			if(!hasStatusEffect(StatusEffects.Level)) createStatusEffect(StatusEffects.Level,6,0,0,0);
			if(adjustment != 0) {
				addStatusValue(StatusEffects.Level,1,adjustment);
				if(statusEffectv1(StatusEffects.Level) < 1) changeStatusValue(StatusEffects.Level,1,1);
				if(statusEffectv1(StatusEffects.Level) > 6) changeStatusValue(StatusEffects.Level,1,6);
			}
			return statusEffectv1(StatusEffects.Level);
		}
		
		public function ladyRafflesiaVineStrike():void {
			outputText("Rafflesia laughs as her vines ready for an attack.\n\n");
			outputText("<i>\"Mmmmm playtime is over... I will eat you now.\"</i>\n\n");
			outputText("Rafflesia’s vines swiftly coil around you, immobilizing your body.");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_SPEED) outputText("\n\nYou successfully dodge her vines!");
			else if (evade != null) outputText("\n\nYou successfully dodge her vines thanks to your superior evasion!");
			else {
				outputText(" ");
				var damage:int = (eBaseStrengthDamage() + rand(str));
				damage = Math.round(damage);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
			}
		}
		
		public function ladyRafflesiaPollenCloud():void {
			outputText("Rafflesia laughs sinisterly as her flower puffs up and unleashes a massive cloud of pollen. Oh damn!\n\n");
			createStatusEffect(StatusEffects.LustAura, 0, 0, 0, 0);
		}
		
		public function ladyRafflesiaStrangulate():void {
			outputText(""+this.short+"’s vines suddenly wrap tight around your neck and strangle you, preventing you from pronouncing any incantations. The plant woman gives you an annoyed glare.");
			outputText("\"<i>I’m done with your magic. Be a good " + player.mf("boy", "girl") + " and just give in.</i>\"");
			player.removeStatusEffect(StatusEffects.CastedSpell);
			player.createStatusEffect(StatusEffects.Sealed, 2, 10, 0, 0);
		}
		
		public function ladyRafflesiaGrab():void {
			outputText("Rafflesia’s vines swiftly coil around you, immobilizing your body.\n\n");
			outputText("<i>\"Mmmmm playtime is over... I will eat you now.\"</i>\n\n");
			player.createStatusEffect(StatusEffects.LadyRafflesiaGrab, 2 + rand(5), 0, 0, 0);
		}
		
		public function ladyRafflesiaTeaseAttack():void {
			if (rand(2) == 1) {
				outputText(""+this.short+" parts her grass-like hair away to reveal her supple breasts, moving her other hand to her nectar drenched pussy then back to her mouth. She sensually licks her fingers clean, then blows you a kiss.\n\n");
				outputText("\"<i>Don’t you want a taste of what my lovely body can offer? It is all yours to play with, all you need to do is give in to me.</i>\"\n\n");
			}
			else {
				outputText(""+this.short+" grabs some of her nectar suggestively, letting it flow all over her breast, thigh and even in her hair.\n\n");
				outputText("\"<i>Mmmmmmm I so love being covered in sticky fluids. How about you?</i>\"\n\n");
			}
			outputText("Unable to take your gaze away from her lewd show, you feel yourself getting more aroused. ");
			var lustDmg:int = rand(player.lib / 20) + rand(this.lib / 10) + 10;
			player.takeLustDamage(lustDmg, true);
			outputText("\n\n");
		}
		
		public function ladyRafflesiaEnergyDrain():void {
			outputText("Rafflesia’s vines begin to crush your body with insane pressure as small thorns prickle your skin drawing blood. She seems to have regained some vitality as blood is slowly sapped out of your body. ");
			var damage:int = (eBaseStrengthDamage() + rand(str));
			damage = Math.round(damage);
			player.takePhysDamage(damage, true);
			addHP(Math.round(damage * 0.1));
			player.addCurse("tou", Math.round(player.touStat.value * 0.05), 2);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(2 + rand(2)), 0.05, 0, 0);
			}
		}
		
		public function ladyRafflesiaDevourservants():void {
			outputText("Rafflesia looks at one of the green succubi on the ground and smirks, her linked tendril working twice as fast as the demon yelps in discomfort, its body reaching several orgasms in no time and filling the tentacle with fluids before passing out. Rafflesia licks her lips as most of her wounds heal.\n\n");
			outputText("\"<i>Cum and fem juices… the best treat.</i>\"\n\n");
			if (hasStatusEffect(StatusEffects.LadyRafflesiaDevSer)) addStatusValue(StatusEffects.LadyRafflesiaDevSer, 1, 1);
			else createStatusEffect(StatusEffects.LadyRafflesiaDevSer, 1, 0, 0, 0);
			addHP(Math.round(maxHP()*0.5));
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Level)) {
				if (!hasStatusEffect(StatusEffects.Stunned) && player.hasStatusEffect(StatusEffects.CastedSpell)) ladyRafflesiaStrangulate();
				else if (player.hasStatusEffect(StatusEffects.LadyRafflesiaGrab)) ladyRafflesiaEnergyDrain();
				else if (HPRatio() < .5 && statusEffectv1(StatusEffects.LadyRafflesiaDevSer) < 5) ladyRafflesiaDevourservants();
				else {
					var choice:Number = rand(3);
					if (choice == 0) ladyRafflesiaTeaseAttack();
					if (choice == 1) {
						if (!hasStatusEffect(StatusEffects.LustAura)) ladyRafflesiaPollenCloud();
						else ladyRafflesiaTeaseAttack();
					}
					if (choice == 2) ladyRafflesiaGrab();
				}
				if (!hasStatusEffect(StatusEffects.Climbed)) {
					outputText("\n\nMeanwhile the vines keep pulling you toward the pitcher.");
					trapLevel(-1);
				}
				else removeStatusEffect(StatusEffects.Climbed);
			}
			else super.performCombatAction();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatLadyRafflesia();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatedByLadyRafflesia();
		}
		
		public function LadyRafflesia() 
		{
			this.a = " ";
			this.short = "Lady Rafflesia";
			this.long = "Sadly no description been provided beside name: Lady Rafflesia.";// You are fighting against an Alraune, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.
			this.bodyColor = "lavender";
			this.hairColor = "pink";
			initStrTouSpeInte(330, 390, 28, 170);
			initWisLibSensCor(170, 330, 160, 100);
			this.armorDef = 300;
			this.armorMDef = 60;
			this.bonusHP = 1000;
			this.bonusLust = 532;
			this.level = 42;
			this.drop = new WeightedDrop().
			add(consumables.RAUNENECT,7).
			addMany(1,consumables.MARAFRU,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.MOONGRASS,
					consumables.SNAKEBANE,
					consumables.IRONWEED,
					consumables.BLADEFERN);
			this.imageName = "alraune";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.PLANT_FLOWER;
			this.hairLength = 6;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 1;
			this.armorName = "skin";
			this.lust = 20 + rand(40);
			this.lustVuln = 0.15;
			this.gems = rand(20) + 5;
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.AlrauneRunDisabled, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.Level,6,0,0,0);
			checkMonster();
		}
		
	}

}