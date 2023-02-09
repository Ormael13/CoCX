/**
 * ...
 * @author Ormael
 */
package classes.Items 
{
	import classes.BaseContent;
	import classes.Player;
	
	public class ItemSetChecks extends BaseContent
	{
		
		public function ItemSetChecks() 
		{}

public function equippedNecroSetItems():int {
	var eNSI:int = 0;
	if (player.weapon == weapons.NECROWA) eNSI++;
	if (player.shield == shields.NECROSH) eNSI++;
	if (player.necklace == necklaces.NECRONE) eNSI++;
	return eNSI;
}
public function equipNecroItemsSet():void {
	var count:int = equippedNecroSetItems();
	if (count == 3) {
		// 2 -> 3, give 3 item bonus
	} else if (count == 2) {
		// 1 -> 2, give 2 item bonus
	}
}
public function unequipNecroItemsSet():void {
	var count:int = equippedNecroSetItems();
	if (count == 2) {
		// 3 -> 2, remove 3 item bonus
	} else if (count == 1) {
		// 2 -> 1, remove 2 item bonus
	}
}

}
}