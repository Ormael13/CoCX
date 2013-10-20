//for all april fools gags

// Encounter Chance 1 out of 40 and only if you're a centaur
function poniesYN():Boolean {
	if(player.lowerBody == 4 && date.date == 1 && date.month == 3 && flags[UNKNOWN_FLAG_NUMBER_00118] == 0) {
		outputText("", true);
		outputText("While walking around the lake, you hear the sound of feminine voices laughing and talking, accompanied by the distinctive clip-clop of hooves. Stepping lightly through the overgrowth you stumble across a group of small brightly colored ponies. The strange part about them isn't so much their size, but rather the shape of their bodies.  They almost look cartoonish in nature, a few even sport fluttery, feathery looking wings.\n\n", false);
		//(option: Approach? Leave them Be?)
		simpleChoices("Approach",approachPonies,"",0,"",0,"",0,"Leave",leavePonies);
		flags[UNKNOWN_FLAG_NUMBER_00118]++;
		return true;
	}
	return false;
}

//----------Next Page-----------
function leavePonies():void {
	outputText("", true);
	outputText("Deciding it must be some demonic trick, you decide to retreat from the scene before they notice your presence.", false);
	doNext(13);
}
function approachPonies():void {
	outputText("", true);
	outputText("You slowly begin your approach, though you are spotted almost immediately by the pink one.\n\n", false);

	outputText("You aren't two steps out of the forest before it seems she, and it HAS to be a she, seemingly teleports in front of you with an expression of rapture and joy pasted on her face.  You almost instinctively pull out your " + player.weaponName + ", startled by the appearance of the pink one in your face.  Immediately she starts asking a myriad of questions, speaking at a speed which makes it impossible to understand a word.  Almost as stunning is the fact that she is speaking in a human tongue. Before you have the time to gather yourself up and figure out what the pink one is saying, or even what is going on, the rest of her group have managed to catch up to her, and begin calming her down.\n\n", false);

	outputText("The purple one turns to you looking apologetic and a bit exasperated, \"<i>Sorry for our friend startling you. She gets excited <b>really</b> easily.</i>\"\n\n", false);
	
	outputText("You respond that it's no problem, but she should be more careful approaching strangers", false);
	if(player.weaponName != "fists") outputText(", especially armed strangers", false);
	outputText(".\n\n", false);
	
	outputText("The blue one looks at you puzzled while hovering above the ground, \"<i>Actually you are the first person we have seen who isn't a pony.</i>\"\n\n", false);

	outputText("To be fair you tell them, you haven't seen any one who IS a pony.  The pink one, now slightly calmer, interjects herself into the conversation \"<i>Ponies, not ponies, whatever!  We have a new friend, and I say PARTY!!!</i>\"\n\n", false);

	outputText("These little horses are definitely a rambunctious bunch, especially the white one, who, from the moment she spotted you, hasn't stop complaining about your awful sense of fashion. The only exception seems to be that yellow one hiding behind a screen of squirrels, birds and what you think are three generations of rabbits.\n\n", false);

	outputText("What should you do? You could party with the horses, after all you haven't had a reason to party since getting here. You can politely decline for now or leave these oddly colored and slightly disturbing creatures for the more familiar sight of demons.\n\n", false);  

	outputText("Whichever you choose something tells you that you won't see these ponies again.", false);
	//Option one: Leave Politely
	//Option Two: Too creepy...
	//Option three: Yay, party?
	simpleChoices("Too creepy",2589,"Yay Party!",2590,"",0,"",0,"Leave",2588);
}

function derpPolitely():void {
	outputText("", true);
	outputText("You hold out your arms and stop the ponies.  Once you have their attention you let them know you have something important you need to do for now, but will come back soon.  With a wave you turn and walk back into the trees to a chorus of disappointed \"<i>ahhhs</i>\", mostly from the pink one.", false);
	doNext(13);
}
	
function derpCreepy():void {
	outputText("", true);
	outputText("Cocks, horns and slavering vaginas is one thing, but this is almost too much cute to process.  You determine to leave this grove and never EVER come back again.  Still disturbed by the mental images running through your head, as you make your way back to camp, you callously slaughter an imp. Yeah that feels better.\n\n(+10 XP!  +5 Gems!)", false);
	player.XP += 10;
	player.gems += 5;
	doNext(13);
}
function derpyParty():void {
	outputText("", true);
	outputText("You watch in amazement as the flying horses string up banners, while the purple one sets a table with snacks and drinks using glowy powers coming from the horn on her head.  Whilst they set up, you discuss your home village with the orange one who compares it with working on an apple farm and you try to ignore  the white one as she primps and fusses around you, obviously unwilling to let you stay in, to quote her own words, \"<i>Hideous attire, lacking any grace or style.</i>\"\n\n", false);
	
	outputText("Time passed, and the rest of the day was a blur, mostly caused by, you assume, the large quantity of Pony Punch you drank.  As you shakily attempt to get up, snippets of the evening's events flash through your mind: a funny joke told by the pink one; the yellow one coming out of hiding to orchestrate an impromptu concerto sung by a choir of songbirds; losing a race to the blue one, flying is definitely cheating: a derpy looking grey one who was knocking over everything in a two meter radius around her.  Your mind slowly returns to the present and as it does you  take a look at yourself, a first glance at your attire shows the magical 'improvements' the white one made are already fading away, crumbling into a cloud of pink dust that blows away, leaving you back in your " + player.armorName + ".  Watching your clothes change was rather distracting, but now that you are up, and ooh what a headache THAT caused, you see your clothes weren't the only thing that changed!!\n\n", false); 

	outputText("Your strong lower body has shrunk, the firm musculature replaced by an oddly cartoonish looking form.  In fact, from the waist down you look just like one of the ponies!  Everything looks to still be in the same general place, and a quick test of your new lower body proves it still functions somewhat the same. The new shape of your hooves takes a little while to get used to, but other than that you get used to your new lower body almost with no effort\n\n(<i>*Note:You should really check the character viewer</i>)", false);
	player.lowerBody = 11;
	doNext(16);
}
/*Notes:
---------------------------------------------------------------------------------------------------------------------------------------------
1. talk a little to the ponies, aka get to know them a little and their personalities
2. futtershy(yellow one with pink mane) hides in the bushes and you comment of the number of small animals surrounding her
3. rarity(white one with purple mane) comments about your awful dress attire
4.applejack(orange one with sandy blonde mane) asks what are you doing in these parts?
the pink one(pinkie pie) offer to throw a party in honor of our new friend
IF you accept you wake up at you camp groaning from a headache, you definitely drank too much Pony Punch, and all you can remember is bits and pieces of the party, when you inspect yourself you see that your centaur lowerbody changed and looks very similar to the body of the ponies you encountered. You explain that the change may have been caused by the food you ate at the party. You also lose half a foot of height(optional, may not be implemented).
If you don't accept you never encounter them again
the way i explain this one time event is that you accidently stumbled across this place, which is protected by magic. after that you never encounter them again.
*/