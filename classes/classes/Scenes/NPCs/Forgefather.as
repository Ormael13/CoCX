/**
	 * ...
	 * @author melyons
	 */

package classes.Scenes.NPCs	{

import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Items.ConsumableLib;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.SceneLib;
import classes.internals.SaveableState;

public class Forgefather extends NPCAwareContent implements SaveableState	{
	//player.hasKeyItem("Marae's Lethicite") >= 0;
	//player.keyItemvX("Marae's Lethicite", 1) > 0;
	//player.addKeyValue("Marae's Lethicite", 1, -1);
	//player.hasItem(consumables.P_PEARL);
		public static var hairLength:int;
		public static var gender:int;
		public static var wings:int;
		public static var arms:int;
		public static var tail:int;
		public static var lowerBody:int;
		public static var chest:int;
		public static var vagina:int;
		public static var cock:int;
		public static var balls:int;
		public static var material:String;
		public static var refinement:int;
		public static var ebony:int;
		public static var granite:int;
		public static var alabaster:int;
		public static var marble:int;
		public static var sandstone:int;
		public static var matCap:int = 300;
		public static var channelInlay:String;
		public static var gem:String;
		public static var rarityAbsorbed:String;
		public static var talkedToFF:Boolean;
		public static var purePearlEaten:Boolean;
		public static var lethiciteEaten:Boolean;
		public static var materialsExplained:Boolean;
		public static var refinementExplained:Boolean;
		public static var inlaysExplained:Boolean;
		public static var gemstonesExplained:Boolean;
		public static var avatarsExplained:Boolean;
		
		public function Forgefather() {
			Saves.registerSaveableState(this);
		}
		
		public function resetState():void {
			hairLength = 0;
			gender = 0;
			wings = 0;
			arms = 0;
			tail = 0;
			lowerBody = 0;
			chest = 0;
			vagina = 0;
			cock = 0;
			balls = 0;
			granite  = 0;
			ebony = 0;
			marble = 0;
			sandstone = 0;
			alabaster = 0;
			material = "";
			refinement = 0;
			channelInlay = "";
			gem = "";
			rarityAbsorbed = "";
			talkedToFF = false;
			purePearlEaten = false;
			lethiciteEaten = false;
			materialsExplained = false;
			refinementExplained = false;
			inlaysExplained = false;
			gemstonesExplained = false;
			avatarsExplained = false;
		}
		
		public function saveToObject():Object {
			return {
				"hairLength": hairLength,
				"gender": gender,
				"wings": wings,
				"arms": arms,
				"tail": tail,
				"lowerBody": lowerBody,
				"chest": chest,
				"vagina": vagina,
				"cock": cock,
				"balls": balls,
				"granite": granite,
				"ebony": ebony,
				"marble": marble,
				"sandstone": sandstone,
				"alabaster": alabaster,
				"material": material,
				"refinement": refinement,
				"channelInlay": channelInlay,
				"gem": gem,
				"rarityAbsorbed": rarityAbsorbed,
				"talkedToFF" : talkedToFF,
				"purePearlEaten": purePearlEaten,
				"lethiciteEaten": lethiciteEaten,
				"materialsExplained": materialsExplained,
				"refinementExplained": refinementExplained,
				"inlaysExplained": inlaysExplained,
				"gemstonesExplained": gemstonesExplained,
				"avatarsExplained": avatarsExplained
			}
		}
		
		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				hairLength = o["hairLength"];
				gender = o["gender"];
				wings = o["wings"];
				arms = o["arms"];
				tail = o["tail"];
				lowerBody = o["lowerBody"];
				chest = o["chest"];
				vagina = o["vagina"];
				cock = o["cock"];
				balls = o["balls"];
				granite = o["granite"];
				ebony = o["ebony"];
				marble = o["marble"];
				sandstone = o["sandstone"];
				alabaster = o["alabaster"];
				material = o["material"];
				refinement = o["refinement"];
				channelInlay = o["channelInlay"];
				gem = o["gem"];
				rarityAbsorbed = o["rarityAbsorbed"];
				talkedToFF = o["talkedToFF"];
				purePearlEaten = o["purePearlEaten"];
				lethiciteEaten = o["lethiciteEaten"];
				materialsExplained = o["materialsExplained"];
				refinementExplained = o["refinementExplained"];
				inlaysExplained = o["inlaysExplained"];
				gemstonesExplained = o["gemstonesExplained"];
				avatarsExplained = o["avatarsExplained"];
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function stateObjectName():String {
			return "ForgeFatherScenes";
		}

		public static function get statueProgress():int {
			var p:int = 0;
			if (Forgefather.gender > 0) ++p;
			if (Forgefather.wings > 0) ++p;
			if (Forgefather.tail > 0) ++p;
			if (Forgefather.lowerBody > 0) ++p;
			if (Forgefather.arms > 0) ++p;
			if (Forgefather.hairLength > 0) ++p;
			if (Forgefather.chest > 0) ++p;
			if (Forgefather.vagina > 0) ++p;
			if (Forgefather.cock > 0) ++p;
			if (Forgefather.balls > 0) ++p;
			return p;
		}
		
		public function meetForgefather():void	{
			flags[kFLAGS.MET_FORGEFATHER] = 1;
			clearOutput();
			outputText("You wander the area, finding the remains of an abandoned, played-out mine. Remains of long destroyed golems litter the ground around the entrance. As you move closer, you hear the faintest sound of metal striking metal. Once inside, you hear a deep, sad voice, singing a sorrowful tune. \n\n");
			outputText("Following the song, you happen across a most unique individual. A squat, muscular being; hunched over an anvil, shaping the head of a warhammer. Powerful arms rhythmically bring the hammer down, pounding the metal further into a shape that seems to flow from the beings mind.\n");
			outputText("After minutes pass, the being stops and turns slightly to face you.\n\n\"<i>Well </i>" + player.mf("<i>lad</i>","<i>lass</i>") + "<i>, are you going to stand there and gawk all day, or are you going to introduce yourself?</i>\"\n\n");
			addButton(0, "Introduce Yourself", introduceSelf);
			addButton(1, "Not Now", notNow);
		}
		
		public function introduceSelf():void {
			flags[kFLAGS.FORGEFATHER_MOVED_TO_TEMPLE] = 1;
			outputText("You introduce yourself to the being. /n/n");
			outputText("Eyeing your quite solid form, he chuckles./n");
			outputText("\"<i>That's quite the stout form you have. I thought the demons destroyed all of your kind.</i>\"\n\n");
			outputText("You respond, telling him of the Temple, and the 2 gargoyles now there. You describe you were a champion of your village, and how you willingly gave up your original form to inhabit the stony body.\n\n");
			outputText("Surprised, the being exclaims.\n\n");
			outputText("\n<i>The temple, high in the mountains. It still stands? Those old stones are more stubborn than we thought. And to hear my people's most wonderful designs live on.</i>\"\n\n");
			outputText("The being grabs his gear from behind the anvil, and steps forward.\n\n");
			outputText("\"<i>I'm going to see how the old workshop fares. If you want to learn more about your kind, " + player.mf("lad","lass") + ", come find me there.</i>\"");
			endEncounter();
		}
		
		public function notNow():void {
			outputText("You decide, maybe you should just go back the way you came.\nYou turn around and begin walking out of the mine.\n\n");
			outputText("\"<i>Fine then, if you finnaly decide to talk, you know where I'll be.</i>\"");
			endEncounter();
		}
		
		public function repeatForgefather():void {
			clearOutput();
			outputText("Finding yourself once again approaching the abandoned mine, you decide to check back in on the intriguing smith.\n");
			outputText("Making your way through the tunnels, you once again find yourself beholding the being.\n\n");
			outputText("\"<i>Well, you've returned,</i>" + player.mf("<i>lad</i>","<i>lass</i>") + "<i>. You finally going to tell me you're name?</i>\"");
			addButton(0, "Introduce Yourself", introduceSelf);
			addButton(1, "Not Now", notNow);
		}
	
		public function setGargoyleHair(hairLengthNew:int): void {
			hairLength = hairLengthNew;
		}
		
		public function setGargoyleGender(genderNew:int): void {
			gender = genderNew;
		}
		
		public function setGargoyleWings(wingsNew:int): void {
			wings = wingsNew;
		}
		
		public function setGargoyleArms(armsNew:int): void {
			arms = armsNew;
		}
		
		public function setGargoyleTail(tailNew:int): void {
			tail = tailNew;
		}
		
		public function setGargoyleLowerBody(lowerBodyNew:int): void {
			lowerBody = lowerBodyNew;
		}
		
		public function setGargoyleChest(chestNew:int): void {
			chest = chestNew;
		}
		
		public function setGargoyleVagina(vaginaNew:int): void {
			vagina = vaginaNew;
		}
		
		public function setGargoyleCock(cockNew:int): void {
			cock = cockNew;
		}
		
		public function setGargoyleBalls(ballsNew:int): void {
			balls = ballsNew;
		}
		
		public function createGargoyleState(): void {
			player.knockUpForce(); //reset any pregnancies
			player.knockUpForce(0, 0, 1); //reset any pregnancies
			player.skin.setBaseOnly({type:Skin.STONE});
			player.skinColor = "dark gray";
			player.skinColor2 = "dark gray";
			player.hairColor = "dark gray";
			material = "stone";
			player.hairType = Hair.NORMAL;
			player.faceType = Face.DEVIL_FANGS;
			CoC.instance.transformations.TongueDemonic.applyEffect(false);
			player.horns.type = Horns.GARGOYLE;
			player.horns.count = 12 + rand(4);
			player.beardLength = 0;
			player.beardStyle = 0;
			player.createPerk(PerkLib.StrengthOfStone,0,0,0,0);
			player.removeAllRacialMutation();
			
			switch (gender) {
				case 1:
					player.femininity = 100
					break;
				case 2:
					player.femininity = 0;
					break;
				case 3:
					player.femininity = 50;
					if (!player.hasPerk(PerkLib.Androgyny)) player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
					break;
			}
			
			switch (hairLength) {
				case 1:
					player.hairLength = 0;
					break;
				case 2:
					player.hairLength = 2;
					break;
				case 3:
					player.hairLength = 8;
					break;
				case 4:
					player.hairLength = 14;
					break;
			}
			
			switch (arms) {
				case 1:
					player.arms.type = Arms.GARGOYLE;
					break;
				case 2:
					player.arms.type = Arms.GARGOYLE_2;
					break;
			}
			
			switch (tail) {
				case 1:
					player.tailType = Tail.GARGOYLE;
					break;
				case 2:
					player.tailType = Tail.GARGOYLE_2;
					break;
			}
			
			player.tailRecharge = 0;
			player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
			
			switch (lowerBody) {
				case 1:
					player.lowerBody = LowerBody.GARGOYLE;
					break;
				case 2:
					player.lowerBody = LowerBody.GARGOYLE_2;
					break;
			}
			
			player.legCount = 2;
			player.eyes.type = Eyes.GEMSTONES;
			player.antennae.type = Antennae.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.ears.type = Ears.ELFIN;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			if (player.hasStatusEffect(StatusEffects.BlackNipples)) player.removeStatusEffect(StatusEffects.BlackNipples);
			if (player.averageNipplesPerBreast() > 1) player.breastRows[0].nipplesPerBreast = 1;
			if (player.breastRows.length > 1) player.breastRows.length = 1;
			player.breastRows[0].breastRating = chest - 1;
			if (player.hasStatusEffect(StatusEffects.Feeder)) {
				player.removeStatusEffect(StatusEffects.Feeder);
				player.removePerk(PerkLib.Feeder);
			}

			if (player.hasStatusEffect(StatusEffects.Infested)) {
				player.removeStatusEffect(StatusEffects.Infested);
				player.buff("Infested").remove();
			}
			switch (vagina) {
				case 1:
					if (player.hasVagina())
					{
						player.clitLength = .0;
						player.removeVagina(0, 1);
					}
					break;
				case 2:
					player.createVagina();
					player.clitLength = 0.5;
					break;
			}
			
			player.killCocks(-1);
			if (cock >= 2){
				player.createCock();
				var length:Number = 3;
				length += cock * 0.5;
				player.cocks[0].cockLength = length;
				player.cocks[0].cockThickness = Math.floor(((length / 5) - 0.1) * 10) / 10;
				player.cocks[0].cockType = CockTypesEnum.HUMAN;
				player.cocks[0].knotMultiplier = 1;
			}
			
			switch (balls) {
				case 1:
					player.balls = 0;
					player.ballSize = 0;
					break;
				default:
					player.balls = 2;
					player.ballSize = balls - 1;
					break;
			}
		}
		
		public function workshopMainMenu(): void{
			clearOutput();
			outputText("Welcome to the stone-shop, what do you want?");
			menu();
			addButton(0, "Talk", talk).hint( "Talk to the Dwarf.");
			if (talkedToFF) {
				addButton(1, "Explain Mat's", explainMaterials).hint("Ask about the various materials a gargoyle can be made of.");
				addButton(2, "Explain Refine", explainRefinement).hint("Ask about the various levels of refinement a gargoyle can have.");
			}
			else{
				addButtonDisabled(1,"Explain Mat's, Talk to the Dwarven Forge-Father first.");
				addButtonDisabled(2,"Explain Refine, Talk to the Dwarven Forge-Father first.");
			}
			if (refinement >=2 && inlaysExplained){
				addButton(3, "Explain Inlays", explainInlay).hint("Ask about the various inlays a gargoyle can be given.");
				addButton(4, "Explain Gems", explainGemstones).hint("Ask about the various gemstones a gargoyle can be blinged with.");
			}
			else if (refinement >= 2 && !inlaysExplained){
				addButton(3, "Explain Inlays", explainInlay).hint("Ask about the various inlays a gargoyle can be given.");
				addButtonDisabled(4, "Explain Gems", "Carve channels in your form first");
			}
			else {
				addButtonDisabled(3, "Explain Inlays", "Carve channels in your form first");
				addButtonDisabled(4, "Explain Gems", "Carve channels in your form first");
			}
			if (materialsExplained && refinement < 5) addButton(6, "Change Mat's", changeMaterials).hint("Change" +
					" your body's material.");
			else if (refinement >= 5) addButtonDisabled(6, "Change Mat's", "You've crossed the rubicon, there is no" +
					" turning back.");
			else addButtonDisabled(6, "Change Mat's", "Maybe you should learn what the materials do first?");
			if (refinementExplained) addButton(7, "Refine Body", refineBody).hint("Refine your form.");
			else addButtonDisabled(7, "Refine Body", "Maybe you should learn about refining your form first?");
			if (gemstonesExplained) addButton(8, "Change Inlays", inlayBody).hint("Set/Change your Inlays.");
			else addButtonDisabled(8, "Change Inlays", "Maybe you should learn about inlays first?");
			if (gemstonesExplained) addButton(9, "Change Gems", blingBody).hint("Set/Change your Gems.");
			else addButtonDisabled(9, "Change Gems", "Maybe you should learn about Gemstones first?");
			if (refinement == 4 && channelInlay != "" && gem != "") addButton(10, "What's Next", learnAboutAvatars).hint("You've come this far, what more can you do?")
			else if (refinement == 4 && avatarsExplained && !celessScene.isAdult) addButtonDisabled(10, "Become" +
					" Avatar", "You need to find a being of divine purity or corruption.")
			else if (refinement == 4 && avatarsExplained && celessScene.isAdult) addButton(10, "Become the Avatar", gargoyleFinalForm).hint("Take the final step.")

			addButton(14, "Back", SceneLib.templeofdivine.templeMainMenu);
		}

		public function talk(): void{
			talkedToFF = true;
			clearOutput();
			menu();
			outputText("The Dwarf turns around as you approach.\n");
			outputText("\"<i>I thought these old stones here were long dust, and your kind, our finest" +
					" creations, were gone. To think, this place survived, and gargoyles are still around.</i>\"\n");
			outputText("\"<i>We Dwarves created the gargoyles at the request of the High-Priests of the Faiths long" +
					" ago; they wanted guardians of the faith, protectors who would not succumb to old age. We" +
					" laboured for years to perfect your form, and scoured the lands for willing and strong souls to" +
					" give them life.</i>\"\n\n");
			outputText("\"<i>We found, as we progressed, that an individuals life prior to their sacrifice" +
					" could be enhanced by different earthern materials. Later, with the proper care and" +
					" design, their past skills could be greatly amplified by further customization of their" +
					" new form. Indeed, they became the paragons of the faith the High-Priests had so desired.</i>\"");
			addButton(14, "Back", workshopMainMenu);
		}

		public function explainMaterials(): void{
			materialsExplained = true;
			clearOutput();
			menu();
			outputText("\"<i>Well, initially, we made the original forms out of ordinary stone.</i>\"\n");
			outputText("\"<i>Later, as we worked with the first volunteers, we learned that some materials" +
					" could enhance your abilities:</i>\"\n\n");
			outputText("\"<i>From our stalwart Knights we found that Granite, like that found in the" +
					" Ashlands, could greatly enhance their defences, as well as slighlty improve their" +
					" damage capability.</i>\"\n");
			outputText("\"<i>From our ferocious Bezerkers we found that Ebony, like that found in the Caves," +
					" could greatly increase their damage potential, as well as increasing their speed.</i>\"\n");
			outputText("\"<i>From our peerless Mages we found that Alabaster, like that found in the Tundra," +
					" greatly increased their spellpower as well as increasing their mana pool.</i>\"\n");
			outputText("\"<i>From our wise Monks we found that Marble, like that found in the Defiled Ravine," +
					" greatly improved their wisdom, as well as bosting their maximum soulforce.</i>\"\n");
			outputText("\"<i>Finally, from our nible rogues and hunters we learned that Sandstone, like that" +
					" found at the Beach, significantly increased their speed, as well as improving their" +
					" damage.</i>\"\n");
			outputText("Now, before you go running off in search of these, you might want to find a pick-axe if you" +
					" don't already have one.");
			addButton(0, "Back", workshopMainMenu);
		}
		
		public function explainRefinement(): void{
			refinementExplained = true;
			clearOutput();
			menu();
			outputText("\"<i>So, you want to learn about refining your form? I found this old book here teaching apprentice masons about gargoyle refinement, maybe you should take a look.</i>\"\n\n");
			outputText("You look at the tome's cover: Gargoyle Refinement - Beautiful Forms for Every Occasion\n");
			outputText("You find a stool nearby, and begin to read\n\n.")
			outputText("\"Gargoyles are an artificial construct, blending both stonecraft and the soul of a" +
					" willing volunteer.\"\n\"To begin, a gargoyle's form start as raw stone, no" +
					" matter what material they are intending to be made of.\nThe Greatest of" +
					" them are Carved and Polished, bearing great and mighty powers. Legends speak of an even" +
					" greater form, needing the abilities of both the Great-Masons as well as a High-Priest to" +
					" bring this about.\"\n");
			outputText("\"<i>By consent of the Dwarves, the Volunteers, and High-Priests, a stone Gargoyle would" +
					" never be taken beyond the smoothed form.</i>\"\nn")
			outputText("To rough out a raw form gargoyle, you will need 200 of their current material. The various" +
					" steps to rough out the form is described.\n");
			outputText("To smooth out a rough form gargoyle, you will need 300 of their current material. The various" +
					" steps to smooth out the form is described.\n");
			outputText("To carve ritual channels into a smooth form gargoyle, you will need 2 Spring Waters, 2" +
					" Sheep's Milk, 1 Ectoplasm, and a pint of God's Mead. The various steps and inscriptions for" +
					" the channels are depicted.\n");
			outputText("To finish and polish a gragoyles form, you will need 3 Rough Lotions, 2 pieces of Coal, 1" +
					" Iron Weed and 1 Light Oil. The method to brew the mixture is described, as well as how to" +
					" apply it.\n");
			addButton(0, "Back", workshopMainMenu);
		}
		
		public function explainInlay(): void{
			inlaysExplained = true;
			clearOutput();
			menu();
			outputText("\"<i>You're ready to learn about carving in channels in your form are you?</i>\"\n\n");
			outputText("\"<i>Well, we Dwarves found that once smoothed, we could further augment your powers by" +
					" carving ritualistic channels into your form.</i>\"\n\"<i>While at first the channels coincided" +
					" with" +
					" the designs we gave the form, we noticed that as the gargoyles developed, the designs came" +
					" to mimic that of their patron Deity. As well, these desgins had what we could only consider" +
					" to be personalised touches, perhaps coming from the soul of the gargoyle.</i>\"\n\n");
			outputText("\"<i>These channels would then be filled in with a chosen gemstone.</i>\"");
			addButton(0, "Back", workshopMainMenu);
		}
		
		public function explainGemstones(): void{
			gemstonesExplained = true;
			clearOutput();
			menu();
			outputText("\"<i>You're ready to learn about filling in channels in your form are you?</i>\"\n\n");
			outputText("\"<i>While the High-Priests of old once dictated what Gemstones we were to use, but they" +
					" aren't around anymore to help. Sapphire just found me an old but intact volume of </i>'Gems of the" +
					" Faiths: Encyclopedia of the Holy Gemstones and Their Purpose'<i>. This will describe the various" +
					" Gemstones we used, and why.</i>\"\n\n");
			outputText("Finding your stool from last time, your begin to read:\n");
			outputText("The various faiths of Mareth have, over time adopted a variety of gemstones that have a" +
					" purpose" +
					" in their faiths. While some small differences exist as to what their exact benefits and" +
					" purposes were, most agreed on the following facts:\n\n");
			outputText("Amethyst - A gem embracing the element of darkness. It empowered dark-based spells and" +
					" allowed an unarmed attacker to inflict dark damage to foes. It also would occasionally" +
					" inflict blindness upon foes. Rarely found in the Caves.\n");
			outputText("Emerald - A gem embracing the element of the wind. It would increase the speed of it's user," +
					" and would allow one who could fly to stay aloft, even in the steepest dive. Rarely found at" +
					" the Beach.\n");
			outputText("Ruby - A gem embracing the element of fire. It empowered fire-based spells, and allowed an" +
					" unarmed attacker to inflict fire damage to foes. It would also occasionally inflict burns" +
					" upon foes. Rarely found in the Ashlands.\n");
			outputText("Sapphire - A gem embracing the element of ice. It would empower ice-based spells, and" +
					" allowed an unarmed attacker to inflict ice damage to foes. It would also occasionally inflict" +
					" freezing upon foes. Rarely found in the Tundra.\n");
			outputText("Topaz - A gem embracing the element of lightning. It would empower lightning-based spells," +
					" and allowed an unarmed attacker to inflict lightning damage to foes. It would also" +
					" occasionally stun foes. Rarely found in the Defiled Ravine.\n");
			addButton(0, "Back", workshopMainMenu);
		}

		public function learnAboutAvatars(): void{
			clearOutput();
			menu();
			outputText("As you head towards the Forge-Father, he turns to you with a look like he has the same" +
					" thought as you, 'What's next?'.\n\n");
			outputText("\"<i>Well now, you look like you've made quite a fine form for yourself. Far from" +
					" the old stone body you had wehn we first met.</i>\"\n");
			outputText("\"<i>I bet you're wondering, whats next? Well in times past, before the demons and" +
					" the subsequent loss of the High-Priests, there was one last step one of your kind would" +
					" take.</i>\"\n");
			outputText("\"<i>We would gather a mason of peerless skill, as well a High-Priest, and dedicate" +
					" your body to your faith. You would become an Avatar of your faith, stronger than any" +
					" lesser gargoyle. You'd never again be able to change your form, but your skills and" +
					" powers would be un-rivaled.</i>\"\n");
			outputText("\"<i>Alas, this is now impossible. The High-Priests are gone. Unless you can find an" +
					" individual with enough power to take an ordinary item, and bring out the legendary form" +
					" at it's heart, you can go no further.</i>\"\n");
			avatarsExplained = true;
			addButton(0, "Back", workshopMainMenu);
		}
		
		public function changeMaterials(): void{
			clearOutput();
			menu();
			outputText("You need 100 of the material you desired to become to be made of.\n\n");
			outputText("Materials:\n");
			outputText("Granite: " + granite +"\n");
			outputText("Ebony: " + ebony +"\n");
			outputText("Alabaster: " + alabaster +"\n");
			outputText("Marble: " + marble +"\n");
			outputText("Sandstone: " + sandstone +"\n");
			if (granite >= 100) addButton(0, "Granite", changeMatFunc, "granite").hint("Change your body to Granite");
			else addButtonDisabled(0, "Granite", "Not enough Granite");
			if (ebony >= 100) addButton(1, "Ebony", changeMatFunc, "ebony").hint("Change your body to Ebony");
			else addButtonDisabled(1, "Ebony", "Not enough Ebony");
			if (alabaster >= 100) addButton(2, "Alabaster", changeMatFunc, "alabaster").hint("Change your body to Alabaster");
			else addButtonDisabled(2, "Alabaster", "Not enough Alabaster");
			if (marble >= 100) addButton(3, "Marble", changeMatFunc, "marble").hint("Change your body to Marble");
			else addButtonDisabled(3, "Marble", "Not enough Marble");
			if (sandstone >= 100) addButton(4, "Sandstone", changeMatFunc, "sandstone").hint("Change your body to Sandstone");
			else addButtonDisabled(4, "Sandstone", "Not enough Sandstone");
			addButton(14, "Back", workshopMainMenu);
		}
		
		public function refineBody(): void{
			clearOutput();
			menu();
			var hasChannelMats:Boolean = (player.hasItem(consumables.GODMEAD, 1) && player.hasItem(consumables.S_WATER, 2) && player.hasItem(consumables.SHEEPMK, 2) && player.hasItem(consumables.ECTOPLS, 1));
			var hasPolishingMats:Boolean = (player.hasItem(consumables.ROUGHLN, 3) && player.hasItem(consumables.COAL___, 2) && player.hasItem(consumables.IRONWEED, 1) && player.hasItem(consumables.LIGHTOL, 1));
			outputText("You need 200 of the material to tranistion from raw to rough.\n");
			outputText("You need 300 of the material to tranistion from rough to smooth.\n");
			outputText("To have channels carved into your form, you need 2 Spring Waters, 2 Sheep's Milk, 1 Ectoplasm, and a pint of God's Mead to perpare the channels.\n");
			outputText("Finally, to polish your form, you need 3 Rough Lotions, 2 pieces of Coal, 1 Iron Weed and 1" +
					" Light Oil to be polished into your body,\nmoudling your power and greatly increasing it.\n\n");
			outputText("Materials:\n");
			outputText("Stone: " + CampStatsAndResources.StonesResc +"\n");
			outputText("Granite: " + granite +"\n");
			outputText("Ebony: " + ebony +"\n");
			outputText("Alabaster: " + alabaster +"\n");
			outputText("Marble: " + marble +"\n");
			outputText("Sandstone: " + sandstone +"\n");
			switch (material){
				case ("granite"):
					if (refinement < 2){
						if (granite >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					}
					else if (refinement == 2){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					}
					else if (refinement == 3){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					
					break;
				case ("ebony"):
					if (refinement < 2){
						if (ebony >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 2){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 3){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				case ("alabaster"):
					if (refinement < 2){
						if (alabaster >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 2){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 3){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				case ("marble"):
					if (refinement < 2){
						if (marble >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 2){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 3){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				case ("sandstone"):
					if (refinement < 2){
						if (sandstone >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 2){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 3){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				default:
					if (refinement < 2){
						if (CampStatsAndResources.StonesResc >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else addButtonDisabled(0, "Refine", "Stone cannot be refined further");
					break;
			}
			addButton(14, "Back", workshopMainMenu);
		}
		
		public function changeMatFunc(mat:String): void{
			switch (mat){
				case "granite":
					refinement = 1;
					granite -= 100;
					material         = "granite";
					player.skinColor = "gray";
					player.hairColor = "gray";
					break;
				case "ebony":
					refinement = 1;
					ebony  -= 100;
					material         = "ebony";
					player.skinColor = "black";
					player.hairColor = "black";
					break;
				case "alabaster":
					refinement = 1;
					alabaster -= 100;
					material         = "alabaster";
					player.skinColor = "quartz white";
					player.hairColor = "quartz white";
					break;
				case "marble":
					refinement = 1;
					marble -= 100;
					material         = "marble";
					player.skinColor = "light gray";
					player.hairColor = "light gray";
					break;
				case "sandstone":
					refinement = 1;
					sandstone -= 100;
					material         = "sandstone";
					player.skinColor = "caramel";
					player.hairColor = "caramel";
					break;
			}
			explorer.stopExploring();
			camp.returnToCamp(36);
		}
		
		public function refineFunc(): void{
			
			if (refinement < 2){
				switch (material){
					case "granite":
						granite -= ((refinement + 2) * 100);
						break;
					case "ebony":
						ebony -= ((refinement + 2) * 100);
						break;
					case "alabaster":
						alabaster -= ((refinement + 2) * 100);
						break;
					case "marble":
						marble -= ((refinement + 2) * 100);
						break;
					case "sandstone":
						sandstone -= ((refinement + 2) * 100);
						break;
					case "stone":
						CampStatsAndResources.StonesResc -= ((refinement + 2) * 100);
						break;
				}
				refinement++;
				explorer.stopExploring();
				camp.returnToCampUseSixHours();
			}
			if (refinement == 2){
				player.destroyItems(consumables.S_WATER, 2);
				player.destroyItems(consumables.SHEEPMK, 2);
				player.destroyItems(consumables.ECTOPLS, 1);
				player.destroyItems(consumables.GODMEAD, 1);
				refinement++;
				explorer.stopExploring();
				camp.returnToCampUseTwelveHours();
			}
			if (refinement == 3){
				player.destroyItems(consumables.ROUGHLN, 3);
				player.destroyItems(consumables.COAL___, 2);
				player.destroyItems(consumables.IRONWEED, 1);
				player.destroyItems(consumables.LIGHTOL, 1);
				refinement++
				explorer.stopExploring();
				camp.returnToCampUseTwelveHours();
			}
			
		}
		
		public function inlayFunc(inlayNew:String, replace:Boolean):void{
			switch (inlayNew){
				case "amethyst":
					if (!replace) player.destroyItems(useables.AMEGEM, 15);
					else player.destroyItems(useables.AMEGEM, 20);
					break;
				case "emerald":
					if (!replace) player.destroyItems(useables.EMDGEM, 15);
					else player.destroyItems(useables.EMDGEM, 20);
					break;
				case "ruby":
					if (!replace) player.destroyItems(useables.RBYGEM, 15);
					else player.destroyItems(useables.RBYGEM, 20);
					break;
				case "sapphire":
					if (!replace) player.destroyItems(useables.SAPPGEM, 15);
					else player.destroyItems(useables.SAPPGEM, 20);
					break;
				case "topaz":
					if (!replace) player.destroyItems(useables.TPAZGEM, 15);
					else player.destroyItems(useables.TPAZGEM, 20);
					break;
			}
			channelInlay = inlayNew;
			inlayBody();
		}
		
		public function blingFunc(gemNew:String, replace:Boolean):void{
			switch (gemNew){
				case "amethyst":
					if (!replace) player.destroyItems(useables.AMEGEM, 10);
					else player.destroyItems(useables.AMEGEM, 15);
					break;
				case "emerald":
					if (!replace) player.destroyItems(useables.EMDGEM, 10);
					else player.destroyItems(useables.EMDGEM, 15);
					break;
				case "ruby":
					if (!replace) player.destroyItems(useables.RBYGEM, 10);
					else player.destroyItems(useables.RBYGEM, 15);
					break;
				case "sapphire":
					if (!replace) player.destroyItems(useables.SAPPGEM, 10);
					else player.destroyItems(useables.SAPPGEM, 15);
					break;
				case "topaz":
					if (!replace) player.destroyItems(useables.TPAZGEM, 10);
					else player.destroyItems(useables.TPAZGEM, 15);
					break;
			}
			gem = gemNew;
			blingBody();
		}
		
		public function inlayBody():void{
			clearOutput();
			menu();
			outputText("To have inlays placed, you need 15 of the respective inlay gem.\n\n");
			outputText("To have inlays replaced, you need 2000 gems, plus 20 of the replacement inlay gem");
			if (channelInlay == "amethyst"){
				addButtonDisabled(0, "Amythyst", "Your inlays are already Amethyst.");
			}
			else if (channelInlay != "") {
				if (player.hasItem(useables.AMEGEM, 20) && (player.gems >= 2000)) addButton(0, "Amethyst", inlayFunc, "amethyst", true).hint("Change inlay to Amethyst");
				else addButtonDisabled(0, "Amythyst", "You need 20 Amethyst and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.AMEGEM, 15)) addButton(0, "Amethyst", inlayFunc, "amethyst", false).hint("Set inlay to Amethyst");
			else addButtonDisabled(0, "Amythyst", "You need 15 Amethyst to do this.");
			
			if (channelInlay == "emerald"){
				addButtonDisabled(1, "Emerald", "Your inlays are already Emerald.");
			}
			else if (channelInlay != "") {
				if (player.hasItem(useables.EMDGEM, 20) && (player.gems >= 2000)) addButton(1, "Emerald", inlayFunc, "emerald", true).hint("Change inlay to Emerald");
				else addButtonDisabled(1, "Emerald", "You need 20 Emerald and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.EMDGEM, 15)) addButton(1, "Emerald", inlayFunc, "emerald", false).hint("Set inlay to Emerald");
			else addButtonDisabled(1, "Emerald", "You need 15 Emerald to do this.");
			
			if (channelInlay == "ruby"){
				addButtonDisabled(2, "Ruby", "Your inlays are already Ruby.");
			}
			else if (channelInlay != "") {
				if (player.hasItem(useables.RBYGEM, 20) && (player.gems >= 2000)) addButton(2, "Ruby", inlayFunc, "ruby", true).hint("Change inlay to Ruby");
				else addButtonDisabled(2, "Ruby", "You need 20 Ruby and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.RBYGEM, 15)) addButton(2, "Ruby", inlayFunc, "ruby", false).hint("Set inlay to Ruby");
			else addButtonDisabled(2, "Ruby", "You need 15 Ruby to do this.");
			
			if (channelInlay == "sapphire"){
				addButtonDisabled(3, "Sapphire", "Your inlays are already Sapphire.");
			}
			else if (channelInlay != "") {
				if (player.hasItem(useables.SAPPGEM, 20) && (player.gems >= 2000)) addButton(3, "Sapphire", inlayFunc, "sapphire", true).hint("Change inlay to Sapphire");
				else addButtonDisabled(3, "Sapphire", "You need 20 Sapphire and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.SAPPGEM, 15)) addButton(3, "Sapphire", inlayFunc, "sapphire", false).hint("Set inlay to Sapphire");
			else addButtonDisabled(3, "Sapphire", "You need 15 Sapphire to do this.");
			
			if (channelInlay == "topaz"){
				addButtonDisabled(4, "Topaz", "Your inlays are already Topaz.");
			}
			else if (channelInlay != "") {
				if (player.hasItem(useables.TPAZGEM, 20) && (player.gems >= 2000)) addButton(4, "Topaz", inlayFunc, "topaz", true).hint("Change inlay to Topaz");
				else addButtonDisabled(4, "Topaz", "You need 20 Topaz and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.TPAZGEM, 15)) addButton(4, "Topaz", inlayFunc, "topaz", false).hint("Set inlay to Topaz");
			else addButtonDisabled(4, "Topaz", "You need 15 Topaz to do this.");
			addButton(14, "Back", workshopMainMenu);
		}
		
		public function blingBody():void{
			clearOutput();
			menu();
			outputText("To have gems placed, you need 10 of the respective decroation gem.\n\n");
			outputText("To have gems replaced, you need 2000 gems, plus 15 of the replacement decroation gem");
			if (gem == "amethyst"){
				addButtonDisabled(0, "Amythyst", "Your gems are already Amethyst.");
			}
			else if (gem != "") {
				if (player.hasItem(useables.AMEGEM, 15) && (player.gems >= 2000)) addButton(0, "Amethyst", blingFunc, "amethyst", true).hint("Change gems to Amethyst");
				else addButtonDisabled(0, "Amythyst", "You need 15 Amethyst and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.AMEGEM, 10)) addButton(0, "Amethyst", blingFunc, "amethyst", false).hint("Set gems to Amethyst");
			else addButtonDisabled(0, "Amythyst", "You need 10 Amethyst to do this.");
			
			if (gem == "emerald"){
				addButtonDisabled(1, "Emerald", "Your gems are already Emerald.");
			}
			else if (gem != "") {
				if (player.hasItem(useables.EMDGEM, 15) && (player.gems >= 2000)) addButton(1, "Emerald", blingFunc, "emerald", true).hint("Change gems to Emerald");
				else addButtonDisabled(1, "Emerald", "You need 15 Emerald and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.EMDGEM, 10)) addButton(1, "Emerald", blingFunc, "emerald", false).hint("Set gems to Emerald");
			else addButtonDisabled(1, "Emerald", "You need 10 Emerald to do this.");
			
			if (gem == "ruby"){
				addButtonDisabled(2, "Ruby", "Your gems are already Ruby.");
			}
			else if (gem != "") {
				if (player.hasItem(useables.RBYGEM, 15) && (player.gems >= 2000)) addButton(2, "Ruby", blingFunc, "ruby", true).hint("Change gems to Ruby");
				else addButtonDisabled(2, "Ruby", "You need 15 Ruby and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.RBYGEM, 10)) addButton(2, "Ruby", blingFunc, "ruby", false).hint("Set gems to Ruby");
			else addButtonDisabled(2, "Ruby", "You need 10 Ruby to do this.");
			
			if (gem == "sapphire"){
				addButtonDisabled(3, "Sapphire", "Your gems are already Sapphire.");
			}
			else if (gem != "") {
				if (player.hasItem(useables.SAPPGEM, 15) && (player.gems >= 2000)) addButton(3, "Sapphire", blingFunc, "sapphire", true).hint("Change gems to Sapphire");
				else addButtonDisabled(3, "Sapphire", "You need 15 Sapphire and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.SAPPGEM, 10)) addButton(3, "Sapphire", blingFunc, "sapphire", false).hint("Set gems to Sapphire");
			else addButtonDisabled(3, "Sapphire", "You need 10 Sapphire to do this.");
			
			if (gem == "topaz"){
				addButtonDisabled(4, "Topaz", "Your gems are already Topaz.");
			}
			else if (gem != "") {
				if (player.hasItem(useables.TPAZGEM, 15) && (player.gems >= 2000)) addButton(4, "Topaz", blingFunc, "topaz", true).hint("Change gems to Topaz");
				else addButtonDisabled(4, "Topaz", "You need 15 Topaz and 2000 gems to do this.");
			}
			else if (player.hasItem(useables.TPAZGEM, 10)) addButton(4, "Topaz", blingFunc, "topaz", false).hint("Set gems to Topaz");
			else addButtonDisabled(4, "Topaz", "You need 10 Topaz to do this.");
			addButton(14, "Back", workshopMainMenu);
		}
		
		public function incrementGraniteSupply(amount:int):void {
			outputText("<b>(+" + amount + " granite!");
			granite += amount;
			if (granite >= matCap) {
				granite = matCap;
				outputText(" Your granite capacity is full.")
			}
			outputText(")</b>");
		}
		
		public function incrementEbonySupply(amount:int):void {
			outputText("<b>(+" + amount + " ebony!");
			ebony += amount;
			if (ebony >= matCap) {
				ebony = matCap;
				outputText(" Your ebony capacity is full.")
			}
			outputText(")</b>");
		}
		
		public function incrementAlabasterSupply(amount:int):void {
			outputText("<b>(+" + amount + " alabaster!");
			alabaster += amount;
			if (alabaster >= matCap) {
				alabaster = matCap;
				outputText(" Your alabaster capacity is full.")
			}
			outputText(")</b>");
		}
		
		public function incrementMarbleSupply(amount:int):void {
			outputText("<b>(+" + amount + " marble!");
			marble += amount;
			if (marble >= matCap) {
				marble = matCap;
				outputText(" Your marble capacity is full.")
			}
			outputText(")</b>");
		}
		
		public function incrementSandstoneSupply(amount:int):void {
			outputText("<b>(+" + amount + " sandstone!");
			sandstone += amount;
			if (sandstone >= matCap) {
				sandstone = matCap;
				outputText(" Your sandstone capacity is full.")
			}
			outputText(")</b>");
		}
		
		public static function materialWord(): String{
			switch (material){
					case "stone":
						return "Stone";
					case "alabaster":
						return "Alabaster";
					case "ebony":
						return "Ebony";
					case "granite":
						return "Granite";
					case "marble":
						return "Marble";
					case "sandstone":
						return "Sandstone";
					default:
						return "Null";
			}
		}

		private function gargoyleFinalForm(): void{
			clearOutput();
			menu();
			outputText("With the news of the discovery of Divine soul similar to that of the High-Priests of old," +
					" you seek out the Forgefather.\n\n");
			outputText("\"<i>This being, she can take a seemingly mundane item, and draw out it's legendary" +
					" qualities? And she radiates a divine presence?</i>\"\n\n");
			outputText("Moving at an excited pace, he shuffles through piles of notes and drawings. \"<i>This" +
					" changes EVERYTHING! You could be raised to heights not seen since the coming of the" +
					" demons!</i>\"\n\n");
			outputText("He gathers some notes, and has you bring him to your camp. There, you meet with " + celessScene.Name +
					" and the Dwarf makes his introductions. Once the plan is agreed on, he declares.\n");
			outputText("\"<i>There is a font of power, located at </i>" + celessScene.isCorrupt ? "<i>the Ebon" +
					" Labyrinth </i>" : "<i>the Oasis atop High Mountain</i>" + "<i>. Let's head there.</i>\"\n\n");
			if (celessScene.isCorrupt){
				outputText("Once you arrive at the Font of Power deep in the Ebon Labyrinth, you are amazed at the" +
						" corruption of the place. The water is thick and murky and not wholly black, but shot" +
						" through" +
						" with deep purples, blues, and reds as well.\n\nThe Forgefather instructs you to lay in the" +
						" font, with only your head remaining above the surface.\n\n");
				outputText(celessScene.Name + " walks forward, with a look of lustful contemplation on her face." +
						" Already at full mast, she suddenly cum's, soaking your head and causing the Font to absorb" +
						" all light around you. As you lie in utter darkness, you sigh in delight as raw corruption" +
						" begins to circulate in your " + player.skin.desc + ", your stony heart within blackening" +
						" with unholy power as your heart turns to black obsidian. You moan out your desire as you" +
						" get a rush of lust... Fuck, ruin, defile, you begin seething with the desire to rape and" +
						" mess up everything you can get your hands on. Red runes have also appeared on your body" +
						" empowering your already mighty enchantments.\n\nTruly, you have become an Avatar of" +
						" Corruption.\n\n");
				if ((player.hasKeyItem("Marae's Lethicite") >= 0) && (player.keyItemvX("Marae's Lethicite", 1) > 0)){
					outputText("You hold Marae's Lethicite in your hands, desiring her power for your own. You take" +
							" a bite out of the Lethicite, feeling what is left of your soul swell with corruption." +
							" You now have an Aura of Corruption.");
					lethiciteEaten = true;
					player.addKeyValue("Marae's Lethicite", 1, -1);
				}
			}
			else{
				outputText("Once you arrive at the Font of Power at the Oasis, you are floored by the sheer purity" +
						" of the place. The water is clear and radiant, with not a ripple upon it's surface.\n\nThe" +
						" Forgefather instructs you to lay in the font, with only your head remaining above the surface.\n\n);");
				outputText(celessScene.Name + " walks forward, with a look of holy serentity upon her face, her horn" +
						" beginning to emit a cleansing light. Once at the Font's edge, she kneels down, touching" +
						" the surface with her horn, resulting in a blinding eruption of light. As you lie blinded" +
						" in the water, you shudder with a chill as the crystal clear magical water begins to" +
						" circulate in your " + player.skin.desc + ", your stony heart within going from greyish to white as holy" +
						" power washes over and cleanses you of any impurity. You sigh in absolute relief, your mind" +
						" clearer than it ever has been since you came to Mareth as you fully embrace purity within" +
						" your being. Blue runes have also appeared on your body empowering your already mighty" +
						"\n\n");
				if (player.hasItem(consumables.P_PEARL)){
					outputText("You hold Marae's Pure Pearl in your hand, desiring nothing more than to serve what" +
							" is left of the Faith's. In a moment of divine inspiration, you swallow the Pearl. You" +
							" now have an Aura of Corruption.");
					purePearlEaten = true;
					player.destroyItems(consumables.P_PEARL, 1);
				}
			}

			refinement++;
			explorer.stopExploring();
			addButton(0,"Return to camp", camp.returnToCampUseSixHours);
		}
	}
}
