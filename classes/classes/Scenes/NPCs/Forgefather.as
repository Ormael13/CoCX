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
	import classes.internals.SaveableState;
	import classes.Scenes.SceneLib;
	
	public class Forgefather extends NPCAwareContent implements SaveableState	{
		
		public static var statueProgress:int;
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
		public static var purePearlEaten:Boolean;
		public static var lethiciteEaten:Boolean;
		public static var materialsExplained:Boolean;
		public static var refinementExplained:Boolean;
		public static var inlaysExplained:Boolean;
		public static var gemstonesExplained:Boolean;
		
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
			purePearlEaten = false;
			lethiciteEaten = false;
			materialsExplained = false;
			refinementExplained = false;
			inlaysExplained = false;
			gemstonesExplained = false;
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
				"purePearlEaten": purePearlEaten,
				"lethiciteEaten": lethiciteEaten,
				"materialsExplained": materialsExplained,
				"refinementExplained": refinementExplained,
				"inlaysExplained": inlaysExplained,
				"gemstonesExplained": gemstonesExplained
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
				purePearlEaten = o["purePearlEaten"];
				lethiciteEaten = o["lethiciteEaten"];
				materialsExplained = o["materialsExplained"];
				refinementExplained = o["refinementExplained"];
				inlaysExplained = o["inlaysExplained"];
				gemstonesExplained = o["gemstonesExplained"];
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function stateObjectName():String {
			return "ForgeFatherScenes";
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
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function notNow():void {
			outputText("You decide, maybe you should just go back the way you came.\nYou turn around and begin walking out of the mine.\n\n");
			outputText("\"<i>Fine then, if you finnaly decide to talk, you know where I'll be.</i>\"");
			doNext(camp.returnToCampUseOneHour);
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
			player.skin.setBaseOnly({type:Skin.STONE});
			player.skinTone = "dark gray";
			player.hairColor = "dark gray";
			material = "stone";
			refinement = 1;
			player.hairType = Hair.NORMAL;
			player.faceType = Face.DEVIL_FANGS;
			player.tongue.type = Tongue.DEMONIC;
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
			
			player.removeVagina(0, 1);
			if (player.hasStatusEffect(StatusEffects.Infested)) player.removeStatusEffect(StatusEffects.Infested);
			switch (vagina) {
				case 1:
					player.clitLength = 0;
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
			addButtonDisabled(0, "Talk", "Not Yet Written");
			addButton(1, "Explain Mat's", explainMaterials).hint("Ask about the various materials a gargoyle can be made of.");
			addButton(2, "Explain Refine", explainRefinement).hint("Ask about the various levels of refinement a gargoyle can have.");
			if (refinement >=3){
				addButton(3, "Explain Inlays", explainInlay).hint("Ask about the various inlays a gargoyle can be given.");
				addButton(4, "Explain Gems", explainGemstones).hint("Ask about the various gemstones a gargoyle can be blinged with.");
			}
			else{
				addButtonDisabled(3, "Explain Inlays", "Carve channels in your form first");
				addButtonDisabled(4, "Explain Gems", "Carve channels in your form first");
			}
			if (materialsExplained && refinement < 4) addButton(6, "Change Mat's", changeMaterials).hint("Change your body's material.");
			else if (refinement >= 4) addButtonDisabled(6, "Change Mat's", "You've crossed the rubicon, there is no turning back.");
			else addButtonDisabled(6, "Change Mat's", "Maybe you should learn what the materials do first?");
			if (refinementExplained) addButton(7, "Refine Body", refineBody).hint("Refine your form.");
			else addButtonDisabled(7, "Refine Body", "Maybe you should learn about refining your form first?");
			if (inlaysExplained) addButton(8, "Change Inlays", inlayBody).hint("Set/Change your Inlays.");
			else addButtonDisabled(8, "Change Inlays", "Maybe you should learn about inlays first?");
			if (gemstonesExplained) addButton(9, "Change Gems", blingBody).hint("Set/Change your Gems.");
			else addButtonDisabled(9, "Change Inlays", "Maybe you should learn about Gemstones first?");
			if (gemstonesExplained) addButton(13, "Trade for Gems", trade4Gems).hint("Temporary measure.");
			addButton(14, "Back", SceneLib.templeofdivine.templeMainMenu);
		}
		
		public function explainMaterials(): void{
			materialsExplained = true;
			clearOutput();
			menu();
			outputText("\"<i>Well, my kin had once made Gargoyles out of pretty much any material brought to us.</i>\"\n");
			outputText("\"<i>Unfortunately, the Demons have made gathering it quite tough. I never was a miner, so I only know of a handful of minerals you could locate.</i>\"\n\n");
			outputText("The Dwarf hands you a list, detailing what the materials are, and where you could possibly find them:");
			outputText("Granite - Melee (Tank) - Found in the Ashlands\n");
			outputText("Ebony - Melee(Dmg) - Found in the Caves\n");
			outputText("Alabaster - Magic - Found in the Tundra\n");
			outputText("Marble - Soulforce - Found in the Defiled Ravine\n");
			outputText("Sandstone - Ranged - Found at the Beach\n\n");
			outputText("You might want a pick-axe, just saying.");
			addButton(0, "Back", workshopMainMenu)
		}
		
		public function explainRefinement(): void{
			refinementExplained = true;
			clearOutput();
			menu();
			outputText("\"<i>So, you want to learn about refining your form? I found this old book here teaching apprentice masons about gargoyle refinement, maybe you should take a look.</i>\"\n\n");
			outputText("Gargoyle Refinement - Beautiful Forms for Every Occasion\n");
			outputText("Gargoyles start as raw forms, no matter what material they are made of.\nThe Greatest of them are Carved and Polished, bearing great and mighty powers.\n");
			outputText("To rough out a raw form gargoyle, you will need 200 units of their current material.\n");
			outputText("To smooth out a rough form gargoyle, you will need 300 units of their current material.");
			outputText("Note, moving past this stage will prevent the rituals to change a gargoyles material from succeeding. Proceed with caution!\n");
			outputText("To carve ritual channels into a smooth form gargoyle, you will need 2 Spring Waters, 2 Sheep's Milk, 1 Ectoplasm, and a pint of God's Mead.\n");
			outputText("To finish and polish a gragoyles form, you will need 3 Rough Lotions, 2 pieces of Coal, 1 Iron Weed and 1 Light Oil.\n");
			addButton(0, "Back", workshopMainMenu)
		}
		
		public function explainInlay(): void{
			inlaysExplained = true;
			clearOutput();
			menu();
			outputText("Shit will go here when creativity happens");
			addButton(0, "Back", workshopMainMenu)
		}
		
		public function explainGemstones(): void{
			gemstonesExplained = true;
			clearOutput();
			menu();
			outputText("Shit will go here when creativity happens");
			addButton(0, "Back", workshopMainMenu)
		}
		
		public function changeMaterials(): void{
			clearOutput();
			menu();
			outputText("To Be Written\n\n");
			outputText("You need 100 of the material you wish to become to be transformed.\n\n");
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
			outputText("You cannot yet become polished\n");
			outputText("You need 200 of the material to tranistion from raw to rough.\n");
			outputText("You need 300 of the material to tranistion from rough to smooth.\n");
			outputText("Note: Moving past this step locks you to your chosen material.");
			outputText("To have channels carved into your form, you need 2 Spring Waters, 2 Sheep's Milk, 1 Ectoplasm, and a pint of God's Mead to perpare the channels.\n");
			outputText("Finally, to polish and finish your form, you need 3 Rough Lotions, 2 pieces of Coal, 1 Iron Weed and 1 Light Oil to be polished into your body,\nsealing your power and greatly increasing it.\n\n");
			outputText("Materials:\n");
			outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] +"\n");
			outputText("Granite: " + granite +"\n");
			outputText("Ebony: " + ebony +"\n");
			outputText("Alabaster: " + alabaster +"\n");
			outputText("Marble: " + marble +"\n");
			outputText("Sandstone: " + sandstone +"\n");
			switch (material){
				case ("granite"):
					if (refinement < 3){
						if (granite >= (100 * (refinement + 1))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} 
					else if (refinement == 3){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					}
					else if (refinement == 4){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					
					break;
				case ("ebony"):
					if (refinement < 3){
						if (ebony >= (100 * (refinement + 1))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 3){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 4){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				case ("alabaster"):
					if (refinement < 3){
						if (alabaster >= (100 * (refinement + 1))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 3){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 4){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				case ("marble"):
					if (refinement < 3){
						if (marble >= (100 * (refinement + 1))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 3){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 4){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				case ("sandstone"):
					if (refinement < 3){
						if (sandstone >= (100 * (refinement + 1))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else if (refinement == 3){
						if (hasChannelMats) addButton(0, "Carve Channel", refineFunc);
						else addButtonDisabled(0, "Carve Channel", "Not enough materials");
					} else if (refinement == 4){
						if (hasPolishingMats) addButton(0, "Polish Form", refineFunc);
						else addButtonDisabled(0, "Polish Form", "Not enough materials");
					}
					break;
				default:
					if (refinement < 3){
						if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= (100 * (refinement + 1))) addButton(0, "Refine", refineFunc);
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
					material = "granite";
					player.skinTone = "gray";
					player.hairColor = "gray";
					break;
				case "ebony":
					refinement = 1;
					ebony  -= 100;
					material = "ebony";
					player.skinTone = "black";
					player.hairColor = "black";
					break;
				case "alabaster":
					refinement = 1;
					alabaster -= 100;
					material = "alabaster";
					player.skinTone = "quartz white";
					player.hairColor = "quartz white";
					break;
				case "marble":
					refinement = 1;
					marble -= 100;
					material = "marble";
					player.skinTone = "light gray";
					player.hairColor = "light gray";
					break;
				case "sandstone":
					refinement = 1;
					sandstone -= 100;
					material = "sandstone";
					player.skinTone = "caramel";
					player.hairColor = "caramel";
					break;
			}
			camp.returnToCamp(36);
		}
		
		public function refineFunc(): void{
			
			if (refinement < 3){
				switch (material){
					case "granite":
						granite -= ((refinement + 1) * 100);
						break;
					case "ebony":
						ebony -= ((refinement + 1) * 100);
						break;
					case "alabaster":
						alabaster -= ((refinement + 1) * 100);
						break;
					case "marble":
						marble -= ((refinement + 1) * 100);
						break;
					case "sandstone":
						sandstone -= ((refinement + 1) * 100);
						break;
					case "stone":
						flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= ((refinement + 1) * 100);
						break;
				}
				refinement++;
				camp.returnToCampUseSixHours();
				return;
			}
			if (refinement == 3){
				player.destroyItems(consumables.S_WATER, 2);
				player.destroyItems(consumables.SHEEPMK, 2);
				player.destroyItems(consumables.ECTOPLS, 1);
				player.destroyItems(consumables.GODMEAD, 1);
				refinement++;
				camp.returnToCampUseTwelveHours();
				return;
			}
			if (refinement == 4){
				player.destroyItems(consumables.ROUGHLN, 3);
				player.destroyItems(consumables.COAL___, 2);
				player.destroyItems(consumables.IRONWEED, 1);
				player.destroyItems(consumables.LIGHTOL, 1);
				refinement++
				camp.returnToCampUseTwelveHours();
				return;
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
		
		private function trade4Gems():void {
			clearOutput();
			menu();
			outputText("So you want to trade for gems? Well, you need 3 ebonbloom per gem.");
			if (player.hasItem(useables.EBONBLO, 3)){
				addButton(0, "Amethys", trade, "amethyst");
				addButton(1, "Emerald", trade, "emerald");
				addButton(2, "Ruby", trade, "ruby");
				addButton(3, "Sapphire", trade, "sapphire");
				addButton(4, "Topaz", trade, "topaz");
			}
			else{
				addButtonDisabled(0, "Amethys", "You need at least 3 ebonbloom");
				addButtonDisabled(1, "Emerald", "You need at least 3 ebonbloom");
				addButtonDisabled(2, "Ruby", "You need at least 3 ebonbloom");
				addButtonDisabled(3, "Sapphire", "You need at least 3 ebonbloom");
				addButtonDisabled(4, "Topaz", "You need at least 3 ebonbloom");
			}
			addButton(14, "Back", workshopMainMenu);
		}
		
		private function trade(input:String):void {
			player.destroyItems(useables.EBONBLO, 3);
			switch (input){
				case "amethyst":
					inventory.takeItem(useables.AMEGEM, trade4Gems);
					break;
				case "emerald":
					inventory.takeItem(useables.EMDGEM, trade4Gems);
					break;
				case "ruby":
					inventory.takeItem(useables.RBYGEM, trade4Gems);
					break;
				case "sapphire":
					inventory.takeItem(useables.SAPPGEM, trade4Gems);
					break;
				case "topaz":
					inventory.takeItem(useables.TPAZGEM, trade4Gems);
					break;
			}
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
	}
}

