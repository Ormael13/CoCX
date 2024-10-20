/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons.RiverDungeon 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Items.DynamicItems;
	import classes.Scenes.Monsters.AbstractAngel;
	import classes.Scenes.SceneLib;
	import classes.internals.ChainedDrop;
	
	public class MistAngelMR extends AbstractAngel
	{
		private function angelReactsToLustiness():void {
			outputText("Angel with it lil helpers stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Tricky one opponent. Fighting like a demon.</i>\"");
			outputText("\n\nThe angel starts then to shine with pure white light so intense you must temporarily avert your gaze. When you look again at spot it was you could only see a bit of powder.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function AngelEnergyRays():void {
			outputText(""+this.short+" lil helpers fixates at you with all of their eyes unleashing a barrage of rays at you! ");
			var omni:Number = 8;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 3;
			while (omni-->0) AngelEnergyRaysD();
			outputText("\n\n");
		}
		private function AngelEnergyRaysD():void {
			var damage:Number = eBaseWisdomDamage() * 0.65;
			damage += eBaseIntelligenceDamage() * 0.17;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
		}
		
		private function AngelBaseAttack():void {
			outputText(""+this.short+" gather energy between his palms and then blasts it toward you. ");
			var damage:Number = eBaseWisdomDamage();
			damage += eBaseIntelligenceDamage() * 0.3;
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
		private function soulfieldsustaincost():Number {
			var sfsc:Number = 15;
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) sfsc *= 2.8;
			return sfsc;
		}
		
		private function angelification():void {
			clearOutput();
			touStat.core.value *= 4;
			speStat.core.value *= 2;
			wisStat.core.value *= 8;
			addPerkValue(PerkLib.MonsterRegeneration, 1, 2);
			addPerkValue(PerkLib.DieHardHP, 1, 39);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 39);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 39);
			bonusWrath += 700;
			bonusSoulforce += 1400;
			HP = maxHP();
			outputText("Staggering back, angelic trio wastes no time and above their heads starts to manifest sort of halo. All their irises become uniform purple colored. And around bodies manifest two crossed circles with pair of eyes looking exactly the same as main eye down to each detail including dual irises.");
			outputText("\n\n\"<i>Don't be afraid of the Mist!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
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
				else cleanupAfterCombat();
			}
			else angelReactsToLustiness();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByMidRankMistAngel();
		}
		
		override public function get long():String
		{
			var str:String = "You're currently fighting "+this.short+". It's looks like example of perfect human with large pair of wings and around it hoover two pairs of winged eyeballs with small mouth full of jagged teeth and one eyes having two";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises each. Around each of their bodies are three circles each with pair of eyes looking the same as the main eye and above angel head hoover halo.";
			else str += " irises each, one red and the other blue. Angel eyes also mirrors this with right one been red and left blue one.";
			str += " All five of them have their bodies covered in nearly not visible purple lines that glows ocassionaly.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of puple protective field surrounding it.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function MistAngelMR() 
		{
			super(false);
			this.a = "the ";
			this.short = "mid-rank angel of mist";
			this.imageName = "angel";
			this.long = "";
			initStrTouSpeInte(36, 400, 220, 120);
			initWisLibSensCor(540, 6, 180, -100);
			this.tallness = 30;
			this.randomDropChance = 0.5;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_MINOR_HIGH
			};
			this.drop = new ChainedDrop()
					.add(useables.SRESIDUE, 0.5)
					.add(useables.PCSHARD, 1);
			this.level = 58;
			this.bonusHP = 4000;
			this.bonusLust = 234;
			this.bonusWrath = 800;
			this.bonusSoulforce = 2000;
			this.additionalXP = 500;
			this.weaponAttack = 36;
			this.armorDef = 110;
			this.armorMDef = 110;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.armorName = "skin";
			this.wings.type = Wings.FEATHERED_AVIAN;
			if (player.cor < 67) this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 39, 39, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 39, 0, 0, 0);
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			checkMonster();
		}
		
	}

}