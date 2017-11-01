/**
 * ...
 * @author Liadri
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponRangeLib;
import classes.display.SpriteDb;

public class CeaniScene extends NPCAwareContent
	{
		
		public function CeaniScene() 
		{}

public function ceaniAffection(changes:Number = 0):Number
{
	flags[kFLAGS.CEANI_AFFECTION] += changes;
	if (flags[kFLAGS.CEANI_AFFECTION] > 100) flags[kFLAGS.CEANI_AFFECTION] = 100;
	return flags[kFLAGS.CEANI_AFFECTION];
}

private function bowSkill(diff:Number):Number {
	player.addStatusValue(StatusEffects.Kelt,1,diff);
	if(player.statusEffectv1(StatusEffects.Kelt) >= 100) player.changeStatusValue(StatusEffects.Kelt,1,100);
	return player.statusEffectv1(StatusEffects.Kelt);
}

public function firstmeetingCeani():void
{
	spriteSelect(SpriteDb.s_ceani);
	clearOutput();
	outputText("As you wander the beach you suddenly spot a weird fish like creature diving in and out of the water. At first you mistake it for some kind of local fish until you realise no fish actually has bright pink hair! Out of nowhere the figure jump out of the water with a harpoon at hand as it throws the weapon at what looks to be a decently sized tuna. You watch in stupor as the humanoid chase the Tuna throwing more and more harpoons ");
	outputText("until the fish is finally unable to swim anymore. As you try to ponder what is happening, the figure jump out of the water carrying the freshly impaled Tuna. It's a woman... a eleven feet tall monster of a woman with a white underbelly and pitch black glossy skin. You're still looking at her with wide eye when she drop the tuna on the ground with a loud thump, her face has a large whale nose, she is smiling as she finally takes notice of you.\n\n");
	outputText("\"<i>Oh... hello! I’m Ceani, are you from the area? I don’t recall seeing you on the beach before.</i>\"\n\n");
	outputText("You're too busy gawking at the huge harpoon still impaled in the tuna to answer to the, surprisingly gentle, orca morph.\n\n");
	outputText("\"<i>Oh that? Its nothing you know. Bet you could learn to do it to with some training if you wanted to.</i>\"\n\n");
	outputText("Really, could she teach you how how to use ranged weapon?\n\n");
	outputText("\"<i>Yea sure, but, I will need a compensation for it because if I’m training you I’m not hunting and I need plenty of food to eat.</i>\"\n\n");
	outputText("Her sharp toothed smile tells you she must indeed eat her fair share of fish daily. You consider her offer for a moment as she leaves adding.\n\n");
	outputText("\"<i>If you want some lessons I will be at the beach, seek me out with at least 50 gems.</i>\"\n\n");
	outputText("You head back to camp considering this golden opportunity.\n\n");
	flags[kFLAGS.CEANI_AFFECTION] = 3;
	flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function basicarcherytraining():void
{
	spriteSelect(SpriteDb.s_ceani);
	clearOutput();
	outputText("You spot Ceani in the distance. Do you wish to spend 50 gem to train with ranged weapon?\n\n");
	menu();
	addButton(0, "No", basicarcherytraining1);
	addButton(1, "Yes", basicarcherytraining2);
}

public function basicarcherytraining1():void
{
	outputText("You wave and wish Ceani a great day as you head back to camp.\n\n");
	doNext(camp.returnToCampUseOneHour);
}

public function basicarcherytraining2():void
{
	player.gems -= 50;
	if (flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 3 && player.statusEffectv1(StatusEffects.Kelt) >= 90) {
		outputText("You seek out Ceani and ask her if she could resume your training. The both of you head to the training ground. Once there she help you to position yourself properly and show you how to throw the javelins. You do so for a few hours moving to recover your weapon every few shots. ");
		outputText("All the while you have a good show of Ceani sexy glossy skin and JJ cup breast held by her pink bikini. Somehow you manage to ignore the distraction and focus anyway hitting bullseye several time.\n\n");
		outputText("\"<i>You got it! Yeah just like that! I think this will likely be our last session together, but before you go, I got a special gift for you to commemorate your graduation.</i>\"\n\n");
		outputText("Ceani go to a nearby barrel and pull out a set of harpoons with a sea animal design on it.\n\n");
		outputText("\"<i>This is an enchanted weapon and nah, it has nothing in particular except the bundle endlessly replenish when emptied. You shouldn't run out of harpoons to throw in battle. People who can properly use these are far and few, so I think it's important for you to have your own set.</i>\"\n\n");
		outputText("Ceani pulls you in, kiss your cheek and walk away, swiftly jumping back into the sea. What a thoughtful gift.\n\n");
		flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 4;
		bowSkill(10);
		inventory.takeItem(weaponsrange.SHUNHAR, camp.returnToCampUseTwoHours);
	}
	else if ((flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 2 || flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 3)) {
		outputText("You seek out Ceani and ask her if she could resume your training. The both of you head to the training ground. Once there she help you to position yourself properly and show you how to throw the javelins. You do so for a few hours, moving to recover your weapon every few shots. ");
		outputText("All the while you have a good show of Ceani sexy glossy skin and JJ cup breast held by her pink bikini. She has to regularly remind you to keep the eyes on the target and not on the ‘horizon’.\n\n");
		outputText("\"<i>Your doing well, but were far from done you're going to need more training before you can effectively aim at a moving target.</i>\"\n\n");
		outputText("The session ends well, you learned a few tricks but you know all too well you're still far from your teachers skill.\n\n");
		outputText("\"<i>Well you're free to go, I can’t teach you more anyway, and, there's a barrel of fish by that otter girl fisherwoman just waiting for me. Come back tomorrow for more training.</i>\"\n\n");
		outputText("You head back to camp resolving to visit her again to resume training.\n\n");
		if (flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 2) flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 3;
		flags[kFLAGS.CEANI_DAILY_TRAINING] = 1;
		bowSkill(10);
		doNext(camp.returnToCampUseTwoHours);
	}
	else {
		outputText("You seek out Ceani and ask her if she could train you in the use of ranged weapons.\n\n");
		outputText("\"<i>First, take these, you will need them for the training.</i>\"\n\n");
		outputText("She hands you a pack of javelins. They look to be of fairly good quality, even if they are novices weapons.\n\n");
		outputText("\"<i>I've set up a few targets on the beach, we will be practicing there. Now if you don’t have any question, let us begin.</i>\"\n\n");
		outputText("The two of you head to the shooting range. Once there she quickly teach you how to position yourself properly and show you how to throw the javelins. You do so for a few hours moving to recover your weapon every few shots. All the while you have a good show of Ceani sexy glossy skin and JJ cup breasts held by her pink bikini. She has to regularly remind you to keep the eyes on the target and not on the ‘horizon’.\n\n");
		outputText("\"<i>Your doing well but we are barely getting started. You're going to need more training before you can effectively aim at a moving target.</i>\"\n\n");
		outputText("The session ends well, you learned a few tricks but you know all too well you're still far from your teachers skill.\n\n");
		outputText("\"<i>Well you're free to go, I can’t teach you more anyway, and, there's a barrel of fish by that otter girl fisherwoman just waiting for me. Come back tomorrow for more training.</i>\"\n\n");
		outputText("You head back to camp resolving to visit her again tomorrow to resume your training.\n\n");
		flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 2;
		flags[kFLAGS.CEANI_DAILY_TRAINING] = 1;
		if (!player.hasStatusEffect(StatusEffects.Kelt)) {
			player.createStatusEffect(StatusEffects.Kelt, 10, 0, 0, 0);
		}
		else bowSkill(10);
		inventory.takeItem(weaponsrange.TRJAVEL, camp.returnToCampUseTwoHours);
	}
}

public function beachInteractionsAfterArcheryTraining():void
{
	clearOutput();
	if (player.statusEffectv1(StatusEffects.Kindra) > 145 && player.weaponRange == weaponsrange.SHUNHAR && flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 4) {
		outputText("You have gone a long way in learning how to use various ranged weapons. It occurs to you Ceani could learn a thing or two from you, and, as you spot the orca girl lazily resting on the beach you give her a wave.\n\n");
		outputText("\"<i>Hey it’s [name] long time no see! How has the demon fishing been going?</i>\"\n\n");
		outputText("You laugh and tell her that you’re doing well. As a matter of fact you even learned more tricks since you left out. The orca make a playful smile.\n\n");
		outputText("\"<i>Oh? So the student thinks it has surpassed the teacher? Well how about this, let's have a fishing contest. Whoever impales the most fish for dinner gets a reward. If I win, I get a free dinner with you, otherwise, I have a final trick for the harpoon I can show you.</i>\"\n\n");
		outputText("She’s on! The both of you head to the beach, weapon at the ready, and start making brochettes out of the fishes. Both of you eventually come back to Ceani’s seaside camp with your respective catches and begin counting.\n\n");
		if (player.str >= 120 && player.spe >= 120) {
			outputText("The orca morph is surprised as you, not only caught more fish than her, but also bigger ones! Kindra training did pay off.\n\n");
			outputText("\"<i>Wow! you truly did surpass me! What a bounty!</i>\"\n\n");
			outputText("The orca claps cheerfully for you then takes on a serious expression.\n\n");
			outputText("\"<i>I would like to give you a final gift before you go, it's not that big, but I will teach you a final trick specific to this weapon so you can better use it against the demons.</i>\"\n\n");
			outputText("Ceani final technique proves useful, as it will allow you to hit way harder with throwing spears and harpoons. You thank her for this gift but as you prepare to head back to camp Ceani stops you.\n\n");
			outputText("\"<i>Wait just a second. Before you go...</i>\"\n\n");
			outputText("Out of nowhere, the giantess pulls you in and kisses you, her white and black cheeks turning pink.\n\n");
			outputText("\"<i>Please come and visit again, it can be pretty dull at the beach alone. I will miss you.</i>\"\n\n");
			outputText("You head back to camp a little disoriented but promise to pass by every now and then.\n\n");
			flags[kFLAGS.CEANI_ARCHERY_TRAINING] = 5;
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("While your talents are one of a kind, Ceani is made for swimming and not only did she outspeed you she also caught bigger fish then you did.\n\n");
			outputText("\"<i>Well, better luck next time champ. Still, how about we share a meal? There is more than enough for the both of us.</i>\"\n\n");
			outputText("You eat with Ceani, sharing stories of your recent adventures. After the dinner is over you head back to camp.\n\n");
			player.refillHunger(25);
			doNext(camp.returnToCampUseTwoHours);
		}	
	}
	if (player.hasItem(consumables.FISHFIL)) {
		outputText("You find Ceani lazily resting on the beach and head out to say hello.\n\n");
		outputText("\"<i>Hey it’s you [name] nice to see you. I was wondering how you were. How is your demon hunting going?</i>\"\n\n");
		outputText("You tell her your latest accomplishment as she smiles widely. However her belly rumbles. You realise she must be getting hungry and pull a fish out of your bags. Ceani eyes sparkles as she see the fish.\n\n");
		outputText("\"<i>Fresh from the lake?! Really?! For me?!</i>\"\n\n");
		outputText("Ceani pick up the fish from your hands and sniffs it before taking a bite and starting to cry.\n\n");
		outputText("\"<i>I just can’t swim in the lake with all those crazed shark girls but the fish there are so tasty! Thank you so much!</i>\"\n\n");
		player.destroyItems(consumables.FISHFIL, 1);
		var x:int = player.cockThatFits(36, "length");
		menu();
		addButton(0, "Talk", beachInteractionsTalk);
		if (player.gender > 1 || (player.hasCock() && player.cocks[x].cockLength >= 15)) addButton(1, "Date", beachInteractionsDate);
	}
	else {
		outputText("You find Ceani lazily resting on the beach and head out to say hello.\n\n");
		outputText("\"<i>Hey it’s you [name] nice to see you. I was wondering how you were. How is your demon hunting going?</i>\"\n\n");
		outputText("You tell her your latest accomplishment as she smile widely. However her belly rumble and she sigh, lifting up and heading to the water.\n\n");
		outputText("\"<i>I would like to spend more time with you [name] however I’m hungry and need to go catch some fish. I will see you around.</i>\"\n\n");
		outputText("<b>Perhaps bringing her some food so she doesn’t have to hunt it could buy you some time with her?</b>\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
}

public function oceanInteractionsAfterArcheryTraining():void
{
	clearOutput();
	outputText("You find move around the ocean when you spot Ceani swimming nearby.\n\n");
	outputText("\"<i>Hey it’s you [name] nice to see you. I was wondering how you were. How is your demon hunting going?</i>\"\n\n");
	if (player.hasItem(consumables.FISHFIL)) {
		outputText("You tell her your latest accomplishment as she smiles widely. However her belly rumbles. You realise she must be getting hungry and pull a fish out of your bags. Ceani eyes sparkles as she see the fish.\n\n");
		outputText("\"<i>Fresh from the lake?! Really?! For me?!</i>\"\n\n");
		outputText("Ceani pick up the fish from your hands and sniffs it before taking a bite and starting to cry.\n\n");
		outputText("\"<i>I just can’t swim in the lake with all those crazed shark girls but the fish there are so tasty! Thank you so much!</i>\"\n\n");
		player.destroyItems(consumables.FISHFIL, 1);
		var x:int = player.cockThatFits(36, "length");
		menu();
		addButton(0, "Talk", beachInteractionsTalk);
		if (player.gender > 1 || (player.hasCock() && player.cocks[x].cockLength >= 15)) addButton(1, "Date", oceanInteractionsDate);
	}
	else {
		outputText("You tell her your latest accomplishment as she smile widely. However her belly rumble and she sigh as she prepare to leave to go back on her hunt.\n\n");
		outputText("\"<i>I would like to spend more time with you [name] however I’m hungry and need to go catch some fish. I will see you around.</i>\"\n\n");
		outputText("<b>Perhaps bringing her some food so she doesn’t have to hunt it could buy you some time with her?</b>\n\n");
		doNext(camp.returnToCampUseOneHour);
	}
}

public function beachInteractionsTalk():void
{
	menu();
	addButton(0, "Her", talkHer);
	addButton(1, "Hunger", talkHunger);
	addButton(2, "Sea", talkSea);
}

public function talkHer():void
{
	clearOutput();
	outputText("So is she genuinely from Mareth or does she hail from another world?\n\n");
	outputText("\"<i>Actually, yes, I am from Mareth, though this isn’t the same ocean as I used to hunt in. Many of the aquatic species migrated to the lake or to the underground ocean when the demons began to hold the water up. This area however is under a constant spell that cancels their magic, so it rains from time to time albeit with powerful thunderstorms. Many of the species living in these depths are from a different world, including less than friendly creatures ");
	outputText("such as Sea Serpents and Krakens. In these waters it's eat or be eaten, literally. Even if the demons did try to dry up this sea I am pretty sure the deep witches would force the water down. Those womans are not any friendlier than any of the beasts you will encounter in the abyss, but at least they are keen on keeping this ocean out of the demons reaches. ");
	outputText("They sometime come up close to the beach in order to call down a downpour, though be aware that their power over storms is dangerous. I swear, getting hit by a lightning bolt is far from fun.</i>\"\n\n");
	outputText("Deep witches, eh? Sounds ominous. You're about to switch subject but Ceani’s stomach rumble reminding you of the time.\n\n");
	outputText("\"<i>Well I guess it’s time that I go back to fishing. Come back anytime [name]!</i>\"\n\n");
	outputText("On these words she heads back to the water and dive, disappearing under the waves. You return to camp thinking that you should visit more often and if possible with extra fishes.\n\n");
	ceaniAffection(3);
	doNext(camp.returnToCampUseOneHour);
}

public function talkHunger():void
{
	clearOutput();
	outputText("Ok, so how come is she constantly hungry anyway?\n\n")
	outputText("\"<i>Well, truth be told, I’m a big eater and my size doesn’t help, so I have to constantly stay on the hunt to maintain my strength. I can spend up to 3 or 4 hours without eating if needs be but the rest of the time I eat every catch I find right away.</i>\"\n\n");
	outputText("Well this is an issue. You decide to change the subject before said hunger catches back to her.\n\n")
	ceaniAffection(3);
	doNext(camp.returnToCampUseOneHour);
}

public function talkSea():void
{
	clearOutput();
	outputText("Last you heard, Mareth water supply ran low, so how come there is an entire sea here. Ceani shrug then simply reply.\n\n");
	outputText("\"<i>Marae roots doesn’t extend to this place mainly because this sea was not originally here. The cult of the deep one is the reason why there is water here in the first place. When the demons attempted to dry out the world, they hid in underwater caves and sealed them shut to prevent the water from escaping. One of their air breathing acolytes came to this place and started the initial flood that would fill this area, the rest of them came over. ");
	outputText("This water is not corrupted by the demons but by something else and Marae fears it as much as the demons do.</i>\"\n\n");
	outputText("What about the sea folks themselves? Are they safe from the demons?\n\n");
	outputText("\"<i>The demons are afraid of what lurks in the watery depths... creatures more lusty or far bigger than they are. You may think I’m tall and strong but that's because you have yet to meet those that hunt deep down. Then there is also the risk of being brainwashed by the sea witches. Do yourself a favor and stay away from the deep sea, especially the ruins of the sunken city, a nameless horror lurks there that you don’t want to meet with, no matter the riches.</i>\"\n\n");
	outputText("You nod and you're about to switch subject as Ceani’s stomach rumble.\n\n");
	outputText("\"<i>Well I guess it’s time for me go back to fishing. Come back anytime [name]!</i>\"\n\n");
	outputText("On these words she heads back to the water and dives in, disappearing under the waves. You return to camp thinking that you should visit more often and if possible with extra fishes.\n\n");
	ceaniAffection(3);
	doNext(camp.returnToCampUseOneHour);
}

public function beachInteractionsDate():void
{
	clearOutput();
	outputText("You ask the Orca if she would like to go on a date with you?\n\n");
	outputText("\"<i>Sure! but I can’t leave the sea for too long. I prefer to stay close to my food if possible.</i>\"\n\n");
	menu();
	if (player.canSwimUnderwater()) addButton(0, "Underwater", beachInteractionsDateUnderwater0);
	addButton(1, "On the Beach", beachInteractionsDateOnTheBeach0);
}

public function oceanInteractionsDate():void
{
	clearOutput();
	outputText("You ask the Orca if she would like to go on a date with you?\n\n");
	outputText("\"<i>Sure! but I can’t leave the sea for too long. I prefer to stay close to my food if possible.</i>\"\n\n");
	menu();
	if (player.canSwimUnderwater()) addButton(0, "Underwater", beachInteractionsDateUnderwater1);
	addButton(1, "On the Beach", beachInteractionsDateOnTheBeach1);
}

public function beachInteractionsDateUnderwater0():void
{
	clearOutput();
	outputText("You propose the two of you move underwater and have a trip out at sea.\n\n");
	outputText("\"<i>Oh, so you want us to swim together? Sure I was done sunbathing anyway.</i>\"\n\n");
	outputText("Sunbathing? Her? It's not like she will get a bronzage with that black skin, heck, she look charred enough already. She notice your confusion then sigh looking to the sky.\n\n");
	outputText("\"<i>Everybody can dream.</i>\"\n\n");
	beachInteractionsDateUnderwater2();
}

public function beachInteractionsDateUnderwater1():void
{
	clearOutput();
	outputText("Why go anywhere else? The water here is pleasant enough and the two of you could go sightseeing.\n\n");
	outputText("\"<i>I agree and I think I know just the places too.</i>\"\n\n");
	beachInteractionsDateUnderwater2();
}

public function beachInteractionsDateUnderwater2():void
{
	if (player.findPerk(PerkLib.AquaticAffinity) >= 0) {
		outputText("You and Ceani dive into the waves, the both of you racing underwater and playing as you try to be the first to reach the coral barrier.\n\n");
		outputText("Ceani is just as fast as you if not faster ");
		if (player.spe >= 200) {
			outputText("however you reach the finishing line before her. She look somewhat frustrated.\n\n");
			outputText("\"<i>Well, you won.. and here I thought I was the fastest.</i>\"\n\n");
		}
		else outputText("however she reach the finishing line before you cheerfully swimming in circle up and down. \n\n");
	}
	else outputText("While you can breath underwater, you don’t have the body to swim quite as fast as she, so so you simply cling to her back as she swim to various locations showing you what the ocean is like. \n\n");
	outputText("Ceani stop for a moment lost in thinking then smile wide.\n\n");
	outputText("\"<i>Hey, there's a place we didn’t go yet. Its pretty far from the coast but I think you ought to see it.</i>\"\n\n");
	outputText("She take you all the way to what looks to be an underwater cave. As you enter, Ceani picks up a weird item that emit some light by the entrance and show you in. Wow, the rock formation is covered with a crystalline mineral that reflects the light in a bright yellow pattern. There is a small air pocket above that seems  to lead in a large set of caves that likely run’s back up the beach. ");
	outputText("There is a warm underwater current running through the cave, which makes it particularly pleasant to swim in.\n\n");
	outputText("\"<i>This is the place where I come to meditate between my fishing sessions. It is beautiful isn't it? This cave tunnels are also one of the place we hid in when the demons almost dried the sea. It has several underground lakes to runs all up to the mountains.</i>\"\n\n");
	outputText("While you're busy looking this place spellbound, the Orca silently swam behind you and hugged your back squishing her JJ cup breast against you.\n\n");
	outputText("\"<i>Say [name]... would it be ok if we did something... here under the water?</i>\"\n\n");
	outputText("Why didn’t she ask you sooner? You begin to slowly remove her pink bikini exposing her generous white breast. All in all if she wasn’t this huge her JJ cup would look like a fairly normal E");
//	if (player.armor != NOTHING) outputText(". You were too busy pondering these details to notice as Ceani slowly removed your [armor]");
//	if (player.lowerGarment != UndergarmentLib.NOTHING) outputText(" and undergarment");
	outputText(". Ceani surprise you by grabbing your shoulder and kissing you. Is it just you or the water around you both is starting to get even warmer. The two of you play with each other tongue for a moment. You aren’t so surprised to find a sea salt taste on Ceani’s saliva, as the both of you have been pretty much talking underwater for this long.\n\n");
	if (player.gender == 3) {
		outputText("Now that you think of it, you could take her as a man or a woman, so which way do you prefer?\n\n");
		menu();
		addButton(0, "Male", underwaterDateMaleVer);
		addButton(1, "Female", underwaterDateFemaleVer);
	}
	if (player.gender == 1) underwaterDateMaleVer();
	if (player.gender == 2) underwaterDateFemaleVer();
}

public function underwaterDateMaleVer():void
{
	var x:int = player.cockThatFits(36, "length");
	outputText("You barely register Ceani hand moving down to your cock as she begins to stroke it.\n\n");
	outputText("\"<i>Mmmm... since we are underwater we won’t need lubrication as I am pretty much as wet as I can be.</i>\"\n\n");
	if (player.cocks[x].cockLength >= 22) {
		outputText("Ceani makes a wide delighted smile as she watch your beast of a dick grow up to full mast, licking her lip in obvious anticipation.\n\n");
		outputText("\"<i>This kind of treasure is rare under the sea. Even males orca don’t exactly always have the biggest one’s even for their sizes. So when I find one of these I reaaally have to try it out!</i>\"\n\n");
	}
	outputText("Her other hands runs under your balls, cupping and playing with them for a moment before she swim under you, still gripping your [cock], and start to suckle on your [balls] one after the other. Ceani takes a look at your cock give it a playful lick and begin to suck on your lenght, her agile tongue playing with your tip. You moan as she suck you for a fair minute then swim back up, wrapping her two legs around your waist as she slowly grind her pussy against you dick sliding the glan between her vaginal lips. ");
	outputText("She isn’t exactly the best at sex due to the sheer size of her cunt but she makes for it with raw skills, making sure to vice grip around your length so you can feel the entirety of her vagina. You moan as your glan/flare is teased by her cunt lips never truly going in but never breaking contact either. She play with your tip for a fair minute before giggling.\n\n");
	outputText("\"<i>You want it in, don’t you? Mmmmmm. Don’t worry, I am done playing.</i>\"\n\n");
	outputText("She finally lower herself down on your prick, sighing in delight as your dick fills her. Her insides feels like a wet glove, it's so lubricated you almost instantly get your full length in. However comes the question of how you will fuck her. Ceani doesn’t seem to see any issue there, as she get her tail in position.\n\n");
	outputText("\"<i>Don’t worry about moving, just let your big girl do the job for you.</i>\"\n\n");
	outputText("Thanks to the low gravity underwater, she manage to slide on your [cock] at a very slow pace making you gasp as she slowly move up and down using her tail as a lift. Heck you are glad you are underwater otherwise you are not sure you could properly lift her through the fact that her tail is doing most of the work helps. ");
	if (player.cocks[x].cockLength >= 22) outputText("Ceani looks to be lost in the pleasure of your [cock], her spasming pussy desperately trying to milk your [cock] as it hits her cervix on every trust. She really must not get a decent fuck this often and you almost feel bad for her. ");
	outputText("Her cunt is as hungry as she is relentlessly devouring your [cock] massaging your flesh to the best of her ability. Soon however you can feel the telltale sign of your own climax as your dick begin to twitch. You and Ceani moans in ecstasy as you fill up full of semen the same color as her belly.\n\n");
	outputText("\"<i>Mhhmmmmm [name] I wonder if you have any idea how delicious it feels to be filled like this underwater. ");
	if (player.gender == 3) outputText("Perhaps you should try a man underwater one day and see it for yourself.");
	else outputText("But again, you don’t have a pussy so I guess it’s not something you could understand.");
	outputText("</i>\"\n\n");
	outputText("Ceani indeed looks to be positively beaming with delight. While you are very tempted to give her another shot you are too tired to do so this early so the two of you lay down on the seafloor to rest.\n\n");
	outputText("When you wake up, Ceani is by your side and you are back on the beach. You can only guess the orca brought you out of the water. You think you could prolong your session of earlier but you are interrupted by Ceani’s stomach rumble.\n\n");
	outputText("\"<i>Well I guess it’s time for me to go back to fishing. Come back anytime [name]!</i>\"\n\n");
	outputText("On these words she puts back her bikini on and head to the water and dive, disappearing under the waves. You dress up and head back to camp thinking that you should visit more often.");
	if (player.cocks[x].cockLength < 22) outputText(" Still something tells you if your cock was bigger Ceani might like it more. Your dick felt like a small key trying to fit an oversized lock.");
	outputText("\n\n");
	player.orgasm();
	ceaniAffection(6);
	doNext(camp.returnToCampUseTwoHours);
}

public function underwaterDateFemaleVer():void
{
	outputText("You barely register Ceani hand moving down to your pussy before she actually slide a finger in, making you gasp in surprise. You answer by breaking the kiss and taking in one of Ceani’s tits in your mouth. You begin to suckle on her tit, making her moan as she slide a second digit inside. If you weren't both standing on the ocean floor you would likely be drifting around as you try to pleasure each other. Yea the water is definitely getting warmer and your cheek flush as your pleasure increases.\n\n");
	outputText("\"<i>Ahhhn say... how about we try a wheel?</i>\"\n\n");
	outputText("You think she's joking when, but  you realise she's not the moment she grab’s you into a, somewhat, interesting pose. This is essentially a sixtynine but the interesting part about it is the fact you both drift around in the gentle current, eating each other pussy out. As her tail makes you two pretty much swim in circles. Thankfully due to your fish like senses ");
//	if () outputText("or perhaps because of the necklace ");necklace part
	outputText("you don’t get dizzy from having your world constantly turned upside down. The feeling of the waterflow on your sensitive skin and Ceani devious tongue soon send you over the edge making you cum. However since neither of you can actually taste each other cum, neither of you know when to exactly stop. The only warning you have are each other moans and you have trouble accurately interpreting wich one is the orgasm. ");
	outputText("As such you both end up eating each other beyond your respective limits and cuming several time in a row. Its barely if you can feel your legs anymore as you force yourself to keep licking your partner. Eventually you both tire out and sink down to the ocean floor to rest.\n\n");
	outputText("\"<i>Hey [name].... just how many time did you cum exactly... I think I did 39 times...</i>\"\n\n");
	outputText("You barely remember, perhaps you came 40 or 38 times, but whether or not you came more or less than Ceani doesn't matter right now. Your cunny is still horribly sensitive and it will take few moment before you recover from this. You slowly drift off to sleep in Ceani’s arms.\n\n");
	outputText("When you wake up Ceani is by your side and you are back on the beach. You can only guess the orca brought you out of the water. You think you could prolong your session of earlier but you are interrupted by Ceani’s stomach rumble.\n\n");
	outputText("\"<i>Well I guess it’s time that I go back to fishing. Come back anytime [name]!</i>\"\n\n");
	outputText("On these words, she put back her bikini and heads to the water and dive, disappearing under the waves. You dress up and head back to camp thinking that you should visit more often.\n\n");
	player.orgasm();
	ceaniAffection(6);
	doNext(camp.returnToCampUseTwoHours);
}

public function beachInteractionsDateOnTheBeach0():void
{
	clearOutput();
	outputText("How about a walk? It's not like she spend that much time out of the water anyway. The both of you take a stroll on the beach");
	beachInteractionsDateOnTheBeach2();
}

public function beachInteractionsDateOnTheBeach1():void
{
	clearOutput();
	outputText("How about a walk? It's not like she spend that much time out of the water anyway.\n\n");
	outputText("\"<i>Well I guess you’re right. I spend most of my day underwater. A walk wouldn’t hurt.</i>\"\n\n");
	outputText("The two of you head back to the surface toward the beach and take a stroll");
	beachInteractionsDateOnTheBeach2();
}

public function beachInteractionsDateOnTheBeach2():void
{
	outputText(" discussing your daily activities. There isn’t anyone aside from you two in the area and soon Ceani realise this.\n\n");
	if (player.tallness < 96) outputText("\"<i>Say... uh... I know I’m a big girl but.. is it ok if we hold hands?</i>\"\n\n");
	else outputText("\"<i>Say... uh... would you mind if we held hands?</i>\"\n\n");
	outputText("You reply that it’s ok, you don’t mind. You both hold hands for an hour resuming your walk when Ceani suddenly surprise you by tripping and pulling you to the ground with her. Your face ends up falling right in the middle of her massive JJ cup. You try to lift up but she hold you still next to her.\n\n");
	outputText("\"<i>Oops it seems I fell...Say this is... um... could we...</i>\" the orca white cheeks are turning pink.\n\n");
	outputText("Oh really? Falling on purpose now are we... well you guess this wouldn’t be the Mareth you know if every date didn’t end up like this.\n\n");
	outputText("You slowly begin to untie Ceani bikini as her tail wrap around your left leg. ");
//	if (player.armor != NOTHING) outputText("Ceani isn’t staying idle either slowly taking care of your some of your equipment. ");
	outputText("Once this is done, Ceani makes a smitten smile.\n\n");
	if (flags[kFLAGS.CEANI_AFFECTION] < 21) {
		if (player.tallness < 96) outputText("\"<i>I have been eyeing you since the trainings but i wasn’t sure you were into... girls above a certain size... furthermore, I was to shy to ask.</i>\"\n\n");
		else outputText("\"<i>I have been eyeing you since the trainings but I wasn’t sure you were interested...furthermore I was too shy to ask you out.</i>\"\n\n");
	}
	else {
		outputText("\"<i>How about the two of us do something else my lower body seems to know exactly what it would want right now.</i>\"\n\n");
		outputText("You ask her to elaborate.\n\n");
		outputText("\"<i>Look must I spell it out for you? I’d like you and I to fuck.</i>\"\n\n");
	}
	outputText("Oh, so that explains her behavior all along. Well there's no way you will miss on a chance to have a nice time with her, right? You begin to caress her smooth, white underbelly with your hand making Ceani coo. You slowly slide your hands all the way up to her massive breast circling her nipples and drawing her contour. You wonder if whales morph can produce milk like other mammals and begin to suckle on her tit to make sure. ");
	outputText("Ceani hands pulls you closer as she moan at your attentions. After a few seconds of suckling you indeed find milk although she clearly won’t produce like a cow. You unplug your mouth from her now erect nipple as you head to her face for a gentle kiss. Ceani smile in rapture as the two of you begin a long duel of tongues.\n\n");
	outputText("Ceani can’t wait any longer and ");
//	if (player.lowerGarment != UndergarmentLib.NOTHING) outputText(", as her tail finish getting rid of your lower clothing, ");
	outputText("begin to remove her lower bikini.\n\n");	
	if (player.gender == 3) {
		outputText("It occurs to you that you could fuck her as a man or a woman so which way do you prefer?\n\n");
		menu();
		addButton(0, "Male", beachDateMaleVer);
		addButton(1, "Female", beachDateFemaleVer);
	}
	if (player.gender == 1) beachDateMaleVer();
	if (player.gender == 2) beachDateFemaleVer();
}

public function beachDateMaleVer():void {
	var x:int = player.cockThatFits(36, "length");
	if (player.cocks[x].cockLength >= 22) {
		outputText("Ceani licks her lips as she eye your massive [cock], truth be told, finding someone with a cock large enough to fit her pussy up to the cervix must be a difficult task.\n\n");
		outputText("\"<i>Mmmmmm... you have quite the beast you know? Do you realise how hard it is to find a dick that can properly fit in my cunny? I had wet dreams about this one...</i>\"\n\n");
	}
	outputText("Ceani, holding off her formidable, strength gently push you on your back and get in position her tail swishing left and right as she take your [cock] in her mouth wrapping her large tongue around it. For someone equipped with dagger like teeth you're surprised she can do a blowjob this well. You moan in pleasure as she slowly brings your [cock] to its full length, coating it entirely with her salty saliva. Soon Ceani is done lubing your ship mast as she slowly ");
	outputText("pull her mouth off your still dripping cock, a thin strand of saliva still covering your glan. She giggle as she begins to pull away to change position.\n\n");
	outputText("\"<i>Hmmm your manhood seems nice and ready but look at my pussy, I think It’s more then just the water. Care to have a look?</i>\"\n\n");
	outputText("She lay on her back so you can have a full view of her drooling snatch and white erect nipples. You approach her cunt and take a whiff of her smell. Mmmmm looks like a female in heat and she’s all the more ready for you to breed. You get in position above her, slowly inserting yourself in her drooling snatch.");
	if (player.cocks[x].cockLength >= 22) {
		outputText("Ceani eyes grows wide as your [cock] fill her to the brim moaning from your insertion alone as her cunt begin to grip on your [cock] like a vice.\n\n");
		outputText("\"<i>Ahhhh It's so freaking big! Fuck me! Please fuck my brain’s out!</i>\"");
	}
	outputText("\n\nCeani moan in delight as you begin to move in her cunt, her arms making large holes in the sand while her tail flail wildly behind you. You're pretty sure a slap of this thing would send anything smaller then her flying, but what you're concentrated on right now is your desire to fill this female with your cum as she begins to buck her hips against your [cock]. Her cunt is just like her hunger, ravenous, and you are not sure how long you will be able to hold ");
	outputText("against her constant onslaught before the dam breaks. Ceani snatch is clamping like a clam around your [cock], trying to milk you of all of your semen as you piston in and out of her, the orca girl wailing like the whales she ressemble.\n\n");
	outputText("\"<i>Iiiiiiiihh! [name]! Aaaaah...AHHhhn! I’m CUUuumiiing!!!</i>\"\n\n");
	outputText("Ceani cunt drench your legs as you finally ejaculate in her needy pussy");
	if(player.cumQ() >= 2000) outputText(", the sand below you darkening from the sheer amount of fluids you both produced");
	outputText(". The two of you finally dose off as you lay your head on Ceani pillowy breasts.\n\n");
	outputText("You wake up still hugging her and the two of you stay like that, smiling for a moment, until Ceani’s stomach starts to rumble.\n\n");
	outputText("\"<i>Well I guess it’s time that I go back to fishing. Come back anytime [name]!</i>\"\n\n");
	outputText("On these words she puts her bikini on and head to the water to dive, disappearing under the waves. You dress up and head back to camp thinking that you should visit more often.");
	if (player.cocks[x].cockLength < 22) outputText(" Still something tells you if your cock was bigger Ceani might like it more. Your dick felt like a small key trying to fit an oversized lock.");
	outputText("\n\n");
	player.orgasm();
	ceaniAffection(6);
	doNext(camp.returnToCampUseTwoHours);
}

public function beachDateFemaleVer():void {
	outputText("You can’t hold it anymore either and you slowly start to grind your pussy against hers. Your vaginal lips sliding against each other as the both of you make blissful smiles.\n\n");
	outputText("\"<i>Mmmm you sure know how to tribe.</i>\"\n\n");
	outputText("The both of you coo as your cunts becomes increasingly slick with fluids. You can feel your juice slowly running around your leg all the way down to the sand below. You start moaning together as your puffy clits slides against each other.\n\n");
	outputText("\"<i>Oooooh [name] your making a mess out of my cunny!</i>\"\n\n");
	outputText("You maintain the hug, grinding against each other for a fair minute until Ceani pussy and legs are positively so wet if you didn't knew better you'd think she had peed on herself. Your cunt is not in any better state and you feel the telltale of your incoming climax. Soon the both of you cum drenching your legs and the ground with girl juice.\n\n");
	outputText("\"<i>Mmmm, we're going to have to clean this mess, don’t you think? Care to have a taste?</i>\" She point to her drooling snatch in a very suggestive way and you nod eagerly.\n\n");
	outputText("She lay down on the sand letting you sit on her white belly as you move down to her, now more than juicy, snatch. The white of her underbelly runs up to her pussy lips slowly vanishing into pink. Sliding two finger in to spread her pussy lips apart, you dive in with your tongue. Ceani grabs your [ass] and pull your cunt down on her mouth as she start to lick on your vaginal lips. ");
	outputText("Her cunt is salty like the sea she constantly bathes in, but it's all right, each time you lick her you get a drink. She on the other side is tongue deep in your pussy making cute cry each time you lick her.\n\n");
	outputText("\"<i>Oh Maraaae you taste so good [name]</i>\"\n\n");
	outputText("Her tail is trashing in front of you as you slowly nib at her clitoris, making sure to lick every side of her cunt clean, but no matter how much you try, it keeps filling with more moisture, so you have to regularly lick an old spot again to keep it clean. You moan in delight as Ceani licks your cunt, making your pussy start to drool just like hers. ");
	outputText("The both of you lick the other for a while and then cum on your respective partner faces. Tired, and barely feeling your legs, you crawl back to her face and kiss her, dozing off to what could be called a very wet dream.\n\n");
	outputText("You wake up still resting your breast against hers and the two of you stay like that, giggling for a moment, until Ceani’s stomach starts to rumble.\n\n");
	outputText("\"<i>Well I guess it’s time that I go back to fishing. Come back anytime [name]!</i>\"\n\n");
	outputText("On these words she puts her bikini on and head to the water and dives, disappearing under the waves. You dress up and head back to camp thinking that you should visit more often.\n\n");
	player.orgasm();
	ceaniAffection(6);
	doNext(camp.returnToCampUseTwoHours);
}

	}
}