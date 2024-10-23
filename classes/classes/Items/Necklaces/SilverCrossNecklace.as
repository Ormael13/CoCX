/**
 * ...
 * @author Liadri
 */
package classes.Items.Necklaces 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Necklace;
	import classes.Scenes.SceneLib;
	import classes.PerkLib;
	import classes.Player;
	import classes.StatusEffects;
	
	public class SilverCrossNecklace extends Necklace
	{
		
		public function SilverCrossNecklace() 
		{
			super("SilCNec", "SilverCrossNecklace", "Silver cross necklace", "a Silver cross necklace", 0, 0, 400, "A small chain with a silver cross or X-shaped pendant attached. At first glance, it seems to be a very ordinary accessory. \n\nType: Jewelry (Necklace) \nBase value: 800 \nSpecial: +50% to tease and magical damage.","Necklace");
		}
		
		override public function canUnequip(doOutput:Boolean):Boolean {
			if (!CoC.instance.player.hasPerk(PerkLib.Soulless)) {
				if (doOutput) {
					outputText("<b>You realize, to your horror, that the chain of the necklace somehow shrunk to the point where you can no longer get the item off your neck. ");
					outputText(""+(CoC.instance.player.hasStatusEffect(StatusEffects.MeetXuviel) && CoC.instance.player.statusEffectv1(StatusEffects.MeetXuviel) > 0?"Obviously, Xuviel wouldn’t want his target to escape his clutches so easily.":"Just what is going on!?")+" You need to find a way to remove this necklace! </b>");
				}
				return false;
			}
			else return true;
		}
		/*
		override public function description():String{
			outputText("A small chain with a silver cross or X attached. At first glance, it seems to be a very ordinary accessory."+((CoC.instance.player.hasPerk(PerkLib.Soulless) && CoC.instance.player.hasVagina())?" While originally this collar served to bind you to Xuviel’s will, something you no longer need, it now actually assists you instead of hindering you, granting your corrupted body amazing powers.":"")+"");
		}
		*/
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave && !game.player.hasStatusEffect(StatusEffects.MeetXuviel)) game.player.createStatusEffect(StatusEffects.MeetXuviel, 0, 0, 0, 0);
			super.afterEquip(doOutput, slot);
		}
		
		override public function unequipText(slot:int):void{
			outputText("You "+(CoC.instance.player.hasStatusEffect(StatusEffects.MeetXuviel)?"untie master Xuviel’s necklace with nostalgic fondness":"untie the necklace")+". You could keep it on but right now you want to try a different accessory. It comes off easily, and putting it back should be just as simple.");
		}
		
	}

}
