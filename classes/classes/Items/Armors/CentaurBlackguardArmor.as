package classes.Items.Armors
{
	import classes.Items.Armor;
		import classes.Scenes.NPCs.CelessScene;
	/**
	 * ...
	 * @author Liadri
	 */
	public class CentaurBlackguardArmor extends Armor
	{
		
		public function CentaurBlackguardArmor()
		{
			super("TaurBAr","Taur B. Armor","some taur blackguard armor","a set of taur blackguard armor",40,20,1698,"A suit of blackguard's armor for centaurs.","Heavy");
			withTag(I_LEGENDARY);
		}
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.isTaur()) return super.canEquip(doOutput, slot)
			if (doOutput) outputText("The blackguard's armor is designed for centaurs, so it doesn't really fit you. You place the armor back in your inventory");
			return false;
		}
		
		override public function equipText():void{
			outputText(CelessScene.instance.Name+" helps you put on the barding and horseshoes. Wow, taking a look at yourself, you think your intimidating appearance alone will scare the hell out of most opponents.");
		}
		
		override public function unequipText(slot:int):void{
			outputText(CelessScene.instance.Name+ "help you remove the centaur armor. Whoa you forgot what carrying light weight was.");
		}
		
		override public function get def():Number{
			var mod:int = game.player.cor/5;
			return 20 + mod;
		}
		override public function get mdef():Number{
			var mod:int = game.player.cor/10;
			return 10 + mod;
		}
	}

}
