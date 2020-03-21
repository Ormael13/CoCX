/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.StatusEffects;
	import classes.Player;

	public class SphinxAccessorySet extends HeadJewelry
	{
		
		public function SphinxAccessorySet() 
		{
			super("SphinxAS", "Sphinx accessory set", "Sphinx accessory set", "a Sphinx accessory set", 0, 0, 400, "This set of enchanted accessories is favored by sphinxes. It consists of a golden tiara depicting a rising cobra, a set of arm braces and a cloth collar with blue and yellow patterns that does not cover the shoulders. It assists its wielder in making better riddles and general spellcasting. \n\nType: Jewelry (Tiara) \nBase value: 400 \nSpecial: Increase of Cursed Riddle damage and Spellpower by 50%.","Tiara");
		}
		
		override public function playerEquip():HeadJewelry {
			while (game.player.hasStatusEffect(StatusEffects.SphinxAS)) game.player.removeStatusEffect(StatusEffects.SphinxAS);
			game.player.createStatusEffect(StatusEffects.SphinxAS,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			while (game.player.hasStatusEffect(StatusEffects.SphinxAS)) game.player.removeStatusEffect(StatusEffects.SphinxAS);
			return super.playerRemove();
		}
		
	}

}