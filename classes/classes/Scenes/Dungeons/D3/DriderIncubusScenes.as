package classes.Scenes.Dungeons.D3
{
	import classes.BaseContent;
	import classes.Items.WeaponLib;
	import classes.StatusEffects;
	import classes.GlobalFlags.kFLAGS;
	import classes.PerkLib;
	import classes.PregnancyStore;
	
	public class DriderIncubusScenes extends BaseContent
	{
		 
		public function DriderIncubusScenes()
		{
			super();
		}
		
		public function encounterDriderIncbutt():void
		{
			clearOutput();
			outputText("The door swings freely from the slightest touch, allowing you to push the well-worked portal open with ease. The view is astonishing. An open chamber big enough to house your entire village stretches away, filled with cavorting, glistening slaves of all shapes and races, locked in displays of unending, licentious delights. Lethice’s throne rises above it all, located at the back end of the room - the peak of this plane’s perversion. The corrupt queen hasn’t noticed you yet, but an eight-legged spider-man has, turning from a captive bee-girl with cruel pleasure in his eyes.");
			outputText("\n\n<i>“Whoah there, Champion. Did you really think you could waltz into Lethice’s throne room unopposed?”</i> He clicks his teeth, almost chittering. <i>“I’m going to beat you. I’m going to bind you. And I’m going to drop you at her feet and bask in the glory of watching her transform you into a mindless, rutting beast.”</i> He skitters closer, abandoning his captive and raising a spear, malice glittering in his eyes.");
			outputText("\n\nThe torchlight glitters on his coal-black skin, revealing another captive - this one strapped to his humanoid half’s middle. She’s a typical goblin by the looks of her, presently impaled on a writhing, demonic shaft that sprouts from where the drider’s chitin transforms into skin. He seems to pay her no regard as he advances. <i>“Why not surrender and spare your tender flesh from my spear?”</i>");
			outputText("\n\nAs if. Looks like you’ll have to fight past him.");
			startCombat(new DriderIncubus());
		}
		
		public function spooderbuttGetsANewCockSleeve(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			clearOutput();
			var m:DriderIncubus = monster as DriderIncubus;
			outputText("The floor of Lethice’s throne room isn’t as cold as you would have thought against your");
			if (hpVictory)
			{
				outputText(" wounded");
			}
			else
			{
				outputText(" flushed");
			}
			outputText(" cheek.");
			if (hpVictory)
			{
				outputText(" You don’t even remember dropping. One moment you were fighting an eight-legged demonic aberration, and the next you were face down on polished granite, your head throbbing.");
				outputText("\n\nKinariel’s insectile legs clatter noisily as he circles you. <i>“I told you this would happen. It would have been better if you hadn’t struggled. The Demon Queen does not like her prey to bear bruises from capture.”</i> He clicks his jaw closed in consternation. <i>“There’s no helping it, I suppose. Cease your struggles and accept your fate.”</i>");
			}
			else
			{
				outputText(" You were too turned on to care when you started slinking down to the polished granite.");
				if (player.weapon != WeaponLib.FISTS)
				{
					outputText(" Your [weapon] clattered dully next to you, forgotten next to your all-consuming need.");
				}
				outputText("\n\nKinariel’s insectile legs clatter noisily as he circles you. <i>“A shame you resisted. I do regret driving you to such a state. The Demon Queen prefers to do so herself, you see.”</i> He clicks his jaw closed noisily. <i>“Cease your squirming. If you ever want to orgasm again, you’ll need to earn the reward from </i>her<i>.”</i>");
			}
			outputText("\n\nA sound somewhere between a hiss and tearing fabric follows the declaration from above and behind you. Those menacing legs curl beneath your hapless body and spin you with dizzying speed. You try to struggle, but your [legs] are pinned together by something, bound up in some kind of inelastic fabric that might as well be coils of steel. You look down and immediately wish you hadn’t. The lower half of your body is already wrapped in white fibers spun from the drider’s arachnid half. The wrappings creep higher with each casual spin of your body.");
			outputText("\n\nYou’re surrounded by a cage of ivory webbing before you know it. The ends stick to your neck irritatingly, but thankfully the demonic drider did not choose to envelop your head. You couldn’t");
			if (hpVictory)
			{
				outputText(" breath through such a thick covering.");
			}
			else
			{
				outputText(" pant needily under such a thick covering.");
			}
			outputText(" If only you could move!");
			outputText("\n\nKinarial easily passes you to his human hands, tucking you under a shoulder");
			if (!player.isTaur() && !player.isDrider())
			{
				outputText(" and across the top portion of his spidery back");
			}
			if (m.goblinFree)
			{
				outputText(" while his goblin slave remounts his dick");
			}
			outputText(". <i>“I must confess, I wondered what Lethice would choose to do with such a prize. Would she try to turn you into a loyal demonic footsoldier or break you into a beast of burden, suitable only to serve our whims and salacious desires?”</i> He skitters through the throng of spectating demons. <i>“Time to find out.”</i>");
			outputText("\n\nA deathly silence falls over the assembled corruptors and their slaves while you are carried to the throne at the end of the hall. A gigantic minotaur and his big-breasted cow-slave even make way for Kinariel.");
			menu();
			addButton(0,"Next",spooderbuttGetsANewCockSleeveII);
		}
		
		public function spooderbuttGetsANewCockSleeveII():void
		{
			clearOutput();
			outputText("The way you’re being held, you can’t get a proper look at the Demon Queen. You can barely see anything past the dick-mounted goblin’s heaving tits and slow-grinding body, and what you can see is mostly floor, a little bit of throne, and petite pink feet with black-painted nails. Those toes wiggle happily. The owner clicks her heels together, revealing bone-spikes that keep her soles arched like high-heels.");
			outputText("\n\n<i>“I must say, I’m surprised, Kinariel. I did not think you’d manage to vanquish such a troublemaker all by your lonesome.”</i> Long-nailed fingers dig into your chin and twist your head around for a better view. <i>“And I’m disappointed. I had hoped you would prove a decent challenge. It has been so long since I’ve gotten to let loose in a fight.”</i> She tuts at you. <i>“Such a shame. Still, you have the aura of a breeder about you. You may yet serve me. Kinariel, put " + player.mf("him","her") + " down.”</i>");
			outputText("\n\n<i>“As you wish my Queen,”</i> the handsome drider responds with a bow low enough to click his horns against the floor. He drops you at the same time, leaving you to hit the ground heavily. <i>“Is there anything else I can do for you, Mistress?”</i>");
			outputText("\n\nLethice’s voice lilts pleasantly. <i>“No. The offer and your service are appreciated. Once I finish with this one I shall see you suitably rewarded. You will return to your people a king.”</i> A weighty pause hangs over the assembled demons. <i>“And if you like, you may have first pick of the slaves from Tel’Adre once the invasion is over. I understand you had designs upon a pair or fox-girls.”</i>");
			outputText("\n\n<i>“You are most gracious my Queen.”</i>");
			outputText("\n\n<i>“Indeed I am.”</i> Soft fingers stroke your hair. <i>“You are free to go, Kinariel. I will send word for you shortly.”</i>");
			outputText("\n\nThe bowing demon lord’s shadow falls across you. You can’t see much, but you swear he’s smiling. He skitters away with astounding rapidity after three or four seconds, leaving you alone with the Queen of Corruption, Lethice.");
			menu();
			addButton(0,"Next",spooderbuttGetsANewCockSleeveIII);
		}
		
		public function spooderbuttGetsANewCockSleeveIII():void
		{
			clearOutput();
			outputText("Your bindings are cut from you by something short and sharp, the point pressing hard enough that you worry it will score your [skin]");
			if (player.skinType != 0)
			{
				outputText(" through your [skinFurScales]");
			}
			outputText(". It doesn’t. Lethice is too skilled to physically damage what she sees as her future property. To think, you believed you’d be able to defeat her all by yourself, and now you’re on the floor, unable to stop her from handling your supine form as she will.");
			outputText("\n\nThe webbing falls away, and a firm hand rolls you to your back for your first good look at your captor. She’s beautiful. You want to hate her. You want her to be an ugly, wretched hag, but she isn’t. Her face is perfectly proportioned and topped with luxurious purple hair. Curling demonic crowns grow from her temples like two halves of a majestic, white crown while smaller, nubbier growths protrude cutely from her forehead.");
			outputText("\n\nHer eyes capture your own inside their inky, black-rimmed depths, stopping your searching gaze from wandering any farther down her form. They’re beautiful and terrible, like the eyes of a great hunting beast, yellow and vertically split. When you look into them, it’s obvious that you’re seeing a predator - something whose entire purpose is preying upon mankind");
			if (player.humanScore() < 5)
			{
				outputText(", no matter how mutated");
			}
			outputText(". You’re drowning in those infinitely deep eyes, aware for once that even a champion cannot hold a candle to an immortal devourer of souls.");
			outputText("\n\nThe pink-skinned queen lazy jostles her chalice of pink crystals, nodding. <i>“You see now, don’t you? The truth of it... You never had a chance against me. Your foolish crusade was as unimportant as the scrabbling of an ant, destined only to carry you to your inevitable fate.”</i> She smiles a smile that never quite reaches those ink-wrapped eyes of hers. <i>“Now that you’re here, I can begin your education.”</i>");
			outputText("\n\nYou want to deny her, desperately so, but she’s right, isn’t she? Your elders sold you out to the demons. For all your fighting and struggling");
			if (player.cor >= 50)
			{
				outputText(", you’ve let yourself become corrupted");
			}
			else
			{
				outputText(", you’ve been sorely tempted by the rampant corruption of these lands");
			}
			outputText(".");
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2)
			{
				outputText(" You couldn’t even save one of the last pure spirits in this place, Marae.");
			}
			outputText(" It’s only a matter of time until Tel’Adre falls,");
			if (flags[kFLAGS.FARM_CORRUPTION_STARTED] == 0)
			{
				outputText(" Whitney’s farm is consumed");
			}
			else
			{
				outputText(" Lethice thanks you for preparing Whitney’s farm");
			}
			outputText(", or worse. You go limp, defeated");
			if (player.lust >= 90)
			{
				outputText(" and horny");
			}
			outputText(", but unwilling to admit as much to your long-time foe.");
			outputText("\n\n<i>“Good " + player.mf("boy","girl") + ".”</i> Lethice strokes your hair, ignoring the tears at the corners of your eyes. <i>“You deserve a reward I rarely give.”</i> She breaks your gaze, allowing you to watch her lift long black skirt, almost like something a nun would wear, if a nun had holes cut in the top to display her rigid, pierced nipples. Higher and higher, the fabric ascends up her perfectly smooth legs until a dewy, pink slit is revealed. <i>“You will be permitted to lick me as a free " + player.mf("man","woman") + ", before you go in the submission tanks.”</i>");
			outputText("\n\nYou look back up at her in shock, accidentally meeting her gaze once more. It’s even easier to fall into her trapped eyes than the last time.");
			outputText("\n\n<i>“If you do a good job, I’ll instruct them to maintain as much of your personality as possible.”</i> Lethice’s voice rings with as much truth as it does authority. <i>“Displease me and you shall be an empty-headed husk, fit only for reproduction.”</i> She giggles, <i>“But there’s no way a </i>good " + player.mf("boy","girl") + "<i> like you would fail to please, is there?”</i>");
			menu();
			addButton(0,"Next",spooderbuttGetsANewCockSleeveIV);
		}
		
		public function spooderbuttGetsANewCockSleeveIV():void
		{
			clearOutput();
			outputText("Lethice’s will presses on you like a physical thing.");
			if (player.cor < 50)
			{
				outputText(" No matter how repugnant the idea of eating her out might have seemed a moment ago, you find your thoughts increasingly turning to her pussy.");
			}
			else
			{
				outputText(" No matter what objections you might have had to the idea, you’re too horny to make even a token effort at resistance.");
			}
			outputText(" What will she taste like? She’s a demon; it could be anything. Her pussy could be flavored with the sweetest strawberries or contain flavors your mortal tongue could barely comprehend.");
			outputText("\n\nYou struggle up and wipe the drool from the side of your mouth. When did that start?");
			outputText("\n\n<i>“Oh, look at you, on your knees and drooling. You flatter me, Champion, you really do.”</i> Lethice spreads her lips. Wetness drips from them in thick rivulets. <i>“See? You’re getting me all wet.”</i>");
			outputText("\n\nShe’s way wetter now than she was a moment ago, and");
			if (player.vaginas.length > 0)
			{
				outputText(" judging by the way your [armor] is clinging to your crotch, she’s not the only one.");
				if (silly())
				{
					outputText(" You could probably drown someone in your panties.");
				}
			}
			else if (player.cocks.length > 0)
			{
				outputText(" judging by the way pre is pouring out of your [cocks], she’s not the only one.");
			}
			else if (player.lust >= 95)
			{
				outputText(" judging by how much you’re salivating, she’s not the only one.");
			}
			else
			{
				outputText(" judging by how hot your [skin] feels, she’s not the only one overcome with randiness.");
			}
			outputText(" With each droplet that spills from her feminine crevice, your curiosity and instinctive desire spikes. The splatter of a droplet on the floor is like a lightning bolt of erotic energy to your brain.");
			outputText("\n\nYou do the only thing you can when kneeling before a demon queen’s dripping snatch. You moan and extend your tongue, leaning forward with rapacious hunger. Lethice’s eyes slip away, and your gaze is filled with her puffy mons and purple-flushed lips. The dribbles journeying down her legs seem to slide against your very soul. The pink center of it all beckons for you to touch it, to taste it. Your [legs] quiver as you close in.");
			outputText("\n\nThe smell hits you first, warm and sweet as apple pie yet perniciously and overwhelmingly sexual. You can’t really describe it. It’s beyond the scope of your understanding, and you have the feeling that if you smelled her a thousand times you still couldn’t adequately describe the sublime aroma of her perfect, blossoming cunt. There’s something inherently </i>wrong<i> about how good it smells, inhuman even, but you want more all the same. When you finish, you’re going to want more. Her scent is a whip that flagellates your better reason until it retreats into the darkest corners of your mind like a beaten dog.");
			outputText("\n\nYou don’t try to wipe the drool from your chin this time. You close your eyes to better focus on the wonderful sensations she engenders in you. A single thought of concern surfaces only to be swiftly locked away by your rampaging need.");
			outputText("\n\nYour tongue fizzes on contact with her ambrosial quim, tastebuds seeming to detonate like fireworks tossed into a bonfire by a careless hand. It doesn’t taste like strawberries, and it damned sure doesn’t resemble an apple pie. It’s something else, wet and syrupy, clinging as thickly to your soul as to your tongue. You surge forward on wings built of naked, demonic desire, determined to have as much of her in your mouth as possible, to taste every fold, savor every drop, and devour the fruits of your sinful labors.");
			outputText("\n\nLethice giggles like a girl with her first lover before transitioning into full-bodied moans. Thunderous applause rises around you, and though the locked-away part of you wants to feel shame, the pussy-licking whore slavishly worshipping Lethice’s cunt thrills at the compliment. You noisily slurp and suck, determined to please your audience as well as the source of the sensuous nutrients you deserve.");
			outputText("\n\nYour cheeks, nose, and chin soon gleam with excess lubricant. You look up with feverish eyes, aware of how you must look and yet incapable of caring. Your [tongue] slithers around her gumball-pink clitoris, making the Corrupt Queen shudder and buck against your face. Then, you slip your oral muscle deeper into her crevice and seal your upper lip against her swollen nub. The ensuing moan is loud enough to make your ears ring.");
			outputText("\n\nA river of honey gushes into your mouth, splashes off your tonsils, and runs down your hungry maw. The pink lips gently flutter against your mouth as you double-down on Lethice’s clit, sucking gently upon it while rhythmically spearing your tongue deeper into her quivering folds. Your body quivers right along with hers; you can taste her ecstasy like a physical thing, absorbing her pleasure into yourself through a wildly thrusting tongue.");
			outputText("\n\nYou smell pussy, you taste pussy, and you shiver through the vicarious bliss until the echoes of ecstasy have you pushed to the edge of your endurance. Your mouth slackens as Lethice grinds against it. Your voice rises into a screaming moan, an imperfect clone of her demoness’s own orgasmic exhortations.");
			if (player.cocks.length > 0)
			{
				outputText(" Your [cocks] spurt");
				if (player.cocks.length > 1)
				{
					outputText("s");
				}
				outputText(" uselessly into your [armor].");
			}
			if (player.vaginas.length > 0)
			{
				outputText(" Your [vagina]");
				if (player.cocks.length == 0)
				{
					outputText(" drenches your undergarments");
				}
				else
				{
					outputText(" mixes right in with all that waste cum");
				}
				outputText(".");
			}
			outputText("\n\nYou feel like a guitar string being tuned tighter and tighter, vibrating at a higher and higher pitch of pleasure until it’s about to snap.");
			outputText("\n\nLethice’s hand abruptly pushes your forehead away before you shut down entirely, and even then, you lie on the floor, tongue extending to hunt for more.");
			menu();
			addButton(0,"Next",spooderbuttGetsANewCockSleeveV);
		}
		
		public function spooderbuttGetsANewCockSleeveV():void
		{
			clearOutput();
			outputText("You come to when a pair of demonic minotaurs loop their furry arms under your elbows and begin to drag you away. Lethice is watching with hunger in her inhuman eyes. Her dress has been lowered, but there’s no hiding the puddle your efforts created beneath her. Your jaw aches from the effort. Just how long were you eating her out?");
			outputText("\n\nExhausted, blissful sleep claims you before you leave the chamber.");
			menu();
			addButton(0,"Next",spooderbuttGetsANewCockSleeveVI);
		}
		
		public function spooderbuttGetsANewCockSleeveVI():void
		{
			clearOutput();
			outputText("True to " + player.mf("his","her") + " words, Lethice conquered Tel’Adre that same year, and the rest of Mareth fell in short order. The Champion came to understand the truth of Lethice’s words");
			if (player.vaginas.length == 0)
			{
				outputText(", and after being outfitted with suitable genitalia,");
			}
			else
			{
				outputText(" and");
			}
			outputText(" served in the breeding pits, endlessly fornicating to maintain an army of expendable imps.");
			outputText("\n\nThe Dark Queen did not forget her favorite prize. At least once a week, time permitting, she would visit the former champion and allow " + player.mf("him","her") + " to tend to her endless, corrupted needs. Hours would pass with little more than the friction of a tongue against a slick slit, and the former champion had never been happier.");
			getGame().gameOver();
		}
		
		public function beatTheSpooderbutt(hpVictory:Boolean):void
		{
			flags[kFLAGS.DRIDERINCUBUS_DEFEATED] = 1;
			clearOutput();
			var m:DriderIncubus = monster as DriderIncubus;
			if (hpVictory)
			{
				outputText("<i>“No!”</i> the corrupted drider cries before collapsing on the floor, too battered to stand any longer. <i>“It cannot be! A mortal cannot stand against Lethice and prevail!”</i>");
			}
			else
			{
				outputText("<i>“No!”</i> the corrupted drider cries before collapsing to the floor, writhing widly. He’s too aroused for any kind of proper coordination");
				if (!m.goblinFree)
				{
					outputText(", but he pushes the goblin off his cock all the same");
				}
				else
				{
					outputText(", but he grabs hold of his cock all the same");
				}
				outputText(", masturbating like wild. <i>“H-h-how could a mortal stand against Lethice and win? H-h-how!?”</i>");
			}
			outputText("\n\nA thudding voice somewhere between an avalanche and a rockslide answers, laughing, <i>“Not Lethice, but certainly you. You never belonged here, Kinarial.”</i>");
			outputText("\n\nAnother voice, this one high-pitched, agrees, <i>“Well said.”</i>");
			outputText("\n\nSilence hangs over the assembled demons and their playthings for a pregnant moment. The female voice - Lethice’s - adds, <i>“Go ahead, Champion. Claim your reward if you wish. I would delight in seeing what kind of lover you are.”</i>");
			outputText("\n\n");
			if (!m.goblinFree)
			{
				outputText("The goblin slowly separates from her fallen master.");
			}
			else
			{
				outputText("The goblin drops to her knees.");
			}
			outputText(" Her eyes are full and luminous. She laces her fingers together and begs, <i>“Please don’t kill Mitzi, Champion! She can be yours.”</i> She drops to her hands and knees, crawling toward you. A petite hand tugs at your [armor]. <i>“Mitzi will be a good slave.”</i>");
			outputText("\n\nMitzi");
			if (player.cocks.length > 0)
			{
				outputText(" wiggles her");
				if (m.goblinOiled)
				{
					outputText(" oiled-up");
				}
				outputText(" butt at you");
			}
			else
			{
				outputText(" unspools a three-foot long tongue from between her plump lips");
			}
			outputText(", winking. <i>“Be mitzi’s [master], and mitzi will help you!”</i>");
			outputText("\n\nIt looks like the demons intend to let you relieve yourself of any lusts you might have. You’ve got a willing goblin right there, but Kinarial may be of use as well...");
			driderDefeatMenu();
		}
		
		public function driderDefeatMenu():void
		{
			var doneDriderbus:Boolean = false;
			var doneGoblin:Boolean = false;
			menu();
			if (flags[kFLAGS.DRIDERINCUBUS_KILLED] != 1 && flags[kFLAGS.DRIDERINCUBUS_FUCKED] != 1)
			{
				addButton(0,"Kill Drider",killDrider);
				if (player.vaginas.length > 0)
				{
					addButton(1,"Ride Drider",rideDrider);
				}
				if (player.cocks.length > 0)
				{
					addButton(2,"Buttfuck Drider",buttfuckDrider);
				}
			}
			else
			{
				doneDriderbus = true;
			}
			if (flags[kFLAGS.MITZI_RECRUITED] != 1)
			{
				if (flags[kFLAGS.MITZI_FUCKED] != 1)
				{
					if (player.cocks.length > 0)
					{
						addButton(5,"Fuck Goblin",fuckMitzi);
						addButton(6,"Goblin Tittyfuck",titfuckMitzi);
					}
					if (player.vaginas.length > 0)
					{
						addButton(7,"Goblin Licks",mitziEatsPussy);
					}
				}
				addButton(8,"Recruit Goblin",recruitMitzi);
				if (doneDriderbus)
				{
					addButton(9,"Leave Goblin",afterDriderbuttFight);
				}
			}
			else
			{
				doneGoblin = true;
			}
			if (Boolean(doneDriderbus) && Boolean(doneGoblin))
			{
				afterDriderbuttFight();
			}
		}
		
		public function afterDriderbuttFight():void
		{
			combat.cleanupAfterCombat(getGame().d3.resumeFromFight);
		}
		
		public function killDrider():void
		{
			clearOutput();
			outputText("You laugh at Lethice and the goblin. <i>“This is all the reward I need.”</i> You press your");
			if (player.lowerBody == 5)
			{
				outputText(" heel");
			}
			else
			{
				outputText(" [foot]");
			}
			outputText(" down on the corrupted drider’s neck until you hear a sickening ‘pop’. He doesn’t move after that.");
			flags[kFLAGS.DRIDERINCUBUS_KILLED] = 1;
			driderDefeatMenu();
		}
		
		public function fuckMitzi():void
		{
			flags[kFLAGS.MITZI_FUCKED] = 1;
			clearOutput();
			outputText("You shrug and start stripping out of your [armor] while you have the chance. Demons aren’t exactly known for their trustworthiness, but she’s doing this as a show of strength. Resorting to trickery to beat a simple mortal might lower her subordinates’ opinions of her. If there’s one thing you’ve learned to count on with demons");
			if (silly())
			{
				outputText(" and smut writers");
			}
			outputText(", it’s hubris.");
			outputText("\n\nMitzi gapes at the sight of your [cocks] springing free. Her master looks on, stroking his own with a forlorn look in his eyes, unable to stop jacking it even when you’re about to claim his playtoy as your own.");
			outputText("\n\n<i>“You like that?”</i> you ask the goblin, pivoting to swing your [cock biggest] under her nose.");
			if (player.cocks.length > 1)
			{
				outputText(" <i>“Or maybe this one?”</i> You grab your");
				if (player.cocks.length == 2)
				{
					outputText(" second");
				}
				else
				{
					outputText(" smallest");
				}
				outputText(" dick and shake it at her.");
			}
			outputText("\n\nThe green-skinned girl shivers. Her knees audibly knock together from the rich, musky scent your maleness");
			if (player.cocks.length > 1)
			{
				outputText("es");
			}
			outputText(" exude. Biting her lower lip, she meekly nods. Her breeding instincts, augmented by demonic magics, must be going wild. The only thing keeping her from jumping your dick this very second is her ingrained submissiveness. Her eyes are wide and pleading, backed up by a high-pitch whine from somewhere inside her throat. Mitzi rubs between her legs, instantly soaking her fingers with incredibly liberal secretions. <i>“...yesssss. Please... fuck mitzi.”</i>");
			outputText("\n\nYou grab a lock of purple hair and pull the mindbroken goblin’s face against your [cock biggest], smearing her cheek with your pre-cum, leaving her skin glistening with fuckscent. She doesn’t protest or complain. Instead, she grows more aroused by the second. Flushing hot, her face radiates heat and desire. Her nipples are as thick as pencil erasers and hard against your roving palm. She can’t even stop her pussy from absolutely drizzling. The off-beat spattering of cunt-juice on the floor is music to your ears.");
			outputText("\n\nMitzi licks her purple-painted lips a few times and opens wide, her bright-pink organ laid out like a landing strip for your pre-oozing sex-engine. You’ve seen some slutty goblins in the wild, but none have managed to look quite so brazenly whorish as this demonic pet. Her mouth looks made for sucking dick, capped with lush angel-bows under a layer of fuck-me paint. Her breasts are huge and shapely without a hint of sag. Even her pussy is primed for fucking, so plush and full that it’d feel like it’s kissing your crotch while you take her.");
			outputText("\n\nYou lay your pipe across her salivating tongue, but as you’re admiring the sight of it there, backlit by hungry goblin, she pulls it inside, wrapping you in the tight heat of her hungry mouth before you can possibly react. Mitzi’s cheeks hollow from establishing a fevered suction. Her eyes flick up, meeting yours while she gently begins to bob back and forth, establishing a gentle, face-fucking rhythm that soon has you freely dribbling condensed anticipation onto her constantly wiggling tongue.");
			outputText("\n\nThere wouldn’t be a need for you to move, if you didn’t want to. You could let mitzi work your [cock biggest] for hours");
			if (player.biggestCockArea() > 100)
			{
				outputText(", her throat bulging with its unholy size");
			}
			outputText(", polishing your knob perfectly. You’ve no doubt she could bring you off quicker if she wanted to, but the little sex slave is treating this blowjob like a job application; she wants to make you last. She wants to make you wallow in pleasure until it becomes so overwhelming that you would fountain even without the back-and-forth bobbing of her head.");
			outputText("\n\nYou don’t have the time to let her treat your cock like an oral gymnasium, and you certainly didn’t want to make do with a blowjob when the real deal is on the menu. Grabbing her by the scruff of the neck, you pull the gasping creature off your [cock biggest]. A purple ring is evident on the bottom third of your prick, rubbed off by the immaculate seal her puffy cockpillows left behind.");
			outputText("\n\n<i>“D-did Mitzi do bad?”</i> The goblin looks like she could cry. The girl must really, really love cock.");
			outputText("\n\n<i>“No,”</i> you answer. <i>“I’d just rather fuck you right now.”</i> You guide her down onto her hands and knees. A spaded tail flicks back and forth above her full moon. She’s definitely sampled a few bottles of succubi milk.");
			outputText("\n\nMitzi’s elfin ears perk right up at your words, and she even");
			if (player.balls > 0)
			{
				outputText(" wraps her tail around your [sack], giving eager little tugs.");
			}
			else
			{
				outputText(" wraps her tail around your [leg], giving you eager little tugs.");
			}
			outputText(" She doesn’t need to pull you in - you can handle that all on your own. Grabbing her petite waist one handed, you pull her down onto your [cock biggest] using your free hand to keep your aim true.");
			outputText("\n\nKnowing that a girl’s pussy is overflowing is one thing; experiencing the sodden reality is another. Her pumped-up petals kiss your [cockHead biggest], slowly giving as you try to thread yourself between them. Ribbons of wetness run down the underside of your [cock biggest], thickening the longer you’re in contact with the fountaining love-slave. The obscene plushness of her labia majora actually holds you back, but at a certain amount of force, they bow around you, allowing you to slip your first few inches into Mitzi’s silken vice.");
			outputText("\n\nWith what she looks like on the outside, falling somewhere between high class call-girl and short, stacked succubus, you expected her slit to be equally pleasing. The slippery, heated heaven into which you now sheath yourself is beyond any expectations. She feels molded to you, her entrance designed to welcome cocks deep inside its deepest recesses. Even compared to other goblins and succubi, Mitzi’s cunt is exceptional. Her silky folds squeeze down on you the further you thrust in, tending to your budding pleasure with excess of slickened sensation.");
			if (player.biggestCockArea() > 250)
			{
				outputText("\n\nThe best part is that she doesn’t seem to care about how enormous the cock you’re forcing into her is. Her belly is bulging out, displaying an imprint of your [cock biggest]’s shape, and all she does is moan harder. The muscles of her girlcum-drizzling slit never stop squeezing you encouragingly, demanding that you bury the whole thing inside.");
			}
			outputText("\n\n");
			if (player.biggestCockArea() <= 250)
			{
				outputText("Bottoming out");
			}
			else
			{
				outputText("Filling her with as much as she can take");
			}
			outputText(" is too much for little Mitzi. Her slender arms buckle, dropping her onto her tits. Her head lays sideways against the floor, her exquisitely long tongue hanging out, drooling. She’s not really talking anymore, just kind of idly grunting with every movement you make. Her brain cells are either too busy controlling the fluttering muscles in her cunt or routing pleasure signals to form cogent thoughts.");
			outputText("\n\nYou don’t see any point in giving her any warning. Grabbing hold of her plump ass with both hands, you pull yourself back until she’s almost entirely empty. A disappointed little mewl escapes her lips. Then, you thrust back in, letting your veiny mass revel in its slick back-and-forth journey. Your [cock biggest] twitches happily within the living dicksheath, dumping a few hot globs of pre-seed into her furthest recesses with every pump.");
			outputText("\n\nThe demons in the area have either gone back to their own hedonistic pleasures or started masturbating to the show you and Mitzi are giving. Kinarial isn’t even visible any more. There’s only a puddle of cum amongst a few discarded webs where you left him. You’ve missed your chance to deal with him permanently, but who cares? Lethice isn’t too far away, and you’re getting the fuck of a lifetime.");
			outputText("\n\nJust looking at the goblin’s smiling face as you smear it back and forth through puddles of demon-cum has you almost ready to go off. You swat her cushy heiny in between rapid-fire thrusts, wondering if you should keep her while your orgasm rises up like a slumbering beast.");
			if (getGame().camp.companionsCount() > 0)
			{
				outputText("\n\nYour other follower");
				if (getGame().camp.companionsCount() > 1)
				{
					outputText("s");
				}
				outputText(" wouldn’t mind having a well-practiced goblin cooze around, would they? You certainly wouldn’t.");
			}
			else
			{
				outputText("\n\nYou certainly wouldn’t mind having a well-practiced goblin cooze around. She’s too obedient to be a problem.");
			}
			outputText("\n\n");
			if (player.cor <= 33)
			{
				outputText(" You could even try to help her cope with her excessive sexual desires, maybe see what she’s like when she doesn’t want to be plugged with dick.");
			}
			outputText(" There’s no harm in waking up with a sexpot milking every drop from your [cocks]. You’d be way more resistant to the demons that way.");
			if (player.cumQ() >= 15000)
			{
				outputText(" The thought that you produce cum far too fast for that to matter doesn’t even occur to you.");
			}
			outputText(" Maybe she’d even give you some daughters. You could raise up an army of petite greenskins to rebuild the land.");
			outputText("\n\nThe thought of Mitzi, pregnant with a half-dozen of your daughters, riding on your dick in the morning flips your switch. You couldn’t stop yourself from cumming if the entire council of elders were there scolding you.");
			if (flags[kFLAGS.PC_FETISH] >= 1)
			{
				outputText(" Actually, that thought’s probably just going to make you blow that much harder. Damn you, Ceraph!");
			}
			outputText("\n\nWith another victorious slap on Mitzi’s ass, you bottom out.");
			if (player.balls > 0)
			{
				outputText(" Your [balls] quake, pulling your [sack] taut against your body as they disgorge their creamy relief.");
			}
			outputText(" You hold yourself there, pumping incessantly against your chosen cum-dump. Her face radiates absolute bliss. Goblins must have some kind of sense of when cum is splattering against their cervix, because you’ve never seen Mitzi happier, not even when she was mounted on her drider lord’s dick.");
			outputText("\n\nPulling out");
			if (player.hasKnot())
			{
				outputText(" with a wet sounding pop after solid knotting");
			}
			outputText(", satisfied, you grab your [armor] and consider your options. Mitzi is still laying there");
			if (player.cumQ() >= 5000)
			{
				outputText(" with a cum-pregnant belly");
			}
			if (player.cumQ() >= 1000)
			{
				outputText(", spooge dripping down her thighs from her overfilled snatch");
			}
			outputText(". She’s slowly rousing back to consciousness, but do you really need a goblin distracting you? You could tell her to wait for you outside, or forget about her and move on.");
			menu();
			addButton(0,"Recruit Mitzi",recruitMitzi);
			addButton(1,"Next",driderDefeatMenu);
		}
		
		public function recruitMitzi():void
		{
			clearOutput();
			outputText("You give Mitzi a friendly pat once she’s ready to go and tell her to wait for you outside.");
			outputText("\n\nShe beams ecstatically and bows. <i>“Thankyousomuchyouwon’tregretthis!”</i>");
			outputText("\n\nThe excitable thing is gone the next moment.");
			flags[kFLAGS.MITZI_RECRUITED] = 1;
			menu();
			driderDefeatMenu();
		}
		
		public function mitziEatsPussy():void
		{
			clearOutput();
			outputText("You shrug and start stripping out of your [armor] while you have the chance. Demons aren’t exactly known for their trustworthiness, but she’s doing this as a show of strength. Resorting to trickery to beat a simple mortal might lower her subordinates’ opinions of her. If there’s one thing you’ve learned to count on with demons, it’s hubris.");
			outputText("\n\nThis goblin, like most of her kind, is obsessed with cock");
			if (player.cocks.length > 0)
			{
				outputText(" and while you do have one for her to lavish her attention upon");
			}
			else
			{
				outputText(" and while you may lack such bulgy organs");
			}
			outputText(", that tongue you saw is just too much to pass up. You spread your legs");
			if (player.balls > 0)
			{
				outputText(" and lift your balls before");
			}
			else
			{
				outputText(",");
			}
			outputText(" stretching your cunny with a pair of fingers. <i>“Get over here and put that tongue of yours to work; if you do a good job, maybe I’ll take you away from here”</i>");
			outputText("\n\n<i>“Mitzi is the best slave, you’ll see.”</i> The little love-slave crawls her way to you, her eyes locked on your [vagina]. Her tongue slithers from her plump lips down... and down to her pillowy tits, wrapping around one sinfully thick nipple. The extensive organ flicks to the other, repeating the action before retreating into her smiling mouth. Mitzi’s small hands slide up your [hips] as she leans in to plant small kisses up your inner thighs. Her eyes look up at you, mesmerized by the sight of your horny slit as only a sex-addled slut can be.");
			outputText("\n\nThe little greenskin tart worshipfully licks and kisses her way up your body, inching closer and closer to the nexus of your sexuality. You grin down at her and run your hands over her head, your fingers threading through her purple hair as you guide her closer and closer. Just another inch, so close you can feel her breath against your [vagina]. You bite your lower lip in anticipation as you pull her in the final distance and press her pillowy lips against your nethers.");
			outputText("\n\nThe simple contact of flesh is the final straw for the barely restrained goblin, her lips seal against your cunt in a lewd kiss, her tongue lashing out to lick along your oozing entrance before darting inside like a serpentine tentacle. The sudden penetration brings a moan of pleasure to your lips as your nerves light up with delicious fire. You grip your playmate’s head tighter and pull her against your crotch. The goblins lips mash against your cunt, her tongue making love to the horny hole as her hands clutch at your hips. She delves deep within you, her writhing tongue slithering back and forth, sliding incessantly against every surface it can get at.");
			outputText("\n\nEager to please you, Mitzi lets out a whorish moan, her plump lips pressing harder against your entrance as she plunges her tongue into your body, thrusting the thick oral tentacle like a rutting lover. The tip teases your cervix, ticking the entrance to your womb at the apex of each deep, ecstatic plunge. Your legs quiver under the pressure of your sexual need. Your lips part in throaty moan; your own tongue darts out to lick your parched lips as you hold your little lover against you, forcing her to please your feminine sex.");
			outputText("\n\nMitzi might as well be a creature born of sapphic desire. She doesn’t show any sign of needing to breath or talk. It’s like her whole world is composed of vaginas, clits, and the fluids within. Her single mindedness is reflected in the motions of her unholy tongue, prowling around every sensitive fold to press on the most sensitive nerves, channeling your");
			if (player.wetness() >= 3)
			{
				outputText(" copious");
			}
			outputText(" lubrication down the crease in the middle of pussy-pleaser to collect in her mouth.");
			outputText("\n\nShe swallows noisily, making sure you can hear the sound of her gulp.");
			outputText("\n\nIt’s too much. You drop down to the ground, [legs] spread, never letting go of the enthusiastic goblin’s hair on your way down. Her own tits cushion the fall just as your tingling netherlips muffle her sounds of surprise. If anything, the change in locale makes her even more determined in the motions of her tongue. She flexes the whiplike organ in ways that make your eyes cross and your [nipples] ache.");
			outputText("\n\nYour fingers slowly drift from her hair as the pleasure mounts, finding their way to your unmolested chest. There, they do their damnedest to augment the ecstasy radiating out from your core, supplementing it with none-too-gentle tugs on your [nipples] and eager fingering. You moan again, whorishly declaring your love for the emerald slut’s tongue for anyone who’s listening to hear. Her twinkling eyes watch you excitedly while her tongue shifts its frenzied licking, bending up and out to encircle your [clit].");
			outputText("\n\nYou melt against your body’s own lava-hot sensations, incapable of controlling your own motions, aware that you’re [hips] twist and thrust against Mitzi’s oral onslaught but unable to do anything but ride it like a ship caught in a tsunami. Somehow, the pleasure continues to grow inside you, stoked by the perpetual slithering of the goblin’s tongue, fed to the blissful beast now possessing your form. Your sweating body writhes like so many nearby demons, gradually going limper and limper until you can only manage a few exhausted twitches.");
			menu();
			addButton(0,"Next",mitziEatsPussyII);
		}
		
		public function mitziEatsPussyII():void
		{
			clearOutput();
			outputText("When your vision clears, Mitzi is sitting on your lap and gently massaging your [chest]. Only a few seconds have passed, but the nearby demons seem closer than you remember. You push the slut off and rise up onto your [feet], well and truly sated.");
			outputText("\n\n<i>“What should Mitzi do now, [Master]?”</i> The harlot with the too-long tongue asks, licking her lips. <i>“Want another cum?”</i>");
			outputText("\n\nYou don’t have time to join in on the debauchery here, but you’ve got to come to a decision about this goblin now. Otherwise, she might distract you while you confront Lethice. Do you tell her that you’ll keep her and send her back to camp?");
			menu();
			addButton(0,"Recruit Mitzi",recruitMitzi);
			addButton(1,"Next",driderDefeatMenu);
		}
		
		public function titfuckMitzi():void
		{
			clearOutput();
			outputText("You grin at the goblin and push your [armor] out of the way to expose your [cocks], explaining that you’d like to see her please your [cock biggest] with her tits before you make any decisions about taking her as a slave of your own. After all, her and her master are responsible for your current, rigid state");
			if (player.balls > 0 && player.lust >= 75)
			{
				outputText(" and too-full feeling balls");
			}
			outputText(". It’s only fitting that she make recompense for the irredeemable demon’s actions.");
			outputText("\n\nMitzi wastes no time in dropping to her knees and half crawling, half waddling over, her hard, purplish teats dragging on the ground whenever she tips too far forward, making her sweat-oiled breasts jiggle and bounce against one another. She blushes deeper from the stimulation, leaving a trail of fuck-me-juice on the floor behind her. When her nose finally reaches [oneCock], she nuzzles against it, kissing softly against the veins while her nostrils flare excitedly.");
			outputText("\n\n<i>“Ohhh, it really needs a good cum, doesn’t it?”</i> Mitzi purrs after one particularly slobbery kiss. <i>“Do you want Mitzi to make you squirt fast or slow? She knows you’re in a hurry.”</i> The goblin wraps both her small hands around you and gently strokes. <i>“Please [master], tell Mitzi how.”</i>");
			outputText("\n\nShe thinks she can get you off fast and let you return to your mission, but is also offering to make love to your [cock biggest] until the pleasure gradually overwhelms you. Which do you prefer?");
			menu();
			addButton(0,"Quick",titfuckMitziQuick);
			addButton(1,"Slow",titfuckMitziSlow);
		}
		
		public function titfuckMitziSlow():void
		{
			clearOutput();
			outputText("A quick look around the assembled demons confirms your suspicions. They’ll be too busy getting off to the show to interfere. <i>“Nice and slow, please.”</i> You grab her by her mane of purple hair and press her face more firmly into your dick. <i>“Milk out every drop. There can’t be a single squirt left for the demons or their cronies.”</i>");
			outputText("\n\nMitzi coos delightedly, <i>“Oooh, you’ll be sure to take Mitzi now! Your dick will love Mitzi after this!”</i> She kisses your [cock biggest] with inflated lips so pillowy you could lie down on them for a nap. Her thick-painted, purple gloss allows them to slide up and down with the briefest nod to friction, planting wet, slobbery kisses across the underside. Your [legs] go weak, to say nothing of your grip on her hair. She slides out of your nerveless fingers as you try to stay upright, giving her full range to please your phallus, feeling her tongue uncoil to coat the trunk in enough spit to dilute a goo-girl.");
			outputText("\n\nYou moan. There’s no point in holding it in, not here, surrounded by demons engaged in acts so lascivious they make a tit-fuck look like meditation. Even if you wanted to, you doubt you could resist the sheer carnality of this place, the way it reeks of sex, the very walls embedded with the sights and sounds of drizzling slits and turgid, cum-hosing boners.");
			outputText("\n\n<i>“Don’t cum, [master],”</i> the greenskin slut pleads, <i>“You have to cum slowly. Mitzi promised.”</i> She deftly wraps a hand around your base to steady your quivering");
			if (player.biggestCockArea() <= 20)
			{
				outputText(", tiny");
			}
			outputText(" tower of meat");
			if (player.biggestCockArea() <= 20)
			{
				outputText(", nearly obscuring the whole thing");
			}
			else if (player.biggestCockArea() >= 100)
			{
				outputText(", barely able to support it");
			}
			outputText(".");
			if (player.cocks.length > 1)
			{
				outputText(" She keeps the other");
				if (player.cocks.length > 2)
				{
					outputText("s");
				}
				outputText(" angled out of the way, though from time to time she favors");
				if (player.cocks.length == 2)
				{
					outputText(" it");
				}
				else
				{
					outputText(" them");
				}
				outputText(" with a gentle, encouraging stroke. Her attention remains fixated squarely on the largest.");
			}
			outputText(" <i>“Though she’s never made someone come with kisses before...”</i> Mitzi brushes purple-dyed hair from her eyes and bends down press her lips against your [cockHead biggest].");
			outputText("\n\nThe kiss is slow yet searing, a declaration of the kind of sinful dicklust that can only come from a goblin, one whose desire for spunk has been augmented past any modicum of reason by demonic magics. Mitzi’s lips make love to your [cockHead biggest]. They worship it, smacking wetly from her repeated oral forays. Her tongue sometimes slides back and forth across your still-sealed urethra. Other times it roams out on lusty excursions to locate and lick every available vein.");
			outputText("\n\nGiggling, the viridian vixen collects your pre-cum on her tongue and spreads it across her puffy, purple cocksuckers until they shine like amethyst, glossed over by your own leaking desire. <i>“‘Course Mitzi’d never disobey " + player.mf("master’s","mistress’s") + " command.”</i> She kisses the bare flesh above your insistent loins. <i>“Only the best titfucks for [master].”</i>");
			outputText("\n\nArching her back, Mitzi drags her oversized bosom");
			if (player.balls > 0)
			{
				outputText(" over your [balls] and");
			}
			outputText(" up to either side of your [cock biggest], swaddling it in flesh that feels a little too cushy to be real. Her manicured fingertips press down from either side, tightening her vise until you feel her heartbeat hammering back against your boner, sending pleasant sensations thundering through the all-too-sensitive organ.");
			if (player.balls > 0 && player.ballSize > 5)
			{
				outputText(" You dribble yet more pre-cum onto the sweat-shined swells. Big as they are, they can’t quite ensconce your entire length, letting you watch it happen in lurid detail.");
			}
			else
			{
				outputText(" You dribble yet more pre-cum into her swampy cleavage. You can feel it getting slicker and slicker but can’t quite see it happen. You’ve nothing to go on but the feel against your [cockHead biggest].");
			}
			outputText("\n\n<i>“You like that?”</i> a voice somewhere above those two magnificent orbs asks.");
			outputText("\n\nYour acknowledgement comes out as half a groan and half a sublime sigh. Rocking back your head, you push your [hips] a bit further forward, properly seating you inside the quaking cleavage.");
			outputText("\n\nMitzi asks, <i>“Do you want this slow or not?”</i> She slowly forces her breasts to bounce in pendulous, alternating motions, sliding and squelching around your drooling fuckstick. <i>“If you hump my tits, it won’t be as good. Promise.”</i> She winks pinching her nipples between her thumbs and index fingers.");
			outputText("\n\nYou lazily nod and grab a nearby column for support, trying to ignore the obscene artwork that has been carved beneath your fingers. It doesn’t work that well; even you can tell that your hands are brushing dozens of tiny teats and jutting nipples. Mitzi’s look like bigger versions of what you feel, capped with obscene areolae and rigid tips that must be incredibly sensitive. She certainly seems to enjoy them, judging by the way she’s moaning as she massages your [cock biggest].");
			outputText("\n\nLittle by little, the sensations assaulting you are overwhelming you. The feel of Mitzi’s exquisite tits on you could have you spurting in short order by themselves, but you aren’t by yourself. You’re surrounded by cavorting forms of all manner of sensuality: succubi with over-sized jugs and flawless faces, muscular minotaurs with cocks that may as well be baseball bats, incubi so devilishly handsome that a nun would rebuke her faith for a single kiss, and a hundred more. You see them all. You smell their passion, redolent in the air, pervasive and encouraging. How could you do anything but cum? How could you do anything but paint Mitzi’s ecstatic features in a thick layer of white?");
			outputText("\n\nAnd just like that, the squeezing warmth vanishes, replaced by air that feels a little too cold to be comfortable. Your [cock biggest] hangs in the air, exposed and twitching, on the edge of blowing and yet unable to without a hand from the greenskin.");
			outputText("\n\n<i>“Please,”</i> you gasp, feeling the moment start to pass. <i>“I need to cum!”</i>");
			outputText("\n\nMitzi chews her bottom lip, still caked with a veneer of your juices. <i>“Nope! You told me to make slow. Besides, everybody knows that " + player.mf("masters","mistresses") + " say things they don’t mean when they’re all jizz-crazy! The last time I got someone off early, I didn’t get any dick for a whole day!”</i> She shakes her head. <i>“Just hold on, and you’ll go off like a cannon. I pussy-promise.”</i>");
			outputText("\n\nPussy-promise? What the hell is that?");
			outputText("\n\n<i>“Oh, you’re ready for more! Yay!”</i> Mitzi’s plush dick-massagers roll back into place before you can get a word in edgewise, turning your queries into a drawn-out moan. An undercurrent of the electric pleasure you’ve already felt lies beneath this new sensation, enhancing it further. If she gave you a few quick up and down jacks, she could have you frosting her boobs white in seconds, but she doesn’t. She keeps it nice and slow, a gentle massage that slides its way back and forth your entire length.");
			if (player.biggestCockArea() >= 100)
			{
				outputText(" Sometimes she even plants a few more kisses on your [cockHead biggest] or just below. Other times she licks you like a lollipop - at least the parts not buried in bust.");
			}
			outputText("\n\nYour head is swimming. No wonder that drider demon kept this girl around! She’s so good with her breasts that they may as well be infused with black magic, transformed into tanks so overloaded with eroticism that they spark and fizz with it.");
			outputText("\n\nThe worst (or best) part is that she was right. You’re already feeling better than when you were at your peak. The desire to climax is still there, clawing at the back of your mind, but it’s buried behind a thicker wall of pleasure, numbed by the knowledge that her cutting you off once more might lead to further bliss.");
			outputText("\n\nMitzi’s dusky eyes flick up at you as she works, favoring you with a smile. <i>“Somebody’s getting into it now, isn’t " + player.mf("he","she") + "?”</i> She bounces her boobs around a little faster, thrilling you with more excitement than you can handle. <i>“Yeah, you’re so close to blowing it, aren’t you?”</i> She smushes them down on either side, twisting her torso to drag them laterally across your overfull [cockNoun biggest], surrounding you in a vortex that threatens to wring every drop of cum from your body. <i>“So close to just giving in.”</i>");
			outputText("\n\nMuscles in your abdomen twitch.");
			if (player.balls > 0)
			{
				outputText(" Your [balls] feel like they’re going to burst, clenching tight beneath your [cocks].");
			}
			outputText(" The edge is right there. You could go over now - just one hard thrust, and you could do it.");
			outputText("\n\nOnce again, Mitzi pulls back before you can get there, leaving your angry shaft there to quiver impotently in the air, still webbed to her strings of pre-cum that never seems to run out. Her tits are glossy and wet with a mixture of it and her sweat. She extends one finger, glistening with sweat or girlcum or something else entirely, and gently taps your [cock biggest].");
			outputText("\n\n<i>“No.”</i> She taps it again. <i>“No cummies yet!”</i> The purple-haired tart squats in a puddle of her own pussy juices and repeats, <i>“No cumming for either of us.”</i> Her tongue licks her lips. <i>“It’ll be so good when we both get off, though won’t it?”</i> She almost moans the last half of it, rocking her hips back and forth across her heel. A seriously engorged clit bumps and grinds with each pass, threatening to detonate and set off an explosion of bliss in the poor goblin’s brain.");
			outputText("\n\nGradually, the involuntary contractions running through your frame fade, leaving you still hard, still unsatisfied, and still standing there with your dick out in front of the sluttiest goblin you’ve seen");
			if (flags[kFLAGS.TAMANI_MET] > 0)
			{
				outputText(" since meeting Tamani");
			}
			outputText(". Even the breezes feel good on your dick.");
			outputText("\n\nYou look over where an oiled up succubus with pert C-cups and wide-open pussy is winking at you. It’d be so easy to take her, to sink into the hilt and unload again and again until your [balls] ran dry and your exhaustion overcame you.");
			outputText("\n\nMitzi actually snarls at the corrupted hussy, baring her own miniature fangs. A tail much like the succubus’s own has risen above her head, somehow making the little green girl look larger and more imposing. <i>“This is <b>my</b> cum,”</i> she hisses, grabbing your [cock biggest] and squeezing none too gently. <i>“<b>Mitzi’s new [master].</b>”</i>");
			outputText("\n\nAmazingly, the demon backs off, fading into the arms of a nearby satyr.");
			outputText("\n\nThen her breasts are compressing about you once more, wringing more ecstasy from your [cock biggest] than you knew it could give short of an orgasm. Echoes of your past almost-gasms combine with the swelteringly slick embrace enfolding you, making it difficult to do anything but moan for the miniature slut. Part of you wonders what her pussy must feel like if her tits can wring this much excitement from you. No wonder this emerald treasure has been locked away in Lethice’s throne room.");
			outputText("\n\n<i>“Ohh, someone’s quivering!”</i> Mitzi announces with delight. <i>“All hot and sticky in momma Mitzi’s titties!”</i> She jogs her jugs up and down a little quicker. Your [cockHead biggest] balloons between them, threatening to go off. It’s so much more sensitive than normal, so achingly hard and ready to go. <i>“It’s building up again, isn’t it?”</i>");
			outputText("\n\nIf it wasn’t before, it is now. You can feel your climax crawling through the haze of overwhelming pleasure, your body pushing your spunk closer and closer to the bursting point. If Mitzi pulled off right now, you’d probably still wind up dripping ribbons of the white stuff.");
			outputText("\n\n<i>“Are you going to do it this time?”</i> Mitzi moans. <i>“It feels like you might.”</i> Her skin feels so hot against yours, blushing dark from her toes to the tips of her hair. Her eyes are luminous and searching, like she’s as ready to cum as you are. <i>“Do you think you can hold another in?”</i> She gives you a quick pump and backs off once more, exposing your pre-oiled length to the air - and her lusty gaze.");
			outputText("\n\nIt’s twitching powerfully");
			if (player.cocks.length > 1)
			{
				outputText(" - they");
				if (player.cocks.length == 2)
				{
					outputText(" both");
				}
				else
				{
					outputText(" all");
				}
				outputText(" are, even the one");
				if (player.cocks.length > 2)
				{
					outputText("s");
				}
				outputText(" not getting much of her attention");
			}
			else
			{
				outputText(", flinging ropes of pre against your belly and Mitzi’s face");
			}
			outputText(". You’re so close; you can feel it, can feel that hot load bubbling up your urethra");
			if (player.cocks.length > 1)
			{
				outputText("s");
			}
			outputText(", on the cusp of firing everywhere. Mitzi’s licking her lips and tugging on her ardor-distended nipples, her jaw open so that you can admire the ridiculously plushness of her lower lip and just how good it would look coated in a layer of virile love.");
			outputText("\n\n<i>“Mmmm,”</i> the green slut moans. Gingerly, she extends that same wet digit in your direction. It smells heavily of feminine arousal. At some point, she must have found time to rub it around inside her gushing box. Slowly - too slowly - she presses her soft fingertip against the underside of your [cockHead biggest]. <i>“You’re ready, finally. I could take you over the edge just by exhaling on you, couldn’t I?”</i>");
			outputText("\n\nGods, she’s right. Your eyes roll back as you nod, the feeling of a single digit against your pulsating shaft taking you to the teetering edge of explosive orgasm.");
			outputText("\n\nMitzi husks, <i>“Good. Now let Mitzi give it to you.”</i> She drags her fingertip down your flexing urethra, closer and closer to where the cum is bubbling within you, setting off explosions of heat and lust within your mind. A yawning, infinite abyss of ejaculation and relief stares back at you, and can do naught but fall into it. Powerful contractions wrack your body, increasing your desire and pleasure exponentially. You couldn’t stop yourself if you wanted to.");
			outputText("\n\nGiggling, Mitzi slips you right back into her dick-slicked tits, wrapping one arm around them to pin your [cockHead biggest] deep inside, buried in so much boob that your [legs] nearly give out from the wondrous sensation. Her other hand briefly reaches down, then diverts upward to fondle a nipple, the feeling of grinding her weeping slit against her own foot enough to bring her off unaided.");
			outputText("\n\nJizz bubbles out of your [cock biggest] in fits and starts, turning the slippery cleavage into a sordid swamp. Bubbles of the white stuff spurt up out the top while runnels of spunk gild the goblin’s middle, pooling in her belly-button. Your [hips] jerk and spasm, forcing you to hump her on instinct, breeding her boobs like a " + player.mf("man","woman") + " possessed, equal parts amazed and determined to fill them to overflowing.");
			if (player.cumQ() >= 5000)
			{
				outputText("\n\nLittle does Mitzi know just how capable a breeder you are. You fill the space between her tits with a sea of thick goo long before you finish jizzing. Her thighs and dusky slit are drenched soon after, painted in a sheen of ivory. The quivering greenskin recovers from her own pleasure long before you even finish, staring in confusion and delirious desire at the ever-greater quantities of jism you produce. Sliding her cum-slick melons down, she pops your [cockHead biggest] out to drench her face and hair with the last of your issue, greedily catching fragrant globs on her too-long tongue.");
			}
			menu();
			addButton(0,"Next",titfuckMitziSlowII);
		}
		
		public function titfuckMitziSlowII():void
		{
			clearOutput();
			outputText("When you finally exhaust yourself, your [legs] give out, and you collapse, sliding your still-hard shaft from betwixt those heavenly globes one last time. Mitzi falls away from you in the other direction, breathing heavily and idly masturbating herself with your cum as her lube. Her high-pitched voice moans, <i>“Keep me, nice [master]!”</i> or some variation of it again and again.");
			outputText("\n\nYou sit up, noting that she’s positioned herself so that her lust-engorged quim is spread before you. You could take her for another go right this very moment without anyone batting an eye. Most of the demons are still too distracted by their own fucking.");
			outputText("\n\nBut... you’ve got a demon queen to face down. If you want to have the goblin as your own, all you have to do is tell her to wait for you outside... Do you keep her?");
			menu();
			addButton(0,"Recruit Mitzi",recruitMitzi);
			addButton(1,"Next",driderDefeatMenu);
		}
		
		public function titfuckMitziQuick():void
		{
			clearOutput();
			outputText("<i>“Do it quick, if you really can,”</i> you answer the petite green slut.");
			outputText("\n\nMitzi presses your [cock biggest] against the side of her face and looks up at you, her eyes wide and excitement and lust. <i>“You’re going to love this [Master]. You won’t be able to resist taking Mitzi home with you after.”</i>");
			outputText("\n\nThe confident slut rises up, arching her back to bring her pendulous breasts up against your [cocks]");
			if (player.balls > 0)
			{
				outputText(", her nipples dragging over the skin of your [sack]");
			}
			outputText(". Matter of factly, she grabs her own tits and pulls them apart, revealing an expanse of green flesh made slippery by her own sweat. [EachCock] sinks right into the welcoming valley a second before she brings her girls back to close around you, enveloping your length");
			if (player.cocks.length > 1)
			{
				outputText("s");
			}
			outputText(" in slick, soft boobflesh. Her chest feels almost molded to your [cocks], designed to press evenly on every sensitive place. You can’t help but give a little throb of excitement.");
			outputText("\n\nThe keen little slut picks up on it and flashes you another knowing smile, following it up by dropping to her knees and sliding [eachCock] through her love-pillows until the tip");
			if (player.cocks.length > 1)
			{
				outputText("s are");
			}
			else
			{
				outputText(" is");
			}
			outputText(" exposed to her purple-painted lips and drooling tongue. She gobbles [oneCock] up in a hurry, easily wrapping her spit-soaked tongue around its circumference while her cheeks hollow from her near-constant sucking.");
			outputText("\n\nYou tremble a little bit. You didn’t expect she’d have your [cocks] so hard so fast, and you certainly didn’t expect she’d have your hips quivering and ready to thrust.");
			outputText("\n\nMitzi moves to the next stage of her tittyfuck while you’re still trying to come to grips with the way her tongue curls and presses on the sensitive spot below your [cockHead biggest]. She expertly drags her jugs down, bouncing them off your crotch in order to slide them back up without a second of downtime. Fuck, this greenskin knows how to make a " + player.mf("guy","girl") + " blow his load!");
			outputText("\n\nYou can feel the pleasure spasms in your gut starting already, and she’s only been touching your [cocks] for thirty seconds or so! Mitzi mischievously meets your gaze and works her breasts faster, wetly slapping them against your [hips] to a regularly building rhythm. By the time you begin to twitch and moan, her voluptuous tits are a blur of green around your [cocks], but when you start to erupt, she slows to match the orgasmic throbs running through your body, milking you for every drop.");
			if (player.cumQ() <= 500)
			{
				outputText("\n\nHer lips never leave your tip; she swallows every drop with the kind of pleased expression that can only come from experiencing something extremely fulfilling.");
			}
			else
			{
				outputText("\n\nShe tries to keep her lips glued to your tip, her throat gulping noisily in an attempt to swallow every drop of your gushing cum, but she just can’t keep up. The volume of spermy fluid pushes her off your [cock biggest] just throwing a tremendously thick rope across her face. She dazedly drools spunk from her purple-painted lips while you coat her hair and face in a mask. Somehow, she looks extremely fulfilled.");
			}
			if (player.cocks.length > 1)
			{
				outputText(" She only has one mouth, so the rest of your load spills across her bouncing tits, building to a milky froth between the quivering, dick-milking mounds. One of her hands starts smearing it around before you’ve even finished.");
			}
			outputText("\n\nThe cock-hungry goblin never completely stops either, attacking your oversensitive member");
			if (player.cocks.length > 1)
			{
				outputText("s");
			}
			outputText(" with the kind of reckless abandon that could only come from a goblin fuckslave. Your [legs] wobble and [eachCock] bulges obscenely, unsure if it should wilt or start shooting a whole ‘nother load.");
			outputText("\n\nLucky for you, you manage to stumble back before she has you ready to go again. Mitzi bats her");
			if (player.cocks.length > 1 || player.cumQ() > 500)
			{
				outputText(" cummy");
			}
			outputText(" eyelashes at you and pushes a stray droplet of spooge past her puffy cocksuckers, swallowing noisily.");
			outputText("\n\nYou should probably decide if you’re going to keep her before moving on. Do you want a goblin slave at camp? She could wait outside for you. It’d be easy. [EachCock] tingles with aftershocks, subtly agreeing.");
			menu();
			addButton(0,"Recruit Mitzi",recruitMitzi);
			addButton(1,"Next",driderDefeatMenu);
		}
		
		public function rideDrider():void
		{
			clearOutput();
			outputText("You push the goblin aside and");
			if (player.isNaga())
			{
				outputText(" slither");
			}
			else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED)
			{
				outputText(" clop");
			}
			else
			{
				outputText(" stride");
			}
			outputText(" victoriously toward your prize, still hard and jutting, polished to a mirror sheen by the goblin’s vigorous, mid-fight fucking. Trickles of pearlescent pre-cum spill from the tip the moment your eyes fix upon it. The mere sight is enough to conjure the taste to your tongue, and the needy whines from the fallen goblin whore beside you spur you forward.");
			if (player.cor <= 33)
			{
				outputText(" You feel a little guilty, about to copulate with a demon to better slay another. You’re supposed to be a force of purity, not stuffing a hot, throbbing, demonic dick inside yourself in Lethice’s throneroom, but you can’t see any better way to ensure you’re fully sated before the next confrontation.");
			}
			else if (player.cor <= 75)
			{
				outputText(" You’ve only got this one chance to get your rocks off before confronting the slut queen. You’ll need to hurry.");
			}
			else
			{
				outputText(" This drider and his glorious cock are yours to use and abuse now, no one else’s. Even Lethice can see the truth of it.");
			}
			outputText("\n\n<i>“Hey, Champion, please... use the goblin. Let me save face. I won’t oppose you again,”</i> Kinariel pleads. <i>“Let me save face.”</i>");
			outputText("\n\nKneeling over him, you consider him and his desperately pulsating member. You could change your mind and use the goblin if you wanted him to owe you a favor... or you could force him to indulge the obvious fetish he has for his own humiliation by riding him into the ground in front of his peers and superiors. Your call.");
			menu();
			addButton(0,"Fuck Him",actuallyRideDriderDick);
			addButton(1,"Use Goblin",rideDriderToGoblin);
			addButton(2,"Nevermind",driderDefeatMenu);
		}
		
		public function rideDriderToGoblin():void
		{
			clearOutput();
			outputText("You grin outlandishly at the demon’s quiet begging and answer, <i>“Sure thing, but you owe me once I take down your boss. Got it?”</i>");
			outputText("\n\nKinariel nods almost too enthusiastically. Coward.");
			outputText("\n\nNow... about this goblin. She looks at you eagerly once more, cupping her own breasts excitedly. <i>“Let Mitzi show you what she can do, and you’ll never want to fuck anyone else!”</i>");
			outputText("\n\nQuite the claim. What do you do with her?");
			if (player.cocks.length > 0)
			{
				addButton(5,"Fuck Mitzi",fuckMitzi);
				addButton(6,"MitziTitfuck",titfuckMitzi);
			}
			if (player.vaginas.length > 0)
			{
				addButton(7,"Mitzi Licks",mitziEatsPussy);
			}
		}
		
		public function actuallyRideDriderDick():void
		{
			clearOutput();
			outputText("<i>“Fat chance,”</i> You hiss in the drider demon’s ear. <i>“");
			if (player.cor <= 33)
			{
				outputText("You deserve worse than a little humiliation, but I’m so turned on that this’ll have to do.");
			}
			else
			{
				outputText("I’m going to work your dick better than that goblin hussy ever could. You’re going to beg like a bitch to the pathetic </i>mortal<i> in front of all your cohorts. They’ll never respect you again.");
			}
			outputText("”</i>");
			outputText("\n\nKinariel looks up with a mix of terror and arousal, suddenly aware of just how precarious his position in the demonic hierarchy was. He trembles while you loop his own silk around his wrists, and his cock weeps liquid excitement. You smear some of it down the length of his cock, making him gasp and twitch on the floor, writhing in forced ecstasy while his peers laugh, jeer, and masturbate to his humiliation.");
			outputText("\n\nNo amount of heckling seems to diminish the rigidness of his phallus against your palm. If anything, it’s having the opposite effect. You can feel his heartbeat pumping him bigger and firmer after a particularly lewd insult from a four-breasted nun, or what was once a nun. He throbs with unspoken delight, his eyes half rolled back in their sockets. High pitched whines slip from his suddenly vocal throat. You wrap your fingers tightly around his quivering boner and give it a few rewarding pumps to reward him for letting out his inner slut.");
			outputText("\n\n<i>“That’s my good little spider,”</i> you coo in his ear, <i>“It feels good not to fight, doesn’t it - to give in?”</i> You kiss his cheek when he whimpers something to the affirmative. <i>“I’m going to fuck you sooo good, but you’ve got to let me know how much you like it, okay?”</i>");
			outputText("\n\nKinarial shudders and moans louder. Atta boy.");
			outputText("\n\nYou stroke his underside from base to tip before breaking contact, playfully eyeing the strand of sticky juice that momentarily connects his bloated phallus to your wiggling digit. Once it snaps, you playfully lick yourself clean, hollowing your cheeks with the force of the suction. His vocalizations turn plaintive and whiny from the lack of contact, but you silence him by bringing the exterior of your [vagina] to rest against him. There’s no way he can ignore the feeling of your slick,");
			if (player.wetness() >= 3)
			{
				outputText(" soaked");
			}
			else
			{
				outputText(" aroused");
			}
			outputText(" lips spreading against him, the way your petals push open to reveal the delicate smoothness of your inner flower.");
			if (player.clitLength > 3)
			{
				outputText("\n\nThe best part is the way your [clit] is smashed up against the upper half of his dick, rubbing against the thick, veiny shaft in the most delicious way. You can barely stand the avalanche of sensations coming from your oversized button while you frot it against the needy demon, but isn’t that what you wanted? To get off so powerfully that Lethice would have nothing left to tempt you with?");
				outputText("\n\nThe mounting hunger in your channel for some kind of penetration jars you from your surprisingly heterosexual frottage. You want him inside you. He can always manage your cock-sized clitty with one of his hands while you mount him again and again, trading a little corruption for the kind of");
				if (player.pregnancyType != 0)
				{
					outputText(" cunt");
				}
				else
				{
					outputText(" womb");
				}
				outputText("-stuffing satisfaction that you can only get from real sex.");
			}
			else if (player.cocks.length > 0)
			{
				outputText("\n\nThe best part is the way your [cocks]");
				if (player.cocks.length == 1)
				{
					outputText(" is");
				}
				else
				{
					outputText(" are");
				}
				outputText(" smashed up against his, rubbing thick, veiny shaft against rigid length in the most sinfully delicious way. You can barely keep yourself from humping away at his cock until you cum, but isn’t that what you wanted? To use this demon until your base urges were wholly satisfied?");
				outputText("\n\nThe mounting hunger in your channel for some kind of penetration jars you from stirring");
				if (player.cocks.length == 1)
				{
					outputText(" your");
				}
				else
				{
					outputText(" a");
				}
				outputText(" dick against his. You want him inside you. He can always manage [oneCock] with a hand while you’re riding him again and again, trading a little corruption for the kind of");
				if (player.pregnancyType != 0)
				{
					outputText(" cunt");
				}
				else
				{
					outputText(" womb");
				}
				outputText("-stuffing satisfaction that you can only get from real sex.");
			}
			outputText("\n\nLifting your [hips], you edge your [vagina] closer and closer to the incubus drider’s demonic length. You swear you can smell the corruption pouring off it in waves, a rich musk that makes you dizzy and eager to have it inside you. It’s so big and thick and yet oh so very wrong. The head spears your lips while you’re still trying to digest all this, your body acting on autopilot, concerned only with the act of filling the overwhelming need.");
			outputText("\n\nHe slips in so easily.");
			if (player.hasVirginVagina())
			{
				outputText(" Your virginity seems an afterthought, torn away from you before you know it. It didn’t even hurt. Why weren’t you fucking before? A whole new world of fucking is open to you now, your [vagina] loudly and perniciously declaring that it wants to feel this again and again. Maybe you can take down the minotaur and ride him as well before getting to Lethice.");
			}
			else
			{
				outputText(" You almost regret fighting him all this time. A wonderful dick like this deserves to be ridden, holstered within a pair of wet and willing folds until it can spill its powerful, corrupting load deep into your innermost recesses again and again. A girl could fall in love with feelings like ");
			}
			outputText("\n\nYou grab hold of his shoulders and push down ferociously, taking him in one fluid, wet-sounding push. You moan right alongside your tainted boy-toy, suddenly and immensely glad that you didn’t let him beg you off onto the goblin. You would’ve missed the mating of a lifetime. The way your nerves sing with delight, you’re barely able to remember to properly humiliate Kinariel. You bounce your [hips], rubbing up against his smooth, well-muscled neck and listening to him cry in delight. Your [vagina] squeezes tight around him, pitching him up an octave, playing him like an instrument, albeit one that you find yourself increasingly enamored with.");
			outputText("\n\nThe jeers from your perverse audience barely register to you by now, but your partner is certainly still aware, judging by the way his eyes flick from demoness to fuckslave to incubus. He’s going to the one that got humiliated by the Champion, no doubt about it, and his body fucking loves it. You grab him by the hair and make him look you in the eyes, slowing your fucking enough that you’ll be able to manage a complete sentence.");
			outputText("\n\n<i>“Don’t fight it. You’re not an incubus anymore, just a slut that’ll whore out his dick for anyone and everyone to use, right?”</i> You bounce up and down, squeezing tight for emphasis. <i>“Even a mortal... or a goblin.”</i> You gesture at Mitzi, who even now is trying to work beneath you to lick at his balls. You let her. <i>“Just let go. Moan for your audience and let yourself enjoy it.”</i> Your juices are puddling thick below you. It’s getting harder and harder to keep this line of thought together. <i>“Be my slut.”</i>");
			outputText("\n\nThat does it. His insect legs splay wide as the tension leaves them, and the demon himself throws back his head, groaning, <i>“Yessssssss...”</i> loud enough to be heard over the din. Chuckles of mirth surround you, but your corrupt toy wallows in it this time, twisting to expose the immense drider-cock beneath the spidery portion of his body. The goblin, Mitzi, is on it in a second, abandoning her sloppy seconds for a cut of the real deal. Shivers wrack the drider’s form from the simultaneous fuck from both ends, his cock jerking wildly inside you, slamming aggressively against your g-spot as if it knows exactly where to push to set you off.");
			outputText("\n\nButterslick heat slams into the wall of your sensitive slit a half-second later as the slut-drider erupts, squirting and moaning, aggressively twisting");
			if (player.clitLength > 3 || player.cocks.length > 0)
			{
				outputText(" one of");
			}
			outputText(" his nipples");
			if (player.clitLength > 3 || player.cocks.length > 0)
			{
				outputText(" while still trying to");
				if (player.clitLength > 3)
				{
					outputText(" pump your [clit]");
				}
				else
				{
					outputText(" give you a handjob");
				}
			}
			outputText(". He floods you with his tainted seed, stuffing your passage until every nook and cranny is chock full of demonspunk, bathed in his reproductive corruption.");
			outputText("\n\nYou go off with him, unsubtly triggered by the feeling of being so suitably and powerfully filled, not just by a wonderful, cunt-stroking cock but by the sinfully slippery love juice he pours into you, seemingly without end. You close your eyes and turn your [hips] loose to buck as wildly as they wish, even if the violent spasm force torrential gouts of ivory goo to squirt from between your fluttering lips. It’s a");
			if (flags[kFLAGS.PC_FETISH] < 1 || Boolean(player.hasVirginVagina()) || player.cor <= 33)
			{
				outputText("n unexpectedly");
			}
			outputText(" wonderful feeling, getting to cum in front of an audience like ");
			outputText("\n\nYou ride the waves of ecstasy just as you ride the gnarly pussy-pleaser that gave gave them to you. The sweaty, orgasmically writhing whore that you’ve become may be a long way from the");
			if (player.findPerk(PerkLib.HistorySlut) < 0 && player.findPerk(PerkLib.HistoryWhore) < 0)
			{
				outputText(" chaste");
			}
			else
			{
				outputText(" determined");
			}
			outputText(" champion that entered Mareth so long ago, but it feels too good to stop, like your pussy is aflame and the only way to put it out is to hose it down with even more drider goo.");
			outputText("\n\nIt’s only when your newly minted slut comes down that you follow suit. His dick must have finally gone dry, though not before his other one managed to significantly expand Mitzi’s belly. The goblin looks about at dazed as you feel, rubbing her tummy excitedly while half-heartedly trying to reach her master’s dick for a few more kisses.");
			if (player.cor <= 33)
			{
				outputText("\n\nYou stagger up feeling more than a little dirty. Demonic seed slides down your thighs in thick streams, but at least you’re not horny any more. You should be ready for whatever comes next so long as you can keep yourself from scoping out all the other hard cocks in the room. They seem to call to you...");
			}
			else if (player.cor <= 75)
			{
				outputText("\n\nYou stagger up feeling better than ever. Sure, there’s demonic cum streaming down your thighs, and you’re surrounded by Lethice’s lieutenants, but at least  you’re wonderfully, totally sated. All you have to do is keep it together until you defeat the Demon Queen, and then you can have all the cocks you want. That’s what you came here for right? It’s getting hard to remember.");
			}
			else
			{
				outputText("\n\nYou make sure to give the drider a full, french kiss on the lips before standing back up. He performed above and beyond the call of duty, filling your [vagina] so full that you can hear it slosh whenever you move. Now that you can think straight, you should be able to take down your next foe. Hopefully you’ll get a chance to fuck them too.");
			}
			flags[kFLAGS.DRIDERINCUBUS_FUCKED] = 1;
			getGame().dynStats("cor+",20);
			player.orgasm();
			player.knockUp(PregnancyStore.PREGNANCY_IMP,PregnancyStore.INCUBATION_IMP);
			driderDefeatMenu();
		}
		
		public function buttfuckDrider():void
		{
			clearOutput();
			flags[kFLAGS.DRIDERINCUBUS_FUCKED] = 1;
			outputText("You look the defeated drider over, contemplating what <i>“reward”</i> you intend to take from him. Your eyes trace over his semi-human form, a twisted cavalcade of humanity and pitch-black demonic corruption. Your hands trace over his curling, razor-edged horns, making the defeated spider-man recoil in... not fear, but something else. Anticipation, maybe?");
			if ((monster as DriderIncubus).goblinFree)
			{
				outputText(" You can see his turgid rod hanging between his legs jump at your touch, spurting a thick, viscous trickle of corrupted spunk across the marble floor.");
			}
			else
			{
				outputText(" The goblin slung under his insectile abdomen yelps as the cock buried balls-deep in her gash twitches, blowing a load of corrupted pre into her womb.");
			}
			if (player.cor > 75)
			{
				outputText(" What a magnificent creature. You look forward to seeing what .. Kinarial can do.");
			}
			outputText("\n\nYou make your way behind the demon drider, observing the twitching, drooling masses of his many spinnerets. The strange, insectile orifices twitch and drool wet-looking silk from his engorged backside, making rivulets that run stickily along the floor under your [feet]. Once you’re around behind him, you eye the sleek black carapace of his insectile half, and the curve of his back up to his human half. The drider glances over his shoulder at you, scowling.");
			outputText("\n\n<i>“Get on with it,”</i> he growls, glancing between you and Lethice upon her throne. <i>“As the Mistress wills it.”</i>");
			outputText("\n\nYou follow his gaze up to the throne, to the Demon Queen sat there. <i>“You want to see what kind of lover I am?”</i> you shout to her, over the cacophonous voices of her demon court. The voices hush to a low murmur at a slight flick of Lethice’s wrist.");
			if (player.cor > 75)
			{
				outputText(" <i>“Watch closely - this is what </i>you<i>’re in for, too, bitch!”</i>");
			}
			else
			{
				outputText(" <i>“Enjoy this show - you’re next!”</i>");
			}
			outputText(" you shout,");
			if (player.isTaur())
			{
				outputText(" lunging up onto the drider’s back, your bestial lower body carrying you up to mount him like your bitch. He lets out an alarmed shout as your massive weight slams down onto him, making his spidery legs buckle. Your [hips] hammer against him, bringing your [cock] to attention and slamming it against his undercarriage, probing for a hole to fuck.");
			}
			else
			{
				outputText(" clambering up into the drider’s back, lunging up onto him and grabbing his humanoid body. He lets out an alarmed cry as you shove his upper body forward, thrusting his face against one of the walls and grabbing a handful of his upper body’s asscheeks. You splay his cheeks apart and divest yourself of your [armor], bringing your [cock] to bear on him.");
			}
			outputText(" With a shift of your hips, you press your [cock] against the drider-demon’s hole and thrust yourself in.");
			outputText("\n\n<i>“And so, a virgin hole deflowered,”</i> Lethice laughs, voice echoing against the cold stone walls. All the demon voices have fallen silent in the moment of your penetration, enraptured by your anal assault. The only sound is Lethice’s laughing, and the sound of your body hammering against Kinarial’s. You sneer at the Demon Queen, grabbing the drider’s demonic horns and yanking them back, curling the creature’s back against you as you thrust into his tight, hot hole.");
			outputText("\n\nAnd it is <i>tight</i>. There’s no other word for it.");
			if (player.biggestCockArea() >= 1200)
			{
				outputText(" You feel like your mammoth member is going to tear him apart at this rate! The drider’s mouth twists into a silent ring of shock, unable to give voice to his reaction as you bury yourself inside him.");
			}
			else if (player.biggestCockArea() >= 500)
			{
				outputText(" Your animalistically-proportioned prick stretches the virginal passage to its limit, making the drider roar in a mix of surprise and unexpected pleasure.");
			}
			else
			{
				outputText(" Your prick sinks deep into the drider’s ass, gliding through his virginal hole.");
			}
			outputText(" It’s surprisingly moist as you plunge in, naturally lubed - of course a demon would be. It’s hard to be surprised by these sorts of things anymore, after all you’ve been through. You");
			if (player.isDrider())
			{
				outputText(" reach down from your bestial position overtop him and");
			}
			outputText(" slap the drider’s ass, digging your fingers into his charcoal skin. A cheer goes up through you demonic audience as you hilt yourself inside the drider’s ass, the wet sounds of flesh slapping against flesh echoing sickly through the corrupted throne room.");
			outputText("\n\n<i>“How vigorous!”</i> one demon wails, grabbing her throbbing erection.");
			outputText("\n\n<i>“How </i>savage<i>!”</i> another calls, and you hear a startled cry as the assembled demons’ willpower crumbles in light of your sexual escapades. Bodies undulate in the stands, mirroring your savage assault on the drider’s asshole.");
			outputText("\n\nYour hands roam over his humanoid half, grabbing nipples and slapping taut flesh. But your grasp keeps straying back to the drider’s horns. They make perfect handlebars, letting you steady yourself overtop his carapaced back. Every thrust makes him unsteadily wobble forward, pressing himself tight to the marble wall, clutching futilely at the stonework. Unable to find purchase, her merely goes limp against the wall, pressed between it and your thrusting weight.");
			if ((monster as DriderIncubus).goblinFree)
			{
				outputText("\n\nLeft to her own devices, the goblin slave that had been firmly affixed to the drider’s dick seems lost, her one purpose wrent away from her by your sudden blessing of freedom. She looks between you, her former master, and the writhing bodies in the stands, and her tiny green fingers just disappear between her thighs.");
				outputText("\n\nWith a grunt, Kinarial breaks free of your grasp, just long enough to grab the goblin slut’s dyed hair and shove her back where she belongs. His spidery legs take hold of her, shifting her down to the cock mounted beneath him.");
				outputText("\n\nAs the goblin’s muffled cries turn to moans of pleasure and sated little mewls, you start to think that’s probably right where she wants to be...");
			}
			else
			{
				outputText("\n\nThe goblin firmly mounted on Kinarial\'s cock makes a shrill, pleasured cry as her master\'s cock throbs to the beat of your anal assault. His shaft swells inside her, visibly straining the tiny greenskin\'s belly as it rises to full mast... and lets loose. You\'re treated to the wet squelching sounds of the goblin being pumped full of spunk as your spiderly victim is coaxed to climax by the sensation of your [cock] hammering his over-sized, demon-tainted prostate.");
			}
			outputText("\n\nYou let the drider have his fun for now - after all, when he’s getting off at the goblin’s expense, his tight little hole just clenches all the more, squeezing your [cock] fiercely. You hammer your hips faster in response");
			if (player.isTaur())
			{
				outputText(", which has the added bonus of carrying through from your bestial backside to his, and down to the cock-goblin mounted on Kinarial’s dick.");
			}
			outputText(" The green slut screams in ecstatic, mindless pleasure. Her voice carries through the throne room, drowning out the moans and cries of the demon court with a shriek of ecstasy.");
			outputText("\n\nYou follow the over-sexed goblin into the throes of climax a few moments later, adding a roar of pleasure to her own wild screams. You turn to Lethice, sitting calmly on her throne, and lock eyes with the Demon Queen while you slam yourself to the hilt in Kinarial’s ass and unleash your seed into the drider’s ass.");
			if (player.cumQ() <= 1000)
			{
				outputText(" You squirt your load deep into the drider’s asshole, packing his virginal hole with sticky white spooge.");
			}
			else if (player.cumQ() <= 5000)
			{
				outputText(" You pump a thick, creamy load into the demon-spider’s behind, filling his virginal hole with hot spunk until it’s drooling out around your hammering member.");
			}
			else
			{
				outputText(" You flood the drider’s ass with a torrential wave of seed, bloating the demon’s gut with your spunk. Cum spurts out of his ass around your thrusting member, pouring out with every motion.");
			}
			outputText("\n\nMoaning weakly, the spunk-bloated demon slumps forward. You withdraw from him with a wet <i>pop</i> the echoes throughout the court, silencing the demon host. You make eye contact with Lethice, holding her gaze as you gather your [armor]. Behind you, the drider is helpless but to moan and leak spooge from his well-fucked ass.");
			if (player.cor >= 75)
			{
				outputText(" You can\'t wait to see how the Demon Queen feels when she\'s skewered on your rod!");
			}
			getGame().dynStats("cor+",20);
			player.orgasm();
			player.knockUp(PregnancyStore.PREGNANCY_IMP,PregnancyStore.INCUBATION_IMP);
			driderDefeatMenu();
		}
	}
}
