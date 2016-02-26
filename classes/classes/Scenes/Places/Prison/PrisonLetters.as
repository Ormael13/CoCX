package classes.Scenes.Places.Prison 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class PrisonLetters extends BaseContent
	{
		
		public function PrisonLetters() {}
		
		public function deliverChildWhileInPrison():Boolean {
			if (flags[kFLAGS.IN_PRISON] == 0) return false;
			if (player.vaginas.length == 0) {
				outputText("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n", false);
				player.createVagina();
				player.genderCheck();
			}
			outputText("\nIt's time! You " + player.clothedOrNakedLower("remove your [lowergarment] and ") + "sit down at one of the corners and spread your [legs]. A sudden gush of fluids erupt from your [pussy] - your water just broke. You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards. ");
			//Various scenes
			if (player.pregnancyType == PregnancyStore.PREGNANCY_MARBLE) {
				outputText("\n\nEventually, a newborn cow-girl comes out of your womb and into your cell; Marble would love to see them. You call for Mistress Elly and she rushes to your cell to see the newborn sirens. \"<i>Don't worry. I promise your newborn cow-girl will be delivered to Marble. I've ordered two imps to carry her,</i>\" she says. Two imp guards come into your cell to take away the newborn cow-girl. Hopefully you'll receive a letter.");
				outputText("\n\n<b>Some time passes...</b>");
				letterFromMarbleAfterGivingBirth();
				flags[kFLAGS.MINERVA_CHILDREN] += 2;
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA) {
				outputText("\n\nEventually, the twin sirens come out of your womb and into your cell; Minerva would love to see them. You call for Mistress Elly and she rushes to your cell to see the newborn sirens. \"<i>Don't worry. I promise your newborn sirens will be delivered to Minerva. I've ordered two imps to carry them,</i>\" she says. Two imp guards come into your cell to take away the siren twins. Hopefully you'll receive a letter.");
				outputText("\n\n<b>Some time passes...</b>");
				letterFromMinervaAfterGivingBirth();
				flags[kFLAGS.MINERVA_CHILDREN] += 2;
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) {
				outputText("\n\nEventually, the purple creature comes out of your womb and into your cell; Behemoth would love to see him. You call for Mistress Elly and she rushes to your cell to see the newborn sirens. \"<i>Don't worry. I promise your newborn behemoth will be delivered to Behemoth. I've ordered two imps to carry him,</i>\" she says. Two imp guards come into your cell to take away the newborn behemoth. Hopefully you'll receive a letter.");
				outputText("\n\n<b>Some time passes...</b>");
				letterFromMinervaAfterGivingBirth();
				flags[kFLAGS.BEHEMOTH_CHILDREN]++;
				if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 1) flags[kFLAGS.BEHEMOTH_CHILD_1_BIRTH_DAY] = model.time.days;
				if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 2) flags[kFLAGS.BEHEMOTH_CHILD_2_BIRTH_DAY] = model.time.days;
				if (flags[kFLAGS.BEHEMOTH_CHILDREN] == 3) flags[kFLAGS.BEHEMOTH_CHILD_3_BIRTH_DAY] = model.time.days;
			}
			//Post-birthing
			if (player.hipRating < 10) {
				player.hipRating++;
				outputText("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
			}
			player.knockUpForce(); //CLEAR!
			return true;
		}
		
		public function initialMessage(npcName:String):void {
			outputText("\nMistress Elly opens the door and hands you the letter. \"<i>This is for you, slave. It's from " + npcName + ",</i>\" she says as she walks out, leaving you in your cell with the letter. You open the letter and read. \n\n");
		}
		
		//------------
		// HELIA
		//------------
		//Helia gives birth
		public function letterFromHelia1():void {
			var randomNames:Array = ["Helara", "Helspawn", "Jayne", "Hesper", "Syn", "Chara"];
			var name:String = randomNames[rand(randomNames.length)];
			initialMessage("Helia");
			outputText("\"<i>Hey lover! Sorry you have to miss out on me giving birth to my daughter. She's beautiful. I've named her \"" + name + "\". I've drawn something to describe what she looks like. I would save you but I can't find the prison.  -Helia</i>\"");
			if (flags[kFLAGS.HELSPAWN_DADDY] == 0) outputText("\n\nLooking at the drawing, you notice that " + name + " has mostly the traits of Helia except that she has your eye colour.");
			else if (flags[kFLAGS.HELSPAWN_DADDY] == 1) outputText("\n\nLooking at the drawing, you notice that " + name + " isn't <b>quite</b> a salamander, though. The little girl has the same shape as her mothers, a body covered in leather scales and a brightly-flaming tail... but her scales are a midnight black, the same color as a spider's chitin.");
			else if (flags[kFLAGS.HELSPAWN_DADDY] == 2) outputText("\n\nLooking at the drawing, you notice that " + name + " isn't <b>quite</b> a salamander, though. The little girl looks mostly like her mother, with a full body of red scales and pale flesh, and a brightly flaming tail; but atop her head, rather than finned reptilian ears are a pair of perky, puppy-dog like ears.");
			outputText(" You chuckle and scratch your head. If only you've went there to witness the birth. Oh well!");
			flags[kFLAGS.HELSPAWN_NAME] = name;
			kGAMECLASS.helSpawnScene.helSpawnsSetup();
		}
		//No choices for you!
		public function noControlOverHelspawn():void {
			flags[kFLAGS.HELSPAWN_PERSONALITY] += 10;
			flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] = 1;
			outputText("\nYou have a feeling that " + (flags[kFLAGS.HELSPAWN_DADDY] == 0 ? "your" : "Hel's") + " daughter is making a slut out of herself. She is beyond your control as long as you're confined in this prison.\n");
		}
		
		//------------
		// IZMA
		//------------
		public function letterFromIzma():void {
			initialMessage("Izma");
			outputText("\"<i>Hello, my Alpha. Today I gave birth to a ");
			if (rand(100) <= 59) {
				outputText("shark-girl", false);
				flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS]++;
			}
			else {
				outputText("tigershark", false);
				flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS]++;
			}
			outputText("daughter and you should come. She has already grew up quite a bit.  -Izma.</i>\"");
		}
		
		//------------
		// KIHA
		//------------
		//Kiha gives birth to egg.
		public function letterFromKiha1(eggCounter:int):void {
			initialMessage("Kiha");
			//Increment children with Kiha.
			var maleCount:int = 0;
			var femaleCount:int = 0;
			var hermCount:int = 0;
			var genderChooser:int;
			var childList:Array = [];
			for (var i:int = 0; i < eggCounter; i++) {
				genderChooser = rand(100);
				if (genderChooser < 20) maleCount++;
				else if (genderChooser < 40) femaleCount++;
				else hermCount++;
			}
			if (maleCount > 0) {
				childList.push(num2Text(maleCount) + " " + (maleCount > 1 ? "boys" : "boy"));
				flags[kFLAGS.KIHA_CHILDREN_BOYS] += maleCount;
			}
			if (femaleCount > 0) {
				childList.push(num2Text(femaleCount) + " " + (femaleCount > 1 ? "girls" : "girl"));
				flags[kFLAGS.KIHA_CHILDREN_GIRLS] += femaleCount;
			}
			if (hermCount > 0) {
				childList.push(num2Text(hermCount) + " " + (hermCount > 1 ? "hermaphrodites" : "hermaphrodite"));
				flags[kFLAGS.KIHA_CHILDREN_HERMS] += hermCount;
			}
			outputText("\"<i>How are you doing, Doofus? I laid a clutch of " + num2Text(eggCounter) + " fertilized eggs today and I wanted you to see me but you couldn't. The eggs hatched quickly and there are " + formatStringArray(childList) + ". I'm going to train them when they grow a bit more. I could have saved you but I don't know where you're imprisoned.  -Kiha</i>\"");
		}
		//Kiha's egg hatches. (Not used anymore due to overhaul)
		/*public function letterFromKiha2():void {
			initialMessage("Kiha");
			outputText("\"<i>How are you doing, Doofus? The egg hatched and I wanted you to see but you couldn't. ");
			var genderChooser:int = rand(100);
			//Male!
			if (genderChooser < 40) {
				outputText("It's a beautiful boy ");
				flags[kFLAGS.KIHA_CHILD_LATEST_GENDER] = 1;
				flags[kFLAGS.KIHA_CHILDREN_BOYS]++;
			}
			//Female!
			else if (genderChooser < 80) {
				outputText("It's a beautiful girl ");
				flags[kFLAGS.KIHA_CHILD_LATEST_GENDER] = 2;
				flags[kFLAGS.KIHA_CHILDREN_GIRLS]++;
			}
			//Hermaphrodite!
			else {
				outputText("It's a beautiful hermaphrodite ");
				flags[kFLAGS.KIHA_CHILD_LATEST_GENDER] = 3;
				flags[kFLAGS.KIHA_CHILDREN_HERMS]++;
			}
			outputText(" and " + (genderChooser < 40 ? "he" : "she") + " will definitely make a great warrior. I hope you'll come someday.  -Kiha</i>\"");
		}*/
		//Kiha tells story.
		public function letterFromKiha3():void {
			initialMessage("Kiha");
			outputText("\"<i>How are you doing, Doofus? I told my kids about the story and they were excited. They miss you and they want to see you. Please come back. You're my one and only Idiot.  -Kiha</i>\"");
		}
		//Kiha's child grows up.
		public function letterFromKiha4():void {
			initialMessage("Kiha");
			outputText("\"<i>How are you doing, Doofus? My children is quite the warrior now. I've taught them my fighting techniques and they put on quite the flame show! It's too bad you didn't get to see them. They miss you and they wants to see you. Please come back. You're my one and only Idiot.  -Kiha</i>\"");
		}
		
		//------------
		// MARBLE
		//------------
		public function letterFromMarble():void {
			initialMessage("Marble");
			var boyOrGirl:Boolean; //true for boy, false for girl.
			if (flags[kFLAGS.MARBLE_PURIFIED] > 0 && rand(2) == 0) {
				flags[kFLAGS.MARBLE_BOYS]++;
				boyOrGirl = true;
			}
			else {
				boyOrGirl = false;
			}
			outputText("\"<i>Sweetie, I'm sorry you could not come here. I've gave birth recently and I'd love you to come and see our new " + (boyOrGirl ? "son" : "daughter") + ". I don't know where the prison is so you're on your own until you can escape. I'm really sorry, sweetie.  -Marble</i>\"");
			flags[kFLAGS.MARBLE_KIDS]++;
		}
		
		public function letterFromMarbleAfterGivingBirth():void {
			initialMessage("Marble");
			var boyOrGirl:Boolean; //true for boy, false for girl.
			if (flags[kFLAGS.MARBLE_PURIFIED] > 0 && rand(2) == 0) {
				flags[kFLAGS.MARBLE_BOYS]++;
				boyOrGirl = true;
			}
			else {
				boyOrGirl = false;
			}
			outputText("\"<i>Sweetie, thank you for caring for my " + (boyOrGirl ? "son" : "daughter") + ". I don't know where the prison is so you're on your own until you can escape. I'm really sorry, sweetie.  -Marble</i>\"");
		}
		//------------
		// SOPHIE
		//------------
		
		//------------
		// URTA
		//------------
		
		//------------
		// BEHEMOTH
		//------------
		public function letterFromBehemothAfterGivingBirth():void {
			initialMessage("Behemoth");
			outputText("\"<i>Thank you " + player.mf("dude", "chick") + ". I have a new son now and he's helping to keep me company. I could save you but I don't know where the prison is. It's awfully hidden even though I've explored Mareth.  -Behemoth</i>\"");
		}
		
		//------------
		// MINERVA
		//------------
		public function letterFromMinerva():void {
			initialMessage("Minerva");
			outputText("\"<i>Darling, I gave birth to a twin today. They're little and beautiful! They want to see you. Sorry I can't come to save you as I have to look after my daughters.  -Minerva</i>\"");
		}
		
		public function letterFromMinervaAfterGivingBirth():void {
			initialMessage("Minerva");
			outputText("\"<i>Thank you darling for taking good care. I feel like a mother again even though I got you pregnant. I would love to come and save you but I have daughters to look after. They want to see you. Sorry I can't come.  -Minerva</i>\"");
		}
	}

}