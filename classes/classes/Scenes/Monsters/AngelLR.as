/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Scenes.SceneLib;
	
	public class AngelLR extends AbstractAngel
	{
		private function angelReactsToLustiness():void {
			outputText("Angel stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Sinner!!! We.Must.Contact.Supreviser.</i>\"");
			outputText("\n\nThe angel starts to burn more and more intense causing you to temporaly avert your gaze. When you look agian at spot it was you could only see a bit of ashes.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function AngelEnergyRays():void {
			outputText("Angel fixates you with "+(hasStatusEffect(StatusEffects.TrueFormAngel)?"all of its eyes":"it eye")+" unleashing a barrage of rays at you! ");
			var omni:Number = 2;
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
			outputText("Angel gather energy and then blasts it toward you. ");
			var damage:Number = eBaseWisdomDamage() * 0.5;
			damage += eBaseIntelligenceDamage() * 0.1;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 10) createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);
				if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
					if (soulforce >= 10) soulforce -= 10;
					else removeStatusEffect(StatusEffects.TranscendentSoulField);
				}
			}
			else {
				if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 5) createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);
				if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
					if (soulforce >= 5) soulforce -= 5;
					else removeStatusEffect(StatusEffects.TranscendentSoulField);
				}
			}
			var choice:Number = rand(5);
			if (choice == 0) AngelEnergyRays();
			if (choice > 0) AngelBaseAttack();
		}
		
		private function angelification():void {
			clearOutput();
			var TB:Number = Math.round(touStat.core.value * 0.2);
			var SB:Number = Math.round(speStat.core.value * 0.1);
			var WB:Number = Math.round(wisStat.core.value * 0.3);
			touStat.core.value += TB;
			speStat.core.value += SB;
			wisStat.core.value += WB;
			createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			addPerkValue(PerkLib.DieHardHP, 1, 3);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 5);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 5);
			HP = maxHP();
			bonusWrath += 100;
			bonusSoulforce += 200;
			outputText("Staggering back, Angel wastes no time and above it head starts to manifest sort of halo. Both irises become uniform purple colored. And around it body manifest two crossed circles with pair of eyes looking exactly the same as main eye down to each detail including dual irises.\n"
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
			var str:String = "You're currently fighting low-rank angel. It's looks like winged eyeball with small mouth full of jagged teeth and one eye having two";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises. Around it body are two circles each with pair of eyes looking the same as the main eye and above head hoover halo.";
			else str += " irises, one red and the other blue.";
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
			initStrTouSpeInte(3, 40, 20, 10);
			initWisLibSensCor(80, 2, 10, 0);
			this.tallness = 30;
			this.drop = NO_DROP;
			this.level = 6;
			this.bonusHP = 200;
            this.bonusLust = 17;
			this.bonusWrath = 50;
			this.bonusSoulforce = 100;
			this.additionalXP = 30;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.weaponAttack = 2;
			this.armorName = "skin";
			this.armorDef = 6;
			this.armorMDef = 6;
			this.wings.type = Wings.FEATHERED_AVIAN;
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 3, 0, 0, 0);
			checkMonster();
		}
		
	}

}