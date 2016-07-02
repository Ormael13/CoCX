package classes.Scenes.Places.Bazaar 
{
	import classes.GlobalFlags.*;
	import classes.*;
	/**
	 * The Black Cock by Foxxling
	 * @author Kitteh6660
	 */
	public class BlackCock extends BazaarAbstractContent
	{
		
		public function BlackCock() 
		{
			
		}
		
		//Will eventually be used to display sprites.
		public function displayAnitaSprite():void {
			//Anita's sprite code goes here
		}
		public function displayAndySprite():void {
			//Andy's sprite code goes here
		}
		public function displayHarrySprite():void {
			//Harry's sprite code goes here
		}
		public function displayFridaSprite():void {
			//Frida's sprite code goes here
		}
		
		private function applyAndysSmokeEffect():void {
			if (player.findStatusEffect(StatusEffects.AndysSmoke) >= 0) {
				if (player.statusEffectv2(StatusEffects.AndysSmoke) > -15) { //Maximum speed loss is -15.
					player.addStatusValue(StatusEffects.AndysSmoke, 2, -5);
					dynStats("spe", -5);
				}
				if (player.statusEffectv3(StatusEffects.AndysSmoke) < 15) { //Maximum intelligence boost is 15.
					player.addStatusValue(StatusEffects.AndysSmoke, 3, 5);
					dynStats("int", 5);
				}
				player.changeStatusValue(StatusEffects.AndysSmoke, 1, 8);
			}
			else {
				player.createStatusEffect(StatusEffects.AndysSmoke, 8, -5, 5, 0);
				dynStats("spe", -5, "int", 5);
			}
			
		}
		
		public function blackCockDescription():void {
			if (isHolidays()) outputText("\n\nThere is also a large marquee-style tent made with black canvas. Smoke rises out of an open flap in the rear. There is a wooden sign next to the front flap depicting a small black rooster; beneath its yellow feet the words \"The Black Cock\" are etched into the old sign. Around the sign there is a festive Christmas wreath with flickering candles. The smell of greasy food and sweets wafts out of the open entrance.");
			else outputText("\n\nThere is also a large marquee-style tent made with black canvas. Smoke rises from a metal pipe sticking out of a hole in the top. You see a wooden sign next to the front flap depicting a small black rooster; beneath its yellow feet the words \"The Black Cock\" are etched into the old sign. The smell of greasy food and sweets wafts out of the open entrance.");
		}
		
		public function enterTheBlackCock():void {
			clearOutput();
			spriteSelect(-1);
			outputText(images.showImage("location-bazaar-theblackcock"));
			//General descriptor
			outputText("You enter the tent to find much of what you'd expect: A bunch of wooden tables and a sectioned-off portion in the back where you presume the cooking happens. Next to the flap leading into the kitchen there is a big \"keep out\" sign stuck into the ground through the tent's bottom. ");
			if (isHalloween()) outputText("The interior is lit by several carved Jack O'Lanterns on each table, emitting a warm glow from flickering flames that cast dancing shapes along the walls.");
			else if (isHolidays()) outputText("The interior is lit by a combination of black rooster-shaped candles on each table and a large globe sitting in the center of the tent. It looks like they just dumped the glowing creamy fluid from all the small globes into a larger one. You also see a big festive tree tucked into the corner decorated with glowing frosting… oh... wait, that's not frosting.");
			else outputText("The interior is lit by what looks like round globes on each table, each of which is filled with a thick creamy liquid that emits a pale glow.");
			//Staff descriptor
			if (flags[kFLAGS.BLACK_COCK_MET_ANITA] == 0) outputText("\n\nThere is a harpy lady sitting next to a sign promising she'll sing if you pay her 5 gems.");
			else outputText("\n\nAnita sits next to a sign promising she'll sing for you if you pay her 5 gems.");
			
			if (flags[kFLAGS.BLACK_COCK_MET_ANDY] == 0) outputText("\n\nThere is an odd satyr going about the place serving customers.");
			else outputText("\n\nAndy walks around the tables serving customers.");
			
			if (flags[kFLAGS.BLACK_COCK_MET_FRIDA] == 0) outputText("\n\nThere is also an echidna-morph leaning on a counter towards the back of the tent.");
			else outputText("\n\nFrida leans on a counter towards the back of the tent, looking a little bored.");
			//General menu
			menu();
			addButton(0, "Check Menu", checkFoodMenu);
			addButton(1, "Staff", checkStaff);
			addButton(2, "Patrons", checkPatrons);
			addButton(14, "Leave", bazaar.enterTheBazaarAndMenu);
		}
		
		//------------
		// FOOD
		//------------
		private function checkFoodMenu():void {
			clearOutput();
			if (player.isBiped() || player.isGoo()) outputText("You sit on one of the vacant chairs surrounding a table.");
			else outputText("You " + (player.isNaga() ? "slither" : "walk") + " to a vacant spot not occupied by any chair.");
			outputText(" Someone has already left a menu for you to look through. How nice!");
			menu(); //Incredibly Lame Pun
			outputText("\n\n<b><u>Food to Go</u></b>");
			addFoodToGo(consumables.GOB_ALE, 5);
			addFoodToGo(consumables.IMPFOOD, 3);
			addFoodToGo(consumables.SATYR_W, 10);
			addFoodToGo(consumables.FR_BEER, 5);
			addFoodToGo(consumables.GODMEAD, 100);
			
			outputText("\n\n<b><u>Special Meals</u></b>");
			addFoodPlate("Rhino Steak", 10, "Despite the name, it doesn't come from any rhinoceros or a rhino-morph. We can guarantee you that no rhinoceros were harmed in the production of this food.\n\nDISCLAIMER: We are not responsible if you find yourself altered.", "When the satyr brings you your steak you can tell from the way it sizzles that it just came off the grill. You take a fork and knife and eat the succulent steak piece by juicy piece, enjoying the explosion of flavor as the tender, juicy meat disappears into your mouth and fills your belly.");
			addFoodPlate("Echidna Cake", 10, "Try our special cake, a favorite among the echidna-morphs!\n\nDISCLAIMER: We are not responsible if you find yourself altered.", "You waste no time digging into the cake and it is absolutely delicious! Within moments every savory morsel is gone. Despite the generous size of the piece you were given you can't help wishing that there had been more.");
			addFoodPlate("Giant Burger", 8, "Want something a bit modern and delicious? We're pleased to offer a large burger fit for a king!", "The satyr brings you a huge burger piled high with meat and bacon and more meat. A generous helping of crisp tomatoes and a single leafy piece of lettuce join in the fray along with a big thick onion ring. When you bite it you taste spices and sauce and cheese along with the meat and veggies you can see. Each bite is a tidal wave of flavor. When you've finished you feel satisfied and a little heavier.");
			addFoodPlate("P. Potatoes", 5, "It's a party! Try these special potatoes for a guaranteed blast of a taste!", "When the satyr brings you your plate the food on it is still sizzling. Your party potatoes sit alongside sliced bits of beef and wedges of green, red and yellow peppers. Its a messy meal and when you're done you feel a little heavier. With a belch you realize that this is going to go straight to your butt.");
			addFoodPlate("Spicy Chilli", 7, "Not for the faint of heart! Try a delicious chili infused with spicy peppers, measured at 100,000 Scoville heat units! We'll gladly offer you a cup of milk to extinguish the inferno in your mouth after you eat these.", "When the satyr brings you your plate just the smell of the bright red chilli burns. Your waiter sits down a cup of white liquid and you begin to chow down. With a mouth full of fiery flavor and your [face] contorted in a grimace of triumph and pain you finish the flavorful chili from hell and wash it all down with the glass of what you find is simply ice cold milk. Once you finish the chilli you feel a little heavier and realize that it's going to go straight to your hips.");
			addFoodPlate("Prot. Shake", 10, "Need something a bit healthy? Thanks to our popular demand, we now offer protein shakes!", "When the satyr brings you your shake he tells you it's his favorite thing in the restaurant. The icy drink is both refreshing and filling. When you're done you feel a slight tingle throughout your body. With a pinch you confirm your suspicions:, you've gotten slightly thinner and a bit more muscular.");
			addFoodPlate("Funnel Cake", 4, "Try our famous dessert, the funnel cake. It's finger-licking good!", "When the satyr brings you your fried cake he sets the hot meal in front of you before whipping out a small shaker and pouring powdered sugar over the top. The meal is tasty and sweet like you expected. Once you're done you have to admit you feel a little heavier.");
			if (isThanksgiving() || isHolidays()) {
				outputText("\n\n<b><u>Holiday Meals</u></b>");
				addFoodPlate("R.Tk. Dinner", 10, "Only for a limited time!\n\nEnjoy a traditional meal commonly eaten during Thanksgiving and Christmas.", "The satyr brings you a big steaming plate piled high with turkey, sliced brisket, hot stuffing, mashed potatoes, green beans with shallot crisps, yams and a slice of cheese cake. He also brings you a glass of sparkling wine to go with your meal. It all smells delicious and you dig in. Once your food is gone you take a swig of the delicious juice and finish with a hearty belch. That was good.");
				addFoodPlate("G.Ham Dinner", 10, "Only for a limited time!\n\nEnjoy a traditional meal commonly eaten during Thanksgiving and Christmas.", "The satyr brings you a big steaming plate piled high with slices of honey glazed ham, barbecued ribs, cranberry sauce, yams, macaroni and cheese and a slice of pumpkin pie. He also brings you a glass of sparkling wine to go with your meal. It all smells delicious and you dig in. Once your food is gone you take a swig of the delicious juice and finish with a hearty belch. That was good.");
			}
			if (isAprilFools()) {
				outputText("\n\n<b><u>Strange Meals</u></b>");
				addFoodPlate("MysteryMeat", 12, "This type of meat is unlike other meat. Every bite tastes different! Puzzle your taste buds!\n\nDISCLAIMER: We are not responsible for any random transformations it may have caused to you.", "When the satyr brings you your food you look at the unassuming block of hot meat with a curious expression. When you begin to eat it you notice that even the taste changes with every spoonful. Once you're done you begin to feel a little weird.");
			}
			addButton(14, "Back", enterTheBlackCock);
		}
		
		private function addFoodToGo(item:ItemType, price:int):void {
			var button:int = 0;
			for (var i:int = 0; i < 14; i++) {
				if (buttonIsVisible(i)) button++;
			}
			outputText("\n" + capitalizeFirstLetter(item.longName) + " - " + price + " gems");
			addButton(button, item.shortName, orderFoodToGo, item, price);
		}
		
		private function orderFoodToGo(item:ItemType, gemCost:int):void {
			clearOutput();
			if (player.gems < gemCost) {
				outputText("<b>You do not have sufficient gems to order that. Damn!</b>");
				doNext(checkFoodMenu);
				return;
			}
			player.gems -= gemCost;
			statScreenRefresh();
			inventory.takeItem(item, checkFoodMenu);
		}
		
		private function addFoodPlate(foodName:String, gems:int, tooltip:String, foodEatDesc:String):void {
			var button:int = 0;
			for (var i:int = 0; i < 14; i++) {
				if (buttonIsVisible(i)) button++;
			}
			var header:String = "";
			switch(foodName) {
				case "P. Potatoes":
					header = "Party Potatoes";
					break;
				case "Prot. Shake":
					header = "Protein Shake";
					break;
				case "R.Tk. Dinner":
					header = "Roast Turkey Dinner";
					break;
				case "G.Ham Dinner":
					header = "Glazed Ham Dinner";
					break;
				case "Mystery Meat":
					header = "Mystery Meat";
					break;
				default:
			}
			outputText("\n" + (header != "" ? header : foodName) + " - " + gems + " gems");
			addButton(button, foodName, orderFoodPlate, foodName, gems, foodEatDesc, tooltip, header);
		}
		
		private function orderFoodPlate(foodName:String, gemCost:int, foodEatDesc:String):void {
			clearOutput();
			if (player.gems < gemCost) {
				outputText("<b>You do not have sufficient gems to order that. Damn!</b>");
				doNext(checkFoodMenu);
				return;
			}
			if ((player.hunger >= 90 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.findStatusEffect(StatusEffects.Fullness) >= 0 && flags[kFLAGS.HUNGER_ENABLED] == 0)) {
				outputText("<b>You are too full to consider eating that.</b>");
				doNext(checkFoodMenu);
				return;
			}
			player.gems -= gemCost;
			statScreenRefresh();
			eatFoodNomNom(foodName, foodEatDesc);
		}
		
		private function eatFoodNomNom(foodName:String, foodEatDesc:String):void {
			outputText(foodEatDesc);
			switch(foodName) {
				case "Rhino Steak":
					player.refillHunger(40);
					rhinoTFs();
					break;
				case "Echidna Cake":
					player.refillHunger(40);
					echidnaTFs();
					break;
				case "Giant Burger":
					player.refillHunger(70);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 4);
					if (rand(3) == 0 && player.hairLength < 16) player.hairLength += 0.5;
					break;
				case "P. Potatoes":
					player.refillHunger(70);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 2);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0 || (rand(2) == 0 && player.hunger >= 80)) player.buttRating++;
					break;
				case "Spicy Chilli":
					player.refillHunger(60);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 1);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0 || (rand(2) == 0 && player.hunger >= 80)) player.hipRating++;
					break;
				case "Prot. Shake":
					player.refillHunger(30);
					player.modTone(100, 1);
					player.modThickness(0, -1);
					break;
				case "Funnel Cake":
					player.refillHunger(50);
					player.modTone(0, 2);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 1);
					break;
				case "R.Tk. Dinner":
					if (player.hunger < 60) player.hunger = 60;
					player.refillHunger(40);
					player.modTone(0, 5);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 2);
					break;
				case "G.Ham Dinner":
					if (player.hunger < 60) player.hunger = 60;
					player.refillHunger(40);
					player.modTone(0, 2);
					if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 5);
					break;
				case "MysteryMeat":
					player.refillHunger(50);
					mysteryMeatTFs();
					break;
				default:
					player.refillHunger(50);
			}
			if (player.findStatusEffect(StatusEffects.Fullness) < 0) player.createStatusEffect(StatusEffects.Fullness, 4, 0, 0, 0);
			else player.changeStatusValue(StatusEffects.Fullness, 1, 4);
			doNext(camp.returnToCampUseOneHour);
		}
		
		//------------
		// STAFF
		//------------
		private function checkStaff():void {
			clearOutput();
			menu();
			//Anita Roswell
			if (flags[kFLAGS.BLACK_COCK_MET_ANITA] == 0) {
				outputText("There is a scantily clad harpy with pale rosy skin whose feathers and short-styled hair are both a dirty blond color. She wears a blue flannel shirt with long sleeves, the bottom of which is tied in the front, pushing her soft milky white tits together and showing off her trim and lightly-toned stomach. Her blue pants are cut off, showing off a pair of stunning legs as well as a firm, pert rump. She is apparently some sort of singer, as the sign next to her promises a song for 5 gems.\n\n");
				addButton(0, "Harpy", meetAnitaRoswell);
			}
			else {
				outputText("You see Anita Roswell, the sexy slutty songbird of The Black Cock. She is wearing her usual breast-exposing front-tied blue flannel and tight tiny cut-off pants to show off her athletic yet feminine figure. The sign next to her promises a song for 5 gems.\n\n");
				addButton(0, "Anita", meetAnitaRoswell);
			}
			//Andy Mathis
			if (flags[kFLAGS.BLACK_COCK_MET_ANDY] == 0) {
				outputText("The waiter is a Satyr. Unlike the table full of his pot-bellied kinsmen his waist is trim and his tall-standing horns are polished to a shine. Curly dark brown hair frames his face but fails to conceal his pointy ears. His goatee is neatly trimmed and tastefully styled. From the look of things he takes great pride in his appearance. He wears nothing more than a simple black shirt with the sleeves cut off; his heavy balls are visible just below the sheath that conceals his presumably dog-like manhood.\n\n");
				addButton(1, "Satyr", meetAndyMathis);
			}
			else {
				outputText("You also see Andy Mathis, the waiter at The Black Cock. Unlike the table full of his beer-bellied kinsmen his waist is trim and his tall-standing horns are polished. His masculine face is framed by a cloud of curly brown hair. His goatee is also neatly trimmed and tastefully styled. He wears nothing more than a simple black shirt with the sleeves cut off; his heavy balls are visible just below the sheath that conceals his dog-like manhood.\n\n")
				addButton(1, "Andy", meetAndyMathis);
			}
			//Harry Roswell
			if (flags[kFLAGS.BLACK_COCK_MET_HARRY] == 0) {
				outputText("You see the sign saying \"Keep Out\" leading to the back. You assume the cook is back there.\n\n");
				addButton(2, "Sneak", meetHarryRoswell, null, null, null, "Sneak into the kitchen?");
			}
			else {
				outputText("You see the sign saying \"Keep Out\" leading to the back portion of the tent. You know that Harry Roswell, the beefy rhino-morph cooking the food, is back there and doesn't mind you ignoring the sign.\n\n");
				addButton(2, "Harry", meetHarryRoswell);
			}
			//Frida
			if (flags[kFLAGS.BLACK_COCK_MET_FRIDA] == 0) {
				outputText("Behind a counter near the back is a busy echidna-morph. You see her wiping off the top of the counter and drying a glass from time to time. Her hair is an afro of quills that sits like a spiky cloud upon her crown. She has a long, thin snout and a lengthy tongue that occasionally flits out from between her lips. It has to be at least a foot long. She has a pair of generous breasts, likely C-cup. When she turns around, you can see that she is wearing nothing under her apron except for a pair of really short shorts, but even they ride low below the waist, revealing her tiny stump of a tail and a good portion of her crack. On her section of the counter, there is a glass cake stand holding a beautifully-crafted cake.");
				addButton(3, "Echidna", meetFrida);
			}
			else {
				outputText("Behind the counter you see Frida, going about her business as usual. When the hard-working girl notices you she gives you a brief wave and a quick smile before returning to tidying up her area.");
				addButton(3, "Frida", meetFrida);
			}
			addButton(14, "Back", enterTheBlackCock);
		}
		
		//Anita Roswell
		//------------
		private function meetAnitaRoswell():void {
			clearOutput();
			displayAnitaSprite();
			outputText(images.showImage("anita-intro"));
			if (flags[kFLAGS.BLACK_COCK_MET_ANITA] == 0) {
				outputText("You catch the sky blue eyes of the songbird and summon her to your table with a nod. As she walks towards you her hard gait causes her tits, twin B-cups by the looks of it, to bounce up and down in her tied and knotted flannel shirt.");
				outputText("\n\n\"<i>Well howdy there...?</i>\" She says as bubbly as can be with a weird hickish accent. Hearing the question in her voice, you tell her your name.");
				outputText("\n\nShe begins talking fast, \"<i>Well shucks, I don't believe I've had the pleasure. It's nice to meet you [name], I'm Anita Roswell, my husband Harry owns the place and he's also the cook. Now did you wanna get a song or is this a more social visit?</i>\" Her eyes make a round trip, taking in your full form before she licks her lips. Wait, didn't she just say she was married?");
				flags[kFLAGS.BLACK_COCK_MET_ANITA] = 1;
			}
			else {
				outputText("You catch Anita's eye and wave her over. With a big smile she struts, her soft tits rising and falling with every step, toward your table. She leans in, proudly displaying her bust and crushing them against your table as she smiles big and says, \"<i>Well if it ain't my favorite customer, [name]. What can I do ya for, hun?</i>\"");
			}
			if (flags[kFLAGS.CODEX_ENTRY_HARPIES] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_HARPIES] = 1;
				outputText("\n\n<b>New codex entry unlocked: Harpies!</b>\n\n");
			}
			menu();
			addButton(0, "Song", listenToAnitaSong, null, null, null, "Listen to Anita's performance. This will cost you five gems.");
			if (player.lust >= 33) addButton(1, "Sex", rompUpAnitaOffer);
			else addButtonDisabled(1, "Sex", "You aren't aroused enough to do that.");
			addButton(4, "Nevermind", nevermindToAnita);
		}
		
		private function nevermindToAnita():void {
			clearOutput();
			outputText("You decide not to take the slutty songbird up on her offer… either of them. You tell her you were just saying hi and she pouts slightly, \"<i>Well, if you need anything,</i>\" She leans in close and says in a sultry whisper, \"<i>... and I mean anything,</i>\" her eyes glance meaningfully towards your crotch, \"<i>...you don't hesitate to call me back over.</i>\"");
			outputText("\n\nThen she leaves, walking back and swinging her ass every which way as she heads back to her stool.");
			doNext(checkStaff);
		}
		
		private function listenToAnitaSong():void {
			clearOutput();
			outputText(images.showImage("anita-song"));
			if (player.gems < 5) {
				outputText("You realize you're a bit short on gems. \"<i>Come back when you have more gems, ya hear?</i>\" Anita says.");
				doNext(enterTheBlackCock);
				return;
			}
			outputText("You decide that you'd like to hear the little songbird sing. When you hand her the gems and tell her to give you a show she takes them with a lick of her soft pink lips. She heads back to her chair and, with a glance to make sure you're still watching, leans over it.");
			outputText("\n\nShe bends at the waist, long silky smooth legs ending in a pert heart shaped ass. She even moans softly as she makes a show of putting the gems in the little locked chest she has next to her stool, her lifted tail feathers fanning in and out like flashing lights pointing to her fuckable rump. She lingers there in that fuck me pose for a short while apparently counting and recounting the money. When the money is taken care of she hops up, her jiggling tits bouncing on the spot as she takes the stage which is basically the area between her stool and the tables.");
			outputText("\n\nYou can't help but smile as Anita comically waves and yells for everybody's attention before starting her number.");
			switch(rand(2)) {
				case 0: //Squirtin Like a Fountain
					outputText("\n\n\"<i>Now ya'll know I'm pleased as a mouse wit a room full of cheese to be singing for ya'll good folk this evenin. Now this'un here's a real classic. You good folks are more'in welcome to sing along if ya know the words.</i>\" With that she starts bouncing around. As she does you hear music coming from the glowing globe of thick creamy liquid, looking to find ripples in its surface as the odd music fills the tent. It honestly sounds as if some guys are vigorously playing a piano, a violin and a set of drums.");
					outputText("\n\n\"<i>oooooh, \nShe'll be squirtin' like a fountain when she cuuuums \nShe'll be squirtin' like a fountain when she cuuuums \nShe'll be squirtin' like a fountain \nShe'll be squirtin' like a fountain \nShe'll be squirtin' like a fountain when she cuuuums</i>\"");
					outputText("\n\nThe tune is similar to a children's song you remember from Ingnam but you gotta admit you like this version a lot better. Anita bounces on the spot and kicks her perfect legs up in the air as she sings, the Patrons around you occasionally shouting dirty comments as they slowly get into the swing of things.");
					outputText("\n\n\"<i>oooooh \nShe'll be ridin' six wide horse cocks when she cuuums \nShe'll be ridin' six wide horse cocks when she cuuums \nShe'll be ridin' six wide horse cocks \nShe'll be ridin' six wide horse cocks \nShe'll be ridin' six wide horse cocks when she cuuums</i>\"");
					outputText("\n\nThe crowd around you jeers and whistles. Anita begins to clap and they follow her lead, she's quite the showgirl. Anita bounces around, pleased as punch and obviously enjoying the attention as she jiggles and dances all over the place.");
					outputText("\n\n\"<i>We'll all cum out ter eat ‘er ‘til she cuuums \nWe'll all cum out ter eat ‘er ‘til she cuuums \nWe'll all cum out ter eat ‘er \nOh, We'll all cum out ter eat ‘er \nI said we'll all cum out ter eat ‘er ‘til she cuuums</i>\"");
					outputText("\n\nYou find yourself clapping and hollering with the rest of the patrons, a big smile on your [face] as the songbird looks down at you. Her big blue eyes are brightly lit stars above a bitten lip as she does a sexy little shimmy, causing the crowd to cheer harder. The music gets louder.");
					outputText("\n\n\"<i>She'll be soaked an' sore an' smilin when she cuuums \nShe'll be soaked an' sore an' smilin when she cuuums \nShe'll be soaked an' sore an' smilin \nShe'll be soaked an' sore an' smilin \nShe'll be soaked an sore an' smilin when she cuuums</i>\"");
					outputText("\n\nThe songbird's dirty blond wings spread, each flap sending an undulation through her soft tits and enticing ass as she takes to the air, wings beating hard as she hovers in place while spinning around. The place explodes into applause and wolf whistles as the Anita shows that those sexy wings aren't just for show.");
					outputText("\n\n\"<i>She'll be squirtin' like a fountain when she cuuuums \nShe'll be squirtin' like a fountain when she cuuuums \nShe'll be squirtin' like a fountain \nShe'll be squirtin' like a fountain \nShe'll be squirtin' like a fountain when she cuuuuuuuuuuuuuuuuuuuuuums.</i>\"");
					outputText("\n\nExplosive applause rips through the tent and you find yourself clapping and hollering along with the crowd. Despite the repetitive, simplistic nature of the song you have to admit you enjoyed yourself. As the applause dies down you realize that you feel a little riled up now.");
					dynStats("lus", 10, "resisted", false);
					dynStats("lus", (player.lib / 5) + (player.cor / 10));
					break;
				case 1: //Rockin Robin
					outputText("\n\nAnita smiles as she looks out over the customer filled tables, \"<i>Now this one is one of my favorites because it was written about my great, great, great grandmother. She's the one who left the mountain and brought her nest down to the plains.</i>\" You hear a wolf whistle and turn to find a beer bellied satyr giving Anita a wink, \"<i>Now if ya know the words feel free to sing along.</i>\" With that she starts bouncing around. As if on cue the light giving bowls of creamy liquid release a funky beat. Once it starts Anita twirls and begins belting out a song in a voice too big for her tiny frame.");
					outputText("\n\n\"<i>She rocks in the tree tops all night long \npurty lips wrapped around daddy's big schlong \nAll the little birdies on JayBird street \nLove that lil robin ‘cause she tastes so sweet");
					outputText("\n\nRockin Robin, tweet tweet tweet \nRockin Robin, tweet tweet tweetleelee \nWith that rockin robin you know ya really gonna rock tonight</i>\"");
					outputText("\n\nThere's this timed thrust working through her body to the rhythm of the song. It flings her juicy tits to the side and lets them settle momentarily before sending them on another ride. Pale fingers slide up her slender waist before suddenly changing course and going down her thigh, all the while still bouncing to the rhythm of the song.");
					outputText("\n\n\"<i>Every little swallow, every chickadee \nEvery horny bird in the tall oak tree \nthe big black cock and the slick crow \nGot the dick out screamin mo' girl mo'");
					outputText("\n\nRockin Robin, tweet tweet tweet \nRockin Robin, tweet tweet tweetleelee \nWith that rockin robin you know ya really gonna rock tonight YEEEAAAH</i>\"");
					outputText("\n\nAt this point the other patrons are in an uproar. Mugs of beer are being spilled, large hands being clapped. The music surges through the place invigorating everything that hears its jazzy tune. Anita seems to revel in the chaos, twirling and purposefully jiggling her tits, causing the guys to cheer harder, but when she opens her mouth the noise softens as they lean in to listen. You find yourself leaning in as well.");
					outputText("\n\n\"<i>A pretty little raven with a doggy to suck \nA big sexy dove with some titties to fuck \nRobin cummin' in sayin fuck that shit \nthose dicks belong to her and she's proud of it");
					outputText("\n\nShe rocks in the tree tops all night long \npurty lips wrapped around daddy's big schlong \nAll the little birdies on JayBird street \nLove that lil robin ‘cause she tastes so sweet");
					outputText("\n\nRockin Robin, tweet tweet tweetleelee \nRockin Robin, tweet tweet tweetleelee \nWith that rockin robin you know ya really gonna rock tonight</i>\"");
					outputText("\n\nExplosive applause rips through the tent and you find yourself clapping and hollering along with the crowd. Despite the repetitive, simplistic nature of the song you have to admit you enjoyed yourself. As the applause dies down you realize that you feel a little riled up now.");
					dynStats("lus", 10, "resisted", false);
					dynStats("lus", (player.lib / 5) + (player.cor / 10));
					break;
				default:
					outputText("\n\n<b>Something wrong has happened. Let me play you the song of my people. Actually, you should let Kitteh6660 know.</b>");
			}
			player.gems -= 5;
			statScreenRefresh();
			flags[kFLAGS.BLACK_COCK_ANITA_SONGS_LISTENED]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function rompUpAnitaOffer():void {
			clearOutput();
			if (flags[kFLAGS.BLACK_COCK_ANITA_SEX_INTRO] == 0) {
				outputText("Picking up on the slutty little songbird's obvious flirtation you decide to test it by asking if she likes to taste her customers.");
				outputText("\n\nShe gives you an amused smile. \"<i>Oh huuunny... No! I don't like to taste the customers... Not unless the customers wanna taste me furst,</i>\" she says without batting an eyelash, \"<i>I gotta say though, I like to fuck 'em much more than I like to suck ‘em.</i>\"");
				outputText("\n\nWell, that was easy. When you let her know you'lll take her up on her offer, she gives the waiter a nod and struts out of the bar with you at her heels, her pert little country-girl butt looking dangerously sexy in those cut-off shorts. Once the two of you are outside she turns a crooked finger and leads you behind the bar where she pulls her arms in close, pushing her B-cup harpy lady tits together and looking up at you as she unbuttons her little cut-off shorts.");
				flags[kFLAGS.BLACK_COCK_ANITA_SEX_INTRO] = 1;
			}
			else {
				outputText("To answer her question you tell her she could get naked and show you her pussy. She gives you a sultry grin and says, \"<i>I love it when you talk like that.</i>\"");
				outputText("\n\nShe gives the waiter the usual nod. Then she runs a single nail gently down your arm, her lust-filled eyes locked onto yours before she turns away and struts out the bar with you at her heels.");
				outputText("\n\nOnce the two of you are outside she leads you behind the bar where she uses her arms to push her perky tits together, looking up at you as she unbuttons her little cut-off shorts.");
			}
			menu();
			if (player.canFly() && player.gender > 0) addButton(0, "Eagle Fuck", eagleFuckAnita, null, null, null, "Take a wild trip in the skies with Anita and fuck her!");
			else addButtonDisabled(0, "Eagle Fuck", (!player.canFly() ? "You'll need wings for that." : "You need either a penis or a vagina to do that."));
			if (player.hasCock()) addButton(1, "Vaginal", vaginalFuckAnita);
			else addButtonDisabled(1, "Vaginal", "You'll need a penis for that.");
			if (player.isBiped() || player.isNaga() || player.isGoo()) addButton(2, "Sixty Nine", sex69Anita);
			else addButtonDisabled(2, "Sixty Nine", "You won't be able to do this with your unusual body shape.");
			addButton(4, "Nevermind", nevermindToAnita);
		}
		
		private function eagleFuckAnita():void { //Eagle fuck, must have wings
			clearOutput();
			outputText(images.showImage("anita-sex-eaglefuck"));
			outputText("Looking into her eyes you feel around your [armor] as she does the same. The two of you blindly disrobe as you hold each other's gaze. It is both a little awkward and undeniably sexy, and once the two of you are completely naked Anita's wings flare out, opening wide in a very royal-looking gesture. She fixes those big blue country-girl eyes on you and asks, \"<i>Sky fuck?</i>\"");
			outputText("\n\nYou spread your [wings], a grin being your only reply as you take to the sky. With a hoot and a holler she runs, thrusting her big blond wings towards the ground and lifting into the open air just behind you. She doesn't stay back there for long, and once she catches up the two of you keep a steady pace, criss-crossing paths as your [wings] carry you upward. The air whistles past, tugging at your [hair] and [face] as your [wings] cause the world below to shrink until you're looking at a tiny speck of the odd collection of tents and shopping stalls you just left. The rolling hills of the plains, the dense foliage of both the forest and swamp, the vast expanse of the desert and the giant splotch of blue that is the lake are all laid out before you in a map of the land of Mareth. The view alone takes your breath away.");
			outputText("\n\nYour married harpy fuck buddy makes a noise and you see her at your side, pouting comically as the wind whips her hair around, her perky tits suffering the same fate to a lesser degree. She is a vision as those bright blue eyes stare into yours, a ravenous hunger plain on her face. The two of you begin to circle each other, whooping and hollering like a pair of crazy kids as you swirl closer and closer. Then, looking at a smiling face you feel mirrored on your own, you reach out to grab her hand, floating up as the two of you lock lips, your [fullChest] pressed firmly against her perky B-cups.");
			if (player.hasCock()) { //Males and hermaphrodites
				outputText("\n\nThe weightless moment comes to a sudden end as gravity reclaims your bodies. You both begin to fall headlong towards the bone-crushing earth. With a practiced maneuver, she flips and wraps her naked body around yours, her dripping snatch poised above your erect [cock]. Obviously giddy with vertigo, she smashes her lips into yours and you reach around her to shove your [cock] up into her dripping-wet pussy.");
				if (player.longestCockLength() < 10) outputText("\n\nYou marvel at the fact that there is a lust-consumed maiden straddling you as the wind rushes past. Strong internal muscles clamp around your invading [cock] as she begins to grind against you. You shove forward and she rewards you with another greedy kiss. The odd sensation of vertigo combined with the wet pussy milking your dick sends a giddy, almost intoxicating feeling through your body. You grab at her soft body, reveling in the smooth hairlessness of her milky skin, tasting her neck, her breasts, her lips as the two of you drop towards the earth like a rock.");
				else if (player.longestCockLength() >= 10 && player.longestCockLength() < 18) outputText("\n\nAnita yells in triumph as you impale her with your [cock], obviously enjoying the sensation of your [cock] being pushed into her surprisingly tight pussy. You can feel strong internal muscles clamp around your [cock] as she grinds against you, fucking herself on your bloated baby maker. With a feral grin spread across your [face] you begin to help her, slamming your [cock] into her slick cum-tunnel, heedless of the way the two of you are falling head-first towards the unyielding earth. The odd sense of vertigo combined with the feeling of Anita's dripping pussy lips being pounded by your [cock] is almost intoxicating. Anita must feel the same way too as she rewards you with a firm, possessive kiss.");
				else {
					outputText("\n\nThe fierce slutty harpy lady catches her breath as you shove your [cock] into her saying, \"<i>Oh sweet daddy dick! You're bigger'n my husband.</i>\" With a grin you think about how you'll never get tired of hearing that. As a reward you thrust forward, watching as your [cockHead] indents against her trim little belly, listening to her groans suffused in pained ecstasy. Her pussy is dripping with need around your embedded [cock], the fluid lubing up your fuck-stick and leaving a glistening trail in the sky. You begin to pull her up and down your entire length with a snarl while falling with the grace of a stone.");
					outputText("\n\nSuddenly her lips smash against yours and she's kissing you hard. As your tongues wrestle, you desecrate her hungry pussy with recklessly hard thrusts. Internal muscles grip you and massage your bloated sex organ, milking your [cock]. Anita screams in pure elation the moment she disconnects from your lips, her pretty pink pussy gushing gobs of harpy-girl juice down your [cock] and into the air above the two of you as she shudders from her unexpected climax.");
				}
				outputText("\n\nYou look down at the ground and realize there isn't much time for you to get your orgasm. With a snarl you grit your teeth, double down and fuck the little harpy's very accommodating pussy with rough needy strokes. Laughter as loud as screams come from her throat as you fuck her at full force until you feel the familiar tingling sensation of fluid rushing through your [cock].");
				outputText("\n\nYou yell, a sound that rings with triumph and finality, as your [cock] explodes into Anita's already soaked pussy. You hold yourself inside of her, your trembling body stuck in that position as you flood Anita's more than accepting snatch with globs of baby batter, some of which flies behind the two of you, most of which is lost into your married fuck buddy's hungry pussy.");
				outputText("\n\nOnce you're done you're spent; if it weren't for the whistling of the wind in your ears and the knowledge that doing so would result in your immediate death, you'd go to sleep right here. As it stands you, can't afford to do that, you have your mission… not to mention your desire to live long enough to do something like this again. The two of you break away, so as to make it easier to fly. "); 
				if (player.cumQ() >= 2500) outputText("Your chest swells with pride as you watch Anita fly, her snatch trailing a sticky trail of your glistening baby-batter as her swollen stomach and loosened lady parts empty.");
			}
			else { //Females (Sorry, no genderless)
				outputText("\n\nThe weightless moment comes to a sudden end as gravity reclaims your bodies. You both begin to fall headlong towards the bone-crushing earth. With a practiced maneuver she flips and wraps her naked body around yours, her dripping snatch poised above your [face]. With a shrill whoop she tells you she'll do you after you do her. It occurs to you that taking turns while falling towards the earth might be a terrible idea… even though it is sexy as hell.");
				outputText("\n\nThrowing caution to the wind you shove your [face] forward and begin lick the tasty drenched bird cunt before you, determined to quickly bring her to a roaring climax. You feel sugary sweet lady-cum streaming down your jaw and into your mouth as you use your tongue and lips to make Anita convulse above you. She screams and grabs your head, shoving you into her hungry snatch as the two of you drop like a stone towards the earth. Soft needy legs wrap around your neck as you hum against the harpy's lady bits, vibrating your lips as you kiss and suck her tender flesh.");
				outputText("\n\nSuddenly your face is even more wet, and then there is a gushing of a lady cum squirting from her pretty pink pussy as above you the harpy lady screams her ecstasy for only you and the whistling wind to hear. She is left trembling and screeching and you have to remind her that you haven't cum yet.");
				outputText("\n\n\"<i>Aw shucks darlin', lemme take care o' that for ya.</i>\" Then she opens one wing, does this sexy little twist and ends up above you. With a hungry snarl she shoves her face into your [vagina]. Almost instantly your legs begin to tingle.");
				outputText("\n\nIt feels like a cool drops of rain falling on an unbearably hot summer day. It feels like thunder crashing inside your [pussy], filling you up with a booming electricity that sends seizures of longing through your body. Anita's tongue and lips send convulsing shudders through your body and explosions through your nerve endings as the harpy lady brings you to completion again and again and again, leaving you a shuddering mess as you hurtle like a stone towards the earth.");
				outputText("\n\nYou can't help it as Anita forces your voice to come out in agonized groans and sudden choking sobs stolen by the wind as you plummet. Yet the falling is a distant memory; you wouldn't mind smashing into the ground as long as you could end it all embraced by this rapture, this ecstasy of which every description is unworthy. Your partner, though, pulls her face back and pulls on you until the two of you are at the same rapidly declining height.");
				outputText("\n\nWithout words the two of you kiss, tasting a potent mixture of sweet girl-cum as your tongue slides into her mouth. No longer high from your repeated orgasms you look up, which is actually down, to gage how close the bone-breaking ground is. With one final kiss the two of you let go of each other and you use your [wings] to avoid an untimely death.");
				outputText("\n\nThe two of your circle each other, wordlessly worshiping the other's cunnilingal skills while admiring the other's form. She jokes about you growing a dick for her and you return with a quip that makes her giggle.");
			}
			outputText("\n\nChuckling to yourself you aim yourself at Anita's heels. After you retrieve your [armor] from the ground and pull it on you begin to walk away. Anita whistles to get your attention; as you wave with a grin, and she yells, \"<i>Now ya'll cum back now ya hear?</i>\" You can't help smiling at her. Still feeling good about the flight you decide to take the scenic route to camp. With a few flaps of your [wings] you take to the sky again, enjoying this beautiful gift of flight that you've been given.");
			player.orgasm();
			flags[kFLAGS.BLACK_COCK_ANITA_SEX_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function vaginalFuckAnita():void { //Vaginal fuck, must have penis
			clearOutput();
			outputText(images.showImage("anita-sex-vaginalfuck"));
			outputText("Before she says anything you press your lips against hers, shoving her against the tall fence behind her with a lip-locked growl. You throw off your [armor] and push her little unbuttoned cut-offs down. She gasps against you, her voice a husky groan as you trail kisses down her neck, hungry to be inside her.");
			outputText("\n\nWhen you begin to press more roughly against her, thinking of pushing your [cock] into her slobbering cunt, she shoves you, halting your advances as she grins up at the question on your face, \"<i>Always lick it before you stick it... darlin'.</i>\"");
			outputText("\n\nAs she says this you grab her by her soft thighs and lift. She's as light as a feather, easier to pick up than a fork and spoon. You shove her up into the air and get a good look at her smooth lady-parts as they leak a steady stream of sweet-smelling wetness. All you do is push your [tongue] across the surface and a pair of legs lock around your neck with hands clutching at your [hair]. This must be one sensitive pussy.");
			outputText("\n\nGrinning against her girl bits you begin to tickle and tease her swollen clitoris, enjoying the sound of the harpy lady screeching and groaning above you. She tastes like candy, as if someone melted a sugary treat and filled her with the juices. The sweetness is intoxicating and sends tingles down to [eachCock] as you practically drink from the harpy's nethers.");
			outputText("\n\nSuddenly the legs clamped around your neck become dangerously tight. With surprising strength Anita holds you in place and grinds her pussy against your [face] with a high pitch keen rending the air. Then she begins to squirt. It is a sudden spray of girlcum drenching your face, coating your jaw in the sugary substance as it travels down to your [fullChest], it leaks down your erect [cock] [if (hasBalls = true) \"and dribbles past your [balls]\"] before streaming down your [legs] and ending at your [feet]. With your entire front half covered in sweet girl cum the Harpy slides down your body, a look of supreme bliss on her face as she says, \"<i>Well partner, let's get that there cock taken care of.</i>\"");
			if (player.isBiped() || player.isGoo() || player.isDrider()) {
				outputText("\n\nSoft hands reach down and encircle your [cock], pulling it towards Anita's dripping wet pussy. The lust-crazed harpy groans the moment your [cockHead] begins to push into her gushy wetness of her salivating vagina.");
				if (player.cockTotal() == 1) {
					if (player.biggestCockLength() < 10) {
						outputText("\n\nWith a groan she drops your [cock], allowing you to take over. Feeling triumphant, a growl surges up from deep inside your chest as you hike her legs up and push forward. She gives a hoot and a holler when you begin to slide in and out, enjoying the wetness of her ecstasy-flooded pussy as she flexes those strong internal muscles.");
						outputText("\n\nFuck me hard, stud,</i>\" she says in that country drawl. Holding her light, soft, milky white body in the air with your arms you begin to vigorously fuck her dripping cunt.[if (hasBalls = true) \"You can feel it slobbering down your [balls] and dripping onto your [legs].\"] Soft tits rise and fall in time with your strokes as the harpy's hands clutch at your [ass]. You just continue to hammer her to the fence she's propped against, watching her scream, groan and pant in response to your [cock] greedily using her like an onahole.");
					}
					else if (player.biggestCockLength() >= 10 && player.biggestCockLength() < 18) {
						outputText("\n\nWith a groan she drops your [cock] and lets you take over. She wiggles with need as you sit inside her, obviously impatient after having touched your shaft. When you begin to move her sky-blue eyes go wide and you slowly push into her, enjoying the feeling of her dripping pussy as she squeezes your slowly invading [cock]. Once you fully hilt her she gives a soft little spasm and you feel evidence of her ecstasy running down your [legs] and squirting onto your trunk.");
						outputText("\n\n\"<i>Oh daddy,</i>\" She groans, shivering as you begin to actually fuck her. You watch her lips tremble as you easily fuck her with your entire length. With deep body jarring thrusts you make a dripping mess and her soft tits practically spin as you hold her up and pound her raw. She screams and whines before reaching forward and grabbing your [ass] as if holding on for dear life.");
					}
					else {
						outputText("\n\nWith a groan she drops your [cock] and lets you take over. As you push forward Anita Roswell sings a single wobbling note. Her juicy pussy is being stretched to the limit around your [cock]. You slide your [cock] into her dripping gash with clenched teeth. Once you've managed to hilt the sexy slut, a spasm rocks her body and once again her lusty secretions are gushing and squirting as she screams at the top of her powerful lungs. After Anita's second orgasm has subsided you begin sawing your [cock] in and out of her amazingly wet pussy, watching her body bulge as you shaft her again and again. She cums again, and again as you pump her full of your apparently perfect [cock], all evidence of her ecstasy running down your [legs].");
						outputText("\n\n");
					}
					outputText("\n\nAfter fucking her for a few more minutes you begin to feel a familiar tingle streaming through your [cock]. With clenched teeth you double down and pound Anita as hard as you can. She's trembling but so are you and with a final thrust forward you reach climax just as she does, your [cock] pouring seed into her squirting vulva as the two of you groan between ragged breaths.[if (cumExtreme) \"<i>Once you've recovered from your orgasm you open your eyes to find Anita's belly swollen as if she's pregnant. She rubs your cum baby with obvious delight and tells you not to worry she can't get pregnant unless she takes some pill. When you pull your [cock] from her your cum comes flooding out like a waterfall and soon she's back to normal.");
					outputText("\n\n\"<i>Whoa stud… just whoa,</i>\" she says, breathless as she reaches forward to press her lips against yours. After the kiss the two of you rise and after a little small talk part ways.");
				}
			}
			else if (player.isTaur()) {
				outputText("\n\nShe smiles big as she turns away and falls to her hands and knees, her ass pointed towards you as she assumes the perfect position. Her dripping wet pussy greets you, salavating for [eachCock] and sending a stirring heat through your body. You very unceremoniously raise your front twoto legs to mount her, shoving your [cockHead] into her dripping snatch.");
				if (player.biggestCockLength() < 10) {
					outputText("\n\nA growl comes from somewhere deep inside when you push forward. \n\n\"<i>You like that there tight pussy, doncha?</i>\" She groans through clenched teeth and you have to admit you're enjoying her tight wetness as she flexes her strong internal muscles against your embedded [cock]. \"<i>Fuck me hard stud,</i>\" she groans in that country drawl.");
					outputText("\n\nYou bear down, pressing her into the ground as you fuck her wet cunt with body- jarring hammer blows. She screams beneath you, a shrill sound filled with so much ecstasy you know she has had another orgasm. You just continue to hammer her slim form into the dirt, listening her scream, groan and pant in response to your [cock] forcing its way in and out of her tiny body.");
				}
				else if (player.biggestCockLength() >= 10 && player.biggestCockLength() < 18) {
					outputText("\n\nShe wiggles with desperate need as your [cock] sits inside her. You hear a throaty whine as you slide into the tightly- stretched vaginal sleeve. \"<i>You like that tight pussy?</i>\" sShe says as she wiggles her ass beneath you, and you have to admit you're enjoying the way her dripping pussy squeezes your [cock] with those strong internal muscles. Once you've managed to fully hilt her you feel a spasm rock her body and the evidence of her ecstasy floods around your [cock]. \"<i>Oh daddy,.</i>\" sShe groans, shivering as you begin to actually fuck her. You give a raucous yell of triumph as you easily fuck her with your entire length. Despite the tightness you know she's got plenty of experience. With deep body jarring thrusts you make a dripping mess as you pound her raw. She screams and whines before reaching forward and grabbing two fist fulls of grass as if holding on for dear life.");
				}
				else {
					outputText("\n\nAs you push forward Anita Roswell sings a single wobbling note of pure ecstasy. Her juicy pussy is being stretched to the limit around your [cockHead] and you're surprised to feel another gushing of lady- juice flooding around your embedded [cock]. As she trembles from orgasm you push forward more, listening to the incoherent babble this produces with a proud grin on your face. Once you've managed to hilt the sexy slut another intense spasm rocks her body and once again her lusty secretions are gushing and squirting as she screams at the top of her powerful lungs. After Anita's second orgasm has subsided you begin sawing your [cock] in and out of her amazingly wet pussy, watching her body bulge as you shaft her again and again. She cums again, and again as you pump her full of your apparently perfect [cock], all evidence of her ecstasy running down your [legs].");
				}
				outputText("\n\nAfter fucking her for a few more minutes you begin to feel a familiar tingle streaming through your [cock]. With clenched teeth you double down and pound Anita as hard as you can. She's trembling beneath you, like a vibrating onahole milking your [cock]. With a final brutal thrust forward you reach climax just as she does, your [cock] pouring seed into her squirting vulva as the two of you groan between ragged breaths.[if (cumExtreme) \"<i>Once you've recovered from your orgasm you open your eyes to find Anita's standing in front of your. Her belly is swollen as if she's pregnant. She rubs your cum baby with obvious delight and tells you not to worry: she can't get pregnant unless she takes some pill.");
				outputText("\n\n\"<i>Can't wait to get on that horse again,</i>\" Anita intones as she kisses you before the two of you redress and part ways.");
			}
			else if (player.isNaga()) {
				outputText("\n\nYou nod as you pull the sexy harpy lady close.");
				//if (player.cockTotal() == 1) { // No multi-cock love :(
					outputText("\n\nYou rise up and begin swirling around her as you wrap her up in your coils, your [cockHead] pressed against her still drooling pussy. You use the strength in your lower snake half to slowly and gently guide her to the ground where you take her hands in yours and press them into the grass. With a grin spread across your [face] you tighten your coils, pulling her closer until your [cockHead] pushes into her slobbering, hungry pussy.");
					if (player.biggestCockLength() < 10) outputText("\n\nAs you begin to work your coils, undulating each one to twist your [cock] around inside the girl and shoving forward to drill deeper into her in a sensual motion that sends shivers of longing up into your chest, the harpy girl trembles beneath you. With a holler she reaches out and grabs your [ass], begging to be fucked hard. You oblige her, increasing the tempo of your [hips] as you begin writhing against the girl, your [cock] twisting around and pumping in and out in the same motion, driving her mad as you fuck that blissfully dripping pussy.");
					else if (player.biggestCockLength() >= 10 && player.biggestCockLength() < 18) outputText("\n\nYou begin to work your coils, squeezing and loosening each one, causing your embedded [cock] to swirl around inside the sexy harpy lady as you keep her pressed to the ground. She openly groans and shudders as you move in and out of her pretty little harpy lady pussy. Then you add a sharp thrust, dipping in and out of the dripping hole squeezing your [cock] with surprisingly strong internal muscles. Anita goes berserk, her voice climbing higher and higher only to break when you slam forward, fully hilting the little cock lover. Without needing further instruction you speed it up and watch that pretty little country girl begin to grimace as you shudder out another orgasm, her lusty secretions squirting around your still rapidly fucking [cock] and drooling down your writhing [legs].");
					else outputText("\n\nThe moment you shove your [cock] into Anita she grabs you and with a deep throaty groan squirts another heavy helping of girl-cum around your almost hilted [cock] and down your [legs]. You watch her convulse as you hold her down, her pussy gripping your dick with surprisingly strong internal muscles. She sure is one hot little winged squirter. When you begin to move, undulating each coil in turn as work your [cock] around in a circular motion, fucking the little cum crazed country girl with circular strokes, each punctuated with a sudden sharp thrust. The practice sends a desperate look through Anita's face, \"<i>Shit you're bigger'n my husband.</i>\" She says as you fuck her harder and harder, pounding her dripping pussy with increasing passion and listening to her call out and babble like a fool.");
					outputText("\n\nYou begin to feel less and less in control of your swirling, thrusting [cock] as a familiar tingle foods your [cock]. Its time and as you slam forward, coils tight around the harpy's legs and fists clenched around her wrists, she smashes her lips into yours. With her tongue in your mouth your dick begins hosing down her insides, your baby batter spreading through her hungry pussy with what can only be described as shuddering convulsions that leave you feeling exhausted as the sensations ebb, your body falling limply onto the harpy lady as your still embedded [cock] slips out, temporarily sated.");
					outputText("\n\nAfter a few seconds of blissful rest you begin the process of disengaging your coils from the dozing harpy lady. [if (cumExtreme) \"<i>As you do, you notice a large amount of your own jism leaking from her slightly distended snatch, her pussy unable to soak it up. Looking down you see a huge puddle of mixed cum around the two of you, most of it yours.</i>\"] Once you've managed to release her the married woman stands on visibly wobbly legs and leaves you after saying, \"<i>You cum back here anytime, darlin'…</i>\" and with a smile you slither back to camp.");
				//}
			}
			player.orgasm();
			flags[kFLAGS.BLACK_COCK_ANITA_SEX_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function sex69Anita():void { //69 with Anita, must not be a taur.
			clearOutput();
			outputText(images.showImage("anita-sex-sixtynine"));
			outputText("Before she says anything you press your lips against hers, shoving her against the tall fence behind her with a lip-locked growl. Still connected at the lips you throw off your [armor] and push her little unbuttoned cut-offs down. She gasps against you, her voice a husky groan as you begin to trail kisses down her neck, hungry to both taste her and to be tasted.");
			outputText("\n\nYou grind your body against her supple form. Your [fullChest] presses against her soft tits as the two of you pull at each other. As she sucks your neck you tell her how hard you're going to make her cum, how she's going to taste the evidence of your pleasure and with that the married hapry lady slides to the ground and rolls over until her ass is propped up against the fence and her head lies against the ground. With a grin you fold yourself into her.");
			if (player.hasCock()) { //Males and hermaphrodites
				outputText("\n\n");
				if (player.balls > 0) {
					outputText("You press your [balls] against Anita's soft lips as you look down at her pretty pink pussy. Her soft lips pull one of your sensitive orbs into her mouth and she rolls her tongue, massaging your testicle with gentle swirls of her tongue. You shudder against her and almost forget you're supposed to be pleasuring her as well, but first things first. You rise a little, pulling your [balls] from her tender lips. ");
				}
				outputText("With a grin you reach down and grab your [cock], pressing your member against her wet lips as you lean in to taste her.");
				if (player.biggestCockLength() < 7) outputText("\n\nAs you dip your [cock] into her lips she opens wide and swallows you whole. You groan at the feeling of her hot mouth embracing your dick. Then you press her legs further down, determined to make her feel every bit as good as her lips are making you feel as you open your mouth and drag your tongue across her pussy. You taste sweet girl-cum on your tongue and looking down you can see the shine of wetness flooding her pussy, the pearly liquid dripping down her body as she balances on her head and shoulders while sucking your [cock]. When you return to her lady parts you suck the excess liquid and begin to twirl your tongue across her swollen clit. Beneath you she screams around your [cock], trembling as her pussy suddenly explodes in your face, squirting a massive deluge of her sweet pussy juice.");
				else if (player.biggestCockLength() >= 7 && player.biggestCockLength() < 13) outputText("\n\nAs you dip your [cock] into her lips she opens wide and takes your hard rod into her lips. As you move, reveling in the feeling of her hot mouth, you find yourself only able to get the first seven inches of your [cock] into her lips, but after a few thrusts she swallows and your [cock] curves into her throat, allowing you to hilt her mouth. With a groan you bounce for a few moments, losing yourself in the feeling. Then you press her legs further down, determined to make her feel every bit as good as her lips are making you feel as you open your mouth and drag your tongue across her pussy. You taste sweet girl-cum on your tongue, and looking down you can the shine of wetness flooding her pussy, the pearly liquid dripping down her body as she balances on her head and shoulders while sucking your [cock]. When you return to her lady parts you suck the excess liquid and begin to twirl your tongue across her swollen clit. Beneath you she screams around your [cock], trembling as her pussy suddenly explodes in your face, squirting a massive deluge of her sweet pussy juice.");
				else if (player.biggestCockLength() >= 13 && player.biggestCockLength() < 25) outputText("\n\nAs you dip your [cock] into her lips she gags. Looking down you watch her lips stretch to encompass your dick, smearing her red lipstick all over your rigid [cock]. As you move, reveling in the feeling of her hot mouth, you find yourself only able to get the first seven inches of your [cock] into her lips but after a few thrusts she swallows and your [cock] curves into her throat. Yet still some of your [cock] hangs out as you feel Anita taking furious breaths through her nostrils; it appears this is the limit of her deep-throating capabilities. With a groan you bounce for a few moments, losing yourself in the feeling. Then you press her legs further down, determined to make her feel every bit as good as her lips are making you feel as you open your mouth and drag your tongue across her pussy. You taste sweet girl-cum on your tongue and looking down you can see the shine of wetness flooding her pussy, the pearly liquid dripping down her body as she balances on her head and shoulders while sucking your [cock]. When you return to her lady parts you suck the excess liquid and begin to twirl your tongue across her swollen clit. Beneath you she screams around your [cock], trembling as her pussy suddenly explodes in your face, squirting a massive deluge of her sweet pussy-juice.");
				else outputText("\n\nIt's easy to see that your [cock] isn't going to fit in her mouth as you press your [cockHead] against her lips. As you press your shaft against her mouth your [cock] slides up and she licks it, suckling the underside as she grabs her tits and presses them against your [cock]. She squeezes your shaft with her perky tits, the tender flesh massaging either side of your shaft as you groan from the sensation. Then you press her legs further down, determined to make her feel every bit as good as her lips are making you feel as you open your mouth and drag your tongue across her pussy. You taste sweet girl-cum on your tongue and looking down you can see the shine of wetness flooding her pussy, the pearly liquid dripping down her body as she balances on her head and shoulders while giving your [cock] a slobbery titjob. When you return to her lady parts you suck the excess liquid and begin to twirl your tongue across her swollen clit. Beneath you she screams around your [cock], trembling as her pussy suddenly explodes in your face, squirting a massive deluge of her sweet pussy-juice.");
				outputText("\n\nStill trembling from orgasm she redoubles her efforts. ");
				//Vagina check
				if (player.hasVagina()) {
					outputText("She even begins to finger your [vagina], The added sensation pushes you over the edge and your [cock] swells as you reach climax. ");
				}
				else {
					outputText("She begins to suck harder, using her hands to massage your [legs] and pull you harder against her. Your [cock] slides, free of her mouth as she kisses its rigid underside. The added sensation pushes you over the edge and your [cock] swells as you reach climax. ");
				}
				if (player.cumQ() >= 250 && player.cumQ() < 1000) outputText("You feel the hot evidence of your climax hit your jaw as you unload, painting hot streaks of cum from your chin to her perky tits.");
				else if (player.cumQ() >= 1000 && player.cumQ() < 2500) outputText("You feel the hot evidence of your climax slam into your chin, a huge glob of your cum painting your jaw white. You groan as you orgasm rages on, painting both your bodies in a liberal coating of jism as Anita continues to lick the belly of your [cock].");
				else if (player.cumQ() >= 2500) outputText("A tidal wave of baby-batter fills your vision with white, your [cock] expelling gigantic torrents of seed with every contraction that rains back down to the earth. By the time your orgasm has subsided you're quietly convulsing with you and Anita covered in spunk and surrounded by a pool of hot seed.");
			}
			else if (player.hasVagina()) { //Females
				outputText("\n\nLicking your lips as you look down at the lady bits you press your [tongue] against Anita's pretty pink pussy. Instantly you taste her vaginal juices as they begin to flow like a river, spilling over and dripping down her body. The girl is definitely a wet one. You feel Anita reciprocate, her tongue lashing at your [vagina] before her mouth encapsulates your lady bits, her tongue tickling your [clit] as she sucks your [pussy] creating a tingling sensation from the vacuum effect. With the sugary sweetness of her lady cum dripping down your chin you grind your [pussy] against her face, further increasing the sensations coursing through your body. With a snarl you shove your face back into her pussy, rubbing your [face] in her spread honey pot as she cringes and convulses from your vaginal machinations. Soft needy legs wrap around your neck as you hum against the harpy's lady bits, vibrating your lips as you kiss and suck her tender flesh.");
				outputText("\n\nSuddenly your face is wetter, and then there is a gushing of lady-cum spraying your face as below you the harpy lady screams in pure euphoric ecstasy. When she is done trembling, she turns to you with a grin.");
				outputText("\n\n\"<i>Aw shucks, darlin', you're good at this. I reckon we'll be here awhile...</i>\" Then she shoves her face back into your [pussy]. Instantly your [legs] begin to tingle.");
				outputText("\n\nAs the warning melody of intense arousal becomes the full cacophonous boom of climax you are lost in the sensations. It is the triumph of victory intermingling with the dull ache of hard work done well. It is a warm room and a big blanket on a cold winter day. It is thunder and lightning clashing in your ears and flashing before your eyes, streaming through you and setting every nerve aflame. Anita's tongue and lips send convulsing shudders through your body and explosions through your soul as the harpy lady brings you to completion again and again and again, leaving you a shuddering mess as you do the same, every time her pussy exploding and squirting you with her very sweet lady spray.");
				outputText("\n\nYou can't help it as your [vagina] forces your voice to come out in agonized groans and sudden choking sobs. When neither of you can take the intensity of your mutual cunnilingus the two of you break apart.");
				outputText("\n\n\"<i>My husband and the guys around here can lick a pussy like nobody's business. But I gotta say, pussy knows what pussy wants,</i>\" Anita jokes, breasts rising and falling as she heaves. You smile at the complement.");
				outputText("\n\nWithout words the two of you kiss, tasting a potent mixture of sweet girl cum as your tongues slide against each other.");
			}
			else { //Genderlesses
				outputText("\n\nAs you sit on Anita's face you grind your [asshole] against her lips. The static like tingle of her tongue invading your backdoor sends a shiver up your spine. She moans and shakes her face, jiggling your [ass] as she vibrates her deeply embedded tongue.");
				outputText("\n\nDetermined to make her feel every bit as good as she is making you feel, you push her legs down, spreading her vaginal lips wide before dragging your tongue across the surface of her pretty little pink pussy. Instantly you can taste her vaginal juices as they begin to flow like a river, spilling over and dripping down her body. The girl is definitely a wet one. You feel Anita reciprocate, her tongue lashing at your [asshole] before her mouth encapsulates your quivering butthole, her tongue fucking you like some slimy tentacle dick as she sucks your [asshole], creating a tingling sensation from the vacuum effect. With the sugary sweetness of her lady cum dripping down your chin, you grind against her face, further increasing the sensations coursing through your body. With a snarl you shove your face back into her pussy, rubbing your [face] in her spread honey pot as she cringes and convulses from your vaginal machinations. Soft needy legs wrap around your neck as you hum against the harpy's lady bits, vibrating your lips as you kiss and suck her tender flesh.");
				outputText("\n\nSuddenly your face is wetter, and then there is a gushing of a lady cum spraying your face as below you the harpy lady screams in pure euphoric ecstasy. You continue, following through her orgasm until it has subsided and she is left trembling.");
				outputText("\n\n\"<i>Aw shucks, darlin', you're good at this. I reckon we'll be here awhile.</i>\" Then she shoves her face back into your [asshole]. Instantly your [legs] begin to tingle.");
				outputText("\n\nAs the tingle of warning becomes the full cacophonous boom of climax you are lost in sensations. It's like the pressure of a raging river breaking free of a dam, exploding in violent glory. It's the boom of dynamite shaking your entire being to the core. Anita's tongue and lips send convulsing shudders through your very soul as the harpy lady brings you to completion again and again and again, leaving you a shuddering mess as you do the same, every time her pussy exploding and squirting you with her very sweet lady spray.");
				outputText("\n\nYou can't help it as your trembling [ass] forces your voice to come out in agonized groans and soul choking sobs. When she can take your cunnilgal skills no more the harpy lady falls, admitting defeat as her tongue leaves your [asshole].");
				outputText("\n\n\"<i>Darlin', you are a gem,</i>\" Anita says, breasts rising and falling as she heaves. You smile at the complement. Without words the two of you kiss and you push her own sweet release into her mouth.</i>\"");
			}
			outputText("\n\nYours and Anita's breaths come out in ragged huffs as you both come down from your respective oral-induced highs. After a few seconds your breaths have quieted and the two of you rise, smiling at each other. In the midst of that post-orgasmic glow the two of you chat a little before pulling your respective outfits back on and departing each other's company with a final quick peck on the lips.");
			player.orgasm();
			flags[kFLAGS.BLACK_COCK_ANITA_SEX_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Andy Mathis
		//------------
		private function meetAndyMathis():void {
			clearOutput();
			displayAndySprite();
			outputText(images.showImage("andy-intro"));
			if (flags[kFLAGS.BLACK_COCK_MET_ANDY] == 0) {
				outputText("With a flick of your fingers you catch the waiter's attention. The satyr walks towards you and pulls out his notepad and a little black pencil.");
				outputText("\n\n\"<i>Hello, my name is Andy Mathis and I'll be your waiter this evening,</i>\" he says as he twirls the pencil between his fingers, \"<i>So what'll it be… um…?</i>\" You give him your name, \"<i>Ok... so what'll it be, [name]?</i>\"");
				outputText("\n\nYou tell him you're not ready to order anything off the menu just yet. Before you can go on to say more, he puts the pad away and says, \"<i>Well if you want to order something off the menu, I keep my stash out back. I used to sell it on the floor but the boss's wife likes free samples. Free is bad for business.</i>\"");
				outputText("\n\nYour head cocks to the side and the satyr takes notice. When you ask him to clarify, his lips pull into a big pearly white grin. \"<i>Oh… you're a first timer. Well, if you want I can show you a lot better than I can tell you, but it'll cost 3 gems.</i>\"");
				outputText("\n\nYou could go check out Andy's stash or maybe check out Andy… or you could just pick up the menu and actually order something.");
				flags[kFLAGS.BLACK_COCK_MET_ANDY] = 1;
			}
			else {
				outputText("You call Andy over and when he sees you his face pulls into a warm inviting smile.");
				outputText("\n\n\"<i>Hey [name], so what'll it be today?</i>\" he asks, pen poised.");
			}
			if (flags[kFLAGS.CODEX_ENTRY_SATYRS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_SATYRS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Satyrs!</b>\n\n");
			}
			menu();
			addButton(0, "Stash", checkAndyStash, null, null, null, "Go out the back of the tent and check out Andy's stash?");
			if (player.lust >= 33) addButton(1, "Sex", rompUpWithAndyTheSatyr, null, null, null, "Proposition to have sex with the satyr.");
			else addButtonDisabled(1, "Sex", "You aren't aroused enough to consider this.");
			addButton(4, "Nevermind", nevermindToAndy);
		}
		
		private function nevermindToAndy():void {
			clearOutput();
			outputText("You decide to not take Andy up on his offer or make any offers of your own so you tell him you'll call him back over when you're actually ready. He nods and with a charming smile leaves you to it.");
			doNext(checkStaff);
		}
		
		private function checkAndyStash():void {
			clearOutput();
			if (flags[kFLAGS.BLACK_COCK_ANDY_STASH_STATE] == 0) {
				outputText("You decide to take a look at Andy's \"stash\". He gives you a wicked grin in response and says, \"<i>Oh, you are in for a treat.</i>\" He nods towards the flap in the back of the tent, the one with the keep out sign and says, \"<i>Well… follow me,</i>\" and with that he leads you through a hot cluttered kitchen past a big furiously-swearing rhino and out the back of the tent.");
				outputText("\n\n\"<i>Over here,</i>\" the deep voice of the satyr calls as he heads towards a bunch of barrels. As you follow him you look around, noting the high fence that keeps others out of this area. There's a large door you assume is for taking deliveries and a huge carriage where they'd probably put all the gear for the tent in if they needed to move.");
				outputText("\n\nOnce you've caught up to the satyr you look at him and are greeted with his bare ass. He is bent over and fishing something out from between the barrels. Once he has it he straightens up and shows you a multi-colored lamp made from crystalline glass in one hand and a bag of ground plant in another.");
				outputText("\n\nHe holds up the bag and some strange scent washes over you. The smell is harsh at first but as you breathe it becomes sort of pleasant. It even makes you feel a little giddy.");
				outputText("\n\n\"<i>All right [name]. This is Nepenthe; it's made from a plant. Well… several plants.</i>\" He wears this big conspiratorial smile like he's letting you in on some huge secret even though it's quite obvious the stuff comes from a plant.");
				outputText("\n\nAs you watch Andy load the crushed plant into the tall multicolored crystal lamp you ask him why anyone would do this?");
				outputText("\n\n\"<i>You have to experience this shit to know what it's like. It's like eating the perfect bowl of cereal or jumping off a cliff and not being afraid of the ground… I don't know how to explain it. It's also different for everybody but trust me, you'll like it. It's the shit man, the real shit. I won't make you try it but it's… just… wow.</i>\"");
				outputText("\n\nThen you ask him about the crystal lamp.");
				outputText("\n\nThis makes him laugh, \"<i>It's not a lamp. No big blue singing genie is gonna come bursting out of this thing if you rub it. It's a hookah. Look, you put the water in this basin here and the plant in this chamber near the bottom and some coals beneath that. You light the coals and you inhale the vapors through these pipes… and experience nirvana. <b>And one session is only 5 gems.</b></i>\"");
				outputText("\n\nHe makes it sound as though it's the best thing in the world but there's no telling how this stuff could affect you, especially since it comes from the bazaar.");
				outputText("\n\nWill you try Nepenthe?");
				flags[kFLAGS.BLACK_COCK_ANDY_STASH_STATE] = 1;
			}
			else {
				outputText("You tell Andy you want to check out his stash again. He steps back with an exaggerated bow, silently telling you to lead the way. You " + (player.isNaga() ? "slither" : (player.isGoo() ? "slide" : "walk")) + " as silently as your [feet] will allow as you enter the tent flap, sneaking past a humming rhino-morph that is dancing as he cooks. Once you've successfully made it out the back of the tent, you breathe a sigh of relief. Andy comes from behind you and walks to his stash.");
				outputText("\n\nHe pulls out his crystal hookah and loads it up. Then he looks at you with a raised eyebrow as he thumbs his lighter; the question on his face is obvious.");
				outputText("\n\nWill you smoke some Nepenthe?");
			}
			doYesNo(smokeSomeHookah, dontSmokeItsBad);
		}
		
		private function smokeSomeHookah():void {
			clearOutput();
			if (player.gems < 5) {
				outputText("You realize you are short on gems. Andy gives you a bit of disappointed look and escorts you back to the tent.");
				doNext(enterTheBlackCock);
				return;
			}
			outputText(images.showImage("andy-smoke"));
			if (flags[kFLAGS.BLACK_COCK_ANDY_STASH_STATE] < 2) {
				outputText("You nod, telling Andy you want to smoke his Nepenthe. He gives you a big smile as he scoots closer to you and shows you what to do, \"<i>It's pretty easy. When the vapor fills this chamber you want to empty your lungs and put it to your lips. Pull this divider up and inhale… simple.</i>\" He then demonstrates and once he's done he's left with a smiling face, \"<i>Also, hold it in your lungs for a second. That makes it feel better.</i>\"");
				outputText("\n\nYou repeat the process but when you inhale the smoke and try to hold it in, your body rejects the sweet tasting vapors. You end up coughing hard, your entire body shaking in time with each heave. Meanwhile beside you Andy is laughing like a maniac.");
				outputText("\n\n\"<i>Sorry kid.</i>\" He says, still chuckling, \"<i>That happens sometimes if you rush it. Try to slow down… it's your first time. Sip it like a hot drink.</i>\"");
				outputText("\n\nFollowing the satyr's advice you try again; this time your coughing fit is nowhere near as intense. The third time though you manage to hold the air in and send it back out of your own volition. As you do so a warm happiness begins to bloom in your [fullChest].");
				outputText("\n\nYou take a hit and another before Andy clears his throat, \"<i>You wanna pass that?</i>\" He says with his fingers raised and waiting. You hand him the pipe with a serene expression.");
				flags[kFLAGS.BLACK_COCK_ANDY_STASH_STATE] = 2;
			}
			else {
				outputText("You hold your hand out for the pipe. Andy scoots closer to you and passes it, leaning back against the barrels. As you take your hit the warm happy heat blooms in your [fullChest] and you hand the pipe back with a giant smile.");
			}
			dynStats("lus", 10, "resisted", false);
			dynStats("lus", 10 + (player.lib / 5) + (player.cor / 10));
			switch(rand(2)) {
				case 0:
					outputText("\n\nAndy pulls the pipe to his lips with a quick, \"<i>Watch this.</i>\" he takes the hit, holds it in and blows. Your mouth drops as a pirate ship, complete with billowing sails, flies from his lips. He chuckles as he hands it back. You yourself barely manage a simple hoop and resolve to stop caring about smoke tricks as the drug takes effect, spreading its hot warmth throughout your body.");
					outputText("\n\n\"<i>I love doing this.</i>\" He says as after he exhales a tiny fairy, \"<i>...especially with friends. It's cool that you're here [name].</i>\"");
					outputText("\n\nAn odd giggle erupts from your lips and you have to force yourself to stop laughing long enough to tell the satyr you're having fun. With a curious look in your direction he asks you about your past. You tell him about the friends you had, the oddities of your village and who looked good enough to fuck and who didn't. You find yourself very relaxed, whether it's from the Nepenthe or the satyr's company you don't care. It is a good feeling to just sit here and talk.");
					outputText("\n\nYou ask Andy about his youth.");
					outputText("\n\n\"<i>Well, when satyrs are born we're usually a copy of our dad with just a little bit of the birthing parent's traits. My dad isn't really like other satyrs; don't get me wrong, when he's real horny he is just as willing to knock you over and fuck you into the grass as any satyr, but he likes other things too. He does more than drink and fuck and fuck and drink. I think it's because he isn't as corrupt, sort of middling corruption I'd guess.</i>\"");
					outputText("\n\nYou take a deep drag and allow the smoke to billow out, feeling like you could float off into the sky if you wanted. It occurs to you that Andy hasn't brought up his mom so you ask him about her.");
					outputText("\n\n\"<i>Oh, my mom was a dog morph. She was really pretty but I think the whole pregnancy thing scared her; I'm pretty sure my dad was supposed to just be a one night stand. She looked at me like I was some alien when I went through puberty and sprouted chest hair right after I was born. I have no clue what happened to her after that.</i>\"");
					outputText("\n\nYou nod. He doesn't seem happy or sad about it, almost as if he's speaking of someone else.");
					outputText("\n\n\"<i>My dad found me and I have to admit that we look just alike. He doesn't have a dog cock though... I got that from eating peppers. When I was younger he taught me how to dance and sing and do all sorts of things like make wine and grow the plants I use to make Nepenthe. Because of him I can throw a sick party if I want to. I know a little old magic too; nothing spectacular… it's more alchemy than anything but I use it to make the wine we sell, kind of gives it a bit of a mystic kick. Dad was a cool dude, is a cool dude. He's still around of course. I'm truly happy that, because of him, I enjoy life beyond fucking and drinking. Sex is good, sex is great but there's more to life than that… you know.</i>\"");
					outputText("\n\nAndy looks over and notices you taking another drag. He gives you a stern look as he holds out his hand. When he takes his turn you remark about how horny smoking is making you, a comment you're not sure if you would have made otherwise.");
					outputText("\n\nAndy chuckles, \"<i>Yeah, it does that. Look.</i>\" He spreads his legs and you look over and see a big dripping dog cock standing tall and poking the short satyr's chest. After a few seconds it becomes apparent that Andy is waiting for you to do something.");
					break;
				case 1:
					outputText("\n\nAndy pulls the pipe to his lips with a quick, \"<i>Watch this.</i>\" He takes the hit, holds it in and blows. Your mouth drops as an omnibus, complete with a smoke leaking horse cock, flies from his lips. He chuckles as he hands the pipe back. You yourself barely manage a simple hoop and resolve to stop caring about smoke tricks as the drug takes effect, spreading its hot happiness through your body.");
					outputText("\n\n\"<i>I love doing this.</i>\" He says as after he exhales a tiny spinning sword, \"<i>...especially with friends. It's cool that you're here [name].</i>\"");
					outputText("\n\nYou feel warmth streaming through your body, happy smokiness that blooms from your lungs and tingles until it gets to your fingers. A smile spreads across your [face] as you look over at Andy. You ask him about transformation. He doesn't seem to understand that, in most places, eating food doesn't cause your body to change as it does here.");
					outputText("\n\n\"<i>Is that how you've always looked?</i>\" he asks.");
					if (flags[kFLAGS.TIMES_TRANSFORMED] < 3 || player.humanScore() >= 5) outputText("You nod, telling him that you look the same as when you walked through the portal.");
					else outputText("You shake your head and tell the curious satyr you've changed since coming to Mareth.");
					outputText("\n\n\"<i>I can't imagine not having the option to change. I was born here, I don't know anything else.</i>\" You tell him that he'd adjust just as you did when you walked through a portal into a world where what you eat can drastically change your appearance.");
					outputText("\n\nAndy looks over and notices you taking another drag and holds out his hand. As he takes his turn you remark about how horny smoking is making you, a comment you're not sure you would have made otherwise.");
					outputText("\n\nAndy chuckles, \"<i>Yeah, it does that. Look.</i>\" He spreads his legs and you look over and see a big dripping dog cock standing tall and poking the short satyr's fuzzy chest. After a few seconds it becomes apparent that Andy is waiting for you to do something.");
					break;
				default:
			}
			player.gems -= 5;
			statScreenRefresh();
			applyAndysSmokeEffect();
			outputText("\n\nWhat do you want to do?");
			menu();
			addButton(0, "Grab It", grabAndysDongAfterSmoking, null, null, null, "That cock looks fun to play with!");
			addButton(1, "Do Nothing", doNothingAfterSmoking);
		}
		
		private function doNothingAfterSmoking():void {
			clearOutput();
			outputText("You can't help laughing at the horny satyr's predicament as he exhales, this time creating a female dog morph, her fingers attached to her wispy snatch, \"<i>Yeah,</i>\" He says with a grin, \"<i>I gotta start wearing pants.</i>\"");
			outputText("\n\nThis makes you laugh again. Suddenly everything is funny and the world is beautiful beyond words. Every star in the sky seems to be vying for your attention. Every blade of grass seems to dance beneath your [feet]. You don't feel like a stranger invading some strange land. You don't feel anything but joy for being here in this alien world with a lung full of happy smoke and this friendly satyr sitting next to you.");
			outputText("\n\n\"<i>In my defense,</i>\" Andy says as he takes the pipe, \"<i>When I wear pants everyone calls me George and I love my dad but I don't like that shit. I'm Andy damnit, Andy fucking Mathis</i>\"");
			outputText("\n\nYou can't help the guffaws of laughter erupting from your face. The two of you continue to smoke, chat and laugh until the happiness inducing drug is gone. Once the two of you have finished Andy says something about getting back to work and you find yourself feeling a little hungry.");
			dynStats("lus", 10, "resisted", false);
			dynStats("lus", 10 + (player.lib / 5) + (player.cor / 10));
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function grabAndysDongAfterSmoking():void {
			clearOutput();
			outputText("Feeling adventurous you wrap a hand around the foot long doggy dong standing at attention next to you. Andy gives a soft gasp as you squeeze his hot dick. After giving it a few pumps he gently tugs your hand off of his leaking dog cock.");
			outputText("\n\n\"<i>You can play with mine if you let me play with yours.</i>\" He says with a cute little grin.");
			outputText("\n\nYou nod, who would say no to that anyway? As you shed your [armor] you notice the cute little satyr looking at your [ass] with an approving nod. You take your seat again and look over at Andy. You look down and he smiles big, reaching and sliding a hand down your body.");
			if (player.hasCock()) { //Male/herm
				outputText("\n\nAs his hands slides down your stomach you flex [eachCock] in anticipation. He reaches down and wraps a tight grip around your [cock]. You look over and he catches your eye. The two of you are suddenly laughing as he maintains a firm grip on your [cock]. Once the joke is over he hands you the pipe and tells you to take a deep hit. As you do his soft fingers begin moving around your erect length, squeezing and teasing your [cock]. As the smoke blows out of your mouth he grabs the pot, taking a hit himself.");
				outputText("\n\nYou reach out and grab the tall standing doggy dick. He gives you a firm tug and you do the same, drawing a soft chuckle from his lips. He's big, about a foot long and a few inches thick. There's a knot at base of his cock, just where it exits the sheath.");
				if (player.dogCocks() > 0) {
					outputText("\n\nYou take a thumb and use it to massage his knot; at the exact same moment he does the same to you and the two of you lock eyes. The teasing sensation intensifies but you both don't look away... this is a battle of wills. The painful pleasure of the teasing rises like a flock of angry birds from your [cock] into your head. The incredible sensation of your mutual knot play is almost unbearable. Yet still you look at him, your face and his both showing each other how incredible the sensations are. Soon enough you find yourself the victor as the horny satyr flinches and uses both his hands to pull your hand from his knot. You smile big as he looks over at you and says, \"<i>Alright [name] you win.</i>\" with a look of good humored fun on his face. You grab his dick and he grabs yours again, ready to get down to business.");
				}
				outputText("\n\nYou pump his dick with a tight fisted grip as he massages yours. The alien hand on your member doesn't jerk your [cock] the way you do. It's an odd sensation as he gives a firm squeeze every time his hand travels up your shaft towards your [cockHead]. He gasps beside you and you know he's enjoying your hand on his staff, jerking in the familiar way you pump your own [cock]. He scoots closer until his furred leg rests against your [legs]. You have to reach around his trim waist and grab his dick, pumping it and feeling pre-cum drip down your fist as it rises and falls.");
				outputText("\n\nSoon the both of you are breathing ragged breaths and trembling slightly.");
				outputText("\n\n\"<i>Let me… just…</i>\" Andy Mathis says as he widens his legs, tightly fisting your [cock] in his odd massaging way of jerking off. It almost feels as if he is milking your dick. You find your hand wrapped around his waist and your head pressed against his as you hump into his hand, the familiar sensation of your impending ejaculation rising until the both of you shoot white hot goo into the air, an arcing X formed by the first few spurts of baby batter as you hold onto his spasming cock and you both gasp and groan.</i>\"");
			}
			else if (player.hasVagina()) { //Female
				outputText("\n\nAs his hand slowly slides down your body you watch his face. Eyes bright with an eagerness to please are locked onto your [vagina] as he bites his lip. Then he rubs a single digit across your [clit]. Then he looks up and catches you watching him and, for some reason, you both burst into laughter. You can't help but wonder at the pure elation coming from the happy fog in your lungs.");
				outputText("\n\nAfter the laughing has died down, and with your hand still firmly wrapped around his cock, he goes for your [pussy] again. Again he uses his fingers to stimulate your clit, handling the sensitive protruding gland with confidence as he brings a shuddering sensation of trembling ecstasy crashing through your mind and body. You look over and he catches your eye. For some reason, probably the drugs, the two of you are suddenly laughing as he maintains a firm grip on your [cock]. Once the joke is over he hands you the pipe and tells you to take a deep hit. As you do this, soft fingers begin moving around inside you, dipping into your moistened lady parts with a single questing finger.");
				if (player.vaginas[0].vaginalLooseness >= 2) {
					outputText("\n\nAnother finger slides alongside the first, and then another until you're groaning from the feeling of multiple wiggling fingers playing around inside of you.");
				}
				outputText("\n\nHe alternates between fingering you and rubbing your clit as you half heartedly squeeze his knotted dog cock. He doesn't see to mind though as he licks his fingers and teases your clit until the sensations are so intense they're unbearable and just as you're going to shove the erotic fire inducing fingers away he pushes into you and without needing any direction heads straight to your G-spot. His cock is released as you lift your legs and scream, your orgasm exploding into existence and drowning out every other sensation, thought and memory with the loud cacophony of deep voiced moans and shuddering gasps. As you come down from your high you watch the satyr's hand slide up and down his own dick, taking a hit from the pipe as you wait. Soon he is painting his fuzzy chest with his own baby batter.");
			}
			else { //Genderless
				outputText("\n\nWith a smile he gently pulls your hand from his dog dick. He slides down onto the ground in front of you. Then he looks up, eyes pleading for permission. Intrigued by this sudden change of pace you nod. With a smile he takes a deep hit from the pipe before handing it to you with a nod, a nod you take to mean you can smoke the rest of it if you want.");
				outputText("\n\nThen he licks his thumbs and his hands begin spreading your [ass]. His wet thumbs tease the surface of your hole. ");
				//Biped or naga
				if (player.isBiped()) outputText("You spread your legs as you settle down and take a deep hit, enjoying the wet teasing fingers and the lung full of warm joy.");
				else if (player.isNaga()) outputText("You wrap your coils around his waist, enjoying the wet teasing fingers and the lung full of warm joy.");
				//Anal looseness check
				if (player.ass.analLooseness < 2) { //Virgin or tight
					outputText("As a single soft finger presses against your [asshole] you flinch at the sudden pressure. The satyr is patient though and after licking the single digit he presses it back against your bud. It doesn't take much and soon his finger is inside you. He gives it a slow wiggle and smiles at your reaction before saying, \"<i>Damn you're tight.</i>\"");
					outputText("\n\nWith the pipe in hand you take a deep relaxing hit. Andy retracts his single finger and you watch him spit shine two digits this time. When he twists his fingers into your hole you flinch again and this time he just widens his fingers, forcing your body to wiggle, \"<i>So warm, so nice.</i>\" He croons as he leans up and begins licking your erect [nipple], his other hand wrapped around your waist as he slowly fucks you with his fingers.");
					outputText("\n\nThen with his voice bleeding with desire he asks, \"<i>Can I make you cum?</i>\" to which you respond with an eager nod. The pressure in your rectum intensifies as he begins shoving his two fingers in and out of your [ass] with gusto, so hard and fast that you can hear his fist landing on your [ass]. Cringing and screaming you cum. Your spasming anal sleeve is the only signal Andy needs and as you lay there twitching he grabs the pipe and takes a deep drag, his big cock wet with his own release, he must have been jerking his cock while he fingered you. As the smoke blows you see the unmistakable shape of your own form tossing and turning through the air.");
				}
				else if (player.ass.analLooseness < 4) { //Loose
					outputText("\n\nAs a single soft finger presses against your [asshole] you give the satyr a soft huff, \"<i>Oh ok, just checking.</i>\" He says before sliding three fingers into you. You sigh as the fingers wiggle around inside of you, reaching for you little internal love button. The moment he finds it Andy tickles and teases it, gently manipulating it until you're twitching with need. You snap at him, telling him to stop playing.");
					outputText("\n\n\"<i>Yes [sir].</i>\" is his only response before he retracts his three fingers and spits into his hand three times. When his spit lubed fingers return he hands you the pipe. Now that his fingers are moving through you at a quicker pace you realize just how big Andy's hands are. You take a deep relaxing hit, a smile spreading your face as you let the satyr work.");
					outputText("\n\nThen he adds a fourth finger, his spit soaked digits widening and massaging their way into your body. You're trembling again and Andy looks up, asking for your permission again. You give the littler satyr the go ahead with another nod and he curls his thumb and dips his whole hand into your [asshole], stretching it and pushing you over the edge. Cringing and screaming you cum. Your spasming anal sleeve is the only signal Andy needs and as you lay there twitching he grabs the pipe and takes a deep drag, his big cock wet with his own release; he must have been jerking his cock while he fingered you. As the smoke blows you see the unmistakable shape of your own form tossing and turning through the air.");
				}
				else { //Gaping
					outputText("\n\nAndy takes one look at your [asshole] and speaks up, \"<i>Is it ok if I try something?</i>\" He asks. Curious you ask him what it is and when he tells you it's a surprise you shrug and give him the go ahead. He hands you the pipe and tells you to take a deep drag. As you do he spits on his hand a few times before he begins working his spit shined fingers into your [asshole]. Soon there is a tightly clenched fist inside you, stretching. Cringing and screaming you cum. Your spasming anal sleeve is the only signal Andy needs and as you lay there twitching he grabs the pipe and takes a deep drag, his big cock wet with his own release; he must have been jerking his cock while he fingered you. As the smoke blows you see the unmistakable shape of your own form tossing and turning through the air.");
				}
			}
			outputText("\n\nAndy helps you to your feet, and gives you a quick embrace, \"<i>Gotta get back to work.</i>\" He says before grabbing his shirt and leaving you to redress.");
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function dontSmokeItsBad():void { //Remember kids, don't do drugs!
			clearOutput();
			outputText("With a shake of your head you tell Andy you don't want to smoke today. He doesn't press you about it, he simply flicks the lighter and pulls the little glass pipe towards his mouth. He stops midway and looks over at you. One of his dark eyebrows rises as he says, \"<i>Well um… you can stay if you want. I'm just gonna take a quick couple hits and head back to work. It'd be cool to have someone to talk to though, I feel kinda weird smoking alone.</i>\"");
			outputText("\n\nWhat will you do?");
			menu();
			addButton(0, "Stay", stayAfterNoSmoke);
			addButton(1, "Leave", leaveAfterNoSmoke);
		}
		
		private function stayAfterNoSmoke():void {
			clearOutput();
			outputText("You tell the satyr that you don't mind staying and keeping him company.");
			outputText("\n\nHis face brightens, \"<i>Well alright… have a seat my friend.</i>\" He says before looking down at his filled pipe. He ignites the coals and gives the smoke-like vapor a second to fill the chamber. Once it does he pulls the pipe to his lips and takes a deep pull. He looks at you as he holds it in his lungs, a wry little smile on his masculine face. Then he opens his mouth and begins blowing hoops of smoke out into the air.");
			outputText("\n\n\"<i>I love this shit. I remember when my dad used to smoke this stuff. He's the one who showed me the ropes and he still grows the plants I use. He's sort of like my supplier.</i>\"");
			outputText("\n\nHe used to say that it was a shame that other satyrs don't care about this stuff. A lot of satyrs like to drink beer and just fuck all day. They sit around jacking off or playing with their boy pussy and getting fat which is fine for them but I like looking good, I like feeling good, I like being wanted…</i>\" He looks up at you, \"<i>I like to serve.</i>\" The satyr's eyes have gone down to your groin.");
			outputText("\n\nHe licks his lips before taking another hit from his pipe. He doesn't bother with any smoke tricks and when he exhales, a thick cloud of odd smelling smog forms that leaves him laughing. \"<i>Most satyrs don't even bother with oral, they just want to get to the point, ya know? They want to cum, they want to get you nice and big and pregnant so that you'll have a son that they can fuck. My dad was refined, for a satyr. He taught me so many things, more than just how to knock something over so that you can rape it.</i>\"");
			if (player.hasCock()) {
				outputText("\n\nHe wears this silly little smile as he speaks, \"<i>I remember this wolfy dog guy who used to be some sort of adventurer. He had a big knotted cock and he loved to shove it in my mouth, I'd play with his knot and his big fuzzy balls. He's the reason I got this.</i>\" He spreads his legs and nods his head towards the knotted dog cock at his groin, stiff and standing tall.");
				outputText("\n\n\"<i>He wasn't the only one either, I love having cocks in my mouth. The taste, hearing the guy or girl groan, whether they grab my horns and shove it in or just let me work, I love to make them feel good, and then they reward me with a nice big salty surprise.</i>\" He glances towards [eachCock], hidden by your [armor]. He hasn't made any direct offer but you're pretty sure he wants to wrap those lips around [eachCock].");
			}
			if (player.hasVagina()) {
				outputText("\n\nHe takes another drag and this time he blows hoops again, \"<i>I love girl bits... I don't know what it is about a good wet pussy but I love having one shoved against my face. It might be the taste, each one tastes different. I love feeling the fluid gush into my mouth as she, or sometimes he, you never know, screams above me.");
				outputText("\n\nAnita is a squirter and she will drench a man, or woman, from head to toe. It's not even hard, you just have to lick it long enough and she starts gushing like a geyser.</i>\" He chuckles at his anecdote. \"<i>I like the way she tastes though. It's weird she's not at all bitter, like melted candy… come to think of it I really haven't found one that tastes bad.</i>\" He grins as you cringe slightly, thinking of having him taste you.");
			}
			outputText("\n\n\"<i>Asses are nice too. I like knowing how people react to having my tongue pressed against their rear door. It's one of those little pleasures people don't expect to like. There's something about having a nice hot ass grinding into my lips, bouncing on my tongue. Eating ass is an art my dad used to say. It's something that can be easily done with just a swirl of the tongue but only a master can bring someone to orgasm with just a rimjob. I used to practice on this tiger guy somewhere around here. He was pretty rough, shoving and pushing against my tongue. He would talk shit and curse and complain… but he loved it. We only stopped when he started playing poker with these other guys; he's a bit of a bitch nowadays. He doesn't let anyone near those gorgeous globes from what I hear. It's a pity too, that was one nice ass.</i>\"");
			outputText("\n\nHe looks up at you expectantly and you have to admit you got a little horny listening to his stories and his past. What do you want him to do now?");
			dynStats("lus", 20, "resisted", false);
			menu();
			if (player.hasCock()) addButton(0, "Suck my Cock", haveAndySuckYouOff, null, null, null, "Have Andy suck you off.");
			else addButtonDisabled(0, "Suck my Cock", "You'll need a cock to have Andy do this.");
			if (player.hasVagina()) addButton(1, "Lick my Pussy", haveAndyLickYouOut, null, null, null, "Have Andy lick your pussy.");
			else addButtonDisabled(1, "Lick my Pussy", "You'll need a vagina to have Andy do this.");
			addButton(2, "Rim my Ass", haveAndyRimYouOmgItsGross, null, null, null, "Have Andy rim your ass. \n\nNOTE: Contains rimjob! You have been warned.");
			addButton(4, "Do Nothing", declineAndyOral);
		}
		
		private function haveAndySuckYouOff():void {
			clearOutput();
			outputText(images.showImage("andy-sex-blowjob"));
			outputText("He looks at you with his boyishly cute face surrounded by a cloud of curly dark brown hair. You begin pulling off your [armor] so as to free your [eachCock]. As you do Andy's mouth drops.");
			outputText("\n\nWith a lick of your lips you wrap a fist around your [cock] and begin to smear drops of pre-cum across your [cockHead] with your thumb. You make a show of stroking yourself, squeezing your [cock] and releasing soft sounds of pleasure. You look up to catch an awestruck Andy. His mouth hangs open and his knotted dog cock is quickly growing to full length.");
			outputText("\n\nYou wag your dick at him to display your impatience; he gets the message. It's as if he has snapped out of a trance the way he suddenly tugs his shirt off and kneels before you with the reverence of a servant bowing before his " + player.mf("king", "queen") + ". With patient hands he reaches forward, taking your [cock] out of your hand and holding it out with a firm grip as his lips descend.");
			//Cocks check
			if (player.findFirstCockType(CockTypesEnum.DOG) >= 0) {
				outputText("\n\nThe satyr smiles down at your dick as if it is an old treasured friend. With a look of utter bliss he drags his tongue up the belly of your shaft, reaching your [cockHead] and pressing against it with his soft lips. He kisses your [cock] again and again, leaving a wet trail down to the sensitive bulbous knot. You shudder as he nibbles at the swollen gland with gentle lips. He sucks off of it with a pop, sending a twisting cringe throughout your entire body.");
			}
			else if (player.findFirstCockType(CockTypesEnum.CAT) >= 0) {
				outputText("\n\nThe satyr uses his long tongue to tickle and tease each of the tiny barbs on your [cock], taking the time to swirl his tongue around each singular fleshy hook in a whirl of sensations that cause your breath to strain its way out your mouth. Looking down you can't help but chuckle at the drool leaking down the sides of his face as he liberally coats your [cock] with satyr spit.");
			}
			else if (player.findFirstCockType(CockTypesEnum.HORSE) >= 0) {
				outputText("\n\nThe satyr uses his hands to twist around the segmented parts of your [cock]. He smiles as he begins teasing your [cockHead], tracing the cum slit with his tongue while his hands glide across your flesh in mind numbing twisting motions.");
			}
			else if (player.findFirstCockType(CockTypesEnum.RHINO) >= 0) {
				outputText("\n\nAndy chuckles fondly as his hands slide down to either side of your [cock]. Soft hands firmly massage the ridge on either side of your shaft. You groan as the sensation intensifies. Then his mouth is on you, a single hot wet tongue dragging up and down the belly of your [cock] and causing you to convulse each time he completes a circuit.");
			}
			else if (player.findFirstCockType(CockTypesEnum.LIZARD) >= 0) {
				outputText("\n\nAndy kisses your shaft at the base, pulling off with a wet pop. When his lips return he slides up the side of your [cock] with a serene expression. Then his thumbs rubs against your sensitive [cockHead], swirling your pre-cum around the sensitive area. As he swirls your pre-cum and slobbers up your schlong, your hips jerk of their own accord and there is nothing you can do to stop them, not that you would if you could.");
			}
			else if (player.findFirstCockType(CockTypesEnum.TENTACLE) >= 0) {
				outputText("\n\nAndy presses his tongue flat against the belly of your [cock]. With exaggerated slowness he drags up to the [cockHead]. Then he takes it in both hands and begins massaging his lubricating spit into your tender flesh. Thumbs firmly press up the belly of your [cock], a teasing sensation that causes your living pecker to go ballistic. As the satyr brings you to the edge and keeps you there each touch becomes an agonizing heaven until you wrap your hands in his hair and pull him down to let your [cock] tunnel into his throat and roughly fuck his lips. Once you release him he gags off your [cock] and you both watch it wiggle around in exalted triumph.");
			}
			else {
				outputText("\n\nThe satyr's tongue does a little swirl around your [cockHead], the wet muscle tracing the contours of your flesh. He lashes his tongue across the cum slit and nibbles your [cock]'s belly with his lips, suckering the exposed skin and creating a wet squelching sound.");
			}
			//Vagina check
			if (player.hasVagina()) {
				outputText("\n\nHe wraps a fist around your [cock], pumping up and down the tender flesh as he leans in to kiss your [vagina]. He tickles your [clit] with his tongue and kisses your lips with his own before lapping up the juices, further teasing you as he drinks from your pussy like a man dying of thirst.");
			}
			//Balls check
			if (player.balls > 0) {
				outputText("\n\nThen, while holding your [cock] up and out the way, he lifts your [balls] with his eager tongue. Gentle lips tug at your orbs with the tenderness of a lover's kiss and you can't help the deep groan that pushes your voice to the sky and clouds. You hear a hoop; someone walking by heard you and whoever she is she obviously enjoyed your voice. You let your head fall back into the barrels behind you as the tingling sensations of his ball sucking cause you to tremble. The satyr dutifully continues to slather your heated sac until you can take no more.");
			}
			outputText("\n\nYou tell Andy Mathis to stop teasing you and he nods.");
			if (player.biggestCockLength() < 7) {
				outputText("\n\nHe sucks your entire length in without a problem, humming around your [cock] as he holds it between his lips. With a pop he pulls off, sending a thundering jolt of pleasure through your spine. He then begins bobbing up and down with an unending moan vibrating your [cock]. Your hands slide to his ears where you rub the lobes, causing a keening sound to to come from his cock filled lips. He doubles down on your dick as you play with his ears and before long you begin to feel that familiar tingle.");
			}
			else if (player.biggestCockLength() >= 7 && player.biggestCockLength() < 12) {
				outputText("\n\nHe sucks himself onto your [cock] until it hits the back of his throat. With a swallow your [cockHead] is engulfed in the tight wet confines of Andy's throat. Your hips buck, causing the satyr to gag. You hear air rushing into his nose as he takes a deep breath, his nose buried in your pubic region as his throat massages your [cock]. With a groan he vibrates your [cock] and sends another convulsion through your body. Still making pleased sounds he begins bobbing up and down your entire length with no difficulty. You watch spit fly as your [cock] repeatedly disappears and your glands are wrapped in hot lips, wet tongue and tight throat over and over until you're shuddering on your improvised seat, a familiar tingle working its way through your [cock].");
			}
			else {
				outputText("\n\nAndy opens his mouth as wide as he can as he guides your [cock] towards his mouth. You feel the heat of his breath bathing your trunk as he slowly sucks you in. When you reach the back of his mouth he stops. Looking up at you with arrogant eyes he swallows, and suddenly your [cockHead] is engulfed in the tight confines of his throat. This causes an uncontrollable thrust to flinch into your hips and choke the satyr. Spit floods your lap[if (hasBalls = true) \"<i>and [balls]</i>\"] as the satyr forces himself to stay in position. Once he's regained himself he presses onward, obviously determined to suck your entire length into his hungry lips. After a few minutes he manages a foot of your [cock] and you feel a groan of frustration shake through his lips when he opens his eyes and sees there's still some [cock] left to choke on. He slurps back up to your [cockHead] and dives back down, only able to fit a foot of your dick into his gorgeous pink lips. A foot is enough, because once he reaches top speed you can't help pushing into him, gagging and choking him with every thrust. The fact that he can't fit your entire length inside his mouth seems to both turn him on and frustrate him. To compensate he hums, making you twitch and pushing your voice high into the sky as a familiar tingle begins creeping up your [cock].");
			}
			outputText("\n\nReaching down you pull the satyr's face into your [cock] and shove forward. [if (cock > 12) \"He flails as you force the rest of your [cock] into him with a snarl. His eyes say it all; he's proud of himself. He takes a deep whiff of your pubic region as you tremble against him.\"]");
			outputText("\n\nWith your mouth open in a silent scream you unload straight into the satyr's belly.");
			if (player.cumQ() >= 1000 && player.cumQ() < 2500) outputText("\n\nWith his lips corked by your spasming [cock] the satyr's trim muscular stomach swells until he looks pregnant.");
			else if (player.cumQ() >= 2500) outputText("\n\nWith his lips corked by your spasming [cock] the satyr's belly floods with your baby batter, expanding his stomach until he looks like he's about to give birth to a litter of your babies.");
			outputText("\n\nFeeling spent you give the satyr a pat on the head and stand. He sits there licking his lips and rubbing his face. [if (cock > 12) \"He makes a show of rubbing his throat and belly as well.\"] You tell him you're leaving and he tells you, \"<i>Until next time.</i>\" his breath reeking of your jizz as you leave him to nurse his belly full of cum.");
			player.orgasm();
			dynStats("sens", -1);
			flags[kFLAGS.BLACK_COCK_ANDY_ORAL_GIVEN]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveAndyLickYouOut():void {
			clearOutput();
			outputText(images.showImage("andy-sex-cunnilingus"));
			outputText("You grin as you look upon that boyishly cute face, those polished horns and the cloud of curly brown hair. The little satyr is adorable you must confess, and the thought of having his mouth on your [vagina] is making you hot. So without a word you begin pulling off your [armor] and watch his mouth drop. As your form comes into view you watch him fall to his knees, almost bowing before you in awe.");
			if (!player.isTaur()) {
				outputText("\n\nYou smirk down at him, \"<i>Well… have a taste.</i>\" You say and he leans forward with tongue outstretched, arms wrapping around your lower half as the surprisingly strong satyr stands, lifting you into the air as he presses his lips into your [vagina].");
				outputText("\n\nThe heated caress of his lips pulling at your [vagina] as he sucks at your [clit] sends a hoarse call trembling up into the air. Wet lips tug and nibble at the sensitive love button. He holds you up as you grind your [pussy] into those lips, reaching down to hold onto his smooth horns.");
				outputText("\n\nHe hums and you find yourself trying to merge his vibrating lips with your nethers as your [legs] wrap around his neck. You lean back and find yourself being gently placed on a barrel. You convulse as his tongue begins tracing the tender contours of your feminine opening despite the fact that you're probably cutting off his oxygen.");
			}
			else {
				outputText("\n\nYou turn your back to him and wiggle your [ass] at him before saying, \"<i>Well… have a taste.</i>\" That's when hands spread your [ass] and a face is shoved into your [vagina].");
				outputText("\n\nThe heated caress of his lips pulling at your [vagina] as he sucks at your [clit] sends a hoarse call trembling up into the air. Wet lips tug and nibble at the sensitive love button with the fevered need of a desperate man. Soft hands rub your [ass] as you grind your [pussy] back against those lips. He hums and you find yourself screaming as you push back with greater need. You convulse as his tongue begins tracing the tender contours of your feminine opening.");
			}
			outputText("\n\n\"<i>So good.</i>\" he says as he begins slurping your [pussy], \"<i>You taste like heaven, I love it.</i>\" He rubs his face into you, bathing his chin hairs in your wet opening before his tongue laps at you again and again before stretching lips suck the juices from your cunt like some natural cup full of his favorite beverage.");
			player.orgasm();
			flags[kFLAGS.BLACK_COCK_ANDY_ORAL_GIVEN]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveAndyRimYouOmgItsGross():void {
			clearOutput();
			outputText(images.showImage("andy-sex-rimjob"));
			outputText("With a grin on your face you ask him how much he really likes eating ass.");
			outputText("\n\nAndy actually blushes, \"<i>Don't say it like that. I feel like you're teasing me.</i>\" he chuckles, \"<i>...but yeah. I love it, nothing like it. I can lick and stick and play in an ass all day long.</i>\" Then with a mischievous grin you tell him to prove it.");
			outputText("\n\nAndy bites his lip as you begin to shed your [armor], revealing your body with exaggerated slowness as you watch his dog cock twitch in anticipation.");
			outputText("\n\n\"<i>Oh hell yes.</i>\" He gasps, licking his lips as his eyes travel southward. Turning away you present your [ass] for his viewing pleasure.");
			outputText("\n\nYou feel hands glide onto your waist. Soft fingers slide against your " + player.skinFurScales() + " and lift your [ass] spreading your " + player.skinTone + " cheeks apart to reveal your [asshole]. You feel a cool dollop of spit silently land on your [ass] and slide down your crack, a teasing tingle of wetness that makes your ass flex. Before the spit slides much lower than your pucker you feel a tongue press into your taint and lick upwards, wiping a wet swath up your [ass].");
			outputText("\n\nYou bite your lip as he begins to lick up and down, his tongue playing in your [ass] like a kid at a playground. He kisses your exposed cheeks, he nibbles at your taint with soft wet lips. You tremble, you gasp and you can't help pushing backward as he teases you into frenzy. A hand lands on your [ass] with a hard smack, and then another. He grabs as much extra skin between his hands as he can and stiffens his tongue.");
			outputText("\n\nAs he begins tongue fucking your [asshole] you can't help pushing back against his tongue, against that wet elation inducing muscle so talented you're singing. Those wet lips begin to nibble and suck, coming off your [asshole] with hard pop before repeating the process. It is bliss unending as he continues to loudly pop, pop, pop against your quivering [asshole].");
			outputText("\n\nYou're cringing and convulsing, you're out of control and every sensation is a reminder of who really runs this show. Not Andy or you or your ass… it's that tongue, it's those lips, it's the mind blowing waves of pleasure breaking through your body like a tidal wave. The sloppy slurp, slurp, slurps and tingling shudders have you almost crazed with need.");
			if (player.hasCock()) {
				outputText("\n\nYou reach down and wrap a fist around your [cock], tugging it in a familiar and comforting motion as Andy slobbers and suckles your [asshole] with two hands pulling your [ass] into his face.");
				outputText("\n\nWith a stuttering scream you cum, spilling your seed onto the barrels beneath you as you reach sweet release.");
			}
			else if (player.hasVagina()) {
				outputText("\n\nYou reach down and slide a single digit into your [vagina] as Andy tongue fucks your [asshole]. Soon the single finger is joined by others as your dripping [pussy] begs for attention.");
				outputText("\n\nWith a stuttering scream you cum, spilling your juices onto the barrels beneath you as you reach sweet release.");
			}
			else {
				outputText("\n\nYou scream as your [asshole] is violated, waiting for the slowly torturously building release. Your hands become claws and your [ass] presses back with desperate need. Then it happens, like taking a step off a cliff the slow build is suddenly an extreme cacophony of sensation and you're left trembling and weak in his wake.");
				outputText("\n\nWith a stuttering scream you reach sweet release, intense pleasure surging throughout your body.");
			}
			outputText("\n\n\"<i>So how was it?</i>\" Andy asks, a smile on his face.");
			outputText("\n\nYou hold up a finger, asking for a moment as you wait for your body to calm down. Once you're relaxed enough to answer you tell him how much you liked having his big wet tongue inside your [ass].");
			outputText("\n\nHe smiles big, \"<i>Good, we should do this again.</i>\" With that the two of you say your goodbyes and you leave The Black Cock.");
			player.orgasm();
			dynStats("sens", 1);
			flags[kFLAGS.BLACK_COCK_ANDY_ORAL_GIVEN]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function declineAndyOral():void {
			clearOutput();
			outputText("Despite his obvious flirtation you're not really interested in his oral skills at the moment. After a few seconds of awkward silence he takes one last deep drag and blows more smokey shapes. The pleasing scent washes over you whenever he does and soon you're light headed and happy. After chatting with the satyr about nothing important he decides he has to get back to work. He lets you out of the large swinging gate and you wave goodbye as you depart for camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function leaveAfterNoSmoke():void {
			clearOutput();
			outputText("You tell the satyr that you think you'd best be leaving. He smiles as he toys with his lighter before saying, \"<i>Alright… Feel free to come back whenever you want [name].</i>\"");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function rompUpWithAndyTheSatyr():void {
			clearOutput();
			if (flags[kFLAGS.BLACK_COCK_ANDY_SEX_COUNTER] == 0) {
				outputText("You tell Andy that you’d like to accompany him out back.");
				outputText("\n\nHe nods, tucking his pen behind his ear and his pad into a band of leather strapped to his shoulder. As he does this you get a good look at his sheath and balls, idly wondering at the size of the dick concealed within. When he turns away you can’t help quietly appraising his ass, the soft little globes with a flitting little goat tail just above them.");
				outputText("\n\nOnce the two of you reach the back tent flap he holds up a hand, silently telling you to stop, \"<i>Ok so I’m supposed to be working right now and I don’t want my boss to see me leave. So be careful... and quiet.</i>\" You nod and the two of you sneak past the rhino morph cook.");
				outputText("\n\nThe area behind The Black Cock has a high wooden fence with a big gate you suppose could be used to receive deliveries. Directly across from you lies a stack of barrels and off to the side is a huge waggon.");
				outputText("\n\nOnce the two of you enter the back area he directs you to stand near the barrels as he climbs up into the waggon to retrieve his extra product. As he does this you spy a barrel on its side that would be perfect for your plans.");
				outputText("\n\nYou reach out and grab his hand, pulling him back and telling him that that’s not what you wanted. Andy’s eyes are round like saucers as he turns toward you, a thick dog cock quickly rising out of his sheath. You tug at his shirt, a silent suggestion that he should disrobe. You watch as he pulls it off too fast, getting it stuck around his horns in his eagerness to do as you ask; it seems he likes being given direction. You can’t help but laugh as he struggles with the uncooperative cloth, his leaking erection wagging around as he tugs. His abs are everything his muscular arms promised. Once he extracts the cloth from his horns he tosses it aside and, without missing a beat, steps toward you as if nothing happened. He presents himself to you with spread arms, pierced nipples and a smile. All of which does nothing to hide the embarrassed blush creeping up his cheeks.");
			}
			else {
				outputText("You tell Andy that you’re going to accompany him out the back. You make sure to give him a suggestive look, your [eyes] glancing at his fuzzy balls just long enough to see the angry red tip push through the slit of his sheath. He gives you a conspiratorial grin. He once again sneaks you out the back, dog cock hanging out as you follow him, watching his soft little fuzzy cheeks move against one another.");
				outputText("\n\nOnce the two of you sneak past the rhino cook and go out into the fenced in back portion of The Black Cock he pulls off his shirt, revealing his finely toned abs and pierced nipples.");
			}
			menu();
			if (player.hasCock()) addButton(0, "Fuck Him", fuckAndyTheSatyr, null, null, null, "Take Andy from behind and put your cock to good use.");
			else addButtonDisabled(0, "Fuck Him", "You will need a penis for that.");
			addButton(1, "Get Fucked", haveAndyFuckYouPrompt, null, null, null, "Get Andy to fuck you good!");
		}
		
		private function fuckAndyTheSatyr():void {
			clearOutput();
			outputText(images.showImage("andy-sex-analpitch"));
			//Height
			if (player.tallness < 64) outputText("You look up into Andy’s eyes and tell him you’re going to be fucking him today. He smiles as he looks down into your eyes and says, \"<i>So long as you fuck me hard, lil’ " + player.mf("guy", "gal") + "..</i>\" He obviously likes the idea of having your [cock] stuffed into his tailhole; you’ll have to oblige him and fuck the cocky bastard as hard as you can for insinuating that your height might be a problem.");
			else if (player.tallness >= 64 && player.tallness < 68) outputText("You look straight into Andy’s eyes and tell him he’s going to be taking your [cock] today. He nods as you grab his trim waist and says, \"<i>Yes " + player.mf("sir", "ma'am") + "</i>\". From the way his dick jumps at the brief contact you can tell he quite likes the idea of you stuffing your [cock] into his tailhole.");
			else outputText("You grab Andy by his polished horn and make him look up, tearing his gaze away from your body and directing it toward your face. His mouth drops open as you tell him you’re going to be fucking his little satyr ass today and his only response is a husky, \"<i>Oh fuck yes.</i>\" You can see his little knotted dog dick twitch at the thought of you ramming your [cock] into his tailhole. When you release his horns he rubs the spot with a smile; he is obviously a fan of the rough treatment, and maybe even a little giddy about you being taller than him.");
			//Taur or not?
			if (player.isTaur()) {
				outputText("\n\nYou begin removing your [armor] slowly, sensually revealing your bare form. Andy quietly massages his leaking doggy dick as he watches, eyes hypnotized by your bare flesh. All you have to do is nod towards the barrel and the satyr climbs atop it, face down and ass in the air with his tiny little tail wagging in delight. His back is perfectly arched and his soft round ass cheeks spread, revealing a black rosebud winking in invitation. You give [eachCock] a quick flex before sliding your [cock] against the satyrs hungry derriere. He presses back, his plump rump obviously inviting you to tunnel into his soft little bud to your heart’s content. Arching your own back you thrust forward and slide up his crack. All it takes is a single order and the satyr reaches back and guides your erect length into his ass.");
				if (player.biggestCockLength() < 7) outputText("\n\nAs you sink into the satyr’s warm depths you hear a huff. The little bastard doesn’t sound too impressed. Well you’re gonna have to correct that aren’t you? As a reward for his dissatisfaction you begin to pound the little asshole as hard as you can. First he releases an uncomfortable grunt of surprise. As you continue to wreck his hole Andy begins clawing at your front legs as he struggles to maintain his footing. Meanwhile above him you are relishing in the way his soft ass molds around your dick, allowing you to shove your entire length into his cum tunnel with every downward stroke.");
				else if (player.biggestCockLength() >= 7 && player.biggestCockLength() < 13) outputText("\n\nAs you push into the satyr’s hot little tail hole you hear a groan. He shoves his little soft rump back against your [cock] like he can’t wait for you to fuck him hard. With a smile you begin working your back half, shoving your [cock] into the little guy as roughly as you can. You feel him spreading his fuzzy ass cheeks, pulling them apart as you wreck his back door with hard full length strokes. His voice comes out in grunts as his body shivers around your [cock]. Soon he can maintain his composure no longer and he’s clawing at your front legs, screaming for more as you wreck his ass with every downward stroke.");
				else outputText("\n\nAs you press into the little guy’s back door he grunts, sounding uncomfortable as your [cock] penetrates his tight tail hole. A sudden flinch sends your cock sliding up his crack. You feel his hand reach back and hold you to his entrance. He apologizes and tells you he’s ready again. With a smile you press forward, he does his best to remain motionless as you slowly rock back and forth. Then, with a goat-like bleat, your [cockHead] pops into the little guy’s tight hole. With a roar of triumph you begin fucking Andy’s ass hard. He screams with every incursion, even as he shoves his hot little rump back against you. His cum tunnel is a hot sleeve of bareback bliss as you pound him into submission with deep, soul shattering strokes that have him begging you to never stop.");
				outputText("\n\nAfter a while of filling up his back door you begin to feel a familiar pressure building. ");
				if (player.balls > 0) outputText("Your [balls] churn with your need for release as hot tingles shoot up your spine. ");
				if (player.hasVagina()) outputText("Even your [vagina] feels fit to explode as you mercilessly pound the sexy little satyr’s furry rump.");
				outputText("\n\nAndy’s ass is hot bliss wrapped around your [cock]. Suddenly the rectal sleeve begins to clench around your [cock]. Every spasm tells you the guy’s in the middle of his own orgasm. With clenched teeth you force your dick in and out of his clenching cum tunnel, the added tightness pushing you over the edge. Your voice comes out in a hoarse soul shaking groan as [eachCock] explodes. ");
				if (player.cockTotal() > 1) {
					outputText("[eachCock] spits hot white semen, most of which travels through your [cock] and inseminates Andy’s upturned backside. ");
					if (player.cumQ() >= 2500) outputText("His belly swells dangerously as each of your dicks spits, creating a puddle of mixed man cream as Andy passes out beneath you. ");
				}
				else {
					outputText("You hold your [cock] deep inside Andy’s wrecked hole, pressed against him like a husband and wife snuggling for warmth. Your body trembles like a scared mouse as you unload into his tightly clenching bowels. ");
					if (player.cumQ() >= 2500) outputText("From your vantage point above the two of you you can see Andy’s belly swelling dangerously. Baby batter leaks from his wrecked hole as well, creating an impressive puddle while making him look pregnant at the same time. ");
				}
			}
			else {
				outputText("\n\nYou begin removing your [armor] slowly, saving the reveal of [eachCock] for last.");
				if (player.biggestCockLength() < 7) {
					outputText("\n\nAs you pull out your [cock] Andy’s shoulders slump for a moment but he falls to his knees and sucks your rigid length into his mouth regardless of how he feels about your size. ");
					if (player.cockTotal() == 2) outputText("He takes your remaining [cock 2] into his hand and fists it with a sure and practiced hand. ");
					else if (player.cockTotal() > 2) outputText("He takes two of your remaining dicks and fists them with two sure and practiced hands. ");
					outputText("He hums as he sucks you in, drool leaking from the side of his mouth as you grab his curly hair and pull his talented mouth up and down your [cock], fucking his face hard due to his reaction to your size.");
				}
				else if (player.biggestCockLength() >= 7 && player.biggestCockLength() < 13) {
					outputText("\n\nAs you reveal [eachCock] Andy gives you an approving grunt as he falls to his knees and takes your [cock] into his mouth with the hungry slurp of a dick loving slut. In one deft motion he sucks your entire length in, his throat muscles massaging your [cockHead] as he smashes his face against your trunk. ");
					if (player.cockTotal() == 2) outputText("He takes your remaining [cock 2] into his hand and fists it with a sure and practiced hand. ");
					else if (player.cockTotal() > 2) outputText("He takes two of your remaining dicks and fists them with two sure and practiced hands. ");
					outputText("\n\nHe doesn’t choke or gag or even flinch when the sensation of his dick pleasing machinations cause you to thrust into his mouth. Throwing caution and decorum to the wind you grab a fist full of curly hair and pull the little sub up and down your [cock], roughly fucking his throat as strings of spit fly off the blur that is your [cock].");
					
				}
				else {
					outputText("\n\nAs you reveal your [eachCock] Andy’s jaw drops. Your [fullChest] swells with pride as he falls to his knees like a reverent priest praying at a treasured alter. He wraps a trembling hand around your [cock] and pulls it to his lips. He gags as you greedily shove forward but the little satyr sub doesn’t give up; he accepts your challenge and begins to furiously bob up and down the length of your [cock], fighting through the gagging sensation until he’s able to take about a foot of your dick into his hungry mouth.");
					if (player.cockTotal() == 2) outputText("He takes your remaining [cock 2] into his hand and fists it with a sure and practiced hand. ");
					else if (player.cockTotal() > 2) outputText("He takes two of your remaining dicks and fists them with two sure and practiced hands. ");
					outputText("\n\nOn a whim you wrap twin fists around the base of his polished black horns, a greedy smile spreading across your [face]. He stops, looking up into your eyes and silently begging you to do exactly what you’re about to do. With a snarl you begin fucking his face as hard as you can, listening to him choke and gag as you force his mouth wide and pump your [cock] deep into his throat. ");
					if (player.cockTotal() > 1) outputText("He even drops your other dicks as he grabs your [legs] and lets you soundly and deeply fuck his throat.</i>\" You feel his voice vibrate your dick as he groans and his face jerks, but looking down at him, you see pure and utter bliss in his happy face with tears leaking down the side as you pump his mouth full of [cock].");
				}
				outputText("\n\nYou have to tug Andy Mathis off your [cock] to keep from filling his belly from the wrong end. As you do you remind him that you wanted his ass, even though his mouth was a nice treat.");
				outputText("\n\nWithout rising he leans back and tucks his hands behind his legs, firmly lifting his little furry satyr rump so you can see his little hungry black cherry. You give his sexy little cheeks a hard slap and watch the fuzz covered skin ripple; it feels soft and perfect for a quick hard fuck. As you grab your spit covered [cock] and aim it for his rear entrance his tail flits about and he bites his lip; he’s ready. With a feral grin down at your temporary lover you aim your spit shined cum filled trouser snake at the horny little sub’s hungry ass and dive right in.");
				if (player.biggestCockLength() < 12) {
					outputText("\n\nAs you sink into the satyr’s fuzzy little rump he croons, lifting his legs as he smiles up at you like an eager kid being given a new toy. You look down at the little happy sub and pull your rigid shaft out until nothing but the head remains, then shove forward in a sudden hard thrust. You watch his reaction, pleased to see his eyes roll back into his head as you grind your [cock] around inside him. When you begin fucking his fuzzy rump with vicious body jarring strokes he begins to convulse. Each powerful thrust sends a clap through the air and forces a sheep-like bleat from his howling maw. Then his hungry ass begins to flutter and clench around your madly fucking [cock]. With one long bleat the satyr ejaculates, his knotted dog dick firing ropes of funky seed onto his fuzzy chest as you continue to wreck his ass, working like a madman towards your own release. He gives you a tired grin as he looks up at you, obviously happy you came.");
				}
				else if (player.biggestCockLength() >= 12 && player.biggestCockLength() < 19) {
					outputText("\n\nAs you push into the satyr’s fuzzy little tight ass he grunts, shifting slightly as he bites his lip and looks up at you with a cocky, daring look. He reaches up and pulls your [face] into his without warning, kissing you deeply as you work your [cock] into him. Once you’ve pushed a foot of your [cock] into him he jerks away and releases a whoosh of air, his breath smelling like fine wine. You feel the light hair on his arm tickling your back as he holds you close, grunting as you work your full length into him until you’ve fully hilted the little guy.");
					outputText("\n\nHe clutches you as if holding on for dear life until you begin to pry his arms from around your body and lift your [fullChest] from his. He tries to smile up at you but your [cock] has him gritting his teeth. His ass is insanely tight, holding you where you are as the little sub shivers. Without warning you watch a funky stream of hot baby batter shoot from his doggy dong, and then another and yet another still. He cums and cums and cums until his fuzzy chest and belly are covered in criss crossing streams that pool around his gorgeous abs. He pants like a dog, his clenching hole finally giving out and allowing you to begin working towards your own release. With a grin you shove his legs into his jizz splattered chest and draw your [cock] out until the only thing still inside the blissfully tight hole is your [cockHead]. Soon you correct this by diving back into that hot little tail hole, thankful for the spit lube that allows you to fuck this little guy this hard. He grunts and groans at first, sounding uncomfortable. The next thing you know his hole is completely relaxed and he’s screaming for you to fuck him harder. You oblige, reaching top speed and listening to him bleat and groan as you fuck him in rough, body jarring strokes.");
				}
				else {
					outputText("\n\nAs you push your big bloated trouser snake into the satyr’s tiny tail hole he yelps, managing to pull his not-so-tight tailhole out the way. You can tell he isn’t a virgin but not experienced enough to easily take your entire length. Even so you know he can do it and even if he can’t he’s about to. You grab your [cock] and use your free hand to press down on the clasped fists keeping the satyr’s legs in the air and push. As your [cockHead] is pressed again and again against his ripe little cherry you watch his face contort in a mixture of pleasure and pain. Then he takes a deep, deep breath and suddenly you pop inside.");
					outputText("\n\nThe Satyr’s entire body convulses as he screams as if in intense pain as his dog dick erupts, sending gushing arks of funky satyr jizz into the air. The long ropes of potent seed land in his hair and on his face and shoulders and his fuzzy chest and finally his depleted and softening doggy dong flattens, the last of his copious load pooling inside his belly button. You can’t help but smile at the intensity of Andy’s orgasm, your [fullChest] swelling with pride at the knowledge of what you did with your size alone. Your [cock] reminds you that the only part of it inside the satyr is the head and with a grin you begin to push into the now completely relaxed back door.");
					outputText("\n\nAndy is delirious as you work your [cock] into his upturned rear. He babbles like a madman, making sounds that range between horror and elation. Ignoring his indecisive ecstasy you press onward. You can see the outline of your [cockHead] distend his stomach, your [cock] reaching into unexplored territory and reforming his body to suit your needs. You can’t help swirling your bloated baby maker around inside him, watching your [cockHead] move around inside the satyr and listening to the noises he makes.");
					outputText("\n\nYou finish playing and pull your [cock] halfway out before slamming it into the satyr. He bleats as you fail to fully hilt him, his body halting your progress and denying you the ability to completely submerge your [cock] in his tight little ass. When you begin fucking him with slowly mounting force he looks up into your face with eyes glazed over by pure bliss. Knowing that in his present state he can’t possibly not enjoy your [cock] tunneling through him you throw caution to the wind and begin fucking Andy for all you’re worth. His orgasm addled brain can only spread his legs and hold them to his chest as you watch your giant dong slam into his stomach over and over again.");
				}
				outputText("\n\nWith a groan your face contorts as you feel fluid working through [eachCock] as you pound the fleshy bunz of the little lust addled and cum covered satyr.");
				if (player.hasKnot()) {
					outputText("\n\nWith a hoarse yell you shove your knot into the satyr who gives a yelp as your [cock] spasms inside him, spurting into his now gaping love tunnel with a vengeance. ");
					if (player.cumQ() >= 2500) outputText("You watch with relish as the little guy’s stomach swells, your baby batter filling him up from the back door and pushing his still bent legs forward, forcing him to let them go. ");
					outputText("Andy Mathis looks up at you with a lazy smile as he holds his hand up, asking for a high five. With a chuckle and a shake of your head you give it to him before tugging your knot, uncocking his insides and letting your potent seed spread onto the floor. Feeling a little tired and sweaty you look down at your cum covered and lightly dozing fuck buddy, watching his chest rise and fall before you gather your [armor] and exit through the back gate, headed back for camp now that you’ve had your fill.");
				}
				else {
					outputText("\n\nWith a soul aching groan you shove your [cock] into the satyr and unload a massive torrent of your own batch of spunky jism. ");
					if (player.cumQ() >= 2500) outputText("Your body trembles as you soak his innards with blast after blast of ejaculent, some of which you can feel streaming down your [legs] as the little guy’s stomach swells with however much of your seed doesn’t fall into the puddle you’re creating below. ");
					outputText("Andy Mathis looks up at you with a lazy smile as he holds his hand up, asking for a high five. With a chuckle and a shake of your head you give it to him before tugging your [cock], out of his cum greased backside. Feeling a little tired and sweaty you look down at your cum covered and lightly dozing fuck buddy, watching his chest rise and fall before you gather your [armor] and exit the building out the back door, headed back for camp now that you’ve had your fill.");
				}
			}
			player.orgasm();
			dynStats("sens", -1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function haveAndyFuckYouPrompt():void {
			if (player.hasVagina()) {
				clearOutput();
				outputText("\"<i>Well alright... So you want me to fuck you? Which of your holes would you like me to fuck?</i>\" Andy prompts.");
				addButton(0, "Vaginal", haveAndyFuckYou, true);
				addButton(1, "Anal", haveAndyFuckYou, false);
			}
			else {
				haveAndyFuckYou(false);
			}
		}
		
		private function vagOrAss(vaginal:Boolean):String {
			if (vaginal) return player.vaginaDescript();
			else return player.assDescript();
		}
		
		private function haveAndyFuckYou(isVaginal:Boolean):void {
			clearOutput();
			if (isVaginal) outputText(images.showImage("andy-sex-vaginalcatch"));
			else outputText(images.showImage("andy-sex-analcatch"));
			const ANDY_COCK_AREA:int = 12 * 1.5; //18
			outputText("As Andy tosses his shirt back you lean forward and plant a wet kiss on his smooth pectoral, right next to the patch of fuzz stretching out like a diamond from the center. Kiss after kiss trails across his toned pectorals until you pull his pierced nipple into your mouth. The satyr groans, cringing against your lips.");
			if (player.isTaur()) { //Tauric lower body
				outputText("\n\nAndy’s soft hands glide down your sides to your lower back. You begin to tickle his other nipple with your head, tweaking it and gently pulling the bubblegum pink pierced flesh. As you do so you turn your head so you can see his foot long dog cock as it juts out from his body like an extra limb. When you’re finished with this foreplay you tell Andy how badly you want him inside of you.");
				outputText("\n\nAs he walks around your [legs] he slides as hand across your haunch, his other hand tugging at his leaking dog cock. Once he’s in position you feel his strong hands pulling your [ass] apart as he prepares to enter you.");
				//Looseness check
				if ((player.hasVagina() && player.vaginas[0].vaginalLooseness < 2 && isVaginal) || (!player.hasVagina() && player.ass.analLooseness < 2)) {
					outputText("\n\nYou hear a low whistle and Andy says, \"<i>Wow, you’re tight… hold on a sec.</i>\" You look back in time to watch the satyr squat and shove his face into your " + (vagOrAss(isVaginal)) + ". Your voice catches in your throat as you feel his tongue invading your tender opening. The strong muscle is soon joined by a finger that slips into you and swirls, the sensation causing you to swoon. Soon he leans back and spits before fingering the cold wetness into your " + (vagOrAss(isVaginal)) + " with dual fingers. Your sexy groans seem to be egging him on as his dual fingers sink into you, spread and then retract. Once the sensation becomes familiar you tell him to stop playing and put his dick in you. His fingers obediently retract and he leans in, planting a wet kiss on your " + (vagOrAss(isVaginal)) + " before putting the bullet shaped head of his dog cock up against your hungry hole, pushing in without delay. ");
					if (isVaginal) player.cuntChange(ANDY_COCK_AREA, true);
					else player.buttChange(ANDY_COCK_AREA, true);
					outputText("\n\nYour head swims as his dick widens your " + (vagOrAss(isVaginal)) + ". Your sharp gasp slows his advance; he’s a very attentive lover, so eager to please. He moves with a deliberate slowness, his fingers holding your [ass] firmly in place as he pulls back and pushes forward. He isn’t fucking you with his entire length but instead is slowly working it into you, allowing you to get used to his dog dick’s long thickness. Soon enough you feel his knot bump against your " + (vagOrAss(isVaginal)) + " and he begins fucking you with deep eager thrusts that send your head reeling as you do everything you can to not take a step forward. In almost no time you feel the tell tale tingle of your impending orgasm and, from the way his thrusts are becoming sloppy and less timed, you’d assume Andy feels the same.");
				}
				else if ((player.hasVagina() && player.vaginas[0].vaginalLooseness < 4 && isVaginal) || (!player.hasVagina() && player.ass.analLooseness < 4)) {
					outputText("\n\nAndy spits into his hand and you turn to see him slickening his foot long cock. He smiles back at you and hooks a free finger inside your " + (vagOrAss(isVaginal)) + ". You watch his bitten lip as his finger moves in and out of you. He adds one, and then a third, pushing through your insides and spreading your entrance in preparation for his thick dog cock. It is a pleasurable sensation, there’s no doubt about that, but not the one you wanted. As he catches your eye and smiles at you like a happy kid with a new toy you give him an impatient glare. He obediently dislodges his fingers from your " + (vagOrAss(isVaginal)) + " and grabs his spit slickened member.");
					outputText("\n\nAs he pushes into your hungry hole you squeeze his invading dog cock, loving the way it fills you up and stretches you open. "); 
					if (isVaginal) player.cuntChange(ANDY_COCK_AREA, true);
					else player.buttChange(ANDY_COCK_AREA, true);
					outputText("Andy wastes no time and begins sliding his rigid length in and out of your " + (vagOrAss(isVaginal)) + " with fevered need. Every time you feel his swollen knot bump against your entrance you squeeze, driving the satyr mad as he begins pounding you harder, his long dick making a glorious mess of your " + (vagOrAss(isVaginal)) + " as you push back, his knot threatening to spread you open even further every time it slams against your " + (vagOrAss(isVaginal)) + " before it is snatched away by Andy’s swiftly thrusting hips become sloppy and poorly timed. He’s close but a familiar tingle creeping up your spine tells you you are as well.");
				}
				else {
					outputText("\n\nAndy slides a spit soaked hand against your " + (vagOrAss(isVaginal)) + " with a whistle, \"<i>Oh I’m going to like this.</i>\" He says as he pulls your loose lips apart and gazes at your entrance with hungry eyes. He wastes no time and grabs his leaking dick and shoves it into your " + (vagOrAss(isVaginal)) + " with a snarl. ");
					if (isVaginal) player.cuntChange(ANDY_COCK_AREA, true);
					else player.buttChange(ANDY_COCK_AREA, true);
					outputText("\n\nAndy thrusts forward hard and swirls his dick around inside of you. Looking back you see his eyes are shut tight and his long tongue is hanging out of his open mouth as he pounds your hole with body jarring strokes. The surprising strength behind his thrusts is only matched by the sensations tingling through your body. You can feel his swollen knot slamming against your " + (vagOrAss(isVaginal)) + ", threatening to enter you before it is snatched away by his rapidly thrusting hips. Soon your body begins to quiver as you stand on the edge of your impending climax. From the sounds he’s making you’d guess he is as well.");
				}
				//Genitals check
				if (player.hasCock() && player.hasVagina() && isVaginal) { //Hermaphrodite
					outputText("\n\nGroaning like a madman Andy suddenly thrusts forward, his swollen knot penetrating your vaginal walls and pushing you over the edge. With a simultaneous cry the two of you unload together. [eachCock] fires round after round of dick milk and your [vagina] screams in tingling triumph while the wet heat of Andy’s satyr spunk coats your insides. ");
					if (player.cumQ() >= 1000 && player.cumQ() < 2500) outputText("As you unload your cum pools around your [feet], spreading out in a giant puddle beneath you.");
					else if (player.cumQ() >= 2500) outputText("As you unload you feel [eachCock] spasm and coat your [legs] and [feet] in hot pearly goo. Your orgasm rages on for what seems like an eternity, [eachCock] creating an ocean of melted pearl that stretches out and covers the ground around you.");
					outputText("\n\nThere you are breathing like you just ran a marathon. You feel an incredible amount of satyr spunk sloshing around in your horse half. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading throughout your body. You can feel Andy lying against your horse half, catching his breath before he stands and tugs his dog cock. You canter back, his swollen knot lodged inside your [vagina] and holding the two of you together.");
				}
				else if (player.hasCock()) { //Male
					outputText("\n\nAndy thrusts forward and shoves his swollen knot into your [asshole] with a crazed snarl. The sudden widening of your rectal opening pushes you over the edge. You scream as his dick explodes inside your [ass] and [eachCock] explodes, releasing intense jets of baby batter as his knotted dog dick spasms inside of you.");
					if (player.cumQ() >= 1000 && player.cumQ() < 2500) outputText("As you fire blast after blast of baby batter across the floor the cum spewing from your body pools around your [feet], leaving a pearly puddle below you.");
					else if (player.cumQ() >= 2500) outputText("Your cum explodes out of [eachCock] like fireworks. Groaning like a dying man your shiver in ecstasy as your cum soaks the earth beneath your [feet], spreading out like a small lake made of moonlight.");
					outputText("\n\nThere you are breathing like you just ran a marathon. You feel an incredible amount of satyr spunk sloshing around in your horse half. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading throughout your body. You can feel Andy lying against your horse half, catching his breath before he stands and tugs his dog cock. You canter back, his swollen knot lodged inside your [ass] and holding the two of you together.");
				}
				else if (player.hasVagina() && isVaginal) { //Female
					outputText("\n\nYou feel Andy’s swollen knot suddenly widen your vaginal walls as it’s shoved into your [pussy]. The sudden increased sensation pushes you over the edge and you cry out, your voice blending with his as you both unload. The sensation of his spasming dog dick unloading his tainted satyr seed into your body only serves to extend your orgasm, an orgasm so intense you find yourself screaming at the top of your lungs before the feeling falters and you’re left feeling tired.");
					outputText("\n\nThere you are breathing like you just ran a marathon. You feel an incredible amount of satyr spunk sloshing around in your horse half. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading throughout your body. You can feel Andy lying against your horse half, catching his breath before he stands and tugs his dog cock. You canter back, his swollen knot lodged inside your [vagina] and holding the two of you together.");
				}
				else { //Genderless
					outputText("\n\nAndy thrusts forward, losing control as he shoves his swollen knot into your [asshole] with a crazed snarl. The sudden widening of your rectal opening pushes you over the edge. As his dick explodes inside your [ass] your body flinches and jerks as your climax rages on. The trembling of Andy’s swollen dog dick only serves to heighten the sensations coursing through your body.[pg] There you are breathing like you just ran a marathon. You feel an incredible amount of satyr spunk sloshing around in your horse half. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading throughout your body. You can feel Andy lying against your horse half, catching his breath before he stands and tugs his dog cock. You canter back, his swollen knot lodged inside your [ass] and holding the two of you together.");
				}
				outputText("\n\nAndy chuckles as you look back at him, \"<i>Sorry about the knot [name].</i>\" You shrug because it’s no big deal. Even know the feeling of his hot flesh inside you makes you tingle. You can feel the hot wetness of Andy’s seed inside you as the two of you wait for the swelling of his knot to go down.");
				outputText("\n\nThe two of you talk, holding an engaging conversation that discusses a range of unimportant but interesting topics. When his dick and knot finally deflate and send a cascade of satyr spunk dripping from your used hole you stay for a minute and enjoy his company. After a short time the two of you rise and you reward him with a kiss before grabbing your [armor] and pulling it on as you head back to camp.");
			}
			else { //Everything else
				outputText("\n\nHis hands slide down your back and land on your [ass], pulling you closer by your cheeks. You begin to tickle his other nipple with your hand, tweaking it and even gently pulling at the piercing. When you straighten up you tell him to get on his back.");
				outputText("\n\nOnce he’s down you can plainly see his tall standing erection. You guess his knotted dog dick to be a foot long. The guy is leaking like a sieve. Just looking at the tall standing canine cock makes your " + (vagOrAss(isVaginal)) + " yearn to be filled. Andy is obviously as hungry for your " + (vagOrAss(isVaginal)) + " as you are for his dog cock, you can tell by the way he palms your tender flesh. With a smile you lower yourself, reaching down to tug his knotted shaft towards your waiting " + (vagOrAss(isVaginal)) + ".");
				//Looseness check
				if ((player.hasVagina() && player.vaginas[0].vaginalLooseness < 2 && isVaginal) || (!player.hasVagina() && player.ass.analLooseness < 2)) {
					outputText("\n\nThe bullet shaped head of Andy’s dog prick stretches your " + (vagOrAss(isVaginal)) + " to the max. The girth of it alone is almost enough to make you hop off and leave him there. Yet looking down at him, the way his eyes widen as he feels your tightness enveloping his cock, gives you the strength to continue. After dropping a line about what you’ll do to him should he move you slowly sink down onto the foot long member, your teeth clenched and you descend. ");
					if (isVaginal) player.cuntChange(ANDY_COCK_AREA, true);
					else player.buttChange(ANDY_COCK_AREA, true);
					outputText("\n\n\"<i>Wow, that’s tight.</i>\" Andy says once you’ve sunk about halfway down his dick. You yourself are consumed with conflicting feelings of agony and ecstasy. You decide not to go any lower for now and begin your ascent. You ride Andy nice and slow at first, obtaining your sea legs and getting used to the sensation. After a while you’re able to quicken your pace and soon you’re fucking yourself with half the satyrs full length and feeling him tremble as he fights to remain motionless lest he suffer your wrath. Soon you lose yourself in riding him, slowly taking in more and more of his tower of a cock until you’re finally taking the whole thing. With your chest swelling with pride you begin to feel an internal tingle and you know you’re dangerously close to your climax. From the way he trembles and groans you can tell Andy is too.");
				}
				else if ((player.hasVagina() && player.vaginas[0].vaginalLooseness < 4 && isVaginal) || (!player.hasVagina() && player.ass.analLooseness < 4)) {
					outputText("\n\nAs the bullet shaped head of Andy’s dog prick pushes into your " + (vagOrAss(isVaginal)) + " he reaches forward to grab your hips, presumably to pull your body up and down his tall standing erection. All it takes is a look to stop him and you tell the satyr to relax. He shudders inside of you as you sink down his rigid pole with deliberate slowness. ");
					if (isVaginal) player.cuntChange(ANDY_COCK_AREA, true);
					else player.buttChange(ANDY_COCK_AREA, true);
					outputText("\n\n\"<i>Oh Marae.</i>\" He gasps as you sink, stopping at his swollen knot. You feel blissfully full and let him know with a deep tongue wrestling kiss. When you come up for air he just smiles up at you, trembling with excitement as he verbally reminds himself not to move. Ignoring his chanting you begin bouncing up and down his swollen dog prick, using him like your own personal dildo. His trembling actually spurs you to ride faster, your " + (vagOrAss(isVaginal)) + " making a squelching sound as you ride his leaking cock. He begins to whine and you can’t help but sympathize with him. You could ride this living dildo forever, feel its slick heat as it penetrates your " + (vagOrAss(isVaginal)) + " at exactly the perfect pace, controlled by your [legs]. Yet from the tell tale tingle creeping up your spine you know it’ll end soon.");
				}
				else {
					outputText("\n\nAs the bullet shaped head of Andy’s dog prick sinks into your " + (vagOrAss(isVaginal)) + " you sink down the entire length without a problem. His eyes go wide as he looks up at you with his jaw hanging open. Then his hands stretch towards your hips like a boy hesitantly reaching for a present he can scarcely believe is real. You tell him he’s going to sit still and let him know what you’ll do to him if he doesn’t. Tucked inside you he complies as best he can. Even though he holds himself still he can’t seem to help trembling beneath you but as his unconscious tremors vibrate his cock it’s not something you’re worried about. It only makes him a better toy. ");
					if (isVaginal) player.cuntChange(ANDY_COCK_AREA, true);
					else player.buttChange(ANDY_COCK_AREA, true);
					outputText("\n\n\"<i>Oh my… ahhnnn, fuck.</i>\" he whines as you begin to slide up and down his doggy dick. The foot long cock is a hot rod of slick heat you ride at a leisurely pace, enjoying the teasing tickle caused by the trembling satyr beneath you. Once you’ve had your fill of torturing the poor guy you throw caution to the wind and begin to really ride him, enjoying the way he cringes every time your " + (vagOrAss(isVaginal)) + " completely envelop his dog cock. The slap, slap, slap of your weight crashing down on his pelvis fills the air and you watch the trembling satyr hold on for dear life. The entire time you’re expecting him to pop at any moment but somehow he manages to hold on until you feel your satisfaction preparing to culminate in a climax of epic proportions.");
				}
				//Genitals check
				if (player.hasCock() && player.hasVagina() && isVaginal) { //Hermaphrodite
					outputText("\n\nGroaning like a madman Andy suddenly thrusts forward, his swollen knot penetrating your vaginal walls and pushing you over the edge. With a simultaneous cry the two of you unload together. [eachCock] fires round after round of dick milk and your [vagina] screams in tingling triumph as the wet heat of Andy’s satyr spunk coats your insides. ");
					if (player.cumQ() >= 250 && player.cumQ() < 1000) outputText("As you unload Andy opens his mouth to catch your seed as it paints his chest and chin in streaks of pearly white baby batter.");
					else if (player.cumQ() >= 1000 && player.cumQ() < 2500) outputText("As you unload the Andy opens his mouth to catch your seed as it paints his chest, chin and abs in a thick coating of white goo.");
					else if (player.cumQ() >= 2500) outputText("As you unload the satyr practically drowns in your baby batter, coated from horns to abs in a heavy coating of white spooge that pools around the two of you like a lake of melted pearls.");
					outputText("\n\nAndy licks his lips as he looks up at you, breathing like he just ran a marathon. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading through your body. You try to stand but Andy’s weight comes with you, his swollen knot lodged inside your [vagina] and holding the two of you together.");
				}
				else if (player.hasCock()) { //Male or herm choosing anal
					outputText("\n\nAndy thrusts forward, losing control as he shoves his swollen knot into your [asshole] with a crazed snarl. The sudden widening of your rectal opening pushes you over the edge. As his dick explodes inside your [ass] [eachCock] explodes onto the satyr’s chest, intense jets of baby batter firing from [eachCock] as his spasms inside of you. ");
					if (player.cumQ() >= 250 && player.cumQ() < 1000) outputText("As you unload Andy opens his mouth to catch your seed as it paints his chest and chin in streaks of pearly white baby batter.");
					else if (player.cumQ() >= 1000 && player.cumQ() < 2500) outputText("As you fire blast after blast of baby batter across Andy’s body you manage to liberally coat his entire form from his chin to his abs, [eachCock] spent as you drool out your last bit of spunk.");
					else if (player.cumQ() >= 2500) outputText("Your cum explodes out of [eachCock] like fireworks and as you cry out so does Andy, sputtering as your titanic orgasm leaves him covered head to abs in your copious load.");
					outputText("\n\nAndy licks his lips as he looks up at you, still breathing like he just ran a marathon. Your body feels heavy but at the same time you’re blissfully aware of glory of the post orgasmic ache spreading through your body. You try to stand but Andy’s weight comes with you, his swollen knot lodged inside your [ass] and holding the two of you together.");
				}
				else if (player.hasVagina() && isVaginal) { //Female
					outputText("\n\nYou feel Andy’s swollen knot suddenly widen your vaginal walls as it’s shoved into your [pussy]. The sudden increased sensation pushes you over the edge and you cry out, your voice blending with his as you tremble. The sensation of his spasming dog dick unloading his tainted satyr seed into your body only serves to extend your orgasm, an orgasm so intense you find yourself screaming at the top of your lungs. You rub your stomach as you look down at the satyr, noting that your belly is slightly swollen from the amount of jizz trapped in your body.");
					outputText("\n\nAndy licks his lips as he looks up at you, still breathing like he just ran a marathon. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading through your body. You try to stand but Andy’s weight comes with you, his swollen knot lodged inside your [vagina] and holding the two of you together.");
				}
				else { //Genderless or female choosing anal
					outputText("\n\nAndy thrusts forward, losing control as he shoves his swollen knot into your [asshole] with a crazed snarl. The sudden widening of your rectal opening pushes you over the edge. As his dick explodes inside your [ass] your body flinches and jerks as your climax rages on. The trembling of Andy’s swollen dog dick only serves to heighten the sensations coursing through your body.[pg] Andy licks his lips as he looks up at you, still breathing like he just ran a marathon. Your body feels heavy but at the same time you’re blissfully aware of the glorious post orgasmic ache spreading through your body. You try to stand but Andy’s weight comes with you, his swollen knot lodged inside your [ass] and holding the two of you together.");
				}
				outputText("\n\nAndy chuckles as you look down at him, \"<i>Sorry about the knot, [name].</i>\" You shrug because it’s no big deal. You can feel the hot wetness of Andy’s seed inside you as the two of you wait for the swelling of his knot to go down.");
				outputText("\n\nThe two of you talk, holding an engaging conversation that discusses a range of unimportant but interesting topics. When his dick and knot finally deflate and send a cascade of satyr spunk dripping from your used hole you stay for a minute and enjoy his company. After a short time the two of you rise and you reward him with a kiss before grabbing your [armor] and pulling it on as you head back to camp.");
			}
			if (player.hasVagina()) player.knockUp(PregnancyStore.PREGNANCY_SATYR, PregnancyStore.INCUBATION_SATYR, 50); //2x chance of pregnancy
			else player.buttKnockUp(PregnancyStore.PREGNANCY_SATYR, PregnancyStore.INCUBATION_SATYR, 50);
			player.slimeFeed();
			player.orgasm();
			dynStats("sens", 1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Harry Roswell
		//------------
		private function meetHarryRoswell():void {
			clearOutput();
			displayHarrySprite();
			outputText(images.showImage("harry-intro"));
			if (flags[kFLAGS.BLACK_COCK_MET_HARRY] == 0) {
				outputText("You catch yourself staring at the keep out sign stuck into the bare ground at the back of the tent. It makes you wonder what the cook's like and how he makes food with such an enticing aroma. Instead of doing the logical thing and asking a member of the staff if you can meet the cook, you resolve to sneak in.");
				outputText("\n\nIt doesn't prove to be too hard. Neither the harpy, the satyr nor the echidna morph look up as you " + (player.isNaga() ? "slither" : "walk") + " on silent [feet] towards the back. You open the flap and glance over your shoulder, scanning the tent to make sure you're not being caught. You spot one of the ubiquitous pot- bellied satyrs. He looks you straight in the eye and gives you a conspiratorial wink before going back to his drinking game. Apparently the only security in this place is the sign itself.");
				outputText("\n\nThen you turn around and come face to face with an angry rhino morph. Bulging muscles wrapped in rough gray skin wearing nothing but an apron greats you with a furious sneer. From the looks of things he's ready to pummel you into mush.");
				outputText("\n\n\"<i>Can you read?</i>\" his gruff voice calmly asks. You, of course, can read so you nod, \"<i>Oh really? Because I could've sworn there was a big ass sign hammered into the ground with big ass letters painted on it saying to keep out of this part of the tent… but let me check, I could be wrong.</i>\" He punches the flap beside you, he's much faster than he looks. His eyes lock on the wooden sign, \"<i>Nope… still there.</i>\"");
				outputText("\n\nNo brilliant or even plausible excuse rises to the surface of your mind as you begin to feel like a child getting caught with a hand in the cookie jar. Then the rhino man's angry expression breaks as he begins to laugh at your expense, a loud obnoxious and somewhat relieving sound. Still chuckling he says, \"<i>You should'a seen the look on your face.</i>\"");
				outputText("\n\nOnce he's done laughing at your expense, the thick and incredibly muscled rhino morph holds out a hand, \"<i>Truth be told I don't give a rat's ass about you comin' in here. I'm the owner and cook of The Black Cock, name's Harry, Harry Roswell.</i>\" Then he gives you a menacing glare, one so comical you both break into raucous laughter.");
				outputText("\n\nAll jokes aside, the happy rhino man turns away and begins to stir a big pot of spicy chilli before saying, \"<i>What's your name sport?</i>\" Graciously deciding to ignore the fact that he just called you sport, you give him your name., \"<i>Alright [name], what can I do ya for?</i>\" he asks, suddenly all business as he cooks.");
				flags[kFLAGS.BLACK_COCK_MET_HARRY] = 1;
			}
			else {
				outputText("Remembering the super secret agent moves you used to get into the back the first time, you can't help but chuckle. You simply walk to the back and push open the flap, letting yourself in and not giving a fuck about anyone seeing you. A wave of heat and the aroma of cooking meat hits you in the face as you do so.");
				outputText("\n\nHearing your entrance Harry Roswell turns his head towards you and smiles big.");
				outputText("\n\n\"<i>Hey [name], what can I do ya for?</i>\"");
			}
			if (flags[kFLAGS.CODEX_ENTRY_RHINOS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_RHINOS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Rhino-Morphs!</b>\n\n");
			}
			menu();
			if (player.lust >= 33) addButton(0, "Sex", rompUpWithHarry);
			else addButtonDisabled(0, "Sex", "You aren't horny enough to consider this.");
			addButton(4, "Nevermind", nevermindToHarry);
		}
		
		private function nevermindToHarry():void {
			clearOutput();
			outputText("You tell Harry you just wanted to chat and he tells you he'll be cooking while you talk. The conversation doesn't cover anything terribly important. Harry makes a bunch of sex jokes about harpies, satyrs, centaurs and even you as he continues to cook. By the time you leave your sides are hurting from laughing so hard.");
			doNext(checkStaff);
		}
		
		private function rompUpWithHarry():void {
			clearOutput();
			if (flags[kFLAGS.BLACK_COCK_HARRY_SEX_INTRO] == 0) {
				outputText("Looking at the big burly masculine rhino morph you can't help but wonder at his partial nudity. He seems to be naked beneath his apron, an observation confirmed when a long tube appears as he moves, swinging just below his knees. As you stare at the enormity of that bulge he clears his throat. You look up to find his eyes looking onto yours, his face pulled into a cocky grin.");
				outputText("\n\nThen he chuckles, \"<i>Alright [name], if you wanna play I'm game.</i>\" Then he takes a knife and points it at you, a menacing but playful gesture, \"<i>...but my back door's off limits and the only pussy I get pregnant is my wife's.</i>\"");
				flags[kFLAGS.BLACK_COCK_HARRY_SEX_INTRO] = 1;
			}
			else {
				outputText("You lick your lips, gazing longingly at the rhino morph's muscle etched form. He, of course, catches you and wags his dick at you with his free hand while the other hand continues to stir a big pot of chilli.");
				outputText("\n\n\"<i>You want some?</i>\" He asks.");
			}
			addButton(0, "Get Fucked", haveHarryFuckYou);
			addButton(1, "Nevermind", nevermindToHarrySex);
		}
		
		private function haveHarryFuckYou():void {
			clearOutput();
			outputText(images.showImage("harry-sex-getfucked"));
			const HARRY_COCK_AREA:int = 18 * 3; //54
			outputText("You accept the rhino morph's offer and watch as he sets the burners and oven to lower temperatures.  From his bulging arms to his muscled legs he is a bevy of corded muscle. His big meaty ass moves around as he stirs pots and covers meat so nothing is burned, then he turns toward you and tugs his apron off, allowing you to see the long rhino dick he has promised you. It lifts in greeting, jutting outward and stretching in your direction. The pink shaft is spotted with dark splotches of brown with an oblong ridge widening its middle. It has to be at least three inches thick and eighteen inches long!");
			outputText("\n\nBefore you can begin to undress Harry Roswell grabs you by your [armor] and pushes you over to a table littered with various food items. From behind the beefy guy holds you, using his powerful hips to pin you to the wooden surface. You feel his strength in every gesture, every motion as his long dong nestles with your [ass]. When you go to undress yourself he pushes your hands onto the table and begins roughly pulling your [armor] off. Every motion tells you he is in complete control as you're forcibly stripped while being surrounded by cutlery and bowls of various ingredients.");
			outputText("\n\nThe cook then grabs you by the waist, squeezing your now nude form as he slides his meaty rhino cock belly flat across your [asshole], thrusting with glee.");
			if (player.analCapacity() < 40) {
				outputText("\n\n\"<i>You hear a disheartening tsk and look up to find Harry Roswell looking disappointed. He catches your questioning gaze and simply says, \"<i>Too little.</i>\"");
				outputText("\n\nYet still he keeps you pinned. His wet tower of a dick is still lying between the cheeks of your [ass] for some reason; your heart sinks as you realize that he plans to continue despite not being able to fit. The panic inducing thought is quickly dispelled when he thrusts his dick belly first against your upturned ass. It seems he has less forcibly invasive intentions.");
				outputText("\n\nHis hands push and pull your prone form into position. [if (isBiped = true) \"He firmly arches your back and wraps a powerful arm around your neck. He then tells you to spread your [legs] and you do so with a smile. Without warning he turns your head to plants a hard kiss on your lips.\"][if (isNaga = true) \"He presses your [fullChest] into the table and wraps an arm around your neck. You can't help the way your coils slide around his legs as you're forcibly restrained. With a chuckle and some difficulty he extracts one leg and widens his stance, turning your head to plant a hard kiss on your gasping lips as your coils tighten around the single leg they hold in their serpentine grip.\"][if (isTaur = true) \"He wraps his arms around the middle of your lower section and lifts, showing off his prodigious strength as he forces you onto your front two legs while he gets you into optimal position. He laughs as you look back, a warning on your face for him to drop your back two legs. The laughter breaks your feigned annoyance and he himself plants a kiss on your haunch as he drops you right where he wants you.\"]");
				outputText("\n\nThen he slides his dick belly first against your [asshole] again, sending a shudder through your body.");
				outputText("\n\n\"<i>Oh shit.</i>\" He breathes into your ear as his muscular hands hold onto your [ass]. He begins hotdogging your upturned [ass] with rapid thrusts. Your [asshole] flutters in undeniably pleasurable sensations that cause you to release a loud moan trembling with need. Somewhere in the back of your mind you're thankful for his restraint. Thankful for his not breaking into your back door with reckless and selfish need. Thankful for his not splitting you open and forcibly raping you into unwilling submission. Being fucked in this manner only serves to heighten your lust and you quickly realize that the pleasurable sensations will never bring you to climax.");
				if (player.hasCock() && player.hasVagina()) { //Hermaphrodite
					outputText("\n\nAlmost the moment you think this, Harry dips his free hand into some creamy concoction and reaches down beneath the table. When his hand grazes your [cock] he wraps a fist around it and gives it a few pleasurable pumps. You push back against his oblong dick greasing up your hole as he massages your [cock] with a practiced and experienced hand. "); 
					if (player.balls > 0) outputText("His powerful grip begins to slide down your [cock]. They continue down to your [balls] and give them a firm but gentle squeeze, one that sends you bucking back into his giant cock as it spills gobs of precum onto your [ass]. ");
					else outputText("His powerful grip slides down your [cock] with firm squeezes, his thumb rubbing the top of your dick before it travels south. "); 
					outputText("When he reaches your [pussy] he dips a practiced finger into your snatch, sending tingles through your body that have you gasping for air. The arm around your neck falls to your groin and wraps itself around your [cock]. \"<i>Time to cum, [name].</i>\" is whispered into your ear as one hand tugs at your [cock] and the other begins to slide in and out of your hungry [vagina]. The triple sensations of the teasing pressure on your [asshole], the firm tugging of your [cock] and the mind blowing finger fucking of your [pussy] is enough to drive you mad. He keeps you on the edge for a while, goading you on as you beg for release. You begin to tremble with need as he dominates your body, controlling you like a puppeteer manipulating an old marionette. Then, teeth clenched and ass pushing back against him, you explode, shivering and convulsing as you fall flat against the table, crushing your [fullChest] beneath you as the last dregs of your orgasm leak from [eachCock] and your [pussy].");
				}
				else if (player.hasCock()) { //Male
					outputText("\n\nAlmost the moment you think this, Harry dips his free hand into some creamy concoction and reaches down beneath the table. When his hand grazes your [cock] he wraps a fist around it and gives it a few pumps. You push back against his oblong dick greasing up your hole as he firmly massages your [cock]. ");
					if (player.balls > 0) outputText("His powerful grip begins to slide down your [cock]. They continue down to your [balls] and give them a firm but gentle squeeze, one that sends you bucking back into his greasy cock as it spills gobs of precum onto your [ass]. ");
					else outputText("His powerful grip slides down your [cock] with firm squeezes, his thumb rubbing the top of your dick as it travels south probably searching for a pair of gonads you don't have; once his fruitless search is over he returns to tugging your [cock]. ");
					outputText("Time to cum, [name]</i>\" he breathes into your ear. You hear him spit into his other hand and release a deep shuddering groan as it joins the other, lubing up your [cock] with rhino spit. Two hands play with your [cock] as an oversized dick greases up your upturned [ass]. The dual sensations have you trembling with need. He keeps you on the edge for a while, goading you on as you beg for release. Your body trembles with need as he completely controls your body. Then, teeth clenched and ass pushing back against him, you explode, shivering and convulsing as you fall flat against the table, crushing your [fullChest] beneath you as the last dregs of your orgasm leak from [eachCock].");
				}
				else if (player.hasVagina()) { //Female
					outputText("\n\nThe moment you think this, Harry reaches his free hand down beneath the table. When he reaches your [pussy] he dips a practiced finger into your snatch, sending tingles through your body. He begins to thrust his finger and hips at the same time, crushing you between his dick and powerful fingers in an oddly satisfying combination of sensations. He plays with your pussy, obviously quite experienced with pleasing a woman as he brings you to climax after climax using the dual sensations created by the belly of his hot dogging cock against your [asshole] and the expertise with which he plays with your [pussy]. Then his other hand travels southward and he uses both to tug at the tender lips of your vulva, gently stretching them before pushing them together. He begins to alternate hands, using one to get you off and then the other. ");
					if (player.vaginas[0].wetness >= 4) outputText("Every time you gush fluid onto his fingers he vibrates his palm, sending uncontrollable shuddering screams into the air as the sensations intensify. ");
					outputText("Once he's satisfied with the number of times you've spilled girl cum onto his kitchen floor he pulls his finger from your pleasantly tingling [pussy].");
					outputText("\n\nThe Rhino puts a hand covered in your juices in front of your [face], \"<i>Lick it.</i>\" He commands and in your post-orgasmic state you don't even think about it, you just stick your [tongue] out and lap up a bit of your own cum. Before you finish he wraps the hand around your lips, smashing your cum into your face as his other wet hand pushes against your back. He begins hot dogging your upturned ass with brutal thrusts that send echoing claps through the room. You can't help clenching your ass cheeks as he roughly humps against you. He smacks your [ass] before the arm holding his cum scented palm to your face pulls back. With a hand now wrapped around your waist he increases the pace and when his thrusts become sloppy you know he's close.");
				}
			}
			else {
				outputText("\n\nHarry looks down at your ass with a wide grin, \"<i>I can work with this.</i>\" He says as he palms your [ass], getting a nice long grope.");
				outputText("\n\nHis weight lifts off of you as he kneels behind you. Rough hands snatch your [ass] back against his face, his tongue thrust out and penetrating your [asshole]. He growls as he suckles your pucker, streaming gobs of spit sliding down your [legs] as he spits then sucks then spits again before suckling your [asshole] again. Then you feel his long tongue being pushed into your back door, wiggling through your receptive tunnel. His head begins to move back and force, his chin slamming into your [ass] as he roughly tongue fucks your [asshole] until you're quivering from the sensation. A large hand lands on your [ass] with an echoing slap. As the hand falls again you find yourself pushing back into the rhino morph's tongue, a hunger deep in your gut that you know just his tongue won't satisfy.");
				outputText("\n\nWith your [asshole] spit shined and dripping saliva Harry rises.");
				outputText("\n\n\"<i>Ready?</i>\" He says with a smile curling across his face.");
				outputText("\n\nYou take a deep breath, remind yourself to relax and tell him you're ready. ");
				if (player.analCapacity() >= 40 && player.analCapacity() < 55) {
					outputText("\n\nWhen the flared head of his rhino dong touches your [asshole] you silently wonder how he's going to fit all that into you. He begins to slowly push against your upturned [asshole], working his thick flared head into your rear entrance with a patient steady pace. It's slow work but every time his fat dick pushes forward you feel yourself opening more and more. After a short time his gentle labor begins to bear fruit as he pressed deeper and deeper, opening your up your rear entrance and pushing past your anal canal. Gritting your teeth you hold yourself steady, muscles tense as you are impaled by the rhino morph's long slimy oblong-shaped dong. You've gotta admit that this is one huge fucking dick.");
					player.buttChange(HARRY_COCK_AREA, true);
					outputText("\n\nHe starts off slow, working his ass stretching rhino dick into your back door with steadily deeper strokes. Somehow he knows to back off just as the pressure becomes too much to bear before slowly tunneling forward. The sensation of being slowly stretched is a teasing scratch to an itch you didn't know you had. Each vein, each curve in his widening member sends a sudden heat blooming through your insides and a quivering through your [legs]. Your body is enraptured by the slow steady progress and you have to admit that you're impressed by Harry Roswell's patience. When you feel the rough skin of his pelvis softly land on your [ass] your mouth drops open at the realization that he has somehow managed to work the entirety of his giant dong into your body. With a bitten lip you widen your legs, desperate for the true fucking to begin.");
				}
				else if (player.analCapacity() >= 55) {
					outputText("\n\nWhen the flared head of his long rhino dong touches your [asshole] you give him a lust filled groan. He rewards you with an eager thrust, the flared head of his rhino dong popping into you with no problem. His hands slide up your body as he begins to play around inside of you. First his big slab of rhino meat twirls around, sending a hurricane of sensation through your [ass]. Then he pulls his dick completely out of your hole and when you look back to see what he's doing he thrusts forward hard, shafting you in one go. He continues like this, enjoying the freedom of movement provided by your [asshole] as he sends crushing waves of pleasure through your body. Then he grabs you purposefully and you know that playtime is over.");
				}
				outputText("\n\nAs if reading your mind Harry pulls his long dong out of your body until only the head remains. You feel the void left in the wake of his cock as an empty hunger. Then he shoves forward, forcing the entirety of his rhino dick into your body with a sudden brutal pelvic slap against your [ass] that knocks the wind out of you. He repeats this a little more quickly again and again until he reaches top speed and there is no pause and no time to react. He just repeatedly pounds into your [asshole] with freight train force and there is nothing you can do but scream in ecstasy. The brutal passion of the powerful man fucking you for all he's worth crashes into your senses and forces your body and mind to convulse wildly. Your mind is filled with the painful pleasure of being smashed into the table, of your nails scratching the wooden surface, of the brutal assault on your [ass] as a greedy dick uses you for its own pleasure. As you howl and groan for all the world to ear you begin to feel a familiar pulsing sensation in your nethers. You hear a growl above you as Harry's thrusts became more brutal and less timed, he moves the table beneath the two of you with every thrust.");
				outputText("\n\nHe pounds you with every bit of strength he has and suddenly his dick is shoved in to the hilt and trembling as a it fires hot semen into your body. Knowing that the married rhino is cumming pushes you over the edge and with one last unending scream you reach the nirvana of climax.");
				if (player.hasCock() && player.hasVagina()) {
					outputText("\n\nYour entire body tingles as you unload, your [cock] and [vagina] both erupting without being touched as the giant dong trembles inside your [asshole]. You flail like a fish out of water as the trembling of [eachCock] and the flooding of your [pussy] drowns out every other feeling except that of the large dong pressed into your [asshole].");
				}
				else if (player.hasCock()) {
					outputText("\n\nYour entire body tingles as you unload, your [cock] erupting without being touch as the giant dong trembles inside your [asshole]. You flail like a fish out of water as the trembling of [eachCock] drowns out every other feeling except that of the large dong pressed into your [asshole].");
				}
				else if (player.hasVagina()) {
					outputText("\n\nYour entire body tingles as you cum, your [vagina] erupting without being touched as the giant dong trembles inside your [asshole]. You flail like a fish out of water as the flooding of your [pussy] drowns out every other feeling except that of the large dong pressed into your [asshole].");
				}
				outputText("\n\nThe Rhino puts a hand covered in your juices in front of your [face], \"<i>Lick it.</i>\" He commands and in your post-orgasmic state you don't even think about it, you just stick your [tongue] out and lap up a bit of your own cum. He tugs his giant dick from your wrecked ass and gives it a gentle palming, a silent thank you for the quick break from work.");
			}
			outputText("\n\nAs he helps you clean up he tells you how much he likes your ass. After chatting for a little bit he tells you he has to get back to work. As you walk out the tent flap all eyes are on you. After a few moments one of the satyrs sticks his fingers to his lips and gives a high pitched wolf whistle. Some of the tables with people in them erupt in stomping and clapping. Harry's harpy wife catches your eye and gives you a conspiratorial wink, rubbing her pussy through her tight little cut off pants as she watches you leave.");
			flags[kFLAGS.BLACK_COCK_HARRY_SEX_COUNTER]++;
			player.orgasm();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function nevermindToHarrySex():void {
			clearOutput();
			outputText("You put your hands up in an attempt to look innocent as you tell the man he's crazy and you weren't thinking any such thing.");
			outputText("\n\nHe gives you a disbelieving look before rolling his eyes and saying, \"<i>Alright ya little cock tease, feel free to hang around if you want.</i>\" He reaches down and tugs at the thickening bulge swinging near his knees. After a few minutes of chatting and watching him cook you decide you'd best be leaving.");
			doNext(enterTheBlackCock);
		}
		
		//Frida
		//------------
		private function meetFrida():void {
			clearOutput();
			displayFridaSprite();
			outputText(images.showImage("frida-intro"));
			if (flags[kFLAGS.BLACK_COCK_MET_FRIDA] == 0) {
				outputText("You approach the echidna-girl's side of the counter, taking a seat in one of the barstools. She approaches you, a pleased smile decorating her visage.");
				outputText("\n\n\"<i>I don't think I've seen you in here before. The name's Frida. Now, stranger, might I ask your name?</i>\"");
				outputText("\n\n\"<i>[name],</i>\" you respond.");
				outputText("\n\n\"<i>Nice to meet you, [name]. Now, tell me. What brought you here, hm? Perhaps it was the cake? Sure is a beauty, isn't it? It was my gran's recipe. She passed it down to my mother, and then to me. The secret? Our eggs. Oh, it may seem odd to you, but they're what makes the cake. It's what makes them so nice and fluffy. Would you like a piece? They're 10 gems each, and it includes a cup of milk.</i>\"");
				flags[kFLAGS.BLACK_COCK_MET_FRIDA] = 1;
			}
			else {
				outputText("Frida smiles at you as you take a seat in one of the barstools.");
				if (flags[kFLAGS.BLACK_COCK_FRIDAS_CAKE_EATEN_COUNTER] > 0) outputText("\n\n\"</i>You come here for another piece of cake?<i>\"");
				else outputText("\n\n\"<i>You ready for a piece of cake now, hun?</i>\"");
			}
			if (flags[kFLAGS.CODEX_ENTRY_ECHIDNAS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_ECHIDNAS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Echidna-Morphs!</b>\n\n");
			}
			doYesNo(orderFridasCake, noThanksToCake);
		}
		
		private function orderFridasCake():void {
			clearOutput();
			outputText(images.showImage("frida-order-cake"));
			if (player.gems < 10) {
				outputText("You count out your gems and realize you're short on these at the moment.");
				doNext(enterTheBlackCock);
				return;
			}
			if ((player.hunger >= 90 && flags[kFLAGS.HUNGER_ENABLED] > 0) || (player.findStatusEffect(StatusEffects.Fullness) >= 0 && flags[kFLAGS.HUNGER_ENABLED] == 0)) {
				outputText("<b>You are too full to consider ordering that that.</b>");
				doNext(enterTheBlackCock);
				return;
			}
			outputText("You drop 10 gems into Frida's waiting hand. She stuffs them in one of her apron pockets as she removes the lid from the cake stand. She takes a dull knife from a nearby knife block and cuts you a piece, putting it on a plate. She sits the plate in front of you before retreating to the back of the tent to pour your milk. Within seconds, she returns with the milk, putting it down next to your plate.");
			outputText("\n\n\"<i>Enjoy!</i>\"");
			if (flags[kFLAGS.BLACK_COCK_FRIDAS_CAKE_EATEN_COUNTER] == 0) outputText("\n\nYou waste no time digging into the cake. She's right. The cake is absolutely delicious! Within moments, the savory morsel is gone. You wish that there had been more.");
			else outputText("\n\nYou immediately dig in, very excited for another piece. You let out a small burp as you finish, but let out a sigh of disappointment at the fact that there is nothing left of your piece of cake.");
			player.refillHunger(35);
			if (flags[kFLAGS.HUNGER_ENABLED] == 0) player.modThickness(100, 2);
			player.modTone(0, 1);
			if (player.findStatusEffect(StatusEffects.Fullness) < 0) player.createStatusEffect(StatusEffects.Fullness, 2, 0, 0, 0);
			else player.changeStatusValue(StatusEffects.Fullness, 1, 2);
			flags[kFLAGS.BLACK_COCK_FRIDAS_CAKE_EATEN_COUNTER]++;
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function noThanksToCake():void {
			clearOutput();
			if (flags[kFLAGS.BLACK_COCK_FRIDAS_CAKE_EATEN_COUNTER] == 0) outputText("You politely decline, not feeling very hungry at the moment.");
			else {
				outputText("You politely decline, explaining that you were just stopping by to say hello. Frida waves at you as you get up.");
				outputText("\n\n\"<i>You come back and see me soon, you hear?</i>\"");
			}
			doNext(enterTheBlackCock);
		}
		
		//------------
		// PATRONS
		//------------
		private function checkPatrons():void {
			var patronCount:int = 0;
			clearOutput();
			menu();
			if (model.time.hours >= 19) {
				outputText("There is a large group of loud satyrs taking up a table, throwing back mugs of beer and belching loudly, obviously too absorbed in their drinking to pay attention to anyone else.\n\n");
				addButton(0, "Satyrs", satyrGangIntro);
				patronCount++;
			}
			if (patronCount == 0) outputText("There appears to be nobody interesting here.");
			addButton(14, "Back", enterTheBlackCock);
		}
		
		private function satyrGangIntro():void {
			clearOutput();
			outputText(images.showImage("satyr-gang-intro"));
			outputText("As you walk towards the table of drunken satyrs the combined scents of arousal and booze hit you like a fist to the face. The drunk hairy goat men, unlike the satyr waiter, are beer bellied with muscle ripped arms and short unkempt excuses for horns. You spy several tall standing erections among the men as they shout for more beer, beer that is already being delivered to their table. One of the patrons smacks their satyr waiter's ass as he sets the beer down. He just chuckles and pulls an arm from around his waist, telling his customers he can't play and he has to work. They seem rowdy, rough and horny.");
			outputText("\n\nSuddenly one of them notices you watching their group and calls out.");
			outputText("\n\n\"<i>Hey… yuuz gonna jus' stand there and watch or you wanta cum sit on this gud dick?</i>\" He slurs through a thick auburn beard, holding his dick in one hand and a beer in another. Without waiting for an answer two hands at either sides catch you by the wrists.");
			menu();
			if (player.lust >= 33) {
				if (!player.isTaur()) {
					addButton(0, "Let Them", letTheSatyrsHaveTheirWayWithYou, false, null, null, "Let the satyrs have their way with you. This is going to be rough and intense. ");
					if (player.hasVagina()) addButton(5, "No Rimjobs", letTheSatyrsHaveTheirWayWithYou, true, null, null, "Let the satyrs have their way with you. This is going to be rough and intense. Also signal that you don't want to rim one of the satyr's asses.");
				}
				else addButtonDisabled(0, "Let Them", "You doubt you'll be able to participate into the orgy with your tauric body.");
			}
			else addButtonDisabled(0, "Let Them", "You aren't horny enough to consider that.");
			addButton(1, "No", dontLetTheSatyrsFuck);
		}
		
		private function letTheSatyrsHaveTheirWayWithYou(noRimjob:Boolean = false):void {
			clearOutput();
			outputText(images.showImage("satyr-gang-bang"));
			if (!player.isTaur()) {
				outputText("Greedy hands yank you back first over the table. The rough satyrs position you so your [ass][if (hasTail = true) \" and tail\"] hang off the edge of the table. Immediately they begin pulling off your [armor]. As your body comes into view they make grunts of approval; they all begin high fiving and you hear several brash comments about your body including, \"<i>[He]'s a beaut isn't [he]?</i>\" and \"<i>SKULLFUCK, SKULLFUCK, SKULLFUCK.</i>\"");
				outputText("\n\nThe other patrons in the tent merely glance over and give a little shrug, not caring that you're about to be gang banged by a bunch of horny satyrs.");
				outputText("\n\nOne of the satyrs holds up a beer and yells something about a toast in your name. Cold beer splashes down your [fullChest] as the group of drunk satyrs give a barely audible toast as they all whip out their human dicks, already dripping with need.");
				outputText("\n\nA burly satyr hops on the table, straddling your face. He gives a bleat of pure joy as he swings apple sized balls around before smashing them against your [face]. You chuckle against the hot orbs as hands tug and yank you in different directions. You open your mouth and slather those swollen orbs with your tongue. The mind numbing scent of arousal is heavy in the air. You're surrounded by satyrs wrestling to get into position around you; you catch one being forced to his knees by another before a thick dick dripping with need is shoved into his throat.");
				outputText("\n\nOne breaks from the herd and you begin to feel his fingers spreading your [ass]. Your [legs] are roughly manipulated out of the way before suddenly a thick dick is being forcefully shoved against your back door.");
				player.buttChange(24, true);
				if (player.ass.analLooseness <= 1) outputText("\n\nYour painful groan is lost in the fuzzy sack smothering your face as you are roughly entered. You hear something about needing grease above the cacophony of cheering and groaning. The invading penis is suddenly retracted from your ass, the slicing pressure suddenly gone. Then your butt is pushed up into the air. You here a rise in the hoops and hollers as several gobs of spit land on your [asshole]. A finger roughly forces your hole open, pushing the slick spit deeper into your tight ass. The satyr sitting on your face begins bouncing, his large balls tea bagging your open mouth. A hard slap lands on your upturned ass before you're dropped and yanked towards the rough satyr. His dick presses back into you, aided by the added lubricant. The sensation is actually making you groan into the orbs stretching your jowls. The dick at your back side begins roughly fucking you with powerful body jarring strokes that keep your mind in that hazy limbo between pain and pleasure. You find yourself quickly adapting to the sensation of being roughly pounded.");
				else if (player.ass.analLooseness <= 3) outputText("\n\nYour lust filled groan is lost in the fuzzy sack smother your face as you are roughly entered. After a few strokes your feel the satyr at your ass roughly slap your [ass]. He begins roughly pounding your [asshole] inward, as if determined to merge his big bloated dick with your ass. A groan above you tells you the guy with his balls in your face is enjoying himself. The satyr fucking your [asshole] growls like a dog as he increases his pace until his thrusts are moving you across the table, much to the tea bagging satyr's delight. You hear a repeated bleating sound to your right and looking with your eyes you watch as a satyr is shoved horns first into the ground and roughly pounded by one of the others. The hooping and hollering group gets more rowdy as you are force fed a heavy, sweaty sac and forcibly fucked by a big bloated dick that fills you up and makes you cry out in euphoric delight.");
				else outputText("\n\nYou smile against the fuzzy sweaty liquid filled balls on your face as you are roughly impaled by one of the satyrs. He's not small but he's definitely not the biggest thing you've ever had in there. The satyr above you bleats and you open your mouth, listening to him sigh as he begins grinding his sac against your tongue and lips again. The satyr fucking your [ass] says something about room for more and another dick pushes its way into your [asshole]. Now that's more like it. The owner of the second dick pushing into your [asshole] must be under the table, holding onto the sides to keep himself up as he shoves his dick in alongside his friend's. As the two well endowed satyrs fuck your [asshole] with rough thrusts you can't help reaching down to spread your [ass]. With your mouth full of fuzzy nuts you groan. The two satyrs fucking your ass begin to synchronize and it feels as if one hot slab of meat is forcing its way through your experienced hole with reckless body jarring thrusts that have you cringing with need.");
				outputText("\n\nThe satyr ball fucking your [face] stands above you, jerking his towering erection and trembling as he begins shooting his heated baby batter on your [fullChest]. Now that you're looking at something other than his little black rosebud you can better see the other satyrs standing around you. Some are stroking their drooling dicks as they drink, curse and wrestle for position. Others have forgotten you completely and are fucking the faces and asses of weaker satyrs.");
				if (player.hasVagina()) {
					outputText("\n\nA nimble satyr standing on the sidelines manages to break from the others. He hops upon the table, standing above you and blocking the satyr roughly fucking your [ass] from view. ");
					if (player.isBiped()) outputText("The satyr presses your [legs] forward. ");
					else if (player.isNaga()) outputText("The satyr embraces your coils as they slide around his body. ");
					outputText("With a happy smile he enters you with a greedy shove of his hips.");
					player.cuntChange(24, true);
					if (noRimjob) {
						if (player.vaginas[0].vaginalLooseness <= 1) outputText("\n\nYour mouth stretches open into a howl of mixed pain and pleasure as your [pussy] is forcibly stretched by the satyr's giant dick. The constant pounding of your [asshole] is soon joined by a girthy prick sawing in and out of your vagina. You begin to tremble uncontrollably as you are fucked raw by multiple rough girthy dicks. Your [pussy] feels like it's being split open by the hot meat slicing through your vaginal opening. Luckily it only takes you a short time to adapt to the sensation. Your [pussy] and [ass] are being stuffed and pounded by pros and you know one of the satyrs surrounding you, jerking their dicks, was fucking this one. ");
						else if (player.vaginas[0].vaginalLooseness <= 3) outputText("\n\nYour mouth stretches open into a groan dripping with pleasure as the dick slides into your [vagina]. You revel in the dicks pounding your [asshole] and [pussy].");
						else outputText("\n\nYou grin as the dick slams into your [pussy] with a sudden deep thrust. The satyr looks down with wide eyes and then up. With a snarl he begins pounding for all he's worth. Your [pussy] is being pounded harder and faster than your [asshole] and you can't help loving the dual sensations. The clattering of hooves on table makes you look up. You revel in the dicks pounding your [asshole] and [pussy].");
					}
					else {
						if (player.vaginas[0].vaginalLooseness <= 1) outputText("\n\nYour mouth stretches open into a howl of mixed pain and pleasure as your [pussy] is forcibly stretched by the satyr's giant dick. The constant pounding of your [asshole] is soon joined by a girthy prick sawing in and out of your vagina. You begin to tremble uncontrollably as you are fucked raw by multiple rough girthy dicks. As soon as you open your mouth to howl in ecstasy another satyr hops on the table, this one smashing his little black cherry into your open mouth. You can barely concentrate on rimming the satyr on your face as your [vagina] and [ass] are roughly fucked as you find yourself trembling and moaning into the sweaty ass engulfing your [face]. Your [pussy] feels like it's being split open by the hot meat slicing through your vaginal opening. Luckily it only takes you a short time to adapt to the sensation. As you are violently fucked, the satyr on your face presses his hot little bud into your face. You can taste the bitter sweetness of another man's seed dripping from his happy hole. Your [pussy] and [ass] are being stuffed and pounded by pros and you know one of the satyrs surrounding you, jerking their dicks, was fucking this one. You swirl your tongue and press it into him. The little guy doesn't survive the quick licks and soon explodes onto your [fullChest], his seed joining his buddy's.");
						else if (player.vaginas[0].vaginalLooseness <= 3) outputText("\n\nYour mouth stretches open into a groan dripping with pleasure as the dick slides into your [vagina]. As soon as your mouth is open another satyr hops onto the table, his hooves clicking on the wood as he squats and offers you his black little cherry. Looking up you can plainly see that he was just getting fucked; his hole drips pearly white seed down onto his fuzzy balls, his heavy ass cheeks naturally spreading. He smashes his greedy ass into your face. You revel in the dicks pounding your [asshole] and [pussy] as you taste the potent bitter sweetness of the seed leaking from the satyr. You swirl your tongue as your body is propelled up and down the table. The fucked satyr doesn't manage to hold on for long and soon he's squirting all over your [fullChest].");
						else outputText("\n\nYou grin as the dick slams into your [pussy] with a sudden deep thrust. The satyr looks down with wide eyes and then up. With a snarl he begins pounding for all he's worth. Your [pussy] is being pounded harder and faster than your [asshole] and you can't help loving the dual sensations. The clattering of hooves on table makes you look up. Above you is a satyr, squatting to offer you his black rosebud. Looking up you can plainly see that he was recently getting fucked; his hole drips pearly white seed as he smashes it into your face. You revel in the dicks pounding your [asshole] and [pussy] as you taste the potent bitter sweetness of the seed leaking from the satyr. You swirl your tongue as your body is propelled up and down the table. The fucked satyr doesn't manage to hold on for long and soon he's squirting his hot load all over your [fullChest].");
						outputText("\n\nThe spent satyr hops off of your [face] with a happy bleat and you watch him get shoved back into the table as a taller satyr grabs his horns and begins pounding him again, just as you are being pounded by the satyrs pushing you across the table.");
					}
				}
				if (player.hasCock()) {
					outputText("\n\nAs you are fucked hard, your wagging of [eachCock] draws the attention of several of the satyrs. Despite the fact that most of them are already getting fucked you can see them eyeing your meat in obvious hunger.");
					if (player.cockTotal() == 1) {
						outputText("\n\nA single one of the dick hungry satyrs climbs onto your body. The pot bellied little guy is shorter than the rest and as he reaches down and pulls your dick to his hole the satyr filling your ass reaches onto his shoulders and pushes the little guy down with a fierce snarl");
						if (player.hasVagina()) outputText(", surprising the satyr balls deep in your [pussy]");
						outputText(".");
						if (player.biggestCockLength() < 10) outputText("The satyr's hungry well fucked ass swallows your [cock] whole without a single problem. The dual sensations of being fucked and ridden have your head swimming in ecstasy. His ass feels wet and you're pretty sure one of the satyrs fucking around your table were fucking him and lost a load in his ass. The fact that you're being pounded and ridden is quickly getting to you, and you know it won't be long before you lose a load into the satyrs well fucked cum tunnel.");
						else if (player.biggestCockLength() >= 10 && player.biggestCockLength() < 14) outputText("\n\nThe satyr groans as he is forced down your [cock]. You can feel the creamy wetness of another man's seed as your [cock] stretches this satyr's little black cherry. Once he has sunk all the way down your length he begins to bounce, his hungry little ass working your [cock] like full time job. The dual sensations of being fucked and ridden have your head swimming in ecstasy. The fact that you're being pounded and ridden is quickly getting to you, and you know it won't be long before you let loose your own load into the cum caked back door.");
						else outputText("\n\nThe satyr flinches and whines as he is forced down your [cock] with clenched teeth. The dual sensations of being ridden and fucked have your head swimming in ecstasy. As your length forcibly stabs into his ass, your eyes roll back and your neck goes slack, your head now hanging off the table. The bleating becomes more hurried as you reach down and help the satyr fucking your ass to push the little whining guy down your full length. Once he's hilted he trembles, his ass milking your dick as yet another load of funky satyr jizz fires onto your [fullChest]. The ass massaging your [cock] is blissfully tight as he unloads and soon you're pulling the little guy up and down your length, slapping his ass to make him ride your [cock] for all he's worth.");
						outputText("\n\nWhen you open your eyes you see two satyrs wrestling, attempting the dominate each other as you are fucked and ridden. Turning your head you see two satyrs fucking a third, filling him from both ends as the staff and patrons watch the satyr orgy with you in the middle. Then a furred groin darkens your view. Your chin is gripped and a thick cockhead slathers leaking pre onto your [face]. The satyr seems taller than the others, and you open your lips to accept the dick being shoved against your lips.");
					}
					if (player.cockTotal() >= 2) {
						outputText("\n\n[eachCock] surges with anticipation as you're roughly fucked. Then some of the satyrs being fucked are pushed up onto the table and you notice, with a pleased smile that there's one for each of your dicks. The first one straddles you and slides down your [cock 1], his cum lubed ass sliding down your [cock 1], accepting all you have to offer with a grin on his little butt slut face. The next one sits on your [cock 2], his face euphoric as he rubs his ass against your trunk, moaning as you feel his slick hole squeeze your [cock 2]");
					}
					if (player.cockTotal() >= 3) {
						outputText("\n\nThis continues until [eachCock] has a satyr sitting on it.");
					}
					outputText(" The sensation of them just sitting there is almost enough to push you over the edge. Even the satyrs who were roughly fucking you just moments before take a break and let you get used to the sensation. At least that is what you think until a strong hand is pulling your head back and you're greeted with meaty beer belly and a stiff cock. This satyr seems to command a lot of respect. It's easy to see why, he's obviously the biggest both in terms of height and muscle and fat. Before you get a good look at the angry reddish pink dick below his fuzzy belly it is being forced into your mouth.");
					outputText("\n\nIt's not nearly as big as you would've thought and as you breath through your nose you smell the bitter sweet stink of his arousal. When he pulls out, every dick and ass lifts and pulls out as well. When he shoves forward, they do the same. Like a synchronized team the satyrs begin fucking and riding you hard, sending your lust into overdrive as you inhale their sweet sex.");
					outputText("\n\nThe wet feeling of cold beer splashing down your [fullChest] and mixing with the semen already there only serves to heightened the pleasure of the synchronized assault on your genitals.");
				}
				switch(player.gender) {
					case GENDER_NONE:
						outputText("\n\nThe hard pounding of your asshole is getting to you and soon you're trembling as you finally feel that sweet sensation of release.");
						break;
					case GENDER_MALE:
						outputText("\n\nThe pounding of your [asshole] and the hard riding of [eachCock] proves to be too much and soon you've erupted and each satyr fucking and being fucked by you responds by releasing his own seed, painting your chest, innards and throat with a white hot load.");
						break;
					case GENDER_FEMALE:
						outputText("\n\nYou begin to tremble as every dick inside you slams in to the hilt and unloads. The hot wet gushing feeling spreading inside your [asshole], your [pussy] and throat send you over the edge as your [pussy] spurts around the dick pressing forward and unloading its corrupt baby batter into your womb.");
						break;
					case GENDER_HERM:
						outputText("\n\nYou begin to tremble as every dick inside you slams in to the hilt and unloads. The hot wet gushing feeling spreading inside your [asshole], your [pussy] and throat sends you over the edge as [eachCock] swells and explodes. Your [pussy] spurts around the dick pressing forward and still unloading its hot corrupt baby batter into your womb.");
						break;
					default:
						outputText("\n\nThe hard pounding of your asshole is getting to you and soon you're trembling as you finally feel that sweet sensation of release.");
				}
				outputText("\n\nFinally exhausted, you slump on one of the satyrs, embracing his warm body. The rest of the satyrs are finally spent as well. When you've finally recovered from the ordeal, you get yourself cleaned up" + player.clothedOrNaked(", redress yourself") + " and return to your camp.");
			}
			player.orgasm();
			player.changeFatigue(25);
			dynStats("lib", 1, "sens", 2, "cor", 1);
			if (player.hasVagina()) player.knockUp(PregnancyStore.PREGNANCY_SATYR, PregnancyStore.INCUBATION_SATYR);
			player.buttKnockUp(PregnancyStore.PREGNANCY_SATYR, PregnancyStore.INCUBATION_SATYR);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function dontLetTheSatyrsFuck():void {
			clearOutput();
			outputText("Pulling your hands from their grip you tell the satyrs you weren't looking their way and make an abrupt U-turn, disappearing out the doors amidst a musical theme of laughter and feeling embarrassed as all hell.");
			doNext(enterTheBlackCock);
		}
		
		//------------
		// TRANSFORMATIONS
		//------------
		public function satyrTFs():void {
			var changes:int = 0;
			var changeLimit:int = 3;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			//Stats and genital changes
			if (rand(2) == 0) {
				outputText("\n\nHeat floods your loins as thoughts of tight round asses and dripping pussies flood your mind.");
				dynStats("lus", 25);
				if (player.lib < 100) {
					if (player.lib < 50) dynStats("lib", 1);
					dynStats("lib", 1);
				}
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.cocks[player.smallestCockIndex()].cockLength < 12) {
				outputText("\n\nHeat funnels into your cock as the alcohol flushes through you. Reaching down to inspect it, you find it has grown longer.");
				player.cocks[player.smallestCockIndex()].cockLength++;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.cocks[player.smallestCockIndex()].cockThickness < 4) {
				outputText("\n\nYou cock feels warm. When you reach down to inspect it your suspicions are confirmed; it's gotten thicker.");
				player.cocks[player.smallestCockIndex()].cockThickness += 0.5;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0) {
				outputText("\n\nYou feel a warmth rising into your face along with a bubbling of alcohol tickling your nose. Once it's subsided, you notice your face has a more masculine, angular shape to it.");
				//player.modFem(0, 2 + rand(4));
				dynStats("lus", 20);
				if (player.cumMultiplier < 10) player.cumMultiplier += 1;
				if (player.cumMultiplier < 50) player.cumMultiplier += 0.5;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.findStatusEffect(StatusEffects.BonusVCapacity) >= 0) {
				outputText("\n\nYou feel a tingling sensation in your vagina… that was weird.");
				if (player.findStatusEffect(StatusEffects.BonusVCapacity) >= 0) {
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, -(rand(5) + 5));
					if (player.findStatusEffect(StatusEffects.BonusVCapacity) <= 0) player.removeStatusEffect(StatusEffects.BonusVCapacity);
				}
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && !player.hasCock()) {
				outputText("\n\nYour vagina begins to feel hot. Removing your [armor], you look down and watch your vagina shrinks to nothing, <b>while your clitoris enlarges to form a human dick</b>.");
				player.removeVagina();
				player.createCock(6, 1, CockTypesEnum.HUMAN);
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.balls <= 0) {
				outputText("Without warning your body begins to tremble as just below [eachCock] you feel a warm trickling sensation of fluid sliding down your body. Before you can check it, the sensation becomes ovewhelming as [eachCock] grows hard and ejaculates " + player.clothedOrNaked("into your [armor]", "all over the ground") + ". Once you've recovered from your intense orgasm you " + player.clothedOrNakedLower("remove your [armor] to ") + "clean yourself and find a <b>new pair of balls</b> hanging just below [eachCock].");
				player.balls = 2;
				player.ballSize = 1;
				player.orgasm();
				changes++;
			}
			//Transformations
			if (rand(3) == 0 && changes < changeLimit && player.skinType == SKIN_TYPE_SCALES) {
				outputText("\n\nYou feel an odd rolling sensation as your scales begin to shift, spreading and reforming as they grow and disappear, <b>becoming normal human skin</b>.");
				player.skinType = SKIN_TYPE_PLAIN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.armType != ARM_TYPE_HUMAN) {
				outputText("\n\nYou feel a pleasant heat in your arms as smoke rises from them, <b>leaving normal human arms</b>.");
				player.armType = ARM_TYPE_HUMAN;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody != LOWER_BODY_TYPE_CLOVEN_HOOFED) {
				outputText("\n\nYou feel an odd sensation in your lower region. Your [feet] shift and you hear bones cracking as they reform. Fur grows on your legs and soon you're looking at a <b>new pair of goat legs</b>.");
				player.lowerBody = LOWER_BODY_TYPE_CLOVEN_HOOFED;
				player.legCount = 2;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED && player.hornType == HORNS_GOAT && player.faceType != FACE_HUMAN) {
				outputText("\n\nYour face grows warm as suddenly your vision is engulfed in smoke, coughing and beating the smoke back you noticed a marked change in your features. Touching yourself you confirm you have a <b>normal human shaped face once again</b>.");
				player.faceType = FACE_HUMAN;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.skinType != SKIN_TYPE_SCALES && player.earType != EARS_ELFIN) {
				outputText("\n\nYou feel an odd shifting sensation on the side of your head and, reaching up to inspect it, find a <b>pair of fleshy pointed ears</b>. "); 
				if (player.skinType == SKIN_TYPE_FUR) ("As you examine your new elvish ears you feel fur grow around them, matching the rest of you.");
				player.earType = EARS_ELFIN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hornType == HORNS_NONE) {
				outputText("\n\nYou begin to feel a prickling sensation at the top of your head. Reaching up to inspect it, you find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
				player.hornType = HORNS_GOAT;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hornType != HORNS_GOAT) {
				outputText("\n\nYou begin to feel an odd itching sensation as you feel your horns repositioning. Once it's over, you reach up and find a pair of hard stubs. <b>You now have a pair of goat horns.</b>");
				player.horns = 1;
				player.hornType = HORNS_GOAT;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hornType == HORNS_GOAT && player.horns == 1) {
				outputText("\n\nYou feel heat blooming in your forehead. Confused you reach up to find your goat horns growing and thickening into a pair of horns with ridges and a slight curve. <b>You now have a pair of tall-standing goat horns.</b>");
				player.horns = 2;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.antennae != ANTENNAE_NONE) {
				outputText("You feel heat blooming in your head, centered at your antennae. It is a feeling similar to the burn of alcohol. When you reach up to inspect them your hands find nothing but quickly dispersing smoke. <b>You no longer have a pair of antennae.</b>");
				player.antennae = ANTENNAE_NONE;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.cockTotal() == 1 && player.countCocksOfType(CockTypesEnum.HUMAN) == 0) {
				outputText("\n\nYou feel a stirring in your loins as your cock grows rock hard. You " + player.clothedOrNakedLower("pull it out from your [armor], to ") + "take a look. It seems you now <b>have a human dick again</b>.");
				player.cocks[0].cockType = CockTypesEnum.HUMAN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.cockTotal() > 1 && (player.cockTotal() - player.countCocksOfType(CockTypesEnum.HUMAN)) > 0) {
				outputText("\n\nOne of your penises begins to feel strange. You " + player.clothedOrNakedLower("pull it out from your [armor], releasing", "notice") + " a plume of thick smoke. When you look down you see it has <b>become a human dick</b>.");
				for (var i:int = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType != CockTypesEnum.HUMAN) {
						player.cocks[i].cockType = CockTypesEnum.HUMAN;
						break;
					}
				}
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.tailType == 0) {
				outputText("\n\nYou feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a short stubby tail that wags when you're happy. <b>You now have a goat tail.</b>");
				player.tailType = TAIL_TYPE_GOAT;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.tailType > 0 && player.tailType != TAIL_TYPE_GOAT) {
				outputText("\n\nYou [tail] suddenly goes numb. Looking back you see it changing, twisting and reforming into a <b>short stubby goat-like tail</b>.");
				player.tailType = TAIL_TYPE_GOAT;
				changes++;
			}
			//No changes?
			if (changes == 0) {
				outputText("\n\nAside from a mild buzz, the wine has no further effect.");
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function rhinoTFs():void {
			var changes:int = 0;
			var changeLimit:int = 3;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			// Stats Changes
			//------------
			if (rand(3) == 0 && player.str < 100) {
				changes++;
				if (player.str < 50) {
					outputText("\n\nShivering, you feel a feverish sensation that reminds you of the last time you got sick. Thankfully, it passes swiftly, leaving slightly enhanced strength in its wake.");
					dynStats("str", .5);
				}
				else {
					outputText("\n\nHeat builds in your muscles, their already-potent mass shifting slightly as they gain even more strength.");
				}
				dynStats("str", .5);
			}
			if (rand(3) == 0 && player.tou < 100) {
				outputText("\n\nYou thump your chest and grin - your foes will have a harder time taking you down while you're fortified by liquid courage.");
				dynStats("tou", 1);
			}
			if (rand(2) == 0 && player.spe > 80 && player.str >= 50) {
				outputText("\n\nYou begin to feel that the size of your muscles is starting to slow you down.");
				dynStats("spe", -1);
			}
			if (rand(3) == 0 && player.tou < 50 && changes < changeLimit) {
				outputText("\n\nYour skin feels clammy and a little rubbery. You touch yourself experimentally and notice that you can barely feel the pressure from your fingertips. Consumed with curiosity, you punch yourself lightly in the arm; the most you feel is a dull throb!", false);
				dynStats("sen", -1);
			}
			if (rand(3) == 0 && player.inte > 15 && player.faceType == FACE_RHINO && player.horns == 2) {
				outputText("\n\nYou shake your head and struggle to gather your thoughts, feeling a bit slow.");
				dynStats("int", -1);
			}
			if (rand(3) == 0 && player.rhinoScore() >= 2 && (rand(2) == 0 || !player.inRut) && player.hasCock()) {
				player.goIntoRut(true);
			}
			// Special TFs
			//------------
			if (rand(4) == 0 && changes < changeLimit && player.hornType != HORNS_UNICORN && player.earType == EARS_HORSE && (player.lowerBody == LOWER_BODY_TYPE_HOOFED || player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED || player.horseScore() >= 3)) {
				outputText("\n\nYou begin to feel an annoying tingling sensation at the top of your head. Reaching up to inspect it you find the <b>sharp nub of a horn protruding from the center of your forehead</b> and growing. Once it's complete you estimate it to be about six inches long.");
				player.hornType = HORNS_UNICORN;
				player.horns = 6;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.hornType == HORNS_UNICORN && player.horns > 0 && player.horns < 12) {
				outputText("\n\nYou begin to feel an intense pinching sensation in your central horn as it pushes out, growing longer and larger. You reach up and find <b>it has developed its own cute little spiral,</b> you estimate it to be about a foot long, two inches thick and very sturdy, a very useful natural weapon.");
				player.horns = 12;
				changes++;
			}
			// Normal TFs
			//------------
			//Removes wings
			if (rand(4) == 0 && changes < changeLimit && player.wingType > WING_TYPE_NONE) {
				if (player.wingType == WING_TYPE_SHARK_FIN) outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into your spine. After a moment the pain passes, though your fin is gone!", false);
				else outputText("\n\nA wave of tightness spreads through your back, and it feels as if someone is stabbing a dagger into each of your shoulder-blades. After a moment the pain passes, though your wings are gone!", false);
				player.wingType = WING_TYPE_NONE;
				changes++;
			}
			//Fur/scales fall out
			if (rand(4) == 0 && changes < changeLimit && (player.skinType != SKIN_TYPE_PLAIN || player.skinTone != "gray" || player.skinAdj != "tough")) {
				outputText("\n\n");
				switch(player.skinType) {
					case SKIN_TYPE_PLAIN:
						outputText("You feel an itchy sensation as your skin thickens, <b>becoming tough gray skin</b>.");
						break;
					case SKIN_TYPE_FUR:
						outputText("You feel an itching sensation as your fur beings to fall off in clumps, <b>revealing tough gray skin</b> beneath it.");
						break;
					case SKIN_TYPE_SCALES:
						outputText("You feel an odd rolling sensation as your scales begin to shift, spreading and reforming as they grow and disappear, <b>becoming tough gray skin</b>.");
						break;
					case SKIN_TYPE_GOO:
						outputText("You feel an itchy sensation as your gooey skin solidifies and thickens, <b>becoming tough gray skin</b>.");
						break;
					default:
						outputText("You feel an itchy sensation as your skin thickens, <b>becoming tough gray skin</b>.");
				}
				player.skinTone = "gray";
				player.skinAdj = "tough";
				player.skinType = SKIN_TYPE_PLAIN;
				player.skinDesc = "skin";
				changes++;
			}
			//Arms change to regular
			if (rand(3) == 0 && changes < changeLimit && player.armType != ARM_TYPE_HUMAN) {
				switch(player.armType) {
					case ARM_TYPE_HARPY:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your feathery arms are shedding their feathery coating. The wing-like shape your arms once had is gone in a matter of moments, leaving " + player.skinDesc + " behind.");
						break;
					case ARM_TYPE_SPIDER:
						outputText("\n\nYou scratch at your biceps absentmindedly, but no matter how much you scratch, it isn't getting rid of the itch. Glancing down in irritation, you discover that your arms' chitinous covering is flaking away. The glossy black coating is soon gone, leaving " + player.skinDesc + " behind.");
						break;
					default:
				}
				player.armType = ARM_TYPE_HUMAN;
				changes++;
			}
			//Change legs to normal
			if (rand(4) == 0 && changes < changeLimit && player.lowerBody != LOWER_BODY_TYPE_HUMAN) {
				if (player.isBiped()) outputText("You feel an odd sensation in your [feet]. Your [feet] shift and you hear bones cracking as they reform into normal human feet.");
				player.lowerBody = LOWER_BODY_TYPE_HUMAN;
				player.legCount = 2;
				changes++;
			}
			//Removes antennaes!
			if (rand(3) == 0 && changes < changeLimit && player.antennae > ANTENNAE_NONE) {
				outputText("\n\nYour " + player.hairDescript() + " itches so you give it a scratch, only to have your antennae fall to the ground. What a relief. <b>You've lost your antennae!</b>", false);
				changes++;
				player.antennae = ANTENNAE_NONE;
			}
			//Hair turns back to normal
			if (rand(4) == 0 && changes < changeLimit && player.hairType != HAIR_NORMAL) {
				switch(player.hairType) {
					case HAIR_FEATHER:
						if (player.hairLength >= 6) outputText("\n\nA lock of your downy-soft feather-hair droops over your eye. Before you can blow the offending down away, you realize the feather is collapsing in on itself. It continues to curl inward until all that remains is a normal strand of hair. <b>Your hair is no longer feathery!</b>", false);
						else outputText("\n\nYou run your fingers through your downy-soft feather-hair while you await the effects of the item you just ingested. While your hand is up there, it detects a change in the texture of your feathers. They're completely disappearing, merging down into strands of regular hair. <b>Your hair is no longer feathery!</b>", false);
						break;
					case HAIR_GOO:
						outputText("\n\nYour gooey hair begins to fall out in globs, eventually leaving you with a bald head. Your head is not left bald for long, though. Within moments, a full head of hair sprouts from the skin of your scalp. <b>Your hair is normal again!</b>");
						break;
					case HAIR_GHOST:
						break;
					case HAIR_ANEMONE:
						outputText("\n\nYou feel something strange going in on your head. You reach your hands up to feel your tentacle-hair, only to find out that the tentacles have vanished and replaced with normal hair. <b>Your hair is normal again!</b>");
						break;
				}
				changes++;
				player.hairType = HAIR_NORMAL;
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
			}
			//Restart hair growth
			if (rand(3) == 0 && changes < changeLimit && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0) {
				outputText("\n\nYou feel an itching sensation in your scalp as you realize the change. <b>Your hair is growing normally again!</b>");
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
				changes++;
			}
			//Remove gills
			if (rand(4) == 0 && changes < changeLimit && player.gills) {
				outputText("\n\nYour chest itches, and as you reach up to scratch it, you realize your gills have withdrawn into your skin. <b>You no longer have gills!</b>");
				player.gills = false;
				changes++;
			}
			// Rhino TFs
			//------------
			//Change a cock to rhino.
			if (rand(4) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) < player.cockTotal()) {
				if (player.cockTotal() == 1) outputText("\n\nYou feel a stirring in your loins as your cock grows rock hard. ");
				else outputText("\n\nOne of your penises begins to feel strange. ");
				outputText("You " + player.clothedOrNakedLower("pull it out from your [armor]", "lean over") + ", right there in the center of The Black Cock, to take a look. You watch as the skin of your cock becomes a smooth, tough pink colored phallus. It takes on a long and narrow shape with an oval shaped bulge along the center. You feel a tightness near the base where your skin seems to be bunching up. A sheath begins forming around your flared rhino cock’s root, tightening as your stiff rhino dick elongates and settles, the thick flared head leaking a steady stream of funky animal-cum. <b>You now have a rhino-dick.</b>");
				for (var i:int = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType != CockTypesEnum.RHINO) {
						player.cocks[i].cockType = CockTypesEnum.RHINO;
						break;
					}
				}
				dynStats("lus", 20);
				changes++;
			}
			//Change ears to rhino
			if (rand(3) == 0 && changes < changeLimit && player.earType != EARS_RHINO) {
				outputText("\n\nYou feel an odd uncomfortable sensation in your ears. Reaching up you find your ears shifting into an open tube shape, once they’re done you flick them around, enjoying the sensation of your new ears swishing through the air. <b>You now have rhino ears.</b>");
				player.earType = EARS_RHINO;
				changes++;
			}
			//Change face to rhino
			if (rand(4) == 0 && changes < changeLimit && player.earType == EARS_RHINO && player.skinTone == "gray" && player.faceType != FACE_RHINO) {
				outputText("\n\nYour face suddenly goes numb. You begin to hear bone cracking as you vision suddenly shifts as you face stretches out and thickens. When your face is done growing you can see the edges of your elongated mouth and noise in the center of your field of vision. They barely impede your vision though. <b>You now have a rhino face.</b>");
				player.faceType = FACE_RHINO;
				changes++;
			}
			//Change tail to rhino
			if (rand(3) == 0 && changes < changeLimit && player.isBiped() && player.tailType != TAIL_TYPE_RHINO) {
				if (player.tailType > 0) outputText("\n\nYou [tail] suddenly goes numb. Looking back you see it changing, twisting and reforming into a long ropy tail with a little " + player.furColor + " tuft at the end. <b>You now have a rhino tail.</b>");
				else outputText("\n\nYou feel an odd itchy sensation just above your [ass]. Twisting around to inspect it you find a long ropy tail with a little " + player.furColor + " tuft on the end. <b>You now have a rhino tail.</b>");
				player.tailType = TAIL_TYPE_RHINO;
				changes++;
			}
			//Gain rhino horns
			//Tier 1
			if (rand(4) == 0 && changes < changeLimit && player.faceType == FACE_RHINO && player.hornType != HORNS_RHINO) {
				outputText("\n\nYou begin to feel an annoying tingling sensation at the top of your head. Reaching up to inspect it you find the sharp nub of a horn protruding from the center of your forehead and growing. Once it'sits complete you estimate it to be about six inches long. If it were sharper and a little longer it would make a useful natural weapon.");
				player.horns = 1;
				player.hornType = HORNS_RHINO;
				changes++;
			}
			//Tier 2
			if (rand(4) == 0 && changes < changeLimit && player.faceType == FACE_RHINO && player.hornType == HORNS_RHINO && player.horns == 1) {
				outputText("\n\nYou begin to feel an annoying tingling sensation at the edge of your nose, above your field of vision. Reaching up you feel the sharp edge of a curved horn growing out the edge of your face. The itchy tingle continues as you feel both of your horns become sharp and tall. You estimate your older horn to be a mere seven inches and your new horn to be around a foot long. They’ll be useful natural weapons.");
				outputText("\n<b>(Gained physical special: Upheaval! Any time you lose your rhino face or horns, you will lose this ability.)</b>");
				player.horns = 2;
				player.tailType = HORNS_RHINO;
				changes++;
			}
			// Other Changes
			//------------
			//Increase cock size of non-rhino up to 10 inches.
			var cocksAffected:int = 0;
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.smallestCockLength() < 10 && player.cockTotal() - player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
				cocksAffected = 0;
				for (i = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockLength >= 10) continue; //Skip over if rhino cock.
					temp = player.increaseCock(player.smallestCockIndex(), rand(2) + 1);
					dynStats("lib", 0.5, "lus", 3);
					cocksAffected++;
				}
				outputText("\n\n");
				player.lengthChange(temp, cocksAffected);
				changes++;
			}
			//Increase girth of rhino cock.
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
				cocksAffected = 0;
				for (i = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockThickness < 3) {
						player.cocks[i].thickenCock(0.5);
						dynStats("lib", 0.5, "lus", 3);
						break;
					}
				}
				changes++;
			}
			//Increase length of rhino cock.
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.RHINO) > 0) {
				cocksAffected = 0;
				for (i = 0; i < player.cockTotal(); i++) {
					if (player.cocks[i].cockType == CockTypesEnum.RHINO && player.cocks[i].cockLength < 18) {
						temp = player.increaseCock(i, 1 + rand(2));
						outputText("\n\n");
						player.lengthChange(temp, 1);
						dynStats("lib", 0.5, "lus", 3);
						break;
					}
				}
				changes++;
			}
			//Grow balls
			if (rand(3) == 0 && changes < changeLimit && player.balls > 0 && player.ballSize < 4) {
				if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin. You pause to examine the changes and your roving fingers discover your " + player.simpleBallsDescript() + " have grown larger than a human's.");
				if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + player.sackDescript() + ". Walking becomes difficult as you discover your " + player.simpleBallsDescript() + " have enlarged again.");
				dynStats("lib", 1, "lus", 3);
				player.ballSize++;
				changes++;
			}
			//Boost vaginal capacity without gaping
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 40) {
				if (player.findStatusEffect(StatusEffects.BonusVCapacity) < 0) player.createStatusEffect(StatusEffects.BonusVCapacity, 0, 0, 0, 0);
				player.addStatusValue(StatusEffects.BonusVCapacity, 1, 5);
				outputText("\n\nThere is a sudden... emptiness within your " + player.vaginaDescript(0) + ". Somehow you know you could accommodate even larger... insertions.");
				changes++;
			}
			//Boost anal capacity without gaping
			if (rand(3) == 0 && changes < changeLimit && player.hasVagina() && player.statusEffectv1(StatusEffects.BonusVCapacity) < 60) {
				if (player.statusEffectv1(StatusEffects.BonusACapacity) < 60) {
					if (player.findStatusEffect(StatusEffects.BonusACapacity) < 0) player.createStatusEffect(StatusEffects.BonusACapacity, 0, 0, 0, 0);
					player.addStatusValue(StatusEffects.BonusACapacity, 1, 5);
					outputText("\n\nYou feel... more accommodating somehow. Your " + player.assholeDescript() + " is tingling a bit, and though it doesn't seem to have loosened, it has grown more elastic.", false);
					changes++;
				}
			}
			//Gain height
			if (rand(2) == 0 && changes < changeLimit && player.tallness < 102) {
				temp = rand(5) + 3;
				//Slow rate of growth near ceiling
				if (player.tallness > 90) temp = Math.floor(temp / 2);
				//Constrain height growth
				if (temp == 0) temp = 1; //Never 0
				if (temp > 6) temp = 6; //Constrain growth to 6 inches
				//Flavor texts. Flavored like 1950's cigarettes. Yum.
				if (temp < 3) outputText("\n\nYou shift uncomfortably as you realize you feel off balance. Gazing down, you realize you have grown SLIGHTLY taller.");
				if (temp >= 3 && temp < 6) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
				if (temp == 6) outputText("\n\nStaggering forwards, you clutch at your head dizzily. You spend a moment getting your balance, and stand up, feeling noticeably taller.");
				player.tallness += temp;
				changes++;
			}
			//Gain muscle tone
			if (rand(2) == 0 && player.tone < 80) {
				if (player.tone < 50) player.modTone(80, 2 + rand(2));
				else player.modTone(80, 1 + rand(2));
			}
			//Gain thickness
			if (rand(2) == 0 && player.thickness < 80) {
				if (player.thickness < 50) player.modThickness(80, 2 + rand(2));
				else player.modThickness(80, 1 + rand(2));
			}
			//Slow hair production
			if (rand(3) == 0 && changes < changeLimit && flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] > 0) {
				outputText("\n\nYou feel a tingling sensation in your scalp. After a few seconds it stops… that was odd.");
				flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 0;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function echidnaTFs():void {
			var changes:int = 0;
			var changeLimit:int = 3;
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) changeLimit++;
			if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
			var i:int = 0;
			// Stats Changes
			//------------
			//None at the moment
			
			// Normal TFs
			//------------
			if (rand(4) == 0 && changes < changeLimit && player.hairType != HAIR_NORMAL && player.hairType != HAIR_QUILL) {
				outputText("\n\nYour scalp feels really strange, but the sensation is brief. You feel your hair, and you immediately notice the change. <b>It would seem that your hair is normal again!</b>");
				player.hairType = HAIR_NORMAL;
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.armType == ARM_TYPE_HARPY) {
				outputText("\n\nYour arm feathers fall out completely, <b>leaving only the " + player.skinFurScales() + " underneath.</b>");
				player.armType = ARM_TYPE_HUMAN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.gills) {
				outputText("\n\nYou grit your teeth as a stinging sensation arises in your gills. Within moments, the sensation passes, <b>and your gills are gone!</b>");
				player.gills = false;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.eyeType == EYES_FOUR_SPIDER_EYES) {
				outputText("\n\nYour two forehead eyes start throbbing painfully, your sight in them eventually going dark. You touch your forehead to inspect your eyes, only to find out that they have disappeared. <b>You only have two eyes now!</b>");
				player.eyeType == EYES_HUMAN;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.averageNipplesPerBreast() > 4) {
				outputText("\n\nA tightness arises in your nipples as three out of four on each breast recede completely, the leftover nipples migrating to the middle of your breasts. <b>You are left with only one nipple on each breast.</b>");
				for (i = 0; i < player.breastRows.length; i++) {
					player.breastRows[i].nipplesPerBreast = 1;
				}
				changes++;
			}
			// Main TFs
			//------------
			//Change to fur
			if (rand(3) == 0 && changes < changeLimit && player.skinType != SKIN_TYPE_FUR) {
				outputText("\n\nYou shiver, feeling a bit cold. Just as you begin to wish for something to cover up with, it seems your request is granted; <b>fur begins to grow all over your body!</b> You tug at the tufts in alarm, but they're firmly rooted and... actually pretty soft. Huh. ");
				player.skinAdj = "";
				player.skinDesc = "fur";
				player.skinType = SKIN_TYPE_FUR;
				player.furColor = "brown";
				changes++;
			}
			//Gain Echidna ears
			if (rand(3) == 0 && changes < changeLimit && player.earType != EARS_ECHIDNA) {
				outputText("\n\n");
				switch(player.earType) {
					case EARS_LIZARD:
						outputText("You feel a strange itching in your reptilian ears. As you scratch them, you can feel their scales flaking away, leaving you with smooth, rounded holes for ears.");
						break;
					default:
						outputText("Tightness centers on your scalp, pulling your ears down from their normal shape into small bumps with holes in their centers.");
				}
				outputText(" <b>You now have echidna ears!</b>");
				player.earType = EARS_ECHIDNA;
				changes++;
			}
			//Gain Echidna tail
			if (rand(3) == 0 && changes < changeLimit && player.earType == EARS_ECHIDNA && player.tailType != TAIL_TYPE_ECHIDNA) {
				outputText("\n\n");
				switch(player.tailType) {
					case TAIL_TYPE_NONE:
						outputText("You feel a brief pinch at the base of your spine. Reaching behind yourself, you find that a small stump has formed above your [ass], just barely enough to qualify as a tail.");
						break;
					case TAIL_TYPE_HARPY:
						outputText("You feel a soft tingle as your tail feathers fall out one by one, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_RABBIT:
						outputText("Your tiny, poofy bunny tail begins to feel chilly as its fur falls out in clumps, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_COW:
						outputText("Your ropey cow tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_CAT:
						outputText("Your long cat tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_DOG:
						outputText("Your wagging dog tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_KANGAROO:
						outputText("Your tapered kangaroo tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_LIZARD:
					case TAIL_TYPE_DRACONIC:
						outputText("Your long, tapered tail becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail. You now have an echidna tail!");
						break;
					case TAIL_TYPE_FOX:
						outputText("Your swishing fox tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_RACCOON:
						outputText("Your ringed raccoon tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_HORSE:
						if (player.isTaur()) outputText("Your shiny horse tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail. This new, mismatched tail looks a bit odd on your horse lower body.");
						else outputText("Your shiny horse tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_MOUSE:
						outputText("Your bald mouse tail becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_FERRET:
						outputText("Your tapered ferret tail begins to feel chilly as all of its fur falls out. It becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					case TAIL_TYPE_RHINO:
						outputText("The tip of your long rino tail begins to itch as the fur begins to fall out. The entire length of your tail becomes tight as the majority of the tail’s length recedes into your body, leaving you with just a little stump for a tail.");
						break;
					default: //Catch-all
						outputText("You groan as you feel your tail shifting and reforming. By the time the sensation is over, you find that you have a little stump for a tail.");
				}
				outputText(" <b>You now have an echidna tail!</b>");
				player.tailType = TAIL_TYPE_ECHIDNA;
				changes++;
			}
			//Gain Echidna legs
			if (rand(3) == 0 && changes < changeLimit && player.earType == EARS_ECHIDNA && player.tailType && TAIL_TYPE_ECHIDNA && player.lowerBody != LOWER_BODY_TYPE_ECHIDNA) {
				outputText("\n\n");
				switch(player.lowerBody) {
					//Irregular lower body type
					case LOWER_BODY_TYPE_CENTAUR: // should be done in other way now...
						outputText("You collapse to the ground, a sharp pain encompassing your equine lower body. The pain quickly becomes so severe that you black out on the spot. Eventually you awake to find that you no longer have the lower body of a horse. You have just two legs again, and your feet look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LOWER_BODY_TYPE_NAGA:
						outputText("You collapse to the ground, a sharp pain encompassing your serpentine tail. The pain quickly becomes so severe that you black out on the spot. Eventually you awake to find that you no longer have the lower body of a snake. You have two legs again, and your feet look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LOWER_BODY_TYPE_GOO:
						outputText("You collapse to the ground, a sharp pain encompassing your amorphous lower half. The pain quickly becomes so severe that you black out on the spot. Eventually you awake to find that you no longer have a gooey lower body. You have two legs again, and your feet look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					//Regular lower body type (Bipedal)
					case LOWER_BODY_TYPE_HUMAN:
						outputText("You feel a sharp stinging at your toenails that only grows worse by the second. As you inspect your aching toes, you’re shocked to see that your toenails are lengthening, eventually becoming fierce claws. It would seem that the bottoms of your feet have changed as well. They’ve become padded!");
						break;
					case LOWER_BODY_TYPE_HOOFED:
					case LOWER_BODY_TYPE_CLOVEN_HOOFED:
						outputText("You nearly drop to the ground as a fuzzy sensation erupts at your hooves. Have they gone to sleep? As you inspect your feet, you find that they are no longer hooved! In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LOWER_BODY_TYPE_HARPY:
					case LOWER_BODY_TYPE_DEMONIC_CLAWS:
					case LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS:
					case LOWER_BODY_TYPE_LIZARD:
					case LOWER_BODY_TYPE_DRAGON:
						outputText("Your feet feel strange, almost as if they’ve fallen asleep. What’s wrong with them? You take a look, and you’re shocked to see that your feet have changed. In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					case LOWER_BODY_TYPE_CAT:
					case LOWER_BODY_TYPE_DOG:
					case LOWER_BODY_TYPE_FOX:
					case LOWER_BODY_TYPE_KANGAROO:
					case LOWER_BODY_TYPE_BUNNY:
					case LOWER_BODY_TYPE_RACCOON:
					case LOWER_BODY_TYPE_FERRET:
						outputText("Ow! What’s wrong with your paws? They hurt! You sit down, taking a moment to inspect your aching paws. What’s this? It would appear that they’ve changed! In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
						break;
					default: //Catch-all
						outputText("Your feet feel strange, almost as if they’ve fallen asleep. What’s wrong with them? You take a look, and you’re shocked to see that your feet have changed. In fact, they look a lot like your old human feet. The only difference is that your toes are clawed, and the bottoms of your feet padded.");
				}
				outputText(" <b>They actually look like the feet of an echidna!</b>");
				player.lowerBody = LOWER_BODY_TYPE_ECHIDNA;
				player.legCount = 2;
				changes++;
			}
			//Gain Echidna cock
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.countCocksOfType(CockTypesEnum.ECHIDNA) < player.cockTotal()) {
				outputText("\n\n");
				if (player.cockTotal() == 1) outputText("Your [cock] suddenly becomes rock hard out of nowhere. You " + player.clothedOrNakedLower("pull it out from your [armor], right in the middle of the food tent, watching", "watch") + " as it begins to shift and change. It becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath.");
				else outputText("One of your penises begins to feel strange. You " + player.clothedOrNakedLower("pull the offending cock out from your [armor], right in the middle of the food tent, watching", "watch") + " as it begins to shift and change. It becomes pink in color, and you feel a pinch at the head as it splits to become four heads. " + (player.hasSheath() ? "" : "The transformation finishes off with a fleshy sheath forming at the base.") + " It ejaculates before going limp, retreating into your sheath.");
				outputText(" <b>You now have an echidna penis!</b>");
				for (i = 0; i < player.cocks.length; i++) {
					if (player.cocks[i].cockType != CockTypesEnum.ECHIDNA) {
						player.cocks[i].cockType = CockTypesEnum.ECHIDNA;
						break;
					}
				}
				changes++;
			}
			//Gain Echidna tongue
			if (rand(3) == 0 && changes < changeLimit && player.echidnaScore() >= 2 && player.tongueType != TONGUE_ECHIDNA) {
				outputText("\n\nYou feel an uncomfortable pressure in your tongue as it begins to shift and change. Within moments, you are able to behold your long, thin tongue. It has to be at least a foot long. <b>You now have an echidna tongue!</b>");
				player.tongueType = TONGUE_ECHIDNA;
				changes++;
			}
			//Gain quill hair
			if (rand(4) == 0 && changes < changeLimit && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 1 && player.hairType == HAIR_NORMAL) {
				outputText("\n\nYour scalp begins to tingle as your hair falls out in clumps, leaving you with a bald head. You aren’t bald for long, though. An uncomfortable pressure racks the entirety of your scalp as hard quills begin to sprout from your hair pores. Their growth stops as they reach shoulder length. <b>You now have quills in place of your hair!</b>");
				player.hairType = HAIR_QUILL;
				changes++;
			}
			//Gain Echidna face if you have the right conditions.
			if (rand(4) == 0 && changes < changeLimit && player.skinType == SKIN_TYPE_FUR && player.earType == EARS_ECHIDNA && player.tailType == TAIL_TYPE_ECHIDNA && player.tongueType == TONGUE_ECHIDNA) {
				outputText("You groan loudly as the bones in your face begin to reshape and rearrange. Most notable, you feel your mouth lengthening into a long, thin snout. <b>You now have an echidna face!</b>");
				player.faceType = FACE_ECHIDNA;
				changes++;
			}
			// Other Changes
			//------------
			//Hair stops growing
			if (rand(4) == 0 && changes < changeLimit && player.echidnaScore() >= 2 && flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
				outputText("\n\nYour scalp tingles oddly. In a panic, you reach up to your " + player.hairDescript() + ", but thankfully it appears unchanged.\n");
				outputText("(<b>Your hair has stopped growing.</b>)");
				changes++;
				flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD]++;
			}

			//Sexual changes
			if (rand(3) == 0 && changes < changeLimit && player.hasCock() && player.cumMultiplier < 25) {
				temp = 1 + rand(4);
				//Lots of cum raises cum multiplier cap to 2 instead of 1.5
				if (player.findPerk(PerkLib.MessyOrgasms) >= 0) temp += rand(10);
				temp *= 0.1;
				player.cumMultiplier += temp;
				//Flavor text
				if (player.balls == 0) outputText("\n\nYou feel a churning inside your gut as something inside you changes.", false);
				if (player.balls > 0) outputText("\n\nYou feel a churning in your " + player.ballsDescriptLight() + ". It quickly settles, leaving them feeling somewhat more dense.", false);
				outputText(" A bit of milky pre dribbles from your " + player.multiCockDescriptLight() + ", pushed out by the change.", false);
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.gender == GENDER_MALE && player.averageBreastSize() > 2 && flags[kFLAGS.HYPER_HAPPY] == 0) {
				outputText("\n\nYou cup your tits as they begin to tingle strangely. You can actually feel them getting smaller in your hands!");
				player.shrinkTits();
				changes++;
			}
			if (rand(4) == 0 && changes < changeLimit && player.echidnaScore() >= 3 && player.hasVagina() && player.findPerk(PerkLib.Oviposition) < 0) {
				outputText("\n\nDeep inside yourself there is a change.  It makes you feel a little woozy, but passes quickly.  Beyond that, you aren't sure exactly what just happened, but you are sure it originated from your womb.\n");
				outputText("(<b>Perk Gained: Oviposition</b>)");
				player.createPerk(PerkLib.Oviposition, 0, 0, 0, 0);
				changes++;
			}
			if (rand(3) == 0 && (rand(2) == 0 || !player.inHeat) && player.hasVagina() && player.statusEffectv2(StatusEffects.Heat) < 30) {
				player.goIntoHeat(true);
			}
			//Thickness and hip modifier
			if (rand(2) == 0 && player.thickness < 90) {
				player.modThickness(90, 2);
			}
			if (rand(2.4) == 0 && changes < changeLimit && player.hasVagina() && player.mf("m", "f") == "f" && player.hipRating < 14) {
				outputText("\n\nAfter finishing, you find that your gait has changed. Did your [hips] widen?");
				player.hipRating++;
				changes++;
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		}
		
		public function mysteryMeatTFs():void {
			//outputText("\n\n<b>Mystery meat transformations are not yet implemented.</b>");
		}
	}

}
