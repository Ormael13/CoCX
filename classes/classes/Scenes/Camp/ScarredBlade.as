package classes.Scenes.Camp
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class ScarredBlade extends Monster
	{
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
			SceneLib.sheilaScene.badEndScarredBlade();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.sheilaScene.breakScarredBlade();
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
			this.bodyColor = "metallic";
			this.long = "The sword you're fighting is no ordinary blade. It's a lethicite-infused, curved saber etched with battle scars. The weapon seems to eagerly seek flesh.";
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			initStrTouSpeInte(80, 100, 75, 50);
			initWisLibSensCor(50, 0, 0, 100);
			this.weaponName = "scarred blade";
			this.weaponVerb="slash";
			this.weaponAttack = 50;
			this.armorName = "lethicite";
			this.armorDef = 15;
			this.armorMDef = 15;
			this.bonusHP = 400;
			this.lust = 0;
			this.lustVuln = 0.01;
			this.level = 17;
			this.gems = 0;
			this.drop = new WeightedDrop(weapons.B_SCARB, 1);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 17, 0, 0, 0);
			checkMonster();
		}
		
	}

}
