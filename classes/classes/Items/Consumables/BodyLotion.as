package classes.Items.Consumables 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.internals.Utils;
	import classes.Items.Consumable;
	import classes.Items.ConsumableLib;
	
	/**
	 * Body lotions, courtesy of Foxxling.
	 * @author Kitteh6660
	 */
	public class BodyLotion extends Consumable 
	{
		private var _adj:String;
		
		public function BodyLotion(id:String, adj:String, longAdj:String) 
		{
			this._adj = adj.toLowerCase();
			var shortName:String = adj + " Ltn";
			var longName:String = "a flask of " + this._adj + " lotion"
			var value:int = ConsumableLib.DEFAULT_VALUE;
			var description:String = "A small wooden flask filled with a " + longAdj + " . A label across the front says, \"" + adj + " Lotion.\""
			super(id, shortName, longName, value, description);
		}
		
		private function liquidDesc():String {
			var liquidDesc:String = "";
			switch(_adj) {
				case "smooth":
					switch(Utils.rand(2)) { //Nested switch-and-case FTW!
						case 0:
							liquidDesc = "smooth liquid";
							break;
						case 1:
							liquidDesc = "thick cream";
							break;
						default:
							liquidDesc = "smooth liquid";
					}
					break;
				case "rough":
					switch(Utils.rand(2)) { 
						case 0:
							liquidDesc = "abrasive goop";
							break;
						case 1:
							liquidDesc = "rough textured goop";
							break;
						default:
							liquidDesc = "abrasive goop";
					}
					break;
				case "sexy":
					switch(Utils.rand(3)) {
						case 0:
							liquidDesc = "smooth liquid";
							break;
						case 1:
							liquidDesc = "attractive cream";
							break;
						case 2:
							liquidDesc = "beautiful cream";
							break;
						default:
							liquidDesc = "smooth liquid";
					}
					break;
				case "clear":
					switch(Utils.rand(2)) {
						case 0:
							liquidDesc = "smooth liquid";
							break;
						case 1:
							liquidDesc = "thick cream";
							break;
						default:
							liquidDesc = "smooth liquid";
					}
					break;
				default: //Failsafe
					liquidDesc = "cream";
			}
			return liquidDesc;
		}
		
		override public function useItem():Boolean {
			if (game.player.skinTone == _adj) {
				outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. Once you’ve finished you feel reinvigorated. ");
				game.HPChange(10, true);
			}
			else {
				if (game.player.skinType != 3) { //If skin is goo, don't change.
					if (_adj != "clear") game.player.skinAdj = _adj;
					else game.player.skinAdj = "";
				}
				switch(game.player.skinType) {
					case 0: //Plain
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. As you rub the mixture into your arms and [chest], your whole body begins to tingle pleasantly. ");
						switch(_adj) {
							case "smooth":
								outputText("Soon your skin is smoother but in a natural healthy way.");
								break;
							case "rough":
								outputText("Soon your skin is rougher as if you’ve just finished a long day’s work.");
								break;
							case "sexy":
								outputText("Soon your skin is so sexy you find it hard to keep your hands off yourself.");
								break;
							case "clear":
								outputText("Soon the natural beauty of your " + game.player.skinFurScales() + " is revealed without anything extra or unnecessary.");
								break;
							default: //Failsafe
								outputText("<b>This text should not happen. Please let Kitteh6660 know.</b>");
						}
						break;
					case 1: //Fur
						outputText("" + game.player.clothedOrNaked("Once you’ve disrobed you take the lotion and", "You take the lotion and") + " begin massaging it into your skin despite yourself being covered with fur. It takes little effort but once you’ve finished... nothing happens. A few moments pass and then your skin begins to tingle. ");
						switch(_adj) {
							case "smooth":
								outputText("Soon you part your fur to reveal smooth skin that still appears natural.");
								break;
							case "rough":
								outputText("Soon you part your fur to reveal rough skin that still appears natural.");
								break;
							case "sexy":
								outputText("Soon you part your fur to reveal sexy skin that makes you want to kiss yourself.");
								break;
							case "clear":
								outputText("Soon you part your fur to reveal the natural beauty of your " + game.player.skinFurScales() + " skin.");
								break;
							default: //Failsafe
								outputText("<b>This text should not happen. Please let Kitteh6660 know.</b>");
						}
						break;
					case 2: //Scales
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the flask of lotion and rubbing", "uncork the flask of lotion and rub") + " the " + liquidDesc() + " across your body. As you rub the mixture into your arms and [chest], your whole body begins to tingle pleasantly.");
						switch(_adj) {
							case "smooth":
								outputText("Soon you part your fur to reveal smooth skin that still appears natural.");
								break;
							case "rough":
								outputText("Soon you part your fur to reveal rough skin that still appears natural.");
								break;
							case "sexy":
								outputText("Soon you part your fur to reveal sexy skin that makes you want to kiss yourself.");
								break;
							case "clear":
								outputText("Soon you part your fur to reveal the natural beauty of your " + game.player.skinFurScales() + " skin.");
								break;
							default: //Failsafe
								outputText("<b>This text should not happen. Please let Kitteh6660 know.</b>");
						}
						break;
					case 3: //Goo
						outputText("You take the lotion and pour the " + liquidDesc() + " into yourself. The concoction dissolves, leaving your gooey epidermis unchanged. As a matter of fact nothing happens at all.");
						//No changes due to gooey skin.
						break;
					default:
						outputText("You " + game.player.clothedOrNaked("take a second to disrobe before uncorking the bottle of oil and rubbing", "uncork the bottle of oil and rub") + " the smooth liquid across your body. Even before you’ve covered your arms and [chest] your skin begins to tingle pleasantly all over. After your skin darkens a little, it begins to change until you have " + _adj + " skin.");
				}
			}
			game.inventory.itemGoNext();
			return true;
		}
	}

}