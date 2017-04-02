package classes.Items.Other 
{

	public class DebugWand extends SimpleUseable
	{
		
		public function DebugWand() 
		{
			super("DbgWand", "Debug Wand", "a wand of debugging", 1000, "This mysterious wand has an entirely unknown origin but somehow you feel like a cheater when using it.", "You raise the wand and a slab of stone emerges from the ground. The slab has fifteen buttons and a text panel.");
		}
		
		override public function canUse():Boolean {
			return true;
		}
		
		override public function useItem():Boolean {
			if (!game.debug) game.inventory.takeItem(this, game.debugMenu.accessDebugMenu);
			game.debugMenu.accessDebugMenu();
			return true;
		}
		
	}

}