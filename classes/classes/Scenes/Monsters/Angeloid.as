/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Items.DynamicItems;
	import classes.Scenes.SceneLib;
	import classes.internals.ChainedDrop;
	
	public class Angeloid extends AbstractAngel
	{
		private function angelReactsToLustiness():void {
			outputText("Angeloid stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Sinner!!! We.Must.Contact.Supreviser.</i>\"");
			outputText("\n\nThe angeloid starts to burn more and more intense causing you to temporarily avert your gaze. When you look again at spot it was you could only see a bit of ashes.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function AngelEnergyRays():void {
			var omni:Number = 0;
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 1) {
				omni += 2;
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 3;
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 2) {
				omni += 4;
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 4;
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 3) {
				omni += 6;
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 5;
			}
			outputText("Angeloid fixates you with "+(hasStatusEffect(StatusEffects.TrueFormAngel)?"all of its eyes":"it eye")+" unleashing a barrage of rays at you! ");
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
			outputText("Angeloid gather energy and then blasts it toward you. ");
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
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 1) {
				addPerkValue(PerkLib.DieHardHP, 1, 3);
				bonusWrath += 100;
				bonusSoulforce += 200;
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 2) {
				addPerkValue(PerkLib.DieHardHP, 1, 6);
				bonusWrath += 200;
				bonusSoulforce += 400;
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 3) {
				addPerkValue(PerkLib.DieHardHP, 1, 9);
				bonusWrath += 300;
				bonusSoulforce += 600;
			}
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 5);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 5);
			HP = maxHP();
			outputText("Staggering back, Angeloid wastes no time and above it head starts to manifest sort of halo. ");
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 1) outputText("Both irises become uniform purple colored. And around it body manifest two crossed circles with pair of eyes looking exactly the same as main eye down to each detail including dual irises.");
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 2) outputText("All irises become uniform purple colored. And around it body manifest three crossed circles with three eyes looking exactly the same as main eye down to each detail including dual irises.");
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 3) outputText("All irises become uniform purple colored. And around it body manifest four crossed circles with two pairs of eyes looking exactly the same as main eye down to each detail including dual irises.");
			outputText("\n\n\"<i>Don't be afraid!!!</i>\" it whispers loud enough for you to hear before launching up to continue the fight.");
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
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 1) {
				str += "low-rank angeloid. It's looks like winged eyeball with small mouth full of jagged teeth and one eye having two";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises. Around it body are two circles each with pair of eyes looking the same as the main eye and above head hoover halo.";
				else str += " irises, one red and the other blue.";
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 2) {
				str += "mid-rank angeloid. It's looks like winged eyeball with small mouth full of jagged teeth and two eye having two";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises each. Around it body are three circles each with three eyes looking the same as the main eye and above head hoover halo.";
				else str += " irises each, one red and the other blue.";
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 3) {
				str += "high-rank angeloid. It's looks like winged eyeball with small mouth full of jagged teeth and three eyes having two";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises each. Around it body are four circles each with two pairs of eyes looking the same as the main eye and above head hoover halo.";
				else str += " irises each, one red and the other blue.";
			}
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective field surrounding it.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function Angeloid() 
		{
			super(false);
			this.a = "the ";
			this.imageName = "angeloid";
			this.long = "";
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 1) {
				this.short = "low-rank angeloid";
				initStrTouSpeInte(3, 40, 20, 10);
				initWisLibSensCor(80, 2, 10, -100);
				this.level = 6;
				this.bonusHP = 200;
				this.bonusLust = 17;
				this.bonusWrath = 50;
				this.bonusSoulforce = 100;
				this.additionalXP = 30;
				this.weaponAttack = 2;
				this.armorDef = 6;
				this.armorMDef = 6;
				this.createPerk(PerkLib.DieHardHP, 3, 0, 0, 0);
				this.createPerk(PerkLib.EnemyForBeginnersType, 0, 0, 0, 0);
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 2) {
				this.short = "mid-rank angeloid";
				initStrTouSpeInte(5, 60, 30, 15);
				initWisLibSensCor(100, 3, 20, -100);
				this.level = 12;
				this.bonusHP = 400;
				this.bonusLust = 33;
				this.bonusWrath = 100;
				this.bonusSoulforce = 200;
				this.additionalXP = 60;
				this.weaponAttack = 4;
				this.armorDef = 12;
				this.armorMDef = 12;
				this.createPerk(PerkLib.DieHardHP, 6, 0, 0, 0);
			}
			if (player.statusEffectv1(StatusEffects.AngelsChooser) == 3) {
				this.short = "high-rank angeloid";
				initStrTouSpeInte(7, 80, 40, 20);
				initWisLibSensCor(120, 4, 30, -100);
				this.level = 18;
				this.bonusHP = 600;
				this.bonusLust = 49;
				this.bonusWrath = 150;
				this.bonusSoulforce = 300;
				this.additionalXP = 90;
				this.weaponAttack = 6;
				this.armorDef = 18;
				this.armorMDef = 18;
				this.createPerk(PerkLib.DieHardHP, 9, 0, 0, 0);
			}
			this.tallness = 30;
			this.randomDropChance = 0.2;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_MINOR_LOW
			};
			this.drop = new ChainedDrop()
					.add(useables.SRESIDUE, 1);
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.armorName = "skin";
			this.wings.type = Wings.FEATHERED_AVIAN;
			if (player.cor < 67) this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			checkMonster();
		}
		
	}

}