package classes.Scenes.Areas.Plains 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class BazaarGatekeeper extends Monster 
	{
		
		public function scimitarSpecial():void {
			if (rand(3) == 0) scimitarCrossAttack();
			else scimitarAttack();
		}
		
		public function scimitarAttack():void {
			
			outputText("The gatekeeper raises his scimitars ", false);
			if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) > 0) {
				outputText("and slashes his scimitars blindly, missing you by a great deal!");
				combatRoundOver();
				return;
			}
			else {
				outputText("and slashes towards you. You attempt to dodge your way out ");
			}
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE || evade == EVASION_MISDIRECTION)
			{
				outputText("and you successfully dodge his scimitars thanks to your superior evasion! ", false);
			}
			else if (evade == EVASION_FLEXIBILITY)
			{
				outputText("and you use your incredible flexibility to barely fold your body and avoid his attacks!", false);
			}
			else if (evade == EVASION_SPEED || evade != null)
			{
				outputText("and you successfully dodge his scimitars! ", false);
			}
			else
			{
				outputText("but you get hit instead! ", false);
				var damage:int = int(str + weaponAttack + 100);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}
		
		public function scimitarCrossAttack():void {
			if (findStatusEffect(StatusEffects.Uber) <= 0) {
				outputText("The gatekeeper raises his scimitars! Judging from the way he is holding, <b>he is going to cross-slash you!</b>");
				combatRoundOver();
				return;
			}
			if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] > 0) {
				outputText("The gatekeeper slashes his scimitar towards you! Thanks to your preparedness, you manage to avoid his scimitars in the nick of time.");
			}
			else if (findStatusEffect(StatusEffects.Blind) >= 0 && rand(3) > 0) {
				outputText("The blind gatekeeper slashes his scimitars wide, missing you by a great deal!");
			}
			else {
				outputText("The gatekeeper slashes you brutally! You are in a lot of pain. ", false);
				var damage:int = int(str + weaponAttack + 250);
				damage = player.reduceDamage(damage);
				player.takeDamage(damage, true);
			}
			removeStatusEffect(StatusEffects.Uber);
			combatRoundOver();
		}
		
		override public function doAI():void
		{
			if (findStatusEffect(StatusEffects.Stunned) >= 0) {
				outputText("Your foe is too dazed from your last hit to strike back!", false)
				if (findStatusEffect(StatusEffects.Uber) >= 0) {
					outputText(" You've managed to interrupt his special attack!");
					removeStatusEffect(StatusEffects.Uber);
				}
				if (statusEffectv1(StatusEffects.Stunned) <= 0) removeStatusEffect(StatusEffects.Stunned);
				else addStatusValue(StatusEffects.Stunned, 1, -1);
				combatRoundOver();
				return;
			}
			if (findStatusEffect(StatusEffects.Fear) >= 0) {
				game.outputText("The gatekeeper appears to be immune to your fear.\n\n");
				removeStatusEffect(StatusEffects.Fear);
			}
			if (findStatusEffect(StatusEffects.Uber) >= 0) {
				scimitarCrossAttack();
				return;
			}
			//Choose attacks
			var chooser:int = rand(6);
			if (chooser < 4) eAttack();
			else scimitarSpecial();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			outputText("You manage to knock the guard off his feet. With the guard unconscious, you manage to check for loot before you head in.", true);
			doNext(game.bazaar.winAgainstGuard);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				outputText("You collapse, too weak to continue fighting. You are covered in cuts and bruises. The world blacks out. When you wake up, you realize that you are in a random location in the plains. You make your way back to your camp.", true);
			}
			else {
				outputText("You collapse from your overwhelming desires and black out. When you wake up, you realize that you are in a random location in the plains. You make your way back to your camp.", true);
			}
			doNext(game.combat.cleanupAfterCombat);
		}
		
		public function BazaarGatekeeper() 
		{
			this.a = "the ";
			this.short = "guard";
			this.imageName = "bazaarguard";
			this.long = "This crimson-skinned demon-morph guarding the entrance to Bizarre Bazaar stands ten feet tall. He has red skin and is wearing almost sky-blue turban on his head. He has solid black eyes. He is wearing a simple tunic and loose-fitting pants. He is wielding a pair of scimitars."
			this.createCock(8, 1.5, CockTypesEnum.DEMON);
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = 1;
			this.ass.analWetness = 0;
			this.tallness = 10*12;
			this.hipRating = 2;
			this.buttRating = 0;
			this.skinTone = "crimson";
			this.skinType = 0;
			//this.skinDesc = Appearance.Appearance.DEFAULT_SKIN_DESCS[SKIN_TYPE_FUR];
			this.hairColor = "black";
			this.hairLength = 8;
			initStrTouSpeInte(100, 100, 80, 70);
			initLibSensCor(15, 10, 55);
			this.weaponName = "dual scimitars";
			this.weaponVerb="slash";
			this.weaponAttack = 16;
			this.weaponPerk = "";
			this.weaponValue = 25;
			this.armorName = "tunic and pants";
			this.armorDef = 0;
			this.bonusHP = 1750;
			this.lust = 0;
			this.lustVuln = .15;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 30;
			this.additionalXP = 300;
			this.drop = new WeightedDrop().add(weapons.SCIMITR, 1);
			this.gems = 250;
			this.special1 = scimitarSpecial;
			checkMonster();
		}
	}
}