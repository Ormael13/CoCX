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
		public var giantScene:FrostGiantScene = new FrostGiantScene();
		
		public function GlacialRift() 
		{
		}
		
		public function exploreGlacialRift():void {
			flags[kFLAGS.DISCOVERED_GLACIAL_RIFT]++
			doNext(playerMenu);

			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Valkyrie
			choice[choice.length] = 1; //Yeti
			choice[choice.length] = 2; //Frost Giant
			if ((flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 0 || flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] > 0) && flags[kFLAGS.VALARIA_AT_CAMP] == 0 && player.armor != armors.GOOARMR) choice[choice.length] = 3; //Valeria
			if (rand(3) == 0) choice[choice.length] = 4; //Freebie items!
			if (rand(15) == 0 && player.hasKeyItem("Camp - Ornate Chest") < 0) choice[choice.length] = 5; //Ornate Chest
			choice[choice.length] = 6; //Find nothing!
			
			//DLC april fools
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0) {
				getGame().aprilFools.DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
				return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			select = choice[rand(choice.length)];
			switch(select) {
				case 0: //Valkyrie
					outputText("Making your way across the hard-packed ice of the Rift, you’re surprised to see the thick gray clouds part overhead.  You see a beautiful woman descend from on high, her snow-white wings flapping powerfully behind her back.  Armed with a long spear and shield, and clad in a bronze cuirass and a winged helm, she looks every bit the part of a mighty warrior.\n\n", true)
					outputText("She touches down gently a few feet before you, her shield and spear raised.  \"<i>You seem a worthy sort to test my skills against, wanderer.  Prepare yourself!</i>\" she shouts, bearing down on you.  She doesn’t look like she’s going to back down -- you ready your " + player.weaponName + " for a fight!")
					startCombat(new Valkyrie());
					break;
				case 1: //Yeti
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
					break;
				case 2: //Frost Giant
					outputText("You wander the frozen landscape of the Rift, frozen rocks, frosted hills and forested mountains your only landmarks. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your " + player.weaponName + " and withdraw from the hill to prepare for battle.\n\n", true);
					startCombat(new FrostGiant());
					break;
				case 3: //Find Valeria! She can be found there if you rejected her offer initially at Tower of the Phoenix or didn't find her. She can never be Lost Forever.
					spriteSelect(79);
					flags[kFLAGS.VALERIA_FOUND_IN_GLACIAL_RIFT] = 1;
					outputText("As you make your way across the Rift's icy extremities, you hear a metallic CLANK CLANK approaching through the snow flurries. You turn in time to see a suit of plated mail charging toward you, its helm and limbs filled with bright blue goo. It skids to a stop a few yards away, a greatsword forming from the goo of its hand. A beautiful, feminine face appears beneath the armor’s visor grinning at you. You suddenly recognize her face!\n\n", true)
					outputText("\"<i>This is my territory!</i>\" she shouts, bringing her two-handed sword to bare. \"<i>You’ll give me your fluids, or I’ll take them.</i>\"")
					addButton(0, "Fight", fightValeria);
					addButton(1, "Submit", kGAMECLASS.valeria.pcWinsValeriaSparDefeat, true);
					break;
				case 4: //Find item!
					var itemChooser:Number = rand(2);
					if (itemChooser == 0) {
						outputText("As you cross one of the floating ice sheets that make up the bulk of the rift, your eyes are drawn to a bright glint amidst the white backdrop.  As you eagerly approach the gleam, you discover a single tiny spire of ice, jutting from the surrounding snow.  You pluck it gently from the ground, give it a quick glance over and, satisfied that it won’t try and kill you, drop it in your bag. ", true)
						inventory.takeItem(consumables.ICICLE_, camp.returnToCampUseOneHour);
					}
					else if (itemChooser == 1) {
						outputText("As you make your way across the icy wastes, you notice a small corked ivory horn half-buried under the snow, filled with a thick sweet-looking liquor. You stop and dig it up, sniffing curiously at the liquid. The scent reminds you of the honey secreted by the bee-girls of Mareth, though with hints of alcohol and... something else. You place the horn of mead in your bag and continue on your way. ", true)
						inventory.takeItem(consumables.GODMEAD, camp.returnToCampUseOneHour);					
					}
					break;
				case 5: //Find ornate chest!
					var gemsFound:int = 400 + rand(400);
					outputText("While you're minding your own business, you spot an ornately-decorated chest somewhat buried in the snow. You walk on the snowy grounds you finally reach the chest. As you open the chest, you find " + String(gemsFound) + " gems inside the chest! You pocket the gems and haul the chest home. It looks nice and would make a good storage.");
					player.createKeyItem("Camp - Ornate Chest", 0, 0, 0, 0);
					for (var i:int = 0; i < 4; i++) {
						inventory.createStorage();
					}
					player.gems += gemsFound;
					statScreenRefresh();
					outputText("\n\n<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
					doNext(camp.returnToCampUseOneHour);
					break;
				default:
					outputText("You spend an hour trudging through the bleak and bitingly cold glaciers but you don’t find anything interesting.", true);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		private function fightValeria():void {
			outputText("You ready your " + player.weaponName + " for a fight!", true)
			startCombat(new GooArmor());
		}
	}
	

}