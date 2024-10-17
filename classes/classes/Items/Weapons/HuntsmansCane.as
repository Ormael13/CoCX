package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.WeaponLib;
	import classes.PerkLib;
	import classes.Player;

	public class HuntsmansCane extends Weapon
	{
		
		public function HuntsmansCane() {
			super("H. Cane", "H. Cane", "huntsman's cane", "a cane that once belonged to Erlking", "thwack", 0, 400, "This ebony black cane is made of polished wood and topped with a golden cap in the shape of a deer's head. This lightweight staff once belonged to the Erlking, but seems too light and delicate to be an effective weapon.", WT_STAFF, WSZ_MEDIUM);
		}
		
		override public function useText():void {
			outputText("You equip the lightweight cane, questioning the effectiveness of such a small stick. However, as you hold it, an intense focus washes over you, and you feel certain that nothing could distract you from your goals. ");
		}
	}
}
