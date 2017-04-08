/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Consumables
{
	import classes.*;
	import classes.internals.Utils;
	import classes.Items.Consumable;

	public class OvipositionMax extends CustomOviElixir {
		
		public function OvipositionMax() {
			super("Ovi Max", "Ovi Max", "an enhanced hexagonal crystal bottle tagged with an image of an egg", 75, "This hexagonal crystal bottle is filled with a strange yellow fluid. A tag with a picture of a glowing egg is tied to the neck of the bottle, indicating it is somehow connected to egg-laying and you know it will be more potent.");
		}
		
		override protected function doSpeedUp(incubation:int):int {
			return incubation - int(incubation * 0.5 + 15);
		}

		override protected function canSpeedUp():Boolean {
			return game.player.pregnancyIncubation > 20;
			}

		override protected function randEggCount():int {
			return rand(4)+6;
			}

		override protected function randBigEgg():Boolean {
			return rand(2)==0;
			}


	}
}
