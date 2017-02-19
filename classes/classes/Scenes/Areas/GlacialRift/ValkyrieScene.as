//Coded by Kitteh6660, courtesy of Savin.
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class ValkyrieScene extends BaseContent
	{
		
		public function ValkyrieScene() 
		{
		}
		
		public function loseToValkyrie():void {
			outputText("Unable to resist ", true)
			if (player.HP <= 0) outputText("her onslaught")
			else outputText("your rising lust")
			outputText(", you collapse to your knees, utterly at the valkyrie’s mercy.  She plants her spear in the ground, just inches from your head, and rolls you onto your back with her foot. \n\n", false)
			if (monster.lust >= 70 && flags[kFLAGS.SFW_MODE] <= 0) loseToValkyrieForcedOral()
			else {
				outputText("With one swift, contemptuous kick to the head, she knocks you right out.", false)
				outputText("  You are utterly freezing after such long exposure to the cold.", false)
				if (player.str > 50) dynStats("str", -1);
				dynStats("str", -1);
				if (player.spe > 50) dynStats("spe", -1);
				dynStats("spe", -1);
				combat.cleanupAfterCombat();
			}
		}
		
		private function loseToValkyrieForcedOral():void {
			var gemPenalty:Number = (player.gems / 100) + 10 + rand(20)
			if (gemPenalty > 100) gemPenalty = 100;
			if (gemPenalty > player.gems) gemPenalty = player.gems;
			gemPenalty = Math.round(gemPenalty);
			outputText("The valkyrie stands over you, her thin skirt already soaked with the arousal you inflicted upon her. She swings one of her long legs over your head, letting you get a good look at her slick, tight cunt before she drops down atop you, smashing your face into her slit. \"<i>You " + player.mf("bastard", "bitch") + ", trying to turn a valiant warrior into a drooling pile of lust. I won’t allow it -- you’ll finish what you started, weakling. Now lick!</i>\n\n");
			outputText("Too ");
			if (player.HP <= 0) outputText("beaten");
			else outputText("lusty");
			outputText(" to put up any kind of a fight against your opponent, especially in this position, you don’t have much choice but to do as she asks. Your tongue snakes out, taking an experimental flick at the wet gash of the valkyrie’s vagina. Her thighs are already utterly soaked with her lust, and probing her lips sends your tongue back coated with her lubricant. \n\n");
			outputText("Apparently such a tentative lick wasn’t enough for the warrior woman, though; she squats down lower on your face, grinding her wet cunny across your face. You sputter and gasp, trying to breath under her assault, but find it difficult with her constant grinding and moving. Resigned, you grasp her hips to steady her and dig in, shooting your tongue as deep into her cunt as it will go. The valkyrie moans, grasping your shoulders to steady herself as you begin your work in earnest, giving her slit quick flicks and little bites.\n\n");
			outputText("Soon, your face is coated with her fem-juices, and you can feel your winged captor beginning to shake and shudder as you tongue-fuck her. You redouble your efforts, hoping to get her off as quickly as possible. You move your head up as far as you can with her sitting on it, giving yourself a clear line of tongue to her tiny pleasure buzzer. You put your lips to it and give her clit a hard suck, running your wet tongue all across it as you do.\n\n");
			outputText("You're rewarded by a high scream from the valkyrie and a sudden gush of femcum that squirts from her slick cunt, splattering across your chest and neck. Moaning, the girl gasps your shoulders and slams her hips into your face, grinding against you until you’re utterly soaked with her cum. By the time she’s finished, you feel light-headed from the overwhelming scent of musk and sex surrounded the two of you, but she finally lets you go and stands.\n\n")
			outputText("\"<i>Hmm, not bad for a lusty pervert,</i>\" she laughs, trying awkwardly to straighten out her sodden skirt. \"<i>Maybe. . . Maybe I’ll let you do that again sometime. If you’re lucky.</i>\"\n\n")
			outputText("Before you can respond, she reaches over and nicks " + gemPenalty + " gems from you and launches off into the sky. Half-dazed by lust of your own, you stagger to your feet and head back to camp.\n\n")
			dynStats("lust", 50);
			player.gems -= gemPenalty
			combat.cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function winAgainstValkyrie():void {
			clearOutput();
			if (monster.HP <= 0) outputText("Beaten and bloodied, the valkyrie stumbles for a moment before dropping her spear and shield.  She kneels before you, head bowed low enough that her long hair brushes the icy ground. ")
			else outputText("Unable to contain her arousal, the valkyrie drops her weapons and collapses onto her knees, slipping a hand into her short skirt. ")
			outputText("\"<i>I submit,</i>\" she concedes weakly, avoiding eye contact with you.  \"<i>I was too weak to defeat you, it seems.  Do with me what you will. </i>\"")
			//(Display Options:
			//-If Male: [Aerial Fuck] [Fuck Anal] [Leave]
			//-If Female: [Get Licked] [Scissor]
			//-If Herm: All Options)
			menu();
			if (player.lust >= 33 && flags[kFLAGS.SFW_MODE] <= 0) {
				if (player.hasCock()) {
					addButton(0, "Aerial Fuck", valkyrieAerialFuck);
					addButton(1, "Anal Fuck", valkyrieAnalFuck);
				}
				if (player.hasVagina()) {
					addButton(2, "Get Licked", valkyrieLicksYou);
					addButton(3, "Scissor", valkyrieScissor);
				}
				addButton(4, "Leave", combat.cleanupAfterCombat);
			}
			else {
				combat.cleanupAfterCombat();
			}
		}
		
		//Aerial Fuck
		private function valkyrieAerialFuck():void {
			clearOutput();
			outputText("Standing over the defeated valkyrie, your eyes alight to her great white wings. They’re certainly powerful enough to keep a strong, fully armored woman aloft. . . So why not the both of you? You haul the warrior woman to her feet, free your " + player.cockDescript() + " from your " + player.armorName + ", and grip her in a tight embrace. You give her a hard slap on the ass and tell her to fly.\n\n")
			outputText("She hesitates for just a moment, prompting another harsh spank. Unable to resist your desires, the defeated girl unfolds her powerful wings and with a mighty flap, launches into the air. You soar on high, quickly rising above the icy wastes to look down upon the northern reaches of Mareth far below you. You can see other creatures roaming the wastes -- giants and vikings and other, low-flying valkyries, looking like little more than ants beneath you. The realization of your height over the world, combined with the closeness of the valkyrie girl, her breasts heaving into your chest and her breath hot on your cheek, serve to make your " + player.cockDescript() + " rock hard between the two of you, sandwiched snugly between your bellies.\n\n");
			outputText("Suddenly, you realize that without letting go of the girl, you aren’t liable to get your dick inside her. Well, shit. You lock eyes with the valkyrie, who gives you a shy smile and, to your surprise, wraps her arms tightly around you. You decide to trust her, and free one of your hands from her. You grab your " + player.cockDescript() + " and lift her skirt, guiding it smoothly into her wet and waiting cunt. She gasps as you enter her tight passage, and you quickly grab her again before she can forget to hold onto you.\n\n");
			outputText("Now inside her, you command the valkyrie to fly as fast as she can to wherever she’d like to go. She smiles and nods, giving her wings a mighty thrust toward the ocean. When she does, her vaginal muscles contract hard around your cock, squeezing you wonderfully with each beat of her powerful wings. You hold onto the valkyrie for dear life, kissing and caressing her soft neck and cheeks as she flies, letting each of her graceful motions gently massaging your dick.\n\n");
			outputText("She seems to be taking no little pleasure from flying full, either, and is soon moaning lewdly into your neck, abandoning her once-proud visage for that of a lusty maid. She wraps her legs around your waist, burying just a little more of your cock inside her until ")
			if (player.cockArea(0) >= 16) outputText("she can take no more of you.  ")
			else outputText("there is no more of you to take.  ") 
			outputText("You return the favor, starting to buck your hips into her contracting passage, fucking her with quick, short strokes that keep the two of you close together.\n\n");
			outputText("\"<i>I... Gotta land,</i>\" she moans. Her muscles are contracting harder and faster now, and you can feel her slick fem-juice now leaking out around your prick. You give her a little nod, already close to the edge yourself, but it looks like it’s too late! The girl screams, clamping down hard on your cock as she cums, squirting her juices onto her thighs and yours. The mid-air orgasm, however, causes her to forget her wings, and soon you’re plummeting toward the earth!\n\n");
			outputText("You scream, half in pleasure and half in terror as your cock unloads inside her, pumping your hot load into her sodden box as the icy ground rises up to meet you. \n\n");
			player.orgasm();
			if (player.canFly())
				outputText("You try to beat your own wings to save yourself, but you have too much momentum and the valkyrie in all her heavy armor is completely entwined around you, refusing to let go as you both cum.\n\n")
			else outputText("You clutch at the valkyrie and brace for the inevitable, cumming more and more inside her despite your impending doom.\n\n");
			outputText("Then suddenly, the valkyrie spreads her wings and flies, pulling up with so little room to spare that you can feel your cheek brush the snow. Panting, she flaps her wings one last time before setting the two of you down on the coast, overlooking the glacial drop into the frigid water.\n\n");
			outputText("You shudder, reeling from the orgasm and near - death experience at the same time. No less exhausted, the valkyrie collapses onto you, her head coming to rest on your lap. It seems you made a good impression on the valkyrie as she drifts off to sleep, your cum and hers pooling between her legs. You fish a blanket (and a few gems) out of her pack, cover her up as best you can, and stumble on back to camp.");
			combat.cleanupAfterCombat();
		}
		//Anal Fuck
		private function valkyrieAnalFuck():void {
			clearOutput();
			outputText("You grab the defeated valkyrie by the hair and push her down onto all fours. She groans as you circle around behind her, giving her ass a hard slap. Defeated, though, she does not try to resist you as you kneel down behind her and flip up her skirt, revealing her lush ass cheeks, her slick cunt, and her tight, puckered little asshole. You reach into your " + player.armorName + " and pull out your " + player.cockDescript() + ", stroking yourself for warmth until your can get your shaft tucked in between the valkyrie’s butt.\n\n");
			outputText("You grab her hips and start to thrust upwards and back, slowly hotdogging the defeated girl’s ass, stopping only to slather a bit of her drooling cunt juices onto your shaft for some much-needed lubricant. You give her ass a quick, playful slap, making her reflexively squeeze down on your cock. Laughing, you get into a nice rhythm, spanking her once every few thrusts to get a little extra thrill out of her.\n\n");
			outputText("To your surprise, the valkyrie looks over her shoulder and, face flush with anxious lust, whispers, \"<i>Well. . . What are you waiting for, huh? Just. . . stick it in already!</i>\"\n\n");
			outputText("Well, if she’s so eager. You lean back and thrust in, slamming your " + player.cockDescript() + " into her tight pucker. She had already tried to relax, but your sudden and forceful intrusion makes her clamp down hard, squeezing your shaft like a wet silken vice. You moan as you shove more and more of your shaft into her blessedly warm depths, feeding her ass your cock one inch at a time until ");
			if (player.cockArea(0) >= 16) outputText("you bottom out.  ");
			else outputText("hilt the valkyrie.  ");
			outputText("She screams in pleasure and pain as you hammer into her backdoor, but settles down once you’ve stopped your advance, unable to continue. Slowly, you begin to rock your hips into her, fucking her ass slow and gentle.\n\n");
			outputText("You smile as she begins to moan and wiggle her hips, finally getting into the assfuck you’re giving her. Now that she’s settled, you pick up the pace, starting to thrust faster and more forcefully. You keep your increase gradual, letting the valkyrie keep up so that by the time you’re roughly pounding her ass, she’s groping herself and yelling \"<i>Fuck me harder! Fuck me harder!</i>\" You oblige her, ramming her ass and resuming your spanking, abusing her tush until she’s screaming.\n\n");
			outputText("With such a tight, eager partner, you manage to last quite some time. Yet, all good things come to an end. With a mighty roar, you slam your cock as far into her as it will go and cum, painting her insides with your seed. She, too, climaxes as you fill her, her pucker squeezing you for everything you’re worth as her unused cunny squirts a bit of femcum onto her thighs and legs. Laughing gaily, you keep on pounding her ass until you’re utterly spent and deflating, and your partner has collapsed, her face buried in the snow.\n\n")
			outputText("You withdraw with a wet “POP!”, and watch with a grin as your seed trickles out of her now-gaping anus, pooling with her own juices beneath her. You give her bruised, bright-red butt a gentle pat as you sheathe your cock back in your armor and head on back to camp, leaving your insensate lover in a cun-soaked heap on the ice.")
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		//Get Licked
		private function valkyrieLicksYou():void {
			clearOutput();
			outputText("You decide to take advantage of the valkyrie girl’s kneeling state. You walk up to her and open the crotch of your " + player.armorName + ", revealing your " + player.vaginaDescript() + ". Before she can react, you grab the back of her blonde head and mash her face into your cunt. You tell her to lick, and to your surprise, she does so without hesitation.\n\n");
			outputText("The girl’s tongue is surprisingly skilled. She quickly teases it across your clitty, making you moan with sudden pleasure right away. You can see her smirking beneath you as she begins to tease and play with your pleasure buzzer, using the flat of her tongue to tickle the sensitive flesh around it. You return her grin, urging her on with little pats of the head and shoulders, even reaching down to cup one of her perky breasts beneath her breastplate.\n\n");
			outputText("She finally slips her tongue in and starts to caress the walls of your " + player.vaginaDescript() + ", running her soft, warm tongue along your innermost depths with delightful speed and gentleness. You smile and run your hands through her long hair, stroking her as she grips your hips and buries her face in your twat, utterly submitting to your pleasure.\n\n");
			outputText("You begin to grind your slit into her face as she eats you out, rubbing your cunt along her nose and forehead to the beat of her tongue’s skillful ministrations. After a few blissful minutes of this, though, you feel one of her hands begin to creep forward. You give her a little nod as she peels apart the cheeks of your " + player.buttDescript() + " and runs the tip of a finger across your [asshole].\n\n");
			outputText("You let out a little gasp as the valkyrie slips a finger into your asshole. She makes a slow, steady progression inward, fingering your asshole gently as she picks up the pace of her tonguefucking. Through your innermost depths, you feel her tongue and finger nearly touch, separated by only the thinnest of walls. You shudder as they rub and caress each other through your vaginal wall, sending incredible, mind-rending spikes of pleasure up through your body.\n\n");
			outputText("You cannot resist her double attack for long. Grabbing the valkyrie’s head, you force her face between your legs, getting every last bit of her tongue inside you as you can as you climax, spraying your femcum all across her face");
			if (player.hasCock()) outputText(" as your dick unloads, spraying her hair with your spunk");
			outputText(".\n\n");
			outputText("Utterly satisfied, you let the valkyrie go. She collapses, dragging her finger and tongue out of you before she face-plants in the snow. You giggle, giving her a pat on her cum-soaked head before grabbing a few of your gems and heading back to camp.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		//Scissor
		private function valkyrieScissor():void {
			clearOutput();
			outputText("You gently push the kneeling valkyrie onto her back and unclasp your " + player.armorName +" just enough to reveal your " + player.vaginaDescript() + ". The girl squirms a bit, but a harsh word from you stops her in her tracks as you spread her legs and get in position. With ease, you heft one of her long legs over your shoulder, pressing her slick cunt against yours.")
			outputText("You give her a little grin and begin to grind against her leg, rubbing your " + player.vaginaDescript() + " along her thighs, feeling her smooth skin part your pussylips ever so slightly. Unwilling to just sit there, you’re gratified to see your partner begin to rub her own cunt against yours, returning your affections. Now that it’s a real two-way, you pick up the pace a little, settling into a good rhythm with the valkyrie.")
			outputText("You reach over and, with a little help from your lover, unclasp her breastplate. Now guarded by only a thin shift, you grasp her perky breasts and begin to squeeze and fondle them, working in a few pinches to her tiny nipples and rough gropes as you play with her soft chest. She lets out a little gasp at each grope or tease, eventually returning the favor, sliding her hands into your " + player.armorName + " and grabbing your " + player.breastDescript(0) + ". She gives your nipples a hard tweak, eliciting a sharp hiss from your lips.")
			outputText("You spend the next few minutes happily grinding and groping each other, but that doesn’t seem to quite do it for the valkyrie girl. She reaches up and, to your surprise, wraps you in a tight embrace. \"<i>Please... Faster. I need this so badly...</i>\" she admits, kissing your neck as she bucks her hips against you. Well, well. You happily agree to her request, picking up your pace until you’re well and truly fucking her, grinding your hips into each other as the valkyrie kisses and caresses you, surprisingly tender for someone who seemed so stoic and prideful a few minutes ago.")
			outputText("You cup her cheeks and give her a kiss full on the lips. When you break it, she’s smiling beautifully. That smile, and her pussy stroking yours, sends you over the edge. You hold your winged lover tight and cum, moaning into her shoulder as you ride out a powerful orgasm. Still smiling, the valkyrie wraps her wings around you and lets out a little moan, and you feel her squirting onto you, soaking your already sodden crotch with her femspunk.")
			outputText("Exhausted from the playful sex, the valkyrie collapses on her back, utterly spent. You give her a pat on the cheek and a quick kiss before grabbing a few gems and heading on back to camp. ")
			player.orgasm();
			combat.cleanupAfterCombat();
		}
		
	}

}
