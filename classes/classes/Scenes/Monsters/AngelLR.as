/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Scenes.SceneLib;
	import classes.internals.ChainedDrop;
	
	public class AngelLR extends AbstractAngel
	{
		private function angelReactsToLustiness():void {
			outputText("Angel with it lil helpers stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Tricky one opponent. Fighting like a demon.</i>\"");
			outputText("\n\nThe angel starts then to shine with pure white light so intense you must temporaly avert your gaze. When you look again at spot it was you could only see a bit of powder.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function AngelEnergyRays():void {
			outputText("Angel lil helpers fixates at you with all of their eyes unleashing a barrage of rays at you! ");
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
			outputText("Angel gather energy between his palms and then blasts it toward you. ");
			var damage:Number = eBaseWisdomDamage();
			damage += eBaseIntelligenceDamage() * 0.2;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= 20) createStatusEffect(StatusEffects.ATranscendentSoulField, 20, 20, 0, 0);
				if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
					if (soulforce >= 20) soulforce -= 20;
					else removeStatusEffect(StatusEffects.ATranscendentSoulField);
				}
			}
			else {
				if (!hasStatusEffect(StatusEffects.ATranscendentSoulField) && soulforce >= 10) createStatusEffect(StatusEffects.ATranscendentSoulField, 10, 10, 0, 0);
				if (hasStatusEffect(StatusEffects.ATranscendentSoulField)) {
					if (soulforce >= 10) soulforce -= 10;
					else removeStatusEffect(StatusEffects.ATranscendentSoulField);
				}
			}
			var choice:Number = rand(5);
			if (choice == 0) AngelEnergyRays();
			if (choice > 0) AngelBaseAttack();
		}
		
		private function angelification():void {
			clearOutput();
			var TB:Number = Math.round(touStat.core.value * 0.4);
			var SB:Number = Math.round(speStat.core.value * 0.2);
			var WB:Number = Math.round(wisStat.core.value * 0.6);
			touStat.core.value += TB;
			speStat.core.value += SB;
			wisStat.core.value += WB;
			addPerkValue(PerkLib.MonsterRegeneration, 1, 2);
			addPerkValue(PerkLib.DieHardHP, 1, 10);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 10);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 10);
			HP = maxHP();
			bonusWrath += 300;
			bonusSoulforce += 600;
			outputText("Staggering back, Angelic trio wastes no time and above their heads starts to manifest sort of halo. All their irises become uniform purple colored. And around bodies manifest two crossed circles with pair of eyes looking exactly the same as main eye down to each detail including dual irises.\n"
				+ "\"<i>Don't be afraid!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
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
				cleanupAfterCombat();
			}
			else angelReactsToLustiness();
		}
		
		override public function get long():String
		{
			var str:String = "You're currently fighting low-rank angel. It's looks like example of perfect human with large pair of wings and around it hoover pair of winged eyeballs with small mouth full of jagged teeth and one eyes having two";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises each. Around each of their bodies are two circles each with pair of eyes looking the same as the main eye and above angel head hoover halo.";
			else str += " irises each, one red and the other blue. Angel eyes also mirrors this with right one been red and left blue one.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding it.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function AngelLR() 
		{
			super(false);
			this.a = "the ";
			this.short = "low-rank angel";
			this.imageName = "angel";
			this.long = "";
			initStrTouSpeInte(7, 80, 40, 20);
			initWisLibSensCor(120, 4, 30, 0);
			this.tallness = 30;
			this.drop = new ChainedDrop()
					.add(useables.SRESIDUE, 1);
			this.level = 15;
			this.bonusHP = 600;
            this.bonusLust = 49;
			this.bonusWrath = 150;
			this.bonusSoulforce = 300;
			this.additionalXP = 90;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.weaponAttack = 6;
			this.armorName = "skin";
			this.armorDef = 18;
			this.armorMDef = 18;
			this.wings.type = Wings.FEATHERED_AVIAN;
			if (player.cor < 67) this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 10, 10, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 10, 0, 0, 0);
			checkMonster();
		}
		
	}

}