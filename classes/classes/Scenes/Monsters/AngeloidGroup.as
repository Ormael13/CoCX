package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.BodyParts.Wings;
	import classes.Items.DynamicItems;
	import classes.Scenes.SceneLib;
	import classes.internals.ChainedDrop;
	
	public class AngeloidGroup extends AbstractAngel
	{
		private function angelsReactsToLustiness():void {
			outputText("Angeloids stops their actions clearly overflowing with lust.");
			outputText("\n\n\"<i>Sinner!!! We.Must.Contact.Supreviser.</i>\"");
			outputText("\n\nThe angeloids starts to burn more and more intense causing you to temporarily avert your gaze. When you look again at spot they were you could only see a bit of ashes.");
			gems = 0;
			XP = 0;
			HP = minHP() - 1;
			SceneLib.combat.cleanupAfterCombatImpl();
		}
		
		private function AngelEnergyRays():void {
			outputText("Angeloids fixates you with all of their eyes unleashing a barrage of concentrated rays at you! ");
			var omni:Number = 10;
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) omni *= 3;
			while (omni-->0) AngelEnergyRaysD();
			outputText("\n\n");
		}
		private function AngelEnergyRaysD():void {
			var damage:Number = eBaseWisdomDamage() * 3;
			damage += eBaseIntelligenceDamage() * 0.6;
			damage = Math.round(damage);
			damage = player.takeMagicDamage(damage, true);
		}
		
		private function AngelBaseAttack():void {
			outputText("Angeloids gather energy and then blasts it toward you. ");
			var damage:Number = eBaseWisdomDamage() * 2;
			damage += eBaseIntelligenceDamage() * 0.4;
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
			var TB:Number = Math.round(touStat.core.value * 0.4);
			var SB:Number = Math.round(speStat.core.value * 0.2);
			var WB:Number = Math.round(wisStat.core.value * 0.6);
			touStat.core.value += TB;
			speStat.core.value += SB;
			wisStat.core.value += WB;
			createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			addPerkValue(PerkLib.DieHardHP, 1, 8);
			addStatusValue(StatusEffects.TranscendentSoulField, 1, 5);
			addStatusValue(StatusEffects.TranscendentSoulField, 2, 5);
			HP = maxHP();
			bonusWrath += 400;
			bonusSoulforce += 700;
			outputText("Staggering back, Angeloids wastes no time and above their heads starts to manifest halos. All irises become uniform purple colored. And around body manifest few crossed circles with few eyes looking exactly the same as main eye down to each detail including dual irises.\n"
				+ "\"<i>Don't be afraid!!! Embrace the light!!!</i>\" their unified voices sounds almost as cheer before they all launching up to continue the fight.");
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
			else angelsReactsToLustiness();
		}
		
		override public function get long():String
		{
			var str:String = "You're currently fighting group of low to high ranked angeloids. They looks like winged eyeballs with small mouth full of jagged teeth and one to three eyes having two";
			if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " purple irises. Around their body are two to four circles each with two to four eyes looking the same as the main eye and above their heads are halo.";
			else str += " irises, one red and the other blue.";
			if (hasStatusEffect(StatusEffects.TranscendentSoulField))
			{
				str += "\n\n<i>From time to time you can notice faint glimmers of orange protective fields surrounding them.";
				if (hasStatusEffect(StatusEffects.TrueFormAngel)) str += " After your attacks it take octagonal shapes for a brief moment.";
				str += "</i>";
			}
			return str;
		}
		
		public function AngeloidGroup() 
		{
			super(false);
			this.plural = true;
			this.a = "the ";
			this.short = "group of angeloids";
			this.imageName = "angeloids";
			this.long = "";
			initStrTouSpeInte(10, 100, 45, 25);
			initWisLibSensCor(180, 4, 30, -100);
			this.tallness = 30;
			this.randomDropChance = 0.2;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_MINOR_LOW
			};
			this.drop = new ChainedDrop()
					.add(useables.SRESIDUE, 1);
			this.level = 18;
			this.bonusHP = 700;
            this.bonusLust = 52;
			this.bonusWrath = 200;
			this.bonusSoulforce = 400;
			this.additionalXP = 90;
			this.weaponName = "energy blast";
			this.weaponVerb = "shoot";
			this.weaponAttack = 5;
			this.armorName = "skin";
			this.armorDef = 15;
			this.armorMDef = 15;
			this.wings.type = Wings.FEATHERED_AVIAN;
			if (player.cor < 67) this.createPerk(PerkLib.AlwaysSuccesfullRunaway, 9, 0, 0, 0);
			this.createStatusEffect(StatusEffects.TranscendentSoulField, 5, 5, 0, 0);//X times less dmg, +X lvl diff bonus
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 7, 0, 0, 0);
			checkMonster();
		}
		
	}

}