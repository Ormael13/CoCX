/**
 * Created by Kitteh6660. Glacial Rift is a new endgame area with level 18-22 encounters, guaranteed to help you grind to level 33.
 * Currently a Work in Progress.
 * 
 * Please see this project. (This is not mine.) http://forum.fenoxo.com/thread-10719.html
 */

/*
 * TODO
 * 
 */ 
package classes.Scenes.Areas 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.GlacialRift.*;
	import classes.Scenes.NPCs.GooArmor;

	use namespace kGAMECLASS;
	
	public class GlacialRift extends BaseContent
	{
		public var valkyrieScene:ValkyrieScene = new ValkyrieScene();
		public var yetiScene:YetiScene = new YetiScene();
		
		public function GlacialRift() 
		{
		}
		
		public function exploreGlacialRift():void {
			flags[kFLAGS.DISCOVERED_GLACIAL_RIFT]++
			doNext(1);
			
			var chooser:Number = rand(5);
			//Wild Valkyrie appears!
			if (chooser == 0) {
				outputText("Making your way across the hard-packed ice of the Rift, you’re surprised to see the thick gray clouds part overhead.  You see a beautiful woman descend from on high, her snow-white wings flapping powerfully behind her back.  Armed with a long spear and shield, and clad in a bronze cuirass and a winged helm, she looks every bit the part of a mighty warrior.\n\n", true)
				outputText("She touches down gently a few feet before you, her shield and spear raised.  \"<i>You seem a worthy sort to test my skills against, wanderer.  Prepare yourself!</i>\" she shouts, bearing down on you.  She doesn’t look like she’s going to back down -- you ready your " + player.weaponName + " for a fight!")
				startCombat(new Valkyrie());
				return;
			}
			//Wild Yeti appears!
			if (chooser == 1) {
				outputText("You grow tired trudging through the hard-packed snow under you, shielding your face with an arm as the wind lashes against you, slowing your progress. The whistle of the wind rings in your ears, only broken with the dull crunch of snow compacting underfoot. You can’t help but regret wandering into this storm and wish for shelter and warmth. Your body freezes at the sound of a loud crack, and turning your head to see the source of the noise, you notice too late that your lower body is sinking in the snow floor. You flail your limbs as your body is swept under by the moving snow, and you feel yourself sliding down some sort of shaft: it’s too dark to see where you are going. With a thump, you come to a stop.\n\n", true)
				if (flags[kFLAGS.MET_YETI_FIRST_TIME] <= 0) {
					outputText("Quickly wiping the snow off your body, you take in your surroundings. There are torches overhead that provide light and a small amount of warmth, making the ice cavern almost beautiful to be in, the light reflecting and shimmering off the polished ice walls, ceiling, and large icicles. There are a number of holes like the one you must have came out of, like a network of chutes that all lead to your location. You are surprised to find something under you, a large pile of white furs broke your fall. Though you are unnerved to find a large collection of bones lining the sides of the ice cavern, all white like snow, cleaned to a shine. Taking all this in, it’s obvious you are in someone’s or something’s residence. ")
					if (silly()) {
						outputText("You notice the bodies of a number of strange, bipedal horse-like creatures, all covered in thick white fur hanging from the nearby wall; laying beneath one is a strange metallic cylinder, not unlike a sword hilt, that gives off a strange, soft heat. ")
					}
					outputText("You brush off the snow and get to your feet, turning your head as you notice a passageway.\n\n")
					flags[kFLAGS.MET_YETI_FIRST_TIME] = 1
				}
				else {
					outputText("Taking in the familiar surroundings, you realize you must have fallen through one of those chutes again. You begin to wonder if they are for the Yeti’s use, or if they are meant to bring in unsuspecting travelers. A meal delivery service set up with their limited ice magic? You shake off the snow on you and get to your feet. Looking to the passage, sure enough shadows dance along the walls as the thumps reach your ears.\n\n")
				}
				outputText("Hearing a thunderous roar, you ready yourself for a fight");
				if (player.weaponName != "fists") outputText(", holding your " + player.weaponName + " at the ready");
				outputText(". A massive hulking creature barrels around the corner and sets its gaze on you, its clawed hands and feet launching its body over the iced caverns with ease as you stare the beast down. The white blur of an ice yeti attacks you!")
				startCombat(new Yeti());
				return;
			}			
			//Wild Frost Giant appears!
			if (chooser == 2) {
				outputText("You wander the frozen landscape of the Rift, frozen rocks, frosted hills and forested mountains your only landmarks. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your " + player.weaponName + " and withdraw from the hill to prepare for battle.\n\n", true);
				startCombat(new FrostGiant());
				return;
			}
			//Find Valeria! She can be found there if you rejected her offer initially at Tower of the Phoenix or didn't find her. She can never be Lost Forever.
			if (chooser == 3) {
				if (flags[kFLAGS.HARPY_QUEEN_EXECUTED] > 0 && flags[kFLAGS.VALARIA_AT_CAMP] == 0 && player.armorName != "goo armor") {
					flags[kFLAGS.VALERIA_FOUND_IN_GLACIAL_RIFT] = 1;
					outputText("As you make your way across the Rift's icy extremities, you hear a metallic CLANK CLANK approaching through the snow flurries. You turn in time to see a suit of plated mail charging toward you, its helm and limbs filled with bright blue goo. It skids to a stop a few yards away, a greatsword forming from the goo of its hand. A beautiful, feminine face appears beneath the armor’s visor grinning at you. You suddenly recognize her face!\n\n", true)
					outputText("\"<i>This is my territory!</i>\" she shouts, bringing her two-handed sword to bare. \"<i>You’ll give me your fluids, or I’ll take them.</i>\"")
					startCombat(new GooArmor());
				}
				else {
					outputText("You spend an hour exploring the frigid glaciers but you don't find anything interesting.", true);
					doNext(13);
				}
			}
			//Find item!
			if (chooser >= 4) {
				//25% chance to find an item. When you do find an item, there is 50/50 chance.
				var itemChooser:Number;
				itemChooser = rand(8);
				if (itemChooser == 0) {
					outputText("As you cross one of the floating ice sheets that make up the bulk of the rift, your eyes are drawn to a bright glint amidst the white backdrop.  As you eagerly approach the gleam, you discover a single tiny spire of ice, jutting from the surrounding snow.  You pluck it gently from the ground, give it a quick glance over and, satisfied that it won’t try and kill you, drop it in your bag.", true)
					menuLoc = 2;
					inventory.takeItem(consumables.ICICLE_);
				}
				else if (itemChooser == 1) {
					outputText("As you make your way across the icy wastes, you notice a small corked ivory horn half-buried under the snow, filled with a thick sweet-looking liquor. You stop and dig it up, sniffing curiously at the liquid. The scent reminds you of the honey secreted by the bee-girls of Mareth, though with hints of alcohol and... something else. You place the horn of mead in your bag and continue on your way.", true)
					menuLoc = 2;
					inventory.takeItem(consumables.GODMEAD);					
				}
				else {
					outputText("You spend an hour exploring the frigid glaciers but you don't find anything interesting.", true)
					doNext(13);
				}
			}
			else {
				outputText("You spend an hour exploring the frigid glaciers but you don't find anything interesting.", true);
				doNext(13);
			}
		}
		
	}

}