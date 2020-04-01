package classes.Items.Armors 
{
	import classes.Items.Armor;
	import classes.Scenes.NPCs.CelessScene;
	import classes.Player;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;
	/**
	 * ...
	 * @author 
	 */
	public class CentaurArmor extends Armor
	{
		
		public function CentaurArmor() 
		{
			super("TaurPAr","Taur P. Armor","some taur paladin armor","a set of taur paladin armor",23,0,1698,"A suit of paladin's armor for centaurs.","Heavy")
		}
		override public function canUse():Boolean{
			if (game.player.isTaur()){return true}
			outputText("The paladin armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory.");
			return false;
		}
		
		override public function useText():void{
			outputText(CelessScene.instance.Name+" helps you put on the barding and horseshoes. Wow, taking a look at yourself, you look like those knights of legend. Fighting the wicked with this armor should be quite easy.");
		}
		
		override public function removeText():void{
			outputText(CelessScene.instance.Name+ "helps you remove the centaur armor. Whoa, you were starting to forget what not being weighted down by heavy armor felt like.");
		}
		
		override public function get def():Number{
			var mod:int = (100-game.player.cor)/10;
			return 13 + mod;
		}
	}

}