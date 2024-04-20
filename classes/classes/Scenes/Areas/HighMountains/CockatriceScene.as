package classes.Scenes.Areas.HighMountains {
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Items.ArmorLib;
import classes.Scenes.SceneLib;
import classes.lists.BreastCup;

/**
 * Created by Stadler76 on 29.04.17.
 * Writer: MissBlackthorne.
 * Ported from UEE to CoCX by Svalkash.
 */
public class CockatriceScene extends BaseContent {

    //Intros and Fight Texts.
    public function greeting():void {
        var cockatrice:Cockatrice;
        clearOutput();
        if (flags[kFLAGS.TIMES_ENCOUNTERED_COCKATRICES] == 0) { //First encounter:
            cockatrice = new Cockatrice();
            outputText("As you follow the trails in the high mountains, the rocky terrain becomes less stable, the path devolving into a series of loose crags with gravel like sediment surrounding large boulders and rough stepping stone-like structures. "
                + "As you cling to the rock face trying to step from one rock to another you see something in the distance. "
                + "A figure, perched on one of the outcroppings with surprising ease.\n\n");
            outputText("Though you can’t pick out many details from this distance, the vibrant coloring of this individual makes you think of the harpies that rule the skies here. "
                + "This is their domain, and you should probably tread carefully. "
                + "[if (hasCock = true) As you notice your precarious position up here, you hope to all the deities you know that it's not a harpy. "
                + "Their enthusiasm for your [cock] is something you could really do without, " + (player.canFly() ? " even though you could use your [wings] to ensure your safety. " : " especially at such dizzying heights.  ")
                + "A scuffle this high up is the last thing you could want.\n\n");
            outputText("Proceeding carefully, you approach the figure, gripping the rock tight as you pull yourself flat against the rough, cool surface. "
                + "As you sneak closer, the creature’s feathers puff out, causing you to freeze. Holding your breath, you wait, hoping it hasn’t yet noticed your presence. "
                + "After a few tense moments pass the creature simply leans forward and begins to preen itself, attention focused purely on itself. "
                + "With a small sigh of relief you work your way across the ridge you had been clinging to, eventually managing to come across a small plateau, "
                + "a godsend in this uneven terrain which allows you to observe the creature in relative safety.\n\n");
            outputText(images.showImage("monster-cockatrice"));
            outputText("The creature before you is easily 6 feet tall, covered in a layer of vibrant midnight blue feathers with turquoise accents. "
                + "It appears to be relatively avian in appearance, more so than the harpies you’ve seen flying around. "
                + "It has a beaked face with large feathered ears, reminiscent of those of an owl. "
                + "A ruff of thicker and fluffier turquoise plumage sits puffed out around its neck, currently the target of its preening. "
                + "You get a peek at its tight, lithe stomach and flat chest as it stretches, the smooth cream scales of its underbelly framed by its deep blue plumage.\n\n");
            outputText("Its arms are coated in feathers down to the forearm, though around the elbows there also seems to be vestigial wing feathers. "
                + "While they aren’t huge, they look capable of assisting landings in acrobatic maneuvers and long jumps. "
                + "The visible portion of creature's hands and forearms are a contrast to its bright avian form, being oddly reptilian, coated in black scales and tipped with sharp claws.\n\n");
            outputText("As the creature shifts its stance, evidently done with its grooming, you see that it's definitely some kind of avian/lizard hybrid. "
                + "It’s long thick tail swings above its tight rear, gradually tapering down into a point. "
                + "It has to be close to half its body length, with a mane of feathers stopping in a v-shape about 4 inches down its length as it transitions from its feathered body into midnight blue scales.\n\n");
            outputText("From its slightly wide hips, powerful feathered haunches transition in reptilian legs at the knee, black scales coating its digitigrade legs. "
                + "Its three long toes terminate in wicked looking talons, while a smaller emerges at the heel. "
                + "You don’t want to get on the wrong side of those. You realise as you appraise its vaguely familiar features, that this must be some kind of harpy basilisk hybrid, a Cockatrice! "
                + "Boy, [benoit name] was right, they are weird looking!\n\n");
            outputText("As it turns to leave, it notices you and its electric blue eyes light up with excitement. "
                + "It jumps from rock to rock with ease, quickly closing in on you with a squawking shout. "
                + "You ready your [weapon] as the creature shows no sign of slowing. Looks like you have a fight on your hands!");
            //(spd loss)
            player.buff("Basilisk Slow").addStats( {"spe":-5} ).withText("Basilisk Slow").combatPermanent();
        } else { //Standard encounter:
            if (rand(100) < 40) {
                //40% chance of wings
                cockatrice = new WingedCockatrice();
            } else {
                cockatrice = new Cockatrice();
            }
            outputText(images.showImage("monster-cockatrice"));
            outputText("As you once again climb high in the mountains, you spend some time catching your breath on a rocky plateau to avoid the loose gravelly ground. "
                + "You see a brightly coloured creature in the distance, ");
            if (cockatrice.canFly())
                outputText("feathered wings unfurled to aid its movements, ");
            outputText("hopping from stone to stone with ease and what seems to be enjoyment. As you let out a sigh and move to leave the creature notices you, speedily moving from rock to rock with flaps of its feathers. "
                + "It approaches squawking with excitement, not slowing in the slightest as it reaches the plateau. "
                + "You now see it clearly, it's a cockatrice, and you know it won’t or can’t halt in such an excitable state. Looks like you’ll have to fight!");
        }
        camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_COCKATRICES);
        startCombat(cockatrice);
        flags[kFLAGS.TIMES_ENCOUNTERED_COCKATRICES]++;
    }

    //Wins
    public function defeatCockatrice():void {
        clearOutput();
        if (monster.HP < 1) outputText(images.showImage("cockatrice-fallen-hp"));
        else outputText(images.showImage("cockatrice-fallen-lust"));
        outputText("The Cockatrice falls to his knees panting as he looks over at you. ");
        //Player HP victory:
        if (monster.HP < 1) outputText("He looks thoroughly beaten, feathers ruffled and face dirtied from debris that rose during the battle. The defiant look in his eyes is all that's left of his previous manic energy.\n\n");
        //Player Lust victory:
        else outputText("He lazily strokes his purple length as he looks up at you with a come-hither gaze. His ruffled feathers, dirtied scales and leisurely pumps manage to make him look quite dashing, even in defeat.\n\n");
        if (player.lust >= 33) {
            menu();
            addButtonDisabled(0, "Ride Him Vag", "This scene requires you to have a vag, not being a taur or drider and sufficient arousal");
            addButtonDisabled(1, "Ride Him Anal", "This scene requires you to be neither taur nor drider and have sufficient arousal.");
            addButtonDisabled(2, "Buttfuck", "This scene requires you to have a fitting cock, not being a taur or drider and sufficient arousal.");
            addButtonDisabled(3, "Oral (Cock)", "This scene requires you to have a cock, not being a taur or drider and sufficient arousal.");
            addButtonDisabled(4, "Oral (Vag)", "This scene requires you to have a vag, not being a taur or drider and sufficient arousal.");
            addButtonDisabled(5, "Taur sex", "This scene requires you to be a taur, having a cock and/or a vagina and sufficient arousal.");
            addButtonDisabled(6, "Drider sex", "This scene requires you to be a drider, having a cock and/or a vagina and sufficient arousal.");
            outputText("What do you do with him?");
            if (!player.isTaur() && !player.isDrider()) {
                if (player.hasVagina()) addButton(0, "Ride Him Vag", rideCockatriceForeplay, cockatriceRideHimVag).hint("Let him fuck your pussy.");
                addButton(1, "Ride Him Anal", rideCockatriceForeplay, cockatriceRideHimAnal).hint("Let him fuck your butt.");
                if (player.cockThatFits(monster.analCapacity()) >= 0) addButton(2, "Buttfuck", cockatriceButtfuck).hint("Fuck the cockatrice's ass!");
                if (player.hasCock()) addButton(3, "Oral (Cock)", cockatriceOralCock).hint("Get a blowjob!");
                if (player.hasVagina()) addButton(4, "Oral (Vag)", cockatriceOralVag).hint("Get a vaginal blowjob!");
            } else if (player.isTaur() && (player.hasVagina() || player.hasCock())) addButton(5, "Taur sex", cockatriceTaurButtFuck).hint("Let him fuck your tauric butt!");
            else if (player.isDrider() && (player.hasVagina() || player.hasCock())) addButton(5, "Drider sex", cockatriceDriderButtFuck).hint("Let him fuck your drider butt!");
            addButton(14, "Leave", cleanupAfterCombat);
            SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatCockatrice);
        } else {
            outputText("You're not aroused enough to rape him.");
            cleanupAfterCombat();
        }
    }

    //Player Victory sex:
    //Cockatrice fucks PCs vag
    private function cockatriceRideHimVag():void {
        outputText("\n\nHis cute begging face and the way he keeps his tongue working your "
            + "[if (hasCock = true)turgid cock|hungry cunt] regardless of your actions speeds up your decision, making you push him back by his firm but downy shoulders. "
            + "You slowly make your way to your knees, letting him get a good look at your body as you do so. "
            + "His breath is coming out in short pants now, devouring you with his raking gaze "
            + "[if (isLactating) and licking his lips as he gets an eyeful of your milky nipples]. "
            + "Slipping your hand around his curved reptilian length you align him with your hungry cunt, the tip now only centimetres away from your heated flesh. "
            + "His low groan and feeble attempt to buck his hips show how much he wants this too, but with a slight squeeze you easily halt him.\n\n");
        outputText("\"<i>P...please...</i>\" he hisses, a somewhat melodic nature to his husky voice. "
            + "If it weren’t for how much you wanted this too, you’d happily continue to tease him so you could have his hypnotic melody caress your senses further. "
            + "With a small nod you push yourself down on him, smirking as he watches inch after inch disappear into you. "
            + "He whimpers and shudders under you, squirts of pre coating your insides as his tail thrashes.\n\n");
        outputText(images.showImage("cockatrice-ridehim-vag"));
        outputText("The combination of his tapered length and it’s bumpy texture causes you to sigh as you reach the bottom of his length, your hot cunt pressing against his cool scales. "
            + "With a slight squawk, pupils dilated into large circles, he pulls you forward into a heavy open-mouthed kiss. "
            + "Your [tongue] and his slide across one another, his head tilted to the side to give you better access to his beak as his hand "
            + "[if (hairLength > 0)threads into your [hair]|cups the back of your head].\n\n");
        outputText("You begin to rise up his length, the bumps rubbing firmly against your clit with each inch that leaves you. "
            + "As you reach the tip you slam your hips back down, relishing the feeling of his length rapidly stretching you as the tip pokes your womb. "
            + "You keep this pace as you break the kiss, the regular ascent and rapid descent making lewd ");
        if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_WET) outputText("squelching");
        else outputText("slapping");
        outputText(" noises as you get closer to your peak. As you ride him the cockatrice suddenly lunges his forward, trapping one of you [nipples] in his mouth."
            + " He sucks hungrily as he feels your walls tightening around him, eager to bring you to a climax. His hand goes to ");
        if (player.breastRows.length > 1) outputText("one of your other nipples");
        else outputText("your other nipple");
        outputText(" as he sucks, pinching your nipple, causing a symphony of gentle suckling, eager fucking and pleasurable pain to encapsulate you."
            + " This tips you over the edge as the pair of you thrust together, burying his member deep in your fluttering passage."
            + " You cry out as you cum [if (cumQuantity > 150)soaking your thighs and his member], your slick channel trying to wring out his seed.");
        if (player.hasCock()) {
            outputText(" Your");
            if (player.hasBalls()) outputText(" balls churn and tighten, roiling seed begging to be released and your ");
            outputText("[cock] lets loose ");
            if (player.cumQ() <= 150) outputText("a few squirts of pearlescent cum, coating your bellies.");
            else if (player.cumQ() <= 350) outputText("squirt after squirt of pearlescent cum, coating your bellies.");
            else if (player.cumQ() <= 1000) outputText("several thick ropes of pearlescent cum, coating your chests and bellies with a thick layer of spooge.");
            else outputText("several thick ropes of pearlescent cum, dousing you both like a perverse fountain.");
        }
        outputText("\n\nUnder you, the cockatrice groans, his cock twitching as his seed begins to surge up it, bloating his member a little as it jets out in thick ropes, determined to thoroughly coat your womb. "
            + "The pair of you lay there panting for a while, him running a hand through your hair as he chirps softly. "
            + "When you finally climb off him, [if (cumQuantity > 350)your body slick with your release, with] his seed dripping down your thighs as you ");
        outputText(!player.armor.isNothing ? "get dressed," : "grab your gear,");
        outputText(" you can’t help but smile at him. Already standing again he shakes himself, trying to get himself presentable, but his feathers are puffed out in random directions."
            + " The goofball has sex-hair! With a slight laugh, you give him a kiss on the tip of his beak before telling him you had fun.\n\n");
        outputText("\"<i>So did I. Let’s do this again sometime.</i>\" he says with a smile before giving himself one last smooth over before "
            + "spreading his wings and taking off].");
        player.sexReward("cum", "Vaginal");
        player.knockUp(PregnancyStore.PREGNANCY_COCKATRICE, PregnancyStore.INCUBATION_COCKATRICE);
        player.cuntChange(monster.cockArea(0), true);
        cleanupAfterCombat();
    }

    //Cockatrice fucks PCs butt
    private function cockatriceRideHimAnal():void {
        outputText("\n\nHis large rounded pupils give him a cute, almost puppy dog look, as he stares up at you. "
            + "If it weren't for his flushed face and lolling tongue adding such a lewd edge, you’d sweep him up into a big hug and pet him. "
            + "But you have a better idea, one that will make this face seem absolutely innocent by the time you’re done with him. "
            + "You push him down to the ground by his shoulders, his warm downy feathers caressing your hands as you then kneel down to the same level.\n\n");
        outputText("For such a lithe creature he has surprisingly good muscle definition, his athletic shoulders supporting your weight with ease. "
            + "You position yourself so his cock is sandwiched between your [butt], gently grinding his length back and forth. "
            + "Between his copious amount of precum slathering your pucker and the variety of nubs that decorate his length you can’t help but let out a small groan. "
            + "As you drag his tip across your [asshole], delighting in every spark of pleasure you get as his nubs run over your sensitive flesh, you feel his hands slide to your hips. "
            + "His eyes are closed as he pants lustily, his lower body tense as he tries to resist thrusting into you and destroying this teasing rhythm you’ve built up. "
            + "Each twitch of his cock results in another spurt of precum lubing up your cheeks, letting his length glide smoothly between them.\n\n");
        outputText("You smirk as you suddenly raise your hips, just enough to let his tip rest against your clenched ring, but not enough to let him enter. "
            + "He lets out a hiss, claws digging into your [butt].\n\n");
        outputText("\"<i>P...please...</i>\" he hisses, a somewhat melodic nature to his husky voice as you feel his thick cock pressing against your entrance with a little more pressure. "
            + "While you know you’d love to tease him longer, you want his thick reptile cock in you more. "
            + "You rock your hips a couple more times, spreading his pre over your entrance before pushing down.\n\n");
        outputText(images.showImage("cockatrice-ridehim-anal"));
        outputText("As his thick tip slides into your pucker ");
        if (player.ass.analLooseness <= AssClass.LOOSENESS_TIGHT) outputText("stretching your tight passage open ");
        outputText("you can’t help but moan. "
            + "The nubs along his shaft each rub against your sensitive pucker as you slowly take his whole length, and you can’t help but ");
        if (player.ass.analLooseness <= AssClass.LOOSENESS_TIGHT) outputText("feel full.");
        else outputText("enjoy his size in your practised asshole.");
        outputText(" His hands come to rest on your ass, squeezing your cheeks lightly as he leans forward and draws you into an open-mouthed kiss."
            + " He gently rocks his hips, making sure he’s snuggly inside you before he urges you to move with a gentle lift.\n\n");
        outputText("You begin your ascent, reveling in the way his nubby shaft drags across your insides as his tongue intertwines with your own. "
            + "You feel a spurt of pre-cum splash against your insides, pasting them with slick warmth as you slide back down him. "
            + "You increase your pace, beginning to bounce on his cock as he lets out a slight squawk in surprise before settling into your rhythm and thrusting with you. "
            + "You can feel his cock twitch as you ride him, your ass slapping against his thighs with each thrust and your tunnel clenching around him rhythmically, "
            + "trying to squeeze his release from him as his nubby purple shaft rakes down your sensitive walls.\n\n");
        outputText("He whines as his claws rake into your cheeks, hips bucking in short, jerky bursts. You can feel his length pulse and twitch inside you as he looks you in the eye pleadingly. "
            + "With a single rise and fall of your hips and a tight squeeze, you hilt him in your twitching passage. "
            + "You gasp as his thick hot cum shoots into you, coating your insides with a layer of his masculine slime "
            + "[if (hasCock = true)and hitting your prostate with surprising force]. You feel a ripple of pleasure rip through you as you cum");
        if (player.hasCock() || player.hasVagina()) {
            if (player.hasVagina()) outputText(" your pussy soaking your thighs");
            if (player.hasCock() && player.hasVagina()) outputText(" and");
            if (player.hasCock()) {
                outputText(" your cock spurting onto his scaled belly, as your testicles shudder as they dispense your");
                if (player.cumQ() < 150) outputText(" small load.");
                else if (player.cumQ() < 350) outputText(" medium load.");
                else if (player.cumQ() < 1000) outputText(" large load.");
                else outputText(" colossal load.");
            }
        } else outputText(" your asshole twitching and hungrily wringing him dry.\n\n");
        outputText("You both sit there for a while, enjoying the afterglow and the warmth of each others bodies. "
            + "You spend a little time enjoying the softness of his feathers on your skin before you remove yourself from him with a wet ‘shlorp’. ");
        if (!player.armor.isNothing) outputText("As you get dressed you give him another glance over. ");
        else outputText("As you grab your gear you give him another glance over. ");
        outputText("Already standing again he shakes himself, trying to get himself presentable, but it does nothing as his feathers are puffed out in random directions. "
            + "The goofball has sex-hair! With a slight laugh, you give him a kiss on the tip of his beak before telling him you had fun.\n\n");
        outputText("\"<i>So did I. Let’s do this again sometime.</i>\" he says with a smile before giving himself one last smooth over before spreading his wings and taking off.");
        player.buttChange(80, true);
        player.sexReward("cum", "Anal");
        cleanupAfterCombat();
    }

    //PC fucks Cockatrices butt
    private function cockatriceButtfuck():void {
        clearOutput();
        outputText("You make your way over to him, [if (hasArmor) stripping yourself of your [armor] piece by piece, putting on quite the show,] a sensuous sway in your [hips]. "
            + "He looks up at you from the ground, confusion and lust in his eyes as you bare yourself to him. "
            + "Throughout the fight you couldn't keep your eyes off his firm, downy rump and now you're gonna claim it for yourself.\n\n");
        outputText("You order him onto his knees, gently nudging his side as he slowly positions himself, tail drooped over his back end. "
            + "The movement is slow and fluid, his lithe form rippling under his feathers as he rolls onto his hands and knees before looking at you for further instructions. "
            + "As you appraise his form, you can't help but circle him, taking in every detail of his lithe, fit frame before setting your gaze on your intended target. "
            + "Reaching down you firmly grope his behind, getting a good feel of those firm cheeks and their soft feathers. He squawks in surprise, jolting forward and thrashing his tail.\n\n");
        outputText("Now, you can't be having that, such a naughty tail getting in your way. You tell him to raise his tail as you get down on "
            + "[if (isNaga)your coils|[if (isGoo)the ground|your knees]] behind him, cooing about what a good boy he is as you cup his cheeks affectionately, your thumbs pressing in lightly. "
            + "Once his tail is moved to the side you can get a good look at him, the raised base making his cheeks spread a little.\n\n");
        outputText("As you follow his slightly wide hips with your fingertips and trace over his fluffy rear, you gently tease his cheeks apart so you can see what you have to work with. "
            + "Between his small, muscular cheeks rests a tight pucker, twitching slightly as you run a finger over it. "
            + "While he definitely doesn't do it often, he evidently is no stranger to some butt loving on occasion.\n\n");
        outputText("You suck your fingers a little as you stroke his lower back, coating them with saliva before beginning to tease his ass."
            + " You gently push your finger in up to the first knuckle, feeling his warm insides cling to you, resulting in a breathy"
            + " whimper from the cockatrice. With some slow wiggling and turning you begin to lube his entrance, squeezing and massaging"
            + " his butt and the base of his tail with your free hand.");
        outputText("\n\nBefore long you manage to slip your finger into him entirely, crooking it now and then to drag against his sensitive"
            + " insides. Each movement brings a shiver to his frame and a slight jerk to his hips, his breath hitching now and then as you"
            + " slowly begin to withdraw.");
        outputText("\n\nHis purple member strains out from its slit, pre beading at the tip as you knead his behind. Running your free hand up"
            + " and over his length you use his slick pre to further lube your fingers before introducing a second, this time at as much"
            + " faster pace. He groans by the time your fingers are at their furthest, his cock twitching towards his belly as his walls"
            + " stretch around your fingers.\n\n");
        outputText("Thrusting them in and out, you try to stretch him slowly while you make sure his tight tunnel is sufficiently slick."
            + " Once your fingers are moving smoothly back and forth you stroke your [cock] to full hardness. You line yourself up before"
            + " pulling out your fingers entirely and pushing your [cockhead] into him with a slow constant pressure, relishing in the tight"
            + " heat that now engulfs you along with the panting whine you draw out from his chest. ");
        outputText(images.showImage("cockatrice-win-buttfuck"));
        if (player.longestCockLength() <= 12) {
            outputText("You slowly feed more of your [cock] into him, reveling in the hot, twitching walls that cling to you, trying to wring you dry with each inch you see disappear. ");
            if (player.hasBalls()) outputText("Your [balls] " + (player.balls == 1 ? "presses" : "press") + " firmly against his fluffy cheeks, caressed by his downy plumage in a delightful way.");
        } else outputText(" You slowly try to feed more of your [cock] into his tight cavity, but soon the crushing tightness becomes too much to handle. You sigh a little as you withdraw to a more comfortable position, disappointed you’re too big to give him a proper reaming. ");
        outputText("Each movement you make causes him to shudder, his cock steadily leaking pre as he moans at first in pain and soon in pleasure.\n\n");
        outputText("You soon begin to thrust, first slowly, gently making sure he’s good and stretched for you, but soon speed up as his now relaxed tunnel lets you bury yourself deep and clings to you hungrily. "
            + "You can feel the head of your cock push against his prostate with each thrust, causing him to moan out his appreciation as his cock jerks and spurts jets of cum onto the ground and his belly. "
            + "As he begins to enjoy himself, joining your thrusts as best he can, you surprise him with a sharp spank to one of those tight cheeks, grabbing a handful as you do so. "
            + "His tail thrashes and his ring tightens, and you can feel yourself swell from the crushing hold he has on you.\n\n");
        outputText("With a groan you spank him again, this time the other cheek just as you hilt yourself. "
            + "It feels so good in his pucker, his walls spasming around you while his ring clenches tight around your base. "
            + "You continue to thrust into him, humping away at him as he shivers and moans under you begging for more. ");
        if (player.hasBalls()) outputText("You feel your [balls] churning, heavy with thick seed that you can’t wait to pour into him.");
        else outputText("You feel heat welling up in your middle, your cock swelling in preparation of the filling you’re going to give him.");
        outputText(" With one last thrust you ready yourself for release, smacking those firm cheeks one more time, only to let out a strangled groan as your cock pulses within him with no effect,");
        if (player.hasBalls()) outputText(" your balls tightening and clenching as " + (player.balls == 1 ? "it gets" : "they get") + " hotter and hotter");
        else outputText(" while the heat in your belly blazes into an inferno");
        outputText("[if (player.hasKnot) and your knot swells, further plugging you inside him]. ");
        if (player.cocks.length > 1) outputText("Your other " + (player.cocks.length > 2 ? "cocks only manage" : "cock only manages") + " to spurt white tinged pre that dribbles down your lengths. ");
        outputText("His tight ring stopped you from cumming like some sort of buttslut cock ring!\n\n");
        outputText("The cockatrice however cums explosively, his bumpy purple length spurting thick reptile cream along the ground and up his chest, some even reaching the underside of his beak before trailing off. "
            + "He quivers under you, spent and panting, while you try to thrust your way to completion as his sphincter loosens its grip and he relaxes in post orgasmic haze. "
            + "You cum with a whimper"
            + "[if (cumNormal) spurts of cum coating his insides|"
            + "[if (cumMedium) as ropes of cum coat his insides, filling him to the brim with heat|"
            + "[if (cumHigh) as thick jets of cum coat his insides, filling him entirely and spurting out around your [cock]| "
            + "as you flood his ass, cum coating his insides and backwashing the pair of you into a sticky mess]]], while the heat "
            + "[if (player.hasBalls())and tightness in your [balls]|in your belly] finally begins to subside.");
        if (player.cocks.length > 1) outputText(" Your other " + (player.cocks.length > 2 ? "cocks coat" : "cock coats") + " his behind further, leaving his ruffled feathers and the underside of his tail a sticky mess, a satisfying sight making his ass look thoroughly claimed.");
        outputText("\n\nYou slip out of him with a wet slurp "
            + "[if (player.hasKnot)although your knot makes it a little difficult] and you let yourself fall back onto the ground, marveling at how you’ve fucked his tight ass into a hungry dripping hole. "
            + "You rest for a while before cleaning yourself up"
            + "[if (hasArmor) and redressing], fully satisfied by this encounter. You leave him there resting and wonder if you’ll get to do this again next time.");
        player.sexReward("no", "Dick");
        cleanupAfterCombat();
    }

    //Cockatrice gives the PC a blowjob
    private function cockatriceOralCock():void {
        clearOutput();
        outputText("You casually approach him [if (hasArmor)stripping your [armor] and tossing it aside confidently], admiring his prone form. "
            + "The cockatrice lies on his back, tail lazily resting between his legs as he runs a clawed finger over his pecs. "
            + "His sapphire eyes are fixed firmly on you, drinking in your naked form. "
            + "His eyes linger on your [if (hasBreasts)[breasts]|chest] for a while, making your nipples pebble before trailing down to your [cock], your erect shaft[if (cocks > 1)s] making him lick his lips.\n\n");
        outputText("He definitely knows what you expect of him, which makes this a lot easier.\n"
            + "\"<i>Time for a little fun.</i>\" you smile as you stand over him and cup his fluffy cheek, guiding him towards your shaft. "
            + "He willingly opens his beak, forked tongue snaking out to drag along the [cockhead] in a torturously slow lick. "
            + "The forked tips tease your urethra as he withdraws, making you shudder. "
            + "He seems pleased with this, licking you again, his flexible tongue curling around your length as he tastes you base to tip. "
            + "His movements become bolder as you encourage him with affectionate rubs of the cheek, and before long he’s actively slurping along your length, swirling around the tip as it begins to bead precum."
            + "[if (hasBalls) He gently laps at your [balls] every now and then, ensuring they get as thorough a tongue bath as your shaft"
            + "[if (hasVagina) and even lifts them up to give your feminine half a good taste too.]|"
            + "[if (hasVagina) Occasionally his tongue slips further down, seeking out your heated slit, refusing to leave your feminine half untouched.]]\n\n");
        outputText(images.showImage("cockatrice-ridehim-oral"));
        outputText("Once you’re covered in a shiny layer of saliva, he takes [if (player.longestCockLength > 12) as much as he can manage of] your length into his mouth. "
            + "His beak is surprisingly soft, more like a firm rubber, and wonderfully warm and wet inside. "
            + "You guide his movements as you sigh in pleasure, helping him establish a steady rhythm as he gently sucks. "
            + "His tongue pushes up against you with each withdrawal, making sure you get all the stimulation he can offer to the tip. "
            + "He strokes himself as he sucks, hungrily devouring your length like a worm in response to your moans. "
            + "You can feel yourself beginning to twitch and pulse in his mouth, your hips starting to jerk with each of his movements and you lace your hands into his feathers, cupping the back of his head.\n\n");
        outputText("With a moaning whisper of encouragement you thrust your hips harder, burying "
            + "[if (player.longestCockLength <= 12)your cock in his throat|as much of your cock in his throat as you can], "
            + "reveling in the tight space and sudden spasms that almost crush your length. "
            + "His eyes water as he tries to keep up, pretty much humping his hand, while his free hand comes up to "
            + "[if (hasBalls)cup your [balls][if (hasVagina) and thumb your slit]|[if (hasVagina)thumb your slit|cup your behind]]. "
            + "You feel [if (player.hasBalls())your balls clench up as they flood with heat|heat pool in your belly] as your cock jerks, before you explosively release into his belly."
            + "[if (cumNormal) A few ropes of cum fill his belly, with the last spurt painting his tongue as you withdraw.|"
            + "[if (cumMedium) A few thick ropes of cum fill his belly, with the last spurt filling his mouth as you withdraw.|"
            + "[if (cumHigh) Thick ropes of cum flow into his belly, with you flooding his mouth as you withdraw. His cheeks bulge but he manages to contain most of it, with only a little dribbling down his chin.| "
            + "Thick streams of cum flood into his belly actively bloating him into having a little paunch. "
            + "You withdraw from him slowly, flooding his mouth just as much. His cheeks bulge before he gags, your virility just too much for him to handle as cum spills from his beak and down his chest. "
            + "The final jets you release into the open, giving him a facial that makes his feathered features turn blue to white.]]]\n\n");
        outputText("You let yourself fall to [if (isNaga)your coils|[if (isGoo)the ground|your knees]], panting"
            + "[if (hasVagina)while your pussy gushes] and heavily as you enjoy the post orgasmic glow in your now spent organ[if (cocks > 1)s]. "
            + "Once you get your strength back you [if (hasArmor)redress and] look over at the Cockatrice. "
            + "He’s laid on the ground with a content and sleepy gaze [if (cumQuantity > 1000) under those layers of thick cum], hands on his belly and spent member. "
            + "He gives you a smile, blushing as he lets out a small belch. Seems he enjoyed himself as much as you did. Waving goodbye you turn to return to camp.");
        player.sexReward("saliva", "Dick");
        cleanupAfterCombat();
    }

    //Cockatrice gives the PC a blowjob
    private function cockatriceOralVag():void {
        clearOutput();
        outputText("You casually approach him[if (hasArmor) stripping your [armor] and tossing it aside confidently], admiring his prone form. "
            + "The cockatrice lies on his back, tail lazily resting between his legs as he runs a clawed finger over his pecs. "
            + "His sapphire eyes are fixed firmly on you, drinking in your naked form. "
            + "His eyes linger on your [if (hasBreasts)[breasts]|chest] for a while, making your nipples pebble before trailing down to your [pussy], your [pussy] making him lick his lips.\n\n");
        outputText("He definitely knows what you expect of him, which makes this a lot easier.\n");
        outputText("\"<i>Time for a little fun.</i>\" you smile as you stand over him and cup his fluffy cheek, guiding him towards your slit [if (player.hasBalls())as you move your balls out of the way]. "
            + "His forked tongue slips out as he opens his beak, gently running over your mound as his hot breath tickles your [if (vaginalWetness <= 2)slick|slopping] lips. "
            + "You whine a little, wanting him to lick with more force, before pushing into his beak a little harder. "
            + "Your clit rubs against the curve of his beak, the firmness against your [clit] exquisite. His tongue delves into your slit, suddenly startling you as it curls up into you before stroking through your puffy wet lips. "
            + "The flick against your clit as he moves his head back coupled with the drag of his firm beak make your knees jerk and your tunnel clench.\n\n");
        outputText(images.showImage("cockatrice-ridehim-cunnilingus"));
        outputText("He slips his scaled hands around your backside, cupping your cheeks with his thumb claws scratching you lightly. "
            + "With a slow and deliberate movement he pulls you close and begins to lick you with firm and confident strokes, eager to drink your feminine nectar. "
            + "His cock stands[if (hasCock = true) like your own,] painfully erect, pre beading at the tip and slowly sliding down the shaft like wax from a candle. "
            + "Grinding his face into your needy [cunt], his tongue delves into your tunnel, writhing along your inner walls, seeking out that deep, spongy spot. "
            + "A warmth builds within your belly, a coiling tightness causing you to seek out a matching rhythm to his tongue.\n\n");
        outputText("With a melodic hum that travels through his beak and up into your eager bitch-button, his tongue thrusts up against that elusive spot, causing your knees to lock, trapping his face between your thighs. "
            + "Your [cunt] spasms, trying to milk the intruder as though it were a cock as you thoroughly juice yourself. "
            + "As you ride out your orgasm [if (hasCock = true)your cock weakly shooting into the air,] the cockatrice tries to drink up as much of your juices as he can, the rest dripping down his chin and chest. "
            + "Panting as you blissfully let the fuzzy post orgasmic haze engulf you, you step back, admiring the way he glistens with your honey, his feathers matted.\n\n");
        outputText("Once you get full control of your [if (isNaga)coils|[if (isGoo)mound|legs]] back, you [if (hasArmor)redress and] thank him for his efforts, kissing him on the tip of his beak and tasting yourself on him. "
            + "You then turn to leave, listening to the lazy ‘fap’ of him working his purple shaft as he lick himself clean.");
        player.sexReward("saliva", "Vaginal");
        cleanupAfterCombat();
    }

    //Cockatrice buttfuck (Taur version)
    private function cockatriceTaurButtFuck():void {
        clearOutput();
        outputText("As you decide what to do with the cockatrice, your loins heated with arousal, you realise a you’ll have a hard time managing anything, what with your tauric form being less than compatible with what many folk are packing. "
            + "Looking around briefly, you notice an alcove on the mountainside which spawns a brilliant idea. "
            + "You could use the rock to pin him at the right height to fuck your ass with that nubby reptile cock of his. Talk about between a rock and a hard place!\n\n");
        outputText("Grabbing his arm you lead him to the gap, turning before pinning him eagerly with your rump, grinding your tauric rear against him enthusiastically. "
            + "His surprised squawk quickly devolves into a moan like cooing as his hard cock is engulfed in the embrace of your [hips]. "
            + "His fluffy plumage tickles your thighs, while his scaled belly glides across your flesh. "
            + "Each bounce of your rear rubs his thighs against your [if (player.hasBalls())ball[if (player.balls > 1)s]|[if (hasVagina)cunt|butt]] while his member prods at your backdoor, slowly lubing you up with his slick pre. "
            + "His clawed fingers grip your flanks tightly as he tries to push into you, but your grinding ensures he can’t get the angle right. "
            + "At one point you purposefully push against him hard, feeling his cock crushed between your bodies as he whines with need.\n\n");
        outputText("\"<i>P-please...</i>\" he hisses as his claws dig into your flesh, his round pupils making his begging cute but pitiful. "
            + "You contemplate playing with him longer, idly toying with the idea of rubbing him to release a few times, only to pin him again and get him wonderfully backed up.\n");
        outputText("\"<i>Show me how much you want it.</i>\" you say with a smirk, looking over your shoulder at him. With a grunt of effort and purple flushed cheeks he nods, stilling himself suddenly. Confusion is evident on your face before your expression melts into a shocked ‘o’. "
            + "Something has squirmed up against your [if (hasVagina)pussy|[if (player.hasBalls())ball[if (player.balls > 1)s]|cock]], something thick and scaly, rubbing itself over you like a perverse fleshy dildo, seeking out your genitals with surprising accuracy."
            + "[if (hasVagina == false)It coils around your cock, squeezing you in tight pulses[if (player.hasBalls()) as closer to the base gently rubs back and forth against your [balls]], hugging you in a warm and soft sheath that flexes with each movement. That’s one impressive tail!|"
            + "It prods the entrance to your pussy, the tapered tip slowly working its way in and stretching you as more of it follows. Slow thrusts cause the scaly appendage to rub your clit each time it stretches you wide, making you feel full as you clench around the intruder. That’s one talented tail!] "
            + "All the while his cock remains pressed against your back door, twitching and oozing as his tail works your sex.\n\n");
        outputText(images.showImage("cockatrice-ridehim-taur-buttfuck"));
        outputText("With a quick shift of your hips and a dip of your forelegs, you manage to slip his length into your [if (analLooseness <= 1)tight|practised] passageway, reveling in the dual stimulation you are receiving. "
            + "His nubby length drags along your walls with each backward thrust you make, while those delightful bumps tease your [if (analLooseness > 1)stretched|eager] ring on each exit. "
            + "His tail’s ministrations lessen as you fuck yourself on his cock, his hips bucking to meet you each time you thrust instead. "
            + "[if (hasVagina == false) The looser grip on your cock lets you glide through his coiled tail with ease, giving you a smooth tailjob, with his tail tensing each time you clench on his purple prick.| "
            + "Though his tails thrusts are weaker now, your movements make up for it, fucking you on both his cock and his tail, the two tapered lengths rubbing against other another through the thin wall separating them.] "
            + "His cock twitches as his claws dig into your rear, his hips pumping into you hard as he pulls you against him as best he can. "
            + "With a forceful thrust he blows his load in your ass, seed coating your innards while his tail [if (hasCock = true)ripples around your cock|thrusts deep into your cunt]. "
            + "Your[if (hasCock = true) cock twitches and bloats as he wrings your length, shooting your load onto the ground[if (cumQuantity > 350) forming a sizable puddle beneath you].| "
            + "cunt spasms as he hits your cervix, coating his tail with femcum as you shudder[if (issquirter), liberally soaking your crotch and his thighs before tapering off].] "
            + "You both remain there panting for a while, your legs struggling to hold both of you up while you enjoy the warmth in your gut. "
            + "You slowly separate and help one another to a more comfy spot where you can recover.\n\n");
        outputText("Once you feel your strength return to your legs you bid him farewell, noting you may have actually tired him out as he curls up for a nap, feathers puffed out at random angles from your rough treatment.");
        player.sexReward("cum", "Anal");
        player.buttChange(80, true);
        cleanupAfterCombat();
    }

    //Cockatrice buttfuck (Drider version)
    private function cockatriceDriderButtFuck():void {
        const CHOICE_PUSSY:int = 1;
        const CHOICE_COCK:int = 2;
        var choice:int;
        if (player.hasCock() && player.hasVagina()) choice = rand(2) == 0 ? CHOICE_PUSSY : CHOICE_COCK; //50/50 chance for herms
        else choice = player.hasVagina() ? CHOICE_PUSSY : CHOICE_COCK;

        clearOutput();
        outputText(images.showImage("cockatrice-ridehim-drider"));
        outputText("As you decide what to do with the cockatrice, your loins heated with arousal, you realise that you’ll have a hard time managing anything, what with your spider-like form being less than compatible with what many folk are packing. "
            + "Looking around briefly, you notice an alcove on the mountainside which spawns a brilliant idea. "
            + "You could tie him up in there and get him to use that nubby reptile cock to fuck your ass!\n\n");
        outputText("Taking him by the hand, you lead him to the alcove before using some of your spider silk to tie him up by his arms, holding him in between the two walls. "
            + "He struggles a little before you shush him and turn around.\n");
        outputText("\"<i>I’m gonna fuck you nice and hard.</i>\" you smile as you back up, positioning your abdomen below him so his thighs rest either side of it, like some kind of parody of him riding you. "
            + "As he slides towards where your human and spider halves meet, you feel his length pressing between your "
            + "[if (buttRating <= 4)tight|plush] cheeks while his feathered thighs hug your hips.\n\n");
        outputText("You gently rock back and forth, making his length grind [if (buttRating <= 4)against|between] your cheeks as he swings slightly. "
            + "As you use your behind to tease his girthy cock you run your hands over your chest [if (hasbreasts)cupping your [breasts]|trailing over your pecs] as you pinch your [nipples]. "
            + "You feel wetness trail down your crack, the cockatrice breathing heavily as he enjoys the show and his cock slides against your pucker easier. "
            + "The nubby texture of his cock makes you shudder, your asshole quivering as your [if (hasCock = true)[cock] hardens|[cunt] moistens].\n\n");
        if (choice == CHOICE_PUSSY) {
            outputText("You chuckle as you slip two fingers into your [pussy], exaggerating each thrust and moan as you continue to rock against his freely leaking cock. "
                + "You look at the cockatrice over your shoulder with a lusty gaze as you pick up speed, starting to schlick yourself with earnest, your clit poking out and begging for your touch."
                + "[if (player.hasBalls()) You cup your [balls] with your free hand, rolling them between your fingers as they begin to roil with seed]"
                + "[if (player.hasBalls() && hasCock), while][if (hasCock = true) your [cock] smears pre on your belly in a steady bubbling stream, wanting to be buried in a warm, snug hole.] "
                + "Before long your pussy is leaking nectar as you flick your [clit] while you dip your fingers into your hot and sticky passage, coating them liberally before you wave them under his nose teasingly. "
                + "His nostrils flare and he moans, shaking his hips to hump at you as best he can, your lusty scent speaking to his pleasure drunk mind. "
                + "You slip your fingers into his mouth and he greedily sucks them clean with closed eyes, jumping out of this submissive bliss as you spear yourself on his cock.");
        } else {
            outputText("You chuckle as you stroke your [cock], exaggerating each stroke and moan as you continue to rock against his freely leaking cock. "
                + "You look at the cockatrice over your shoulder with a lusty gaze as you pick up speed, starting to jack yourself as pre beads at the tip."
                + "[if (player.hasBalls() || hasVagina) You [if (player.hasBalls())cup your [balls], rolling them between your fingers as they begin to roil with seed]"
                + "[if (player.hasBalls() && hasVagina) and you][if (hasVagina) feel your pussy slowly leak juices, coating your thighs in sticky girl juices while ignored].] "
                + "Before long a steady stream of pre leaks from your [cock] and you run a fingertip through it before waving them under his nose teasingly. "
                + "His nostrils flare and he moans, shaking his hips to hump at you as best he can, your lusty scent speaking to his pleasure drunk mind. "
                + "You slip your fingers into his mouth and he greedily sucks them clean with closed eyes, jumping out of this submissive bliss as you spear yourself on his cock.");
        }
        outputText("\n\nThe pair of you spend a moment enjoying the sensation of you finally being joined before you buck your hips, starting to use the swaying silk ropes to make him fuck your [if (analLooseness <= 1)tight|spread] butthole. "
            + "As his length pulls out, the nubs slowly drag and catch on your inner walls, rubbing on your entrance as each one pops out before rapidly spearing you again as he buries his length in you, spreading you open[if (hasCock = true) as the pointed tip prods your prostate]. "
            + "Each thrust fills the silence with moans and the slap of flesh on flesh, your behind slowly becoming a little rosy from the force of fucking. You continue to pleasure yourself as you rhythmically clench your tunnel, eager on making him fill you before you cum. "
            + "The cockatrice’s cock twitches in your ass as he grips your hips with his thighs, humping at your behind desperately as he tried to hold back. "
            + "With a pulsing shudder, his cock swells and lets loose rope after rope of hot cum deep into your ass. "
            + "He nips your shoulder as he empties himself into you, triggering you to lose your cool. You cum hard,"
            + "[if (hasCock = true) your [cock] spurting pearly white cum against the wall"
            + "[if (cumQuantity > 350) painting it white by the time it stops]][if (hasCock == true && hasVagina == true) and]"
            + "[if (hasVagina) your [pussy] soaking your thighs as your walls flutter]"
            + "[if (player.hasBalls()), heat spreading through your clenched [balls] as "
            + "[if (player.balls > 1)they slowly relax|it slowly relaxes]].\n\n");
        outputText("You slowly move away and blush as your pucker feels cold, no doubt from the absence of his girthy member. "
            + "Turning as you try to retain your composure while seed slowly drips down your cheeks, you untie the cockatrice and help him to the ground, rubbing his shoulders for a while as you both enjoy the afterglow in each other's company."
            + "Once you feel ready you bid him goodbye, teasingly saying you’ll have to come back again tomorrow, laughing as his eyes widen and his cock twitches slightly.");
        player.sexReward("cum", "Anal");
        player.buttChange(80, true);
        cleanupAfterCombat();
    }

    private function rideCockatriceForeplay(nextFun:Function):void {
        clearOutput();
        outputText("You slowly make your way over to the cockatrice, ");
        player.biggestTitSize();
        if (!player.armor.isNothing) outputText("stripping out of your [armor] as you approach, ");
        outputText("standing over him as you give him a good look over. Now he isn’t rushing you, you can see he has quite the charming face, a dashing mix of mischievous and kind. As you present yourself to him, he looks up at you, ");
        if (player.biggestTitSize() >= BreastCup.H) outputText("or at least tries to, his view of your face obstructed by your bountiful breast flesh.");
        else outputText("as if asking for permission with his gaze. While he may be head level with your groin which would suggest your intent, he hasn’t moved to touch you once.");
        outputText(" The moment you tell him to start he smiles, scaled hands slowly sliding up the back of your [if (isNaga)serpentine lower body|calves]."
            + " Surprisingly smooth and warm, his powerful grip massages up your [if (isNaga)tail|legs], palms coming to rest on your [butt] as he leans forward."
            + " The heat of his breath on your [if (hasCock = true)[cocks]|[if (hasVagina)[vagina]|crotch]] makes you shudder.\n\n");
        sceneHunter.selectGender(dickF, vagF, assF, null, 0);

        function vagF():void {
            outputText("With a slowness that seems unnatural for a creature that was moments ago bouncing around like a ferret hopped up on sugar, he licks at your folds, his forked tongue dragging over your clit as he nuzzles you affectionately. "
                + "He slowly increases his pace, his tongue dipping into your [vagina] with each lick. "
                + "He nuzzles your clit as he drives his tongue deeper, fucking you with his tongue with each leisurely flick. "
                + "His clawed fingers grip your [butt] a little tighter as he looks up at you beggingly. "
                + "His purple member is slick with pre, his hips gently pumping with the desire to sheathe himself in your slick cunt."
                + "[if (hasCock = true) Your neglected [cock longest] leaks in arousal, pre beading at the tip as you contemplate how you want this.]");
            nextFun();
        }

        function dickF():void {
            var cockLength:Number = player.longestCockLength();
            outputText("With a slowness that seems unnatural for a creature that was moments ago bouncing around like a ferret hopped up on sugar, he licks tentatively at your hardening [cock longest], his forked tongue slowly flicking across the tip."
                + "[if (hasVagina) Your pussies walls shudders in sympathetic pleasure, disappointment of not being filled ignored as your bodies shared pleasure helps temporarily sate your dual sexes.] "
                + "Opening his beak he slowly engulfs the head, his tongue curling around it as he sucks. "
                + "You’re surprised by how soft his beak is, the edge not hard and sharp as you had expected, but more like a layer of firm rubber. "
                + "You groan and slide your hands into his feathers, gently rubbing behind his feathered ears as encouragement. "
                + "He eagerly shoves more of your cock into his mouth with a slight purr, his forked tongue flicking over the tip as he rubs and kneeds your buttcheeks. ");
            if (cockLength <= 5) {
                outputText("As the wet heat of his mouth and the gentle suction tease your [cock longest] you can’t help but force your length deeper into his mouth, your hips pumping gently. "
                    + "He takes your length with ease, his beak brushing against your crotch [if (hasVagina) your slit dripping | as your [balls] hit his chin] with each thrust.");
            } else if (cockLength <= 12) {
                outputText("As the wet heat of his mouth and the gentle suction tease your [cock longest] you can’t help but force your length deeper into his mouth, your hips pumping gently. "
                    + "With some difficulty he manages to take your length, your [cock longest] entering his throat with each stroke. "
                    + "His beak brushes against your crotch [if (hasVagina) your slit dripping | as your [balls] hit his chin] with each thrust.");
            } else if (cockLength <= 18) {
                outputText("As the wet heat of his mouth and the gentle suction tease your  [cock longest] you can’t help but force your length deeper into his mouth, your hips pumping gently. "
                    + "He barely manages to take your length, his throat bulging obscenely as you thrust.");
                if (player.hasVagina() || player.hasBalls()) {
                    if (player.hasVagina()) outputText(" Your slit drips");
                    if (player.hasBalls()) outputText(" [if (hasVagina)and your|Your] [balls] swing[if (player.balls == 1)s] roughly");
                    outputText(" with each cock sheathing thrust.");
                }
            } else /* if (cockLength > 18) */ {
                outputText("As the wet heat of his mouth and the gentle suction tease your [cock longest] you can’t help but force your length deeper into his mouth, your hips pumping gently. "
                    + "Unfortunately your sheer size halts you making much progress, much of your length still simply exposed to the open air, rather than buried deep in his clenching throat.");
                if (player.hasVagina() || player.hasBalls()) {
                    if (player.hasVagina()) outputText(" Your slit drips");
                    if (player.hasBalls()) outputText(" [if (hasVagina)and your|Your] [balls] swing[if (player.balls == 1)s] roughly");
                    outputText(" with each incomplete thrust.");
                }
                outputText(" You notice his purple member is slick with pre, straining out of his genital slit."
                    + " You contemplate how you could best use this as you drag your length out of his throat.");
            }
            nextFun();
        }

        function assF():void {
            if (player.gender == 0) outputText("With a slowness that seems unnatural for a creature that was moments ago bouncing around like a ferret hopped up on sugar, he examines you with a curious look. Your lack of genitals seems to have stumped him. ");
            outputText("After a moment of silence you sigh, removing yourself from his grip and drag him over to a nearby rock. "
                + "The flat slab is perfect for you to bend over, presenting your [ass] to him with a slight wiggle. "
                + "Your [breasts] rub gently against the cool surface as you tell him to get you nice and slick.\n\n");
            outputText("Your [nipples] [if (hasNippleCunts == true || isLactating == true)moisten|harden] as you feel the heat of his breath against your cheeks, his clawed fingers gently digging in as they spread your cheeks so that your [butthole] is exposed. "
                + "You shiver as his moist breath ghosts over your fluttering tunnel, gasping as something thick and wet begins to probe your depths. "
                + "His tongue pushes past your ring of muscle with ease, its reptilian forks tickling your sensitive inner walls. "
                + "As his tongue retreats his hands slide up your sides, gripping your [hips] as he then gives your crack a long, hard lick. "
                + "As his tongue flicks against your cheeks, you grind your [chest] across the rock, a painful pleasure delighting your senses.");
            outputText("His next rough lick is in a circular motion, punctuated by affectionate nips to your [butt] before jabbing his tongue back inside you. "
                + "You know that at this point he’s slipped at least an inch of tongue into you, and he doesn't seem inclined to stop until he’s tasted as much of you as he can. "
                + "As he works his tongue deeper you hear him whimper. With a smirk you turn your gaze to his thick purple member, his throbbing length straining against his belly, a slick trail of pre painting his scales. "
                + "You decide he’s done a good job on getting you warmed up with that tongue of his, now its time to see if he’s just as good with that thick cock of his.");
            nextFun();
        }
    }

    //Player Defeated:
    public function loseToCockatrice():void {
        clearOutput();
        sceneHunter.selectLossMenu([
                [0, "Oral", cockatriceLossOral],
                [1, "Vaginal", cockatriceLossVaginal, "Req. a vagina", player.hasVagina()],
                [2, "Anal", cockatriceLossAnal]
            ],
            "As [themonster] approaches, you can only hope that he's not going to just leave you to here for other creatures to fuck. Maybe force him to do something right now?"
        );
    }

    //Player lost -> Anal sex
    public function cockatriceLossAnal():void {
        clearOutput();
        outputText("You fall to the ground [if (hp <= 1)utterly exhausted|too aroused to continue]. "
            + "The Cockatrice, knowing that he’s won, approaches you slowly, eyes roving over your body hungrily. "
            + "[if (hasArmor) He makes short work of your [armor], tossing it aside with little care.] "
            + "With a sudden lunge he pins you to the ground, your wrists held under his scaled hands and your [if (isNaga)coils trapped beneath|[if (isGoo)mound trapped beneath|legs spread around]] his curved hips. "
            + "His thick purple cock eagerly pokes from his genital slit as it rubs against [if (hasCock = true)your own [cock]|your belly], smearing you with viscous pre-cum.\n\n");
        outputText(images.showImage("cockatrice-loss-butt"));
        outputText("With a buck of his hips as he shifts forwards, he forces you to curl up enough for his cock to press insistently at your rear entrance while [if (isNaga)your coils are bunched up beneath him|[if (isGoo)mound is bunched up beneath him|your legs hook over his hips]]. "
            + "The slick heat that is spread against your pucker makes you flush as his tapered tip teases you open. "
            + "You can’t help but feel [if (hasCock = true) your [cock] harden under his steady but persistent assault] "
            + "[if (hasCock == true && hasVagina == true) and ][if (hasVagina) your pussy moistens as he buries himself in you] "
            + "[if (hasCock == false && hasVagina == false)your tunnel flutter and try to draw this intruder deeper], "
            + "his bumpy cock [if (analLooseness <= 1)slowly stretching you wide|sinking into your practised tunnel].\n\n");
        outputText("He begins to withdraw letting cool air rush in the gap he left behind before plugging you again, rocking his hips back and forth until he bottoms out in your heated asshole, the nubs along his length making your ring twitch as they enter and exit. "
            + "He picks up the pace, moaning and nipping your [if (hasBreasts)breasts|chest] as he leans forward. "
            + "You can’t help but move your hips with him, burying his length in you as deep as you can so that it "
            + "[if (hasCock = true)hits your prostate, making you spurt weak ropes of cum|rubs the spot where your walls are thinnest, sending jolts of pleasure to your empty but dripping pussy].\n\n");
        outputText("Breathy moans and the slap of flesh on flesh fills the quiet mountainside as the cockatrice’s thrusts become more and more erratic, his cock twitching in your pucker. "
            + "Before long his cock pulses, shooting jet after jet of hot cum deep into your rectum as he slumps over you. "
            + "As he fills you with wet, thick heat you join him in orgasm[if (hasCock = true) your cock spurting your creamy load over both of your bellies]"
            + "[if (cumQuantity > 350) drenching you both thoroughly][if (hasCock == true && hasVagina == true) while ]"
            + "[if (hasVagina) your pussy clenches and soaks your thighs with girl cum which drips down your crack]"
            + "[if (hasCock == false && hasVagina == false) your ass eagerly milking him for all he can give as heat pools in your belly, your mind going blank in pleasure].\n\n");
        outputText("He withdraws his softening member with a wet ‘slurp’ and stands up, leaving your prone form on the ground as you drift to sleep in a post orgasmic haze. "
            + "The last thing you see is his swinging tail and feathered rump as he happily continues on his way.");
        player.buttChange(80, true);
        player.sexReward("cum", "Anal");
        cleanupAfterCombat();
    }

    //Player lost -> Vag sex
    public function cockatriceLossVaginal():void {
        clearOutput();
        outputText("You fall to the ground [if (hp <= 1)utterly exhausted|too aroused to continue]. "
            + "The Cockatrice, knowing that he’s won, approaches you slowly, eyes roving over your body hungrily. "
            + "[if (hasArmor)He makes short work of your [armor], tossing it aside with little care.] "
            + "With a sudden lunge he pins you to the ground, your wrists held under his scaled hands and your [if (isNaga)coils trapped beneath|[if (isGoo)mound trapped beneath|legs spread around]] his curved hips. "
            + "His thick purple cock eagerly pokes from his genital slit as it rubs against [if (hasCock = true)your own [cock]|your belly], smearing you with viscous pre-cum.\n\n");
        outputText(images.showImage("cockatrice-loss-vag"));
        outputText("He gently rubs the tip of his member against your [cunt], parting the lips gently and nuzzling your [clit] enough to make you gasp. "
            + "Your [if (vaginalWetness <= 2)drenched|wet] slit clings to his cock as he slowly enters you, spreading your cunt as his shaft widens. "
            + "[if (player.hasBalls() || hasCock)Your [if (hasCock = true) hard [cock] gently twitches, batting against your belly as he spears you on his shaft][if (player.hasBalls() && hasCock) and your][if (player.hasBalls()) [balls] bounce as he thrusts into your slick snatch.]] "
            + "As he pulls back, your inner walls cling to him like a lovers embrace, making those delicious bumps rub your g-spot with considerable force.\n\n");
        outputText("He’s soon pumping into you like a rutting beast, stirring up your insides. "
            + "Each gasp he draws from you spurs him on as he eagerly hilts himself with each thrust. "
            + "He leans over you and peppers your [if (hasBreasts)breasts|chest] with gentle nips, his thick forked tongue then darting out "
            + "to soothe your skin[if (isLactating), before settling on hungrily suckling from you, his tongue swirling around your [nipples] so he doesn't miss a drop].\n\n");
        outputText("A telltale pulsing in his member signals he’s close, and as his thrusts become jerky he slips both your wrists under one hand, the other coming down to rub at your [clit]. "
            + "You come undone at his lust driven touches, your [pussy] fluttering around him as you [if (vaginalWetness <= 2)coat|drench] him with femcum. "
            + "[if (player.hasBalls() || hasCock)Your [if (player.hasBalls()) [balls] tighten and flush with heat] "
            + "[if (player.hasBalls() && hasCock)as your][if (hasCock = true) [cock] spurts jets of sticky cum in sympathetic orgasm, "
            + "coating your bellies[if (cumQuantity > 350) as well as your chests[if (hasBreasts), the underside of your [breasts] receiving most of the blast]].]]\n\n");
        outputText("He fills your sensitive pussy with rope after rope of thick cum, bathing your womb in his virile contribution before pulling out. "
            + "He straightens up as his cock begins to retreat into his genital slit, wiping himself  clean before leaving you there on the ground. "
            + "As your mind grows fuzzy with post orgasmic contentment and you long for sleep, the last thing you see is the cockatrices swaying hips and tail as he continues on his way with a spring his step.");
        player.cuntChange(monster.cockArea(0), true);
        player.knockUp(PregnancyStore.PREGNANCY_COCKATRICE, PregnancyStore.INCUBATION_COCKATRICE);
        player.sexReward("cum", "Vaginal");
        cleanupAfterCombat();
    }

    public function cockatriceBirth(womb:int = 0):void {
        outputText(images.showImage("birth-cockatrice"));
        var kids:int = Math.floor(player.totalFertility() / 7);
        if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) kids *= 2;
		outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees. You realize something is about to be birthed, and you shed your [armor] before it can be ruined by what's coming. "
            + "A contraction pushes violently through your midsection, stretching your " + player.vaginaDescript(womb) + " painfully, the lips opening wide as something begins sliding down your passage. "
            + "A burst of pink slime soaks the ground below as the birthing begins in earnest, and the white chicken egg peaks between your lips. You push hard and the medium egg pops free at last, making you sigh with relief as it drops into the pool of slime. ");
        player.cuntChange(15, true, true, false);
        outputText("The experience definitely turns you on, and you feel your clit growing free of its hood as another medium egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably. "
            + "You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips. The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure. "
            + "Aroused beyond reasonable measure, you begin to masturbate your clit, stroking it up and down between your slime-lubed thumb and fore-finger. It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure. "
            + "You cum hard, the medium eggs each making your cunt gape slightly just before popping free. You slump down, nervous and barely conscious from the force of the orgasm.\n\n");
        player.orgasm('Vaginal');
        player.addCurse("sen", 3, 2);
        //(eggCounter)
        outputText("When you find yourself able to stand, you examine what it is you have birthed; " + num2Text(kids) + " medium, white eggs, the unmistakable shape of hen eggs. "
            + "You pick up one and hold it gently against your ear; inside, you can hear a tiny heart, beating so fast. "
            + "You put it down carefully with his fellows and stare at your clutch, a queasy tangle of emotions tugging at you. "
            + "There is nothing else to be done: you will have to take this clatch to your camp\n\n");
        outputText("When the light of day breaks, you wake up and see a clutch of eggs still resting in a puddle of pink slime. All are empty, and tiny cocks against it. They have pink chests, flanks, front legs, heads, necks, and a long stretch of their backs. "
            + "You slowly drag yourself into a sitting position, in front of you finally are a dozen newly hatched cockatrices, crawling around on all fours, the wetness of their eggs slowly drying on their feathers, licking each other, flicking their cock tails around and blinking at their surroundings with eyeballs huge in their tiny heads as interest in the wider world takes hold. "
            + "You can't say whether you find the sight insanely cute or utterly disgusting, and you don't know whether the reason you can't look away is because you are fascinated by the creatures you have brought into this world, or because of the effect of " + (num2Text(kids)) + " baby cockatrice eyes on you. "
            + "You suspect in either case the answer is a bit of both.\n\n");
        outputText("They seem to quickly adapt to where they have found themselves, running around each other with increasing confidence, and you can see even in the short time you have been watching they have grown, their tender feathers hardening as the sun and air beats down on them. "
            + "One of them suddenly scuttles like the cock it is for cover, and you lose it from view behind bushes. They are quickly all at it, one after the other dashing and slipping from view. "
            + "The last to go is the largest, the first to hatch: it fixes you with its stare before slowly turning and following suit. You could swear it gives you the smallest of smiles, a child's eager grin, before it goes. "
            + "The only evidence you have left of what just happened is a slimy pile of discarded eggshells.\n\n");
        if (player.cor < 33) outputText("You find yourself shaken by the experience, and deeply disquieted by the thought of the clutch of monsters you have unleashed on this world. You pick yourself up, rub yourself down and leave, promising yourself fervently you'll be more careful around cockatrices in the future.");
        else if (player.cor < 66) outputText("You pick yourself up, rub yourself down and leave. You feel conflicted about what just happened; on the one hand you feel disquieted about the dozen monsters you just unleashed on this world, on the other you cannot help feel oddly proud of them and yourself.");
        else outputText("With a soft smile, you get up and leave, enjoying the sensation of pink slime trickling down your legs. You cannot wait to get pregnant again, for your stomach to bulge with eggs, to release more delightful creatures into this world which can grow up to fuck you and everyone else in turn, so everyone can enjoy life as much as you do.");
        if (player.hips.type < 25) {
            player.hips.type++;
            outputText("There's an extra thickness to your [hips] as well.");
        }
        cleanupAfterCombat();
    }

    //Player lost -> Taur/Drider oral
    public function cockatriceLossOral():void {
        clearOutput();
        outputText("You fall to the ground [if (hp <= 1)utterly exhausted|too aroused to continue]. "
            + "The cockatrice stalks over to you, eyeing you up as he strokes his rapidly emerging cock. "
            + "His casual approach has you mesmerised, such calm confidence something you didn't expect from the  hyperactive reptile. "
            + "He cups your chin, looking into your eyes, letting you get lost in that electric blue gaze as he gently hums. "
            + "After a few moments he grabs you by the [if (hairLength > 0)[hair]|back of the head] and thrusts his thick purple member into your mouth. "
            + "You splutter around him, your tongue being pressed down under his length as musky pre-cum is smeared on the roof of your mouth. "
            + "You try to jerk away, but find your lower half unable to move, your multiple legs remaining still as you wriggle your upper half. He’s petrified you!\n\n");
        outputText(images.showImage("cockatrice-loss-oral"));
        outputText("He roughly fucks your face and all you can do is hold onto his biceps putting up a weak struggle. "
            + "His cock slides over your tongue with each thrust, the tip poking into your throat now and then [if (isBimbo) as you relax it so you can better swallow his cock|making you gag at each sudden intrusion]. "
            + "You suck at him, running the tip of your tongue along some of the bumps on his length and he settles down a little, thrusting slow and deep so you can do the work for him. "
            + "Encouraged by his response, you continue to work his shaft [if (isBimbo) your cock lust slowly clouding your thoughts, making you eager to worship the shaft "
            + "in your mouth|glad to minimise it battering into your throat while he coats your tastebuds in his unique flavor].\n\n");
        outputText("Before long he twitches in your mouth and his thrusts begin to pick up in pace, making him mash his pelvis into your [if (isBimbo)pillowy|spit slicked] lips. "
            + "His grip on your face tightens as his thrusts become more erratic, his cock pushing into your throat with each thrust and giving barely any reprieve. "
            + "Your throat [if (isBimbo)milks him|spasms around him] as he buries himself deep as he can in your warm, wet throat. "
            + "You feel his member bloat against your tongue before hot cum spills down your throat, warming your belly. "
            + "He slowly pulls out, letting the last spurts splash against your tongue, leaving his musky taste in your mouth.\n\n");
        outputText("He lets go of your face as he pants, walking around you until you can’t see him. "
            + "You shudder as his scaled hands run over your flanks, unsure what he’s going to do now. "
            + "Your arousal has leveled out, leaving you needy but rational, but you can’t help but wonder if he’s going to fuck you again. "
            + "To your surprise, he spends some time massaging your lower body, easing the tension in your muscles and making you relax under his firm but slow kneading. "
            + "All too soon he finishes, leaving you on the ground where you lay with little more than a wave. "
            + "At first, you panic, concerned that you’ve been left at the mercy of other creatures but as your leg twitches, you come to realise you can move again. "
            + "While somewhat leaden feeling, your body is no longer petrified, allowing you to leave the area slowly. "
            + "You smile a little, thankful for the massage that evidently released your joints from the spell of his eyes, wondering if next time you could just skip the fight and go straight to such a leisurely massage.\n\n");
        outputText("By the time you return to camp you feel a slight heat in your loins from the encounter.");
        player.sexReward("cum", "Lips", false);
        cleanupAfterCombat();
    }
}
}
