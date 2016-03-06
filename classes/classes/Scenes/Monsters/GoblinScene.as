/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Monsters
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class GoblinScene extends BaseContent
	{
		public function GoblinScene()
		{
		}

		/*Goblins
		 Gender: Female
		 Height: 2-4 feet
		 Eye Colors:  Red, Violet, Amber, or Pink
		 Hair Colors: Red, Very Light Blonde, Purple, Pink, White
		 Skin Colors: Green, though in rare cases gray, blue or yellowish.
		 Appendages: Their arms and legs look like a human's, although they are scaled down to fit the goblin's smaller frames.
		 Appearance: Goblins are normally lithe little creatures with somewhat elfin faces.  Their ears are pointed, though their unusual (and very punk rock) haircuts can sometimes hide them.   A goblins age can usually be determined by the size of her bust and hips.  Very young goblins have relatively small chests and hips, though as they age and give birth, their endowments will grow ludicrous sizes.  It is rumored that somewhere there is a goblin Queen who has so many children that she has become immobile.

		 They often dress themselves in tight fitting leather harnesses to display their chests.  A goblin's crotch will ALWAYS be exposed.  They favor piercings in multiple locations, and most have jewelry in their nipples, clit, and both pairs of lips.  
		 Aging: Goblins do not get 'old' like other races, and do not get lines or wrinkles.  They will not die from age alone, though should a goblin be successful enough to immobilize herself, she may die if she does not have family that keeps her fed.
		 Sex Life: Goblins are ALWAYS horny and ready to copulate.  They have large juicy vulva that ache for penetration, and despite their small size can take many of the larger members out there (in moderation).  They will always seek to have sex with any willing participant, and in those rare cases where they are too small, they will be sure to take as much cum inside them as possible.  Thanks to the wide array of psychology altering chemicals in their body, goblins get off on the act of giving birth.
		 Life Cycle: The life of a young goblin is likely to end in the jaws of a hellhound, impaled on a minotaur's dick, or drowned tentacle-cum.  Due to the special properties of their wombs (any pregnancy ALWAYS results in a goblin), they are considered worthless to most monsters and demons, and due to their small size, they often end up dying after an encounter with a minotaur or similar creature. Despite the high fatality rate of young goblins, those who survive beyond their first pregnancy will often live a very long time, and will dedicate themselves to birthing their broods (4+ goblins per pregnancy) and perfecting alchemical recipes they can use to 'seduce' more 'fathers'.
		 History: Goblins were once the technological leaders of what is now known as the Demon-Realm.  When the demons came, they signed a treaty guaranteeing peace and freedom to the goblin people.  The peace was a lie.  That night, a team of demons tunneled into the goblins water supply and began tainting with ever increasing levels of corruption.  Over the next few days, the goblins spent less and less time working, and more and more time fucking.  

		 Within a week, their greatest minds were spending all their time eating pussies and developing new aphrodisiacs.  Within a month the goblins were permanently turned on by the strongest of drugs and fucking nonstop in the streets of their once-great city.  A few did not partake of the tainted water, and locked themselves inside their dwellings for as long as they dared.  Some gave in to thirst or loneliness.  Others stayed indoors until the demons walked in and easily assumed control.  They put the few sane goblins left to work building the machines that run their empire to this day.  No one has seen those few survivors since, and most goblins don't waste time thinking about them.
		 Social Structure: Goblins live in groups of 100-300, typically lead by an elder female with a direct bloodline to every goblin under her.

		 STANDARD GOBLIN ENCOUNTER:
		 3' even height.
		 Breasts would be about DD cup if she were human.
		 Nice hips & well-rounded ass.
		 Green skin, pink and black(mostly pink) gothy hair.
		 Vagina/ass/mouth capable of taking dicks with volume up to about 36 (so 12x3 or 24x1.5, etc, etc)
		 Cute face, likes to put on drugged lipstick to incapacitate her foes with after raping them.
		 Carries bottles of aphrodisiacs and drugs.
		 Dressed in leather straps that support her chest (in a lewd way) while leaving her pierced nipples exposed and slightly parting her ass to expose her pucker & femmy funbits.  Pierced pointed ears.
		 */
		//RAEP TEXT 1
		public function goblinRapesPlayer():void
		{
			
			spriteSelect(24);
			clearOutput();
			if (doSFWloss()) return;
			if (player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) {
				//[Female Bimbo Loss Against Goblin]
				if (player.hasVagina()) {
					outputText(images.showImage("goblin-loss-female-bimbodildo"));
					outputText("The goblin saunters up to you, wiggling her hips with a needy, sexual sway. She opens a small pouch, the sight of which instantly bombards your easy mind with thoughts of your lower lips being opened similarly, and pulls out a tube of lipstick, pausing to apply it to her lips. She caps off the tube and blows you a kiss with a wet smacking sound as she steps up to your trembling form. Your breath is knocked from your body as she drops all her weight onto your middle, making her ass and well-rounded tits jiggle just like yours do when you are bouncing on a cock. She reaches up to twist her nipple-studs, grinding the wetness of her crotch up and down your belly. You can't help but envy her piercings. Like, they totally turn you on!\n\n", false);
					outputText("Your body is already hot and your " + player.nippleDescript(0) + "s harden involuntarily in response to the tiny slut's totally understandable display of desire. Your " + player.vaginaDescript(0) + " leaks enough girl-juice to form a puddle beneath you, doing its best to show your fellow slut how ready you are. You 'subtly' (at least in your little mind) push your chest forward, making your " + player.nippleDescript(0) + "s easy targets for the goblin. She grabs hold of your breasts", false);
					//--[If nipplecunts]
					if (player.hasFuckableNipples()) outputText(", fingering your wet nipplecunts and pinching the now-puffy areolas tightly, sending uncontrollable waves of pleasure from your chest to your groin.", false);
					//-[If not]
					else outputText(" and slides her fingers up to your nipples, pinching and twisting them, torturing you with pain and pleasure.", false);
					outputText("\n\n", false);

					outputText("The goblin, almost drooling, says \"<i>Baby, we're both horny, but fingers and tongues just aren't enough for me. Lucky for you, I've got just the thing.</i>\"\n\n", false);

					outputText("For a moment, your dumb, bimbo mind struggles to think of whatever she could, like, mean by that. Oh well, you giggle airheadedly and just let it happen.\n\n", false);

					outputText("The goblin reaches into another one of her pouches and pulls out a dildo that flops about in her hand as if it were glad to be free of the pouch. Slapping you on the cheek and grinning mischeviously, she offers, \"<i>Why don't we bury one end in each of our cunts? Just open your mouth and help me get it warmed up for us, okay?</i>\"\n\n", false);

					outputText("For a moment, you blink dumbly, trying to think why for, like, one tiny second you wanted to say 'no', but then you forget about it, let the horniness flow, and naturally pop your mouth open into a perfect-lip lined 'O', shooting her a involuntarily slutty look.\n\n", false);

					outputText("She instantly plugs your sex-doll-like mouth with the bulging dildo.  It plumps up somehow, forcing your jaw open and pinning your tongue to the bottom of your mouth – this is like, so much easier than having to hold it open yourself. A trickle of fluid escapes its tip. You swallow it reflexively – oh wait, was that like cum or like what? Your little brain is confused for a moment, at least 'til the smarter slut explains it to you.\n\n", false);

					outputText("\"<i>Yummy isn't it? I made this myself. It's made of the best stuff – it reacts with fluids to puff up and fill ANY hole perfectly. Which, by the looks of you, will probably be helpful.  You look like you've taken a few in your day.</i>\" She winks, \"<i>Oh, and even better... it has a little tube inside full of aphrodisiacs that'll slowly leak out into your wet body!</i>\"\n\n", false);

					outputText("Saliva coats your lips and dribbles down onto your boobs when the goblin pulls the thick, soaked dong out of your mouth. The part that was stuffed down your throat is swollen up to nearly twice as wide as the half still in her hand. The goblin quickly corrects that, slurping the second half down into her throat, taking at least eight inches into her mouth with no sign of gagging. She's like, totally good at this! She pulls it out, watching it puff up. She blushes, turning her slightly-dimpled, green cheeks a shade of purple. The dildo slaps your twat cruelly as she drops part of it onto your mons. With a few practiced motions, she shoves it inside you, stuffing you full of artificial cock, bringing your mind back to all the times you'd fucked yourself just like this. Your easy, wandering mind is brought back to the present by a small slap on the dildo, which sends vibrations right into your " + player.vaginaDescript(0) + ".\n\n", false);

					outputText("Your green slut counterpart stands up and steps over your crotch, positioning herself perpendicular to you. The warm wetness of her dripping cunt splashes your thighs when she works the free end of the double-dong into her own slick twat. Your pussy squelches against hers wetly as they meet in the middle, your " + player.clitDescript() + " pressed on by her nether lips. The goblin twists, grinding and scissoring her thighs, the hard bud of her clit rubbing against your " + player.clitDescript() + " again and again.\n\n", false);

					outputText("By now your passage feels, like, more stuffed than ever! Every motion the tiny slut makes is amplified directly into the fuck-stick plugging your drooling pussy. Judging by how wonderful it feels rubbing and twisting against your well-experienced vaginal walls, the aphrodisiac is definitely working. You moan and spread your legs wide, giving the tiny dominatrix free reign over your body in its natural position – open and ready.\n\n", false);

					outputText("She wiggles against you harder, throwing her head back and running her fingers through her purple hair, shouting out encouragement all the while, \"<i>Mmm, you like this, don't you slut? My dildo fits your slutty cunt well, doesn't it? I bet that's rare. Keep wiggling those hips – the aphrodisiac is gravity fed, and with you on the bottom you'll be blissed into unconsciousness soon. Just don't cum before me hun, I want to feel release WITH you.</i>\"\n\n", false);

					outputText("It isn't hard these days, but you lose yourself in the sweet sensations of the bloated dildo that joins your simmering groins, pleasure whisking away whatever little intelligence you have left. Rocking back and forth, scissoring relentlessly against your green mistress, you moan, drowning yourself in a sea of drug-enhanced pleasure. The goblin cries out and thrashes in sudden orgasm, twisting the fat dildo violently around inside your slut-hole. The juices of her orgasm react with the toy, stretching you to a perfect level of vaginal gape – it's sooooo rare to, like, find someone who can stretch you out! Your bodies thrash together, wracked by twin orgasms that leave you smeared with a mixture of sweat and girl-cum.\n\n", false);

					outputText("Later, the wet goblin audibly pops off the dildo. She stumbles, bow-legged, before teasing your bimbo-clit and yanking her toy free of your needy pussy. Your lips gape wider than ever, but you've gotten used to your pussy getting stretched by now...", false);
					player.cuntChange(player.vaginalCapacity(), true, true, false);
					outputText("\n\n", false);

					outputText("She plants a kiss on your lips and mutters, \"<i>Can't forget this,</i>\" as she puts her dildo away. You find yourself smiling and watching her strap-covered form jiggle pleasantly as she bounds away from you into the distance. Your eyelids drift closed and your lips go numb as her drugged lipstick begins to put you out.\n\n", false);

					outputText("Your eyes roll up into your head, leaving you looking dumber than ever. Damn, like, that was, like, totally fucking amazing!", false);
					player.orgasm();
					combat.cleanupAfterCombat();
					return;
				}
			}
			outputText("The goblin saunters up to you, wiggling her hips with a needy, sexual sway.  She opens a small pouch and pulls out a tube of lipstick, pausing to apply it to her lips.  She caps off the tube and blows you a kiss with a wet smacking sound as she steps up to your ", false);
			if (player.HP < 1) outputText("defeated", false);
			else outputText("trembling", false);
			outputText(" form.  Your breath is knocked from your body as she drops all her weight onto your middle, making her ass and well-rounded tits jiggle enticingly.   She reaches up to twist her nipple-studs, grinding the sopping wetness of her crotch up and down your belly.\n\n", false);
			outputText("Your body grows hot, responding to the tiny fetish-slut's outrageous display of desire.  ", false);
			if (player.cockTotal() > 0) {
				outputText(images.showImage("goblin-loss-male-raped"));
				outputText("The warmth spreads, growing larger ", false);
				if (player.cocks[0].cockLength <= 7) outputText("as your bulge begins to press between her soft ass-cheeks", false);
				else if (player.cocks[0].cockLength <= 14) outputText("as your bulge grows upwards between her ass-cheeks and lays against the small of her back", false);
				else outputText("as your bulge grows up her back and creeps towards her shoulders steadily", false);
				outputText(".  ", false);
			}
			if (player.hasVagina()) {
				outputText(images.showImage("goblin-loss-female-raped"));
				if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_NORMAL) outputText("The lips of your sex engorge, becoming almost as puffy as the goblin's.  ", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("Feminine lubricant soaks into the back of your " + player.armorName + ".  ", false);
				else outputText("It rapidly forms into a puddle as your " + player.vaginaDescript(0) + " does its best to show just how ready you are.  ", false);
			}
			outputText("Your " + player.nippleDescript(0) + "s poke upwards, giving the goblin easy targets.  She grabs hold of them ", false);
			if (player.hasFuckableNipples()) outputText("slipping her thumbs inside the tender cunts and pinching against them tightly", false);
			else outputText("twisting and tweaking", false);
			outputText(", torturing you with pain and pleasure.\n\n", false);
			//[DICK VERSION]
			if (player.totalCocks() > 0 && (!player.hasVagina() || rand(2) == 0)) {
				//[TOO BIG]
				if (player.cockArea(0) > monster.vaginalCapacity()) {
					outputText("She lifts her body up high, grabbing your " + player.cockDescript(0) + " with both her petite hands.  Your mind somehow makes note of the shiny black of her fingernails as she struggles to part her dripping wet womanhood around your massive member.  Though her body stretches to an absurd degree, she just can't get you inside. She pouts and drops your tool back onto you, promising you, \"<i>I'll find a way to get every ounce of your cum inside me, don't you worry.</i>\"\n\n", false);
					outputText("The little slut jumps back onto you, wrapping her arms and legs tightly around your member.  Her tongue slithers over ", false);
					if (player.balls > 0) outputText("your " + player.ballsDescriptLight(), false);
					else outputText("the base of your " + player.cockDescript(0), false);
					outputText(" before she buries it deep into your " + player.assholeOrPussy() + ".  Her thighs, breasts, and body surround you with a shroud of warm green flesh that wriggles and twists around you with feverish lust.  The lips of her still-partially stretched cunt do their best to devour your member's head when the flexible little minx curves her hips back down to grind on it.\n\n", false);
					outputText("The lewd little creature body-fucking your titanic tool is just so passionate and sensual that you can't hold the budding pressure in your loins.  You're sure you must be leaking pre-cum, but the squishing wet cunt wrapped around your cock-tip has you so slathered in fuck-juice you'd never be able to tell.  You tremble, struggling to hold back and ", false);
					if (player.cor > 50) outputText("prolong your pleasure", false);
					else outputText("prevent the monstrous girl from getting what she wants", false);
					outputText(".  The goblin looks back over her shoulder, narrows her eyes, and pulls back to say, \"<i>Don't even think about holding back stud.</i>\"\n\n", false);
					outputText("She works her fingers into the void her tongue left behind, ", false);
					if (player.hasVagina()) outputText("caressing your " + player.clitDescript(), false);
					else outputText("pressing tightly against your prostate", false);
					outputText(" as she whispers, \"<i>Go ahead, make my twat a swollen cum-dump.  I NEED you to FILL me with ALL of your cream.  Stuff me full of your fuck-juice and I promise I'll give you a dozen slutty daughters to fill with jizz every night.</i>\"\n\n", false);
					outputText("Her fingers and words have the desired effect, drawing out a tremendously pleasurable orgasm.  Your hips rock and buck against her lithe body, forcing her to cling on to your spasming form as globules of cum force their way up your massive urethra.  You can feel them explode into the tiny girl's sopping tunnel, immediately soaking into her womb.", false);
					if (player.cumQ() > 100) outputText("  Your loads keep coming, until the jism begins to backwash out of her love tunnel to soak her body and your midsection.", false);
					if (player.cumQ() >= 250) outputText("  Her belly distorts visibly as her uterus is packed full of cum, making her look heavily pregnant already.  She coos in delight at the sight of her swollen abdomen.", false);
					outputText("  Satisfied, your orgasm tapers off into tiny dribbles.  The goblin slips off you, looking a bit bowlegged, but utterly pleased.\n\n", false);
					outputText("She waves, \"<i>Thanks for the spunk hun!  It ", false);
					if (player.cumQ() < 100) outputText("wasn't much, but I'll make do", false);
					else if (player.cumQ() < 250) outputText("should be plenty to make a few new wet-behind-the-ears sluts for you to fuck", false);
					else outputText("was better than I could have dreamed.  I'm going to find you again stud", false);
					outputText("!</i>\"\n\n", false);
					outputText("She giggles again and leans over to kiss you on the lips, smearing her thick bubbly lips across your own and leaving you tasting the bubble-gum of her lipstick.  You find yourself smiling dreamily and slipping into unconsciousness... there must have been something in that lipstick!", false);
					combat.cleanupAfterCombat();
					player.orgasm();
				}
				//[DICK FITS]
				else {
					outputText("The goblin-girl doesn't waste time with any more foreplay, she just arches her back like a cat about to get the cream, and slides her plush ass towards your " + player.cockDescript(0) + " with deliberate slowness.  Her eyes watch you with an intent expression as the slightly parted lips of her sex brush against your ", false);
					if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flare", false);
					else outputText("cock-head", false);
					outputText(", spreading around you ever-so-slowly as she sinks further and further down.  She licks her glossy lips and blows you a kiss as she violently pushes the rest of the way down, impaling herself on every inch of your length.\n\n", false);
					outputText("She arches her back further, proudly displaying the bulge your manhood has made in her tight little tummy.  She coos while fiddling with her clit, \"<i>Mmmm I'm so glad that fit.  The last mate I found was too big to stuff my greedy hole, and that's never as fun.</i>\"  She looks wistful for a moment as her hips begin grinding up and down, \"<i>He did fill me fit to burst though.  Can you do that for me?  Can you fuck me pregnant?</i>\" she asks.\n\n", false);
					outputText("You're too turned on to do anything besides groan and nod, imprisoned by desire and her tight wet pussy.  You can feel it rippling around you, squeezing and milking in rhythmic motions as if it's trying to drain you dry.  Girlish giggles erupt from the goblin when your hips start grinding back against her, bouncing her up and down and making her leather-wrapped tits jiggle for you.  Light reflects off her piercings with hypnotic intensity as they bounce to and fro.\n\n", false);
					outputText("The sultry slut pulls out a flask from somewhere behind her and uncorks it, releasing a puff of red smoke that smells of cherries.\n\n", false);
					outputText("\"<i>Drink your medicine for me stud, I need to make sure you've got a full load for me,</i>\" she orders, stretching to press the flask to your lips.  ", false);
					if (player.cor < 50) outputText("You shake your head, trying to get away from the sweet-smelling drug, but she tilts it up, pouring most of it into your throat.", false);
					else outputText("You lick your lips and open your mouth, happily taking in the cherry-flavored drug.", false);
					outputText("  A sensation of dizziness flows through you, along with relaxing waves of gentle warmth that make it easy to relax and let that cute green whore take your shaft.\n\n", false);
					outputText("She reaches down to ", false);
					if (player.balls > 0) outputText("cup your " + player.ballsDescriptLight() + " in one hand, squeezing gently as the drug begins to affect them", false);
					else outputText("squeeze your taint in her hand, giggling as your prostate suddenly begins to swell from the drug", false);
					outputText(". In no time your crotch is feeling tight and full.  You feel fit to burst, and you're surely dripping pre into the goblin's hungry cunt.  She pats your chest knowingly, rocking back and forth slowly and sighing contentedly.  \"<i>Feel that hun?  That's my special alchemical creation, designed to put your body into an incredibly potent rut.  In a few seconds you'll have too much jizz to hold in, and you'll have to cum for me.  Are you ready baby?  Don't hold back now, my cunt's waiting,</i>\" she coos.\n\n", false);
					outputText("Your dick obeys happily, thickening slightly as your abdominal muscles clench with the force of your orgasm.  The goblin's pupils shrink and her eyes roll back as the first torrent of cum splatters against her cervix.  She quivers when the pressure builds up and begins to fill her womb.  You clench again, this time pressing against her as the drug's effects begin wearing off.  Her belly stretches out slightly from all the cum packed inside her, but you know you aren't done.   She drools, her tongue hanging lewdly from her mouth as you pump load after load into her fertile womb, but like all good things, it does come to an end.\n\n", false);
					outputText("The goblin regains consciousness, and flops off of you, grabbing her belly and smiling blissfully, before staggering up to her feet.  She thanks you, \"<i>Mmmm, good job stud.  I'll have to let my daughters know how to find you once they're born.  I think you've got what it takes for me to start my own tribe!</i>\"  Patting your still-dripping member, the pregnant goblin leans down and gives you a wet kiss with her glossy lips.  You smile contentedly and close your eyes, barely realizing her lipstick was drugged before you pass out.", false);
					player.orgasm();
					combat.cleanupAfterCombat();
				}
				//[END MALE]
			}
			//[FEMALEZ]
			else {
				outputText("The goblin says, \"<i>Baby we're both horny, but fingers and tongues just aren't enough for me. Lucky for you, I've got just the thing.</i>\"\n\n", false);
				outputText("She reaches into a tiny bulging pouch on her hip and pulls out a dildo that flops about in her hand as if was glad to be free.  Slapping you on the cheek and grinning impishly, she offers, \"<i>Why don't we bury one end in each of our cunts?  Just open your mouth and help me get it warmed up for us, OK?</i>\"\n\n", false);
				if (player.cor < 33) outputText("You shake your head violently, clearly indicating 'No', but when you open your mouth to vocalize your complaint, your lips are swiftly plugged with bulging sex-toy.", false);
				else if (player.cor < 66) outputText("You open your mouth to stammer out your concerns, but she plugs the hole with the floppy artificial dong, turning your speech into surprised muffles.", false);
				else outputText("You lick your lips coyly then open your mouth into a welcoming 'O'.  The sex-toy slips straight into the hole, muffling the sounds of your happiness with the arrangement.", false);
				outputText("  It 'plumps' up somehow - perhaps in reaction to your spit - forcing your jaw open and pinning your tongue to the bottom of your mouth.  A trickle of fluid escapes its tip, nearly gagging you before your throat reflexively drinks it down.  What did you just swallow?\n\n", false);
				outputText("\"<i>Yummy yummy isn't it?  I made this myself.  It's made up of the best stuff – it reacts with fluids to puff up and fill ANY hole perfectly.  Even better, it has a reservoir stuffed with aphrodisiacs that'll slowly leak out.  Do you feel warm yet hun?</i>\" she asks.\n\n", false);
				outputText("You sputter a bit when she pulls the thick spit-soaked dong out of your mouth.  The part that was stuffed down your throat is swollen up nearly twice as wide as the half in her hand.  The goblin slurps the other half into her throat, taking at least eight inches into her mouth with no sign of discomfort.  She pulls it out, watching it begin to puff up and blushing, turning her slightly-dimpled cheeks purple.   The dildo slaps your twat cruelly as she drops part of it onto your mons.  With a few expert motions, she shoves it inside you, stuffing you full of artificial cock.  The goblin giggles again and slaps the outer half of the dong, making it flop about and sending vibrations directly to your core.\n\n", false);
				outputText("The green slut stands up and steps over your crotch, positioning herself at a ninety degree angle to you.   The warm wetness of her readiness splashes your thighs when she works the free end of the double-dong into her own aching twat.  She slides down its length, easily taking the remaining length up her juicy cunt.  Your " + player.vaginaDescript(0) + " squelches against hers wetly as they meet in the middle.  The goblin twists, grinding and scissoring her thighs, the hard bud of her clit rubbing back and forth over your " + player.clitDescript() + ".\n\n", false);
				if (player.clitLength >= 7) outputText("Of course, the sheer size of your clit makes it difficult for the goblin to handle in the normal way - it keeps slipping between up her breasts.  The tiny green tart's eyes light up with a devilish idea.  She pulls out a vial of pink slime and dumps it over her breasts, pushing them around your clit and smothering them in slippery flesh.   You cry out in delight, overwhelmed by the feelings radiating from your over-sized pleasure-buzzer as it is mercilessly worked by the tiny woman.\n\n", false);
				outputText("By now your passage feels as stuffed as it ever has been, crammed totally full of the squishy expanded double-dong.  Every motion the tiny slut makes is amplified directly into the fuck-stick plugging your " + player.vaginaDescript(0) + ".  Judging by how wonderful it feels rubbing and twisting against your sensitive walls, the aphrodisiac is definitely having an effect.  You moan and spread your legs wide, giving the tiny dominatrix free reign over your body.  She wiggles against you harder, throwing her head back and running her fingers through her " + monster.hairColor + " hair, shouting out encouragement all the while, \"<i>Mmmm, you like this, don't you slut?  Doesn't my dildo just fill you up perfectly?  Keep wiggling those hips – the aphrodisiac is gravity fed, and with you on the bottom you'll be blissed into unconsciousness soon.  Just don't cum before me hun, I want to feel release with you.</i>\"\n\n", false);
				outputText("You lose yourself to the sweet sensations of the bloated dildo that joins your simmering groins.  Rocking back and forth, scissoring relentlessly against your green mistress, you moan, drowning yourself in a sea of drug-enhanced pleasure. The goblin cries out and thrashes in sudden orgasm, twisting the fat dildo violently around inside your " + player.vaginaDescript(0) + ".   The juices of her orgasm react with the toy, stretching you almost painfully and pushing you past the point of no return.  Your bodies thrash together, wracked by twin orgasms that leave you smeared with a mixture of sweat and girl-cum.\n\n", false);
				outputText("Later, the wet goblin audibly pops off the dildo.  She stumbles, bow-legged, before teasing your " + player.clitDescript() + " and yanking her toy free.  Your lips ", false);
				if (player.vaginas[0].vaginalLooseness <= VAGINA_LOOSENESS_GAPING) outputText("gape apart momentarily", false);
				else outputText("gape wider than ever, but only for a moment", false);
				outputText(".\n\n", false);
				outputText("She plants a kiss on your lips and mutters, \"<i>Can't forget this,</i>\" as she puts her dildo away.  You find yourself smiling and watching her strap-covered form jiggle pleasantly as she bounds away from you into the distance.  Your eyelids drift closed and your lips go numb as her drugged lipstick puts you out.  ", false);
				player.cuntChange(player.vaginalCapacity(), true);
				player.orgasm();
				combat.cleanupAfterCombat();
			}
		}

		//[WIN RAEPZ]
		public function gobboRapeIntro():void
		{
			spriteSelect(24);
			clearOutput();
			//[HP Intro]
			if (monster.HP < 1) outputText("The goblin falls down, smashing her tits flat on the ground and crying softly from the pain.  She looks up at you and sniffles.", false);
			//[Lust Intro]
			else {
				outputText("The goblin groans and drops onto her back.  Her legs spread wide, displaying amazing flexibility as one hand dives into her cunt and the other begins twisting her pierced nipples, one at a time.  The display manages to stir your loins.", false);
				dynStats("lus", 20);
			}
			//If cant rape or breastfeed
			if (player.lust < 30 && player.findStatusEffect(StatusEffects.Feeder) < 0) {
				combat.cleanupAfterCombat();
				return;
			}
			var buttseks:Function =null;
			var feeder:Function =null;
			var fitsFuck:Function =null;
			var tooBig:Function =null;
			var corruptTooBig:Function =null;
			var cuntFuck:Function =null;
			var spiderCondom:Function =null;
			var jog:Function =null;
			var eggs:Function =null;
			if (player.canOvipositSpider()) {
				eggs = laySomeDriderEggsInGobboTwat;
			}
			//cunt stuff
			if (player.hasVagina()) cuntFuck = gobboGetsRapedFem;
			//Dick stuff:
			if (player.hasCock()) {
				//Corrupt too big scene
				if (player.cockArea(player.biggestCockIndex()) > monster.vaginalCapacity() && player.cor > 80 && kGAMECLASS.monk > 2)
					corruptTooBig = rapeAGoblinCorruptTooBig;
				//Regular too big scene
				if (player.cockArea(player.biggestCockIndex()) > monster.vaginalCapacity())
					tooBig = manRapesGoblinTooBig;
				//It fits!
				if (player.cockThatFits(monster.vaginalCapacity()) >= 0) {
					jog = gobboGetsRapedMaleFits;
					fitsFuck = gatsGoblinBoners;
				}
				//Buttsex toggle
				if (player.cockThatFits(monster.analCapacity()) >= 0 && (player.cor > 70 - player.corruptionTolerance() || flags[kFLAGS.MEANINGLESS_CORRUPTION] >= 1)) buttseks = gobboButtSecks;
				//Spidercondom
				if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && player.cockThatFits(monster.vaginalCapacity()) >= 0)
					spiderCondom = goblinCondomed;
			}
			//Breastfeed adds an option
			if (player.findStatusEffect(StatusEffects.Feeder) >= 0) {
				feeder = giveGoblinAMilkMustache;
			}
			if (player.lust >= 33 && player.gender > 0 && (fitsFuck != null || cuntFuck != null || tooBig != null ||
					corruptTooBig != null || buttseks != null || feeder != null || spiderCondom != null || eggs != null) && flags[kFLAGS.SFW_MODE] <= 0) {
				outputText("\n\n<b>What do you do to her, and if anything, which of your body parts do you use?</b>", false);
				choices("Dick Fuck", fitsFuck, "DickTooBig", tooBig, "CorruptDick", corruptTooBig, "Dick In Ass", buttseks, "Jog Fuck", jog, "Breastfeed", feeder, "Web Condom", spiderCondom, "Pussies", cuntFuck, "Lay Eggs", eggs, "Leave", combat.cleanupAfterCombat);
				if (player.hasItem(useables.CONDOM) && player.cockThatFits(monster.vaginalCapacity()) >= 0) {
					addButton(6, "Use Condom", goblinCondomed, 1);
				}
			}
			else if (feeder!=null || eggs!=null) {
				outputText("\n\n<b>You aren't horny enough to rape her, but ");
				if (feeder!=null) outputText("your nipples ache with the desire to feed her your milk.  Do you feed her milk or leave?</b>", false);
				else outputText("your abdomen aches with the desire to impregnate her full of insect eggs.  Do you?</b>");
				simpleChoices("Feed", feeder, "Lay Eggs", eggs, "", null, "", null, "Leave", combat.cleanupAfterCombat);
				//doYesNo(feeder, combat.cleanupAfterCombat);
			}
			else combat.cleanupAfterCombat();
		}
		private function giveGoblinAMilkMustache():void {
			clearOutput();
			outputText("You slowly walk up to the downed goblin, gently telling her that everything will be all right now. She looks at you a bit incredulously and spreads her legs, obviously hoping that you will satisfy the urges that she has. You shake your head at her and instead cup your hands under your " + player.biggestBreastSizeDescript() + " and tell her that it's feeding time. The goblin looks at you annoyed and says, \"<i>I don't want your breasts! I want your naughty bits!</i>\" You laugh at her and grab her arms, pulling them behind her head.\n\n", false);

			outputText("She struggles against your grip, trying to get something, anything inside her needy pussy while yelling \"<i>Come on " + player.mf("slut","stud") + ", you know you want to - mmph!</i>\"  You cut her off by shoving her mouth onto your " + player.nippleDescript(0) + ". She gasps involuntarily, filling her mouth with your milk. In an instant she freezes, then slowly swallows the milk in her mouth. She relaxes in your arms a moment later, gently suckling at your nipple. Her old lust-filled self is gone, replaced with a pliant girl who now wants nothing but your milk. You slowly lower your hand and start rubbing at her still-slick pussy. In response, she puts her hand on your other " + player.nippleDescript(0) + ", playing with it and teasing you.\n\n", false);

			outputText("After a while, you feel the goblin fall asleep in your arms. Even then, she still continues suckling gently on your " + player.nippleDescript(0) + ". You smile, satisfied, and gently lift the goblin off your chest. You pat her shoulder softly, and she stirs awake again. She gives you a bit of a dazed look before you give her a gentle push, and she starts walking away with a vacant, drooling stare.", false);
			//set lust to 0, increase sensitivity slightly
			dynStats("lib", .2, "lus", -50);
			//You've now been milked, reset the timer for that
			player.addStatusValue(StatusEffects.Feeder,1,1);
			player.changeStatusValue(StatusEffects.Feeder,2,0);
			combat.cleanupAfterCombat();
		}
		private function gobboButtSecks():void
		{
			spriteSelect(24);
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = 0;
			clearOutput();
			outputText(images.showImage("goblin-win-male-buttsex"));
			outputText("As usual, you easily defeat another slutty goblin. Was there any doubt you could? Knowing what's about to happen, the goblin braces herself for the inevitable. Her face is flushed from arousal as she licks her lips. To goad you even further, she spreads her legs, revealing more of her sopping cunt.\n\n", false);
			outputText("\"<i>Fuck me, stud!</i>\" she begs. Though defeated, she has to gall to make demands. \"<i>Pump me full of your baby batter!</i>\" Her defeat doesn't seem to do much to silence her tongue.\n\n", false);
			outputText("You're insulted. Who emerged victorious from the prior battle? You could have left her there to wallow in a pool of her own juices if you weren't so damn horny yourself. So what do you do? After some silent pondering, you get a deliciously wicked idea.\n\n", false);
			outputText("After quickly removing your " + player.armorName + ", you tear off what little clothing the green-skinned woman is wearing.  With ease, you lift her off the ground and position her over your " + player.cockDescript(x) + ". The little goblin whore is so enthralled with you that her body quivers from excitement.\n\n", false);
			outputText("With a sneer, you take the crown of your " + player.cockDescript(x) + " and press it not against her drenched pussy lips, but her asshole!\n\n", false);
			outputText("\"<i>Not there!</i>\" she begs, her lips trembling and eyes watering. \"<i>I need your spunk to make my own tribe!</i>\" she explains.\n\n", false);
			outputText("You say nothing to the trembling woman in your grasp. No words could describe the joy you feel from crushing her dreams. By the elders, this world has truly corrupted you, and you love it!\n\n", false);
			outputText("Without any reservations, you slam the goblin whore onto your " + player.cockDescript(x) + ", virtually impaling her! The immediate tightness of her asshole nearly drives you over the edge! The more she squirms, the tighter her ass muscles squeeze you. You stand frozen in ecstasy for a moment, your tongue drooping out of your mouth and eyes rolling into the back of your head.\n\n", false);
			outputText("Protesting, the goblin squirms more, even going as far as to beat her fists into your chest; she's so feeble at the moment that her strikes actually tickle. Her puny assault is enough to knock you out of your carnal daze. You grin manically as you grasp her tiny waist and hammer her! Your " + player.cockDescript(x) + " quickly adjusts to her stretching asshole as you thrust harder and deeper!\n\n", false);
			outputText("\"<i>This isn't what I wanted!</i>\" she cries, \"<i>This isn't what I wanted!</i>\" If your " + player.cockDescript(x) + " expanding her ass wasn't enough, she can feel your ", false);
			if (player.balls > 0) outputText(player.sackDescript(), false);
			else outputText(player.hipDescript(), false);
			outputText(" smacking her plump rump with each thrust, as if to tease her.\n\n", false);
			outputText("The tight confines of the goblin's asshole prove too much for you. Your body convulses wildly as you unload a massive load in her. Spent, you throw the little whore onto the ground; you have no further use for her at the moment.\n\n", false);
			outputText("As you pick up your " + player.armorName + " and begin to get dressed, you glance at the goblin. Her hands began to dig in her now stretched out anus, desperately trying to gather up the cum you deposited in her. Smirking, you walk away nonchalantly, quite pleased with yourself.", false);
			combat.cleanupAfterCombat();
			player.orgasm();
		}

//[FEMSAUCE]
		private function gobboGetsRapedFem():void
		{
			spriteSelect(24);
			clearOutput();
			if (player.isTaur()) {
				outputText(images.showImage("goblin-win-female-taur-rapedfem"));
				outputText("You pick up the goblin, holding her tightly against your side with your arm. You tear a piece of supple leather off of her slutty garments and use it to bind her arms behind her back, just to be sure she can't do anything. She looks up at you, her eyes wide and frightened at the thought of being at the mercy of a much larger creature. In spite of it all, she seems more than a little turned on, if the juices staining your flank are any indication. You look down at her and remark, \"<i>So the little skank has a submissive streak huh?</i>\"\n\n", false);

				outputText("She blushes red and the flow of feminine fluid thickens as she nods. You know she'll probably enjoy whatever sexual act you could perform with her, so you may as well surprise her. A cruel idea forms in the back of your mind – getting revenge for her attempts to drug you. You easily rip the pouches from her belt and pull out a few random bottles. The goblin, understanding your intent, begins struggling to free herself, but you easily restrain the smaller woman and force the drugs into her mouth, one after the another. When she tries to spit them out, you massage her throat, triggering her instinct to swallow.\n\n", false);

				outputText("By the third bottle she's given up on struggling free and is instead attempting to find some part of your body to grind against. Her mouth is open wide and her entire face is flushed reddish-purple with desire. You finish force-feeding her the remaining bottles and release her, catching her ankles just before she hits the ground. The scent of her arousal and the vapors from all the drugs and aphrodisiacs give you a bit of a 'contact high', at least in the sense that your " + player.vaginaDescript(0) + " drips with feminine moisture. Your arousal can wait. This slut needs to be punished.\n\n", false);

				outputText("You flip the creature back into the crux of your arm, this time with her facing the opposite direction. *THWACK!* Your hand smacks her nicely rounded ass. You pull back, feeling drops of wetness thanks to her prominent pussy-lips. The little bitch's cunt is so inflamed with need that she's practically squirting from a simple spank. You swat her again, watching her entire body tense and feeling her fluids splatter you. \"<i>YOU GOT ME WET, YOU CUNT!! BAD BITCH!</i>\" you scold, slapping her even harder.\n\n", false);

				outputText("The goblin squeals, though in delight or pain you can't be sure. You start spanking her harder and harder, turning her ass from green to red with the repeated abuse. Her entire body begins convulsing and squirting, splattering your arm with her honey. She got off on it! Well, after that kind of show, she's going to get you off too - or else!\n\n", false);

				outputText("You drop her for real this time but don't give her the opportunity to stand, roughly shoving your " + player.vaginaDescript(0) + " on top of her. She thrashes against you, too lost to her own pleasure to realize what's going on. Her tiny fists beating weakly against your haunches feels surprisingly good, and you allow it to continue for a while until you've had enough 'foreplay' and start to roughly rub your box against her face, letting her tongue slip into your folds.\n\n", false);

				outputText("You can't see what she's doing but her struggling soon stops as the flavor and scent trigger her to lick. You tremble; it feels WAY better than it should. Perhaps some of her potions have left a residue on her lips and tongue, but you don't care. You put even more of your considerable weight onto the little slut as your hind legs go weak from pleasure. She reacts by sliding her hands up and pounding on your " + player.clitDescript() + ", trying to get you off of her.\n\n", false);

				outputText("Her efforts are rewarded as you cum on the drugged green bitch, leaving the taste of pussy on her tongue. Her face has a strange dopey smile on it, and she looks like she's in some strange state in between consciousness and sleep. You watch as she twitches and writhes on the ground, gasping for air and orgasming repeatedly. While at first you're worried, the convulsions start to slow down; the little twat ought to be fine.\n\n", false);

				outputText("You casually dress, ignoring the pants and moans from the blissed-out goblin, and prepare to leave. Taking one last look over your shoulder, you realize her fluids have made a puddle bigger than her. She'll probably have a hell of a hangover when she wakes up. You sigh and trot off, feeling a bit guilty about overdoing it.", false);
				combat.cleanupAfterCombat();
				player.orgasm();
			}
			//Goblin victory rape, female naga:
			else if (player.isNaga()) {
				outputText(images.showImage("goblin-win-female-naga-rapedfem"));
				outputText("You slither over to the helpless goblin, who watches you half in fear, half in curiosity. ", false);
				//[Has fangs:
				if (player.faceType == FACE_SNAKE_FANGS) outputText("You bare your fangs at her and the curiosity disappears. She turns to run, but your tail is faster than she is.", false);
				//[No fangs: 
				else outputText("You smile at her and the fear disappears. She's still wary though, and you make sure to grab her with your tail before she changes her mind about you.", false);
				outputText("\n\n", false);

				outputText("You wrap yourself tightly around your struggling prey, in the process removing her slutty 'clothes'. The incapacitated goblin whimpers plaintively at you and you respond by giving her cunt a smack with your hand. Pulling your hand away, you're surprised at how wet it is. You wipe it dry on her face and bring your head down to her ear.\n\n", false);

				//[Corrupt characters:
				if (player.cor > 60) {
					outputText("You hiss something incoherent to the terrified woman, who starts to quiver in your grip. Laughing, your fingers slide into her mouth and she begins to suck on them in an attempt to appease you. Her tiny tongue feels wonderful; clearly she's very experienced at this.  ", false);
					outputText("Using your fingers, you spread open her mouth. She's confused but can't resist as you fiddle with something beside you. She realizes what's about to happen too late, as you pull off a number of shiny flasks from her pouches. As punishment for trying to poison you, you start emptying bottle after bottle into her mouth, stroking her throat and forcing her to drink them down.\n\n", false);
				}
				//[Non-corrupt characters:
				else {
					outputText("You ask her if she's sorry for trying to poison you as your fingers slide around her face. She nods vehemently at you, too constricted or afraid to answer. You smile pleasantly at her and feel her body relax a little in your grip.  Your fingers slide into her mouth and she sucks on them eagerly, clearly not wanting to anger you. Her tongue is talented and you enjoy the experience for a little bit until you decide you've toyed with her enough.\n\n", false);

					outputText("Opening your fingers, you open her mouth and prevent it from closing. The confused goblin tries to see what you're doing beside her but can't. When you bring up a handful of shiny flasks from her pouches though, her body tenses again and she whimpers at you.\n\n", false);

					outputText("Your pity for the creature doesn't extend quite far enough to prevent you from punishing her though, and you pick out some of the less potent looking concoctions from the bunch. While stroking her throat gently to make sure she swallows you pour in vial after vial.\n\n", false);
				}
				outputText("The effects don't take long to materialize, and soon the slut is a purplish hue and desperately trying to grind against your coils. She pants and moans in frustration as her dripping cunt can't get enough pleasure from your smooth underbelly, while you wait, enjoying the sensations.\n\n", false);

				outputText("You slide your tail up to her cunt and tweak her clit with the tip. She immediately releases a gush of fluids, thoroughly coating your already slick and sticky coils in more of her cum. You waggle your finger in front of her face to tell her off; you're not done with her yet.\n\n", false);

				outputText("With a smooth motion your tail slides inside her, causing her to moan in pleasure and buck her hips. You squirm about inside, stretching her so wide you suspect she'll be gaping for quite a while. The tip of your tail hits the end of her love canal and you're surprised to find her uterus is pulsating, trying to grip at something that's not there. Curious, you move your tail up to the opening, which grabs you and drags you inside her womb. You smile at the pleasure-overloaded goblin and begin stroking at the walls. She clamps down hard on you and screams out in ecstasy as her eyes roll back into her head.\n\n", false);

				outputText("With no warning you pull out your entire tail, feeling a massive gush of fluids sliding out behind you. The goblin is barely conscious, so you look around inside her pouch for something to help. Nothing seems to look like it would help your cause though, and you're beginning to regret being so vicious, when you notice a particularly tiny flask at the very bottom.\n\n", false);

				outputText("You pull it out and examine it. Not much more than a centimeter long, it's filled with a white fluid. There's a label, but the lettering is far too small to read. You think you can make out the word \"<i>wake</i>\", but aren't entirely sure.\n\n", false);

				outputText("Shrugging, you dump the contents into the goblin's mouth, little more than a drop that's quickly absorbed into her tongue. For a moment nothing happens, then the tiny figure starts to shake violently. Not sure what to do, you simply stay as you are, holding her tight. The shaking stops as suddenly as it started though, and you think you might have killed her.\n\n", false);

				outputText("That's proven very false in a moment though, as her eyes fly open and she yells out \"<i>WHOOOOOO!</i>\". You're startled at the sudden change in demeanor, but decide to roll with it, shoving your " + player.vaginaDescript(0) + " into the evidently very energetic little creature.\n\n", false);

				outputText("You hear a muffled yell of \"<i>YOU GOT IT BOSS!</i>\" as she starts licking and gently chewing at you. The feeling is wonderful and you can't help but wonder what was in the vial, but the thought is wiped from your mind as you cum, spraying all over her.\n\n", false);

				outputText("You orgasm repeatedly, the goblin not tiring and the residue of the various substances you poured into her still coating her lips and tongue, making you not feel like stopping. Eventually you grow tired, releasing the goblin from your coils. She lands on her feet, does a pirouette, runs about the clearing for a bit (all while giggling like a madwoman), then collapses face first onto her 'clothes'.\n\n", false);

				outputText("Thoroughly confused about what just happened, you decide not to test fate by sticking around near the heavily drugged creature and make for camp as soon as you've grabbed your things.", false);
				combat.cleanupAfterCombat();
				player.orgasm();
			}
			else {
				outputText(images.showImage("goblin-win-female-rapedfem"));
				outputText("You pick up the goblin, sitting her onto your knee and restraining both her arms behind her back with your left hand.  You tear a piece of supple leather off of her slutty garments and use it to bind her arms there.  She looks up at you, her eyes wide and frightened at the thought of being at the mercy of a larger creature.  In spite of it all, she seems more than a little turned on, if the juices staining your knee are any indication.  You look down at her and remark, \"<i>So the little skank has a submissive streak huh?</i>\"\n\n", false);
				outputText("She blushes red and the flow of feminine fluid thickens as she nods.  You know she'll probably enjoy whatever sexual act you could perform with her, so you may as well surprise her.  A cruel idea forms in the back of your mind – getting revenge for her attempts to drug you.  You easily rip the pouches from her belt and pull out a few random bottles.  The goblin, understanding your intent, begins struggling to free herself, but you easily restrain the smaller woman and force the drugs into her mouth, one after the another.  When she tries to spit them out, you massage her throat, triggering her instinct to swallow.\n\n", false);
				outputText("By the third bottle she's given up on struggling and is instead trying to grind her cunt into your knee.  Her mouth is open wide and her entire face is flushed reddish-purple with desire.  You finish force-feeding her the remaining bottles and shove her, catching her ankles to hold her over your leg with her ass in the air.  The scent of her arousal and the vapors from all the drugs and aphrodisiacs give you a bit of a 'contact high', at least in the sense that your " + player.vaginaDescript(0) + " ", false);
				if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) outputText("grows puffy and moist", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_DROOLING) outputText("drips with feminine moisture", false);
				else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("slowly begins to soak your thighs", false);
				else outputText("drools with need, puddling under you", false);
				outputText(".  Your arousal can wait.  This slut needs to be punished.\n\n", false);
				outputText("*<b>THWACK</b>!* Your hand smacks her nicely rounded ass.  You pull back, feeling drops of wetness thanks to her prominent pussy-lips.  The little bitch's cunt is so inflamed with need that she's practically squirting from a simple spank.  You swat her again, watching her entire body tense and feeling her fluids splatter you.\n\n", false);
				outputText("\"<i>YOU GOT ME WET, YOU CUNT!!  BAD BITCH!</i>\" you scold, slapping her even harder.\n\n", false);
				outputText("The goblin squeals, though in delight or pain you can't be sure.  You start spanking her harder and harder, turning her ass from green to red with the repeated abuse.  Her entire body begins convulsing and squirting, splattering your arm with her honey.  She got off on it!  Well, after that kind of show, she's going to get you off too - or else!\n\n", false);
				outputText("You pull her off your leg and shove her face into your " + player.vaginaDescript(0) + ".  She thrashes against you, too lost to her own pleasure to realize what's going on.   Forcefully you put her plump little lips on your box and grind, letting her tongue slip into your folds.  Her eyes are little white slits, her pupils rolled up out of view, but there's enough of something in there that her tongue recognizes the taste and starts licking.  You tremble; it feels WAY better than it should.  Perhaps some of her potions have left a residue on her lips and tongue, but you don't care.\n\n", false);
				outputText("You cum on the drugged green bitch, ", false);
				if (player.vaginas[0].vaginalWetness > VAGINA_WETNESS_DROOLING) outputText("splattering her with your fluids", false);
				else if (player.vaginas[0].vaginalWetness > VAGINA_WETNESS_SLICK) outputText("coating her face with the proof of your pleasure", false);
				else if (player.vaginas[0].vaginalWetness > VAGINA_WETNESS_WET) outputText("leaving her sticky with your nether-juices", false);
				else outputText("leaving the taste of pussy on her tongue", false);
				outputText(".  ", false);
				if (player.biggestLactation() >= 3.5) outputText("Milk explodes from your nipples, soaking the petite slut.  ", false);
				else if (player.biggestLactation() > 2) outputText("Twin streams of milk soak the slut's hair, running down her face like white tears.  ", false);
				else if (player.biggestLactation() >= 1) outputText("Milk dribbles from your nipples, falling into the little slut's hair.  ", false);
				outputText("Her face has a strange dopey smile on it, and she looks like she's in some strange state in between consciousness and sleep.  You grab her by the hair and toss her on the ground, watching her body twitch and jump as her orgasm continues to rack her body.  It looks like it's starting to slow down, the little twat ought to be fine.\n\n", false);
				outputText("You casually dress, ignoring the pants and moans from the blissed-out goblin, and prepare to leave.   Taking one last look over your shoulder, you realize her fluids have made a puddle bigger than her.  She'll probably have a hell of a hangover when she wakes up.  You ", false);
				if (player.cor > 50) outputText("smirk", false);
				else outputText("sigh", false);
				outputText(" and saunter off, feeling ", false);
				if (player.cor < 50) outputText("a bit guilty about overdoing it.", false);
				else outputText("thoroughly satisfied with your revenge.", false);
				combat.cleanupAfterCombat();
				player.orgasm();
			}
		}

//Corrupt too big fuck
		private function rapeAGoblinCorruptTooBig():void
		{
			var x:Number = player.biggestCockIndex();
			clearOutput();
			spriteSelect(24);
			outputText(images.showImage("goblin-win-male-corruptedfuck"));
			outputText("You begin to remove your " + player.armorName + ", looking down on your helpless would-be-attacker and soon-to-be victim while licking your lips hungrily. Your " + player.multiCockDescriptLight(), false);
			if (player.cockTotal() == 1) outputText(" is", false);
			else outputText(" are all", false);
			outputText(" far more aware of the situation than she is as you stoop down and strip her of every scrap of her admittedly sparse clothing. While you look her over, ", false);
			if (player.cockTotal() > 1) outputText("one of your " + player.multiCockDescriptLight() + " comes to rest on top of her and the fact that it's ", false);
			else outputText("your " + player.cockDescript(x) + " comes to rest on top of her and the fact that it's ", false);
			if (player.cocks[0].cockLength < 20) outputText("about as long as her entire torso", false);
			else outputText("bigger than she is", false);
			outputText(" gives you a wicked idea.\n\n", false);

			outputText("You have a seat, legs wide, on the ground and hold the little goblin whore with her relatively tiny slit resting at the tip of your " + player.cockDescript(x) + ". Finally out of her stupor a look of extreme conflict crosses her face as her need for cock and cum goes to war with her survival instincts. On the brink of defeat, those instinct suddenly regroup and beat back her lust once she feels the pain of just the " + player.cockHead(x) + " of your " + player.cockDescript(x) + " starting to stretch out her " + monster.vaginaDescript() + ". She does all she can to resist, but with the way you're holding this is little more than flailing wildly and pushing against your " + player.cockDescript(x) + " with her feet, practically climbing it like the tree trunk it must look like from her perspective.\n\n", false);
			outputText("Both of you dripping with sweat from your respective exertions, you slowly begin to realize the combination of her furious struggling and the tightness of her " + monster.vaginaDescript() + " is going to keep you from the penetration you were so looking forward to. However, as you begin to consider finishing off in her throat, a darkness stirs and another idea crosses your mind.\n\n", false);
			outputText("The goblin relaxes a little when she feels you no longer pressing her down onto your " + player.cockDescript(x) + ". She absolutely thrills when you bring her tiny pussy to your lips and begin to have at it. Your tongue plays around both on the inside and outside of her " + monster.vaginaDescript() + " until you coax her little nub out from hiding. You wrap your lips around it and begin putting your corruption to task. As you drive the goblin slut closer and closer to orgasm, working over her clit with an expertise rarely found outside of the infernal ranks, bolts of corrupt energies travel from your tongue, through her clit, and deep into her core. As she cums, screaming, you pull off of her, admiring the outward signs of your demonic handiwork. What before was an average sized love button has swollen five times its size into a proud, engorged clit... and that's not the only thing you enlarged.\n\n", false);

			outputText("You reposition your fucktoy so that now she's facing away from you and again bring your " + player.cockDescript(x) + " into contact with her " + monster.vaginaDescript() + ". Again she struggles, but after her orgasm she doesn't have the strength to put up a decent fight; all her resistance does is arouse you further, now that she's fighting the inevitable. You begin to press her down onto yourself.\n\n", false);

			outputText("\"<i>Too much...</i>\" she says, weakly. The tip of the head pops in.\n\n", false);
			outputText("\"<i>You'll kill me...</i>\" she pleads. The rest of the head follows.\n\n", false);
			outputText("\"<i>Stop...</i>\" she begs. The shaft starts to sink in.\n\n", false);
			outputText("\"<i>Don't...</i>\" More enters her small body.\n\n", false);
			outputText("\"<i>Please...</i>\" She fills to capacity.\n\n", false);
			outputText("\"<i>Please...</i>\" And beyond.\n\n", false);
			outputText("\"<i>... Fuck me.</i>\"\n\n", false);
			outputText("You ram home the rest of your " + player.cockDescript(x) + " left outside of your newly christened dick jockey. It's enough to orgasm the bitch, and you haven't even gotten started. You ", false);
			if (player.cocks[0].cockLength < 20) outputText("can feel the massive bulge in her midsection", false);
			else outputText("stretch her so much that you can see the bulge even from this angle", false);
			outputText(" and it drives your lust even higher. You withdraw more cock from the hole than your cum starved slut has body, causing her eyes to roll into the back of her head as her " + monster.vaginaDescript() + " clamps down on you and she cums again. Every time you pull out or hammer home brings her off to the point that by the time you've both gotten down on all fours, rutting like a pair of wild animals, she can only lie there, practically foaming at the wide open mouth", false);
			if (player.biggestTitSize() >= 1) {
				outputText(", her head resting between your " + player.breastDescript(0), false);
				if (player.biggestLactation() >= 1) {
					outputText(" as your " + player.nippleDescript(0) + " ", false);
					if (player.biggestLactation() < 2) outputText("occasionally drip milky tears onto her face", false);
					if (player.biggestLactation() < 3) outputText("weep streams of milk onto her features", false);
					else outputText("plaster her with gouts of fluid", false);
				}
			}
			outputText(". Her hair is matted with", false);
			if (player.biggestLactation() >= 1) outputText(" milk and", false);
			outputText(" the sweat of the both of you, and the only sound she makes is an occasional gurgle of ecstasy every few orgasms.\n\n", false);
			outputText("\"<i>Alright, whore. You wanted my babies? Here. They. CUM!</i>\" you yell. However, ", false);
			if (player.hasVagina()) {
				outputText("while your " + player.vaginaDescript(0) + " ", false);
				if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_SLICK) outputText("juices ", false);
				else if (player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_DROOLING) outputText("floods ", false);
				else outputText("explodes ", false);
				if (player.cockTotal() > 1) outputText("and the rest of your " + player.multiCockDescriptLight() + " drench her, ", false);
			}
			else if (player.cockTotal() > 1) {
				outputText("while your other " + Appearance.cockNoun(CockTypesEnum.HUMAN), false);
				if (player.cockTotal() > 2) outputText(" drench her, ", false);
				else outputText(" drenches her, ", false);
			}
			outputText("the bitch is too tight! Like a natural cock-ring! ", false);
			if (player.balls >= 2) outputText("Your " + player.ballsDescriptLight() + " are trying but, h", false);
			else outputText("H", false);
			outputText("er spasming " + monster.vaginaDescript() + " is clamping down so hard on your " + player.cockDescript(x) + " that it can't release.\n\n", false);
			outputText("The moment passes and you're left unsatisfied.  This only serves to piss you off as your cum receptacle fails in its one duty. You, however, are undaunted. In fact you redouble your efforts. If this size queen slut wants to deny you your pay off while getting off herself, well, you'll just have to cum her into oblivion the next go-round.\n\n", false);
			outputText("For what seems like hours you almost literally screw the brains out of her little green head, working yourself back up to the brink. You consider pulling out this time, but decide against it. At least two loads worth at once; it'll work, and the bitch has it coming.\n\n", false);
			outputText("\"<i>Let's. Try. This. AGAIN!</i>\" you shout, pulling the two of you back into a sitting position and arching both of your backs.\n\n", false);
			outputText("Your " + player.cockDescript(x) + " is pressed so firmly against her skin that you can see the cum working its way up and out of your shaft and bloating your goblin toy with only the first shot. ", false);
			if (player.cockTotal() > 2) outputText("Your remaining " + player.multiCockDescriptLight() + " blast geysers into the air, coating you both in your spunk. ", false);
			if (player.cockTotal() == 2) outputText("Your remaining penis blasts geysers into the air, coating you both with spunk. ", false);
			outputText("The same tightness that prevented your cumming the first time now ensures that none of the copious amount of seed you blast into her escapes until you pull out. It's a good thing your corruption was so effective, as she is beginning to look pregnant enough to hold a beach ball.\n\n", false);
			outputText("Finally you blow your last wad into this latest piece of ass, shoving her off of your " + player.cockDescript(x) + " and letting her fall to the ground. The impact sends torrents of cum sluicing out of her.\n\n", false);
			outputText("You stand and prepare to leave, looking down at the goblin slut you just finished with.\n\n", false);
			outputText("\"<i>I hope my daughters are a better fuck than their bitch mother,</i>\" you say. \"<i>Tell'em to find me if they want to get split like a log too.</i>\"", false);
			outputText("\n\nShe absolutely will.", false);
			player.orgasm();
			dynStats("cor", 1);
			combat.cleanupAfterCombat();
		}

//(TOO BIG – pin the bitch to the ground with your cock, coat it in her potions, and make her lick it clean, then blow your load in her mouth, possible cum inflation.)
		private function manRapesGoblinTooBig():void
		{
			clearOutput();
			outputText(images.showImage("goblin-win-male-corruptedbj"));
			var x:Number = player.biggestCockIndex();
			spriteSelect(24);
			outputText("You whip out your stiffening maleness, revealing its ", false);
			if (player.cockArea(x) < 80) outputText("nearly ", false);
			outputText(" absurd size to your victim.  The goblin-girl's eyes grow to the size of dinner plates in shock as she takes in the view.   Knowing you'll try regardless of the size-mismatch, she spreads her legs and settles herself more comfortably on the ground.\n\n", false);
			outputText("You ", false);
			if (player.cor < 50) outputText("shrug and guess you may as well try since she's ready", false);
			else outputText("grin, happy to try and stretch her around yourself", false);
			outputText(".  The ", false);
			if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flare", false);
			else outputText("head", false);
			outputText(" of your " + player.cockDescript(x) + " visibly pulses in excitement as you brush it against her already-slick folds.  She squirms under you, clearly enjoying the feeling of you pushing against her opening.  With painful slowness, you begin pushing forward, feeling her body stretch around your ", false);
			if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flare", false);
			else outputText("crown", false);
			outputText(", but after a moment or two of progress the tiny passage will stretch no more, and you're sure you can't force any more in without hurting her.\n\n", false);
			outputText("Disgruntled with the tease, you pull out and slide it onto her torso, pinning her underneath your " + player.cockDescript(x) + " and smearing her face and body with her juices.  Her tits squish down enough that her erect little purple nipples barely poke out on each side.  The little slut looks relieved and more than a little turned on.  She licks her lips and speaks happily, \"<i>Thanks hun, I think you would have torn me in half!  Don't worry, I'm more than happy to get soaked with your cum,</i>\" as she wraps her arms and legs around you", false);
			if (player.hasKnot(0)) outputText(" hooking the heels of her feet just behind your knot", false);
			outputText(".\n\n", false);
			outputText("\"<i>She's good at this,</i>\" you muse as she begins grinding underneath you, using her legs to piston her entire body up and down your length, her arms and hands rubbing and caressing you with surprising passion.  The feeling is intense – these goblins know how to please a ", false);
			if (player.gender == 3) outputText("herm", false);
			else outputText("man", false);
			outputText(", that's for sure!  You start dripping with excitement, soaking the goblin's face with an errant drop.  Her smile only broadens when she blinks it away.   A trail of warm wetness licks its way up your tip as the goblin greedily begins to devour your pre, going so far as to lick it from your urethra.  Your " + player.hipDescript() + " twitch, lifting her off the ground as she clings to your member.\n\n", false);
			outputText("You'd never think such an act would be so enjoyable, but it's just too good.  You lose control, blasting a load of hot seed over the goblin's face.  She sputters and tries to wipe the spunk from her eyes when your next blast hits her square in the forehead, unbalancing the sprightly woman.   She thumps down hard on the ground after losing her grip on your spasming " + player.cockDescript(x) + ".  You step back, dick bobbling in the air as your orgasm finishes, ", false);
			if (player.cumQ() < 75) outputText("splattering her a few more times with potent seed.  ", false);
			else if (player.cumQ() < 250) outputText("painting her with a thick layer of seed.  ", false);
			else outputText("soaking her and leaving her in a thick puddle of seed. ", false);
			outputText("The green slut seems to handle it pretty well, even going so far as to scoop up your spunk and rub it into her cunt as she masturbates.  She licks her lips as she watches you redress, a sultry smile on her cum-painted face, \"<i>You tasted as good as I thought stud!  Maybe shrink that bad-boy down and come visit me for a better visit next time ok?  Hopefully by then all this baby batter I'm cramming into my box will give me a nice belly for you to rub!</i>\"\n\n", false);
			outputText("You shake your head and leave, somewhat drained and relieved by the experience.", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}

//[DUDEGASM]
		private function gobboGetsRapedMaleFits():void
		{
			spriteSelect(24);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.biggestCockIndex();
			clearOutput();
			outputText(images.showImage("goblin-win-male-getridden"));
			//(FITS( barley) – Get ridden)
			if (player.cockArea(x) > monster.vaginalCapacity() * .8) {
				outputText("You pick up the defeated goblin, looking her over. She crosses her arms across her chest pitifully and asks, \"<i>What now?</i>\" with her eyes darting down when she thinks you won't notice. A grimace temporarily crossing her face at the size of your " + player.cockDescript(x) + ". You get the idea of giving her more cock than she can handle, and lower her down towards your " + player.cockDescript(x) + ". The tip slips between her moist and folds, stretching her and taking some of her weight off your arms. She winces slightly, wrapping her legs as far around your " + player.hipDescript() + " as possible.\n\n", false);
				outputText("You start walking, letting your movements work with gravity, allowing you to penetrate her with little difficulty. Those puffy wet walls clench you tightly as she slides down, ", false);
				if (player.cocks[0].cockType == CockTypesEnum.DEMON) outputText("rubbing painfully against your demonic nubs", false);
				else if (player.hasKnot(0)) outputText("stretching painfully around your knot", false);
				else if (player.cocks[0].cockType == CockTypesEnum.HORSE || player.cocks[0].cockType.Index > 3) outputText("feeling painfully tight around you", false);
				outputText(". With each and every step she slides down further, stretching her to capacity, until she sits almost completely impaled on you, grabbing your ", false);
				if (player.biggestTitSize() >= 1) outputText(player.allBreastsDescript(), false);
				else outputText("torso", false);
				outputText(" to help support herself.  A steady pulse of motion massages you in time with the green girl's breathing.  You realize just how much of her body must be devoted to accommodating monstrous members, no wonder goblins are so fragile in a fight!\n\n", false);
				outputText("She pants happily, her tongue rolling free from her mouth as she comments, \"<i>So full. . .</i>\"  Still wincing from the monster inside her she begins to cheer you on, \"<i>oooh go-ah-faster! I wanna bounce!</i>\"\n\n", false);
				outputText("It's all the encouragement you need, and you break into a run, feeling her lithe form bounce on your " + player.cockDescript(x) + ", drawing out a cacophony of cries ranging from happy wails and moans to slight yelps of pain. Her tiny fists dig into your ", false);
				if (player.biggestTitSize() >= 1) outputText("tits", false);
				else outputText("skin", false);
				outputText(" as she hangs on, clenching and smashing her ample tits against you. You run hard, feeling her bounce and wriggle as her cunt and rapid breathing squeezing and milking you like you never before. You're sure if you could feel like this every time you took a jog, you'd be in great shape.\n\n", false);
				outputText("\"<i>Ooh fuck stud, bounce me! Yeah just like that,</i>\" she moans, \"<i>Are you gonna cum? Omigod please cum, I need you to fill me up just like this!</i>\"\n\n", false);
				outputText("The familiar tightness of a coming orgasm grows in your groin, tightening as you near release. You pick up the pace, full out sprinting, letting the girl bounce and jiggle as she clings to you, supported entirely by your " + player.cockDescript(x) + ". ", false);
				if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " tighten, releasing the seed of your orgasm.  ", false);
				outputText("The howl of a powerful orgasm fills your ears as your cumming sets off the little green cock-sleeve. One of her hands lets go, and starts rubbing her belly while she kisses and licks your belly-button.", false);
				if (player.cumQ() >= 100) outputText("  Your enhanced body easily stuffs her full of cream, pudging her belly out slightly, your seed staying embedded in her womb with nowhere to escape, her cunt plugged tightly with your " + player.cockDescript(x) + ".", false);
				if (player.cumQ() >= 500) outputText("  The orgasm is so potent that by the time you wind down, she looks to be sporting a pregnancy the size of a medicine ball.  Your cum is trapped inside her, unable to find any gap between her walls and your " + player.cockDescript(x) + ".", false);
				else if (player.cumQ() >= 250) outputText("  The orgasm is so potent that by the time you wind down, she looks heavily pregnant.  Your cum is unable to find any gap between her walls and your " + player.cockDescript(x) + ".", false);
				outputText("\n\n", false);
				outputText("You pant and stop, pulling the stuffed goblin off you and setting her on the ground, smiling in satisfaction as your cum ", false);
				if (player.cumQ() >= 250) outputText("pours out in a river", false);
				else outputText("leaks", false);
				outputText(" from her now-gaping twat. She rubs her belly and blows you a kiss, still trying to catch her breath. You smirk and begin redressing. Once finished, you start walking away, but she calls out one last time to you, \"<i>MMMmm I hope you don't mind if I find you again. I need more of your baby batter so I can give you lots of beautiful sluts to fuck!</i>\"\n\n", false);
				if (player.cor > 50) outputText("Chuckling", false);
				else outputText("Shuddering", false);
				outputText(", you make your way back to camp, satisfied.", false);
			}
			//(FITS – Get ridden)
			else {
				outputText("You pick up the defeated goblin, looking her over.  She crosses her arms across her chest pitifully and asks, \"<i>What now?</i>\" with her eyes darting down when she thinks you won't notice.  You muse to yourself 'great minds think alike' and lower her down towards your " + player.cockDescript(x) + ".  The tip slips between her moist and parted folds, brushing against her entrance and taking some of her weight for you.  She goes cross-eyed and smiles happily, wrapping her legs as far around your " + player.hipDescript() + " as possible.\n\n", false);
				outputText("You start walking, letting the movements work with gravity to allow you to effortlessly penetrate her.  Those puffy wet walls clench you tightly as she slides down ", false);
				if (player.cocks[0].cockType == CockTypesEnum.DEMON) outputText("rubbing perfectly against your demonic nubs", false);
				else if (player.hasKnot(0)) outputText("stretching tightly around your knot", false);
				else if (player.cocks[0].cockType == CockTypesEnum.HORSE || player.cocks[0].cockType.Index > 3) outputText("feeling absolutely perfect around you", false);
				outputText(".  With each and every step you take, she slides down further, until she sits fully impaled on you, grabbing your ", false);
				if (player.biggestTitSize() >= 1) outputText(player.allBreastsDescript(), false);
				else outputText("torso", false);
				outputText(" to help support herself.   A steady pulse of motion massages you in time with the green girl's breathing, making you realize just how much of her body must be devoted to accommodating monstrous members.\n\n", false);
				outputText("She pants happily, her tongue rolling free from her mouth as she cheers you on, \"<i>oooh go-ah-faster!  I wanna bounce!</i>\"\n\n", false);
				outputText("It's all the encouragement you need, and you break into a run, feeling her lithe form bounce on your " + player.cockDescript(x) + ", drawing out a cacophony of happy wails and moans.  Her tiny fists dig into your ", false);
				if (player.biggestTitSize() >= 1) outputText("tits", false);
				else outputText("skin", false);
				outputText(" as she hangs on, clenching and smashing her ample tits against you.  You run hard, feeling her bounce and wriggle as her cunt and rapid breathing begin squeezing and milking you like never before.  You're sure if you could feel like this every time you took a jog, you'd be in great shape.\n\n", false);
				outputText("\"<i>Ooh fuck stud, bounce me! Yeah just like that,</i>\" she moans, \"<i>Are you gonna cum? Omigod please cum, I need you to fill me like this!</i>\"\n\n", false);
				outputText("The familiar tightness of a coming orgasm grows in your groin, tightening as you near release.  You pick the pace, full out sprinting, letting the girl bounce and jiggle as she clings to you, supported entirely by your " + player.cockDescript(x) + ".  ", false);
				if (player.balls > 0) outputText("Your " + player.ballsDescriptLight() + " tighten, releasing the seed of your orgasm.  ", false);
				outputText("The howl of a powerful orgasm fills your ears as your cumming sets off the little green cock-sleeve.  One of her hands lets go, and starts rubbing her belly while she kisses and licks your belly-button.", false);
				if (player.cumQ() >= 250) {
					outputText("  Your enhanced body easily stuffs her full of cream, pudging her belly out slightly and dripping down your ", false);
					if (player.balls > 0) outputText(player.ballsDescriptLight(), false);
					else outputText("legs", false);
					outputText(".", false);
				}
				if (player.cumQ() >= 500) outputText("  The orgasm is so potent that by the time you wind down, she looks heavily pregnant and your cum squirts out of any gap it can find between her walls and your " + player.cockDescript(x) + ".", false);
				outputText("\n\n", false);
				outputText("You pant and stop, pulling the stuffed goblin off you and setting her on the ground, smiling in satisfaction as your cum ", false);
				if (player.cumQ() >= 250) outputText("pours out in a river", false);
				else outputText("leaks", false);
				outputText(" from her now-gaping twat.  She rubs her belly and blows you a kiss, still trying to catch her breath.  You smirk and begin redressing.  Once finished, you start walking away, but she calls out one last time to you, \"<i>Ummm I hope you don't mind if I find you again.  I need more of your baby batter so I can give you lots of beautiful sluts to fuck!</i>\"\n\n", false);
				if (player.cor > 50) outputText("Chuckling", false);
				else outputText("Shuddering", false);
				outputText(", you make your way back to camp, satisfied.", false);
			}
			combat.cleanupAfterCombat();
			player.orgasm();
		}


//Spider goblin condom
		private function goblinCondomed(mode:Number = 0):void
		{
			spriteSelect(24);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			clearOutput();
			outputText(images.showImage("goblin-win-male-goblincondomed"));
			outputText("Defeated, the goblin girl's knees give out and she sinks backward, lying on her back with her emerald ankles suspended above her head. \"Use me,\" she begs, \"humiliate, degrade, and debase me! Just, whatever you do, fill me!\" As you strip off your " + player.armorName + ", she spreads her legs as wide as she can, the wanton girl presenting her drooling pussy to you, puffy green lips already dripping with beads of anxious sweat and eager lubrication. She wiggles in the dirt, gripping her plump rear with both hands and lifting her ass into the air for you, hopefully. You can practically feel the heat pouring off the small slut's cum-hungry cunt, her breeding-fever leaving her eyes glassy and unfocused. Standing over her, it's clear that the only things she's even aware of are the pulsing pussy between her legs and your burgeoning erection.\n\n", false);

			outputText("Impatiently, she thrusts her legs out and hooks her toes around your lower body, trying to pull you closer while still keeping her needy hole accessible. Her olive feet clench around your flesh, her soles firm and muscular on your " + player.skinFurScales() + " as she slides up and down the outsides of your " + player.hipDescript() + ". Dragging her heels across your thighs, the goblin pushes her feet together on either side of your " + player.cockDescript(x) + ", the balls of her jade skin pressing against ", false);
			if (player.balls > 0) outputText("your throbbing sack", false);
			else outputText("the base of your shaft", false);
			outputText(" while her digits curl around your member like thick fingers. Stroking you slowly at first, the lime-hued girl picks up her tempo and alternates to the soft embrace of the silken skin between her instep and her calf, using the firmness of her ankles to massage your dick to full-mast. Quivering between her feet, blobs of pre-cum begin to leak from your tip, nearly transparent globules rolling down your glans. The goblin uses her big toes to gather up the warm fluid reverently, letting it flow between each digit gleefully before spreading it back onto your shaft with firm caresses, kneading the seedless ejaculate into your flesh like oil, her feet glistening like sea-green beryl with your fluid.\n\n", false);

			outputText("By now, a widening lake of over-stimulated honey has pooled under the lascivious girl. Moaning lewdly, her fingers still digging into her ass cheeks, you realize the goblin is cumming just from giving you a footjob. She needs your dick so badly that it's almost pathetic and a wicked idea crosses your mind.  Taking hold of her pre-cum slick feet, you run your fingers along her ejaculate-softened skin, tickling and rubbing her soles until the girl squeals in ecstasy, clenching her eyes shut as her panting desire becomes too much for her to keep her hands away from her cunt any longer. With a warm splash of overflowing honey, she digs the fingers of her right hand into her verdant slit, her left hand rubbing her jade clit in widening circles so quickly the vibrations jiggle her butt in the mud she's made of the forest floor. While she's distracted, ");
			if (mode == 0) { //Web condom (spinnerets)
				outputText("you work your spinnerets, the delicate organ weaving a long, thin sheath of finely meshed spider silk, taking care to leave the sticky strands between the inert layers of the flexible condom. Sliding it over your " + player.cockDescript(x) + ", you marvel at how light it is! You can even feel the wind's breeze through the silken covering.");
			}
			else { //Latex condom (item)
				player.destroyItems(useables.CONDOM, 1);
				outputText("you tear open the packet and slide the latex condom over your " + player.cockDescript(x) + ", marveling at how transparent and shiny it is. You don't think the goblin will be able to notice that until it's too late!", false);
			}
			outputText(" Time to give the goblin what she asked for, if not what she wanted.\n\n", false);

			outputText("Still holding her wriggling feet, you bend down and pull her legs apart as far as you can, muscles stretching almost wider and wider as her inner thighs clench against the tugging. The added pressure along with her own frantic jilling crests the girl into another orgasm, this time her gushing lube squirting upwards in crystal streams of depraved lust that patter against your abdomen warmly. Her arms fall at her sides, palms up and fingers twitching, clearing the path for your " + player.cockDescript(x) + " to the quivering green pussy she has so kindly prepared for you. Pushing against her engorged lips, you find she's so wet that you practically slip right in, her climax-racked muscles spasming irregularly as you fill her with your stiff manhood. \"Oh yesss, you finally found your cock\" she pants, drool bubbling in her mouth. \"Pump me like you hate me, you fucker\" she demands and you haul her upward by the ankles, pulling her further onto your pulsing dick, her dribbling cunny sucking at your shaft as her deep green inner folds part before your thrusting length. \"I'm not a glass doll, you pussy, just fucking jam it in!\" she screams, fingers clawing at the ground as she bucks upward to get more of you inside her.\n\n", false);

			outputText("The mouthy bitch apparently forgot who lost the fight, it seems, so you decide to remind her. Using her legs like a lever, you twist her around on your dick, spinning her 180 degrees, leaving her lying on her tits, her ass jutting up as you slam your cock the rest of the way into the olive-skinned nympho. She grunts and starts to say something else, but you push forward and grind her face into the mud before she can get it out, her mouth filling with her own lubrication-soaked dirt with an ecstatic gurgle. Her legs fight against your grip, jerking this way and that, her slick feet nearly slipping out of your hands. You grit your teeth and begin screwing her slavering twat as hard as you can, eager to tame the thrashing cunt of a girl. Slamming her sweat-soaked thighs against your " + player.hipDescript() + ", your thrusts become almost savage, bringing a deep flush to her backside as you slap her snatch against your groin, the secret condom working perfectly, as thin as skin on your " + player.cockDescript(x) + ".\n\n", false);

			outputText("As you feel the tickling heat of your orgasm worming its way into your veins, you lean down, putting your weight into every uterus-filling movement while the goblin sputters and screeches her approval, toes curling in your hands. You release her legs to grab the goblin slut's thin waist with both hands and slam against her jutting ass one last time before liquid heat pours from your " + player.cockDescript(x) + " in thick streams of potent seed. At the cresting grunt, she wraps her legs around your " + player.buttDescript() + ", locking her ankles and using her sore legs to pull your gushing prick as deeply into her fertile loins as possible and keep you there. Rocking against her, you rub her head and breasts through the mud one last time as your loads fill her tummy with the ejaculate she so craved, her narrow belly bulging at the weight of your jizz. You take a moment longer to enjoy the clenching, pulsing depths of the cum dumpster before sliding out an inch and taking hold of the ");
			if (mode == 0) {
				outputText("loose strand you left in your secret cock-shawl. Pulling carefully, you unravel the delicate outer layer, leaving only the sticky strands covering the inner, juice-filled sheath. With a short bark of laughter, you pull out of the whorish girl, the spider silk condom sealing as your tip slides out. ");
			}
			else {
				outputText("rim of your latex cock-sheath. Pulling carefully, you slowly remove your used condom and tie the open end shut. You look at it and you can see your cum inside the condom. ");
			}
			outputText("Then, wresting her feet apart, you unceremoniously dump her to the ground.\n\n", false);

			outputText("Squirming right-side up, covered in sweat and mud, the emerald girl's face screws into an expression of confusion as she pokes at the bulge of her abdomen. \"What... that doesn't feel right,\" she mumbles, pushing at her skin with both hands. Checking her cunny with a long, middle finger, she pulls it out clean, devoid of the ivory cream she expected. \"The fuck? A condom?\" she screeches. \"You bastard!\" Pushing at her belly with increasingly frantic motions, her mouth gapes when the seed-loaded balloon bounces right back, still intact. \"Why won't it burst?\" she demands. ");
			if (mode == 0) {
				outputText("You politely inform her that spider silk is terribly strong and oh so sticky. Reaching her fingers into her slit, she tries to pull it out and gasps at the feeling of her inner walls being pulled by the clinging webbing. Despite her best effort, the silk bubble stays right where you left it, snugly glued in place by your binding webbing. You laugh and wish her luck trying to get it out as you gather your clothes and walk away. So full of cum and yet unable to get any of it into her womb, the goblin girl moans helplessly, fingering herself in desperation, as if her orgasm could dislodge the treasure you've left inside of her.", false);
			}
			else {
				outputText("You politely inform her that latex is strong and effective at preventing pregnancy. You laugh and wish her luck trying to get it out as you gather your clothes and walk away. So full of cum and yet unable to get any of it into her womb, the goblin girl moans helplessly, fingering herself in desperation, as if her orgasm could dislodge the treasure you've left inside of her.", false);				
			}
			player.orgasm();
			combat.cleanupAfterCombat();
		}

//REQUIRES: AT LEAST ONE DICK AND A COPY OF ATLAS SHRUGGED - MUST NOT BE MONSTROUSLY HUGE
		private function gatsGoblinBoners():void
		{
			clearOutput();
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = player.smallestCockIndex();
			outputText(images.showImage("goblin-win-male-goblinboners"));
			outputText("The goblin lies strewn across the ground upon her stomach, exhausted from the battle. Her plump legs are unintentionally spread open while her ass pokes up into the air, giving you a clear view of her wet pussy as she tries to get herself off.  It seems as if the green-skinned slut has already forgotten about you - too many fruitless encounters might've caused her to give up hope on finding a virile specimen to pump her full of cum.\n\n", false);

			outputText("Luckily for her, you have every intention of changing that.\n\n", false);

			outputText("You begin to fondle your cock", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(" as you walk towards the unsuspecting goblin girl, taking in the sight of her perfectly round cheeks as they jiggle against her hurried movements, her soft thighs clenched against the eager hand between them.  Bending down, you quickly grab the goblin's ample hips, causing the girl to squeak in surprise as she turns around to catch the sight of your erect length", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(".\n\n", false);

			outputText("\"<i>W-woah!  Hey stud, whaddya think you're doing back there?</i>\" she yelps, more surprised than scared at your sudden appearance.  Instead of answering, you decide to grab your cock", false);
			if (player.cockTotal() > 1) outputText("s", false);
			outputText(" and slap ", false);
			if (player.cockTotal() == 1) outputText("it", false);
			else outputText("them", false);
			outputText(" against the bare flesh of her ass, whilst your victim anxiously awaits your next move.  You take your time massaging the goblin's slutty ass with your bare hands before sliding your " + player.cockDescript(x) + " in between her soft cheeks.  Your horny victim appears impatient, attempting to grind against you as she spreads her moist lips open, enthusiastic that she's found someone willing to mate with her.  You slap her ass firmly as you quicken your thrusting - seconds before finally plunging ", false);
			if (player.cockTotal() == 1) outputText("your dick inside of the panting whore, pushing her forwards violently as you enter her tight snatch", false);
			else if (player.cockTotal() == 2) outputText("both of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole", false);
			else {
				outputText("two of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole - your other cock", false);
				if (player.cockTotal() >= 4) outputText("s", false);
				outputText(" remaining sandwiched in between her asscheeks", false);
			}
			outputText(".\n\n", false);

			outputText("You roughly pound against the goblin girl, maintaining a firm grip on her hips while she squeals with delight.  The sound of your groin slapping against her echoes throughout the area, followed by your grunting and the goblin's moans of ecstasy.  Your victim struggles to lift herself up by her arms, only to collapse back down from the feeling of you invading her insides.\n\n", false);

			outputText("Eventually you begin to feel yourself coming to a climax, your movements getting faster and faster as you build up to your release.  The goblin below you has already lost herself to the pleasure of your " + player.cockDescript(x) + ", her eyes rolled upwards and her tongue drooling out of her mouth while her slutty face rubs against the ground you're currently pounding her on.  With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance", false);
			if (player.cockTotal() == 2) outputText("s", false);
			outputText(".  You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed.\n\n", false);

			outputText("You pick yourself back up, jerking yourself slowly as cum dribbles from your " + player.cockDescript(x) + " onto the collapsed body of the goblin.  It'll be awhile before she comes back to consciousness, but you're certain she'll have a better appreciation for sex when she does.", false);
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		private function laySomeDriderEggsInGobboTwat():void
		{
			clearOutput();
			outputText(images.showImage("goblin-win-drider-egged"));
			//Play standard goblin victory text
			outputText("The pitiful struggling of the little green-skinned creature as she tries to scramble away from you gives you a rather generous view of her drooling box.  While you feel yourself ");
			if (player.hasCock()) outputText("harden");
			else if (player.hasVagina()) outputText("moisten");
			else outputText("twitch");
			outputText(" slightly,  you can't help but register the growing weight of your spider half.  Looking down at the goblin again, you decide that maybe you can both get something... <i>similar</i> to what you want.");

			outputText("\n\nYou quickly undress and skitter over to the sniffling slut, reaching down to pull her up and turning her to face you as you do.  Looping one arm under her armpits, you prod at her soft stomach with your free hand, inquiring about the state of her children.");

			//[if (femininity > 50)
			if (player.femininity > 50) outputText("\n\n\"<i>W-what?  You- I haven't got any, you stupid bitch!  This your idea of fun, jackass?  Kicking people when they're down?!</i>\"");
			//[if (femininity < 51) 
			else outputText("\n\n\"<i>W-what?  You- I haven't got any, you stupid bastard!  This your idea of fun, jackass?  Kicking people when they're down?!</i>\"");
			outputText("  She lashes out with her feet, but there's no strength behind it, and her pout deepens as tears begin to gather at the corners of her eyes.");

			outputText("\n\n\"<i>Lemme go, lemme go!</i>\"  She squirms around, and you slip your other hand under her arm to help restrain her.  You hold her out further from you as you begin to curl your spider abdomen underneath yourself.  Already, you can see your egg-chute poking free of your carapace, twitching in time with your heartbeat, drooling green lube all over your undercarriage.");

			outputText("\n\nYour goblin plaything has fallen silent, staring at the thickening rod between your many legs.");

			outputText("\n\n\"<i>What?  What is that?  What's it for?</i>\"  Her nervous tone does nothing to conceal the interest sliding down her thighs.  You pull her closer, holding her just above your ovipositor, and kiss her on her forehead, promising her all the children she could ever dream of.  Her conflicted smile and heavy panting makes your heart beat just a little faster, and any reply is cut off as you impale the purpled-haired woman on your slippery shaft.");

			outputText("\n\nStifled gasps and grunts escape her lips as you work her up and down like a living sex toy, stuffing as much of yourself into as you can.  A deep blush spreads across your goblin whore's face; one of her hands twists and pulls at her nipple as she bites down on her lip while her free hand massages excitedly at the bulge you make with every thrust.  Your carapace is slick with a mixture of her juices and the slow leak of your arachnid egg lube.");

			outputText("\n\nYou finally bottom out, working the green cum-sleeve all the way down as you feel your thickness brush against her cervix.  You slide your hands out from under her arms and reposition them on her shoulders, pinning her in place for what's about to come.  Her stomach pushes out slightly when the first wave of lube forces its way inside her and she gasps in bliss, rubbing her hands across her 'pregnancy'.  Your own smile grows wider as you feel your bottom half clench and shiver, as the first of many eggs forces its way up your ovipositor.");

			outputText("\n\nYou feel its slow path up into the goblin, your egg-tube flaring out around it, until it stops just short of her womb's entrance.  She looks up from her stomach, her wide-eyed stare meeting yours for only a second before a powerful spasm forces the egg past her clenched cervix.  The miniature whore convulses, her eyes rolling back, tongue lolling as she cums hard, a torrent of girlcum spraying across your chitin.");
			if (player.hasCock()) {
				outputText("  Your own orgasm is just as strong, [eachCock] spraying powerfully across your torso");
				if (player.hasVagina()) outputText("and y");
			}
			else if (player.hasVagina()) outputText("  Y");
			if (player.hasVagina()) outputText("our [vagina] clenching in time with hers as your copious fluids drench your spider half.");

			outputText("\n\nThen the next egg rolls forward, and the next, and the next...");

			outputText("\n\nYou keep her pinned against your body as you fill her up, one orb at a time, each sphere bloating her stretched stomach a little further, until she's so full you can feel your eggs through the taut skin of her belly.  The goblin is nearly unconscious, insensibly gurgling as the pleasure of her instant pregnancy numbs her mind.  You pull her off with a loud wet plop, her twitching snatch leaking an unending stream of her own clear fluids as well as a sticky string of your green egg-mucus.");

			outputText("\n\nLaying her down in the shade, you put your clothes back on, glad to be free of the extra weight and ready to continue your adventure.");
			player.dumpEggs();
			player.orgasm();
			combat.cleanupAfterCombat();
		}
	}
}
