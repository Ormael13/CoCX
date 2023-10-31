/**
 * @author Liadri
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Items.Equipable;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;

	public class BlizzardKimono extends Armor
	{
		
		public function BlizzardKimono()
		{
			super("Blizz.K", "BlizzardKimono","blizzard kimono","a blizzard kimono",0,8,1600,"A snowflake patterned dress favored by the glacial rift Yuki Onna which reduces spellcasting cost and empowers the magic of ice spells while weakening fire magic and abilities as a tradeoff. It is pale blue and white decorated with snowflakes motif and long sleeves that reminds of snow angels wings and a short skirt assorted with white shoes. Instead of keeping warm the dress cools and chills the body of whoever wears it, which might even prove lethal to someone not resilient to its insidious power. Yuki Onna being creatures of the cold they actually regenerate instead thanks to this effect.","Light");
			withBuffs({'spellcost': -0.40});
		}
		
		override public function equipText():void {
			if (!game.player.hasPerk(PerkLib.ColdMastery) && !game.player.hasPerk(PerkLib.ColdAffinity)) outputText("Is it just you or you are freezing within that Kimono. Without proper resistance to cold, the blizzard kimono begins to sap your body warmth.\n\n");
			else outputText("You equip " + longName + ".  ");
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.removeStatusEffect(StatusEffects.YukiOnnaKimono);
				game.player.createStatusEffect(StatusEffects.YukiOnnaKimono, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.removeStatusEffect(StatusEffects.YukiOnnaKimono);
			super.afterUnequip(doOutput);
		}
		
	}
}
