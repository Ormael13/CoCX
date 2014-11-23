/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public class ComfortableClothes extends Armor {
		
		public function ComfortableClothes() {
			super("C.Cloth", "C.Cloth", "comfortable clothes", "a set of comfortable clothes", 0, 0, "These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements.  (DEF: +0) (Cost: 0)", "Light", true);
		}
/*
		override protected function unequipReturnItem(player:Player,output:Boolean):ItemType
		{
			if (output && player.armorName != player.armor.name){
				outputText("The " + player.armorName + " revert into a pair of comfortable clothes, as if by magic.  ");
			}
			return this;
		}
<<<<<<< HEAD

		public function ComfortableClothes()
		{
			super("C.Cloth","C.Cloth","comfortable clothes","a set of comfortable clothes",0,0,"These loose fitting and comfortable clothes allow you to move freely while protecting you from the elements. \n\nType: Clothing \nDefense: 0 \nBase value: 0","Light");
		}
=======
*/
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
	}
}
