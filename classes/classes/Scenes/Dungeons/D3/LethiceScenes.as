package classes.Scenes.Dungeons.D3
{
	import classes.BaseContent;
	import flash.net.SharedObject;
	import classes.StatusEffects;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.Items.WeaponLib;
	
	public class LethiceScenes extends BaseContent
	{
		
		public static const GAME_END_REDEMPTION:uint = 1;
		public static const GAME_END_CONSORT:uint = 2;
		public static const GAME_END_PURGE_0_50:uint = 3;
		public static const GAME_END_PURGE_50_100:uint = 4;
		public static const GAME_END_PURGE_100:uint = 5;
		public static const GAME_END_CONQUER_LOW:uint = 6;
		public static const GAME_END_CONQUER_MED:uint = 7;
		public static const GAME_END_CONQUER_HIGH:uint = 8;
		 
		public function LethiceScenes() {}
		
		private function exportSaveData():void {
			var currFileName:String = null;
			var sharedObject:SharedObject = null;
			var foundFreeFile:Boolean = false;
			var baseFileName:String = "CoC_EndExport_";
			var attemptNum:int = 1;
			while(!foundFreeFile)
			{
				currFileName = baseFileName + String(attemptNum);
				sharedObject = SharedObject.getLocal(currFileName,"/");
				if(sharedObject.size <= 100)
				{
					foundFreeFile = true;
				}
				sharedObject.close();
				attemptNum++;
			}
			getGame().saves.saveGameObject(currFileName, false);
			doNext(postEndingChoices);
		}
		
		public function encounterLethice():void {
			if (player.cor < 90)
				goFight();
			else {
				menu();
				addButton(0,"Fight",goFight);
				addButton(1,"Consort",joinHer);
			}
		}
		
		private function goFight():void
		{
			outputText("<i>“So be it.”</i> Lethice rises from her throne, pacing pensively back and forth. Wings unfurl from behind her back, casting you into the darkness of her demonic shadow. <i>“You seek a fight with the Queen of Mareth, and you shall have one.”</i> With feline grace, she launches herself dozens of feet into the air, flips forward, and snaps her wings out to catch her midair. <i>“My pets! My lovelies! Watch what this mortal’s foolishness earns " + player.mf("him","her") + "!”</i>");
			outputText("\n\nScattered applause breaks out as Lethice wings around to engage you.");
			if(!player.canFly())
			{
				outputText(" Good thing she’s not the only one that can fly!");
			}
			outputText("\n\n<b>It’s a fight!</b>");
			var m:Lethice = new Lethice();
			if(player.wingType != 0)
			{
				m.createStatusEffect(StatusEffects.PhysicalDisabled,0,0,0,0);
				m.createStatusEffect(StatusEffects.AttackDisabled,0,0,0,0);
			}
			if(flags[kFLAGS.MINOTAURKINGS_TOUCH] == 1)
			{
				player.createStatusEffect(StatusEffects.MinotaurKingsTouch,0,0,0,0);
			}
			startCombat(m);
		}
		
		public function defeated(hpVictory:Boolean):void
		{
			clearOutput();
			flags[kFLAGS.LETHICE_DEFEATED] = 1;
			if(hpVictory)
			{
				outputText("<i>“No,”</i> Lethice cries, dropping onto all fours, barely able to support herself. <i>“How c-can this be...”</i> She shakes her head, tries to stand, and collapses once more. <i>“My reign was to be eternal and unquestioned.”</i> Hatred burns in her eyes. <i>“You ruined it all.”</i> She spits on the ground, then struggles not to collapse into it.");
			}
			else
			{
				outputText("<i>“No,”</i> Lethice cries, shaking her head in denial. <i>“How c-can this be? How can you do this to me.”</i> She shudders, dropping onto all fours, barely keeping a hand out of her cunt by sheer force of will. It dances across the slip of fabric at her crotch, threatening to rebel at any moment. <i>“I’m not some ditsy, succubus slut.”</i> A whole-body shiver wracks her from head to toe. <i>“Gods, am I?”</i>");
			}
			outputText("\n\nThe question remains - what to do with her?");
			combat.cleanupAfterCombat();
			menu();
			if(player.hasCock())
			{
				addButton(0,"Plow Her",plowHer);
			}
			if(player.hasVagina())
			{
				addButton(1,"Queen Her",queenHer);
			}
			addButton(2,"Boob Play",boobPlay,hpVictory);
			var hasLethicite:Boolean = player.hasKeyItem("Sheila's Lethicite") > 0 || player.hasKeyItem("Stone Statue Lethicite") > 0;
			if (Boolean(hasLethicite) && flags[kFLAGS.MET_MARAE] > 0 && flags[kFLAGS.FACTORY_SHUTDOWN] == 1)
			{
				addButton(5, "Redemption", redemption, hpVictory);
			}
			addButton(14, "Skip Out", theChoiceDunDunDun, null, null, null, "Screw this! Skip out and make the choice.");
		}
		
		private function plowHer():void
		{
			clearOutput();
			outputText("After all you’ve been through, after everything you’ve fought and every enemy you’ve made... it all has come down to this: Lethice, the so-called Demon Queen, on her knees before you like any corrupted slut, helpless but to be just another sheathe for your cock. The realization fills your heart with a sense of pride and joy. Your quest is over, and now it’s time to reap your rewards.");
			outputText("\n\nYou");
			if(!player.isNaga())
			{
				outputText(" step");
			}
			else
			{
				outputText(" slither");
			}
			outputText(" forward, looming over the demoness’s defeated body, and grin down at her. She knows how this goes - who knows how many poor, innocent people have been in this same position before her? Now that the tables are turned, the demon just eyes the floor, refusing to meet your eyes until you reach down and grab her chin, forcing her to look at you.");
			outputText("\n\nAll the hatred, resentment, and indignation in her dragon’s eyes just makes you harder. She sneers at you, some last measure of defiance - so you pick her up and hurl her against the throne, putting her face-first where her ass was sat just a few minutes ago, thinking she was the biggest, baddest thing in Mareth. Lethice yelps, thrusting her wings around and grabbing at her arm rests to steady herself, try and stand back up. You put a stop to that in a hurry, planting a firm hand on her back between her draconic wings, and using the other to grab at the sheer fabric of her nun’s habit. It rips away easily, like it was designed to be torn away at a moment’s notice, leaving her flawless pink flesh bare to your inspection. Her small little breasts bob as the clothing supporting them is torn off, swaying and jiggling as you roughly position their owner just as you want her.");
			outputText("\n\nLethice turns, regarding you contemptuously over her shoulder. <i>“What are you waiting for, </i>Champion<i>?”</i> she spits. <i>“Can’t get it up?”</i>");
			outputText("\n\nYou reward her weak insult with a slap on the ass, as hard as you can make it. The demoness yelps, rocking forward with the impact; her ass jiggles and sways hypnotically, reddening where you hit her until you can see your hand print glistening on her ass. Practically a mark of ownership! Grinning to yourself, you do it again on the other cheek, swatting the queen hard enough that she can’t hold back a cry of... of pleasure?");
			outputText("\n\nGlancing down between her legs, you can see clear as day that her puffy pink pussy is glistening with moisture. Oh-ho, for such a haughty queen, Lethice might just have a hidden fetish deep down there... You give her another swat, and another, alternating cheeks as you make the Demon Queen croon with agonizing ecstasy. She fucking loves it! Ten spanks in and her crotch is a swamp, thighs bathed in glistening rivulets of her excitement. Ten more, and you’re fairly sure she orgasms, giving off a shrill cry of pleasure that echoes through the throne room. Every other demon in the place is silent for once, locked in a rapture of confusion and arousal.");
			outputText("\n\nAnd Lethice? Lethice is panting and gasping, whining with the lingering sting you’ve left on her bubble butt. You’re half sure she’s used her shapeshifting powers to pad her rump out, making her ass as full and soft as a cow-girl’s - and as sensitive as a clit, if the way just running your fingers across her bare behind makes her gasp and bite at her lip, wings batting weakly under your firm grasp.");
			outputText("\n\nYou’re already hard as a rock, your");
			if(player.cocks.length == 1)
			{
				outputText(" [cock]");
			}
			else
			{
				outputText(" cocks");
			}
			outputText(" [cocks] pushing uncomfortably against your [armor]. Deciding she’s had enough of an ass-beating, you shrug out of your gear and grab your prick, letting it flop mightily between Lethice’s up-turned cheeks. She gasps, clawing her fingers into the seat of her throne but finding no purchase as your [hips] bear down on her. After the spanking you’ve given her, though, Lethice is too lust-addled and weak-kneed to do anything but whimper and lift her spaded tail like a bitch in heat, all but inviting you to plow your cock into her sweet demon’s cunny.");
			if(player.cocks.length == 1)
			{
				outputText("\n\nUnless you have better plans...");
				menu();
				addButton(0,"Fuck Pussy",plowHerPussy);
				addButton(1,"Fuck Butt",plowHerButt);
				return;
			}
			outputText("\n\nOf course, with more than one cock, you can easily take advantage of everything the queen bitch has to offer...");
			menu();
			addButton(0,"Next",plowHerDouble);
		}
		
		private function plowHerPussy():void
		{
			clearOutput();
			outputText("Lethice is primed and ready, spanked into submission twice over and drooling with her eagerness for a victorious fucking. You have to wonder when the last time this haughty bitch was put on the bottom - how long has she gotten to play top dog, with nobody to tell her otherwise?");
			outputText("\n\nGrinning to yourself, you decide it’s high time you put Lethice in her place. You grab your [cock] and drag it through the sodden valley between her legs, slathering yourself in the steaming fuck-juice her first orgasm’s left behind before bringing your [cockHead] to rest firmly between the puffy lips of Lethice’s pink fuckhole.");
			outputText("\n\nBefore you can do anything else, Lethice manages one final act of defiance and thrusts her hips back against your tumescent shaft, taking you to the hilt in one sudden swoop. You gasp with a mix of surprise and absolute, overwhelming pleasure, having to grab her red flanks to keep from being pushed off the dias - or pushed over the edge to orgasm. You punish her would-be transgression with a firm spank, sending her ass-cheeks quaking around your buried shaft and making the sodden, silky sheath around your prick squeeze wonderfully tight.");
			outputText("\n\nLethice’s wings beat weakly against the throne, but her tail swishes around your [chest] - a clear sign she likes everything you’re doing to her. You grin and give the slender appendage a good yank, just enough to make its owner moan and grind her hips firmly against your crotch. Keeping the other hand on her shining-red rump to steady her, you start to pull back out, slowly taking your shaft back through every inch of her inhumanly wet twat. You withdraw all the way back, until just your [cockHead] is spreading her pussy open. Her cavernous hole seems to be sucking you back in before you can blink, though, and before you know it you’re starting pound away at the demoness’s upraised ass with abandon.");
			outputText("\n\nYou just can’t resist Lethice’s sex - she’s positively addictive, so tight yet so soft and welcoming inside that you could positively lose yourself in fucking her, day and night, forever and ever. Her pussy is magic around your member, so much so that you can barely restrain yourself from just hilting inside her and spilling your seed. You grab at Lethice’s hips, trying to anchor yourself, to hold back from the brink... but as if she knows what you’re trying to do, the demoness wails and throws back her head, sable locks tossed across your hands as she gives voice to her absolute, climactic ecstasy.");
			outputText("\n\nLethice’s orgasm treats you to a whole new kind of sensation. A wave of feminine slime floods past your [cock], lubing the demon’s slit up like never before and squirting a thick, musky feminine slime across her crotch and your pistoning hips. Your cock instantly finds itself in a firm, lube-slicked grip, being massaged and milking you for all you’re worth as the fallen queen surrenders to your sexual prowess. You try and hold back with all your might, determined not to let the defeated demon dictate when you cum.");
			outputText("\n\nRiding out her climax takes every ounce of willpower you have left, but in the end, it’s worth the strain just to make sure that only when Lethice has completely and totally given in, surrendered her body to you in a cascade of fem-cum... only then do you slam your hips hard against her battered ass, driving your [cock] to the hilt in her quivering quim before unleashing your load deep in Lethice’s womb, flooding her twat with every last drop of cum you’ve got.");
			outputText("\n\nWhen you’re done, you stagger back with a victorious howl of triumph. Cum drools in languid rivulets from Lethice’s thoroughly-bred pussy, pooling on the ground and intermixing with her own vast release of fem-cum. She’s completely motionless on the throne, save for ragged breaths and gasps of echoing pleasure. One of her hands absently tugs at her clit, stirring up the cascade of juices plastering her sex.");
			outputText("\n\nWith a smirk, you grab Lethice by the hips and yank her off the throne once and for all, letting the well-fucked slut marinate in the pool of cum you’ve left on the floor. She gives a final gasp of unexpected pleasure, collapsing beside the throne with a mighty beat of her wings. Content in your final victory, you swing yourself into her throne in her stead, letting Lethice’s half-conscious head rest against your leg. The other demons look positively");
			if(player.cor >= 66)
			{
				outputText(" gleeful");
			}
			else
			{
				outputText(" shocked");
			}
			outputText(" at what you’ve done, but none dare challenge the Champion in " + player.mf("his", "her") + " moment of victory.");
			outputText("\n\nAnd now, you’ve got a choice to make...");
			menu();
			addButton(0,"Next",theChoiceDunDunDun);
		}
		
		private function plowHerButt():void
		{
			clearOutput();
			outputText("As tempting as that drooling slit might be, you’ve got other plans for the Demon Queen. You grind your hips through the reddened, sensitive valley of her rump, making sure to slather up in the drenched swamp of her eager pussy. Lethice actually tries to push back against you, to take your throbbing cock when your crown parts her lips, but another rough spank and a push down into the throne stops that. This is <i>your</i> victory, and you’re not letting her decide how it goes down!");
			outputText("\n\nInstead, you grab your schlong and press the [cockHead] into the dark, tight ring of the demoness’s pert behind. She gasps and squirms, tail flicking weakly at you in protest, but there’s not a damn thing she can do to stop you now. Slowly, steadily, you push your [hips] forward against the resistant but weakened grip of Lethice’s ass. She tries to push you out on basic instinct, but a few extra spanks have her opening up and screaming your name as you drive your shaft on home.");
			outputText("\n\nShe cries out in pain and pleasure as she’s speared on your [cock], ass forced wide open to accept your throbbing manhood. Her mouth hangs open in a contorted look of shock and boundless pleasure, not even capable of screaming anymore by the time you bottom out inside her. Even the sultry shapeshifter seems unable, or perhaps unwilling, to adapt her ass to better suit your cock - she’s no different from a whimpering human virgin.");
			outputText("\n\nYou give her ass another appreciative spank, gasping at the way her asshole crunches down on your cock so hard even you can’t help but grunt with rising pleasure. Slowly, her body recovers, relaxing enough for you to move a little. You slowly piston your hips back out until just your cockhead remains buried in her ass, keeping her spread open. Another spank nearly pops you out of her, squeezed out by how hard she contracts - and this time she screams again, burying her face in the cushions of the throne as if to hide her shame and pleasure from her followers.");
			outputText("\n\nContent in Lethice’s complete and utter humiliation, you pick up the pace, starting to really fuck that demonic hole. Your [cock] slides eagerly back inside her, spreading those tight, silken walls back out before they can recover from the last thrust.");
			outputText("\n\n<i>“How do you like your queen now?”</i> you shout to the demon horde around you as you sodomize Lethice in full view of them all. Some of them actually cheer, but most take that as encouragement to start fucking each other, surrendering to the building lust that’s permeating the air around their defeated queen. You just laugh and jackhammer your hips, pounding away at the spasming demonic hole until its owner’s cries fade to a constant, wordless moan.");
			outputText("\n\nHer ass is like a silken vice around your [cock], so tight and yet so warm and hungry for more that you can barely restrain yourself from just hilting inside her and spilling your seed. You grab at Lethice’s hips, trying to anchor yourself, to hold back from the brink... but as if she knows what you’re trying to do, the demoness wails and throws back her head, sable locks tossed across your hands as she gives voice to her absolute, climactic ecstasy.");
			outputText("\n\nLethice’s orgasm treats you to a whole new kind of sensation. A flood of feminine slime slathers your thighs as she orgasms, squirting a thick, musky feminine slime across her crotch and your pistoning hips. Your cock, meanwhile, is massaged and groped with feverish ferocity, milking you for all you’re worth as the fallen queen surrenders to your sexual prowess. You try and hold back with all your might, determined not to let the defeated demon dictate when you cum.");
			outputText("\n\nRiding out her climax takes every ounce of willpower you have left, but in the end, it’s worth the strain just to make sure that only when Lethice has completely and totally given in, surrendered her body to you in a cascade of fem-cum... only then do you slam your hips hard against her battered ass, driving your [cock] to the hilt in her quivering asshole before unleashing your load deep in the demoness’s bowels, flooding her butt with every last drop of cum you’ve got.");
			outputText("\n\nWhen you’re done, you stagger back with a victorious howl of triumph. Cum drools in languid rivulets from Lethice’s thoroughly-fucked ass, pooling on the ground and intermixing with her own vast release of fem-cum. She’s completely motionless on the throne, save for ragged breaths and gasps of echoing pleasure.");
			outputText("\n\nWith a contemptuous smirk, you push Lethice off her throne once and for all, letting the sodomized slut marinate in the pool of cum you’ve left on the floor. Content in your final victory, you swing yourself into her throne{ and prop your feet up on the Demon Queen’s prostrate back, smearing her face down in your seed}. The demons look positively");
			if(player.cor >= 66)
			{
				outputText(" gleeful");
			}
			else
			{
				outputText(" shocked");
			}
			outputText(" at what you’ve done, but none dare challenge the Champion in " + player.mf("his", "her") + " moment of victory.");
			outputText("\n\nAnd now, you’ve got a choice to make...");
			theChoiceDunDunDun();
		}
		
		private function plowHerDouble():void
		{
			clearOutput();
			outputText("You smirk down at Lethice’s winged back and reddened ass, letting your multiple cocks tell her what’s in store. Your [cock] presses against the tight, dark ring of her asshole while the");
			if(player.cocks.length == 2)
			{
				outputText(" other");
			}
			else
			{
				outputText(" next");
			}
			outputText(" member sloppily nestles between the lips of her pussy, slathering its crown with demonic juices. Lethice can only groan and weakly struggle against your firm, dominant hand when she realizes what you intend.");
			outputText("\n\nRelentlessly, remorselessly, you push your [hips] forward against the desperate resistance of Lethice’s tight ass, and into the sloppy, welcoming embrace of her pussy. With a final, sudden release, you find yourself almost falling forward into her, slapping your hips against her sore rump. She cries out in pain and pleasure as she’s speared in both holes, spread wide open around your throbbing manhoods. Her mouth hangs open in a contorted look of shock and boundless pleasure, not even capable of screaming anymore by the time you bottom out inside her. Even the sultry shapeshifter seems unable, or perhaps unwilling, to adapt her body to the sudden double penetration.");
			outputText("\n\nFor now, at least, Lethice is taking this like a mere human. You give her ass another appreciative spank, gasping at the way her holes crunch down on your cocks, slathering the lower one with slick juices and squeezing the top so hard even you can’t help but grunt with rising pleasure. Slowly, her body recovers, relaxing enough for you to move a little, slowly pistoning your hips back out until just your cockheads remain buried in her holes. Another spank nearly pops you out of her, squeezed out by how hard she contracts - and this time she screams again, burying her face in the cushions of the throne as if to hide her shame and pleasure from her followers.");
			outputText("\n\nContent in Lethice’s complete and utter humiliation, you pick up the pace, starting to really fuck those demonic holes. One tight and resistant, one so eager for cock it almost swallows you in - the dichotomy is glorious, bathing you in a mix of sensations that drive your lusts absolutely wild. You grab at Lethice’s hips, trying to anchor yourself, to hold back from the brink... but as if she knows what you’re trying to do, the demoness wails and throws back her head, sable locks tossed across your hands as she gives voice to her absolute, climactic ecstasy.");
			outputText("\n\nLethice’s orgasm treats you to a whole new kind of sensation. A flood of feminine slime slathers your lower cock, while your upper is massaged and groped with feverish ferocity, both holes milking you for all you’re worth as their owner surrenders to your sexual prowess. You try and hold back with all your might, determined not to let the defeated demon dictate when you cum.");
			outputText("\n\nRiding out her climax takes every ounce of willpower you have left, but in the end, it’s worth the strain just to make sure that only when Lethice has completely and totally given in, surrendered her body to you in a cascade of fem-cum... only then do you slam your hips hard against her battered ass, driving your twin rods to the hilt in her body before letting loose a pent-up flood of cum.");
			outputText("\n\nWhen you’re done, you stagger back with a victorious howl of triumph. Two creamy white floods of spunk bubble up from her abused holes, splattering onto the ground between Lethice’s shaking legs. Even if she wanted to fight back any more, you know the demon’s completely at your mercy. She’s thoroughly broken, helpless to be anything but your personal cock-sock if you wanted.");
			outputText("\n\nWith a contemptuous smirk, you push Lethice off her throne once and for all, letting the well-fucked slut marinate in the pool of cum you’ve left on the floor. Content in your final victory, you swing yourself into her throne");
			if(player.isBiped())
			{
				outputText(" and prop your feet up on the Demon Queen’s prostrate back, smearing her face down in your seed");
			}
			outputText(".");
			outputText("\n\nAnd now, you’ve got a choice to make...");
			theChoiceDunDunDun();
		}
		
		private function queenHer():void
		{
			clearOutput();
			outputText("The Demon Queen is defeated. Some part of you knew this was where it had to end ever since you first heard of Lethice: with one of you on her knees, completely at the mercy of the other. Now, though... She looks almost... normal, in a way. Her default form, such as it is, seems like nothing more than a tall, lanky girl with horns - she doesn’t even sport the huge, drooling cock and tits of most of her slack-jawed minions standing around. If she closed her eyes and furled back her wings, you could almost imagine her as any of the priestesses from Ingnam.");
			outputText("\n\nBut she’s not. Queen Lethice is a sick mockery of their purity - the purity of the world you left behind. At least now she’ll never hurt anyone again. Not much of a queen, lying on her knees and reeling from the fight. She’s a plaything for you to use and discard, a living promise of one final climactic victory before you complete your quest. Smiling to yourself at the thought, you");
			if(!player.isNaga())
			{
				outputText(" step");
			}
			else
			{
				outputText(" slither");
			}
			outputText(" forward, pulling your [armor] off as you loom over the defeated demoness.");
			outputText("\n\n<i>“So that’s it?”</i> Lethice manages to groan, even as you push her over. She rolls onto her back, draconic wings spreading out around her like pools of midnight. <i>“You’re not so different from us after all. Go ahead, take me! Show just how far you’ve fallen!”</i>");
			outputText("\n\n");
			if(player.cor < 66)
			{
				outputText("Scowling at the haughty bitch’s implications");
			}
			else
			{
				outputText("Laughing right in the bitch’s face");
			}
			outputText(", you swing a [leg] over her and straddle her shoulders, shutting her up with a face-full of [cunt]. Lethice splutters and squirms under you, kicking her legs up in a pitiful show of resistance. Using your knees, you pin her arms and wings to the flagstone floor while you grab her by the horns, forcing her face up into your crotch. After a few moments, the demoness’s resistance falters, and you feel her full lips start to move. Some demonic instinct to just give in to sex, you think to yourself... that, or Lethice might just have a subby streak under all that bravado!");
			outputText("\n\nEither way, you’re treated to a kiss right on your lower lips, spreading them ever-so-slightly apart so that Lethice’s slender tongue can slide inside. You moan,");
			if(player.biggestTitSize() >= 2)
			{
				outputText(" cupping a tit");
			}
			else
			{
				outputText(" pinching one of your nipples");
			}
			outputText(" and arching your back as you feel her long, sinuous muscle slithering inside you like a snake - or a tentacle! Her talents as a shapeshifter become readily apparent as her tongue grows thicker and thicker, yet no less dexterous, spreading your pussy-lips and straining your slit with growing girth.");
			outputText("\n\nYou croon your approval, telling Lethice what a good little bottom bitch she is as you stroke her huge, curling horns. She shivers and moans into your twat like you’re giving her a handjob - from the hornplay or you putting her in her place, you don’t know. Maybe both! You just keep going, chewing on your lip to bite back little moans and gasps of pleasure. She’s good with her tongue... very, very good; thrusting in and our, wiggling it around your g-spot, flicking the sinfully soft tip around every inch of your vaginal walls.");
			outputText("\n\nLetting her continue on her way, you glance up to the remaining demons in the stands, and the horde flopping around the floor more towards the door. They hoot and holler, stroking their cocks or brazenly fingering themselves, urging you to claim your conquest any way you want. Clearly Lethice isn’t too well-loved, it seems - or demons just value voyeurism more than loyalty. Not surprising, but your heart still hammers all the harder for the added encouragement.");
			outputText("\n\nYour [hips] rock back and forth, smearing the demon’s chin with musky slime");
			if(player.hasCock())
			{
				outputText(" and dragging your [cock] across her face, smearing pre all through her hair");
			}
			outputText(". She keeps wriggling under you, trying to rest herself free of your pin, but you’re relentless in your determination: she’s not moving from this spot until you cum all over her face!");
			outputText("\n\n<i>“Lick harder, bitch!”</i> you shout, giving in to your dominant side and bucking your hips against Lethice’s demonic tongue.");
			outputText("\n\nShe does, and you instantly regret your command. The tongue buried inside you suddenly changes in texture, growing rings of concentric, rounded nubs all along its length that rub viciously against your walls with even the slightest motion, and she’s more than happy the thrust deep inside you, pounding away like a proper cock... but with all the flexibility of a tentacle, coiling around itself and exploring every inch of pussy it can get. Under that kind of pressure, you can’t help but moan and gasp, putting a hand on your belly and able to feel her tongue-cock inside yourself. Your flesh bulges obscenely, straining to contain Lethice’s immense cock.");
			outputText("\n\nUnder that kind of treatment, it doesn’t take long for you to reach your limit. With a shrill cry that echoes thunderously through the throne room, you give voice to your climax. Femcum pours freely down your thighs, drenching Lethice’s face and leaving her gasping for breath! The erstwhile queen’s long since given up struggling, surrendering to her fate as you positively drown her in your [cunt]. Her tongue stays buried to the hilt inside you, letting you bounce and grind on the nubby shaft to your heart’s content.");
			outputText("\n\nWhen the last shivering vestiges of orgasm finally pass, you sigh with satisfaction and stagger");
			if(player.isBiped())
			{
				outputText(" to your feet");
			}
			else
			{
				outputText(" off");
			}
			outputText(". Lethice is lying stunned on the ground, eyes rolled back in her head and face utterly smeared with your orgasmic juices. That’s a good look for you, you decide. Content in your final victory, you swing yourself into her throne");
			if(player.isBiped())
			{
				outputText(" and prop your feet up on the Demon Queen’s prostrate back, smearing her face down in your seed");
			}
			outputText(".");
			outputText("\n\nAnd now, you’ve got a choice to make...");
			theChoiceDunDunDun();
		}
		
		private function boobPlay(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("So this is the great and powerful Demon Queen, brought low");
			if(!hpVictory)
			{
				outputText(" by your superior sexual acumen");
			}
			else
			{
				outputText(" by the might of your [weapon]");
			}
			outputText(". She looks almost... normal, in a way. Her default form, such as it is, seems like nothing more than a tall, lanky girl with horns - she doesn’t even sport the huge, drooling cock and tits of most of her slack-jawed minions standing around. Strange, for a shapeshifter... maybe you can force her to fix that before you reap the fruits of your conquest!");
			outputText("\n\nYou grab the defeated demoness’s shoulders and");
			if(player.cor >= 66)
			{
				outputText(" throw her roughly onto her back");
			}
			else
			{
				outputText(" push her onto her back");
			}
			outputText(". The way she’s dressed, the way she looks so unsettlingly human... Lethice reminds you of an innocent maiden, locking her legs together and lying unresistant before you - like a girl on her wedding night. You lick your lips and tear away the tainted churchwear she’s clad herself in, revealing in full the pert mounds of her small breasts, and the puffy pink nipples at their peaks.");
			outputText("\n\n<i>“Well then, Champion?”</i> Lethice coos, her dark eyes fixed on you with a mix of apprehension and anticipation. <i>“I wonder what you-”</i>");
			outputText("\n\nYou cut her off, tired of hearing the self-righteous bitch talk. Your hands lock around her teats, pinching and pulling at the vulnerable peaks until their owner’s back arches, voice twisting into a shrill scream of pleasure and pain. The more you savage her perky little tits, though, you start to feel Lethice’s demonic flesh shiver and prickle under your fingers. And then it starts to grow. The Demon Queen’s titflesh starts to expand in your hands, filling out like a pair of balloons. Her nipples swell up too, the once compact little points expanding rapidly across her smooth flesh.");
			outputText("\n\nYour eyes go wide, staring at Lethice’s rapidly-growing chest. Your fallen foes gives you a teasing look, fluttering her eyelashes like an innocent maiden - she’s not even taking this seriously! Giving her a fearsome scowl, you rear back and give one of her swelling teats a rough slap. The sound echoes throughout the throne room, a thunderous sound that lays a hush over the crowd of demons. Lethice gasps, but her chest seems to hop up a whole cup size the moment you strike her alabaster flesh.");
			if(player.hasCock())
			{
				outputText(" They’re easily big enough to fuck now!");
			}
			outputText("\n\nYou’re half sure now that Lethice is just trying to entice you, but after all you’ve been through... everything you’ve done to get here... you don’t really care. You’re going to take your just rewards from the queen, whether she likes it or not.");
			if(player.hasCock())
			{
				outputText("\n\nYanking off your [armor], you grab your [cock] and let the hardening slab of meat flop into the growing valley of Lethice’s cleavage. The Demon Queen licks her lips at the sight of it, her dark eyes gleaming hungrily. You have to give her another rough push down, putting the demoness back in her place: she’s not in charge here!");
				outputText("\n\nHer back goes flat against the flagstone, making her grunt with surprise, but she just giggles and cups her breasts, inviting you to ravish the slip of flesh between them. Her tits are two plump orbs now, sinfully soft and jiggling with every one of their owner’s quickened breaths. You ram your hips forward, more than happy to take advantage of the quivering valley you’ve brought into existence. Each thrust between the Demon Queen’s tits just makes them grow more and more, at first lovingly caressing your [cock], then enveloping it completely. She’s quickly surrounded your entire member in her ever-expanding titflesh, and shows no sign of stopping! The once petite queen looks positively cowgirl-like now, and you’re starting to feel liquid sloshing around in her chest too! She gasps, and a squirt of pale purple milk squirts out of her now saucer-sized teats. Geysers of corrupted cream spurt out of her every time your [hips] slam into Lethice’s jiggling underside, eliciting a sensual moan from the soulless faux-nun with each mighty thrust.");
				outputText("\n\n<i>“So strong... so <b>vigorous</b>!”</i> Lethice moans, lifting herself onto her elbows to get a look at you over the still-inflating mass of her breasts. <i>“You fought so hard to get here, and now all you can think about is a pair of tits! It’s almost funny, Champion.”</i>");
				outputText("\n\nYou give one of her milky jugs another rough slap, but the masochistic demon just laughs and rolls her head back, letting the laugh turn into a feral moan of pleasure. Her cries of pleasure only make you want to fuck her harder - to put a stop to her obvious enjoyment of her punishment. Something about the Demon Queen getting off from you, as if you were");
				if(player.cor >= 66)
				{
					outputText(" any other corrupted soul of her court");
				}
				else
				{
					outputText(" like you’re some kind of demon yourself");
				}
				outputText(" is maddening!");
				outputText("\n\nWith a grunt of annoyance, you reach around the Demon Queen by the horns. She gasps in surprise and starts to say something, but you’re having none of it. You cut off her next teasing reprimand by giving the demon a mouthful of cock, bending her neck forward at an angle only a demon could manage, right into the depths of her cleavage. You don’t get to see her reaction, but the <i>glugging</i> sound and a sudden rush of pleasure around your [cockHead]. Lethice’s lips are thicker than you’d have thought, so plush and soft that you’re afraid their mere touch will send you over the edge.");
				outputText("\n\nYou’re pretty sure you hear Lethice mumbling something about your enjoyment of her, but the words are drowned out by her cock-laden lips. You give her a rough thrust through the valley of her cleavage, hammering at her mouth until she gives up talking to moan like a whore instead. Her tremendous wings beat against the stone of the floor, keeping pace with your thrusting [hips] until you start to worry she means to take off with you!");
				outputText("\n\nThankfully, you’re pretty sure the demoness’s grossly swollen tits are more than enough to keep her weighted to the ground. She’s probably put on fifty pounds of boob now, both so full of corrupted milk. You give her a gloating grin and reach up to tweak her nipples, making Lethice cry out around your [cockHead]. Now this is more like it!");
				outputText("\n\nThe Demon Queen’s finally learning her place: firmly planted on your cock, using every inch of her tainted body for your pleasure - and yours only. Seeing Lethice on her back, used like a common tramp, drives you wild with renewed lust. Pistoning your [hips] ever harder, you feel your climax rising steadily, milked out by the soft embrace of the demoness’s tits, now slathered with a thick coating of their owner’s milk like a glaze of lube.");
				outputText("\n\nYour hands close firmly on Lethice’s thick, pink teats, clutching hard enough to make her back arch beneath you. The added sensation of her tits grinding against your shaft, pinched between her writhing body and your firm hands, is just what you needed to send you over the edge. You feel a rush of spunk surging through your meaty shaft, rushing up to meet the Demon Queen’s lush red lips. The next thing you hear is a familiar choking, gasping cough as Lethice’s mouth is flooded with your seed. You keep pistoning your hips, hammering the queen’s corrupted mouth until you’ve spent every drop you have left into her.");
				outputText("\n\nWhen you’re done with her, the Demon Queen looks like any other well-used whore: ragged, gasping, drooling with your cum. She wasn’t so tough after all - just another demon that stood in your way. Sated, you stagger up and to the nearest place to rest: her throne. You collapse upon it, assured of your victory as you look out upon the defeated host of demons you plowed through to get here.");
				outputText("\n\nBut now... now you have a choice to make.");
			}
			else
			{
				outputText("\n\nOf course, she doesn’t have much to offer you right now. So plain, so... human. Were it not for the wings and horns, she might be just any other girl. But she <i>is</i> a demon - a shapeshifter, a being that exists as consummate pleasure incarnate. She can be anything you want her to be: and you want a whole new way to play with those growing tits of hers. You latch your hands around her nipples and give both swollen pink peaks a rough yank, making the queen croon in pleasure.");
				outputText("\n\n<i>“Ah! You’re positively <b>obsessed</b>, aren’t you, Champion?”</i> Lethice moans, chewing her lower lip seductively. <i>“You’ve come all this way, just to play with my tits. Why, if that’s all you wanted, you could have just asked. I’d have been more than happy to let a big, strong " + player.mf("man","woman") + " like you crawl into my lap and play with me until you came your soul right out for me.”</i>");
				outputText("\n\nYou give the Demon Queen a rueful grin. No way she’s getting your soul - not while she’s on her back, completely at your mercy. To the victor go the spoils...");
				outputText("\n\nYour hands keep groping and pulling on Lethice’s exposed nipples, and sure enough, they keep growing just like her tits were a moment ago, eagerly responding to your rough caresses. It’s like her body wants this, wants to mold itself into the perfect fuck-toy for you! A few more vindictive seconds of teasing and Lethice’s teats look like a pair of great big pink dicks: two pillars of flesh jutting up from her teats and drooling with purple-tainted demon-milk.");
				outputText("\n\nPerfect. You lick your lips with anticipation, crawling up the erstwhile queen’s prone form until your [hips] are grinding against the jiggly, milky mounds of the once-petite queen’s udders. She gives a little gasp, squirming in pleasure beneath you as you man-handle her towering teats, aligning one of them with your [vagOrAss]. <i>“Oooh, delightfully deviant,”</i> Lethice laughs, taking a deep breath that seems to make her chest swell up even more, nestling the base of her teat between your [legs]. As she does, you feel the tip of her teat shift, its flesh melding into the form of a human-like cock, complete with a rounded head and thick glans, perfect for your pleasure.");
				outputText("\n\nWell, at least she’s not <i>resisting</i>, you suppose.");
				outputText("\n\nWith corrupted milk all but pouring from Lethice’s engorged breast like from a fountainhead, it doesn’t take much to slip her slick shaft inside you, spreading out your hole around a pillar of thick demonic meat. You claim your prize: the body of the demon queen, brought low and reduced to your own personal whore. Even her body is molding itself to you, submitting to your every desire... But that’s your just deserts, your reward for finally laying low this tyrant, and ridding Mareth of its demon overlord once and for all!");
				outputText("\n\nGrinning to yourself, you grab the demoness’s oversized horns like a pair of handlebars and sink yourself down until her tits are pressed firmly to your ass, her meat buried completely inside. You shiver at the sensation of ice-cold milk squirting into your");
				if(player.hasVagina())
				{
					outputText(" womb");
				}
				outputText(" bowels");
				outputText(", pumping out of the Demon Queen like cum out of a real cock. It feels... good. <b>Really</b> good! The milk might be cold, but you feel a heat start spreading through your loins, spurring you to start really moving - to start taking all the pleasure that Lethice’s mutable body can give you!");
				outputText("\n\n");
				if(player.hasVagina())
				{
					outputText("One cock’s not enough for you now. Not at the end of your adventure, after everything this bitch and her minions have put you through. You need <b>more</b>! You hike");
					if(!player.isNaga())
					{
						outputText(" a leg");
					}
					else
					{
						outputText(" your coils");
					}
					outputText(" over Lethice’s body, starting to ride her sideways. The feeling of her nipple-cock twisting around inside you, gushing milk all the harder, but it’s not what you’re looking for. Instead, you reach back and grab the other dick-nipple, angling it towards your [asshole]. Like the first, it’s slicked with plenty of tainted milk, making the entrance as easy as you’d like. You give out a shuddering sigh as you sink down on both of the Demon Queen’s dicks, filling your holes with throbbing, milky meat.\n\n");
				}
				outputText("You start to move, grinding against Lethice’s jiggling rack and drawing her dick-nipple");
				if(player.hasVagina())
				{
					outputText("s");
				}
				outputText(" through you, again and again. The demons around you hoot and holler, driven wild with lust as you rape their queen, and you can’t help but smile.");
				if(player.cor >= 66)
				{
					outputText(" You’re finally where you belong!");
				}
				else
				{
					outputText(" Even the demons recognize what you’ve done! Now the only question is what to do with them afterwards...");
				}
				outputText(" For now, though, you sate yourself by riding faster, bouncing on Lethice’s plump chest. Faster and faster, you piston your [hips] until you and Lethice both are moaning with pleasure, your bodies quaking with growing ecstasy.");
				outputText("\n\nGiving little concern to your corrupted partner’s pleasure, you ride her dick-nipple");
				if(player.hasVagina())
				{
					outputText("s");
				}
				outputText(" as hard and fast as you can, letting purple milk spray from your hole as Lethice’s milky tits cum their corrupted load inside you. She screams, back arching and wings beating like hammers against the stone. But that doesn’t matter to you - not right now, not when you’re so close! You shove the demoness down, pinning her between your pounding hips and the unrelenting stone.");
				outputText("\n\nNot long after, you cum. An explosive orgasm shudders through you, wracking your body with convulsions of pleasure. Milk gushes into your");
				if(player.hasVagina())
				{
					outputText(" holes");
				}
				else
				{
					outputText(" ass");
				}
				outputText(" from the Demon Queen’s swollen breast");
				if(player.hasVagina())
				{
					outputText("s");
				}
				outputText(", gushing their lactic load inside you. You keep pistoning your hips as fast as you can, dragging out every iota of pleasure that you can before the climax passes over you, leaving you panting and gasping and leaking corrupted fluids from your hole");
				if(player.hasVagina())
				{
					outputText("s");
				}
				outputText(".");
				outputText("\n\nWhen you’re done with her, the Demon Queen looks like any other well-used whore: ragged, gasping, slathered with sexual fluids and milk. She wasn’t so tough after all - just another demon that stood in your way. Sated, you stagger up and to the nearest place to rest: her throne. You collapse upon it, assured of your victory as you look out upon the defeated host of demons you plowed through to get here.");
				outputText("\n\nBut now... now you have a choice to make.");
			}
			theChoiceDunDunDun();
		}
		
		private function redemption(hpVictory:Boolean):void
		{
			clearOutput();
			outputText("Looking down at the");
			if(hpVictory)
			{
				outputText(" battered and beaten demon, once so full of haughty pride and self-assured in her power, fills you with a sense of pity.");
			}
			else
			{
				outputText(" horny, desperate demon before you fills you with a sense of pity.");
			}
			outputText(" She’s defenseless now - the greatest of the demons has fallen at your hand, but to what end? What about all the other countless demons swarming the vast palace, and the world outside. Merely killing Lethice accomplishes precious little. Another will rise in her place, won’t they?");
			outputText("\n\nBut if you could purify her, stop the corruption taking hold of her as you did with Marae...");
			outputText("\n\nGrinning to yourself with the dawning thought, you take a suddenly all the more confident step towards the demonic queen. She looks up to you with a snarl on her lips, spite written clearly across her regal features. <i>“Do what you will, </i>Champion<i>,”</i> she all but spits, though even you can hear the wavering surety in her voice. You’d almost say she’s afraid, if you didn’t know any better. She knows she’s beaten, and that her life is completely in your hands. It wouldn’t be any effort at all to finish the job, kill her dead where she stands and send her minions running; to speak nothing of the many, many ways a weaker soul than yours would use and abuse her svelte, once-proud body for their own lusts.");
			outputText("\n\nInstead, you grab her by the shoulder and drag her up to her feet, forcing her to stand before you. She looks at you incredulously, as if you’re defying every one of her expectations yet again by not claiming your victory on her here and now. You have much, much more important things in mind for the Demon Queen, and tell her as much. She’s your prisoner now.");
			outputText("\n\nThe demons in the stands hiss and boo, but a shout from you silences them - sends many of them running for their lives, too. If even their all-powerful queen can’t defeat you, what hope do they have?");
			outputText("\n\nTaking Lethice by the shoulder, you march the defeated demon out of the grandiose hall and out towards the winding path down the mountain. You’ve got an important meeting with a certain tree-goddess.");
			menu();
			addButton(0,"Next",redemptionII);
		}
		
		private function redemptionII():void
		{
			clearOutput();
			outputText("<b>A day of travel later...</b>");
			outputText("\n\n<i>“You return, my Champion,”</i> the sweet, ethereal voice of the realm’s mother goddess coos, even as you’re just beaching your boat on Marae’s island. You disembark, taking in a deep breath of the sweet, fresh air. Even now, the island seems fresher, brighter... more pure... than when you last left it. Slowly but surely, you know that the goddess is fighting back the corruption that had nearly claimed her great soul.");
			outputText("\n\nHauling a bound and gagged Lethice behind you, you approach the great tree in the middle of the island. Marae’s humanoid incarnation, half buried in the ancient oak’s bark, turns to greet you with a beneficent smile on her full lips, matronly breasts bobbing freely in the wind. <i>“My Champion!”</i> she gasps, eyes widening as you present the erstwhile Demon Queen to your goddess, forcing the succubus to her knees. <i>“You... you’ve done it! Even I had hesitated to hope...”</i>");
			outputText("\n\nYou smile at Marae, saying that human perseverance should never be underestimated. Though your trials were long and hard, taking you far and wide through the corrupted landscape of her world, no force could stop you from saving Mareth so long as you held onto the purity in your heart. The goddess beams, smiling with such joy as you’ve never seen from her before, and reaches out a hand to you. Taking it, you find yourself drawn into a long embrace, with Marae burying her face in your [chest]. A ragged, gasping sound escapes her, all but muffled in your clothing. You’d almost say she’s struggling to hide tears from the demoness, though of joy or sheer relief you cannot say.");
			outputText("\n\nMarae recovers in but a moment, composing herself back into the serene deity of motherly grace she always was, and turns her attentions towards Lethice. <i>“I recognize your hostage. Why have you brought her, Champion? Though long have I wished for a chance to see the wicked queen of demons brought low, why does she yet live?”</i>");
			outputText("\n\nYou imagine a great many people can’t wait to see Lethice dead. But, you say, you have another option in mind. Some way to make the Demon Queen do a little good for once in her life; to bring a little hope of her own back to this tainted world. You explain your plan to Marae, such as it is, and implore the goddess to help you. Even as mighty as you’ve become, restoring the soul of a demon is far and away beyond your abilities.");
			outputText("\n\nMarae listens, nodding slowly as you lay out your request. When you’ve finished, she falls silent for a moment, thinking over what you’ve said.");
			outputText("\n\n<i>“It might be possible,”</i> Marae eventually concedes, locking eyes with you. <i>“But she would not be the same. A soul, once lost, can never be regained... only replaced, and at great cost of power.”</i>");
			outputText("\n\n<i>“Power?”</i> you query, reaching into your bag. From it, you produce a crystal of lethicite, darkly radiant and glowing pink. <i>“Like this?”</i>");
			outputText("\n\nMarae shivers, drawing back from the brandished soul-stone. <i>“Yes... yes. These crystals are mortal souls made manifest, drawn out by the demons through their horrid deprivations. It is awful what they do, but you’re right. A potent enough crystal could be used to wipe clean the corruption in her, implant a new and untainted soul.”</i>");
			outputText("\n\nCould Marae do that to other demons? To all of them that you capture and return?");
			outputText("\n\nShe smiles, <i>“So long as there is Lethicite, yes. Though I fear there is less than there are demons.”</i>");
			outputText("\n\nStill, every demon you redeem is another life saved in your eyes.");
			outputText("\n\nMarae nods approvingly at your sentiment and takes the proffered pink crystal. You drag Lethice forward, depositing her at the goddess’s roots and yanking out her gag. The fallen queen spits and curses, struggling against the restraints you’ve secured her in.");
			outputText("\n\n<i>“This will change nothing!”</i> she sneers, even as several mighty roots grasp her arms and legs, holding her firm. <i>“My followers will-”</i>");
			outputText("\n\n<i>“Shh,”</i> Marae whispers, holding up the pink crystal in her humanoid hands. A soft, green glow spreads up the tree-maiden’s arms, growing in intensity as it reaches towards her hands. In the blink of an eye, Marae’s power has grown to a sun-bright flare, cutting the demon’s utterances off in a wail of divine power. You recoil, shielding your eyes for a moment as the flash washes past you, blasting the air around the island into a shockwave. You’re sure they could feel that all the way on the shore!");
			outputText("\n\nWhen you’ve recovered from the outburst of radiance, you see Lethice has fallen on her side, lying motionless on the sand. Marae looms above her, titanic and regal as ever... yet looking suddenly exhausted, her bare chest heaving with the effort of what she’s done. The crystal she held is nothing more than a cracked piece of glass in the goddess’s green fingers, slowly crumbling to dust and flittering away in the breeze.");
			outputText("\n\n<i>“Is it...”</i> you start to ask,");
			if(player.isBiped())
			{
				outputText(" kneeling");
			}
			else
			{
				outputText(" leaning");
			}
			outputText(" over the fallen demoness. Already, you can see her body changing: her bright pink skin is flushing out, becoming a more human hue, the bone spikes are slowly retreating into her heels, and the black roses interwoven in her now-viridian hair are blooming anew, becoming verdant, brilliant shades of crimson. Slowly but surely, the Demon Queen is beginning to look much less... well, demonic.");
			outputText("\n\n<i>“I’ve done all within my power,”</i> Marae murmurs, putting a hand over her heart. <i>“The rest is up to you. And... to her, as well. I am sorry, my Champion. I’m very tired, now.”</i>");
			outputText("\n\nThe goddess reaches back to the great tree she’s buried in at the hips, and in a shimmer of magic, disappears within herself. Your attentions return to Lethice, in time to see the sprawling cavalcade of demonic horns crumble from her brow, leaving only the curling goat-like ones behind. Her wings, once huge and draconic, a dark imitation of the great wyrms of legend, twist and writhe within themselves. They fold back into themselves, melding back into their owner’s flesh until nothing remains beneath her churchwear’s torn back but a pair of smooth, slender shoulder blades.");
			outputText("\n\nYou’d barely recognize her now, save the unchanging, statuesque form of her slender body. That, at least, remains unchanged - perhaps this is really how Lethice appeared even before her demonic transformation. With beauty like hers, then, she’d have had no reason to change her appearance.");
			outputText("\n\nWarily, you");
			if(player.weapon == WeaponLib.FISTS)
			{
				outputText(" flip a knife out of your pack");
			}
			else
			{
				outputText(" take your [weapon]");
			}
			outputText(" and cut her bonds, trusting in the goddess’s power. With a soft, almost girlish moan, Lethice rolls onto her back and cradles her wrists, still reddened from the merciless grip of the rope. After a long moment, her eyes slowly open, groggily blinking away what seems like a hundred years of sleep. The once-golden irises, split like a drake’s, are now a soft, alluring golden brown, utterly human in shape and radiant with intelligence, compassion, and warmth. Traits so rare in Mareth that your breath catches in your throat a moment as you take in the change.");
			outputText("\n\n<i>“Who...”</i> she moans, struggling unsteadily to a sitting position beside you. You’re about to answer her, to give your name again, when she utterly surprises you: <i>“Who am I?”</i>");
			outputText("\n\nThe question takes you aback; leaves you struggling for an answer. Though she may once have been Lethice, the nefarious Demon Queen, now she’s... what? Who? Marae said this was not her original soul, but a new one altogether. The incredible shock of her transformation must have muted her memories. You don’t doubt that they’re still there, somewhere, but for now, she is free to forge a new path.");
			outputText("\n\nA second chance, perhaps.");
			outputText("\n\nWhat do you tell her?");
			menu();
			addButton(0,"Next",redemptionIII);
		}
		
		private function redemptionIII():void
		{
			clearOutput();
			outputText("What name do you give the new woman you and Marae have made?");
			mainView.nameBox.text = "";
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			menu();
			addButton(0,"Next",redemptionIIIGoName);
		}
		
		private function redemptionIIIGoName():void
		{
			if(mainView.nameBox.text == "")
			{
				clearOutput();
				outputText("<b>You must select a name.</b>",false);
				mainView.nameBox.x = mainView.mainText.x + 5;
				mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
				menu();
				addButton(0,"Next",redemptionIII);
				return;
			}
			flags[kFLAGS.LETHICE_NAME] = mainView.nameBox.text;
			mainView.nameBox.visible = false;
			clearOutput();
			if(flags[kFLAGS.LETHICE_NAME] == "Lethice")
			{
				outputText("You decide to tell her the truth - to give her back the name she bore as the Demon Queen. Trying to hide who and what she was from her - and from the world - will do you no good. The rest of the demons, and those who fight against them, deserve to see that there is hope. That even the Demon Queen could be made whole again.");
				outputText("\n\nAt least, that’s what you hope. So you tell her that, slowly and in great detail explaining to the confused-looking girl that she is Lethice, the ruler of the demons who even now plague the realm of Mareth. Though she and her minions have committed atrocities beyond imagining, brought ruin to the world, you showed her mercy. You’re giving her a second chance.");
				outputText("\n\nEven before you finish your explanation, the poor thing bursts into tears, clutching at you and insisting she has no idea - that she’s so, so sorry for what she’s done, but that she remembers nothing. That, you think, might just be for the best.");
			}
			else
			{
				outputText("You decide it’s better not to tell the erstwhile Demon Queen who she was, and what she’s done. If she doesn’t remember anything, then... well, you did intend to give her a second chance, didn’t you? Reminding her of what her horde has done to the world can only lead to misery, and her drawing the ire of those she’s hurt.");
				outputText("\n\nSo you give her the name of " + flags[kFLAGS.LETHICE_NAME] + ", and tell her that she’s a creation of the goddess Marae, a redeemed soul made manifest. She stares at you with wide eyes as you half-explain and half-lie about her origins, who she is now and what world she’s been born into. The very mention of demons, creatures running wild across the tainted realm, sends shivers through her, and recounting their deeds to destroy her <i>“mother”</i> and the pure beings of Mareth brings tears to her eyes.");
			}
			menu();
			addButton(0,"Next",redemptionIV);
		}
		
		private function redemptionIV():void
		{
			clearOutput();
			outputText("You spend some time there on the beach, comforting " + flags[kFLAGS.LETHICE_NAME] + ". Eventually, as the hazy sky begins to darken, you take her hand and board your small boat, pushing off towards land. A new day will soon dawn on Mareth, and with it, you introduce a new hope: a way to fight back against the demons.");
			outputText("\n\nIt soon comes to light just why " + flags[kFLAGS.LETHICE_NAME] + "’s rebirth was so costly, so tiring, to your patron goddess. Not a week after your victory at the mountain fortress, you and your new companion are ambushed by demons - assassins, bent on exacting vengeance for their queen’s humiliation. Instead, they end up on their knees before you, beaten as all who stood before you always are. This time it’s different, though. This time, rather than the choice of carnal punishment or death, you find yourself given a third option.");
			outputText("\n\nThe demons carried a few shards of Lethicite, which " + flags[kFLAGS.LETHICE_NAME] + " quickly finds, drawn to the power of it like a moth to flame. Before you have time to realize what she intends, " + flags[kFLAGS.LETHICE_NAME] + " grabs the brilliant pink stones and raises one of them aloft. Her arms and hands begin to glow, radiating that same awesome viridian power that Marae had shown you before, and in a flash of light one of the demons crumples to the ground, orgasming and writhing as the seething corruption in his veins is torn from his body in one last demonic ejaculation. The pool of cum he leaves catches flame, burning away to smoke and cinders a moment later. Corruption eradicated, utterly and completely.");
			outputText("\n\nShe repeats the process for each of the defeated maledictors. One by one, their taint is burned away, leaving confused, virgin souls in their wake. Pure souls, in bodies burned incandescent by holy flame.");
			outputText("\n\nWhen she’s finished, " + flags[kFLAGS.LETHICE_NAME] + " collapses to her knees, gasping, chest heaving against her comfortable clothes - she has long since abandoned the twisted habit of her demonic reign. You put a hand on her shoulder, expecting her to be almost ready to collapse as Marae was... but instead, she turns to you with a huge smile. " + flags[kFLAGS.LETHICE_NAME] + " throws her arms around you, laughing like a giddy child.");
			outputText("\n\n<i>“I did it!”</i> she cries, even as the other erstwhile demons slowly stagger around, gaping at the pair of you or looking shame-faced about their nudity. <i>“<b>We</b> did it!”</i>");
			outputText("\n\nShe certainly did. With power like that... as long as you have lethicite, you can take the fight to the demons. Push them back, purify them one by one.");
			outputText("\n\nSomehow, you get the impression Marae’s smiling back on her island at the sheer irony of it all. The woman that was once this world’s greatest threat might just be the one to help you save it.");
			outputText("\n\nYou’ve got a long, hard crusade ahead of you, though. But now, at least, you’re not going it alone.");
			outputText("\n\n<b>THE END</b>");
			flags[kFLAGS.GAME_END] = GAME_END_REDEMPTION;
			doNext(postEndingChoices);
		}
		
		private function joinHer():void
		{
			clearOutput();
			outputText("Stepping towards the infamous Demon Queen, you");
			if(player.weapon == WeaponLib.FISTS)
			{
				outputText(" raise your empty hands");
			}
			else
			{
				outputText(" set aside your [weapon]");
			}
			outputText(" and smile. Lethice cocks a bemused brow, crossing her legs and tracing her slender fingers around the rim of her Lethicite-filled goblet. None of her remaining minions move to stop you, allowing you to approach their queen, right to the foot of her throne.");
			outputText("\n\n<i>“Well, well,”</i> Lethice purrs, mighty wings twitching expectantly behind her. <i>“What’s going through your mind, I wonder. Shouldn’t you be raising your hackles and telling me how you’re going to topple me off my throne and put an end to my reign of lust about now?”</i>");
			outputText("\n\nNo, no. You have a very different speech in mind right about now. You sweep an arm back towards the defeated bodies of the Demon Queen’s most elite servants, her own personal guard and the very king of the minotaurs. Both");
			if(flags[kFLAGS.DRIDERINCUBUS_KILLED] == 0 || flags[kFLAGS.MINOTAURKING_KILLED] == 0)
			{
				outputText(" humiliated");
			}
			else
			{
				outputText(" slain");
			}
			outputText(" by your hand back to back. Compared to you, they were nothing. Pathetic, really. Are they the best the mighty demons have to offer?");
			outputText("\n\nYour words seem to take the Demon Queen aback, actually leaving the haughty slut speechless for a moment. Keeping the momentum, you say that she clearly needs replacements for those useless weaklings. A mighty, beautiful queen like Lethice <i>deserves</i> someone who can properly defend her. Someone whose power is rival only to her own.");
			outputText("\n\nSlowly, a smile spreads across the demon’s face. <i>“Someone like you?”</i> she smirks, flicking a small crystal into her mouth. The resounding crunch of a soul being devoured echoes through the grand chamber, to the delight of the demonic courtiers in the stands. <i>“Perhaps I underestimated you, ‘Champion.’ You’ve certainly proved yourself most capable. And </i>most<i> arousing.”</i>");
			outputText("\n\nLethice stands, high heels clicking on the stone floor and wings unfurling behind her. You notice with keen appreciation the way her dark churchware clings to every lush mound and shapely curve. She even has a regal walk, one leg sensuously slipping in front of the other until she’s within arm’s reach; then closer still, tracing a pale finger around your chin.");
			outputText("\n\n<i>“So. You’ve resisted my poor imps and demons at every turn.");
			if(flags[kFLAGS.DRIDERINCUBUS_KILLED] == 1 || flags[kFLAGS.MINOTAURKING_KILLED] == 1)
			{
				outputText(" Carved a bloody swathe");
			}
			else
			{
				outputText(" Fucked your way");
			}
			outputText(" through my keep. And all this to... what? Become my new bodyguard?”</i>");
			outputText("\n\n<i>“Something like that,”</i> you answer, grabbing the demoness by the hips and yanking her close, tight against your chest so that you can feel her pert breasts hot against your [armor]. She gasps with surprise, but the moment of weakness is just that: momentary. In the blink of an eyes, she’s right back to unflappable, regal dominatrix. One of her legs hikes up around your hip, pressing her crotch against yours, and her hands reach up to cup your cheeks.");
			outputText("\n\n<i>“My, my,”</i> Lethice smirks, <i>“You continue to surprise... and delight. I see every one of the stories I’d heard about this so-called Champion seems to be true.”</i>");
			outputText("\n\nEvery one of them and more, you assure her, running your hands down her back. You grab a handful of demonic ass, squeezing until she moans.");
			outputText("\n\n<i>“Let’s not get ahead of ourselves,”</i> she chuckles, brushing your hand off. <i>“Even you can’t just waltz in here and simply... demand my power. No, there will be tests. I must assure your loyalty, my new Champion, and there’s so much I simply can’t wait to extract from that precious body of yours. Your soul, for starters.”</i>");
			outputText("\n\nShe smiles and steps back from you, slipping like a spirit out of your arms and back towards her throne. As she does, her fingers play across her tarnished garb and in the blink of an eye, pulls it away in tatters to reveal a pristine body. She’s ghostly pale, with long hair spilling down around her slender shoulders and small, high breasts. A pink, silken slit sits proudly between her legs, so small and pretty that you’d easily mistake it for a princess’s - not the gaping, lustful orifice you might have expected. Even her wings and horns seem somehow less threatening now, almost cute.");
			outputText("\n\nShe walks backwards to her throne, swinging into it with peerless grace and legs spread wide open like the lewdest of wantons. <i>“Some queens might make their new vassals kneel before her, but as you might imagine, my court has a different take on things.”</i>");
			outputText("\n\nAs if to punctuate her point, Lethice runs a single slender digit around the pink left lip of her pussy, spreading her slit open for your inspection. A little gasp of pleasure escapes her full lips as her finger slides inside, completely enveloped by rosy walls that hug it perfectly. It pops out a moment later, polished to a shine that the queen is all too eager to lick clean with a moan of relish.");
			outputText("\n\n<i>“Come now, Champion,”</i> she purrs, bringing that same finger back down to caress the hooded rosebud over her petite slit. <i>“Show your loyalty to your new monarch to the whole court. Cement in all our minds your utter and complete dedication to corruption.”</i>");
			outputText("\n\nIt’s an easy choice. One that will pay out a thousand times over, earning you every pleasure of the flesh you’ve become so utterly addicted to since your first arrived in this tainted world. What do you need a soul for anyway, if that’s what’s holding you back. Trading it away is a small price for the power and pleasure that Lethice’s court commands with such mastery. The knowledge you’ll soon be just like these creatures fills you with a mix of dread and excitement, wondering just what it must feel like to be a creature whose entire existence is nothing but sex, and the search for more and more extreme and hedonistic expressions of it.");
			outputText("\n\nYou approach the throne and slink down to your knees, placing your hands firmly on the Demon Queen’s creamy thighs. She smiles regally, hungrily, down upon you while you explore the gulf between her legs, moving ever closer to her alluring hole. Eventually, your lips close with hers, gently teasing your way until the you taste the first sweet droplets of corrupted, feminine excitement.");
			outputText("\n\nAn explosion of sensation erupts through your [tongue], spreading as a tingling warmth all through your mouth, throat, and beyond. You’ve barely gotten your tongue out of your mouth before the alien feeling has spread through your entire body, infusing you with renewed lust above and beyond anything you’ve felt for the statuesque demoness. Like a " + player.mf("man","woman") + " starving, you dig in with desperate abandon, munching that demonic rug with everything you have.");
			outputText("\n\n<i>“Mmm, intent on making a sterling first impression, aren’t you?”</i> Lethice murmurs, wrapping her thighs around your [face]. Turning her gaze upwards to the demons in the stands, she shouts, <i>“Do you see, my dears? Another would-be Champion reduced to nothing more than a fuck-hungry animal like us, even without the help of the factory. Our plans are quite on track! Humans, beast-morphs, even the so-called gods of this realm all end just as this one has: on their knees, worshipping my twat like the perverse altar of our wonderful Demon Realm.”</i>");
			outputText("\n\nYou feel Lethice’s satin-soft hand on your [hair], caressing you. <i>“More importantly, though, I’ve gained a very, very promising new stalwart. Someone who might just be strong enough to help us finish off our conquest. Oh, I have so many questions before you forget yourself to pleasure. Like where your friends and companions are, and the location of the last cities I’ve heard so many rumors of. You’ll tell me these things, won’t you?”</i>");
			outputText("\n\nOf course you will. Even if there were an ounce of resistance left in you, any fleeting desire to save your soul and hold to your duty, some small part of your mind realizes that the Demon Queen’s very sex has ensorcelled you, sinking talons of magic deep into your spirit. You’re hers, utterly and completely, body and mind and soul.");
			outputText("\n\nYou wouldn’t have it any other way.");
			menu();
			addButton(0,"Next",joinHerII);
		}
		
		private function joinHerII():void
		{
			clearOutput();
			outputText("<b>Time passes in Mareth...</b>");
			outputText("\n\nYou spare little thought to the passage of time. Weeks, months, perhaps years have gone by in your carnal service to Queen Lethice. Each day blends into the next, swamped in pleasures of the flesh known only to the race of shapeshifters and boundless hedonists you’ve joined with. In more ways than one.");
			outputText("\n\nThe legend of the <i>“Demon’s Champion”</i> spread through Mareth like wildfire soon after your falling in with the demonic host. With Lethice’s power, and the near-limitless capabilities of her demons, at your back, there seemed nothing you could not do. Your trek across the Demon Realm had seen you come across all manner of folk and places secluded and safe from the steady reach of your patron’s corruption.");
			outputText("\n\nNo more.");
			outputText("\n\nThough your memories from before your triumphant ascent are nothing more than a vague haze, your alluring consort assures you that before she milked your soul from your body in an orgiastic affair like none the realm had ever seen before, she had extracted oh so much information from your willing mind. Everywhere you had visited, everyone you had ever spoken to in your adventures... all were carefully recorded by Queen Lethice before your soul was quite literally fucked from your once-mortal flesh, and you were made perfect and powerful beyond your wildest dreams.");
			outputText("\n\nAnd now... now the Demon’s Champion stands victorious on the ramparts of the last free city in your realm, looking over the carnal chaos you’ve let loose. The streets of Tel’Adre are overrun with demons of every shape and form, fucking like mad as the screaming, struggling defenders drown in a sea of corrupted cum and milk and every other sexual fluid they could imagine.");
			outputText("\n\nThe sight of such a magnificent, victorious orgy sends shivers of delight through you almost as sexual as the wet, tight hug of your consort’s sex around your");
			if(player.hasCock())
			{
				outputText(" [cock].");
			}
			else
			{
				outputText(" newgrown cock. Just another side benefit of demonhood: molding your body on the fly to suit whatever takes your fancy moment to moment.");
			}
			outputText(" The thrill of victory simply and utterly overwhelmed your queen when she arrived to survey the scene of your victory, and you soon found yourself with Lethice bent over the sandy stone walls, breasts bared to the growing crowd of demons in the streets as you plow her from behind, hips pistoning hard against her lush, soft rump.");
			outputText("\n\nSomething clicks inside you as you unleash yet another potent load into the queen’s womb. Already, her stomach grows with the freshest clutch of soulless, pleasure-hungry imps inside her. Realization dawns to the beat of Lethice’s pussy clenching around your tainted member and accepting your virile seed once more.");
			outputText("\n\nYou’re right where you belong. For the first time, maybe ever, you are completely and utterly sure in the realization that you are exactly where you were always meant to be. Every moment in your life, every battle and every victory that led you to Queen Lethice’s throne, to surrendering your soul to the vacuous, mind-breaking pleasure only a true demon could command - all of it has led you here, right now, leading the last and greatest victory of the demonic horde.");
			outputText("\n\nAnd thus ends purity in Mareth, crushed under your heel and stamped out in a tidal wave of cum.");
			outputText("\n\n<i>“Ah, my Champion,”</i> Lethice coos, propping herself up on her hands and gazing out over the ruined city. <i>“This was a hard-fought victory for you. I could not be more proud.”</i>");
			outputText("\n\nShe smiles over her shoulder, slowly turning so that your prick slides out of her in a tidal-wave of pent-up semen. Spunk stains her alabaster thighs, drooling down in thick, creamy rivulets as she slips into your arms and plants a kiss on your lips.");
			outputText("\n\n<i>“Your work is done, if you so choose,”</i> she smiles. Behind her, your eyes are drawn to a four-dicked demonic minotaur stampeding out of the city guardhouse, several morphic soldiers mounded on his shafts. Cum sprays from them and him, and the screams of pleasure echo through the streets, completely drowning out all other sound for a moment. When he’s turned a corner and left, leaving a sea of spooge in his wake, Lethice chuckles. <i>“But I know you, now, my dear Champion. I know you’ll never be satisfied with victory. No, no, even now your spirit yearns for adventure and conflict more than it yearns for even my bed. Isn’t that right?”</i>");
			outputText("\n\nPerhaps, you have to admit. Though passion swells in your heart now, you wonder what you’ll do in the future. You’d thought you could be sated by endless days spent entwined with your queen and her endless harem, indulging in your fantasies day in and day out.");
			outputText("\n\nBut some part of you, however small, will always be the Champion. A warrior, destined to fight. You just happen to fight for the demons now.");
			outputText("\n\n<i>“I know,”</i> Lethice chuckles, wrapping her arms around your waist, smearing your mixed cum between your bodies. <i>“That’s why I have one more job for you.”</i>");
			outputText("\n\nDonning a wicked smirk, Lethice whispers <i>“We’ve finally got enough souls to open another portal. A way out of this cursed, trapped realm. And an all but infinite supply of new sluts to milk for their souls. Imagine: power beyond everything we already have, scattered on many worlds ripe for the taking. And you... my Champion... are so very, very good at taking what you want.”</i>");
			outputText("\n\nYou nod. <i>“Where to first, then?”</i>");
			outputText("\n\nLethice just smiles, brushes past you to look out over the ramparts and into the Marethian wasteland.");
			outputText("\n\n<i>“A realm of traitorous souls. A little village that dared to send a wolf instead of a lamb. I think it’s time we thanked Ingnam.”</i>");
			outputText("\n\n<b>THE END</b>");
			awardAchievement("You Bastard", kACHIEVEMENTS.GENERAL_YOU_BASTARD, true, true);
			flags[kFLAGS.GAME_END] = GAME_END_CONSORT;
			doNext(postEndingChoices);
		}
		
		public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			outputText("You fall.");
			outputText("\n\nAfter everything you’ve done to get here, after fighting tooth and nail for so long... after finally finding the Demon Queen herself and challenging her fearsome power... you fall. Brought low");
			if(!hpVictory)
			{
				outputText(" by your own rampant sexual desires");
			}
			else
			{
				outputText(" beneath the demoness’s merciless assault. She’s more powerful than you could have ever imagined, far more so than a wisp of a girl like her has any right to be");
			}
			outputText(". Gasping, you slump");
			if(!player.isBiped())
			{
				outputText(" down");
			}
			else
			{
				outputText(" to your knees");
			}
			outputText(",");
			if(player.weapon != WeaponLib.FISTS)
			{
				outputText(" your [weapon] clattering away across the stone");
			}
			else
			{
				outputText(" too weak to even ball your fists");
			}
			outputText(" as the victorious demon strides towards you.");
			outputText("\n\n<i>“Ah, now <b>that</b> is what I like to see,”</i> she purrs, lifting her arms triumphantly to the gibbering host of demons still crowding around the throne room. <i>“Another would-be savior on " + player.mf("his", "her") + " knees before me! Once again,”</i> she sneers, turning her gaze down to you, her demonic heels clacking one after the other on the cold floor, <i>“we see that nothing... no one... can stand against me.”</i>");
			outputText("\n\nLethice reaches down, cupping your chin with her long-nailed fingers and tilting your head up. She’s not forceful, more like a mother disappointed in her child, forcing you to confront your misdeeds. In her churchy outfit, you could easily mistake her for one of the priestesses that would teach you and the other children back in Ingnam, save for the tremendous wings and curling horns. She must recognize the look you give her, and she smiles almost beatifically. Beautifully.");
			outputText("\n\n<i>“So powerful, so self-righteous... and here you are, kneeling before me like so many before you. Still, I have to give you credit, Champion. You got so much further than most: I almost broke a sweat breaking you.");
			if(monster.lust < 50 && monster.HP > monster.eMaxHP() * 0.5)
			{
				outputText(" Almost.");
			}
			outputText("”</i> She licks her lips, and gives your chin a sharp release. <i>“I think you deserve a special... reward... for your efforts, Champion. Oh, except that’s not what you are anymore, is it? A Champion doesn’t bow down, hoping a pretty little demon doesn’t rip " + player.mf("his", "her") + " soul out, does " + player.mf("he", "she") + "? No, that’s something I’d expect my dog to do. Is that what you are: a dog?”</i>");
			outputText("\n\nYou look away from Lethice, trying");
			if(hpVictory)
			{
				outputText(" to hide just how turned on she’s left you... how close you are to orgasm, just in need of her lurid touch");
			}
			else
			{
				outputText(" not to let her see how weak you are, how easy it really would be for her to kill you... or worse");
			}
			outputText(". The Demon Queen just smiles all the wider as she turns from you, striding towards her throne. She stops after a few long-legged paces, casting a gaze over her shoulder to you. <i>“What are you waiting for, </i>dog<i>? Come along...”</i>");
			outputText("\n\n<b>Do you turn into a dog or would suicide be a better option?</b>");
			menu();
			addButton(0, "Go Dog", woofwoof);
			addButton(1, "Suicide", goKillYourself);
		}
		
		private function woofwoof():void
		{
			clearOutput();
			outputText("<b>Time passes...</b>");
			outputText("\n\n<i>“Heel, Champ!”</i>");
			outputText("\n\nYou look up with a start, blinking away the haze of lust that has fallen over you. Your [hips] are still pistoning like a jackhammer, but you wrest your attentions up to the glorious throne high above you where Mistress reclines, casually consuming the glowing soul-crystals that bear her name. The black-skinned dragoness beneath you moans and shudders, cum gushing from her corrupted cock and splattering onto the floor. Her whole body convulses in mindless pleasure, making a mess of your mistress’s throne dais.");
			outputText("\n\n<i>“Tsk! Now look what you’ve done, Champ,”</i> Mistress chides, tracing one of her lush fingers across the rim of her goblet. Slowly, sensuously, she drops her hand down to the side of her throne and coils her slender digits around a leather strap hooked there. Mistress coils her hand around it and gives the strap a harsh pull, yanking you by the neck off of the prostrate woman. Cum sprays from your");
			if(player.dogCocks() == 0)
			{
				outputText(" newly-grown doggy cock");
			}
			else
			{
				outputText(" thick, throbbing dog-member");
			}
			outputText(" as your swollen knot is yanked from the dragon-girl’s hole. You tumble across the floor with a pathetic whine, drooling spunk from your twitching member. Your beloved Mistress gives you a disapproving scowl as you recover.");
			outputText("\n\n<i>“When I tell you to heel, you heel,”</i> Mistress says, tugging on your leash. She sighs, <i>“I suppose I can’t blame you for wanting to go back into the training pits. I’m sure Syrena can... correct that behavior.”</i>");
			outputText("\n\nYou shudder at the unbidden memory, of the shark-like demon <i>“bitch breaker’s”</i> ministrations. You’ve never felt pleasure like that before... of course, you can’t exactly remember <i>“before”</i> much anymore. Just your name: Champ. And of course, who your mistress is. That’s the most important thing in world. You know who your mistress is, that obeying her gives you more pleasure that pumping your tainted seed into a thousand whorish cunnies. You whimper under your owner’s withering gaze, as apologetic as you can be without words. She tuts at you before turning her attention to the thoroughly creampied dragoness who was, mere moments ago, ready to accept your... tenth load? Twelfth? You lost count an hour ago, mindlessly pumping away at her twat as hard and fast as you could, just imagining it was your mistress’s hole you had to pleasure.");
			outputText("\n\nThe dragoness is almost totally still, on all fours with her ass in the air, drooling her cum and yours into a growing pool on the floor between her dark, scaly legs. Her reptilian cock dangles down, still spasming with the aftershocks. Mistress leans back in her throne, eyeing the dragoness. <i>“As for you, captain... I think my precious little Champ here has given you an adequate reprimand for your failings. I put quite a lot of effort into you and my other new guards, and after all of that, you let some wet-eared outlander barely old enough to know a man’s touch almost make it to my palace. Again.”</i>");
			outputText("\n\nYour mistress snaps her fingers, and the huge doors to the throne room slide open. Another pair of armored dragon-morphed women stride in, dragging a human girl between them. She’s beaten, once comfortable clothes all but shredded, letting a pair of palmable breasts bounce with every step her captors take. Dirty blonde hair fringes her face, hiding her features until the two guards throw their charge down, mashing her face into cum-puddle you left behind. She moans, gasping for breath as tainted seed clings hotly to her fair, uncorrupted cheeks. The guards grab their chastised captain and drag her off, retreating to the edge of the throne room beneath the stands, now devoid of demons. Mistress isn’t holding court right now: this is her private time. Otherwise, you’d be full of demon cock with your own buried in tainted loins every second you weren’t busy tending to Mistress’s many, fiery needs.");
			outputText("\n\n<i>“So, this is the next so-called ‘Champion,’ hmm?”</i> Mistress murmurs, tugging on your leash.");
			outputText("\n\nObedient dog that you are, you bound up to your lovely owner, taking your rightful place wiggling and dripping cum at her feet. She reaches down, caressing your [hair]. You pant happily, nuzzling against her leg, waiting for your next command. But for now, Mistress’s attention is elsewhere: on the girl. The Champion.");
			outputText("\n\nA silent, salient moment passes before the Champion looks up, gritting her teeth, staring up at you and your Mistress with burning blue eyes alive with hatred unlike anything you’ve ever seen. She grits her teeth, wiping the fluids from her face and flicking them to the ground.");
			outputText("\n\nMistress laughs. A noble, lyrical laugh, like one a queen might make at a gala. She deposits a crystal onto her tongue and crunches it, sending the cracking sound of a soul being devoured throughout the barren chamber.");
			outputText("\n\n<i>“Another Champion of Ingnam. My, my, how long has it been?”</i> Mistress smirks, still rubbing you lovingly. <i>“Are your village elders doing well - are they enjoying their immortality?”</i>");
			outputText("\n\nThe girl blinks, the rage on her face replaced by confusion. <i>“W-what are you talking about, demon?”</i> she murmurs, looking up for the first time. You glance down at her from your place at Mistress’s side, really looking at .. this <i>“Champion”</i> for the first time. You feel a vague sense of recognition when you look at her, even as dirty and cum-slathered as she is, though you can’t place her. You squint, but trying to think more about it just makes your head hurt, and so you instead look down at those perky tits of hers, letting yourself get hard again at the thought of grabbing onto them and fucking her as your next bitch.");
			outputText("\n\n<i>“You’re lucky,”</i> Mistress smirks, standing. <i>“");
			if(flags[kFLAGS.FACTORY_SHUTDOWN] > 0)
			{
				outputText("Your predecessor destroyed our welcoming facility. Otherwise I’m sure a certain imp would have revealed the truth to you long ago, before joining you with our breeding machines.");
			}
			else
			{
				outputText("How did you escape from the factory, I wonder? And so clean and pure, too... your belly’s not yet swollen with imps, and your breasts are so small. Did you slip through");
				if(flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] == 0)
				{
					outputText(" Zetaz");
				}
				else
				{
					outputText(" the new Warden");
				}
				outputText("’s fingers, I wonder? Tsk, more punishments to deal out, I suppose. Isn’t that right, " + player.mf("boy","girl") + "?”</i>");
			}
			dynStats("lus=", player.maxLust(), "int/", 5, "lib", 100, "sens", 50, "cor", 70, "resisted", false);
			menu();
			addButton(0,"Next",woofwoofII);
			
		}
		
		private function woofwoofII():void
		{
			clearOutput();
			outputText("You bark excitedly, ready to be your loving, forgiving mistress’s means of meeting out punishment. The Champion’s eyes turn to you, and her jaw drops like an anchor.");
			outputText("\n\n<i>“No... [name]? [name] is that you?”</i> she gasps, staring wide-eyed. <i>“Oh, gods, no...”</i>");
			outputText("\n\nYou cock your head aside, confused. That’s not your name. You’re Champ. You’re Mistress’s favorite puppy-" + player.mf("stud","slut") + ".");
			outputText("\n\n<i>“Aw, don’t confuse the poor thing,”</i> Mistress chides, patting your head. <i>“This is Champ. Champ, say hello.”</i>");
			outputText("\n\nYou bark, rising up on all fours and wagging your tail a hundred miles a minute. Your throbbing, wet canid cock swings between your legs, restrained only by Mistress’s firm hold on your leash. You can practically smell the virgin womanhood before you, begging to be deflowered and bred.");
			outputText("\n\n<i>“My dear,”</i> Mistress smiles, coiling her hand around your leash. <i>“You’ve been duped. You’re nothing but another sacrificial lamb. Or a sacrificial dog, like Champ here.”</i>");
			outputText("\n\nSacrificial? You don’t really know what Mistress means, but you guess that doesn’t matter. Mistress is so much smarter than you after all. Whatever she wants you to be, that’s what you are!");
			outputText("\n\nThe Champion girl stares at you with wide eyes, ignoring Mistress’s words. You can smell the fear on her now, intermixing with the scent that truly has your heart hammering: the scent of a bitch ready to be bred. <i>“[name], listen to me,”</i> she mewls. <i>“I don’t know what they’ve done to you, but you have to snap out of it. Please! Don’t... don’t you recognize me?”</i>");
			outputText("\n\nYour nose twitches as you stare down the strange woman. Why would you recognize her - and why does your head hurt? You give yourself a vigorous shake before glancing up at Mistress. She’s smiling down at you, her rosy lips looking so lush and loving that you’d give anything just to touch them. The thought of ramming yourself between them, shooting your seed into Mistress’s beautiful mouth tonight, when she’s had done with this random human, makes you shiver in anticipation.");
			outputText("\n\n<i>“[name], come on!”</i> the girl cries. <i>“You can fight this! You’re still... still human on this inside, I know it!”</i>");
			outputText("\n\nWhy is she still talking to you!? Your head is starting to hurt with all her blabbering. You’re not a human, you’re a dog! A good, obedient dog. Mistress’s favorite dog.");
			outputText("\n\nMistress gives your leash a gentle tug, drawing your attention back. <i>“Poor thing. My precious Champ’s starting to get confused. I think we need to shut this pretty little bitch up, don’t we " + player.mf("boy","girl") + "? Or better yet, make her scream.”</i>");
			outputText("\n\nYou bark, feeling yourself harden at your Mistress’s words. Making bitches scream is what she and her friends made you for. There’s nobody in the world better at it than you, and everyone in Mistress’s palace knows it now.");
			outputText("\n\n<i>“Have fun, Champ. I’ll be watching,”</i> Mistress purrs, dropping your leash.");
			outputText("\n\nYou’re on the bitch in a heartbeat, leaping forward and slamming your full weight into her. The so-called Champion screams, her limbs flailing weakly as you send her toppling into the pool of seed you’d left on the stones. What little is left of the girl’s clothes are easily rent apart by your bestial claws, leaving her breasts easy targets for your hungry mouth while you tear apart of her skirt and panties, leaving her virginal hole defenseless.");
			outputText("\n\n<i>“Go get her, Champ,”</i> Mistress coos behind you, munching on her snacks while you defile her prisoner.");
			outputText("\n\nYour lips lock around a pink teat, sucking hard; fingers scour her flesh, pulling the girl’s pert cheeks apart to expose a rosy hole so tight you can barely get a finger in before she squeals. <i>“[name], get off! Get off!”</i> she yelps, but her body practically begs you to keep going: her teat stiffens between your teeth, and her pussy slathers your furred digit with juices: she’s desperate to get ready for you, to welcome your alpha’s member inside and soak up your seed. Your legs spread hers out, hiking her knees around her shoulders as you align your veiny, throbbing canid member with her breed-hungry hole.");
			outputText("\n\nThe girl’s struggling stops the moment your ram your hips in, spreading her slick, hot walls wide open around a pillar of dominant meat big enough to make even Mistress’s pet dragons mewl. The Champion’s gut bulges between your bodies and her womb spreads open around your pointed crown, taking you like any of Mistress’s other breeding cows. You just know this one will make a perfect new toy!");
			outputText("\n\n<i>“[name]...”</i> she gasps, voice ragged and husky, barely able to form the alien, unfamiliar word. <i>“Please...”</i>");
			outputText("\n\nPlease fuck her harder? Please fill her womb with virile seed until she’s bloated with your pups? You grin ear to floppy ear and piston your hips, hammering into the juicy honeypot between the would-be champion’s legs with renewed vigor. Her voice breaks, no longer able to form words - she descends into incoherent cries and moans, squirming helplessly beneath you.");
			outputText("\n\n<i>“Good " + player.mf("boy","girl") + ", Champ,”</i> your Mistress murmurs, and as you give a glance over your shoulder, you’re deeply, deeply pleased to see that one of her hands has slipped beneath her priestly garb to pleasure herself. She approves!");
			outputText("\n\nSeeing your beloved Mistress enjoying your vigorous domination of her prisoner drives you to finish for her. Your swollen canid knot presses hard against the girl’s cunny, stretching her open around the bulbous bitch-breaker. As strong as you are now, it doesn’t take long before you do break her, forcing her slutty sex to open wide and accept your masculine rod in its entirely. Her body convulses, orgasming in ways you imagine she’s never done before. Then she goes limp, her body surrendering to you utterly and completely. Sweet-smelling feminine slime drools down her thighs and ass, pooling on the floor between your legs. The second your knot submerges into the sultry-wet embrace of her quivering sex, locking the two of you together in primal sexual bliss. There’s nothing left but animal lust, the bestial drive to breed the pathetic, broken vixen.");
			outputText("\n\nYou cum like a fire hose, loosing yourself inside her. No matter how many times you cum in a day, Mistress’s magics have made sure you’re always so swollen with seed that you leave your bitches’ bellies bloated, drooling sticky whiteness from their twats. And that’s just what you leave this hapless whore doing, spraying your own corrupted seed into her virginal womb until you can feel the rising tide of you cum sloshing against your buried knot. Panting like the dog you are, you flop down overtop the broken <i>“champion,”</i> pinning her to the ground and bottling your seed inside her, making sure it takes.");
			outputText("\n\n<i>“That’s what I like to see, Champ,”</i> your mistress smiles, standing. You feel the leash around your neck tighten, gently encouraging you to get off of the ravaged woman. It takes a few minutes for your knot to deflate enough to let you slip out, letting loose a deluge of spunk that splatters down her rounded ass and onto the flagstone. You trot happily back to Mistress’s side, wagging your tail as your well-used doggy-dong starts to soften back into its sheath. <i>“Good " + player.mf("boy","girl") + ". Very good... so good, in fact, I think I’ll keep this would-be heroine. Perhaps I’ll give her to your trainer first. All you poor Ingnam sluts should stick together after all... perhaps I’ll breed myself a whole little village of humans. Well, of </i>dogs<i>, more like.”</i>");
			outputText("\n\nMistress smiles and strokes your hair, watching as her draconic guardswomen return and cart your bred bitch away for her first training session, still leaking cum as she goes.");
			outputText("\n\n<i>“As for you,”</i> Mistress adds, tugging your leash as she reclines back in her throne, <i>“I expect you to make me cum even harder. Right now.”</i>");
			outputText("\n\nYou bark eagerly and lunge up into her lap, burying your face between your loving Mistress’s thighs as the doors slam closed behind you, sealing the Champion of Ingnam’s fate...");
			dynStats("cor", 70);
			player.orgasm();
			getGame().gameOver();
			removeButton(1);
		}
		
		private function goKillYourself():void {
			clearOutput();
			outputText("There is nothing worse than being humiliated and turned into a corrupted, lustful dog who serves only the Queen of the Demons. Death is a better option for sure. Reaching your shaking hand into your pack, you pull out a cyanide pill and pop it into your mouth then swallow. Your mouth foams as your heart stops beating.");
			outputText("\n\nAs your vision begins to fade into blackness, the last word you hear is Lethice screaming \"<i>NOOOOOOOOOOOOOOO!</i>\" ");
			outputText("\n\nYou give her the last laugh before finally passing away. ");
			awardAchievement("NOOOOOOOOOOOO!", kACHIEVEMENTS.GENERAL_NOOOOOOO);
			player.takeDamage(player.HP + 9999, false);
			getGame().gameOver();
		}
		
		private function theChoiceDunDunDun():void
		{
			menu();
			addButton(0,"Kill Her",killHerPrompt);
			addButton(1,"Leave Her",leaveHer);
		}
		
		private function killHerPrompt():void {
			if (player.weaponVerb == "slash" || player.weaponVerb == "cleave" || player.weaponVerb == "keen cut" || player.weaponVerb == "stab") {
				clearOutput();
				outputText("How shall you end Lethice? Do you snap her neck and make it quick? Or do you chop her head off and scare the demons?");
				addButton(0, "Snap Her Neck", killHer, 0, null, null, "Snap her neck and make it quick.");
				addButton(1, "Behead Her", killHer, 1, null, null, "Off with her head!\n\n(Warning: Contains gore!)");
			}
			else {
				killHer();
			}
		}
		
		private function killHer(method:int = 0):void
		{
			clearOutput();
			if (method == 0) {
				outputText("Lethice probably deserves the worst sorts of torture imaginable, but you don’t have time to dawdle. You snap her neck and drop her twitching body to the ground. ");				
				flags[kFLAGS.LETHICE_KILLED] = 1;
			}
			else if (method == 1) {
				outputText("Lethice probably deserves a punishment that would fit her foul deeds indeed. You raise your [weapon] and slice through her neck, causing her head to fall to the floor and demonic blood spills forth. You pick up your prize and show it to the demons to let them know not to mess with you. ");
				awardAchievement("Off With Her Head!", kACHIEVEMENTS.GENERAL_OFF_WITH_HER_HEAD, true, true, true);
				flags[kFLAGS.LETHICE_KILLED] = 2; // 2 indicates Lethice beheaded
			}
			outputText("The assembled demons scatter at the sight, fearful they’ll fall next - and rightly so. So long as they remain, there’s always the chance another will take her place.");
			postTheChoice();
		}
		
		private function leaveHer():void
		{
			clearOutput();
			flags[kFLAGS.LETHICE_LEFT_ALIVE] = 1;
			outputText("<i>“Begone.”</i> You kick her in the ribs hard enough to roll her down the stairs. Looking over the assembled host, you repeat the command as a shout. <i>“Leave this place and never return. You deserve no power over this land or its peoples. Dare to resist me, and I will shatter your power as easily as your former queen’s.”</i>");
			outputText("\n\nLethice attempts to crawl away, but her battle-wearied limbs barely support a slow crawl. How fortunate for her that a daring shark-demon scoops her up and carries her away. Somehow, you don’t think she’ll be commanding anyone ever again, not if the look in that shark’s eyes are anything to go by.");
			postTheChoice();
		}
		
		private function postTheChoice():void
		{
			outputText("\n\nNow that you’re alone in an empty citadel, the world’s is seemingly your oyster. Doubtless the demons had experiments into interdimensional travel. You could search the place for a way home, or claim it as your own. For all this land’s harshness, it is a place of magic and love too. Surely staying here would not be too great a burden?");
			menu();
			addButton(0,"Go Home",goHome);
			addButton(1,"ClaimFort",claimFortress);
		}
		
		private function goHome():void
		{
			clearOutput();
			outputText("This place is huge. You had no idea there were so many wings with so many different occupants. More than a few demons missed their chance to escape in the initial confusion and slither out of your way at the sight of you, leaving their possessions and experiments unguarded. Priceless artifacts, forgotten slaves, and endless walls of advanced machinery. It’s all yours for the taking, and yet none of it is what you came here to seek.");
			outputText("\n\nHours pass while you fruitlessly search. Who knew demons would keep so much junk. It isn’t until you find the Research and Development wing that you catch a break. One of Lethice’s scientists spent decades trying to crack the mystery of how to open a stable portal between Mareth and another plane - any plane, by the looks of it. The demons considered themselves trapped here, evidence backed up by tomes you found in your search of their library.");
			outputText("\n\nThey weren’t always demons. They were a large party of interdimensional explorers whose expedition became mired in Mareth. Dark, demonic arts weren’t even considered at first, but after endless years of isolation, even the most pure-hearted of wizards were willing to risk burning out their own souls.");
			outputText("\n\nYou’d almost feel bad for them if they weren’t responsible for so much pain and death, but you’ve more to worry about than your foes’ origins. Arcane diagrams and portal construction techniques are everywhere. Sorting them out is going to take weeks.");
			outputText("\n\nSighing, you grab a book and sit down to study it. Maybe they figured it out before you drove them out?");
			menu();
			addButton(0,"Next",goHomeII);
		}
		
		private function goHomeII():void
		{
			clearOutput();
			outputText("<b>Weeks later...</b>\nThey had it. The damned bastards had it. Syrena, the head researcher had figured out how to open a stable portal months ago, but for whatever reason, she kept it from Lethice. There’s a shortage of evidence about what she was actually scheming, but you’d guess she was planning to take a cadre of loyal demons to an untainted plane and set herself up as a queen.");
			outputText("\n\nNo room for loyalty among demons, you suppose. Still, with the information in these books, you can go home. Taking them back to your camp, you work the rituals on the portal to Ingnam{, assisted by your follower{s}}, and before you know it, the portal’s hazy mists resolve into a perfectly circle opening, one that leads to a familiar cave.");
			outputText("\n\nWill you seek vengeance or justice or with your return?");
			menu();
			addButton(0,"Vengeance",goHomeVeng);
			addButton(1,"Justice",goHomeJustice);
		}
		
		private function goHomeVeng():void
		{
			clearOutput();
			outputText("<b>Later...\n</b>Tales of the Champion’s return are rarely told, not in the open anyway. " + player.mf("He","She") + " blew into town with all the subtlety of a cyclone, laying waste to the village’s elders and all who dared defend them. Every villager remembers that night, the night that their leadership was put to the torch - literally. Each of them was left to die inside his own burning mans, bathed in the scorching heat until naught remained but ashes and memories.");
			outputText("\n\nAfter that night, there wasn’t a rebellious soul left alive to oppose to the Champion’s rule. " + player.mf("He","She") + " became the defacto " + player.mf("King","Queen") + " of the village, the breaker of the old ways and forger of the new.");
			if(player.cor <= 33)
			{
				outputText(" Despite the fear and terror of " + player.mf("his","her") + " arrival, " + player.mf("he","she") + " proved a fair and wise monarch. The village soon became a town, and that town a city. Prosperity came to those who lived in the valley, guided by the strength of its unshakable ruler.");
			}
			else if(player.cor <= 66)
			{
				outputText(" Despite the fear and terror of " + player.mf("his","her") + " arrival, " + player.mf("he","she") + " proved a competent, if harsh monarch. The village’s prosperity was marred only by its limited liberties. Still, it was soon a town, and later a city. Most folk were willing to sacrifice their freedoms for the safety " + player.mf("he","she") + " provided.");
			}
			else
			{
				outputText(" Despite the fear and terror of " + player.mf("his","her") + " arrival, " + player.mf("he","she") + " proved a capable monarch in spite of " + player.mf("his","her") + " rapacious tastes. The villagers dared not protest when their once-Champion treated their sons and daughters as little more than slaves. They feared to question where the fruits " + player.mf("he","she") + " provided came from, and why they felt so strange after eating them. Of course, these concerns did not stop them from breeding. Soon, nothing could. As the population of the valley swelled, the Champion amassed an army, one large enough to rival the nearby countries that had ignored it for so long.");
			}
			doNext(postEndingChoices);
		}
		
		private function goHomeJustice():void
		{
			clearOutput();
			outputText("<b>Later...</b>\nTales of the Champions arrival spread far and wide. None expected " + player.mf("his","her") + " return, and yet " + player.mf("he","she") + " arrived all the same, weapon in hand before the council chambers, demanding the corrupt old men who once lead to face justice for their betrayal. At " + player.mf("his","her") + " feet were strange creatures, beings the Champion faced and defeated, brought to Ingnam’s world to testify to just how rotten the village’s core had become. Once they said their piece, " + player.mf("he","she"));
			if(player.cor >= 50)
			{
				outputText(" put an end to their rank existence right there.");
			}
			else
			{
				outputText(" sent them through a glowing portal of " + player.mf("his","her") + " own creation, never to be seen again.");
			}
			outputText("\n\nElder Nomur protested hardest, but his treachery had been laid bare. Not even the most silver-tongued liar could stand against the living proof that the Champion offered.");
			if(player.cor < 50)
			{
				outputText(" In " + player.mf("his","her") + " wisdom, " + player.mf("he","she") + " stopped the townsfolk from lynching their traitorous leaders right there. Instead, they were banished, forever expelled from the lands of Ingnam on pain of death.");
			}
			else
			{
				outputText(" The townsfolk lynched their traitorous leaders right there and then under the watchful eyes of the Champion. " + player.mf("He","She") + " nodded approvingly when they gave their last twitches, seemingly happy to let small-town justice run its course.");
			}
			outputText("\n\nLife continued on. A new council was chosen, but it was Champion [name] that most people followed. " + player.mf("He","She") + " had left on the cusp of adulthood and returned a grizzled");
			outputText(" warrior. With a seemingly infallable champion there to defend it");
			if(getGame().camp.companionsCount() > 0)
			{
				outputText(" to say nothing of " + player.mf("his","her") + " bizarre friends");
			}
			outputText(", Ingnam prospered. The tiny village soon grew into a bustling town, and later a city.");
			outputText("\n\nWhen age finally claimed the unexpected " + player.mf("hero","heroine") + ", a stone statue of immense proportions was erected so that future generations could forever live under the protection of their greatest hero.");
			doNext(postEndingChoices);
		}
		
		private function claimFortress():void
		{
			clearOutput();
			outputText("This fortress would be a fitting seat to your power. But the question remains, what would you do from such a fortress? You could gather the pure forces of the land together into one army, and from here purge the demon’s corrupted taint from the land, or you could set yourself up in Lethice’s place. Many demons could be turned to serve you, now that you think about it. Surely you could rule better than she!");
			menu();
			addButton(0,"Purge",purgeShit);
			addButton(1,"Conquer",conquer);
		}
		
		private function HowFuckedIsThePlayerOMeter():Number
		{
			var levelOfFuckedness:Number = 0;
			//Increases the fuckedness
			if(flags[kFLAGS.FACTORY_SHUTDOWN] == 2)
				levelOfFuckedness += 50;
			if(flags[kFLAGS.SHEILA_DEMON] == 1)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.LETHICE_KILLED] == 0)
				levelOfFuckedness += 25;
			if(flags[kFLAGS.MINOTAURKING_KILLED] == 0)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.DRIDERINCUBUS_KILLED] == 0)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.D3_CENTAUR_DEFEATED] != 1)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.D3_GARDENER_DEFEATED] != 3)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.D1_OMNIBUS_KILLED] != 1)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.ZETAZ_DEFEATED_AND_KILLED] != 1)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.HARPY_QUEEN_EXECUTED] != 1)
				levelOfFuckedness += 25;
			if(getGame().camp.campCorruptJojo())
				levelOfFuckedness += 10;
			if(player.findStatusEffect(StatusEffects.WandererDemon) >= 0)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.AMILY_FOLLOWER] == 2)
				levelOfFuckedness += 10;
			if(flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] != 0)
				levelOfFuckedness += 10;
			//Decrease the fuckedness
			if(flags[kFLAGS.MORE_CUM_WITCHES] == 1)
				levelOfFuckedness -= 10;
			if(flags[kFLAGS.FREED_VALA] == 1)
				levelOfFuckedness -= 10;
			if(getGame().camp.ceraphIsFollower())
				levelOfFuckedness -= 5;
			if(flags[kFLAGS.OWCA_SACRIFICE_DISABLED] == 1)
				levelOfFuckedness -= 10;
			if(flags[kFLAGS.SAND_WITCHES_FRIENDLY] == 1)
				levelOfFuckedness -= 10;
			if(flags[kFLAGS.URTA_QUEST_STATUS] == 1)
				levelOfFuckedness -= 30;
			if(flags[kFLAGS.HELSPAWN_NAME] != 0)
				levelOfFuckedness -= 10;
			if(flags[kFLAGS.FARM_CORRUPTION_FIRST_DATE] != 0)
				levelOfFuckedness += 20;
			if(flags[kFLAGS.KID_A_XP] >= 100 && flags[kFLAGS.ANEMONE_WEAPON_ID] != 0)
				levelOfFuckedness -= 10;
			if(flags[kFLAGS.FUCK_FLOWER_LEVEL] > 3)
				levelOfFuckedness += 15;
			if(flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] != 0)
				levelOfFuckedness -= 5;
			if(flags[kFLAGS.COTTON_KID_COUNT] != 0)
				levelOfFuckedness -= 5;
			if(flags[kFLAGS.ANT_KIDS] != 0)
				levelOfFuckedness -= 20;
			if(getGame().camp.followerKiha())
				levelOfFuckedness -= 15;
			if(player.findStatusEffect(StatusEffects.PureCampJojo) >= 0)
				levelOfFuckedness -= 5;
			if(flags[kFLAGS.KATHERINE_UNLOCKED] == 4)
				levelOfFuckedness -= 5;
			if(player.findStatusEffect(StatusEffects.CampRathazul) >= 0)
				levelOfFuckedness -= 5;
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] >= 100)
				levelOfFuckedness -= 10;
			if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] >= 10)
				levelOfFuckedness -= 15;
			return levelOfFuckedness;
		}
		
		private function hasChildren():Boolean
		{
			if(player.statusEffectv1(StatusEffects.Birthed) > 0)
				return true;
			if(flags[kFLAGS.AMILY_BIRTH_TOTAL] > 0 || flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS] > 0)
				return true;
			if(flags[kFLAGS.BEHEMOTH_CHILDREN] > 0)
				return true;
			if(flags[kFLAGS.BENOIT_EGGS] > 0)
				return true;
			if(flags[kFLAGS.COTTON_KID_COUNT] > 0)
				return true;
			if(flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0)
				return true;
			if(getGame().emberScene.emberChildren() > 0 || flags[kFLAGS.EMBER_EGGS] > 0)
				return true;
			if (getGame().isabellaScene.totalIsabellaChildren() > 0)
				return true;
			if(flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0 || flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
				return true;
			if (flags[kFLAGS.JOJO_LITTERS] > 0)
				return true;
			if(flags[kFLAGS.KELLY_KIDS_MALE] > 0 || flags[kFLAGS.KELLY_KIDS] > 0)
				return true;
			if (getGame().kihaFollower.totalKihaChildren() > 0)
				return true;
			if(flags[kFLAGS.MARBLE_KIDS] > 0)
				return true;
			if(flags[kFLAGS.MINERVA_CHILDREN] > 0 || flags[kFLAGS.TIMES_BIRTHED_SHARPIES] > 0)
				return true;
			if(flags[kFLAGS.ANT_KIDS] > 0)
				return true;
			if(flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
				return true;
			if(flags[kFLAGS.SHEILA_JOEYS] > 0)
				return true;
			if(flags[kFLAGS.SHEILA_IMPS] > 0)
				return true;
			if(flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0 || flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0)
				return true;
			if(flags[kFLAGS.SOPHIE_EGGS_LAID] > 0)
				return true;
			if(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 0)
				return true;
			if(getGame().urtaPregs.urtaKids() > 0)
				return true;
			return false;
		}
		
		private function purgeShit():void
		{
			clearOutput();
			outputText("You gather an army of friends, companions");
			if (hasChildren())
			{
				outputText(", offspring");
			}
			outputText(", and the last pure forces in the land. Even those of questionable purity are gathered into the fold. With Lethice deposed, the remaining free peoples of Mareth flock to your leadership. The enchantment binding the pure waters of the world into cloud are broken, and the world has its first real rainfall in years, clearing the air of residual corruption and washing the taint from the soil into recessed cesspits.");
			var levelOfFuckedness:Number = HowFuckedIsThePlayerOMeter();
			if(levelOfFuckedness <= 50) {
				outputText("\n\nBy necessity, your campaign is brutal. So long as demons yet live, they’ll sow their corruption into those around them, who will in turn carry it inside them, like a plague. But you aren’t alone in this endeavor. Corruption can be cleansed by magic or will, and those fetid abominations that spread it can be killed once and for all.");
				outputText("\n\nThe campaign wages on for the better part of a year, but inevitably, the demons crumble before your forces. You singlehandedly claimed their fortress, leaving them no strong points save for a few factories - structures that were never really built to stand up to a siege. They could not trick your armies, for you would not make the mistake of negotiating with them, as you learned the goblins did.");
				outputText("\n\nIn time, peace came to Mareth.");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] != 2)
					outputText(" Marae reclaimed the full network of her roots and single-handedly purged the last holdouts of corruption from the lands, choking it out of her world like weeds from a garden.");
				else
					outputText(" Marae fought for a time, but even corrupted goddesses cannot hold back your tide of purity. Her fall was the biggest blight on your campaign, a sad footnote on an otherwise successful reclamation.");
				outputText("\n\n<b>You ended the demon threat forever and saved Mareth.</b>");
				flags[kFLAGS.GAME_END] = GAME_END_PURGE_0_50;
			}
			else if(levelOfFuckedness <= 100) {
				outputText("\n\nBy necessity, your campaign is brutal. There are so many demons, and they’re so skilled at sowing their corruption into everything around them that wiping them out seems an impossible task. Even with the return of the rains, this world is still filled with hundreds of festering blights. Yes, you can cleanse corruption with your magic or your will, but there’s so much of it. The world is so infected that the task before you seems almost impossible at times.");
				outputText("\n\nYou do not let that deter you, not when your campaign drags into its tenth season or even its twentieth. You may have been a champion in name only, but you live up to the title. Again and again, you break the demon’s fortresses and holds. You burn what cannot be purified and wipe clean those few things that can. They run and rebuild, but you chase them, tirelessly scouring them from the face of this warped planet.");
				outputText("\n\n");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] != 2)
					outputText("Marae is a wonderful aid in your quest, always able to manifest in her newly purified roots and offer words of wisdom or encouragement. Her magical might is a rock you can lean upon when times are tough. You aren’t sure how long you could keep this up without her.");
				else
					outputText("Marae is always there, always lending her power to the demons, even when you dig her roots out of the ground with shovels and axes, burning the greasy lumber into nothingness. This task would be so much easier if the goddess was on your side, but still, you persevere.");
				outputText("\n\nSlowly but steadily, you make headway. On your fortieth birthday, you receive word that Tel’Adre has been restored to its full strength. On your forty-fifth, you realize that you’re close to winning. Those few demons that remain are madly spawning imps, but the flimsy fliers are no match for a hail of flaming arrows or arcs of magic.");
				outputText("\n\nYou are well into your fifties by the time you’re ready to declare victory.");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] != 2)
					outputText(" Those few pockets that escaped your armies could not escape Marae’s all-encompassing roots. Mareth is purified once more.");
				else
					outputText(" A few places are tainted still, but it’s impossible to cleanse every cave. Instead, you make instructions to maintain the army. Should evidence of corruption arise anywhere, your forces will swiftly put it to flame.");
				outputText(" Peace returns to the land. You did it. You saved this world.");
				outputText("\n\nThe champions that followed you through the portal year after year find a way home in the abandoned texts inside your keep. You go with them, for a time, but you’ve lived too long in Mareth to stay anywhere else. The twisted reality of the once-demonic realm is your home. Besides, you’ve made too many friends here to abandon them.");
				flags[kFLAGS.GAME_END] = GAME_END_PURGE_50_100;
			}
			else {
				outputText("\n\nBy necessity, your campaign is brutal. There are so many demons, and they’re so skilled at sowing their corruption into everything around them that wiping them out seems an impossible task. Even with the return of the rains, this world is still filled with endless festering blights. Yes, you can cleanse corruption with your magic or your will, but there’s so much of it. The task seems impossible, but still, you attempt it.");
				outputText("\n\nThe demons were once able to exploit the naivete of Mareth’s inhabitants, but no longer. Every living creature on this plane has had ample time to suffer firsthand at the yoke of their infernal treachery. Without their trickery, the demonic armies are forced to survive by the strength of their magic and their arms alone. Both are mighty, but so are you.");
				outputText("\n\nYou fight them in a seemingly endless war. For every victory, a battalion is enveloped in a swarm of imps. For every inch of ground you gain, the earth is soaked in blood, sweat, and cum. Fresh faced recruits from Tel’Adre arrive only to be matched by hulking, demonic minotaurs. The sand witches lend covens only to be countered by the steel-eyed gazes of basilisks.");
				outputText("\n\nYou grow old to the sound of steel on steel. Mareth becomes a bloodbath fueled by its own insane fertility, a host for the never ending battle between the last bastion of good and a rape-happy horde. Some good comes of your war, at least. The demons cannot do any more damage. The world behind your lines can recover, even if the world you oppose steeps itself ever deeper in despair.");
				outputText("\n\nEventually, you die. Not of wounds in battle, but from old age. Your whole life was a war for this realm, one that could not be won in your allotted years. Perhaps if you had been more aggressive in dealing with the demons in your youth, this would have ended differently.");
				flags[kFLAGS.GAME_END] = GAME_END_PURGE_100;
			}
			outputText("\n\n<b>THE END</b>");
			doNext(postEndingChoices);
		}
		
		private function conquer():void
		{
			clearOutput();
			if(player.cor <= 33)
			{
				outputText("You could definitely run this place better than Lethice, and though she had many corrupted lieutenants, surely their worst depredations could be reigned in by your steady hand. You");
				if(getGame().camp.companionsCount() > 0)
				{
					outputText(" gather your follower");
					if(getGame().camp.companionsCount() > 1)
					{
						outputText("s");
					}
					outputText(" in the citadel itself and");
				}
				outputText(" familiarize yourself with the place. Rather than driving off the few remaining demons you find, you place them into your service, explaining that so long as they serve you loyally they may yet live.");
				outputText("\n\nWord gets out over the coming days about the new " + player.mf("King","Queen") + " of the demons, and little by little, the masterless hordes find their way back.");
				if(flags[kFLAGS.LETHICE_KILLED] == 0)
				{
					outputText(" Lethice herself is even brought back, though this time securely leashed and empty-eyed.");
				}
				outputText(" You order the worst of their factories shut down and put an end to attempts to locate Tel’Adre. No more will the demons be all-consuming force.");
				outputText("\n\nUnder your heel, they’ll loose the rains they’ve kept magically bound in the clouds for so long. Ruined places will be rebuilt to their former glories. Demonic scientists will work to tame the base urges they’ve engendered in the goblins, harpies, and minotaurs. It’ll be like a utopia, the kind of utopia that Lethice could have created if she had used her power properly instead of selfishly hoarding it.");
				outputText("\n\nSo what if there’s an excess of mind-broken demons and former slaves lazing about your mountaintop castle? You treat them better than their former owners ever did, and besides, it’d be cruel not to let them service you. It’s practically all they live for nowadays.");
				outputText("\n\nYou get used to it after a while - the constant pleasures, armies of slaves fawning over you. Your temper with your subordinates shortens. The longer you rule, the less it seems like you’re surrounded by competent individuals and the more you feel like you’re the zookeeper in a sea of animals. Ordering your chief enforcer to orally service you after a particularly terrible failure seems like it might be too far until her tongue presses into your aching flesh.");
				outputText("\n\nThen you wonder why you didn’t do this sooner.");
				outputText("\n\nYou tighten your rule, but the tighter you close your grip on Mareth, the more often you need to dispense punishments. The more punishments you dispense, the more you find yourself looking forward to the next one. How did you get by before you had a dozen succubi to provide you orgasms on the hour and a squad of incubi musicians ceaseless singing your praises?");
				outputText("\n\nThe changes are slow. Years pass, but inevitably, you see the wisdom in becoming an immortal demon. How else will you save the poor wretches of this plane from themselves?");
				outputText("\n\n<b>You’ve won, but at what cost?</b>");
				flags[kFLAGS.GAME_END] = GAME_END_CONQUER_LOW;
			}
			else if(player.cor <= 66)
			{
				outputText("Lethice truly didn’t know what she was doing. She had one of the mightiest armies Mareth had ever seen at her beck and call. Her scientists and magicians worked never-before-seen wonders at her behest. The technology on display in one of her factories alone could advance the civilizations of the realm by decades. Yet she squandered it all on pointless armies and perverse devices with little practical use.");
				outputText("\n\nSure, you can see the appeal of having a few fuck-addled sluts to tend to your baser needs, but there’s no need to transform the whole world into them. Surely there’s a middle ground. You set out to find it.");
				outputText("\n\nThe first step is moving");
				if(getGame().camp.companionsCount() > 0)
				{
					outputText("your followers from");
				}
				outputText(" your camp away from the old portal and into the fortress. With their organization broken, the demons will hardly be in any position to mount an organized invasion into your world, and once you cow them into submission, they’ll work for you. Luckily, a few hung around after the fight. Either they weren’t close enough to the throne to hear the commotion or they didn’t care.");
				outputText("\n\nConvincing them to work for you isn’t easy as you hoped, but they cave all the same. They have friends too, or at least what passes for friends amongst the soulless abominations. Word gets out fast, and your horde swells. Those who disobey you are swiftly brought in line by your loyal troops, acknowledging your power in spite of your less-corrupted ways.");
				outputText("\n\nOne of your first orders is to let loose the rains that have been suspended in the clouds around your mountain for so long. Torrential downpours scour the landscape in the wake of your order, washing the residual corruption from the air the ground. And with the factories shut down, everyone should breathe a little easier.");
				outputText("\n\nAll goes well for a time. Hungry succubi are there to wake you with their unearthly tongues every morning. Food is plentiful, provided by magic. Tel’Adre and the other free places are safe. You even have some of the ruined cities rebuilt.");
				outputText("\n\nSo what if you collect steep taxes for protection from the demons, or that you decide slave-breaking is more efficient than capital punishment. At least this way the worst criminals have a use. You even get to take them for a spin after they’ve been ‘reformed.’");
				outputText("\n\nYou get used to it after a while - the constant pleasures, armies of slaves fawning over you. Your temper with your subordinates shortens. The longer you rule, the less it seems like you’re surrounded by competent individuals and the more you feel like you’re the zookeeper in a sea of animals. Ordering your chief enforcer to orally service you after a particularly terrible failure seems like it might be too far... until her tongue presses into your aching flesh.");
				outputText("\n\nThen you wonder why you didn’t do this sooner.");
				outputText("\n\nYou tighten your rule, but the tighter you close your grip on Mareth, the more often you need to dispense punishments. The more punishments you dispense, the more you find yourself looking forward to the next one. How did you get by before you had a dozen succubi to provide you orgasms on the hour and a squad of incubi musicians ceaseless singing your praises?");
				outputText("\n\nThe changes are slow. Years pass, but inevitably, you see the wisdom in becoming an immortal demon. How else will you save the poor wretches of this plane from themselves?");
				outputText("\n\n<b>You’ve won, but at what cost?</b>");
				flags[kFLAGS.GAME_END] = GAME_END_CONQUER_MED;
			}
			else
			{
				outputText("For all her might, Lethice had no idea what she was doing. She subsumed herself in corruption to no effect, washing away her reason in order to consistently and constantly overindulge in pleasure.");
				outputText("\n\nYou won’t make the same mistake. You scour the castle’s every hallway, rooting out those demons that remain. Those smart enough to surrender join you, while those who dare to oppose your rule fall. Next, you set a watch and return to camp, gathering your things");
				if(getGame().camp.companionsCount() > 0)
				{
					outputText(" and follower");
					if(getGame().camp.companionsCount() > 1)
					{
						outputText("s");
					}
				}
				outputText(". With Lethice’s rule broken, there’s no danger of a demonic invasion of your homeland, and you’ll have any surviving rogues in hand soon enough.");
				outputText("\n\nThat night, you send word through the land of Lethice’s loss. Your demonic agents tell their fellows of your power and strength, gathering more to your cause. Those free peoples with an ounce of sense pledge their loyalty to you, and those with more pride than the fallen Queen unwittingly sign the orders for their own invasion.");
				outputText("\n\nThe only way to keep the world from falling into ruin once more is to have one kingdom under absolute rule. You make full use of the Lethice’s facilities to enforce your laws. Her submission tanks break malcontents into willing, eager servants. Her factories provide fluids unending to taint those who dare to hide from you. The magic that trapped the rain in the clouds about the citadel is yours to command, allowing your farmers to easily grow crops while your enemies’ wilt in the sun.");
				outputText("\n\nIn the short span of a few years, you achieve control over nearly all the peoples of Mareth. Tel’Adre, the sand witches, the giant bees of the forest: they all answer to you. Even the demons are bound to your yoke, though you have to make an example of them from time to time in order to maintain order. They try to tempt you, of course. Their sensuous lures and slow-burning corruption are a waste of effort, of course. You were already corrupted when you defeated Lethice. If you were going to fall into debauchery, you would have already.");
				outputText("\n\nAge is your only problem, but your servants devise draughts to keep you young, treatments to keep your flesh as firm and vigorous as the day you stepped through the portal. <b>You rule Mareth as its ageless " + player.mf("King","Queen") + ", a harsh monarch whose word is law and whose whims are made manifest.</b>");
				
				flags[kFLAGS.GAME_END] = GAME_END_CONQUER_HIGH;
			}
			outputText("\n\n<b>THE END</b>");
			doNext(postEndingChoices);
		}
		
		private function postEndingChoices():void {
			clearOutput();
			outputText("What would you like to do?");
			menu();
			addButton(0, "Export", exportSaveData, null, null, null, "Export your save for possible use in CoC2.");
			if (flags[kFLAGS.GAME_END] == GAME_END_CONSORT)
				addButtonDisabled(1, "Continue", "Nuh-uh. Mareth is too fucked up to let you continue and it's all due to the consequences you've made.");
			else
				addButton(1, "Continue", postEndingReturn, null, null, null, "Continue the game so you complete anything you've missed.");
			addButton(4, "Quit", quitToMenu, null, null, null, "Quit and return to the main menu?");
		}
		
		private function postEndingReturn():void {
			clearOutput();
			outputText("You may have defeated Lethice and completed the main story but the fun isn't over! It's time for you to return to the game and begin a new era of Mareth.");
			outputText("\n\n<b>You can now ascend if you like. Search for the book in the ruined cathedral and perform the ritual at your camp.</b>");
			awardAchievement("Demon Slayer", kACHIEVEMENTS.STORY_FINALBOSS, true, true, false);
			if (player.level <= 1) awardAchievement("Ultimate Noob", kACHIEVEMENTS.CHALLENGE_ULTIMATE_NOOB, true, true, false); //Lethice beaten at level 1!
			inDungeon = false;
			inRoomedDungeon = false;
			player.HP = player.maxHP();
			player.lust = player.minLust();
			player.fatigue = 0;
			player.hunger = 100;
			model.time.hours = 23;
			inventory.takeItem(weapons.L_WHIP, camp.returnToCampUseEightHours);
		}
		
		private function quitToMenu():void {
			player.str = 0;
			getGame().mainMenu();
		}
		
		public function takeLethiciteArmor():void {
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = 1;
			clearOutput();
			//outputText("Thankfully, the armor is still there. ");
			inventory.takeItem(armors.LTHCARM, getGame().d3.resumeFromFight, putBackLethiciteArmor);
		}
		private function putBackLethiciteArmor():void {
			flags[kFLAGS.LETHICITE_ARMOR_TAKEN] = 0;
			clearOutput();
			outputText("Unfortunately, you don't have enough space in your inventory so you put the armor back where it was.");
			doNext(getGame().d3.resumeFromFight);
		}
	}
}
