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
	import classes.Stats.Buff;
	import classes.display.SpriteDb;
	
	public class Forgefather extends NPCAwareContent implements SaveableState	{
		
<<<<<<< HEAD
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
		public var templeofdivine:TempleOfTheDivine = new TempleOfTheDivine();
=======
		public static var hairLength:int
		public static var gender:int
		public static var wings:int
		public static var arms:int
		public static var tail:int
		public static var lowerBody:int
		public static var chest:int
		public static var vagina:int
		public static var cock:int
		public static var balls:int
		public static var material:String
		public static var refinement:int
		public static var channelInlay:String
		public static var gem:String
		public static var rarityAbsorbed:String
		public static var purePearlEaten:Boolean
		public static var lethiciteEaten:Boolean
>>>>>>> parent of ddd361217 (Garg)
		
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
			material = "";
			refinement = 0;
			channelInlay = "";
			gem = "";
			rarityAbsorbed = "";
			purePearlEaten = false;
			lethiciteEaten = false;
<<<<<<< HEAD
			materialsExplained = false;
			refinementExplained = false;
=======
>>>>>>> parent of ddd361217 (Garg)
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
				"material": material,
				"refinement": refinement,
				"channelInlay": channelInlay,
				"gem": gem,
				"rarityAbsorbed": rarityAbsorbed,
				"purePearlEaten": purePearlEaten,
<<<<<<< HEAD
				"lethiciteEaten": lethiciteEaten,
				"materialsExplained": materialsExplained,
				"refinementExplained": refinementExplained
=======
				"lethiciteEaten": lethiciteEaten
>>>>>>> parent of ddd361217 (Garg)
			};
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
				material = o["material"];
				refinement = o["refinement"];
				channelInlay = o["channelInlay"];
				gem = o["gem"];
				rarityAbsorbed = o["rarityAbsorbed"];
				purePearlEaten = o["purePearlEaten"];
				lethiciteEaten = o["lethiciteEaten"];
<<<<<<< HEAD
				materialsExplained = o["materialsExplained"];
				refinementExplained = o["refinementExplained"];
=======
>>>>>>> parent of ddd361217 (Garg)
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
			outputText("Eyeing your quite solid form, he chuckles."
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
	
		public function setGargoyleHair(hairLength:int): void {
			this.hairLength = hairLength;
		}
		
		public function setGargoyleGender(gender:int): void {
			this.gender = gender;
		}
		
		public function setGargoyleWings(wings:int): void {
			this.wings = wings;
		}
		
		public function setGargoyleArms(arms:int): void {
			this.arms = arms;
		}
		
		public function setGargoyleTail(tail:int): void {
			this.tail = tail;
		}
		
		public function setGargoyleLowerBody(lowerBody:int): void {
			this.lowerBody = lowerBody;
		}
		
		public function setGargoyleLowerBody(lowerBody:int): void {
			this.lowerBody = lowerBody;
		}
		
		public function setGargoyleChest(chest:int): void {
			this.chest = chest;
		}
		
		public function setGargoyleVagina(vagina:int): void {
			this.vagina = vagina;
		}
		
		public function setGargoyleCock(cock:int): void {
			this.cock = cock;
		}
		
		public function setGargoyleBalls(balls:int): void {
			this.balls = balls;
		}
		
		public function createGargoyleState(): void {
			player.skinTone = "dark gray";
			player.hairColor = "dark gray";
			player.skin.setBaseOnly({type:Skin.STONE});
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
			
			switch (wings) {
				case 1:
					player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
					break;
				case 2:
					player.wings.type = Wings.FEATHERED_LARGE;
					break;
			}
			
			switch (lower) {
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
		
<<<<<<< HEAD
		public function workshopMainMenu(): void{
			clearOutput();
			outputText("Welcome to the stone-shop, what do you want?");
			menu();
			addButtonDisabled(0, "Talk", "Not Yet Written");
			addButton(1, "Explain Mat's", explainMaterials).hint("Ask about the various materials a gargoyle can be made of.");
			addButton(2, "Explain Refine", explainRefinement).hint("Ask about the various levels of refinement a gargoyle can have.");
			if (materialsExplained != false) addButton(6, "Change Mat's", changeMaterials).hint("Change your body's material.");
			else addButtonDisabled(6, "Change Mat's", "Maybe you should learn what the materials do first?");
			if (refinementExplained != false) addButton(7, "Refine Body", refineBody).hint("Refine your form.");
			else addButtonDisabled(7, "Refine Body", "Maybe you should learn about refining your form first?");
			addButton(14, "Back", templeofdivine.templemainmenu);			
		}
		
		public function explainMaterials(): void{
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
			outputText("To carve ritual channels into a smooth form gargoyle, you will need ERROR: File Not Found.\n");
			outputText("To finish and polish a gragoyles form, you will need ERROR:Gargoyle-Gate Case not decided.\n");
			addButton(0, "Back", workshopMainMenu)
		}
		
		public function changeMaterials(): void{
			clearOutput();
			menu();
			outputText("To Be Written\n\n");
			outputText("You need 100 of the material you wish to become to be transformed.");
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
			outputText("You cannot yet become carved or polished\n");
			outputText("You need 200 of the material to tranistion from raw to rough.\n");
			outputText("You need 300 of the material to tranistion from rough to smooth.\n");
			outputText("Note: Moving past this step locks you to your chosen material.");
			outputText("To have channels carved into your form, you need ERROR NOT DECIDED to perpare the channels.\n");
			outputText("Finally, to polish and finish your form, you need SUPER ERROR NOT FOUND to be polished into your body, sealing your power and greatly increasing it.\n\n");
			outputText("Materials:\n\n");
			outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] +"\n");
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
					} else addButtonDisabled(0, "Refine", "Not implmented yet");
					break;
				case ("ebony"):
					if (refinement < 2){
						if (ebony >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else addButtonDisabled(0, "Refine", "Not implmented yet");
					break;
				case ("alabaster"):
					if (refinement < 2){
						if (alabaster >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else addButtonDisabled(0, "Refine", "Not implmented yet");
					break;
				case ("marble"):
					if (refinement < 2){
						if (marble >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else addButtonDisabled(0, "Refine", "Not implmented yet");
					break;
				case ("sandstone"):
					if (refinement < 2){
						if (sandstone >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else addButtonDisabled(0, "Refine", "Not implmented yet");
					break;
				default:
					if (refinement < 2){
						if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= (100 * (refinement + 2))) addButton(0, "Refine", refineFunc);
						else addButtonDisabled(0, "Refine", "Not enough materials");
					} else addButtonDisabled(0, "Refine", "Not implmented yet");
					break;
			}
			addButton(14, "Back", workshopMainMenu);
		}
		
		public function changeMatFunc(mat:String): void{
			switch (mat){
				case "granite":
					refinement = 0;
					granite -= 35;
					material = "granite";
					player.skinTone = "gray";
					player.hairColor = "gray";
					break;
				case "ebony":
					refinement = 0;
					ebony  -= 35;
					material = "ebony";
					player.skinTone = "black";
					player.hairColor = "black";
					break;
				case "alabaster":
					refinement = 0;
					alabaster -= 35;
					material = "alabaster";
					player.skinTone = "albino";
					player.hairColor = "albino";
					break;
				case "marble":
					refinement = 0;
					marble -= 35;
					material = "marble";
					player.skinTone = "light gray";
					player.hairColor = "light gray";
					break;
				case "sandstone":
					refinement = 0;
					sandstone -= 35;
					material = "sandstone";
					player.skinTone = "caramel";
					player.hairColor = "caramel";
					break;
			}
			camp.returnToCamp(36);
		}
		
		public function refineFunc(): void{
			
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
		
=======
>>>>>>> parent of ddd361217 (Garg)
	}
}