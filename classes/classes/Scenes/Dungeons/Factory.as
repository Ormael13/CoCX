//Dungeon 1: Factory
package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.BaseContent;
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.Scenes.Dungeons.DungeonEngine;
	import classes.Scenes.Dungeons.Factory.*;
	
	import coc.model.GameModel;
	
	use namespace kGAMECLASS;
	
	public class Factory extends DungeonAbstractContent
	{
		private static const DUNGEON_FACTORY_FOYER:int				= 0;
		private static const DUNGEON_FACTORY_PUMP_ROOM:int			= 1;
		private static const DUNGEON_FACTORY_BREAK_ROOM:int			= 2;
		private static const DUNGEON_FACTORY_FURNACE_ROOM:int		= 3;
		private static const DUNGEON_FACTORY_REPAIR_CLOSET:int		= 4;
		private static const DUNGEON_FACTORY_MAIN_CHAMBER:int		= 5;
		private static const DUNGEON_FACTORY_FOREMANS_OFFICE:int	= 6;
		private static const DUNGEON_FACTORY_PUMP_CONTROL:int		= 7;
		private static const DUNGEON_FACTORY_STORE_ROOM:int			= 8;
		private static const DUNGEON_FACTORY_BATHROOM:int			= 9;
		
		public function Factory() {}
		
		//EVENTS
		public function enterDungeon():void {
			clearOutput();
			outputText(images.showImage("dungeon-entrance-factory"));
			kGAMECLASS.inDungeon = true;
			//Shutdown state
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) outputText("Rounding a bend in the mountainous foothills, you stumble upon a large, rusted and eerily silent iron structure with a number of tall gray smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside toward a jagged hole in its face.  Most of these are cracked open along their seams and both the pipes and mountainside are glazed with pink tinted runoff.");
			else if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("Rounding a bend in the mountainous foothills, you stumble upon a large, rusted and eerily silent iron structure with a number of tall gray smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside and disappearing into a hole in its face.");
			else outputText("Rounding a bend in the mountainous foothills, you stumble upon a large and rusted iron structure belching cloying pink smoke from its tall smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside and disappearing into a hole in its face.  It must be some kind of demonic factory, though you've no idea what they could be pumping out.  High atop the roof, you spy a huge water tower fed by smaller pipes that run down the building's side and off in the direction of the lake.  ");
			//Generic text
			outputText("\n\nThere are no windows to the hellish factory, with only a single iron door adorning the front wall. ");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 0) outputText("If you go inside there will undoubtedly be many demons to fight and little chance to escape. Death or worse awaits should you fall into their hands.");
			outputText("\n\nDo you enter the factory or leave?");
			if (flags[kFLAGS.FACTORY_FOUND] < 1) {
				outputText("\n\n<b>The factory is now accessible from the 'Dungeons' submenu inside 'Places' menu.</b>");
				flags[kFLAGS.FACTORY_FOUND] = 1
			}			
			simpleChoices("Enter", roomLobby, "", null, "", null, "", null, "Leave", exitDungeon);
		}
		
		private function exitDungeon():void {
			kGAMECLASS.inDungeon = false;
			outputText("You slip out the door and disappear, heading back towards your camp, leaving the hellish factory behind.", true);
			doNext(camp.returnToCampUseOneHour);	
		}
		
		private function checkDoor1():void {
			if (player.hasKeyItem("Iron Key") < 0) 
			{
				outputText("The door is locked with a key that is not in your possession.", true);
				doNext(roomLobby);
				return;
			}
			else roomPumpRoom();
		}
		private function checkDoor2():void {
			if (player.hasKeyItem("Supervisor's Key") < 0) 
			{
				outputText("The door is locked with a key that is not in your possession.", true);
				doNext(roomForemanOffice);
				return;
			}
			else roomPremiumStorage();
		}
		private function checkStairs():Boolean {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && (flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] + flags[kFLAGS.FACTORY_INCUBUS_BRIBED] <= 0)) {
				outputText("The glass door is locked! You have a feeling you should confront the incubus first.", true);
				if (silly()) outputText("\n\nNo, you can't break it down! Locked doors are indestructible!");
				doNext(roomMainChamber);
				return false;
			}
			else {
				roomForemanOffice();
				return true;
			}
		}
		private function checkExit():Boolean {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] <= 0) {
				outputText("The metal door is locked! Looks like you won't be able to get out until you defeat whoever runs the factory.", true);
				doNext(roomLobby);
				return false;
			}
			else {
				exitDungeon();
				return true;
			}
		}
		
		private function takeIronKey():void {
			outputText("You take the <b>Iron Key</b> to keep with your other important items.", true);
			player.createKeyItem("Iron Key",0,0,0,0);
			doNext(roomBreakRoom);
		}
		
		private function takeSupervisorKey():void {
			outputText("You search the desk and find a silver key labelled 'Supervisor'.\n\nYou take the <b>Supervisor Key</b> to keep with your other important items.", true);
			player.createKeyItem("Supervisor's Key", 0, 0, 0, 0);
			doNext(roomForemanOffice);
		}
		
		private function takeGroPlus():void {
			flags[kFLAGS.FACTORY_TAKEN_GROPLUS]++
			inventory.takeItem(consumables.GROPLUS, roomPremiumStorage);
		}
		private function takeLactaid():void {
			flags[kFLAGS.FACTORY_TAKEN_LACTAID]++
			inventory.takeItem(consumables.LACTAID, roomPremiumStorage);
		}
		
		private function drinkCoffee():void {
			spriteSelect(96);
			outputText("You take a sip of the rich creamy coffee and suddenly feel refreshed. As you replace the coffeepot, the busty coffee-maker comes to life, grabbing her thick dusky nipples and squeezing out a trickle of scaldingly hot liquid. You can see her eyes roll up into her head from what you assume to be pleasure as she automatically refills the missing coffee, mouth open with ecstasy.  Her movements gradually slow as she quivers almost imperceptibly. A contented smile graces her features as immobility overtakes her, freezing her back in place.  You wonder if 'Mrs. Coffee' was created, or a victim of this place's dark master.", true);
			dynStats("lus", 1);
			HPChange(35, false);
			player.refillHunger(10);
			doNext(roomBreakRoom);
		}
		
		private function buildCockMilker():void {
			outputText("You puzzle out how to build a fully functional cock-milker from the spare parts here and assemble it.\n\nYou gained a <b>Cock Milker</b>!", true);
			outputText("\n\nYou'll need a little help to use it though.", false);
			player.createKeyItem("Cock Milker",0,0,0,0);
			flags[kFLAGS.FACTORY_MILKER_BUILT] = 1;
			doNext(roomRepairCloset);
		}
		
		private function buildBreastMilker():void {
			outputText("You puzzle out how to build a fully functional breast-milker from the spare parts here and assemble it.\n\nYou gained a <b>Breast Milker</b>!", true);
			outputText("\n\nYou'll need a little help to use it though.", false);
			player.createKeyItem("Breast Milker",0,0,0,0);
			flags[kFLAGS.FACTORY_MILKER_BUILT] = 1
			doNext(roomRepairCloset);
		}
		
		private function doTensionRelease():void {
			clearOutput();
			//First time...
			if (player.findStatusEffect(StatusEffects.TensionReleased) < 0) {
				outputText("You nod and step forwards, allowing her to hook up a modified harness and inject you with the demonic concoction.  In no time heat boils through your veins, pooling on your chest and crotch.  ", false);
				if (player.biggestTitSize() < 10) {
					player.growTits(1, (2+rand(3)), true, 1);
					outputText("  ", false);
				}
				outputText("You glance over to the pile of glistening entwined bodies as they writhe in pleasure, and find yourself drawn in to the mass.  You spend the next four hours suckling tainted breast milk, fucking gaping pussies, and doing your damnedest to milk as much cum from the dick-girls around you.  Eventually the drugs work their way out of your system, leaving you to recover on the floor.  Cum, milk, and sweat drip from your nude form as you try to clean up and get dressed.", false);
				player.orgasm();
				dynStats("int", -2, "lib", 4, "cor", 4);
				player.slimeFeed();
				player.createStatusEffect(StatusEffects.TensionReleased,0,0,0,0);
			}
			//Second/third times...
			else {
				//[[2nd time]] 
				if (player.statusEffectv1(StatusEffects.TensionReleased) == 0) {
					outputText("You eagerly put on the modified harness and let them inject you with more of those body-altering chemicals.  As they fill you with artificial lust and desire, you cry out and beg for more.  They oblige you and give you a larger dose than the first time.  ", false);
					//Grow dick!
					if (player.cocks.length > 0) {
						player.lengthChange(player.increaseCock(0, 5), player.cocks.length);
						if (player.averageCockLength() >= 9 && player.averageCockThickness() < 2) {
							outputText("You feel yourself gain in thickness as well, to match your new length.  ", false);
							temp = player.cocks.length;
							while(temp > 0) {
								temp--;
								if (player.cocks[temp].cockThickness < 2) player.cocks[temp].cockThickness++;
							}
						}
						else if (player.averageCockLength() >= 15 && player.averageCockThickness() < 3) {
							outputText("You feel yourself gain in thickness as well, to match your new length.  ", false);
							temp = player.cocks.length;
							while(temp > 0) {
								temp--;
								if (player.cocks[temp].cockThickness < 3) player.cocks[temp].cockThickness++;
							}
						}
					}
					//Grow chest
					//(If player has 0 bewbs)
					if (player.breastRows.length == 0) {
						player.createBreastRow();
						outputText("Your chest tingles, revealing a pair of pink nipples on your new mammory glands.  ", false);
					}
					player.growTits(1, (2+rand(3)), true, 1);
					outputText("  ", false);
					outputText("Your " + player.nippleDescript(0) + "s ", false);
					if (player.cocks.length > 0) outputText("and " + player.multiCockDescript(), false);
					outputText(" become rock hard, leaking fluids constantly.  ", false);
					//MALE
					if (player.cocks.length > 0 && player.vaginas.length == 0) outputText("Glancing over into the sea of sex, you find yourself drawn to the nearest pussy, as if it was the only thing in the world to matter.  You lose track of the time as you fuck hard dozens of gaping cunts, each of them overflowing with cum from all participants in this infernal orgy.  ", false);
					//FEMALE
					if (player.vaginas.length > 0 && player.cocks.length == 0) {
						outputText("As you enter the sex-crazed crowd, you notice several \"girls\" with demonic cocks bloated by the use of drugs, getting drawn to you by the scent of your dripping wet " + player.vaginaDescript(0) + ". Sitting on the floor, you spread your legs wide, facing the nearest one with an inviting lewd moan, while you hungrily grab another cum-covered cock, that just filled up an obscenely wide gaping vagina, to suck it.  You are soon penetrated and fucked hard and deep, one huge infernal dick after another, as they all cum into you in turn. ", false);
						player.cuntChange(150, true);
					}
					//HERM
					if (player.vaginas.length > 0 && player.cocks.length > 0) outputText("You feel your " + player.multiCockDescript() + " getting milked by many wet holes, though you are too busy sucking cocks and moaning in ecstasy to notice who they belong to.  ", false);
					outputText("The next eight hours are lost to your desires as you cum over and over, feeling mind-shattering pleasure.  You recover a while on the floor, soaked with a mixture of milk, cum, and pussy-juice.  Getting dressed is a bit troublesome with the recent changes, but you manage to squeeze back into your " + player.armorName + ".  You walk away while still feeling horny, and the moaning of the girls behind you doesn't help.  Maybe you could stay for another round...", false);
					player.orgasm();
					dynStats("int", -2, "lib", 4, "cor", 4);
					player.createStatusEffect(StatusEffects.TensionReleased,0,0,0,0);
					player.addStatusValue(StatusEffects.TensionReleased,1,1);
					player.slimeFeed();
				}
				//Third time, move on to bad end!
				else {
					doBadEndTension();
				}
			}
			doNext(roomMainChamber);
		}
		
		//Succubus Secretary
		private function talkSuccubus():void {
			spriteSelect(55);
			outputText("\"<i>I suppose I really should thank you for coming down all by your lonesome.  The boss is gonna be sooo happy we found you.  Just think, in an hour or two we can get you strapped in and working with the others,</i>\"  says the secretarial succubus as she saunters over, still sipping her coffee, \"<i>You're so cute!  I tell you what, if you agree to come with me, I'll, like, make sure the experience is pleasurable.</i>\"\n\n", true);
			outputText("She runs a stocking covered foot up your leg and thigh, almost to your groin.  Giggling, the succubus pulls it away and asks, \"<i>So are you ready and willing?</i>\"", false);
			simpleChoices("For what?", talkSuccubusForWhat, "Yes", talkSuccubusYes, "No", talkSuccubusNo,"", null,"", null);
			return;
		}
		
		private function talkSuccubusForWhat():void {
			spriteSelect(55);
			outputText("The succubus looks at you with a bemused expression, \"<i>You haven't figured it out yet?  Really?  What do you think we make at this factory, bubble-gum?</i>\" she asks with a cruel smile, \"<i>We take human and once-human champions like you, pump you full of aphrodisiacs, body-altering drugs, and corrupting agents, and then milk you of your tainted fluids continually for the rest of your life!  And don't even start to ask why, I'll tell you – there are still pockets of purity out there that repel cute demons like me.  So the best way to deal with those is just to release a river of drug-filled sex-juice at them.  By the time the area dries off, the locals welcome us with open arms... and spread legs.</i>\"", true);
			simpleChoices("Sick!", talkSuccubusNo, "Sounds Fun", talkSuccubusYes,"", null,"", null,"", null);
		}
		
		private function talkSuccubusItsMe():void {
			outputText("You laugh mockingly at the stupid demon, roaring, \"<i>I'm the bloody champion you vapid cunt!</i>\"\n\nShe whirls, her beautiful face marred by rage.  It looks like you have a fight on your hands...", true);
			doNext(doFightSuccubusMocked);
		}
		
		private function talkSuccubusYes():void {
			spriteSelect(55);
			outputText("The blue skinned seductress steps forward and wraps her arms around you, pulling your head down and crushing it into her heavenly breasts as she speaks, \"<i>My my, aren't you the kinky little play-toy.  Let's get you hooked up.</i>\"\n\n", true);
			outputText("She catches you off-guard, lifting your feet off the ground.  You realize she has somehow grown taller.  You stretch to see what's going on, but have no leverage to pry your face from the smooth globes of flesh that smother you.   Vaguely, the click-clack of heels reaches you through the walls of flesh.  You're being moved deeper into the facility.   A creaky door opens, allowing you to hear the loud humming of machinery, mixed with what sounds like desperate sexual moans.\n\n", false);
			outputText("Abruptly you are pulled free from the succubus' fleshy prison and bodily thrown into padded restraints.  Blinded by the sudden onslaught of light, you blink away tears as restraints are placed securely around your wrists.  Warm lips press against your own as a foreign tongue penetrates your lips, mouth-raping you.  It tastes of sweet exotic spices, like nothing you've ever had before.   Helpless to do anything but return the kiss, you respond, sliding your tongue along the slippery sweetness of your captor's.  You risk opening your eyes and see your inhuman captor to be enjoying the kiss every bit as much as you.", false);
			doNext(doBadEndSuccubusPart1);
		}
		private function talkSuccubusNo():void {
			spriteSelect(55);
			outputText("She frowns, \"<i>I was secretly hoping you would say that... I'm going to make you beg me to hook you into the machines.  Just wait.</i>\"", true);
			doNext(doFightSuccubus);
		}
		
		private function goDemon():void {
			clearOutput();
			outputText("Advancing slowly, the succubus gives you a hungry look.  She extends a hand, allowing her fingers to lengthen into razor-sharp claws.  With a single expert slash, she cuts away everything holding together your " + player.armorName + ".  They fall into a discarded pile, already forgotten as your ", false);
			//[genderless]
			if (player.gender == 0) {
				outputText("entire body blushes read before the sexy seductress.  She looks at you, frowning as she murmers, \"<i>Now this just won't do.  You look more like a " + player.mf("boy", "girl") + " to me, so why don't I make the plumbing match the exterior?</i>\"\n\n", false);  
				outputText("Her palm caresses your crotch, stoking the warmth inside you until it blazes white-hot with new sensation.  Your skin ripples and parts, ", false);
				if (player.biggestTitSize() <= 1) {
					outputText("pushed apart the thick flesh of a powerful demonic member, complete with two swollen balls.", false);
					player.gender = 1;
					player.createCock();
					player.cocks[0].cockLength = 10;
					player.cocks[0].cockThickness = 2;
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					player.balls = 2;
					player.ballSize = 3;
				}
				else {
					outputText("gushing with fluids as it shapes itself into a hungry demonic cunt.", false);  
					player.gender = 2;
					player.createVagina();
					player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
				}
				outputText("\n\n\"<i>Much better,</i>\" the demon coos, licking her lips as your ", false);
			}
			//[male]
			if (player.gender == 1) {
				//Multispoooooo
				if (player.cockTotal() > 1) {
					outputText(player.multiCockDescriptLight() + " pulsate, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your " + player.multiCockDescript() + " seem to follow her, twitching and thickening any time she takes a step closer.\n\n", false);
					outputText("She reaches out, cupping the underside of a shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww, so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your " + player.cockDescript(0) + " already has.</i>\"\n\n", false);
					outputText("You glance down, seeing just how hard her words have made you.  You squirm your " + player.hipDescript() + "s pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ", false);
					if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " and ", false);
					outputText("the bases of your " + player.multiCockDescriptLight() + ".\n\n", false);
					outputText("\"<i>There, that'll make sure you feel every squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n", false);
					outputText("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cocks, as if possessed, angle themselves upward towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n", false);
					outputText("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your " + player.cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your " + player.multiCockDescriptLight() + ".  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n", false);
					outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
					outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
					outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
					outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
					outputText("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + player.cockDescript(0) + " empties, you feel drained and strangely energized at the same time, and your entire torso is spattered with rapidly hardening pink crystals.\n\n", false);
					outputText("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
					outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, yours was potent!</i>\"\n\n", false);
					outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ", false);
					if (player.hasKeyItem("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity...", false);
					else outputText("devour Marae's as soon as you get a chance.", false);
					outputText("You greedily gather up the lethicite splattered on your body and devour it, turning it into raw demonic power.  You really do need to get more of this... but first you know a certain demoness you intend to wrap around your ", false);
					if (player.countCocksOfType(CockTypesEnum.DEMON) > 0) outputText("growing", false);
					else outputText("new", false);
					outputText(" demon-cock for a few more orgasms.", false);
				}
				//SINGLEZ NITE
				else {
					outputText(player.multiCockDescriptLight() + " pulsates, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your " + player.multiCockDescript() + " seems to follow her, twitching and thickening anytime she takes a step closer.\n\n", false);
					outputText("She reaches out, cupping the underside of the shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww, so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your " + player.cockDescript(0) + " already has.</i>\"\n\n", false);
					outputText("You glance down, seeing just how hard her words have made you.  You squirm your " + player.hipDescript() + "s pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ", false);
					if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " and ", false);
					outputText("the base of your " + player.cockDescript(0) + ".\n\n", false);
					outputText("\"<i>There, that'll make sure you feel every squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n", false);
					outputText("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cock, as if possessed, angles itself upwards towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n", false);
					outputText("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your " + player.cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your " + player.cockDescript(0) + ".  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n", false);
					outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
					outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
					outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
					outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
					outputText("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + player.cockDescript(0) + " empties, you feel drained and strangely energized at the same time.\n\n", false);
					outputText("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
					outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm your's was potent!</i>\"\n\n", false);
					outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ", false);
					if (player.hasKeyItem("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity...", false);
					else outputText("devour Marae's as soon as you get a chance.", false);
					outputText("  But first you know a certain demoness you intend to wrap around your ", false);
					if (player.countCocksOfType(CockTypesEnum.DEMON) > 0) outputText("growing", false);
					else outputText("new", false);
					outputText(" demon-cock for a few more orgasms.", false);
				}
			}
			//[female]
			else if (player.gender == 2) {
				outputText(player.vaginaDescript(0) + " grows wet and ready, practically juicing itself as the demoness' hand caresses your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until all your humanity drips out?</i>\"\n\n", false);
				outputText("The words make you blush hard, shaming you and stoking the growing fire between your " + player.legs() + ".  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your " + player.legs() + " spread.  \"<i>There,</i>\" she comments, \"<i>now your juicy snatch is on display, just like you've always wanted.</i>\"\n\n", false);
				outputText("She effortlessly swings her lissomelegs onto the table as she pulls herself up, mounting you as a man might.  You can feel waves of heat rolling off her sex, bathing your own slit in her warmth.  ", false);
				if (player.clitLength >= 2) outputText("Your " + player.clitDescript() + " pushes free, nuzzling against her hairless cunt and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your " + player.clitDescript() + ", fucking and grinding against it.  ", false);
				else outputText("She lowers herself down, rubbing smooth hairless netherlips over you, smearing you with her fragrant demon-honey.  You feel her clit grinding on your own, drawing out gasps of delight from both of your mouths as she relentlessly scissors against you.  ", false);
				outputText("In no time flat you feel your climax building.  Your " + player.vaginaDescript(0) + " quivers and grows wetter in anticipation.  Tugging on your aching " + player.nippleDescript(0) + "s and aching for release, you squirm under your demonic mistress, smashing your " + player.vaginaDescript(0) + " against her in a lewd attempt to find your orgasm.  It does not happen, and you moan in disappointment as the pleasure continues to build, oblivious to your desire for orgasm.\n\n", false);
				outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
				outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
				outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, oh I don't know, the focused remains of your soul and humanity.  Now you think on that while I grind away any remaining doubts you might have.</i>\"\n\n", false);
				outputText("The beautiful succubus on top of you picks up the pace, grinding harder against your " + player.vaginaDescript(0) + " and " + player.clitDescript() + ", pushing you beyond anything you've ever felt before.  She leans down over you, licking her lips to reveal an inhumanly long tongue.  It snakes down, curving around you " + player.allBreastsDescript() + " before it arches up to flick a " + player.nippleDescript(0) + ".  ", false);
				if (player.hasFuckableNipples() && player.biggestTitSize() > 2) outputText("You gasp as the tongue slides inside each of your breasts, violating them in turn thanks to your strange anatomy.\n\n", false);
				else outputText("You gasp as it curls around each of your " + player.nippleDescript(0) + "s in turn, tugging them lewdly.\n\n", false);  
				outputText("She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you find yourself craving release, and over time you cave in further and further to the need.  You start to feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, and this need for release.  The block shatters, melting away under the force of your need as you explosively orgasm.\n\n", false); 
				outputText("Sparkling pink fluid splatters between the two of you as you cum, squirting hard", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText(" for the first time", false);
				outputText(".  The succubus throws back her head and lets loose a moan of ecstasy, her entire body shivering with your own as both of your heads fill with fireworks of pleasure.  Nervelessly, she rolls off of you, her tail contracting hard around your leg while the two of you share the moment.\n\n", false);
				outputText("The succubus interrupts your delight by recovering far faster than you, rolling up to a standing position and watching something between your legs.  You prop yourself up on your elbows to see what the fuss is about.  Between your legs something curious is happening – a trickle of pinkish fluid is still escaping your nethers, rolling towards a rapidly expanding pool, along with every other drop of the pink goop.  Before your very eyes the pool grows until every drop of pink fluid has collected together, and it grows upwards, solidifying into a sparkling crystalline shape.\n\n", false);
				outputText("Before you can react, she grasps the newly-formed lethicite and noisily begins eating it, her eyes glowing with newfound power.  Watching her makes you more than a little jealous and angry with yourself.  You should've taken the lethicite and gained its power!  No use fretting about it, you can still fuck this succubus for a few hours before you go out in search of your own victims...\n\n", false);
			}
			//[HERM ENDING]
			else {
				//Buh.  Zombie fen need brains.
				outputText(player.multiCockDescript() + " and " + player.vaginaDescript(0) + " grow wet and ready, both starting to leak fluids as the succubus' hand traces your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  And that throbbing cock!  How obscene!  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until your humanity is splattered between my legs?</i>\"\n\n", false);
				outputText("The words make you blush hard, shaming you and stoking the growing fire between your legs.  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your legs spread.  \"<i>There,</i>\" she comments, \"<i>now all of your fun-parts are on display.  Maybe I should call in an incubus and a few imps to watch.  I bet you'd like that wouldn't you?</i>\"\n\n", false);
				outputText("She effortlessly swings her lissomelegs onto the table as she pulls herself up, mounting you in a single swift motion.  You can feel waves of heat rolling off her sex, bathing your " + player.cockDescript(0) + " in her warmth.  ", false);
				if (player.clitLength >= 2) outputText("Your " + player.clitDescript() + " pushes free, nuzzling against her tight asshole and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your " + player.clitDescript() + ", fucking her ass and grinding against it.", false);
				else outputText("She lowers herself down, rubbing smooth hairless netherlips over your crotch and vulva, smearing you with her fragrant demon-honey.  You feel her clit grinding on your belly, drawing out gasps of delight from both of your mouths as she relentlessly works her body against your own.", false);
				outputText("\n\nMarvelous heat and wetness wraps your " + player.cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be cumming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by something deep inside you, pushing away your release and hiding it somewhere inaccessible.\n\n", false);
				outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days...</i>\"\n\n", false);
				outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
				outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
				outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, until the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time you cave in further and further to the need.  Eventually, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
				outputText("A look of shock and pleasure spreads over the succubus' face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + player.cockDescript(0) + " empties, you feel drained and strangely energized at the same time.\n\n", false);
				outputText("The slutty succubus stands up, her puffy vulva coated in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
				outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, your's was soooo potent!</i>\"\n\n", false);
				outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with her new-found power.  You resolve to ", false);
				if (player.hasKeyItem("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity...", false);
				else outputText("devour Marae's as soon as you get a chance.", false);
				outputText("  But first you know a certain demoness you intend to wrap around your ", false);
				if (player.countCocksOfType(CockTypesEnum.DEMON) > 0) outputText("growing", false);
				else outputText("new", false);
				outputText(" demon-cock for a few more orgasms.", false);
				outputText("  Before you get into that, you spy a small piece of pink crystal on the floor between your legs.  You snatch it and devour it before the succubus has a chance and eat it, turning part of your soul into new-found demonic strength before you return to a long night of sex...", false);
			}
			player.orgasm();
			dynStats("str", 2,"tou", 2, "spe", 2, "int", 2, "lib", 2, "sen", 2, "cor", 100);
			doNext(doBadEndDemon);
		}
		
		private function doFightSuccubus():void {
			spriteSelect(55);
			outputText("\"<i>You're going down!</i>\" you yell at her as you ready your " + player.weaponName + "! \n\nAn unseen force closes the door, preventing you from running away. \n\nIt's a fight!", true)
			flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1
			startCombat(new SecretarialSuccubus(), true);
		}
		private function doFightSuccubusMocked():void {
			spriteSelect(55);
			flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] = 1
			startCombat(new SecretarialSuccubus(), true);
			monster.armorDef -= 10;
		}
		
		public function doRapeSuccubus():void {
			player.slimeFeed();
			clearOutput();
			//MALE
			if (player.cocks.length > 0 && (player.gender != 3 || rand(2))) {
				//(LUSTY) 
				if (monster.lust >= monster.eMaxLust()) outputText("Panting hotly, the succubus staggers towards you, her eyes fixated on the bulge in your crotch.  Dark viscous liquid drips from her dusky folds as her hips undulate hypnotically.  Blue fingers smear the corrupted lubricants over the smooth outer folds of her sex as she lies back enticingly, giving up on anything but bedding you.  In moments your " + player.armorName + " are on the floor and you approach your prize.\n\n", false); 
				//(HP) 
				else outputText("The succubus collapses on the floor, groaning in pain.  Most of her clothes have been destroyed by the combat and her blue skin is marked with deep purple bruises and bloody lacerations.  You undress, straddling your conquest and gazing down on her helpless, curvaceous form.  She looks up at you and forces a smile, licking the blood from a cracked lip and beginning to masturbate for you.\n\n", false);
				//START ZE RAEP CANNONZ
				outputText("While pondering the best way to take your horny prize, her complexion begins to change, the marks of combat disappearing from her toned body.  The demonic horns crowning her perfect visage begin withdrawing into her head, and her hair ", false);
				if (player.hairLength > monster.hairLength) outputText("lengthens", false);
				else outputText("shortens", false);
				outputText(", shifting to " + player.hairColor + ".  The bone structures of her cheeks, nose, and face shift ever so slightly, and you suddenly realize you are looking down at a slutty version of yourself!  You aren't sure if it's the growing pool of succubus fluid below you or how hot your female twin is, but your " + player.cockDescript(0) + " is as hard as a rock.\n\n", false);
				outputText("Well, you DID decide to rape her, and now you know that you ARE smoking hot.  You shrug and shove your fem-double's legs apart, exposing her glistening fuck-target.  You bend down and bite her nipple as you position yourself at her entrance, allowing her to grasp your " + player.cockDescript(0) + " and coat it with her slick dark fluids.  It tingles as the tainted cunt-juices wick up into your dick like the oil from a lantern back home. At first it burns painfully, as if badly sunburned, but you adjust to the discomfort and marvel as your skin turns blackish-purple. Midnight-colored nodules sprout along the upper and lower portions of your " + player.cockDescript(0) + ", perfectly shaped to tease clits.  Just under its head, a ring of larger growths emerge, somewhat pointy, but flexible, rubbery and incredibly sensitive.  Your " + player.cockDescript(0) + " gets harder and harder as it grows slightly beyond its normal size.  It tugs your groin forwards, practically leaping towards its demonic mate on its own volition.  You cave in and press forwards, parting her folds and submerging your crown in corruptive bliss.\n\n", false); 
				//((TOO BIG))
				if (player.cockArea(0) > monster.vaginalCapacity()) {
					outputText("But the pleasure is short-lived, as even her altered physiology can't accommodate your massive tool. With a grunt of frustration you yank your hungry demonic cock away from your goal.  She smiles knowingly and massages her breasts, releasing streams of the same black fluid from her tumescent nipples. It coats the valley of her pornstar-sized breasts, allowing the fluid to flow down and pool in her tight little belly button.\n\n", false);
					outputText("\"<i>This will, like, be even better anyways stud!</i>\" coos a higher pitched you, smashing her tits together wetly for emphasis.  Viscous strings of lubricants form a mesmerizing lattice between her mountainous tits as she puts on a show for you.  Entirely of its own accord, your " + player.cockDescript(0) + " drags you into her web of corruption, plopping itself firmly into the river of desire that fountains from the peaks on either side. With a steady rhythm, you rock your " + player.hipDescript() + " back and forwards, plunging into her delicious fuckpillows without abandon. With an inhuman strength, she pushes them together, forcing them to completely encircle your over-sized pole with a tight ring of corruption-dripping tit-flesh.\n\n", false);
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					//[normal]
					if (player.cumQ() < 50) outputText("Droplets of pre begin to escape your cock-slit every time your sensitive nodules pass between your fem-clone's wondrous pleasure-tits.  You fuck harder, no longer caring if it's your choice or your cock's, mashing your purplish head against her lips with every stroke.  The flash-fire of an orgasm sweeps over you, over-engorging the nodules all over your cock and doubling their size.  Your hips resort to tiny rocking motions as you rub your cock-slit into your fem-self's open mouth, blasting thick ropes of tainted black cum into her mouth. Though you quickly empty of cum and collapse onto her, your " + player.hipDescript() + " continue to fuck like a machine.  All you can do is hang on to your meat and try to stay conscious as your demonic prick feasts on your double.\n\n", false); 
					//[high]
					if (player.cumQ() >= 50 && player.cumQ() < 500) {
						outputText("A steady stream of pre begins to escape your cock-slit, drooling over your double's face and tits as you pound away at her bouncing ring of titflesh.  Every new bump and nodule seems as sensitive as your entire maleness used to be.  Every thrust into the dark wet prison only makes your pre-cum drool faster and your " + player.cockDescript(0) + "'s new adornments grow fuller and even more tender.  In a flash, the fire of orgasm overwhelms your body's new taint-saturated cock.  Like a kinky 'wave', each nodule from the base to the pointy ring at your crown grows larger as your muscles clench.  ", false);
						if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " practically glow with relief as they begin contracting.  Their entire surface is covered with black veins that radiate from your demonic prick, sharing the corruption with your sperm factories.  ", false);  
						outputText("You throw back your head as the first wave of release pours from your tip, splattering your female clone with inky black cum!  The color startles you for a moment before the next blast moves down your shaft, visibly distending your urethra until it bursts free to coat her hair.  Your hips keep moving of their own accord, massaging the crown-ring with tits during each thrust forwards and accompanying cumshot.  By the fourth load, your double is opening her soaked lips wide and guzzling it down.  By the sixth she's sputtering and coughing as the black sex juice sloughs off her.  By the ninth she's managed to clamp her lips over your cock-tip, and her throat bulges ludicrously with the effort of taking each load.  Thankfully, your orgasm finally winds down.  As the last few globs of inky jism escape from you, you realize your hips are still moving, plunging your massive possessed tool into its new favorite place.  Sighing, you hang onto your endowment and try to stay conscious in spite of your exhaustion and the overwhelming feelings coming from your groin.\n\n", false);
					}
					//[ultrahigh]
					if (player.cumQ() >= 500) {
						outputText("A river of pre-cum begins pouring from your cock-tip's slit, soaking your slutty double's face and tits as it mixes with the corruptive fluids already smeared about.  The alien bumps and nodules upon your " + player.cockDescript(0) + " flex and twitch at every pass through the fuck-able foe's soft tits, slowly growing as they absorb more of your slut-self's taint.  The tight squeeze around your newly retextured " + player.cockDescript(0) + " overwhelms any sense of control you may have had as your arousal-soaked groin takes over completely.  You begin pounding the tit-pussy as if your life depended on it, jack-hammering  your " + player.cockDescript(0) + " forward and back hard enough to make the mountains of breast ripple and shake like jello during an earthquake.  The ring of pointed nodules around your crown continues to swell and grow with every pass through the inky passage, soaking up more and more of the corruption until they are each nearly two inches long.  Overwhelmed by the pleasure, your eyes roll back and a mighty orgasm comes to boil in your groin.  ", false);
						if (player.balls > 0) outputText("Your " + player.ballsDescript() + " twitch and shake, the veiny surface of your sack darkening as the corruption begins to fill them.  ", false);
						outputText("\n\nLike a perverted version of the wave, the nodules along your length fill with blood, doubling in size along your length as a massive bulge of cum rushes out your urethra.  Black cream drizzles from the tiny growths as the first blast of cum passes into your dick's crown moments before erupting like a volcano.  One second the sexy female version of you is moaning like a whore and licking her lips. The next she is sputtering and gasping as a half-gallon of inky black cum soaks her from head to tits.  Heedless of her discomfort, your legs keep sawing your " + player.cockDescript(0) + " deeper into this perfect titfuck as more thick bulges of tainted spunk begin to stretch your urethra on their way out.  You babble incoherently as your cock's tip plants itself against her open lips, blasting even more spunk directly into her waiting gullet.  Her cheeks bulge comically as the stuff drips from her nose, but somehow she manages to swallow the bulk of it, her hands vigorously milking your " + player.cockDescript(0) + " with her fuck-bags.  By the time the third jet of cum erupts, she's unhinged her jaw and somehow taken the head into her mouth, giving unfettered access to pump her belly full of your black jism.  You groan with uncontrollable pleasure as her belly fills with spunk.  Her eyes roll back as the next blasts expand her belly further, at first making her look slightly pregnant and then gradually stretching her belly until she looks like she could have minotaur twins.  You lose count of how much cum you put into her, but eventually she can take no more and your cock is pushed free by the pressure, splattering her face again.  Far from finished, you blast cum over her face as you realize she's lost consciousness; her eyes are totally rolled back and her tongue lolls from her mouth like that of a sleeping bitch.  Eventually your orgasm winds down, but not before leaving her in a 4 inch deep puddle of spunk, looking like more like a blue balloon full of dark water than woman.\n\n", false); 
					}
					outputText("Still, your possessed maleness is far from finished as it continues to slide along her belly and between her still-dripping tits, and before long you feel another orgasm building.  You hang on for dear life, hoping just to stay conscious through the ordeal...\n\n\nHours later you pull away, sated.  For now.", false);
				}
				//((IT FITS))
				else {
					outputText("You plunge in to her velvety depths and feel her rippling cunt-muscles contract tightly around you for a perfect fit.  She gasps as each cock-distorting nodule bounces her two-inch clitty, making your mirror image moan like a bitch in heat.  The corrupted fluids dripping from her snatch squelch loudly, making your groin burn with pleasure.  ", false);
					if (player.balls > 0) outputText("Looking down, you even see the veins on your sack darkening to solid black as the corruption begins tainting your sperm-factories.  ", false);
					outputText("You pull back, letting the ring of pointed fleshy barbs spring free before plunging them back in. The pleasure makes you swoon, nearly forcing you to orgasm on the spot.  ", false);
					if (player.biggestTitSize() > 0) outputText("Your female double reaches down to pinch your nipple, spurring you on, \"<i>Please, could you like, cum for me?</i>\"", false);
					//New PG
					outputText("\n\n", false);
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					outputText("The succubus bucks her hips weakly, still clearly defeated, but egging on your orgasm as dark fluids squelch free from her quim.  \"<i>Please... can't you see how hot you're making me?  I've made your cock perfect, so please make me cum!</i>\" she begs as she quivers with delight.  ", false);  
					outputText("You pause to think about it, not noticing that your groin is pounding away with furious energy, splattering cum and pre over her thighs as your new cock's instincts take control from your waist down.  Gasping with sudden pleasure, you feel a flash of heat pass through your tainted meatstick as an orgasm builds.", false);
					//New PG
					outputText("Each of the new bumps and rounded spines of your " + player.cockDescript(0) + " flood with blood, doubling in size as orgasm overtakes you.  ", false);
					outputText("Your hips bury your entire length inside her, acting on their own as your " + player.cockDescript(0) + " clenches, pouring more and more spunk inside her", false);
					if (player.balls > 0) outputText(" as your balls empty their load queue", false);
					outputText(".  ", false);
					//Big cum
					if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("You inhale as black cum spatters from her entrance, her belly distending slightly as you empty what feels like a gallon inside her.  ", false);
					//((Ginormohuge)) 
					if (player.cumQ() >= 400) outputText("Gasping in pleasure and surprise, you marvel as her belly visibly expands with each eruption of your dark load.  At first it looks like a tiny belly, but by the time the orgasm finishes, your girlish double looks like a woman in her ninth month of pregnancy – with twins.", false);
					outputText("\n\nYou pant with exertion and pull back, only to have your " + player.cockDescript(0) + " plunge right back in. Beginning another rough fucking session, your hips force-fuck her beyond your control.  Exhausted, you lean over her, figuring you may as well enjoy your double's wondrous breasts until your demonic cock has finally sated itself.  You just hope you don't black out from the waves of pleasure each of your new nubs radiates.\n\n\nHours later you pull away, sated.  For now.", false); 
				}
				outputText("\n\nThe succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out the door, disappearing.", false);
				player.orgasm();
				dynStats("cor", 5);
				combat.cleanupAfterCombat();
			}
			//FEMSAUCE
			else {
				if (monster.HP < 1) outputText("Your foe staggers and falls hard on her ass, utterly defeated.  Her bruises and lacerations slowly fade and heal, regenerating with the aid of her demonic powers.  You easily tear through her clothes, leaving only the damaged stockings that gird her legs. It doesn't take much to force her down on her back and straddle her as you disrobe, ready to take your pleasure.\n\n", false);
				else outputText("Your foe drops to her knees, stuffing three digits into her greedy snatch as arousal overcomes her desire to subdue you.  With great care, you approach your insensible enemy and tear off her clothes, leaving her wearing only the remains of her stockings as you force her down on her back.  As if possessing a will of their own, her legs lewdly spread as you disrobe.\n\n", false);
				outputText("Her budding clit rises from between her folds, hardening like a tiny three inch dick.\n\n", false);
				if (player.biggestLactation() > 1) {
					outputText("<b>You could scissor with her, or maybe force-feed her some of the milk you've backed up.  Which will it be?</b>", false);
					simpleChoices("Scissor",doScissorSuccubus,"Force Feed",doForcefeedSuccubus,"", null,"", null,"", null);
				}
				//No choices if not lactating...
				else {
					doScissorSuccubus();
				}
			}
		}
		public function doScissorSuccubus():void {
			outputText("You shiver with anticipation as you hook your leg under her thick thighs, lining up your " + player.vaginaDescript(0) + " as you press forwards.  The anticipation builds as your matched honeypots grow ever closer.  Making contact, your folds part as her purplish-red clit slips betwixt your nether-lips, vibrating slightly in tune with the succubus' heartbeats.  You gasp, feeling your own " + player.clitDescript() + " erecting and rubbing against her smooth mound.\n\n", false);
			if (player.clitLength >= 3) outputText("You groan with wanton desire as your " + player.clitDescript() + " continues to grow and grow until reaching full size and slipping inside the defeated slut's sloppy pleasure-hole.  ", false);
			outputText("It takes only a few seconds to get the succubus' juices really flowing, the sounds of your grinding hips dissolving into a cacophony of liquid squelches.  The gooey corrupt fem-cum tingles, spreading warmth through every patch of skin it touches.  Your locked hips writhe and twist with her's, eliciting pants and squeals from the both of you.  In no time flat, you find yourself cumming and feel your " + player.vaginaDescript(0) + "'s muscles clench hungrily with an unquenchable desire to be filled.  The succubus shivers in pleasure, probably feeding off your orgasm.  You back off, fingering your " + player.vaginaDescript(0) + " languidly and denying her a full meal.  Pouting, the succubus dips her fingers back in, determined to cum.", false);
			outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!", false);
			player.orgasm();
			dynStats("cor", 1);
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);
		}
		public function doForcefeedSuccubus():void {
			clearOutput();
			outputText("You chuckle as you decide to release some of the pent up pressure in your " + player.allBreastsDescript() + ".  Laying down over your conquest, you grasp her wrists and pin them to the floor as you shove your tits in her face", false);
			if (player.biggestTitSize() > 6) outputText(", nearly smothering the succubus with the swell of tit-flesh", false);
			outputText(".  You jiggle back and forth, lining up a " + player.nippleDescript(0) + " with the demon's parted lips.  You press your weight down threateningly, making it clear you could suffocate her with a boob.\n\n", false);  
			outputText("\"<i>Drink up bitch, these tits are full!</i>\" you command.\n\n", false);
			outputText("The succubus tentatively takes a " + player.nippleDescript(0) + " into her mouth, sighing at the tangy taste of your sweat-drenched skin.  Her lips gently suckle, wrapping around the perky hardening nub as it fills with arousal and milk.  You feel something let go inside your " + player.breastDescript(0) + " and the succubus smiles, now working to free more of your trapped cream.\n\n", false);
			if (player.biggestLactation() < 2) outputText("Her flexible tongue easily curls around one of your " + player.nippleDescript(0) + "'s, letting her pull and tug on it as she increases the suction from her lips.  Your body rewards her efforts with a faster flow of milk that she sucks down as if she were starving.\n\n", false); 
			if (player.biggestLactation() >= 2 && player.biggestLactation() < 3) {
				outputText("Her flexible tongue wraps around your milk-engorged nipple, pulling it tightly as she increases the suction of her lips.  Your body wastes no time rewarding her and she begins gulping down a steady supply of your breastmilk with a pleased expression on her face. You muse to yourself that perhaps succubi are masochists as breast-milk runs freely from your un-milked ", false);
				if (player.totalBreasts() > 2) outputText("tits.\n\n", false);
				else outputText("tit.\n\n", false);
			}
			if (player.biggestLactation() >= 3 && player.biggestLactation() < 4) {
				outputText("Her flexible tongue wraps around a milk-swollen nipple, immediately squeezing out a jet of thick breast-milk.  The tongue squeezes and tugs while the succubus ramps up the suction between her thick bee-stung lips.  Your body rewards her with fountains of milk, forcing her to visibly gulp and struggle to keep up with the heavy flow.  Milk runs freely down the " + player.skinDesc + " on your chest, pooling around the succubus' groin and your own as the unattended nipple", false);
				if (player.totalBreasts() > 2) outputText("s", false);
				outputText(" can't help but dribble in sympathy.\n\n", false);
			}
			if (player.biggestLactation() >= 4) {
				outputText("Her flexible tongue wraps around a milk-bloated nipple, immediately releasing a massive spray of cream that pours into her gullet, nearly choking her.  You stifle a giggle and pull her closer.  Thankfully, her determined tongue manages to stay in place and start tugging your nipple about, releasing even more of your over-large milk production.  She struggles, her throat and cheeks bulging from your explosive output of milk, until it overwhelms her and begin to pour out of her nose.  More milk pours from your unoccupied nipple", false);
				if (player.totalBreasts() > 2) outputText("s", false);
				outputText(" in sympathy, drenching your " + player.skinDesc + " with creamy goodness until it puddles on your captive demon.\n\n", false);
			}
			if (player.totalNipples() == 2) outputText("As your first nipple drains, you move her to your other breast, being sure to motivate her cunt by grinding it with your " + player.foot() + ".  She squeals and sucks harder, emptying the last of your milk with a cute burp.  ", false);
			if (player.totalNipples() > 2 && player.totalNipples() < 6) outputText("As your first " + player.nippleDescript(0) + " drains, you forcibly move her to the next, unleashing a fresh batch of milk for her to feast upon.  Eventually, it too dries up, so you migrate her onwards to your next " + player.nippleDescript(0) + ".  After she drains each of your " + num2Text(player.totalNipples()) + ", you smile happily at your now emptied breasts.  ", false);
			if (player.totalNipples() >= 6) outputText("As your first " + player.nippleDescript(0) + " drains, you force her over to the next, unleashing even more milk for her to feast upon.  In time, that " + player.nippleDescript(0) + " also empties and you rotate her on to the next.  The cycle repeats seemingly endlessly as you work her from nipple to nipple, relieving the insistent pressure of your breasts and slowly filling her with your milk.  ", false);
			if (player.averageLactation() * player.totalBreasts() < 6) outputText("Her belly bulges slightly from all the breast-milk she's consumed.\n\n", false);
			else outputText("The succubus looks bloated and pregnant from all the milk you've forced into her.  She sloshes and moans incoherently from the strain of it all.\n\n", false);
			outputText("Despite the relief your " + player.allBreastsDescript() + " now feel, your " + player.vaginaDescript(0), false);
			if (player.cocks.length > 0) outputText(" and " + player.multiCockDescriptLight() + " feel hungrier than ever.  ", false);
			else outputText(" feels hungrier than ever.  ", false);
			outputText("You shove your crotch into your milk-dazed foe's white-stained visage, grinding your " + player.vaginaDescript(0) + " into her mouth until you cum all over her", false);
			if (player.cocks.length == 0) {
				temp = rand(3);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText(", soaking her with girl-cum.", false);
				else {
					if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_WET) outputText(", slicking her face with girlish cum.", false);
					else outputText(", drenching her with a deluge of girlcum.", false);
				}
			}
			else outputText(", and unloading a wave of hot spunk into her hair.", false);
			outputText("\n\nYou push her over, noting that her freed fingers immediately bury themselves in her demonic snatch, loudly squelching as she tends to her own arousal.  Her perfect visage is a mess, coated with musky girlcum", false);
			if (player.cocks.length > 0) outputText(" and a thick layer of spunk", false);
			outputText(".", false);
			outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!", false);
			dynStats("lus", -50);
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);
		}
		public function dildoSuccubus():void {
			clearOutput();
			outputText("Your defeated opponent eyes you warily as you advance upon her, thrusting her chest forwards lewdly, with a hopeful gleam in her eye.  That gleam vanishes in sudden surprise when you stop and pull the oblong form of Tamani's dildo from your pouches.  The busty demon giggles happily, \"<i>I, like, love those things!  Those little sluts never let me keep one though!  Greedy bitches...</i>\"\n\n", false);
			outputText("The succubus spreads her fishnet-coated legs, exposing her moist vulva while she reclines against a table, beckoning you forwards.  Well, you certainly didn't expect her to be so willing, but you may as well go through with it!  You push up her tiny skirt for better access and position the toy for a perfect insertion. She begs, \"<i>Quit teasing me and just jam it in me already!  Honey, I just want to feel it stretch me while my hot little box drools all over it.  Would you mind giving my clitty a lick too?  It's aching for a touch.</i>\"\n\n", false);
			outputText("You see her button poking between her folds, far larger than the mortal women you've met, and you feel more than a little compelled to do as she's asked.   The toy slides in easily, though the further it penetrates her dark-blue cunt, the thicker it gets, and the more difficult it becomes to force it deeper inside.  Eventually you get it the entire way in.  The pair of you, demon and champion, watch together as her glistening cunt-lips are slowly forced apart, stretched wider and wider by the exotic dildo.  She giggles as you watch transfixed, and begins stroking her fingers all over her juicy outer folds while she asks, \"<i>Are you going to rape me or just stare at my cunt all day?</i>\"\n\n", false);
			outputText("Shaking your head and blushing ", false);
			if (player.cor < 50) outputText("in shame", false);
			else outputText("with lust", false);
			outputText(", you begin tracing your finger over her clit, smiling when it twitches.  It begins visibly growing every time you touch it, puffing up until it's nearly four inches of smooth purple succubus sex.   Glancing down further, you see her cunt stretched massively, the pink blob spreading her so wide it looks like any more swelling would dislocate her hips.  You give her clit a little squeeze and the succubus cums, noisily and happily.  Her clit spasms wildly, growing slightly bigger before beginning to wilt as the cunt-contractions force the dildo out.\n\n", false);  
			outputText("With a sodden 'plop', it hits the floor, revealing a gaping canal dripping with the dildo's pink aphrodisiacs.  The secretary-impersonating slut flops back, fondling her tits through her clothing as she languidly sighs, \"<i>Oooooh yeah those little cunts can make a good toy.</i>\"   She props herself up and begins touching her sex, holding open the gaped love-tunnel for you as she teases, \"<i>Yes, you've defeated me, like, for sure, mighty champion!  I don't think I'm capable of standing up to stop you! *Giggle*</i>\"\n\n", false);
			outputText("Good.  You pick up the toy ", false);
			if (player.cor > 75) outputText("giving it a long lick to taste the succubi's delicious flavor ", false);
			outputText("and put it away.  When you glance back towards the Succubus, she's gone, leaving you alone and horny...", false);
			dynStats("lus", (20 + (player.lib/5) + (player.cor/10)));
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);
		}
		public function doLossSuccubus():void {
			clearOutput();
			if (player.cocks.length > 0) {
				if (player.lust >= player.maxLust()) outputText("Driven half mad with lust, you drop to your knees. Your fingers fly over your body as you pry off every last piece of your " + player.armorName + ", displaying just how hard your alluring opponent has gotten you.  The succubus saunters over, every sinuous step radiating the inhuman sexuality that pours off her skin like heat from a bonfire.\n\n", false);
				else outputText("Exhausted, you collapse before the succubus.  She effortlessly slices away your " + player.armorName + ", peeling your possessions away with practiced ease.  In moments you are stark naked and wholly exposed to your captor.  In spite of yourself, your body begins to respond to her sultry aura, displaying the hardness of your desire and shame immediately.\n\n", false);
				outputText("\"<i>Awww, did I get you all <b>HOT</b> and bothered?</i>\" She croons, poising a stocking clad foot above you as her high-heels seem to fade away.  Warm silk begins to press against your groin as slender toes curl around the head of your throbbing maleness, your foe having her way with your desire-saturated form.  You mewl pitifully at the sensation, your hips twitching involuntarily against her demonic sole. The slippery surface of her foot squeezes as she expertly strokes you with her foot, delighting in her complete dominance over your easily controlled member.\n\n", false);  
				//balls or pussy play
				if (player.balls > 0) {
					//[[balls]]
					if (player.ballSize < 6) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses your " + player.ballsDescriptLight() + " with soft touches.  Almost immediately you feel them clench with boiling heat, growing heavy and churning with a load big enough to satisfy a thirsty succubus.", false); 
					//[[huge balls]]
					else outputText("Your sultry captor leans low, marveling at the size of your " + player.ballsDescriptLight() + " as she reaches down to caress them.  Her tits swing lewdly above you, bouncing in hypnotic motions. Her hands work gently, taking each one of your " + player.ballsDescriptLight() + " and hefting it gently.  Almost immediately you feel them fill with an unnatural heat that spreads everywhere her slender fingers touch.  They begin to feel full and heavy, practically sloshing as the pent up need inside you is channeled into liquid form.  \"<i>So ripe... and full,</i>\" she whispers to herself as she caresses them, her silken foot still sliding all over your " + player.cockDescript(0) + ", pumping stroke after stroke of pleasure into your lust-weakened form.", false);
				}
				else {
					//[[no balls no pussy]]
					if (player.vaginas.length == 0) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the skin between your " + player.cockDescript(0) + " and " + player.assholeDescript() + " with a slender finger.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning out from your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
					//[[no balls + pussy]]
					else outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the slick skin of your slit with a single digit.  Other fingers circle your " + player.clitDescript() + ", teasing it from between the folds as it grows hard, peeking out from the hood and turning cherry-red.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning in your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
				}
				outputText("\n\n", false);
				//[[Cum]]
				outputText("The succubus licks her lips in anticipation as she curls her silk-clad toes tighter around you, making you bulge and twitch in obscene pleasure.  With a naughty smile, she caresses your ass with her bulbous demonic tail.  Before you can react, it plunges inside you, easily slipping through your " + player.assholeDescript() + " and pressing tightly against your prostate.  The suddenness pushes you over the edge, but she immediately wraps her fingers around you, pinching tightly, bottling your cum inside you.  You cry out in pain and surprise as your entire thick load is trapped inside you.  After nearly a full minute, your groin aches with the discomfort of it all.\n\n", false);
				//More cum paragraph.  HAHA! TINY BABY CUM! 
				outputText("She wastes no time, and caresses you again.  You instantly feel another surge of heat and desire as a fresh load of cum brews behind your first strangled orgasm.  You need to cum so bad, her foot still stroking and squeezing you full of perverted desire.  She slaps your ", false);
				if (player.balls > 0) outputText("balls", false);
				else outputText("ass", false);
				outputText(" as she releases your " + player.cockDescript(0) + ", shouting, \"<i>CUM!  Feed me!</i>\"  You are all too happy to oblige.  ", false);
				//[[normal volume]]
				if (player.cumQ() < 50) outputText("Freed at last, your body clenches tightly as it squirts the first jet of cum from your " + player.cockDescript(0) + ".  She smears her foot over the head, catching the cum and using it to lubricate her silken foot as it massages your member with merciless strokes, alternatively catching your spooge and milking more from your obedient maleness.  Your orgasm lasts many times longer than normal as your dual loads feed her demonic hunger.", false); 
				//[[big volume]]
				if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("Freed at last, your body clenches tightly as it spurts a big glob of cum onto her waiting sole, soaking the bottom of her foot with slippery male-milk.  She smears her cum-covered foot over every inch of your " + player.cockDescript(0) + ", making each successive spurt bigger and messier than the last. Somehow she manages to catch more and more of your jizm over her foot, bathing you in cummy silkiness.  You groan helplessly as she milks more and more of from you till her foot is dripping steadily, your own groin and belly soaked with the stuff.  You give a few final exhausted squirts as she languidly rubs it into you.", false);
				//[[huge volume]]
				if (player.cumQ() > 400) outputText("Freed at last, your body clenches powerfully as a massive eruption of cum launches from your " + player.cockDescript(0) + " onto her waiting foot.  The succubus looks on incredulously as her entire foot is soaked with your sticky whiteness, forgetting to move as the second wave of cum drenches her to the ankle and rains down over your stomach.  She giggles and moves it back to your cock, massaging your slick spooge into your cock with her foot, wringing an even bigger explosion of cum from your tortured body.  Flopping back, she gets her other foot in on the action, milking you between her feet as you soak yourself completely with bigger and bigger eruptions until at last your orgasm begins to wane.  She slides forwards, rubbing against you and smearing the mess over herself with a blissful expression.", false);
				outputText("\n\n\"<i>Good boy,</i>\" she croons, mopping the cum up as it seems to wick into her stockings, \"<i>You'll do well once we get you on the line.</i>\"  You don't have time to ponder the significance of that as you lose consciousness.", false);
				//ONWARD TO BAD-END-IA!
				player.orgasm();
				doNext(doBadEndGeneric);
			}
			else {
				if (player.lust >= player.maxLust()) {
					outputText("Driven half mad with lust, you shake yourself free from the trappings of your " + player.armorName + ", first revealing your " + player.allBreastsDescript() + ", then " + player.hipDescript() + " and finally your ", false);
					if (player.vaginas.length > 0) outputText(player.vaginaDescript(0) + " as the last pieces fall away.\n\n", false);
					else outputText("bare groin as the last pieces fall away.\n\n", false);
				}
				//(HP loss)
				else outputText("You realize you're wobbling unsteadily, either from a blow to the head or blood loss, you can't be sure which.  In a display of sublime defiance, you manage to stay on your feet.  Though your tenacity does little good as your lightning-fast foe effortlessly undresses you, easily avoiding your clumsy and pain-addled movements.\n\n", false);  
				//START ZE RAPE
				outputText("The succubus steps away from you, withdrawing a tiny vial from a pocket in her vest.  She uncaps it with practiced ease, her outfit shifting into latex parody of a nurse's uniform as she attaches a small needle, completing the assembly of her injector.  \"<i>Like, don't worry about a thing hun, this will only hurt for a second,</i>\" she coos as she prances forwards, easily sinking the entire needle into your shoulder.\n\n\"<i>W-what did you do to me?</i>\" you manage to stammer.\n\n", false);
				outputText("She merely smiles and slips a delicately manicured finger under a rapidly disappearing skirt.  You ignore her crude display of wanton sexuality for the moment and try to focus on figuring out what the drugs did you, and what her needy slit smells like.  No, that wasn't it... you wanted to taste her nipples!  You shake your head and try to focus, but fail completely as the succubus lifts her sticky latex skirt, exposing her dripping snatch to you.  Your eyes lock on to the wondrous slut's fuckhole as her fingers tease you with glimpses between her folds every few seconds while she continues pleasuring herself.  With a flash of intuition, you realize what you were trying to think about:  finding something hard to penetrate that perfect hole with.  That little hungry snatch deserves to be filled with something throbbing and hard...\n\n", false);
				outputText("\"<i>OoooooOOOOH!  ...you're feeling it now are-AH AH YES-you dear?  Mmmmm yes, I bet this pussy is all you can think about.  I wonder if you can feel it-aaahhhhhhmmmm-yet?  This is always, like, the best part...</i>\" gasps out the succubus as she pleasures herself.  You wonder what she could be talking about as ", false);
				if (player.vaginas.length > 0) outputText("your " + player.clitDescript() + " parts your folds, growing harder.", false);
				else outputText("a fleshy growth erupts from your pale flesh, growing harder.", false);
				outputText("  In seconds you're playing with it, tugging the sensitive button as it fills up with more and more blood, growing bigger and harder than ever before.  Your legs give out as you begin stroking it with feverish intensity, barely registering as it grows to nearly eighteen inches in length, not noticing the increasingly veiny surface or different texture at the tip.  You force yourself to stop as a sudden truth asserts itself upon your consciousness - you need to shove your clit-like cock into a pussy.  You need to cum inside that hungry slut's blue spunk-receptacle.\n\n", false);
				outputText("You stand on shaky legs and lunge forwards, impaling the slutty nurse on your new tool with a violent animalistic passion.  Fucking her roughly, you lick her nipples to finally get the taste you've ached for.  Girl-cum squirts from the sloppy fuck-hole of the latex-nurse underneath you as you fuck her like a desperate animal.  She squeals with pleasure, splitting her legs wide apart to encourage your new maleness.  Your eyes roll back from the drug-enhanced pleasure of her dripping cunt as a male orgasm rocks your mind.  Mixed fluids splatter your pistoning hips as you do what you were always meant to do - feed and pleasure succubi.  Somehow your tool remains rigid and your hips continue plunging your new cum-spigot deeper and deeper into your mistress as the next orgasm begins to build inside your drug-addled mind, even as you black out.", false);
				player.createCock();
				player.cocks[0].cockLength = 16;
				player.cocks[0].cockThickness = 1.5;
				//[[[[To bad end!]]]
				player.orgasm();
				doNext(doBadEndGeneric);
			}
		}
		public function doLeaveSuccubus():void {
			combat.cleanupAfterCombat();
			//doNext(roomBreakRoom);			
		}
		
		//Incubus Mechanic
		private function talkIncubus():void {
			spriteSelect(30);
			if (player.hasKeyItem("Hentai Comic") >= 0) {
				outputText("The incubus speaks to you with calm deep voice, \"<i>And so the insect, heedless of it's path, stumbled directly into the spider's web.  Tiny insect... wait, what is that book you're carrying?  Is that hentai?  It IS!  Let me offer you a deal – I'm not really hungry or interested in fighting. So if you hand over the comic, I'll happily ignore your presence here. Though, I guess you could also just submit. Then I could put you to work and still get the comic.</i>\"", true);
				simpleChoices("Fight", doFightIncubus, "Submit", doSubmitIncubus, "Trade", doTradeIncubus, "", null, "", null);
			}
			else {
				outputText("The incubus speaks to you with calm, deep voice, \"<i>And so the insect, unaware of its path, stumbles directly into the spider's web.  Tiny insect, you have little to offer me, but everything to offer our facility.  Why don't you come along quietly?</i>\"", true);
				simpleChoices("Fight", doFightIncubus, "Submit", doSubmitIncubus, "", null, "", null, "", null);
			}
		}
		
		private function doTradeIncubus():void {
		spriteSelect(30);
			outputText("You hand over the Hentai Comic tentatively to the male sex demon.  As soon as he has it in his grubby mits he sits down and starts thumbing through the pages, toying with his half-hard member the entire time.  He must really like porn.", true);
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) outputText("\n\n<b>You swear you can hear a clicking sound coming from the west.</b>");
			player.removeKeyItem("Hentai Comic");
			flags[kFLAGS.FACTORY_INCUBUS_BRIBED] = 1;
			doNext(roomFurnaceRoom);
		}
		
		private function doFightIncubus():void {
			flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] = 1;
			spriteSelect(30);
			outputText("\"<i>You're going down!</i>\" you yell at him as you ready your " + player.weaponName + "! \n\nAn unseen force closes the door, preventing you from running away. \n\nIt's a fight! ", true)
			startCombat(new IncubusMechanic(), true);
		}
		
		private function doSubmitIncubus():void {
			spriteSelect(30);
			outputText("\"<i>It is good to see the insect accept its fate as the spider closes in,</i>\" intones the strange demonic mechanic as he takes you by the arm and leads you deeper into the facility.  ", false);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
				outputText("\n\nYou enter the main milking chamber, and the incubus gives a start when he realizes what has happened.  With a grunt of rage he throws you through the doorways back into his chamber.  The demon stalks after you, taking up a fighting stance.", false);
				startCombat(new IncubusMechanic(), true);
				return;
			}
			outputText("You are brought into a room full of moaning humans, lined up in machines along the walls. You can see they're apparently sorted by age, as the victims' hair turns more and more grey and silver as you look down the line toward the far wall. All of them are hermaphrodites, the older individuals seeming to have larger breasts and genitals than the younger ones.  Most have a number of syringes embedded into their bodies, pumping them full of tainted chemical aphrodisiacs and demonic mutagens.  Clear cups and tubes are attached to leaky nipples, pulling steady streams of milk from the insensible captives as they pant and moan like drug-addicted sluts.  Similar tubes cradle their enhanced man-hoods, rhythmically squeezing cum from their constantly orgasming bodies.  Hoses suck away the jizz and milk, pumping it to places unknown.  Despite yourself, you are beginning to be majorly turned on, realizing that you'll probably become another milk-dripping pleasure-addict in a few minutes.\n\n", false);
			outputText("\"<i>Time to serve your purpose, insect,</i>\" says the incubus, gesturing towards an empty harness. You stand immobile, either from fear or lust, until the incubus shoves you into the machine.  It automatically straps you down, leather pieces crisscrossing over your body and holding you in place.  You see something move at the edge of your vision, but due to the harness you can't turn your head to see it.  Something sharp pinches your neck and you fade to blackness....", false);
			doNext(doBadEndGeneric);
			return;
		}
		
		public function doLossIncubus():void {
			player.slimeFeed();
			clearOutput();
			//Nipplefuck city
			if (player.hasFuckableNipples() && player.lust >= player.maxLust()) {
				outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate.  You drop your top, exposing your " + player.allBreastsDescript() + " to your foe in a submissive display. Lowering your eyes, you hope you can tempt him to plug your " + player.nippleDescript(0) + " with his demonic prick.  You roughly squeeze each sensitive tit, trailing your fingers down the sensitive breast-flesh towards your rapidly dampening fuck-holes.\n\n", false);
				outputText("Your eyes relax as pure sensation overwhelms your already over-excited body.  Your fingers find your nipple-holes, locking around them while tugging and squeezing, stretching them tight with pleasure and pain.  You cast a seductive glance to the incubus' groin, noting that he's been taken in by your wanton display.  He takes a step, his cock rippling and twisting as it shifts and changes before your eyes. It divides it half, splitting into two full-sized pricks.", false);
				if (player.totalNipples() > 2) outputText("  Each of those divides again, splitting into four prehensile penises.", false);
				if (player.totalNipples() > 4) outputText("  They continue dividing until his wriggling mass is sufficient to penetrate every single nipple and then some.", false); 
				outputText("\n\n", false);
				outputText("A pleading moan escapes your lips and your captor obliges you, the cocks wriggling forward under their own power and sliding into your slippery " + player.nippleDescript(0) + "s with ease.  Each member is perfectly sized to stimulate you without over-stretching your tender breast-flesh.  You barely stifle a giggle, drunk on enough pleasure to shatter a lesser mind.  Your giggling is rudely interrupted by something hard and slick forcing itself between your lips.  You smile and slurp on it like a pacifier, swallowing droplets of pre-cum as his tentacle-like pricks fuck your breasts hard and fast, ", false);
				if (player.biggestLactation() > 1) outputText("splattering milk and pre everywhere.\n\n", false);
				else outputText("splattering your tits with escaped sexual fluids.\n\n", false);
				outputText("The demon tenses, pulling your head forwards and burying your nose against his belly.  The dick in your mouth slides down your throat, hanging just above your belly as it begins to fill your gut with bursts of demonic warmth.  Black cum erupts from your nipples as his orgasm overwhelms their meager storage capacity, soaking your tits in his corruptive essence as the pleasure finally breaks your mind.  Your eyes roll back into your head as you begin cumming... and cumming... and cumming. The orgasm drags on and on as more and more cum pours into your body.  Like a passenger in a car you see what's happening but have no control.  Your body is used and abused for hours before you finally drift off to sleep.", false);
				player.refillHunger(100);
				player.orgasm();
				dynStats("cor", 20);
				if (flags[kFLAGS.LETHICE_DEFEATED] > 0) outputText("\n\n\"<i>You're lucky I've decided to let you go since you've overthrown Lethice,</i>\" the incubus grumbles.");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) doNext(doBadEndGeneric);
				else combat.cleanupAfterCombat();
				return;
			}
			//Tentacle gangbang
			else {
				if (player.lust >= player.maxLust()) outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate. You drop your top, exposing your " + player.allBreastsDescript() + " to your foe in a submissive display, ", false);
				else outputText("You lower your top, exposing your nubile form to your foe in a submissive display, ", false);
				outputText("lowering your eyes and fixating on his now-rigid demonic member.  Right before your eyes, it begins splitting and dividing into thinner prehensile penises that squirm about in the air, each one reminding you of a snake on the prowl.  ", false);
				if (player.cor < 80) outputText("In a disgusting display", false);
				else outputText("As you grope yourself noisily with your hand into your undergarments, a salacious smile on your lips", false);
				outputText(", you watch as his pricks pulse and thicken out until their masses are as wide as his original dick.\n\n", false);
				if (player.cor >= 80) outputText("As you realize their size and number, you open your eyes wide and smile broadly, reflexively spreading your legs wide, practically begging him to fuck you.  ", false);
				outputText("In a flash, each fat tentacle-cock whips out and surrounds your body in slick demon-flesh.  The tentacles constrict, working in pairs to take off every piece of your " + player.armorName + ".  ", false);
				if (player.biggestTitSize() >= 2) outputText("They make sure to rub each of your breasts, spending a few seconds smearing slick pre-cum into your " + player.nippleDescript(0) + ".  ", false);
				outputText("A pair of them slides into your undergarments, pressing against your needy crotch and teasing your " + player.assholeDescript() + " with more slick demonic cum.  ", false);
				if (player.cor < 80) outputText("You wriggle and whine,", false);
				else outputText("You grab the thick tentacle-cock working on your cunt with both hands, as you can barely grab it with one. Then,  while letting out moans fit for a bitch in heat, which you are, you begin", false);
				if (player.vaginas.length > 0) outputText("squeezing your legs around them and grinding your " + player.clitDescript() + " against the oddly textured demon-cock.", false);
				else {
					if (player.balls > 0) outputText("grinding down against the ribbed and textured demonic cock as it slides between your " + player.ballsDescriptLight() + ".", false);
					else if (player.cocks.length > 0) outputText("squeezing your legs around the thick demonic flesh as a steady dribble of pre-cum drips from your " + player.cockDescript(0) + ".", false);
					if (player.gender == 0) outputText("grinding suggestively on your captor's rods, barely noticing as the last of your " + player.armorName + " falls away.", false);
				}
				outputText("\n\n", false);
				//FUCKKKING
				//Female paragraph
				if (player.vaginas.length > 0 && (player.cocks.length == 0 || rand(2))) {
					outputText("The incubus at last decides to tend to your over-aroused body and pulls you off the ground with his tentacles, suspending you in mid-air.  ", false);
					if (player.cor < 80) outputText("You feel your " + player.legs() + " lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door while a thicker one lines itself up just below your " + player.clitDescript() + ".  ", false);
					else outputText("As he lifts you, you spread your legs, showing him your cunt which is dripping wet from anticipation, and grabbing your ass to give him a perfect view of your " + player.assholeDescript() + ".  You then beg him, between lecherous moans, to use his three biggest tentacles, as you want to have the most sensations.  With a sadistic smile, he lines up two tentacle cocks about as big as your arm over your " + player.vaginaDescript(0) + " and your " + player.assholeDescript() + ".  ", false);
					outputText("You then giggle and try to wiggle your " + player.hipDescript() + " forward, begging for him to take you and quench the fire burning in your " + player.vaginaDescript(0) + ".  The incubus obliges, pressing forth with both drooling members and simultaneously plugging your front and back doors.  ", false);
					if (player.cor < 80) outputText("You gasp from pleasure and surprise, ", false);
					else outputText("You open your mouth wide, as the enormous tentacle-cocks force their way in, dripping demonic pre-cum all over. Quickly, it acts as additional lubricant, and the pain largely subsides.  You find that these massive demonic cocks' size is perfect to stimulate, in an incredibly pleasurable way, all sides of your cunt at once, and to stretch your ass just a bit over your preferred size.  As the incubus starts moving his appendages in rhythm, you're lost in heavenly pleasure, eyes closed, letting out deafening moans of lust, your legs and arms dangling without any thought for dignity.  You are deeply ", false);
					outputText("enjoying the knobbed texture of his shafts as you're double-penetrated by a single demon. The incubus smirks as another cock-tentacle wraps itself up around your neck like a shiny student collar and plugs your noisy little mouth.  You groan into his member as you're ", false); 
					if (player.cor < 80) outputText("squeezed and caressed by the writhing tentacle-pricks in and around your body, lost in the pleasure and taste of demonic pre-cum.\n\n", false);
					else outputText("getting roughly fucked by the two tentacle-cocks at the same time.  Taking the tentacle-cock in your mouth with both hands, you eagerly swallow every bit of demonic pre-cum, then suckle on the huge cock-slit. \n\n", false);	
					
					//FemCum
					if (player.clitLength > 3) outputText("You nearly cum on the spot when the cock fucking your pussy loops its length around your " + player.clitDescript() + ", the cum-slickened coils driving you mad with pleasure as they coil, slide, and jerk around your clit as if it was a cock.  ", false);
					else outputText("You nearly cum on the spot when the cock fucking your pussy curves up to rub its textured nodules against your " + player.clitDescript() + ".  ", false);
					player.cuntChange(player.vaginalCapacity()*.8, true);
					if (player.cor >= 80) outputText("You cum more times than you are able to count, each time causing a tightening of your fuckholes, which increases the rubbing against the demonic nodules and sends another wave of pleasure to your dazed brain.  You begin to drool freely, reveling in this most unholy mating.  ", false);
					outputText("The prick in your mouth surges forward, sliding deep into your throat.  The coils around your neck tighten in response, choking your neck into a tight cock-sleeve as you feel bulges of cum moving along its length.  In moments you feel your belly starting to grow full, sloshing with cum as you become desperate to breathe.  The tentacles lodged in your " + player.assholeDescript() + " and " + player.vaginaDescript(0) + " react in similar fashion, stretching you wide as they begin pumping your body full of vast quantities of spunk.  A few free tentacles begin spurting gobs of the white stuff onto your " + player.skinDesc + ", soaking you in the stuff as you black out from a combination of oxygen deprivation and pleasure.", false);
					player.refillHunger(100);
					player.orgasm();
					dynStats("cor", 25);
					player.buttChange(monster.cockArea(0), true);
					if (flags[kFLAGS.LETHICE_DEFEATED] > 0) outputText("\n\n\"<i>You're lucky I've decided to let you go since you've overthrown Lethice,</i>\" the incubus grumbles.");
					if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) doNext(doBadEndGeneric);
					else combat.cleanupAfterCombat();
					return;
				}
				//Male/Genderless
				else {
					outputText("The incubus at last decides to tend to your over-aroused body and pulls you off the ground with his tentacles, suspending you in mid-air.  You feel your " + player.legs() + " lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door, slathering your " + player.assholeDescript() + " with a nubby cock-head as it slowly presses forward and fills you with incredible tainted warmth.  Each nub and ridge that grinds past your sphincter bumps against the organs in your backdoor and fills you with pleasure that only increases as more of the demonic pre-cum is wicked into your body.  The gasp you started fades into a soft croon of pleasure before being muffled entirely by another thick prick.  The shaft belonging to the dick in your mouth curls around your neck like the collar a pet or submissive slut would wear.", false);
					if (player.cocks.length > 0) outputText("  As your body's orifices fill with more and more dripping demonic dick-flesh, your " + player.cockDescript(0) + " becomes painfully hard.  Another tentacle wastes no time in wrapping itself tightly around the base like a cock-ring.  The rest of the demon's prehensile tool slides along your shaft, curling around to squeeze and jerk you off.", false);
					if (player.balls > 0) outputText("  You groan around the dick plugging your throat as another tentacle-like appendage wraps around your " + player.sackDescript() + ", pulling your " + player.ballsDescriptLight() + " down and gently squeezing them.", false);
					outputText("\n\n", false);
					//Genderless Orgasm
					if (player.gender == 0) outputText("The tainted cum mixed with the sensation of fullness provide you with pleasures beyond what your genderless body could accomplish on its own.  You writhe as the demon face-fucks you with one tendril while another continues to bury itself ever-deeper into your abused " + player.assholeDescript() + ".  ", false);
					if (player.cocks.length > 0) outputText("The cock-tentacle around your " + player.cockDescript(0) + "  increases the pace of its stimulation as it begins to spurt hot wet cum over you, giving it lubrication as it jacks you off while staying tight around your base to prevent you from an orgasming.  ", false);
					outputText("You feel cum pulse through the tentacles encircling you as the incubus loses control of his tentacles.  Cum pumps into your belly, suffusing you with drug-like warmth as the tentacle around your neck pulls tight enough to squeeze the cock inside your throat.  You squirm and gasp for oxygen as spooge begins unloading into and around your body to the point where you aren't sure where your body begins and the demonic-spunk ends.  You twitch in what you assume is orgasm as you fight to breathe; all the while more cum is squeezed into your stuffed belly and ruined anus. The tentacle in your ass backs out slowly, having filled every inch of your intestines with cum, until it pops free with a splatter.", false);
					outputText("\n\n", false);
					if (player.cocks.length > 0) {
						outputText("Being so thoroughly used and stimulated pushes you over the edge of orgasm, and your ", false);
						if (player.balls > 0) outputText("balls", false);
						else outputText("prostate", false);
						outputText(" unloads with enough force to squeeze past the constrictor clutching at your groin.\n\n", false);  
						//Small cum
						if (player.cumQ() < 50) outputText("You groan and orgasm with enough force to splatter a few ropes of cum into the sea of demon-spunk that soaks you from head to toe.  ", false);
						//Big cum
						if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("Your orgasm goes off like a shotgun blast, splattering the incubus with a huge wad of cum.  It's but the first of many, and though each load of jizz is of comparable size, the force behind them diminishes until the last few blasts drip down your body and soak your " + player.legs() + " and " + player.feet() + ".  ", false);
						//Huge cum
						if (player.cumQ() >= 400) outputText("Your orgasm goes off like a volcano, visibly distending your " + player.cockDescript(0) + " as a huge wave of cum erupts from your groin, painting the incubus and floor with your spoo.  You cry from the sheer pleasure as the next wave builds and erupts, nearly as large as the last.  The demon-cock controlling your prick aims this blast up, forcing you to soak your " + player.hairDescript() + " and face with slick goo. The orgasming drags on and on while you slowly turn blue from oxygen deprivation. Before long, both you and the incubus are buried under a wave of white.  ", false);
					}
					outputText("The feeling is so intense that your " + player.hipDescript() + " twitch and move of their own volition while your eyes roll back in pleasure.\n\n", false);
					outputText("You black out just as you feel the cock-tentacle in your throat retracting. You dully feel your body drop to the ground, your pregnant-looking belly sloshing with demon jizz.", false);
					player.refillHunger(100);
					player.buttChange(monster.cockArea(0), true);
					player.orgasm();
					if (flags[kFLAGS.LETHICE_DEFEATED] > 0) outputText("\n\n\"<i>You're lucky I've decided to let you go since you've overthrown Lethice,</i>\" the incubus grumbles.");
					dynStats("cor", 25);
					if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) doNext(doBadEndGeneric);
					else combat.cleanupAfterCombat();
				}
			}
		}
		public function doRideIncubusAnally():void {
			outputText("Every day you've spent in this corrupted landscape has made you stronger and hornier, the evidence of which now kneels at your feet.\n\n", true);
			outputText("The fight over, your eyes begin to wander. You find you cannot resist staring at the huge swinging cock exposed by the incubus' crotchless overalls. The sight ignites desire that has been building within you ever since you arrived in this corrupted land. With an unnatural hunger, you knock the defeated incubus onto his back. He closes his eyes and groans, lost in his own world of lust and pain and unable to resist as you wantonly straddle him. His tool is hot in your hand as you tease it and his cock begins to grow slick with pre-cum. You lick your lips at the sight of his now glistening member, but not for hunger of food or drink. It is another kind of hunger that longs for satisfaction, a hole that needs to be filled. Eagerly, you position his swollen glans against your " + player.assholeDescript() + " and begin to ease yourself down over the massive tool. You start slowly, but the pleasure it's giving feels so good you ram the rest of the incubus' cock deep into your " + player.assholeDescript() + ".  ", false);
			outputText("His eyes flash open as if you'd just sent a jolt of electricity through him and he regains his senses, becoming hyper-aware of what you're doing. The incubus instinctively moves to control your " + player.hipDescript() + " and " + player.buttDescript() + " as they grind against him, guiding his cock towards pleasurable areas up your " + player.assholeDescript() + " that you would never have guessed were there a short while ago.\n\n", false);
			outputText("All too soon, he grunts and shivers as loads of his hot cum begin to squirt into you. He may be cumming, but you're not done yet; each squirt of seed only fans the flames of lust within you, making your increasingly wet and noisy thrusts even harder. Enjoying the ride and still nowhere near satisfied, you start sliding up and down on his slick pole even faster than before. He halfheartedly tries to push you off as you continue draining him of his seed, your lust seemingly unquenchable. But you cannot be stopped; his efforts only add to your pleasure as he struggles and unloads underneath you. With your belly beginning to swell with the cum you're relentlessly drawing from the incubus, you don't know how much longer either of you will last. Each movement of his tool inside you heightens the fire inside you until, with an unholy roar, the pleasure peaks and wave after wave of shuddering orgasm crashes over you. Each one hits hotter and harder than the last until finally, your senses are overcome and you lose consciousness entirely.\n\n", false);
			outputText("You awaken moments later beside a sleeping, limp, and drained incubus. You have definitely come out on top from the encounter. Though you feel stretched, sticky and a little sore, for the moment at least the burning desire to fill your " + player.assholeDescript() + " is satisfied.", false);
			player.buttChange(monster.cockArea(0), true);
			player.slimeFeed();
			player.orgasm();
			dynStats("cor", 2);
			combat.cleanupAfterCombat();
			//doNext(roomFurnaceRoom);
		}
		public function doRapeIncubus():void {
			clearOutput();
			//RAPE THE DEMON -
			//(BUTTRAPE - Requires Penis)
			if (player.cocks.length > 0) {
				outputText("With a few deft motions, you shift your " + player.armorName + " to expose your ", false);
				if (player.gender == 3) {
					if (player.balls > 0) outputText(player.multiCockDescriptLight() + ", " + player.ballsDescriptLight() + ", and " + player.vaginaDescript(0), false);
					else outputText(player.multiCockDescriptLight() + " and " + player.vaginaDescript(0), false);
				}
				else {
					if (player.balls > 0) outputText(player.multiCockDescriptLight() + " and " + player.ballsDescriptLight(), false);
					else outputText(player.multiCockDescriptLight(), false);
				}
				outputText(".  Having resolved to take the demon's backdoor, you approach his weakened form with brimming confidence.  He looks up, clearly hoping your plan is to squat on his throbbing member.  You dispel his misguided notion when you grab him by the horns and shove his face against the floor. He struggles weakly until you press down harder, making it clear he is to stay in position - on his knees with his head down and his ass in the air.  Circling your prey, you inspect his flawless body and carefully note that the hole at his crotch actually exposes a fair portion of his very supple and surprisingly feminine-looking backside.\n\n", false);
				outputText("You don't waste any time, gripping your " + player.cockDescript(0) + " in one hand and ", false);
				if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("pressing your thick flare ", false);
				if (player.cocks[0].cockType == CockTypesEnum.DOG) outputText("pressing your pointed tip ", false);
				if (player.cocks[0].cockType == CockTypesEnum.HUMAN || player.cocks[0].cockType.Index > 2) outputText("pressing your head ", false);
				outputText("between the incubus' cheeks towards his inhumanly smooth rear-passage.  You gasp in delight at the tight ribbed texture of his asshole as you slide ", false);
				if (player.cocks[0].cockLength > 10) outputText("deep inside ", false);
				else outputText("inside ", false);
				outputText(".  The demon underneath you grunts in an attempt to sound displeased, but it's plain to see the pre-cum he's dripping all over the floor.  What a slut!  You slap his ass and begin roughly butt-fucking him, panting with each plunge into the depths of his ridged passage, gradually increasing your tempo until your " + player.hipDescript() + " fill the room with loud slapping noises.", false);
				if (player.balls > 0) outputText("  Your " + player.ballsDescriptLight() + " swing freely, smacking into the demon's own and making both of you squeal and dribble more pre-cum.", false);
				outputText("\n\n", false);
				//(CUM)  
				if (player.balls > 0) outputText("You feel your " + player.ballsDescriptLight() + " draw up tight against your body.  ", false);
				outputText("Warm heat begins to build inside your groin, pooling under the base of your " + player.cockDescript(0) + ".  You realize you're about to paint this demon's gut with white, the thought only turning you on more.  ", false);
				if (player.cumQ() > 200) outputText("You groan as you feel your urethra being stretched by the sheer volume of fluid beginning to shoot through it.  ", false);
				outputText("You throw back your head and cum, slapping the incubus' ass with one hand while you grip and squeeze the jiggling flesh of his other cheek.  ", false);
				if (player.cumQ() < 50) outputText("A few thick spurts later and y", false);
				if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("Thick jets of cum pump into the demon's plump backside, soon building up a wave of pressure that pushes back against you.  Y", false);
				if (player.cumQ() >= 400) outputText("A massive cock-distending bulge of cum works through your shaft, splashing into the demon's rectum in an explosive burst of pleasure. Unfortunately for your victim, it is only the first of many such cum-blasts. In no time flat, jism is spurting from his overfilled rectum while his belly looks a few months pregnant. You feel weak from discharging so much fluid, and y", false);
				outputText("ou fall back, the fluid of your orgasm dripping from your " + player.cockDescript(0) + " and the gaping asshole of your latest conquest.\n\nYou turn to gather your " + player.armorName + ", and when you look back the demon is gone, leaving only a small puddle of male fluids in his wake.", false);
				player.orgasm();
				combat.cleanupAfterCombat();
				//doNext(roomFurnaceRoom);
			}
			//(VAGINAL - Requires Vagina)
			else {
				player.slimeFeed();
				outputText("With a few deft motions, you shift your " + player.armorName + " to expose your ", false);
				//Herm
				if (player.gender == 3) {
					if (player.balls > 0) outputText(player.multiCockDescriptLight() + ", " + player.ballsDescriptLight() + ", and " + player.vaginaDescript(0), false);
					else if (player.balls > 0) outputText(player.multiCockDescriptLight() + " and " + player.vaginaDescript(0), false);
				}
				else {
					outputText(player.vaginaDescript(0), false);
				}
				outputText(".  Striding forwards with hunger in your eyes, you give your left hand free access to your groin and slip your fingers between the moist folds of your " + player.vaginaDescript(0) + ".  As you undulate into the incubus' personal space, a swift thrust of your " + player.hipDescript() + " buries your fingers up to the knuckles and knocks the demon onto his well-muscled back.\n\n", false); 
				outputText("He looks up at you with a practiced eye, adjusting his demon-tool's size to better fill your  " + player.vaginaDescript(0) + ".  ", false);
				//(set cocksize = to 80% vaginalCapacity).
				
				outputText("Thankful for the gesture, you sink down onto him, letting the nubs of his crown stimulate your lips and the underside of your " + player.clitDescript() + ".  ", false);
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("In no time flat your drooling fluids soak him in slippery wetness.  ", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK && player.vaginas[0].vaginalWetness != VAGINA_WETNESS_DRY) outputText("Before long, you've lubricated a fair portion of his tool with wetness.  ", false);
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) outputText("Despite your usual light lubrication, you manage to moisten the top-half of his tool with wetness.  ", false);
				outputText("Relaxing the muscles in your " + player.legs() + ", you let a few inches of his length slip inside you, every nub and nodule of his corrupted prick filling the walls of your love-canal with inhuman pleasures that make your knees weak.  A particularly delightful bump brushes your " + player.clitDescript() + ", causing your " + player.legs() + " to finally give out. The incubus' nubbly cock plunges entirely inside you.\n\n", false);
				outputText("You gasp and moan like a cheap whore, disgusted by yourself and yet so turned on by the total loss of self-control.  The incubus is leering up at you, having regained some of his lost confidence.  Despite the lust, desire and pleasure burning through the hot pole buried in your abdomen, you work up enough rage to grip his neck with your left hand and practically choke him out.  You work your hips quickly as you feel his pre start to drip into your canal, spreading tingling warmth in the deepest parts of your passage and into your cervix.  You tighten your grip as you forcibly take your pleasure, barking in displeasure at the demon, \"<i>Don't look like you're enjoying this too much bitch, or I'll take it out of your hide.</i>\"  Satisfied at the renewed look of fear in his eyes, you return to using his magnificent tool as a masturbation aid.\n\n", false);
				outputText("Unable to contain your body's desires due to either the demon's aura or his wonderful penis, you slam your " + player.vaginaDescript(0) + " onto his member with impunity, twitching and squeezing involuntarily.  His tainted pre-cum begins seeping deep inside your uterus and you cry out with orgasmic intensity.  Your entire body clenches down, even the hand clamped on the incubus' windpipe. You feel his demon-cock swell up inside you in response to his stress, stretching your cunt taut.  His skin darkens from the lack of oxygen as he begins cumming HARD inside you.  Your womb immediately fills with his demon-seed, leaving ribbons of spunk to drip from your tightly-stretched cunt.  You sigh in delight as your muscles slowly stop quivering.  With a pleasured gasp, you rise off the distended demon-prick, and realize that you've choked your foe into unconsciousness. Still, you did let him cum, so maybe he won't mind too much when he wakes.  Feeling sensual and sated, you redress and prepare to explore the rest of the factory. ", false);
				player.cuntChange(player.vaginalCapacity()*.8, true);
				player.orgasm();
				dynStats("cor", 2);
				combat.cleanupAfterCombat();
				//doNext(roomFurnaceRoom);
			}
		}
		public function doOralIncubus():void {
			player.slimeFeed();
			clearOutput();
			outputText("You lick your lips, moistening them as you decide that the demon will provide your next 'snack'.  Touching the defeated incubus' soft skin, you grab him by the wrists and yank him to his clawed feet. Leaning him back against the wall as he sways unsteadily, you tenderly slide down his body and take the measure of his monstrous meat with your hands. The smooth skin and tiny bumps slide between each finger as his manhood firms and twitches in response.  You glance up and grab his baseball size nuts, caressing the smooth hairless sack that contains them, watching the demon-man sigh and relax with equal parts desire and relief.\n\n", false);
			outputText("You lean forwards, opening your mouth ", false);
			if (player.hairLength > 10) outputText("and brushing a strand of " + player.hairColor + " out of the way ", false);
			outputText("as his shiny purplish monster-cock fills your view. You kiss the tip, swirling your tongue around the nubbly ridge that surrounds the crown.  After a few moments of your tongue's focused attention, you are rewarded with a dollop of slightly sweet pre-cum.  You pause momentarily to smile at your victim before you wrap your hand around as much of him as you can hold and start to jack him off, slowly cramming more and more of his length inside your mouth.  Your free hand continues to fondle his balls, occasionally sliding a finger along the inside of his thigh.\n\n", false); 
			outputText("You feel his balls begin to grow. Perhaps he can sense your thirst for cum, or maybe he just wants to enjoy it - but you are sure he is going to finish spectacularly. They stop swelling just as they reach the size of grapefruits, tingling and pulsing spectacularly in your hand.  You stroke him faster, letting you guzzle his pre as it pours into your greedy mouth.  A coo of delight escapes from your tightly-stretched lips as you savor his tasty fluids.\n\n", false);
			outputText("The incubus' hips begin humping your face, stuffing a few more inches of his length into your throat and forcing you to struggle against gagging.  His cock swells wider and nearly unhinges your jaw as you feel a gooey warmth wash your throat, flooding your gullet with demon-seed.  Still impaled on his nubby member, your body is rocked back and forth by the strength of his orgasm, the motions making your belly slosh with an increasingly large load.  You moan at the warmth of his corruption seeping through your body as his orgasm diminishes. Yanking back hard, you let his dick slip free of your mouth as the last spurt of cum blasts your face.", false); 
			player.refillHunger(50);
			outputText("\n\n", false);
			outputText("You push the exhausted demon down and idly collect the cum from your face with your fingers, slowly licking each clean.  Feeling rather sensual and sated, you decide to resume exploring the factory.\n\nAfter redressing you turn about, and see the demon is gone, leaving only a small pool of cum in his wake.", false);
			combat.cleanupAfterCombat();
			//doNext(roomFurnaceRoom);
		}
		public function doLeaveIncubus():void {
			combat.cleanupAfterCombat();
			//doNext(roomFurnaceRoom);
		}
		
		//Omnibus Overseer
		private function doFightOmnibus():void {
			outputText("You strike a combat pose and prepare your " + player.weaponName + ".  She smiles and saunters around the desk, letting something bulbous and fleshy drop free from between her nether-lips.  You watch in shock as it hardens into a dick, growing right from where her clit should be.\n\nShe taunts, \"<i>Like what you see cow?  I'll be sure to visit you in the pens.</i>'\" \n\nAn unseen force closes the glass door to the north, preventing you from running away!", true);
			flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] = 1;
			startCombat(new OmnibusOverseer(), true);
			spriteSelect(16);
			return;
		}
		
		private function acceptOmnibus():void {
			spriteSelect(16);
			outputText("She smiles, sauntering closer.  Your eyes widen in shock as her vulva are spread apart by something inside her.   A slick and growing cock emerges, sprouting from where her clit should be located.  She's a hermaphrodite.  You don't have time to contemplate the implications, as the demoness used your temporary distraction to sink a needle into your neck.  You sigh and black out almost instantaneously, letting her catch you with her strong arms and soft bosom.", true);
			doNext(doBadEndGeneric);
		}
		
		public function doLossOmnibus():void {
			doBadEndOmnibusPart1();
		}
		
		//Choose your poison
		public function winAgainstOmnibus():void {
			clearOutput();
			if (monster.lust >= monster.eMaxLust()) {
				outputText("The omnibus trembles where she stands, her proud demonic dick twitching and pulsating as her desires totally overwhelm her.  The tainted nodules covering the purplish hermaphrodite's member ripple and swell from the base towards the tip, culminating with an explosive eruption of sticky, white demon-seed.  She moans with shame and pleasure, pumping larger and larger volumes of cum onto her office's floor.  She drops to her knees, too exhausted and ashamed by her premature orgasm to continue fighting.\n\n", false);
				outputText("\"<i>Ooooh no.  You can't tell the other demons I got off so easily!  I'll never live it down,</i>\" she cries, \"<i>You've beaten me, please if you let me go and promise not to tell the other demons I'll use my magic to give you a gift!  My magic is powerful, I can do nearly ANYTHING with it when the subject desires the changes.</i>\"\n\n", false);
			}
			else {
				outputText("The omnibus trembles and drops to her knees, utterly defeated.\n\n", false);
				outputText("\"<i>Please, if you'll let me go I could use my magics to give you nearly anything you want!  Just please don't tell the other demons what happened here, I'd never live it down,</i>\" she begs.\n\n", false);
			}
			outputText("What do you do?  You could use her boon increase the size of your endowments or maybe regain some of your lost humanity!  Or you could play it safe and turn down her offer.  Although then you'd have to decide to let her go or kill her.", false);
			menu();
			addButton(0, "Grow Breasts", chooseBreasts, null, null, null, "Grow a new pair of breasts if flat-chested or grow existing breasts. \n\nAnd receive something else.");
			addButton(1, "Grow Dick", chooseDick, null, null, null, "Grow a new penis. Somehow, you have a feeling that the new cock you'll receive won't be a normal cock. \n\nAnd receive something else.");
			addButton(2, "Normal Face", normalFace, null, null, null, "Normalize your face. This will also remove your horns or antennae and change your ears back to human ears! \n\nAnd receive something else.");
			addButton(3, "Normal Chest", normalChest, null, null, null, "Normalize your chest. This will shrink breasts larger than E-cup to a reasonable size and remove their other unusual traits, if you have it. This will also change your skin to human skin. \n\nAnd receive something else.");
			addButton(4, "Normal Groin", normalGroin, null, null, null, "Normalize your groin, removing any extra cocks and reset remaining cock to normal, if you have any. Or grow genitalia for genderless. \n\nAnd receive something else.");
			addButton(5, "Normal Legs", normalLegs, null, null, null, "Turn your legs back to normal. This will also remove your tail, if you have any! \n\nAnd receive something else.");
			addButton(6, "More Lust", postOmnibusBoon, true, null, null, "Be always ready for sex.\n\nDo you think it is really good idea?");
			addButton(8, "No (Let go)", letGoOmnibus, null, null, null, "Refuse the offer and let the demon go.");
			addButton(9, "No (Kill Her)", killOmnibus, null, null, null, "Refuse the offer and kill the demon instead.");
		}
		
		private function chooseBreasts():void {
			spriteSelect(16);
			clearOutput();
			//Grow if none
			if (player.breastRows.length == 0) {
				outputText("<b>Your chest swells out, forming rounded C-cup globes, capped with tiny erect nipples!</b>", true);
				player.createBreastRow();
				player.breastRows[0].breastRating = 3;
				player.nippleLength = .25;			
			}
			//Singular row - cup size + 3.  Nipple size to 1" if smaller.
			else if (player.breastRows.length <= 1) {
				outputText("Your " + player.allBreastsDescript() + " tingle pleasantly as the magic takes effect.  You watch with fascination as they begin to swell up, like sponges exposed to water.  The top of your " + player.armorName + " is pulled tight by change, until your chest seems ready to burst free.  <b>You've gained 3 cup sizes!</b>  ", false);
				player.breastRows[0].breastRating += 3;
				if (player.nippleLength < .75) {
					player.nippleLength += .5;
					outputText("Your " + player.nippleDescript(0) + "s grow hard and sensitive, becoming much more noticable inside your " + player.armorName + ".  It appears your nipples are have grown larger to match.", false);
				}
			}
			//Multiple Rows...
			else {
				//Top row + 3, all other rows brought up to par.
				outputText("Your top " + player.breastDescript(0) + " tingle pleasantly as the magic takes effect.  You watch with fascination as they begin to swell up, like sponges exposed to water.  The top of your " + player.armorName + " is pulled tight by change, until you're chest seems ready to burst free.  <b>You've gained 4 cup sizes!</b>  ", false);
				player.breastRows[0].breastRating += 4;
				outputText("The next row of " + player.breastDescript(1) + " jiggle and tingle with even more pleasure than the first.  They pulsate for a few seconds, shrinking and growing rapidly until they settle at a size just below your top " + player.breastDescript(0) + ".  ", false);
				player.breastRows[1].breastRating = player.breastRows[0].breastRating-1;
				if (player.breastRows.length >= 3) {
					outputText("Your third group of " + player.breastDescript(2) + " seem to follow their sister's example, and settle tingle briefly before settling at a size just below the breasts above.  ", false);
					player.breastRows[2].breastRating = player.breastRows[1].breastRating-1;
				}
				if (player.breastRows.length >= 4) {
					outputText("Your remaining " + player.breastDescript(3) + " feel so wonderful that you just can't resist cupping and squeezing them as they reshape to fit in perfectly with the rest of your breasts.  ", false);
					player.breastRows[3].breastRating = player.breastRows[2].breastRating-1;
					if (player.breastRows.length == 5) player.breastRows[4].breastRating = player.breastRows[3].breastRating-1;
				}
				if (player.nippleLength < .75) {
					player.nippleLength += .5;
					outputText("Your " + player.nippleDescript(0) + "s grow hard and sensitive, becoming much more noticable inside your " + player.armorName + ".  It appears your nipples are have grown larger to match.", false);
				}
			}
			outputText("\n\n", false);
			postOmnibusBoon();
		}
		private function chooseDick():void {
			spriteSelect(16);
			clearOutput();
			//No dick?  Grow one!
			if (player.cocks.length == 0) {
				outputText("A sudden pressure builds in your groin.  You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ", false);
				if (player.cor < 80) outputText("In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.", false);
				else outputText("Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...", false);
				player.createCock();
				player.cocks[0].cockType = CockTypesEnum.DEMON;
				player.cocks[0].cockLength = 10;
				player.cocks[0].cockThickness = 2;
				player.genderCheck();
			}
			if (player.cocks.length == 1) {
				if (player.countCocksOfType(CockTypesEnum.DEMON) < 1) {
					outputText("You smile, watching your " + player.cockDescript(0) + " grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed tool, a wave of burning desire passes through you.  ", false);
					if (player.cor < 80) outputText("You watch in horror as the skin of your " + player.cockDescript(0) + " turns shiny and purplish-black.  ", false);
					else outputText("Curious, you watch the skin of your " + player.cockDescript(0) + " turn a shiny-dark purple.  ", false);
					player.cocks[0].cockLength += 3 + rand(5);
					player.cocks[0].thickenCock(2);
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					if (player.cor < 50) outputText("Corrupt nodules begin to spring up over its entire length.  <b>Your penis is transforming into a " + player.cockDescript(0) + "!<\b>  The new nubs wriggle about as they sprout over every inch of surface, save for the head.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crown of your " + player.cockDescript(0) + ", seemingly completing its transformation, until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes!  ", false);
					else outputText("As you watch expectantly, tiny wriggling nodules begin to erupt from the purplish skin, like those magnificent cocks you saw on demons!  <b>Your penis is transforming into a " + player.cockDescript(0) + "!<\b>  You pant and moan in happiness as it lengthens one last time.  As you stroke all of its amazing length with both hands, the excitement of possessing such a beautiful pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your " + player.cockDescript(0) + "'s crown, you notice that the squirts getting out of your cock-slit are not completely white and gradually become darker, the last drops being pitch-black! Your new " + player.cockDescript(0) + " pulsates darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke the huge, dark, bumpy shaft, that if this feels as good as this looks, it doesn't really matter.  ", false);
				}
				else {
					outputText("Your " + player.cockDescript(0) + " leaps forwards, taking to the dark magic with ease.  Inch after inch of new length erupts from your groin as your " + player.cockDescript(0) + " gets longer and thicker.  It pulsates, as if promising dark pleasure as it settles into its new enhanced size.", false);
					player.cocks[0].cockLength += 6 + rand(10);
					player.cocks[0].thickenCock(3);				
				}
			}
			if (player.cocks.length > 1) {
				//Already has demoncocks
				if (player.countCocksOfType(CockTypesEnum.DEMON) == player.cockTotal()) {
					outputText("Your " + player.multiCockDescriptLight() + " leap forwards, taking to the dark magic with ease.  Inch after inch of new length erupts from your groin as your " + player.multiCockDescriptLight() + " get longer and thicker.  They pulsate, as if promising dark pleasure as they settle into their new enhanced size.", false);
					temp = player.cocks.length;
					while(temp > 0) {
						temp--;
						player.cocks[temp].cockLength += 6 + rand(10);
						player.cocks[temp].thickenCock(3);	
					}
				}
				//Not yet full of demoncocks...
				else {
					outputText("You smile, watching your " + player.multiCockDescriptLight() + " grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed pleasure tools, a wave of burning desire passes through you.  You watch", false);
					if (player.cor < 80) outputText(" in horror", false);
					else outputText(" curiously", false);			
					outputText(" as the skin of your " + player.multiCockDescriptLight() + " turns shiny and purplish-black.  Corrupt nodules begin to spring up over the entire length of each dick.  ", false);
					temp = player.cocks.length;
					while(temp > 0) {
						temp--;
						player.cocks[temp].cockLength += 3 + rand(5);
						player.cocks[temp].thickenCock(2);
						player.cocks[temp].cockType = CockTypesEnum.DEMON;
					}
					if (player.cor < 50) outputText("<b>Your dicks are transforming into " + player.multiCockDescriptLight() + "!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the heads.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crowns of your " + player.multiCockDescriptLight() + ", seemingly completing its transformation, until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes!  ", false);
					else outputText("<b>Your dicks are transforming into " + player.multiCockDescriptLight() + "!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the heads.  You pant and moan in happiness as they lengthen one last time.  As you stroke all of their amazing length with both hands, the excitement of possessing such a magnificent pleasure tool makes you cum. You lick your fingers eagerly, tasting your new cum, while a last ring of nodules forms around the crowns of your beautiful " + player.multiCockDescriptLight() + ".   Your new " + player.multiCockDescriptLight() + " pulsate darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke a huge, dark, bumpy shaft, that if they feel as good as they look, it doesn't really matter.  ", false);
				}
			}
			postOmnibusBoon();
			return;
		}
		private function normalFace():void {
			spriteSelect(16);
			clearOutput();
			if (player.horns > 0 || player.antennae > ANTENNAE_NONE) {
				outputText("Your forehead itches intensely.  You cannot help but stratch madly at it.  ", false);
				if (player.horns > 0) {
					outputText("Your horns fall off, landing on the floor with a heavy thud.  ", false);
					player.horns = 0;
					player.hornType = HORNS_NONE;
				}
				if (player.antennae > ANTENNAE_NONE) {
					outputText("Antennae pop free, and float lightly down towards the floor.  ", false);
					player.antennae = ANTENNAE_NONE;
				}
			}
			//EARS
			if (player.earType != EARS_HUMAN) {
				outputText("Pain erupts from both sides of your head as your ears reform and move, returning to look like your old human ears!  ", false);
				player.earType = EARS_HUMAN;
			}
			//Face
			if (player.faceType != FACE_HUMAN) {
				outputText("Your facial structure rearranges itself into a normal human visage, exactly like yours was before you came to this horrid place.", false);
				player.faceType = FACE_HUMAN;
			}
			postOmnibusBoon();
		}
		private function normalChest():void {
			spriteSelect(16);
			clearOutput();
			temp = 0;
			if (player.breastRows.length > 1) {
				player.removeBreastRow(1,player.breastRows.length-1);
				outputText("Your chest tingles and begins to feel lighter.  You hastily pull open your " + player.armorName + " and realize you only have " + player.allBreastsDescript() + " now!  ", false);
				if (player.nippleLength > 1) {
					outputText("Your nipples shrink down to a more normal size.  ", false);
					player.nippleLength = .75;
				}
				temp++;
			}
			//Size!
			if (player.breastRows[0].breastRating > 7) {
				outputText("The weighty flesh that constantly hangs from your chest gets lighter and lighter, vanishing rapidly.  ", false);
				player.breastRows[0].breastRating = 3 + rand(5);
				outputText("You now have " + player.allBreastsDescript() + ".  ", false);
				temp++;
			}
			//Fix nips
			if (player.nippleLength > 1) {
				outputText("Your nipples shrink down to a more normal size.  ", false);
				player.nippleLength = .75;
				temp++;
			}
			if (player.hasFuckableNipples()) {
				outputText("The vagina-like openings in your nipples close, sealing themselves shut.  ", false);
				player.breastRows[0].fuckable = false;
				temp++;
			}
			if (player.skinType != SKIN_TYPE_PLAIN) {
				outputText("The skin on your body itches intensely as it sheds it's " + player.skinDesc + ", revealing " + player.skinTone + " skin.  ", false);
				player.skinDesc = "skin";
				player.skinType = SKIN_TYPE_PLAIN;
				temp++;
			}
			//Nothing changed
			if (temp == 0) {
				outputText("You tingle briefly but feel no obvious change.  Your chest is already fairly human.", false);
			}
			postOmnibusBoon();
		}
		private function normalGroin():void {
			spriteSelect(16);
			//Temp used to track changes
			temp = 0;
			outputText("You feel a strange shivering sensation pass through you.  ", true);
			//Remove multiple.
			if (player.cocks.length > 1) {
				outputText("Your " + player.multiCockDescriptLight() + " shiver and retract back towards your body.  When the process finishes you are left with only your " + player.cockDescript(0) + ".  ", false);
				player.removeCock(1,player.cocks.length-1);
				player.genderCheck();
				temp++;
			}
			//Super long nerf
			if (player.hasCock()) {
				if (player.cocks[0].cockLength > 12) {
					outputText("A tingling sensation worms through your " + player.cockDescript(0) + " as it shrinks down to a more modest eleven inches.  ", false);
					player.cocks[0].cockLength = 11;
					temp++;
				}
				//Super thick nerf
				if (player.cocks[0].cockThickness > 2) {
					outputText("Your " + player.cockDescript(0) + "'s obscene thickness withers down to roughly two inches of girth.  ", false);
					player.cocks[0].cockThickness = 2;
					temp++;
				}
				//Humanitize
				if (player.cocks[0].cockType != CockTypesEnum.HUMAN && player.cocks[0].cockType != CockTypesEnum.DEMON) {
					outputText("The inhuman appearance of your " + player.cockDescript(0) + " shifts, the flesh rearranging itself into a more human configuration.  After a few seconds you have a very normal looking penis.  ", false);
					player.cocks[0].cockType = CockTypesEnum.HUMAN;
					temp++;
				}
				//If demon cocked....
				if (player.cocks[0].cockType == CockTypesEnum.DEMON) {
					outputText("Your " + player.cockDescript(0) + " tingles as the bumps begin to fade.  After a moment the flesh darkens, and every single nodule reappears.  <b>Your corrupt penis resisted the magic!</b>  ", false);
					temp++;
				}
			}
			//Balls shrink
			if (player.ballSize > 5) {
				temp++;
				outputText("The " + player.ballsDescriptLight() + " that constantly pull so heavily on your groin tingle and shrink down to a more managable size.  ", false);
				player.ballSize = 2 + rand(3);
			}
			if (temp > 0) outputText("\n\n", false);
			//Vajajay
			if (player.vaginas.length > 0) {
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) {
					outputText("The constant fluids leaking from your " + player.vaginaDescript(0) + " slow down, then stop.  ", false);
					player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
					temp++;
				}		
			}
			//Being genderless isn't normal too...
			if (player.gender == GENDER_NONE) {
				if (player.balls > 0 || player.femininity < 35 || rand(3) == 0) {
					player.createCock();
					player.cocks[0].cockType = CockTypesEnum.DEMON;
					player.cocks[0].cockLength = 10;
					player.cocks[0].cockThickness = 2;
					outputText("A sudden pressure builds in your groin.  You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ", false);
					if (player.cor < 80) outputText("In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.", false);
					else outputText("Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...", false);
					if (player.balls == 0) {
						player.balls = 2;
						outputText("\n\nIncredible pain scythes through your crotch, doubling you over.  In shock, you barely register the sight before your eyes: <b>You have balls!</b>", false);
						player.ballSize = 1;    
					}
				}
				else {
					player.createVagina();
					outputText("An itching starts in your crotch and spreads vertically.  You reach down and discover an opening.  You have grown a <b>new " + player.vaginaDescript(0) + "</b>!", false);
				}
				temp++;
				outputText("\n\n", false);
				player.genderCheck();
			}
			//Reduce excessive anal wetness
			if (player.ass.analWetness >= ANAL_WETNESS_SLIMY) { 
				outputText("The constant fluids leaking from your " + player.assDescript() + " slow down, then stop.  ", false);
				player.ass.analWetness = ANAL_WETNESS_MOIST;
				temp++;
			}

			//Nothing changed
			if (temp == 0) {
				outputText("You tingle briefly but feel no obvious change.  Your crotch isn't really in need of becoming more human.", false);
			}
			postOmnibusBoon();
		}
		private function normalLegs():void {
			spriteSelect(16);
			clearOutput();
			if (player.lowerBody == LOWER_BODY_TYPE_HUMAN) outputText("You feel as if you should slap yourself for stupidy.  Your legs are already normal!  You flush hotly as the corrupt magics wash over you, changing nothing.", false);
			else outputText("You collapse as your " + player.legs() + " are unable to support you.  The sounds of bones breaking and reshaping fills the room, but oddly you feel no pain, only mild arousal.  You blink your eyes and sigh, and when you look down again <b>you have normal human legs</b>!", false);
			player.lowerBody = LOWER_BODY_TYPE_HUMAN;
			player.legCount = 2;
			if (player.tailType > TAIL_TYPE_NONE) {
				outputText("  A moment later, your feel something detach from above your backside.  <b>You no longer have a tail!</b>", false);
				player.tailType = TAIL_TYPE_NONE;
				player.tailVenom = 0;
				player.tailRecharge = 5;
			}
			postOmnibusBoon();
		}
		
		private function postOmnibusBoon(willing:Boolean = false):void {
			if (willing) {
				clearOutput();
				outputText("The omnibus disappeared while you were examining the changes.  You guess you did get what you wanted.  You blush and smile, feeling very horny.  You decide to use the privacy of the office to relieve the tension you've been building up since you arrived.\n\nYou masturbate quickly and efficiently, eager to calm down and resume your exploration.  In no time at all an orgasm crashes through your body.  Stretching and standing up, you find yourself still aroused.\n\nYou've got exactly what you were asking for - <b>the demoness' magic is keeping you from ever being totally satisfied!</b>\n(Perk Gained - Omnibus' Gift - Minimum lust has been increased!)");
			}
			else
				outputText("\n\nThe omnibus disappeared while you were examining the changes.  You guess you did get what you wanted.  You blush and smile, still feeling very horny.  You decide to use the privacy of the office to relieve the tension you've been building up since you arrived.\n\nYou masturbate quickly and efficiently, eager to calm down and resume your exploration.  In no time at all an orgasm crashes through your body.  Stretching and standing up, you find yourself still aroused.\n\nYou slap your forehead as realization washes over you - <b>the demoness' magic is keeping you from ever being totally satisfied!</b>\n(Perk Gained - Omnibus' Gift - Minimum lust has been increased!)");
			player.createPerk(PerkLib.OmnibusGift,0,0,0,0);
			player.orgasm();
			dynStats("cor", 2);
			combat.cleanupAfterCombat();
			//doNext(roomForemanOffice);
		}
		
		private function letGoOmnibus():void {
			spriteSelect(16);
			outputText("You refuse to fall for her ploy, and decide not to take her up on her offer.  However, being that she is so thoroughly defeated, you allow her to escape, promising her far worse should she ever oppose you in the future.\n\n\"<i>Thank you, merciful hero!</i>\" she says and she sprints out the door.  Wings unfurl from her back and she takes flight, disappearing out a skylight above the main factory floor.", true);
			combat.cleanupAfterCombat();
			//doNext(roomForemanOffice);
		}
		private function killOmnibus():void {
			spriteSelect(16);
			outputText("You step forwards and grab her by the head.  With an abrupt twist you snap her neck, ending at least one small part of the demonic threat.", true);
			flags[kFLAGS.D1_OMNIBUS_KILLED] = 1;
			combat.cleanupAfterCombat();
			//doNext(roomForemanOffice);
		}
		
		//Factory finale
		private function factoryShutdown():void {
			outputText("You resolve to shut down the factory, then destroy the controls.  You spend a few moments making sure you aren't about to do something disastrous.  A few deep breaths calm your nerves, letting you focus on pressing the correct buttons.  The constant thrumming of the machinery slowly dies down, closely followed by a chorus of disappointed moans.  You step over to the window and watch as the captives come out of their drug induced sex-comas.  A great deal of them gather up and leave, though you are unsure what their destination is.  A few seem to be gathering back around the equipment, and puzzling out how to operate it.  Maybe they liked being here...", true); 
			outputText("\n\nYou remember to destroy the controls. You pick up a nearby large wrench and repeatedly smash the controls. Finally, you throw the wrench at the exposed spinning gears, causing it to jam and dislodge.", false)
			flags[kFLAGS.FACTORY_SHUTDOWN] = 1;
			doNext(roomControlRoom);
		}
		
		private function factoryOverload():void {
			outputText("You resolve to shut down the factory by overloading the storage tanks, rendering much of the equipment inoperable and difficult to repair.  With a quick twist of a knob, you override the pressure vents for the storage tanks.  Within minutes, you hear the sounds of popping rivets and straining pumps.  You look out over the factory floor and watch as many of the pipes fracture, dripping seed over the moaning captives.  Smoke rises from pumps as they short out and overheat.  The entire building shudders as a massive blast echoes from somewhere to the west.  A high pitched whine fills the building as the last motors shriek and die.  The captives slowly start to come to as the flood of drugs and artificial pleasure come to a stop.  Many break down and cry, others begin unhooking themselves and exploring their surroundings.  You watch with interest as many of them rally together and make for an exit.   The remaining survivors begin scavenging parts from the machinery and puzzling out how to use it.  Perhaps they liked it here.", true);
			outputText("\n\nYou remember to destroy the controls. You pick up a nearby large wrench and repeatedly smash the controls. Finally, you throw the wrench at the exposed spinning gears, causing it to jam and dislodge.", false)
			flags[kFLAGS.FACTORY_SHUTDOWN] = 2;
			doNext(roomControlRoom);
		}
		
		//BAD ENDS
		private function doBadEndGeneric():void {
			clearOutput();
			outputText("You crack your sleep-fuzzed eyes, blinking at the sudden light as you try to get your bearings and remember where you are.  A nearby voice is moaning like a bitch in heat, or a drunk slut.  You giggle a bit at the thought as you work at focusing your eyes.  You feel warm and happy, particularly in your chest and groin.  The cobwebs of sleep clear from your mind with agonizing slowness, but you find it hard to worry about with how warm and wonderful you feel.  It's almost like hot wet mouths are latched onto your crotch and breasts, licking and sucking in perfect rhythm.  ", false);
			if (player.cocks.length == 0 || player.biggestTitSize() <= 1) {
				outputText("A small inner voice pipes up to remind you that you don't have ", false);
				if (player.cocks.length == 0) {
					outputText("anything in your groin to suck on", false);
					if (player.biggestTitSize() <= 1) outputText(" or ", false);
				}
				if (player.biggestTitSize() <= 1) outputText("any adornments on your chest", false);
				outputText(".  That voice trails off as that feeling of perfect pleasure and rightness sweeps it away with the last remnants of sleep.\n\n", false);
			}
			else outputText("A small inner voice tries to warn you of something, only to be swept away in the feelings of perfect pleasure and rightness that wash away the last remnants of your sleep.\n\n", false);
			outputText("You realize that the moaning voice is your own, and find that the thought just turns you on more.\n\n", false);
			outputText("'<i>You're such a horny slut!</i>' echoes a voice in your head.  You want to nod and smile, but are prevented by something.  You realize you're strapped into some kind of chair and harness so securely that you can't even move.  Tiny soothing fingers massage your temples, rubbing away the fears that moments ago threatened to interrupt your pleasure.  You can see a ", false);
			if (player.totalBreasts() == 2) outputText("pair of ", false);
			else outputText("multitude of ", false);
			outputText(" clear hoses coming away from your cow-like chest udders.  ", false);
			if (player.biggestLactation() <= 1.5) outputText("Creamy white milk is flowing in a steady stream up the tubes and away from you.  ", false);
			else outputText("The hoses bulge obscenely as they struggle to keep up with the torrents of creamy-white milk you're producing.  ", false);  
			outputText("Even more wanton moans erupt from your disobedient lips now that you know what's going on.  You're not just a horny slut.  You're a horny cow-slut who's getting off on having her tits pumped.  The massage you're getting feels so good once you realize that.\n\n", false); 
			outputText("A snap echoes through the pumping room, nearly drowned out by the moans of the other milk-sluts around you.  You look around as you realize the band to restrain your head has been unlatched.  You take advantage of your newfound freedom and look around.  Rows and rows of other girls are there, just like you.  Almost all of them have bigger tits and fuller milk-tubes.  In addition, they all have enormous members that would drag on the floor were it not for the gigantic tubes encapsulating each and every one.  ", false);
			outputText("The girl next to you squirms and cums, wriggling inside her harness as waves of sticky goop are pumped down her cock-tube into a floor-socket.  She just keeps going and going, making you wonder how she can make so much of the stuff.  As the sight excites you, the pleasure in your own crotch redoubles.  Looking down thanks to your newfound freedom, you see your own giant encapsulated member; though not as large as your neighbor's, it still looks and feels wonderful.\n\n", false); 
			outputText("The lining of the tube squeezes and massages your trapped prick expertly, even as those hands continue to work on your mind.  Some part of you suspects that your thoughts are being manipulated, but the carnal pleasure you are experiencing is so amazing that you have no intention of resisting. If being a cumslut for your sexy demonic masters is what it takes, so be it. Cramming a massive demon-cock in your throat, getting a few others up your holes to keep you pregnant all the time, and being their busty hermaphrodite breeding tool would be your joy and privilege.  ", false);
			if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
				outputText("As if reading your thoughts, the hands stop massaging, and their owner snaps their fingers. You see Marble step in front of you, wearing an odd set of pink panties with a dick-like protrusion sticking out the front of them.  At the command of the figure behind you, she presents the panty-cock to you.  Happy to be of service, you spread your jaws and engulf as much of the great penis-like thing as you can, while the figure behind you moves around and takes Marble in the ass.  You continue to suck on the pink flesh until you feel it pour some kind of unholy load into your stomach.  Gurgling in pleasure, you start cumming yourself, all the while appeasing your demonic masters by servicing your once lover.\n\n", false);
			}
			else outputText("As if reading your thoughts, the hands stop massaging, and their owner comes in front of you, presenting you with a meaty, throbbing cock.  Happy to be of service, you spread your jaws and engulf as much of the great penis as you can, until you feel it pouring his unholy load into your stomach.  Gurgling in pleasure, you start cumming yourself, all the while attending to one or more of your demonic masters.\n\n", false);
			
			
			outputText("<b>This kind of treatment continues for a few days, until sucking, fucking and getting fucked is the only thing you desire. As your mind is now broken, injections are no longer necessary to keep you in a perfect pleasure state. After a month, they even untie you, since you are now their complete cum-puppet, eager only to please and obey.</b>", false);
			//The style on this part wasn't up to par with the rest, so I rewrote some of it, while keeping the meaning
			getGame().gameOver();
		}
		
		public function doBadEndSuccubusPart1():void {
			spriteSelect(55);
			//Arousal
			outputText("In no time flat your blood begins to burn hot with the fires of unnatural lust.  ", true);
			//Tits – regular
			if (player.biggestLactation() < 1) outputText("Your " + player.nippleDescript(0)  + "s begin prodding painfully against your " + player.armorName + ", every touch serving to make them harder and more erect.  ", false);
			//Tits – lactating
			if (player.biggestLactation() >= 1 && player.biggestLactation() < 3) outputText("Your " + player.nippleDescript(0) + "s get painfully hard as you feel milk begin backing up inside your " + player.allBreastsDescript() + ".   The succubus glances down mischieviously as her hands begin to grope you through your " + player.armorName + ", squeezing out a few drops of milk.  ", false);
			//Tits – megalactating
			if (player.biggestLactation() >= 3) outputText("Your " + player.nippleDescript(0) + "s get painfully hard as milk begins drooling down your over-productive chest, making your " + player.armorName + " slide across your leaky milk-spouts in an agonizingly pleasurable way.  ", false); 
			//Cock – single
			if (player.cocks.length == 1) {
				if (player.cockArea(0) < 30) outputText("Swooning from sudden blood loss, you struggle to maintain the kiss as your body takes your " + player.cockDescript(0) + " to full hardness in seconds.  ", false);
				//Cock – single big
				if (player.cockArea(0) >= 30 && player.cockArea(0) < 100) outputText("Nearly blacking out, you struggle to stay awake as your body shifts your blood to your disproportionate " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ".  ", false);
				//Cock -megahuge
				if (player.cockArea(0) >= 100) outputText("As you struggle not to lose consciousness, you realize your over-aroused body had pumped most of your blood to your over-sized " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", which now droops to the floor, pulsing hotly.  ", false);
			}
			//DO MULTIZ
			if (player.cocks.length > 1) outputText("The feeling of light-headedness nearly robs you of consciousness as your " + player.multiCockDescript() + " fill with blood, pulsating with arousal as they reach full size.  ", false);
			//Vagooooz
			if (player.vaginas.length > 0) {
				//'uge clit
				if (player.clitLength >= 4.5) outputText("Popping from between your thighs, your " + player.clitDescript() + " responds to the sheer hotness of the situation by making itself known.   You squeeze your legs tightly together, hungry for additional sensation.  ", false);
				//big clit
				if (player.clitLength > 1 && player.clitLength < 4.5) outputText("A wave of pleasure erupts from between your legs as your " + player.clitDescript() + " pops free.    You squeeze your legs tightly together, hungry for the additional sensations.  ", false);
				//slick
				if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("Squishing wetly, your bottoms become soggy with the flood of fluids leaking from your " + player.vaginaDescript(0) + ".   Your legs spread apart on their own, begging for any kind of intrusion.  ", false);
				//normal
				else outputText("Groaning softly, you feel yourself getting wetter and wetter with arousal.  You wish your sticky bottoms were off so you could let something into your " + player.vaginaDescript(0) + ".  ", false); 
			}
			outputText("\n\n", false);
			//New PG
			outputText("No longer caring about modesty, etiquette, or even your own safety, you squirm against your bindings, lewdly putting on a display for your captor as you suck her tongue as if your life depended on it.   She breaks the kiss with a smile, \"<i>I told you I'd make sure it was pleasurable.  Now you sit tight while I get you hooked up, and we'll have you cumming what's left of your brains out in no time,</i>\" she promises.\n\n", false);
			outputText("The succubus pushes a button on the wall, and a number of strange looking suction tubes and hoses drop down from above you.   Moving with practiced efficiency, she hooks a ", false);
			if (player.breastRows.length == 1) outputText("pair of", false);
			else outputText("number of", false);
			outputText(" hoses to your breasts, ", false);
			if (player.cocks.length == 0) {
				if (player.vaginas.length > 0) outputText("and a vacuum pump to your clit.  ", false);
				else {
					outputText("and another vacuum pump to your bare groin.  In seconds a wet fleshy growth erupts.  You have grown a cock!  ", false);
					player.createCock();
				}
			}
			else {
				if (player.vaginas.length > 0) outputText("a vacuum pump to your clit, and a pump many times bigger than your " + player.cockDescript(0) + " to it.  ", false);
				else outputText("and a pump many times bigger than your " + player.cockDescript(0) + " to it.  ", false);
			}
			outputText("At first there is only a gentle suction, you assume in order to keep them in place.  Unfinished, your captor places something large and hollow against your backdoor", false);
			if (player.vaginas.length == 0) outputText(".", false);
			else outputText(" and an ever larger dildo against your " + player.vaginaDescript(0) + ".  It seems to pulse and wiggle with a life of its own rubbing the bumps of it's lumpy head against your lips.", false);
			outputText("  You swoon as you hear the solid click of a button being pushed, and all at once all devices attached to you leap to life.", false);
			doNext(doBadEndSuccubusPart2);
		}
		private function doBadEndSuccubusPart2():void {
			spriteSelect(55);
			outputText("The beautiful seductress that bound you giggles and says, \"<i>Oh it only gets better baby,</i>\" as she pushes another button.  You see a number of needles lower from the equipment above.  Two pause at chest height.  Faded parchment labels on the tubes mark them as \"Gro+\".  You spot the same markings on at least some the hoses gathering around your groin.  A few are marked with different labels, but you cannot make out the demonic script.  As one, the hoses rear back, then plunge forward, burying themselves into your supple flesh and injecting their drugged payload into your body.  It hurts at first, but the drugs fog your mind, blocking the pain with pulsing waves of desire.   You begin cumming as your body erupts with artificial pleasure.\n\n", true); 
			//Nipples
			outputText("The suction pulls squirt after squirt of milk from your breasts as your " + player.allBreastsDescript() + " start to grow, swelling heavier as they enlarge to produce more milk.  You squeal with delight as your nipples turn black, tainted by corruptive chemicals that are slowly dripped into you.  ", false);
			//Dick  
			if (player.cocks.length > 0) {
				outputText("The vacuum-pump on your cock noisily sucks down all your spoo, ", false);
				//High cum variant
				if (player.cumQ() > 300) outputText("struggling with the amount you put off.  Grinning, the succubus reaches over and flips a lever.  You feel the suction increase as the machine is turned up to accommodate your altered physique.  ", false);
				//else
				else outputText("the suction and drugs make it so easy to just keep cumming and cumming.  ", false);
				//either or:
				outputText("Dimly, you feel a needle lodged in your taint, pumping your prostate full of something.  Your " + player.cockDescript(0) + " begins growing mid-orgasm, the skin turning a deep purple even as small nodule-like bumps form all over it, rapidly becoming a bloated parody of it's demonic counterparts.  ", false);
			}
			//Puss Orgasmz
			if (player.vaginas.length > 0) outputText("Clenching tightly, your " + player.vaginaDescript(0) + " squeezes tightly on it's intruder as it's repeatedly violated by the machines.  ", false);
			//End
			outputText("\n\nThe world around you disappears, leaving you alone with the drug-enhanced sensations assaulting your body.  In truth, you don't want it to end.  You find yourself wishing it would never end, and no doubt the equipment you're hooked in to will see to that.\n\n", false);
			if (player.statusEffectv3(StatusEffects.Marble) == 1) {
				outputText("Later on, you are briefly pulled out of your reverie by a familiar warm fluid flowing down your throat.  You come to your senses and see Marble looking down at you with an odd expression on her face.  ", false);
				outputText("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
			}
			else if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
				outputText("You are given a brief moment of clarity as you see Marble standing in front of you.  ", false);
				outputText("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
			}
			else outputText("Later on, in a moment of clarity, you look around and realize you aren't alone.  ", false);		
			outputText("In rows alongside you are a large number of other captives, every single one endowed with freakishly sized breasts, and nearly all gifted with throbbing demonic dicks.  Some small analytical part of you notes that the farther down the line they are, the older and larger they have become.   You look down and see your own massive tits, shiny tainted nipples still pumping out streams of milk.  The huge throbbing demon-cock between your legs begins to get hard as the machines crank back up, filling you full of happy horniness.", false);
			if (player.statusEffectv3(StatusEffects.Marble) == 1 || player.findStatusEffect(StatusEffects.CampMarble) >= 0) outputText("  With Marble here too, you'll be around for a long time.", false);
			getGame().gameOver();
		}
		
		private function doBadEndOmnibusPart1():void {
			if (player.HP < 1) outputText("You stagger into the desk, clutching tightly just to stay upright.  ", false);
			else outputText("Forgetting about the fight, you lean on the desk and slide your free hand under your " + player.armorName + ", seeking any pleasure you can get.  ", false);
			outputText("Sensing victory, the demoness sidles up next to you and pushes you into a chair.  Incapable of resisting, all you can do is watch as she opens your " + player.armorName+ " for easier access.  She steps back and admires her handiwork as she gives you a thorough looking over.\n\n", false);  
			outputText("\"<i>I have just the thing for a ", false);
			if (player.gender <= 1) outputText("man", false);
			else outputText("woman", false);
			outputText(" such as you.  I've been crossbreeding the parasites that developed in the deep jungle, trying to create the PERFECT slave-maker.  You get to be my first test subject,</i>\" she says.\n\n", false);
			outputText(" She sees the look of fear creeping into your eyes and pats you comfortingly, \"<i>Awww don't worry. It'll feel REALLY good.  If anything you should feel honored to be assisting an Omnibus in her experiments.</i>\"\n\n", false);
			outputText(" She opens one of the desk drawers, and searches briefly before her eyes light up with recognition.  \"<i>Here we are,</i>\" she says as she pulls something free...", false);
			doNext(doBadEndOmnibusPart2);
		}
		
		private function doBadEndOmnibusPart2():void {
			clearOutput();
			//(Multi dicks)
			if (player.cocks.length > 1) {
				outputText("In her hand is a mass of shining green material.  She turns to face you, bringing it closer and letting you see the lights shift and change on its luminescent surface.\n\n", false);
				outputText("\"<i>For someone as... different as you, we will have to try this creature.  I've bred it from a mixture of plant-tentacles, dazzle-weed, and what we've taken to calling pussy plants,</i>\" she mentions, her hands working to open the mass on the table.  The interior surface is a mass of slimy undulating protrusions that wriggle feverishly as they are exposed to the air.  She gathers up the thing in her arms while continuing to speak to you, \"<i>You see, my plant will encapsulate your members tightly, wrapping them in sticky wetness.  Its fluids are a perfect blend of aphrodisiacs, lubricants, and will-sapping narcotics.  You'll love it.</i>\"\n\n", false);
				outputText("You make a desperate attempt to escape her chair, but your body fails to do much more than squirm in place.  She drops the creature squarely into your crotch and hops up onto her desk to watch.  Thousands of tiny wet nodules immediately begin massaging your " + player.multiCockDescriptLight(), false);
				if (player.balls > 0) outputText(" and " + player.ballsDescript(), false);
				outputText(".  You groan as the pleasure washes over you like a wave.  Your squirming stops as your hips begin twitching into the air, as if begging for even more stimulation.  It's not fair how good this feels... you can't help it, it's just too hard to fight.\n\n", false);
				outputText("You watch with detached fascination as each of your " + player.multiCockDescript() + " is wrapped tightly in shiny green material.  The shape of each penis is still clearly defined under the pulsating green stuff, though you can see it shifting and rippling over your lengths as it pleasures you.  It almost looks like some kind of kinky bondage-toy.  Aware of your attentions, the green stuff squeezes you tightly and begins flashing beautiful bioluminescent color patterns across its surface that scatter your thoughts as you watch.  You blink a few times as the green mass rolls more of itself out, curling over your ", false);
				if (player.balls > 0) {
					outputText("balls", false);
					if (player.vaginas.length > 0) outputText(" and " + player.vaginaDescript(0), false);
				}
				else if (player.vaginas.length > 0) outputText(player.vaginaDescript(0), false);
				else outputText("taint", false);
				outputText(", sliding up your abdomen, and oozing down over your hips.  As it spreads the colors fill more and more of your head, clearing away your thoughts of resistance.\n\n", false);
				outputText("A soothing female voice talks to you from somewhere, \"<i>Did I mention it's specifically tuned to ensnare the conscious mind with it's pretty colors?  I must have forgot.  Well, I see you've discovered it on your own.  The colors are just so perfect for opening your mind to me, aren't they?  They just chase away your thoughts and let my words slip deep into your subconscious.  I bet it feels nice to just focus on the colors and let my pet tease your cocks, doesn't it?</i>\"\n\n", false);
				outputText("You nod without any awareness of the act.\n\nThe voice laughs and continues while the creature reaches around your " + player.hipDescript() + " and slides a feeler between your cheeks, completing the tight loop around your groin, \"<i>That's good.  You want to let the creature cover as much of you as it wants.  Being sex-food for a symbiotic plant is arousing beyond measure.</i>\"  You feel the creature licking at your " + player.assholeDescript() + " until it relaxes, and then slides something inside.  A warm wetness spreads through your bowels as something begins caressing your prostate from inside you.\n\n", false);
				outputText("Overloaded with pleasure, you feel your " + player.multiCockDescriptLight() + " pulse and cum, creating translucent green cum balloons the size of ", false);
				if (player.cumQ() < 50) outputText("apples ", false);
				if (player.cumQ() >= 50 && player.cumQ() < 300) outputText("cantaloupes ", false);
				if (player.cumQ() >= 300) outputText("watermelons ", false);
				outputText("at the end of each of your dicks.  The creature's flashing intensifies while your hips quake uncontrollably, pumping the last of your load feeds into the wonderful plant.  The light-show grows brighter, totally emptying any remaining stray thoughts and leaving you feeling wonderfully open.\n\n", false);
				outputText("\"<i>Being used for your cum is great,</i>\" says the voice and you agree, it is great.\n\n", false);
				outputText("\"<i>Your greatest fetish is allowing demonic creatures to feed on your cum,</i>\" she says, and it feels so right.  Your cum is meant for demons and plants to feast on.  Just the thought makes you want to orgasm again.\n\n", false);
				outputText("\"<i>Since you provide food-source, that must make you livestock.  You like being livestock.  Livestock don't have to think.  Livestock follow orders.  Best of all, as livestock you can live your favorite fetish of being milked of all your cum, every hour of every day,</i>\" the voice says, filling your mind with new thoughts.  Of course it's right, you can just let a demon or tentacle plant milk you and do all the hard stuff, like thinking.  All you have to do is cum.  The thought makes you shiver as the plant-suit absorbs the encapsulated bubbles of jizz.  The dazzling lights grow even brighter as it takes in the nutrients.\n\n", false);
				outputText("*FLASH* \"<i>You want to cum for the plant.</i>\"\n\n", false);
				outputText("Tendrils of plant crawl up your belly, coating you in slime as they massage every inch of you.\n\n", false);
				outputText("*FLASH* \"<i>You need to cum for the plant.</i>\"\n\n", false);
				if (player.breastRows.length == 1) outputText("They reach the lower curve of your breasts.\n\n", false);
				if (player.breastRows.length > 1) outputText("They slide over your lowest pair of breasts, encapsulating them in wriggling tightness.\n\n", false);
				outputText("*FLASH* \"<i>You love cumming for anything and anyone.</i>\"\n\n", false);
				if (player.breastRows.length == 3) outputText("Your middle breasts tingle with absolute pleasure as they too become engulfed in tightness.\n\n", false);
				if (player.breastRows.length == 2) outputText("You groan as the plant grows up the summit of your top breasts, coating the bottom half of your aureola.\n\n", false);
				if (player.breastRows.length == 1) outputText("Your " + player.nippleDescript(0) + "s become hard as steel as the wave of slick pleasure washes over them.\n\n", false);  
				outputText("*FLASH* \"<i>You love being told to orgasm.</i>\"\n\n", false);
				if (player.breastRows.length == 1) outputText("The wriggling mass slides up the top-most parts of your breasts, narrowing into two tiny tendrils that loop around your neck.\n\n", false);
				if (player.breastRows.length >= 2) outputText("The wriggling mass climbs your top pair of breasts with ease, wrapping your diamond-hard nipples in slime and sensation.  It continues climbing upward, narrowing into two bands that loop around the back of your neck.\n\n", false);
				outputText("*FLASH* \"<i>To orgasm is to obey.  You love to orgasm.  You love to obey.  You love to obey my voice more than any other.  Obeying my voice gave you these orgasms.  Since you love to obey me, you must be my pet.</i>\"\n\n", false);
				outputText("Your mistress' OTHER pet wraps around your neck, forming a choker comprised of shifting green colors.  You smile as you realize it is done - you've become one of her pet cattle.  Your body is wrapped in an emerald sea of shifting pleasure, just like your mistress wanted.  If it weren't for the obvious bulges of your " + player.multiCockDescriptLight() + ", you'd look to be wearing an extraordinarily revealing one piece swim-suit.  The constant teasing at your crotch continues, and you stay rock-hard, even though you just came.  The idea of being milked to feed your new clothing just turns you on so much that you bet you're leaking constant streams of pre-cum for your new green master.\n\n", false);
				outputText("The flashing subsides, and your new thoughts rush into the void.  You immediately begin masturbating your encapsulated members as you seek to obey.  To orgasm is to obey.  To obey is to orgasm.  You discover that you can feel every touch through the skin of your 'clothing'.  You increase the tempo, knowing that your orgasm will be feeding the creature that now lives on you, fulfilling your deepest darkest desires.  You cum again, just as hard as before, inflating " + num2Text(player.cocks.length) + " shiny green balloons with the proof of your obedience.\n\n", false);
				
				if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
					outputText("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
					outputText("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first...\"\n\n", false);
					
				}
				else outputText("Your mistress looks down with approval and speaks, \"<i>Very good.  ", false);
				outputText("I want you to stay here and cum 'til morning.  My pet needs lots of nutrition to recharge, and I have plans for new ways to teach you to obey tomorrow.</i>\"\n\n", false);
				outputText("Happy to have such a wonderful task, you spend the next day being bathed in drugged aphrodisiacs, cumming over and over and over.  Every morning the creature flashes you into obedience while the voice teaches you more and more about how to think.  After a week you're the perfect pet.  By the end of your first month of servitude, any memories of your past life are gone.  You spend the rest of your days feeding your mistress and her pet, and helping her refine and breed her pets in order to teach others the way.", false);
				getGame().gameOver();
				return;
			}
			//Dick version
			if (player.cocks.length == 1) {
				outputText("In her hand is a squirming purplish mass.  It has a smooth outer surface, spotted with dark shades of iridescent purple. The opposite side is comprised of a smooth mucusy membrane covered with wriggling pink cilia.\n\n", false);
				outputText("She leans over you with a predatory smile, \"<i>This little guy is my favorite.  I've even given him a bit of 'field testing'.</i>\"  She gestures towards a small dripping orifice, explaining, \"<i>You see, once I put this on you, it'll open up niiice and wide.  It'll suck your nice little cock into its mouth and starting squeezing and massaging you with each of its tiny tentacles until you can't help but release all your ", false);
				if (player.cor < 33) outputText("sweet ", false);
				if (player.cor >= 66) outputText("tainted ", false);
				outputText("sexual energies deep into its gullet.  And that's just the start!</i>\"  Her hands let go of the squirming mass, dropping it squarely into your lap.\n\n", false);
				if (player.averageCockLength() < 15) outputText("With one swift motion, the beast engulfs your " + player.cockDescript(0) + " in its slimy maw.  ", false);
				else outputText("Distending obscenely, the beast starts engulfing your " + player.cockDescript(0) + " in its slimy maw, progressing along its entire length until you can no longer see your pleasure tool.  ", false);		
				outputText("The slimy tentacles waste no time, massaging you with mechanical precision.  You groan in helpless pleasure, growing to painful hardness within the squirming confines of the creature.  Three protrusions sprout from the creature's core, dripping with slime of their own, and covered on the inside with the same wriggling protrusions that now massage your trapped member.  Two curl around your " + player.hipDescript() + ", while the last one", false);
				if (player.balls > 0) outputText(" smothers your balls, entrapping them in sticky sensation as it continues across your taint between your butt-cheeks.  ", false);
				else outputText(" journeys over your taint before travelling between your butt-cheeks.  ", false);
				outputText("The three tendrils join together in the back, forming a seemless tiny purple triangle.  It really rides up high, tickling your " + player.assholeDescript() + " with constant teasing.  You're wearing an organic purple thong!\n\n", false);
				outputText("You try to endure, but the humiliation is too much for you to take.  The pleasure and shame push you past your limit.  You let out a squeal of mixed agony and delight as the proof of your pleasure boils out into the creature.  You pant and twitch, helpless to resist the strength of your orgasm as your jism fills the creature, distorting it visibly around your member.  Sighing, you relax as the assault winds down, the squirming tentacles relaxing noticeably as they work to digest their 'meal'.\n\n", false);
				outputText("\"<i>Enjoy yourself?  The best part is about to start,</i>\" she says with an evil glint in her eye.  You sit bolt upright as your living thong squirms and shifts, pressing something rigid against the ring of your " + player.assholeDescript() + ".  You reach down, trying to pull the creature off, but its outer covering is surprisingly hard, and seals almost perfectly against your " + player.skinDesc + ".  You look up with terror in your eyes, a pleading look painted across your face.\n\n", false);
				outputText("She cocks her head to the side with an inquisitive look and asks, \"<i>So it's found your back door I take it?</i>\"  You nod sheepishly, squealing as the rigid growth pushes through your sphincter, violating you completely.  She continues with a nonchalant tone, though her eyes seem to be drinking in the scene, \"<i>That thing you feel drilling into your ass?  It's a carefully evolved injection appendage.  Don't worry, once it settles in it won't move much.  It's just going to get nice and cozy with your prostate and a few major blood vessels.  Then it's going to reward you for cumming!</i>\"\n\n", false);
				outputText("You feel it burrow a little deeper, and then curve up.  It presses against something inside of you in a way that makes your " + player.cockDescript(0) + " twitch uncontrollably.  You're sure that if it weren't for the greedy tentacle-panties around your dick you would've seen a huge dollop of pre-cum squeeze out.  Filled with angst and worry as to what is to come, you ask, \"<i>Ummm, h-h-how is it going to reward me?</i>\"\n\n", false);
				outputText("She winks, petting the mottled surface of your purple-cock-prison as you feel a sensation of warm wetness in your backside.  At the same time you nearly jump as you feel a painful pinch in your prostate.  The demoness licks her lips and answers, \"<i>Well, it rewards you in two ways pet.  One:  It empties a specially designed cocktail of drugs directly into your bowels, where they'll be absorbed slowly into the body.</i>\"  As if on cue a gentle warmth spreads through your torso, radiating out into your limbs, and settling like calming mist in your head.  You relax utterly, enjoying the feeling in spite of your worries.\n\n", false);
				outputText("She coos, petting your still-hard member and the creature around it.  Miraculously you can feel both the touch of her silky fingers and the constant pleasurable squirming of the panties themselves.  You twitch your " + player.cockDescript(0) + " against her hand, giggling happily.\n\n", false);
				outputText("\"<i>That's right, it's a good reward isn't it?</i>\" she asks as she continues to fondle you, \"<i>those drugs are making you docile and extraordinarily suggestible.  For instance – every time I talk you can feel my hands caressing and fondling your member", false);
				if (player.balls > 0) outputText(" and teasing your balls", false);
				outputText(".  You see?  I'm not even touching you anymore and you're still twitching.  My my, what an obedient slave you're going to be.</i>\"\n\n", false);
				outputText("You pant and groan while she talks to you, still feeling the combined efforts of the panty-creature and your master's wonderful hands, \"<i>And I haven't even told you about the second part of your reward.  If you want me to tell you, you'll need to admit out loud what we both already know – that you're my obedient slave-toy.  Say it toy.</i>\"\n\n", false);
				outputText("\"<i>I-I-I'm your obedia—ahhh-nt s-s-lave toy,</i>\" you moan.  As soon as the words leave your mouth, you know it's true, but that settles in the back of your mind.  You're eager to know how the creature and your mistress will reward you for being such an obedient-toy.  And of course, to get her talking again so you can feel those smooth fingertips caress you once more.\n\n", false);
				outputText("\"<i>You really are my good toy already, aren't you?</i>\" she muses, \"<i>You just love pleasing, me don't you toy?</i>\"  You nod feverishly, eliciting a happy laugh from your mistress as she lectures you, \"<i>The second part of your reward is an injection of its venom directly into your prostate.  You may not have noticed with the constant teasing your cock is enduring, but by now your prostate should have doubled in size.  If I ever separate you and your training-suit, you'll notice you're producing so much pre-cum that it's dribbling out ALL the time.  Your orgasms won't get much bigger, but you'll find yourself pouring out pre as you get more and more turned on.  After all, my baby here needs to feed.</i>\"\n\n", false);
				outputText("Your mistress pats your obscene purple panties tenderly and whispers in your ear, \"<i>Be a good toy and cum for mistress.</i>\"  You smile broadly as your hips piston in the air, as if fucking an imaginary twat.  Cum boils out from your ", false);
				if (player.balls > 0) outputText(player.ballsDescriptLight() + " and ", false);
				outputText(" over-sized prostate, filling the chamber around your cock with thick blasts of seed.  You smile happily as the tentacle-chamber distorts to hold your load, bulging out into a more spherical appearance.  You slump down as your orgasm finishes and you begin to feel even more 'reward' fill your now greedy-hole.\n\n", false);
				if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
					outputText("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
					outputText("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first...</i>\"\n\n", false);
				}
				outputText("Your mistress pats your head and whispers commands in your ear while the now-sated slave-making creature devours your cum, turning it into more 'reward'.  You don't pay attention to her words, what's important is serving mistress and cumming for your panty-toy as often as possible.  You don't need to worry, she will tell you what to think.  She's just so perfect and amazing, you don't know why anyone would want to harm her or her wonderful creations.  'Gods it feels good to obey' is the last thought your mind ever thinks for itself.\n\n", false);
				outputText("In the days to come, you spend your time being teased by your new mistress until you feel as if you'll burst, then being brought to sudden explosive orgasms that fill your panty-prison to capacity.  After every session you black out, but each time you mind less and less.  You wanted to be here, having these wonderful orgasms and obeying your beautiful mistress.\n\n", false);
				outputText("After a month she starts letting you live without your favorite panties.  You beg her to put them back on you, but she often makes you crawl around the factory, pooling pre-cum everywhere from your swollen prick as you beg her to be put back into the pleasure-panties.  Sometimes, if you're lucky, she'll fuck you, or send you out to catch another adventurer.  There is nothing you love more than cumming into your tentacle-panties while another one of your mistress' creations teaches a slut how to embrace her true nature.", false);
				getGame().gameOver();
				return;
			}
			//(Female) 
			if (player.vaginas.length == 1 || player.gender == 0) {
				outputText("In her hand is a seamless pair of panties.  Their surface reflects light perfectly, as if its bright pink surface were coated in slippery oil or made from latex.  ", false);
				if (player.gender == 0) {
					outputText("The demoness smiles with wicked intent and yanks the bottoms of your " + player.armorName + " the rest of the way off.  Your lack of genetalia does not faze her, and she responds by swiftly pulling out a needle and injecting your groin.  In seconds your crotch splits open, revealing a fresh virgin vagina.  Licking her perfect lips with anticipation, she inverts the panties and holds them up for you to see.\n\n", false);
					player.createVagina();
				}
				else outputText("The demoness smiles with wicked intent and yanks your " + player.armorName + "'s bottom the rest of the way off.  She leans close, smiling and inhaling the scent of your sex, savoring it like a aroma of a fine wine.  Licking her perfect lips with anticipation, she inverts the panties and holds them up for you to see.\n\n", false);
				outputText("They aren't panties at all, but instead some living creature.  The entire inside surface of the living garment is covered with fleshy pink nodules that wriggle constantly, practically dripping with a pungent lubricant that smells not unlike your own juices.  Horrifyingly, there is a large lump of flesh towards the front.  Its surface is ribbed and pulses, constantly swelling and shrinking.  It's clearly designed to enter the passage of anyone who wears it.  Worse yet is a smaller narrower protrusion on the backside.  This... creature... will certainly do its best to plug both your holes.\n\n", false);
				outputText("Your captor pulls it back and leans closer, letting the scent of her own fragrant puss fill the air.  It smells tangy and sweet and makes you ", false);
				if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_WET) outputText("wet ", false);
				else if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_DROOLING) outputText("drip on the chair ", false);
				else outputText("soak the chair ", false);
				outputText("from the heady taste that clings to your nostrils.  She speaks with confidence, \"<i>You needn't worry my dear.  I call this little creature my slut-panties.  You see, when you wear them they will stimulate every part of you.  They'll suck on your clit while the two large mounds grow inside you, filling you with wriggling pleasure.  Their slime is a wonderful lubricant and a mild aphrodisiac.  Between the constant touches and its secretions, you'll be horny and on the edge of orgasm in no time.</i>\"\n\n", false);
				outputText("You shake your head in desperate denial and start to cry as you realize she intends to keep you locked in some kind of hellish pleasure-prison.  The panties slide up your legs with ease, and with a swift movement, the demon lifts your ass up and slips them into position with a wet 'SQUELCH'.  You moan as it goes to work, wrapping your " + player.clitDescript() + " in slippery tightness.  The two 'lumps' you observed elongate, the ridged surfaces making your " + player.vaginaDescript(0) + " quiver and dance with pleasure.  In mere seconds you're panting hotly and ready to cum.  Your crying devolves into heated moans of pleasure and longing.\n\n", false);
				outputText("Bright red eyes fill your vision as the beautiful visage comes closer.  She whispers hotly in your ear, \"<i>I bet it feels good doesn't it?  Do you feel wet and horny?  I bet you'd love to throw yourself on my cock and get off right now.</i>\"\n\n", false);
				outputText("You blink away the tears and nod frantically; you're so close!  But every time you feel an orgasm start to build the creature eases up just enough to keep you away from your orgasm.\n\n", false);
				outputText("\"<i>You see, these panties are attuned to our kind.  I've worked hard to breed a pair that could be taught to only provide release when a demon cums in or on them.  Fortunately for you, the nodules will actually open to allow a demon's dick in either passage.  And just for our succubi friends, they can grow a protrusion from the front, and transmit the sensations to you,</i>\" she says as she demonstrates by bringing her throbbing purplish prick close to your pink-enclosed groin.  The surface of the panties splits with a line down the front, reshaping to reveal your pink-covered camel-toe.\n\n", false);  
				outputText("She asks, \"<i>I won't be a rapist my dear.  This cock will only enter you if you desire the pleasure it can bring you.  You could say no and just enjoy being on the edge until your will finally crumbles.</i>\"\n\n", false);
				if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
					outputText("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
					outputText("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first, didn't you want something from me?</i>\"\n\n", false);
					
				}
				outputText("It takes less than a second for you to moan out, \"<i>Taaaaake meeeee!</i>\"\n\n", false);
				outputText("She smiles and lifts you up from the chair with her strong arms, and sits down on the desk.  She lowers your symbiote-covered lips onto her demon dick and coos with delight as you slide down her length, taking the entire thing in your greedy depths.  If anything, the creature inside you makes sex even better - you feel a combination of her nub-covered cock fucking you and the ridges of the panty-creature as it continues to stimulate you.  It drives you mad with pleasure, and you begin bouncing yourself up and down, spearing your " + player.vaginaDescript(0) + " with the demon's pole.\n\n", false);
				outputText("She giggles and reaches down.  Too aroused to care, you just keep fucking her and moaning in delight.  Her hands come up and begin to massage and rub your " + player.allBreastsDescript() + " taking special care to tweak and tug on your nipples.  They become as hard as ", false);
				if (player.nippleLength < .5) outputText("erasers ", false);
				else if (player.nippleLength < 3) outputText("bullets ", false);
				else outputText("tiny cocks ", false);
				outputText("in moments", false);
				if (player.biggestLactation() > 2) outputText(" and start to drip with milk", false);
				outputText(".  You sigh with disappointment when her hands drop away.  You were so close to orgasm.  She reaches back up and places something wet and warm on ", false);
				if (player.breastRows.length <= 1) outputText("your " + player.nippleDescript(0), false);
				if (player.breastRows.length > 1) outputText("your top " + player.nippleDescript(0), false);
				outputText(".  You look down and see two star-shaped creatures made of glistening pink (just like your panties!) attached to your " + player.nippleDescript(0) + "s.  They pulse and ripple as they constantly massage and suck.  ", false);
				if (player.biggestLactation() > 1) outputText("Your milk erupts, spraying out from a tiny hole in the center of the star.  In response the creature increases the force of its sucking action, making you fountain milk constantly.  ", false);
				if (player.breastRows.length > 1) outputText("While you continue to fuck that meat pole and watch the creatures squirming on your nipples, more are affixed to each of your remaining " + player.nippleDescript(0) + "s, until every single one is covered with its own tiny pleasure-creature.\n\n", false);
				outputText("A flood of hot demonic spunk unloads into your aching " + player.vaginaDescript(0) + ", filling you with warmth.  The panty-plug in your backside seems to erupt as well, dumping a flood of undiluted aphrodisiacs into your body.  You squeal and cum, your eyes rolling back with pleasure as you sink down on the quivering member of your captor.  You twitch and moan, orgasming for far longer than the dick inside of you.  The pleasure goes on for minute after minute.  Your " + player.nippleDescript(0) + "s each radiate satisfaction and pleasure as they manage to provide you with miniature orgasms of their own.  You moan, feeling relief at last and losing yourself in the wave of satisfaction that fills your body.\n\n", false);
				outputText("You blink a few times, and sit up, finding yourself back in the chair.  Your pink panty-creature has closed back up, trapping the demon's cum inside you.  The corrupted seed is so potent you can actually feel it tainting your body further as it spreads into your core.  You stretch languidly as you try to recover from the best orgasm of your life.  Perhaps you can escape?  No, you can't leave, the panties are already massaging your aching cunt and toying with your still-hard " + player.clitDescript() + ".  You squirm as it effects you, ramping your body's desires back up to the max.  Maybe if you take a load in the front AND back at the same time it'll sate the creature long enough for you to escape....\n\n", false);
				outputText("You set off into the factory, looking for the Omnibus and an Incubus to help.\n\n", false);
				outputText("<b>One month later:</b>\nYou lick the demonic jism from your lips and stretch, happy your mistress provided you with your fifth orgasm of the morning.  Normally she only lets her favorite slut get her off three or four times before lunch.  You squirm as your panties go to work, taking you back to that wonderful plateau of pleasure that only your masters and mistresses can bring you down from.  Thinking back, this really is the best way for things to end.  You thank your mistress and ask if you can see if any of the imps want to knock you up again.  She smiles condescendingly and nods, making your cunt squeeze with happiness.  Imps have such great cum!", false);
				getGame().gameOver();
				return;
			}
		}
		
		private function doBadEndTension():void {
			outputText("Desperate for more of the demon-drugs, you slide into the now-familiar harness and let the needles sink into your skin.   Panting in lust, you beg for them increase the dosage again.   Desire burns through your veins as the cocktail surges through them", false);
			if (player.cocks.length > 0) {
				outputText(", filling your " + player.multiCockDescriptLight(), false);
				outputText(" with sensation", false);
				if (player.cockTotal() == 1) outputText("s", false);
				outputText(" as ", false);
				if (player.cocks.length > 1) outputText("they", false);
				else outputText("it", false);
				outputText(" grow", false);
				if (player.cocks.length == 1) outputText("s", false);
				outputText(" massive and engorged.  ", false);
			}
			else outputText(".  ", false);
			outputText("Your " + player.nippleDescript(0) + "s throb, becoming hard, puffy, and starting to dribble milk.  ", false);
			if (player.vaginas.length > 0) outputText("Your pussy is instantaneously soaked, filling the air with the scent of sex.  ", false);
			outputText("The desire for more of the drugs battles with your need to fuck and be fucked, until a small functioning part of your brain realizes it'll be easier to get sex than to get more of the drug.  You pull free and throw yourself into the mass of sweaty bodies, losing yourself in the salty tang of sweat and sex, pleasing nipples, clits, and cocks with your hands, and giving and receiving as much pleasure as you can.  You're in heaven.  Vaguely you realize time is passing, but it is a secondary concern next to the idea of having another groin-soaking orgasm.   You fuck and suck until you pass out from delirium.\n\n", false);
			//GAME OVERZZ
			outputText("In time you wake, your body aching both from the exertion and a desire for more.  On one hand you had a mission here, but why fight and struggle with danger and loneliness when you could be high on sex and cumming near-constantly?  You cuddle up to an exhausted girl and decide to wait for the drug-mistresses to give you another turn in the pile.  One of them turns, as if noticing your train of thought, and wheels over a breast-pump.  She hooks it up to your still-leaking nipples and you ", false);
			if (player.biggestLactation() >= 3) outputText("moo", false);
			else outputText("moo", false);
			outputText(" with happiness, promising another dose to you if you are a good cow for her.", false);
			dynStats("int", -100, "lib", 100, "cor", 2);
			getGame().gameOver();			
		}
		
		private function doBadEndDemon():void {
			clearOutput();
			if (player.gender == 1) outputText("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion.", false);
			else if (player.gender == 2) outputText("Now a full-fledged demon, you leave the factory, setting off on your own.  Over the next year you capture many foolish mortals, and even convince more than a few of them to give up their souls.  With your rapid gain in power, it's easy to rise in the demonic ranks, and in no time flat your power far exceeds that of the succubus that 'turned' you.  You live in luxury, surrounded by a harem of slaves, waiting in your camp for the next victim to step through...", false);
			else outputText("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion. It should be quite satisfying...", false);
			getGame().gameOver();
		}
		
		//ROOMS
		public function roomLobby():void {
			kGAMECLASS.dungeonLoc = 0;
			outputText("<b><u>The Factory Foyer</u></b>\n", true);
			outputText("The door swings shut behind you with an ominous 'creeeeeaaaaaaak' followed by a loud 'SLAM'.  Glancing around, you find yourself in some kind of stylish foyer, complete with works of art and a receptionist's desk.  Looking closer at the paintings on the wall quickly reveals their tainted and demonic nature: One appears at first to be a painting of a beautiful smiling woman, except you notice dripping tentacles coiling around the hem of her dress.  Behind the receptionist's desk, the second painting is even less discreet, openly depicting a number of imps gang-raping a vaguely familiar-looking woman.  Luckily, whatever demon is employed as the receptionist is away at the moment.  Behind the desk on the northern wall stands a secure-looking iron door.  On the western wall, is a door. A sign on the door indicates that it leads to the factory restroom.  On the eastern wall is a simple wooden door, though the color of the wood itself is far darker and redder than any of the hard woods from your homeland.  Behind you to the south is the rusty iron entry door.", false);
			dungeons.setDungeonButtons(checkDoor1, null, roomBathroom, roomBreakRoom);
			addButton(11, "Leave", checkExit);
		}
		
		public function roomBreakRoom():void {
			kGAMECLASS.dungeonLoc = 1;
			outputText("<b><u>Break Room</u></b>\n", true);
			outputText("Stepping through the dark red doorway, you wander into an expansive break room. Tables surrounded by crude wooden chairs fill most of the floor space. Along the far eastern wall sits a small counter, complete with a strange ebony sculpture of a busty woman with 'Mrs. Coffee' printed on the side. Below the sculpture is a pot of steaming hot coffee, giving off an invigoratingly rich smell.", false);
			dungeons.setDungeonButtons(null, null, roomLobby, null);
			if (flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED] > 0) {
				if (player.hasKeyItem("Iron Key") < 0) {
					outputText("  It seems your opponent dropped a small iron key as she fled.", false);
					addButton(0, "Iron Key", takeIronKey, null, null, null, "Pick up the iron key. It looks like it might unlock the door in this factory.");
				}
				addButton(1, "Coffee", drinkCoffee, null, null, null, "Drink some coffee.");
				spriteSelect(96);
			}
			else {
				spriteSelect(55);
				outputText("\n\nStanding next to the coffeemaker is a blue-skinned woman holding a mug of coffee.  As she takes a sip, oblivious to your presence, you see the mug has '#1 Dad' written on it.  Dressed in a tiny vest, short skirt, and sheer stockings, she looks every bit an air-headed secretarial ditz.  Her two horns are little more than nubs, mostly covered by her flowing blond hair, and if it wasn't for her blue skin and the tip of a spaded tail peeking out from under her skirt, you'd never know what she was.\n\n", false);
				menu();
				// demon bad end available
				if (player.demonScore() >= 4 && player.cor > 75) {
					outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there ", false);
					if (player.gender == 1) outputText("stud", false);
					else outputText("sexy", false);
					outputText("!</i>\"  She stops, sniffing the air, a curious expression on her face as she slowly circles you, her heals clicking loudly on the floor.  A knowing grin blooms across her face as understanding hits her.\n\n", false); 
					outputText("She exclaims, \"<i>Omigawsh!  You're the champion!  Your, like, soul is still there and everything!  But, you're like, completely corrupt an' stuff!  Ya know what'd be fun?  I could fuck you 'til you cum so hard your soul melts out an' you turn into a demon.  Wouldn't that be great?</i>\"\n\n", false);
					outputText("The secretarial demoness pulls out a file and fiddles with her nails, murmuring, \"<i>I guess if you don't wanna, we could just hook you up in the factory.  What's it gonna be?</i>\"", false);
					if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
						outputText("<b>New codex entry unlocked: Succubus!</b>\n\n")
					}
					simpleChoices("Fight", doFightSuccubus, "Go Demon", goDemon, "Hook Up", talkSuccubusYes, "", null, "", null);
				}
				//Not recognized
				else if (player.humanScore() <= 3) {
					outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there ", false);
					if (player.gender == 1) outputText("stud", false);
					else outputText("sexy", false);
					outputText("!  You haven't seen a confused human about calling itself a champion have you?</i>\"\n\nShe shakes her more-than-ample bosom from side to side as she licks her lips and offers, \"<i>If you do, be sure and bring them back here ok?  We've got their spot all ready for them, but that little prick Zetaz fucked up the pickup.  Tell you what – if you bring me the 'champion' I'll ", false);
					if (player.totalCocks() > 0) outputText("give you the blowjob of a lifetime", false);
					else if (player.hasVagina()) outputText("lick your honeypot 'til you soak my face", false);
					else outputText("give you a new addition and show you how to use it", false);
					outputText(".</i>\"\n\nThe succubus turns away from you and makes a show of tweaking her make-up, ignoring you for the moment.", false);
					if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
						outputText("<b>New codex entry unlocked: Succubus!</b>\n\n")
					}
					simpleChoices("Fight", doFightSuccubus, "It's Me!", talkSuccubusItsMe, "Leave", roomLobby, "", null, "", null);
				}
				else {
					outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there ", false);
					if (player.gender == 1) outputText("stud", false);
					else outputText("sexy", false);
					outputText("!  What's a cute little morsel like you doing by yourself out here?</i>\"", false);
					if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
						outputText("<b>New codex entry unlocked: Succubus!</b>\n\n")
					}
					simpleChoices("Fight", doFightSuccubus, "Talk", talkSuccubus, "Run", roomLobby, "", null, "", null);
				}
			}
		}
		
		public function roomPumpRoom():void {
			kGAMECLASS.dungeonLoc = 2;
			outputText("<u><b>Pump Room</b></u>\n", true);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] < 1) {
				outputText("As you step through the iron door, a cacophony of thrumming mechanical noise assaults your ears.  Coppery pipes arch overhead, riveted into spiked iron brackets that hang from the ceiling in twisted pairs.  The constant thrum-thrum-thrum of concealed pumps and mechanisms makes it difficult to hear anything, but you swear you can make out the faint sounds of sexual pleasure emanating from the northwest side of the room.  Investigating further, you spot a door along the west wall of the room that appears to be the source of the licentious sounds.  The vibrations of all the machinery are strongest along the east walls, indicating the possible site of this hellish place's power-plant. There is a door on the east wall and a door on the north.  To the south is a solid iron door that leads back to the lobby.", false);
			}
			else outputText("As you step through the iron door, silence is the only noise you hear.  Coppery pipes arch overhead, riveted into spiked iron brackets that hang from the ceiling in twisted pairs.  The near-complete silence of the place unnerves you, but allows you to make out the faint sounds of sexual pleasure emanating from northwest side of the room.  Investigating further, you spot a door along the west wall of the room that appears to be the source of the licentious sounds.  There are two other doors, one along the east wall and one on the north.  To the south is a solid iron door that leads back to the lobby.", false);
			dungeons.setDungeonButtons(roomRepairCloset, roomLobby, roomMainChamber, roomFurnaceRoom);	
		}
		
		public function roomFurnaceRoom():void {
			kGAMECLASS.dungeonLoc = 3;
			outputText("<b><u>Furnace Room</u></b>\n", true)
			if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) {
				outputText("The air inside this room is hot enough to coat your " + player.skinTone + " " + player.skinDesc + " in a fine sheen of sweat.  The eastern side of the chamber is more machine than wall, a solid mass of iron piping covered in small metal blast-doors through which fuel is to be fed.  A small transparent plate is riveted into the wall, allowing you to see some kind of pink crystalline fuel being burned by purple-white fire.  The few visible controls and gauges don't seem to be linked into anything important, and the machinery looks far too durable to damage with what you have.  The only exit is a heavy iron door on the west wall.  ", false);
			}
			else {
				outputText("Despite the machinery being shut down, the air in this room is still hot enough to coat your " + player.skinTone + " " + player.skinDesc + " in a fine sheen of sweat.  The eastern side of the chamber is more machine than wall, a solid mass of iron piping covered in small metal blast-doors through which fuel is to be fed.  A small transparent plate is riveted into the wall, allowing you to see some the ashes of a previous fuel source.  The few visible controls and gauges don't seem to be linked into anything important, and the machinery looks far too durable to damage with what you have.  The only exit is a heavy iron door on the west wall.  ", false);			
			}
			dungeons.setDungeonButtons(null, null, roomPumpRoom, null);	
			
			//Incubus is ALLLLIVE
			if (flags[kFLAGS.FACTORY_INCUBUS_DEFEATED] <= 0) {
				spriteSelect(30);
				if (flags[kFLAGS.FACTORY_INCUBUS_BRIBED] > 0) {
					outputText("\n\nThe incubus mechanic is here, thumbing through a hentai comic and laughing to himself at the absurdity of it.  That doesn't stop him from stroking his half-hard member the whole time...", false);
					addButton(0, "Fight", doFightIncubus);
				}
				else {
					menu();
					outputText("\n\nA demonic mechanic lounges against the hot machinery, unperturbed by the high temperatures of the room.  He wears cut-off denim overalls, stained with grease in a few places.  They don't seem to be in good repair, and have a fair-sized hole at his groin, where a floppy foot-long member hangs free.  His skin is light purple and unblemished, as you would expect from a sexual demon.  He has a rugged handsome face and black hair tied back in a simple ponytail.  Two large curving horns protrude from his forehead, curving back along his skull and giving him a dangerous appearance.  A narrow goatee grows from his chin, about 3 inches long and braided skillfully.  He looks up and smiles, amused at your appearance.", false);
					addButton(0, "Fight", doFightIncubus);
					addButton(1, "Talk", talkIncubus);
				}
			}
		}
		
		public function roomRepairCloset():void {
			kGAMECLASS.dungeonLoc = 4;
			outputText("<b><u>Repair Closet</u></b>\n", true);
			outputText("As you carefully slip inside the room, you note with some relief that it seems to be an empty storage closet. The room is tiny, barely 6' by 8' and almost entirely empty.  The one piece of furniture inside the closet is a simple wooden cabinet, placed against the far wall.  ", false)
			dungeons.setDungeonButtons(null, roomPumpRoom, null, null);	
			if (flags[kFLAGS.FACTORY_MILKER_BUILT] > 0) outputText("The shelves are empty.  ", false);
			else {
				outputText("The shelves of the cabinet hold various pieces of pump machinery, probably used to repair complete machines further into the factory.  ", false);
				if (player.inte >= 40) {
					outputText("You realize there are enough pieces here to put together a breast-milking pump or a cock-milker.  ", false);
					if (player.hasKeyItem("Cock Milker") >= 0) outputText("\nYou already have a cock milker.\n", false);
					else {
						addButton(1, "Cock Milker", buildCockMilker);
					}
					if (player.hasKeyItem("Breast Milker") >= 0) outputText("\nYou already have a breast milker.\n", false);
					else {
						addButton(0, "Breast Milker", buildBreastMilker);
					}
				}
			}
			outputText("The only exit is back to the south.", false);
		}
		
		public function roomMainChamber():void {
			kGAMECLASS.dungeonLoc = 5;
			outputText("<b><u>Main Chamber</u></b>\n", true);
			dungeons.setDungeonButtons(null, null, null, roomPumpRoom);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) {
				outputText("This cavernous chamber is filled with a cacophony of sexual moans.  Rows of harnesses are spaced evenly throughout this room, nearly all of them filled with delirious-looking humans.  Each is over-endowed with huge breasts and a penis of elephantine proportions.  The source of their delirium hangs down from the ceiling - groups of hoses that end with needles buried deep into the poor 'girls' flesh, pumping them full of demonic chemicals.  Constant sucking and slurping noises emanate from nipple and cock pumps as they keep the victims in a state of near-constant orgasm.  ", false);
				if (player.cor < 50) outputText("You wish you could free them, but it would take the better part of a day to get them all free.  It'd be better to find the control room and shut down the infernal machinery.  ", false);
				else outputText("You wish you had some machinery like this for yourself.  It looks so fun!  Still, you suppose you should find the control panel to shut this down and free these people.  ", false);
				outputText("There is a doorway to the east marked with an 'exit' sign above it.  Along the southern wall is a stairwell that leads up to some kind of foreman's office.  Perhaps the controls are in there?", false);
			}
			//Dungeon shut down.
			else {
				outputText("The chamber is significantly emptier since you've shut down this factory.  Roughly half the girls appear to have left.  The rest seem to be pre-occupied by fucking each other in a massive orgy.  A few enterprising ladies have found leather outfits and appear to be helping to manually administer the chemical cocktails to those engaged in rampant sexual exploits.  It seems some of them preferred a life of near-constant orgasm to their freedom.  There is a door to the east marked as 'EXIT', and a stairwell along the south wall that leads to an overseer's office.", false);
				outputText("\n\nOne of the leather-clad ladies steps over and offers, 'Would you like a dose?  You look like you need to relieve some tension...", false);
				addButton(0, "Tension", doTensionRelease);
			}
			addButton(5, "Upstairs", checkStairs);
		}
		
		public function roomForemanOffice():void {
			kGAMECLASS.dungeonLoc = 6;
			//Foreman's Office
			outputText("<b><u>Foreman's Office</u></b>\n", true);
			outputText("This office provides an excellent view of the 'factory floor' through a glass wall along the north side.  Towards the south side of the room is a simple desk with an even simpler chair behind it.  The desk's surface is clear of any paperwork, and only has a small inkwell and quill on top of it.  There are a few statues of women and men posted at the corners of the room.  All are nude and appear to be trapped in mid-orgasm.  You wonder if they're statues or perhaps some kind of perverted petrified art.  The north has a glass door leading back to the factory.  There are two other doors, both made of very solid looking metal.  One is on the east wall and another is on the south, behind the desk.  The one behind the desk is marked 'Premium Storage' (though it appears to be locked).", false);
			dungeons.setDungeonButtons(null, checkDoor2, null, roomControlRoom);
			addButton(7, "Downstairs", roomMainChamber)
			if (flags[kFLAGS.FACTORY_OMNIBUS_DEFEATED] <= 0) {
				menu();
				spriteSelect(16);
				outputText("\n\nA nearly nude demonic woman is standing behind the desk, appraising you.  She is gorgeous in the classical sense, with a curvy hourglass figure that radiates pure sexuality untamed by any desire for proper appearance.  Shiny black lip-gloss encapsulates her bubbly lips, while dark eyeshadow highlights her bright red eyes.  The closest thing she has to clothing is a narrow band of fabric that wraps around her significant chest, doing little to hide the pointed nubs of her erect nipples.  Her crotch is totally uncovered, revealing the hairless lips of her glistening womanhood.\n\n", false);
				outputText("She paces around the edge of the desk, licking her lips and speaking, \"<i>So you've made it all the way here have you, 'champion'?  Too bad you've wasted your time.  Have you figured it out yet?  Have you discovered why you were sent here with no weapons or blessed items?  Have you found out why there are more humans here than anywhere else in this realm?  I'll tell you why.  You weren't a champion.  You were a sacrificial cow, meant to be added to our herd.  You just got lucky enough to get free.</i>\"\n\n", false);
				outputText("A part of you wants to deny her, to scream that she is wrong.  But it makes too much sense to be a lie... and the evidence is right behind you, on the factory floor.  All those women must be the previous champions, kept alive and cumming for years in order to feed these insatiable demons.  The demoness watches your reaction with something approaching sexual bliss, as if the monstrous betrayal of it all is turning her on.\n\n", false);
				outputText("\"<i>Yes,</i>\" she coos, \"<i>you belong here.  The question is do you accept your fate, or do you fight it?</i>\"", false);
				addButton(0, "Fight", doFightOmnibus);
				addButton(1, "Accept", acceptOmnibus);
			}
			else {
				if (player.hasKeyItem("Supervisor's Key") < 0) {
					addButton(0, "Desk", takeSupervisorKey, null, null, null, "Check the desk for something.");
				}
			}
		}
		
		public function roomControlRoom():void {
			kGAMECLASS.dungeonLoc = 7;
			outputText("<b><u>Pump Control Room</u></b>\n", true);
			outputText("This room is little more than a closet in reality.  There is a simple set of mechanical controls on a finely crafted terminal against the far wall.  ", false)
			if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) {
				outputText("You spend a moment looking over them, and realize you have three options to deal with this place.\n\n", true);
				outputText("-You could close the storage vent valves and overload the fluid storage systems.  The storage tanks along the back portion of the building would rupture, releasing thousands of gallons of tainted fluids into the surrounding area, but the facility's systems would suffer catastrophic failures and shut down forever.\n", false);
				//(Consequences - lake goddess becomes tainted!)
				outputText("-You could perform a system shutdown and then smash the controls.  It'd let the girls go and keep the factory shut down in the short term.  However most of the equipment would be undamaged and the place could be re-opened without too much work on the demons' part.\n", false);
				//(Consequences - If Marcus is a demon he takes over running the factory forever.  If not, nothing bad happens)
				outputText("-You could leave the equipment to continue running.  After all, the girls downstairs did seem to be enjoying themselves...\n", false);
				//(Consequences - Marcus takes over if demonic choice taken, if not he shuts down the equipment & things continue as per #3).
			}
			else {
				outputText("The controls are now inoperable due to the damage your actions have caused.", false);
			}
			dungeons.setDungeonButtons(null, null, roomForemanOffice, null);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] <= 0) {
				addButton(0, "Valves", factoryOverload, null, null, null, "Overload the valves. This may have unintended consequences but the factory will suffer catastrophe and shut down forever.");
				addButton(1, "Shutdown", factoryShutdown, null, null, null, "Shut down the factory safely. This may seem like a safe bet but it leaves the factory vulnerable to the possibility of being re-opened.");
			}
		}
		
		public function roomPremiumStorage():void {
			kGAMECLASS.dungeonLoc = 8;
			outputText("<b><u>Premium Products</u></b>\n", true);
			outputText("This store room is filled with a few opened crates, meant to store the various substances in the factory.  It looks as if the current overseer has allowed supplies to run low, as there is not much to be gleaned from this meager stash.\n\n", false);
			dungeons.setDungeonButtons(roomForemanOffice, null, null, null);
			if (flags[kFLAGS.FACTORY_TAKEN_LACTAID] > 0) {
				if (flags[kFLAGS.FACTORY_TAKEN_LACTAID] < 5) {
					outputText("There is a crate with " + num2Text(5 - flags[kFLAGS.FACTORY_TAKEN_LACTAID]) + " bottles of something called 'Lactaid' inside.\n\n", false);
					addButton(0, "Lactaid", takeLactaid);
				}
			}
			else {
				outputText("There is an unopened crate with five bottles of something called 'Lactaid' inside.\n\n", false);
				addButton(0, "Lactaid", takeLactaid);
			}
			if (flags[kFLAGS.FACTORY_TAKEN_GROPLUS] > 0) {
				if (flags[kFLAGS.FACTORY_TAKEN_GROPLUS] < 5) {
					outputText("There is a crate with " + num2Text(5 - flags[kFLAGS.FACTORY_TAKEN_GROPLUS]) + " bottles of something called 'Gro+' inside.\n\n", false);
					addButton(1, "GroPlus", takeGroPlus);
				}
			}
			else {
				outputText("There is an unopened crate with five bottles of something called 'Gro+' inside.\n\n", false);
				addButton(1, "GroPlus", takeGroPlus);
			}
		}
		
		public function roomBathroom():void {
			kGAMECLASS.dungeonLoc = 9;
			outputText("<b><u>Washroom</u></b>\n", true);
			outputText("This room is fairly clean. At one of the walls, there is a row of four sinks. Opposite side, there are few bathroom stalls. Three urinals are mounted against one of the walls. You'd guess even the demons need to use the bathroom.", false);
			dungeons.setDungeonButtons(null, null, null, roomLobby);
			//outputText("Do you use?")
			//addButton(2, "Use", useBathroom);
		}
	}
}