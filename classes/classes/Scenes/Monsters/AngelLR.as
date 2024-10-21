/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Items.DynamicItems;
	import classes.Scenes.Dungeons.RiverDungeon;
	import classes.Scenes.SceneLib;
	import classes.internals.ChainedDrop;

import coc.view.CoCButton;

public class AngelLR extends AbstractAngel
	{
		public var floor4:RiverDungeon = new RiverDungeon();
		
		private function angelReactsToLustiness():void {
			outputText("Angel with it lil helpers stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Tricky one opponent. Fighting like a demon.</i>\"");
			outputText("\n\nThe angel starts then to shine with pure white light so intense you must temporarily avert your gaze. When you look again at spot it was you could only see a bit of powder.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		private function angelSwitchWithOtherOne():void {
			clearOutput();
			outputText(this.short + " with it lil helpers stops their actions defeated.");
			outputText("\n\n\"<i>Tricky one opponent. Need assistance.</i>\"");
			outputText("\n\nThe angel starts then to shine with pure white light so intense you must temporarily avert your gaze. When you look again at spot it was you could see other angel with it helpers all ready to next round of the fight while the defeated one is recovering at the arena side.");
			touStat.core.value *= 0.25;
			speStat.core.value *= 0.5;
			wisStat.core.value *= 0.125;
			addPerkValue(PerkLib.DieHardHP, 1, -6);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, -6);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, -6);
			bonusWrath -= 200;
			bonusSoulforce -= 400;
			HP = maxHP();
			lust = 0;
			removeStatusEffect(StatusEffects.TrueFormAngel);
			if (this.short == "Gabriel") this.short = "Uriel";
			else this.short = "Gabriel";
			if (hasStatusEffect(StatusEffects.Stunned)) removeStatusEffect(StatusEffects.Stunned);
			if (hasStatusEffect(StatusEffects.StunnedTornado)) removeStatusEffect(StatusEffects.StunnedTornado);
			if (hasStatusEffect(StatusEffects.InkBlind)) removeStatusEffect(StatusEffects.InkBlind);
			if (hasStatusEffect(StatusEffects.Fascinated)) removeStatusEffect(StatusEffects.Fascinated);
			if (hasStatusEffect(StatusEffects.FrozenSolid)) removeStatusEffect(StatusEffects.InkBlind);
			if (hasStatusEffect(StatusEffects.Sleep)) removeStatusEffect(StatusEffects.InkBlind);
			if (hasStatusEffect(StatusEffects.Polymorphed)) removeStatusEffect(StatusEffects.Polymorphed);
			if (hasStatusEffect(StatusEffects.JabberwockyVenom)) {
				removeStatusEffect(StatusEffects.JabberwockyVenom);
				buff("Poison").remove();
			}
			doNext(SceneLib.combat.combatMenu, false);
		}
		
		private function AngelEnergyRays():void {
			outputText((player.hasStatusEffect(StatusEffects.SoulArena)?""+this.short+"":"Angel")+" lil helpers fixates at you with all of their eyes unleashing a barrage of rays at you! ");
			var omni:Number = 4;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 3;
			while (omni-->0) AngelEnergyRaysD();
			outputText("\n\n");
		}
		private function AngelEnergyRaysD():void {
			var damage:Number = eBaseWisdomDamage() * 0.75;
			damage += eBaseIntelligenceDamage() * 0.15;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
		}
		
		private function AngelBaseAttack():void {
			outputText((player.hasStatusEffect(StatusEffects.SoulArena)?""+this.short+"":"Angel")+" gather energy between his palms and then blasts it toward you. ");
			var damage:Number = eBaseWisdomDamage();
			damage += eBaseIntelligenceDamage() * 0.2;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= (soulfieldsustaincost()*2)) createStatusEffect(StatusEffects.ATranscendentSoulField, (soulfieldsustaincost()*2), (soulfieldsustaincost()*2), 0, 0);
				if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
					if (soulforce >= (soulfieldsustaincost()*2)) soulforce -= (soulfieldsustaincost()*2);
					else removeStatusEffect(StatusEffects.ATranscendentSoulField);
				}
			}
			else {
				if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= soulfieldsustaincost()) createStatusEffect(StatusEffects.ATranscendentSoulField, soulfieldsustaincost(), soulfieldsustaincost(), 0, 0);
				if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
					if (soulforce >= soulfieldsustaincost()) soulforce -= soulfieldsustaincost();
					else removeStatusEffect(StatusEffects.ATranscendentSoulField);
				}
			}
			var choice:Number = rand(5);
			if (choice == 0) AngelEnergyRays();
			if (choice > 0) AngelBaseAttack();
		}
		override public function postPlayerBusyBtnSpecial(btnSpecial1:CoCButton, btnSpecial2:CoCButton):void{
			if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				if (!player.hasStatusEffect(StatusEffects.MinoKing) && player.companionsInPCParty()) btnSpecial1.show("Dish Helper", SceneLib.hexindao.dishHelperIL);
				else btnSpecial1.showDisabled("Dish Helper", "You don't have anyone to take care of second angel!");
			}
		}
		private function soulfieldsustaincost():Number {
			var sfsc:Number = 10;
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) sfsc *= 2.8;
			return sfsc;
		}
		
		private function angelification():void {
			clearOutput();
			touStat.core.value *= 4;
			speStat.core.value *= 2;
			wisStat.core.value *= 8;
			addPerkValue(PerkLib.MonsterRegeneration, 1, 2);
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				addPerkValue(PerkLib.DieHardHP, 1, 28);
				addStatusValue(StatusEffects.TranscendentSoulField, 1, 28);
				addStatusValue(StatusEffects.TranscendentSoulField, 2, 28);
				bonusWrath += 700;
				bonusSoulforce += 1400;
			}
			else if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				addPerkValue(PerkLib.DieHardHP, 1, 6);
				addStatusValue(StatusEffects.TranscendentSoulField, 1, 6);
				addStatusValue(StatusEffects.TranscendentSoulField, 2, 6);
				bonusWrath += 200;
				bonusSoulforce += 400;
			}
			else {
				addPerkValue(PerkLib.DieHardHP, 1, 10);
				addStatusValue(StatusEffects.TranscendentSoulField, 1, 10);
				addStatusValue(StatusEffects.TranscendentSoulField, 2, 10);
				bonusWrath += 300;
				bonusSoulforce += 600;
			}
			HP = maxHP();
			outputText("Staggering back, angelic trio wastes no time and above their heads starts to manifest sort of halo. All their irises become uniform purple colored. And around bodies manifest two crossed circles with pair of eyes looking exactly the same as main eye down to each detail including dual irises.");
			outputText("\n\n\"<i>Don't be afraid"+(player.hasStatusEffect(StatusEffects.RiverDungeonA)?" of the Mist":"")+"!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
			createStatusEffect(StatusEffects.TrueFormAngel, 0, 0, 0, 0);
			SceneLib.combat.combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				if (!hasStatusEffect(StatusEffects.TrueFormAngel)) {
					angelification();
					return;
				}
				if (player.hasStatusEffect(StatusEffects.SoulArena)) {
					if (player.hasStatusEffect(StatusEffects.MinoKing)) {
						player.removeStatusEffect(StatusEffects.MinoKing);
						SceneLib.hexindao.intermediateleadershippostfight();
					}
					else {
						SceneLib.combat.disableEachHelperIfTheyCauseSoftLock();
						angelSwitchWithOtherOne();
					}
				}
				else cleanupAfterCombat();
			}
			else {
				if (player.hasStatusEffect(StatusEffects.SoulArena)) {
					if (player.hasStatusEffect(StatusEffects.MinoKing)) {
						player.removeStatusEffect(StatusEffects.MinoKing);
						SceneLib.hexindao.intermediateleadershippostfight();
					}
					else angelSwitchWithOtherOne();
				}
				else angelReactsToLustiness();
			}
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) floor4.defeatedByLowRankMistAngel();
			else cleanupAfterCombat();
		}
		
		override public function get long():String
		{
			var str:String = "You're currently fighting"+(player.hasStatusEffect(StatusEffects.SoulArena)?" "+this.short+" a":"")+" low-rank angel"+(player.hasStatusEffect(StatusEffects.RiverDungeonA)?" of mist":"")+". It's looks like example of perfect human with large pair of wings and around it hoover pair of winged eyeballs with small mouth full of jagged teeth and one eyes having two";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises each. Around each of their bodies are two circles each with pair of eyes looking the same as the main eye and above angel head hoover halo.";
			else str += " irises each, one red and the other blue. Angel eyes also mirrors this with right one been red and left blue one.";
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) str += " All three of them have their bodies covered in nearly not visible purple lines that glows ocassionaly.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of ";
				if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) str += "puple";
				else str += "orange";
				str += " protective field surrounding it.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function AngelLR() 
		{
			super(false);
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.short = "low-rank angel of mist";
				initStrTouSpeInte(24, 340, 180, 80);
				initWisLibSensCor(480, 4, 120, -100);
				this.randomDropChance = 0.5;
				this.randomDropParams = {
					rarity: DynamicItems.RARITY_CHANCES_MINOR_HIGH
				};
				this.drop = new ChainedDrop()
						.add(useables.SRESIDUE, 0.5)
						.add(useables.PCSHARD, 1);
				this.level = 42;
				this.bonusHP = 3000;
				this.bonusLust = 166;
				this.bonusWrath = 700;
				this.bonusSoulforce = 1400;
				this.additionalXP = 420;
				this.weaponAttack = 30;
				this.armorDef = 90;
				this.armorMDef = 90;
				this.createStatusEffect(StatusEffects.ATranscendentSoulField, 28, 28, 0, 0);//X times less dmg, +X lvl diff bonus
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.createPerk(PerkLib.DieHardHP, 28, 0, 0, 0);
			}
			else if (player.hasStatusEffect(StatusEffects.SoulArena)) {
				if (rand(2) == 0) this.short = "Gabriel";
				else this.short = "Uriel";
				initStrTouSpeInte(6, 75, 35, 15);
				initWisLibSensCor(100, 3, 25, -100);
				this.randomDropChance = 0.5;
				this.randomDropParams = {
					rarity: DynamicItems.RARITY_CHANCES_MINOR_HIGH
				};
				this.drop = new ChainedDrop()
						.add(useables.SRESIDUE, 1);
				this.level = 9;
				this.bonusHP = 400;
				this.bonusLust = 36;
				this.bonusWrath = 100;
				this.bonusSoulforce = 200;
				this.additionalXP = 60;
				this.weaponAttack = 4;
				this.armorDef = 9;
				this.armorMDef = 9;
				this.createStatusEffect(StatusEffects.ATranscendentSoulField, 6, 6, 0, 0);//X times less dmg, +X lvl diff bonus
				this.createPerk(PerkLib.DieHardHP, 6, 0, 0, 0);
			}
			else {
				this.short = "low-rank angel";
				initStrTouSpeInte(7, 80, 40, 20);
				initWisLibSensCor(120, 4, 30, -100);
				this.randomDropChance = 0.2;
				this.randomDropParams = {
					rarity: DynamicItems.RARITY_CHANCES_MINOR_HIGH
				};
				this.drop = new ChainedDrop()
						.add(useables.SRESIDUE, 1);
				this.level = 15;
				this.bonusHP = 600;
				this.bonusLust = 49;
				this.bonusWrath = 150;
				this.bonusSoulforce = 300;
				this.additionalXP = 90;
				this.weaponAttack = 6;
				this.armorDef = 18;
				this.armorMDef = 18;
				this.createStatusEffect(StatusEffects.ATranscendentSoulField, 10, 10, 0, 0);//X times less dmg, +X lvl diff bonus
				this.createPerk(PerkLib.DieHardHP, 10, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "angel";
			this.long = "";
			this.tallness = 30;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.armorName = "skin";
			this.wings.type = Wings.FEATHERED_AVIAN;
			if (player.cor < 67) this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			checkMonster();
		}
		
	}

}