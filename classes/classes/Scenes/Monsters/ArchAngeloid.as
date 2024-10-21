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
	
	public class ArchAngeloid extends AbstractAngel
	{
		private function angelReactsToLustiness():void {
			outputText("ArchAngeloid stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Sinner!!! We.Must.Contact.Supreviser.</i>\"");
			outputText("\n\nThe archangeloid starts to burn more and more intense causing you to temporarily avert your gaze. When you look again at spot it was you could only see a bit of ashes.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function AngelHailOfBlades():void {
			
		}
		private function AngelHailOfBladesD():void {
			
		}
		
		private function AngelEnergyRays():void {
			outputText("ArchAngeloid fixates you with all of its eyes unleashing a barrage of rays at you! ");
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
			outputText("ArchAngeloid gather energy and then blasts it toward you. ");
			var damage:Number = eBaseWisdomDamage() * 0.5;
			damage += eBaseIntelligenceDamage() * 0.1;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
			outputText("\n\n");
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) {
				if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 20) createStatusEffect(StatusEffects.TranscendentSoulField, 20, 20, 0, 0);
				if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
					if (soulforce >= 20) soulforce -= 20;
					else removeStatusEffect(StatusEffects.TranscendentSoulField);
				}
			}
			else {
				if (!hasStatusEffect(StatusEffects.TranscendentSoulField) && soulforce >= 10) createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);
				if (hasStatusEffect(StatusEffects.TranscendentSoulField)) {
					if (soulforce >= 10) soulforce -= 10;
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
			createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
			addPerkValue(PerkLib.DieHardHP, 1, 12);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 10);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 10);
			HP = maxHP();
			bonusWrath += 200;
			bonusSoulforce += 400;
			outputText("Staggering back, ArchAngeloid wastes no time and above it head starts to manifest sort of halo. All irises become uniform purple colored. And around it body manifest three crossed circles with three eyes looking exactly the same as main eye down to each detail including dual irises.\n"
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
			var str:String = "You're currently fighting ";
			str += "mid - rank angel. It's looks like winged eyeball with small mouth full of jagged teeth and two eye having two";
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
		
		public function ArchAngeloid() 
		{
			super(false);
			this.a = "the ";
			this.imageName = "archangeloid";
			this.long = "";
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 1) {
				this.short = "low-rank archangeloid";
				initStrTouSpeInte(10, 120, 60, 30);
				initWisLibSensCor(160, 6, 50, -100);
				this.level = 24;
				this.bonusHP = 1000;
				this.bonusLust = 80;
				this.bonusWrath = 250;
				this.bonusSoulforce = 500;
				this.additionalXP = 150;
				this.weaponAttack = 10;
				this.armorDef = 30;
				this.armorMDef = 30;
				this.createPerk(PerkLib.DieHardHP, 12, 0, 0, 0);
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 2)  {
				this.short = "mid-rank archangeloid";
				initStrTouSpeInte(12, 140, 70, 35);
				initWisLibSensCor(180, 7, 60, -100);
				this.level = 30;
				this.bonusHP = 1200;
				this.bonusLust = 97;
				this.bonusWrath = 300;
				this.bonusSoulforce = 600;
				this.additionalXP = 180;
				this.weaponAttack = 12;
				this.armorDef = 36;
				this.armorMDef = 36;
				this.createPerk(PerkLib.DieHardHP, 15, 0, 0, 0);
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 3)  {
				this.short = "high-rank archangeloid";
			}
			this.tallness = 30;
			this.drop = new ChainedDrop()
					.add(useables.SRESIDUE, 1);
			this.level = 12;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.armorName = "skin";
			this.wings.type = Wings.FEATHERED_AVIAN;
			if (player.cor < 67) this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 10, 10, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			checkMonster();
		}
		
	}

}