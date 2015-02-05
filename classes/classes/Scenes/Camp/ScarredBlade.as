package classes.Scenes.Camp 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class ScarredBlade extends Monster
	{
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
			game.sheilaScene.badEndScarredBlade();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.sheilaScene.breakScarredBlade();
		}
		
		public function ScarredBlade() 
		{
			this.a = "the ";
			this.short = "scarred blade";
			this.plural = false;
			this.createBreastRow();
			this.balls = 0;
			this.ballSize = 0;
			this.tallness = 36;
			this.skinTone = "metallic";
			this.long = "The sword you're fighting is a no ordinary sword. It's a lethicite-infused metal curved saber etched with scars. It seems to eagerly seek flesh."
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			initStrTouSpeInte(80, 100, 75, 50);
			initLibSensCor(0, 0, 100);
			this.weaponName = "scarred blade";
			this.weaponVerb="slash";
			this.weaponAttack = 50;
			this.armorName = "lethicite";
			this.armorDef = 15;
			this.bonusHP = 400;
			this.lust = 0;
			this.lustVuln = 0;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 17;
			this.gems = 0;
			this.drop = new WeightedDrop(weapons.B_SCARB, 1);
			checkMonster();
		}
		
	}

}