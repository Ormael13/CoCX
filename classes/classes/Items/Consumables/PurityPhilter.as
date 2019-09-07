package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	
	/**
	 * Reduces corruption.
	 */
	public class PurityPhilter extends Consumable 
	{
		private static const ITEM_VALUE:int = 100;
		
		public function PurityPhilter() 
		{
			super("PPhiltr","P.Philter", "a vial of purity philter", ITEM_VALUE, "This silver vial feels cool to the touch. In fact, it feels a bit cold. Given the label, you suspect this will help to erase corruption.");
		}
		
		override public function useItem():Boolean
		{
			clearOutput();
			outputText("You uncap the small silver vial and place it to your lips. Tilting your head back, you pour the cold tasteless liquid down your throat.\n\n");
			if (player.cor < 20) {
				outputText("You shiver as your body is suffused with a cold, refreshing feeling. You feel much calmer than before.");
			}
			
			if (player.cor >= 20 && player.cor < 40) {
				outputText("You break out into a cold sweat as the freezing liquid surges through your body. Despite the discomfort, your thoughts do seem clearer.");
			}
			
			if (player.cor >= 40 && player.cor < 60) {
				outputText("As the freezing liquid hits your stomach, you suddenly feel like you're standing in a blizzard. Your hands and feet go numb, and even though you've never felt colder in your life, you're covered in sweat. Eventually, you begin to feel more normal, and your thoughts definitely seem clearer.");
			}
			
			if (player.cor >= 60) {
				outputText("As you swallow the liquid, you fall gasping to your knees. It feels like someone shoved an icicle through your middle. You break out in a cold sweat as the sensation spreads, and you feel like your blood is freezing in your veins. Mercifully, you pass out.\n\nLater, when you wake up, the constant haze of lust that usually clouds your thoughts seems a bit thinner.");
			}
			
			var corLoss:Number = 5 + Math.floor(player.cor / 10);
			dynStats("cor", -corLoss);
			
			return false;
		}
	}
}
