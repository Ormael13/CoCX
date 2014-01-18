//Dungeon events from 11000+
public function doDungeon(eventNo:Number):void {
	if(eventNo == 11000) dungeonLoc = 0;
	if(eventNo == 11001) {
		if(player.hasKeyItem("Iron Key") < 0) {
			outputText("The door is locked with a key that is not in your possession.", true);
			doNext(1);
			return;
		}
		else dungeonLoc = 1;
	}
	if(eventNo == 11002) dungeonLoc = 2;
	if(eventNo == 11003) dungeonLoc = 3;
	if(eventNo == 11004) dungeonLoc = 4;
	if(eventNo == 11005) dungeonLoc = 5;
	if(eventNo == 11006) dungeonLoc = 6;
	if(eventNo == 11007) dungeonLoc = 7;
	if(eventNo == 11008) {
		if(player.hasKeyItem("Supervisor's Key") < 0) {
			outputText("The door is locked with a key that is not in your possession.", true);
			doNext(1);
			return;
		}
		else dungeonLoc = 8;
	}
	if(eventNo == 11009) dungeonLoc = 9;
	if(eventNo == 11010) {
		inDungeon = false;
		dungeonLoc = 0;
		if(dungeonLoc == 0) {
			outputText("You slip out the door and disappear, heading back towards your camp, leaving the hellish factory behind.", true);
			doNext(13);
		}
		else eventParser(1);
		return;
	}
	//Drink Coffee
	if(eventNo == 11011) {
		spriteSelect(96);
		outputText("You take a sip of the rich creamy coffee and suddenly feel refreshed. As you replace the coffeepot, the busty coffee-maker comes to life, grabbing her thick dusky nipples and squeezing out a trickle of scaldingly hot liquid. You can see her eyes roll up into her head from what you assume to be pleasure as she automatically refills the missing coffee, mouth open with ecstasy.  Her movements gradually slow as she quivers almost imperceptibly. A contented smile graces her features as immobility overtakes her, freezing her back in place.  You wonder if 'Mrs. Coffee' was created, or a victim of this place's dark master.", true);
		dynStats("lus", 1);
		HPChange(35, false);
		doNext(1);
		return;
	}
	//Dungeon Factory Activate!
	if(eventNo == 11012) {
		inDungeon = true;
		dungeonLoc = 0;
		eventParser(1);
		return;
	}
	//Talk with Succubus 1
	if(eventNo == 11013) {
		spriteSelect(55);
		outputText("\"<i>I suppose I really should thank you for coming down all by your lonesome.  The boss is gonna be sooo happy we found you.  Just think, in an hour or two we can get you strapped in and working with the others,</i>\"  says the secretarial succubus as she saunters over, still sipping her coffee, \"<i>You're so cute!  I tell you what, if you agree to come with me, I'll, like, make sure the experience is pleasurable.</i>\"\n\n", true);
		outputText("She runs a stocking covered foot up your leg and thigh, almost to your groin.  Giggling, the succubus pulls it away and asks, \"<i>So are you ready and willing?</i>\"", false);
		simpleChoices("For what?", 11014, "Yes", 11015, "No", 11017,"",0,"",0);
		return;
	}
	//Talk with succubus 2
	if(eventNo == 11014) {
		spriteSelect(55);
		outputText("The succubus looks at you with a bemused expression, \"<i>You haven't figured it out yet?  Really?  What do you think we make at this factory, bubble-gum?</i>\" she asks with a cruel smile, \"<i>We take human and once-human champions like you, pump you full of aphrodisiacs, body-altering drugs, and corrupting agents, and then milk you of your tainted fluids continually for the rest of your life!  And don't even start to ask why, I'll tell you – there are still pockets of purity out there that repel cute demons like me.  So the best way to deal with those is just to release a river of drug-filled sex-juice at them.  By the time the area dries off, the locals welcome us with open arms... and spread legs.</i>\"", true);
		simpleChoices("Sick!", 11017, "Sounds Fun", 11015,"",0,"",0,"",0);
		return;
	}
	//Volunteer for bad-end!
	if(eventNo == 11015) {
		spriteSelect(55);
		outputText("The blue skinned seductress steps forward and wraps her arms around you, pulling your head down and crushing it into her heavenly breasts as she speaks, \"<i>My my, aren't you the kinky little play-toy.  Let's get you hooked up.</i>\"\n\n", true);
		outputText("She catches you off-guard, lifting your feet off the ground.  You realize she has somehow grown taller.  You stretch to see what's going on, but have no leverage to pry your face from the smooth globes of flesh that smother you.   Vaguely, the click-clack of heels reaches you through the walls of flesh.  You're being moved deeper into the facility.   A creaky door opens, allowing you to hear the loud humming of machinery, mixed with what sounds like desperate sexual moans.\n\n", false);
		outputText("Abruptly you are pulled free from the succubus' fleshy prison and bodily thrown into padded restraints.  Blinded by the sudden onslaught of light, you blink away tears as restraints are placed securely around your wrists.  Warm lips press against your own as a foreign tongue penetrates your lips, mouth-raping you.  It tastes of sweet exotic spices, like nothing you've ever had before.   Helpless to do anything but return the kiss, you respond, sliding your tongue along the slippery sweetness of your captor's.  You risk opening your eyes and see your inhuman captor to be enjoying the kiss every bit as much as you.", false);
		doNext(11018);
		return;
	}
	//Start combat succubi
	if(eventNo == 11016) {
		player.createStatusAffect("FactorySuccubusDefeated", 0, 0, 0, 0);
		startCombat(new SecretarialSuccubus(),true);
		eventParser(1);
		spriteSelect(55);
		return;
	}
	//Refuse succubus' offer
	if(eventNo == 11017) {
		spriteSelect(55);
		outputText("She frowns, \"<i>I was secretly hoping you would say that... I'm going to make you beg me to hook you into the machines.  Just wait.</i>\"", true);
		doNext(11016);
		return;
	}
	//Succubi bad end 2
	if(eventNo == 11018) {
		spriteSelect(55);
		//Arousal
		outputText("In no time flat your blood begins to burn hot with the fires of unnatural lust.  ", true);
		//Tits – regular
		if(player.biggestLactation() < 1) outputText("Your " + nippleDescript(0)  + "s begin prodding painfully against your " + player.armorName + ", every touch serving to make them harder and more erect.  ", false);
		//Tits – lactating
		if(player.biggestLactation() >= 1 && player.biggestLactation() < 3) outputText("Your " + nippleDescript(0) + "s get painfully hard as you feel milk begin backing up inside your " + allBreastsDescript() + ".   The succubus glances down mischieviously as her hands begin to grope you through your " + player.armorName + ", squeezing out a few drops of milk.  ", false);
		//Tits – megalactating
		if(player.biggestLactation() >= 3) outputText("Your " + nippleDescript(0) + "s get painfully hard as milk begins drooling down your over-productive chest, making your " + player.armorName + " slide across your leaky milk-spouts in an agonizingly pleasurable way.  ", false); 
		//Cock – single
		if(player.cocks.length == 1) {
			if(player.cockArea(0) < 30) outputText("Swooning from sudden blood loss, you struggle to maintain the kiss as your body takes your " + cockDescript(0) + " to full hardness in seconds.  ", false);
			//Cock – single big
			if(player.cockArea(0) >= 30 && player.cockArea(0) < 100) outputText("Nearly blacking out, you struggle to stay awake as your body shifts your blood to your disproportionate " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ".  ", false);
			//Cock -megahuge
			if(player.cockArea(0) >= 100) outputText("As you struggle not to lose consciousness, you realize your over-aroused body had pumped most of your blood to your over-sized " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", which now droops to the floor, pulsing hotly.  ", false);
		}
		//DO MULTIZ
		if(player.cocks.length > 1) outputText("The feeling of light-headedness nearly robs you of consciousness as your " + multiCockDescript() + " fill with blood, pulsating with arousal as they reach full size.  ", false);
		//Vagooooz
		if(player.vaginas.length > 0) {
			//'uge clit
			if(player.clitLength >= 4.5) outputText("Popping from between your thighs, your " + clitDescript() + " responds to the sheer hotness of the situation by making itself known.   You squeeze your legs tightly together, hungry for additional sensation.  ", false);
			//big clit
			if(player.clitLength > 1 && player.clitLength < 4.5) outputText("A wave of pleasure erupts from between your legs as your " + clitDescript() + " pops free.    You squeeze your legs tightly together, hungry for the additional sensations.  ", false);
			//slick
			if(player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("Squishing wetly, your bottoms become soggy with the flood of fluids leaking from your " + vaginaDescript(0) + ".   Your legs spread apart on their own, begging for any kind of intrusion.  ", false);
			//normal
			else outputText("Groaning softly, you feel yourself getting wetter and wetter with arousal.  You wish your sticky bottoms were off so you could let something into your " + vaginaDescript(0) + ".  ", false); 
		}
		outputText("\n\n", false);
		//New PG
		outputText("No longer caring about modesty, etiquette, or even your own safety, you squirm against your bindings, lewdly putting on a display for your captor as you suck her tongue as if your life depended on it.   She breaks the kiss with a smile, \"<i>I told you I'd make sure it was pleasurable.  Now you sit tight while I get you hooked up, and we'll have you cumming what's left of your brains out in no time,</i>\" she promises.\n\n", false);
		outputText("The succubus pushes a button on the wall, and a number of strange looking suction tubes and hoses drop down from above you.   Moving with practiced efficiency, she hooks a ", false);
		if(player.breastRows.length == 1) outputText("pair of", false);
		else outputText("number of", false);
		outputText(" hoses to your breasts, ", false);
		if(player.cocks.length == 0) {
			if(player.vaginas.length > 0) outputText("and a vacuum pump to your clit.  ", false);
			else {
				outputText("and another vacuum pump to your bare groin.  In seconds a wet fleshy growth erupts.  You have grown a cock!  ", false);
				player.createCock();
			}
		}
		else {
			if(player.vaginas.length > 0) outputText("a vacuum pump to your clit, and a pump many times bigger than your " + cockDescript(0) + " to it.  ", false);
			else outputText("and a pump many times bigger than your " + cockDescript(0) + " to it.  ", false);
		}
		outputText("At first there is only a gentle suction, you assume in order to keep them in place.  Unfinished, your captor places something large and hollow against your backdoor", false);
		if(player.vaginas.length == 0) outputText(".", false);
		else outputText(" and an ever larger dildo against your " + vaginaDescript(0) + ".  It seems to pulse and wiggle with a life of its own rubbing the bumps of it's lumpy head against your lips.", false);
		outputText("  You swoon as you hear the solid click of a button being pushed, and all at once all devices attached to you leap to life.", false);
		doNext(11019);
		return;
	}
	//Succubus voluntary bad end round 3. 
	if(eventNo == 11019) {
		spriteSelect(55);
		outputText("The beautiful seductress that bound you giggles and says, \"<i>Oh it only gets better baby,</i>\" as she pushes another button.  You see a number of needles lower from the equipment above.  Two pause at chest height.  Faded parchment labels on the tubes mark them as \"Gro+\".  You spot the same markings on at least some the hoses gathering around your groin.  A few are marked with different labels, but you cannot make out the demonic script.  As one, the hoses rear back, then plunge forward, burying themselves into your supple flesh and injecting their drugged payload into your body.  It hurts at first, but the drugs fog your mind, blocking the pain with pulsing waves of desire.   You begin cumming as your body erupts with artificial pleasure.\n\n", true); 
		//Nipples
		outputText("The suction pulls squirt after squirt of milk from your breasts as your " + allBreastsDescript() + " start to grow, swelling heavier as they enlarge to produce more milk.  You squeal with delight as your nipples turn black, tainted by corruptive chemicals that are slowly dripped into you.  ", false);
		//Dick  
		if(player.cocks.length > 0) {
			outputText("The vacuum-pump on your cock noisily sucks down all your spoo, ", false);
			//High cum variant
			if(player.cumQ() > 300) outputText("struggling with the amount you put off.  Grinning, the succubus reaches over and flips a lever.  You feel the suction increase as the machine is turned up to accommodate your altered physique.  ", false);
			//else
			else outputText("the suction and drugs make it so easy to just keep cumming and cumming.  ", false);
			//either or:
			outputText("Dimly, you feel a needle lodged in your taint, pumping your prostate full of something.  Your " + cockDescript(0) + " begins growing mid-orgasm, the skin turning a deep purple even as small nodule-like bumps form all over it, rapidly becoming a bloated parody of it's demonic counterparts.  ", false);
		}
		//Puss Orgasmz
		if(player.vaginas.length > 0) outputText("Clenching tightly, your " + vaginaDescript(0) + " squeezes tightly on it's intruder as it's repeatedly violated by the machines.  ", false);
		//End
		outputText("\n\nThe world around you disappears, leaving you alone with the drug-enhanced sensations assaulting your body.  In truth, you don't want it to end.  You find yourself wishing it would never end, and no doubt the equipment you're hooked in to will see to that.\n\n", false);
		if(player.statusAffectv3("Marble") == 1) {
			outputText("Later on, you are briefly pulled out of your reverie by a familiar warm fluid flowing down your throat.  You come to your senses and see Marble looking down at you with an odd expression on her face.  ", false);
			outputText("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
		}
		else if(player.hasStatusAffect("Camp Marble") >= 0) {
			outputText("You are given a brief moment of clarity as you see Marble standing in front of you.  ", false);
			outputText("She seems to be in a state of bliss. Looking down, you see that she is wearing some kind of pair of pink panties.  Marble gasps and the surface of the panties ripples; it's a living thing!\n\nYou look around and realize you aren't alone.  ", false);
		}
		else outputText("Later on, in a moment of clarity, you look around and realize you aren't alone.  ", false);		
		outputText("In rows alongside you are a large number of other captives, every single one endowed with freakishly sized breasts, and nearly all gifted with throbbing demonic dicks.  Some small analytical part of you notes that the farther down the line they are, the older and larger they have become.   You look down and see your own massive tits, shiny tainted nipples still pumping out streams of milk.  The huge throbbing demon-cock between your legs begins to get hard as the machines crank back up, filling you full of happy horniness.", false);
		if(player.statusAffectv3("Marble") == 1 || player.hasStatusAffect("Camp Marble") >= 0) outputText("  With Marble here too, you'll be around for a long time.", false);
		eventParser(5035);
		return;
	}
	//VICTORY RAEP - SUCCUBUS
	if(eventNo == 11023) {
		spriteSelect(55);
		succubusVictoryRape();
		return;
	}
	//Loss Rape - SUCCUBUS
	if(eventNo == 11024) {
		spriteSelect(55);
		succubusLossRape();
		return;
	}
	//Factory Bad-End Generic
	if(eventNo == 11025) {
		factoryFinisher();
		return;
	}
	//Succubus scissor
	if(eventNo == 11026) {
		spriteSelect(55);
		outputText("", true);
		dungeonSuccubusForceScissor();
		return;
	}
	//Succubus force-feed
	if(eventNo == 11027) {
		spriteSelect(55);
		dungeonSuccubusForceFeed();
		return;
	}
	//Take iron key
	if(eventNo == 11028) {
		outputText("You take the <b>Iron Key</b> to keep with your other important items.", true);
		doNext(1);
		player.createKeyItem("Iron Key",0,0,0,0);
		return;
	}
	//Build Cock Milker
	if(eventNo == 11029) {
		outputText("You puzzle out how to build a fully functional cock-milker from the spare parts here and assemble it.\n\nYou gained a <b>Cock Milker</b>!", true);
		outputText("\n\nYou'll need a little help to use it though.", false);
		player.createKeyItem("Cock Milker",0,0,0,0);
		player.createStatusAffect("BUILT: Milker",0,0,0,0);
		doNext(1);
		return;
	}
	//Build Breast Milker
	if(eventNo == 11030) {
		outputText("You puzzle out how to build a fully functional breast-milker from the spare parts here and assemble it.\n\nYou gained a <b>Breast Milker</b>!", true);
		outputText("\n\nYou'll need a little help to use it though.", false);
		player.createKeyItem("Breast Milker",0,0,0,0);
		player.createStatusAffect("BUILT: Milker",0,0,0,0);
		doNext(1);
		return;
	}
	//Start combat incubi
	if(eventNo == 11031) {
		player.createStatusAffect("FactoryIncubusDefeated", 0, 0, 0, 0);
		startCombat(new IncubusMechanic(),true);
		eventParser(1);
		spriteSelect(30);
		return;
	}
	//Talk to Incubus
	if(eventNo == 11032) {
		spriteSelect(30);
		if(player.hasKeyItem("Hentai Comic") >= 0) {
			outputText("The incubus speaks to you with calm deep voice, \"<i>And so the insect, heedless of it's path, stumbled directly into the spider's web.  Tiny insect… wait, what is that book you're carrying?  Is that hentai?  It IS!  Let me offer you a deal – I'm not really hungry or interested in fighting. So if you hand over the comic, I'll happily ignore your presence here. Though, I guess you could also just submit. Then I could put you to work and still get the comic.</i>\"", true);
			simpleChoices("Fight",11031,"Trade",11034,"Submit",11033,"",0,"",0);
		}
		else {
			outputText("The incubus speaks to you with calm, deep voice, \"<i>And so the insect, unaware of its path, stumbles directly into the spider's web.  Tiny insect, you have little to offer me, but everything to offer our facility.  Why don't you come along quietly?</i>\"", true);
			simpleChoices("Fight",11031,"Submit",11033,"",0,"",0,"",0);
		}
		return;
	}
	//Submit to Incubus
	if(eventNo == 11033) {
		spriteSelect(30);
		outputText("\"<i>It is good to see the insect accept its fate as the spider closes in,</i>\" intones the strange demonic mechanic as he takes you by the arm and leads you deeper into the facility.  ", false);
		if(player.hasStatusAffect("DungeonShutDown") >= 0) {
			outputText("\n\nYou enter the main milking chamber, and the incubus gives a start when he realizes what has happened.  With a grunt of rage he throws you through the doorways back into his chamber.  The demon stalks after you, taking up a fighting stance.", false);
			doNext(11031);
			return;
		}
		outputText("You are brought into a room full of moaning humans, lined up in machines along the walls. You can see they're apparently sorted by age, as the victims' hair turns more and more grey and silver as you look down the line toward the far wall. All of them are hermaphrodites, the older individuals seeming to have larger breasts and genitals than the younger ones.  Most have a number of syringes embedded into their bodies, pumping them full of tainted chemical aphrodisiacs and demonic mutagens.  Clear cups and tubes are attached to leaky nipples, pulling steady streams of milk from the insensible captives as they pant and moan like drug-addicted sluts.  Similar tubes cradle their enhanced man-hoods, rhythmically squeezing cum from their constantly orgasming bodies.  Hoses suck away the jizz and milk, pumping it to places unknown.  Despite yourself, you are beginning to be majorly turned on, realizing that you'll probably become another milk-dripping pleasure-addict in a few minutes.\n\n", false);
		outputText("\"<i>Time to serve your purpose, insect,</i>\" says the incubus, gesturing towards an empty harness. You stand immobile, either from fear or lust, until the incubus shoves you into the machine.  It automatically straps you down, leather pieces crisscrossing over your body and holding you in place.  You see something move at the edge of your vision, but due to the harness you can't turn your head to see it.  Something sharp pinches your neck and you fade to blackness....", false);
		doNext(11025);
		return;
	}
	//Trade Hentai Comic for Safety
	if(eventNo == 11034) {
		spriteSelect(30);
		outputText("You hand over the Hentai Comic tentatively to the male sex demon.  As soon as he has it in his grubby mits he sits down and starts thumbing through the pages, toying with his half-hard member the entire time.  He must really like porn.", true);
		player.removeKeyItem("Hentai Comic");
		player.createStatusAffect("IncubusBribed",0,0,0,0);
		doNext(1);
		return;
	}
	//Incubus Cock-Trip Attack
	if(eventNo == 11035) {
		//Blind dodge change
		if(monster.hasStatusAffect("Blind") >= 0) {
			outputText(monster.capitalA + monster.short + " suddenly grows its dick to obscene lengths and tries to trip you with it.  Thankfully he's so blind he wasn't aiming anywhere near you!!", false);
			combatRoundOver();
			return;
		}
		outputText("The incubus lunges forward in a clumsy attack that you start to side-step, only to feel something grip behind your " + buttDescript() + " and pull your  " + player.legs() + " out from under you.", false);
		if((player.spe-30) > rand(60)) {
			outputText("  You spin as you fall, twisting your " + player.legs() + " free and springing back to your " + player.feet() + " unharmed.", false);
		}
		//Fall down go boom
		else {
			outputText("  You land hard on your ass, momentarily stunned as the demonic cock-tentacle curls around your " + player.legs() + ", smearing them with oozing demonic fluids.", false);
			if(player.lust >= 80 || player.cor >= 80) {
				outputText("  Moaning with desire, you lick your lips as you slide your well-lubricated " + player.legs() + " free.  You gather a dollop of cum and lick it seductively, winking at the incubus and hoping to make him cave into his desire.", false);
				dynStats("lus", 13, "cor", 1);
			}
			else {
				if(player.lust >= 50 || player.cor >= 50) {
					outputText("  Blushing at the scent and feel of cum on your " + player.legs() + ", you twist and pull free.  You find yourself wondering what this demon's dick would taste like.", false);
					dynStats("lus", 8 + player.cor/20);
					
				}
				else {
					outputText("  Disgusted, you pull away from the purplish monstrosity, the act made easier by your well-slimed " + player.legs() + ".", false);
					dynStats("lus", 5 + player.cor/20);
				}
			}
			takeDamage(5);
		}
		outputText("\nThe incubus gives an overconfident smile as his cock retracts away from you, returning to its normal size.", false);
		combatRoundOver();
		return;
	}
	//Incubus Spooge Attack
	if(eventNo == 11036) {
		//Blind dodge change
		if(monster.hasStatusAffect("Blind") >= 0) {
			outputText(monster.capitalA + monster.short + " pumps his thrust lewdly before cumming with intense force in your direction!  Thankfully his aim was off due to the blindness currently affect him.", false);
			combatRoundOver();
			return;
		}
		outputText("Your demonic foe places his hands behind his head and lewdly pumps and thrusts his hips at you.  Your eyes open wide as a globule of cum erupts from the demon-prick and flies right at you.  ", false);
		outputText("You do your best to dodge, but some still lands on your ", false);
		temp = rand(3);
		//Face
		if(temp == 0) {
			outputText("face.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your mouth and nose!  You can feel it moving around inside you, doing its best to prepare you for its master.", false);
			dynStats("lus", 3);
			if(player.hasStatusAffect("DemonSeed") < 0) player.createStatusAffect("DemonSeed",5,0,0,0);
			else player.statusAffects[player.hasStatusAffect("DemonSeed")].value1 += 7;
			player.slimeFeed();
		}
		//Chest
		if(temp == 1) {
			if(player.hasFuckableNipples()) {
				outputText(allBreastsDescript() + ".  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way into your open nipples.  You can feel it moving around inside you, doing its best to prepare you for its master.", false);
				dynStats("lus", 3);
				if(player.hasStatusAffect("DemonSeed") < 0) player.createStatusAffect("DemonSeed",5,0,0,0);
				else player.statusAffects[player.hasStatusAffect("DemonSeed")].value1 += 8;
				player.slimeFeed();
			}
			else outputText(allBreastsDescript() + ".  Thankfully it doesn't seem to have much effect.", false);
		}
		//Crotch
		if(temp == 2) {
			if(player.vaginas.length > 0) {
				outputText("crotch.  The gooey demon-seed oozes and slides over you with a mind of its own, forcing its way past your " + player.armorName + " and into your " + vaginaDescript(0) + ".  You can feel it moving around inside you, doing its best to prepare you for its master.", false);
				dynStats("lus", 3);
				if(player.hasStatusAffect("DemonSeed") < 0) player.createStatusAffect("DemonSeed",5,0,0,0);
				else player.statusAffects[player.hasStatusAffect("DemonSeed")].value1 += 8;
				player.slimeFeed();
			}
			else outputText("crotch.  Thankfully, it doesn't seem to have much effect.", false);
		}
		combatRoundOver();
		monster.lust -= 10;
		if(monster.lust < 0) monster.lust = 10;
		return;
	}
	//UNUSED
	if(eventNo == 11037) {
		
	}
	//Incubus Loss Rape
	if(eventNo == 11038) {
		incubusLossRape();
		return;
	}
	//Incubus Victory Service
	if(eventNo == 11039) {
		incubusVictoryService();
		return;
	}
	//Tension release
	if(eventNo == 11040) {
		outputText("", true);
		//First time...
		if(player.hasStatusAffect("TensionReleased") < 0) {
			outputText("You nod and step forwards, allowing her to hook up a modified harness and inject you with the demonic concoction.  In no time heat boils through your veins, pooling on your chest and crotch.  ", false);
			if(player.biggestTitSize() < 10) {
				player.growTits(1, (2+rand(3)), true, 1);
				outputText("  ", false);
			}
			outputText("You glance over to the pile of glistening entwined bodies as they writhe in pleasure, and find yourself drawn in to the mass.  You spend the next four hours suckling tainted breast milk, fucking gaping pussies, and doing your damnedest to milk as much cum from the dick-girls around you.  Eventually the drugs work their way out of your system, leaving you to recover on the floor.  Cum, milk, and sweat drip from your nude form as you try to clean up and get dressed.", false);
			dynStats("int", -2, "lib", 4, "lus=", 0, "cor", 4);
			player.slimeFeed();
			player.createStatusAffect("TensionReleased",0,0,0,0);
		}
		//Second/third times...
		else {
			//[[2nd time]] 
			if(player.statusAffects[player.hasStatusAffect("TensionReleased")].value1 == 0) {
				outputText("You eagerly put on the modified harness and let them inject you with more of those body-altering chemicals.  As they fill you with artificial lust and desire, you cry out and beg for more.  They oblige you and give you a larger dose than the first time.  ", false);
				//Grow dick!
				if(player.cocks.length > 0) {
					player.lengthChange(player.increaseCock(5,0), player.cocks.length);
					if(player.averageCockLength() >= 9 && player.averageCockThickness() < 2) {
						outputText("You feel yourself gain in thickness as well, to match your new length.  ", false);
						temp = player.cocks.length;
						while(temp > 0) {
							temp--;
							if(player.cocks[temp].cockThickness < 2) player.cocks[temp].cockThickness++;
						}
					}
					else if(player.averageCockLength() >= 15 && player.averageCockThickness() < 3) {
						outputText("You feel yourself gain in thickness as well, to match your new length.  ", false);
						temp = player.cocks.length;
						while(temp > 0) {
							temp--;
							if(player.cocks[temp].cockThickness < 3) player.cocks[temp].cockThickness++;
						}
					}
				}
				//Grow chest
				//(If player has 0 bewbs)
				if(player.breastRows.length == 0) {
					player.createBreastRow();
					outputText("Your chest tingles, revealing a pair of pink nipples on your new mammory glands.  ", false);
				}
				player.growTits(1, (2+rand(3)), true, 1);
				outputText("  ", false);
				outputText("Your " + nippleDescript(0) + "s ", false);
				if(player.cocks.length > 0) outputText("and " + multiCockDescript(), false);
				outputText(" become rock hard, leaking fluids constantly.  ", false);
				//MALE
				if(player.cocks.length > 0 && player.vaginas.length == 0) outputText("Glancing over into the sea of sex, you find yourself drawn to the nearest pussy, as if it was the only thing in the world to matter.  You lose track of the time as you fuck hard dozens of gaping cunts, each of them overflowing with cum from all participants in this infernal orgy.  ", false);
				//FEMALE
				if(player.vaginas.length > 0 && player.cocks.length == 0) {
					outputText("As you enter the sex-crazed crowd, you notice several \"girls\" with demonic cocks bloated by the use of drugs, getting drawn to you by the scent of your dripping wet " + vaginaDescript(0) + ". Sitting on the floor, you spread your legs wide, facing the nearest one with an inviting lewd moan, while you hungrily grab another cum-covered cock, that just filled up an obscenely wide gaping vagina, to suck it.  You are soon penetrated and fucked hard and deep, one huge infernal dick after another, as they all cum into you in turn. ", false);
					player.cuntChange(150, true);
				}
				//HERM
				if(player.vaginas.length > 0 && player.cocks.length > 0) outputText("You feel your " + multiCockDescript() + " getting milked by many wet holes, though you are too busy sucking cocks and moaning in ecstasy to notice who they belong to.  ", false);
				outputText("The next eight hours are lost to your desires as you cum over and over, feeling mind-shattering pleasure.  You recover a while on the floor, soaked with a mixture of milk, cum, and pussy-juice.  Getting dressed is a bit troublesome with the recent changes, but you manage to squeeze back into your " + player.armorName + ".  You walk away while still feeling horny, and the moaning of the girls behind you doesn't help.  Maybe you could stay for another round...", false);
				dynStats("int", -2, "lib", 4, "lus=", 0, "cor", 4);
				player.createStatusAffect("TensionReleased",0,0,0,0);
				player.statusAffects[player.hasStatusAffect("TensionReleased")].value1++;
				player.slimeFeed();
			}
			//Third time
			else {
				outputText("Desperate for more of the demon-drugs, you slide into the now-familiar harness and let the needles sink into your skin.   Panting in lust, you beg for them increase the dosage again.   Desire burns through your veins as the cocktail surges through them", false);
				if(player.cocks.length > 0) {
					outputText(", filling your " + multiCockDescriptLight(), false);
					outputText(" with sensation", false);
					if(player.cockTotal() == 1) outputText("s", false);
					outputText(" as ", false);
					if(player.cocks.length > 1) outputText("they", false);
					else outputText("it", false);
					outputText(" grow", false);
					if(player.cocks.length == 1) outputText("s", false);
					outputText(" massive and engorged.  ", false);
				}
				else outputText(".  ", false);
				outputText("Your " + nippleDescript(0) + "s throb, becoming hard, puffy, and starting to dribble milk.  ", false);
				if(player.vaginas.length > 0) outputText("Your pussy is instantaneously soaked, filling the air with the scent of sex.  ", false);
				outputText("The desire for more of the drugs battles with your need to fuck and be fucked, until a small functioning part of your brain realizes it'll be easier to get sex than to get more of the drug.  You pull free and throw yourself into the mass of sweaty bodies, losing yourself in the salty tang of sweat and sex, pleasing nipples, clits, and cocks with your hands, and giving and receiving as much pleasure as you can.  You're in heaven.  Vaguely you realize time is passing, but it is a secondary concern next to the idea of having another groin-soaking orgasm.   You fuck and suck until you pass out from delirium.\n\n", false);
				//GAME OVERZZ
				outputText("In time you wake, your body aching both from the exertion and a desire for more.  On one hand you had a mission here, but why fight and struggle with danger and loneliness when you could be high on sex and cumming near-constantly?  You cuddle up to an exhausted girl and decide to wait for the drug-mistresses to give you another turn in the pile.  One of them turns, as if noticing your train of thought, and wheels over a breast-pump.  She hooks it up to your still-leaking nipples and you ", false);
				if(player.biggestLactation() >= 3) outputText("moo", false);
				else outputText("moo", false);
				outputText(" with happiness, promising another dose to you if you are a good cow for her.", false);
				doNext(5035);
				return;
			}
			
		}
		doNext(1);
		return;
	}
	//Accept Omnibus' Offer
	if(eventNo == 11041) {
		spriteSelect(16);
		outputText("She smiles, sauntering closer.  Your eyes widen in shock as her vulva are spread apart by something inside her.   A slick and growing cock emerges, sprouting from where her clit should be located.  She's a hermaphrodite.  You don't have time to contemplate the implications, as the demoness used your temporary distraction to sink a needle into your neck.  You sigh and black out almost instantaneously, letting her catch you with her strong arms and soft bosom.", true);
		doNext(11025);
		return;
	}
	//Fight Omnibus
	if(eventNo == 11042) {
		outputText("You strike a combat pose and prepare your " + player.weaponName + ".  She smiles and saunters around the desk, letting something bulbous and fleshy drop free from between her nether-lips.  You watch in shock as it hardens into a dick, growing right from where her clit should be.\n\nShe taunts, \"<i>Like what you see cow?  I'll be sure to visit you in the pens.</i>'\"", true);
		eventParser(11045);
		spriteSelect(16);
		return;
	}
	//Omnibus Lust Aura;
	if(eventNo == 11043) {
		outputText("The demoness blinks her eyes closed and knits her eyebrows in concentration.  The red orbs open wide and she smiles, licking her lips.   The air around her grows warmer, and muskier, as if her presence has saturated it with lust.", false);
		if(monster.hasStatusAffect("Lust Aura") >= 0) {
			outputText("  Your eyes cross with unexpected feelings as the taste of desire in the air worms it's way into you.  The intense aura quickly subsides, but it's already done its job.", false);
			dynStats("lus", (8+int(player.lib/20 + player.cor/25)));
		}
		else {
			monster.createStatusAffect("Lust Aura",0,0,0,0);
		}
		combatRoundOver();
		return;
	}
	//Omnibus Milk Attack
	if(eventNo == 11044) {
		temp = rand(2);
		if(temp == 0) outputText("The demoness grips her sizable breasts and squeezes, spraying milk at you.\n", false);
		else outputText("Your foe curls up to pinch her nipples, tugging hard and squirting milk towards you.\n", false);
		if((player.spe > 50 && rand(4) == 0) || (player.hasPerk("Evade") >= 0 && rand(3) == 0) || (player.hasPerk("Misdirection") >= 0 && rand(4) == 0 && player.armorName == "red, high-society bodysuit")) {
			outputText("You sidestep the gushing fluids.", false);
		}
		//You didn't dodge
		else {
			if(rand(2) == 0) outputText("The milk splatters across your face and chest, soaking you with demonic cream.  Some managed to get into your mouth, and you swallow without thinking.  It makes you tingle with warmth.  ", false);
			else {
				outputText("The milk splashes into your " + player.armorName + ", soaking you effectively.  ", false);
				if(player.cocks.length > 0) {
					outputText("Your " + cockDescript(0) + " gets hard as the milk lubricates and stimulates it.  ", false);
					dynStats("lus", 5);
				}
				if(player.vaginas.length > 0) {
					outputText("You rub your thighs together as the milk slides between your pussy lips, stimulating you far more than it should.  ", false);
					dynStats("lus", 5);
				}
			}
			dynStats("lus", 7 + player.sens/20);
			if(player.biggestLactation() > 1) outputText("Milk dribbles from your " + allBreastsDescript() + " in sympathy.", false);
		}
		combatRoundOver();
		return;
	}
	//Omnibus Combat Start
	if(eventNo == 11045) {
		player.createStatusAffect("FactoryOmnibusDefeated", 0, 0, 0, 0);
		startCombat(new OmnibusOverseer(),true);
		spriteSelect(16);
		return;
	}
	//Omnibus loss rape 1
	if(eventNo == 11046) {
		omnibusLossRape();
		spriteSelect(16);
		return;
	}
	//rape pt2!
	if(eventNo == 11047) {
		omnibusLossRape2();
		spriteSelect(16);
		return;
	}
	//Omnibus TITS
	if(eventNo == 11048) {
		spriteSelect(16);
		outputText("", true);
		//Grow if none
		if(player.breastRows.length == 0) {
			outputText("<b>Your chest swells out, forming rounded C-cup globes, capped with tiny erect nipples!</b>", true);
			player.createBreastRow();
			player.breastRows[0].breastRating = 3;
			player.nippleLength = .25;			
		}
		//Singular row - cup size + 3.  Nipple size to 1" if smaller.
		else if(player.breastRows.length <= 1) {
			outputText("Your " + allBreastsDescript() + " tingle pleasantly as the magic takes effect.  You watch with fascination as they begin to swell up, like sponges exposed to water.  The top of your " + player.armorName + " is pulled tight by change, until your chest seems ready to burst free.  <b>You've gained 3 cup sizes!</b>  ", false);
			player.breastRows[0].breastRating += 3;
			if(player.nippleLength < .75) {
				player.nippleLength += .5;
				outputText("Your " + nippleDescript(0) + "s grow hard and sensitive, becoming much more noticable inside your " + player.armorName + ".  It appears your nipples are have grown larger to match.", false);
			}
		}
		//Multiple Rows...
		else {
			//Top row + 3, all other rows brought up to par.
			outputText("Your top " + breastDescript(0) + " tingle pleasantly as the magic takes effect.  You watch with fascination as they begin to swell up, like sponges exposed to water.  The top of your " + player.armorName + " is pulled tight by change, until you're chest seems ready to burst free.  <b>You've gained 4 cup sizes!</b>  ", false);
			player.breastRows[0].breastRating += 4;
			outputText("The next row of " + breastDescript(1) + " jiggle and tingle with even more pleasure than the first.  They pulsate for a few seconds, shrinking and growing rapidly until they settle at a size just below your top " + breastDescript(0) + ".  ", false);
			player.breastRows[1].breastRating = player.breastRows[0].breastRating-1;
			if(player.breastRows.length >= 3) {
				outputText("Your third group of " + breastDescript(2) + " seem to follow their sister's example, and settle tingle briefly before settling at a size just below the breasts above.  ", false);
				player.breastRows[2].breastRating = player.breastRows[1].breastRating-1;
			}
			if(player.breastRows.length >= 4) {
				outputText("Your remaining " + breastDescript(3) + " feel so wonderful that you just can't resist cupping and squeezing them as they reshape to fit in perfectly with the rest of your breasts.  ", false);
				player.breastRows[3].breastRating = player.breastRows[2].breastRating-1;
				if(player.breastRows.length == 5) player.breastRows[4].breastRating = player.breastRows[3].breastRating-1;
			}
			if(player.nippleLength < .75) {
				player.nippleLength += .5;
				outputText("Your " + nippleDescript(0) + "s grow hard and sensitive, becoming much more noticable inside your " + player.armorName + ".  It appears your nipples are have grown larger to match.", false);
			}
		}
		outputText("\n\n", false);
		eventParser(11055);
		return;
	}
	//Omnibus DICK
	if(eventNo == 11049) {
		spriteSelect(16);
		outputText("", true);
		//No dick?  Grow one!
		if(player.cocks.length == 0) {
			outputText("A sudden pressure builds in your groin.  You look down in wonder, more than a little turned on by the prospect of growing your own penis.  Your skin ripples and bulges outwards, the sensation turning from pressure to feelings of intense warmth.  The bump distends, turning purple near the tip as it reaches three inches in size.  You touch it and cry out with pleasure, watching it leap forwards another inch in response.  Your tiny dick's crown becomes more and more defined as it grows larger, until you have what looks like a normal six inch dick.  You sigh with happiness and desire at your new addition.  Before you can enjoy it, another wave of heat washes through you, making your new addition respond.  It grows painfully hard as it crests eight inches in length.  ", false);
			if(player.cor < 80) outputText("In horror you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your cock look more like a crazed sex-toy than a proper penis.  You pant and nearly cum as it lengthens one last time, peaking at ten inches long.  One last ring of nodules forms around the edge of your demon-dick's crown, pulsating darkly with each beat of your horrified heart.", false);
			else outputText("Curious, you watch the skin turn a shiny-dark purple.  Tiny wriggling nodules begin to erupt from the purplish skin, making your penis look more like those amazing cocks you saw on demons!  You pant and moan in happiness as it lengthens one last time, peaking at ten inches long.  The excitement of possessing such a magnificent pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your new demon-dick's crown, you notice to your surprise that the liquid you ejaculated is pitch black!  But as your new cock pulsates darkly with each beat of your heart, the only thing you have on your mind is to try it out as soon as possible...", false);
			player.createCock();
			player.cocks[0].cockType = CockTypesEnum.DEMON;
			player.cocks[0].cockLength = 10;
			player.cocks[0].cockThickness = 2;
			genderCheck();
		}
		if(player.cocks.length == 1) {
			if(player.demonCocks() < 1) {
				outputText("You smile, watching your " + cockDescript(0) + " grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed tool, a wave of burning desire passes through you.  ", false);
				if(player.cor < 80) outputText("You watch in horror as the skin of your " + cockDescript(0) + " turns shiny and purplish-black.  ", false);
				else outputText("Curious, you watch the skin of your " + cockDescript(0) + " turn a shiny-dark purple.  ", false);
				player.cocks[0].cockLength += 3 + rand(5);
				player.cocks[0].thickenCock(2);
				player.cocks[0].cockType = CockTypesEnum.DEMON;
				if(player.cor < 50) outputText("Corrupt nodules begin to spring up over its entire length.  <b>Your penis is transforming into a " + cockDescript(0) + "!<\b>  The new nubs wriggle about as they sprout over every inch of surface, save for the head.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crown of your " + cockDescript(0) + ", seemingly completing its transformation, until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes!  ", false);
				else outputText("As you watch expectantly, tiny wriggling nodules begin to erupt from the purplish skin, like those magnificent cocks you saw on demons!  <b>Your penis is transforming into a " + cockDescript(0) + "!<\b>  You pant and moan in happiness as it lengthens one last time.  As you stroke all of its amazing length with both hands, the excitement of possessing such a beautiful pleasure tool makes you cum.  As one last ring of nodules forms around the edge of your " + cockDescript(0) + "'s crown, you notice that the squirts getting out of your cock-slit are not completely white and gradually become darker, the last drops being pitch-black! Your new " + cockDescript(0) + " pulsates darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke the huge, dark, bumpy shaft, that if this feels as good as this looks, it doesn't really matter.  ", false);
			}
			else {
				outputText("Your " + cockDescript(0) + " leaps forwards, taking to the dark magic with ease.  Inch after inch of new length erupts from your groin as your " + cockDescript(0) + " gets longer and thicker.  It pulsates, as if promising dark pleasure as it settles into its new enhanced size.", false);
				player.cocks[0].cockLength += 6 + rand(10);
				player.cocks[0].thickenCock(3);				
			}
		}
		if(player.cocks.length > 1) {
			//Already has demoncocks
			if(player.demonCocks() == player.cockTotal()) {
				outputText("Your " + multiCockDescriptLight() + " leap forwards, taking to the dark magic with ease.  Inch after inch of new length erupts from your groin as your " + multiCockDescriptLight() + " get longer and thicker.  They pulsate, as if promising dark pleasure as they settle into their new enhanced size.", false);
				temp = player.cocks.length;
				while(temp > 0) {
					temp--;
					player.cocks[temp].cockLength += 6 + rand(10);
					player.cocks[temp].thickenCock(3);	
				}
			}
			//Not yet full of demoncocks...
			else {
				outputText("You smile, watching your " + multiCockDescriptLight() + " grow longer.  Inches of newfound dick-flesh erupt from your crotch in response to omnibus' dark magics.  Before you can play with your transformed pleasure tools, a wave of burning desire passes through you.  You watch", false);
				if(player.cor < 80) outputText(" in horror", false);
				else outputText(" curiously", false);			
				outputText(" as the skin of your " + multiCockDescriptLight() + " turns shiny and purplish-black.  Corrupt nodules begin to spring up over the entire length of each dick.  ", false);
				temp = player.cocks.length;
				while(temp > 0) {
					temp--;
					player.cocks[temp].cockLength += 3 + rand(5);
					player.cocks[temp].thickenCock(2);
					player.cocks[temp].cockType = CockTypesEnum.DEMON;
				}
				if(player.cor < 50) outputText("<b>Your dicks are transforming into " + multiCockDescriptLight() + "!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the heads.  Unable to do anything but groan with forced pleasure and horror, you can only watch.  One last batch of nodules forms in a ring around the crowns of your " + multiCockDescriptLight() + ", seemingly completing its transformation, until you notice, almost throwing up, that your testicles are also getting covered in black veins under your powerless eyes!  ", false);
				else outputText("<b>Your dicks are transforming into " + multiCockDescriptLight() + "!</b>  The new nubs wriggle about as they sprout over every inch of surface, save for the heads.  You pant and moan in happiness as they lengthen one last time.  As you stroke all of their amazing length with both hands, the excitement of possessing such a magnificent pleasure tool makes you cum. You lick your fingers eagerly, tasting your new cum, while a last ring of nodules forms around the crowns of your beautiful " + multiCockDescriptLight() + ".   Your new " + multiCockDescriptLight() + " pulsate darkly with each beat of your heart, but the thick, throbbing veins that are finishing to cover your testicles do not contain blood, but a black liquid which apparently has perverted them. You ponder what its purpose might be, but then you decide, as you stroke a huge, dark, bumpy shaft, that if they feel as good as they look, it doesn't really matter.  ", false);
			}
		}
		eventParser(11055);
		return;
	}
	//Omnibus Facial Normalization
	if(eventNo == 11050) {
		spriteSelect(16);
		outputText("", true);
		if(player.horns > 0 || player.antennae > ANTENNAE_NONE) {
			outputText("Your forehead itches intensely.  You cannot help but stratch madly at it.  ", false);
			if(player.horns > 0) {
				outputText("Your horns fall off, landing on the floor with a heavy thud.  ", false);
				player.horns = 0;
				player.hornType = HORNS_NONE;
			}
			if(player.antennae > ANTENNAE_NONE) {
				outputText("Antennae pop free, and float lightly down towards the floor.  ", false);
				player.antennae = ANTENNAE_NONE;
			}
		}
		//EARS
		if(player.earType != EARS_HUMAN) {
			outputText("Pain erupts from both sides of your head as your ears reform and move, returning to look like your old human ears!  ", false);
			player.earType = EARS_HUMAN;
		}
		//Face
		if(player.faceType != FACE_HUMAN) {
			outputText("Your facial structure rearranges itself into a normal human visage, exactly like yours was before you came to this horrid place.", false);
			player.faceType = FACE_HUMAN;
		}
		eventParser(11055);
		return;
	}
	//Omnibus Chest Normalization
	if(eventNo == 11051) {
		spriteSelect(16);
		outputText("", true);
		temp = 0;
		if(player.breastRows.length > 1) {
			player.removeBreastRow(1,player.breastRows.length-1);
			outputText("Your chest tingles and begins to feel lighter.  You hastily pull open your " + player.armorName + " and realize you only have " + allBreastsDescript() + " now!  ", false);
			if(player.nippleLength > 1) {
				outputText("Your nipples shrink down to a more normal size.  ", false);
				player.nippleLength = .75;
			}
			temp++;
		}
		//Size!
		if(player.breastRows[0].breastRating > 7) {
			outputText("The weighty flesh that constantly hangs from your chest gets lighter and lighter, vanishing rapidly.  ", false);
			player.breastRows[0].breastRating = 3 + rand(5);
			outputText("You now have " + allBreastsDescript() + ".  ", false);
			temp++;
		}
		//Single row
		else {
			//Fix nips
			if(player.nippleLength > 1) {
				outputText("Your nipples shrink down to a more normal size.  ", false);
				player.nippleLength = .75;
				temp++;
			}
			if(player.hasFuckableNipples()) {
				outputText("The vagina-like openings in your nipples close, sealing themselves shut.  ", false);
				player.breastRows[0].fuckable = false;
				temp++;
			}
		}
		//Normal chest, normal nips
		if(player.skinType != SKIN_TYPE_PLAIN) {
			outputText("The skin on your body itches intensely as it sheds it's " + player.skinDesc + ", revealing " + player.skinTone + " skin.  ", false);
			player.skinDesc = "skin";
			player.skinType = SKIN_TYPE_PLAIN;
			temp++;
		}
		//Nothing changed
		if(temp == 0) {
				outputText("You tingle briefly but feel no obvious change.  Your chest is already fairly human.", false);
		}
		eventParser(11055);
		return;
	}
	//Omnibus Crotch Normalization
	if(eventNo == 11052) {
		spriteSelect(16);
		//Temp used to track changes
		temp = 0;
		outputText("You feel a strange shivering sensation pass through you.  ", true);
		//Remove multiple.
		if(player.cocks.length > 1) {
			outputText("Your " + multiCockDescriptLight() + " shiver and retract back towards your body.  When the process finishes you are left with only your " + cockDescript(0) + ".  ", false);
			player.removeCock(1,player.cocks.length-1);
			genderCheck();
			temp++;
		}
		//Super long nerf
		if(player.hasCock()) {
			if(player.cocks[0].cockLength > 12) {
				outputText("A tingling sensation worms through your " + cockDescript(0) + " as it shrinks down to a more modest eleven inches.  ", false);
				player.cocks[0].cockLength = 11;
				temp++;
			}
			//Super thick nerf
			if(player.cocks[0].cockThickness > 2) {
				outputText("Your " + cockDescript(0) + "'s obscene thickness withers down to roughly two inches of girth.  ", false);
				player.cocks[0].cockThickness = 2;
				temp++;
			}
			//Humanitize
			if(player.cocks[0].cockType != CockTypesEnum.HUMAN && player.cocks[0].cockType != CockTypesEnum.DEMON) {
				outputText("The inhuman appearance of your " + cockDescript(0) + " shifts, the flesh rearranging itself into a more human configuration.  After a few seconds you have a very normal looking penis.  ", false);
				player.cocks[0].cockType = CockTypesEnum.HUMAN;
				temp++;
			}
			//If demon cocked....
			if(player.cocks[0].cockType == CockTypesEnum.DEMON) {
				outputText("Your " + cockDescript(0) + " tingles as the bumps begin to fade.  After a moment the flesh darkens, and every single nodule reappears.  <b>Your corrupt penis resisted the magic!</b>  ", false);
				temp++;
			}
		}
		//Balls shrink
		if(player.ballSize > 5) {
			temp++;
			outputText("The " + ballsDescriptLight() + " that constantly pull so heavily on your groin tingle and shrink down to a more managable size.  ", false);
			player.ballSize = 2 + rand(3);
		}
		if(temp > 0) outputText("\n\n", false);
		//Vajajay
		if(player.vaginas.length > 0) {
			if(player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) {
				outputText("The constant fluids leaking from your " + vaginaDescript(0) + " slow down, then stop.  ", false);
				player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
				temp++;
			}		
		}
		//Nothing changed
		if(temp == 0) {
			outputText("You tingle briefly but feel no obvious change.  Your crotch isn't really in need of becoming more human.", false);
		}
		eventParser(11055);
		return;
	}
	//Omnibus Leg Normalization
	if(eventNo == 11053) {
		spriteSelect(16);
		outputText("", true);
		if(player.lowerBody == LOWER_BODY_TYPE_HUMAN) outputText("You feel as if you should slap yourself for stupidy.  Your legs are already normal!  You flush hotly as the corrupt magics wash over you, changing nothing.", false);
		else outputText("You collapse as your " + player.legs() + " are unable to support you.  The sounds of bones breaking and reshaping fills the room, but oddly you feel no pain, only mild arousal.  You blink your eyes and sigh, and when you look down again <b>you have normal human legs</b>!", false);
		player.lowerBody = LOWER_BODY_TYPE_HUMAN;
		if(player.tailType > TAIL_TYPE_NONE) {
			outputText("  A moment later, your feel something detach from above your backside.  <b>You no longer have a tail!</b>", false);
			player.tailType = TAIL_TYPE_NONE;
			player.tailVenom = 0;
			player.tailRecharge = 5;
		}
		eventParser(11055);
		return;
	}
	//Omnibus Refuse & release
	if(eventNo == 11054) {
		spriteSelect(16);
		outputText("You refuse to fall for her ploy, and decide not to take her up on her offer.  However, being that she is so thoroughly defeated, you allow her to escape, promising her far worse should she ever oppose you in the future.\n\n\"<i>Thank you, merciful hero!</i>\" she says and she sprints out the door.  Wings unfurl from her back and she takes flight, disappearing out a skylight above the main factory floor.", true);
		cleanupAfterCombat();
		return;
	}
	//Omnibus Post-Boon stuff
	if(eventNo == 11055) {
		outputText("\n\nThe omnibus disappeared while you were examining the changes.  You guess you did get what you wanted.  You blush and smile, still feeling very horny.  You decide to use the privacy of the office to relieve the tension you've been building up since you arrived.\n\nYou masturbate quickly and efficiently, eager to calm down and resume your exploration.  In no time at all an orgasm crashes through your body.  Stretching and standing up, you find yourself still aroused.\n\nYou slap your forehead as realization washes over you - <b>the demoness' magic is keeping you from ever being totally satisfied!</b>\n(Perk Gained - Omnibus' Gift - Minimum lust has been increased!)", false);
		player.createPerk("Omnibus' Gift",0,0,0,0,"Raises your minimum lust by up to 35 and slightly reduces lust gain.");
		dynStats("lus=", 0, "cor", 2);
		cleanupAfterCombat();
		return;
	}
	//Omnibus Kill
	if(eventNo == 11056) {
		spriteSelect(16);
		outputText("You step forwards and grab her by the head.  With an abrupt twist you snap her neck, ending at least one small part of the demonic threat.", true);
		cleanupAfterCombat();
		return;
	}
	//Find Factory
	if(eventNo == 11057) {
		if(player.hasStatusAffect("Found Factory") < 0) {
			outputText("\n\n<b>The factory is now accessable from your places menu.</b>", false);
			player.createStatusAffect("Found Factory",0,0,0,0);
		}
		outputText("Rounding a bend in the mountainous foothills, you stumble upon a large and rusted iron structure belching cloying pink smoke from its tall smokestacks.  A bevy of green-tinged copper pipes stem from the rear of the building, climbing up the steep mountainside and disappearing into a hole in its face.  It must be some kind of demonic factory, though you've no idea what they could be pumping out.  High atop the roof, you spy a huge water tower fed by smaller pipes that run down the building's side and off in the direction of the lake.\n\nThere are no windows to the hellish factory, with only a single iron door adorning the front wall.  If you go inside there will undoubtedly be many demons to fight and little chance to escape. Death or worse awaits should you fall into their hands.\n\nDo you enter the factory or leave?", true);
		
		simpleChoices("Enter",11012,"",0,"",0,"",0,"Leave",13);
		return;
	}
	//Shut down factory!
	if(eventNo == 11058) {
		outputText("You resolve to shut down the factory, then destroy the controls.  You spend a few moments making sure you aren't about to do something disastrous.  A few deep breaths calm your nerves, letting you focus on pressing the correct buttons.  The constant thrumming of the machinery slowly dies down, closely followed by a chorus of disappointed moans.  You step over to the window and watch as the captives come out of their drug induced sex-comas.  A great deal of them gather up and leave, though you are unsure what their destination is.  A few seem to be gathering back around the equipment, and puzzling out how to operate it.  Maybe they liked being here...", true); 
		doNext(1);
		player.createStatusAffect("DungeonShutDown",0,0,0,0);
		return;
	}
	//Shut down overload
	if(eventNo == 11059) {
		outputText("You resolve to shut down the factory by overloading the storage tanks, rendering much of the equipment inoperable and difficult to repair.  With a quick twist of a knob, you override the pressure vents for the storage tanks.  Within minutes, you hear the sounds of popping rivets and straining pumps.  You look out over the factory floor and watch as many of the pipes fracture, dripping seed over the moaning captives.  Smoke rises from pumps as they short out and overheat.  The entire building shudders as a massive blast echoes from somewhere to the west.  A high pitched whine fills the building as the last motors shriek and die.  The captives slowly start to come to as the flood of drugs and artificial pleasure come to a stop.  Many break down and cry, others begin unhooking themselves and exploring their surroundings.  You watch with interest as many of them rally together and make for an exit.   The remaining survivors begin scavenging parts from the machinery and puzzling out how to use it.  Perhaps they liked it here.", true);
		doNext(1);
		player.createStatusAffect("DungeonShutDown",0,0,0,0);
		player.createStatusAffect("FactoryOverload",0,0,0,0);
		return;
	}
	//Take Supervisor's Key
	if(eventNo == 11060) {
		outputText("You search the desk and find a silver key labelled 'Supervisor'.\n\n(Supervisor's Key acquired!)", true);
		player.createKeyItem("Supervisor's Key",0,0,0,0);
		doNext(1);
		return;
	}
	//Take item from storage
	if(eventNo == 11061) {
		if(player.hasStatusAffect("TakenGro+") >= 0) player.statusAffects[player.hasStatusAffect("TakenGro+")].value1--;
		else player.createStatusAffect("TakenGro+",4,0,0,0);
		inventory.takeItem(consumables.GROPLUS);
		return;
	}
	//Take item from storage
	if(eventNo == 11062) {
		if(player.hasStatusAffect("TakenLactaid") >= 0) player.statusAffects[player.hasStatusAffect("TakenLactaid")].value1--;
		else player.createStatusAffect("TakenLactaid",4,0,0,0);
		inventory.takeItem(consumables.LACTAID);
		return;
	}
	//Take incubus in the butt
	if(eventNo == 11063) {
		incubusVictoryRapeBackdoor();
		return;
	}
	//Take incubus normally
	if(eventNo == 11064) {
		incubusVictoryRapeSex();
		return;
	}
	if(eventNo == 11065) {
		outputText("You laugh mockingly at the stupid demon, roaring, \"<i>I'm the bloody champion you vapid cunt!</i>\"\n\nShe whirls, her beautiful face marred by rage.  It looks like you have a fight on your hands...", true);
		//(START FIGHT – Succubus Defense -10)
		player.createStatusAffect("FactorySuccubusDefeated", 0, 0, 0, 0);
		startCombat(new SecretarialSuccubus(),true);
		monster.armorDef -= 10;
		return;
	}
	if(eventNo == 11066) dungeonLoc = 10;
	if(eventNo == 11067) dungeonLoc = 11;
	if(eventNo == 11068) dungeonLoc = 12;
	if(eventNo == 11069) dungeonLoc = 13;
	if(eventNo == 11070) dungeonLoc = 14;
	if(eventNo == 11071) dungeonLoc = 15;
	if(eventNo == 11072) dungeonLoc = 16;
	if(eventNo == 11073) dungeonLoc = 17;
	//Start fighting imp horde.
	if(eventNo == 11074) {
		startCombat(new ImpHorde(),true);
		eventParser(1);
		return;
	}
	if(eventNo == 11075) {
		inDungeon = false;
		dungeonLoc = 0;
		if(dungeonLoc == 0) {
			outputText("You leave the cave behind and take off through the deepwoods back towards camp.", true);
			doNext(13);
		}
		else eventParser(1);
		return;
	}
	//Enter Zetaz's Lair!
	if(eventNo == 11076) {
		inDungeon = true;
		dungeonLoc = 10;
		eventParser(1);
		return;
	}
	//Try to go to Zetaz's room from the south
	if(eventNo == 11077) {
		if(flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] == 0) {
			outputText("The door won't budge.", true);
			doNext(1);
			return;
		}
		else dungeonLoc = 16;
	}
	//Male rape
	if(eventNo == 11078) {
		impGangGetsRapedByMale();
		return;
	}
	//Fem imp gang rape
	if(eventNo == 11079) {
		impGangGetsRapedByFemale();
		return;
	}
	//Part 2 of imp mob bad-end
	if(eventNo == 11080) {
		loseToImpMobII();
		return;
	}
	if(eventNo == 11081) {
		getSwordAndGetTrapped();
		return;
	}
	if(eventNo == 11082) {
		flyToSwordAndGetTrapped();
		return;
	}
	if(eventNo == 11083) {
		loseToThisShitPartII();
		return;
	}
	if(eventNo == 11084) dungeonLoc = 17;
	if(eventNo == 11085) dungeonLoc = 18;
	if(eventNo == 11086) dungeonLoc = 19;
	if(eventNo == 11087) dungeonLoc = 20;
	if(eventNo == 11088) dungeonLoc = 21;
	if(eventNo == 11089) dungeonLoc = 22;
	if(eventNo == 11090) dungeonLoc = 23;
	if(eventNo == 11091) dungeonLoc = 24;
	if(eventNo == 11092) dungeonLoc = 25;
	if(eventNo == 11093) {
		takeGooArmor4Realz();
		return;
	}
	if(eventNo == 11094) {
		refuseGooArmorOffer();
		return;
	}
	if(eventNo == 11095) {
		takeGooArmorAndWearIt();
		return;
	}
	if(eventNo == 11096) {
		takeGooArmor();
		return;
	}
	if(eventNo == 11097) {
		inventory.takeItem(consumables.GODMEAD);
		flags[kFLAGS.HEL_DUNGEON_MEAD_LOOTED]++;
		return;
	}
	if(eventNo == 11098) {
		talkToKiri();
		return;
	}
	if(eventNo == 11099) {
		askKirkAboutHel();
		return;
	}
	if(eventNo == 11100) {
		 askKiriAboutHarpies();
		return;
	}
	if(eventNo == 11101) {
		askKiriAboutSalamander();
		return;
	}
	if(eventNo == 11102) {
		askKiriAboutKiri();
		return;
	}
	if(eventNo == 11103) {
		kiriSexIntro();
		return;
	}
	if(eventNo == 11104) {
		kiriSexAnal();
		return;
	}
	if(eventNo == 11105) {
		kiriSexGetLicked();
		return;
	}
	if(eventNo == 11106) {
		talkToValeria();
		return;
	}
	if(eventNo == 11107) {
		inventory.takeItem(weapons.SUCWHIP);
		flags[kFLAGS.HEL_DUNGEON_TAKEN_WHIP] = 1;
		return;
	}
	if(eventNo == 11108) {
		inventory.takeItem(armors.BONSTRP);
		flags[kFLAGS.HEL_DUNGEON_TAKEN_STRAPS] = 1;
		return;
	}
	if(eventNo == 11109) {
		inventory.takeItem(weapons.L_DAGGR);
		flags[kFLAGS.HEL_DUNGEON_TAKEN_DAGGER] = 1;
		return;
	}
	if(eventNo == 11110) {
		tortureGear();
		return;
	}
	if(eventNo == 11111) {
		helDungeonPrisonerTalk();
		return;
	}
	if(eventNo == 11112) {
		phoenixMissionary();
		return;
	}
	if(eventNo == 11113) {
		phoenixWanking();
		return;
	}
	if(eventNo == 11114) {
		gitButtRoadPhoenix();
		return;
	}
	if(eventNo == 11115) {
		phoenixAginal();
		return;
	}
	if(eventNo == 11116) {
		checkOutDemBirdBitches();
		return;
	}
	if(eventNo == 11117) {
		harpyQueenBeatsUpPCBadEnd(true);
		return;
	}
	if(eventNo == 11118) {
		harpyQueenAdvantage();
		return;
	}
	if(eventNo == 11119) {
		HeliaThroneRoom();
		return;
	}
	if(eventNo == 11120) {
		heliaHakonTalk();
		return;
	}
	if(eventNo == 11121) {
		heliaKiriTalk();
		return;
	}
	if(eventNo == 11122) {
		heliaQueenTalk();
		return;
	}
	if(eventNo == 11123) {
		letHarpyQueenGo();
		return;
	}
	if(eventNo == 11124) {
		harpyQueenLetHerGoForgive();
		return;
	}
	if(eventNo == 11125) {
		harpyQueenLetHerGoBerate();
		return;
	}
	if(eventNo == 11126) {
		killHarpyQueen();
		return;
	}
	if(eventNo == 11127) {
		fuckHarpyQueen();
		return;
	}
	if(eventNo == 11128) {
		harpyQueenSexAnal();
		return;
	}
	if(eventNo == 11129) {
		vaginalHarpyQueenSex();
		return;
	}
	if(eventNo == 11130) {
		harpyQueenInterrogate();
		return;
	}
	if(eventNo == 11131) {
		towerOutro();
		return;
	}
	if(eventNo == 11132) {
		takeQueensStaff();
		return;
	}
	if(eventNo == 11133) dungeonLoc = 23;
	if(eventNo == 11134) dungeonLoc = 24;
	if(eventNo == 11135) dungeonLoc = 25;
	if(eventNo == 11136) dungeonLoc = 26;
	if(eventNo == 11137) dungeonLoc = 27;
	if(eventNo == 11138) dungeonLoc = 28;
	if(eventNo == 11139) dungeonLoc = 29;
	if(eventNo == 11140) dungeonLoc = 30;
	if(eventNo == 11141) dungeonLoc = 31;
	if(eventNo == 11142) dungeonLoc = 32;
	if(eventNo == 11143) dungeonLoc = 33;
	if(eventNo == 11144) dungeonLoc = 34;
	if(eventNo == 11145) dungeonLoc = 35;
	if(eventNo == 11146) dungeonLoc = 36;
	if(eventNo == 11147) dungeonLoc = 37;
	if(eventNo == 11148) dungeonLoc = 38;
	if(eventNo == 11149) dungeonLoc = 39;
	if(eventNo == 11150) {
		inDungeon = false;
		dungeonLoc = 0;
		outputText("You leave the door behind and take off through the desert back towards camp.", true);
		doNext(13);
		return;
	}
	if(eventNo == 11151) {
		openZeDoorToParadize();
		return;
	}
	if(eventNo == 11152) {
		cumWitchDefeated();
		return;
	}
	if(eventNo == 11153) {
		riddleGameGo();
		return;
	}
	if(eventNo == 11154) {
		fuckItAttack();
		return;
	}
	if(eventNo == 11155) {
		sandMotherStuffGOA();
		return;
	}
	if(eventNo == 11156) {
		pullLever();
		return;
	}
	if(eventNo == 11157) {
		knockUpSomeDoubleStuffedSandWitches();
		return;
	}
	if(eventNo == 11158) {
		milkBathsAhoy();
		return;
	}
	if(eventNo == 11159) {
		takeBarrenPills();
		return;
	}
	if(eventNo == 11160) {
		takeFertilePills();
		return;
	}
	if(eventNo == 11161) {
		friendlyCumWitchBlessing();
		return;
	}
	if(eventNo == 11163) {
		fuckDatSphinx();
		return;
	}
	eventParser(1);
}

//BLAH!