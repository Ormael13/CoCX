/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Monsters
{
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.UniqueSexScenes;

import coc.xxc.BoundStory;
import coc.xxc.Story;

public class GoblinScene extends BaseContent
	{
		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		public function GoblinScene()
		{
			onGameInit(init);
		}
		private var story:BoundStory;
		private function init():void {
            story = new Story("story", CoC.instance.rootStory.locate("monsters"), "goblin").bind(CoC.instance.context);
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
					outputText("The goblin saunters up to you, wiggling her hips with a needy, sexual sway. She opens a small pouch, the sight of which instantly bombards your easy mind with thoughts of your lower lips being opened similarly, and pulls out a tube of lipstick, pausing to apply it to her lips. She caps off the tube and blows you a kiss with a wet smacking sound as she steps up to your trembling form. Your breath is knocked from your body as she drops all her weight onto your middle, making her ass and well-rounded tits jiggle just like yours do when you are bouncing on a cock. She reaches up to twist her nipple-studs, grinding the wetness of her crotch up and down your belly. You can't help but envy her piercings. Like, they totally turn you on!\n\n");
					outputText("Your body is already hot and your " + nippleDescript(0) + "s harden involuntarily in response to the tiny slut's totally understandable display of desire. Your " + vaginaDescript(0) + " leaks enough girl-juice to form a puddle beneath you, doing its best to show your fellow slut how ready you are. You 'subtly' (at least in your little mind) push your chest forward, making your " + nippleDescript(0) + "s easy targets for the goblin. She grabs hold of your breasts");
					//--[If nipplecunts]
					if (player.hasFuckableNipples()) outputText(", fingering your wet nipplecunts and pinching the now-puffy areolas tightly, sending uncontrollable waves of pleasure from your chest to your groin.");
					//-[If not]
					else outputText(" and slides her fingers up to your nipples, pinching and twisting them, torturing you with pain and pleasure.");
					outputText("\n\n");

					outputText("The goblin, almost drooling, says \"<i>Baby, we're both horny, but fingers and tongues just aren't enough for me. Lucky for you, I've got just the thing.</i>\"\n\n");

					outputText("For a moment, your dumb, bimbo mind struggles to think of whatever she could, like, mean by that. Oh well, you giggle airheadedly and just let it happen.\n\n");

					outputText("The goblin reaches into another one of her pouches and pulls out a dildo that flops about in her hand as if it were glad to be free of the pouch. Slapping you on the cheek and grinning mischeviously, she offers, \"<i>Why don't we bury one end in each of our cunts? Just open your mouth and help me get it warmed up for us, okay?</i>\"\n\n");

					outputText("For a moment, you blink dumbly, trying to think why for, like, one tiny second you wanted to say 'no', but then you forget about it, let the horniness flow, and naturally pop your mouth open into a perfect-lip lined 'O', shooting her a involuntarily slutty look.\n\n");

					outputText("She instantly plugs your sex-doll-like mouth with the bulging dildo.  It plumps up somehow, forcing your jaw open and pinning your tongue to the bottom of your mouth – this is like, so much easier than having to hold it open yourself. A trickle of fluid escapes its tip. You swallow it reflexively – oh wait, was that like cum or like what? Your little brain is confused for a moment, at least 'til the smarter slut explains it to you.\n\n");

					outputText("\"<i>Yummy isn't it? I made this myself. It's made of the best stuff – it reacts with fluids to puff up and fill ANY hole perfectly. Which, by the looks of you, will probably be helpful.  You look like you've taken a few in your day.</i>\" She winks, \"<i>Oh, and even better... it has a little tube inside full of aphrodisiacs that'll slowly leak out into your wet body!</i>\"\n\n");

					outputText("Saliva coats your lips and dribbles down onto your boobs when the goblin pulls the thick, soaked dong out of your mouth. The part that was stuffed down your throat is swollen up to nearly twice as wide as the half still in her hand. The goblin quickly corrects that, slurping the second half down into her throat, taking at least eight inches into her mouth with no sign of gagging. She's like, totally good at this! She pulls it out, watching it puff up. She blushes, turning her slightly-dimpled, green cheeks a shade of purple. The dildo slaps your twat cruelly as she drops part of it onto your mons. With a few practiced motions, she shoves it inside you, stuffing you full of artificial cock, bringing your mind back to all the times you'd fucked yourself just like this. Your easy, wandering mind is brought back to the present by a small slap on the dildo, which sends vibrations right into your " + vaginaDescript(0) + ".\n\n");

					outputText("Your green slut counterpart stands up and steps over your crotch, positioning herself perpendicular to you. The warm wetness of her dripping cunt splashes your thighs when she works the free end of the double-dong into her own slick twat. Your pussy squelches against hers wetly as they meet in the middle, your [clit] pressed on by her nether lips. The goblin twists, grinding and scissoring her thighs, the hard bud of her clit rubbing against your [clit] again and again.\n\n");

					outputText("By now your passage feels, like, more stuffed than ever! Every motion the tiny slut makes is amplified directly into the fuck-stick plugging your drooling pussy. Judging by how wonderful it feels rubbing and twisting against your well-experienced vaginal walls, the aphrodisiac is definitely working. You moan and spread your legs wide, giving the tiny dominatrix free reign over your body in its natural position – open and ready.\n\n");

					outputText("She wiggles against you harder, throwing her head back and running her fingers through her purple hair, shouting out encouragement all the while, \"<i>Mmm, you like this, don't you slut? My dildo fits your slutty cunt well, doesn't it? I bet that's rare. Keep wiggling those hips – the aphrodisiac is gravity fed, and with you on the bottom you'll be blissed into unconsciousness soon. Just don't cum before me hun, I want to feel release WITH you.</i>\"\n\n");

					outputText("It isn't hard these days, but you lose yourself in the sweet sensations of the bloated dildo that joins your simmering groins, pleasure whisking away whatever little intelligence you have left. Rocking back and forth, scissoring relentlessly against your green mistress, you moan, drowning yourself in a sea of drug-enhanced pleasure. The goblin cries out and thrashes in sudden orgasm, twisting the fat dildo violently around inside your slut-hole. The juices of her orgasm react with the toy, stretching you to a perfect level of vaginal gape – it's sooooo rare to, like, find someone who can stretch you out! Your bodies thrash together, wracked by twin orgasms that leave you smeared with a mixture of sweat and girl-cum.\n\n");

					outputText("Later, the wet goblin audibly pops off the dildo. She stumbles, bow-legged, before teasing your bimbo-clit and yanking her toy free of your needy pussy. Your lips gape wider than ever, but you've gotten used to your pussy getting stretched by now...");
					player.cuntChange(player.vaginalCapacity(), true, true, false);
					outputText("\n\n");

					outputText("She plants a kiss on your lips and mutters, \"<i>Can't forget this,</i>\" as she puts her dildo away. You find yourself smiling and watching her strap-covered form jiggle pleasantly as she bounds away from you into the distance. Your eyelids drift closed and your lips go numb as her drugged lipstick begins to put you out.\n\n");

					outputText("Your eyes roll up into your head, leaving you looking dumber than ever. Damn, like, that was, like, totally fucking amazing!");
					player.orgasm();
					cleanupAfterCombat();
					return;
				}
			}
			outputText("The goblin saunters up to you, wiggling her hips with a needy, sexual sway.  She opens a small pouch and pulls out a tube of lipstick, pausing to apply it to her lips.  She caps off the tube and blows you a kiss with a wet smacking sound as she steps up to your ");
			if (player.HP < 1) outputText("defeated");
			else outputText("trembling");
			outputText(" form.  Your breath is knocked from your body as she drops all her weight onto your middle, making her ass and well-rounded tits jiggle enticingly.   She reaches up to twist her nipple-studs, grinding the sopping wetness of her crotch up and down your belly.\n\n");
			outputText("Your body grows hot, responding to the tiny fetish-slut's outrageous display of desire.  ");
			if (player.cockTotal() > 0) {
				outputText(images.showImage("goblin-loss-male-raped"));
				outputText("The warmth spreads, growing larger ");
				if (player.cocks[0].cockLength <= 7) outputText("as your bulge begins to press between her soft ass-cheeks");
				else if (player.cocks[0].cockLength <= 14) outputText("as your bulge grows upwards between her ass-cheeks and lays against the small of her back");
				else outputText("as your bulge grows up her back and creeps towards her shoulders steadily");
				outputText(".  ");
			}
			if (player.hasVagina()) {
				outputText(images.showImage("goblin-loss-female-raped"));
				if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_NORMAL) outputText("The lips of your sex engorge, becoming almost as puffy as the goblin's.  ");
				else if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_DROOLING) outputText("Feminine lubricant soaks into the back of your [armor].  ");
				else outputText("It rapidly forms into a puddle as your " + vaginaDescript(0) + " does its best to show just how ready you are.  ");
			}
			outputText("Your " + nippleDescript(0) + "s poke upwards, giving the goblin easy targets.  She grabs hold of them ");
			if (player.hasFuckableNipples()) outputText("slipping her thumbs inside the tender cunts and pinching against them tightly");
			else outputText("twisting and tweaking");
			outputText(", torturing you with pain and pleasure.\n\n");
			//[DICK VERSION]
			if (player.cockTotal() > 0 && (!player.hasVagina() || rand(2) == 0)) {
				//[TOO BIG]
				if (player.cockArea(0) > monster.vaginalCapacity()) {
					outputText("She lifts her body up high, grabbing your [cock] with both her petite hands.  Your mind somehow makes note of the shiny black of her fingernails as she struggles to part her dripping wet womanhood around your massive member.  Though her body stretches to an absurd degree, she just can't get you inside. She pouts and drops your tool back onto you, promising you, \"<i>I'll find a way to get every ounce of your cum inside me, don't you worry.</i>\"\n\n");
					outputText("The little slut jumps back onto you, wrapping her arms and legs tightly around your member.  Her tongue slithers over ");
					if (player.balls > 0) outputText("your " + ballsDescriptLight());
					else outputText("the base of your " + cockDescript(0));
					outputText(" before she buries it deep into your " + player.assholeOrPussy() + ".  Her thighs, breasts, and body surround you with a shroud of warm green flesh that wriggles and twists around you with feverish lust.  The lips of her still-partially stretched cunt do their best to devour your member's head when the flexible little minx curves her hips back down to grind on it.\n\n");
					outputText("The lewd little creature body-fucking your titanic tool is just so passionate and sensual that you can't hold the budding pressure in your loins.  You're sure you must be leaking pre-cum, but the squishing wet cunt wrapped around your cock-tip has you so slathered in fuck-juice you'd never be able to tell.  You tremble, struggling to hold back and ");
					if (player.cor > 50) outputText("prolong your pleasure");
					else outputText("prevent the monstrous girl from getting what she wants");
					outputText(".  The goblin looks back over her shoulder, narrows her eyes, and pulls back to say, \"<i>Don't even think about holding back stud.</i>\"\n\n");
					outputText("She works her fingers into the void her tongue left behind, ");
					if (player.hasVagina()) outputText("caressing your " + clitDescript());
					else outputText("pressing tightly against your prostate");
					outputText(" as she whispers, \"<i>Go ahead, make my twat a swollen cum-dump.  I NEED you to FILL me with ALL of your cream.  Stuff me full of your fuck-juice and I promise I'll give you a dozen slutty daughters to fill with jizz every night.</i>\"\n\n");
					outputText("Her fingers and words have the desired effect, drawing out a tremendously pleasurable orgasm.  Your hips rock and buck against her lithe body, forcing her to cling on to your spasming form as globules of cum force their way up your massive urethra.  You can feel them explode into the tiny girl's sopping tunnel, immediately soaking into her womb.");
					if (player.cumQ() > 100) outputText("  Your loads keep coming, until the jism begins to backwash out of her love tunnel to soak her body and your midsection.");
					if (player.cumQ() >= 250) outputText("  Her belly distorts visibly as her uterus is packed full of cum, making her look heavily pregnant already.  She coos in delight at the sight of her swollen abdomen.");
					outputText("  Satisfied, your orgasm tapers off into tiny dribbles.  The goblin slips off you, looking a bit bowlegged, but utterly pleased.\n\n");
					outputText("She waves, \"<i>Thanks for the spunk hun!  It ");
					if (player.cumQ() < 100) outputText("wasn't much, but I'll make do");
					else if (player.cumQ() < 250) outputText("should be plenty to make a few new wet-behind-the-ears sluts for you to fuck");
					else outputText("was better than I could have dreamed.  I'm going to find you again stud");
					outputText("!</i>\"\n\n");
					outputText("She giggles again and leans over to kiss you on the lips, smearing her thick bubbly lips across your own and leaving you tasting the bubble-gum of her lipstick.  You find yourself smiling dreamily and slipping into unconsciousness... there must have been something in that lipstick!");
					cleanupAfterCombat();
					player.orgasm();
				}
				//[DICK FITS]
				else {
					outputText("The goblin-girl doesn't waste time with any more foreplay, she just arches her back like a cat about to get the cream, and slides her plush ass towards your [cock] with deliberate slowness.  Her eyes watch you with an intent expression as the slightly parted lips of her sex brush against your ");
					if (player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("flare");
					else outputText("cock-head");
					outputText(", spreading around you ever-so-slowly as she sinks further and further down.  She licks her glossy lips and blows you a kiss as she violently pushes the rest of the way down, impaling herself on every inch of your length.\n\n");
					outputText("She arches her back further, proudly displaying the bulge your manhood has made in her tight little tummy.  She coos while fiddling with her clit, \"<i>Mmmm I'm so glad that fit.  The last mate I found was too big to stuff my greedy hole, and that's never as fun.</i>\"  She looks wistful for a moment as her hips begin grinding up and down, \"<i>He did fill me fit to burst though.  Can you do that for me?  Can you fuck me pregnant?</i>\" she asks.\n\n");
					outputText("You're too turned on to do anything besides groan and nod, imprisoned by desire and her tight wet pussy.  You can feel it rippling around you, squeezing and milking in rhythmic motions as if it's trying to drain you dry.  Girlish giggles erupt from the goblin when your hips start grinding back against her, bouncing her up and down and making her leather-wrapped tits jiggle for you.  Light reflects off her piercings with hypnotic intensity as they bounce to and fro.\n\n");
					outputText("The sultry slut pulls out a flask from somewhere behind her and uncorks it, releasing a puff of red smoke that smells of cherries.\n\n");
					outputText("\"<i>Drink your medicine for me stud, I need to make sure you've got a full load for me,</i>\" she orders, stretching to press the flask to your lips.  ");
					if (player.cor < 50) outputText("You shake your head, trying to get away from the sweet-smelling drug, but she tilts it up, pouring most of it into your throat.");
					else outputText("You lick your lips and open your mouth, happily taking in the cherry-flavored drug.");
					outputText("  A sensation of dizziness flows through you, along with relaxing waves of gentle warmth that make it easy to relax and let that cute green whore take your shaft.\n\n");
					outputText("She reaches down to ");
					if (player.balls > 0) outputText("cup your [balls] in one hand, squeezing gently as the drug begins to affect them");
					else outputText("squeeze your taint in her hand, giggling as your prostate suddenly begins to swell from the drug");
					outputText(". In no time your crotch is feeling tight and full.  You feel fit to burst, and you're surely dripping pre into the goblin's hungry cunt.  She pats your chest knowingly, rocking back and forth slowly and sighing contentedly.  \"<i>Feel that hun?  That's my special alchemical creation, designed to put your body into an incredibly potent rut.  In a few seconds you'll have too much jizz to hold in, and you'll have to cum for me.  Are you ready baby?  Don't hold back now, my cunt's waiting,</i>\" she coos.\n\n");
					outputText("Your dick obeys happily, thickening slightly as your abdominal muscles clench with the force of your orgasm.  The goblin's pupils shrink and her eyes roll back as the first torrent of cum splatters against her cervix.  She quivers when the pressure builds up and begins to fill her womb.  You clench again, this time pressing against her as the drug's effects begin wearing off.  Her belly stretches out slightly from all the cum packed inside her, but you know you aren't done.   She drools, her tongue hanging lewdly from her mouth as you pump load after load into her fertile womb, but like all good things, it does come to an end.\n\n");
					outputText("The goblin regains consciousness, and flops off of you, grabbing her belly and smiling blissfully, before staggering up to her feet.  She thanks you, \"<i>Mmmm, good job stud.  I'll have to let my daughters know how to find you once they're born.  I think you've got what it takes for me to start my own tribe!</i>\"  Patting your still-dripping member, the pregnant goblin leans down and gives you a wet kiss with her glossy lips.  You smile contentedly and close your eyes, barely realizing her lipstick was drugged before you pass out.");
					player.orgasm();
					cleanupAfterCombat();
				}
				//[END MALE]
			}
			//[FEMALEZ]
			else {
				outputText("The goblin says, \"<i>Baby we're both horny, but fingers and tongues just aren't enough for me. Lucky for you, I've got just the thing.</i>\"\n\n");
				outputText("She reaches into a tiny bulging pouch on her hip and pulls out a dildo that flops about in her hand as if was glad to be free.  Slapping you on the cheek and grinning impishly, she offers, \"<i>Why don't we bury one end in each of our cunts?  Just open your mouth and help me get it warmed up for us, OK?</i>\"\n\n");
				if (player.cor < 33) outputText("You shake your head violently, clearly indicating 'No', but when you open your mouth to vocalize your complaint, your lips are swiftly plugged with bulging sex-toy.");
				else if (player.cor < 66) outputText("You open your mouth to stammer out your concerns, but she plugs the hole with the floppy artificial dong, turning your speech into surprised muffles.");
				else outputText("You lick your lips coyly then open your mouth into a welcoming 'O'.  The sex-toy slips straight into the hole, muffling the sounds of your happiness with the arrangement.");
				outputText("  It 'plumps' up somehow - perhaps in reaction to your spit - forcing your jaw open and pinning your tongue to the bottom of your mouth.  A trickle of fluid escapes its tip, nearly gagging you before your throat reflexively drinks it down.  What did you just swallow?\n\n");
				outputText("\"<i>Yummy yummy isn't it?  I made this myself.  It's made up of the best stuff – it reacts with fluids to puff up and fill ANY hole perfectly.  Even better, it has a reservoir stuffed with aphrodisiacs that'll slowly leak out.  Do you feel warm yet hun?</i>\" she asks.\n\n");
				outputText("You sputter a bit when she pulls the thick spit-soaked dong out of your mouth.  The part that was stuffed down your throat is swollen up nearly twice as wide as the half in her hand.  The goblin slurps the other half into her throat, taking at least eight inches into her mouth with no sign of discomfort.  She pulls it out, watching it begin to puff up and blushing, turning her slightly-dimpled cheeks purple.   The dildo slaps your twat cruelly as she drops part of it onto your mons.  With a few expert motions, she shoves it inside you, stuffing you full of artificial cock.  The goblin giggles again and slaps the outer half of the dong, making it flop about and sending vibrations directly to your core.\n\n");
				outputText("The green slut stands up and steps over your crotch, positioning herself at a ninety degree angle to you.   The warm wetness of her readiness splashes your thighs when she works the free end of the double-dong into her own aching twat.  She slides down its length, easily taking the remaining length up her juicy cunt.  Your " + vaginaDescript(0) + " squelches against hers wetly as they meet in the middle.  The goblin twists, grinding and scissoring her thighs, the hard bud of her clit rubbing back and forth over your [clit].\n\n");
				if (player.clitLength >= 7) outputText("Of course, the sheer size of your clit makes it difficult for the goblin to handle in the normal way - it keeps slipping between up her breasts.  The tiny green tart's eyes light up with a devilish idea.  She pulls out a vial of pink slime and dumps it over her breasts, pushing them around your clit and smothering them in slippery flesh.   You cry out in delight, overwhelmed by the feelings radiating from your over-sized pleasure-buzzer as it is mercilessly worked by the tiny woman.\n\n");
				outputText("By now your passage feels as stuffed as it ever has been, crammed totally full of the squishy expanded double-dong.  Every motion the tiny slut makes is amplified directly into the fuck-stick plugging your " + vaginaDescript(0) + ".  Judging by how wonderful it feels rubbing and twisting against your sensitive walls, the aphrodisiac is definitely having an effect.  You moan and spread your legs wide, giving the tiny dominatrix free reign over your body.  She wiggles against you harder, throwing her head back and running her fingers through her " + monster.hairColor + " hair, shouting out encouragement all the while, \"<i>Mmmm, you like this, don't you slut?  Doesn't my dildo just fill you up perfectly?  Keep wiggling those hips – the aphrodisiac is gravity fed, and with you on the bottom you'll be blissed into unconsciousness soon.  Just don't cum before me hun, I want to feel release with you.</i>\"\n\n");
				outputText("You lose yourself to the sweet sensations of the bloated dildo that joins your simmering groins.  Rocking back and forth, scissoring relentlessly against your green mistress, you moan, drowning yourself in a sea of drug-enhanced pleasure. The goblin cries out and thrashes in sudden orgasm, twisting the fat dildo violently around inside your " + vaginaDescript(0) + ".   The juices of her orgasm react with the toy, stretching you almost painfully and pushing you past the point of no return.  Your bodies thrash together, wracked by twin orgasms that leave you smeared with a mixture of sweat and girl-cum.\n\n");
				outputText("Later, the wet goblin audibly pops off the dildo.  She stumbles, bow-legged, before teasing your [clit] and yanking her toy free.  Your lips ");
				if (player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING) outputText("gape apart momentarily");
				else outputText("gape wider than ever, but only for a moment");
				outputText(".\n\n");
				outputText("She plants a kiss on your lips and mutters, \"<i>Can't forget this,</i>\" as she puts her dildo away.  You find yourself smiling and watching her strap-covered form jiggle pleasantly as she bounds away from you into the distance.  Your eyelids drift closed and your lips go numb as her drugged lipstick puts you out.  ");
				player.cuntChange(player.vaginalCapacity(), true);
				player.orgasm();
				cleanupAfterCombat();
			}
		}

		//[WIN RAEPZ]
		public function gobboRapeIntro():void
		{
			spriteSelect(24);
			clearOutput();
			story.display("strings/defeated/intro");
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
				if (player.cockArea(player.biggestCockIndex()) > monster.vaginalCapacity() && player.cor > 80 && JojoScene.monk > 2)
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
				if (player.tailType == Tail.SPIDER_ADBOMEN && player.cockThatFits(monster.vaginalCapacity()) >= 0)
					spiderCondom = goblinCondomed;
			}
			//Breastfeed adds an option
			if (player.hasStatusEffect(StatusEffects.Feeder)) {
				feeder = giveGoblinAMilkMustache;
			}
			if (player.lust >= 33 && player.gender > 0 && (fitsFuck != null || cuntFuck != null || tooBig != null ||
					corruptTooBig != null || buttseks != null || feeder != null || spiderCondom != null || eggs != null) && flags[kFLAGS.SFW_MODE] <= 0) {
				story.display("strings/defeated/prompt-sex");
				menu();
				if (fitsFuck != null) addButton(0, "Dick Fuck", fitsFuck);
				if (tooBig != null) addButton(1, "DickTooBig", tooBig);
				if (corruptTooBig != null) addButton(2, "CorruptDick", corruptTooBig);
				if (buttseks != null) addButton(3, "Dick In Ass", buttseks);
				if (jog != null) addButton(4, "Jog Fuck", jog);
				if (player.hasStatusEffect(StatusEffects.Feeder)) addButton(5, "Breastfeed", feeder);
				if ((player.tailType == Tail.SPIDER_ADBOMEN || player.hasItem(useables.CONDOM)) && player.cockThatFits(monster.vaginalCapacity()) >= 0) {
					if (player.tailType == Tail.SPIDER_ADBOMEN) addButton(6, "Web Condom", goblinCondomed, 0);
					if (player.hasItem(useables.CONDOM)) addButton(11, "Use Condom", goblinCondomed, 1);
				}
				if (player.hasVagina()) addButton(7, "Pussies", cuntFuck);
				if (player.canOvipositSpider()) addButton(8, "Lay Eggs", eggs);
				addButton(10, "Kill", killGoblin);
				addButton(14, "Leave", cleanupAfterCombat);
			}
			else if (feeder!=null || eggs!=null) {
				if (feeder!=null) story.display("strings/defeated/prompt-feed");
				else story.display("strings/defeated/prompt-eggs");
				menu();
				if (player.hasStatusEffect(StatusEffects.Feeder)) addButton(5, "Breastfeed", feeder);
				if (player.canOvipositSpider()) addButton(8, "Lay Eggs", eggs);
				addButton(10, "Kill", killGoblin);
				if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
				addButton(14, "Leave", cleanupAfterCombat);
			}
			else {
				//If cant rape or breastfeed
				cleanupAfterCombat();
			}
		}
		private function giveGoblinAMilkMustache():void {
			clearOutput();
			story.display("strings/Breastfeed");
			//You've now been milked, reset the timer for that
			player.addStatusValue(StatusEffects.Feeder,1,1);
			player.changeStatusValue(StatusEffects.Feeder,2,0);
			cleanupAfterCombat();
		}
		private function gobboButtSecks():void
		{
			spriteSelect(24);
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = 0;
			clearOutput();
			outputText(images.showImage("goblin-win-male-buttsex"));
			story.display("strings/RapeAnal",{$x:x});
			cleanupAfterCombat();
			player.orgasm();
		}

//[FEMSAUCE]
		private function gobboGetsRapedFem():void
		{
			spriteSelect(24);
			clearOutput();
			if (player.isTaur()) {
				outputText(images.showImage("goblin-win-female-taur-rapedfem"));
				story.display("strings/RapeFemTaur");
				cleanupAfterCombat();
				player.orgasm();
			}
			//Goblin victory rape, female naga:
			else if (player.isNaga()) {
				outputText(images.showImage("goblin-win-female-naga-rapedfem"));
				story.display("strings/RapeFemNaga");
				cleanupAfterCombat();
				player.orgasm();
			}
			else {
				outputText(images.showImage("goblin-win-female-rapedfem"));
				story.display("strings/RapeFem");
				cleanupAfterCombat();
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
			story.display("strings/CorruptDick");
			player.orgasm();
			dynStats("cor", 1);
			cleanupAfterCombat();
		}

//(TOO BIG – pin the bitch to the ground with your cock, coat it in her potions, and make her lick it clean, then blow your load in her mouth, possible cum inflation.)
		private function manRapesGoblinTooBig():void
		{
			clearOutput();
			spriteSelect(24);
			outputText(images.showImage("goblin-win-male-corruptedbj"));
			story.display("strings/DickTooBig");
			player.orgasm();
			cleanupAfterCombat();
		}

//[DUDEGASM]
		private function gobboGetsRapedMaleFits():void
		{
			spriteSelect(24);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.biggestCockIndex();
			clearOutput();
			outputText(images.showImage("goblin-win-male-getridden"));
			story.display("strings/RapeJog");
			cleanupAfterCombat();
			player.orgasm();
		}


//Spider goblin condom
		private function goblinCondomed(mode:Number = 0):void
		{
			spriteSelect(24);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			clearOutput();
			outputText(images.showImage("goblin-win-male-goblincondomed"));
			outputText("Defeated, the goblin girl's knees give out and she sinks backward, lying on her back with her emerald ankles suspended above her head. \"Use me,\" she begs, \"humiliate, degrade, and debase me! Just, whatever you do, fill me!\" As you strip off your [armor], she spreads her legs as wide as she can, the wanton girl presenting her drooling pussy to you, puffy green lips already dripping with beads of anxious sweat and eager lubrication. She wiggles in the dirt, gripping her plump rear with both hands and lifting her ass into the air for you, hopefully. You can practically feel the heat pouring off the small slut's cum-hungry cunt, her breeding-fever leaving her eyes glassy and unfocused. Standing over her, it's clear that the only things she's even aware of are the pulsing pussy between her legs and your burgeoning erection.\n\n");

			outputText("Impatiently, she thrusts her legs out and hooks her toes around your lower body, trying to pull you closer while still keeping her needy hole accessible. Her olive feet clench around your flesh, her soles firm and muscular on your " + player.skinFurScales() + " as she slides up and down the outsides of your " + hipDescript() + ". Dragging her heels across your thighs, the goblin pushes her feet together on either side of your " + cockDescript(x) + ", the balls of her jade skin pressing against ");
			if (player.balls > 0) outputText("your throbbing sack");
			else outputText("the base of your shaft");
			outputText(" while her digits curl around your member like thick fingers. Stroking you slowly at first, the lime-hued girl picks up her tempo and alternates to the soft embrace of the silken skin between her instep and her calf, using the firmness of her ankles to massage your dick to full-mast. Quivering between her feet, blobs of pre-cum begin to leak from your tip, nearly transparent globules rolling down your glans. The goblin uses her big toes to gather up the warm fluid reverently, letting it flow between each digit gleefully before spreading it back onto your shaft with firm caresses, kneading the seedless ejaculate into your flesh like oil, her feet glistening like sea-green beryl with your fluid.\n\n");

			outputText("By now, a widening lake of over-stimulated honey has pooled under the lascivious girl. Moaning lewdly, her fingers still digging into her ass cheeks, you realize the goblin is cumming just from giving you a footjob. She needs your dick so badly that it's almost pathetic and a wicked idea crosses your mind.  Taking hold of her pre-cum slick feet, you run your fingers along her ejaculate-softened skin, tickling and rubbing her soles until the girl squeals in ecstasy, clenching her eyes shut as her panting desire becomes too much for her to keep her hands away from her cunt any longer. With a warm splash of overflowing honey, she digs the fingers of her right hand into her verdant slit, her left hand rubbing her jade clit in widening circles so quickly the vibrations jiggle her butt in the mud she's made of the forest floor. While she's distracted, ");
			if (mode == 0) { //Web condom (spinnerets)
				outputText("you work your spinnerets, the delicate organ weaving a long, thin sheath of finely meshed spider silk, taking care to leave the sticky strands between the inert layers of the flexible condom. Sliding it over your " + cockDescript(x) + ", you marvel at how light it is! You can even feel the wind's breeze through the silken covering.");
			}
			else { //Latex condom (item)
				player.destroyItems(useables.CONDOM, 1);
				outputText("you tear open the packet and slide the latex condom over your " + cockDescript(x) + ", marveling at how transparent and shiny it is. You don't think the goblin will be able to notice that until it's too late!");
			}
			outputText(" Time to give the goblin what she asked for, if not what she wanted.\n\n");

			outputText("Still holding her wriggling feet, you bend down and pull her legs apart as far as you can, muscles stretching almost wider and wider as her inner thighs clench against the tugging. The added pressure along with her own frantic jilling crests the girl into another orgasm, this time her gushing lube squirting upwards in crystal streams of depraved lust that patter against your abdomen warmly. Her arms fall at her sides, palms up and fingers twitching, clearing the path for your " + cockDescript(x) + " to the quivering green pussy she has so kindly prepared for you. Pushing against her engorged lips, you find she's so wet that you practically slip right in, her climax-racked muscles spasming irregularly as you fill her with your stiff manhood. \"Oh yesss, you finally found your cock\" she pants, drool bubbling in her mouth. \"Pump me like you hate me, you fucker\" she demands and you haul her upward by the ankles, pulling her further onto your pulsing dick, her dribbling cunny sucking at your shaft as her deep green inner folds part before your thrusting length. \"I'm not a glass doll, you pussy, just fucking jam it in!\" she screams, fingers clawing at the ground as she bucks upward to get more of you inside her.\n\n");

			outputText("The mouthy bitch apparently forgot who lost the fight, it seems, so you decide to remind her. Using her legs like a lever, you twist her around on your dick, spinning her 180 degrees, leaving her lying on her tits, her ass jutting up as you slam your cock the rest of the way into the olive-skinned nympho. She grunts and starts to say something else, but you push forward and grind her face into the mud before she can get it out, her mouth filling with her own lubrication-soaked dirt with an ecstatic gurgle. Her legs fight against your grip, jerking this way and that, her slick feet nearly slipping out of your hands. You grit your teeth and begin screwing her slavering twat as hard as you can, eager to tame the thrashing cunt of a girl. Slamming her sweat-soaked thighs against your " + hipDescript() + ", your thrusts become almost savage, bringing a deep flush to her backside as you slap her snatch against your groin, the secret condom working perfectly, as thin as skin on your " + cockDescript(x) + ".\n\n");

			outputText("As you feel the tickling heat of your orgasm worming its way into your veins, you lean down, putting your weight into every uterus-filling movement while the goblin sputters and screeches her approval, toes curling in your hands. You release her legs to grab the goblin slut's thin waist with both hands and slam against her jutting ass one last time before liquid heat pours from your " + cockDescript(x) + " in thick streams of potent seed. At the cresting grunt, she wraps her legs around your " + buttDescript() + ", locking her ankles and using her sore legs to pull your gushing prick as deeply into her fertile loins as possible and keep you there. Rocking against her, you rub her head and breasts through the mud one last time as your loads fill her tummy with the ejaculate she so craved, her narrow belly bulging at the weight of your jizz. You take a moment longer to enjoy the clenching, pulsing depths of the cum dumpster before sliding out an inch and taking hold of the ");
			if (mode == 0) {
				outputText("loose strand you left in your secret cock-shawl. Pulling carefully, you unravel the delicate outer layer, leaving only the sticky strands covering the inner, juice-filled sheath. With a short bark of laughter, you pull out of the whorish girl, the spider silk condom sealing as your tip slides out. ");
			}
			else {
				outputText("rim of your latex cock-sheath. Pulling carefully, you slowly remove your used condom and tie the open end shut. You look at it and you can see your cum inside the condom. ");
			}
			outputText("Then, wresting her feet apart, you unceremoniously dump her to the ground.\n\n");

			outputText("Squirming right-side up, covered in sweat and mud, the emerald girl's face screws into an expression of confusion as she pokes at the bulge of her abdomen. \"What... that doesn't feel right,\" she mumbles, pushing at her skin with both hands. Checking her cunny with a long, middle finger, she pulls it out clean, devoid of the ivory cream she expected. \"The fuck? A condom?\" she screeches. \"You bastard!\" Pushing at her belly with increasingly frantic motions, her mouth gapes when the seed-loaded balloon bounces right back, still intact. \"Why won't it burst?\" she demands. ");
			if (mode == 0) {
				outputText("You politely inform her that spider silk is terribly strong and oh so sticky. Reaching her fingers into her slit, she tries to pull it out and gasps at the feeling of her inner walls being pulled by the clinging webbing. Despite her best effort, the silk bubble stays right where you left it, snugly glued in place by your binding webbing. You laugh and wish her luck trying to get it out as you gather your clothes and walk away. So full of cum and yet unable to get any of it into her womb, the goblin girl moans helplessly, fingering herself in desperation, as if her orgasm could dislodge the treasure you've left inside of her.");
			}
			else {
				outputText("You politely inform her that latex is strong and effective at preventing pregnancy. You laugh and wish her luck trying to get it out as you gather your clothes and walk away. So full of cum and yet unable to get any of it into her womb, the goblin girl moans helplessly, fingering herself in desperation, as if her orgasm could dislodge the treasure you've left inside of her.");
			}
			player.orgasm();
			cleanupAfterCombat();
		}

//REQUIRES: AT LEAST ONE DICK AND A COPY OF ATLAS SHRUGGED - MUST NOT BE MONSTROUSLY HUGE
		private function gatsGoblinBoners():void
		{
			clearOutput();
			var x:Number = player.cockThatFits(monster.analCapacity());
			if (x < 0) x = player.smallestCockIndex();
			outputText(images.showImage("goblin-win-male-goblinboners"));
			outputText("The goblin lies strewn across the ground upon her stomach, exhausted from the battle. Her plump legs are unintentionally spread open while her ass pokes up into the air, giving you a clear view of her wet pussy as she tries to get herself off.  It seems as if the green-skinned slut has already forgotten about you - too many fruitless encounters might've caused her to give up hope on finding a virile specimen to pump her full of cum.\n\n");

			outputText("Luckily for her, you have every intention of changing that.\n\n");

			outputText("You begin to fondle your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" as you walk towards the unsuspecting goblin girl, taking in the sight of her perfectly round cheeks as they jiggle against her hurried movements, her soft thighs clenched against the eager hand between them.  Bending down, you quickly grab the goblin's ample hips, causing the girl to squeak in surprise as she turns around to catch the sight of your erect length");
			if (player.cockTotal() > 1) outputText("s");
			outputText(".\n\n");

			outputText("\"<i>W-woah!  Hey stud, whaddya think you're doing back there?</i>\" she yelps, more surprised than scared at your sudden appearance.  Instead of answering, you decide to grab your cock");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" and slap ");
			if (player.cockTotal() == 1) outputText("it");
			else outputText("them");
			outputText(" against the bare flesh of her ass, whilst your victim anxiously awaits your next move.  You take your time massaging the goblin's slutty ass with your bare hands before sliding your " + cockDescript(x) + " in between her soft cheeks.  Your horny victim appears impatient, attempting to grind against you as she spreads her moist lips open, enthusiastic that she's found someone willing to mate with her.  You slap her ass firmly as you quicken your thrusting - seconds before finally plunging ");
			if (player.cockTotal() == 1) outputText("your dick inside of the panting whore, pushing her forwards violently as you enter her tight snatch");
			else if (player.cockTotal() == 2) outputText("both of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole");
			else {
				outputText("two of your dicks inside of the panting whore, pushing her forwards violently as you enter her tight snatch and asshole - your other cock");
				if (player.cockTotal() >= 4) outputText("s");
				outputText(" remaining sandwiched in between her asscheeks");
			}
			outputText(".\n\n");

			outputText("You roughly pound against the goblin girl, maintaining a firm grip on her hips while she squeals with delight.  The sound of your groin slapping against her echoes throughout the area, followed by your grunting and the goblin's moans of ecstasy.  Your victim struggles to lift herself up by her arms, only to collapse back down from the feeling of you invading her insides.\n\n");

			outputText("Eventually you begin to feel yourself coming to a climax, your movements getting faster and faster as you build up to your release.  The goblin below you has already lost herself to the pleasure of your " + cockDescript(x) + ", her eyes rolled upwards and her tongue drooling out of her mouth while her slutty face rubs against the ground you're currently pounding her on.  With a final thrust, your hips lurch forward as you paint her insides with your thick spunk, relishing in the feeling of your ejaculate filling her up to the brim and plugging her entrance");
			if (player.cockTotal() == 2) outputText("s");
			outputText(".  You slowly release yourself from her tight body, finishing off by covering her curved back and pert rump with the rest of your seed.\n\n");

			outputText("You pick yourself back up, jerking yourself slowly as cum dribbles from your " + cockDescript(x) + " onto the collapsed body of the goblin.  It'll be awhile before she comes back to consciousness, but you're certain she'll have a better appreciation for sex when she does.");
			player.orgasm();
			cleanupAfterCombat();
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
			cleanupAfterCombat();
		}
		private function killGoblin():void {
			clearOutput();
			flags[kFLAGS.GOBLINS_KILLED]++;
			if (flags[kFLAGS.NO_GORE_MODE] >= 1) outputText("You make a quick work of the goblin before dragging the corpse away. That's one less foul creature prowling the realms. ");
			else {
				outputText("You slowly stalk towards your defeated foe. The goblin looks at you, lust filling her eyes as she believes you're going to use her. That lust quickly changes to fear as you pull a small knife out of its holster, the blade gleaming dangerously.\n\n");
				outputText("The goblin tries to run, but in her tired state, only manages to stumble around as you draw closer. You grab her by the hair and hoist her up, placing the sharp edge of the knife against her ear. The goblin wails in pain as you cut her ear off, blood spurting out as you quickly slit her throat to put the thing out of its misery. ");
			}
			if (player.cor < 25) dynStats("cor", -0.5);
			inventory.takeItem(useables.GOBOEAR, cleanupAfterCombat);
		}
	}
}
