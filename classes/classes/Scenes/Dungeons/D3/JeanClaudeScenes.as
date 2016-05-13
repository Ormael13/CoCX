package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.StatusEffects;
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
		
		public function gogoFuckTheseBasilisksNorth():void
		{
			clearOutput();
			outputText("You " + (player.hasKeyItem("Laybans") >= 0 ? "put your Laybans back on" : "steel yourself") + ", carefully unlock the door and then, as quietly as you can, creep back out onto the wire gantry. The throng of greyish green below seems oblivious. It’s only when you get halfway across that you realize that you’ve been had. As soon as you are as far away from one exit as the other, two big groups of the lizards near the stairs immediately jump up and climb upwards determinedly. You speed as fast as you can to the door ahead, but the team of basilisks are ready and plough into you, grabbing your body as they reach for your shades. You desperately push and elbow them away from you but you cannot stop one from " + (player.hasKeyItem("Laybans") >= 0 ? "deftly hooking your Laybans off with his sickle claw" : "grabbing you with his clawed hand") + ".");
			if (player.findPerk(PerkLib.BasiliskResistance) >= 0) {
				outputText("\n\nDespite your naked eyes gazing into a dozen basilisk eyes, they have no effect on you! You " + (player.canFly() ? "fly" : "run") + " as fast as you can, being careless of glancing over the basilisk eyes thanks to your immunity. In no time, you manage to open the door and lock it as soon as you enter! You laugh as you hear the basilisks cursing about.");
				menu();
				addButton(0, "Next", d3.move, "antechamber");
			}
			else {
				outputText("\n\nA horrible leaden weight settles upon your bones as your naked eyes gaze into a dozen basilisk eyes, your body turning into rapidly solidifying cement. You reach for your [weapon], but it’s as if it were a continent away, and the lizards press into you, grabbing your hands and [hips], forcing you to stare deeper and deeper into the ocean of depthless grey which surrounds you on all sides, and encompasses you, and where you were and what you were doing no longer matters, because the grey permeates your body and soul, and you are just an atom in a sky of peaceful, dove coloured submission, and whether you’re up or down or sideways or down doesn’t matter...");
				menu();
				addButton(0, "Next", capturedByBasilisks);
			}
		}
		
		public function gogoFuckTheseBasilisks():void
		{
			clearOutput();
			
			outputText("You breathe deep, steel yourself")
			if (player.hasKeyItem("Laybans") >= 0) outputText(", put your shades on");
			outputText(" and stride out onto the gantry. The plan is simple. You’ll keep your eyes up and march across as if you belong there, as if you are on official business.");
			if (player.demonScore() > 4) outputText("  You can’t be mistaken for anything but a demon, after all.");
			outputText("  If or when the lizards realize who you are, you’ll make a break for it, and hopefully by then you’ll be in reach of the exit. It’s straight-forward, it’s elegant, it will work, whatever your hammering pulse has to say on the matter.");

			outputText("\n\nYou try and not look down as you proceed, back straight and as aloof as you can.");
			
			if (player.isNaga()) outputText("  You’re probably imagining things but the passage of your sinuous form over the wire surface seems absurdly loud, an endless rubbing of sandpaper which seems to fill the hall.");
			else if (player.isGoo()) outputText("  Godsdamn this form... you try not to think as you slide across the wire surface, intensely aware of the slimy sound you make as you go, of the steady drip of your fluids through the mesh, trying not to think of it splashing down on curious, blunt heads.");
			else outputText("  Clack, clack, clack. You are intensely aware of the sound of your [feet] on the wire surface. You close your eyes and tell yourself you’re only imagining that it’s loud, that it echoes around the hall, that the basilisks would have to be deaf not to hear you.");

			outputText("\n\nYou are almost half of the way there when the hush descends. You keep your eyes fixed determinedly upon the exit, trying to wish away the spreading silence, the meadow of deathly grey flowers which has gradually blossomed below you.");
			// Look out, an intruder!
			outputText("\n\n<i>“Attention, un intrus!”</i>");
			// Get him!
			outputText("\n\n<i>“Attrapez-le!”</i>");

			if (player.hasKeyItem("Laybans") < 0)
			{
				outputText("\n\nImmediately you break into a run, pelting for the other side, as below you there’s a general rush for the stairs. Your heart feels like it’s going to burst out of your chest as the gantry bounces to your frantic motion, and to the beat of many feet climbing it. The booth is in reach... a sickle claw catches you in the thigh, and you stagger. Growling, you frantically right yourself- only to find yourself staring directly into the face of a basilisk. You punch that one in the nose, wildly tearing your eyes away... to another. And another. They surround you as horrible leaden weights settle on your bones, your body turning into rapidly solidifying cement. You reach for your [weapon], but it’s as if it were a continent away, and the basilisks press into you, grabbing your hands and [hips], forcing you to stare deeper and deeper into the ocean of depthless grey which surrounds you on all sides, and encompasses you, and where you were and what you were doing no longer matters, because the grey permeates your body and soul, and you are just an atom in a sky of peaceful, dove coloured submission, and whether you’re up or down or sideways or down doesn’t matter....");

				// [go to Captured]
				menu();
				addButton(0, "Next", capturedByBasilisks);
				
				return;
			}
			else
			{
				outputText("\n\nImmediately you break into a run, pelting for the other side, as below you there’s a general rush for the stairs. Your heart feels like it’s going to burst out of your chest as the gantry bounces to your frantic motion, and to the beat of many feet climbing it.");
 
				if (player.spe < 90 && player.findPerk(PerkLib.BasiliskResistance) < 0)
				{
					outputText("\n\nThe booth is in reach... a sickle claw catches you in the thigh, and you stagger. Growling, you frantically right yourself- only to find yourself staring directly into the face of a basilisk. You punch that one in the nose, wildly tearing your eyes away... to another. And another. They surround you and though you wheel around, desperately pushing and elbowing them away from you, you cannot stop one deftly hooking your Laybans off with his sickle claw. A horrible leaden weight settles itself upon your bones as your naked gaze is trapped by a dozen basilisk eyes, your body turning into rapidly solidifying cement. You reach for your [weapon], but it’s as if it were a continent away, and the lizards press into you, grabbing your hands and [hips], forcing you to stare deeper and deeper into the ocean of depthless grey which surrounds you on all sides, and encompasses you, and where you were and what you were doing no longer matters, because the grey permeates your body and soul, and you are just an atom in a sky of peaceful, dove coloured submission, and whether you’re up or down or sideways or down doesn’t matter...");

					//[go to Captured]
					menu();
					addButton(0, "Next", capturedByBasilisks);	
					
					return;
				}
				else
				{
					outputText("\n\nThe booth is in reach... your panic unlocks a final reserve in your straining muscles and you");
					if (!player.canFly()) outputText(" almost");
					else outputText(" literally");
					outputText(" fly towards the door. A solitary basilisk manages to clamber onto the catwalk ahead of you- and you simply bull-rush straight through him, his deathly eyes useless against your screened vision. You think you feel the passage of sickle claws scything fruitlessly through the air inches away from your back as you bundle through the exit and into the empty observation booth. In an ecstasy of terror you fumble with the door and manage to slam it shut, just as several heavy bodies thud into the other side. You breathe a huge sigh of relief as your hands find a deadbolt and slide it across, sealing the basilisks off from you. They hammer at it for a while longer, shouting and hissing angrily, but eventually, whilst you’re still gathering your breath, they get fed up with it and leave.");
					
					outputText("\n\nYou’re free to continue- but you will have to find an alternative route if you want to go back, unless you’re crazy enough to unlock the door and try the catwalk dash again.");
					
					menu();
					addButton(0, "Next", d3.move, "magpiehalln");
				}
			}
		}
		
		public function capturedByBasilisks():void
		{
			clearOutput();
			outputText("Down. You’re staring up at the ceiling of the magpie hall, from your position upon your back. Your limbs are seized up, are not responding to any of your brain’s frantic demands, and you can only see what is in the corner of your frozen gaze, which is lots and lots of basilisks standing over you staring back.");

			// And now, what should we do?
			outputText("\n\n“<i>Et maintenant, que devrions-nous faire?</i>” says one.");

			// Summon in the king
			outputText("\n\n“<i>Faites venir le Roi,</i>” says another, after a heavy pause. A murmur ripples through the hall at that. You have no idea what they’re saying in their raspy, fluid tongue, but you can’t imagine it’s anything good. One in the corner of your vision darts out of sight, and you are left to wait, a statue frozen in the stance of a running struggle. You feel dense apprehension weight steadily more and more upon you as a heavy footstep thuds towards you.");

			// I certainly hope you have a good reason to disturb me, soldier, for I now burn with the desire to skin you alive and rape your corpse. Oh my, what have we here?
			outputText("\n\n“<i>J'ose espérer que vous avez une bonne raison de me déranger, soldat, car il me brûle d'envie de vous écorcher vif et de violer votre cadavre. Oh! ma foi, qu'avons-nous là?</i>” Dry, smooth hands grip you and winch you up so you may see the owner of the thick, rich voice. It’s a basilisk- but bigger, at least a foot taller than those that surround him, heavier built, and obviously simmering deep in corruption. Purple scales slather his shoulders and back like an imperial cloak, and he is clad in a military tunic and ornate brass cuirass. The former does absolutely nothing to disguise his two thick, purple pricks, which unlike those of his brethren swing freely and imposingly between his muscled legs. His long, tapering face gives him a toothy sneer of epic proportions, and his proud head is crowned with a helmet, resplendent with a long, black ponytail. His eyes... you renew your frantic efforts to look away. Leering, the basilisk rex steps closer to you, bathing you in their hungry glare. They are a seething yellow, pupil-less, two eternal, burning suns of depthless corruption.");

			// Can you(T-form second person) understand me, intruder? 
			outputText("\n\n“<i>Peux-tu me comprendre, intrus? Non? Sprechen de Gnollen? How about now? Ah, yes. Human. The language of masters... and slaves.</i>” His widening sneer leaves you in no doubt which camp he considers you as belonging to. “<i>I am Jean-Claude, the Rude King, if you please. You are the interloper, if you please. Ah, yes! Yes you are! Do not try to deny it!</i>” He laughs richly, his slow, velvety voice rolling around you as he goes on. “<i>You have beat up enough of my scouts that you have left, eh, an impression, shall we say? We do not need orders from the demons to watch out for such a rough player as you!</i>” He moves as fast as a snake, belying his size and frame, to grab you tight around the jaw. His claws dig into your skin as he stares deep into your eyes, encompassing you in their rich, bottomless glow. It glows like your blood glows, rising to the surface of your skin, coursing inexorably to your groin,");
			if (player.hasCock()) outputText(" [eachCock] stiffening");
			if (player.hasCock() && player.hasVagina()) outputText(" and");
			if (player.hasVagina()) outputText(" your [vagina] beading with excitement");
			if (!player.hasCock() && !player.hasVagina()) outputText(" your loins aflame with excitement");
			outputText(" as you sink further into the yellow warmth, immersing yourself in it, so small and pliant and willing to be shaped by that fathomless, over-arching will, this huge masculine creature with a body of carved strength, with his feral, demanding smell surrounding you, with his big, luscious cocks....  The other basilisk’s spell is fading from your limbs, allowing you to move, but it is no respite at all- the more you stare into the eyes in front of you now, the weaker you feel, the more you want to puddle onto the floor and supplicate yourself before their power.");

			outputText("\n\n“<i>But now the ball is in the basilisk court, is it not, interloper?</i>” Jean-Claude growls softly, holding your face close, pulling you deeper and deeper into his glow, bathing you in heat. “<i>And the only question now is how I am going to serve you.</i>”");

			outputText("\n\nThe last of the petrifying curse slips from your limbs and a thought leaps lightning fast through your mind, cutting through the warm haze for a moment. It tells you that you have to act now - with your body free of the grey and your mind still resisting the gold. What do you do in this one, free, desperate moment?");
			menu();
			addButton(0, "Taunt", capturedbyBasilisksTaunt);
			addButton(1, "Run", capturedByBasilisksRun);
		}
		
		private function capturedByBasilisksRun():void
		{
			clearOutput();
			outputText("With all your willpower you tear away from the monster’s lidless gaze. His sharp claws graze your cheeks as you throw yourself backwards, turn and charge with a defiant cry into the ranks of reptiles which surround you. You have your [weapon] loose, and you swing it this way and that, adrenaline and desperation lending you strength as you send basilisks flying... but there are hundreds of them, and one of you, and too many places not to look. You strike, you punch, you scratch, you bite, but eventually your limbs tire; they seize up as you tear yourself away from one grey gaze only to find another, and the basilisks simply have to surround you, pack you tight with their bodies while one of them stares deep into your eyes, flooding your mind with a blaring, hypnotic wash. There’s a sound coming from somewhere: a strange, staccato bark. It’s only when the lizards return you frozen to the feet of their king that you realize what it is. The Rude King is laughing, sat on a table and doubled up with gulping mirth.");

			outputText("\n\n“<i>You’re fast, interloper! And you fight good! But not so bright, eh? I think you think fast, but a stupid thought is a stupid thought, whether it takes a second or an hour to arrive.</i>” He reaches forward and almost tenderly takes you by the cheek again, rubbing the lines he left there with his smooth thumb, forcing you to look back into his eyes. “<i>See? All you managed was to damage yourself. That’s no good to anyone, is it?</i>” It occurs to you that since you were captured none of the basilisks have used their claws or teeth against you, and you realize why that is- they want you whole. You groan deep in your still throat as the hot, yellow glow of Jean-Claude’s eyes encompasses you.");

			// [go to bad ends]
			menu();
			addButton(0, "Next", basiliskBadEnds);
		}
		
		private function capturedbyBasilisksTaunt():void
		{
			clearOutput();
			outputText("You stare into the yellow, hypnotic eyes and for a moment see beyond them, see them as part of this being rather than the whole, see the arrogance that sits behind them, see, perhaps, a way out of this. With all your willpower you force your mouth to open, work your vocal chords- and make a 'pfft' noise.");

			outputText("\n\n“<i>Some king you are,</i>” you manage. Jean-Claude draws back, looking slightly surprised, and emboldened you press on. “<i>Your servants did all the hard work- you just came out to claim all the credit at the end. Is that how it works for basilisks? You get the day-glo eyes for sucking demon dick, and then sit on your ass whilst everybody else does the thinking and fighting for you?</i>”");

			outputText("\n\n“<i>You dare...</i>” the rex whispers, deep in his throat. His eyes have turned a yellowish white. You raise your voice, so every basilisk in the hall can hear.");

			outputText("\n\n“<i>I haven’t been here five minutes and I can already tell what kind of ruler you are. Doesn’t matter how many extra inches you’ve given yourself by kissing imp ass- you’re the smallest lizard in this room. Your kind will fight and die for you whilst you, with your fancy armor, will cower in the corner and wait for it to be over. You think you frighten me, that you impress me? You wouldn’t dare fight me, and everybody here knows it!</i>” A deathly silence ensues. Jean-Claude stares at you, fury clenching his long face, and for a moment you think he might just bite your head off. Then he looks up, blinks, and roars with laughter.");

			outputText("\n\n“<i>Ahahaha! I like it interloper, I like it a lot. Being rude to the Rude King! You think to make me angry so I make a mistake, yes? Even when it is all over for you, you are being clever, you are fighting.</i>” He turns away, snorting. The monstrous basilisk might be affecting bonhomie, but in the fractious swish of his tail and the whiteness of his eyes, you see that you have succeeded- you’ve pissed him off. He barks something to one of his brethren. The others murmur, and there’s a hushed sound as they fall back, forming a ring around the two of you. Something is thrown to Jean-Claude; he catches it and swishes it thoughtfully, before turning back to you.");

			outputText("\n\n<i>“Here’s the problem, interloper,”</i> he says, sneering at you as he points the huge, bronze cutlass down. <i>“I don’t make mistakes. You can. By the end, you will appreciate just how serious a mistake it was to fight me. How much better it would have been to simply accept your fate.”</i>");

			outputText("\n\nYou scramble to your feet, draw your weapon and set your jaw. You’ve gotten your one shot, and you can’t waste it.");
			
			startCombat(new JeanClaude());
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

				// Spare me your mercy (can be interpreted as mercy kill), intruder
				outputText("\n\n“<i>Épargne-moi ta miséricorde, intrus,</i>” he snarls, his rich voice heavy with exertion and humiliation. “<i>Spare me of your forgiveness and spare me of your mercy kill. I will see my own way out. Trust me- once the bitch queen has got her hands on you, you will wish you did the same thing.</i>” He reaches for his throat with his sharp claws. You are grateful that he no longer has the power to hold your gaze- unfortunately there is no way of closing your ears. You turn away as, with a wet choke and gurgle, a small part of the evil holding this place departs forever.");
			}

			outputText("\n\nThere’s an echoing silence as the ranks of basilisks stare at their dead king. Then, with a shifting sound that spreads out like a tidal wave through the huge room, they drop one by one to a knee, their eyes closed and spiked heads pointed towards you. Elation inflates in your breast and fills out to the very tips of your digits as you take in the reptile horde bowing before you, the significance of it dawning brilliantly.");
			if (player.mf("m", "f") == "f" && silly()) outputText("  You raise your fists in glee and crow “<i>I AM THE LIZARD QUEEN!</i>” at the ceiling.");

			outputText("\n\nThere’s a bit of scuffling and shoving at the front, and finally a smaller-than-average basilisk is pushed out towards you. He almost trips over the flagstones in his attempts to keep his eyes squeezed shut and head bowed in deference to you.");

			// What are your orders, my king/my queen (assuming bost basilisks don't speak english)
			outputText("\n\n“<i>Que- quels sont vos ordres, " + player.mf("mon roi","ma reine") + "?</i>” he whispers.");

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
			
			combat.cleanupAfterCombat(d3.resumeFromFight);
			
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
			if (player.findPerk(PerkLib.BasiliskWomb) >= 0) bwombBadEnd();
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
			if (player.findStatusEffect(StatusEffects.RemovedArmor) > 0) outputText("  You realize vaguely you already have taken your clothes off, undoubtedly your own subconscious preparing you for this moment.");
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
				outputText("\n\nHe reaches down and, bending his claws away, puts his warm, smooth hand to your [vagina]. Already aroused beyond measure, you seep femcum ardently as he circles your [clit] and moves his digit down your channel. Grinning, he moves his hand upward, sliding over a nipple teasingly before pressing his finger against your mouth, wiping the black fluid onto your frozen lips, making you taste it.");

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
			
			getGame().gameOver();
		}
		
		private function bwombBadEnd():void
		{
			clearOutput();
			
			outputText("The Rex’s yellow glow encompasses you, glaring out everything- your purpose, your memories, your sense of self, replaced only by the need to stare deeper and deeper into the pits of gold, the depthless lava of his will which rolls over you, heats you within and without. When he steps into you and puts his warm, smooth hand on your waist you almost flinch, you are that sensitive to his presence. He grins with the exhilaration of a conqueror as he draws you further into himself. The nagging undercurrents of your own body rise to the surface as you feel his warmth and smell his powerful musk; your [vagina] beads with excitement and the bubble which sits in front of your stomach seems to expand, flooding your system with pheromones which make your heart pump faster and your skin turn red as your body reacts to the presence of this alpha male. Jean-Claude breathes your own smell deeply, his smile widening as he stares into your unfocused, helpless eyes.");

			outputText("\n\n“<i>So,</i>” he husks, “<i>that is true, too. Do you know I had six of my scouts beaten for telling lies? For bringing back the story about a wanderer of the mountains who smells exactly like a female basilisk? Wishful thinking, I thought- I had heard it a hundred times before. And yet here we are, interloper. Here we are. The answer to our curse. How did you do it? Why did you do it?</i>” He is fretful with excitement, his breathing heavy and tail lashing as he slides his hand down to squeeze your [butt], handling you like a choice cut of meat. You wish you could step away from your body and his, feel disgust at the deep excitement and anticipation your modified womb is pressing on you, remember the reason why you changed yourself in this way, but you can’t. You can’t tear yourself away from the golden glow, how hot and soft it makes you feel bathed in its radiance, and- you can’t remember the reason. You struggle. You wanted to help the basilisks. That can be the only reason. And you’re here now, with their leader, and... you sigh. Everything suddenly feels right, your horny body and frustrated mind clicking into sync. You wanted to help the basilisks, you changed your body to do it, and now you’re here, ready to begin. You return Jean-Claude’s smile gladly, pleased with your breakthrough.");

			outputText("\n\n“<i>Ah, you’ve remembered the why of it,</i>” he murmurs, his rich voice resonating deep in your bones as his hypnosis rolls over your unresisting mind, like soft, unceasing fingers on your [clit]. “<i>The how of it does not really matter, does it? Not anymore. Undress me.</i>” Happily you get to work, stretching to undo the clasps of his breastplate, your hands sliding over his hot, smooth scales, glorying in his size and strength as you denude him of his tunic and helmet.");
			if (player.findStatusEffect(StatusEffects.RemovedArmor) >= 0)
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
				player.cuntChange(24, true, true, false);
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
			getGame().gameOver();
		}
		
	}

}
