/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Scenes.SceneLib;
	
	public class AngelMR extends AbstractAngel
	{
		private function AngelEnergyRays():void {
			outputText("Angel fixates you with all of its eyes unleashing a barrage of rays at you! ");
			var omni:Number = 4;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 4;
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
			if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 5) createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);
			if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
				if (soulforce >= 5) soulforce -= 5;
				else removeStatusEffect(StatusEffects.TranscendentSoulField);
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
			addPerkValue(PerkLib.DieHardHP, 1, 6);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 5);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 5);
			HP = maxHP();
			bonusWrath += 200;
			bonusSoulforce += 400;
			outputText("Staggering back, Angel wastes no time and above it head starts to manifest sort of halo. All irises become uniform purple colored. And around it body manifest three crossed circles with three eyes looking exactly the same as main eye down to each detail including dual irises.\n"
				+ "\"<i>Don't be afraid!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
			createStatusEffect(StatusEffects.TrueFormAngel, 0, 0, 0, 0);
			SceneLib.combat.combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (!hasStatusEffect(StatusEffects.TrueFormAngel)) {
				angelification();
				return;
			}
			cleanupAfterCombat();
		}
		
		override public function get long():String
		{
			var str:String = "You're currently fighting mid-rank angel. It's looks like winged eyeball with small mouth full of jagged teeth and two eye having two";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises each. Around it body are three circles each with three eyes looking the same as the main eye and above head hoover halo.";
			else str += " irises each, one red and the other blue.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding it.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function AngelMR() 
		{
			super(false);
			this.a = "the ";
			this.short = "mid-rank angel";
			this.imageName = "angel";
			this.long = "";
			initStrTouSpeInte(5, 60, 30, 15);
			initWisLibSensCor(120, 3, 20, 0);
			this.tallness = 30;
			this.drop = NO_DROP;
			this.level = 12;
			this.bonusHP = 400;
            this.bonusLust = 33;
			this.bonusWrath = 100;
			this.bonusSoulforce = 200;
			this.additionalXP = 60;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.weaponAttack = 4;
			this.armorName = "skin";
			this.armorDef = 12;
			this.armorMDef = 12;
			this.wings.type = Wings.FEATHERED_AVIAN;
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 6, 0, 0, 0);
			checkMonster();
		}
		
	}

}