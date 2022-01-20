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
				"lethiciteEaten": lethiciteEaten
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
		
	}
}