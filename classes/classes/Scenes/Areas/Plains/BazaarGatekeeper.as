package classes.Scenes.Areas.Plains 
{
	import classes.*;
	import classes.internals.*;

	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class BazaarGatekeeper  extends Monster 
	{
		
		public function scimitarAttack():void {
			
			outputText("The gatekeeper raises his scimitars! You attempt to dodge your way out ", false);
			if ((player.spe - spe) + rand(30) > 20) 
			{
				outputText("and you successfully dodged his scimitars!", false);
			}
			else
			{
				outputText("but you fail and get hit instead! ", false);
				var damage:int = int((str + 100) - rand(player.tou) - player.armorDef);
				player.takeDamage(damage);
				outputText("(" + damage + ")");
			}
			combatRoundOver();
		}
		
		public function scimitarCrossAttack():void {
			
			outputText("The gatekeeper raises his scimitars! Judging from the way he is holding, he is going to cross-slash you! You attempt to dodge ", false);
			if ((player.spe - spe) + rand(30) > 10) 
			{
				outputText("and you successfully dodged his scimitars!", false);
			}
			else
			{
				outputText("but you fail and you get hit instead! You are in a lot of pain. ", false);
				var damage:int = int((str + 250) - rand(player.tou) - player.armorDef);
				player.takeDamage(damage);
				outputText("(" + damage + ")");
			}
			combatRoundOver();
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
			doNext(cleanupAfterCombat);
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
			initStrTouSpeInte(100, 100, 75, 70);
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
			this.drop = NO_DROP;
			this.gems = 250;
			this.special1 = scimitarAttack;
			this.special2 = scimitarCrossAttack;
			checkMonster();
		}
	}
}