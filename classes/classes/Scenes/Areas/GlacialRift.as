/**
 * Created by Kitteh6660. Glacial Rift is a area with level 30-40 encounters	(outer lvl 60-80, inner lvl 85-110)
 * Currently a Work in Progress.
 * 
 * Please see this project. (This is not mine.) http://forum.fenoxo.com/thread-10719.html
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.BodyParts.Eyes;
import classes.BodyParts.RearBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.GlacialRift.*;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.GooArmor;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class GlacialRift extends BaseContent
	{
		public var yukionnaScene:YukiOnnaScene = new YukiOnnaScene();
		public var valkyrieScene:ValkyrieScene = new ValkyrieScene();
		public var yetiScene:YetiScene = new YetiScene();
		public var giantScene:FrostGiantScene = new FrostGiantScene();
		public var winterwolfScene:WinterWolfScene = new WinterWolfScene();
		public var alrauneScene:AlrauneScene = new AlrauneScene();
		
		public function GlacialRift() 
		{
		}
		
		public function exploreGlacialRift():void {
			flags[kFLAGS.DISCOVERED_GLACIAL_RIFT]++;
			doNext(playerMenu);

			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Yuki Onna OR Valkyrie (Valkyrie later on move down to Tundra ^^)
			choice[choice.length] = 1; //Yeti
			choice[choice.length] = 2; //Frost Giant
			choice[choice.length] = 3; //Winter Wolf
			choice[choice.length] = 4; //Ice True Golems
			choice[choice.length] = 5; //Snow Lily
			if ((flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 0 || flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] > 0) && flags[kFLAGS.VALARIA_AT_CAMP] == 0 && flags[kFLAGS.TOOK_GOO_ARMOR] == 0 && player.armor != armors.GOOARMR) choice[choice.length] = 6; //Valeria
			if (rand(3) == 0) choice[choice.length] = 7; //Freebie items!
			if (rand(15) == 0) choice[choice.length] = 8; //Ornate Chest or cache of gems/pile of stones
			if (player.faceType == 24 && player.ears.type == 18 && player.arms.type == 10 && player.lowerBody == 33 && player.tailType == 29 && player.hasFur() && player.hairColor == "glacial white" && player.coatColor == "glacial white" && player.hasKeyItem("Fenrir Collar") < 0) choice[choice.length] = 9; //Fenrir ruined shrine
			choice[choice.length] = 10; //Find nothing!
			
			//DLC april fools
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0) {
                Holidays.DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
                return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helScene.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0 && (player.level >= 20)) {
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			//Anzu
			if (flags[kFLAGS.ANZU_PALACE_UNLOCKED] < 1 && rand(5) == 0) {
				SceneLib.anzu.initialPalaceEncounter();
				return;
			}
			//Yu shop
			if (flags[kFLAGS.YU_SHOP] < 2 && rand(5) == 0) {
				SceneLib.glacialYuShop.YuIntro();
				return;
			}
			select = choice[rand(choice.length)];
			switch(select) {
				case 0: //Yuki Onna OR Valkyrie
					clearOutput();
					if (rand(2) == 0 && flags[kFLAGS.YU_SHOP] > 0) yukionnaScene.encounterYukiOnna();
					else {
						outputText("Making your way across the hard-packed ice of the Rift, you’re surprised to see the thick gray clouds part overhead.  You see a beautiful woman descend from on high, her snow-white wings flapping powerfully behind her back.  Armed with a long spear and shield, and clad in a bronze cuirass and a winged helm, she looks every bit the part of a mighty warrior.\n\n");
						outputText("She touches down gently a few feet before you, her shield and spear raised.  \"<i>You seem a worthy sort to test my skills against, wanderer.  Prepare yourself!</i>\" she shouts, bearing down on you.  She doesn’t look like she’s going to back down -- you ready your [weapon] for a fight!");
						startCombat(new Valkyrie());
					}
					break;
				case 1: //Yeti
					clearOutput();
					outputText("You grow tired trudging through the hard-packed snow under you, shielding your face with an arm as the wind lashes against you, slowing your progress. The whistle of the wind rings in your ears, only broken with the dull crunch of snow compacting underfoot. You can’t help but regret wandering into this storm and wish for shelter and warmth. Your body freezes at the sound of a loud crack, and turning your head to see the source of the noise, you notice too late that your lower body is sinking in the snow floor. You flail your limbs as your body is swept under by the moving snow, and you feel yourself sliding down some sort of shaft: it’s too dark to see where you are going. With a thump, you come to a stop.\n\n");
					if (flags[kFLAGS.MET_YETI_FIRST_TIME] <= 0) {
						outputText("Quickly wiping the snow off your body, you take in your surroundings. There are torches overhead that provide light and a small amount of warmth, making the ice cavern almost beautiful to be in, the light reflecting and shimmering off the polished ice walls, ceiling, and large icicles. There are a number of holes like the one you must have came out of, like a network of chutes that all lead to your location. You are surprised to find something under you, a large pile of white furs broke your fall. Though you are unnerved to find a large collection of bones lining the sides of the ice cavern, all white like snow, cleaned to a shine. Taking all this in, it’s obvious you are in someone’s or something’s residence. ");
						if (silly()) {
							outputText("You notice the bodies of a number of strange, bipedal horse-like creatures, all covered in thick white fur hanging from the nearby wall; laying beneath one is a strange metallic cylinder, not unlike a sword hilt, that gives off a strange, soft heat. ")
						}
						outputText("You brush off the snow and get to your feet, turning your head as you notice a passageway.\n\n");
						flags[kFLAGS.MET_YETI_FIRST_TIME] = 1;
					}
					else {
						outputText("Taking in the familiar surroundings, you realize you must have fallen through one of those chutes again. You begin to wonder if they are for the Yeti’s use, or if they are meant to bring in unsuspecting travelers. A meal delivery service set up with their limited ice magic? You shake off the snow on you and get to your feet. Looking to the passage, sure enough shadows dance along the walls as the thumps reach your ears.\n\n")
					}
					outputText("Hearing a thunderous roar, you ready yourself for a fight");
					if (player.weaponName != "fists") outputText(", holding your [weapon] at the ready");
					outputText(". A massive hulking creature barrels around the corner and sets its gaze on you, its clawed hands and feet launching its body over the iced caverns with ease as you stare the beast down. The white blur of an ice yeti attacks you!");
					startCombat(new Yeti());
					break;
				case 2: //Frost Giant
					clearOutput();
					outputText("You wander the frozen landscape of the Rift, frozen rocks, frosted hills and forested mountains your only landmarks. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your [weapon] and withdraw from the hill to prepare for battle.\n\n");
					startCombat(new FrostGiant());
					break;
				case 3: //Winter Wolf
					clearOutput();
					outputText("A titanic howling sound is heard nearby as an enormous shape jump off a nearby cliff into the snow right in front of you. As the flying snow clear off you see a wolf of immaculate pelt and size bordering the absurd. You likely accidentally stepped into its hunting territory and to clearly show its displeasure the ten feet tall monster growl at you showing its dagger-like teeth then start running in your direction howling what sounds to be a challenge.\n\n");
					startCombat(new WinterWolf());
					break;
				case 4: //True Ice Golems
					clearOutput();
					outputText("As you take a stroll, out of the nearby glaciers emerge a group of golems. Looks like you have encountered some true ice golems! You ready your [weapon] for a fight!");
					startCombat(new GolemsTrueIce());
					break;
				case 5:	//Snow Lily
					clearOutput();
					if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
						outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
						menu();
						addButton(0, "Yes", camp.returnToCampUseOneHour);
						addButton(1, "No", alrauneScene.alrauneGlacialRift);
					} else {
						alrauneScene.alrauneGlacialRift();
					}
					break;
				case 6: //Find Valeria! She can be found there if you rejected her offer initially at Tower of the Phoenix or didn't find her. She can never be Lost Forever.
					spriteSelect(79);
					flags[kFLAGS.VALERIA_FOUND_IN_GLACIAL_RIFT] = 1;
					clearOutput();
					outputText("As you make your way across the Rift's icy extremities, you hear a metallic CLANK CLANK approaching through the snow flurries. You turn in time to see a suit of plated mail charging toward you, its helm and limbs filled with bright blue goo. It skids to a stop a few yards away, a greatsword forming from the goo of its hand. A beautiful, feminine face appears beneath the armor’s visor grinning at you. You suddenly recognize her face!\n\n");
					outputText("\"<i>This is my territory!</i>\" she shouts, bringing her two-handed sword to bare. \"<i>You’ll give me your fluids, or I’ll take them.</i>\"");
					addButton(0, "Fight", fightValeria);
					addButton(1, "Submit", SceneLib.valeria.pcWinsValeriaSparDefeat, true);
					break;
				case 7: //Find Aria of item!
					clearOutput();/*
					if (rand(2) == 0) {
						SceneLib.ariaScene.MelkieEncounter();
					}
					else {*/
						var itemChooser:Number = rand(2);
						if (itemChooser == 0) {
							outputText("As you cross one of the floating ice sheets that make up the bulk of the rift, your eyes are drawn to a bright glint amidst the white backdrop.  As you eagerly approach the gleam, you discover a single tiny spire of ice, jutting from the surrounding snow.  You pluck it gently from the ground, give it a quick glance over and, satisfied that it won’t try and kill you, drop it in your bag. ");
							inventory.takeItem(consumables.ICICLE_, camp.returnToCampUseOneHour);
						}
						else if (itemChooser == 1) {
							outputText("As you make your way across the icy wastes, you notice a small corked ivory horns half-buried under the snow, filled with a thick sweet-looking liquor. You stop and dig it up, sniffing curiously at the liquid. The scent reminds you of the honey secreted by the bee-girls of Mareth, though with hints of alcohol and... something else. You place the horns of mead in your bag and continue on your way. ");
							inventory.takeItem(consumables.GODMEAD, camp.returnToCampUseOneHour);					
						}
					//}
					break;
				case 8: //Find ornate chest!
					if (player.hasKeyItem("Camp - Ornate Chest") < 0) {
						var gemsFound:int = 400 + rand(400);
						outputText("While you're minding your own business, you spot an ornately-decorated chest somewhat buried in the snow. You walk on the snowy grounds you finally reach the chest. As you open the chest, you find " + String(gemsFound) + " gems inside the chest! You pocket the gems and haul the chest home. It looks nice and would make a good storage.");
						player.createKeyItem("Camp - Ornate Chest", 0, 0, 0, 0);
						for (var i:int = 0; i < 4; i++) {
							inventory.createStorage();
						}
						player.gems += gemsFound;
						statScreenRefresh();
						outputText("\n\n<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
					}
					else {
						if (rand(2) == 0) {
							var stonesHarvested:Number = 10;
							var stonesCapacity:Number = 300;
							if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) stonesCapacity += 600;
							outputText("You find a big amount of stone rubble in the rift and begin to harvest them for your constructions. ");
							if (SceneLib.emberScene.followerEmber() || SceneLib.kihaFollower.followerKiha()) {
								stonesHarvested += 10;
								if (SceneLib.emberScene.followerEmber() && SceneLib.kihaFollower.followerKiha()) {
									outputText("Kiha and Ember");
									stonesHarvested += 10;
								}
								else if (SceneLib.emberScene.followerEmber()) {
									outputText("Ember");
									if (SceneLib.kihaFollower.followerKiha()) outputText(" and ");
								}
								else outputText("Kiha");
								outputText(" assist you into bringing as many as possible back to camp. ");
							}
							if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + stonesHarvested < stonesCapacity) flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stonesHarvested;
							else flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] = stonesCapacity;
						}
						else {
							var gemsFound2:int = 40 + rand(160);
							outputText("As you wander the rift your foot hits something burrowed under the snow. It is a treasure chest and it looks packed to the brim.\n\nInside was " + String(gemsFound) + " gems! ");
							player.gems += gemsFound2;
							statScreenRefresh();
						}
					}
					doNext(camp.returnToCampUseOneHour);
					break;
				case 9: //Fenrir ruined shrine!
					clearOutput();
					if (flags[kFLAGS.FENRIR_COLLAR] == 1) {
						outputText("On your way to the glacial rift you find your way back to the temple again and the menacing voice of Fenrir echoes.");
						outputText("\n\n\"<i>’So have you reconsidered my offer? You can take your time I have an eternity ahead of me.</i>\"");
						outputText("The collar is still patiently waiting on the altar so what do you do. Will you take the collar and allow the black god the freedom he crave or will you ignore it and leave.");
						addButton(0, "Put the collar", putTheCollar);
						addButton(1, "Leave", leaveShrine);
					}
					else {
						outputText("As you walk in the Glacial rift you spot what looks like an old ruin covered in snow the entrance barely still visible from the outside. Clearing some of the snow you open yourself a path. You walk inside what looks to be a room of which the walls are either made out of magical ice. The circular room has several pillars some of them shattered as if a great battle had raged here. At the bottom of the room stands the statue of a fearsome looking wolf made out of what appears to be a diamond like structure at the foot of which is an altar on which has been placed what looks like a collar made for a huge sized animal.  ");
						outputText("The collar is bound to the altar with chains and, despite the fact the place likely has been abandoned for century, they seems to be quite strong. As you approach the altar a powerful masculine voice echo through the room making the ancient structure shake with its power alone.");
						outputText("\n\n\"<i>You who dares to approach my ruined shrine and enter the boundary of my prison... speak up... why have you come here?</i>\"");
						outputText("\n\nYou present yourself telling you're a champion sent on Mareth to defeat the demons.");
						outputText("\n\n\"<i>Defeating the demons eh? Have the gods sunk so low as to fear vermins now?</i>\" The voice roar in an unsettling laugh making the icy chamber shake.");
						outputText("\n\nYou ask just who or what is talking actually.");
						outputText("\n\n\"<i>You mortals have forgotten the gods and their battle. I am what one could call... a fallen deity... a divinity who has been sealed by the other gods for fear of its power because they could not control me, they couldn't TAME me. ");
						outputText("I am the cold hand of winter the howling blizzard the treasonous chill of death my name is Fenrir and I am the deity of this blasted lost glacial land or rather I was until the pantheon itself teamed up to seal me in this ridiculous collar destroying my body and scattering its remnant across the glacial rift in the form of puppies. I fear no demons I was there before them and will still be there after them. Right now I only wish one of those fiends would come here and set me free so that I could exact my vengeance.</i>\"");
						outputText("\n\nFaced with such a malevolent being you prepare to leave as the voice rise again.");
						outputText("\n\n\"<i>’I will never be able to fully take form again. However, as your body is close enough to my original form, I have a favor to ask that only you mortal could do. Take this collar and wear it so that at least what is left of my once mighty spirit can see the world again through your eyes. In exchange, I will grant you a fraction of my once almighty divine power. For it is power that you seek is it not?</i>\"");
						outputText("\n\nThe voice has a sinister laugh for a moment then falls silent leaving you a choice will you leave the shrine or will you take the risk and put on the collar?");
						addButton(0, "Put the collar", putTheCollar);
						addButton(1, "Leave", leaveShrine);
					}
					break;
				default:
					clearOutput();
					outputText("You spend an hour trudging through the bleak and bitingly cold glaciers but you don’t find anything interesting. But on your way back you feel you're a little more used to traveling through this harsh area.");
					dynStats("tou", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		private function fightValeria():void {
			clearOutput();
			outputText("You ready your [weapon] for a fight!");
			startCombat(new GooArmor());
		}
		
		private function putTheCollar():void {
			clearOutput();
			outputText("You pull the chains binding the collar to the table using a warhammer left nearby to shatter the binding extremities on the ground and pick the collar up, for some reason the chains still tied to the collar refuse to break likely it is indestructible. You open and fasten the collar around your neck and the voice of the sealed deity wash over your mind.");
			outputText("\n\n\"<i>Free... I am FREE! I have thousands of years of retribution to enact on this world and you will help me with it! You want power, I will grant you all the power you want as long as you use it in the most destructive way possible to further my goal.</i>\"");
			outputText("\n\nThe black god didn't lie you feel power like you could never have imagined pouring into you altering you into a creature people could only fear or kneel to in silent awe. You are not just a regular wolf now… no you are THE Fenrir a beast of legend that has terrorised both gods and mortals for thousands of years. It is high time they remember your existence an existence they thought forgotten and forever sealed and with those new power you obtained it is something well in your reach.");
			outputText("\n\nFor a few second cold air wash on your eyes and no matter how much you try to cover them with your hands to end the freezing sensation it won't stop. As your eyes begins to water the chilling finally end, you remove your hand as everything before you looks way clearer especially the snow which no longer blinds you. As you look at your reflection in the water you discover that not only your eyes glow with an unsettling blue aura, from your eyes now emanate a pair of bluish smoke of cold air contrasting with the ambient heat. <b>You now have glowing icy eyes.</b>");
			outputText("\n\nYou feel the air freeze and condensate around you specifically behind your shoulder blades and all on the length of your spine. Jagged Ice spikes seems to have covered your back but oddly enough you don't feel the cold. <b>Your back is now covered with sharp ice spike constantly cooling the air around you. (Gained Frozen Waste and Cold Mastery perks)</b>");
			outputText("\n\nYou suddenly feel something raging in you wanting to be unleashed as it slowly climbs out of your chest. It rushes through your throat and you scream a titanic primordial roar as the air in front of you ondulate with a massive drop of temperature and everything covers with a thick layer of solid ice. You massage your throat for a moment noticing as thin volume of condensation constantly escape from your maw. <b>You can now use Freezing Breath and Frostbite.</b>");
            CoC.instance.mutations.setEyeTypeAndColor(Eyes.FENRIR, "blue");
            player.rearBody.type = RearBody.FENRIR_ICE_SPIKES;
			player.createPerk(PerkLib.ColdMastery, 0, 0, 0, 0);
			player.createPerk(PerkLib.FreezingBreath, 0, 0, 0, 0);
			player.createPerk(PerkLib.FromTheFrozenWaste, 0, 0, 0, 0);
			player.createPerk(PerkLib.FenrirSpikedCollar, 0, 0, 0, 0);
			player.createKeyItem("Fenrir Collar", 0, 0, 0, 0);
			dynStats("cor", 100);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function leaveShrine():void {
			clearOutput();
			outputText("You're not sure if putting this collar on is the brightest idea especially considering it's an item belonging to an evil deity. You decide to leave and go back when you're ready to make a choice however Fenrir still manage to reply a sinister promise as you leave the cave.");
			outputText("\n\n\"<i>It doesn't matter how long it takes you to make the choice. I have waited hundred of years and will still wait as long as it takes for someone to set me free. If not you then even a demon would do. Would you rather have my power in the hands of your foes? I promise you that if a demon unbinds me you'll be the first prey I'll devour.</i>\"");
			outputText("\n\nOn those word Fenrir fall silent again as you make your way back to your camp.");
			if (flags[kFLAGS.FENRIR_COLLAR] < 1) flags[kFLAGS.FENRIR_COLLAR] = 1;
			doNext(camp.returnToCampUseOneHour);
		}
	}
	

}