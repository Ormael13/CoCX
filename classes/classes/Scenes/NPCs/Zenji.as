/**
 * ...
 * @author Pyromania
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

use namespace CoC;

	public class Zenji extends Monster
	{
		private function zenjiSpearThrust():void {
			outputText(""+(this.short == "Zenji" ? "Zenji" : "The troll")+" charges at you with a spear, ");
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (flags[kFLAGS.ZENJI_PROGRESS] == -1) outputText("you manage to dodge his oncoming attack");
				else outputText("he misses as you dodge his oncoming attack");
			}
			else {
				var damage:Number = 0;
				var boost:Number = 1;
				if (this.level > 49) boost += 1;
				if (this.level > 74) boost += 1;
				if (this.level > 99) boost += 1;
				if (this.level > 124) boost += 1;
				if (this.level > 149) boost += 1;
				damage = int(((str + 60 + weaponAttack) * boost) - Math.random()*(player.tou) - player.armorDef);
				outputText("he strikes you directly before you have a chance to avoid the oncoming attack for ");
				if (damage > 0) player.takePhysDamage(damage, true);
			}
			outputText(".");
			statScreenRefresh();
		}
		private function zenjiFeint():void {
			outputText(""+(this.short == "Zenji" ? "Zenji" : "The troll")+" charges at you with a spear, but he feints and attempts to bash your face with his tusks");
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) {
				if (flags[kFLAGS.ZENJI_PROGRESS] == -1) outputText("but you narrowly manage to avoid his tusks");
				else outputText(" but you manage to avoid his tusks");
			}
			else {
				var damage:Number = 0;
				var boost:Number = 0.4;
				if (this.level > 49) boost += 0.4;
				if (this.level > 74) boost += 0.4;
				if (this.level > 99) boost += 0.4;
				if (this.level > 124) boost += 0.4;
				if (this.level > 149) boost += 0.4;
				damage = int(((str + 50 + weaponAttack) * boost) - Math.random() * (player.tou) - player.armorDef);
				if (flags[kFLAGS.ZENJI_PROGRESS] == -1) outputText(", he strikes you for ");
				else outputText(". He strikes you for ");
				damage = player.takePhysDamage(damage, true);
				if (!player.hasPerk(PerkLib.Resolute) && rand(2) == 0) player.createStatusEffect(StatusEffects.Stunned, 0, 0, 0, 0);
			}
			outputText(".");
			statScreenRefresh();
		}
		private function zenjiEnrage():void {
			var damage:Number = 0;
			var boost:Number = 2.5;
			if (this.level > 49) boost += 2.5;
			if (this.level > 74) boost += 2.5;
			if (this.level > 99) boost += 2.5;
			if (this.level > 124) boost += 2.5;
			if (this.level > 149) boost += 2.5;
			damage = int(((str + 100 + weaponAttack) * boost) - Math.random() * (player.tou / 2) - player.armorDef);
			if (this.short == "Zenji") outputText("Zenji yells with primal wrath, he's fully intent on decimating");
			else if (flags[kFLAGS.ZENJI_PROGRESS] == -1) outputText("The troll yells with primal wrath, he's fully intent on killing");
			else outputText("The troll yells with primal wrath, he's fully intent on decimating");
			outputText(" you as he leaps toward you with tremendous force, you cannot dodge his oncoming attack as he's too fast and strikes you for ");
			damage = player.takePhysDamage(damage, true);
			outputText(".");
			this.lust = 0;
			outputText("\n\nHe remains agitated, fully intent on finishing the fight.");
			statScreenRefresh();
		}
		private function zenjiRegenerate():void {
			mana -= Math.round(maxMana() * 0.2);
			var heal:Number = 0;
			heal += Math.round(maxHP() * 0.35);
			heal += inteligencescalingbonus();
			heal += wisdomscalingbonus();
			if (this.short == "Zenji") outputText("Zenji crouches down for a moment and clutches at his wounds, \"<i>Dis is noting!</i>\" He shouts, \"<i>Ya gotta try harda dan dat!</i>\" And before your eyes, his wounds close as he heals for " + heal + ".");
			else outputText("The troll crouches down for a moment and clutches at his wounds, \"<i>YOU ARE NOTHING!</i>\" He shouts, \"<i>I WILL NOT FALL!</i>\" And before your eyes his wounds close as he heals for " + heal + ".");
			this.HP += heal;
		}
		private function zenjiPiercingBlow():void {
			outputText(""+(this.short == "Zenji" ? "Zenji" : "The troll")+" readies himself, aiming, then throws his spear like a javelin");
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 80)) > 80) outputText(". You dodge the incoming spear, but you notice "+(this.short == "Zenji" ? "Zenji" : "him")+" charging at you, he rams into your midriff, knocking the wind out of you. You struggle to regain your composure and are having trouble concentrating on spells for a moment.");
			else {
				var damage:Number = 0;
				var boost:Number = 0.4;
				if (this.level > 49) boost += 0.4;
				if (this.level > 74) boost += 0.4;
				if (this.level > 99) boost += 0.4;
				if (this.level > 124) boost += 0.4;
				if (this.level > 149) boost += 0.4;
				damage = int(((str + 50 + weaponAttack) * boost) - Math.random() * (player.tou) - player.armorDef);
				outputText(", you do your best to dodge, but the spear is moving too fast for you to move out of the way in time, it punctures you for ");
				if (this.short == "Zenji") {
					if (damage < player.maxHP() * 0.35) {
						damage = player.maxHP() * 0.35;
						player.HP -= damage;
						outputText("<b>(<font color=\"#800000\">" + damage + "</font>)</b>");
					}
					else damage = player.takePhysDamage(damage, true);
				}
				else damage = player.takePhysDamage(damage, true);
				outputText(", but he doesn't stop there, he rams into your midriff, knocking the wind out of you. You struggle to regain your composure and are having trouble concentrating on spells for a moment.");
				if (this.short == "Zenji") outputText("\n\nZenji looks down at your dazed state, \"<i>Ahaha! Say my name! Say it!</i>\"");
			}
			player.createStatusEffect(StatusEffects.PiercingBlow,2,0,0,0);
		}
		
		override protected function performCombatAction():void
		{
			if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) {
				if (this.level > 49) {
					if ((this.lust > this.maxLust() * .8) || (this.HP < this.maxHP() * .3)) zenjiEnrage();
					else if (this.HP < this.maxHP() * .4 && mana > maxMana() * 0.2) zenjiRegenerate();
					else {
						var choice5:Number = rand(4);
						if (choice5 < 2) zenjiSpearThrust();
						if (choice5 == 2) zenjiFeint();
						if (choice5 == 3) {
							if (player.hasStatusEffect(StatusEffects.PiercingBlow)) zenjiFeint();
							else zenjiPiercingBlow();
						}
					}
				}
				else if (this.level > 39) {
					if ((this.lust > this.maxLust() * .8) || (this.HP < this.maxHP() * .3)) zenjiEnrage();
					else if (this.HP < this.maxHP() * .4 && mana > maxMana() * 0.2) zenjiRegenerate();
					else {
						var choice4:Number = rand(3);
						if (choice4 < 2) zenjiSpearThrust();
						if (choice4 == 2) zenjiFeint();
					}
				}
				else {
					if (this.lust > this.maxLust() * .8) zenjiEnrage();
					else {
						var choice3:Number = rand(3);
						if (choice3 < 2) zenjiSpearThrust();
						if (choice3 == 2) zenjiFeint();
					}
				}
			}
			else if (flags[kFLAGS.ZENJI_PROGRESS] == -1 || flags[kFLAGS.ZENJI_PROGRESS] == 5 || flags[kFLAGS.ZENJI_PROGRESS] == 6 || flags[kFLAGS.ZENJI_PROGRESS] == 10) {
				if (this.lust > this.maxLust() * .8 || this.HP < this.maxHP() * .3) zenjiEnrage();
				else if (this.HP < this.maxHP() * .4 && mana > maxMana() * 0.2) zenjiRegenerate();
				else {
					var choice2:Number = rand(4);
					if (choice2 < 2) zenjiSpearThrust();
					if (choice2 == 2) zenjiFeint();
					if (choice2 == 3) {
						if (player.hasStatusEffect(StatusEffects.PiercingBlow)) zenjiFeint();
						else zenjiPiercingBlow();
					}
				}
			}
			else {
				if (this.lust > this.maxLust() * .8) zenjiEnrage();
				else {
					var choice1:Number = rand(3);
					if (choice1 < 2) zenjiSpearThrust();
					if (choice1 == 2) zenjiFeint();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (flags[kFLAGS.ZENJI_PROGRESS] == 8) SceneLib.zenjiScene.followerZenjiSparZenjiDefeated();
			else if (flags[kFLAGS.ZENJI_PROGRESS] > 5) SceneLib.zenjiScene.part2TrollEncounterRepeatFightZenjiDefeated();
			else if (flags[kFLAGS.ZENJI_PROGRESS] == 5) SceneLib.zenjiScene.part2TrollEncounterFirstFightZenjiDefeated();
			else if (flags[kFLAGS.ZENJI_PROGRESS] == -1) SceneLib.zenjiScene.part1TrollEncounterFightTOTHEDEATHZenjiDefeated();
			else SceneLib.zenjiScene.part1TrollEncounterFightZenjiDefeated();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (flags[kFLAGS.ZENJI_PROGRESS] == 8) SceneLib.zenjiScene.followerZenjiSparPCDefeated();
			else if (flags[kFLAGS.ZENJI_PROGRESS] > 5) SceneLib.zenjiScene.part2TrollEncounterRepeatFightPCDefeated();
			else if (flags[kFLAGS.ZENJI_PROGRESS] == 5) SceneLib.zenjiScene.part2TrollEncounterFirstFightPCDefeated();
			else if (flags[kFLAGS.ZENJI_PROGRESS] == -1) SceneLib.zenjiScene.part1TrollEncounterFightTOTHEDEATHPCDefeated();
			else SceneLib.zenjiScene.part1TrollEncounterFightPCDefeated();
		}
		
		public function Zenji() 
		{
			if (flags[kFLAGS.ZENJI_PROGRESS] >= 1 && (flags[kFLAGS.ZENJI_PROGRESS] < 8 || flags[kFLAGS.ZENJI_PROGRESS] == 10)) {
				initStrTouSpeInte(145, 140, 135, 125);
				initWisLibSensCor(135, 20, 40, 0);
				this.weaponAttack = 50;
				this.armorDef = 50;
				this.armorMDef = 200;
				this.level = 25;
			}
			if (flags[kFLAGS.ZENJI_PROGRESS] == -1 || flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) {
				initStrTouSpeInte(145, 140, 135, 125);
				initWisLibSensCor(135, 20, 40, 0);
				this.weaponAttack = 50;
				this.armorDef = 50;
				this.armorMDef = 200;
				this.additionalXP = 125;
				if (player.level > 25 && player.level < 185) {
					this.level = player.level;
					this.strStat.core.value += 29 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.touStat.core.value += 28 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.speStat.core.value += 27 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.intStat.core.value += 25 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.wisStat.core.value += 27 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.weaponAttack += 5 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.armorDef += 5 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.armorMDef += 20 * Math.round((player.level - 20) / 5) * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.additionalXP += 25 * Math.round((player.level - 20) / 5);
				}
				else if (player.level >= 185) {
					this.level = 185;
					this.strStat.core.value += 957 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.touStat.core.value += 924 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.speStat.core.value += 891 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.intStat.core.value += 825 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.wisStat.core.value += 891 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.weaponAttack += 165 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.armorDef += 165 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.armorMDef += 660 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
					this.additionalXP += 825;
				}
				else this.level = 25;
			}
			if (flags[kFLAGS.ZENJI_PROGRESS] == 5) {
				initStrTouSpeInte(145, 140, 135, 125);
				initWisLibSensCor(135, 20, 40, 0);
				this.weaponAttack = 50;
				this.armorDef = 50;
				this.armorMDef = 200;
				this.level = 25;
			}
			if (flags[kFLAGS.ZENJI_PROGRESS] < 5) {
				this.a = "the ";
				this.short = "troll";
			}
			else {
				this.a = "";
				this.short = "Zenji";
			}
			this.imageName = "zenji";
			if (flags[kFLAGS.ZENJI_PROGRESS] >= 5) this.long = "You are fighting Zenji. He is over 8 feet tall, covered in green fuzz and has a lithe, yet notably muscular build. He has tusks protruding from his mouth each about 8 inches long curving upwards. He stands tall, ready to deflect your blows. You can tell by his softer features, perfect symmetry and handsome face that he’s actually quite young. His tail sways gently behind him, trying to keep balance and a steady rhythm.";
			if (flags[kFLAGS.ZENJI_PROGRESS] >= 1 && flags[kFLAGS.ZENJI_PROGRESS] < 5) this.long = "You are fighting what appears to be an adult troll male. He is over 8 feet tall, covered in green fuzz and has a lithe, yet notably muscular build. He has tusks protruding from his mouth each about 8 inches long curving upwards. He stands tall, ready to deflect your blows. You can tell by his softer features, perfect symmetry and handsome face that he’s actually quite young. His tail sways gently behind him, trying to keep balance and a steady rhythm.";
			if (flags[kFLAGS.ZENJI_PROGRESS] == -1) this.long = "You are fighting what appears to be an adult troll male. He is over 8 feet tall, covered in green fuzz and has a lithe, yet notably muscular build. He has tusks protruding from his mouth each about 8 inches long curving upwards. He stands tall, having recovered from previous ordeals. He is unyielding, sensing your corruption now, ready to end this quarrel. His tail is tucked between his legs, is he afraid or trying to prevent it from being injured?";
			// this.plural = false;
			this.createCock(7.5,2.2);
			this.balls = 2;
			this.ballSize = 3;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 50;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 98;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "skin";
			this.hairColor = "green";
			this.hairLength = 2;
			this.weaponName = "spear";
			this.weaponVerb="stab";
			this.armorName = "green fuzz";
			this.lust = 0;
			this.lustVuln = .1;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.gems = rand(10) + 5;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.HydraRegeneration, 0.5, 0, 0, 0);
			this.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			if ((flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) && this.level >= 40) this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}