package classes.Scenes.Areas.Bog 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	
	public class LizanRogue extends Monster
	{
		private static const STAT_DROP_FLAT:int = 5;
		private static const STAT_DROP_MULT:int = 2;
		//1 - str
		//2 - tou
		//3 - spe
		//4 - sens
		public function blowGun():void {
			if (player.hasStatusEffect(StatusEffects.WindWall)) {
				outputText("The lizan flings himself back.  In the air he puts a blowgun to his lips.  Then that tiny dart is stopeed by the wind wall that still surrounds you.");
				player.addStatusValue(StatusEffects.WindWall,2,-1);
			}
			else if (player.getEvasionRoll()) {
				outputText("The lizan flings himself back.  In the air he puts a blowgun to his lips.  You move just in time to avoid the tiny dart.");
			}
			else {
				var statdrop:int = STAT_DROP_FLAT+STAT_DROP_MULT*player.newGamePlusMod();
				outputText("The lizan flings himself back.  In the air he puts his blowgun to his lips and fires a single dart into your neck.  As you pull it out your limbs begin to feel like wet noodles, it appears you’ve been poisoned.");
				game.dynStats("str", -statdrop, "spe", -statdrop);
				if (!player.hasStatusEffect(StatusEffects.LizanBlowpipe)) player.createStatusEffect(StatusEffects.LizanBlowpipe, statdrop, 0, statdrop, 0);
				else {
					player.addStatusValue(StatusEffects.LizanBlowpipe, 1, statdrop);
					player.addStatusValue(StatusEffects.LizanBlowpipe, 3, statdrop);
				}
				if (player.cor > 50) {
					game.dynStats("str", -statdrop, "spe", -statdrop);
					player.addStatusValue(StatusEffects.LizanBlowpipe, 1, statdrop);
					player.addStatusValue(StatusEffects.LizanBlowpipe, 3, statdrop);
				}
			}
			combatRoundOver();
		}
		
		public function immaHurtYouBadly():void {
			if (player.getEvasionRoll()) {
				outputText("The lizan Rushes at you.  As you raise your [weapon] to defend yourself he dives to the side, using a blowgun to fire a single dart at you.  You somehow manage to dodge it.");
			}
			else {
				var statdrop:int = STAT_DROP_FLAT+STAT_DROP_MULT*player.newGamePlusMod();
				outputText("The lizan rushes at you.  As you raise your [weapon] to defend yourself he dives to the side, using his blowgun to fire a single stinging dart into your neck.  You pull out the dart and your skin begins to feel hypersensitive, you’re going to have trouble defending yourself");
				game.dynStats("tou", -statdrop, "sens", statdrop);
				if (!player.hasStatusEffect(StatusEffects.LizanBlowpipe)) player.createStatusEffect(StatusEffects.LizanBlowpipe, 0, statdrop, 0, statdrop);
				else {
					player.addStatusValue(StatusEffects.LizanBlowpipe, 2, statdrop);
					player.addStatusValue(StatusEffects.LizanBlowpipe, 4, statdrop);
				}
				if (player.cor > 50) {
					game.dynStats("tou", -statdrop, "sens", statdrop);
					player.addStatusValue(StatusEffects.LizanBlowpipe, 2, statdrop);
					player.addStatusValue(StatusEffects.LizanBlowpipe, 4, statdrop);
				}
			}
			combatRoundOver();
		}
		
		public function wingstickThrow():void {
			if (player.getEvasionRoll()) {
				outputText("The lizan zips to the side and you hear the whistle of something being thrown. You sidestep just in time to see a wingstick fly past.");
			}
			else {
				outputText("The lizan zips to the side and as you move to follow you feel something sharp cut across your body. He must have thrown something. ");
				var damage:int = this.spe/3 + rand(60);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
				
		public function tongueAttack():void {
			if (player.getEvasionRoll()) {
				outputText("All you see is a flash of pink and without even thinking you twist out of its way and watch the lizan’s long tongue snap back into his mouth.");
			}
			else {
				outputText("All you see is a flash of pink as the lizan’s long tongue hits your eyes. Some kind of chemical reaction causes your eyes to burn, you’ve been blinded!");
				if (!player.hasStatusEffect(StatusEffects.Blind)) player.createStatusEffect(StatusEffects.Blind, 1 + rand(2), 0, 0, 0)
			}
			combatRoundOver();
		}
		
		protected function chooseBlowpipe():void {
			if (rand(2) == 0) blowGun();
			else immaHurtYouBadly();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.bog.lizanScene.winAgainstLizan();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.bog.lizanScene.loseToLizan();
		}
		
		private const SKIN_VARIATIONS:Array = ["emerald", "azure", "scarlet", "violet", "obsidian", "amber", "silver"];
		
		public function LizanRogue() 
		{
			var skinToneAdj:String = randomChoice(SKIN_VARIATIONS);
			this.skin.growCoat(SKIN_COAT_SCALES,{color:skinToneAdj});
			this.a = "the ";
			this.short = "lizan rogue";
			this.imageName = "lizanrogue";
			this.long = "A rogue lizan male stands before you, watching your every move with quick yellow eyes. His slim body is covered in glistening " + skinTone + " scales. His strong tail swings back and forth as he shifts his weight, a fluid movement that hints at his speed.  He wears a simple loincloth to protect his modesty to which a small pack is belted.";
			// this.plural = false;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.createCock(8, 3, CockTypesEnum.LIZARD);
			this.createCock(8, 3, CockTypesEnum.LIZARD);
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_MOIST;
			this.tallness = 60 + rand(10);
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinDesc = "skin";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(140, 180, 120, 90);
			initLibSensCor(20, 10, 0);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 38 + (8 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "loincloth";
			this.armorDef = 18 + (2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.bonusHP = 350;
			this.bonusLust = 10;
			this.lust = 20;
			this.lustVuln = .7;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 36;
			this.gems = 70 + rand(80);
			this.drop = new WeightedDrop().add(consumables.REPTLUM, 5)
					.add(consumables.SMALL_EGGS, 2)
					.add(consumables.OVIELIX,2)
					.add(consumables.W_STICK,1);
			this.createPerk(PerkLib.Evade, 0, 0, 0, 0);
			this.createPerk(PerkLib.Precision, 0, 0, 0, 0);
			this.createPerk(PerkLib.ResistanceI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Tactician, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanMarrow, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.special1 = chooseBlowpipe;
			this.special2 = wingstickThrow;
			this.special3 = tongueAttack;
			this.str += 42 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 54 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 36 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 27 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 6600;
			checkMonster();
		}
		
	}

}
