/**
 * ...
 * @author Ormael and others
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.BodyParts.Tail;
	
	public class JourneyToTheEast extends HeXinDaoAbstractContent
	{
		public function JourneyToTheEast() 
		{}
		
		public function enteringInn(first:Boolean = true):void {
			clearOutput();
			if(first){
				outputText("You enter the town local Inn ‘Journey to the East’ and look around. ");
			}
			outputText("You can see many people enjoying a meal or drink in the dining hall, a barman standing by ready to serve drinks.");
			if (model.time.hours >= 18 && rand(4) == 0) {
				ChiChiDrunkSex();
				return;
			}
			menu();
			addButton(0, "Drink", drinkAlcohol);
			//addButton(4, "", );mission giving npc
			//addButtonDisabled(12, "???", "You see some suspicious looking squirrel in one of inn corners. (Liadri + Star should bring this npc to more completness)");
			addButton(14, "Leave", heXinDao.riverislandVillageStuff);
		}
		
		private function drinkAlcohol():void {
			clearOutput();
			outputText("You go sit at the counter and the barman comes over to take your order.\n\n");
			outputText("\"<i>Good ");
			if (model.time.hours >= 16) outputText("afternoon ");
			else outputText("morning");
			outputText("" + player.mf("mister", "miss") + ", what can I get you?</i>\"\n\n");
			menu();
			addButton(0, "ManUp B", buyDrink, consumables.MANUP_B);
			addButton(1, "Gob.Ale", buyDrink, consumables.GOB_ALE);
			addButton(2, "NoceLiq", buyDrink, consumables.NOCELIQ);
			addButton(3, "OniSake", buyDrink, consumables.ONISAKE);
			addButton(4, "SalamFW", buyDrink, consumables.SALAMFW);
			addButton(12, "BimboL", buyDrink, consumables.BIMBOLQ);
			addButton(13, "BroBrew", buyDrink, consumables.BROBREW);
			addButton(14, "Back", notThirsty);
		}
		//drink list (to be expanded)	fire mouse TF, some generic nonTF beers
		private function notThirsty():void {
			clearOutput();
			outputText("In the end you realise you are not thirsty after all and wave a goodbye before leaving.\n\n");
			doNext(curry(enteringInn,false));
		}
		
		private function buyDrink(drink:ItemType):void{
			var cost:int = drink.value * 3;
			if(player.gems < cost){
				outputText("\n\nBarman shakes his head, indicating you need " + String(cost - player.gems) + " more gems to purchase this drink.");
				doNext(drinkAlcohol);
				return;
			}
			player.gems -= cost;
			statScreenRefresh();
			outputText("\n\nThe barman hands over the drink you ordered.");
			inventory.takeItem(drink, drinkAlcohol);
		}
		
		public function ChiChiDrunkSex():void {
			clearOutput();
			outputText("As you enter the bar you hear a feminine laughter swiftly spotting what seems to be ");
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 1 && flags[kFLAGS.CHI_CHI_AFFECTION] >= 20) outputText("Chi Chi");
			else if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 1 && flags[kFLAGS.CHI_CHI_AFFECTION] < 20) outputText("Chi Chi the waitress from the exotic food restaurant");
			else outputText("a blazing mouse girl");
			outputText(" sitting on one of the stool drinking sake.\n\n");
			outputText("\"<i>Yeah, and after I told it I was the top girl here I punched it in the face, Woooooooo!</i>\"");
			outputText("The barman sighs, pretending not to notice the drunken mouse, aside for when he has to serve her a new drink. Just as you are about to order something she realises you are there and engages in conversation.\n\n");
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2) outputText("\"<i>Gaaaaah, [name], why do you hang around all those girls. Worse why do you fuck with them and not me?! Its like you are a " + player.mf("go go boy","cheap whore") + " selling your body to everyone and thish drives me mad! Yeaaa, I’m going to prove them all I’m the top shlut!</i>\"");
			else if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 1) outputText("\"<i>Hey... you’re that so called champ who lost in the arena?! Well I like you. I like you so much I’d want you as my " + player.mf("boy","girl") + "friend but waaaah I’m way too shy to tell you that right! Well don’t go tell [name] I like " + player.mf("him","her") + " got it? Yeah who cares about that! Barman a round for [name] the best person I met woooo. Now let’s have sex!</i>\"");
			else outputText("\"<i>Hey you... yesh you, the tall person over there! Think you can fight?! Well I’m pretty sure nobody in this village hash the guts to anyway. If you dare show up in the arena I will beat you to death like I do everyone. Now that I think of it, there are other kinds of battle I can beat people in. Bet you're the kind who fucks every demon you meet. Well not tonight, letsh bang!</i>\"");
			outputText("Wait, what? You barely have the time to mutter a reply before the red cheeked mousette pushes you on the nearest table and climbs over you. The barman pulls a curtain around your table, he must be used to this.\n\n");
			outputText("\"<i>Yeshh you heard me you big idiot. I’m going to fuck with you here and now! So don’t you dare try to run away because I will get very mad if you do.</i>\"");
			outputText("Do you let her?\n\n");
			menu();
			addButton(0, "Let Her", drunksex,true);
			addButton(1, "Refuse", drunksex,false);
		}
		private function drunksex(selected:Boolean):void {
			if (!selected) {
				outputText("" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 0 ? "Chi Chi" : "The mouse") + " is clearly out of it. Better stop her now before she does something she will regret later. You shove her to the side and run for the exit of the bar. Hearing her swear in background. Once outside you head back to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				outputText("You would have to be an idiot indeed to refuse this free fuck. The drunken mouse girl licks her lips in anticipation, grabbing your clothes and begins to removing them one-by-one. Unsurprisingly, her own clothes barely takes a second to remove. She is so close now you can feel her breath on your neck.");
				if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) {
					outputText(" The mousette introduces herself.\n\n");
					outputText("\"<i>My name’s Chi Chi by the way, but... oh why does it matter? What's important is that we are about to have a lot of fun.</i>\"");
				}
				//post marriage
				if (player.hasCock()) {
					outputText("Chi Chi initiates with a wet but warm kiss; Her tongue dancing tango with yours. While small in stature, she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how her burning tail and fur isn't actually setting everything on fire around her, especially you. You inquire on this matter.\n\n");
					outputText("\"<i>That’sh because I’m burning with passion for you big idiot! My flamesh won’t burn anything I wish not to. Or maybe they will. I never recalled how that one inn caught fire. Just you wait, I'll set both of our body aflame with desire. Your cock will be as hot as my embers.</i>\"\n\n");
					outputText("Well it's too late to back down anyway and, even if you did, the drunken megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore, you slowly tease the entrance of her warm canal with your [cock]. If anything, despite being wet you can already feel how hot her oven is from the outside and can’t help but hope you won’t end up burned. Chi Chi however has no such concern and out of impatience starts stroking your dick with her embery tail.\n\n");
					outputText("\"<i>Come on, I know you want to put it in. What are you waiting for dumbassh?! I’m positively burning here.</i>\"\n\n");
					outputText("You're surprised by the direct contact with her fiery tail, even more so by the fact that it didn’t leave your dick with a third degree burn. Deciding to give the hot mouse what she wants, you put it in. Her vagina immediately starts milking you as if it was a thirsty mouth seeking water, and the frantic moving of her hips up down doesn’t help it.\n\n");
					outputText("\"<i>Gah doushe me! Don’t you shee how much I’m burning! Put that fire out with your manwater!</i>\"\n\n");
					outputText("Her pussy starts heating even more and before you know it, it actually transfers to you. Wow, your urethra is indeed as if possessed by some kind of angry efreeti. It's so hot you can’t think straight anymore, only the cool passage of cum can free you from this heat! You begin to piston in and out of Chi Chi desperate for a cooling release.\n\n");
					outputText("Both desperate for a way to get rid of the heat, the two of you manage to cum together, your jizz filling Chi Chi to the brim before slowly dripping on the ground. Chi Chi sighs in relief and exhaustion falling limp on the table.\n\n");
					outputText("\"<i>" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 ? "You're the besht [name] you know that? Let'sh do thish again sometimes, I jusht can’t get enough of it." : "You're a good boyfriend you know that? Let'sh do thish again sometimes.") + "</i>\"\n\n");
					outputText("She finally passes out, which is a good thing because, even if you're as tired as her, you think it'd be wise if you headed back to camp before she came back to her senses" + (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 ? ", especially because you're pretty sure she will beat you to death if she discovers the two of you had sex while she was drunk" : "") + ". You exit the establishment under the somewhat relieved gaze of the barman who gently proceeds to also get the sleeping inferno-mouse out with the help of a bouncer.\n\n");
				}
				else {
					outputText("Chi Chi initiates with a wet but warm kiss her tongue dancing tango with yours. While small in stature she displays an uncommon level of strength rarely seen even among animal morphs. What’s more concerning is that you aren't sure how come her burning tail and fur isn't actually setting on fire everything around her starting with you. You inquire on this matter.\n\n");
					outputText("\"<i>Thatsh because I’m burning with passion for you, big idiot! My flamesh won’t burn anything I wish not to. Or maybe they will. I never recalled how that one inn caught fire. Just you wait I'll set both of our body aflame with desire. Your pussy will be as hot as my embers.</i>\"\n\n");
					outputText("Well it's too late to back down anyway and, even if you did, the drunken megamouse is clearly going to keep you pinned down. Not to make your partner wait anymore you begin to grind your pussy lips against hers making her gasp in surprise at your initiative.\n\n");
					outputText("\"<i>Oh?! Finally fighting back? Good I love a girl that tries.</i>\"\n\n");
					outputText("Chi Chi begins to grind herself in response, making you both coo. For a drunk she clearly knows what she’s doing, almost like if drunken sex was an expertise of hers. You’re swiftly forced out back to reality as your blazing partner accelerates the tempo, causing you to moan in pleasure. Well now there's no way you going to simply lose this! You get the mouse ears with your hands and start caressing them. Chi Chi has a positive reaction and you are clearly getting to her however ");
					outputText("that's counting without her hidden weapon. Her burning tail lashes out like a whip and slides between you, aiming for your cunt. Before you can stop it you already have 15 inch of hot mouse tail in your [pussy] and Chi Chi uses it to fuck your brain out. The fuck isn't all that happens it seems her very heat start to spread on to you. Wow your cunt is indeed as if possessed by some kind of angry efreeti. It's so hot you can’t think straight anymore, ");
					outputText("only the cool passage of your girl-juices can free you from this heat! Meanwhile she grinds against her own tail bump but you have decided not to let her get off at her own pace. You swiftly slide " + (player.tailType > Tail.NONE ? "your tail" : "a pair of finger") + " in the smoking hot hinezumi cunt and retaliate with a set of rapid movement of your own.\n\n");
					outputText("Both desperate for a way to get rid of the heat and unable to fully outpace her, the two of you still manage to cum together your girl juices melding together and staining the ground. Chi Chi sighs in relief and exhaustion falling limp on the table.\n\n");
					outputText("\"<i>" + (flags[kFLAGS.CHI_CHI_FOLLOWER] > 2 ? "You're the besht [name] you know that? Let'sh do thish again sometimes, I jusht can’t get enough of it." : "You're a good girlfriend you know that? Let'sh do thish again sometimes.") + "</i>\"\n\n");
					outputText("She finally pass out which is a good thing because, even if you're as tired as her, you think it'd be wise if you headed back to camp before she came back to her senses" + (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2 ? ", especially because you're pretty sure she will beat you to death if she discovers the two of you had sex while she was drunk" : "") + ". You exit the establishment under the somewhat relieved gaze of the barman who gently proceeded to also get the sleeping mouse out with the help of a bouncer.\n\n");
				}
				player.orgasm();
				if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 1) flags[kFLAGS.CHI_CHI_FOLLOWER] = 1;
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}