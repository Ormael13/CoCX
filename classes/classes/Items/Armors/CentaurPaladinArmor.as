package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Scenes.NPCs.CelessScene;
	/**
	 * ...
	 * @author Liadri
	 */
	public class CentaurPaladinArmor extends Armor
	{
		
		public function CentaurPaladinArmor() 
		{
			super("TaurHPAr","Taur HP. Armor","some taur paladin armor","a set of taur paladin armor",40,20,1698,"A suit of paladin's armor for centaurs.","Heavy")
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.isTaur() && game.player.level >= 54) return super.canEquip(doOutput)
			if (doOutput) {
				if (game.player.level >= 54) outputText("You try and wear the legendary armor but to your disapointment the item simply refuse to stay on your body. It would seem you yet lack the power and right to wield this item.");
				else outputText("The paladin's armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory");
			}
			return false;
		}
		
		override public function equipText():void {
			outputText(CelessScene.instance.Name+" helps you put on the barding and horseshoes. Wow, taking a look at yourself, you look like those knights of legend. Fighting the wicked with this armor should be quite easy.");
		}
		
		override public function unequipText():void{
			outputText(CelessScene.instance.Name+ "helps you remove the centaur armor. Whoa, you were starting to forget what not being weighted down by heavy armor felt like.");
		}
		
		override public function get def():Number{
			var mod:int = (100-game.player.cor)/5;
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = (100-game.player.cor)/10;
			return 10 + mod;
		}
	}

}
