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
import classes.Scenes.SceneLib;
import classes.StatusEffects.Combat.BasiliskSlowDebuff;
import classes.internals.*;
import classes.Monster;
	
public class Tyrantia extends Monster
	{
		public static function tyraniaSpeed(player:Player,amount:Number = 0):void {
			var bse:BasiliskSlowDebuff = player.createOrFindStatusEffect(StatusEffects.BasiliskSlow) as BasiliskSlowDebuff;
			bse.applyEffect(amount);
		}
		
		private function tyrantiaLustAura():void {
			outputText("Tyrantia’s eyes close momentarily, and a wave of energy pulses from her, in sickening pink and black waves. Lust and pain intermingled fills your senses for a split second, and she groans. The energy stops, leaving you hornier, and feeling a little dirtier, than before.\n\n");
			player.dynStats("cor", 1, "lus", (8 + int(player.effectiveLibido() / 15 + player.effectiveSensitivity() / 15 + player.cor / 20)));
		}
		
		private function tyrantiaBasicAttack():void {
			outputText("The Giantess Drider stabs toward you, her phallus-spear glistening. Your body feels warmer wherever the thing touches you, blood flowing faster than usual. ");
			var dmg0:Number = 0;
			dmg0 += this.str * 3;
			dmg0 += eBaseStrengthDamage() * 2;
			dmg0 += this.weaponAttack * 3;
			dmg0 = Math.round(dmg0);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.takePhysDamage(dmg0, true);
			player.dynStats("lus", (4 + int(player.effectiveLibido() / 20 + player.effectiveSensitivity() / 20 + player.cor / 25)));
		}
		
		private function tyrantiaWebbing():void {
			
		}
		
		private function tyrantiaCharge():void {
			
		}
		
		private function tyrantiaPounce():void {
			outputText("As you finish your attack, the violet eyes of the spider-girl flash with sudden anger. The shaft of her Dick flashes in your vision before nailing you in the side of the head. As you reel in pain, her front legs strike you in the shoulder. Before you can react, you’re on the ground, and all you can see are her bladed limbs. ");
			if (rand(2) == 0) {
				outputText("You notice a single weak point in her armor, the single metal flap on the front of her spider half. You surge up, jamming your fist as hard as you can into it. The metal and leather slide aside...and your fist enters a surprisingly warm, wet crevasse. The drider on top of you wails in surprise...and something else. Well, if you didn’t know what you’d entered before, you do now. She bucks, your fist exiting with a moist *pop*, and the giantess backs up, her tan cheeks bright red.\n\n");
				outputText("\"<i>Fighting Dirty like that?!</i>\" She hisses. \"<i>I’ll show you.</i>\"\n");
				dynStats("lus", 15);
				teased(15);
			}
			else {
				outputText("Unable to throw the giant Drider off of you, she sinks two of her bladed limbs into your body, seemingly at random. You buck, the cold steel sending rippling pain through you, to no effect. ");
				var dmg3:Number = 0;
				dmg3 += this.str * 3;
				dmg3 += eBaseStrengthDamage() * 2;
				dmg3 = Math.round(dmg3);
				player.takePhysDamage(dmg3, true);
				player.takePhysDamage(dmg3, true);
			}
		}
		
		private function tyrantiaLustzerk():void {
			wrath -= 50;
			outputText("Tyrantia makes no motion towards you, but her smile grows. She licks her arm, where one of your strikes had injured her. The wound doesn’t seem to phase her, and her five functioning eyes narrow. \"<i>You’re a tricky one, aren’t you?</i>\" She coos, and you can feel the skin on your back crawling. \"<i>I know exactly how I’m paying you back.</i>\" The black aura around her thickens, and a small pink layer forms underneath.\n\n");
			this.weaponAttack += (40 + (40 * (1 + player.newGamePlusMod)));
			createStatusEffect(StatusEffects.Lustzerking,10,0,0,0);
		}
		
		private function tyrantiaFangs():void {
			outputText("The massive Drider charges at you. You sidestep her Dick, but that proved to be a feint. She rams you with her shoulder, then grabs you in her furry arms. You squirm, but her fangs sink into your exposed neck, leaving you both flushed and in pain. Blood squirts from your neck, and as you push, getting out from her grip, you can feel your muscles slackening.\n\n");
			player.dynStats("lus", (2 + int(player.effectiveLibido() / 25 + player.effectiveSensitivity() / 25 + player.cor / 30)));
			tyraniaSpeed(player,5);
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Lustzerking)) {
				wrath += 5;
				if (statusEffectv1(StatusEffects.Lustzerking) > 1) addStatusValue(StatusEffects.Lustzerking, 1, -1);
				else {
					this.weaponAttack -= (40 + (40 * (1 + player.newGamePlusMod)));
					removeStatusEffect(StatusEffects.Lustzerking);
				}
			}
			tyrantiaLustAura();
			//if () 
			//else {
				var choice0:Number = rand(6);
				switch (choice0) {
					case 0:
					case 1:
					case 2:
						tyrantiaBasicAttack();
						break;
					//	if (HPRatio() < .5 && rand(3) == 0 && (mana >= spellCostHeal())) castHealDinah();
					//	break;
					//	else if (mana >= spellCostArouse()) castArouseDinah();
					//	break;
					case 3:
						tyrantiaPounce();
						break;
					case 4:
						/*if (!hasStatusEffect(StatusEffects.Lustzerking) && wrath >= 50) tyrantiaLustzerk();
						else */tyrantiaBasicAttack();
						break;
					case 5:
						tyrantiaFangs();
						break;
					default:
						tyrantiaBasicAttack();
				}
			//}
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
			this.skinTone = "brown";
			this.hairColor = "black";
			this.hairLength = 24;
			initStrTouSpeInte(275, 310, 190, 150);
			initWisLibSensCor(100, 280, 150, 100);
			this.weaponName = "Dick";
			this.weaponVerb="piercing stab";
			this.weaponAttack = 100;
			this.armorName = "carapace";
			this.armorDef = 200;
			this.armorMDef = 200;
			//this.bonusHP = 300;
			this.bonusLust = 488;
			this.lustVuln = .1;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 58;
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
			checkMonster();
		}
		
	}

}