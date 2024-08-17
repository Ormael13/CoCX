/**
 * ...
 * @author Ormael
 */
package classes.Items.HeadJewelries 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.HeadJewelry;
	import classes.Scenes.SceneLib;
	
	public class SkullCrown extends HeadJewelry
	{
		
		public function SkullCrown() 
		{
			super("SkullsCr", "SkullsCrown", "Skulls Crown", "a Skull Crown", 0, 0, 400, "A crown made of skulls with strong aura of death surrounding it. Rumored to be blessed by the god of death have amazing effect for any undead being that would wear it. (+4%/-4% HP regeneration (undead / others))", HJT_CROWN);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			SceneLib.setItemsChecks.equippedSkullSetItems();
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			SceneLib.setItemsChecks.unequipSkullItemsSet();
			super.afterUnequip(doOutput);
		}
	}
}