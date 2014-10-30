package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.StatusAffects;
	import classes.PerkLib;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class JeanClaudeScenes extends BaseContent
	{
		
		public function JeanClaudeScenes() 
		{
			
		}
		
		public function beatDaFuckhugeBasilisk(hpVictory:Boolean):void
		{
			clearOutput();
			flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] = 1;
			
			if (hpVictory)
			{
				outputText("Jean-Claude makes a sound like a tree in a gale as he falls to one knee. Breathing heavily and foaming at the mouth, he attempts to stand back up- and promptly gives at the knees, falling to the floor with a heavy thump. There is a mighty intake of breath in the room. Ignoring the spectators, you step carefully towards the shuddering mound of scales and brass, kicking away his cutlass as you do.");
			}
			else
			{
				outputText("“<i>Gods,</i>” Jean-Claude curses with a kind of horrified wonder as he stares at you. He seems almost oblivious to the fact that he is masturbating furiously, the cock in his hand bulging needily, his yellow, endlessly aroused attention fixed entirely upon you. “<i>What... what even are you? How is it even possible... oh, Gods...</i>” he drops his cutlass and sinks to his knees, almost sobbing curses, unable to do anything but pump his meat. There is a mighty intake of breath in the room. Ignoring the spectators, you step carefully towards the shuddering mound of scales and brass, kicking away his weapon as you do.");
			}
			
			if (player.cor >= 60)
			{
				outputText("\n\nThe defeated rex stares at you with white hot hate as you reach his head.");

				outputText("\n\n“<i>You have defeated me intrus, but you will not disgrace me,</i>” he snarls, his rich voice heavy with exertion and humiliation. “<i>I have heard what you do to your victims, you who would have the demon throne for yourself, and I’d sooner... I’d sooner.</i>” He reaches for his throat with his sharp claws. You are grateful that he no longer has the power to hold your gaze- unfortunately there is no way of closing your ears.");

				outputText("\n\n“You really had nothing to worry about, you ugly bastard,” you murmur, under the wet choke and gurgle.");
			}
			else
			{
				outputText("\n\nThe defeated rex stares at you with white hot hate as you reach his head.");

				outputText("\n\n“<i>Spare me your piousness, intrus,</i>” he snarls, his rich voice heavy with exertion and humiliation. “<i>Spare me of your forgiveness and spare me of your mercy kill. I will see my own way out. Trust me- once the bitch queen has got her hands on you, you will wish you did the same thing.</i>” He reaches for his throat with his sharp claws. You are grateful that he no longer has the power to hold your gaze- unfortunately there is no way of closing your ears. You turn away as, with a wet choke and gurgle, a small part of the evil holding this place departs forever.");
			}

			outputText("\n\nThere’s an echoing silence as the ranks of basilisks stare at their dead king. Then, with a shifting sound that spreads out like a tidal wave through the huge room, they drop one by one to a knee, their eyes closed and spiked heads pointed towards you. Elation inflates in your breast and fills out to the very tips of your digits as you take in the reptile horde bowing before you, the significance of it dawning brilliantly.");
			if (player.mf("m", "f") == "f" && silly()) outputText("  You raise your fists in glee and crow “<i>I AM THE LIZARD QUEEN!</i>” at the ceiling.");

			outputText("\n\nThere’s a bit of scuffling and shoving at the front, and finally a smaller-than-average basilisk is pushed out towards you. He almost trips over the flagstones in his attempts to keep his eyes squeezed shut and head bowed in deference to you.");

			outputText("\n\n“<i>What- what are your orders, rex/reine?</i>” he whispers.");

			// Fight for me!/Go away
			menu();
			addButton(0, "Go Away", goAway);
		}
		
		private function goAway():void
		{
			clearOutput();
			outputText("You draw yourself up to your full height, calm your slightly giddy emotions and make your voice as cold and commanding as possible. You say you aren’t anyone’s new king, but since they ask, your orders are that any basilisk still within half a mile of this place in five minutes time is going to get twice the ass-whupping you just handed out to this one. You indicate with an airy wave what was, until recently, Jean-Claude. There’s a pause, followed by a minor earthquake, as the horde of reptiles pours towards the exit. You climb onto the table and watch them go, assuring that they all do indeed vamoose. If they display any emotion at all during their mass exodus, it’s one of distinct relief.");

			outputText("\n\nWithin a minute the huge hall is echoingly empty, the forgotten corpse of the rex and the tables of jetsam and eggs the only signs the basilisks were ever here. You are free to get up onto the gantry again and leave.");
			
			flags[kFLAGS.D3_BASILISKS_REMOVED_FROM_MAGPIE_HALL] = 1;
			
			menu();
			addButton(0, "Next", d3.resumeFromFight);
			
		}
		
		public function fuckhugeBasiliskFuckedYouUp(hpVictory:Boolean):void
		{
			clearOutput();
			
			if (!hpVictory)
			{
				outputText("You look down at the [weapon] in your hand in bleary confusion. Why are you holding it? Everything feels slow and close, your body almost painful with arousal and sensitivity, and you can’t push beyond it, can’t fathom where you are, what is happening, who you are. It’s the golden glow- it surrounds you and blots everything else out. When Jean-Claude steps in and almost kindly grabs your [weapon] out of your unresisting hands and takes you by the chin, you almost groan. So big, so powerful, so in control- everything you are not. You gladly stare into his maddening yellow eyes, gladly intensifying the feeling of delicious helplessness they give you.");

				outputText("\n\n“<i>I told you it was a mistake, interloper,</i>” he husks. “<i>But a good one, as far as mistakes go. It got my blood pumping. You cannot enjoy something you haven’t properly earned, eh?</i>”");
			}
			else
			{
				outputText("You fall, battered, to the stone floor. With one last herculean effort you attempt to shield yourself with your [weapon] as Jean-Claude strides towards you; he knocks it out of your hands with casual ease. You can’t stop him as he grabs you by the chin, draws you up to his face and makes you stare deep into his yellow eyes.");

				outputText("\n\n“<i>I told you it was a mistake, interloper,</i>” he husks, as the golden glow encompasses your tired, dazed mind. “<i>But a good one, as far as mistakes go. It got my blood pumping. You cannot enjoy something you haven’t properly earned, eh?</i>”");
			}
			
			menu();
			addButton(0, "Next", basiliskBadEnds);
		}
		
		public function basiliskBadEnds():void
		{
			if (player.findPerk(PerkLib.BasiliskWomb)) bwombBadEnd();
			else regularBadEnd();
		}
		
		private function regularBadEnd():void
		{
			clearOutput();
			
			outputText("The Rex’s yellow glow encompasses you, glaring out everything - your purpose, your memories, your sense of self, replaced only by the need to stare deeper and deeper into the pits of gold, the depthless lava of his will which rolls over you, heating you within and without. When he steps into you and puts his warm, smooth hand on your waist you almost flinch, you are that sensitive to his presence. He grins with the exhilaration of a conqueror as he draws you further into himself. The nagging undercurrents of your own body rise to the surface as you feel his warmth and smell his powerful musk;");
			if (player.hasVagina()) outputText(" your [vagina] beads with excitement");
			if (player.hasCock() && player.hasVagina()) outputText(" and");
			if (player.hasCock()) outputText(" [eachCock] hardens");
			if (player.hasCock() || player.hasVagina()) outputText(" as"); 
			outputText(" your body reacts uncontrollably to the presence of the being whose claws reach deeper and deeper into your mind, touching and triggering your basest desires.");
			if (player.findStatusAffect(StatusAffects.RemovedArmor) > 0) outputText("  You realize vaguely you already have taken your clothes off, undoubtedly your own subconscious preparing you for this moment.");
			else outputText("  You really are uncomfortably hot underneath the glare of those eyes. Hardly even aware you’re doing it, you begin to take off your [armor]. Piece after piece falls to the floor until you are naked before him.");

			outputText("\n\nJean-Claude breathes your own smell deeply, his smile widening as he stares into your unfocused, helpless eyes.");

			outputText("\n\n“<i>Lethice will set us high in her service for bringing her you, interloper,</i>” he murmurs. “<i>But it is lacking, eh, the personal touch, n’est ce pas?</i>”");

			if (player.skinAdj != "smooth" || player.skinAdj != "latex" || player.skinAdj != "rubber")
			{
				outputText("\n\nHe turns, snaps his fingers and raps out some instructions, too fast for you to follow, and a number of basilisks break off to hurry towards the back of the hall. His eyes are away from yours for a moment but it doesn’t matter; your mind is floating in the vast golden sea, your body submerged in its radiance. When an object is pushed into your hands, it takes you a while to focus upon it, a while longer to recognise what it is. An egg- a black egg. You look up in dozy confusion to find Jean-Claude staring back deep into your eyes, amusement curling his long mouth. Why have they given you this? You must have asked for it. Yes- it’s obvious now, what you have to do. You crack the egg’s shell and greedily gulp down its contents.");
				if (player.skinType == SKIN_TYPE_FUR) outputText("  Your fur drops away in ragged clumps as you drink."); 
				outputText("  Once you are finished another black egg is pushed into your hands, then another... you sigh as the viscous gloop slides down your throat and your flesh begins to thrum, your pores puckering and then shrinking into themselves as your skin begins to gleam with the clean starkness of rubber. You slowly examine yourself once the transformation is complete, marvelling at your living, latex flesh. Yes. This feels right.");
			
				outputText("\n\nJean-Claude watches, sharing in your admiration of your new body before stepping in to casually touch you himself. He slides his hand down your flank, rounding your [butt] before suddenly digging his claws cruelly into your rubber flesh. This time you do flinch, unable to stop yourself gasping as the pain trades with your heavy arousal.");
			}
			else
			{
				outputText("\n\nHe slides his hand down your flank, rounding your [butt] before suddenly digging his claws cruelly into your rubber flesh. This time you do flinch, unable to stop yourself gasping as the pain trades with your heavy arousal.");
			}

			outputText("\n\n“<i>You like this?</i>” the monstrous basilisk growls. “<i>The feeling of synthetic flesh? You like the remove, the lack of feature it gives you? Ah... you were a pervert before you even came here, interloper. Well. You will learn that what your new masters will always do is give you exactly what you want.</i>” You are deep in the heat of his golden will and you cannot tell where his words end and where your thoughts begin. Why did you eat those black eggs? He’s right, there cannot be any other reason other than the masochistic thrill you feel from being dehumanized, of looking like a shiny sex doll. The thought sends deep, shameful tingles through your body, which feels increasingly hard to move. But why would you want to move it? It feels so much better to act like what you look like, frozen in supplication, ready to be taken and used whenever your masters desire- a state of true submission. You manage a groan as fireworks of arousal go off in your head,");
			if (player.hasVagina()) outputText(" your [vagina] dribbling excitement");
			if (player.hasVagina() && player.hasCock()) outputText(" and");
			if (player.hasCock()) outputText(" your [cock] straining helplessly");
			outputText(" to this depth of slutty surrender you have plumbed, your neck muscles seizing up and your limbs tightening as the thoughts sink into you.");

			outputText("\n\nSmirking, Jean-Claude gives you a small push. You teeter for a moment and then fall onto your back. Although your paralyzed body was unable to brace itself, you don’t feel much pain; your rubber flesh does cause you to bounce a bit, drawing a flutter of chuckles from the crowd.");
			if (player.isBiped()) outputText("  The transformation isn’t quite complete; your mouth opens as a will not your own forces your arms and legs to open, leaving you completely exposed. It takes you a few seconds to realize that your mouth opening wasn’t your doing, either. It won’t close.");
			else outputText("  The transformation isn’t quite complete; your mouth opens as a will not your own forces your arms to open and your monstrous bottom half to take on a stance as close to complete submission as it will allow, your [hips] flared to the world. It takes you a few seconds to realize that your mouth opening wasn’t your doing, either. It won’t close.");

			outputText("\n\nJean-Claude circles you, admiring his handiwork with a flaming connoisseur’s eye. One last tiny spark inside the molten glow of your mind struggles to the surface and makes you try to force your limbs to move; you may as well try to lift a house. They are locked into position, your mind a prisoner in the sex doll your body has become.");

			outputText("\n\n“<i>I wish to congratulate whoever it was who created black eggs,</i>” he says at last, with a barked laugh. “<i>They do amazing things, with the right magic. Here slave, let me show you.</i>”");

			if (player.hasCock())
			{
				outputText("\n\nHe reaches down and grasps your [cock]- fiercely erect, as it will always be, now. You still feel everything and you cannot flinch or turn away, cannot do anything but helplessly bask in the sensation as Jean-Claude rubs your cock at its base, making it warmer and wetter and gooier until with a slimy sound, he pulls the whole thing away from you. With a kind of horror, you find you can still feel it as he turns around and, to a chorus of dry laughter, presents your ragingly hard erection to his brethren.");

				outputText("\n\n“<i>Isn’t black sorcery wonderful?</i>” he roars, waggling his new-found dildo to escalating hilarity, his hot, smooth hand rubbing down your length. “<i>Whilst you could be down here getting a good fucking from me, this little number could be shoved up the ass of a demon’s gutter slut three floors away. You’ll feel both just as much, and either way you will never. Find. Release!</I>”");
			}
			else if (player.hasVagina())
			{
				outputText("\n\nHe reaches down and, bending his claws away, puts his warm, smooth hand to your [vagina]. Already aroused beyond measure, you seep femcum ardently as he circles your [clit] and moves his digit down your channel. Grinning, he moves his hand upward, sliding over a nipple teasingly before pressing his finger against your mouth, wiping the [skincolor] fluid onto your frozen lips, making you taste it.");

				outputText("\n\n“<i>Isn’t black sorcery wonderful?</i>” he says. “<i>Self-lubricating sex dolls! With nice, elastic holes that will never get loose, no matter how much dick they take in a day! Which will be a lot for a pretty thing like you, trust me. But don’t worry- you’ll always want it, because the way you are now, you will never. Find. Release!</i>”");
			}
			else
			{
				outputText("\n\nHe reaches down and, bending his claws away, places his warm smooth hand over the featureless mound where your sex once was.");

				outputText("\n\n“<i>Did you think that taking this away would shield you from a slave’s fate, interloper?</i>” The Rex says, almost kindly. As he speaks, he moves his fingers, rubbing your mound gently up and down, as if he were removing a smear. You feel warmth spread through your groin, your latex flesh becoming wetter and gooier where he touches. “<i>Foolish. It just means whoever catches you gets to choose what kind of slave you are.</i>” He slides his finger up the gooey slit he has given you, twisting a small wad of your sensitive form into a little nub, stopping for a moment to admire the oozing, needy pussy he has given you. You pray he leaves you alone now at the same time as you desperately want him to touch you again- your new anatomy throbs and simmers with excitement. You almost force a groan past your lips as he returns his fingers to your cunt. Already aroused beyond measure, you seep femcum ardently as he circles your clit and moves his digit down your channel. Grinning, he moves his hand upward, sliding over a nipple teasingly before pressing his finger against your mouth, wiping the [skincolor] fluid onto your frozen lips, making you taste it.");

				outputText("\n\n“<i>Isn’t black sorcery wonderful?</i>” he says. “<i>Self-lubricating sex dolls! With nice, elastic holes that will never get loose, no matter how much dick they take in a day! Which will be a lot for a pretty thing like you, trust me. But don’t worry- you’ll always want it, because the way you are now, you will never. Find. Release!</i>”");
			}

			outputText("\n\nOnce he has finished his gloating, Jean-Claude once again considers your frozen form.");

			outputText("\n\n“<i>I suppose I should deliver you to the throne room pristine,</i>” he says. He snaps his claws. “<i>Here, you two- ah, you know what? Fuck it. I deserve this.</i>” He stamps forward and flips you onto your back, ripping off his tunic as he does. Throughout all of this a tiny voice in your mind cries out for you to feel horror at your situation, at the fate which has befallen you. It is drowning though, drowning in a bottomless pit of molten arousal, and as the basilisk rex’s bulging purple prick");
			if (player.hasVagina()) outputText("s");
			outputText(" push roughly against your [asshole]");
			if (player.hasVagina()) outputText(" and [vagina]");
			outputText(", it disappears into the depths forever. Your mind is a blank canvas of pure, submissive pleasure and it, like your limitless future, is golden.");
			
			menu();
			doNext(9999);
		}
		
		private function bwombBadEnd():void
		{
			clearOutput();
			
			outputText("The Rex’s yellow glow encompasses you, glaring out everything- your purpose, your memories, your sense of self, replaced only by the need to stare deeper and deeper into the pits of gold, the depthless lava of his will which rolls over you, heats you within and without. When he steps into you and puts his warm, smooth hand on your waist you almost flinch, you are that sensitive to his presence. He grins with the exhilaration of a conqueror as he draws you further into himself. The nagging undercurrents of your own body rise to the surface as you feel his warmth and smell his powerful musk; your [vagina] beads with excitement and the bubble which sits in front of your stomach seems to expand, flooding your system with pheromones which make your heart pump faster and your skin turn red as your body reacts to the presence of this alpha male. Jean-Claude breathes your own smell deeply, his smile widening as he stares into your unfocused, helpless eyes.");

			outputText("\n\n“<i>So,</i>” he husks, “<i>that is true, too. Do you know I had six of my scouts beaten for telling lies? For bringing back the story about a wanderer of the mountains who smells exactly like a female basilisk? Wishful thinking, I thought- I had heard it a hundred times before. And yet here we are, interloper. Here we are. The answer to our curse. How did you do it? Why did you do it?</i>” He is fretful with excitement, his breathing heavy and tail lashing as he slides his hand down to squeeze your [butt], handling you like a choice cut of meat. You wish you could step away from your body and his, feel disgust at the deep excitement and anticipation your modified womb is pressing on you, remember the reason why you changed yourself in this way, but you can’t. You can’t tear yourself away from the golden glow, how hot and soft it makes you feel bathed in its radiance, and- you can’t remember the reason. You struggle. You wanted to help the basilisks. That can be the only reason. And you’re here now, with their leader, and... you sigh. Everything suddenly feels right, your horny body and frustrated mind clicking into sync. You wanted to help the basilisks, you changed your body to do it, and now you’re here, ready to begin. You return Jean-Claude’s smile gladly, pleased with your breakthrough.");

			outputText("\n\n“<i>Ah, you’ve remembered the why of it,</i>” he murmurs, his rich voice resonating deep in your bones as his hypnosis rolls over your unresisting mind, like soft, unceasing fingers on your [clit]. “<i>The how of it does not really matter, does it? Not anymore. Undress me.</i>” Happily you get to work, stretching to undo the clasps of his breastplate, your hands sliding over his hot, smooth scales, glorying in his size and strength as you denude him of his tunic and helmet.");
			if (player.findStatusAffect(StatusAffects.RemovedArmor) >= 0)
			{
				outputText(" You already have taken your clothes off, undoubtedly your own subconscious preparing you for this moment, and you require no direction from Jean-Claude to sit yourself down and eagerly");
				if (player.isBiped()) outputText(" spread your [hips]");
				else outputText(" position yourself");
				outputText(" for him, your breeder’s body aching to be taken.");
			}
			else
			{
				outputText(" You require no direction from Jean-Claude to take off your [armor] once you are done. Piece after piece falls to the floor until you are naked before him. Anticipation thrumming through you, you sit yourself down and eagerly");
				if (player.isBiped()) outputText(" spread your [hips]");
				else outputText(" position yourself");
				outputText(" for him, your breeder’s body aching to be taken.");
			}

			outputText("\n\nIn front of your huge audience- who for once are the ones who can’t tear their eyes away- the basilisk rex mounts you, pinning your arms down with his hands; his hot, agitated breath rolls over your face as with one powerful thrust, he spears into your sopping cunt with one of his bulging pricks. You arch your back to the sensation, opening your mouth as he pushes into your wet, sensitive tunnel, fucking you with the roughness of bestial urgency.");

			if (player.averageVaginalLooseness() < 2)
			{
				outputText("\n\n“<i>Ungh! Tight little bitch,</i>” he gasps. He thrusts into you with wicked force and you gasp, grasping at his scaled shoulders, upon the threshold of pain and exquisite pleasure as he spreads your [vagina] wide with his huge girth. “<i>Been saving yourself for this? Good girl.</i>”");
			}
			else
			{
				outputText("\n\nHe grunts with satisfaction as, after just a few thrusts, you take his huge girth right down to his muscled hips. You gasp as he begins to fuck you harder, pressing into your tunnel forcefully. “<i>Been preparing yourself for this, have you?</i>” He growls, his breathing coming heavier as he bucks his heavy body into you. “<i>Few test runs, with my soldiers? Or maybe you’re the kind of girl who sits down and spreads them for anything that might have a big, fat dick. No matter. You belong to me now, body and soul.</i>”");
			}
			if (!player.hasCock()) outputText("  His other dick bats into your stomach, thrusting upwards towards your [chest] as he speaks, his eyes transfixing you, drawing you further into his savage, potent, golden dreams of lust and conquest as he speaks.");
			else outputText("  His other dick thrusts against your own [cock], hardening it with incessant rubbing as he speaks, his eyes transfixing you, drawing you further into his savage, potent, golden dreams of lust and conquest as he speaks.");
	

			outputText("\n\n“<i>The demons were scared of you, thought you might bring their empire down. And you shall. I will fill you full of my eggs. You will give me dozens, hundreds of loyal soldiers and eager breeders. Whilst Lethice’s fodder fret and furrow over how to produce anything from their cursed seed except fucking imps, we will procreate, we will create an army underneath them, and then, then we shall tear them apart from within. We shall set ourselves above everyone, bring back the old ways, walk Mareth the way our ancestors did, feared by all. A Tyrannosauracy!</i>” He laughs richly as he thrusts himself deep into you, enjoying every inch of your [cunt] as you moan, and he goes on in a lower tone. “<i>My genes are good, but if this is to work I guess I will have to spread our bets a little. Loan you out some. You’d like that, wouldn’t you? Sleep with the crew some nights?</i>”");
			
			outputText("\n\nAn excited, breathless murmur spreads through the hall to these words, whilst yellow tinted images push their way into your head, of being surrounded by tight, smooth lizard flesh, of hard, hot dick pushing urgently into every hole you have, all night long... you can’t help it. Your [vagina] convulses around Jean-Claude’s thick dick, surges of helpless pleasure pulsing through your body, and he roars with renewed laughter even as he continues to drive into you. “<i>She DOES like the sound of that! So behave yourself, boys. If you do real good for me, who knows? Maybe I’ll let you have some quality time with the queen!</i>” So saying, he thrusts himself upwards to his own orgasm, burying himself deep into you as he fills you full of his hot spunk. You buck your [hips] into him happily, unable to think of anything but of getting more of his seed, of being packed full of new life, of serving your new master. Your mind is a blank canvas of pure, submissive pleasure and it, like your future, is golden.");

			//THE END
			// 9999
			menu();
			doNext(9999);
		}
		
	}

}