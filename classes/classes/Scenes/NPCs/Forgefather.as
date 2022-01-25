/**
	 * ...
	 * @author melyons
	 */

package classes.Scenes.NPCs	{
	
	import classes.*;
	import classes.BodyParts.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.SaveableState;
	import classes.Items.WeaponLib;
	import classes.Scenes.SceneLib;
	import classes.Scenes.NPCs.Forgefather;
	import classes.Scenes.Areas.HighMountains.TempleOfTheDivine;
	import classes.Stats.Buff;
	import classes.display.SpriteDb;
	
	use namespace CoC;
	
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
		public var templeofdivine:TempleOfTheDivine = new TempleOfTheDivine();
		
		public function stateObjectName():String {
			return "Forgefather";
		}
		
		public function resetState():void {
			statueProgress = 0;
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
			ebony = 0;
			granite = 0;
			alabaster = 0;
			marble = 0;
			sandstone = 0;
			channelInlay = "";
			gem = "";
			rarityAbsorbed = "";
			purePearlEaten = false;
			lethiciteEaten = false;
			materialsExplained = false;
		}
		
		public function saveToObject():Object {
			return {
				"statueProgress": statueProgress,
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
				"ebony": ebony,
				"granite": granite,
				"alabaster": alabaster,
				"marble": marble,
				"sandstone": sandstone,
				"channelInlay": channelInlay,
				"gem": gem,
				"rarityAbsorbed": rarityAbsorbed,
				"purePearlEaten": purePearlEaten,
				"lethiciteEaten": lethiciteEaten,
				"materialsExplained": materialsExplained
			};
		}
		
		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				statueProgress = o["statueProgress"];
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
				ebony = o["ebony"];
				granite = o["granite"];
				alabaster = o["alabaster"];
				marble = o["marble"];
				sandstone = o["sandstone"];
				channelInlay = o["channelInlay"];
				gem = o["gem"];
				rarityAbsorbed = o["rarityAbsorbed"];
				purePearlEaten = o["purePearlEaten"];
				lethiciteEaten = o["lethiciteEaten"];
				materialsExplained = o["materialsExplained"];
			} else {
				// loading from old save
				resetState();
			}
		}
		
		public function Forgefather() {
			Saves.registerSaveableState(this);
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
			outputText("Eyeing your quite solid form, he chuckles.");
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
	
		public function setGargoyleHair(newHairLength:int): void {
			hairLength = newHairLength;
			statueProgress++;
		}
		
		public function setGargoyleGender(newGender:int): void {
			gender = newGender;
			statueProgress++;
		}
		
		public function setGargoyleWings(newWings:int): void {
			wings = newWings;
			statueProgress++;
		}
		
		public function setGargoyleArms(newArms:int): void {
			arms = newArms;
			statueProgress++;
		}
		
		public function setGargoyleTail(newTail:int): void {
			tail = newTail;
			statueProgress++;
		}
		
		public function setGargoyleLowerBody(newLowerBody:int): void {
			lowerBody = newLowerBody;
			statueProgress++;
		}
		
		public function setGargoyleChest(newChest:int): void {
			chest = newChest;
			statueProgress++;
		}
		
		public function setGargoyleVagina(newVagina:int): void {
			vagina = newVagina;
			statueProgress++;
		}
		
		public function setGargoyleCock(newCock:int): void {
			cock = newCock;
			statueProgress++;
		}
		
		public function setGargoyleBalls(newBalls:int): void {
			balls = newBalls;
			statueProgress++;
		}
		
		public function getRefinement(): String {
			var level: String;
			switch (refinement)
			{
				case (0):
					level = "raw";
					break;
				
				case (1):
					level = "rough";
					break;
				
				case (2):
					level = "smooth";
					break;
				
				case (3):
					level = "carved";
					break;
				
				case (4):
					level = "polished";
					break;
				
			}
			return level;
		}
		
		public function createGargoyleState(): void {
			material = "stone";
			refinement = 0;
			player.skinTone = "gray";
			player.hairColor = "gray";
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
			outputText("Welcome to the stone-shop, what do you wnat?");
			menu();
			addButtonDisabled(0, "Talk", "Not Yet Written");
			if (materialsExplained != 1) addButton(5, "Explain Mat's", explainMaterials).hint("Ask about the various materials a gargoyle can be made of");
			else addButtonDisabled(5, "Explain Mat's", "You already know this");
			if (materialsExplained != 0) addButton(6, "Change Mat's", changeMaterials).hint("Change your body's material");
			else addButtonDisabled(6, "Change Mat's", "Change your body's material");
			addButton(7, "Refine Body", refineBody).hint("Refine your form");
			addButton(14, "Back", templeofdivine.templemainmenu);			
		}
		
		public function explainMaterials(): void{
			clearOutput();
			menu();
			outputText("This will be typed out better later but:\n\n");
			outputText("Granite - Melee (Tank)\n");
			outputText("Ebony - Melee(Dmg)\n");
			outputText("Alabaster - Magic\n");
			outputText("Marble - Soulforce\n");
			outputText("Sandstone - Ranged\n");
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
			outputText("To Be Written\n\n");
			outputText("You cannot yet become carved or polished\n");
			outputText("You need 200 of the material to tranistion from raw to rough.\n");
			outputText("You need 300 of the material to tranistion from rough to smooth.\n");
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
					refinement++;
					break;
				case "ebony":
					ebony -= ((refinement + 1) * 100);
					refinement++;
					break;
				case "alabaster":
					alabaster -= ((refinement + 1) * 100);
					refinement++;
					break;
				case "marble":
					marble -= ((refinement + 1) * 100);
					refinement++;
					break;
				case "sandstone":
					sandstone -= ((refinement + 1) * 100);
					refinement++;
					break;
				case "stone":
					flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= ((refinement + 1) * 100);
					refinement++;
					break;
			}
			camp.returnToCampUseSixHours();
		}
	}
}