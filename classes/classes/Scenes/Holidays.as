package classes.Scenes {
import classes.Appearance;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.CoC;
import classes.CockTypesEnum;
import classes.DefaultDict;
import classes.EngineCore;
import classes.EventParser;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.ItemType;
import classes.Items.ConsumableLib;
import classes.PerkLib;
import classes.Player;
import classes.PregnancyStore;
import classes.Scenes.NPCs.JojoScene;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.Utils;

public class Holidays {
    public function Holidays() {
    }
    private static function get player():Player{
        return CoC.instance.player;
    }
    private static function get flags():DefaultDict{
        return CoC.instance.flags;
    }
    private static function get date():Date{
        return CoC.instance.date;
    }
    private static function get consumables():ConsumableLib{
        return CoC.instance.consumables;
    }
    public static function pumpkinFuckEncounter():void {
        EngineCore.awardAchievement("Pump-kin-kin-kin", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_I);
        EngineCore.clearOutput();
        EngineCore.outputText("Just ahead, in the middle of the path, lies a seeming innocuous gourd - a pumpkin to be precise.  The growth is oddly out of place.  Nothing else grows on the soft animal-forged path you now tread, and the pumpkin and its vines are moist, as if wet with morning dew.  They are the only plants in the vicinity to bear such moisture, gleaming dully in the muted arboreal light.");
        if (flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] > 0) EngineCore.outputText("  An old, haunting memory surfaces, and you realizes this seems... familiar.  Did you find this last year?  Yes... it could have been this very same pumpkin...");
        EngineCore.outputText("\n\nWhile startled by the vegetation's placement, it seems harmless enough."
                +"\n\nYou advance cautiously, extremely familiar with the traps and pitfalls that all-too-often prevail in this world.  The pumpkin's rind is bright orange, ripe and seemingly ready to bulge out.  The vines are thick, dark green, and reflective, partly thanks to the oozing moisture that drips from them to the floor.  After closing, it becomes clear that it isn't a coating of dew on the pumpkin but thick, viscous slime instead.  The clear, syrupy ooze begins to drip from the vines even as it rolls down the pumpkin, seeping out of the plant's skin in fat, heavy rivulets.");
        var fuck:Function = null;
        var mount:Function = null;
        if (player.hasCock()) {
            EngineCore.outputText("\n\nOne of the many indentations that mar the sphere's circumference seems deeper, darker than the others.  You lean a little closer, for a better look, and the shadowed fold ripples, then undulates, yawning wider and wider to reveal whole new shades of inky blackness.  It squelches, and a wide streamer of slime oozes out to slide down the side of the rind.  The puddle below the obviously tainted gord deepens with this new addition even as the wide-open rent widens.  A sweet, fruity smell rises from the opening, splattering out with a fresh wave of goop. This time, the passed slime leaves something different behind.\n\nWhere once the pumpkin had a midnight-black crevasse, it now has a fleshy, purplish gash.  The slime it exudes is more a fragrant nectar.  The rind around the opening appears cushy, and soft.  Best of all, the interior is as pink as any pussy you've ever seen, and as wet as a succubus's snatch.  You take a deep breath of the fruit's female musk and find yourself wondering: should you fuck it?");
            fuck = pumpkinFuck;
        }
        /* UNUSED DUE TO FEN LAZINESS {PC has tits}{NIPNUMBER} of the corrupted growth's vines rise up, slowly waving, snake-like in the air.  As if hypnotized, they lazily bob back and forth, drawing a few inches closer at the culmination of each movement.  You ready your [weapon], reading to defend yourself, but the slimy green tentacles pause at the new development, their tips opening to reveal plush green lips and slobbery purple tongues.  They lick at their lips, hungrily watching your {allChest] and waiting, biding their time.  They seem hungry for tits, and at the sight you feel your burgeoning milk readying to let down.  You could feed the plant, if you want to.  The idea is oddly compelling.  Do you?*/
        //Chick sauce
        if (player.hasVagina()) {
            EngineCore.outputText("\n\nThe stem of the pumpkin is long and proud, as well as knotted, barbed, ribbed, and flared like someone crafted the world's most perverted dildo to simultaneously resemble every type of cock in existence.  The tip bubbles constantly with slime like pre-cum oozing out of an erect phallus."
                    +"\n\nAs you gaze upon the stem, you can see it twitching like an actual penis and the aroma that comes from it is as enticing as what any incubus could produce.  You take a deep breath of the fruit's musk and find yourself wondering: should you mount it?");
            mount = mountPumpkin;
        }
        if (player.gender == 3) EngineCore.outputText("\n\nSo many choices, so little time.");
        //If PC has neither
        if (player.gender == 0) {
            EngineCore.outputText("\n\nOdd as it is, it doesn't seem to react as you look it over.  You avoid it, for now.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }
        EngineCore.simpleChoices("Fuck It", fuck, "Mount It", mount, "", null, "", null, "No Way", SceneLib.camp.returnToCampUseOneHour);
        //addButton(3, "Smash It", pumpkinSmash);
        //[HOLY SHIT YOU BE FUCKING A PUMPKIN]
        function pumpkinFuck():void {
            EngineCore.clearOutput();
            flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
            EngineCore.outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing gourd-pussy.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to bust a nut in this fruit's sweet, supple folds, not let some malformed tentacle-horror molest you."
                    +"\n\nYou kneel down before your target and examine the leaky orifice before you.  The rind around the opening is softer and smoother than human skin, yet oddly supple.  As soon as your fingers grace the surface of the moist fruit, a splash of ooze squirts from the gash to puddle at your [feet].  Curiously, you open the pumpkin's pussy with your fingers, feeling the slick wet walls trying to envelop your digits even as you gander at the compellingly vibrant interior.  The air seems thick with the plant's sweet smell, and [eachCock], regardless of your reason, seems hard as stone and painfully erect."
                    +"\n\nTentatively, you raise one of your juice-soaked fingertips to your lips and taste it.  The flavor is as you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [cock biggest] up with the lurid purple plant-pussy.  Smiling at the absurdity of it all, you push forward, anticipating the slimy tightness of your pumpkin's pie."
                    +"\n\nThe gushy gourd's interior does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a female, the slick plant-pussy is incredibly soft and pliant.  However, the walls seem to be squeezing against every square inch of dick that you yield to them, and a gentle suction slowly drags you in, whether you planned on going ");
            if (player.balls > 0) EngineCore.outputText("balls deep ");
            else EngineCore.outputText("hilt deep ");
            EngineCore.outputText("or not.  Not that you mind - the swollen labia seem to be doing an adequate job of smooching all over your shaft as it passes through their glossy gates.");
            if (player.cocks[0].cockLength >= 20) EngineCore.outputText("  After you've fed over a foot of your [cock biggest] into the gluttonous gourd, you briefly wonder where it's all going.  The pumpkin can't be more than a foot and a half across, yet it's sucking down the second foot now, and you have yet to hit any wall!  The suction suddenly increases, yanking you deeper, faster, and you forget all about the whys, whens, and whatevers.  It feels great.");
            EngineCore.outputText("\n\n");
            if (player.balls > 0) EngineCore.outputText("Your [balls] slap");
            else EngineCore.outputText("Your groin slaps");
            EngineCore.outputText(" into the orange 'skin' wetly, the omnipresent ooze immediately soaking your " + player.skinFurScales() + " with corrupted lubricant.  You hardly mind, finding your hips already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rind and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cunt, too drunk on lust and pleasure to question the strangeness of it all.");
            EngineCore.outputText("\n\n'Slap-slap-slapslapslapslap' rings out as you piston faster and faster, violently plowing the plant's pussy in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy hole each time you pull out, the suction keeping your [cock biggest] as hard as absolutely possible.  The purple-lipped pussy seems even larger than before, the vulva monumentally swollen, a thick pillow for you to slam into as you ride the pumpkin into orgasm.  You feel a strange compulsion to cum inside, to flood the gourd with white goo until it sprays out around your [legs]."
                    +"\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough into the pillow-like pussy that its mysteriously copious lube is squirted in every direction.  You don't care, your [cock biggest] is flexing, your urethra is dilating, and your cum is boiling out, flooding the pumpkin's innards in white goo.  Clenching tightly, your muscles lock, working in perfect concert with one goal: filling this fruit with cum.  ");
            if (player.cumQ() < 200) EngineCore.outputText("Your weak load disappears into the plant's sucking gullet, wicked away as fast as you fire.");
            else if (player.cumQ() < 1000) EngineCore.outputText("Your thick load disappears into the plant's sucking gullet almost as fast as you're firing it, though you can see a bit of white creampie forming around the edges of your cock.");
            else {
                EngineCore.outputText("Your massive load floods the pumping, a deluge of semen squirting around your [cock biggest] even as the pumpkin starts to enlarge.  Every titanic spooge-squirt pumps the gourd up another level.  Soon, the rind is rubbing your belly.  A few blasts later, it's lifting you from the ground, your still-spurting cock lodged firmly in its cunt.  The suction feels so much stronger now - you're not sure you could pull out now if you wanted to, and you don't!");
            }
            if (player.cumQ() < 1000) {
                EngineCore.outputText("\n\nAll too soon, you finish and step away, satisfied.  The pumpkin's pussy seals closed slowly, cutting off the worst of the slime-flow.  You get dressed, but the plant's tendrils no longer bother you.  They lie still and flat, and even the perverse sweating comes to an end.  Whatever fel magic was behind this, it seems to have settled after the salty snack you gave it.  You get dressed and walk back to camp with a spring in your step.");
                player.orgasm();
                player.dynStats("cor", 2);
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }
            else {
                EngineCore.outputText("\n\nOver and over you empty your [balls] into the growing gourd, inflating it larger and larger, passionately giving up every drop of sperm to fuel its unnatural growth.  Even once you feel empty, your [cock biggest] continues to clench and pump, firing blanks in an effort to feed EVERYTHING to the semen-hungry plant.  Still, even your prodigious virility can only take so much, and once your dick starts to go soft inside the massive cunt, it releases you, allowing you to ride out the rest of your orgasm, below, on the ground.  Your descent is graceless, a lazy slide down the orange rind.  Were it not for the gentle slope, it would be a dangerous six-foot fall."
                        +"\n\nYou thank the gods for that small mercy as you calm down and climb to your feet, beholding the sudden gargantuan growth as if for the first time.  That pumpkin is at least six feet tall, and the swollen pussy that devoured your cum?  It has grown with it, now a gash big enough to devour a man.  A few strings of semen trail from the labia to the ground, but it looks like most of your cum is vanishing into the pumpkin's depths, drank down for some purpose only the demons would know."
                        +"\n\nA faint rumbling is the only warning you get (or need).  You jump back and ready yourself for anything, ");
                if (player.weaponName == "fists") EngineCore.outputText("brandishing your fists");
                else EngineCore.outputText("picking up your [weapon]");
                EngineCore.outputText(" as if it would somehow protect your nude body.");
                EngineCore.doNext(pumpkinFuckPartII);
                player.orgasm();
                player.dynStats("cor", 2);
            }
        }

        //[Next]
        function pumpkinFuckPartII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("The titanic rent shivers, flaps of fruit-flesh smacking wetly for a second before splitting along their length.  The crack goes up the height of the six-foot pumpkin until it looks on the verge of splitting in two.  Suddenly, the gap widens, strings of orangey-purple goo hanging wetly between them for a moment.  Soon, the bisected fruit falls apart, at last revealing the corrupt core.  No trace of your mammoth insemination remains."
                    +"\n\nStanding in the middle of the vegetational carnage is a human figure, shrouded in slime and pumpkin, but clearly alive.  Her waist-length hair shimmers, orange as the goop that drips from it as she turns to face you.  She casually brushes a wash of the filth from her head, revealing a achingly beautiful visage - pale skin, a button nose, and full, blood-red lips that glitter in the suddenly-dim light.  Burning crimson eyes lock onto you, and a voice as smooth as a razor's edge intones, \"<i>So... YOU are my savior, hrmmm?</i>\""
                    +"\n\nAwestruck by the sudden development, you nod mutely, not really sure if you're going to have to fight this new demon, or if this woman was righteous and somehow imprisoned in the oh-so-fuckable pumpkin.  She reads the unasked questions in your eyes and begins to answer, stepping forward with hips slowly swaying.  \"<i>I, my creamy little meal, am Fera, Goddess of Predation.</i>\""
                    +"\n\nThe goddess circles you, idly tracing black, claw-like nails over your exposed [skin].  When did she get so close?  She drops her hand low, the dagger-sharp protrusions tenderly cupping your ");
            if (player.balls > 0) EngineCore.outputText("[balls]");
            else EngineCore.outputText("base");
            EngineCore.outputText(" as she explains, \"<i>Almost a decade ago, my sister, Marae, bolstered by Tel'Adre's Covenant, sealed me away, bound me up in barren, lifeless soil.</i>\"  Her grip tightens, drawing a drop of blood and a wince of pain from you.  \"<i>She didn't approve of my decision to throw my lot in with Lethice's army.  The bitch always did think she knew best.</i>\"  The painful cage around your package relaxes, and she goes on, \"<i>You have no idea how hard it was to grow that pumpkin to the surface... but with your more than generous donation, you gave me the life I needed to break free.</i>\""
                    +"\n\nFera's pert bust catches your eye, but the most jarring thing by far is the realization that all the gunk and slime is gone.  She is cleaner and more pristine than a virgin on her wedding night.  Well, the hard red nipples and her puffy sex seem to disagree with that assumption."
                    +"\n\n\"<i>How should I thank my savior?  That is the human tradition, is it not?</i>\" Fera interrupts, sliding her palm along the sensitive underside of your [cock]");
            if (player.cockTotal() > 1) {
                EngineCore.outputText(", her free hand working ");
                if (player.cockTotal() == 2) EngineCore.outputText("your other");
                else EngineCore.outputText("another");
                EngineCore.outputText(" dick with child-like glee");
            }
            EngineCore.outputText(".  \"<i>");
            if (player.race() != "human") EngineCore.outputText("I know what you were, virile suitor.  ");
            EngineCore.outputText("There's never too much of a good thing.  Of course, my champion must have the proper train of thought...</i>\""
                    +"\n\nWait... what?  You start to pull back, but her grip tightens, forcing you rigid with involuntary pain.  Prickly vines boil out of the ground around your [legs] and entwine into a twisted web with the strength of iron.  In seconds, you're firmly bound up to your [chest], the only part left mobile being your poor, depleted dick.  It swings freely, controlled as effortlessly by the tainted goddess as your veridian prison."
                    +"\n\nFera rambles, \"<i>My sister is not so strong anymore... the planet itself has been turned to my way of thinking, just like you.</i>\"  She leans forward to kiss you, those ruby lips as smooth as glass and soft as the finest velvet.  You lose yourself in her lips, immediately kissing her back, devoting all your muscle control to passionately twisting your tongue about hers, tasting her cinnamon-sweet mouth, moist organs lapping against one another while bubbles of saliva roll between your hungry lips.  It's enough to blind you to the rising wall of verdant tentacles, at least until they touch your ears."
                    +"\n\nYou cry out when they slide into your ears, the slimy slickness worming into your cranium as they dribble warm lubricants everywhere.  Inch after inch of ropy green vine disappears inside you, and your first thought, aside from the panic coursing through your veins, is, \"<i>How is this even possible?</i>\"  The next one isn't nearly as cogent, as your entire body seems to light up with sensation, every inch of skin bathed in wet kisses, fragrant cunts, pillowy tits, and the occasional slippery dong.  It's an electric cacophony of pleasure like no other.  All of these sensual caresses move together, a perfectly orchestrated ballet of erotic movement timed to the rhythm of the gently thrusting ear-tentacles."
                    +"\n\nDimly, you feel rivulets of something sticky running down the sides of your neck, but the phantom tits smearing you with breastmilk and caressing your sensitive-as-genetalia skin are a more pressing, and arousing concern.  Fera somehow pushes through the phantom female forms to re-engage the liplock, and you happily return to frenching her, an obedient slave to her skillful techniques and mind-molding roots.  This cavalcade of sexual hallucinations is impossible to withstand, and though silent aside from the gentle squishes of your perpetual ear-fuck, you have to admit that you enjoy it as much anything you've ever done."
                    +"\n\nThe pleasant numbness from the intrusion - like the blissful crest of rolling waves - sweeps everything but pleasure from your mind.  You sag into your bindings, ecstatic, melted putty awaiting its sculptor's touch.  Fera hums and breaks the kiss to look into your empty, dazed eyes, two red stars of fire that utterly fill your view.  You drool and begin to lick at an imaginary pussy, your fevered attentions wasted on empty air, though to you it as real as a wet succubus's snatch."
                    +"\n\nMeanwhile, you feel a pussy sliding over your [cock].  Just as it hilts you, a second set of lips, slippery internal vulva, slide down your shaft, trailing the first until they nestle up against them, leaking their drool out the first's entrance.  Stranger still, a third vagina crests your [cockHead], slithering down your turgid mast to join its sisters, and that's only the beginning.  A seemingly endless array of vaginas wraps around your cock and squeeze it with twenty different textures, all of them as soft and wet as liquid butter.  Your [cock] may as well have died and gone to heaven, for it joins the rest of you in bliss."
                    +"\n\nFera giggles at your expression and puts her finger in your mouth, laughing uproariously when you immediately suck it, flicking your tongue about its circumference.  Those slow, pumping tendrils have utterly fucked your mind, and there's nothing you could have done about it.  It's hellishly good, a torture of sinful, unadulterated pleasure potent enough to keep your [cock] throbbing and aching to release, even though it just did.  You would mind, if it wasn't like every single other part of you was orgasming on its own, ecstatically twitching in the firm bindings as you give yourself wholly to Fera's minions."
                    +"\n\nHow long it goes on you can't say.  Somewhere along the lines your memory went dark, repurposed by your coiled masters to allow you to feel even greater heights of bliss.  There's faint flashes of you thrashing, but giant-sized labia keep you pinned in place, your limbs devoured in vaginal restraint.  With a triumphant surge, bulges stretch your abused noise-holes and work deep into your skull.  Your world goes white, an orgasmic soup of delight that washes any vestiges of thought from you and leaves behind only dripping obedience to pleasure.  Your cock fires weakly, offering tribute Fera in sympathy, yet the real thing is in your cum-bathed brain.  Runny tentacle-spooge drips from your nose as you gurgle in bliss, then black out.");
            EngineCore.hideUpDown();
            player.orgasm();
            EngineCore.doNext(pumpkinFuckPartIII);
        }

        function pumpkinFuckPartIII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("SLAP!  The crack of a palm on your face rouses you, a red handprint left on your cheek.  Fera smirks at you as you stir woozily in your plant-woven prison.  \"<i>Did you enjoy yourself?</i>\"  You slowly nod, feeling... liberated, free.  The situation is less worrying than before.  Fera just wanted to thank you, right?"
                    +"\n\nThe sultry orange-haired maiden ");
            if (player.balls > 0) EngineCore.outputText("pats your sloshing sack");
            else EngineCore.outputText("caresses a sensitive spot beneath your dick");
            EngineCore.outputText(" as the vines unwind, allowing you to stand on your own [feet].  You go to wipe the cum from your nose and upper lip as soon as you're free.  It's dry.  Did any of that even happen?"
                    +"\n\n\"<i>I went ahead and gave you your reward.  It seemed fitting to give you a little bit more 'juice', since that was how you saved me.  My hero,</i>\" Fera explains before giving you a chaste kiss on the lips.  \"<i>You'll find yourself cumming a little harder and recovering a little faster in the future.  Now go, take what you want from the weak.  Do not disappoint me.</i>\""
                    +"\n\nFera disappears along with all the evidence of your encounter, her ruby lips hanging in the air for a split-second before fading as well.  You're left naked, alone with your discarded armor, lusts, and recently adjusted attitude.");
            //(+30 corrution, Fera's Boon - Alpha gained)
            if (player.findPerk(PerkLib.FerasBoonAlpha) < 0) {
                EngineCore.outputText("\n\n(<b>Perk Gained: Fera's Boon - Alpha</b>)");
                player.createPerk(PerkLib.FerasBoonAlpha, 0, 0, 0, 0);
            }
            player.dynStats("cor", 30);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        function mountPumpkin():void {
            EngineCore.clearOutput();
            flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
            //>Yes [Player is pregnant, has low vaginal wetness, or has low fertility and is not in heat]
            if (player.pregnancyIncubation > 0 || (player.wetness() < 2 && player.totalFertility() < 30)) {
                EngineCore.outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing stem-rod.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to mount this fruit's hard, pulsing phallus, not let some malformed tentacle-horror molest you."
                        +"\n\nYou kneel down before your target and examine the leaking cock before you.  The stem is softer and smoother than human skin, hard as wood, yet oddly supple.  As soon as your fingers grace the surface of the phallic protrusion, a splash of ooze squirts from the stem to puddle at your feet.  Curiously, you stroke the pumpkin's dick with your fingers, feeling the stiff rod twitch under your fingers even as you gander at the compellingly vibrant shaft.  The air seems thick with the plant's sweet smell, and your pussy, regardless of your reason, seems as wet as a riverbed."
                        +"\n\nTentatively, you raise a juice-soaked fingertip to your lips and taste it.  The flavor is exactly what you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [vagina] up with the hard green phallus.  Smiling at the absurdity of it all, you push downward, anticipating the slimy thickness of your pumpkin's pie goo.\n\n");
                (player as Player).cuntChange(50, true, false, false);
                EngineCore.outputText("\n\nThe gourd's oozing stem does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a male, the slick plant-cock is both hard and pliant.  However, the shaft seems to be pulsating against every square inch of pussy that you lower onto it, and that gentle pulsing slowly draws you down, whether you planned on going to the hilt or not.  Not that you mind - the pulsing plant seems to be doing an adequate job of stimulating your walls as it passes through your glossy gates."
                        +"\n\nYour [hips] slap into the orange 'skin' wetly, the omnipresent ooze immediately soaking your [skin] with corrupted lubricant.  You hardly mind, finding your body already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rinds and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cock, too drunk on lust and pleasure to question the strangeness of it all."
                        +"\n\nWet slapping noises ring out as you piston faster and faster, violently plowing the plant-cock into your [vagina] in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy shaft each time you pull up, the ooze keeping your [vagina] well lubricated.  The green shaft seems even larger than before, the phallus stretching you wider and longer each time you slam down on it as you ride the pumpkin into orgasm.  You feel a strange compulsion to let it cum inside, to flood your womb with pie goop until you appear immensely pregnant and the overflow is spraying out around your legs."
                        +"\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough onto the hard green shaft, that you could almost swear your cervix was penetrated.  You don't care, your vagina is clenching, the stem is flexing, and the pumpkin's ooze is gushing out, flooding your innards with pumpkin seed as you flood the pumpkin's surface with your female juices in turn.  Clenching tightly, your muscles lock, working in perfect concert with one goal; filling you up with fruity cum.  The pumpkin's thick load floods your inner folds, a deluge of sweet-smelling goop squirting deep into your [vagina], inflating you and then squirting back out mixed with your own juices.  The mixed juices are absorbed into the plant's rind almost as fast as they exit your body, though you can see a bit of glistening moisture around the base of the stem."
                        +"\n\nAll too soon, you finish and step away, satisfied.  The pumpkin's stem slowly stops pulsing, cutting off the worst of the slime-flow.  You get dressed, but the plant's tendrils no longer bother you.  They lie still and flat, and even the perverse sweating comes to an end.  Whatever fell magic was behind this, it seems to have settled after the pressure you relieved it of.  You get dressed and walk back to camp with a spring in your step.");
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }
            //Female characters don't have an easy analogue to cum production unless we count milk production, and female gender doesn't require either breasts or lactation to play.  So I just went for high vaginal wetness, not pregnant, and likely to become pregnant if she had sex with a male creature.  I hope that works out OK.
            else {
                //[Player is not currently pregnant, has high vaginal wetness, and is either in heat or has high fertility]
                EngineCore.outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing stem-rod.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to mount this fruit's hard, pulsing phallus, not let some malformed tentacle-horror molest you."
                        +"\n\nYou kneel down before your target and examine the leaking cock before you.  The stem is softer and smoother than human skin, hard as wood, yet oddly supple.  As soon as your fingers grace the surface of the phallic protrusion, a splash of ooze squirts from the stem to puddle at your feet.  Curiously, you stroke the pumpkin's dick with your fingers, feeling the stiff rod twitch under your fingers even as you gander at the compellingly vibrant shaft.  The air seems thick with the plant's sweet smell, and your pussy, regardless of your reason, seems as wet as a riverbed."
                        +"\n\nTentatively, you raise a juice-soaked fingertip to your lips and taste it.  The flavor is exactly what you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [vagina] up with the hard green phallus.  Smiling at the absurdity of it all, you push downward, anticipating the slimy thickness of your pumpkin pie's goo."
                        +"\n\nThe gourd's oozing stem does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a male, the slick plant-cock is both hard and pliant.  However, the shaft seems to be pulsating against every square inch of pussy that you lower onto it, and that gentle pulsing slowly draws you down, whether you planned on going to the hilt or not.  Not that you mind - the pulsing plant seems to be doing an adequate job of stimulating your walls as it passes through your glossy gates."
                        +"\n\nYour [hips] slap into the orange 'skin' wetly, the omnipresent ooze immediately soak your [skin] with corrupted lubricant.  You hardly mind, finding your body already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rinds and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cock, too drunk on lust and pleasure to question the strangeness of it all."
                        +"\n\nWet slapping noises ring out as you piston faster and faster, violently plowing the plant-cock into your [vagina] in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy shaft each time you pull up, the ooze keeping your [vagina] well lubricated.  The green shaft seems even larger than before, the phallus stretching you wider and longer each time you slam down on it as you ride the pumpkin into orgasm.  You feel a strange compulsion to let it cum inside, to flood your womb with pie goop until you appear immensely pregnant and the overflow is spraying out around your legs."
                        +"\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough onto the hard green shaft, that you could almost swear your cervix was penetrated.  You don't care, your vagina is clenching, the stem is flexing, and the pumpkin's ooze is gushing out, flooding your innards with pumpkin seed as you flood the pumpkin's surface with your female juices in turn.  Clenching tightly, your muscles lock, working in perfect concert with one goal; filling you up with fruity cum.  The pumpkin's massive load floods your inner folds, a deluge of sweet-smelling goop squirting deep into your [vagina], inflating you until you are certain you might burst and then squirting back out mixed with your own juices even as the pumpkin starts to enlarge.  Every titanic gush from your pussy pumps the gourd up another level.  Soon, the rind has forced your [legs] into an uncomfortable position as it grows.  A few blasts later, it's lifting you from the ground, its still-spurting stem-cock lodged firmly in your cunt.  You're not sure you could pull yourself off now if you wanted to, and you don't!"
                        +"\n\nOver and over the growing gourd empties its ooze into you as it seems to suck up the torrent of mixed juices that pour back out of you, inflating it larger and larger.  Even once you feel like you've cummed to the point of dehydration, your [vagina] continues to milk the pumpkin's stem of ooze and gush femspunk in return in an effort to douse EVERYTHING onto to the fluid-hungry plant.  Still, even your prodigious libido can only take so much, and once your [vagina] starts to slow in its ministrations, the stem softens just enough to let you slide off to where you can ride out the rest of your orgasm, below, on the ground.  Your descent is graceless, a lazy slide down the orange rind.  Were it not for the gentle slope, it would be a rough six-foot fall."
                        +"\n\nYou thank the gods for that small mercy as you calm down and climb to your feet, beholding the sudden gargantuan growth as if for the first time.  That pumpkin is at least six feet tall, and the swollen stem that filled you with pumpkin ooze?  It has grown with it, now a towering rod as big as an average woman's torso.  As you wonder how you managed to fit such a monstrosity inside you at the end, you notice that only a few strings of mixed pumpkin goo and female cum trail from the stem to the ground.  It looks like most of the combined fluids are vanishing into the pumpkin's depths, drank down for some purpose only demons would know."
                        +"\n\nA faint rumbling is the only warning you get (or need).  You jump back and ready yourself for anything, ");
                if (player.weaponName != "fists") EngineCore.outputText("picking up your [weapon]");
                else EngineCore.outputText("raising your guard");
                EngineCore.outputText(" as if it would somehow protect your nude body.");

                EngineCore.doNext(pumpkinMountingLevelII);
            }
            player.orgasm();
            player.dynStats("cor", 1);
        }

        //>Next
        function pumpkinMountingLevelII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("The pumpkin's titanic stem shivers, the mighty shaft trembling immensely before the pumpkin splits from the top causing it to topple.  The crack goes around the rind in multiple directions, causing it to split open like a flower as strings of orangey-purple goo hang wetly between the pieces for a moment.  A moment later, the sectioned fruit falls apart, at last revealing the corrupt core.  No trace of the mammoth copulation remains."
                    + "\n\nStanding in the middle of the vegetational carnage is a human figure, shrouded in slime and pumpkin, but clearly alive.  Her waist-length hair shimmers, orange as the goop that drips from it as she turns to face you.  She casually brushes a wash of the filth from her head, revealing a achingly beautiful visage - pale skin, a button nose, and full, blood-red lips that glitter in the suddenly-dim light.  Burning crimson eyes lock onto you, and a voice as smooth as a razor's edge intones, <i>\"So... YOU are my savior, hmmm?\"</i>"
                    + "\n\nAwestruck by the sudden development, you nod mutely, not really sure if you're going to have to fight this new demon, or if this woman was righteous and somehow imprisoned in the oh-so-fuckable pumpkin.  She reads the unasked questions in your eyes and begins to answer, stepping forward with hips slowly swaying.  <i>\"I, my creamy little meal, am Fera, Goddess of Predation.\"</i>"
                    + "\n\nThe goddess circles you idly tracing black, claw-like nails over your exposed [skin].  When did she get so close?  She drops her hand low, the dagger-sharp protrusions tenderly cupping your [vagina] as she explains, <i>\"Almost a decade ago, my sister, Marae, bolstered by Tel'Adre's Covenant, sealed me away, bound me up in barren, lifeless soil.\"</i>  Her grip tightens, drawing a drop of blood and a wince of pain from you.  <i>\"She didn't approve of my decision to throw in my lot with Lethice's army.  The bitch always did think she knew best.\"</i>  The painful cage around your snatch relaxes, and she goes on, <i>\"You have no idea how hard it was to grow that pumpkin to the surface... but with your more than generous action, you gave me the strength I needed to break free.\"</i>"
                    + "\n\nFera's pert bust catches your eye, but the most jarring thing by far is the realization that all the gunk and slime is gone.  She is cleaner and more pristine than a virgin on her wedding night.  Well, the hard red nipples and her puffy sex seem to disagree with that assumption."
                    + "\n\n<i>\"How should I thank my savior?  That is the human tradition is it not?\"</i>  Fera interrupts, sliding her palm along the sensitive folds of your [vagina]");
            if (player.biggestTitSize() >= 2) EngineCore.outputText(", her free hand working your [fullChest] with glee");
            EngineCore.outputText(".  <i>\"There's never too much of a good thing.  Of course, my champion must have the proper train of thought...\"</i>"
                    + "\n\nWait... what? You start to pull back, but her grip tightens, forcing you rigid with involuntary pain.  Prickly vines boil out of the ground around your legs and entwine into a twisted web with the strength of iron.  In seconds, you're firmly bound up to your chest, no part of you left mobile."
                    + "\n\nFera rambles, <i>\"My sister is not so strong anymore; the planet itself has been turned to my way of thinking, just like you.\"</i>  She leans forward to kiss you, her ruby lips as smooth as glass and soft as the finest velvet.  You lose yourself in her lips, immediately kissing her back, devoting all your muscle control to passionately twisting your tongue about hers, tasting her cinnamon-sweet mouth, moist organs lapping against one another while bubbles of saliva roll between your hungry lips.  It's enough to blind you to the rising wall of verdant tentacles, at least until they touch your ears."
                    + "\n\nYou cry out when they slide into your ears, the slimy slickness worming into your cranium as they dribble warm lubricants everywhere.  Inch after inch of ropy green vine disappears inside you, and your first thought, aside from the panic coursing through your veins, is <i>\"How is this even possible?\"</i>  The next one isn't nearly as cogent, as your entire body seems to light up with sensation, every inch of skin bathed in wet kisses, pulsing cocks, fragrant balls, and the occasional slippery cunt.  It's an electric cacophony of pleasure like no other.  All of these sensual caresses move together, a perfectly orchestrated ballet of erotic movement timed to the rhythm of the gently thrusting ear-tentacles."
                    + "\n\nDimly, you feel rivulets of something sticky running down the sides of your neck, but the phantom shafts smearing you with pre and caressing your sensitive-as-genetalia skin are a matter of more pressing, and arousing concern.  Fera somehow pushes through the phantom male forms to re-engage the lip-lock, and you happily return to frenching her, an obedient slave to her skillful techniques and mind-moulding roots.  This cavalcade of sexual hallucinations is impossible to withstand, and though silent aside from the gentle squishes of your perpetual ear-fuck, you have to admit that you enjoy it more than anything you've ever done."
                    + "\n\nThe pleasant numbness from the intrusion - like the blissful crest of rolling waves - sweeps everything but pleasure from your mind.  You sag into your bindings, ecstatic, melted putty awaiting its sculptor's touch.  Fera hums and breaks the kiss to look into your empty, dazed eyes, two red stars of fire that utterly fill your view.  You drool and begin to lick at an imaginary dick, your fevered attentions wasted on empty air, though to you it's as real as a hard incubus's member."
                    + "\n\nMeanwhile, you feel a penis sliding into your pussy.  Just as it fills you, a second shaft, slides into your folds, trailing the first until it nestles up against it, both leaking their pre-cum out the first's tip.  Stranger still, a third rod breaches your entrance, slithering past your folds to join it's brothers, and that's only the beginning.  A seemingly endless array of penises nestle within your pussy and pulsate inside with twenty different textures, all of them as hard and strong as steel.  Your pussy may as well have died and gone to heaven, for it joins the rest of you in bliss."
                    + "\n\nFera giggles at your expression and puts her finger in your mouth, laughing uproariously when you immediately suck it, flicking your tongue about its circumference.  Those slow, pumping tendrils have utterly fucked your mind, and there's nothing you could have done about it.  It's hellishly good, a torture of sinful, unadulterated pleasure potent enough to keep your cunt drooling and aching to release, even though it just did.  You would mind, if every other part of you wasn't orgasming on its own, ecstatically twitching in the firm bindings as you give yourself wholly to Fera's ministrations."
                    + "\n\nHow long it goes on you can't say.  Somewhere along the lines your memory went dark, repurposed by your coiled masters to allow you to feel even greater heights of bliss.  There's faint flashes of you thrashing, but giant-sized testicles keep you pinned in place, your limbs devoured in penile restraint.  With a triumphant surge, bulges stretch your abused noise-holes and work deep into your skull.  Your world goes white, and an orgasmic soup of delight washes over you and erases any vestiges of thought from you, leaving behind only dripping obedience to pleasure.  Your pussy twitches weakly, offering tribute to Fera in sympathy, yet the real thing is in your cum-bathed brain.  Runny tentacle-spooge drips from your nose as you gurgle in bliss, then black out.");
            //>Next
            EngineCore.doNext(mountPumpkinsIII);
        }

        function mountPumpkinsIII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("SLAP!  The crack of a palm on your face rouses you, a red handprint left on your cheek.  Fera smirks at you as you stir woozy in your plant-woven prison.  <i>\"Did you enjoy yourself?\"</i>  You slowly nod, feeling... liberated... free.  The situation is less worrying than before.  Fera just wanted to thank you, right?"
                    + "\n\nThe sultry orange-haired maiden pats your sloshing middle as the vines unwind, allowing you to stand on your own feet.  You go to wipe the cum from your nose and upper lip as soon as you're free.  It's dry.  Did any of that even happen?"
                    + "\n\n<i>\"I went ahead and gave you your reward.  It seemed fitting to enhance the power of your womb, since that was how you saved me.  My hero,\"</i> Fera explains before giving you a chaste kiss on the lips.  <i>\"You'll find yourself breeding easier and giving birth faster.  Now go, fill this world with strong offspring.  Do not disappoint me.\"</i>"
                    + "\n\nFera disappears along with all the evidence of your encounter, her ruby lips hanging in the air for a split-second before fading as well.  You're left naked, alone with your discarded armor, urge of release, and recently adjusted attitude.");
            if (player.findPerk(PerkLib.FerasBoonBreedingBitch) < 0) {
                EngineCore.outputText("\n\n(<b>Perk Gained: Fera's Boon - Breeding Bitch</b>)");
                player.createPerk(PerkLib.FerasBoonBreedingBitch, 0, 0, 0, 0);
            }
            player.dynStats("cor", 30);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }
    }
    //Perk name: Fera's Boon - Breeding Bitch
    //Perk description: Greatly increases fertility and doubles base pregnancy speed.
    //Increases the chance that the character will get pregnant and increases the speed of the character's pregnancies.
    //Why, yes, I did copy/paste Marae's Gift - Fertility for this perk. Edit: And edited it to correct a mistake in its wording. YOU FAILED ME LAD. NOW ROT IN THE DEPTHS OF HELL.
    //Edit of this guy edit : You failed like, ¾ of your tags, you're the one to talk, man.
    //But I had to fix all the tags you tried to fix
    //You are just as much of a failure as he is.
    //Introduction
    public static function feraSceneTwoIntroduction():void {
        EngineCore.clearOutput();
        EngineCore.outputText("While you're walking through the deepest, darkest parts of these overgrown woodlands, you come across a wild glade, filled with hundreds and hundreds of the most beautiful blossoming flowers. They cover the hundred or so feet across the clearing densely, some small, like dandelions and orchids, others enormous, on stalks as thick as small tree-trunks, blooming so vibrantly that you find yourself rubbing your eyes after gazing at them, dazzled by their many hued palettes. Sweet aromas of a thousand types of flowers blend together into a symphony of nasal delight, and you breathe deep, laughing loudly and openly at this wondrous find."
                +"\n\nYou flop back into the soft grasses that ring this overwhelmingly sweet glade. The nectar-sweet ambrosia that's carried through the air on clouds of pollen ought to be attracting some insects, shouldn't it? You glance around, looking for the bees and butterflies you would normally expect to thrive in such a place, but there are none. No bugs, no gnats, no aphids... just flowers... flowers everywhere. You get up and wander around a little bit, looking this way and that, hunting for any proof of life while simultaneously taking in the cacophony of dazzling colors."
                +"\n\nHere and there, you spot proof of Mareth's corruption in this seemingly pristine place: a flower whose petals look like plump, red lips, just waiting to be kissed, vines with distinctly phallic shapes protruding from the central stalk of the flower, and flowers whose entrances shine with slick fluids and part at your approach, appearing very much like a pair of clingy, virginal folds. And still, there are no bees. You run to the edge of the blooming meadow, and there, at last, you find what you were looking for."
                +"\n\nA single, normal-looking bee, is lazily buzzing down onto a flower a few inches away, heedless of your presence. It homes right in on the sweet-smelling divot in the center of the petals, touching down without slowing or stopping to investigate the new arrival. Instead, it crawls deeper into the floral creases, hunting pollen and nectar. The petals snap up and around, slamming together with the speed of a clockwork trap, their edges seamlessly joined together into a single, entrapping sphere, perfectly encapsulating the poor insect. You hear a muffled buzz as the bug vainly attempts to escape, and then nothing. Whatever happened inside, the bee isn't struggling anymore."
                +"\n\nA creeping shiver crawls down your back until you straighten and take in your surroundings once more. This place is too pretty for you to stay down in the dumps for too long, and besides, a particularly intriguing fragrance is tickling your nose. It seems to come from the center of the glade, where the biggest, most vibrant blooms have sprouted. Do you want to explore the center, around some of the huge flowers, or head back to the safety of your camp?");
        //[Explore] [Leave]
        EngineCore.menu();
        EngineCore.addButton(0, "Explore", exploreFerasWonderland);
        EngineCore.addButton(4, "Leave", leaveFerasWonderland);

        //Leave
        function leaveFerasWonderland():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Nah, that whole place is probably some kind of giant venus fly trap. Fuck that.");
            flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR] = date.fullYear;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //Explore Das Trees
        function exploreFerasWonderland():void {
            EngineCore.clearOutput();
            EngineCore.awardAchievement("Fera's Wonderland", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_II);
            flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR] = date.fullYear;
            EngineCore.outputText("Straightening to your full height, you take a few experimental sniffs and begin to walk back towards the middle of the meadow, brushing aside garish pink blooms that rise up past your waist.  That smell is getting stronger now.  How could you have missed it when you first arrived? It's heavenly, like a combination of every sweet treat you like with an undercurrent of passionate sexual musk blended in underneath.  You close in, " + player.mf("[hips] swaggering excitedly", "[hips] sashaying excitedly") + ", [skin] flushing.  A few baby blue sunflowers bump your shoulders as you muscle past them to hone in your new favorite aroma.  You've just got to know what bloom could possibly release such a heavenly scent!"
                    +"\n\nYou idly wonder what you would look like to any new arrivals, nose up and dragging you forward, almost like a fish on a hook, your body stumbling past chest-high blossoms that are nearly as wide as your shoulders.  A shadow dims the light as you pass under a massive flower-bulb that stretches thirty feet overhead, its petals folded into a familiar-looking, sealed sphere.  That doesn't stop it from dripping sweet-smelling nectar that reminds you vaguely of pussy for some reason, and you certainly don't notice the feet-shaped impressions that kick against the petals after you pass by."
                    +"\n\nThat wondrous aroma guides you deeper, threading past delicate honeysuckles and crimson-colored lotus flowers.  Sometimes, you have you to stop and turn your head this way and that, testing the air with quick breaths to determine which way you must go to chase the increasingly omnipresent odor.  Other times it seems as obvious as a gold-plated path, dragging you right past vibrant foliage and smells that would normally incite you to stop and smell the roses if you weren't so focused on this one, heavenly, nose-tickling smell."
                    +"\n\nYou stumble a few steps forward, sighing in excitement as you near your prize.  It's so close that you can almost taste the pollen-scent you've been chasing on your tongue at this point.  Brushing back a petal nearly as tall as you, you loop past a plant as big as a house and come face to face with your current obsession.  It doesn't look at all like you expected, yet it seems so perfectly suited to its odor now that you're able to behold it up close and personal.  You blink a few times and smile widely, just taking it all in."
                    +"\n\nThe flower would stand nearly three times your own height were it not bending its stalk double under its own tremendous weight, the bottom-most petals long ago coming to rest on the ground in such a way that they'd make perfect ramps.  The outer and upper edges of its floral plumage stick out straight and true, almost like a daisy's would if it could grow to such a tremendous size.  In the very center is exactly what you'd expect from this twisted land: a pair of plump, obscene-looking lips compressed together into a smile and surrounded by dozens of phallic stamen, all wiggling this way and that.  Both the lips and the stamen leak a clear, glossy-looking fluid that seems to be the source of the smell.  It runs down creases in the petals towards your feet."
                    +"\n\nThe petals themselves are scarlet red near the center and a dusky, iridescent purple near their edges.  While you look, the colors seem to shift and change, slowly washing in towards the middle in an almost hypnotic pattern.  New hues scroll in from the tips of the bloom, turning it a psychedelic yellow-orange briefly before it too is pulled into the core, briefly staining the lips and stamen with its tawny hue before the next color in line washes it away.  You watch it for a few minutes, losing yourself in the flashing, changing colors, letting your eyes be guided to the unmistakably sexual accoutrements at the flower's core, watching and appreciating its unnatural beauty until you are roused by your [legs] starting to feel a little sore."
                    +"\n\nYou gather some of the nectar without thinking, compelled to lift it to your nose and take a sniff, heedlessly sampling its delicate bouquet, letting it tickle the back of your sinuses with its pheromonal payload while you enjoy the ambrosial levels of sweetness that come with it.  Your head swims a little... at least, until you lick your fingers clean and steady yourself against a nearby stalk.");
            if (player.gender > 0) EngineCore.outputText("  Your heart is hammering");
            if (player.hasCock() && !player.hasVagina()) EngineCore.outputText(", and there's a telltale tightness building in your groin, expanding and pressing oh-so-hard on your [armor]. You look up at those sweet lips and ponder what they would feel like wrapped around your [cocks], a thought that only makes your gear that much harder to bear as it constrains you.");
            else if (player.hasVagina() && !player.hasCock()) EngineCore.outputText(", and there's a telltale heat building in your groin, practically dripping out to stain your [armor] with your leaking girl-honey. You look up at those leaky stamen and idly wonder what it would feel like to let one or two inside you, stirring your insides with their sticky-sweet lovejuices.");
            else if (player.hasVagina() && player.hasCock()) EngineCore.outputText(", and there's a telltale sticky tightness in your [armor], keeping your [cocks] tightly compressed while your [vagina] practically juices itself all over everything, so hot, wet, and unmistakably eager to feel something inside of it. You look up at those leaky stamen and the plump lips between them and wonder what it would feel like to stick yourself in between the lips and let the stamen go to town on your exposed holes.");
            else {
                EngineCore.outputText("\n\nWell, that was nice, but you don't see much reason to stick around.  You head back to camp with a wistful look over your shoulder.");
                player.dynStats("lib", 1, "lus", 20, "cor", 1);
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
                return;
            }

            EngineCore.outputText("\n\nYou bite your lip and search your feelings, gasping in more breaths of the delectable scent as you mull over your options.  Your eyes look down at the ramp-like lower petals, immediately chasing the shifting colors back up to the center, and a whimper escapes your lips.  You briefly recall that you only wanted to find the source of the scent");
            EngineCore.menu();
            if (player.inte >= 40) {
                EngineCore.outputText(", and with that accomplished, you could head back to camp.  Now, though, you'd rather stay; it smells and looks too good to leave this place.  If you focus on your better sense, you could still leave.");
                if (player.hasCock()) EngineCore.addButton(0, "Continue", fuckDemCorruptFlowerLips);
                else EngineCore.addButton(0, "Continue", stickAStamenInIt);
                EngineCore.addButton(4, "Leave", leaveAfterFlowerHuffing);
            }
            else {
                EngineCore.outputText(", but that thought slips out of your head as it fills with more of that sinfully exciting aroma, making you feel so hot, horny, and eager.  You have to get more of it, submerse yourself deeper in its cloying clutches as you watch the pretty colors drain away your worries and concerns.");
                if (player.hasCock()) EngineCore.addButton(0, "Next", fuckDemCorruptFlowerLips);
                else EngineCore.addButton(0, "Next", stickAStamenInIt);
            }
            if (player.hasCock() && player.hasVagina()) {
                EngineCore.outputText("\n\nThe only ");
                if (player.inte >= 40) EngineCore.outputText("other ");
                EngineCore.outputText("question left to you is, are you more concerned with slipping [oneCock] into those subliminally-whispering lips or guiding a writhing stamen into your [vagina] and [asshole] so that you can take in as much nectar as possible?");
                EngineCore.addButton(0, "Lips", fuckDemCorruptFlowerLips);
                EngineCore.addButton(1, "Stamen", stickAStamenInIt);
            }
            player.dynStats("lib", 1, "lus", 25, "cor", 1);
        }

        //Leave
        function leaveAfterFlowerHuffing():void {
            EngineCore.clearOutput();
            EngineCore.outputText("The farther you get from that glade, the more your head clears and the more you realize how close you came to disaster.  You resolve to avoid it in the future, lest you fall prey to that entrancing pollen and the hypnotic petals once more.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //Fuck the Lips
        function fuckDemCorruptFlowerLips():void {
            EngineCore.clearOutput();
            flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] = date.fullYear;
            EngineCore.outputText("You dazedly stagger forward, putting one [foot] after another on the supple flesh of the gigantic, color-swirling petal that leads to your goal: the plush, nectar-leaking lips at the center of the bloom.  With each plodding movement, the hues become more vibrant, the intoxicating scent becomes thicker, and the less well-reasoned your thoughts become, shutting down in the avalanche of sensory overload.  Soon, your thoughts are little more than: <i>Scent. Sex. Horny. Fuck.</i>"
                    +"\n\nWith a slight stumble, you work your way out of your [armor], not stopping your plodding advance in the slightest and never letting the flower's core out of your sight, if you can help it.  Those lips seem to be pursing ever so slightly, beckoning you to slip something inside them... something hard and throbbing, aching to unload.  You shudder as you walk, slipping on a stream of leaking nectar and falling down onto your hands, but this doesn't impede your progress.  You continue to climb up, hand over hand, dragging yourself up until the 'floor' levels and you're about to smash yourself face-first into the flower's plump, mouth-like pillows."
                    +"\n\nYou drag yourself up onto your [feet] just as the stamen react to your presence, lashing out with snake-like swiftness to encircle your arms and [legs], binding them up in slippery stalks such that you can barely move.  Luckily, you're close enough that you can still do what you came here to do: fuck this flower.  You lunge your [hips] forward, slamming your crotch towards the huge, multi-hued lips, ");
            if (player.longestCockLength() >= 20) {
                EngineCore.outputText("easily ramming your huge endowment");
                if (player.cockTotal() > 1) EngineCore.outputText("s");
                EngineCore.outputText(" straight into the erotic-looking mouth");
            }
            else if (player.longestCockLength() >= 8) {
                EngineCore.outputText("slipping your large endowments");
                if (player.cockTotal() > 1) EngineCore.outputText("s");
                EngineCore.outputText(" right into the erotic-looking mouth");
            }
            else if (player.longestCockLength() >= 4) {
                EngineCore.outputText("easing the top hal");
                if (player.cockTotal() > 1) EngineCore.outputText("ves");
                else EngineCore.outputText("f");
                EngineCore.outputText(" of your phallus");
                if (player.cockTotal() > 1) EngineCore.outputText("es");
                EngineCore.outputText(" into the erotic-looking mouth");
            }
            else {
                EngineCore.outputText("barely managing to slip your tip");
                if (player.cockTotal() > 1) EngineCore.outputText("s");
                EngineCore.outputText(" into the erotic-looking mouth");
            }
            EngineCore.outputText(". The contact is everything you thought it would be: surprisingly warm, soaking-wet, and squeezing just tight enough to make your pillar");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" of lust twitch in excitement."
                    +"\n\nThe bindings around your arms and legs respond by tightening, forcing you spread-eagle, as caught as an insect in a spider's web.  Blessedly, instead of turning their control of your position to some nefarious turn, they pull you closer, slapping your ");
            if (player.balls > 0) EngineCore.outputText("[balls] against the cushy lower lip, wreathing them in syrupy sap or nectar.  You're not really sure what the appropriate name for such a substance is, and you're well past caring.");
            else EngineCore.outputText("loins against the cushy, sap-slicked lips, compressing their hot, smooth surfaces against your [skin].  You're not really sure if sap is the appropriate name for such a substance, but you're far beyond caring at this point.");
            EngineCore.outputText("  The fast-diminishing light doesn't even register, as your eyes have closed as you subsume yourself in pleasure."
                    +"\n\nThe bindings aren't tight enough to prevent you from flexing your [legs] and sawing yourself back and forth, thrusting in and out of the tight, slobbery hole, and you go at it like an animal in rut, savagely humping against the lurid lips, bound to them by dangling streamers of glittering nectar with each pull back. The petals slam closed with such force that it pops your ears, rousing you from your stupor. When you open your eyes, you're treated to the briefest moment of darkness before the petals light up with bioluminescent energy. Neither occurrence stops the frantic pounding your [hips] are doling out, but you do look up in a daze."
                    +"\n\nIt is at this point the colors begin to slide and change, twisting and shifting in a calming rhythm that seems perfectly synced to your sloppy, piston-like thrusts. A trickle of drool escapes the corner of your mouth as you moan, in ecstasy, right up until a free stamen arcs around to slam into your slack-jawed opening. It slides right into the back of your throat, throwing great big blobs of sweet, heavenly nectar so deep inside you that you have no choice but to swallow and sigh. Everywhere the juice touches practically sizzles with sexual energy, and after a few frenetic gulps you begin to eagerly gulp and swallow, drinking deeply of the goo until your belly begins to feel too full to drink any more."
                    +"\n\nYour motions slow as the ambrosial syrup is wicked into your body, frying your synapses with ecstasy until only lust, pleasure, and perfect heat are occupying your few remaining thoughts. By the time the tendril pulls free, glazing your face in sappy goo, your [hips] have stopped their thrusts entirely, leaving your [cocks] to pulsate and ache with need despite their owner's inability to remember how to hump. Best of all, the few times that you do manage to summon up a coherent thought, the flashing, undulating colors unravel it, letting you revel in unthinking arousal."
                    +"\n\nThe deluge of drugs, arousal, sexual stimulation, and mind-scattering visual patterns has made your mind as pliant and vulnerable as the lips your [cocks] ");
            if (player.cockTotal() > 1) EngineCore.outputText("are");
            else EngineCore.outputText("is");
            EngineCore.outputText(" buried in, so hot, wet, and soft. With each passing moment, you become more relaxed, more open and exposed, and more aroused than before. You would probably be afraid if you were capable of any kind of reason."
                    +"\n\nA perfectly smooth, perfectly dry hand traces down your back in a comforting yet sensual gesture, followed a moment later by another upon your [butt]. It squeezes you, kneading your cheek in its supple, dextrous fingers, letting long, sharp nails just barely dig into your " + player.skinFurScales() + ". Then the hands move down to your [legs] to continue their massage, dodging around the tentacle-like stamen so that they can reach your [feet]. There, the hands stop and separate from your body, vanishing until a familiar face leans in front of you, interrupting the slew of mind-tranquilizing colors briefly."
                    +"\n\nIt's Fera, Goddess of Predation, Marae's corrupt sister, and you've fallen directly into her trap.  The fair-skinned goddess titters, her fiery-orange tresses hanging down around you in a corrupted halo, drawing your slow-to-respond gaze to her pale, creamy skin, prominent lips, button nose, and smoldering red eyes.  \"<i>Oh, [name], I was hoping you'd come to my glade!</i>\"  She kisses your forehead tenderly.  \"<i>Last time we met, you saved me, and I gave you a gift for it. This time, I'll save you from a lifetime of orgasms, and you'll give me a gift, all right?</i>\""
                    +"\n\nYour mind has all the ability to resist of a fertile field before a plow, and you do the only thing you can think of: agreeing.  \"<i>Yyeshhh...</i>\" you slur, drooling sugar-sweetened spit out of the corner of your mouth."
                    +"\n\nFera rubs your ");
            if (player.balls == 0) EngineCore.outputText("inner thighs");
            else EngineCore.outputText("[balls]");
            EngineCore.outputText(", squeezing you encouragingly.  \"<i>Now, I am a generous goddess. Your gift will be to aid me by being a rapacious, horny predator, one who will seed every strong person or monster " + player.mf("he", "she") + " encounters until there is an army of unstoppable fuck-monsters roaming the lands.  You will fertilize the weak again and again, until they give birth to strong offspring.  You'll make the males your subservient bitches, only fit to serve your pregnant slaves and to take your steaming loads in their holes whenever there's no suitable female around</i>\"  She taps her chin thoughtfully.  \"<i>How does that sound?</i>\""
                    +"\n\nThere isn't enough guidance in that question to rouse a response from your supine form, so Fera continues on, smiling all the while.  \"<i>Oh, I'm going to do it, [name].  You're going to do this for me.</i>\"  She idly slips a finger along the underside of [oneCock] and licks her lips.");

            //[next]
            player.dynStats("lus=", player.maxLust());
            EngineCore.menu();
            EngineCore.addButton(0, "Next", dickBoostingFuntimes);
        }

        //Get a Boosted Dick!
        function dickBoostingFuntimes():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You hang there, suspended, spread-eagled, and with your dick [sheath]-deep in a giant pair of fuck-hungry lips as the goddess circles you, running her dagger-sharp nails gently across your " + player.skinFurScales() + " until she stands behind you, arms wrapped around your [chest] and squeezing. She nips at your ear, biting it gently but getting no response from your blissed out, drug-ravaged body."
                    +"\n\n\"<i>Suck,</i>\" the goddess commands authoritatively to the flower, and to you, she bids, \"<i>Fuck.</i>\""
                    +"\n\nThose beautifully plump flower-lips compress down more tightly, sealing perfectly around your length");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" just in time to take the first thrust from your hips, burying yourself into them and immediately pulling back, setting an easy, average rhythm.  At the same time, the suction starts, causing your ");
            if (player.cockTotal() > 1) EngineCore.outputText("heads");
            else EngineCore.outputText("[cockHead]");
            EngineCore.outputText(" to swell up a little, and when the rest of your length is plowed through the tight, slippery ring, the tugging vacuum increases, plumping your dick");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" bigger, harder, and fatter than ");
            if (player.cockTotal() == 1) EngineCore.outputText("it");
            else EngineCore.outputText("they");
            EngineCore.outputText(" should be."
                    +"\n\nFera, unseen but felt behind you, begins to whisper thoughts and ideas into your ears as you sway in the corrupt flower's embrace.  \"<i>You like to fuck, don't you [name]?  To thrust and hump until your [balls] ");
            if (player.balls > 0) EngineCore.outputText("empty");
            else EngineCore.outputText("empties");
            EngineCore.outputText(" so that you can start the cycle anew.  You love that, and this is the perfect place for that kind of behavior, isn't it? Everybody in this world wants to fuck, they just like to fight to see who gets to be on top, and you're good at winning, aren't you, pet champion?</i>\" Fera ");
            if (player.balls > 0) EngineCore.outputText("cups your [sack] tenderly");
            else EngineCore.outputText("tickles your taint");
            EngineCore.outputText(" to spur you to thrust harder while she fills your head with lurid thoughts."
                    +"\n\n\"<i>Go on, fuck it harder. Assert yourself, [name].  Tame that fuck-hole.  Give it the sperm-filling it deserves,</i>\" the goddess instructs."
                    +"\n\nOn command, you pound away, causing the huge pillows to shiver and shudder with your slap-happy impacts, feeling the tightness of an on-command orgasm building deep within you, as inexorable as the rising tide. Your eyes cross from the pleasure, and you hilt yourself, erupting what feels like gallon after gallon of sticky, fertilizing spooge into the suck-hungry passage, flooding it with your jism."
                    +"\n\nFera pinches your [nipples] and instructs, \"<i>Don't go soft, [name]. You go right back to humping, stay horny... always horny.  Remember how good it felt to fill that hole with cum.  Realize that you can feel like that again and that you will.  All you have to do is think about how horny Mistress Fera has made you and what a rutting, breeding fuck-tool you are.</i>\"  She squeezes your [sheath] when you pull back.  \"<i>It is your duty to flood every hole with your cum.  You are the superior mate.  You are the most powerful creature out there, and it is your duty to show every person you meet that fact.  It is your duty to fuck them into their place.</i>\""
                    +"\n\nShe squeezes harder until you whine with excitement, feeling a warm, wet tongue slither around [eachCock], licking and suckling as it devours your contribution.  [EachCock] is spasming and flexing, already as hard as it can possibly be and once more ready to unload."
                    +"\n\nFera coos, \"<i>Cum again for me while we make this tool a little more suited to your duty, [name]. Unload.  Your mistress commands it.</i>\""
                    +"\n\nYou sputter and spurt, each crest of pleasure stronger and more potent than the last, and Fera rubs your ");
            if (player.balls > 0) EngineCore.outputText("[balls]");
            else EngineCore.outputText("taint");
            EngineCore.outputText(" as you do, whispering, \"<i>Good " + player.mf("boy", "girl") + ",</i>\" into your ears as dark energies flow into you, refilling your fast-emptying reservoirs faster than they can empty.  \"<i>Don't stop yet, [name].  You're going to be doing this a lot, so I'm giving you lots of practice.</i>\""
                    +"\n\nYou shudder as your climax starts all over again, right before the last one ends, locking you in a cycle of thrusting, shuddering, starting to withdraw and then planting yourself back in and groaning. Your eyes flutter closed, your mouth hangs open, and Fera whispers instruction after instruction into your pliant little mind, sowing the seeds of your libidinous behavior to come.  Honestly, you don't ever want to stop.");
            //Cum, dick length +1, dick thickness increased noticeably, libido +10, cum production +1000, bonus virility.
            for (var x:int = 0; x < player.cocks.length; x++) {
                player.cocks[x].cockLength++;
                if (player.cocks[x].cockThickness < player.cocks[x].cockLength / 5) {
                    player.cocks[x].cockThickness = player.cocks[x].cockLength / 5;
                }
            }
            player.orgasm();
            player.dynStats("lib", 10, "cor", 5);
            if (player.findPerk(PerkLib.FerasBoonSeeder) < 0) {
                player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
            }
            EngineCore.menu();
            EngineCore.addButton(0, "Next", postSeederUpgrade);
        }

        function postSeederUpgrade():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You awaken fully dressed with a familiar ache between your legs.  Damn, that was a good nap.  You rise, scratching [oneCock] and smiling as you feel how hard and sensitive it is.  You're already feeling pretty anxious for a fuck, especially after the crazy wet dreams you had last night, and you resolve to find a nice hole to dump a few loads into before too long.  First, you had better go check back up on your camp.  You've got to bring your A-game if you're going to fuck stronger babies into every weak pussy you come across.  Besides, the wait will only make your eventual sexual enjoyment that much messier.");
            //Add ten more corruption.
            //Add 50 lust.
            player.dynStats("lus", 25, "cor", 10, "scale", false);
            EngineCore.doNext(SceneLib.camp.returnToCampUseFourHours);
        }

        //Stick a Stamen in It!
        function stickAStamenInIt():void {
            EngineCore.clearOutput();
            flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] = date.fullYear;
            EngineCore.outputText("You dazedly stagger forward, one [foot] after another falling on the supple flesh of the gigantic, color-shifting petal that rises up towards the flower's center like steps on an ancient ziggurat.  The closer you get, the more vibrant the hues become, the thicker the scent becomes, and the simpler and more instinctive your thought processes become.  <i>Flower. Fuck. Sex. Need. Ache.</i>"
                    +"\n\nStumbling slightly, you begin to wriggle out of your [armor].  First one arm, then the other.  You pause briefly to slide your kit off, forgotten on the petal behind you, and come closer to those juicy, turgid stamen, so heavy and sticky and perfectly hard looking.  The slickness of the leaking nectar nearly robs you of your footing but you struggle on and catch hold at the seam between two petals, never letting your goal out of your sight.  On hands and ");
            if (player.isNaga()) EngineCore.outputText("tail");
            else if (player.isGoo()) EngineCore.outputText("goo");
            else EngineCore.outputText("knees");
            EngineCore.outputText(", you drag yourself up until the 'floor' flattens out and you nearly ram into the pursed lips, stopping yourself abruptly once you realize you've reached your goal."
                    +"\n\nThe stamen react to your presence with snake-like swiftness, lunging out around your arms and [legs], tangling you up in their slippery length, surprisingly warm and comforting on your skin. Darkness reigns as the flower petals snap closed with enough force to make your ears pop with a near-deafening boom. The shock is enough to rouse you from your contented stupor, though your body still burns with an unnatural lust, craving for the tentacles to touch you in a far more intimate, internal way. You still try to struggle, but as your mouth opens to scream, it is immediately plugged by a thick, vein-corded stamen."
                    +"\n\nAt the same time, the petals abruptly light themselves in waves of multicolored bioluminescence that run that spectrum from violet to red, always shifting and sliding in such a way that whenever you try to follow them, you lose yourself in the swirl of exotic color.  It's distracting enough that you fail to bite down on the tentacle in your maw or resist its plunge towards the back of your throat.  Not that it matters, your fate was sealed the moment you decided to climb up the flower.  Having a tentacle leaking its perfect ooze onto your tongue and sliding back towards the rear of your throat is little more than the final stroke of color on a master's painting.  It's so potent, so strong, this close to the source that you can practically feel it sizzle through your taste buds and into your nervous system, frying synapses as it goes."
                    +"\n\nYour struggles cease as abruptly as they started and you backslide into the comfortable, sensual embrace of your restraints, letting your [legs] spread and your [vagina] drip hungrily");
            if (player.hasCock()) EngineCore.outputText(", [eachCock] bobbing");
            EngineCore.outputText(".  You aren't hoping they'll take you, though.  On the contrary, that delicious nectar has hit your consciousness with such sublime delight that you can't possibly resist its siren call, and you've let yourself slip into a kind of happy, receptive state, your eyes dilating wide as the sweet, drugged sap does its work.  Your vision stays locked straight in front of you, up towards the ceiling, given the way you've been suspended, where you can watch the colors flip and change, dancing so wonderfully and merging and twisting and changing in ways that would make you gasp if you had the capacity for it."
                    +"\n\nThe deluge of drugs, arousal, sexual stimulation, and mind-scattering visual patterns has made your mind as pliant and vulnerable as the dripping-wet delta between your legs, so hot, wet, and soft, just waiting to take something inside it.  For now, the plant seems content to merely hold you, pushing the stamen in your mouth a little deeper, past the point where a gag reflex would kick in, were it not suppressed.  Instead, your jaw works automatically, swallowing it into your esophagus, letting it ooze its drug-laced nectar into your receptive stomach, just like you wanted (until your brain switched off)."
                    +"\n\nA perfectly smooth, perfectly dry hand traces down your back in a comforting yet sensual gesture, followed a moment later by another upon your [butt].  It squeezes you, kneading your cheek in its supple, dextrous fingers, letting long, sharp nails just barely dig into your " + player.skinFurScales() + ".  Then the hands move down to your [legs] to continue their massage, dodging around the tentacle-like stamen so that they can reach your [feet].  There, the hands stop and separate from your body, vanishing until a familiar face leans in front of you, interrupting the slew of mind-tranquilizing colors briefly."
                    +"\n\nIt's Fera, Goddess of Predation, Marae's corrupt sister, and you've fallen directly into her trap. Unfortunately, you're in no state to react, not with your belly full of sweet, narcotic goo.  In fact, you've gotten so full that the tentacle exits and allows you to breathe once more, leaving a few thick globs behind on your face as a parting gift.  The fair-skinned goddess titters, her fiery-orange tresses hanging down around you in a corrupted halo, drawing your slow-to-respond gaze to her pale, creamy skin, prominent lips, button nose, and smoldering red eyes.  \"<i>Oh, [name], I was hoping you'd come to my glade!</i>\"  She kisses your forehead tenderly.  \"<i>Last time we met, you saved me, and I gave you a gift for it.  This time, I'll save you from a lifetime of orgasms, and you'll give me a gift, all right?</i>\""
                    +"\n\nYour mind has all the ability to resist of a fertile field before a plow, and you do the only thing you can think of: agreeing.  \"<i>Yyeshhh...</i>\" You slur, drooling sugar-sweetened spit out of the corner of your mouth, your [hips] struggling against their restraints to get a good fuck."
                    +"\n\nFera rubs your [chest], tweaking a [nipple] encouragingly.  \"<i>Now, I am a generous goddess.  Your gift will be to aid me by being a rapacious, horny predator, one who will reproduce with every strong person or monster she encounters until there is an army of unstoppable fuck-monsters roaming the lands.  You will seed the weak again and again, until they give birth to strong offspring, and you will offer your womb to the biggest, strongest, toughest males you can find.  Perhaps the minotaurs.</i>\"  She taps her chin thoughtfully.  \"<i>Oh, I can let you pick!  How does that sound?</i>\""
                    +"\n\nThere isn't enough guidance in that question to rouse a response from your supine form, so Fera continues on, smiling all the while.  \"<i>I could work on your vagina, make it a proper breeding cunt, nice and gaped for easy birth and penetration.  You'll be a real hit with tentacle monsters, I bet.  They might even just slip past your poor cervix and fill you up in the rare moments where you aren't pregnant.</i>\"  She idly slips a finger in between your folds, ticking it back and forth as she talks."
                    +"\n\nFera adds, \"<i>Or, I could tighten this baby up, make it so that no matter how many cocks you take in your journeys you'll always be tight, always ready to really milk your fallen foes so that you can wick that cum up into your hungry pussy as soon as possible.</i>\"  She brushes your clit, sending involuntary shudders of exquisite pleasure through your body.");
            if (!player.hasCock()) {
                EngineCore.outputText("\n\n\"<i>Or, there's always a cock, I suppose.  You would be far more efficient at spreading your strengths that way, my obedient little slave,</i>\" Fera muses with a wide grin.  \"<i>Imagine yourself with a huge cock, constantly slick with your victims' fuckjuices, pounding pussy after pussy until every female in walking distance is carrying a litter of your young - young that will grow up and fuck and breed just as happily as their 'father.'</i>\"  You can't help but do it.  Your mind paints a vivid picture, one that makes your [legs] twist in excitement and your [vagina] drool.");
            }
            EngineCore.outputText("\n\nThe goddess pulls her finger out and brings it to her blood-red lips.  She slips it past her plump entrance to the knuckle and sighs, slowly dragging it back out, now as clean and dry as after a day at a spa. Her intense eyes regard you for a moment, and she leans down, low and close to your ear, \"<i>Tell me, pet. Tell me which is most your heart's desire.  Would you rather be a gaped, drooling breeder, ");
            if (player.hasCock()) EngineCore.outputText("or ");
            EngineCore.outputText("a tight, dick-milking rape-mother");
            if (!player.hasCock()) EngineCore.outputText(", or a libidinous dick-girl, sowing your seed everywhere you can and saving your cunt for only the strongest of mates");
            EngineCore.outputText("?</i>\""
                    +"\n\nWith the question asked, she awaits your slow-moving mind's answer.  No is not an option you're even capable of considering at this point.  Which do you want?");
            //[Gape] [Tight] [Dick]
            player.dynStats("lus=", player.maxLust(), "cor", 2);
            EngineCore.menu();
            EngineCore.addButton(0, "Gape", gapeMePleaseFera);
            EngineCore.addButton(1, "Tight", tightLikeAToigar);
            if (!player.hasCock()) EngineCore.addButton(2, "Dick", growADickForFera);
        }

        //Gape
        function gapeMePleaseFera():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Fera smiles as you announce your choice.  \"<i>I thought you might say that, little champion.  Now, you simply relax and enjoy the pleasure that only my normal weak-willed prey are allowed to experience.  You will be the first to taste it and be allowed free.  How wonderful!</i>\"  She pets your forehead."
                    +"\n\nMeanwhile, you hear a squelching, slithering sound down below as Fera pulls away, kneeling down beside you so that her lips are at your ear, washing her hot breath across it and occasionally letting her soft, pillow-like mouth press against your aural opening.  \"<i>Relllaaaax,</i>\" she commands, and you do.  Your body sags bonelessly into its organic cradle as a writhing mass of tentacle-like stamen contort just shy of your mons, their squirming shapes dripping almost as eagerly as you."
                    +"\n\nThe mass of tendrils does not delay. It lurches forward as one unified column of hole-fucking power, plowing straight into your [vagina]");
            if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) EngineCore.outputText(", spreading its well-widened lips as wide as they've ever been");
            else if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING) EngineCore.outputText(", spreading your lips well beyond the widest they've ever been and still farther.");
            else if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE) EngineCore.outputText(", meeting a bit of token resistance at your unprepared entryway and slithering stamen after stamen inside, the forerunners widening you until the entirety of the column can pass inside, gaping you almost inhumanly wide.");
            else EngineCore.outputText(", meeting more than a little resistant at your unstretched entry and finding a way in anyhow. First one tentacle slithers in, then a second, then a fourth, and so on. One after another, they spread you wider and wider, opening you until the entire wiggling column is buried deep, pulling your lips ridiculously wide.");
            EngineCore.outputText("\n\nYou do not feel an ounce of pain from the extreme insertion. You don't even feel a whiff of discomfort. All you can feel is a sense of delicious, twat-stuffing fullness, filling and expanding you all while flooding you with more of that heavenly, brain-deadening slime. Your crotch quickly overflows. There simply isn't room for all the nectar they're leaking inside. The excess is painting you with a glossy coat of nectar and girl-honey, spraying over your [legs] around the impaling members.");
            //STEAL VIRGINITY!
            player.cuntChange(90000, true, true, false);

            EngineCore.outputText("\n\nFera's voice whispers with a voice that has as much heat as the crackling coals of a long-burning bonfire, \"<i>Feel the pleasure of being filled, my servant.  Feel the bliss of stuffing yourself so full, so very full.  Only the biggest, strongest, most well-hung of mates will ever come close to filling you like this, and you will seek them out.  Your twat will hunger for huge cocks.  It will </i>thirst<i> for the cum that's lurking in those big, meaty balls.  Your womb will ache for impregnation, and you will seek it, won't you?  Answer me, my pet champion.</i>\""
                    +"\n\nYour lips mouth, exhaling your answer in a barely audible, \"<i>yessss....</i>\""
                    +"\n\nThe sap-oozing tendrils respond by pulling back and thrusting in, scraping your tightly-stretched walls, rubbing over every sensitive place. Your lips, your clit, your g-spot - they're all caressed by slick heat, forced to accept the hip-stretching insertion with nothing short of incredible excitement.  Your body shudders from head to ");
            if (player.lowerBody == LowerBody.HUMAN) EngineCore.outputText("toe");
            else if (player.tailType > Tail.NONE) EngineCore.outputText("tail");
            else EngineCore.outputText("[foot]");
            EngineCore.outputText(" as you climax, arching your back and making guttural, beast-like sounds of pleasure.  Your eyelids hang low, lazily obscuring some of those wonderful colors from your view as the pleasure and plant-sap work on you.  Shuddering, you gush girlcum harder than ever, spraying a thick wave of lady-spunk across the tentacles, shining them with your juices");
            if (player.wetness() < 4) EngineCore.outputText(" even though you're not a squirter");
            EngineCore.outputText(".  They pump on with intense, unrelenting energy, squishing wetly with every thrust, splattering juice everywhere as they ruin your poor, convulsing cunny.");
            player.cuntChange(90000, true, true, false);

            EngineCore.outputText("\n\nAs you come down, Fera resumes talking. Your body doesn't seem to care, because you start to cum again three thrusts later, riding out wave after wave of ecstasy to the sound of her simmering-hot voice filling you with idea after idea.  Her words just slip right into your delicate, open consciousness, settling in as if they're your own with every cunt-shattering orgasm that wracks your bliss-riddled form.  \"<i>This is your top priority, [name].  Pleasure.  Ecstasy.  You are going to fuck who you want, when you want.  You are going to take the sperm you want from the male you choose to father your young and you are not going to take anything for an answer except his big, fat dick in your needy cooch.</i>\"");
            player.cuntChange(90000, true, true, false);
            EngineCore.outputText("\n\nYou pant, \"<i>Yessssssssss,</i>\" though you don't know if it's due to the nerve-incinerating excitement or in agreement with Fera's declarations.  Your world dissolves into pure rapture.  The colors fade away when your eyes roll back, and the instructions seem far away, almost as if spoken to someone else.  The tentacles never stop thrusting, and you never stop cumming, focusing solely on the hot, lurid flower-fuck until your mind is laden with cruel suggestions and your body has orgasmed into unconsciousness.");
            player.cuntChange(90000, true, true, false);
            //(cum!)
            //Minimum size to 4
            if (player.findPerk(PerkLib.FerasBoonWideOpen) < 0) {
                player.createPerk(PerkLib.FerasBoonWideOpen, 0, 0, 0, 0);
            }
            //Boost fertility by a bunch
            player.fertility += 20;
            if (player.fertility > 50) player.fertility = 50;
            //Raise wetness to at least 3.
            if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK) player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;
            if (player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE) player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_GAPING_WIDE;
            //Add five corruption.
            player.orgasm();
            player.dynStats("cor", 3);
            //[Next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", gapeByFeraEpilogue);
        }

        function gapeByFeraEpilogue():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You awaken fully dressed with a familiar ache between your legs. Damn, that was a good nap.  You rise, stretching as you rub your back, sore from lying against a tree for so long.  You suppose you could hunt down a tentacle monster and see if it'd really give you a filling");
            if (player.pregnancyIncubation == 0) EngineCore.outputText(", but you'd rather fuck something that'll get you good and pregnant with a well-hung fuck-monster, like a minotaur!");
            else EngineCore.outputText(".");
            EngineCore.outputText("  You idly reach into your [armor] and stuff four fingers into yourself before sighing and removing them.  It just isn't the same as being full of cock."
                    +"\n\nAs you head back to camp to prepare for your next adventure, you realize that you had some really, really fucked up dreams.  You hope you have more tomorrow night.");
            //Add ten more corruption.
            player.dynStats("lus", 20, "cor", 10, "scale", false);
            EngineCore.doNext(SceneLib.camp.returnToCampUseFourHours);
        }

        //Tight
        function tightLikeAToigar():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Fera smiles.  \"<i>I had hoped we might do that, little champion.  Now, you simply relax and enjoy the pleasure that only my normal weak-willed prey are allowed to experience.  You will be the first to taste it and be allowed free.  How wonderful!</i>\"  She pets your forehead."
                    +"\n\nMeanwhile, one of the tentacles that had been holding you decides to disentangle itself from its brethren, swaying over towards Fera like a snake to a snake-charmer.  The goddess grabs the tentacle in her hands and smiles, tickling it just behind its exoticly-shaped glans in a way that makes it drip sweet-goo everywhere.  She stops before it can cum and changes posture, gripping the stalk tightly in her hand and curling her fingers inward until the tips of her nails pierce the plant-beast's skin.  It stiffens as if in pain and then goes limp, pinpricks of inky blackness spreading from where it's been punctured.  The inky coloration doesn't appear to be decay but rather an almost latex-like sheen."
                    +"\n\nThe tentacle's inky spots expand to big, black blotches before combining together to turn the first foot of the thing into a rubbery onyx dong.  The corrupted, sextoy-like texture spreads like wildfire down the stalk and beyond your view, though you're sure it must stop somewhere, because the other tentacles never change color.  That succulent syrup that leaks from the tip changes to the same color, every bit the same tone but still completely liquid, dripping down off of it to splatter wetly on the floor as Fera strokes it once more."
                    +"\n\n\"<i>Don't mind the exotic tone, dear.  It won't change how your pussy looks one iota");
            if (player.skinAdj == "latex" || player.skinAdj == "rubber") {
                EngineCore.outputText(", not that a " + player.skinAdj + " honey like you would notice");
            }
            EngineCore.outputText(", but it will change how quickly your pussy recovers from a nice gape.  It will definitely change how your pussy feels about getting fucked, no doubt about that,</i>\"  Fera promises as she continues to stroke her pet rubber-plant, leaning low to kiss you once she finishes.  Though you lack the capacity to kiss back by this point, your mouth is pliant and unresisting, and you are able to feel the intensely erotic sensation of a goddess' tongue in your mouth.  More importantly, you can taste her, and while her flavor is different than the nectary plant-sap you were instantly addicted to, it is even more divine, like cinnamon mixed with the essence of lust and sex."
                    +"\n\nBreaking away at last, she smiles once more and releases her tendril.  \"<i>Go on,</i>\" she says to it, \"<i>Do what I created you to do. Do what you were meant to do.</i>\""
                    +"\n\nThe sable shaft disappears below before surfacing above your vulnerable cleft, spattering hot, wet, goo all over the puffy lips of your sex.  Sighing, you arch your back and await the coming penetration, opening yourself to be used by this creature, obediently awaiting the remolding of your pussy into a permanently tight twat."
                    +"\n\n\"<i>Good girl,</i>\" Fera coos as she drops down beside you and presses her lips to the edge of your ear.  \"<i>Just relax and enjoy the pleasure that comes from being one of my pets.</i>\""
                    +"\n\nYou groan in unrestrained lust, forced by her command to relax in spite of the lava-hot need drooling out from your [vagina] and at the same time enjoy it as fully as possible, focusing on every tingle of pleasure from the vine's slow, slick shifting about your body.  Some more black goo splatters across your mons, and you nearly cream to the feeling of that warm, corruptive ooze sliding between your lips and tainting you with Fera's inescapable love.  Your lips spread on their own, displaying the interior of your nectar-stained pussy to the horny tendril, practically begging for it to take you and spear you over and over until your pussy is stuffed to the brim with its pussy-tightening fuck-slime."
                    +"\n\nTouching against the pliant, slippery vulva that girds your entrance, the tendril rubs its rounded head against you in a surprisingly gentle way, teasing your exterior until you're aching to buck back against it, but you can't, Fera told you to relax.  Disobedience is a concept your poor, addled psyche won't remember for some time.  You hang there, mewling like a cat in heat, pussy splayed and being touched but not penetrated.  Breathily, you repeatedly make pathetic little begging noises, and turn your slow-to-respond eyes towards Fera's face questioningly, begging the goddess with your moans."
                    +"\n\nShe smiles, and the tentacle finally pushes forward");
            if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LEVEL_CLOWN_CAR) EngineCore.outputText(", slipping past your capacitive entrance with ease");
            else if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_GAPING) EngineCore.outputText(", sliding into your welcoming entrance fairly easily");
            else if (player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE) EngineCore.outputText(", slowly working its way into your decently unstretched entrance");
            else EngineCore.outputText(", slowly burrowing past your tight, restrictive entrance");
            EngineCore.outputText(" and leaving a trail of slick, black corruption in its wake.  The tendril pushes the whole way up to your cervix, gently butting up against your womb's portal before dragging back out, sputtering more inky cum all the way.  When it pops out, the head catches the tip of your [clit], causing your [vagina] to spasm and contract, squeezing down on the foreign fluid with such strength that a geyser of sable spunk erupts from your quivering quim.");
            player.cuntChange(1, true, true, false);
            EngineCore.outputText("\n\nFera coos, \"<i>Atta girl, are you feeling it?  Can you feel the way your pussy is tightening up?  You can, I know, and your womb is getting thirstier and thirstier, just aching to squeeze the cum out of a helpless male or herm that you've taken the time to beat into their place, right, my pretty?</i>\"  Her fingers reach down to your black-stained cleft and rub around the hardening gunk that paints your crotch, making it look like someone painted liquid latex all across your [skin].  At the same time, the tendril lunges back in to your spunk-spouting cunt, plugging it just before it starts to unload once more, its stalk undulating between your legs with each thrust, rising up and straightening with each hip-shaking thrust it delivers to your increasingly supple, stained box."
                    +"\n\nYou cum, and you cum... and you cum some more.  Each orgasm comes closer on the heels of the one before, wetter, hotter, and more powerful than the last.  Despite the commands to relax, your body shakes and quivers like a leaf caught up in a tornado, helplessly tossed about on disastrously strong winds of ecstasy.  Your [legs] clench around the penetrating stalk, increasingly painted with the onyx hue of your floral lover's distilled love, and you give yourself over to the passion, screaming and crying and moaning until your voice goes hoarse and Fera's gentle whispers shush you into silence."
                    +"\n\nYou have no choice but to obey as you lose consciousness to the pleasure, your mind left as open to Fera's instructions as your pussy is to that ever-thrusting, continually-cumming vine-cock.");
            //(cum!)
            player.orgasm();
            player.dynStats("lib", 5, "sen", 20, "cor", 3);
            //Maximum size to 2
            if (player.findPerk(PerkLib.FerasBoonMilkingTwat) < 0) {
                player.createPerk(PerkLib.FerasBoonMilkingTwat, 0, 0, 0, 0);
            }
            if (player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_LOOSE) player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
            //Boost fertility a little
            player.fertility += 10;
            if (player.fertility < 50) player.fertility = 50;
            //Raise wetness to at least 3.
            if (player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK) player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_SLICK;

            //[Next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", tightnessEpilogue);
        }

        function tightnessEpilogue():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You awaken fully dressed with a familiar ache between your legs.  Damn, that was a good nap.  You rise, stretching as you rub your back, sore from lying against a tree for so long.  You suppose you could find yourself something to fight and fuck, but you ought to head back to camp first.  You idly reach into your [armor] and slip a finger into your [vagina], feeling your tight walls instinctively clamp down and squeeze it.  It's nice, but it's just so much better when you can do that to a captive cock until it has no choice but to impregnate you with its hot seed.  What better way to save the world than by making sure that the strongest get to breed as often as possible?"
                    +"\n\nAs you head back to camp to prepare for your next adventure, you realize that you had some really, really fucked up dreams.  You hope you have more tomorrow night.");
            player.dynStats("lus", 20, "cor", 10, "scale", false);
            EngineCore.doNext(SceneLib.camp.returnToCampUseFourHours);
            //Add ten more corruption.
        }

        //Grow a Dick!
        function growADickForFera():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Fera's luscious lips twist up into a knowing smile as you announce your decision.  \"<i>Really? You're a girl after my own heart.  You're going to miss out on experiencing the pleasure I normally give my prey,</i>\" she says with a gesture to one of the tentacle-like stamen as it rises up above your face, dripping its sweet nectar across the bridge of your nose.  \"<i>But, you'll get to feel the bliss of cumming like a man, filling a nice, tight hole with a steaming-hot load of spunk again and again, and you'll even get to play with your cunt while you do it.  Prepare yourself, pet, for the experience of your lifetime.</i>\""
                    +"\n\nA juicy-sounding 'schluck' sounds from below your [butt] when she finishes her proclamation, and a tendril far different from its flowery brethren rises up above your [legs], angling down towards your groin with an unflinching, almost robotic attention.  The tip is clearly hollow and lined with thousands of tiny, wiggling cilia, all slick and slimy with some kind of clear ooze, but that isn't what catches your eye.  No, there is something far more menacing protruding from the stalk's opening - a needle-like spike at least four inches long, though only an inch sticks past the lips of the cup-like tendril."
                    +"\n\nFera crouches down next to your ear, planting her puffy, ruby kissers up against the lobe of your ear.  \"<i>It won't hurt, my pet champion. It won't hurt at all.  You've far too much of my sap inside you to feel pain by this point.  Instead, the only thing you'll experience is the erotic pleasure of allowing my voice to guide your thoughts and shape your mind, making you hotter, wetter, and more eager for a huge, throbbing cock.</i>\"  She purrs an indecipherable sound of pleasure.  \"<i>Get ready to feel so very good, [name]....</i>\""
                    +"\n\nAs soon as Fera trails off, the exotic vine begins to lower itself down, carefully positioning itself squarely above your mons, perhaps an inch above your [clit].  It holds steady there, making minute adjustments this way and that, jerking with each slight change in aim to track your less-than-stationary, suspended form.  There is a moment of complete silence and breathless anticipation, and then, it scythes downwards, slamming into you with sufficient force to rock you down in your organic harness");
            if (player.tailType > Tail.NONE) EngineCore.outputText(" and press your tail to the ground");
            EngineCore.outputText(".  You feel the wetness of the hollow tube as it presses against you along with a lance of pure desire and heat in the very center, undoubtedly caused by the tainted needle as it slips through your unprotected flesh.  The thing is compressed so tightly against you that it looks like the entire injector was able to bury itself in your body."
                    +"\n\nYour whole body shudders in surprise before Fera soothes you back into stillness, and then, it begins, not with pain but with a whimper of bliss. You feel that heat grow into a fiery knot before blossoming into a molton-hot ball of tight, aching need. That part of your body feels so... so compressed, almost crushed into place by the flesh around. You shudder and thrust your hips, crying out in eagerness and ecstasy, tears streaming from your empty, dilated eyes as you hump the tentacle in accordance with the drives you can't understand, only obey. The tightness increases until it feels like that spot is about to be crushed by the rest of you, yet you drip hot ladyspunk all over the organic 'floor,' loving every second of it."
                    +"\n\nPulling back, the tentacle's cup-like tip stretches away from your body a few inches, its base still sealed tight to your " + player.skinFurScales() + ", tugging and pulling with gentle suction.  There's a moment of insistent, tremendous pressure, upwelling like a long-dormant volcano, and suddenly, the pressure is gone, and gods, it's so fucking hot and good and sensitive and you start to cum, nearly throwing your back out as you scream out in pleasure for your goddess to hear.  There's more of you that feels pleasure than ever and it's so hot, full, and just... twitching with bliss that you can barely stop moaning long enough to breathe."
                    +"\n\nThe stalk above your crotch has bulged out significantly, distended with a thicker, concealed shape for the first eight inches of its length, and there are slow bulges traversing up and away from you, each timed to a particularly, bliss-loaded pulse from the new, concealed organ.  Every single, little, wriggling nub inside that hollow tube is stroking and squeezing down on your miraculous new cock, and a pillar of liquid-hot lust is boiling up and out the very middle of it while the spike sits, lodged inside and pumping something else back inside, keeping your orgasm going."
                    +"\n\nYou're crying with sublime ecstasy as you let the pleasure consume you, simply feeling yourself constantly erupting, constantly swelling... constantly blissful.  Your eyes roll back, and Fera is whispering into your ear, but the words don't need to be understood, only heard, only left to burrow deeply into your psyche and embed themselves there, right where they can stay and take root.  You slip from consciousness to the feel of your new cock expanding past nine inches in length...");
            //(cum!)
            player.orgasm();
            player.dynStats("lib", 10, "sen", 10, "cor", 3);
            //Grow a 10" human or tentacle dick! RANDOM!
            player.createCock();
            player.cocks[0].cockLength = 10;
            player.cocks[0].cockThickness = 2.5;
            //Add five corruption.
            if (player.findPerk(PerkLib.FerasBoonSeeder) < 0) {
                player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
            }
            EngineCore.menu();
            EngineCore.addButton(0, "Next", afterFeraGivesYouACawk);
        }

        function afterFeraGivesYouACawk():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You awaken fully dressed with a familiar ache between your legs.  Damn, that was a good nap. You rise, scratching your [cock] and smiling as you feel how hard and sensitive it is.  You're already feeling pretty anxious for a fuck, especially after the fucked up wet dreams you had last night, and you resolve to find a nice hole to dump a few loads into before too long.  First, you had better go check back up on your camp.  You've got to bring your A-game if you're going to fuck stronger babies into every weak pussy you come across.");
            //Add ten more corruption.
            //Add 50 lust.
            player.dynStats("lus", 20, "cor", 10);
            EngineCore.doNext(SceneLib.camp.returnToCampUseFourHours);
        }
    }

    public static function isAprilFools():Boolean {
        return date.date == 1 && date.month == 3;
    }

    public static function poniesYN():Boolean {
        // Encounter Chance 1 out of 40 and only if you're a centaur
        if (player.lowerBody == LowerBody.HOOFED && player.isTaur() && date.date == 1 && date.month == 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00118] == 0) {
            EngineCore.clearOutput();
            EngineCore.outputText("While walking around the lake, you hear the sound of feminine voices laughing and talking, accompanied by the distinctive clip-clop of hooves. Stepping lightly through the overgrowth you stumble across a group of small brightly colored ponies. The strange part about them isn't so much their size, but rather the shape of their bodies.  They almost look cartoonish in nature, a few even sport fluttery, feathery looking wings.\n\n");
            //(option: Approach? Leave them Be?)
            EngineCore.simpleChoices("Approach", approachPonies, "", null, "", null, "", null, "Leave", leavePonies);
            flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00118]++;
            return true;
        }
        return false;

        //----------Next Page-----------
        function leavePonies():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Deciding it must be some demonic trick, you decide to retreat from the scene before they notice your presence.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        function approachPonies():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You slowly begin your approach, though you are spotted almost immediately by the pink one.\n\n"
                    +"You aren't two steps out of the forest before it seems she, and it HAS to be a she, seemingly teleports in front of you with an expression of rapture and joy pasted on her face.  You almost instinctively pull out your [weapon], startled by the appearance of the pink one in your face.  Immediately she starts asking a myriad of questions, speaking at a speed which makes it impossible to understand a word.  Almost as stunning is the fact that she is speaking in a human tongue. Before you have the time to gather yourself up and figure out what the pink one is saying, or even what is going on, the rest of her group have managed to catch up to her, and begin calming her down.\n\n"
                    +"The purple one turns to you looking apologetic and a bit exasperated, \"<i>Sorry for our friend startling you. She gets excited <b>really</b> easily.</i>\"\n\n"
                    +"You respond that it's no problem, but she should be more careful approaching strangers");
            if (player.weaponName != "fists") EngineCore.outputText(", especially armed strangers");
            EngineCore.outputText(".\n\n"
                    +"The blue one looks at you in a puzzled manner while hovering above the ground, \"<i>Actually, you are the first person we have seen who isn't a pony.</i>\"\n\n"
                    +"To be fair, you tell them, you haven't seen any one who IS a pony.  The pink one, now slightly calmer, interjects herself into the conversation \"<i>Ponies, not ponies, whatever!  We have a new friend, and I say PARTY!!!</i>\"\n\n"
                    +"These little horses are definitely a rambunctious bunch, especially the white one, who, from the moment she spotted you, hasn't stop complaining about your awful sense of fashion. The only exception seems to be that yellow one hiding behind a screen of squirrels, birds and what you think are three generations of rabbits.\n\n"
                    +"What should you do? You could party with the horses; after all, you haven't had a reason to party since getting here. You can politely decline for now or leave these oddly colored and slightly disturbing creatures for the more familiar sight of demons.\n\n"
                    +"Whichever you choose, something tells you that you won't see these ponies again.");
            //Option one: Leave Politely
            //Option Two: Too creepy...
            //Option three: Yay, party?
            EngineCore.simpleChoices("Too creepy", derpCreepy, "Yay Party!", derpyParty, "", null, "", null, "Leave", derpPolitely);
        }


        function derpPolitely():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You hold out your arms and stop the ponies.  Once you have their attention you let them know you have something important you need to do for now, but will come back soon.  With a wave you turn and walk back into the trees to a chorus of disappointed \"<i>ahhhs</i>\", mostly from the pink one.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        function derpCreepy():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Cocks, horns and slavering vaginas is one thing, but this is almost too much cute to process.  You determine to leave this grove and never EVER come back again.  Still disturbed by the mental images running through your head, as you make your way back to camp, you callously slaughter an imp. Yeah, that feels better.\n\n(+10 XP!  +5 Gems!)");
            player.XP += 10;
            player.gems += 5;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        function derpyParty():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You watch in amazement as the flying horses string up banners, while the purple one sets a table with snacks and drinks using glowy powers coming from the horn on her head.  Whilst they set up, you discuss your home village with the orange one who compares it with working on an apple farm and you try to ignore  the white one as she primps and fusses around you, obviously unwilling to let you stay in, to quote her own words, \"<i>Hideous attire, lacking any grace or style.</i>\"\n\n"
                    +"Time passed, and the rest of the day was a blur, mostly caused by, you assume, the large quantity of Pony Punch you drank.  As you shakily attempt to get up, snippets of the evening's events flash through your mind: a funny joke told by the pink one; the yellow one coming out of hiding to orchestrate an impromptu concerto sung by a choir of songbirds; losing a race to the blue one, (flying is definitely cheating): a derpy looking grey one who was knocking over everything in a two meter radius around her.  Your mind slowly returns to the present and as it does you take a look at yourself.  A first glance at your attire shows the magical 'improvements' the white one made are already fading away, crumbling into a cloud of pink dust that blows away, leaving you back in your [armor].  Watching your clothes change was rather distracting, but now that you are up, and ooh what a headache THAT caused, you see your clothes weren't the only thing that changed!!\n\n"
                    +"Your strong lower body has shrunk, the firm musculature replaced by an oddly cartoonish looking form.  In fact, from the waist down you look just like one of the ponies!  Everything looks to still be in the same general place, and a quick test of your new lower body proves it still functions somewhat the same. The new shape of your hooves takes a little while to get used to, but other than that you get used to your new lower body almost with no effort\n\n(<i>*Note:You should really check the character viewer</i>)");
            player.lowerBody = LowerBody.PONY;
            player.legCount = 4;
            EngineCore.doNext(SceneLib.camp.returnToCampUseEightHours);
        }

        /*Notes:
        ---------------------------------------------------------------------------------------------------------------------------------------------
        1. talk a little to the ponies, aka get to know them a little and their personalities
        2. futtershy(yellow one with pink mane) hides in the bushes and you comment of the number of small animals surrounding her
        3. rarity(white one with purple mane) comments about your awful dress attire
        4.applejack(orange one with sandy blonde mane) asks what are you doing in these parts?
        the pink one(pinkie pie) offer to throw a party in honor of our new friend
        IF you accept you wake up at you camp groaning from a headache, you definitely drank too much Pony Punch, and all you can remember is bits and pieces of the party, when you inspect yourself you see that your centaur lowerbody changed and looks very similar to the body of the ponies you encountered. You explain that the change may have been caused by the food you ate at the party. You also lose half a foot of height(optional, may not be implemented).
        If you don't accept you never encounter them again
        the way i explain this one time event is that you accidently stumbled across this place, which is protected by magic. after that you never encounter them again.
        */
    }

    public static function DLCPrompt(dlcName:String, dlcPitch:String, dlcPrice:String, nextFunc:Function = null):void {
        //DLC April Fools
        EngineCore.clearOutput();
        EngineCore.outputText(dlcPitch);
        EngineCore.outputText("\n\nYou can purchase " + dlcName + " for " + dlcPrice + ". Would you like to purchase it now?");
        EngineCore.menu();
        EngineCore.addButton(0, "Yes", buyDLCPrompt, dlcName, dlcPrice, nextFunc);
        if (nextFunc != null) EngineCore.addButton(1, "No", nextFunc);
        else EngineCore.addButton(1, "No", EventParser.playerMenu);

        function buyDLCPrompt(dlcName:String, dlcPrice:String, nextFunc:Function = null):void {
            EngineCore.clearOutput();
            EngineCore.outputText("<b>Item:</b> " + dlcName + "\n"
                    +"<b>Price:</b> " + dlcPrice + "\n"
                    +"Please select a purchase method.");
            EngineCore.menu();
            EngineCore.addButton(0, "Credit/Debit", proceedToCheckout, "Credit/Debit Card", nextFunc);
            EngineCore.addButton(1, "PayPal", proceedToCheckout, "Paypal", nextFunc);
            EngineCore.addButton(2, "Interac", proceedToCheckout, "Interac", nextFunc);
            EngineCore.addButton(3, "COMING SOON!", EngineCore.doNothing);
            EngineCore.addButton(4, "COMING SOON!", EngineCore.doNothing);
            EngineCore.addButton(14, "Cancel", nextFunc);
        }

        function proceedToCheckout(method:String, nextFunc:Function = null):void {
            EngineCore.clearOutput();
            EngineCore.outputText("You will be taken to an external website to complete your checkout. Proceed?");
            EngineCore.doYesNo(reallyCheckout, nextFunc);
        }

        function reallyCheckout():void {
            //You just got TROLLED!
            EngineCore.clearOutput();
            EngineCore.outputText(CoC.instance.images.showImage("monster-troll"));
            EngineCore.outputText("APRIL FOOLS! The game will ALWAYS be entirely free to play. :)");
            flags[kFLAGS.DLC_APRIL_FOOLS] = 1;
            EngineCore.doNext(EventParser.playerMenu);
        }

    }

    public static function isThanksgiving():Boolean {
        return ((date.date >= 21 && date.month == 10) && (date.date < 30 && date.month == 10) || flags[kFLAGS.ITS_EVERY_DAY] > 0);
    }

    public static function datTurkeyRumpMeeting():void {
        //Turkey Girl Thanksgiving Special
        //By: Savin


        /*
        Requirements:
        Introduction:
        Shoo her Off
        Let her Approach
        Baste Her
        Stuff Her
        SPITROAST HER! GangHel Style*/

        /*Requirements:
    
        -PC has a Dick
        -PC has (Dick'd)Izma or Ceraph in camp (to get the Spit Roast scene only)
        -Scene proc's at 12:00, overriding other scenes
    
        Note on progression:
           The PC has, after each scene (Baste, Stuff, Spitroast) the option to say \"<i>That's Enough</i>\" or continue on to the next scene -- the scenes must be done in order, however.*/

        //const TURKEY_FUCK_YEAR_DONE:int = 566;

        //Introduction: -McGirt
        if (flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] > 0) {
            turkeyGirlTwoTheTurkeningBySavinWhatADickInAButt();
            flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] = date.fullYear;
            return;
        }
        flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] = date.fullYear;
        EngineCore.outputText("\nYou sit down by your fire pit, looking at the meager provisions you've managed to gather up in the days leading up to the Feast for the Thankful, your village's largest annual feast day.  Right now through the portal, your friends and loved ones from Ingnam are sitting down to a mighty banquet, holding hands in prayer before devouring more food than they can possibly stand.  A pang of homesickness sweeps through you as you look at the small meal before you.  With a sigh, you pick up your fork and prepare to dig in."
                +"\n\nSomething stirs at the edge of camp."
                +"\n\nYou jump to your feet, readying your [weapon] for battle as you scan the perimeter.  A moment later, and you see a ponderous figure step out of the shadows behind a large rock.  At first glance, it looks like a normal girl dressed in a simple deerskin poncho, her bright red hair falling past her shoulders to rest on a pair of absolutely massive breasts.  Timidly, she steps forward, giving you a good look at her less human attributes: a pair of avian legs stick out beneath the hem of her clothes, and a large plume of feathers stick up from her big bubble-butt, each red feather nearly reaching the back of her head.  And her breasts... each easily the size of a goblin, so massive that it seems she can barely wobble along."
                +"\n\n\"<i>G-gobble?</i>\"  she asks quietly, her big blue eyes pleading at you.");

        //[Shoo her Off] [Let her Approach]
        EngineCore.simpleChoices("Let Approach", letZeTurkeyApproach, "Shoo Away", shooTurkeyAway, "", null, "", null, "", null);

        //Shoo her Off -McGirt
        function shooTurkeyAway():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You scowl and wave your arm at the strange turkey-girl, telling her to get lost."
                    +"\n\n\"<i>G-gobble?</i>\"  she repeats, cocking her head to the side."
                    +"\n\nRolling your eyes, you yell at the strange girl until she finally gets the idea and; with a few more sorrowful gobbles, she wobbles off again, looking for someone else to bother."
                    +"\n\nShaking your head, you sit back down and eat.");
            if (player.hunger > 60) player.hunger = 70;
            player.refillHunger(40);
            EngineCore.doNext(EventParser.playerMenu);
        }

        //Let her Approach
        function letZeTurkeyApproach():void {
            if (player.gender == 2 || (player.gender == 3 && Utils.rand(2) == 0)) {
                femaleLetZeTurkeyGalApproach();
                return;
            }
            EngineCore.clearOutput();
            EngineCore.outputText("Considering her ponderous form, the girl obviously poses no threat.  You wave her over, telling her to come on into camp.  With a huge grin, the turkey-girl wobbles over, her gigantic breasts swaying underneath her moccasins until she plops down beside you.  You try saying hello and introducing yourself, but the girl simply cocks her head to the side and murmurs, \"<i>Gobble?</i>\""
                    +"\n\nYou raise an eyebrow.  Is that all she can say?"
                    +"\n\n\"<i>Gobble?</i>\"  she asks again, her hand drifting onto your leg.  You feel [eachCock] involuntarily stiffening as her slender, alabaster fingers slide along your thigh.  \"<i>Gobble,</i>\" she repeats, brushing your stiffening prick through your [armor].  Oh, is that what she wants?  Well then....");

            //(Baste Her) (That's Enough)
            EngineCore.simpleChoices("Baste Her", basteThatTurkeyBooty, "No Thanks", noThanksTurkeyGal, "", null, "", null, "", null);
        }

        function noThanksTurkeyGal():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You reluctantly push her away.  You've no need to ram your dick down some new monstrosity's gullet.  The girl forlornly gobbles one last time, then prances off into the fading evening light, globular ass jiggling.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //Baste Her -McGirt, reluctantly
        function basteThatTurkeyBooty():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You let your cock slip free of your [armor], and immediately the turkey-girl takes it in hand, wrapping her fingers around your thick shaft and giving it a few long, languid strokes.  \"<i>Gobble?</i>\"  she asks, and this time you nod as she leans down toward your cock, her long tongue flicking out to run across the [cockHead], tickling the slit of your urethra as she continues to pump your prick."
                    +"\n\nHer huge tits pop free as you toss her deerskin poncho aside, the massive orbs falling into your lap around your [cock].  The turkey lowers herself onto your rock-hard rod, wrapping her full red lips around the crown and slurping it up.  You run your fingers through her red hair, guiding her head down along your shaft, pushing more and more of your length past her rosy lips and into the wet vice of her throat.  She gags a moment as your tip brushes past her tonsils, but relaxes in your grip, content to let you slowly stuff the entire length of your cock into her pliant mouth."
                    +"\n\nWith your [cock] shoved fully into the turkey-girl's mouth, you let her begin to blow you, moving her head up and down your length, her tongue lapping hungrily as the underside of her throat contracts around the shaft, trying to gobble it all up.  You stroke her hair, urging her onwards, enjoying the pleasant tightness of her throat and the ministrations of her tongue.  You let the turkey-girl carry on for a few rapturous minutes, shuddering as her coarse tongue slathers your [cock] with her warm saliva, her lips pressed firmly around the inches of your prick she takes in and out of her mouth, always keeping the thick crown in her mouth, lavishing it with throat-kisses and gentle suckling."
                    +"\n\nAn idea comes to mind as you begin to feel a knot forming in your [balls].  You grab the turkey-girl's bare, supple shoulders and push her up onto her knees, leaving her kneeling in front of you, a surprised \"<i>Gobble?</i>\"  escaping her lips as your cock pops free.  Time to baste this turkey."
                    +"\n\nYou stand and grab her titanic tits, hefting them up and pushing them together around your stiff [cock].  You start to buck your [hips] into her soft, yielding titflesh, using her massive mammaries to get yourself off.  Quickly, thick rivulets of pre begin to leak from your crown, smearing onto her breasts as you titfuck the hapless girl.  She lets out a series of alarmed gobbles as you thrust into her chest, but finally gets the idea as your leaking head pokes out from between her mounds and, like a good little cock-gobbler, slurps it back up into her eager mouth."
                    +"\n\nYou move faster and faster, willing the potent seed surging through your loins out and onto the strange turkey, humping her tits until with a roar of ecstasy you pull out of her mouth and cum. Thick globs of spunk shoot out of you, smearing the turkey-girl's face, the tops of her huge breasts and, from there, leaking down onto her flat stomach and bare thighs.  You continue to thrust between her tits, spurting out the last of your climax onto her neck and chest, utterly covering the turkey-girl with your seed."
                    +"\n\n\"<i>Gobble!</i>\"  she cries ecstatically, a huge smile playing across her face as she licks up a bit of your cum from her cheek, drinking it up without inhibition.  With a sigh, you let the girl's bosom fall free, leaving your wilting prick in the warm air, content with the powerful face-fucking you've given the eager slut.  You run your hand through her hair again, telling her what a good cock-gobbler she is."
                    +"\n\n\"<i>G-gobble?</i>\""
                    +"\n\nThe turkey-girl smiles at you and flops onto her back, spreading her meaty thighs to give you a good look at the trimmed red bush between her legs, and the glistening slit of her vagina.  It looks like she wants some stuffing....");
            player.orgasm();
            player.dynStats("sen", -1);
            EngineCore.simpleChoices("Stuff Her", stuffDatTurkeyWithSpoo, "", null, "", null, "", null, "That'll Do", thatllDoTurkey);
        }

        //Stuff Her -McGirt, this is awful by the way.
        function stuffDatTurkeyWithSpoo():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Even though you just came, the sight of such an inviting pussy causes your cock to begin to stiffen again.  You move between the turkey legs, tossing them over your shoulders to give you the best angle on her slick snatch.  You give her an experimental lick, running your tongue across her outer folds.  The girl shivers slightly, a tiny gasp passing her lips as you flick your tongue across her tiny bud.  Spurred on by her cute reactions, you bury yourself between her thighs, lapping at her cunt and clit.  Soon, she's nice and ready, her slit practically leaking her lubricants as you orally assault her, preparing her passage for your stuffing."
                    +"\n\n\"<i>Gobble?</i>\"  she coos, her fingers slipping down to spread her lips wide as you withdraw, giving you a perfect look at the waiting hole for you to fill.  You grin at her and, straightening yourself out, let your [cock] flop onto her crotch, the shaft resting between the lips of her womanhood.  You slide back, letting the [cockHead] of your prick line up with the turkey-girl's tunnel."
                    +"\n\nAnchoring your fingers around her thick thighs, you ease yourself into the turkey-girl.  A ragged gasp escapes her lips as your turgid [cock] parts her lower lips, sliding through the spit-lubed channel of her cunt with agonizing slowness.  You revel in the tight, slick muscles of her cunt contracting around you, her pussy squeezing down on your invading member as you push further and further into her, nearly tearing her tight slit apart until your crotch presses against hers."
                    +"\n\n\"<i>G-gobble?</i>\"  the girl asks plaintively, looking over the massive mounds of her breasts to watch the final inches slide into her.  Oh, those do look like inviting targets...."
                    +"\n\nYou begin to move your hips, slowly rocking a few inches of your cock out and back into the turkey's vice-like sheathe.  Yet your attention turns to the huge, soft orbs of her tits, so large that all but the top of her head is obscured by titflesh.  You reach up, sinking your fingers into one of the huge mounds, angling the large, pink nipple towards you.  A moment passes, your fingers kneading her sensitive breast as you push your cock into her to the hilt."
                    +"\n\n\"<i>Gobble,</i>\" the turkey-girl suggests, pushing her mountainous breast toward you, the little nub of her nipple practically brushing your cheek.  You lick your lips and accept the proffered teat, locking your mouth around her large, pale areola.  You run your tongue around the turkey-girl's teat, swirling around the delicate outer flesh before running across the ridges of her stiff nipple."
                    +"\n\nTo your surprise, something comes out as you suckle from the turkey-girl!  For a moment, you prepare to feast upon a stream of milk from the strange avian, but... it's much too thick, and whatever she's lactating into your mouth tastes like... wait, no.  No way it's actually..."
                    +"\n\n...Gravy?"
                    +"\n\nYou gag a bit as a thick trickle of gravy spills down your throat, now pouring freely from the girl's heavy-laden teats.  She sighs contentedly as you swallow another mouthful of tit-gravy, starting to form a rhythm of sucking sharply between steadily quickening thrusts into her sodden vagina."
                    +"\n\nSoft moans begin to echo through the air as you thrust harder and faster into the turkey-girl, lapping up half a gallon of gravy from one of her huge tits before switching to the other, giving her neglected nip the attention it deserves.  You hammer into her, thrusting with enough force to let loose spurts and trickles of femcum and your own pre as the turkey-girl throws her head back in rapture, overwhelmed by the dual sensations."
                    +"\n\nWith a laugh, you let go of the turkey's tit and bury your face between her mounds, burying yourself in her expansive flesh as ");
            if (player.cumQ() < 1000) EngineCore.outputText("you let loose another load of seed, this time deep into her cunt.  You grunt and growl animalistically, pumping thick gobs of spunk into her until the turkey's womb is practically painted white with your cum.  Each roar sends shudders through her teats, waves of the fatty flesh forming as you cry out into her chest.  You steady yourself between orgasmic thrusts by grabbing onto her melons, your sudden grasp harsh enough to elicit a stream of titgravy from inside her.");
            else EngineCore.outputText("your [cock] distends and bulges.  A startled gasp catches in her throat as the hapless fowl's fuckhole is stretched wider by the oncoming storm.  No sooner has your shaft unloaded a monstrous surge of virile spunk deep inside her cunt than a familiar pressure signals yet another load is on the way.  As you continue to stuff the bitch with baby batter, her once-taut stomach swells outwards, jiggling and gurgling with each fresh load.  Your grunts and growls intermingle with the overstuffed turkey's moans of mindless lust.  Each roar sends shudders through her teats, waves of the fatty flesh forming as you cry out into her chest. You steady yourself between orgasmic thrusts by grabbing onto her melons, your sudden grasp harsh enough to elicit a stream of titgravy from inside her.");

            EngineCore.outputText("\n\nSoon, between your kneading out the thick gravy from her breasts and the spunk leaking out from her loins, mixing with what you splattered across her minutes earlier, the poor turkey is absolutely filthy, covered in the remnants of your rough fucking.  Slowly, languidly, you pull out from inside her, your cock still dribbling little rivulets of cum onto the musky girl's thighs.  The air around you now reeks of sex and a warm meal, her strange breastmilk creating a strong aroma of its own below that of drying spooge.");
            player.orgasm();
            player.dynStats("sen", -1);
            if (flags[kFLAGS.HEL_FUCKBUDDY] == 1 && flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] == 0) {
                EngineCore.outputText("\n\nAs you lay atop the turkey, you hear a faint, almost pleading, \"<i>Gobble?</i>\"  from her. Furrowing your brow, you pick yourself up to look at the cum-slathered turkey.  As soon as you're off her, she rolls over onto her hands and knees, her big bubble butt sticking up in the air for you, her plume of feathers tickling your cheeks.  She... still wants more?</i>\"");
                EngineCore.simpleChoices("Spit-Roast", spitRoastThatTurkey, "", null, "", null, "", null, "That's Enough", thatllDoTurkey);
            }
            else EngineCore.doNext(thatllDoTurkey);
        }

        //SPITROAST HER! GangHel Style
        //(Needs friendly/lover Hel)
        function spitRoastThatTurkey():void {
            EngineCore.clearOutput();
            EngineCore.outputText("As you contemplate what to do with the insatiable turkey-girl, you hear another rustling at the edge of camp.  For a moment both worried and aroused by the thought of a whole flock of these sluts, you glance up in time to see a certain salamander poking her way through your bevy of traps."
                    +"\n\n\"<i>Here, Cockgobbler!  Here girl!</i>\" she calls, letting out a sharp whistle that echoes through the camp. \"<i>C'mon out, girl, I know you're --- on hey, lover mine!  Don't suppose you... oh, I see you met my little Cockgobbler,</i>\" Hel laughs, sauntering over."
                    +"\n\n\"<i>Aww, did you find a juicy little cock, girl?  Was that lots of fun?</i>\" she laughs, scratching the little turkey girl under the chin, talking down to her like a pet.  Looking up to you, she adds, \"<i>Guess she found the best cock around, huh?  Been tracking this little cutey for a couple of days, now.  Real sweetheart; not too bright, though.  Couldn't tell the difference between a gnoll slut and a real cock.  Might just not be too picky, though.  Either way. So, I don--- hey!</i>\""
                    +"\n\nBefore Hel can finish her sentence, the turkey-girl reaches out and nabs the salamander's tail between her teeth, grabbing it like a worm off the ground.  Though she flails around in confusion for a moment, Hel soon lets out an involuntary shudder as the turkey-girl applies her oral talents to Hel's sensitive tail-end.  \"<i>W-well, if you insist...</i>\""
                    +"\n\n\"<i>Gobble,</i>\" the turkey says, muffled by the thick tail stuffed in her mouth."
                    +"\n\nAs Hel moves to straddle the turkey's shoulders, planting her own cunt in front of the avian girl's face, you decide to join in on the fun.  You sink your fingers into the cockgobbler's plump buttocks, kneading her plush ass as you had her tits before.  You give her a little push, letting her rest upon her massive gravytits as you spread her cheeks out, getting a good look at her last unviolated hole.  Grinning, you slip a finger into your mouth, slathering it with as much saliva as you can before pressing the tip against the tight ring of her ass."
                    +"\n\n\"<i>Mrh?</i>\" the girl mumbles, looking over her shoulder for a split second before Hel grabs her by the hair and puts her back to work. With your partner helpless to stop you, you push in, parting her sphincter with the very tip of your finger before sliding the well-lubricated digit in.  She lets out a muffled gasp, squealing around your lover's mouth-filling member as you push your finger in to the last knuckle, swirling it around in little circles inside her ass."
                    +"\n\nWhen you've given her all the lubrication you can, you slowly withdraw your finger and grab your [cock], pushing it up between her full buttcheeks.  The turkey-girl makes a pitiful squeak of a \"<i>Gobble!?</i>\" as you press the [cockHead] against her lightly-stretched anus, giving it an extra gob of spittle on the tip as you start to push into her. She's incredibly tight, her poor, defenseless sphincter clamping down hard around your intruding cock as you press the first inches into her, gently guiding yourself into her backdoor."
                    +"\n\nThe turkey squirms and writhes as you start to slowly buttfuck her, shuddering and mewling at the strange sensations.  Yet every time she tries to move, Hel locks the girl's head back between her legs, keeping the little slut occupied with sucking her tail. Free to continue, you grab the turkey's wide, egg-layer hips and start to fuck her properly, picking up the pace to a powerful rut, pounding her butt with only her jiggly ass to ablate the force of the buttfuck."
                    +"\n\nYou hammer the turkey-girl's ass, fucking her until she cries out around Hel's tail, screaming an ecstatic combination of lusty moans and her only word.  Now she's getting into it! You grab her auburn hair, yanking her head back as you land a thrust hard enough to send wobbles through her whole body, ripples running through her bubble butt and goblin-sized jugs.  Over her plumage, you hear Hel give out a sharp yelp, and for a moment fear you've made the poor turkey bite down on her -- until you see Hel's eyes rolled back in her head, one hand ravaging her tits and the other furiously masturbating."
                    +"\n\nWith a roar, you give the turkey a hard slap on the ass and, with her last violent contraction around your prick, cum.  Thrice already in the last hour, but you manage, pouring another hot load of semen into the turkey's abused anus.  She cries out as you slap her butt, but her scream turns into a long, lewd moan as she feels your seed filling her bum, your prick packing it in until trickles of spooge pour out around your shaft."
                    +"\n\nYou pull out of her with a wet squelch, grinning as a flood of your spunk starts to pour from her abused asshole, mixing in with the titgravy and two other loads you blew on her previously.  Supported by her huge tits, the turkey-girl goes limp, finally contented by the third fucking, her body stained and completely covered in your cum.  Looking around her, you see Hel lying on her back, snoring quietly after her own tail-based orgasm, her own body coated liberally with femcum and globs of your own spunk that rubbed off on her.");
            player.orgasm();
            player.dynStats("sen", -1);
            EngineCore.doNext(thatllDoTurkey);
        }

        function thatllDoTurkey():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Running your hand through the turkey-girl's hair, you whisper what a good little cockgobbler she is. However, you soon find that the poor thing's passed out, your rut finally over with.  You give her a gentle push over her back, giving you a nice soft tit-pillow to lay your head down upon as you pick up the lunch you'd been preparing to eat before the eager slut arrived."
                    +"\n\n\"<i>That'll do, turkey,</i>\" you say, patting her jiggling tit. \"<i>That'll do.</i>\"");
            if (player.findPerk(PerkLib.PilgrimsBounty) < 0) {
                player.createPerk(PerkLib.PilgrimsBounty, 0, 0, 0, 0);
                EngineCore.outputText("\n\n(<b>Perk Gained: Pilgrim's Bounty - Lower lust values no longer reduce the size of your orgasm.</b>)");
            }
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //Let her Approach:
        function femaleLetZeTurkeyGalApproach():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Considering her ponderous form, the girl obviously poses no threat.  You wave her over, trying to welcome her to the camp.  With a huge grin the turkey-girl wobbles over, her gigantic breasts heaving beneath her poncho until she plops down beside you.  You try saying hello and introducing yourself, but the girl simply cocks her head to the side."
                    +"\n\n\"<i>Gobble?</i>\""
                    +"\n\nYou raise an eyebrow.  Is that all she can say?"
                    +"\n\n\"<i>Gobble?</i>\" This time her question is punctuated by her hand drifting onto your leg.  You feel your body warming slightly as her slender, alabaster fingers slide along your thigh.  \"<i>Gobble.</i>\" She repeats, fingertips brushing against the crotch of your [armor] as she squeezes your thigh gently."
                    +"\n\nIt looks like you've found yourself a dinner guest...");
            //[Appetiser] [Main Course] [Dessert]
            EngineCore.simpleChoices("Appetizer", turkeyAppetizer, "Main Course", femaleAndTurkeyMainCourse, "Dessert", haveTurkeyGirlDesertInYourCunt, "", null, "", null);
        }

        //Appetiser:
        function turkeyAppetizer():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Biting back a moan as the girl continues to tease you, your own hands reach out to her wrists, reluctantly pulling her hands away and placing them on her own thighs.  She seems disappointed as you shift in your seat, but before she can voice her displeasure you slide up to her, snaking an arm around her back as you start to play with her oversized rack.  She gasps slightly as you heft her plush breasts, kneading and squeezing them as your fingers circle around her hardening nipples."
                    +"\n\nShe shivers at your attentions, starting to grind her thighs together as you press yourself into her side.  Your fingertips pinch at her nipples, staining the thin clothing covering them with dark, damp patches that slowly spread as you increase the pressure.  She coos as you start to nuzzle her neck, kissing and nipping at her ear as you press yourself harder against her.  She cranes her neck as your tongue traces her earlobe, going limp in your arms as a particularly large dollop of fluid starts to soak completely through her poncho, covering your fingers."
                    +"\n\nYou groan into the girl's ear as warm fluid drips over your hands, slowly nudging her until she flops backwards atop the log, her legs splaying to lie either side of the wood.  Still sitting upright, you look down at her as you bring a hand to your mouth, eager to taste her milk.  However, as your tongue swirls around your fingers, your eyes go wide; this isn't milk!  The taste is far too savory, although it is probably one of the best things you've tasted since you entered this realm.  Your brow furrows as you slurp another finger clean of the thick, delicious fluid.  If you didn't know better, you'd have to say that it was some kind of gravy! Then again, considering where you are, maybe that's not so implausible."
                    +"\n\nA choked moan rips your attention away from your new discovery and you look back at the source of both the sound and the delicious goo covering your hands.  The turkeygirl has sprawled herself out on the log, the bottom of her poncho flipped up to reveal her severe lack of undergarments.  One hand sits atop her exposed pussy, slowly rubbing in languid circles around her clit whilst her free hand plays with a still-leaking breast."
                    +"\n\nIt's the sight of her big, beautiful rear that snaps you back into action and you quickly position yourself over the girl, placing a knee between her legs as your hands slide up her juicy thighs.  She coos softly as your knee grinds against her cleft, one of your hands pulling hers away, relocating the reluctant limb to her heaving chest.  Your other hand strokes up and down her feathered thigh, rubbing teasingly close to her needy clit, drawing another low groan from the aroused avian."
                    +"\n\nHer breathing grows ragged as you press your leg harder into her crotch, feeling her engorging lips beginning to spread slightly at the increased pressure.  Beneath the poncho, her enormous tits jiggle and bounce as her hands furiously tease and squeeze them, plucking at her erect nipples whilst your own hand starts to snake its way under her clothing, trying to get better access to more of her delicious gravy.  As your hand traces its way across her taut stomach her hips start to hump slowly against your leg, rolling back and forth as she tries to brush her throbbing clit against your armoured limb, desperate to relieve her growing lust."
                    +"\n\nFeeling a little sorry for the horny girl, you slide your thumb briefly over her needy button, her back arching as she cries out at the sudden rush of pleasure.  Her breasts strain against the thin poncho as she quivers in excitement, her oversized bust seemingly threatening to burst right out of her modest clothing.  Smirking to yourself, you withdraw your knee from between her legs.  Her hands almost unconsciously start to make the move to her now-neglected netherlips, a low cry of displeasure rumbling out of her mouth, a harsh contrast to her previous, high pitched moan.  However, before her hands can even leave her chest you dart your own in, splaying your fingers across her moist slit.  She bites her lip as your hand slowly starts to circle her aching pussy, her fingers tweaking at her nipples as you spread her own femspunk around her entrance."
                    +"\n\nMaking sure to stay away from her erect clit, you continue to tease her entrance.  Her hips once again try to hump against you, but your other hand presses down on her stomach with enough force to hold her back.  Lifting her head to look at you, she whines in displeasure as you keep denying her, her breasts still leaking as she plays with herself.  Your eyes lock with hers and you see the need burning behind them.  Without looking away, you slide two fingers into her warm, wet hole."
                    +"\n\nShe cries out at the penetration and you feel her tunnel grip your fingers as they try to go deeper inside her.  She stiffens up, moaning and groaning as an orgasm wracks her body, her thighs quaking with pleasure and hands going and breasts bouncing as she gasps in air.  You rest your thumb on her clit as she cums, rapidly rolling over the nub and her hips thrust into your hand, desperate to feel your fingers touch as much of her as they can.  Her nipples jut out through the poncho as she contorts herself, her fingers clamping down on them harshly as the pleasure overwhelms her, causing what could only be called an eruption from each nub.  Gravy spurts out, splattering against her already sodden clothing as you feel the tasty liquid streaking down her body beneath the material.  The warmth spreads across your hand, though it is no match for the heat between your legs as you watch the girl writhing in pleasure."
                    +"\n\nUnable to stop yourself, you wrench your hand out from beneath her garment and before the girl can tell what's happening, you start to pull it up over her head, finally unleashing those fantastic breasts to the fresh air.  She nearly squawks as you drag her up from her relaxed position to free the material trapped beneath her, but calms down once you manage to get the thing over her head, throwing the soaked cloth out of the way.");

            player.orgasm();
            EngineCore.doNext(femaleAndTurkeyMainCourse);
        }


        //Main Course:
        function femaleAndTurkeyMainCourse():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Fully disrobed, the girl runs her hands down her chest, fingers clamping around her dribbling nipples once again.  With another squeeze, gravy is rolling down her chest once more, slathering her fingers with her own mouthwatering juices.  Unable to hold yourself back, your mouth clamps onto her breast, hands shooting to her soft, plush rear as you pull her bodily into your lap.  Her eyes almost light up in her new position, her hands running through your [hair] as you suck for all you're worth.  Her thick, rich gravy fills your mouth with its delicious mix of flavours.  There's so many different, wonderful tastes mixing together that you could almost believe you were back in Ingnam, gorging yourself on the gigantic spread that the village always strives to put on, regardless of how well the harvest went."
                    +"\n\nYour tongue plays with her nipple as you drink, flicking it to make the girl moan softly whilst your other hand plays with her unattended breast.  Despite her recent orgasm, she still tries to press her dripping pussy against your stomach as you drain her, her head thrown back in bliss as you nibble gently on the hard nub in your mouth.  Feeling your own [vagina] awash with pleasure too, you are, for a moment, torn between continuing to suckle the girl and pulling your lips away to beg her for some attention.  Luckily, as if she can read your mind, one of the turkeygirl's hands extracts itself from your hair and starts to makes its way down your body, cupping your [chest] as she goes.  You moan into her tit as her fingers slip under your waistband, brushing their way tantalizingly across your entrance as she brings her head to rest on your shoulder."
                    +"\n\nGravy dribbles down your chin as her fingers seek out your slit, teasing you in much the same way you had done to her, something you suddenly find yourself regretting.  Her lithe digits prod at your needy hole, nearly making you thrust against her hand in an attempt to get some contact.  However, the weight of her on you prevents you from making a move, forcing you to withstand her teasing touches as you continue to gorge yourself.  The steady stream of delicious goo starts to wane slightly, the turkeygirl's massive mammaries apparently struggling to keep up with your copious consumption.  Your fingers tweak her other nipple absentmindedly, forcing another burst of gravy out of her.  Deciding that it just isn't fair to leave her other tit so very unattended, you move your mouth to the hard, leaking nub, gulping and sucking hard as the liquid fills your mouth once more."
                    +"\n\nYour stomach begins to swell slightly as her gravy keeps filling you up, giving her body better purchase and making it much easier for her to rub her crotch against you.  The girl begins to moan again at the double sensation of her still-trembling lips rubbing against you and your slight less lewd lips locked firmly onto her sensitive nipple.  Her teasing becomes slightly more insistent as she grinds her slit into you, fingers sliding between your lips with an ever-increasing pace."
                    +"\n\nHowever, she continues to deny your aching clit, darting around your opening and occasionally dragging a fingertip across your swollen entrance.  Her crotch keeps thrusting into you, each stroke a little harder than the last.  Her arousal clearly has an effect on her breasts, streams of fluid drip from your soaked chin and splatter across her mound as you struggle to contain her delicious lactate, the girl groaning wantonly as warm juice drizzles over her sensitive clit.  Her moans get faster and higher with each thrust against you, her fingers becoming more adventurous, spreading and squeezing your labia, but never dipping into you."
                    +"\n\nOne of her fingers gently grazes your clit and you almost climax on the spot, your mouth nearly breaking its seal on her nipple.  Gravy spills out of the corners of your mouth as you cry out into her chest, shaking slightly as you struggle to contain yourself.  The girl grunts as you pull her hard against you, her pussy pressing into your stomach hard enough for her clitoris to brush over your armor.  Her grunt explodes into a moan as her body tightens up again, hips thrusting wildly against you as she orgasms a second time, coating your stomach with thick femspunk as her quivering quim drenches you."
                    +"\n\nThe hand still entwined in your hair pushes your face into her soft, smooth boob, the point of her nipple nearly touching the back of your throat as your maw is filled with titflesh.  Your tongue flicks across her nub, making her still-cumming body shudder with the overload of pleasure.  The fingers between your twitch and form a fist as her body is wracked with sensation, her knuckles sliding against your lips as she struggles to maintain control, keeping away from your needy button but leaving you panting all the same."
                    +"\n\nYour hands pull her tightly against you, stopping her mad thrusts as her vagina continues to spasm against your taut belly, the contractions so powerful that you can feel them even through your [armor].  She cranes her head back and moans indecently into the air as her legs grip you, almost making you feel like you're about to burst with the pressure."
                    +"\n\nFinally though, her climax begins to die down.  She holds you close for a few moments, gulping down air after her body-shaking finish.  You continue to drain her breast, though you feel your [vagina] starting to leave a damp patch on the inside of your armour, dripping down your thighs to soak into the log beneath you.  The hand on your head begins to move its way out of your hair, trailing down your neck almost lovingly as her breathing starts to return to normal.  Her touch is almost electric against your skin and you suddenly find yourself very aware of how much your body has been reacting whilst your brain was fixated on her mind-numbingly good goo."
                    +"\n\nFinally, unable to withstand it any longer, you break your lips away from her teat and push the girl to the ground, your hunger for her body finally having overcome your hunger for her gravy.  She looks up at you with a confused expression to begin with, but once she sees your hands darting to the clasps of your armor, a much more sultry look crosses her features.");
            player.dynStats("lus", 30);
            EngineCore.doNext(haveTurkeyGirlDesertInYourCunt);
        }

        //DESERT
        function haveTurkeyGirlDesertInYourCunt():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Barely able to contain yourself, you nearly tear your [armor] from your burning body, desperate to feel the girl with your bare flesh.  She reclines lazily on the ground, legs spreading wide as a hand moves from her dribbling tits, sliding its way down her toned stomach to her swollen lips.  She continues to tease herself whilst you struggle with your clothes, little moans and grunts of pleasure leaving you weak at the knees as she dreamily circles her reddening snatch with a finger.  Her other hand busies itself with her chest, pinching and squeezing just hard enough to release another spurt of gravy that rolls its way down the curve of her breast, dripping onto her belly in a thick glob."
                    +"\n\nYou finally free yourself of your damned armor, throwing it haphazardly to the ground as your skin finally feels the cool air flow over it, though it does nothing to sate the burning feeling that still threatens to consume you.  The girl's eyes noticeably widen as she takes in your nude body, her reaction making you blush even though it barely affects on your flushed cheeks.  Deciding to put on a little show for your avian acquaintance you drag your hands up from your hips, moving them across your stomach so that they can cup your [chest], tweaking your nipples between the fingers as they slide past.  You moan as you grip the hard nubs, throwing your head back in an exaggerated fashion as your hands keep on going, slipping up your neck to run sensuously through your [hair].  Finally, you turn you eyes back down to the fuckable fowl, shooting her a smouldering look, biting your lip for added effect as a low groan rumbles in your throat."
                    +"\n\nHer face is as red as yours, hands motionless as she takes in your display.  You can't help but smile at her response, the fact that she's so into your little show having a considerable effect on your own body.  Shifting your hips, you swagger over to her, letting your hands slip down to your nipples once more as you approach.  Your thighs are soaked with your own juices and each step you take brushes them against each other just hard enough to send a shiver of excitement up your back.  You reach the girl and crouch down in between her spread thighs, making sure to stretch your own legs as far apart as possible, eager to display your quivering slit to her as lewdly as you can manage."
                    +"\n\nShe's panting at you display, her pussy dripping with moisture as you advance on the girl, swinging your legs over her head and spreading her thighs as wide as you can as you come down above her.  She gets the message pretty quickly, her stiff little tongue shooting out to slip across your snatch, a grunt bursting from your mouth just before you can dig into the girl's own moist little hole."
                    +"\n\nYou recover, though her frantic assault keeps your body wracked with pleasure as you zero in on her pussy.  Your hands keep pushing her thighs apart as they move closer to her snatch, thumbs gently pulling the flushed lips apart to give you a perfect view of her passage.  She moans into you as a breeze blows against her entrance, humping at the air as she whines for you to dig in."
                    +"\n\nWell, with an offer like that, who could refuse?  Your head dips, tongue digging into her flesh as you give her one obscenely long lick, taking in as much of her taste as possible in one stroke.  Instead of the expected taste of sweat and cum, you find yourself licking your lips as the sweet taste of fresh pumpkin pie assails you.  A few hours ago, this would probably have given you pause, but after gorging yourself on her gravy you simply find yourself digging back into her slit, eager to sample as much of her as you can."
                    +"\n\nShe moans under your rapid strokes, though her own tongue hardly relents on you entrance, short jabs finally penetrating you as her fingers try to spread your lips as widely as they can, exposing as much of your [vagina] as possible.  You respond in kind, hands sliding under her thighs to come below her drooling slit, spreading wide whilst your pinky fingers tease her tight ring.  She groans in ecstasy as you dig in, her delightful flavor the perfect complement to the savory soup that even now leaks from her, coating your lower stomach as it rests on her bosom."
                    +"\n\nHer fingers snake their way around your hips until you can feel them resting just above your clit, poised to strike at any moment.  You realize that even one tap could probably finish you off now and begin to slurp at the turkeygirl's own nub, tongue lapping up as much of her sweet juice as it can manage.  You <b>need</b> to get as much of it as possible before she makes you cum, your mouth clamping down on her vagina, getting right to the source and trying to suck it straight out of her as you swirl your tongue around her button in hopes of making her leak even more."
                    +"\n\nHowever, the girl must be close and she decides to try and finish you off at the same time.  Her fingers suddenly grasp your clit, pinching it softly whilst her tongue dives deeper than ever before.  You cum almost instantly, you passage quivering around her orgasmic organ, humping against her face as you scream into her mound.  As the sound washes over her entrance, she too starts to cry out, both her holes spasming and you take the opportunity to slip a couple of fingers into her tight rear."
                    +"\n\nThe intrusion completely pushes her over the edge, leaving the pair of you screaming and humping unashamedly into one another, two tangled, sweat-slicked bodies writhing on the ground and groaning blissfully.  Her pussy covers your face with femspunk, which you waste no time in trying to lick up as you feel your own snatch [if (isSquirter = true) \"drench her face, a muffled 'meep' sounding out from between your legs as the girl weathers a vertiable flood from your twitching tunnel\"][if (isSquirter = false) tremble and coat her tongue with fluid, which she quickly drinks down before returning to your soaked hole]."
                    +"\n\nAs your orgasm starts to fade, you manage to roll your exhausted body off the turkeygirl, your chest heaving as you try to catch your breath.  You lie there for a few moments, your stretched stomach a testament to how delicious the girl was.  Out of the corner of your eye you notice her shifting and, to your surprise, she lifts herself up from the sodden ground beneath her.  Her body is dripping with remnants of your encounter, but she seems to be no worse the wear after no less than three orgasms!"
                    +"\n\nShe looks down at you, her big eyes sparkling as your own start to close, the exertion of such a vigorous round of sex too much for your stuffed body to take.  Kneeling down beside you, her mouth locks onto yours, kissing you deeply as you push back with your mouth, though even the effort of raising your head is almost too much for you.  One of her hands starts to gently stroke your bulging stomach, slowly circling the tight skin and kneading your sensitive flesh with soft, slow caresses.  Your eyes start to flutter and your head falls back to the ground, breaking the kiss.  Unperturbed, she coos softly at your dazed expression, her head nuzzling into the crook of your neck as her soft touch starts to calm your overworked body down."
                    +"\n\nHer mouth nips at your neck, tongue flicking your earlobe whilst she continues to moan quietly, your eyes glancing down her body to see her other hand buried firmly between her legs.  Your mouth curls into a smile as you relax completely, feeling safe and content under the caresses of the turkeygirl.  Somehow you can guess that she won't be here when you wake up, but your body is far too relaxed to do anything about it."
                    +"\n\n<b>One hour later...</b>"
                    +"\nYour eyes crack open, mind still foggy as sleep still clings to the corners of your eyes.  Memories of the insatiable turkeygirl flood back as you start to sit up, dreading the inevitable clean-up after so much spilled fluid.  However, you quickly realize that you're already redressed! In fact, it seems like someone not only dressed you, but both your body and your [armor] are completely spotless, not even a trace of the girl remaining on your person.  Looking around you notice that your campfire still burns brightly, as if someone stoked it recently.  Even your stomach has returned to its previous state, leaving no sign of the massive amount of gorgeous gravy you guzzled not an hour ago."
                    +"\n\nLurching to your feet, you stretch your arms, feeling completely refreshed after the short nap.  If it wasn't for the sweet taste of pumpkin still lingering on your lips, you'd be prepared to call what had just happened one of the weirdest dreams you've had since arriving in Mareth."
                    +"\n\nThen again, you have to admit that it would also class as one of the most fun...");
            if (player.findPerk(PerkLib.Cornucopia) < 0) {
                EngineCore.outputText("\n\n(<b>Gained Perk: Cornucopia - increases vaginal and anal capacities by 30.</b>)");
                player.createPerk(PerkLib.Cornucopia, 0, 0, 0, 0);
            }
            //HP set to full, fatigue to 0?
            EngineCore.fatigue(-100);
            EngineCore.HPChange(3000, false);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //Turkey Girl II: Return of the Cockgobbler (Cockwielders)
        //{Thanksgiving Day event, nat. Cockmeisters only.}
        function turkeyGirlTwoTheTurkeningBySavinWhatADickInAButt():void {
            EngineCore.clearOutput();
            EngineCore.outputText("As you're wandering through camp, your mind wanders back to the old harvest festival your village would hold about this time of year.  The days have come slowly since your arrival in this corrupted demon realm, but you can't help but think back to your family, to the friends you left behind.  Right about now they're probably sitting around the table, saying a prayer to the gods in thanks for the bountiful harvest.  Maybe they're saying one for you."
                    +"\n\nYou start to scrounge together a meal together for yourself.  Not much you can do here, with what little you have, but it feels...  right...  to be making something special for today."
                    +"\n\nA pang of homesickness sweeps through you as you look at the small meal before you.   With a sigh, you pick up your fork and prepare to dig in."
                    +"\n\nAs you reach for some of your spices, you notice...  something...  poking its head into one of your satchels, rustling around."
                    +"\n\nYou jump to your feet, readying your [weapon] for battle as you scan the perimeter.   A moment later, and you see a ponderous figure step out of the shadows behind a large rock.   At first glance, it looks like a normal girl dressed in a simple moccasin poncho, her bright red hair falling past her shoulders to rest on a pair of absolutely massive breasts.   Timidly, she steps forward, giving you a good look at her less human attributes: a pair of avian legs stick out beneath the hem of her clothes, and a large plume of feathers stick up from her big bubble-butt, each red feather nearly reaching the back of her head.   And her breasts...  each is easily the size of a goblin, so massive that it seems she can barely wobble along."
                    +"\n\n“<i>G-gobble?</i>”  she asks quietly, her big blue eyes pleading at you.");
            EngineCore.awardAchievement("Gobble Gobble", kACHIEVEMENTS.HOLIDAY_THANKSGIVING_II, true, true, false);
            //[Shoo Off] [Let her Come] [Hello again!]
            EngineCore.menu();
            if (player.hasCock()) {
                if (player.hasKeyItem("Deluxe Dildo") >= 0 || player.hasItem(consumables.L_DRAFT) || player.hasItem(consumables.F_DRAFT)) {
                    EngineCore.outputText("\n\n<b>You could let her come, like last year, or greet her in a whole new way (by clicking 'Hello Again')</b>");
                    EngineCore.addButton(2, "Hello Again", helloAgain);
                    flags[kFLAGS.MORE_TURKEY] = 0;
                }
                else {
                    EngineCore.outputText("\n\n<b>You might be able to have some new, kinky fun with Gobbles this year if you had something lusty on you...</b>");
                    flags[kFLAGS.MORE_TURKEY] = 1;
                }
            }
            EngineCore.addButton(0, "Shoo Off", shooTurkeyAway);
            EngineCore.addButton(1, "Let Her Come", letZeTurkeyApproach);
        }

        function helloAgain():void {
            EngineCore.clearOutput();
            EngineCore.outputText("\"<i>Oh, hey, you,</i>\" you say as the seasonal little near-harpy waddles up.  You pat your thigh invitingly, letting Gobbles approach."
                    +"\n\nSeeing that you're not angry with her, she bounds over with a flutter of her seemingly useless wings, plopping into your lap with a happy cry of \"<i>Gobble!</i>\" You rustle her feathers playfully as the turkey-girl nestles in, pressing her massive bust tight to your chest.  Damn, those tits of hers are gargantuan, like they haven't been milked since you gave her a good spit-roasting last year.  You can practically hear the gravy sloshing around in them, just waiting to spill out and drench her again.  You lick your lips at the thought, your hands wandering up to the clasps of your [armor] to pull it free."
                    +"\n\n\"<i>Gobble?</i>\" Gobbles asks cheerily, big blue eyes staring intently at your crotch."
                    +"\n\n\"<i>Gobble,</i>\" you answer, pushing her head down toward your [cock].  She giggles giddily as you free your prick, already hard enough to bop her on the nose as she buries her face in your groin.  The turkey takes a deep breath, wallowing in the potent musk of your [cocks], venturing to lick along the side of your shaft.  You let out a soft moan, stroking her auburn locks as the turkey happily suckles on your prick, taking the head ");
            if (player.cockArea(0) <= 60) EngineCore.outputText("and down to the base");
            else EngineCore.outputText("and swallowing your shaft until her throat is bulging with your massive manhood");
            EngineCore.outputText(".  She bobs up and down your length, hefting up her huge rack when she's at the peak to rub your sensitive underside, trying to titfuck you but just too damn big to get them into the action.  You suppose you'll have to take care of that...");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", gravyBoatDatTurkturk);
            //Gravy boat?
        }

        //Gravy Boat
        function gravyBoatDatTurkturk():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You cup the turkey's chin, pulling her up off your cock enough to get her looking up at you with her big, questioning eyes.  \"<i>Gobble?</i>\" she ventures nervously, straining against your hand to get back at your shaft."
                    +"\n\n\"<i>Soon, little bird,</i>\" you tease, reaching back to pat her huge harpy booty, fingers digging into the turkey's supple backside before hefting her up into your lap again and turning her around, letting her back rest against your [chest], tits held over your meager harvest meal."
                    +"\n\n\"<i>Gobble!?</i>\" she yelps, but a gentle caress of one of her heavy-laden tits is all it takes to get her to relax, practically putty in your hands.  You cup her breasts, giving them just enough of a squeeze to get them dripping, thick dark cream welling up at her pink points, drooling down onto your fingertips.  The smell...  oh, that's nice.  You lean around her slender shoulder, licking up a stray rivulet of gravy, savoring the sweet taste and the hearty smell that so reminds you of home.  The turkey flutters her wings happily, practically quivering in anticipation as you start to milk her, squeezing her big nipples, pulling and pinching them until the gravy starts to flow.  She squeals, back arching as her thick lactation spills down her ample chest, rivulets running through your eager fingers and down your arms, too, pooling beneath the pair of you in a steamy lake of rich gravy."
                    +"\n\nYou let her enjoy it for a long minute, working her sensitive teats until she's constantly fidgeting and gasping, crying, \"<i>Gobble gobble!</i>\" as her feathers flutter happily.  She's enjoying this so much you'd think she was a little cow-girl, almost! Of course, she's not entirely content to just get milked: cock-gobbler that she is, you soon feel a feathered arm slipping down your bare [chest], tickling and teasing as she's reaching around to your [hips] and waist before finally diving down to your [cock].  It's your turn to moan and groan as she wraps her fingers around your turgid member, stroking you from base to crown with gentle, affectionate motions that soon see a well of pre pooling at your slit, staining her reddish feathers dark with eager seed."
                    +"\n\n\"<i>Gobble?</i>\" she asks again, silenced when you squeeze her tits harder, aiming them for your meager meal.  She squeals happily as you bathe your lunch in gravy, squirting a thick arc of her sweet cream into your cook pan, still so hot that her lactic load quickly sets to steaming.  \"<i>Gobble!</i>\" she giggles, taking a deep breath of the meal as her gravy gets nice and toasty warm in the embers of your fire.  She shifts her hips ever so slightly, letting her grip of your cock go in order to straddle your [legs], squeezing her thigh thighs around your manhood, letting her silky-soft feathers caress your most sensitive flesh, tickling your [cockHead] as she starts to work her hips, grinding against your cock as you keep her tits constantly flowing.  You can visibly see her huge breasts shrinking as you milk her, cream flowing out of your over-flowing pan and into the fire or the hungry ground to be swallowed up."
                    +"\n\nThe smell is almost overwhelming, so potent and familiar that you can't help but feel homesick and hungry.  But her cock-rubbing legs keep you from getting too down; she's going at it with wild abandon, happily humping against your cock's length.  Her cunt is drooling fem-slime almost as much as her tits now, slathering your [cock] in her warm slickness, her nether lips reaching out to gently caress your prick, almost inviting you to penetrate her.  You hold her still just a moment, long enough to shift your [hips] and slide right on in.  Gobbles' back arches, voice turning into a giddy cry of pleasure as your [cock] enters her, spearing her on your length as you hold her dripping tits over the hearth, cooking her gravy as you spitroast Gobbles once again."
                    +"\n\n\"<i>Gobble!</i>\" she declares triumphantly as your prick slides home, pushing into her until her hips are nestled back into your lap");
            if (player.cocks[0].cockThickness >= 5) EngineCore.outputText(", her stomach bulging obscenely with your inhuman girth");
            EngineCore.outputText("."
                    +"\n\n\"<i>Gobble indeed,</i>\" you laugh, planting your arms back on the dry ground, letting the turkey adjust herself.  Her tits are practically empty by now; not quite, but enough that her once immense rack is down to something you can quantify - maybe G-cups.  A pair of perfectly round, bouncy G-cups that are still dripping with spattered gravy, her big red nips erect and still leaking even without your hands to spur them on.  The turkey shifts around on your pole to face you, leaning back in your lap against your [legs], content for the moment to grind her cunt on the [cock] buried deep inside her."
                    +"\n\nSlowly, she starts to move, rising up along the girthy length of your [cock] until just the tip is buried inside her before sliding back down, giving a little squawk of \"<i>Gobble!</i>\" when you bottom out in her.  You lie back, letting the turkey bounce on your prick, and close your eyes, reveling in the warm coating of gravy smeared across your body, the contentment of having your cock nice and buried in the slutty turkey."
                    +"\n\n\"<i>Gobble?</i>\" the turkey asks mid-bounce, staring down at you expectantly."
                    +"\n\nYou open an eye, looking incredulously at the little bird.  When you don't respond, she gives a harrumph of a squawk and dismounts you, turning around to plant her big, round booty in your face and stuffing her face back in your crotch.  You groan as her still delightfully big tits wrap around your [cock], finally sized down enough to where she can work with them; you grit your teeth and try to hold back as she strokes you off between her wet, soft tits, faster and faster with her own gravy as lubrication.  She gleefully takes the head into her mouth as she goes, swirling her slender tongue around your crown before lapping up the trickling pre leaking from your slip.  The sensation of her dexterous muscle caressing your cock, combined with the ceaseless stroking of her tits enveloping your dick, is just too much: you can't hold it in any longer."
                    +"\n\nYou grab the turkey's head and slam her down on your [cock], pushing it all past her lips as you shoot your load down her throat.  She squeals and flutters atop you, but your strength and the weight of her tits still mounted atop your cock keep her nice and immobile as you throat-fuck her, [hips] pounding your prick deep down her gullet to send your cum right into her belly."
                    +"\n\n\"<i>Gobble!</i>\" Gobbles cries, and you're not sure if she's happy or upset anymore: the sheer amount and cum and cock in her mouth muffles her word into a mere pleasured cry.  It takes her a solid minute to finally regain her senses enough to pull your shaft out of her mouth, cum drooling out of her lips as she lets your prick droop down.  \"<i>Gobble!</i>\" she repeats, this time wiggling her hips in your face, pushing her drooling, cock-stretched cunt right onto your nose to give you a nice, big whiff of her entrancing pussy-smell.  You're almost hard again by the time you manage to dislodge her, but she holds fast just off of your face, the lips of her muff practically kissing your own."
                    +"\n\n\"<i>Gobble!</i>\""
                    +"\n\nLooks like she wants you to return the favor!");
            player.orgasm();
            player.dynStats("lib", 1);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", seasonHerDatTurkeyBitch);
        }

        //Season Her
        function seasonHerDatTurkeyBitch():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You plant your hands on the busty bird's broad, breeder's hips, spreading her cheeks to get a good look at her slit.  Still agape after taking your cock earlier, she's liberally leaking fem-slime onto your face, eagerly awaiting your lusty touch.  You venture your tongue out to taste her, and instantly draw back even as she flutters excitedly - does she...  of course she tastes like turkey.  What else? But it's a damn fine turkey, oh so sweet and juicy; you don't hesitate to dig in, tongue probing deep into the giddy fowel's slit.  She wiggles her tremendous tush happily as you spread her nethers wide, her vibrant brown plumage standing straight up, as erect as your own [cock] as Gobbles' tits bounce and jiggle around it.  Tonguing your tasty turkey, you slip a few fingers up between her luscious thighs, brushing the tender flesh just enough to make her arch her back, dragging her tits right along the length of your shaft to bury the crown in the jiggly bottom of her rack.  You trace your fingers higher, brushing the silky lips of her sodden box and circling up to the prominent little bud of her clit."
                    +"\n\n\"<i>GOBBLE!</i>\" she cries as your digits brush her sensitive point, arching her back and squirting gravy onto your crotch, lactating from pleasure alone.  You shudder as the warm, creamy gravy slathers onto your [cocks] pinned between her tits, her pleasured motions getting her boobs bouncing like a regular titfucking.  At your touch, her quivering quim lets loose a torrent of excited fem-slime, smearing your face in turkey-tasting juices faster than your hard-working tongue can lap it up.  She's a fine tasting turkey if ever you saw one, her sweet juices practically compelling you to eat her out, pushing your tongue as deep into her juicy slit as you can to harvest her delicious bounty."
                    +"\n\nBut what's a turkey without a little seasoning, hmm? Sweet as she is, and as eager to gobble your cock as can be, things could still turn up a notch.  Still servicing her box, you reach an arm out to your discarded pack, searching through it until you feel the familiar shape of ");
            if (player.hasKeyItem("Deluxe Dildo") >= 0) EngineCore.outputText("Tamani's dildo");
            else if (player.hasItem(consumables.L_DRAFT)) EngineCore.outputText("a bottle of Lust draft");
            else if (player.hasItem(consumables.F_DRAFT)) EngineCore.outputText("a bottle of Fuck draft");
            else EngineCore.outputText("A FUCKIN ERROR");
            EngineCore.outputText(".  You pull it out and squeeze a copious load of the bubblegum pink aphrodisiac out into your hand.  The second it touches your skin, you feel a palpable warmth spreading out through your nerves, skin burning with sensitivity as the roiling, viscous substance pools in your cupped hand.  You can't help but shudder as the pink veno's effect reaches out through your body, setting your whole person to tingling - and especially your [cocks], which rises to an almost painful hardness."
                    +"\n\n\"<i>Gobble!</i>\" Gobbles giddily cries, sucking up the head of your turgid [cock] when its crown peeks out from between her teats, clearly pleased with your oral attentions.  She's got no idea what's coming! You slip one hand out of her cunny, and push another in, fingers sliding easily into her sodden hole.  \"<i>G-gobble!?</i>\" she whines as your lust-coated digits probe her, swirling around her quivering walls, making sure to spread the pink venom it out nice and even, coating every inch of her channel."
                    +"\n\nInstantly, you can see her pale flesh reddening, burning with desire.  Her fem-slime practically pours out of her over-excited pussy as her breath quickens, chest heaving her tits up and around your [cocks].  Perfect! You pull your hand back out of her love-tunnel, slapping both her butt cheeks to wipe off the last of the lusty cream on her bare derriere, which flushes as red as her hair.  \"<i>Gobble!</i>\" she screams as you swat her ass, slamming her big hips down on your face, trying to get you to eat her needy box again even as she's panting and twitching, playing with her tits and your cock with shameless abandon."
                    +"\n\n\"<i>Gobbles, gobble,</i>\" you command, poking a finger into her drooling slit."
                    +"\n\n\"<i>Gobble!</i>\" she answers, rolling off of you and hiking her legs up, knees sinking into her bust to show off her slit for you, so eager and inviting.  You rise to your [feet], grabbing the lusty fowl behind her hooked knees and pulling her in to line up with your [cocks].  \"<i>G-gobble!</i>\" she begs, fluttering her plumage against your [legs], staring up at you imploringly as her skin further reddens, so hot with desperate lust you can practically feel the sexual hunger radiating off of her.  Time to finish this turkey off in style!");
            player.dynStats("lus=", player.maxLust(), "scale", false);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", turkeyDesertBitches);
        }

        //Dessert
        function turkeyDesertBitches():void {
            EngineCore.clearOutput();
            EngineCore.outputText("\"<i>G-gobble!?</i>\" Gobbles whines at your moment of hesitation, wiggling her upraised botty at you enticingly, hot flesh jiggling just close enough to brush your [cocks] with her lust-coated cheeks."
                    +"\n\n\"<i>Fuck!</i>\" you groan as the venom drips off your [cock], a small droplet vanishing into your dilated urethra.  Your heart skips a beat as the lusty cream works its magic, pounding through your sex.  Well, that backfired! You clutch at your [chest]");
            if (player.biggestTitSize() > 1) EngineCore.outputText(", cupping a tit");
            EngineCore.outputText(" as the venom takes control, flushing your skin and forcing out all thoughts but one: fuck that turkey! There's nothing for it, now: you grab Gobbles' hips and plunge in");
            if (player.cockTotal() == 2) EngineCore.outputText(" with both cocks, one ramming into her abused cunny and the other right up her vulnerable little bumhole");
            else if (player.cockTotal() > 2) EngineCore.outputText(" with every cock you've got, half in the pink and half in the stink, spreading her as wide as you are in both barrels");
            EngineCore.outputText(", shocking her so much that she can't hold back, screaming and cumming on the spot! You groan, thrusting forward as her spasming muscles contract around your cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(", milking you as hard as she can while her orgasm overtakes her.  Gravy geysers out of her swollen tits as fem-cum splashes out around your deep-buried cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(", drenching your [hips] and [legs] in creamy girl-spunk, tinged pink by the poison you fist-fucked up her cunt."
                    +"\n\nThe squawking turkey seems to be depthless, easily swallowing up every inch of your [cocks] until ");
            if (player.cockArea(0) >= 50) {
                EngineCore.outputText("her stomach is bulging obscenely with the sheer volume of cockflesh rammed up her cunt");
                if (player.cockTotal() > 1) EngineCore.outputText("and ass");
            }
            else EngineCore.outputText("your hips are slapping into hers, making her butt bounce with the impact");
            EngineCore.outputText(".  She cries her one word to the heavens as you pound into her hole");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(", thrusting your cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" deep inside.  Her avian legs break free of her hold, wrapping around your [hips] and pulling you in, locking you in her spasming hole");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" as she cums and cums, pleading, \"<i>Gobble!</i>\" at the top of her lungs.  You switch your grip to her bountiful bosom, roughly squeezing her tits as you hump your cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" in and out of her slick slit{and quivering behind}, pinching her nipples to give the squealing turkey just a little more pleasure."
                    +"\n\nGobbles' feathered arms reach up, hooking around your neck and bringing you down, pulling you into a startlingly passionate kiss.  You lose yourself in her warm embrace, hips pistoning on automatic as you caress and kiss the lusty bird, tongue playing across her full red lips as you cup a breast just hard enough to make it lactate, so that your fingers are coated in thick gravy.  You bring them up to her cheek, smearing a bit over her lower lip before she eagerly swallows it up, suckling her own lactic lust from your digit like a little teat; you join in, half-kissing her and half licking up the gravy from your fingers, tongue tying with hers more than once, playing across each other.  Your sexy moans turn to gasps and cries as you continue to pound her puss");
            if (player.cockTotal() > 1) EngineCore.outputText(" and ass");
            EngineCore.outputText(", her legs spurring you on every time you withdraw, muscles clenching when you pause, never letting you rest.  Needy slut! But she's more than willing to do her part, thrusting her hips up to meet you, squeezing and milking your cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" every time you pierce her, working your shaft");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" so expertly that you know you won't be able to hold on for long - and neither will she, the way she's panting and gasping along with you!"
                    +"\n\nYou draw nearer to the breaking point, hips unrelentingly slamming your shaft");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" deep into Gobbles' eager depths, urged on by her happy squawks and gleeful cries.  Lust-venom-addled as the two of you are, orgasm approaches like a wave of relief, crashing through your bodies in beautiful unison.  \"<i>Gobbles!</i>\" she cries as her cunt ");
            if (player.cockTotal() > 1) EngineCore.outputText("and ass ");
            EngineCore.outputText("squirm around your cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(", wringing the cum from you with powerful spastic contraction.  Her arms pull you down into the valley of her gravy-laden bosom, squeezing your face between her massive mounds as she cums, drawing the spunk right out of you.  With a potent, feral roar, you cum, [cocks] blasting its salty load deep into Gobbles' womb");
            if (player.cockTotal() > 1) EngineCore.outputText(" and bowels");
            EngineCore.outputText("; her back arches, teats wobbling around your head as she takes your cum, squawking and gobbling gaily as more and more of your virile spunk pours into her, mixing with her own fem-cum and the remnants of the lusty draft your fucked into her."
                    +"\n\n\"<i>Gobble!</i>\" she sighs happily as your cock");
            if (player.cockTotal() > 1) EngineCore.outputText("s deposit the last of their");
            else EngineCore.outputText(" deposits the last of its");
            EngineCore.outputText(" cream into her, fully stuffing your turkey-girl.  Panting, you let your head rest between her tits a moment long, shaft");
            if (player.cockTotal() > 1) EngineCore.outputText("s");
            EngineCore.outputText(" wilting inside her until like a broken dam, her cunt");
            if (player.cockTotal() > 1) EngineCore.outputText(" and ass");
            EngineCore.outputText(" begin");
            if (player.cockTotal() == 1) EngineCore.outputText("s");
            EngineCore.outputText(" to drool spunk, pooling onto the hungry ground with the gallons of spilt gravy and fem-spooge."
                    +"\n\n\"<i>Gobble,</i>\" you agree, wrapping the giddy turkey up in your arms and planting one last kiss on her big ol' boob.  She stares sedately at you with big, blue eyes, a cute little smile on her lips as you withdraw from her, wiping the last of your spunk on her feathery thigh.  Running your hand through the turkey-girl’s hair, you whisper what a good little cockgobbler she is.  However, you soon find that the poor thing’s passed out, your rut finally over with.  Still, she's left you with a nice soft tit-pillow to lay your head down upon as you pick up the lunch you’d been preparing to eat before the eager slut arrived."
                    +"\n\n“<i>That’ll do, turkey,</i>” you say, patting her jiggling tit and scraping some of the excess gravy out of your lunch.  “<i>That’ll do.</i>”");
            player.orgasm();
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }
    }

    public static function pigSlutRoastingGreet():void {
        //Ham Roast: Getting All Up In A Honey Pot (Female and Genderless only)
        //{Yeah what Savin said up there}
        //Desc: Hamroast will be the thanksgiving special at The Wet Bitch. PC will be prompted when they enter to try one. PC can repeat this scene as many times as they want during the Thanksgiving window.
        EngineCore.clearOutput();
        EngineCore.outputText("As you enter The Wet Bitch you’re accosted by an incredibly busty waitress. You can’t really discern what exactly she is as your eyes are solely focused on the massive melons jutting out from her chest and jiggling proudly with mile deep cleavage to boot."
                +"\n\n\"<i>Hey there " + player.mf("handsome", "cutie") + "! We've got quite a unique special going on right now!</i>\" she exclaims in a cheery voice."
                +"\n\nThen she motions to a sparkly gem-filled bucket, with several strands of what looks like cum running in creamy rivulets down the side."
                +"\n\nShe moves in closer to talk right into your ear with a seductive voice, \"<i>Just throw a gem in that bucket over there and <i>she's</i> all yours for the night!</i>\""
                +"\n\nYou grin. You could really go for a wild night right about now and a cheap whore sounds like just the right thing to ease your... stress.");
        EngineCore.awardAchievement("Thankslutting", kACHIEVEMENTS.HOLIDAY_THANKSGIVING_I, true, true);
        //{Lust = lust + 10}
        player.dynStats("lus", 5);
        EngineCore.menu();
        if (player.gems >= 1) EngineCore.addButton(0, "Throw gem", getARoastPiggueOinkOinkOinkMotherfucker);
        EngineCore.addButton(1, "Nah", SceneLib.telAdre.barTelAdre);
        EngineCore.addButton(2, "Never", disablePigSlut);

        //[ In For A Gem... ] [ Not My Style ]

        function disablePigSlut():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Pig sluts are not really your thing. You tell her that you have no interest in her. She seems to be a bit heartbroken.");
            flags[kFLAGS.PIG_SLUT_DISABLED] = 1;
            EngineCore.doNext(SceneLib.telAdre.barTelAdre);
        }

        //{Return to The Wet Bitch menu}
        //Ham Roast -> In For A Gem
        function getARoastPiggueOinkOinkOinkMotherfucker():void {
            EngineCore.clearOutput();
            player.gems -= 1;
            EngineCore.outputText("You quickly approach the gooey bucket and toss a single, shiny gem inside. Another waitress winks at you, almost equally as busty, nodding her head in the direction of the back rooms."
                    +"\n\nYou wander around for a bit in the hallway, doors on either side of you filled with mysterious grunts and groaning. Apparently, people are really getting filled with the holiday spirit, you muse, and getting FILLED with it as well!"
                    +"\n\nEventually you come upon a door at the end of the hallway, noticing a sticky sheet of parchment nailed to it."
                    +"\n\nIt reads: \"<i>Get your sausage sticky! Or dip some pork tongue into your honey pot!</i>\" in playful calligraphy handwriting, an arrow closer to the bottom of the sheet pointing to the door knob. You notice in amusement how the knob seems a bit sticky too. Just about everything involving this... spit-roasted speciality is sticky."
                    +"\n\nYou open the door, the smell of sex wafting out in dizzying amounts: hungry pussy, eager asshole, meaty shafts, and hairy balls all mixing together to create a truly arousing aroma. The room is foggy with lusty fumes, working themselves into your [armor] and finding a home in your [hair]."
                    +"\n\n");
            if (player.hasVagina()) EngineCore.outputText("\n\nYour [vagina] drools pussy juice down your [legs] as y");
            else EngineCore.outputText("Y");
            EngineCore.outputText("our nostrils flare, taking in great amounts of the salacious stench."
                    +"\n\nThen you see her, a jiggly piggy slut furiously frigging her juicy honey pot as syrupy, golden brown juices fly out, not stopping for even a second. Her pink, soft form jiggling and wobbling with just the right amount of fat. There's a paunch in her stomach that wiggles around, possibly a cream-filled belly from all the fun she's been having today. She's lying on her massive posterior, easily one of the biggest you've ever seen, hips flared out like a tried-and-true brood mother. An enormous pair of jugs adorns her plump body, bouncing and leaking what looks like honey as she enters the peak of her excitement."
                    +"\n\nOinking cutely, her curled tail waves around and quivers vigorously, like a happy dog getting a treat. You look up to her slightly pig-like snout, an adorable nose poking out from her muzzle, her eyes closed while her mouth is gaping open. Strands of thick masculinity are plastered all over her body, her ass-length curly brown hair tangled and stained with male-milk."
                    +"\n\nFemspunk dribbles down from her open maw, making her neck rather sticky as the same fluid runs from her own squishing sex. Fingers moving like a blur, she finally creams herself, gushing another wave of honey out of her hot, roasted sex. She breathes deeply, like she had just finished a vigorous exercise. She pulls her fingers out, frosted with syrupy goodness from her still drizzling, juicy cunt."
                    +"\n\nThe piggy slut brings them to her mouth, tasting her own pussy juice as she licks each one absentmindedly."
                    +"\n\nShe finally opens her eyes and lets out a surprised, \"<i>Oink!</i>\" when she sees you observing her with an amused glint in her eyes."
                    +"\n\nThen the plump whore's eyes suddenly turn more seductive, giving you a come-hither look as she oinks rather sexily, something that you didn't think would be possible until now.");

            //[ Next ]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", morePigRoast);
        }

        function morePigRoast():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You climb on top of the bed with her, letting your [armor] slip off in the process. She oinks playfully, letting you know that she approves of the action. You smile at her, your hand reaching down to explore her dribbling nethers, slipping a finger into her love-tunnel with ease. You let a dumb grin spread across your features as you feel her searing folds, so hot and slippery with sticky, liquid lust."
                    +"\n\n\"<i>Oink?</i>\" she asks eagerly, ready for more.");
            EngineCore.addButton(0, "Next", tenderizeDatPigSloot);
        }

        //[ Tenderize Her ]
        //Ham Roast -> Tenderize Her (Female and Genderless versions)
        function tenderizeDatPigSloot():void {
            EngineCore.clearOutput();
            EngineCore.outputText("\"<i>Turn over.</i>\" you say rather plainly, eager to see that jiggling booty of hers."
                    +"\n\nShe does as you command, rolling over onto her stomach and letting you see the massive mounds of fleshy orbs she calls her ass. You maneuver your way onto her legs, pinning them down with yours as you lick your lips in anticipation. You bring your hand down in a tentative spank, your hand smacking against one of the enormous butt cheeks, sending it jiggling and wobbling as it ripples away from the point of impact."
                    +"\n\n\"<i>Oink!?</i>\" the pork roast exclaims in surprise, her muscles stiffening. You answer her with a slap on the other cheek, harder and more confidently as this one repeats the action of her sister."
                    +"\n\nThe afflicted areas on her generous rump turn rosy red, which is hard to notice on her otherwise pink skin. You grin; apparently nobody had the decency to give this sausage slut a good rump-roasting. You bring both of your open palms down at the same time, both giant tushy cheeks undulating sexily as you leave fingerprint marks on her juicy booty. You experimentally put pressure on one of her fat orbs of flushing-red posterior, smiling in delight as your fingers practically sink into the round flesh."
                    +"\n\n\"<i>Oink...</i>\" she moans, lustily as you manhandle her backside. The dirty little slut! She likes it! Well, you're not one to deprive a sexy strumpet of her pleasure."
                    +"\n\nYou begin to rapid-fire spank her ass, alternating your strikes between her two cheeks. ");
            if (player.tailType > Tail.NONE) EngineCore.outputText("You even bring your tail from behind your back to join in, the unfamiliar texture causing the sausage slut to let out surprised, high-pitched squeaks. ");
            EngineCore.outputText("You notice the pigslut moving backwards, her ass being pushed into the air as she attempts to feel the full power of your spanking, her pussy spraying juices onto the soaked sheets."
                    +"\n\nYour hands are a blur as they play some unknown rhythm on her bouncing booty, as if they were acting on their own. The piggy slut has her hands clenching down on a nearby pillow, teeth gritted as you have your way with her colossal ass. Tears streak down onto the pillow, staining the fabric wet. The sight of her weeping sex is all you need to know to continue; the desperately oinking whore turns out to be a bit of a masochist..."
                    +"\n\nYou look around the room for a more fitting tool to use on this pain-loving slut, even as you turn the whore's jiggling butt cheeks into a pair of booty bongos.");
            player.dynStats("lus", 25, "scale", false);
            //[ Hardcore ] [ Softcore ]
            EngineCore.menu();
            EngineCore.addButton(0, "Softcore", hamRoastTenderizeHerSoftcore);
            EngineCore.addButton(1, "Hardcore", tenderizeHerHardcore);
        }

        //Ham Roast -> Tenderize Her -> Hardcore
        function tenderizeHerHardcore():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You can't help but maliciously smirk, your eyes resting on a fetish whip and some bondage equipment. You give the piggy one last double-handed spank on her ample ass, leaving her a pitifully moaning and quivering wreck. You quickly snatch up the whip, some rope, and a kinky ballgag."
                    +"\n\nYou return to the trembling whore, petting her curly brown hair reassuringly as the tears from her eyes slow down, the heat and pain from her raw rump still fresh. You gingerly place the ballgag onto her snout, making her appear as though she was a ham roast with an apple in her mouth. She looks into your eyes with a mixture of pain, arousal, mercy, and pleading. You softly kiss her on the forehead, stroking her hair, admiring its luscious fullness."
                    +"\n\nYou grab one of her weakened arms, stretching it out to the respective corner of the bed and restraining it with the rope. You do the same for each of her other limbs, her legs being a bit hard to maneuver due to her massive hips and thighs. Eventually you manage to get her all done up, smiling at your handiwork as you brandish the whip."
                    +"\n\n\"<i>Oink...</i>\" she moans weakly, her hips bucking uncontrollably in her secure bondage."
                    +"\n\nYou crack your whip on a nearby surface, creating an ominously loud striking sound. The piggy slut squeals in surprise, struggling in her bonds more when she hears the telltale cracking of the whip. You cocksuredly strut over to the squeaking whore, expertly striking down the whip on her wobbling boty. A bright red, painful looking mark shows itself on her ass where the whip made contact, the slut tensing as all of her muscles lock up."
                    +"\n\nSuddenly she lets out a high pitched whine, tears pouring from her eyes. Her drooling honey pot tells a different story though, a veritable river of feminine juices erupting from her sex. You crack the whip down on her again, the masochistic pork roast squealing for mercy as you relentlessly go to town on her booty."
                    +"\n\n\"<i>Oink! OINK! <b>OINK!</b></i>\" her pathetic squealing only excites you more, the sounds of loud strikes from your whip filling the room."
                    +"\n\nYou lose yourself in the excitement, your own [vagOrAss] twitching with delight each time your whip comes down on her bubbly buttocks.");
            player.dynStats("lus", 25, "scale", false);
            //[ Next ]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", spankEpilogueColonYoureAHorriblePersonForAbusingADumbPigGirl);
            //{Route to: here}
        }

        //Ham Roast -> Tenderize Her -> Softcore
        function hamRoastTenderizeHerSoftcore():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You can't help but let a salacious smile grace your lips, your eyes resting on a paddle in the corner. You give the piggy one last double-handed spank on her ample ass, leaving her a pitifully moaning and quivering wreck. You quickly snatch the somewhat heavy paddle, feeling its heft and grinning like a madman."
                    +"\n\nYou return to the trembling whore, petting her curly brown hair reassuringly as the tears from her eyes slow down, the heat and pain from her raw rump still fresh. She looks into your eyes with a mixture of pain, arousal, mercy, and pleading. You softly kiss her on the forehead, stroking her hair, admiring its luscious fullness."
                    +"\n\nYou move back down to your original position, pinning her down by her legs as you brandish the paddle. You quickly smack it down onto her flushing cheeks, sending them jiggling vigorously from the use of the new equipment."
                    +"\n\n\"<i>Oink!</i>\" she whines in surprise, her tempting rear receiving the full brunt of all the paddle has to offer as you quickly repeat the action with the other globe-like orb. She buries her snout in the pillow and bites down hard, whimpering and wailing as you go to town on her vulnerable booty, providing a gigantic target for your spanks."
                    +"\n\nYou can see her pussy practically gushing femspunk like a waterfall at each strike from her paddle. The ruined bed becoming even more sticky from the syrupy-like production of her honeypot."
                    +"\n\nShe oinks and squeals for mercy but you're not having any of it, simply ignoring her pleading and endlessly, rapidly paddling her heated bottom. All the direction you need is coming from her juicebox, which is commanding all of your attention as her slickened gash constantly leaks her cream."
                    +"\n\nThe pain-slut bucks her hips at each hard spank, moving her rear end back to meet your whacks on her wobbling, huge butt."
                    +"\n\n\"<i>Oink! OINK! <b>OINK!</b></i>\" her pathetic squealing only excites you more, the sounds of loud strikes from your paddle filling the room."
                    +"\n\nYou lose yourself in the excitement, your own [vagOrAss] twitching with delight each time your paddle comes down on her bubbly buttocks.");

            player.dynStats("lus", 25, "scale", false);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", spankEpilogueColonYoureAHorriblePersonForAbusingADumbPigGirl);
            //[ Next ]
        }

        function spankEpilogueColonYoureAHorriblePersonForAbusingADumbPigGirl():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Eventually you stop your ceaseless romping of her rear, the piggy whore blubbering into the now thoroughly torn pillow from her biting and tearing. Several strips of flesh from her reddened ass look practically raw from your activities. You lay an experimental finger on the tortured flesh, the blazing heat radiating from it telling you all you need to know."
                    +"\n\nYou grab a handy bottle of <i>Booty Balm</i> and squirt a generous amount on your palm and on each of her butt cheeks, working it in gently and easing a least some of the pain from her juicy rump."
                    +"\n\nAfter you're sure you've worked as much of the soothing cream into her ass as it will take, you gently pat it with an almost loving caress."
                    +"\n\n\"<i>Oink...</i>\" the slut sighs appreciatively, her tears finally coming to a stop as you get ready for the second part of your night together.");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", spankEpilogueForRizzles);
            //[ Next ]
        }

        function spankEpilogueForRizzles():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You look around the room once again, searching for more toys you could use on the masochistic piggy slut. Your eyes rest on a jumbo-sized, horsecock dildo sticking up like a sore thumb out of the rest of the stuff. Someone even had the audacity to put a hat on it! You grab the monstrous thing, mottled black and pink all over with an artificial sheath near the base. You reason it's over two feet long and incredibly thick, its huge weight making it so that you have to carry it with both hands!"
                    +"\n\nYou roughly flip the pigslut back over onto her back, eyeing her honey roasted pussy as it constantly dribbles more of the thick sex juice."
                    +"\n\nFirst things first, you gotta get this dildo in the other hole if you want to get all up in her syrup dispenser. You look around for lube, the only thing you spot being the <i>Booty Balm</i> from before. You shrug your shoulders; it will have to do. You apply a thick coating to the massive head of the flopping, artificial rod."
                    +"\n\nYou dominantly spread her legs apart and motion for her to hook her legs back, which she does without argument."
                    +"\n\n\"<i>Oink!</i>\" she happily exclaims, seeing the monster horsecock toy in your hands. Obviously she wants it, and by the looks of the magnitude of her whorishness, she's probably had plenty of experience in the anal department."
                    +"\n\nYou bring it down to poke into her pucker, teasing the pink entrance to her other hole with the flared head of the stallion-shaft. Her asshole gapes open a slight bit, making it clear to you that it's been fairly well used today. You ram it forward with all your strength, parting her meaty tushy with the ample girth of the huge beast."
                    +"\n\nIt easily sinks in a couple of inches into her ass. A lusty, sex-dripping \"<i>Oink...</i>\" escapes her mouth as you shove the dildo in deeper, effortlessly reaching the one foot mark. You chuckle to yourself; she's probably had a couple minotaurs in her booty today... especially judging by the squishing sounds you hear from her spunk-filled insides."
                    +"\n\nA visible bulge appears in her plump stomach, her stretched asshole touching the outside of the sheath. It takes a little more strain to get the sheath inside, but her butthole gulps it up greedily all the way until you get to the base of the monstrous horse-pole."
                    +"\n\nThe piggy slut's love-tunnel gushes another helping of femcum onto the sheets as she pats her belly where the flare is poking bulging out of it, satisfiedly oinking in pleasure as her asshole is filled."
                    +"\n\nWell, now that that's taking care of, you can move on to that delicious looking pig-pussy. While the whore is distracted with the new toy her butthole can play with, you dive into her depths, lapping experimentally at the golden flower with your tongue. A rich, candied, sugary glaze wipes itself on the length of your tongue, the explosion of flavor causing you to eagerly dive into the honey pot."
                    +"\n\nYour licking tongue easily parts the piggy slut's folds and dives deeper inside, tasting the syrupy sweetness from the source as the whore moans in pleasure, squealing like a pig in a mud pile."
                    +"\n\nThe taste reminds you so much of home; the candied sweet potatoes you use to have every year around this time. You need more, inserting your oral muscle as far is it can go into her soaking depths and thrashing it around inside, swirling it to lick up as much of the gooey syrup as you can. Lewd slurping sounds fill the air as the slutty pork roast's groans get more high-pitched, quickly approaching another climax."
                    +"\n\nYou tongue her pleasure buzzer, prodding it with your wet tongue and enveloping it with your slobbering oral muscle, sending the whore over the edge as she sprays the creamy syrup into your mouth. You guzzle it down eagerly; the pig slut's biggest orgasm yet gushing into your [face], causing your cheeks to puff out as you drink more and more of the delicious fluid, losing track of time.");

            //[ Next ]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", getDoneEatingOutPigSlut);
        }

        function getDoneEatingOutPigSlut():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Finally you remove yourself from the still slightly dribbling juicebox, giving the whore one last spank as she seems to have passed out from the bliss. The bed is entirely a mess, covered with her sticky juices and torn from the spanking."
                    +"\n\nYou let out a satisfied burp from all the syrup you just ingested. Patting your own stomach, you make your way towards the door, leaving the piggy pussy drenched as the whore snoozes away, snorting cutely every once in a while."
                    +"\n\nWhoah, that was strange.");
            var changed:Boolean = false;
            if (player.thickness < 100) {
                EngineCore.outputText("  You notice that you seem a bit more... jiggly, a slight paunch in your stomach now as you grow a bit more plump than you once were.");
                if (player.thickness <= 10) player.thickness += 10;
                if (player.thickness <= 20) player.thickness += 10;
                if (player.thickness <= 30) player.thickness += 10;
                if (player.thickness <= 40) player.thickness += 10;
                if (player.thickness < 50) player.thickness += 5;
                changed = true;
            }
            if (player.butt.type < 35) {
                EngineCore.outputText("  You notice your ass filling out, gaining more mass as it visibly grows before your eyes.");
                if (player.butt.type < 4) player.butt.type += 3;
                if (player.butt.type <= 10) player.butt.type += 2;
                if (player.butt.type <= 15) player.butt.type += 1;
                if (player.butt.type <= 20) player.butt.type += 1;
                if (player.butt.type <= 35) player.butt.type += 1;
                changed = true;
            }
            if (player.hips.type < 35) {
                EngineCore.outputText(" Your hips grow too, widening and giving you more sexy curves.");
                if (player.hips.type < 4) player.hips.type += 3;
                if (player.hips.type < 10) player.hips.type += 2;
                if (player.hips.type < 15) player.hips.type += 1;
                if (player.hips.type < 20) player.hips.type += 1;
                if (player.hips.type < 35) player.hips.type += 1;
                changed = true;
            }
            if (player.biggestTitSize() < 20) {
                EngineCore.outputText(" Your boobs also grow, gaining size as it seems that every part of your body wants to join in on the growth.");
                if (player.biggestTitSize() < 3) player.growTits(3, player.bRows(), false, 1);
                if (player.biggestTitSize() < 6) player.growTits(2, player.bRows(), false, 1);
                if (player.biggestTitSize() < 12) player.growTits(2, player.bRows(), false, 1);
                if (player.biggestTitSize() < 20) player.growTits(2, player.bRows(), false, 1);
                changed = true;
            }
            EngineCore.outputText("\n\nYou sigh");
            if (changed) EngineCore.outputText(", feeling your body expand as you waddle out back towards camp with belly full of sweet syrup");
            EngineCore.outputText(". For only one gem, that was a pretty good time...");
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }
    }

    public static function isValentine():Boolean {
        //const VALENTINES_EVENT_YEAR:int = 736;
        return ((date.date >= 13 && date.date <= 15 && date.month == 1) || flags[kFLAGS.ITS_EVERY_DAY] > 0)
    }

    public static function crazyVDayShenanigansByVenithil():void {
        /*First of all, a few notes:
        - The scene should probably trigger automatically for people who have met Scylla enough times or been on her addiction meeting at least once, depending on which flags would make it easier for you, and should proc sometime from sometime before the normal hours for the addiction meeting to sometime after; let's say 16-20, upon entering the Wet Bitch or Tel'Adre at all, depending on what you think is better here. Probably the Wet Bitch.
        - Because the scene is Scylla-based, while it should require that you've only met Scylla and not necessarily meet her requirements anymoar, it'd still only be available for players who once had a 12+ inches cock. So, I guess the perks related to the event would best be somewhat weak, or you could do away with them at all, though in that case stat modifications should be present or even enhanced.
        - In short, the event has 7 possible outcomes, 3 possible gain-able perks, and might require an item and gender or just a cock present for some of the outcomes. 
        - The event should probably be available for a few days around the Valentines as usual, and sorry for the delay on it.
        - Most of the scenes are, unfortunately, not centaur-proof at all.
        - To go with Pastie, I've set it up so the player must have female parts or one of the game's more regular \"<i>alcohols</i>\". I guess she's the most messed up of the trio.
        
        Possible Perks to Gain:
        - One Track Mind : Player gains additional cum production or multiplier and their capacities increase.
        - Sensual Lover : Increases the effectiveness of teasing and gives a small Lust Resistance boost.
        - Pure and Loving : increases corruption resistance and lust resistance more than Sensual Lover, and/or maybe improves affection gains for NPCs if possible.
        
        Perk Descriptions:
        
        [One Track Mind] You're a dirty person. The highest you'd think of another is that they make you horny, and maybe \"<i>I'd tap that like there's no tomorrow.</i>\" There are no higher feelings for you in intimacy or sexual relations; you dabble in these purely to get off and not really caring about your partners. Even on a special days where love is celebrated, you can't muster affection other than in the form of an orgasm.
        As a super-sexual being, your cum production and capacities are slightly increased.
        
        [Sensual Lover] Intimacy is about making yourself and the other person feel good. You know that, and you resist neither falling in love nor having a one-night stand if someone is to your tastes. On a day that celebrates love, you're certainly wanted by many, but whose do you intend to be? Just tantalize others with how alluring and pleasant you are, or maybe more?
        Your sensuality makes it easy to arouse others and allows you to resist a bit of temptation yourself.
        Your Lust Resistance slightly increases, and you're better at teasing.
        
        [Pure and Loving] This day was about celebrating love, and although to each person love can mean something a bit different and some people need to open their eyes to the fact it exists, you've proven numerous times that being a romantic is not hopeless, and you certainly feel the spirit of the new Mareth holiday. Your strong heart is less likely to be purged of feelings, and people will love you more, too.
        
        THE EVENT ITSELF!*/
        EngineCore.clearOutput();
        flags[kFLAGS.VALENTINES_EVENT_YEAR] = date.fullYear;
        EngineCore.outputText("Moving through the streets of Tel'Adre, you turn your steps towards the Wet Bitch, only to find that there's some odd event going on nearby.  Deciding the town is a safe enough place to let yourself be led astray by curiosity, you decide to investigate a bit closer."
                +"\n\nNext to the tavern, there's a stall that's filled with flowers and many heart-shaped things; there's cards, chocolates, boxes of sweets, clothes with hearts sewn into them, mascots with the same, and even a sculpture of a heart and two lockets.  You'd say this was a shopping booth of sorts, but then, you're surprised by the sight of a goblin nearby, looking at you and waving."
                +"\n\nYou come closer.  At first, you'd only recognize Abylon because she's more or less the only goblin one can really see in Tel'Adre, but only by coming closer are you sure it's really her.  She seems oddly annoyed by her situation, and you sure can see why.  She's not clad in her usual leather plates; in its place, she has a nice, pink and red dress, with white gloves, frills, and a small belt around her waist, complete with a heart-shaped beltbuckle, accentuating her petite curves.  She appears to flush a bit as she notices you eyeing her up.  \"<i>W...what?  The fat cow told us to do this and Can't-Hold-Her-Drink was all for it, can you imagine?  I just... just tagged along.  In any case, as you can see, it's a disaster.  So much red and pink and whatnot.  I was surprised anybody was even interested.</i>\""
                +"\n\nRaising an eyebrow, you can easily understand why Abylon would be displeased with this kind of atmosphere, but at the same time you can't resist asking what, as a matter of fact, is going on here."
                +"\n\nAbby just points to the stall, explaining.  \"<i>Suck-a-lot claimed that there'd be some sort of a celebration regarding lovey-dovey stuff where she's from sometime around today.  She decided to make it known and popular here in Tel'Adre and try to get'em to celebrate said holiday as well.  Hence this little farce.  Me and Pastie are helping her, and surprisingly some people were even interested.</i>\""
                +"\n\nYou nod to Abby and decide to come closer to the stall.  Pastie, surprisingly sober for once, and only slightly displeased by that fact, it seems, is dancing over the table, also dressed in frilly clothes, apparently meant to act as some sort of cupid, only with fairy wings instead of feathery ones.  You hear the voice of someone pleasantly surprised before you look up to see Scylla smiling at you.  Unlike Abby and Pastie, she kept most of her habit intact, but today, she has forgone her coif and veil, leaving her hair completely exposed, though made up in a way to cover her little horns along with the small embroidery she decided to add.  She has a pink flower in her hair, and also in the space in-between her voluminous chest-mounds, giving you an excuse to glance at it for a moment, and flower-like frills added to the sleeves of her over-filled habit.");
        EngineCore.outputText("\n\n\"<i>[name]!  I had hoped to see you here today! It's certainly a very nice occasion, you know.  You see, where I come from, it's a holiday to celebrate love in all its forms- both for couples and the freshly love-struck.  I'm hoping, with a little help from our humble demonstration, the people of Mareth will adopt it, in time...</i>\" she says, her voice still buoyant with optimism, but a hint of worry in her voice.  It's probably not going exactly as well as she had hoped.  \"<i>Well, in your case, I'm sure you'd have a reason to celebrate it.  Certainly, a brave, valiant " + player.mf("man", "woman") + " like you would have quite a few people interested in them, and maybe someone you'd see as a special person as well!</i>\"  You guess you can see her logic.  After all, it's because you've beaten the Omnibus that she's here in the first place.  You can't say that the random people in Tel'Adre treat you unpleasantly, so maybe you're more popular here than you would've guessed.");

        //Corruption 0-33 :
        if (player.cor <= 33) EngineCore.outputText("\n\nIt is a rather pleasant thought, that not only a few someones, but a wider public in general appreciates what you've done.");
        //Corruption 34-66 :
        else if (player.cor < 66) EngineCore.outputText("\n\nYou certainly deserve the recognition, and maybe some of the benefits that could've come with it as well.");
        //Corruption 67-100 :
        else EngineCore.outputText("\n\nNow that's a thought.  Perhaps there'd be more people in this town willing to help you slake your lusts more often than you thought this place would allow.  A bunch of lovestruck hero-worshippers dedicated to your pleasure sounds great.");

        EngineCore.outputText("\n\nLifting a finger to her plump lips, Scylla seems to be considering something.  \"<i>Perhaps you would like to participate in one of our events?  Some of these things are for sale, but mostly I tried to organize these things so that anyone interested can get something, and with the games anyone can get absolutely anything as long as they try a little.  Although... it seems like we've managed to prepare too much, as it turns out now...</i>\" Scylla says with a saddened expression, Pastie flying over to perch onto her shoulder and looking at you helpfully before whispering something to the nun.  \"<i>Ah, yes!  Maybe if you helped, if you'd be so kind.  You see, it's hard to bring the attention of many people when there's only three of us, even if I tried to pick up a popular location, so maybe you could go with Abby and spread the word to all the love-birds that there's a celebration!  What do you say, [name]?  Could you help us?</i>\"");

        //I've considered making it so that the truly corrupt characters can't really participate, but that might be seen as unfair. You could either apply these or give the \"<i>moderate</i>\" corruption text and choice to everyone.
        //Corruption 86-100 : You consider for a moment, but the answer is as clear as day and night. With a look of contempt and maybe a hint of pity, you tell Scylla that things like love are illusions the weak rely on, useless to you, and intimacy is simply a more polite word for fucking and taking your pleasure from whom you'd want to get it. You don't care much for her stupid excuse for celebration.
        //With that, you turn around and go back into the streets of Tel'Adre
        //[end event]
        //Corruption 16-85 : 
        EngineCore.outputText("\n\nWell, you do have more important things to do, and in the world of Mareth, where the corruption is dominant and there's definitely way more sex than romance, such a mission may be doomed to fail anyways, but it is something to consider.  All in all, it comes down to whether you think you have the time for this and whether it even seems worth it.");
        EngineCore.awardAchievement("Valentine", kACHIEVEMENTS.HOLIDAY_VALENTINE);
        //[Help them][Leave]
        EngineCore.menu();
        EngineCore.addButton(0, "Help Them", helpValentinesDay);
        EngineCore.addButton(1, "Leave", leaveValentinesDayForever);

        //[Help them] :
        function helpValentinesDay():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Deciding to try and improve the overall appreciation of romance and love in possibly the last pure city of Mareth, you smile to Scylla and tell her she can count on you.  Her happy expression makes you forget any doubts you might've had before.");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", helpValentinesDayII);
        }

        //[Leave] :
        function leaveValentinesDayForever():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Ultimately, this is not worth your time.  You wish Scylla good luck, but tell her you won't help her make the holiday more popular in Tel'Adre, as you have other things to do.  Her expression turns sad and she nods in understanding as you turn away and go back into the streets of Tel'Adre.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //[next]
        function helpValentinesDayII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Deciding to help Scylla out, you take Abylon and head out.  Travelling around the city, splitting up occasionally to cover more ground, the two of you spread the word.  Even the little goblin, who is still wearing her displeasure with more enthusiasm than her lace, seems content with your companionship in this little quest.   You put a few posters around the city, but mostly tell people directly about the event, convincing them to come and participate.  You bustle about, dropping the good message into the gym first, and then, visiting the shopkeepers."
                    +"\n\nAs you approach the pawn shop, you're nearly certain someone is observing you.  You turn about to catch the peeping tom, but find no one.  From the corner of your eye, you spot a cat's long, black tail flashing from a nearby alley but just like that, it's gone.  Perhaps you just imagined it."
                    +"\n\nYou find Oswald in front of his shop this time around, and tell him of Scylla organizing the celebration in the name of romance and love.  He seems a bit confused.  \"<i>Well, this seems pointless... it's not even going to bring her any profit.  Anyway, I may go and see if I have the time.</i>\""
                    +"\n\nVictoria seems far less resistant to the idea.  \"<i>Scylla?  Clad all the way in a black habit, but with so many curves she might as well be hiding other people under it?  Plump ruby lips, tall as all the remaining mice-people in the world combined?  Yeah, I remember her.</i>\""
                    +"\n\nYou explain to her the idea behind the celebration.  \"<i>Oh, so that's the reason she came here asking for materials and even buying some clothes straight away... she only told me I'd see in a couple of days.  Well, sure, that sounds like it might be quite profitable if something like that ever became a commonly celebrated holiday in Tel'Adre... but I guess it's against the spirit of it to think that way.  First and foremost, it warms the heart to think someone even thinks that way these days.  I'll come and tell my friends.</i>\""
                    +"\n\nYvonne faintly blushes at hearing about the celebration.  \"<i>W-well, I don't know,</i>\" she says, fanning herself more quickly.  \"<i>There's business and everything, and I'm not sure if... well, that's just not profitable, I think...</i>\"  You nod and prepare to leave, as you hear her mumble.  \"<i>I'll probably have the time, though...</i>\""
                    +"\n\nYara is way more openly enthusiastic about the idea.  \"<i>Hey, that sounds kinda familiar.  In any case, it's a good idea, I think.  People here mostly just care about the fucking, it'd seem.  Anyone knows even the fucking is a bit better with some feelings thrown into it.  Well... anyone NORMAL should know that.  Sure, I'll come and tell any of today's clients.</i>\""
                    +"\n\nAfter visiting the bakery and the weapon shop, that makes for all the people you can think of other than those in the Wet Bitch, who would know anyway. After another run around the Tel'Adre with Abby, who oddly seems to be holding back on showing her slightly improved mood, you return to the front of Scylla's stall. There are certainly way more people around the place now."
                    +"\n\nThrough the small crowd, you even see an oddly familiar flash of black and gray vulpine fur.");
            //([Fuckbuddy or Heartbroken Urta])
            //if(!urtaLove()) outputText("\n\nThe bearer of it seems to just come here to look uncomfortably but, perhaps, longingly at the stall for a few moments, before practically leaping back into the Wet Bitch.");
            //else outputText("\n\nYou see a flash of said fur as the person with said characteristic moves away from the stall, clearly carrying a confection or two and some other pink, red, or heart-shaped things into the Wet Bitch.");

            //[next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", helpValentinesDayIII);
        }

        function helpValentinesDayIII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You spend the rest of the evening participating in holiday games and showing people around the stall, listening to Scylla giving a talk or two about love and the celebration of it.  All in all, the little popularization of the holiday turned out to be a moderate success, but a success after all thanks to the joint effort of the four of you."
                    +"\n\nThat being said, the sun is slowly setting and the people begin to leave for their homes.  You reckon you may be a bit tired soon, and have to return to camp at some point, but at the same time, you could allow yourself to wander around with one of the girls instead."
                    +"\n\nHow do you want to spend the rest of your evening?");
            //[GoHome][Scylla][Abby][Pastie]
            EngineCore.menu();
            EngineCore.addButton(0, "Scylla", goVisitScyllaVday);
            EngineCore.addButton(1, "Abby", goVisitAbbyVday);
            if (player.cockThatFits(28) >= 0 || player.hasVagina()) EngineCore.addButton(2, "Pastie", goVisitPastyVDay);
            EngineCore.addButton(4, "Leave", goHomeFromVDay);
        }

        //([Go home])
        function goHomeFromVDay():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You decide your work here is done, and bid the three girls goodbye.  Scylla in particular seems grateful for your help, locking you in a smooshy hug for a few seconds before letting you go, and again expressing her gratitude for your help.  Well, that last gratitude almost made it worth it, though on the other hand, you find yourself a bit aroused by it...");
            //With no other things to do, you go back to camp to rest.
            //{Small Lust Increase, return to camp, go to sleep}
            player.dynStats("lus", 10);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //([Scylla])
        function goVisitScyllaVday():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You say your goodbyes to Abby and Pastie, before asking Scylla if she'd mind you accompanying her when she packs the remaining few things and maybe afterwards.  The nun blushes, playing with a lock of her hair as she answers.  \"<i>My dear [name], you are of course aware that the reason for me even trying to make this celebration more popular is so that people would spend it with ones they love.  As much as I'd appreciate your company, are you sure you'd want to be spending this day with a nun that is already so indebted to you?</i>\""
                    +"\n\nYou tell her you're more than willing to spend more time with her, and help her pack the things that did not get given away, won or sold in the celebration.  After that, she covers the stall and smiles at you. \"<i>I'll be taking these things home tomorrow. How about we just go for a walk now?</i>\"");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", goVisitScyllaVdayII);
        }

        //SCYLLA EVENT
        function goVisitScyllaVdayII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Scylla takes you for a longer walk throught the now barely illuminated streets of Tel'Adre, clearly a bit giddy and in a good mood after today's events.  \"<i>Thank you, [name].  Once again, I think I am in your debt.  These are certainly hard times for this world, and many people certainly try to cope by indulging themselves while throwing away the emotional and spiritual sides of things... it's understandable, but it's wrong.  People shouldn't forget how much comfort and happiness one can find in another person, especially through strong emotions and attachments like romantic or familial love,</i>\" she says as you walk through the sunset-illuminated alleys, smiling at you gently, a small rosy blush at her cheeks.  \"<i>The way myself, and I'm sure a few lucky others, find in those like you,</i>\" she says in a whisper that's still easily heard in the near-empty streets of Tel'Adre."
                    +"\n\nYou simply listen to her but also blush at the last line, thanking her for her appreciation of your person. She gives a small laugh at that.  \"<i>Well, certainly, we've had our troubles with my... new way of eating, and I'm sure you didn't always feel like I really appreciated you or treated you with dignity... I'm sorry about that, but I really feel like I depended on you a lot and I know you're a great person,</i>\" she continues, her smile widening and blush slightly deepening with every sentence.  \"<i>You're more special than the others who've helped me, having always recognized my problems and solutions to them first.  You've saved me from a certain fall to the demon's corruption...  And you taste really good, too,</i>\" she says, licking her ruby lips before absent-mindedly noticing what she just said, flushing a deep red.  \"<i>Well, in any case, thanks to your help, this wasn't as much of a strain as I thought.  I feel like I might've really done some things to make this world a slightly better place, and I've certainly seen you do so.  That warms my heart and makes the time spent here worth it,</i>\" she explains, resting a hand on your shoulder before showing you a turn.  \"<i>We could climb that tower there and watch the sunset,</i>\" she says, before explaining, \"<i>I'm certain we're both known enough around the place that the guards won't protest much, after all, it's just watching a sunset.  What do you think, dear?</i>\"  Her soft body bounces a bit under the habit as she stops, her flush receding to the pleasant, rosy color from before, but remaining clearly visible on her alabaster skin.");
            //[next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", goVisitScyllaVdayIII);
        }

        function goVisitScyllaVdayIII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Indeed, once the guards recognize Scylla and one of them whispers something about you to the other, getting through the tower to the walls of the town isn't much of a challenge at all.  You two climb the stairs of the tower, Scylla's large breasts bouncing tantalizingly in her habit as she holds your hand moving up and up."
                    +"\n\nFinally, you come out another door, and you're somewhat blinded by suddenly facing the setting sun.  Scylla doesn't seem to mind, however, as she takes a few steps forward, sits down on the stony wall of the city and pats the spot next to her, motioning for you to join her."
                    +"\n\nWhen you do, she hooks an arm around yours, obviously pressing your hand and forearm against her overwhelming breasts, the soft, slightly liquid-like, smooshy feeling quickly encompassing almost all of your hand.  You certainly don't complain as you bring your body closer to Scylla's warm one.  \"<i>It's a very nice sunset, certainly.  Views like this one make the effort worth it, I think, even if the place would be better with a lot more green...</i>\"  She sighs.  \"<i>In any case, you're probably working hard to make Mareth a better place, and you're on the right track, I'm sure.  Spending time with you and seeing you develop also makes a day a good one, you know.</i>\""
                    +"\n\nYou ponder on how you should respond... it seems Scylla got a bit touchy-feely with you on this holiday, and while it certainly feels nice, the very presence of her over-eroticized body is a temptation in and of itself to take advantage of this closeness...");

            //What will you do?
            EngineCore.menu();
            //[Cuddle] [Make out] [Feed her]
            EngineCore.addButton(0, "Cuddle", cuddleWithScyllaVDay);
            EngineCore.addButton(1, "Make Out", makeOutWithScyllaVDay);
            EngineCore.addButton(2, "Feed Her", feedScyllaVDay);
        }

        //Cuddle]
        //{This option doesn't require any sexual endowments whatsoever}
        function cuddleWithScyllaVDay():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Realizing this can be quite a special moment, you gently slide a hand through Scylla's hair, guiding her by the head and towards your own [face].  Slowly, you place a kiss on her soft, ruby lips, allowing your tongue to slip inside and touch hers, which thrashes in her mouth for a moment before wrapping around yours, with Scylla first somewhat whimpering, then almost purring at the contact as the two of you kiss one another.  Her hand also meets the back of your head, pulling you more strongly into the kiss, her lips gently puffing up and encompassing yours with their warmth as your tongues coil around one another, a trickle of mixed saliva escaping your mouths and marking Scylla's habit with wetness.  Rather than break the kiss, Scylla gently decreases the pressure and, very slowly, starts to pull away, her lips first still keeping in light, tantalizing touch with your own before parting.  You start inhaling deeper, the flower in Scylla's hair still giving her a gentle fragrance, her own feminine scent nicely blending with it.  You thank Scylla for the kiss, which causes her to blush, and she answers right back.  \"<i>Thank you too, my dear angel.  For everything.  Saving me, and showing me both the good, pleasant things and the things I needed for survival... a kiss is the least I can give you, I guess.</i>\""
                    +"\n\nWith a smile, you cuddle up more against Scylla, sharing the bodily warmth between the two of you and snaking an arm around her waist.  \"<i>My, my.  I'm surely being treated appropriately for the occasion.  It's a bit embarassing...</i>\" she whispers, but leans her head towards you and you feel both her warmth and her gentle fragrance."
                    +"\n\nThe two of you spend some time cuddled up like that, watching the sun set.  Scylla's soft curves, especially her breasts, are overwhelming; you don't even have the willpower to resist copping a few feels, and initially, it's hard to stay still, aroused as you are.");
            //[if (hasVagina = true)]
            if (player.hasVagina()) EngineCore.outputText("  Your [vagina] is starting to get moist, making a small mess in your underclothes.");
            //[if (hasCock = true)]
            if (player.hasCock()) EngineCore.outputText("  You realize it'd probably be a done deal if you didn't resist the pull of your hardening cock towards one of Scylla's orifices, but you decide to spare her any temptations and endure yourself.");
            EngineCore.outputText("  In time, your ignited lust slowly changes to constant arousal, and Scylla just sitting there, watching the sun with a beautiful smile on her face, clearly content to just have someone in her arms on this evening is helping you control yourself a lot better."
                    +"\n\nHer eyes sparkle a bit as the sun's last rays of light loom over the horizon, and by that time your wants have changed into a pleasant, calm passion and relaxation in the soft arms of the nun, her breast smooshed against your hand and even your own [fullChest], the warmth almost making you think you could simply fall asleep right there.  However, a couple of minutes after the sun has completely crossed the horizon, Scylla rouses you and moves up to her feet herself, helping you get up before planting a hand on the cheek of your [face] and sharing one last, tender kiss with you.  \"<i>Thank you for helping out and spending time with me today, [name].  I will not forget this, and I do appreciate everything you've done to make this day special.  I hope every day turns out great and full of love for you.</i>\" She says, putting a hand on your shoulder and leading you down the stairs."
                    +"\n\nLater, when you move through the desert around Tel'Adre towards your own camp, looking back at Scylla waving towards you, you're somehow glad things turned out that way, and feel more determined than ever to not only defeat the demons, but also spread the good will and positive feelings through any world you may call your own.");

            if (player.findPerk(PerkLib.PureAndLoving) < 0) {
                EngineCore.outputText("\n\n(<b>You have gained the Pure and Loving perk!</b>");
                player.createPerk(PerkLib.PureAndLoving, 0, 0, 0, 0);
            }
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //[Make out]
        function makeOutWithScyllaVDay():void {
            EngineCore.clearOutput();
            //{This option requires a member of essentially any size}
            EngineCore.outputText("Before long, the silkiness, warmth, and absolutely astounding curves of Scylla's body, not to mention the sight of her beautiful, full ruby lips, reflecting the light of the setting sun a bit, become a bit too much for you to resist.  You raise a bit, placing one of your hands against Scylla's way-beyond-prominent breast, feeling her start a bit as she turns to you, before you push your own lips against hers.  You hear a small gasp escape her, though you could never guess which pair of lips let it out.  You slip a tongue inside her mouth and she quickly yields, half-sighing as she gently slumps against you, your hand sinking further into her flesh as you can swear the lipple on the breast you're fondling starts sucking on her habit, seeking your fingers."
                    +"\n\nYou're not content to part with her yet, though, and your tongues start dancing alongside one another.  Scylla wraps her hands around you and pulls you into a close, intimate embrace, your body being encompassed by her enormous cleavage.  Your hand is now more forcefully pressed against her chest along with your forearm, and you feel a stirring in your groin at the sensation.  Certainly, Scylla's shyness has evaporated somewhere as she sucks on your tongue forcefully with her own wrapped around it, all the while forcefully pressing you close to her magnificent body.");

            //[pg]
            EngineCore.outputText("\n\nAfter a longer while, Scylla's tongue unwraps from yours and, with a moist slurp, she swallows your mixed drool as your lips break their touch.  You both pant heavily, and ");
            //[if (cocks = 1)
            if (player.cockTotal() == 1) EngineCore.outputText("your [cock] is completely hard and stiff, forming a bulge in your clothing");
            else if (player.cockTotal() > 1) EngineCore.outputText("[eachCock] is by now completely hard, eager to be touched and wanting to be caressed by the nun you're kissing");
            EngineCore.outputText("."
                    +"\n\nScylla, of course, notices and presses her hand against your bulge.  \"<i>It seems... we've gone a little too far in... celebrating...</i>\" she says, blushing heavily, but leaning in to kiss at your neck, sucking so strongly by sheer instinct that she'll probably leave a hickey. The fragrant flower in her hair bobs next to you before she moves towards your cheek, and back to your lips, need driving her deeper.  Eager to comply, you open your lips, while the two of you tug at the stretchy velvet of her habit.  The modest drape is pulled down and away from her over-stimulated, hungry tit-lips."
                    +"\n\nSuccessfully bearing her prodigious chest, you're rewarded with the pale luminescence of Scylla's smooth, alabaster skin; her huge, yielding breasts; and her glistening, ruby nipples that curl at the ends into coy smiles."
                    +"\n\nThe two of you break your kiss and you both realize she probably could use a smooch or two on her other lips.  \"<i>Please, help yourself... go right... ahead...</i>\" Scylla says, gently tugging you towards her breasts as she does so, and you comply eagerly, rubbing your cheeks against her sating breast and eager, suckling lips.  At first, you just smooch the ruby, drop-shaped nipple, but as it insistently tries to deepen the kiss and reengage into it, you comply, letting your tongue run along the lip before plunging in for a wet, milky kiss as Scylla releases a small yelp changing into a moan of increasing passion, her fingers wrapping around the back of your head and pressing you closer to her enormous breast, slowly putting more pressure onto you, forcing you to make out with her eager lipple.  The tasty, creamy milk starts to generously flow into your mouth after a while, and you drink it contentedly, your other hand traveling to Scylla's other breast, lifting it up and appreciating its weight, softness, and luxurious satin feel.  You brush your fingertips against her tit, causing her to shudder and sending her breasts into jiggles, increasing the flow into your mouth as Scylla continues to release mewls and moans of pleasure, some of them quiet, some more energetic. \"<i>Yesss, [name]... now, please, the other one, too!</i>\"");

            //[pg]
            EngineCore.outputText("\n\nNot being one to refuse a lady, you break the kiss with her right lipple even though it sucks aggressively on your tongue, almost as if trying to force it to stay, and instead plunge a finger into her right boob-lip, letting it suck on it happily and sloppily as you make out with Scylla's other boob.  The nun shivers and shudders, trying to control her pleasure, but only partially succeeding. \"<i>..Oh... oh gods...</i>\" she lets slip, pulling you more closely into her body."
                    +"\n\nYou're eager to try to steal the first orgasm from the chaste nun without giving in to your own lust too quickly, but the way she's starting to squirm against your painful hardness makes it difficult for you to remain noble.  The sheer volume of the absurdly-endowed woman's cleavage starts to overwhelm you, leaving you gasping short and hot breaths.  As usual - for the tainted nun, anyway - your suckling and nursing has stimulated Scylla's body, her curves swelling to overcompensate for her burgeoning hunger.  Your presence, to say nothing of your own arousal, has left her a bit too eager to get you off as well...");
            //[next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", makeOutWithScyllaVDayII);
        }


        function makeOutWithScyllaVDayII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Bending at her waist, Scylla kisses you on the forehead as she pulls your body upwards, into the squishy, half-liquid embrace of her mountainous cleavage, and you're at home, encompassed by the warmth and softness.  Her hands fiddle around your waist, disposing of the lower parts of your [armor] quickly as she handles your erection with care, but enthusiasm, stroking you as you drip your precum onto her palms.  It's impossible for either of you to resist anymore and you push forward through the near-literal valley of her cleavage, snuggling up to Scylla and kissing her on the lips.  Her hand, continuously stroking, directs your [cockHead] against the satin skin of her heaving boob, and you shudder at the sensation, being dragged across it, soon, you realize, about to end up wrapped in her breast again, sucked at until you cum."
                    +"\n\nYou eagerly make out with her, trying to give as you're about to get, while kneading her breast flesh with your own hands, and soon, you arrive at your destination, the crown of your member pressed against her steamy, drooling breast-lips, moistened by her milk as it slurps audibly, first teasingly, but then, drawing you inside.  Your hips buck slightly and you're pushed inside her more quickly than she was prepared for.  Scylla's entire body shudders, you realize, in orgasm, going a bit slack in your arms.  However, her titflesh never stops to contract around you, the milk-laden folds lapping at your member, pulling you deeper inside and seeking to milk you dry.  You're way too turned on and Scylla suddenly recovering to moan into your mouth and press herself closer against you is the last straw when you give in to her breasts' hunger."
                    +"\n\nYou fire off inside Scylla's tit, and the remaining lip draws in air eagerly as the two of them suck, one at the air, the other at your [cock]. You shudder in Scylla's embrace as you unload your offering into her.");
            //[if (cumMedium = true)
            if (player.cumQ() < 500) EngineCore.outputText("  It's easy to lose yourself into the feeling of Scylla's breast drawing from you, and you realize you're cumming longer and harder than you should, but soon, the ravenous breast sucks you dry, continuing to milk you aggressively for more.  You moan into Scylla's lips, and she pats your head, shuddering as she seems to slowly get off again too from being fed directly....");
            //[if (cumHigh = true) 
            else if (player.cumQ() < 1500) EngineCore.outputText("  Scylla's a blessed cum-milker and she doesn't fail this time, either.  Your orgasm and cum output are tremendous, more and more being pulled out of your [cock] and [balls] as Scylla releases a guttural sound, gently inflating her boobs further from draining you and orgasming on her own, milk flowing down her breasts and saliva down her neck as she gives in to the sensations.  Her breast, despite being sated, continues to suckle at you even after your orgasm, almost as if wondering if it could draw out more.  You snuggle up to Scylla, making out with her upper lips, her hands roam over your body in a comforting, pleasant fashion...");
            //[if (cumVeryHigh = true) 
            else {
                EngineCore.outputText("  Scylla's tit thirsts for your cum and you can't afford to let it down. Your orgasm causes you to black out for a moment as you flood her breast with wave after wave of cum, so much that you risk being pulled away from her lips if not for her possessively hanging on to you as she trembles in an intense orgasm, her thirst being sated and pleasure spreading through her body, more and more being pulled out of your [cock] and [balls] as Scylla's body and breasts continue to balloon out, her tits easing out slowly on their draining of you.  Cum and milk flow down her breasts as her body gives in to the sensations.  Her breast, despite being sated, continues to suckle at you even after your orgasm, almost as if wondering if it could draw out more.  You enjoy the sensation of Scylla's liquid-filled body under you for a while.");
            }
            EngineCore.outputText("\n\nYou finally lift yourself off Scylla after your orgasm, and she looks at you with warmth.  \"<i>That surprised me...</i>\" she claims.  \"<i>Not in a way that I'd mind, though...</i>\" she says, her smile widening as she blows you a kiss.  \"<i>This is certainly one way to celebrate love, and I must say I'm glad you gave me your proof of celebration...</i>\" she says with a blush, but quickly adds.  \"<i>Neither of us should give into desire so easily, though. Today, however, is special, so we should be easy on ourselves and let it slide...</i>\""
                    +"\n\nAn hour or so later and quite a bit after sunset, you return to your camp, satisfied and pleased with how you celebrated this holiday...");

            // Only add the perk if the player doesn't already have it.
            if (player.findPerk(PerkLib.SensualLover) < 0) {
                EngineCore.outputText("\n\n(<b>You have gained the Sensual Lover perk!</b>)");
                player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
            }

            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //[Feed Her!]
        function feedScyllaVDay():void {
            //{This option requires a member of Scylla's usual requirements}
            EngineCore.clearOutput();
            //{The PC titfucks Scylla again, and then gets her to suck them off, resulting in two quick orgasm and a big nice load of food for Scylla. How far can you fall to get off? On such a nice day, too!}
            EngineCore.outputText("You feed Scylla what feels like a gallon of jizz!");
            player.orgasm();
            if (player.findPerk(PerkLib.OneTrackMind) < 0) {
                EngineCore.outputText("\n\n(<b>You have gained the One Track Mind perk.</b>");
                player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
            }
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }


        //([Abby] 
        function goVisitAbbyVday():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You wave to Scylla and Pastie as you try to catch up with Abylon, who's already picking up the pace and, by the looks of it, trying to remove her dress.  \"<i>Well, sup.  I'll be going home and changing myself into my usual clothes, if you don't mind.  This entire celebration thingy just shows your people's issues,</i>\" she says, though she doesn't seem entirely untouched by the mood of it..."
                    +"\n\nDeciding to risk it, you ask her if she'd like some company. Abylon turns to you, completely stunned.");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", goVisitAbby);
        }

        //ABYLON EVENT
        function goVisitAbby():void {
            EngineCore.clearOutput();
            EngineCore.outputText("\"<i>You... you're kidding, right?  That fatty's words messing with yah head?  I always figured you were somewhat less... messed up in the head than Suck-a-Lot and Always-Drunk.  Was I wrong?</i>\""
                    +"\n\nYou smile and tell her that if she wasn't wrong, that'd make it obvious you'd like to hang out with her rather than them, and if she was wrong, she'll just have to judge it for herself."
                    +"\n\n\"<i>Makes sense, I guess?</i>\" she answers, nodding. \"<i>But, seriously, keep a lil' bit of distance, and don't shove anything pink or red in my face.  Seriously, I'm all weird after that little love talk...</i>\""
                    +"\n\nYou nod and muse that as a goblin, she's not probably used to the notion.  \"<i>Damn right I ain't!  My crazy bitch of a momma would trade three of me for a four inch dick!  All she cares about is thick cum in her slut-box.  The guys I meet come to me 'cause they figure I'll let 'em blow their load inside me an practically cream my brains out 'cause of it,</i>\" she answers, somewhat defensively, and you wonder about musing if they were right, but decide against it. You do note, however, that this seems like she's not opposed to the notion, more like she was never faced with anybody loving her or anyone she'd come to love.  \"<i>Well... uhhh, look, it's all fine and all, the pinkies, reds, hearts and everything.  I just don't get it, all right?  It doesn't work that way, out there in Mareth.  They fuck you and claim you, or dump you in the dirt, or fuck you again and you possibly die, or fuck you and eat you.  That's how things work.  Cuddling up with someone after sex and whispering sweet nothings? Dates?  Gifts?  Weddin' someone?  Dat kinda shit?  Now, that's what's kinky and unusual here.</i>\"  She nods semi-sagely, and you can't help but think she has a point."
                    +"\n\nAfter a while of walking in silence, she finally breaks it. \"<i>Soo, uhh, what's the story with you and Sister Cow-boobs?  You two came 'ere from the same world or somethin'?</i>\" she asks."
                    +"\n\nYou explain to her that while you've known Scylla for longer than she has, probably, it's a pretty recent acquaintance.  You managed to free her, amongst other slaves, from a demonic factory and found her in Tel'Adre.  The two of you have... \"<i>helped</i>\" one another in a few ways after that, and been rather friendly since.  You blush a bit, remembering what the \"<i>helping</i>\" has sometimes brought."
                    +"\n\n\"<i>Ahhh, I see.  " + player.mf("He", "She") + ", the hero, saving a nun from the evil clutches of the demonic overlord!  She says thank you through growin' monstrous curves and providing extra sloppy blowjobs!  Dat right?</i>\"  You giggle a bit at that interpretation, and say it's not really all that far from the truth, although it is cheapening things... as is her previous interpretation of \"<i>Marethian kinkyness</i>\" cheapening love somewhat.  Abby brings a hand to her lips.  \"<i>Well, she does, at least, LOOK like she could do some... stuff... to a cock.</i>\"  She says, blushing, before you detour that train of thought with a question on how she's gotten herself here."
                    +"\n\n\"<i>Well, I am the daughter of one of the firstborn corrupt gravidophiliac goblin-sluts of this world, Tamani! As a goblin, I should probably look up to the sluttiness of my mom while hating her guts for stealin' all that cock, but I simply hate her guts, since she's a selfish whore,</i>\" she explains.  \"<i>Same can be applied to most goblins, I guess.  Chasing after cum and pregnancy more than any real satisfaction, day after day,</i>\" she nods to herself.  \"<i>I knew something was wrong about it and have managed to fight off the urges somewhat, escaping \"<i>mommy's</i>\" clutches and moving away from the forest.  Saw a few things, even a farm, though there was a mean-looking guy there, so I stayed away.  I've met a few hunter and scout guys, though.  Nice boys.  Understood me and offered some... relief to these sick urges.  Done my best to avoid changing into an incubator permanently.</i>\" she says, though the amount of plumpness to her butt and her not completely flat chest may point out she's gotten herself pregnant once... or thrice. You don't push the issue."
                    +"\n\n\"<i>And a girl.  Really nice one, that.  With a cock, of course, I ain't much for that carpet munchin' shit, like most goblins.  A hermaphrodite, people would say.  Still, she called herself a girl, makes sense with the boobs, what else would she call herself?  She showed me my way here.  I guess she saw I'm less crazy than your everyday goblin.  I shagged her and a few guys, but... haven't seen her in a while.  Anyway, I...</i>\" she goes silent for a moment, looking at you, and then the ground.  She seems to try and weigh her words, or even consider saying them. \"<i>... something was a bit wrong about all that.  I mean, sure, getting cock was fun, but... I might've been just like every goblin, just seeing a bit past the get pregnant race and seeking mostly the sexual satisfaction. If that's true, I'm just remotely better than my cumwhore of a mother, so... when a nun invited me to that shitty meeting after seeing me drink my doubts away, I said, what the hell.  You know the rest.</i>\""
                    +"\n\nYou nod and tell her that, certainly, she seems less crazy and way more reasonable than any goblin you know of so far.  \"<i>Uhh, thanks. It's... nice to hear you say that.</i>\""
                    +"\n\nAbylon suddenly deeply flushes and turns to face you.  \"<i>You know, [name], I'm not dumb.  I know where this is going.  Uhhh, it's certainly rare to see a dashing hero play the nice guy with a goblin, I guess I didn't expect that, but, essentially... getting me worked up with nun blowjobs and stories of getting here... you're lookin' to get a little wet ain't you?  Just... be honest, I know better.  And I could actually use that.  Haven't gotten any in a while and I guess that whole talk and, well... you... got me a bit horny.</i>\""
                    +"\n\nYou smile at Abylon coyly and tell her that there's certainly no shame in getting off with someone on the day that's supposed to celebrate love, but you'd like to do it a little better than her \"<i>guys</i>\" before did, and get her off without dumping her in an alley afterwards."
                    +"\n\nShe nods and picks up the pace, and you soon arrive at a rather small, but not bad-looking shack nearby the city's walls.  Abylon invites you in, and you ask her if it's her house.  \"<i>Well... yeah?  I mean... I gotta live somewhere!  Suck-a-lot actually helped me with it, and... Uhh, you see, goblins can have other skills than just suckin' dick and taking creampies.  I'm a bit fit, I know a bit of alchemy, so put the two together, do some making, do some delivery, do a mix of both... I've made a small living.</i>\""
                    +"\n\nNodding, you go in and make yourself at home, before Abylon tugs at your hand and seemingly continues to remove her dress, showing herself to you naked, in all of her small, couple of feet tall \"<i>glory</i>\". \"<i>W-well, time for you to show what you're made of, champ,</i>\" she says, bending around a small table, wiggling her posh bottom at you with a look of certain hunger and restlessness to her eyes.");
            EngineCore.menu();
            if (player.hasCock()) {
                var x:int = player.cockThatFits(46);
                //([If ([cocksmallest] < 46 cockArea) 
                if (player.cockArea(x) < 46) {
                    EngineCore.outputText("\n\nYou could certainly go for a dip into that goblin cunt, but, there's also the option of forgoing your pleasure on this special day and using other means to show her a good time.");
                    //<You can both pleasure and fuck her>
                    EngineCore.addButton(1, "Fuck Her", fuckAbbyVDay);
                }
                //[If ([cocksmallest] > 46 cockArea)
                else {
                    EngineCore.outputText("\n\nThe small look of fright in her eyes when she sees how well-endowed you are tells you she'd be unable to really accommodate that.  Still, the option of pleasuring her in other ways remains.");
                }
            }
            //[if (hasVagina = false)
            else if (player.hasVagina()) EngineCore.outputText("\"<i>Well, that's unexpected. I have certain doubts about you showing me such a good time,</i>\" she says.  You tell her you don't actually require a cock at all to do this, and she seems surprised.");
            EngineCore.addButton(0, "PleasureHer", pleasureAbbyVDay);

        }

        //{FUCK HER}
        function fuckAbbyVDay():void {
            EngineCore.clearOutput();
            var x:int = player.cockThatFits(46);
            if (x < 0) x = player.smallestCockIndex();
            EngineCore.outputText("Figuring that the goblin girl's felt so out of place amid a celebration of love, you might as well show her a little affection the only way she's likely to understand.  Pulling aside your [armor] enough to let [eachCock] spring free, you step up behind the bent-over girl and rest your hands on her thick thighs.  The emerald girl's breath quickens as the heat of your manhood presses between the jiggling globes of her ass cheeks and a whimper escapes her throat before she realizes it.  Coughing, in an attempt to cover the moment of weakness, she turns her head to the side to give you a disapproving eye.  “What is this, romance?  Just jam it in, already!” she commands, gruffly.  Her face is flushed a deeper forest hue, pink irises twinkling in the dim light of her spartan home."
                    +"\n\nUnintimidated, you take just a moment longer to tease the girl.  With the two of you, alone, in this intimate setting, you're given a chance to appreciate the goblin on her own merits.  Unlike most goblins, she doesn't  appear to be using hair dye - her vibrant red hue looks natural and matches the small tuft of silky red hair at the top of her jade pussy.  The three-foot braid hanging from her scalp is both thick and lustrous, suggesting that she may have channeled some of her kind's cock-hungry energy into an obsession with hair care.  Even her home is curiously devoid of the sexual aids you'd expect in a goblin's residence. She does have her kind's affinity for potions and leather, but most of the vials look more like antidotes than poisons and the leather plates she's cured are clearly more to protect the body than accentuate any sexuality.  Considering the rest of her race, she must be something of a paladin among them - showing a degree of self-restraint almost unheard of by the common goblin."
                    +"\n\nBut, at the end of the day, she's still wet and waiting - her plump rump wiggling against the throbbing thickness resting between her cheeks.  With a crooked smile, you draw back and brace yourself at the goblin paladin's moist lips.  She's no virgin, but the way she blushes and bites her lower lip in anticipation strikes you as positively demure.  Digging your fingers into her yielding hips, you slowly drag the girl onto your [cock], the tip slipping into her viridian folds with lubricated ease.  The proud woman lets out a shuddering moan as you fill the oft-neglected slit with your pulsing girth, her inner walls clenching around you as tight as a lover's embrace.  Resting her chin on the table she's bent over, Abylon closes her eyes, a smile flickering over her face as her hands restlessly toy with her long braid."
                    +"\n\nTaking your time, you slowly feed inch after inch into your quivering companion, her body remarkably accommodating for one who normally avoids sex.  Her mother's legacy, you suppose.  When you finally bottom out inside of her, Abby picks her legs up and hooks her feet around your waist.  With her flat, unremarkable chest laying atop the small table, she begins to rock back and forth, dragging every fold of her pussy across your " + player.cockDescript(x) + ".  You match her motions, thrusting slowly at first, before gradually speeding up. Her tight interior suckles at the rod spearing her while the table beneath her rocks back and forth at the rising tempo.  Shifting one palm from her hip to the distended swell of her belly, you use your other hand to gather up a few feet of her hair and coil it around your arm, pulling her head back just enough to let you see the gathering ecstasy flushing her olive cheeks."
                    +"\n\nUnable to hold back any further, you pick up your pace, from tender strokes to urgent thrusts, pounding into the goblin paladin with deep, hard motions.  The force of your efforts sends the table toppling to its side, Abylon suspended in the air by her legs tightly wrapped around your back, your hand on her muscled abdomen, and her burnished crimson braid wrapped around your arm.  Clinging to your " + player.cockDescript(x) + " with single-minded bliss, the goblin girl doesn't even seem to notice the ruckus your love-making is causing.  Impassioned loins united by mutual delight, the cavalier rides her champion until the cold tickle of your climax rushes down your spine and through your core.  With a cry of joy, Abylon tightens the grip of her athletic legs on your [hips] and hugs you close as the first spurt of your cum lances into her belly.  Succumbing to her racial needs, the gallant orgasms from the touch of your seed, her tongue hanging from the side of her mouth as her eyes roll up in her head.  You fill her with your hot loads until the spunk gushes out of her quivering pussy and she weakly mutters a word of thanks to Scylla that you suspect she hadn't meant to say aloud."
                    +"\n\nSated, you disentangle yourself from the clinging girl and lay her into her bed, with a kiss on her sweat-slick forehead.  She absently strokes between her legs, feeling the oozing jizz dribbling out of her stuffed snatch.  Maybe, for her, this is the meaning of the holiday: not just a casual fuck, but taking the time to really savor the body of someone who's important to you.  Even if it isn't love, in the strictest sense, being close to the people who impact your life is reason enough to find joy in your days.  You wish the little paladin a good night and, blowing out her candles, you take your leave.");

            if (player.findPerk(PerkLib.SensualLover) < 0) {
                EngineCore.outputText("\n\n(<b>You've received the Sensual Lover Perk!</b>)");
                player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
            }

            player.orgasm();
            player.dynStats("sen", -3);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //{PLEASURE HER}
        //{This option doesn't require any sexual endowments whatsoever}
        function pleasureAbbyVDay():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Quite willing to comply in her desires in ways probably no one else has before, you approach Abylon from behind, wrapping your arms around her waist as you run them along her body.  She's certainly sensitive, shuddering and sighing a bit as your fingers take a dip down her abdomen and towards her female hole.  It spreads eagerly for them, and Abby sighs again.  \"<i>What's wrong?  Well, it's nice that you're preparing me, but...</i>\" you start moving your fingers faster and playing with her clit, as you kiss her neck as well, and she mewls, melting in your arms.  Her vagina is getting increasingly wetter, and you pleasure her skillfully, the little goblin writhing in your arms.  \"<i>Hah... like this... could make me cum, you dumbass!  What, you're suddenly in suck-a-lot's camp?  Where's my... UGHHH!</i>\"  That last sound makes it seem that she's lying a bit, and you prove it by starting to plunge your way about her cunt, stroking both her clit and her insides with your fingers.  She seems to resist continuously but it's definitely not easy on her...  So, rather than continue teasing, you pull away a bit, and she sighs, \"<i>Finally, let's get started,</i>\" before she feels you breathe out onto her wet goblin pussy.  \"<i>Wh...whawhat? You've got issues, come on, you can't eat me out nooaaaghghhH!</i>\""
                    +"\n\nYour fingers pumping into her and your tongue teasing her exposed labia and clit is too much for the goblin, and she shudders in her orgasm as you eagerly drink of her.  Slowly, you pull your hand away and push your lips in place of it, starting to lick and tongue-fuck the poor girl before she has a chance to come out of her high."
                    +"\n\nHer pussy gives way and drips onto your [face] and in your mouth richly, and she makes constant mewling sounds.  \"<i>C-come on!  Stop teasing me god damn it!  Are you an iii-aahhh-diot?  I'm go-oh-ohna kick ya out, ya know!?</i>\"  You don't intend to desist, and you flick her clit with your fingers again, causing her to push her bottom right into your face.  That gives you an idea, as you run your tongue from her pussy, and then, over her crack and soft buttocks, pleasuring her other hole when you're at it.  She starts panting and moaning.  \"<i>G-goblins don't use that hole!  We don't!  Don't get any crazy ideas you dumb f-fuck!</i>\" she says when you run your tongue back all the way to where it came, teasing both of her holes.  You massage her soft rump while you're at it, and by now, you're pretty sure she's rather sensitive all over, especially where her curves are developing..."
                    +"\n\nAfter a while of doing this, you're pretty sure Abylon starts approaching her second orgasm, and you intent to fill her as much as you can for the occasion.");
            //([Naga tongue]
            if (player.tongue.type == Tongue.SNAKE) EngineCore.outputText("  Your fingers make it into her pussy alongside your tongue, and the prehensile thing, longer and more flexible than a human's, ravages the insides of her pussy, tasting everywhere as Abby shakes in her orgasm.  Her pussy eagerly tries to milk both your fingers and your tongue, clenching and gripping at them as it drips her pussy juices all over your face.  Abby screams out in a loud, uninhibited orgasm at last, expressing her ecstasy.");
            //([Demon/Dragon Tongue]
            else if (player.hasLongTongue()) EngineCore.outputText("  Abylon shakes in excitement, pleasure, and fear as you extend your inhuman tongue to reach deep into the recesses of her pussy.  She cannot hold out a moment longer, her cunt gripping your inhuman muscle tightly, the hole and muscles inside quivering as you can taster her orgasmic juices with every single point of your tongue.  She screams, shudders and moans, tongue lolling out from the intense pleasure as you force your own tongue to roll around inside her and stretch her in multiple ways. Only you holding her stops Abylon from slumping forward, it seems...");
            //([Human tongue]
            else EngineCore.outputText("  Hooking your fingers at the front and back of her cunny, you plunge your tongue in and wiggle it eagerly.  Abby clamps down on all three invaders and loudly moans out, screaming to her content at last, as your face is flooded with pussy juice.");

            EngineCore.outputText("\n\nAfter a while, Abby comes down from her orgasm and you're holding her in your arms for the duration of it.  \"<i>Dammnnn... it's still twitching.  I don't know if I can...</i>\"  You shush her, telling her you intended to do that and that returning the favor is unneccessary, before kissing her on the lips and wishing her the best of luck on this new holiday, and advising that perhaps she shouldn't give up on finding that special someone..."
                    +"\n\nAbylon blushes the whole time, for once not finding the words to retort or insult you in any way, as you pat her on the head, making your way out.  \"<i>Th...thanks,</i>\" she says in a stuttering voice, before you close the door behind yourself and leave for your camp."
                    +"\n\nAll in all, you're pleased that perhaps you've managed to show a goblin that real affection does exist... not to mention get somebody off twice on a new Mareth holiday!");

            if (player.findPerk(PerkLib.PureAndLoving) < 0) {
                EngineCore.outputText("\n\n(<b>You've received the Pure and Loving Perk!</b>)");
                player.createPerk(PerkLib.PureAndLoving, 0, 0, 0, 0);
            }

            player.dynStats("lus", 80);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //([Pastie])
        function goVisitPastyVDay():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You lean over the table Pastie is no longer dancing, but rather laying, on, and, conspiratorially, ask her if she'd like to go and get something to drink."
                    +"\n\n\"<i>Well, I wouldn't mind it, but actually getting it probably won't happen... everything's more or less closed,</i>\" she responds, livening up a little at the mention of drinking.  \"<i>Although, if you do have something with you, I wouldn't mind...</i>\"");

            //Check inventory for Goblin Ale, Black Cat Beer, Bimbo Champagne; failing this, check if PC has female genitalia.
            //[BCBeer] [BimboCham][GoblinAle][vagina]
            if (player.hasItem(consumables.BIMBOCH) || player.hasItem(consumables.BC_BEER) || player.hasItem(consumables.GOB_ALE) || player.hasVagina()) {
                EngineCore.menu();
                if (player.hasItem(consumables.BIMBOCH)) EngineCore.addButton(0, "BimboCham", pastieValentineIntro, consumables.BIMBOCH.id);
                if (player.hasItem(consumables.BC_BEER)) EngineCore.addButton(1, "B.Cat Beer ", pastieValentineIntro, consumables.BC_BEER.id);
                if (player.hasItem(consumables.GOB_ALE)) EngineCore.addButton(2, "Gob. Ale", pastieValentineIntro, consumables.GOB_ALE.id);
                if (player.hasVagina()) EngineCore.addButton(3, "Pussy", pastieValentineIntro, "vag");
            }
            else {
                EngineCore.outputText("\n\nYou tell Pastie that, regrettably, you only have what she sees.  She nods and says, \"<i>Too bad.  I think I'll better get going, then.  It's been somewhat fun, and I finally get a chance to go to sleep sober and wake up without a hangover.\"</i>");
                EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
            }
        }

        function pastieValentineIntro(choice:String = ""):void {
            EngineCore.clearOutput();
            if (choice == "vag") {
                EngineCore.outputText("You tell Pastie that indeed, she could get her fix, as you have something you're sure every fairy likes to drink not far away... between your legs.  \"<i>T-that's an... unusual drink proposition...  Umm, and I'm more susceptible to girls than most fairies, so... Ohhh, who am I kidding, that sounds pretty good right now.</i>\""
                        +"\n\nFollowing you into a back alley, you prepare to get yourself naked and let the fairy get her fix.");
                //((Move straight to pussy scene)) )
                EngineCore.menu();
                EngineCore.addButton(0, "Next", goForAPushayDivePasty);
            }
            //({Any other drink}. 
            else {
                var itype:ItemType = ItemType.lookupItem(choice);
                player.consumeItem(itype, 1);
                EngineCore.outputText("You present the drink to Pastie and she flashes you a grin as she flies up and away, leading you into an alley.  \"<i>Well, lemme at it!  A drink sure as hell sounds good right now and none of this seems like it'd be really bad.</i>\"");
                EngineCore.menu();
                EngineCore.addButton(0, "Next", Utils.curry(valentineDrinkPastie, itype));
            }
        }

        //PASTIE EVENT
        function valentineDrinkPastie(itype:ItemType):void {
            EngineCore.clearOutput();
            EngineCore.outputText("One you're away from any prying eyes, Pastie turns to you and rubs her little fairy hands together, apparently barely able to hold her enthusiasm to finally get a bit drunk.  You're afraid it may not end at one drink, either, and for a moment, wonder about whether this is all right or not...");
            //Corruption 0-20] 
            if (player.cor < 33) EngineCore.outputText("  It probably isn't.");
            //[Corruption 21-75]
            else if (player.cor < 75) EngineCore.outputText("  You guess as long as she's fine afterwards, it should be okay.");
            //[Corruption 76-100]
            else EngineCore.outputText("  As long as she's in the mood to drink more than just the alcohol afterwards, you don't really care.");

            EngineCore.outputText("\n\n\"<i>Now, now!  Gimme, gimme!</i>\"  Well, apparently, the choice is out of your hands anyways.  You uncork the bottle and point the opening at Pastie, who is quick to dive into it, drinking her fill and causing you to spill some all over her body.  It's a bit fun to watch, to be honest, as a little fairy tries to drink out of a bottle larger than her."
                    +"\n\nWith a burp, Pastie removes herself from the bottle's tip and rubs her belly.  \"<i>Tasteeeehhh!!!</i>\"");

            valentineDayGetPastieDrink(itype);
        }

        function valentineDayGetPastieDrink(itype:ItemType):void {
            //{Black Cat Beer}
            if (itype == consumables.BC_BEER) {
                EngineCore.outputText("\n\nPastie suddenly starts running her hands along her body, licking her lips as she does so. \"<i>Odd... Imma bit of a horny drunk, yah know, but thish ish... overkill...</i>\"  The little fairy-drunkard complains as she reaches between her legs and starts fingering herself, while rubbing a nipple.  \"<i>Daaaamnnnn, I'm sooo horny! I need more... to, uhhh, to driiink!</i>\""
                        +"\n\nWell, that was an expected effect, to be honest.  You guess you could also comply with her request, and horny as she is, she'd probably degrade herself with whatever sex bits you want her to... although, too big of a member can definitely be a problem for her.");
                //[RubDick][PussyDive]
                //{Rub Dick option is present if a character has a member underneath 28 cock area. Pussy Dive is obviously present if a character has a pussy of any kind.}
            }
            //{Bimbo Champagne}
            else if (itype == consumables.BIMBOCH) {
                EngineCore.outputText("\n\nPastie giggles as her body starts to slowly show the effects of the liquid she just drank.  \"<i>Hihihi... I feel kinda funny,</i>\" she says, and you start to see the changes the champagne is starting to have on her body.  Her hair starts turning blonde, and her position in mid-air changes somewhat... almost as if she was imitating standing on \"<i>fuck-me</i>\" pumps, and, slowly, her little cupid dress stretches, as you become aware that her body is starting to become curvier, especially in the chest area.  \"<i>Hahaha... it's, like, I'm hitting three puberties at once!  Ummm... pu... puber, ah, nevermind.  Look, look!  It's gonna rip!</i>\" The seams in the little dress indeed pop, exposing a significant amount of the little girl's cleavage, now very significant.  True, compared to your body size her breasts are still nothing, but on her little body they're very prominent.  She even seems to have trouble flying from the added mass!  Her hips gained the slightest bit of curve, too, and Pastie's hair is now completely blonde."
                        +"\n\n\"<i>Uhh, like... baby, you know, the usual drink gets me hot, and this one is as special as my new titties!  Would you mind helping me out?</i>\""
                        +"\n\nYou wonder if the sluttification has passed to everywhere on her body... there's a good chance a small member that's normally impossible for her entire body to fit may actually slip inside her now.  And you doubt she'd turn away a chance to get some cum or pussy juice, too.");

                //[Fuck][RubDick][PussyDive]
                //{Fuck is only present if a character has a cock under 8 cock area, Rub Dick option is present if a character has a member underneath 28 cock area. Pussy Dive is obviously present if a character has a pussy of any kind.}
            }
            //{Goblin Ale}
            else if (itype == consumables.GOB_ALE) {
                EngineCore.outputText("\n\n\"<i>Huuuh? Feels weird!</i>\" Pastie says, as she runs her hands over her body, and then slips a finger into her little pussy... four fingers... her hand, and then, reaches halfway up to her elbow before she cannot bend any more in her drunken state.  \"<i>Thissh... got me more horny than usual, and I feel so... stretchy, hehehe!</i>\""
                        +"\n\nHer body's still totally diminutive, but you guess someone with a small enough endowment might actually be able to take advantage of her now.  You doubt she'd refuse a little cum or pussy juice, either.");
                //[Fuck][RubDick][PussyDive]
                //{Fuck is only present if a character has a cock under 8 cock area, Rub Dick option is present if a character has a member underneath 28 cock area. Pussy Dive is obviously present if a character has a pussy of any kind.}
            }
            EngineCore.menu();
            if (player.cockThatFits(8) >= 0) EngineCore.addButton(0, "Fuck", fuckPastieForVDay);
            if (player.hasCock()) EngineCore.addButton(1, "RubOnDick", rubPastieOnYourWangDawg);
            if (player.hasVagina()) EngineCore.addButton(2, "Go In Pussy", goForAPushayDivePasty);
        }


        //[Fuck]
        function fuckPastieForVDay():void {
            EngineCore.clearOutput();
            var x:int = player.smallestCockIndex();
            EngineCore.outputText("With a semi-sadistic grin, you watch Pastie saunter towards you, clearly allured by the scent of your genitals.  You stroke your " + player.cockDescript(x) + ", quickly bringing it to an erection, imagining how tight even this little thing will feel inside Pastie's small, but now unnaturaly stretchable body."
                    +"\n\nBeing able to resist no longer, you grab her little bum and direct her towards your cock, not really hearing whether she's cheering, complaining, or asking you to stop; honestly, you could care less when you press your " + player.cockDescript(x) + " against the entrance to her diminutive vagina and start pushing."
                    +"\n\nAfter a while of fruitless pressing against her little legs, bum, and clit, Pastie finally gives way. Even your " + player.cockHead(x) + " is enough to stretch her already, but there's not much else to do now other than pushing it in deeper."
                    +"\n\nThe tightness of Pastie's confines is amazing, even as her body balloons out to more than twice its usual thickness, stretching and quivering around you, trying to either accommodate your " + player.cockDescript(x) + " or push it out completely.  It almost borders on painful, but also feels like a divine cum milking machine meant to draw your seed out of you.  You gently press Pastie down and pull her up your erection, essentially using her body as a masturbation aid, moaning all the while..."
                    +"\n\nThat tight snatch is definitely made to make your cock spurt, and it won't be long, but for now you're enjoying the confines and twitches of a body stretched to beyond its limits only so it could accommodate your cock and cum, licking your lips at the thought.  Yes, you'll definitely give that little fairy bitch a good \"<i>shot</i>\"."
                    +"\n\nNot really caring about whether it's premature or whether she's already fucked out of her mind, you groan and dump the contents of your [balls] into Pastie's overstretched body, feeling her incredible tightness first block it, then give way, then start pulsing and tugging on you as you fill her.");
            //if (cumNormal = true)
            if (player.cumQ() < 250) EngineCore.outputText("  Even your pretty average load is probably a massive amount for Pastie to take inside herself, and you can see it bloating her even further than your cock would do on its own as you slowly start to pull her off it.  Pastie moans and thrashes as you do, but soon, she's off, and your load drips from her pussy and onto the ground.  She seems slightly out of it.");
            //[if (cumMedium = true)
            else if (player.cumQ() < 500) EngineCore.outputText("  Your cumshots are normally pretty big, but for Pastie, it's like a flood.  Her tight confines prompt you to shoot out even more, milking you and tugging on your dick as you pump load after load into her little body.  Pastie screams out, moans, thrashes and pants as she's bloated further and further, ballooning out from the sheer amount of cum and starting to slide off your dick, but you keep her there until she starts twitching, her tongue lolling and her apparently losing consciousness.  Afterwards, you pull her off her dick, and your load drips from her pussy and onto the ground, her little body more like a ball now. She's more or less unconscious...");
            //[if (cumHigh = true)
            else if (player.cumQ() < 1000) EngineCore.outputText("  Pastie yells out at the first wave of your cum, and her tongue lolls out as you fill her up.  Her pussy clearly isn't meant to take that much and soon, she's little more than a balloon of your sperm, filled to the brim and beyond, sliding off your cock and onto the ground.  You tug on your member a few times to add a cum shower onto the effect, wondering how she'll react, before noticing she's unconscious.  Damn, that pussy clenches TIGHT and milks well.");
            //[if (cumVeryHigh = true)
            else if (player.cumQ() < 2000) EngineCore.outputText("  Pastie yells out at the first wave of your cum, and her tongue lolls out as you fill her up.  Her pussy tugs at you and you comply, filling her up to the brim, making her into a balloon of your cum rather than a little fairy, stretching her body to its absolute limits only gained thanks to her stretchable cunt.  She clearly isn't meant to take that much and yet, you pump equally big loads into her.  Pastie can't keep being on your cock with that pressure and is shot out, rolling onto the ground a few meters away as the rest of your load splashes onto the ground.  You look at her, and notice she's unconscious.");
            //[if (cumExtreme = true)
            else {
                EngineCore.outputText("  Pastie's mind apparently breaks from the first two ropes of your cum, pumping her full and stretching her as she whimpers, yells, her eyes rolling up to show her whites.  She's drooling by the time you've stretched her to her limits, becoming a sphere rather than a humanoid, filled to the brim with your cum, and that's just a small part of it.  The pressure is already too much for her supreme-milking, extra stretchy but even more extra tight pussy and she pops off your cock.  Your load follows her and splashes all over the place, shooting her further, onto the nearby wall that is already painted with ropes of your cum.  You do the same to the rest of the wall and the ground in front of you, tugging at your member as you almost lose sight of the fairy in the sea of white.  When you fish her out, she's unconscious.");
            }
            EngineCore.outputText("\n\nHaving gotten off so well, you pat the little fairy on the head and leave her on a nearby windowsill so no animal will harm her when she sleeps - and so nobody steps on her by accident.  She's out of it, but given that she's made such a good cumdump, she deserves a little safety in return."
                    +"\n\nYou grin and lick your lips as you return to camp.");

            if (player.findPerk(PerkLib.OneTrackMind) < 0) {
                EngineCore.outputText("\n\n(<b>You have gained the One Track Mind perk!</b>)");
                player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
            }
            player.orgasm();
            player.dynStats("sen", -2);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //[RubDick]
        function rubPastieOnYourWangDawg():void {
            EngineCore.clearOutput();
            //Pastie rubs her entire body against the PC's dick, allowing them to cum quicker and give her a cum bath. Too much cum causes her to go ahegao, scream \"<i>itsh a sheeeaaa of driiinkshhh!</i>\", and forces the PC to fish her out of the cum before she drowns.
            //Pastie Valentine option
            //(Just a thought, but the size requirement for this scene should be removed, as it works with just about any size dick)
            //[Rub on Dick]
            EngineCore.outputText("You watch Pastie with some amusement as she tries to saunter over towards you, swishing her skirt in a sassy strut. Her diminutive form notwithstanding, the allure of her movements are somewhat sabotaged by the lush's lack of coordination.  Though slight enough to be unnoticeable by anyone else, the small fairy seems to be drawn by your scent, her uncertain flight tracing a dizzying path toward you.  Somehow, she manages to trip over herself in mid-air, her delicate crystal heels flying wide as she kicks out with a yelp.  Flapping her gossamer wings wildly as she spins downward, the sprite lets out a frustrated \"<i>ack!</i>\" and faceplants into your groin. Making the best of the situation, she wriggles onto her side and puts on her best 'come hither' look."
                    +"\n\nShaking your head with a smile, you gently pick the drunken fairy up and loosen your [armor], allowing your [cock biggest] to breathe free. She giggles in glee at the sight, wriggling to try to get free, but you keep her firmly in hand for the moment, instead stroking yourself to full erection.  \"<i>Aw, come on, ya tease,</i>\" she whines, sulking as she watches your shaft swell.  Once you're satisfied with your own firmness, you transfer Pastie to your dominate hand and take a moment to appreciate her body. The small blond is actually quite buxom, with curves that'd be the envy of any goblin, though writ small.  Her addiction to milk has apparently spurred mammary development in the pixie far beyond the normal proportions of her kind, while her drinking has put a fair amount of weight in her hips and rump.  With careful fingertips, you pull the dress from her slender shoulders and leave the fairy bare and hiccupping."
                    +"\n\nWith a grin, you bring the hand holding Pastie to the base of your [cock biggest] and wrap your fingers around the shaft, pinning the girl to your throbbing pole.  With slow, steady motions, you lift her up and down in long strokes, rubbing her warm soft body along your shaft.  She protests, drunkenly, insisting that she's more than capable of handling you without the help, but you raise her to the crest of your cockhead and press your thumb against the back of her head, pushing the noisy sylph's open mouth against your urethra just as a dollop of pre-cum bubbles out.  Catching the drug-like spunk full-on, she sputters, swallowing and blinking away the miniature facial you've given her.  The effects are immediate, the alcohol-lubricated fairy instantly pliant to your renewed caresses.  You can finally appreciate why she's in addiction counseling: a single drop was enough to leave her reeling - and of pre no less!  She's even more sensitive than most of her race, which would explain why she dulls the sensations with liquor."
                    +"\n\nFlushed and panting, Pastie gives up trying to control your pace and goes along with it, wrapping her arms and legs around your [cock biggest] as best she can.  Grinding her petite pussy against the bumps and swells of your engorged length, you're delighted to find that the little lush's cunny is drooling a seemingly endless stream of warm, clear fem-cum.  The lubrication saturates your rod in no time and your pumping grip quickly coats the fairy in her own honey, leaving her glistening as if freshly oiled.  You pull her once more to the sensitive tip of your cockhead, though this time she leans in of her own volition, kissing your peak with ditzy relish, even going so far as to slip her tiny, wet tongue into your urethra.  Satisfied with the renewed, crystal flow gushing from between her legs, you rub her along your shaft with even harder strokes, feeling every curve of her wriggling form."
                    +"\n\nPolishing your mast with the amorous drunk has been fun, but you think you've teased her enough. Raising the tempo of your fey massage, you can feel your release building up just behind your [cock biggest] in a heavy pressure that floods your loins with urgency.  Gritting your teeth, you wrap your other hand around the first and bounce her faster and faster along your meat.  Eager caresses become frantic friction as Pastie feels your flesh swelling against her.");
            if (player.balls > 0) EngineCore.outputText("  Your [balls] lurch, [skin] contracting as liquid passion rises within you.");
            EngineCore.outputText("  Your [ass] clenches in anticipation, heralding your climax, so you slide the fairy up your shaft, pulling free from the grip of her arms and legs, holding the confused girl directly in front of your [cocks] while loosing your grasp to bear her entire, curvaceous form to the open air.  With a shuddering gasp, you erupt your intoxicating cream directly into the fey girl, your orgasm");
            //low cum production:
            if (player.cumQ() < 250) EngineCore.outputText(" easily drenching the tiny fairy, in plump pearls up and down her naked flesh.");
            else if (player.cumQ() < 750) EngineCore.outputText(" leaving her and the arm you're holding her in dripping with a sticky alabaster lacquer.");
            //high cum production:
            else EngineCore.outputText(" almost blasting her right out of your hand in the torrent of white that spills forth from your mighty member.");
            EngineCore.outputText("  The spunk-plastered pixie shudders in your palm, overwhelmed by the spoo drenching her.  She masturbates, feverishly, climaxing in seconds and then again a moment later.  You watch her for a few minutes, the batter-basted bimbo jilling herself silly from the heightened sensitivity your spoo shower has given her."
                    +"\n\nHaving gotten yourself off, and with the sprite showing no sign of slowing down in her insensible self-love, you pat the little fairy on the head and leave her on a nearby windowsill.  Eventually, you reason, she'll run out of steam and be so exhausted from the effort that she'll likely pass out.  You wouldn't want a stray animal—or footfall!—to harm the tanked girl while she sleeps.  She's too out of it to appreciate the compliment, but you thank her all the same for being such a wonderful cum-canvas."
                    +"\n\nYou grin and whistle a spritely tune as you return to camp.");
            // (You have gained the One Track Mind perk!)
            if (player.findPerk(PerkLib.OneTrackMind) < 0) {
                EngineCore.outputText("\n\n(<b>You have gained the One Track Mind perk!</b>)");
                player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
            }
            player.orgasm();
            player.dynStats("sen", -2);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        //[Pussy Dive]
        function goForAPushayDivePasty():void {
            EngineCore.clearOutput();
            EngineCore.outputText("With a grin and a lick of your lips, you shed your [armor] and spread your legs for the happily drunk fairy, showing her prize: your [vagina] and the [clit] that accompanies it.  It doesn't take Pastie even a few moments to fly towards you and then aim for that [vagina] in a small slalom in the air.  The lips of your gash feel the touch of little hands and feet, and you shudder in anticipation.  Pastie takes long licks all over your vagina and rubs her entire little body around, before finally starting to slip one or another of her limbs experimentally into your [vagina].  It feels amazing to have such a pretty little thing moving around in there, and soon, your [clit] is shown some love as well as Pastie rubs herself all over it before stuffing her face into your wet pussy."
                    +"\n\nYou raise a hand to your [chest], moaning out loud, ");
            if (player.hasCock()) EngineCore.outputText("your other hand moving downwards to tug on [oneCock], ");
            EngineCore.outputText("anticipating the incoming wriggling inside your pussy and an orgasm you'll have with an entire fairy buried inside you."
                    +"\n\nPastie doesn't disappoint and is soon pushing herself all the way to her hips inside you to get as good of a taste as she can. It does feel amazing when her little hands press against your inner walls, spreading you wide, and your [vagina] starts quivering and clenching around her in anticipation.");
            //[if (hascock = true)
            if (player.hasCock()) EngineCore.outputText("  All the while, you continue to jerk off [eachCock], preparing yourself for an orgasm on both sides.");
            EngineCore.outputText("  She finally takes a full dive inside, and you moan out in pleasure, feeling her little body roll and explore in there, her tongue tasting every bit of fluid she can from what's moisturizing your inner passage."
                    +"\n\nAfter a while, you're moaning out loud, rapidly approaching orgasm, when Pastie, struggling against the clenching and unclenching walls of your [vagina], manages to get her head and hands out of you.  She kisses and wraps her hand around your [clit], stimulating you further as you scream out, her lower body still penetrating you and wiggling around."
                    +"\n\nYou can take this no more and you shudder in an orgasm, painting Pastie's little body with more of your femcum.  She giggles at the sudden intensity of your contractions, and starts trying to slip out slowly.");
            //[if (hascock = true)]
            if (player.hasCock()) EngineCore.outputText("  At the same time, your cock deposits its own load onto the ground as your hermaphrodite genitals achieve a simultaneous orgasm.");
            //[if (isSquirter = true)
            if (player.wetness() >= 4) EngineCore.outputText("  She doesn't have much to say in the matter when your female ejaculation truly shoots in, though, sending her rolling out of your [vagina] and onto the ground.");

            EngineCore.outputText("\n\nPastie giggles as she flies onto the nearby wall, heavily, completely soaked in your secretions.  As you look to her, she answers.  \"<i>I'm fine!  It's all okay.  Justtt.... too much to drink.  Feels gooood, though, hehe!  We should try that again.</i>\"  You nod and smile at her, gently wiping her with a finger and letting her taste your pussy juice off it before going back to camp."
                    +"\n\nTrue, this might not have been the most romantic sex act, but it was certainly enjoyable for the two of you.");

            if (player.findPerk(PerkLib.SensualLover) < 0) {
                EngineCore.outputText("\n\n(<b>You have gained the Sensual Lover perk!</b>)");
                player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
            }

            player.orgasm();
            player.dynStats("sen", -2);
            EngineCore.doNext(SceneLib.camp.returnToCampUseTwoHours);
        }

        /*END!

        1) Hanging out with Scylla's Addiction Group. Requirements :
        A) Meeting Scylla's Addiction Group (Scylla, Abylon, Patsie) before.
        B) One has to have a cock to play with Scylla or Abylon, but not neccessarily Patsie. One has to bring either Black Cat Beer, Bimbo Champagne, or Goblin Ale to play with Patsie.
        C) The player meets Scylla's Addiction Group and they hang out as Scylla goes about establishing the holiday in Tel'Adre.
        D) Once this is over, player can choose to stay and spend more time with Patsie, Scylla, or Abylon, or leave.
        E) Staying with Patsie requires one of the alcoholic items. If the player has none, re-direct to Abylon, Scylla, or Leave.
        F) The encounter can grant one of three PerkLib. Scylla allows all perks, Patsie allows the Tainted or Corrupted perk, and Abylon allows the Pure or Tainted perk.
        G) Picking Scylla leads to walking around Tel'Adre before watching sunset on the walls. The PC and Scylla are allowed to do this due to their reputation.
        G1) The player staying with Scylla can choose to : 
        - Cuddle and watch, leads to next day or loss of a few hours. Gives the Pure and Loving perk, plus stat modifications (lowers Corruption and Libido, raises Lust)
        - Make out with all of Scylla's nipples. (Heightens Sensitivity, Toughness and Lust, lowers Libido, gives the Sensual Lover perk)
        - Feed Scylla (Lowers Lust, increases Corruption and Libido, gives the One Track Mind perk)
        
        G2) Player going with Abylon gets to learn a bit more about her and later can help with her Sex Addiction. They can finally fuck Abylon or help her masturbate.
        - Fucking Abylon (tenderly) gives the Sensual Lover perk
        - Masturbating Abylon gives the Pure and Loving perk
        G3) Players going with Patsie get her drunk, and if it's Goblin Ale, they may gain a goblin transformation and unlock the penetration of her.
        - If they have a vagina, they can allow Patsie to go there. Unlocks the Sensual Lover perk.
        - If they have a cock  of a very low area (up to 9 I guess), they can penetrate Pastie if she drunk the Goblin Ale. This unlocks the One Track Mind perk.

        And in Scylla's Cuddle scene, you just share a simple kiss before cuddling. In the makeout scene, you first kiss all of her lips before she notices you're sporting a boner, then she slowly rubs one out of you as you keep making out with her lips, until you're finally on your back as she coaxes you almost to the point of cumming and then sticking you in her appropriate lipple, having you cum.
        
        */
    }

    public static function isHolidays():Boolean {
        return (date.date >= 25 && date.month == 11 || flags[kFLAGS.ITS_EVERY_DAY] > 0);
    }

    public static function xmasBitchEncounter():void {
        EngineCore.clearOutput();
        CoC.instance.spriteSelect(9);
        EngineCore.outputText("Your sleep is disturbed by something repeatedly smacking into your side.  Groggily at first, you grumble and throw back your blanket.  Then you remember where you are, and snap to full wakefulness.  You launch onto your feet, bring up your fists, and stare bewildered at the sight in front of you.\n\n"
                +"Standing there, innocent as can be, ");
        if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] == 0) EngineCore.outputText("is an elf.  She can't be more than four and a half feet tall, and though she has fairly womanly hips, her chest is nothing to speak of.  Her clothing is strange – a red two piece lined with some kind of white fur.  She has typically pointed ears, blond hair, and a red fur-lined cap topped with a white puffball. She's holding a large box in front of her and looking at you expectantly as you stare, dumbfounded.\n\n");
        else EngineCore.outputText("is the same elf you met last year.  She can't be more than four and a half feet tall, and though she has fairly womanly hips, her chest is nothing to speak of.  Her clothing is strange – a red two piece lined with some kind of white fur.  She has typically pointed ears, blond hair, and a red fur-lined cap topped with a white puffball. She's holding a large box in front of her and looking at you expectantly as you stare, dumbfounded.\n\n");

        EngineCore.outputText("The elf says, \"<i>Hiya [name]!  I brought you a");
        if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] > 0) EngineCore.outputText("nother");
        EngineCore.outputText(" present, straight from the big man himself!</i>\"\n\n");

        if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] > 0) {
            EngineCore.outputText("Confused by her sudden re-appearance, you dumbly ask if you'll be getting the same thing as last year.\n\n"
                    +"She giggles, \"<i>Oh silly, that would spoil the surprise, wouldn't it?  We've got EVERYONE on our list, even ");
            if (flags[kFLAGS.KELT_BREAK_LEVEL] < 4) EngineCore.outputText("Kelt, though he's getting coal AGAIN");
            else EngineCore.outputText("Kelly, though I think she's getting another big fat dildo");
            EngineCore.outputText(".  You'll get what you're supposed to get!</i>\"\n\n");
        }
        else {
            EngineCore.outputText("Confused by her appearance and the fact that she already knows you by name, you dumbly ask how she can possibly know who you are.\n\n"
                    +"She giggles, \"<i>Oh silly, don't you know what time of year it is?  We've got EVERYONE on our list, even ");
            if (flags[kFLAGS.KELT_BREAK_LEVEL] < 4) EngineCore.outputText("Kelt, though he's getting coal this year");
            else EngineCore.outputText("Kelly, though I think she's getting a big fat dildo this year");
            EngineCore.outputText(".</i>\"\n\n");
        }
        EngineCore.awardAchievement("Naughty or Nice", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_I);
        EngineCore.outputText("You wonder out loud, \"<i>So this... present is mine?</i>\"\n\n");
        if (player.cor >= 90 || JojoScene.monk >= 5 || player.hasStatusEffect(StatusEffects.Exgartuan) || SceneLib.amilyScene.amilyCorrupt() || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[kFLAGS.NIAMH_STATUS] > 0) {
            EngineCore.outputText("She nods, bouncing up and down in excitement and flushing slightly, \"<i>Yup, just tear the lid off and get your gift!</i>\"\n\n");
            if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] > 0) EngineCore.outputText("Here we go again...\n\n");
            //[Open Present] [Unwrap Elf] [Decline]
            EngineCore.simpleChoices("OpenPresent", openXmasPresent, "", null, "Decline", declineXmasPresent, "", null, "", null);
            return;
        }
        if (player.gender == 0) {
            EngineCore.outputText("She nods, bouncing up in down in excitement, \"<i>Yup!  Just open it up!  Are you ready?</i>\"\n\n");
            EngineCore.simpleChoices("OpenPresent", openXmasPresent, "", null, "Decline", declineXmasPresent, "", null, "", null);
            return;
        }
        EngineCore.outputText("She nods, bouncing up in down in excitement, \"<i>Yup!  You can unwrap it or unwrap me.  What'll it be?</i>\"\n\n");
        //[Open Present] [Unwrap Elf] [Decline]
        EngineCore.simpleChoices("OpenPresent", openXmasPresent, "Unwrap Elf", unwrapElfyPresent, "Decline", declineXmasPresent, "", null, "", null);

        //[Decline]
        function declineXmasPresent():void {
            CoC.instance.spriteSelect(9);
            EngineCore.clearOutput();
            EngineCore.outputText("You shake your head 'no', and inform the elf that you'll have nothing to do with her 'gifts' or 'surprises'.  She looks on the verge of tears as she whines, \"<i>I'm going to get reamed for this!</i>\"\n\n"
                    +"Before you can react, she sprints off into the darkness.");
            flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
            EngineCore.doNext(EventParser.playerMenu);
        }

        //[Open Present]
        function openXmasPresent():void {
            CoC.instance.spriteSelect(9);
            EngineCore.clearOutput();
            EngineCore.outputText("You easily rip through the ribbons holding the box together and pull off the top.   You gasp in ");
            if (player.cor >= 90 || JojoScene.monk >= 5 || player.hasStatusEffect(StatusEffects.Exgartuan) || SceneLib.amilyScene.amilyCorrupt() || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[kFLAGS.NIAMH_STATUS] > 0) {
                //[Bad Present]
                EngineCore.outputText("shock at the box's contents – a nine inch cock with damn near a dozen buzzing, elliptical devices taped to it.  A pair of coal lumps rattles around underneath it, positioned as if they were the dick's testicles.\n\n"
                        +"Before you can utter a single word of confusion or protest, the elf moans and the cock erupts, spurting a rope of cum into your hair.  The next blast takes you across the nose, then on your lips, then your chin, and finally onto your [allbreasts].  Shocked and dripping, you stand dumbfounded as the elf plants a kiss on your lips, tears off the box, and runs away with her cock flopping and buzzing in time with each step.  There's no way to catch her in this darkness.\n\n"
                        +"The empty 'present' is on the ground with the coal still inside.  You wonder if the coal has any special effect. Everything else in this place does.  In the distance you can hear sleigh bells, and you know it's going to be hard to sleep with all that racket on top of the threat of more intruders...\n\n");
                SceneLib.inventory.takeItem(consumables.COAL___, EventParser.playerMenu);
                flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
            }
            else if (player.cor <= 33) {
                //Great present!
                EngineCore.outputText("surprise at the box's contents - there's a careful arranged set of equipment here, made from woven spider-silk!  Somebody must think you're pretty good.\n\n");
                if (Utils.rand(2) == 0) {
                    SceneLib.inventory.takeItem(CoC.instance.armors.SS_ROBE, EventParser.playerMenu);
                } else SceneLib.inventory.takeItem(CoC.instance.armors.SSARMOR, EventParser.playerMenu);
                flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
            }
            else if (player.cor < 60) {
                //[Good present]
                EngineCore.outputText("surprise at the box's contents – there's a vial labeled gro+.  It looks like it's going to be a 'big' Christmas this year...\n\n");
                SceneLib.inventory.takeItem(consumables.GROPLUS, EventParser.playerMenu);
                flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
            }
            else {
                //[Mediocre Present]
                EngineCore.outputText("surprise at the box's contents – there is a single vial of succubi's delight packed inside.  It's going to be a white Christmas after all...\n\n");
                SceneLib.inventory.takeItem(consumables.SDELITE, EventParser.playerMenu);
                flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
            }
        }

        //[Unwrap the elf]
        function unwrapElfyPresent():void {
            CoC.instance.spriteSelect(9);
            EngineCore.clearOutput();
            EngineCore.outputText("The elf tosses the present to the side and saunters up to you, her hips swaying sensually.  She ");
            if (player.tallness > 60) EngineCore.outputText("reaches up and presses herself against you seductively, caressing your body.");
            else EngineCore.outputText("cuddles up alongside, happy to have someone of similar stature to seduce.");
            EngineCore.outputText("  You find yourself getting more and more aroused as she teases you, sliding around your body as she feels every nook and cranny of your form.  She teases, \"<i>If you don't unwrap a present soon enough I hear it gets taken away, and we don't want that.</i>\"\n\n"
                    +"You ");
            if (player.spe < 25) EngineCore.outputText("clumsily ");
            else EngineCore.outputText("easily ");
            EngineCore.outputText("reach around and grab hold of her fur-lined tube-top, yanking it up over her head in a smooth motion.  Her now exposed breasts are small but well formed.  Her skin is very pale, practically white, and it provides a stark contrast for her hard, cherry-red nipples.   She wiggles happily when you grab her short red skirt and undo the clasp, yanking it off to fully expose her.  The elf's sex is rosy pink in color, and her outer lips are puffy with arousal.   Her slit is completely hairless, and an intricate tattoo of a snowflake sits just above it.  You glance up at her hat and down at her stocking-clad legs and think, 'those can stay.'\n\n");

            if (player.gender == 1) dickXmasElfGo();
            else if (player.gender == 2) vagFuckXmasElf();
            else {
                EngineCore.outputText("Which part will you ravish her with?\n\n");
                EngineCore.menu();
                EngineCore.addButton(0, "Male", futaDickXmasElfClr);
                EngineCore.addButton(1, "Female", futaVagXmasElfClr);
            }
        }

        function futaDickXmasElfClr():void {
            EngineCore.clearOutput();
            dickXmasElfGo();
        }

        function futaVagXmasElfClr():void {
            EngineCore.clearOutput();
            vagFuckXmasElf();
        }


        function dickXmasElfGo():void {
            //(Dickfuck)
            if (player.cockArea(0) < 80) {
                EngineCore.outputText("She pushes you down onto your bedroll and whispers, \"<i>Time to enjoy your present.</i>\"\n\n"
                        +"She mounts you without pretense, straddling and inserting your [cock] in one smooth motion.  The sudden change from cool, night air to hot, tight pussy sends shockwaves of pleasure into your skull.  You master yourself before your eyes roll the whole way back and close your mouth before you start drooling.   Her vise-like tightness is inhuman, but somehow not so tight as to be uncomfortable.   The internal muscles clench and squeeze around you with an uncommon degree of control.  She's so hot, wet, and tight that you shiver.  You start rocking underneath her, giving in completely to the pleasure of her hole.\n\n"
                        +"You grunt, pistoning into her over and over.  She clears her throat as she's bouncing atop of you, and you look back up, suddenly reminded that there's more to the world than the cunt milking your [cock].  The elf explains, \"<i>Don't be ashamed.  We elves have magical cunts.  Once something is inside it'll feel so good that it never wants to leave.  Judging from the look on your face I don't think you ever want to leave, do you?  I'm the best present you've ever had, aren't I?  Go ahead, cum for me, show me what a great gift I am.</i>\"\n\n"
                        +"She's absolutely right – there's some indescribably pleasurable thing about the heat radiating into your dick that makes it feel like it's about to melt and pass into heaven.  The elf giggles and the vibrations of her laugh somehow radiate into you, and it's just too much.  You cum for your present, submitting to her pleasure as your spooge boils up into her.   It squelches wetly as it pumps into her, sounding absolutely perverse.");
                if (player.cumQ() >= 250) EngineCore.outputText("  The spunk quickly fills her womb and flows back out her entrance, frothing and bubbling as it drips over your " + Appearance.hipDescription(player) + ".  ");
                if (player.cumQ() >= 1000) EngineCore.outputText("  It begins to splatter everywhere as you pour out more and more, the elf looking on with amusement as her cunt turns into a cum-spraying fountain.  ");
                EngineCore.outputText("\n\n"
                        +"Once your orgasm ends the elf begins gyrating her hips again, her pussy frothing and dripping a mixed batch of creamy cum.   You don't go soft.  If anything you get even harder and more sensitive.  Brain blasting pressure squeezes up your rod from the elf's cunt as she starts bouncing again, fucking you in earnest, \"<i>I told you my cunt was magical.  You'll never go soft inside me – your cum fuels my magic and makes you feel even better.</i>\"\n\n"
                        +"Aside from your [cock], your body has gone completely numb from the waist down.  You glance down and see your [legs] twitching and convulsing under the elf's assault.   She's so hot inside, it's like her pussy's candy-coated in liquid pleasure.   You fuck her harder and harder, squeezing her hips tightly and roughly fucking her magical pussy.   Somehow you're on the edge again, about to unload.  You start counting in your head, trying to resist another orgasm.  You know if you do you'll never be able stop.  You doubt you'll even be able to think.\n\n"
                        +"Your effort at holding out totally fails – you start counting in time with each thrust, tying the numbers into the feel of the velvet cock-sleeve as it massages your [cock].   The elf smiles condescendingly and taunts, \"<i>I can see you've already lost the ability to resist the pleasure.  Just give in, and enjoy the night.  I'll be riding you 'til morning.</i>\"\n\n"
                        +"It's too hot, oh gods it's too hot.  You cum again, splattering her womb with more seed.  The elf's skin flushes as you pump more into her, squirting more and more into her overfull entrance.  Miraculously, you cum just as much as before, ");
                if (player.cumQ() >= 250) EngineCore.outputText("dumping out more and more waves of jizm until you're lying in a deep puddle of it, ");
                EngineCore.outputText("and somehow the orgasm lasts on even after you've emptied.   Your eyes roll back for a moment as you nearly lose consciousness.\n\n"
                        +"You snap out of it and the elf is smirking down at you, stationary.  You feel totally numb – your [cock] has all of your sensation, all of your sense of touch.   On their own, your " + Appearance.hipDescription(player) + " continually rise and fall, pumping into her with noisy explosions of pleasure that leave you gasping and writhing.  Every time you start to think something, the vise-like tunnel slides down you and squeezes your [cock], interrupting any attempt at thought.  You give up on thinking and start drooling all over yourself, your world fading into a heaven of constant pleasure and repeated orgasms.\n\n"
                        +"The elf fucks you relentlessly for hours, forcing you to cum over and over.  Somehow you never go dry, and each time feels better than the last.  Your bedroll is soaked with cum, your body is exhausted, and the elf FINALLY cums with a high-pitched cry of orgasmic pleasure.  Her body quakes, and you cum again, squirting messily inside her again.  The vise of pleasure on you quivers and squeezes, growing hotter by the second as the elf's orgasm drags on and on, milking you of every drop and setting you in a feedback loop of infinite pleasure.  You black out.");
            }
            else {
                //(TOO BIG)
                EngineCore.outputText("She pushes you down onto your bedroll and whispers, \"<i>Time to enjoy your present.</i>\"\n\n"
                        +"The elf grabs ahold of your [cock] with both hands and cuddles against it as if it were a person, planting kisses along the edge of its [cockhead].  She laughs, \"<i>Oh my, you're so big!  I almost wish I was big enough to take this bad boy.  Believe me, you haven't lived until you've been milked by an elf's cunt.</i>\"\n\n"
                        +"She wraps her arms around it and begins licking it, squatting down and standing up, jerking you off with her whole body.  Each time her cute bottom bumps your [allbreasts] ");
                if (player.biggestTitSize() >= 2) EngineCore.outputText("making them jiggle");
                else EngineCore.outputText("making her tight butt give a tiny jiggle");
                EngineCore.outputText(".  She hums happily as she works at the task, slathering it in spit, pressing her moist cunt against you.   Her warm body sliding along you feels fantastic, and feeling a bit daring, you give her a light slap on the ass-cheek.\n\n"
                        +"The elf looks over her shoulder and laughs, \"<i>Someone is feeling a bit naughty.  Well, I guess I'll have to help you drain out all that naughty energy.</i>\"\n\n"
                        +"Before you can puzzle out her meaning, she takes a big gulp of air, grabs your [cockhead] with both hands, and presses her lips into your urethra.  She blows into it with a look of intense concentration.  You can feel your urethra filling, expanding with something, but it feels more like liquid than air, tingling as it slides deep into your shaft towards your ");
                if (player.balls > 0) EngineCore.outputText("balls");
                else if (player.hasSheath()) EngineCore.outputText("sheath");
                else EngineCore.outputText("body");
                EngineCore.outputText(".   She blows and blows, seemingly filling you with an inexhaustible supply of whatever magical substance she's forcing inside you. The tingling grows stronger and stronger, and then changes to warmth as a pleasurable heat centers itself in your midsection.\n\n"
                        +"The magic-using elf pulls back with a knowing grin and resumes stroking you, ignoring a dribble of pink fluid that squirts from your tip.   The warmth inside builds higher and you start sweating, even in the cool night air. The uncomfortable heat churns inside you");
                if (player.balls > 0) EngineCore.outputText("r " + Appearance.ballsDescription(true, true, player));
                EngineCore.outputText(", a gentle pressure that builds higher and higher until you feel about to explode.  You need to cum, and you squirm in the elf's grasp, trembling and shuddering as one of her hands slips over a particularly sensitive spot. A bead of pre-cum rolls out of your [cockhead] and starts sliding down the shaft, followed by another, and another, and another.\n\n"
                        +"Your 'present' asks with gradually rising authority, \"<i>Do you feel the naughtyness leaking out?  It feels good doesn't it?  Yes it does, but that's just the start.  You've got a lot of pent up naughty that needs to come out so you'll be good and see me next year.  So be a good boy and cum out all those bad thoughts for me please.</i>\"\n\n"
                        +"She flips around to the far side of your dick and hugs it tightly, squeezing it from base to tip in a fluid motion makes your abdominals clench with unexpected orgasm.   The first 'squirt' of cum is more like a geyser going off.  ");
                if (player.cumQ() < 500) EngineCore.outputText("You recoil from shooting out so much – it's far and away more than you're normally capable of.  ");
                EngineCore.outputText("The elf hugs it and squeezes tightly while whispering, \"<i>Naughty naughty.</i>\"\n\n"
                        +"Thick ropes of your orgasmic goop splatter into her hair, and each successive blast comes out with less and less force, until you're leaking a steady stream of cum that rolls down your [cock] and soaks the pointy-eared woman completely.   As you release your prodigious load the scent of cinnamon fills the air, and you dumbly wonder if it's some side effect of the magic she used on you.  Regardless, cum keeps leaking out over the elf and onto you, and you eventually lose consciousness from perpetual orgasm.");
            }
            //(Go to followup for fucking scene)
            //[Next]
            EngineCore.doNext(xmasFuckFollowup);
            player.orgasm();
        }

        //[FEMALE SCENE]
        function vagFuckXmasElf():void {
            EngineCore.outputText("She pushes you down onto your bedroll and whispers, \"<i>Time to enjoy your present.</i>\"\n\n"
                    +"The elf winks and spreads her legs, revealing her obviously aroused sex to you.  She winks and you see her muscles clench.  The moist lips of her vagina slowly spread apart, and a blunt white object begins to squeeze out.  Is she laying an egg?  Wait- no, more of the object slides out and you can see now that it's tubular in shape, like some sort of sex-toy, and it's covered in a spiraling red pattern.  The object continues its slow journey downwards, roughly six inches hanging free as the elf grunts and moans, her face flushed.   She grips it with both hands and pulls it slowly.  It reminds you the soldiers in training back home the first time they tried to draw a sword – a mix of awkwardness and excitement.\n\n"
                    +"In seconds the elf has her hands around a red-striped double-sided dildo.  It wiggles back and forth obscenely, and now that you have a good look at it, you realize the red sections are slightly raised, to better stimulate the user.  She pants and runs her hand over its pussy-slicked surface, shivering in remembered pleasure until her attention returns to you.  Her lips curl into a knowing smile and she kneels between your [legs], spreading them apart for better access to your " + Appearance.vaginaDescript(player, 0) + ".\n\n"
                    +"The diminutive elf rubs the tip over your lower lips and " + Appearance.clitDescription(player) + " a few times, getting you nice and hot before she slides it up your " + Appearance.vaginaDescript(player, 0) + ".  The dildo feels wonderful inside, each curved ridge sending shivers up your spine as it enters you, then stroking along your walls as you take it deeper and deeper.  The motion is interrupted once your 'present' has decided she's lodged her candy-cane-like toy deep enough inside you.  She lies back and scoots forwards, taking the rest of the striped dildo into her hairless snatch until your mounds are locked together, feminine fluids mixing on an artificial cock.");
            player.cuntChange(15, true, true, false);
            EngineCore.outputText("\n\n"
                    +"The elf giggles, \"<i>Merry Christmas,</i>\" as she starts rocking against you.  The dildo slides through your passage, massaging your inner walls and bumping against your " + Appearance.clitDescription(player) + "'s underside with each stroke.   She's got such great muscle control that she's clamped down on the double-sided dildo and started using it as a cock to fuck you!  She smirks and pounds your vulnerable " + Appearance.vaginaDescript(player, 0) + ", raping it with increasingly forceful strokes.  You grunt and moan as each stroke loudly smacks into your hips.  You feel yourself closing in on an orgasm, but the elf-girl relaxes her grip and simply grinds against you, taking the stimulation down a notch.\n\n"
                    +"Determined to get off, you wiggle against her, mashing your " + Appearance.clitDescription(player) + " into her own.  She squirms and cries out, actually getting off before you!  You muse that elves must have extraordinarily sensitive clitorises, but before you can act on it, you feel a sudden stirring in your loins.   The dildo is starting to spin!  You prop yourself up and watch, unbelieving as the elf's orgasmic contractions visibly contort her belly, moving more and more quickly as the spinning speeds up.  In seconds the twirling assault has placed you back on the edge of orgasm, and you're groaning and rubbing against your insensate lover for more.\n\n"
                    +"You cum, ");
            if (player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_SLAVERING) EngineCore.outputText("gushing fluids");
            else if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLICK) EngineCore.outputText("dripping fluids");
            else EngineCore.outputText("squishing wetly");
            EngineCore.outputText(" as your " + Appearance.vaginaDescript(player, 0) + " is drilled by the elf's double-ended dong.   It feels beyond good, like having a cock inside you that rubs against each part of your pussy over and over and over without the barest hint of mercy.  Your gasp and pant, glancing back up at the elf.  She's already recovered from her orgasm, though she has an intense look of concentration on her face while she focuses on twisting the dildo inside you.\n\n"

                    +"\"<i>You don't think I'd let you cum just once did you?  I'm going to drill all the naughty, sinful little thoughts from your slut-hole!</i>\"\n\n"
                    +"You throw your head back and let out a low shuddering moan as she spins the dildo even faster, forcing your convulsing cunt to stay locked in a mind-shattering orgasm.  Eyes crossed, you collapse onto your back and twitch, body wriggling and flopping about nervelessly as it caves in to pleasure it was never meant to handle.\n\n"
                    +"You black out to the following words: \"<i>Good girl.  Keep cumming, let out all those naughty thoughts.  I can't wait to see you next year!</i>\"");
            EngineCore.doNext(xmasFuckFollowupFems);
            player.orgasm();
        }

        //MANTASTIC FOLLOWUP:
        function xmasFuckFollowup():void {
            EngineCore.hideUpDown();
            EngineCore.clearOutput();
            EngineCore.outputText("You awaken in the morning, sore and exhausted, but more satisfied than you've ever felt before.  Your body feels INCREDIBLY sensitive from head to toe, but particularly on your well-used [cock].  In spite of the traumatic lovemaking, you feel remarkably clear-headed.\n\n"
                    +"Did you enjoy being able to cum so much");
            if (player.findPerk(PerkLib.ElvenBounty) >= 0) EngineCore.outputText(" <b>again</b>");
            EngineCore.outputText("?");
            //[Yes][No] – yes awards (+250 mls cum volume), no awards +15 intellect
            EngineCore.doYesNo(Utils.curry(xmasPerkM,true), xmasSmart);
            //(-5 corruption)
            player.dynStats("cor", -5);
            //(+20 sens unless it would bring you over 80 sens, then +5 sens)
            if (player.sens + 20 > 80) player.dynStats("sen", 5);
            else player.dynStats("sen", 15);
            flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
        }

        //FEMTASTIC FOLLOWUP:
        function xmasFuckFollowupFems():void {
            EngineCore.hideUpDown();
            EngineCore.clearOutput();
            EngineCore.outputText("You awaken in the morning, sore and exhausted, but more satisfied than you've ever felt before.  Your body feels INCREDIBLY sensitive from head to toe, but particularly in your well-used " + Appearance.vaginaDescript(player, 0) + ".  In spite of the traumatic lovemaking, you feel remarkably clear-headed.  The dildo appears to have completely dissolved inside you, leaving behind a pinkish fluid that drips from your lips.\n\n");

            EngineCore.outputText("Do you think it might have done anything to you");
            if (player.findPerk(PerkLib.ElvenBounty) >= 0) EngineCore.outputText(" <b>again</b>");
            EngineCore.outputText("?");
            //[Yes][No] – yes awards (+15 fertility!), no awards +15 intellect
            EngineCore.doYesNo(Utils.curry(xmasPerkM,false), xmasSmart);
            //(-5 corruption)
            player.dynStats("cor", -5);
            //(+20 sens unless it would bring you over 80 sens, then +5 sens)
            if (player.sens + 20 > 80) player.dynStats("sen", 5);
            else player.dynStats("sen", 15);
            flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
        }

        function xmasPerkM(cumQ:Boolean):void {
            if (player.findPerk(PerkLib.ElvenBounty) < 0) {
                if (cumQ) player.createPerk(PerkLib.ElvenBounty, 250, 0, 0, 0);
                else player.createPerk(PerkLib.ElvenBounty, 0, 15, 0, 0);
                EngineCore.clearOutput();
                EngineCore.outputText("<b>New Perk Acquired - Elven Bounty!</b>");
            }
            else {
                EngineCore.clearOutput();
                EngineCore.outputText("<b>Perk Enhanced - Elven Bounty!</b>");
                if (cumQ) {
                    player.addPerkValue(PerkLib.ElvenBounty, 1, 250);
                    EngineCore.outputText("<b> - +250mL cum production!</b>");
                }
                else {
                    player.addPerkValue(PerkLib.ElvenBounty, 2, 15);
                    EngineCore.outputText("<b> - +15 bonus fertility!</b>");
                }

            }
            EngineCore.doNext(EventParser.playerMenu);
        }

        function xmasSmart():void {
            EngineCore.hideUpDown();
            EngineCore.clearOutput();
            EngineCore.outputText("You nod to yourself, feeling pretty smart about your decision.");
            EngineCore.doNext(EventParser.playerMenu);
            player.dynStats("int", 15);
        }
    }

    public static function gatsSpectacularRouter():void {
        //const GATS_ANGEL_GOOD_ENDED:int = 638;
        //const GATS_ANGEL_DISABLED:int = 639;
        //const GATS_ANGEL_QUEST_BEGAN:int = 640;
        //const GATS_ANGEL_TIME_TO_FIND_KEY:int = 641;
        /*A Christmas Carol
        
        Entry for the 2012 CoC Contest, \"<i>A Very Milky XMas</i>\".
        Starring Gatters Bee, Shamble Sworth and a caribou named Kirbu.
        */
        if (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0) christmasEncounterAngelJunk();
        else if (player.hasKeyItem("North Star Key") < 0) findTheWindUpKey();
        else giveThatBitchAKeyYo();

        function christmasEncounterAngelJunk():void {
            EngineCore.clearOutput();
            EngineCore.menu();
            //[Not Christmas]
            //[Explore > High Mountains]
            if (!isHolidays()) {
                EngineCore.outputText("You traipse the high mountainside, a light sprinkle of snow fluttering haphazardly through cold winds.  The sound of your steps begins to form a crunch as the silent white blanket folds over the tops of the nearby peaks, and with your journey to the high mountains appearing fruitless thus far, you consider the possibility of going back to camp.  As snowflakes pervade the air, they'll eventually obscure your sight, leading to a far more dangerous trip both up or down.  Just as you start to turn back, however, a small song echoes from the other side of the peak.  Soft enough to send one to sleep, it barely catches your attention.  Do you decide to investigate?");
                //[Yes][No]
                EngineCore.addButton(0, "Yes", encounterQuoteUnquoteAngel);
                EngineCore.addButton(4, "No", dontExploreGatsChristmasTale);
            }
            //4. Intro
            //[Must Be Christmas Time]
            //[Explore > High Mountains]
            else {
                EngineCore.outputText("You traipse the high mountainside, a light sprinkle of snow fluttering haphazardly through cold winds.  The sound of your steps begins to form a crunch as the silent white blanket folds over the tops of the nearby peaks, and with your journey to the high mountains appearing fruitless thus far, you consider the possibility of going back to camp.  As snowflakes pervade the air, they'll eventually obscure your sight, leading to a far more dangerous trip both up or down.  Just as you start to turn back, however, a small sob echoes from the other side of the peak.  Soft enough to send one to sleep, it barely catches your attention.  Do you decide to investigate?");
                //[Yes][No]
                EngineCore.addButton(0, "Yes", encounterQuoteUnquoteAngel);
                EngineCore.addButton(4, "No", dontExploreGatsChristmasTale);
            }
        }

        function dontExploreGatsChristmasTale():void {
            EngineCore.clearOutput();
            //i. No
            EngineCore.outputText("In a place like the high mountains, there's no warning to be found if you happen to be confronted by danger.  Deciding not to take your chances, you continue to walk down the path you came, leaving the peaks to head straight back to camp."
                    +"\n\nIt's certainly warmer there.");
            //turn dat shit off
            flags[kFLAGS.GATS_ANGEL_DISABLED] = .5;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //ii. Yes
        function encounterQuoteUnquoteAngel():void {
            EngineCore.clearOutput();
            if (!isHolidays()) {
                EngineCore.outputText("You haven't found anything as of yet, so you figure you might as well keep going.  Following the quiet tune from above, you trace the spiralling side of the snow-capped behemoth, eventually reaching a small cliff hanging beneath the mountain's peak.  Upon the cliff, a small lake encompasses the area.  Though it remains frozen, a single soldier lies inside, hugged by an icy grave."
                        +"\n\nThe source of the song you had heard appears to be coming from a small, elderly woman huddling over the lake.  She holds a small fishing rod piercing through the icy shell of the water, though by the looks of it there aren't even any fish to be found.  Trotting over, you manage to catch her attention.  The old lady pats the soft, snowy ground beneath her, offering a seat by her side."
                        +"\n\n\"<i>I have a tale to tell, traveller,</i>\" she coughs.  \"<i>Sit by me, will you?</i>\""
                        +"\n\nWith nothing else to do, you figure you might as well hear it out.  Stories may not bring warmth to your body, but your heart might find it comforting during this unnatural winter.  Nodding, you sit down next to the elderly woman, to which she offers you some rock candy.  You decline, mentioning that you had brought your own");
                if (EngineCore.silly()) EngineCore.outputText(" (you didn't.)");
                else EngineCore.outputText(".");
                EngineCore.outputText("  She beams a toothless grin, popping one into her mouth and blowing out a stream of candy-scented smoke.  Suddenly, you're glad you didn't take any."
                        +"\n\n\"<i>Once upon a time, upon this very mountain, two lovers had ran to escape the corruption of the world.  A single spirit, more beautiful than any mortal woman, and a man she had created from tin.  Her brave soldier.</i>\""
                        +"\n\nLike a wistful tune, her words form vivid images within the ethereal smoke.  A lone giant as tall as the mountains themselves huddles close with her soldier, an average-sized suit of armor.  The foggy image twists and turns like a velvet cloth, telling the story of her soldier's life.  Though they had stayed together, he grew slower and slower each day.  Eventually she carried him in her arms to the peak of a snowy mountain, but by that point he had ceased to move.  She built a grave, and with her divine tears, encased him in the crystalline lake for an eternity."
                        +"\n\n\"<i>No one knew where the woman had gone, but they say she visits him once a year, when the lake is covered in a blanket of snow.  Perhaps you'll see her.</i>\""
                        +"\n\nHer gummed smile appears once more.  \"<i>Perhaps you'll save them, too.</i>\""
                        +"\n\nWith that, she hushes you away to return to her fishing.  With nothing to show for it, you decide to cease your journey up the high mountains, turning tail to head back to camp.  In the back of your head, the tale of the spirit and her soldier stay fresh in your mind.");
            }
            //ii. Yes
            else {
                EngineCore.outputText("You haven't found anything as of yet, so you figure you might as well keep going.  Following the quiet cries from above, you trace the spiralling side of the snow-capped behemoth, eventually reaching a small cliff hanging beneath the mountain's peak.  The sight you're met with manages to take your breath away - and considering the inhabitants of the land around you, that in itself is quite a difficult feat."
                        +"\n\nYou had never met a true giant in the land of Mareth, though to be fair you aren't even sure you're meeting one now.  A woman as tall as the mountain itself rests her head upon the side of the cliff, her umber skin adorned with falling snowflakes and her rosy cheeks stained with tears.  Her waterfall of ivory-white hair curls down gracefully onto the soft ground, and a pair of tree-like antlers erupt from the top of her head, colored with red and white stripes."
                        +"\n\nYou could swear that a sextet of invisible wings beat slowly behind her, forcing the direction of the wind to change with every movement.  In the span of the warm breath that emits from your cold lips, a single word appears in your mind - one that perfectly defines the sight you have been introduced to."
                        +"\n\nGoddess."
                        +"\n\nYou take a step forward, though something else seems to have caught your eye in the process. It seems you had missed it earlier - another person?  Though it isn't as lively or as remarkable as the sleeping giantess in front of you.  Regardless, you walk towards it to investigate further."
                        +"\n\nThe closer you get, the more you're able to discern the figure of a lone knight covered by the mountain's icy blanket.  The helmet, though obscuring his face, reveals an empty interior.  You'd call it a shell, though the joints of the armor are more practical than protective.  If you could hazard a guess, this knight is more like... a doll? You slowly reach out to touch him, but as you do, the angelic colossus stirs from her slumber."
                        +"\n\n\"<i>Who... is there?</i>\""
                        +"\n\nYou don't have time to hide, and considering your location you'd be surprised to find effective camouflage in the giant fuck-white background you're currently situated in.  Instead, you wait out the woman's awakening, the divine giant stretching out and appearing taller than the world itself.  She yawns awkwardly, blinking her emerald eyes before focusing them upon you.  With a sense of finality to her morning routine, her unseen wings flap once against the winter winds, blowing you back into the cliffside.  Holy Marae, you're going to be swallowed alive."
                        +"\n\n\"<i>Lost child, who might you be?</i>\""
                        +"\n\nYou back up against the rocky wall, mostly to get out of the heap of snow building up around the peak.  The giantess seems kind, forgiving");
                if (EngineCore.silly()) EngineCore.outputText(", without a penis");
                EngineCore.outputText(" - a loving aura surrounds the feminine creature and you can't help but feel as if she's here without ill intent.  Stating your name, you question her purpose at the high mountains."
                        +"\n\n\"<i>[name], is it?  That's quite pretty.  I don't meet many people with names, and I'll be sure to remember yours.</i>\""
                        +"\n\nYou cock an eyebrow, though she doesn't take notice.  Instead, the snow-dusted titaness turns her gaze towards the empty soldier, before a look of pain embraces her visage.  Turning your neck, you ask her about her relationship towards the mechanical man.  She smiles, though it's plain to see how distant it has become."
                        +"\n\n\"<i>He's my brave soldier.  Nothing more, and nothing less.  I had created him out of tin, before giving him life, and from the moment he was born, he had loved me from the very bottom of his heart.</i>\""
                        +"\n\nThough her presence is otherworldly, you ask if she is a goddess of the land - a deity from above, perhaps, but the woman only shakes her head in response."
                        +"\n\n\"<i>Not a god, nor a giant,</i>\" she whispers.  \"<i>The men of your land had called me a spirit, and for the person I once was, it seemed to be the most appropriate title.  Now, however, I am but a fool who wished to know what it was like to toy with fate.</i>\""
                        +"\n\nYou'd pat her on the shoulder, but you'd rather not climb any more mountains.  Instead, you offer your condolences, looking towards the silent knight in his time of slumber.  The angelic giant continues her story, the whistling of the snow-speckled wind providing music to her joyless tale.  The magic that had brought her knight to life was more akin to a curse than a miracle, and although she herself could live for an eternity, the knight would move less and less, until eventually he ceased to move at all.  She begins to cry once more, her voice echoing through the mountainside."
                        +"\n\n\"<i>I didn't know I was going to fall in love, too.</i>\""
                        +"\n\nSilence falls upon you both as you allow the colossus time to collect her thoughts.  Though her eyes sparkle with a divine beauty, they're red with the years spent crying to herself.  In time, she picks herself back up, letting her soft-spoken voice continue her story.  The soldier had given himself a name - North, simply after the direction he was facing during his creation.  And although her kind had no need for names, her soldier had given her one regardless."
                        +"\n\nYou ask if there's a way to bring him back to life, to end this eternal suffering they had subjected themselves to.  She smiles weakly, but shakes her head in dismay."
                        +"\n\n\"<i>Though the magic that kept him together was strong, the key that wound him up and began his life was the secret to his creation.  It was lost long ago inside the secret grotto he was born in, and by the time we had returned when we needed it most, the mountains had grown over it.  I am far too tall to search them, and far too weak to rip them apart.  Though a stranger might find us every hundred years or so, none return.</i>\""
                        +"\n\nYou tell her that you'll try your best to find it, though you admit that even you don't fully believe your words.  She must've heard the same thing thousands of times before, to no avail.  Despite this, her face brightens, her glimmering tears whisked away by the cold winds."
                        +"\n\n\"<i>I believe in you.</i>\""
                        +"\n\nThe feminine behemoth rests her head upon the cliff once more, but not before waving you goodbye.  You return her gesture with a thumbs up, heading back to camp to prepare for another wintery escapade.");
                flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] = 1;
            }
            flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] = 1;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //5. Solution
        function findTheWindUpKey():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Upon reaching the base of the mountain, you set off on your quest for the grief-stricken giantess.  A sunken grotto hidden around the mountain's base, you recall.  In all your treks over this bump in the land, you've never noticed anything even vaguely resembling the little shelter she described.  However, \"sunken\" gives you a vital hint to help begin your quest in the right direction.  You remember a steep valley, flooded and forgotten in its tiny alcove amidst the towering earth.  It takes little time at all until you've worked your way around to the unremarkable crater, pushing your way past the dense growth and through the humid mist surrounding it."
                    +"\n\nIn a surprisingly bold move, you strip free of your [armor], not wishing to waste thoughts worrying about wet or ruined articles of clothing.  The majority of your time in this land is spent in the nude as it is, so a skinny dip isn't so out of the ordinary.  A simple dive into the unusually clear waters marks the next branch of your search.  Sunlight sparkles as it draws rays through the crystal-clean pond, highlighting the darker recess underneath an outcropping of jagged rock.  You surface for another gasp of air before embarking on the next leg of your journey."
                    +"\n\nAn odd green glow fades in ahead of you, marking the exit from the engulfed tunnel.  Surprisingly cool, fresh air fills your lungs as you emerge onto the stony beach.  Brushing your [hair] clear away from your face, you can hardly believe your eyes as they set upon the cramped cave.  The entire opening is bathed in a dim green light, radiating from glowing rocks and gems embedded into every imaginable surface.  Dotted among them are tiny, slightly brighter specks of red and pink.  You can't help but stare in silent awe at the sight, glancing down at your wet hands to bask in the deep, inviting glow.  This has to be the place."
                    +"\n\nRegret is the only thing on your mind once you pull free of the water; it's much colder in here than you had anticipated.  A quick shake and a firm rubbing along your arms staves off the feeling long enough for you to concentrate on the task at hand.  With careful steps of your bare [feet] along the smooth rock, you investigate your surroundings for anything of particular note.  It's only now that you wish you had actually bothered to ask just what this key looked like.  Best not to just assume things when it comes to mysterious, gargantuan titans weeping high in the skies, you note to yourself."
                    +"\n\nLuckily for you, there isn't much ground for you to cover.  Your hands slowly pass over the illuminated surfaces, hunting for anything that stands out.  For as inspiring as the illuminated crag and minuscule gems appear, you doubt that any it is what the mountaintop spirit requested of you.  A few moments pass before a slight ledge hanging over your head comes to your attention, shrouded in the dense emerald radiance of the cave.  Looks as though this little hole has at least a little more to it than you anticipated!"
                    +"\n\nA sturdy grip and a measured tug propels you up the wall, with extra care taken not to brush your bare body against whatever lays on the multicolored wall.  Though there is more to the cave than you initially anticipated, it doesn't amount to much more than an illuminated little dome.");
            //[if (tallness > 60) 
            if (player.tallness > 60) EngineCore.outputText("  You can't even stand straight up below the low-hanging ceiling, forced to carefully tread along on your knees over the slick, hard rock.");
            EngineCore.outputText("  Squinting around the small, deep green grotto, a pedestal in the center calls out to you.  As you approach it, it becomes evident to you why things are so chilly in here; the outcrop is made up of clear ice - and within, the bodies of the many who had found this place before you.  At least that mystery is cleared up.  Atop the frozen prop lies a small, crystal... crank? Upon closer inspection, it actually resembles a - kitty titties, it's a windup key!  Despite the fact that you should've seen this one coming, you surmise that this is the item you've come searching for."
                    +"\n\nYou reach over the bitter base to pluck your prize free, again careful that your moistened, exposed body refrain from making contact with the frigid obelisk.  There isn't an ounce of your being that wants to experience ripping any frozen flesh free.  As you grasp and pull free the slick, clear trinket you're taken by surprise as the brilliant glow surrounding you snuffs out, quickly leaving you in silent, black darkness.  Your hands grasp tightly onto your bounty, gently rubbing over its curves with your fingertips as you fruitlessly glance around in search of light."
                    +"\n\nOne surprise leads to another when a warm glow breaks free from between your hands.  A swirling of green and red mist is concentrated within the frame of your prize, glowing brightly as they swim endlessly through the key's curves at a variety of velocities.  It's plain to see that this little treasure was the cause for the cave's unnatural brilliance.  You're a little ashamed to rob it of its power source... but not enough to give it a second thought as you crawl back down to the entrance only a few feet away.  The last thing you want is for your magical lantern to dull and leave your naked body blind in this hazard-filled hole."
                    +"\n\nYou carefully re-enter the flooded tunnel, unsure how the supposed key will take to water.  It makes little impact as you submerge it, though the glowing light looks lovely on the pitch black tunnel.  The sight reinvigorates you slightly, though the warmer waters are probably more to blame.  Chalking up yet another simple retrieval asked of your person, you surface back outside, eager to get back into your [armor] and return to the high mountains.");
            player.createKeyItem("North Star Key", 0, 0, 0, 0);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //ii. Bringing the Key Back
        //Activates upon returning to the High Mountains after the previous scene, before X amount of hours or X amount of time past Dec 25th (presumably)
        function giveThatBitchAKeyYo():void {
            EngineCore.clearOutput();
            //if in time!
            if (flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 150) {
                EngineCore.outputText("All throughout your perilous climb, you cannot help but ogle at the brilliant little crystal key.  You have a suspicion as to how this innocent little key will help the crying colossus on the peak, but you are not completely sure this is the artifact she required.  But you have a hunch that it is."
                        +"\n\nYour trek halts to a standstill as you return to the side of the vast giantess.  Her sadness and longing appears to have overwhelmed her to a degree, putting her to sleep beside the still-inanimate soldier beside her.  You cast another glance at your brilliant relic, hooking a finger through it as you lift it before your face.  Transfixed by the swirling dance of red and green, you begin to weigh the options before you.  The spirit would surely request the key from you so that she may return her love to his former self, you believe.  However, perhaps you deserve a greater reward from this little deed.  You hold all the important cards in this deal after all.  You thoughtlessly swirl the windup key around on your finger, pondering your next move."
                        +"\n\nYou could try to fuck around with the spirit or her soldier, but doing either would be a huge dick move...");
                EngineCore.menu();
                //[Give the Key] [Fuck the Soldier] [Fuck the Angel] 
                EngineCore.addButton(0, "Give The Key", goodEndForChristmasMiracleICant);
                EngineCore.addButton(1, "FuckSoldier", theWorstEndingEverDotJPG);
                EngineCore.addButton(2, "Fuck Spirit", fuckTheAngelBadEnd);
            }
            else {
                //Activates upon returning to the High Mountains after the previous scene, but after X amount of hours or X amount of time past Dec 25th (presumably)
                EngineCore.outputText("All throughout your perilous climb, you cannot help but ogle at the brilliant little crystal key.  You have a suspicion as to how this innocent little key will help the crying colossus on the peak, though you aren't entirely sure this is the artifact she required.  But you have a hunch that it is."
                        +"\n\nAs you reach the peak of the mountain, you find the lone giantess still lying on top of the cliff side, a hand stretched out to her mechanical lover. Perhaps you should surprise her when she wakes."
                        +"\n\nWalking towards the tin soldier, you take out the cold wind-up key, looking around for a place to stick it inside.  Before you can look any lower, a small, convenient hole lies at the base of his back, between two slices of armor resembling shoulder-blades.  Darn.  You give a grin, placing the object within the hole and turning it ever, ever so slightly.  You want this to work, and you're certain that his titanic lover would want more than anything to see him alive again."
                        +"\n\nIt snaps in perfectly."
                        +"\n\nHis body begins to whirr and click, pieces moving into place as the soldier - North, was it - starts to power up.  With a final creak of his joints, he begins to stand up, stumbling at first, but ultimately landing upon his feat in triumph.  Squeaking up, he mutters what are probably the first words in a lifetime."
                        +"\n\n\"<i>Carol.</i>\""
                        +"\n\nYou shy a little wave in return, but he's already gone to ignoring you.  Searching around, he finds the object of his desire - the woman he had waited with for centuries.  His steps are slow and lumbering.  Whether it's the fault of his time spent in the ice or if he had always been this way is unknown, but regardless he crunches through the snow awkwardly and with great caution.  His movements grow more and more excitable - there's no doubt that he recognizes the resting giantess, but... something appears to be off.  You can't quite place it, so you walk towards them to investigate."
                        +"\n\nNorth shakes at the woman's resting head, trying with all his strength to wake her from her sleep, but her size just proves the feat to be near impossible to accomplish.  He resorts to pushing, to shoving, to beating at her forehead, but she doesn't move.  It's hit you, but you aren't sure whether or not it's quite hit him yet."
                        +"\n\nShe's already dead."
                        +"\n\nYou leap over to them, taking North's fists away from her gentle face.  He tries to retaliate, but he gives up in half-stride."
                        +"\n\nYou aren't sure how to respond, and the two of you are seated in silence for a long period of time.  His lover's hand remains outstretched, reaching for the place that her soldier had once lay still.  You want to speak, but North only tells you to leave, creaking over to her hand and resting in-between her cold palm."
                        +"\n\n\"<i>She didn't know,</i>\" he croaks.  \"<i>She didn't even know that I had always been watching her.</i>\""
                        +"\n\nHe wasn't dead. Only waiting, like her."
                        +"\n\nThe air remains cold and merciless, and regardless of what you do it would be difficult to stay for much longer.  Turning away, you trot silently back to your camp, wondering how things would've gone - if only you were quicker.");
                //[BAD END, Can no longer see the Old Woman or this series of events]
                flags[kFLAGS.GATS_ANGEL_DISABLED] = 1;
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }
            //player.removeKeyItem("North Star Key");
        }

        //6. Corrupt End #1
        function theWorstEndingEverDotJPG():void {
            EngineCore.clearOutput();
            //Requirements: Choosing [Fuck the Soldier] at the prompt
            EngineCore.outputText("Still listlessly spinning the windup key around your pointer finger, you gaze back down at the pile of armor buried in the snow.  A strange amount of curiosity surrounds this peculiar set of protection, only mounting the longer you stare at it.  It isn't like you owe anything to the slumbering titan.  Just what could she see in something a mere fraction her size?  Maybe this is some sort of dominating fantasy of hers; you've been around the block enough times to know that not everything is at it appears.  There's no telling just what she has in store for her little creation.  You may actually get to be a hero!"
                    +"\n\nAnd, hey, if the windup key does fuck all, at least you get a free set of armor out of the deal!"
                    +"\n\nWith your mind made up and your resolve firm, you set off to rescue the dormant soldier, sliding the key back into your pocket.  White powder flies one way and another as the inanimate prisoner is freed from its snowy confines, once again knowing open air.  You prop the set of armor up against your back, taking great care not to alert its captor of its daring escape.  You drape the arms up over your shoulders and scoop the legs into your arms, employing a generous piggyback ride to aid in your liberation.  You pay the giantess a final glance, a hint of doubt still lingering in confines of your judgment.  You assuage your hesitation with a quick hiking of your cargo, rushing down off the mountain.  The cold mountain wind once again shrouds the slumbering spirit from your peripheral vision, helping ease your conflict."
                    +"\n\nYou eventually reach the base of the mountain, free of the seemingly never-ending, blindingly white blizzard.  You take a few minutes to trot over to a clearing, your load lightly bouncing around behind you.  A nearby tree acts as the perfect prop for your friend as you turn in place and gently set down the suit of armor.  Eying over the lifeless pile of scrap, it appears as hollow to you as it did when you first saw it buried in the snow.  Even as you pull the beautiful little windup key back from your pocket, you're hesitant to believe something so simple could spark life back to this creation."
                    +"\n\nWith a hand propped over the soldier's shoulder, you guide the key back to a slot in base of the soldier's back and give it a quick turn, filling the air with a pleasant click.  You're taken by surprise as the suit begins to shudder and rattle, backing off of the little miracle to take in the sight.  The armor braces up against the tree, trembling as it slowly rises to its feet.  An ebony haze fills the interior of the once-hollow soldier, light wisps escaping from little cracks and openings as the shuddering soldier fills with what you presume to be life.  The construct finally settles and lifts its hand to its helmet, revealing a pair of minuscule, glowing orbs of gold staring back at you.  North has returned."
                    +"\n\n\"<i>Why have you dragged me down from the mountain?</i>\""
                    +"\n\nHis pleasant, innocuous tone takes you by surprise.  The soldier glances around lightly as you try to concoct some sort of response.  How does he know what you did?"
                    +"\n\n\"<i>May I ask as to who you are?</i>\""
                    +"\n\n\"<i>Why, I'm the spirit,</i>\" you respond.");
            //[if (corruption > 49)
            if (player.cor > 49) EngineCore.outputText("  It seems like the best response to you for now.  Based on the giantess's sobbing soliloquy, you figure that standing in for the love of the soldier's life will get you straight to the action.");
            else EngineCore.outputText("  Wait, what?  It appears that in your desperation to contain the situation, your lingering doubt was enough to get you blurt out a bold faced lie.  You figure that you may as well roll with it for now.");
            EngineCore.outputText("\n\n\"<i>That can't be right.  Carol was lying beside me up on the mountain.  Then you came and dragged me away,</i>\" North replies, still as casual and calm as before.  Carol... you figure that must be the name of the spirit you left behind.  Without missing a beat, you devise an explanation consisting of dreams, loneliness and immeasurable amounts of time leading to North's obvious hallucinations.  Why would a spirit be so large and leave the two of you lost to a cold and forgotten mountaintop?  As North processes your explanation, you figure it best to just go straight for your coup de grace, insisting on the love between the two of you."
                    +"\n\nIt's hard to get a read on just what's going on in that tin-covered head of his.  In a last ditch effort to reign in the situation, you strip free of your [armor], accentuating ");
            if (player.hasCock()) EngineCore.outputText("[eachCock]");
            if (player.gender == 3) EngineCore.outputText(" and ");
            if (player.hasVagina()) EngineCore.outputText("your [vagina]");
            EngineCore.outputText(" to try and convince the confused soldier.  You look North over, figuring the best way to work him under your spell.  It isn't a long search, as you decide that his ");
            //[if (hasCock = true) 
            if (player.hasCock()) EngineCore.outputText("keyhole");
            //[if (hasCock = false) 
            else EngineCore.outputText("windup key");
            EngineCore.outputText(" would make a worthy candidate for your first alluring act of debauchery."
                    +"\n\nA playful, sly smile is the only hint you give to the strangely compliant tin man as you slink on around to his back, gracefully resting your fingertips upon his crystal key."
                    +"\n\n\"<i>What are you doing?</i>\" he asks, his tone still as polite and reserved as ever.  He doesn't react with much more than a sideways glance as you lurch the sizeable apparatus free of his backside.  ");
            //[if (hasCock = true) 
            if (player.hasCock()) EngineCore.outputText("You slide the key playfully down your wrist, rubbing your [cock] with your free hand.  You aren't entirely sure if he'll even feel a sensation from your penetration, but perhaps it'll at least get him in the mood.  With your manhood at full mast, you gently skirt along the edges of the keyhole.");
            else EngineCore.outputText("A mischievous tongue traces along the smooth, perfect surface of the windup key.  You promptly lower the makeshift toy precariously in front of your [cunt]; if there was ever a time to make a wind up pun or remark as some sort of goofy foreplay, now would be the time.");
            EngineCore.outputText("\n\n\"<i>This isn't right.</i>\""
                    +"\n\nNorth backs away from you, breaking the little amount of action you were trying to get started."
                    +"\n\n\"<i>You aren't Carol.  I know I'm not delirious,</i>\" he states plainly, staring at his metal hands.  \"<i>I need to go back to my love.  She... she...</i>\""
                    +"\n\nThe tin soldier begins to falter, having trouble standing as he paces back towards the mountain.  It's just then when you realize that the black mist making up his form appears to be dissipating.  He appears to be trying to fight it, but more and more of North's essence continues to escape from his metal confines."
                    +"\n\n\"<i>I-I need to check on Car... on Carol.  To make... make sure she's,</i>\" North takes one last gasp, his gentle tone finally beginning to crack, \"<i>...that she's not c-crying.</i>\""
                    +"\n\nWith one last forlorn outstretched arm, the suit of armor crashes to the ground, extinguished of its occupant.  You stand motionless, not sure how to react.  You glance down at the windup key in your hand.  Did... Was this your fault?"
                    +"\n\nThere has to be more to it than this key."
                    +"\n\nYou slip it back into the armor's lock and give it another twist.  But nothing happens.");
            //[if (corruption > 49) 
            if (player.cor > 49) EngineCore.outputText("  ...Well, that was a waste of time.");
            EngineCore.outputText("\n\nThe key's glowing innards finally disappear, leaving a simple glass key jammed into tin.  It's a sad sight, one that you can't help but stand in silence over."
                    +"\n\nAfter a few moments, you decide to don your [armor] once again, leaving the mishap behind as you return to camp.  There's no telling if what you did was ultimately right or wrong in the grand scheme of things, but dwelling over North or Carol isn't going to get you anywhere any time soon.");
            //[if (corruption > 49) 
            if (player.cor > 49) EngineCore.outputText("  More importantly, you have some unsatisfied, pent up lust that you'd like to expend.");
            player.dynStats("lus", 2 + player.lib / 10 + player.cor / 10, "cor", 10, "scale", false);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            flags[kFLAGS.GATS_ANGEL_DISABLED] = 1;
            player.removeKeyItem("North Star Key");
        }


        //7. Corrupt End #2
        //Requirements: Choosing [Fuck the Angel] at the prompt
        function fuckTheAngelBadEnd():void {
            EngineCore.clearOutput();
            EngineCore.outputText("The spirit lies comfortably upon the pillowy white ground, laying in wait for the moment she awakes to her mechanical lover.  Unfortunately, you're the one with the key.  The one with the fate of two lovers twirling around your finger.  They're both quite still, frozen upon your decision.  Well!  No need to wait any longer - there's fun to be had this winter, and the sight of that divine giantess is getting you antsy."
                    +"\n\nRunning towards the mocha-colored titan, you disturb the side of the mountain peak, causing lumps of snow to fall upon her head.  It's one way to wake her up for sure, as she slowly removes her head from the cliff's edge."
                    +"\n\n\"<i>Hnn... ? North, is that you?</i>\""
                    +"\n\nWoah, rude.  No, you aren't that mechanical dustbin, and as far as you're concerned the only name she should be pushing through those fat lips is yours.  Her jade eyes focus their gaze upon you, brightening when she realizes that you've brought back the key.  She motions for you to go by North's side with the tip of her finger, but you'd rather not comply.  Instead, you slap the tip of her digit to catch her attention."
                    +"\n\nUnderstandably, she doesn't quite know what you're getting up to, cocking the side of her head in confusion.  You dangle the key in front of her, before pretending to snap it in your hands.  The giantess cries out in surprise, reaching out before backing off as soon as you try it again.  She's completely at your mercy, unable to reach out and crush you without risking the safety of her lover's key."
                    +"\n\n\"<i>W-w-wait, what's going on?  What are you doing?</i>\""
                    +"\n\nHa, as if she doesn't know!  Flaunting those - literally gigantic - tits in front of you, expecting you to bend over and partake in a fetch quest to get her with someone else?  As if that was ever going to turn out for the better!  That metallic moron over there has been out of service for centuries, and you're sure as shit not about to find out how that relationship even works in the first place.  You tell the dumbass divinity about the exhausting, difficult journey that you had partaken on to obtain her lover's key.  The treacherous crystal cave submerged beneath a chilling pool of death.  All in all, a rather distressing adventure for all parties involved.  The titanic spirit stutters a few words of apology, but you shake your head.  You need something more than petty words, you know?  You need compensation."
                    +"\n\nCompensation only she can provide."
                    +"\n\nInnocent as always, you didn't really expect her to pick up the hint.  Your chocolate-colored goddess seems flustered and confused.  Of course, you are holding her tin soldier up for ransom, so it's only natural she'd respond with bewilderment and stress.  You tut - this isn't going to go anywhere without a push.  Grasping the key tightly with one hand, you tell her to rest her chin upon the cliff, and to open wide."
                    +"\n\nThe giantess has no choice but to comply with your odd demands, still unaware of the plans you have in store for her.  Her snow-dusted head rests against the edge of mountain, her cold, mint-like breath causing the vanilla ground to ebb and flow like a tide.  Pursing her lips, she impulsively licks them before opening her maw slowly, allowing her tongue to stretch out upon the ground.  You walk towards it, slowly removing your [armor].  The prospect of fucking someone's tongue seems interesting enough to grab your attention, and it isn't every day you run into a desperate spirit like this.");
            if (player.hasCock()) EngineCore.outputText("\n\nTaking out your junk");
            else EngineCore.outputText("\n\nCaressing your cunt");
            EngineCore.outputText(", you wander your way towards the giant's mouth-muscle, climbing on top of her warm, pink bed. There's gotta be some kinda magic involved - her mint saliva sends tingles through your body, while dragging your ");
            if (player.hasCock()) EngineCore.outputText(player.multiCockDescriptLight());
            else EngineCore.outputText(Appearance.vaginaDescript(player, 0));
            EngineCore.outputText(" against each bump and curve is beginning to get you hard.  She winces at the taste of your crotch against her tongue, though she's obviously never given oral to something with a heartbeat before.  Well, there's a first time for everything."
                    +"\n\nHer mouth is already lubricated with what appears to be chocolatey saliva, a sweet syrup coating your genitals with a cool, arousing fluid.  It's not hard to guess that her tongue might be incredibly sensitive, and every hump against it seems to be getting the giantess unconsciously excitable.  Her eyes begin to flutter and a groan escapes her lips, while you hug against each wave of her warm breath.  The hypersensitivity of her mouth-muscle begins to take control of her movements, the grinding of your ");
            if (player.hasCock()) {
                EngineCore.outputText("member");
                if (player.cockTotal() > 1) EngineCore.outputText("s");
            }
            else EngineCore.outputText(Appearance.vaginaDescript(player, 0));
            EngineCore.outputText(" along the softness of her maw causing her to twitch and drool uncomfortably.  You're beginning to fuck along her slowly, chuckling at every wince and moan she makes from the taste of your genitals."
                    +"\n\nOne of the giantess' hands moves slowly towards the top of her head - what could she possibly be planning, you wonder.  Your query is answered almost instantly as the tips of her fingers start to caress the lengths of her striped horns, and her unused hand drifts slowly beneath to pet the increasingly wet problem below.  It didn't take her long to forget that pathetic bin of a man!  If anything, the taste of your ");
            if (player.hasCock()) EngineCore.outputText("cock");
            else EngineCore.outputText("pussy");
            EngineCore.outputText(" seems to have awakened something inside of her.  Each breath of the jiggling giant intensifies, while her heaving breasts press up against the hard mountainside.  You thrust between the curves of her tongue, lapping at her chestnut saliva and caressing each bump and groove.  Her soft, candy-coated lips slowly descend every so often in an attempt to kiss you, to which you respond with slow licks of those luscious love-pillows.  Your titanic lover jerks slightly - she's dipped a finger inside of her slick honeypot, flowing freely to wherever her arousal will take her.  Taking to the tongue-fucking charade quite easily, you wonder if she's allowed her mechanical mate to blow one off on her blushing bronze face before."
                    +"\n\nDespite the increasing ecstasy wrought on by your talkbox-twiddling escapade, you snap back from your delirium to take notice of your lover's aroused antics.  The giantess pushes back and forth against another nearby mountain while furiously fingering her tight cunt.  Upon further inspection, a large curiously-shaped rock appears to be lubed up and ramming her from behind, pounding into her ample ass by her command.  Unable to resist any longer, she's taken to pleasuring herself from every angle, entrusting you to take command on her tongue.");
            EngineCore.outputText("\n\nThe grooves of her syrup-coated organ hum against your body, the chocolate-covered taste buds massaging your figure as you grind along them.  The vibrations drooling along your " + player.skinFurScales() + " appear to be coming from the snow-dusted girl herself, a result of her constant moaning from the good plowing she's receiving from behind.  Her fingers dance between her, now focusing on squeezing her cushiony tits together to rub her nipples against the hardness of the cliff's edge, while bending down further to fit more of the lubed-up loverock taking her from below.  In some form of ambrosia-induced harmony, you've allowed yourself to become a part of this incredibly orchestrated scene of scented fucking.");
            EngineCore.outputText("\n\nThe giantess' butt-drilling escalates with her hand ravaging the tight confines of her dripping pussy, attempting to cry words but unwilling to close her mouth on you.  It's amazing, this chance to drag your ");
            if (player.hasCock()) EngineCore.outputText("dick");
            else EngineCore.outputText("vagina");
            EngineCore.outputText(" on a person's tongue to fuck it thoroughly.  You wonder if she's already long forgotten the pile of bolts she was originally trying to save.  A man frozen in time, never to wake up because - whoops!  You're taking care of her needs now.  Maybe you'll invest in a giant goblin-built sex machine, who knows?  Judging by the bitch's aroused whines, she was probably waiting for the chance to strip for the next person to find her up the mountain.  It's about time she let herself go, after all."
                    +"\n\nYou grin at the thoughts pervading your mind, unaware of the intense pleasure building up in your junk - the sugary syrup coating the base of her mouth starts to force your [hips] to propel further, to splatter your love inside her.  It's almost automatic, the movement of your [hips] against each rubbery, vibrating protrusion tickling and fondling you while receiving satisfaction in return.  You're going to cum, and there's nothing stopping you now!"
                    +"\n\nWith a jerk of your hips, you release your ");
            if (player.hasCock()) EngineCore.outputText("hot, white seed");
            else EngineCore.outputText("feminine juices");
            EngineCore.outputText(" all along her starving tongue, your eyes lifting up as you stretch to force as much as you can upon her.  A slick, stubby tendril fits between your [butt], while more of her taste buds rub against you in your squirting ecstasy.  Your ");
            if (player.hasCock()) {
                EngineCore.outputText(player.multiCockDescriptLight());
                if (player.cockTotal() == 1) EngineCore.outputText("throbs");
                else EngineCore.outputText("throb");
            }
            else EngineCore.outputText(Appearance.vaginaDescript(player, 0) + " throbs");
            EngineCore.outputText(", painting the giantess while she pants and moans, legs almost buckling from her own joy along with the taste of your mess inside of her.  She struggles to remove the makeshift dildo from her ass, resting her cheek against the size of the mountain let your concoction drool out.  Slipping out, you take the opportunity to grind up against her ruby lips, before cumming on her face.  She lets out a weathered smile, before her giant eyes focus once more on the mechanical soldier.");
            //[Next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", fuckTheAngelBadEndPartII);
        }

        function fuckTheAngelBadEndPartII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("It shakes, and - wait, it's shaking?  You walk towards him, still naked from your recent session with his lover.  It appears to be vibrating with a sense of... sadness, you'd guess.  You look inside, but nothing can be found.  Was it really dead, or just unable to move?  It soons stops though, and both you and the giantess stare at the cold figure of the soldier."
                    +"\n\nOf course, you kick it over, while it thumps into the snow.  Whatever it was doing before, it's certainly gone now.  You turn back to your new lover, and - oh no."
                    +"\n\nShe's sobbing, and it's hardly a light drizzle, either.  Her eyes are filled with a watery melancholy that you haven't quite seen before.  She spits, trying to regain her composure."
                    +"\n\n\"<i>He was watching the entire time.</i>\""
                    +"\n\nShit, you think.  He could've joined in.  There's no use consoling her now, she's an absolute mess at the sight of her dead mate.  Though she effectively killed the mood, you walk towards her, in hopes for another round.  The angelic woman only glares at you, but the circumstances won't let her be angry for long."
                    +"\n\n\"<i>Give me one reason why I should not crush you right now.</i>\""
                    +"\n\nNope, she's still angry. It's time to go. Taking your [armor] with you, you make a run down the side of the high mountain, throwing the key off the side of the cliff as you hear the distraught damsel cry into the skies. The mountains tremble in fear, and a snow storm begins to brew."
                    +"\n\nThankfully, you're out of that mess and heading for camp. That slut is cold.");
            //[End of event. Possible expansions include finding her as a difficult combat encounter, or raping her while she sleeps.]
            flags[kFLAGS.GATS_ANGEL_DISABLED] = 1;
            player.orgasm();
            player.dynStats("cor", 10);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //8. Good End
        function goodEndForChristmasMiracleICant():void {
            EngineCore.clearOutput();
            //Requirements: Choosing [Give the Key] at the prompt
            //completely fucking tender let's get moe
            EngineCore.outputText("After everything you've heard, the decision seems clear enough.  Holding your prize above your head, you start forward, calling to the gargantuan woman to announce your successes.  Her eyes flutter open at your voice, and she raises her head to regard you.  Seeing the key to her love (both metaphorically and physically), her expression brightens exponentially.  She beams a brilliant and nearly blinding grin, allowing herself hope for the first time in quite a while.  \"<i>[name], did you... could you have...</i>\"");
            EngineCore.outputText("\n\nYou smile back at her even as you move towards her beloved construct, considering your actions to have much more impact than anything you might try to say.  With the giantess looking on, tears still ringing her eyes and hands clenching and unclenching in nervous anticipation, you reach the motionless tin knight.  You kneel to inspect him for hints on how to proceed, but the solution stares you in the face almost immediately: a hole square in the construct's back."
                    +"\n\nSmiling wryly at the luck, you ready the fancy-looking wind-up key and gently slide the instrument into the designated receptacle, nodding in satisfaction at the snug fit.  Glancing over your shoulder at the nervous entity behind you, you take a steadying breath and... turn the key."
                    +"\n\nClick."
                    +"\n\nThe sound, while small, resounds around the mountains in an extended echo, both of you holding your breath and uttering nary a whisper.  A shudder runs through the armor, snow sliding off the cold metal to pile up around it.  The soldier, North, sits up a little straighter, metal creaking against itself as he turns toward you.  The hollow gloom within gives way to a swirling obsidian cloud, and two shimmering dots of gold peer at you from its midst.  North stares at you for a moment, then turns his gaze skyward, meeting the gaze of the colossal girl."
                    +"\n\n\"<i>Hello,</i>\" North says softly, his hard exterior belying the gentle and peaceful tone of his voice.  Almost musical, you muse.  \"<i>I know you.  But...</i>\" he transfers his gaze back to you.  \"<i>I don't know you.  What do they call you?</i>\""
                    +"\n\nAdmittedly a little off-guard by his forwardness, you offer him a hand to help him rise while introducing yourself.  Surprisingly enough, he weighs much less than you would imagine, and he climbs to his feet easily enough."
                    +"\n\n\"<i>... Interesting,</i>\" he replies, tilting his head slightly as he continues to regard you.  You can't be sure, of course, but it seems like he's smiling - or at least as close to smiling as he can get with only eyes and that strange, assumedly magic fog roiling within his helmet.  Moving past you, North walks to the edge of the precipice, standing passively as his creator loomed over him."
                    +"\n\nFor many moments, they simply stand silently, until finally, the knight speaks.  \"<i>I'm back,</i>\" he declares lamely."
                    +"\n\nBefore either of you can react, one of her enormous hands sweeps down, snatching North up and bringing him to her lips.  Overwhelmed with emotion, the giantess lays kiss after kiss on the poor knight before hugging him to her breast and not letting go for many heartbeats.  Somewhat sheepishly, she replaces North on the outcropping, falling back and fixing her little creation with a hopelessly passionate gaze.  \"<i>Oh, North, my brave, sweet knight,</i>\" she sighs, struggling to keep her voice from cracking with her relief.  \"<i>Thank you so much, hero,</i>\" she continues, directing her appreciation towards you.  \"<i>I had almost given up my singular desire, but you somehow managed... Thank you...</i>\""
                    +"\n\nYou begin to retort with some modest response, but a small groan from North drags both your and the giantess's eyes to the knight.  As you watch, despite the magic most certainly injected into his being, the knight's form falters; his eyes dim and nearly wink out, and his movements become more and more sluggish as he struggles against his sudden lethargy.  You hasten to him as quick as you can manage, and the woman falls forward with an awful cry.  However, it seems the key is still firmly attached to his back, and that seemed to be the only thing that could have gone wrong."
                    +"\n\nThe giantess casts around desperately for something, anything to prevent her love - her creation - from leaving her again, but only peaks and snow greet her from any direction.  With another anguished scream that reverberates around the range, she scoops both of you up, cupping her hands and raising her knight and his rescuer up to her eyes.  Giant tears threatening to spill down her cheeks, her sobs renewed twice over, she stares helplessly as the light of life fizzles in North's eyes."
                    +"\n\nSomething changes in her eyes abruptly, however. Inspiration and determination replace desperation and panic in her visage.  \"<i>[name], quickly, sit North up.  I have no promises, but I have... an idea.</i>\""
                    +"\n\nYou doubt anything she does could help the poor, silent knight more than the magic key, but you oblige, pulling him up and facing him squarely to the spirit's face.  With only a moment of hesitation, she leans forward.  Remarkably, her lips almost seem to shift in tint, moving from pinkish blue to, apparently, pure white as she comes."
                    +"\n\nShe plants another kiss on her dying knight's visor - instantly, the air around you seemingly densifies, charged with surprising amounts of divine energy.  The pearly coloration of her lips crawls from her onto the metal, cascading down North's body.  The giantess's brow furrows as she concentrates her energy, forcing all of her energy from herself onto and into her love.  Finally, his entire ensemble dyed a magnificent and resonant alabaster, she leans back, eyeing you both with concern."
                    +"\n\nSuddenly, impossibly, North moans, shuddering into your hands as you continue to prop him up.  His eyes flare back to life, coiling inky cloud flowing into full form once more.  The giantess, looking as exhausted as she does relieved, sets you and North back down onto the cliff-face, taking extra care to set her revived creation down as gently as possible."
                    +"\n\n\"<i>Why am I still here?</i>\" North asks dreamily, disoriented and dazed from the morbid tug-of-war.  He glances down at his gauntlet.  \"<i>And why am I white?</i>\""
                    +"\n\nYou would like to know the same, in fact, and you look to the tearful woman in a bid for an explanation.  It's only then that you notice a lack of something you mostly took for granted until this moment: the ever-present swishing of her assumedly invisible wings.  Combining this observation and the sudden hint of haggardness in her features, you begin to put the pieces together.  She smiles wearily, nodding as if reading your thoughts.  \"<i>I fear to admit, you most likely can guess the reason for North's revival,</i>\" she says.  \"<i>Spirits possess a limited grasp of clerical ability, but certainly nothing applicable to poor North... at least, not until you acquired that key.  It's hard to explain, but a bit of... humanity, I suppose, was 'injected' into his body when you turned that key.  I knew this was a one-off chance to begin with - it's been subjected to age for centuries, and most of the magic must have been either relocated or removed.  I had to get more drastic, I'm afraid.  I am happy to say I do not regret my decision, but... well...</i>\""
                    +"\n\n\"<i>I am not an spirit anymore.</i>\""
                    +"\n\nThere it was; North wheezes in an approximation of a gasp, and you're profoundly reminded of the devotion from creator to creation.  You ask her what the loss entails."
                    +"\n\n\"<i>Ah... well, I suppose the most profound result is the loss of immortality,</i>\" she explains.  \"<i>While the key sparked his soul, I simply kept the flame going longer with my own... adding fuel, you could say...</i>\""
                    +"\n\nShe meant to go on, but North interrupts her.  \"<i>Wait,</i>\" he demands.  The giantess's train of thought is brought to a halt as she waits for her creation to proceed.  \"<i>You did this for me,</i>\" he begins, pulling himself to his feet.  \"<i>I don't have to know why, though I'm sad you had to.  I love you.</i>\""
                    +"\n\nThose three words, mentioned so suddenly, pierce the woman's heart as surely as any arrow, and hot tears finally track down her cheeks - not the bitter tears she barely choked back earlier, however.  She weeps now with one of the most profound expressions of pure joy you've ever experienced.");
            //{turn the page}
            EngineCore.menu();
            EngineCore.addButton(0, "Next", goodEndForChristmasMiracleICantII);
        }

        function goodEndForChristmasMiracleICantII():void {
            EngineCore.clearOutput();
            EngineCore.outputText("North throws his arms out wide, armor hardly protesting to the sudden movement.  The action gives the giantess pause for a moment, but she swiftly understands the motivation and raises her hand to the beckoning knight.  She crooks her little finger toward North, and he throws himself around it, expressing his feelings in a tight and passionate hug.  The giantess gazes down at her little knight with a loving smile, and they hold the pose for a remarkably long time."
                    +"\n\nThe seemingly divine titan worryingly crooks her eye over to you, and in an attempt to shoosh you away, she nods her head towards the mountain's exit, implying that they're going to spend some time to themselves. Of course, there's a chance you can probably stick around for some weird-ass action. Would you prefer to stay behind, or do you excuse them temporarily?");
            EngineCore.menu();
            EngineCore.addButton(0, "Stay", stayForPretendNTRGoodWinjobSex);
            EngineCore.addButton(4, "Leave", goodEndLeaveBeforeSexings);
        }

        //If Leave
        function goodEndLeaveBeforeSexings():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You get the message, feeling that letting them do their own thing might be for the best.  With a hasty pardon, you promptly turn around and walk a good twenty yards down the mountainside, idly playing in the snow while the two reunited lovebirds do their thing."
                    +"\n\nYou hear the sound of a gentle humming in the distance, and you figure that the two lovers might be quite done with their 'honeymoon'.");
            //[Go to Conclusion]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", conclusionOfGiantessGoodEnd);
        }

        //If Stay
        function stayForPretendNTRGoodWinjobSex():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You prefer to stay here, but the frosty giant has already gone back to her mechanical man, so you hold your explanation and continue to observe."
                    +"\n\nFinally, she draws away, North reluctantly releasing his hold on her pinky.  The giant woman unexpectedly groans, running her arms from her chest to what you could only assume to be her waist - you can't exactly see from your current perch, and as you wish to remain as impartial a bystander that you can in this situation, you don't bother inching to the edge of the cliff."
                    +"\n\nHer shoulders shift back, and with a little grunt, she... begins to raise herself, by the looks of it!  She shuffles back as her hips rise, lifting her butt above the cliff, and then slamming the soft pillows against the rock.  While it groans in protest, the overhang holds the weight well enough, leaving you and North face-to-face with his lover's titanic undercarriage."
                    +"\n\nHoisting herself up with her arms, the giantess peers over herself to get a good look at you, saying, \"<i>Having you back reminds me of so long ago, my big, strong knight.  [name], we had this trick we used to do... it's definitely a bit embarrassing, but since you did so much for us, your presence bothers me not at all.  Come to me, North, just like we used to...</i>\""
                    +"\n\nNodding calmly like he is wont to do, North steps forward until he's practically bumping into her anal star, then kneels, adopting a meditative pose.  You look on curiously, then blink your surprise when his armor trembles.  Out of the visor slot of his helmet flows North's ebony essence, drifting from his newly white 'body' straight towards his giant lover.  The gaseous black cloud makes a beeline for her swollen pubic mound.  Aiming only to please, North swirls and curls around the giantess's clitoris, and she nearly knocks her knees together with the pleasure tremors that jolt through her body."
                    +"\n\nThat being accomplished, the knight kicks his applications up a notch, breaking away from the throbbing and stimulated button and zooming straight toward the depths of her glistening and inviting folds.  She coos throatily, back arching and tongue lolling, as North penetrates and wriggles further into her pussy.  Blossoms of fog issue from the giantess's mouth with increased frequency as North tunnels deeper and deeper inside her; you idly marvel at how effective the little knight's tactics prove on his enormous lover."
                    +"\n\nWith a cry of simple pleasure, the giantess's arms buckle under her and she falls back, tumbling from her perch on the cliff and landing back-first.  Unable to sit idle while North has all the fun, she takes matters in her own hands, cupping a breast in one hand while the other slips down between her legs.  Her moans only intensify once she gets into the squeezing and caressing, scattering snow in all directions as she squirms along the valley, crying her pleasure for all to hear.");
            //LUST GAIN +20: IF 100:
            player.dynStats("lus", 10 + player.lib / 10, "scale", false);
            EngineCore.outputText("\n\n");
            if (player.lust >= player.maxLust()) {
                EngineCore.outputText("Despite yourself, your hands slowly begin crawling into your [armor] in pursuit of your naughty bits.  ");
            }
            EngineCore.outputText("\"<i>Aaaahn, North, you haven't lost your touch,</i>\" the giantess moans, kneading deeply into her chilled titflesh and barraging her already-titillated tunnel with three slender fingers.  Even from your position from on high, you can hear the squelches of her very well-lubricated fingering, and before you know it, the bottom part of your [armor] is off, and you're openly toying with your genitals, spurred on by the passionate internal embrace of the giant woman and her loving creation."
                    +"\n\nWithout notice, the sexually belaboured titan howls with newfound fervor.  Her breasts shudder noticeably, her already dusky breast-skin darkening slightly as their churning contents shift in composition.  The giantess's fingers fly from stroking her womanhood to grabbing the other breast, a line of glistening femcum trailing from her fingers and splattering against the mountains.  Efforts redoubled by her two-handed grip, she writhes in absolute orgasmic bliss even as her bosom swells up a bit."
                    +"\n\nYou can easily guess what's coming, even before the giantess's frenzied gasps give way to an almost anguished shriek of ecstasy.  Her butt rises off the ground, then slams back down, sending a snowy shockwave out in all directions and doing absolutely marvelous things to the suddenly-oscillating ass-flesh.  Even with the chilly breeze making sure her nipples will stay perpetually rock-stiff, you can see them puff up further and wiggle ominously from your perch.  Sure enough, her internal valves burst open, and twin geysers of milk - white, but a shade darker than what one would expect - spray into the air.");
            //IF LUST 100:
            if (player.lust >= player.maxLust()) {
                EngineCore.outputText("\n\nHer powerful climax nearly shakes the very bluff you're standing on, and the event is enough to force you over the edge");
                if (player.wetness() >= 4 || player.cumQ() >= 1000) EngineCore.outputText(" - figuratively, and literally, as well, as your fluids drip off the edge to add to the rain of sexual fluids the giantess is laying in the midst of");
                EngineCore.outputText(".");
            }
            EngineCore.outputText("\n\nFor many heartbeats she lays panting, basking in the afterglow of her and her lover's first outing in a long, long time.  Eventually, a stirring in the breast-milk coating her and the ground around her rouses her from her peaceful contemplations.  Just as you suspected, North had internally traveled from her vaginal passage to her enormous breasts, and escaped with the boobgasm that followed.  His shadow-essence separates from its milky prison to reform near the giantess's cheek.  She smiles warmly at him, and he hugs her cheek in response."
                    +"\n\nWith North in tow, the giantess lifts herself back up onto the cliff, allowing the knight to retreat back into his ashen armor.  He turns towards you, his golden orbs slightly eclipsed in what you can only assume to be his form of a happy expression.  \"<i>Thank you, hero,</i>\" he says, only managing the brief courtesy before he's swept up into his lover's arms and smashed against her cheek once more, in an even bigger and more passionate hug.");
            //IF MASTURBATED: 
            if (player.lust >= player.maxLust()) {
                EngineCore.outputText("\n\nYou take the opportunity to do up your [armor] before either of them notices.");
                player.orgasm();
            }
            //[Next]
            EngineCore.menu();
            EngineCore.addButton(0, "Next", conclusionOfGiantessGoodEnd);
        }

        //[Conclusion]
        function conclusionOfGiantessGoodEnd():void {
            EngineCore.clearOutput();
            EngineCore.outputText("The air is crisp, and the light powdering of snow floats through the air as if playing an invisible melody.  The warm couple are together.  Lifting her head, the giantess beams at you with a refreshing sense of spirit."
                    +"\n\n\"<i>I can't believe anything that has happened to me today... it's all thanks to you.  Thank you for bringing North back to me, and thank you for relighting a fire that had gone out so, so long ago.</i>\""
                    +"\n\nYou bow in some sense of obligation, yet the chestnut titaness giggles at your formality.  North automatically returns the gesture, and you all share a moment of laughter.  The mechanical soldier is lifted up by her lover and placed upon her shoulder, his legs dangling off the edge.  You give them a friendly nod and a happy smile before realizing how tired you were after this whole affair.  Telling the two as much, you chuckle victoriously, proud of your exploits and of the potential stories you could tell regarding the reunion of an spirit and her favorite little soldier."
                    +"\n\nThey both bid you farewell as you begin to walk off, North waving his arm far above his head and the tanned former spirit politely swaying her hand at the wrist.  With a reciprocated adieu, you turn and stride away.  \"<i>Oh, [name]!</i>\" the giantess calls, and you turn curiously to find her extending the little crystal key to you, clasped between two of her fingers and looking absolutely minuscule by comparison.  She easily reaches you despite the distance gained by your strides, and you receive the device readily.  \"<i>I want you to have this. Merry Christmas, [name].</i>\" You wish her a Merry Christmas in response, though call up blanks when trying to remember her name - It's then you realize that she had never given it in the first place. The spirit stops and laughs before pulling a thumbs up, just as you had done earlier."
                    +"\n\n\"<i>It's Carol.</i>\""
                    +"\n\nAfter a long pause, you pocket the key, square yourself with Carol and North, returning her hand gesture before giving them a goofy grin that positively sparks in the snow-cushioned landscape.  As you turn to depart once more, you wave over your shoulder, escorted out with the continued giggles and lovey-dovey conversation of the unlikely couple."
                    +"\n\nMerry Christmas indeed!");
            //[if you haven't been introduced to christmas via elf or otherwise] 
            if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] == 0) EngineCore.outputText("\n\nYou have no idea what that is.");
            EngineCore.awardAchievement("A Christmas Carol", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_II);
            //[end, get The North Star & A Christmas Carol perks]
            //The North Star
            //Witness picnic events with North & Carol at the High Mountain.
            //A Christmas Carol
            //Christmas events are open all year 'round! (some sort of arbitrary limit)
            //merry christmas everyone <3
            flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] = 1;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

    }

    public static function meetJackFrostInTheMountains():void {
        //const JACK_FROST_YEAR:int = 645;
        //const JACK_FROST_PROGRESS:int = 646;

        //Jack Frost and Snow
        /*
        The Flow:
        Meeting Jack
        Back in camp
        No followers
        Rathazul
        Izma
        Jojo
        Pure
        Corrupt
        [=Pen Ass=]
        [=Ride Cock=]
        [=Spank and Finger Ass=]
        Amily
        Pure
        [=Fuck Her=]
        [=Make out=]
        Corrupt
        Tainted Ember
        Marble (Written by TDM himself)
        With Kids
        Without kids
        Helia
        Isabella
        Kiha
        [=Fuck Her=]
        [=Lick Boobs and Finger Pussy=]
        Aftermath...
        
        The Flow:
        Notice snow in Mountain.
        Investigate to meet Jack.
        Request he makes it snow over the camp.
        Have fun with followers inside the camp.
        PC loses a day in this process.
        Meeting Jack
        */

        //Takes place when exploring the mountain.
        EngineCore.clearOutput();
        EngineCore.outputText("As you explore the mountainous heights, you come across something strange - a great spray of cold, wet, soft, creamy substance.  You realise with a start that it's snow!  You haven't even seen rain since you came to this world.  What's more, looking around shows you other strange drifts of snow; it almost looks like a path of some sort.  Curious, you decide to follow them, see if you can track down what's causing it."
                +"\n\nWhile hiking up the mountain you hear a strange masculine voice.  \"<i>Yeah, that should be enough... but this part needs some more!</i>\"  Shortly after you hear the faint, but distinct sound of someone masturbating furiously."
                +"\n\nCurious, you slink closer; that doesn't sound like any imp you've encountered so far... as you creep through the rocks, the target of your investigation suddenly lets out an ecstatic howl.  A great wooshing, roaring noise fills the air... which is the last thing you notice before something cold, wet and sticking lands on you in a massive flurry, knocking you to the ground and completely burying you."
                +"\n\nIn a panic, you claw your way free of the stuff - more snow, an absent part of you notices - and you find yourself face to face with the person you were investigating... and who you realize is responsible for your predicament."
                +"\n\nBefore you, hand around his gigantic cock, sits a man... judging by his size, you'd estimate him to be at least 12 feet tall, his surprisingly human-looking prick seems to be at least 4 feet long and 1 foot thick; a heavy pair of massive balls hang low, under his shaft.  He is completely naked, save for a loincloth that looks barely able to conceal his throbbing length, and atop his head you notice a series of icicles that seem to make up his hair, along with a pointy beard also made of ice."
                +"\n\nHe ignores you, too busy stroking himself off to care, when suddenly he lets out another moan and his cock bulges before disgorging another huge flurry of white - you narrowly avoid being struck in the face as it roars past to splatter down the mountain.  It looks like the snow you've been tracking is actually this strange fellow's ejaculate!"
                +"\n\nIt takes a while for his impressive orgasm to subside, but finally, he lets go of his hard throbbing shaft and moves his icy blue eyes to look at you.  \"<i>Oh, hey there little one, didn't see you sitting there.  Can I help you?</i>\""
                +"\n\nYou apologize for interrupting him, wary of disturbing someone so huge, but you thought you had encountered snow and, well, you were curious to find where it was coming from.  It's been so dry since you came to this land; you can't recall seeing snow before."
                +"\n\nHe scratches his neck and nods.  \"<i>Indeed, little one, lately there has been no snow... I have no idea why... this world used to be so nice... always covered in white by this time of the year... but it doesn't matter.  If there's no snow, uncle Jack will just have to make some!  Though I didn't expect THIS would be the way I'd be making it snow.</i>\"  He chuckles, giving his shaft a few extra pumps and spraying a bit of snow on the ground."
                +"\n\nYou nod your head in unfeigned sympathy and tell him that you can understand why he would miss the snow... considering there hasn't been even a single drop of rain ever since you stepped in this world, it's no wonder it hasn't snowed."
                +"\n\nYou sigh longingly.  Back in your own world, there would be much snow everywhere in your home village, and your people would be celebrating.  But it looks like you'll be missing it this year.  Nothing but rocks and dust in your camp."
                +"\n\n\"<i>Rock and dust, huh?  Now... that's no way to be spending Winterfest...</i>\"  He shakes his head.  \"<i>If you don't mind, little one, I could help you bring a bit of snowy joy to your camp... if you don't mind telling me where it is.</i>\"  Then he chuckles.  \"<i>And if you don't mind WHERE that snow is going to be cumming from.</i>\"  He laughs at his own joke."
                +"\n\nWhat do you say?  Do you take the ice giant's deal and get a day off playing in the snow on your camp?");
        //[Yes] [No]
        EngineCore.menu();
        EngineCore.addButton(0, "Yes", jizzSnowOnMyCampPlease);
        EngineCore.addButton(1, "No", noJizzingInMyCampPlease);

        //[=No=]
        function noJizzingInMyCampPlease():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You thank the giant for his offer, but you'll have to refuse.  You really can't take even one day off your quest."
                    +"\n\n\"<i>Pity... well, if you'll excuse me, this mountain ain't snowy enough just yet!</i>\"  He resumes his furious masturbation, spraying another gush of snow on the side of the mountain."
                    +"\n\nSeeing no reason to linger, you return to your camp.");
            flags[kFLAGS.JACK_FROST_YEAR] = date.fullYear;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //[=Yes=]
        function jizzSnowOnMyCampPlease():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You look around, and then find a convenient rock to climb.  From here, you can see your camp, and you indicate to the friendly giant where it is.  \"<i>Alright, I'll make sure to paint it white.</i>\"  He chuckles once more.  \"<i>I have a pretty good aim, I'll have you know, and my friend here can pump it far!</i>\"  He pats his enormous dick.  \"<i>Off you go, then.  And merry Winterfest.</i>\"  He smiles turning to point his gigantic prick at your camp and beginning to masturbate furiously."
                    +"\n\nYou thank him for the surprisingly kind gesture, and start to head back down to camp.  Even as you go, you can see the first huge jet of snow arcing its way across the sky...");
            flags[kFLAGS.JACK_FROST_YEAR] = date.fullYear;
            flags[kFLAGS.JACK_FROST_PROGRESS] = 1;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }
    }
    public static function processJackFrostEvent():void {
        //Back in camp
        EngineCore.hideUpDown();
        EngineCore.clearOutput();
        //Each follower PC has adds a block, having no followers just plays the no followers block.
        //Corrupts can forget about their lust for one day to play on the snow.
        if (flags[kFLAGS.JACK_FROST_PROGRESS] == 1) {
            EngineCore.outputText("As you approach your camp, you can see that Jack Frost's efforts are paying off.  A great, constant flurry of snowflakes is gently drifting down, swaying in the wind as it makes its inevitable descent towards the ground.  A layer of snowflakes is quickly building up, growing wider and deeper as more snow is launched from out of the mountains to rain down on your camp. You can't help but enjoy the cool air as the snowflakes fall down languidly onto the ground.  It's so beautiful you almost forget the rather perverted origin of it all.\n\n");
            flags[kFLAGS.JACK_FROST_PROGRESS] = 2;
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
        }
        //No followers
        else if (SceneLib.camp.companionsCount() == 0) {
            //Only if PC really has NO ONE to be with. aka: ForeverAlone.gif
            EngineCore.outputText("You sigh... this really reminds you of back home... you only wish you had someone to share this feeling with... Well, there is no reason you shouldn't enjoy yourself while it snows, so you set about rolling a big ball of snow to make a snowman out of...");
            //Skip to next day...
            flags[kFLAGS.JACK_FROST_PROGRESS] = 0;
            EngineCore.HPChange(EngineCore.maxHP(), false);
            EngineCore.fatigue(-100);
            EngineCore.doNext(SceneLib.camp.returnToCampUseEightHours);
        }
        //Rathazul
        else if (player.hasStatusEffect(StatusEffects.CampRathazul) && flags[kFLAGS.JACK_FROST_PROGRESS] == 2) {
            EngineCore.outputText("Rathazul approaches you.  \"<i>[name]?  What is going on?  It hasn't snowed in Mareth for years now.  And why only around the camp?  I wandered out to investigate, but outside there is no snow at all...</i>\" he asks, concerned."
                    +"\n\nYou tell Rathazul that you met a friendly... er... wizard up in the mountains who wanted to try and bring snow back to Mareth.  You offered to let him cast it out over your camp, so it's basically being flung from the mountains to land here.  But, really, why is he worrying about it?  This is the first time it's happened in years, doesn't he want to enjoy it while it lasts, before it melts away?"
                    +"\n\n\"<i>Maybe you're right... it has been a long time.</i>\"  Rathazul smiles.  \"<i>I think I would like to build a snowmouse.</i>\""
                    +"\n\nYou ask if he'd like a hand doing that, being as it's been so long since he had a chance to do that?  Rathazul nods.  \"<i>I would love it!  Help me with the base.</i>\""
                    +"\n\nYou begin gathering snow along with the old rat...");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
            flags[kFLAGS.JACK_FROST_PROGRESS] = 3;
        }
        //Izma
        else if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1 && flags[kFLAGS.JACK_FROST_PROGRESS] <= 3) {
            EngineCore.outputText("You wonder where Izma is; as a shark, maybe she doesn't like the cold?  Even as the thought crosses your mind, you note a surprisingly large pile of snow sitting not too far - with a very suspicious striped fin jutting out of it.  You rush over, calling for Izma and asking if she's all right."
                    +"\n\nThe mound snow suddenly explodes as Izma pounces you, knocking you on your back and pinning you against the snowy ground.  \"<i>Gotcha!</i>\"  At once she notices who it is she's pounced upon.  \"<i>Hi there, [name].</i>\""
                    +"\n\nYou tell her she's a bold one indeed to do something like that to you - isn't she supposed to be your beta?"
                    +"\n\nThe tigershark laughs.  \"<i>A pretty poor alpha you'd be if you can't have fun like this - I don't know what this cold white stuff is, but it's so neat!</i>\"  She promptly leaps off of you to dive into the snow, rolling around in it like a kid with a laugh.  \"<i>It's cold, but it feels so lovely - slippery and soft and smooth.  I think mom and dad used to talk about stuff like this when I was a kid - they called it 'snow', I think,</i>\" she says, flopping onto her belly in it."
                    +"\n\nYou're glad she's liking it, you tell her, getting up to brush the snow off you.  You tell her she should enjoy it while it lasts, you reckon it won't last more than a day..."
                    +"\n\nIzma sighs in disappointment.  \"<i>Guess I'll have to enjoy it while it's here, then,</i>\" she notes, sadly."
                    +"\n\nNow about that alpha-beta chat, you tell her... \"<i>What about it?</i>\"  You don't reply, simply pouncing her yourself and pinning her to the ground as you run your hands along her shark-tail.  You tell her to never forget her place.  \"<i>Oh?  Is that so?</i>\"  She purrs, wriggling her ass.  \"<i>Why don't you remind me of where my place is, hmm?  Now was that on top of me or under me...?</i>\"  She grins the sharp-toothed grin only a tigershark can grin."
                    +"\n\nYou'll be glad to demonstrate, you grin back.  \"<i>Oh, really?  So, what do you have in mind, my [name]?</i>\" she asks, feigning ignorance with terrible acting skills."
                    +"\n\nYou run your hand hands along her body, over the curves of her tits, her supple thighs, her hips and down her legs.   \"<i>Mmm... that feels so good, [name].  Though, if this is supposed to be dominant behavior, it doesn't really feel like it,</i>\" she reports lazily.  Oh really, now?  How about if you do this!  You press a point on her belly with your index finger.  The tigershark yelps in shock, but giggles in the obvious manner of someone who's been tickled.  With a smirk, you tell her that she's not the only one who knows about \"<i>pressure points</i>\".  You menacingly wiggle your fingers at her. \"<i>Ah... I don't suppose I can just say I'm sorry and I was only kidding around?</i>\"  Izma hesitantly suggests."
                    +"\n\nYou click your tongue, shaking your head.  You tell her that there is no escape from her destiny.  The shark-morph promptly twists around in the snow and tries to dive away from you, forgetting that snow isn't as reactive to such efforts as water would be.  You grab her shark-tail and pull her back. \"<i>No, please, don't!  Anything but that!</i>\"  Izma wails as she is dragged to her inevitable tickling doom."
                    +"\n\nYou begin tickling her breasts, belly, arms, anywhere your wiggling fingers can touch.  Izma cackles and screeches, tears running down her face even as she pleads for you to stop; evidently, that tough orange and black-striped skin doesn't make her any less vulnerable to a good tickling session.  You don't heed her pleas, continuing to tickle the tiger-shark with abandon.  \"<i>All right, all right, stopit-stopit-stopit, I'm sorry, I'm sorry!</i>\" she cries.  You tell her that if she wishes you to stop all she has to do is admit, you're the alpha and she's the beta...   The tigershark tries, you have to give her points for that, but she can't quite gasp the words out around her laughter.  You tell her that her performance was lacking, so if she'll excuse you... you have more tickling to do.  \"<i>No!  Please, no, I'm sorry, you're the alpha and I'm the beta and I'll never forget it again!</i>\" she cries.  Satisfied, you turn her around, giving her a quick kiss and a tap on her nose.  With a wink you tell her to never forget that again.  \"<i>I promise to always remember that  - I know who's the conqueror in our little relationship.</i>\"  She grins, displaying her shark fangs.  Smiling, you wish her Happy Holidays.  \"<i>Happy... whatever that is. I just hope our next ones aren't so painful,</i>\" she replies, clutching her side for emphasis."
                    +"\n\nYou promise her that they won't be... if she remembers not to start something she can't finish, tapping the chastened tigershark on the nose for emphasis.");
            EngineCore.addButton(0, "Next", processJackFrostEvent);
            flags[kFLAGS.JACK_FROST_PROGRESS] = 4;

        }
        //Jojo
        else if ((player.hasStatusEffect(StatusEffects.PureCampJojo) || SceneLib.jojoScene.campCorruptJojo()) && flags[kFLAGS.JACK_FROST_PROGRESS] <= 4) {
            //Pure
            if (player.hasStatusEffect(StatusEffects.PureCampJojo)) {
                EngineCore.outputText("Jojo is sitting on his usual rock, one hand out to catch snowflakes with a beatific smile of awe on his face.  \"<i>Look, [name], snow!  I haven't seen snow since I was a very, very small boy.</i>\"  He tells you."
                        +"\n\nSo is he enjoying it?  You ask.  If so, then it was worth it getting someone to make it snow on your camp."
                        +"\n\n\"<i>Yes, I'm enjoying it - it's a wonderful reminder of purer times.</i>\"  The mouse says, still catching flakes and watching them melt in the palms of his hands."
                        +"\n\nOut of the monk's sight you take a small bit of snow and slowly roll it into a ball.  Then taking your time to place your shot carefully, you swing your arm at full speed, hurling the small ball of snow right at the back of the white-furred monk's head."
                        +"\n\nThe snowball explodes as it lands, knocking Jojo right off his perch with a startled squeak.  \"<i>[name], what was that for!?</i>\" he splutters."
                        +"\n\nYou can't resist laughing out loud.  You were just testing to see if he had his guard up."
                        +"\n\nFaster than you would have expected, Jojo stoops down, rolls a snowball and smacks you right in the face with it.  \"<i>Two can play at that game,</i>\" he says, a faint grin playing on his features."
                        +"\n\nYou calmly wipe the snow off your face and smile evilly at the monk, asking him if he realizes this means war..."
                        +"\n\n\"<i>Bring it on,</i>\" Jojo states, already bouncing another snowball in his palm."
                        +"\n\nLaughter echoes as the two of you exchange snowballs...");
                EngineCore.menu();
                EngineCore.addButton(0, "Next", processJackFrostEvent);
                flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
            }
            //Corrupt
            else {
                EngineCore.outputText("Out in the outskirts of the camp you notice your pet mouse-slut Jojo, casually fucking a small mound of snow like an animal.  You laugh to yourself, now, now... doesn't he know that there are better things to fuck than a pitiful mound of snow on the ground..."
                        +"\n\nYou casually approach him from behind, stripping off your [armor].  Once behind his heart-shaped ass, you pull on his tail and reach down to grope at his shaft and balls.  Silly slut, you tell him.  This is not how one fucks in the snow... if he doesn't know how to do it right, you'll be happy to demonstrate.");
                //(How should you demonstrate?)
                //[Pen Ass] [Ride Cock] [Spank and Finger Ass]
                EngineCore.menu();
                if (player.hasCock()) EngineCore.addButton(0, "Pen Ass", penetradeCorruptJojoAss);
                if (player.hasVagina()) EngineCore.addButton(1, "Ride Cock", rideCorruptJojoCock);
                EngineCore.addButton(2, "Spank n Finger", spankNFingerCorruptJojoAss);
            }

        }
        //Amily
        //less than 5!
        else if (SceneLib.amilyScene.amilyFollower() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 5) {
            flags[kFLAGS.JACK_FROST_PROGRESS] = 6;
            //Pure
            if (!SceneLib.amilyScene.amilyCorrupt()) {
                EngineCore.outputText("Amily is warily prowling across the icy surface, occasionally glancing all around as if trying to spot an ambush.  Other times, she suddenly leaps up in a flurry, whirling around in mid-air as something catches her over-large ears.  All in all, it's quite obvious she's scared."
                        +"\n\nApproaching her, you ask what's gotten her so worried?"
                        +"\n\n\"<i>Can't you see all this snow?  There hasn't been snow in Mareth since I was a little baby girl - the demons must have something to do with this!</i>\"  Amily hisses, clearly expecting an attack to come at any moment."
                        +"\n\nYou can't help but laugh lightly at Amily's wariness.  There's no need to be this worried.  You're responsible for today's snowing as a matter of fact."
                        +"\n\n\"<i>...You are?</i>\" she asks in obvious bafflement - her tail actually curls itself into a crude question-mark shape behind her for emphasis."
                        +"\n\nYou nod.  You met someone who was capable of making it snow up in the mountains, and he was nice enough to offer to make it snow on your camp.  So you accepted it, you thought that everyone deserves a day of fun in the snow, where you can all forget the troubles of the world... at least for a day."
                        +"\n\nThe mouse smiles and then scampers through the snow to hug you fiercely.  \"<i>Oh, thank you, thank you!  It's so wonderful to see something like this again; it reminds me of what the world was like before the demons ruined everything... and it gives me hope that you'll stop them, too.</i>\" she says, nuzzling you in her affectionate overload."
                        +"\n\nYou laugh and hug her back, telling Amily to take it easy.  With all the friction the two of you are making, hugging together and nuzzling, you might just end up melting all the snow.  The mouse looks into your eyes. \"<i>Oooh, you little tempter, you,</i>\" she trills, tail looping around your wrist.  \"<i>Maybe I wouldn't mind that...?</i>\" she suggests mischievously."
                        +"\n\nYou grin at her then envelop her lips into a kiss... sounds like a plan, you're feeling a bit cold and this would be a nice way to warm you right up...");
                EngineCore.outputText("\n\nIt's not really possible to smirk and kiss at the same time, but your murine lover does her level best to try.  Breaking the kiss with a smile, she tugs you gently towards your " + SceneLib.camp.homeDesc() + ".  \"<i>Come on then, lover-" + player.mf("boy", "girl") + ", let's go and get warmed up...</i>\" She coos.  Her hands start to remove your clothes, \"<i>So, what do you have in mind, exactly...?</i>\"");
                //[Penetrate Her] [Make out]
                EngineCore.menu();
                if (player.hasCock()) EngineCore.addButton(0, "Penetrate", penetradePureMouseWaifu);
                EngineCore.addButton(1, "Ride Cock", makeOutWithPureMouseWaifu);
                return;
            }
            //Corrupt
            else {
                EngineCore.outputText("Out in the outskirts where your favorite cum-slut lives, you spot her slowly rubbing the snow over her erect nipples, the cold making her shiver in pleasure."
                        +"\n\nYou approach her with a smile, commenting that she seems to be enjoying herself..."
                        +"\n\nLooking up to you and kneeling obediently as her spaded mouse-tail waves lazily behind her, she smiles.  \"<i>Very much, [master].  I haven't seem snow ever since I was a little baby girl.  So seeing all this snow is such a turn-on for me, [master].</i>\""
                        +"\n\nYou laugh, telling her to enjoy it; then maybe, thank you later, since you're responsible for the snow."
                        +"\n\nAmily gasps.  \"<i>O - Of course!  I'm [master]'s loyal cum-guzzling mouse-slut.  I'm ready to serve anytime!  Thank you for letting me play in the snow.</i>\"  She grins gratefully at you."
                        +"\n\nYou pat her on the head, telling her she's welcome...");
                //(if PC has genitals)
                if (player.gender > 0) {
                    EngineCore.outputText("\n\nStopping to scratch your chin in thought... you ask how she would like a cum-cone?"
                            +"\n\nAmily smiles with glee.  \"<i>Oh, I would love it [master]...</i>\"");

                    //(if PC has a dick)
                    if (player.hasCock()) {
                        EngineCore.outputText("\n\nYou strip off your lower garments, exposing your [cocks] to the hungry eyes of your cumslut.  You tell her you would like her to give you a \"<i>hand</i>\", with the extraction process..."
                                +"\n\nAmily bows respectfully.  \"<i>Right away, [master].</i>\""
                                +"\n\nShe promptly takes hold of your [cock] with awe-filled respect, her long, dextrous fingers quickly falling into the familiar rhythym of dancing along your cock to fill you with the most wonderous sensations.  Her spaded tail wiggles idly for several moments, then slithers through the air to brush its feather-like tip against the tip and underside of your shaft");
                        if (player.balls > 0) EngineCore.outputText(", even tickling your [balls]");
                        else if (player.hasVagina()) EngineCore.outputText(", even tickling your [cunt] for added tantalization");
                        EngineCore.outputText("."
                                +"\n\nFeeling yourself getting close, you pull away from the corrupt mousette and aim yourself at a particularly soft-looking mound of snow.  With a few more pumps you moan and blast your load, soaking the snow in spunk.  You tell Amily there she has it... her cum-cone is ready for the picking."
                                +"\n\n\"<i>Oh, [master]!  Thank you, thank you, thank you!</i>\"  She claps her hands in delight, moving over to gather a handful of snow and eat it all up.  \"<i>Hmm... delicious and refreshing... thank you, [master].</i>\"  You pat her on her head and redress yourself, moving away...");
                    }
                    else { //if PC has a vagina
                        EngineCore.outputText("\n\nYou strip off your lower garments, exposing your [vagina] to the hungry eyes of your cumslut.  You tell her you would like her to give you a \"<i>hand</i>\", with the extraction process..."
                                +"\n\nAmily bows respectfully.  \"<i>Right away, [master].</i>\"  She quickly slides through the snow into position, kneeling before you with all the respect of a devout nun at prayer, and begins to run her nimble fingers expertly through your cunt, tickling and fondling your [clit] with her long spade-tipped tail as her fingers probe and slide through your netherlips, sending sparks coursing through your being."
                                +"\n\nFeeling yourself getting close, you pull away from the corrupt mousette and stand over a particularly soft-looking mound of snow.  With a few more prods from your questing fingers and a little pinch on your [clit] you moan throatily and let your femcum spill out of your [vagina].  Wave after wave of juices spill, sliding along your [legs] to mat the white snow.  By the time you're done the whole area around you smells of pussy juice and sex... truly a delightful aroma."
                                +"\n\n\"<i>Slut!</i>\" you tell, calling Amily to attention, who seemed to be just a little too distracted with the fumes of your recent climax.  \"<i>Y - Yes, [master]?</i>\"  You tell her to eat it all up, and enjoy her juicy cum-cone."
                                +"\n\n\"<i>Oh, [master]!  Thank you, thank you, thank you!</i>\"  She claps her hands in delight, moving over to gather a handful of snow and eat it all up.  \"<i>Hmm... sweet and refreshing... thank you, mistress.</i>\"  You pat her on her head and redress yourself, moving away...");
                    }
                }
            }
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);

        }
        //Tainted Ember
        else if (SceneLib.emberScene.followerEmber() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 6) {
            flags[kFLAGS.JACK_FROST_PROGRESS] = 7;
            EngineCore.outputText("The dragon is wandering your camp in open fascination.  \"<i>What is this weird white stuff?  It's cold and wet... but soft and fluffy, too,</i>\" " + SceneLib.emberScene.emberMF("he", "she") + " says, gently catching a snowflake."
                    +"\n\nHaving heard " + SceneLib.emberScene.emberMF("his", "her") + " question, you approach Ember and tell " + SceneLib.emberScene.emberMF("him", "her") + " that's just snow."
                    +"\n\n\"<i>Snow...?</i>\" " + SceneLib.emberScene.emberMF("He", "She") + " repeats in a curious, blatantly awed voice.  \"<i>...It's so pretty.</i>\" " + SceneLib.emberScene.emberMF("he", "she") + " tells you."
                    +"\n\nYou ask if this is " + SceneLib.emberScene.emberMF("his", "her") + " first time seeing snow.  It always snowed back home around this time of the year.  Why... back when you were a child, you used to play all the time in the snow."
                    +"\n\n\"<i>So it's for kids,</i>\" Ember notes, sounding kind of depressed - and a little envious, especially given the way she still looks so eagerly at the snow all around you."
                    +"\n\nPerhaps... would " + SceneLib.emberScene.emberMF("he", "she") + " like to play in the snow with you?"
                    +"\n\n\"<i>I thought you said this was for little kids?  I'm no baby!</i>\" Ember protests."
                    +"\n\nWho said it was just for kids?  You just said you used to play all the time when you were a child, there is no reason why you couldn't play now that you're grown up either... after all, back in your village, even adults played in the snow.  Unless... " + SceneLib.emberScene.emberMF("he", "she") + " doesn't like the idea of spending the day playing with you?  That would be a pity, since it's " + SceneLib.emberScene.emberMF("his", "her") + " first time seeing snow..."
                    +"\n\n\"<i>What?  I... ooh, very well.  Teach me how you play with this stuff,</i>\" Ember says, blowing a thin trail of steam out of each nostril."
                    +"\n\nYou smile and begin explaining to the dragon all about the games you used to play when it snowed back home.  Ember listens attentively with a gleam in " + SceneLib.emberScene.emberMF("his", "her") + " eyes."
                    +"\n\nBy the time you're done Ember's tail is waving excitedly behind her.  You ask how she'd feel about a snowball fight?"
                    +"\n\n\"<i>All right, let's try it!</i>\" " + SceneLib.emberScene.emberMF("he", "she") + " agrees, as eager as any kid back in Ingnam."
                    +"\n\nYou explain to " + SceneLib.emberScene.emberMF("him", "her") + " the rules and walk a short distance away... then declare the match started!  Ember is pretty good... but being " + SceneLib.emberScene.emberMF("his", "her") + " first time doing this, " + SceneLib.emberScene.emberMF("he", "she") + " ends up not being able to hit you as many times as you hit " + SceneLib.emberScene.emberMF("him", "her") + ", while you expertly dodge and roll her snowballs."
                    +"\n\n\"<i>Damn it, stand still, [name]!  You're slippier than the rabbits I go catching in the mornings!</i>\" the irate dragon complains."
                    +"\n\nRather than complaining " + SceneLib.emberScene.emberMF("he", "she") + " should be focusing on hitting you, otherwise you're going to end up crushing " + SceneLib.emberScene.emberMF("him", "her") + " in this match!  You tease " + SceneLib.emberScene.emberMF("him", "her") + ", throwing another snowball right on " + SceneLib.emberScene.emberMF("his", "her") + " belly."
                    +"\n\nThe dragon promptly drops to " + SceneLib.emberScene.emberMF("him", "her") + " knees and starts sweeping together huge armfuls of snow, crushing and melding them together until " + SceneLib.emberScene.emberMF("he", "she") + " has made a snowball the size of a small boulder, which " + SceneLib.emberScene.emberMF("he", "she") + " promptly hurls at you."
                    +"\n\nWoah!  The large ball of snow connects squarely with your face, bowling you over and burying you under the snow.  Having the air knocked out of you, you scramble to dig yourself off the snow."
                    +"\n\nA pair of claw-fingered hands promptly come clawing their way through the snow, grabbing you by the shoulders and pulling you bodily out of the snow.  \"<i>Well?  I think I won that round,</i>\" " + SceneLib.emberScene.emberMF("he", "she") + " gloats, a twinkle of delight in " + SceneLib.emberScene.emberMF("his", "her") + " eye."
                    +"\n\nCoughing up some snow, you concede defeat, congratulating Ember on winning " + SceneLib.emberScene.emberMF("his", "her") + " first snowball fight... but then, you smirk and tell " + SceneLib.emberScene.emberMF("him", "her") + " this was all beginner's luck... and next time you'll beat " + SceneLib.emberScene.emberMF("him", "her") + " for sure."
                    +"\n\n\"<i>So you say, but the truth is you know you'll never beat me,</i>\" Ember brags.  Then " + SceneLib.emberScene.emberMF("he", "she") + " lowers her eyelids and gives you a coy look.  \"<i>And now, for the victor, a prize,</i>\" " + SceneLib.emberScene.emberMF("he", "she") + " growls, then swoops in to kiss you passionately.  Several minutes pass before " + SceneLib.emberScene.emberMF("he", "she") + " breaks the kiss, a somewhat goofy smile on " + SceneLib.emberScene.emberMF("his", "her") + " face.  \"<i>I'm going to go and play in the snow some more.  See you, [name].</i>\"  " + SceneLib.emberScene.emberMF("He", "She") + " giggles, then ambles off."
                    +"\n\nYou wave " + SceneLib.emberScene.emberMF("him", "her") + " away - maybe being beaten isn't so bad.  Your thoughts turn to Ember's passionate kiss...  It certainly is a nice sight, to see " + SceneLib.emberScene.emberMF("him", "her") + " so happy.  Having it snow on your camp was a great idea after all.");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
        }
        //Marble (Written by TDM himself)
        else if (flags[kFLAGS.JACK_FROST_PROGRESS] <= 7 && player.hasStatusEffect(StatusEffects.CampMarble)) {
            flags[kFLAGS.JACK_FROST_PROGRESS] = 8;
            //With Kids
            if (flags[kFLAGS.MARBLE_KIDS] > 0 && flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] >= 100) {
                EngineCore.outputText("You find Marble simply staring into the sky, a look of wonder covering her face.  Dancing around her in excitement ");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("are ");
                else EngineCore.outputText("is ");
                EngineCore.outputText("your kid");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("s");
                EngineCore.outputText(", playing in the snow, blowing the snow, and experimenting with the snow.  Exactly what ");
                if (flags[kFLAGS.MARBLE_KIDS] == 1) EngineCore.outputText("she");
                else EngineCore.outputText("they");
                EngineCore.outputText(" are up to at any given moment is really hard to say, and you're not even sure that the little girl");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("s");
                EngineCore.outputText(" know");
                if (flags[kFLAGS.MARBLE_KIDS] == 1) EngineCore.outputText("s herself.");
                else EngineCore.outputText(" themselves.");

                EngineCore.outputText("\n\nMarble lifts up her hand, then takes a step forward as you approach.  It looks like she is about to catch a flake in her hands, only to instead suddenly slip on the frozen ground under her hooves, and fall down onto her backside with a cry of surprise.  \"<i>Oww...</i>\" she grumbles, giving her backside a rub as you come up in front of her.  You tell her to be careful, that stuff can be slippery while extending your hand to help her up.  \"<i>Yeah, thanks sweetie, I noticed.</i>\" she sighs and accepts your hand."
                        +"\n\n\"<i>[name], do you know what this is?</i>\" your lover asks while raising her arms in the air and looking around in amazement once more.  \"<i>How can stuff fall from the sky?</i>\"  You laugh, and say that it's snow, or frozen rain.  The cow-girl looks at you in confusion once more and asks what rain is.  Now it is your turn to be surprised, she has never seen it rain before in her life?  It has never gotten cloudy and water has fallen from the sky?  Marble shakes her head no, \"<i>Sweetie, I'm not sure what a cloud is either.  Every day of my life has always been sunny and warm.  This is something I've never experienced before...</i>\""
                        +"\n\nYou're left at a loss for words once more, and the two of you turn back to look at your ");
                if (flags[kFLAGS.MARBLE_KIDS] == 1) EngineCore.outputText("child");
                else EngineCore.outputText("children");
                EngineCore.outputText(" playing together once more.  A moment later, Marble puts her hand to her expansive backend again, before suddenly exclaiming again in realization.  \"<i>Sweetie, watch our kid");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("s");
                EngineCore.outputText(" for a moment, I'll be right back!</i>\" and she leaves the camp as quickly as she can, without slipping and falling on her ass again."
                        +"\n\nYou certainly don't mind staying behind for now, it is certainly a lot of fun spending time with your kid");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("s");
                EngineCore.outputText(" and just having fun.  Your cow-girl daughters are certainly not lacking in energy in the cold snow, their fur covered legs and built in shoes probably help a lot with this.  ");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("They");
                else EngineCore.outputText("She");
                EngineCore.outputText(" listen");
                if (flags[kFLAGS.MARBLE_KIDS] == 1) EngineCore.outputText("s");
                EngineCore.outputText(" with rapt attention when you explain what snow is, and about all the things you use to do in it back home.  Hands-on demonstrations are also in high demand."
                        +"\n\nWhen Marble returns, she can't find a single face that isn't showing a huge smile.  That isn't to say that there wasn't more excitement when what she went off to get is revealed; a big sled for the little one");
                if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("s");
                EngineCore.outputText(" to ride on!  Happy cries of joy fill the air for some time, as you and Marble take turns in giving rides on the sled.");

                //PC strength check:
                //(>=85)
                if (player.str >= 85) {
                    EngineCore.outputText("\n\nIt would seem that your strength has won you more favor with ");
                    if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("the girls");
                    else EngineCore.outputText("your daughter");
                    EngineCore.outputText(" when it comes to giving sled rides, Marble doesn't seem to mind too much though.  Your mate actually decides to join in the riding part after a while!");
                }
                //(60-84)
                else if (player.str >= 60) {
                    EngineCore.outputText("\n\nSoon you and Marble turn the sled rides into a friendly contest, trying to earn the favor of ");
                    if (flags[kFLAGS.MARBLE_KIDS] > 1) EngineCore.outputText("the girls");
                    else EngineCore.outputText("your daughter");
                    EngineCore.outputText(" in deciding who gives the best rides.  In the end, a clear winner is never decided, but everyone agrees that it was a lot of fun.");
                }
                //(<=59)
                else {
                    EngineCore.outputText("\n\nOf course, Marble's great strength soon shows you that you simply can't compete with her when it comes to giving sled rides.  Instead, you end up joining in with the kids and have fun riding with them as Marble pulls you all around on the snow with a smile on her face.");
                }

                EngineCore.outputText("\n\nAfter the sled rides end, you all cuddle up together under the blankets Marble put in the nursery for the kids that seldom get used.  There isn't much else to be said, and everyone just relaxes and enjoys the combined warmth that your bodies bring.");
            }
            //Without kids
            else {
                EngineCore.outputText("You find Marble simply staring into the sky, a look of wonder covering her face.  She lifts up her hand, then takes a step forward as you approach.  It looks like she is about to catch a flake in her hands, only to instead suddenly slip on the frozen ground under her hoofs, and fall down onto her backside with a cry of surprise.  \"<i>Oww...</i>\" she grumbles, giving her backside a rub as you come up in front of her.  You tell her to be careful, that stuff can be slippery while extending your hand to help her up.  \"<i>Yeah, thanks sweetie, I noticed,</i>\" she sighs and accepts your hand."
                        +"\n\n\"<i>[name], do you know what this is?</i>\" your lover asks while raising her arms in the air and looking around in amazement once more.  \"<i>How can stuff fall from the sky?</i>\"  You laugh, and say that it's snow, or frozen rain.  The cow-girl looks at you in confusion once more and asks what rain is.  Now it is your turn to be surprised, she has never seen it rain before in her life?  It has never gotten cloudy and water has fallen from the sky?  Marble shakes her head no, \"<i>Sweetie, I'm not sure what a cloud is either.  Every day of my life has always been sunny and warm.  This is something I've never experienced before....</i>\""
                        +"\n\nYou're left at a loss for words once more, and the two of you turn back to look at the snow once more.  You feel Marble gently take a hold of your hand as you two simply watch the flakes fall to the ground.");

                //PC height check:
                //(greater than 75 inches)
                if (player.tallness > 75) EngineCore.outputText("\n\nMarble leans against you, and gently asks, \"<i>Sweetie, will you please tell me about the snow and rain?</i>\"");
                //(less than, or equal to 75 inches)
                else EngineCore.outputText("\n\nMarble pulls on you to get you to lean against her, and gently asks, \"<i>Sweetie, will you please tell me about the snow and rain?</i>\"");

                EngineCore.outputText("\n\nYou start to speak, slowly at first, but pick up speed as you go.  You tell her about the patter of raindrops on the roof of your home, and about the feel of water droplets falling on your face when running outside.  Of the snow flurries that can fill the air for days, and about the new great white landscapes that they brought.  Finally you tell her about how the land looks and smells refreshed at the end of a rainfall, and the games that you and the other kids use to play in the refreshed land, or in the snow drifts."
                        +"\n\nYou finish, and silence once again fills the air as you two continue to watch the snow fall.  \"<i>Sweetie?</i>\" Marble suddenly speaks out, \"<i>I want to have kids with you some day.</i>\"  You look at her somewhat surprised, she continues to simply look ahead, continuing, \"<i>I want them to experience those things too, and there is no one else that I'd rather have them with then you.</i>\"  There isn't much else to do but to look back at the falling flakes once more.");
            }
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);

        }
        //Helia
        //if she ain't a follower and is a lover, just have her visit.
        else if (flags[kFLAGS.JACK_FROST_PROGRESS] <= 9 && (SceneLib.helScene.fuckBuddyHel() || SceneLib.helFollower.followerHel())) {

            EngineCore.outputText("\"<i>Hey, champ, what's going on here?</i>\"  Helia calls as she sees you approach.  Gentle trails of steam are wafting from the salamander's body as her own internal heat melts any snow that builds up on her."
                    +"\n\nYou greet your salamander lover, telling her you found a way to make it snow on your camp... so you were just planning on having a snow-day play-day on your camp, while it lasts."
                    +"\n\n\"<i>What's a snow-day play-day?</i>\"  The firey lizard-girl asks, clearly not understanding the reference; it may not have snowed in the plains even before this accursed drought."
                    +"\n\nYou explain to her it's just having fun in the snow... something you used to do a lot as a child.  You'd build snowmen, make snow angels, have a snowball fight-"
                    +"\n\n\"<i>Fight? Now you're talking my language!</i>\"  Helia cheers.  The cloud of steam around her gets even denser as she starts melting the snow she's standing in.  You give her a wry glance and point out she can't really participate if she's so hot that the snowballs melt to slush in her hands."
                    +"\n\nHelia doesn't listen as she hurls a handful of water straight at you, splashing your face with molten snow.  \"<i>Looks like I hit you pretty well there!</i>\"  She laughs uproariously.  Well... if this is how she intends to play... You quickly roll up a ball of snow of your own and toss it at her!  It connects with a hiss as the snowball quickly melts off her body."
                    +"\n\n\"<i>All right!  Now let's get this party started!</i>\" she cries, doing her best to grab handfuls of melting slush and hurl them at you before they completely dissolve."
                    +"\n\nYou enjoy your 'battle' with Helia a while longer.  Eventually, you're completely soaked, water dripping off your [armor].  You ask for Helia to stop for a moment, shivering as the cold finally gets to you."
                    +"\n\nHelia sighs, obviously disappointed, but complies.  \"<i>You know, now that you're so cold, I got the perfect way to warm you up...</i>\"  She smirks, squeezing her sizable dark-skinned breasts to make you perfectly aware of what she's suggesting."
                    +"\n\nCold and not willing to keep the salamander-girl waiting, you eagerly strip off your [armor] and pounce towards her..."
                    +"\n\nYou are rather surprised when Helia fends you off, knocking you into the snow.  She clicks her tongue and waggles her finger at you, her expression highly amused.  \"<i>Sorry, pervy, but I didn't mean sex... not that I would say no to a nice tumble afterwards,</i>\" she leers."
                    +"\n\nYou wipe the snow off your face and ask her what she has in mind, if not that?");
            EngineCore.outputText("\n\nWithout words, the fiery lizard-woman shucks off her clothes until she is standing naked in the snow before you, striking a pose that shows off her muscles (and also, by sheer coincidence, her boobs and ass), allowing flakes of snow to fall upon her and sizzle into steam.  \"<i>Why, a good hard wrestle, lover!</i>\"  She grins, and then suddenly she springs at you!");
            //(Speed check)
            if (player.spe / 20 + Utils.rand(20) > 11) {
                EngineCore.outputText("\n\nYou're surprised by the sudden lunge, but thankfully your well trained reflexes means you quickly duck under the pouncing salamander and watch as she falls face-first into the snow behind you with an audible \"<i>Oof!</i>\""
                        +"\n\nShe laughs as she surfaces amidst a spray of slush, whipping her long hair around.  \"<i>That's the way to do it, lover-" + player.mf("boy", "girl") + "!</i>\" she crows.");
            }
            else {
                EngineCore.outputText("\n\nYou yelp in surprise as the salamander comes crashing down on you, pinning you to the floor and holding your shoulders."
                        +"\n\n\"<i>Look at that; I think I win already,</i>\" she laughs.  Not if you can help it!  You give a sly smirk.");
            }
            EngineCore.outputText("\n\nThe two of you toss and turn, trying to pin each other down on the wet ground, but it's quite a difficult task.  Not only is Helia pretty good at this, but the wet snow also makes her skin and scales become so slippery that she manages to easily escape from your pins and holds.  Of course, this also works to your advantage when you get pinned yourself."
                    +"\n\nThat's not to say Helia gives up, insistently diving and scrambling, wrestling with all the sinewy strength her body is capable of mustering.  By the time you've both burnt up your energy, the snow in a meter-wide circle has been melted into slushy mud and the two of you are both steaming in the chill air.  Helia leans against you, your mutual exhaustion grounds for a truce, heaving for air.  \"<i>Now that is what I call a fun little workout, [name],</i>\" she tells you."
                    +"\n\nYou wipe some moisture from your brow, nodding agreement.  Yeah, that was pretty fun... you didn't think wrestling could be this fun, nor this sexy, you point out");
            if (player.gender > 0) {
                EngineCore.outputText(", as evidenced by ");
                if (player.hasCock()) EngineCore.outputText("your erect " + player.multiCockDescriptLight());
                if (player.gender == 3) EngineCore.outputText(" and ");
                else if (player.hasVagina()) EngineCore.outputText("your ");
                if (player.hasVagina()) EngineCore.outputText("dripping [vagina]");
            }
            EngineCore.outputText("."
                    +"\n\n\"<i>Heh, yeah, a nice wrestle in the wet's always been like that for us salamanders,</i>\" Helia laughs.   \"<i>Don't worry, sexy, we'll take care of that in a minute... but first!</i>\"  She suddenly turns and lunges at you, knocking you over and pinning you to the ground, thanks to the advantage of attacking while your guard was off.  Your shocked yelp is promptly smothered as she kisses you fiercely, grinding her sopping-wet gash against your crotch."
                    +"\n\nYou kiss her back, trying your best to turn the tables on the fiery salamander, rubbing your body against hers with as much enthusiasm as her.  Breaking the kiss shortly, you tell her that was a pretty low move, and call her a cheater."
                    +"\n\n\"<i>All's fair in love and war, [name], and when you're with a salamander, it's often hard to tell the difference,</i>\" Helia laughs, then promptly cuts off any further attempt at conversation by sticking her tongue in your mouth, her fiery tail coiling around your [hips] to brush its warm tip lustfully over your [ass]."
                    +"\n\nUnwilling to engage in any further conversation, you resolve to simply accept Helia's playful affections.  You grind yourself against her, feeling the fire of your combined lusts heat your bodies.  The snow that falls on top of your grinding bodies ensure that the area around you is always partially obscured by steam.  With your fierce making out, it's no surprise when you feel a familiar feeling build up inside you."
                    +"\n\nThe salamander suddenly cries out, steaming-hot femcum splashing across your [legs] as she orgasms first, spasming from her position atop you before falling limp with an ecstatic sigh, giving you free reign to do what you want.  Not that you could do anything, yourself, since you suddenly spasm and cries out as your own orgasm overwhelms you.");

            //(If PC has a cock)
            if (player.hasCock()) EngineCore.outputText("  A torrent of seed splashes against Helia's taut belly, as [eachCock] throbs and spews its seed while sandwiched between the two of you.");
            //(if PC has a pussy)
            if (player.hasVagina()) EngineCore.outputText("  Your [vagina] quivers and spill your juices with the force of a wave.  Moisture falls on the ground to join in with Helia's own discharge.");

            EngineCore.outputText("\n\nAs you finally finish cumming, Helia lifts her head and starts to laugh.  \"<i>Oh, man, not how I'd usually do it, but whoo, what a ride, huh?</i>\" she laughs.  You laugh as well.  It certainly felt good, though this is far from what you're used to.  You have to give Helia's wrestling idea some credit.  Rolling around with her, grinding together was pretty hot - in more ways than one."
                    +"\n\n\"<i>Oh, were you maybe wanting another turn, lover?</i>\"  Helia insinuates, gently tapping her fingers on your chest.  You make a show of considering her offer, then, with a smile, say that sounds like a reasonable proposal.  You promptly wrap the salamander-girl, into a tight hug, spreading her legs so you can have access to her dripping vagina...");
            flags[kFLAGS.JACK_FROST_PROGRESS] = 10;
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);

        }
        //Isabella
        else if (SceneLib.isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 10) {
            EngineCore.outputText("The bovine adventurer Isabella is staring at the snow around her with a sad look on her face, one hand gently raised to catch snowflakes.  She watches them gather in her palm and heaves a huge sigh.  You quietly approach her and ask what's wrong; is she homesick?"
                    +"\n\n\"<i>");
            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("Da, [name], I am,");
            else EngineCore.outputText("Yes, [name], I am,");
            EngineCore.outputText("</i>\" she replies.  ");
            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\"<i>Back home, in mine land, it vould be snowing all over at this time of year, and ve vould be having big vinter festival to celebrate ze ending of old year and coming of new year.  This land, it is so dry and hot...  I had forgotten it, but seeing zis snow makes me remember it and all I have lost by being stuck here.</i>\"  She sighs.");
            else EngineCore.outputText("\"<i>Back home, in my old land, it would be snowing all over at this time of year, and we would be having a big winter festival to celebrate the ending of the old year and the coming of the new one.  This land, it's so dry and hot...  I had forgotten it, but seeing this snow makes me remember it and all I have lost by being stuck here.</i>\"  She sighs.");

            EngineCore.outputText("\n\nYes, you agree.  It does bring back memories.  Though you don't know if you've been in this world quite as long as Isabella has.  You chuckle to yourself.  If you were back in your village, you and your family would be gathering for a big feast, playing in the snow, drinking, laughing... all the jolly good stuff.  Still, at least you're not alone here in Mareth.  You look at Isabella with a smile.");

            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\n\"<i>So, you are having a celebration at this time of year too?  How coincidental,</i>\" she muses, but then favors you with a friendly smile.  \"<i>But, da, it is good zat ve have found each other and so must not be lonely at zis time of year.</i>\"  Then she sighs, \"<i>I could use a nice hot cup of yochalot, though.</i>\"");
            else EngineCore.outputText("\n\n\"<i>So, you have a celebration at this time of year too?  How coincidental,</i>\" she muses, but then favors you with a friendly smile.  \"<i>But, yeah, it's good that we have found each other and have each other's company at this time of year.</i>\"  Then she sighs, \"<i>I could use a nice hot cup of yochalot, though.</i>\"");
            EngineCore.outputText("\n\nYochalot?  You ask in curiosity.");
            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\n\"<i>Da, yochalot.  It is very sweet, tasty treat, made from grinding up special bean seeds.  We add powder to warm milk and it is most yummy, mmm...</i>\"  Isabella makes a show of rubbing her hands over her belly with a delighted smile.  \"<i>I would always have a great big mug of hot yochalot at this time of year, ja?</i>\"");
            else EngineCore.outputText("\n\n\"<i>Yep! Yochalot.  It's a very sweet, tasty treat, made from grinding up special bean seeds.  We add powder to warm milk and it is most yummy, mmm...</i>\"  Isabella makes a show of rubbing her hands over her belly with a delighted smile.  \"<i>I would always have a great big mug of hot yochalot at this time of year.</i>\"");
            EngineCore.outputText("\n\nYochalot... sounds a lot like chocolate...  Still, you'd like to try it sometime.  You tell the cow-girl as much.");

            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\nAt this, she looks crestfallen.  \"<i>I am sorry, mein little sweety, but I am having no yochalot on me - I drank ze last of mine some time ago, and I do not think zey have such thing in this vorld any more.  At least, none that has not been tampered with, like the demons have ruined so many other nice things.</i>\"  She scowls.  \"<i>The only thing I could be offering you is nice, warm milk, fresh from the tap, so to speak.</i>\"  She pats her hefty quad-nippled boobs to make it clear where the milk would come from.");
            else EngineCore.outputText("\n\nAt this, she looks crestfallen.  \"<i>I am sorry, my little sweet, but I don't have any yochalot on me - I drank the last of mine some time ago, and I don't think they have such thing in this world any more.  At least, none that have not been doubtlessly tampered with, like the demons have ruined so many other nice things.</i>\"  She scowls.  \"<i>The only thing I could be offering you is nice, warm milk, fresh from the tap, so to speak.</i>\"  She pats her hefty quad-nippled boobs to make it clear where the milk would come from.");

            EngineCore.outputText("\n\nPity, but then again, Isabella's milk is pretty tasty.  You confess you're feeling at least a bit chilly, so, you ask the cow-girl if she wouldn't mind warming you up with some of her sweet-tasting milk?");

            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\nIsabella looks surprised, and then grins mischievously.  \"<i>Okay then, mein sweet,</i>\" she says, calmly exposing her breasts.  \"<i>I vill give you all ze milk you could want,</i>\" she adds, then suddenly lunges for you, grabbing your head and pulling you into a headlock that, not so coincidentally, mashes your face against her naked boobs.  \"<i>Naughty, cheeky [name]!  If you are wanting to drink mein milk, zen you are not needing zis subterfuge to get me in the mood,</i>\" she chortles good-naturedly as she finishes, her homesickness evidently forgotten with the diversion you've presented her.");
            else EngineCore.outputText("\n\nIsabella looks surprised, and then grins mischievously.  \"<i>Okay then, sweet,</i>\" she says, calmly exposing her breasts.  \"<i>I will give you all the milk you could want,</i>\" she adds, then suddenly lunges for you, grabbing your head and pulling you into a headlock that, not so coincidentally, mashes your face against her naked boobs.  \"<i>Naughty, cheeky [name]!  If you want to drink my milk, then you don't need this subterfuge to get me in the mood,</i>\" she chortles good-naturedly as she finishes, her homesickness evidently forgotten with the diversion you've presented her.");

            EngineCore.outputText("\n\nSeeing as you're already so conveniently positioned, you waste no time in opening your mouth and taking her four nipples into your mouth, suckling in earnest, as the cow-girl's tasty milk fills your mouth and belly.  You momentarily stop your nursing to lick a stray drop of milk that has escaped your mouth, smiling to Isabella, you tell her that her milk truly hits the spot.  You can already feel yourself getting warmer.");

            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\nIsabella smiles and cuddles you against her bosom.  \"<i>Be honest; you vere not vanting mein milk, you vere wanting to be cheering me up, da?</i>\" she laughs.  Busted!  You laugh yourself, though your plan seems to have worked pretty well, and you're not complaining about the bellyful of tasty milk you've gotten either.  You burp sheepishly, for emphasis.");
            else EngineCore.outputText("\n\nIsabella smiles and cuddles you against her bosom.  \"<i>Be honest; you weren't wanting my milk, you wanted to cheer me up, huh?</i>\" she laughs.  Busted!  You laugh yourself, though your plan seems to have worked pretty well, and you're not complaining about the bellyful of tasty milk you've gotten either.  You burp sheepishly, for emphasis.");

            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\n\"<i>You are just ze sweetest little thing, aren't you, [name]?</i>\"  Isabella laughs, her breasts jiggling heavily from the force.  \"<i>Vell, if you are liking mein milk so much, perhaps you should have some more, da?</i>\"  She grins, gently lifting one breast with a free hand to better offer it to you.");
            else EngineCore.outputText("\n\n\"<i>You are just the sweetest little thing, aren't you, [name]?</i>\"  Isabella laughs, her breasts jiggling heavily from the force.  \"<i>Well, if you are liking my milk so much, perhaps you should have some more, yeah?</i>\"  She grins, gently lifting one breast with a free hand to better offer it to you.");

            EngineCore.outputText("\n\nSounds like a plan, you tell the cow-girl.  You take the offered tit in your hands and proceed to bury yourself into the pillowy mound, latching onto her nipples and draining them of all its contents as fast as you can without choking.");

            if (SceneLib.isabellaFollowerScene.isabellaAccent()) EngineCore.outputText("\n\nIsabella smiles and releases her arm from around your neck to instead stroke your [hair].  \"<i>Da, zat ist good, [name].  I love to empty zese big boobs of mine, but I am loving you more,</i>\" she says this last-part in a stage whisper, clearly intending for you to hear it.  You decide that for now, you'll just busy yourself with the cow-girl's teats, you can return the feelings later...");
            else EngineCore.outputText("\n\nIsabella smiles and releases her arm from around your neck to instead stroke your [hair].  \"<i>Yeah, that's good, [name].  I love to empty these big boobs of mine, but I think I love you more,</i>\" she says this last-part in a stage whisper, clearly intending for you to hear it.  You decide that for now, you'll just busy yourself with the cow-girl's teats, you can return the feelings later...");
            flags[kFLAGS.JACK_FROST_PROGRESS] = 11;
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
        }
        //Kiha
        else if (SceneLib.kihaFollower.followerKiha() && flags[kFLAGS.JACK_FROST_PROGRESS] <= 11) {
            EngineCore.outputText("\"<i>Ah-ah-ahchoo!</i>\""
                    +"\n\n\"<i>Bless you,</i>\" you say to Kiha as you approach the dragon-girl."
                    +"\n\nKiha sniffles and wipes her nose on her arm when she sees you.  \"<i>[name], what is this weird white stuff?  It's cold and wet and - achoo!</i>\"  She sneezes again, spraying a gout of flame across the camp.  \"<i>And the flakes keep flying up my nose,</i>\" she snuffles."
                    +"\n\nYou explain to Kiha it's just snow.  You had a friend you met recently help you make it snow in your camp, since it would be snowing around this time of the year, back home.  You thought it would be fun to take a break from adventuring to enjoy the snow... at least for a day."
                    +"\n\n\"<i>Achoo!</i>\" she sneezes again, sending sparks flying.  \"<i>What could be fun about this cold wet stuff?</i>\" she growls."
                    +"\n\nWell, aside from the games, there's also the romantic side... like keeping your loved ones warm.  You close the distance between the two of you and embrace the dragon-girl into a hug, doing your best to keep her warm."
                    +"\n\n\"<i>W-what are you doing, doofus?</i>\" she demands, blushing - which, coincidentally, makes her grow noticeably warmer in your arms.  You chuckle and tell her you're just helping her stay warm, and by the feel of things, it seems to be working.  You can't have her setting your camp ablaze with her sneezes, so this was absolutely necessary, you tell her, hoping to cull any incoming protests.  However, you don't miss the opportunity to run your hands over her back, down her scaled tail, and over her wonderful buttcheeks."
                    +"\n\nShe swallows hard, you can hear the gulping in her throat, but she hugs you back, slowly growing bolder and running her hands across your body in the same manner yours are running across hers.  \"<i>Well, you do have good taste,</i>\" she admits in a hoarse half-whisper, eyes lidded and smouldering."
                    +"\n\nSeeing that, you suggest that perhaps the two of you should move somewhere more... private.  You happen to know a way to make her feel even warmer.  She says nothing, looking into your eyes and nodding with a soft smile on her face, obviously trusting you to lead her."
                    +"\n\nYou waste no time in leading her away to a snowy clearing nearby.  Once there you look the shivering dragon-girl over, considering your options...");
            //[Fuck her] [Lick Boobs and Finger Pussy]
            flags[kFLAGS.JACK_FROST_PROGRESS] = 12;
            EngineCore.menu();
            if (player.hasCock() && player.cockThatFits(67) >= 0) EngineCore.addButton(0, "Fuck Her", kihaXmasFuck);
            EngineCore.addButton(1, "Finger Her", kihaXmasFingering);
        }
        //Feast time! Just a collection of words on the pleasant day...
        else {
            EngineCore.outputText("This small holiday of yours was much needed.  You feel reinvigorated and even more determined to put an end to this struggle with demons."
                    +"\n\nThe only thing left to end this day is a feast.  Though your family is not here to join you, at least you won't be dining alone.");
            //(if One sexable follower)
            if (SceneLib.camp.loversCount() + SceneLib.camp.slavesCount() == 1) {
                EngineCore.outputText("\n\nYou take care of the preparations and cooking, whipping up a delightful meal for you and your companion.  You can tell that you were not the only one needing this break, and judging by the way your companions eyes you as the two of you eat... it seems the day is not over yet...");
            }
            //(if no sexable follower)
            else if (SceneLib.camp.loversCount() + SceneLib.camp.slavesCount() == 0) {
                EngineCore.outputText("\n\nYou take care of the preparations and cooking, whipping up a delightful meal for you and your companion");
                if (SceneLib.camp.companionsCount() > 1) EngineCore.outputText("s");
                EngineCore.outputText(".  You can tell that you were not the only one needing this break... but unfortunately all good things must come to an end, and so you bid your companion");
                if (SceneLib.camp.companionsCount() > 1) EngineCore.outputText("s");
                EngineCore.outputText(" good night and retire for the night.");
            }
            ////more than one sexable follower.
            else {
                EngineCore.outputText("You take care of the preparations and cooking, whipping up a delightful meal for you and your companions.  For a moment you look around - this small band you've formed feels enough like a family that you wouldn't mind having more days like this in the future.  You vow to work extra hard to make this a reality."
                        +"\n\nThe feast progresses without a hitch.  You cheer, eat and drink together (though you really don't have any appropriate alcohol for the evening).  As the feast progresses, you notice more than one pair of hungry eyes sizing you up... it seems your day is far from over...");
            }
            EngineCore.HPChange(EngineCore.maxHP(), false);
            EngineCore.fatigue(-100);
            flags[kFLAGS.JACK_FROST_PROGRESS] = 0;
            EngineCore.doNext(SceneLib.camp.returnToCampUseEightHours);
        }
        //[=Fuck Her=]
        //PC needs to have a cock.
        function kihaXmasFuck():void {
            EngineCore.clearOutput();
            var x:int = player.cockThatFits(67);
            if (x < 0) x = player.smallestCockIndex();
            EngineCore.outputText("Stripping off your [armor], you tell the dragon-girl that a good workout is all she needs to get nice and warm.  She snorts in dismissal, but the way she's looking at you is a pretty good indication she's willing to try it.  \"<i>So, what do you have in mind?</i>\" she blusters.  You stroke your quickly erecting [cocks] and, smirking, ask her if your intentions aren't obvious?"
                    +"\n\nShe stalks over, tail swaying sensually behind her, and takes you by the shoulders.  Then, with a mischievous grin, she pushes you into the snow.  \"<i>All right, but you're on the bottom - you can have the cold back this time!</i>\" she smirks, straddling your waist."
                    +"\n\nYou laugh and tell her you're fine with that, but she better hurry up, the cold is starting to catch up to you.   The mock-dragon blows a fine trickle of smoke from her nose, reaching down to stroke your shaft.  \"<i>Such a pervert, aren't you?  Here I am all freezing and wet, and all you can think about is fucking me, is that it?  You just want to shove this cock into my wet cunny and ride me until you burst, isn't that right?</i>\"  She growls lustfully, her fingers nimbly caressing and stroking your " + player.cockDescript(x) + " as she speaks."
                    +"\n\nWith a wry smile you ask her if she's got a problem with that.  You wouldn't be thinking about her wet pussy all the time if she ever bothered to throw some clothes on... so who's the real perv now?  You or her?"
                    +"\n\n\"<i>You are, of course... so, I'll just have to punish you for being such a corrupted, demonic pervert...</i>\"  Kiha declares in a teasing voice.  She lifts herself up and positions herself over your cock, gently grinding her damp netherlips against the head but deliberately refusing to sink any further.  \"<i>How do you like that, cunt-hungry demon?  Do you want Kiha to take it all the way?  Do you?</i>\" she croons in a sweet voice."
                    +"\n\nImpatient, and starting to feel the cold snow creeping on your back, you ask her if she intends to get started with it, or if you'll have to go up there and get her yourself.  Your hands are already sliding along her thighs to grasp her hips.  \"<i>Oh, love, if you must</i>\" Kiha declares in mock protest, rolling her eyes before suddenly impaling herself to the hilt on your shaft, an action that makes her scream in shocked delight, fiercely clamping her netherlips down around your cock.  You hiss in pleasure as your " + player.cockDescript(x) + " is suddenly wrapped in the warm folds of the dragon-girl."
                    +"\n\nNot interested in delaying the act any longer, you grab a firm hold of her hips and begin pistoning in and out of her as well as you can in your current position.  Her moist honeypot feels absolutely wonderful on your shaft, and you can already feel yourself forgetting about the snow on your back.  Moaning, the mock-dragon starts to piston herself up and down, leaning on your chest for support as her hips rise and fall with increasing speed, wings half-flared and tail swishing in delight."
                    +"\n\nYou smile at the dragon-girl standing above you, careful to maintain your rhythm in fucking that wonderful pussy of hers.  Kiha smiles back at you, even as she continues to ride you for all she's worth.  You glide your hands over her sides to grasp her shoulders and pull her closer.  The mock-dragon eagerly allows you to pull her into your embrace, mashing her breasts against your [chest] and kissing you passionately.  You return the lip-lock with equal intensity, feeling the familiar pressure of a oncoming orgasm."
                    +"\n\n\"<i>I... oh, [name], I'm close!</i>\" Kiha gasps.  You try to reply and tell her so are you, but words fail you.  Instead you moan at her and thrust yourself as far into her as you can, painting her walls white with your seed as you spew rope upon rope towards her ready womb.  The dragoness manages to throw you a lustful smirk.  \"<i>Cumming already, lo-oh oh OH!</i>\"  She screams, arching her back and spewing flames out into the snowy sky above as she cums violently, flooding your crotch with all the lubricants and orgasm-fluids she can produce."
                    +"\n\nOnce her orgasm has subsided, the dragon-girl comes crashing down on top of you.  You laugh lightly and ask her what was she saying?  \"<i>...I guess that this snow stuff isn't so bad after all,</i>\" she admits, then sneaks a smooch to try and keep you from laughing at her.  You're happy to return the kiss and lay with her for a while longer, basking the heat of your each other, as well as your afterglow...");
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);

        }

        //[=Lick Boobs and Finger Pussy=]
        //All sexes!
        function kihaXmasFingering():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You examine Kiha.  A small snowflake lands on one of her nipples and she yelps with a start at the sudden contact.   \"<i>Hey, I asked you to help warm me up, not to stare at me!</i>\" she complains. "
                    +"\n\nYou tell her not to worry, you know just the way to warm her all up.  \"<i>Get on with it then,</i>\" she grumbles.  You grab hold of the impatient dragoness's boobs, massaging them gently, and lick the snowflake off her nipple.  Taking it in your mouth to suckle, you nip at her erect nub.  She gasps and moans in equal parts pleasure and shock.  \"<i>W-what?  Oh, that's nice, but, how's that going to help?</i>\"  You unlatch from her breast momentarily to wink at her and tell her to trust you - you know what you're doing.  \"<i>You perv,</i>\" Kiha says, but she's smiling as she does so."
                    +"\n\nYou pay no heed to her words, preferring instead to show her what you mean.  One of your hands slowly slides down her body, over her belly, and finally over her labia.  Slowly, you begin massaging her suddenly moist netherlips.  Wordlessly the mock-dragon lets you do so, moaning and hissing softly at the obvious pleasure your actions are bringing to her.  You switch breasts, turning your attention to her other nipple, and with your thumb, you press on her little pleasure buzzer.  With a hiss, Kiha reaches out and takes hold of your cheeks.  \"<i>Mmm, not what I had in mind, but I'll go with it,</i>\" she declares, gently stroking your face."
                    +"\n\nYou chuckle, sending vibrations through your mouthful of breast.  \"<i>Less laughing, please, [name] - I'm still cold!</i>\"  She demands through a shiver.  You decide to give in to her insistent demands and plunge your fingers as far as they'll go into her quivering quim.  This elicits a squeal of delighted shock from the fiesty dragon, whose whole body spasms from the surprised pleasure, her clenching slit doing its best to grip your fingers as if they were a cock."
                    +"\n\nYou begin pistoning your fingers in and out of the dragon-girl, asking her if she's feeling warmer now.  \"<i>Mmm, y-y-yes,</i>\" Kiha answers, even as her legs start to buckle, making her sway in a rather drunken fashion. \"<i>B-but it'll take more than - ooohhh... than that to warm me up,</i>\" she says, then moans.  She wants more, doesn't she?  Well, you're happy to oblige!  You add a couple more fingers to her love-hole, your other hand joining the first one in caring for her womanly needs by pinching and stroking her little, achingly engorged clit.  She shudders and squeals, her nether-lips squeezing you tightly as fem-cum drenches your hand, the orgasm ripping through her body and causing her to lose control of her legs, sending her crashing into you and knocking you both to the ground."
                    +"\n\nYou click your tongue, mocking her for giving in to a little pleasure.  Isn't she supposed to be all strong and mighty?  \"<i>I'll never be defeated,</i>\" right?  \"<i>Shush, love,</i>\" she pants unthinkingly.  You laugh at your scaly lover's reaction, patting her butt gently.  Then, you ask her if she's feeling warmer now?  If she isn't, you'll be happy to warm her up some more, even going so far as to send a questing hand to prod her moist opening."
                    +"\n\n\"<i>Well, I suppose you could get me a little hotter... if you can take the heat, my doofus,</i>\" she croons, snuggling tighter against you...");
            player.dynStats("lus", 20 + player.sens / 20 + player.lib / 20);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);

        }

        //[=Fuck Her=]
        //Needs PC with cock that fits.
        function penetradePureMouseWaifu():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Stripping down your [armor] and indicating Amily should do the same... you tell her that you were hoping for some good old-fashioned sex between a horny " + player.mf("man", "herm") + " and " + player.mf("his", "her") + " lovely mousette.  You playfully ask Amily if she has any objections?"
                    +"\n\n\"<i>Well, it's a little counterproductive to take your clothes off if you want to get warm,</i>\" Amily notes.  Despite her words, she's stripping off without the slightest hesitation.  You reply that just the sight of her getting nude is already making you a little warmer... thrusting your hips so she can see your erect [cocks].  \"<i>Flattering flirt; you always think with your dick, don't you?</i>\" the mouse laughs.  That's rich; you can see her pussy dripping from here");
            if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) EngineCore.outputText(", not to mention her dick's pretty hard, too");
            EngineCore.outputText("."
                    +"\n\nSitting down on your bedroll, you open your arms, inviting Amily over.  The mouse promptly approaches");
            if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) EngineCore.outputText(", her own " + SceneLib.amilyScene.amilyCock() + " jutting out in anticipation");
            EngineCore.outputText(", wriggling into your arms and angling her pussy over your " + player.cockDescript(CoC.instance.x) + ".  With the ease of long practice, she slides smoothly down its length, her warm, wet depths greedily inhaling your masculinity.  \"<i>Ah, nothing like a nice hard cock in your cunt to make you feel warmer,</i>\" she coos."
                    +"\n\nYou simply grin and begin bucking your hips against her, suppressing your moans by kissing her, hugging her tightly against you, holding your bodies flush together.  The mouse hugs you as tightly as she can, smothering you with kisses as her hands roam nimbly across your back, slinking down to squeeze your ass with an obvious hunger to molest you."
                    +"\n\nYou guide your hands down her sides, towards her behind, taking it into your hands and helping her rise and fall on your shaft.  She breaks the kiss with a loud exclamation.  \"<i>Oh, this feels so good, [name]!  And it's certainly warming... why, I think I'm starting to break a sweat... and I think you are too,</i>\" she grins."
                    +"\n\nYou ask her to tell you how much she wants this... how much she wants your seed... how much she wants you?  \"<i>I want you!  I want you with everything I have, I want everything you have to give!</i>\" she cries out.  Then she can have all of you... with one last thrust, you bury your shaft deeply into her quivering cunny and blast your liquid lust straight into her waiting womb.  She moans loudly, making no effort to hide her delight at your treatment, and shudders violently in your grip as orgasm rocks her body, flooding your crotch with her rodent fem-cum");
            if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) EngineCore.outputText(" and painting your belly white with futa-spooge");
            EngineCore.outputText("."
                    +"\n\nYou tell Amily, \"<i>Happy Holidays,</i>\" hugging her in post-coital affection.  \"<i>Happy Holidays, [name]... whatever that is,</i>\" she giggles.  \"<i>But, you know, we might just have a little late Winterfest present brewing after that bit of fun.</i>\"  She bats her eyes at you flirtatiously, patting her cum-stuffed belly."
                    +"\n\nYou agree with her and enjoy your closeness a while longer...");
            player.orgasm();
            player.dynStats("lib", -1);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
        }

        //[=Make out=]
        //For any gender.
        function makeOutWithPureMouseWaifu():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You strip down your [armor] and suggest Amily should do the same.  \"<i>Well, it's a little counterproductive to take your clothes off if you want to get warm,</i>\" Amily notes.  Despite her words, she's stripping off without the slightest hesitation.  \"<i>So, what's on your mind, lover-" + player.mf("boy", "girl") + "?</i>\" she asks."
                    +"\n\nYou say that with all that's been going on lately, the two of you just haven't been able catch a break... so today, you'd like to just forget about everything and spend some quality time with her... not by having sex... though you don't mind doing it either, but... you'd just like to sit back and enjoy your pretty mousette, mother of your children, properly.  You ask if she's getting what you're saying?"
                    +"\n\nShe smiles at you with joy.  \"<i>If all you want is to stay close to me, then I'd be more than willing to humor you - I had thought that all last remnants of romance had been squeezed out of this world.  I'm going to enjoy this,</i>\"  she promises to.  \"<i>Though... why do we need to be naked to sit and cuddle?</i>\" she asks, clearly baffled."
                    +"\n\nSilly mouse, you remark with a smirk.  That's the best way to share body heat... you're still a bit cold... and you're willing to bet so is she... you wink.  \"<i>Ah, so that's your game,</i>\" Amily chuckles.  \"<i>Well, I'm game if you are.</i>\""
                    +"\n\nYou open your arms in a clear invitation for the mousette to sit with you.  ");
            if (flags[kFLAGS.AMILY_WANG_LENGTH] > 0) EngineCore.outputText("Smiling sheepishly you  tell her to mind the erection... though you're not actually looking for sex, you can't help with how cute she looks...  \"<i>Flirt.</i>\"  Amily giggles, but otherwise doesn't comment on it.  ");
            EngineCore.outputText("The mouse promptly walks over and sits down just in front of you, her back facing you and giving you a perfect opportunity to hug her.  Not keen on missing such an opportunity, you do so.");

            if (player.hasCock()) EngineCore.outputText("\n\n\"<i>You know I can feel your dick poking me in the back, right?</i>\" Amily giggles, wriggling back against your jutting shaft for emphasis.  You chuckle and tell her to lay off your man-parts... this is just a natural reaction.  \"<i>Oh yeah?  Maybe you wanna see my natural reaction to this situation, hmm?</i>\" she croons.  Maybe later... right now you just want to enjoy her like this.");

            EngineCore.outputText("\n\nThe mouse sighs softly.  \"<i>You know how I feel about you, [name]?  I feel that Marae herself must have blessed me to have someone like you find me.  For all the ordeals I faced, having you in my life makes up for everything.  Having you here like this, arms wrapped around me, our hearts beating together... I want this moment to last forever,</i>\" she declares quietly."
                    +"\n\nYou put your nose against her neck, inhaling her scent, a faint grassy smell that is distinctively feminine.  \"<i>Mmm... that feels good.</i>\"  Amily drawls, and then she giggles, \"<i>Actually, it kinda tickles.</i>\""
                    +"\n\nYou tell her it feels perfect, and you'll fight hard to ensure you will all have more moments like this in the future...  \"<i>Well, I'll be rooting for you all the way... though, right now, I think I'd rather you just shut up and enjoy the moment,</i>\" she adds."
                    +"\n\nYou chuckle, even though she's the one that's been chatting your ears off this whole time?  \"<i>Yes, even though I'm the one that's been chatting your ears off,</i>\" Amily replies with a smile.  You suggest that perhaps all you need to do to stop talking is finding something to keep your mouths busy.  \"<i>Oh?  What are you suggesting?</i>\" she asks, her tail gently looping around your midriff.  Your reply is to simply draw her into a kiss...");
            player.dynStats("lus", 30 + player.sens / 10);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
        }


        //[=Pen Ass=]
        //PC needs a cock.
        function penetradeCorruptJojoAss():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You roughly pull the mouse slut's tail out of the way, getting a clear look at his accommodating ass.  Your broken slut of a murine monk rises to the tips of his toes in anticipation, already moaning in delight at the thought of your ravaging his ass.  You laugh at him, telling him he has come very far ever since the first time you've violated his bum.   \"<i>Yes [master], thank you [master],</i>\" is all Jojo's corrupted brain can think to say."
                    +"\n\nFeeling like you're just wasting your time, you drop your lower garments and begin stroking yourself into an erection.  With a throaty groan, Jojo wiggles his ass, crudely trying to tempt you to start.  You roughly shove your [cock] as far as it'll go on the former monk's ass, sinking a few inches in without any resistance.  Moaning, pre already dribbling from his cock, the fallen mouse bucks eagerly back into you, trying to shove more of your cock up his ass."
                    +"\n\nYou slap his ass, commenting on what a slut he is, getting so worked up about having his ass violated... does he really enjoy it that much?  \"<i>Yes, oh, [master], yes I do!</i>\" he vows.  Good, as he should.  You grab hold of his hips and pull them towards you, while thrusting yourself to the hilt into your mouse-slut's once tight ass, giving him a complementary slap on the butt in the process.  Jojo squeals like a sow in heat, thrusting back eagerly to swallow your cock, too horny to care about the pain his actions might cause him.  Without further ado, you begin pistoning yourself in and out of his ass, with nary a hint of worry about the monk's own enjoyment, not that you should considering each time your hips meet with a loud slap his cock pumps out a stream of pre."
                    +"\n\nJojo voices a loud moaning cry of orgasmic lust, clearly not too far off from his climax.  You silence his lurid cries by thrusting his face into the snow with a particularly strong pump of your cock on his ass.  You tell him to be quiet and take it like the bitch he is.   Jojo moans and sobs in pleasure, wriggling and squirming under you, too caught up in his own lusts to heed you."
                    +"\n\nFeeling yourself getting close, you redouble your effort at pounding the former monk's ass raw, pistoning in and out with all your might, until with a final thrust, you spill your load deep into the mouse-slut's hungry ass.  With a mighty shriek of joy, the corrupted monk arches his back, his distended, corruption-bloated cock spewing cum");
            if (player.cumQ() >= 700) EngineCore.outputText(" all over his own cum-engorged gut and ");
            EngineCore.outputText("onto the snowy earth underneath him.  He cums and cums until he's exhausted even his prodigious balls, creating a salty quagmire of semi-melted snow and spooge under him that he promptly collapses face-first into."
                    +"\n\nLaughing at his reaction, you ask if he has learned how to properly fuck in the snow.  Jojo lifts his face, covered in half-frozen spunk-slush, and nods at you, too tired from his recent fucking to speak."
                    +"\n\nGood, now he should get his face cleaned up.  You order him to lick himself clean.  Without hesitation, Jojo starts doing exactly what you said, slurping up all of the cum-slush on his face and using his fingers to scrape the rest into his reach.  He then begins licking at his arms and chest, clearly not intending to stop until he has it all.   You nod in satisfaction, telling him to keep at it, you want to see him eat it all up...");
            player.orgasm();
            player.dynStats("lib", -3, "sen", -1, "cor", 1);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
            flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
        }

        //[=Ride Cock=]
        //PC needs vagina
        function rideCorruptJojoCock():void {
            EngineCore.clearOutput();
            EngineCore.outputText("With a flourish, you easily discard your [armor].  Then you grab a hold of the mouse-slut's tail and twist it to the side, forcing the former monk to crash into the ground on his back, shaft half-erect and covered in melting snow, pointing upwards like a perverted pole.  You ask him if he can see anything he would like from his current vantage point."
                    +"\n\n\"<i>Y-yes [master],</i>\" Jojo meekly declares, unable to take his eyes from your [cunt].  His cock immediately grows to full mast, which you can't help but think is one of his more convenient features since you remade him into this far more enjoyable version of himself."
                    +"\n\nYou take his shaft into your hand, stroking it languidly, milking the mouse-slut's thick pre and spreading it along his shaft as you do so.  You ask him what he would like you to do.  \"<i>F-fuck me, [master]!  Fuck me!</i>\"  He cries, moaning as he bucks his cock furiously into your clasping hands."
                    +"\n\nNow, now... you can't have your slut forgetting his place... so you grab his balls and begin forcefully grasping at it, but rather than pain, the former monk only displays delight at the act; his brain enjoying both the pain and pleasure of the act in equal measure.  \"<i>Fuh-forgive me, [master]!  I was wrong!</i>\" Jojo pleads."
                    +"\n\nThat's better.  You release him and stand over him, issuing a single order.  If he wants it, you want to hear him ask it, like a proper slut should.  Swallowing audibly, the mouse-slut does his best to calm himself down, but he never stops panting as he begs. \"<i>M - [Master], please... please show this unworthy slut how to fuck in the snow... please, let me cum,</i>\" he says meekly, cock throbbing in anticipation."
                    +"\n\nNow that's what you like to hear, and you promptly impale yourself on Jojo's handy shaft, brutally forcing it inch by inch inside you until you have forced him to the ground with your efforts.  Moaning with satisfaction at being stuffed, you begin to roughly rise and fall, pistoning back and forth in order to sate your pleasures."
                    +"\n\nJojo goes berserk, babbling incoherently as he grabs your hips and begins roughly slamming himself into your [vagina], trying to dig as deep into you as he can, even as his pre leaking shaft lubricates your tunnel.  You try to exert some control over the ex-monk, but eventually decide it's better to just sit back and enjoy the ride - however, you can't resist taunting Jojo over what a depraved little slut he has become, totally incapable of controlling himself. \"<i>S-Sluuut... I'm... sluuuut,</i>\" he utters incoherently between moans.");
            player.cuntChange(20, true, true, false);

            EngineCore.outputText("\n\nYou thrust, buck, and heave, enjoying everything there is about mastering this once-pure soul and reducing him to your fuck puppet.  Finally, with an ecstatic howl, you cum, female lubricants gushing onto his burning hot cock");
            if (player.hasCock()) EngineCore.outputText(", your own futa-cock spewing its load, which you deliberately spray in his face for amusement");
            EngineCore.outputText(".  Your orgasm triggers Jojo's own; though he has cum without permission, at least he waited for you to cum first like a good slut should.  Rope after rope of mousy sperm bats your cervix, trying to get past the barrier and into the waiting womb inside, even as Jojo tries his best to fuck you over and over as he spills his load, until he finally slumps into the ground, panting, with his mouth open and his tongue lolling out, eyes glazed over in a pleasured daze."
                    +"\n\nYou wait until you're sure you dripped the last few drops of femcum from your cunt, then, with a groan, noisily pull yourself off of the mouse's now-limp dick.  Moving so that you are hovering it over Jojo's face, you authoritatively command your slave to clean up all the mouse-spunk he stuffed into your cunt.  The panting mouse-slut breaks out of his trance with a start, and quickly raises to get started and do your bidding, even as drops of your mixed juice and his slutty baby-batter drip on his face.  He drinks the spunk with joy, moaning in enjoyment at the act."
                    +"\n\nYou just stand and watch as he works, waiting for him to finish cleaning you up so you can get started on your next task...");
            player.orgasm();
            player.dynStats("lib", -3, "sen", -1, "cor", 1);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
            flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
            //Preggers chance!
			if (player.goblinScore() > 9) player.knockUp(PregnancyStore.PREGNANCY_GOBLIN, PregnancyStore.INCUBATION_GOBLIN);
            else player.knockUp(PregnancyStore.PREGNANCY_JOJO, PregnancyStore.INCUBATION_MOUSE + 82); //Jojo's kids take longer for some reason
        }

        //[=Spank and Finger Ass=]
        //Available to all.
        function spankNFingerCorruptJojoAss():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Not bothering to undress, you yank the mouse's ropy tail out of the way with brutal force, to gaze at his white, heart-shaped ass.  Jojo stands on the tips of his toes, moaning at the rough treatment that surely follows.  His ass looks so inviting... so deserving of a good hard smack... you ask the former monk-turned-slut how he would like a good beating on his ass."
                    +"\n\n\"<i>M-[master], please, spank me!  I'm such a naughty boy - spank me hard!</i>\" Jojo cries.  You laugh at your wanton slut.  You've never seen a mouse as perverted as this, begging to be spanked and getting off on the idea... well, the slut certainly deserves it... you're pretty sure he has been masturbating without your permission, and you can't have that."
                    +"\n\nJojo just wiggles his bare ass, doing his best to make it look as tempting as possible for you."
                    +"\n\nYou administer an echoing slap on his bubbly butt, causing the cheeks to jiggle as a hand-shaped print appears on his behind.  Jojo moans throatily, spurting a gobbet of pre from his bobbing cock, wiggling his ass in appreciation of the spank."
                    +"\n\nYou can't resist laughing, pointing out what a parody of a monk he has become.  So perverted, begging for sex, cock and cum.  Why... if his order saw him now, they would surely punish him for this disgrace... and since they're not around anymore... perhaps you should be the one to administer the punishment instead?  \"<i>Oh, yes, [master], please!</i>\" the mouse begs, clearly loving the way you're talking to him in his defiled state."
                    +"\n\nYou release his tail, letting him drop to his knees, and begin fondling his balls, asking him if he will spill his load for you if you spank him?  If he will further forget about his foolish morals and embrace his inner slut like a good little slave?  \"<i>Yes! Yes!  Oh, yes, [master], I will!</i>\" he cries out in rapture, his tail coiling around your wrist like a whip and tugging it insistently towards his ass."
                    +"\n\nSeeing no reason to deny, nor tease the mouse-slut any longer, you begin administering his punishment, each resounding slap rocking the mouse, who is only too happy to moan at the pain.  Slap after slap you chastise him for ever believing he was anything more than your willing slut, and he loves every minute of it.  His once noble goals are now just a faint memory... his only purpose now is to be a fucktoy for you and whomever you appoint, good for nothing more than sex.  The only coherent thoughts that run through the defiled monk's head are fuck, cum and pain; he is so far gone in his corruption, in his new purpose in life that he begs you to spank him more, even as his ass begins glowing with the severe spanks you administer him."
                    +"\n\nThe mouse moans and groans lustily with every spank, his cock growing stiffer and harder, pre bubbling out of its tip until it is constantly oozing steadily from his cock.  He's lost in pleasure, existing only to be pushed over the edge into a true orgasm.  Realizing that the slut is bordering the edge of orgasm, you decide to put a finishing touch to his treatment... you shove your fingers into his easily yielding ass, pushing the digits up to the knuckle and pressing on his prostate with a single order: Cum."
                    +"\n\nWith a gasp and a howl, Jojo does as you command, a fountain of tainted mouse-spooge gushing from his cock, soaking into the snow to create a great slushy puddle.  He cums and he cums until he's totally exhausted his strength, collapsing bonelessly into the puddle he's just created, his tail slipping off of your wrist as he does so."
                    +"\n\nYou laugh at the mouse-slut's blissed out face of pleasure, feeling like you managed to chip away another part of his broken will.  Before you leave him to pass out on his snowy puddle of mouse-cum you ask him, what is his name?  \"<i>S - Slut...</i>\"  Is the moaning reply.  Satisfied, you decide to leave for the moment.  Maybe you'll get back to him and break him in a little more later...");
            player.dynStats("lus=", player.maxLust(), "scale", true);
            EngineCore.menu();
            EngineCore.addButton(0, "Next", processJackFrostEvent);
            flags[kFLAGS.JACK_FROST_PROGRESS] = 5;
        }
    }

    public static function candyCaneTrapDiscovery():void {
        //CONSTS
        //const CANDY_CANE_YEAR_MET:int = 637;
        //const XMAS_CHICKEN_YEAR:int = 642;
        //const KAMI_ENCOUNTER:int = 643;
        //const POLAR_PETE_YEAR_MET:int = 644;
        //const NIEVE_STAGE:int = 647;
        //const NIEVE_GENDER:int = 648;
        //const NIEVE_MOUTH:int = 649;

        //TOC (Ctr + F to find):
        //1. Kirbster's Bunny Trap
        //2. Abraxas's Christmas Chicken
        //3. nRage's Kanga herm loving
        //4. Donto's Polar Pete
        //5. Third's Nieve

        //1. Kirbster's Bunny Trap
        //if(isHolidays() && flags[kFLAGS.CANDY_CANE_YEAR_MET] < date.fullYear)
        EngineCore.clearOutput();
        EngineCore.outputText("Shortly after embarking into the plains, your thoughts drift back to your life and home in your village.  The slight chill in the air today reminds you of a time of cheer celebrated by your former friends and family.  As days grew shorter and colder, people exchanged humble trinkets, and great feasts were prepared.  ");
        if (player.cor < 50) EngineCore.outputText("The memory brings a nostalgic smile to your [face].");
        else EngineCore.outputText("The memory reminds you of how bland your world truly was in comparison to Mareth.");

        EngineCore.outputText("\n\nYour musings are interrupted by a sharp moan that immediately catches your attention.  It's light enough that whoever did it must be a distance away, but audible enough for you to be sure of where it came from.  Keeping your [weapon] up and prepared, you venture in the direction where the sound originated.  Stepping through a dense patch of shrubbery, you find yourself in a semi-secluded glade littered with puddles of semen.  Whatever creature these came from must be rather \"<i>pent up,</i>\" so to speak."
                +"\n\nDo you run the risk of investigating?");
        //(Present \"<i>Investigate</i>\" and \"<i>Leave</i>\" options.)

        //simpleChoices("Investigate",9999,"",0,"",0,"",0,"Leave",9999);
        EngineCore.menu();
        EngineCore.addButton(0, "Investigate", investigateCandyCaneBun);
        EngineCore.addButton(4, "Leave", leaveBeforeMeetingCandyCaneBun);

        //LEAVE
        function leaveBeforeMeetingCandyCaneBun():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You're not willing to run the risk of getting a foreign cock stuffed up your [butt].");
            //(If corruption or libido>50) 
            if (player.cor > 50 || player.lib > 50) EngineCore.outputText("  At least not right now.  You turn back, navigating your way back to your camp.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //INVESTIGATE
        function investigateCandyCaneBun():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You make the decision to find out just what's going on.  You cautiously follow the small pools of goo, slightly on edge.  You approach a wall of low hanging vine which you quickly pull aside.  Sitting in the largest pudddle of semen you've seen yet, a trembling bunny-like figure kneels on its knees.");
            //(If corruption and libido<50) 
            if (player.cor < 50 && player.lib < 50) EngineCore.outputText("  Your eyes are quickly drawn to the rabbit morph's stark nudity.");
            //(If corruption or libido>50) 
            else EngineCore.outputText("  Your eyes are quickly drawn to the rabbit morph's finely curved ass.");
            EngineCore.outputText("  A pair of heavily hanging balls confirm the figure to be at least partially male."
                    +"\n\nYou make the move to ");
            //(If corruption and libido<50)
            if (player.cor < 50 && player.lib < 50) EngineCore.outputText("leave, ");
            //(If corruption or libido<50)
            else EngineCore.outputText("approach, ");
            EngineCore.outputText("but one of your [feet] snaps a twig and causes the bunny to turn at the sound. As its large eyes lock with your, you get your first good look at the figure.  It is predominantly human looking, but the floppy ears sprouting from its head and fluff adorning him from the thighs down indicates at least a little mutation.  Two small nipples lie on a flat chest, confirming him to be a male.  His eight inch dick and kiwi-sized balls leave even less to your imagination.  He is lightly tanned, his skin colored a non abrasive brown.  The hair on his body stands in a sharp contrast to his relatively regular skin.  A mop of shoulder length hair on his head is as white as freshly fallen snow, with sprinklings of red stripes highlighting it.  You can't help but notice how nicely it frames his surprisingly soft, feminine face.  The fur covering his legs is smiliary covered.  His hips jut out notably, adding even further to his overall girly appearance."
                    +"\n\n\"<i>You're not going to rape me?</i>\"  The bunny boy's remarkably high voice breaks your train of thought.  ");
            //(If corruption<50)
            if (player.cor < 50) EngineCore.outputText("You calmly inform him that you didn't have the intention of violating him. ");
            //(If corruption>50)
            else EngineCore.outputText("Your train of thought is derailed, but you agree to let the bunny believe whatever he wants to.");
            //(If silly mode on) 
            if (EngineCore.silly()) EngineCore.outputText("  You're willing to say anything to calm him down.  This kid's voice is even more shrill than that asshole from Glee!");
            EngineCore.outputText("  A smile lights up his face, his shoulders visibly drop and lose their tension.   He sits like that for but a moment, before he realizes the full scope of the current situation.  His eyes grow wide while he throws down his arms with a rather unmanly yelp, covering his dripping cock.  Despite his embarrassment, it's evident that he's not going to get off unassisted.");
            flags[kFLAGS.CANDY_CANE_YEAR_MET] = date.fullYear;
            EngineCore.outputText("\n\nDo you help him out?");
            //(Present \"<i>Yes</i>\" and \"<i>No</i>\" options)
            EngineCore.menu();
            EngineCore.addButton(0, "Yes", helpWithTheCandyCane);
            EngineCore.addButton(1, "No", declineCandyCaneCawks);
            //simpleChoices("Yes",9999,"No",9999,"",0,"",0,"",0);
            player.dynStats("lus", 10 + player.lib / 10, "scale", false);

            //NO
            function declineCandyCaneCawks():void {
                EngineCore.clearOutput();
                EngineCore.outputText("Turning around a tad awkwardly, you stumble out of the glade.  Tempting as he is, you don't have time to help the random bunny orgasm.");
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }

            //YES
            function helpWithTheCandyCane():void {
                EngineCore.clearOutput();
                EngineCore.outputText("You lower your eyes seductively as you begin to sashay your [hips], approaching the lusty rabbit.  He trembles slightly as you lift his hands away from his dick, but he doesn't protest.  Up close, you can see his cock is adorned with red stripes similar to the ones in his hair. You push your [face] up against it, letting the pheromone laced tool drag across your face.  The rigid rod even leaves a few streaks of pre cum in your [hair].  After a minute of teasing the whimpering bunny, you pull his cock down, dragging it past your lips.  Your mouth lights up with a chilling sensation the moment his cock's head touches your tongue.  It fills you with an indescribable happiness, as if the boy inside your mouth is radiating pure joy.  You begin to moan around his tonsil-tickler while ");
                //(if male)
                if (player.gender == 1) EngineCore.outputText("[eachCock] rises up, rocking against you.");
                //(If female)
                else if (player.gender == 2) EngineCore.outputText("your [vagina] and [clit] become coated in liberal amounts of juices.");
                //(If herm)
                else if (player.gender == 3) EngineCore.outputText("both of your sexes flare with arousal.");
                //(If genderless) 
                else EngineCore.outputText("sweat drips off of you.");
                EngineCore.outputText("  You pay no mind to this, too pre-occupied bobbing your head on the delicious dick in your mouth."
                        +"\n\n\"<i>Oh my goodness!</i>\"  The bunny cries out from above you as he wraps his furry legs around your neck.  \"<i>I can't keep from squirting if you keep it up like this!</i>\"  You smile around him before pulling off of his prick.  Your lips make a grotesque popping noise as his cock head pulls out of your dick-craving suck-hole.  You wrap a hand around his throbbing rod, jacking him off while you whisper throatily to him to coat you in his seed.  He wriggles under your experienced grip, dripping his slippery spunk down your fingers.  The mess that coats your fingers allows you to improve your handjob even further.  You hand becomes a practical blur as it draws up and down at an alarming rate."
                        +"\n\nThe feminine boy's slender hands suddenly grip at your [hair], pulling you up against his penis.  You feel his balls churning up against your [face].  Preparing to receive your generous gift, a sharp ringing suddenly distracts you.  Your eyes open wide to identify the odd jingling, but your field of view only lets you view the balls pressing up against your face.  As they churn visibly, you quickly deduce that his nuts are the source of the jingling, announcing his impending climax!  The ringing quickly ceases as his cock swells and blasts of jet of semen onto your [face].  You reflexively open your mouth as wide as you can, resembling a whore clenched between the legs of this bunny boy. His next spurt layers your entire mouth in the white cream, sending a pleasurable shiver down your spine.  His cum is so minty and chilling that you immediately dive on him, engulfing him in your mouth once more.  He allows you to suck down the last few shots of his cum before falling back, utterly spent.  Shuddering slightly, he pulls you on top of him, and leans up to place a not-too-chaste kiss on your cum coated lips.  You remain for a moment, caressing his soft hair.  He eventually lays back, thanking you before drifting into slumber.");
                //(If corruption<50) 
                if (player.cor < 50) EngineCore.outputText("  Not wanting to disturb him, you make your way back to camp and attempt to ignore the burning fire in your loins.");
                //(If corruption>50) 
                else EngineCore.outputText("  Despite your rising urge to take advantage of the unknowing bunny, you decide to retire and return to camp.");
                //(Lust set to 100, hour passes.)
                player.dynStats("lib", 1, "sen", 1, "lus=", 100, "cor", -5, "scale", false);
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }
        }
    }

    public static function getAChristmasChicken():void {
        //2. Abraxas's Christmas Chicken
        //[Wake up, whatever morning]
        flags[kFLAGS.XMAS_CHICKEN_YEAR] = date.fullYear;
        EngineCore.outputText("\nThe grating sound of squawking rouses you in the morning.  You groggily roll over, hoping to go back to sleep for a while, but the annoying noise persists unrelenting.  Realizing that it probably isn't going away any time soon, you reluctantly force your eyes open and push yourself up.  The sight around you causes you to blink a few times to shake away the disbelief: a layer of brilliant white snow frosts the ground, a rare sight at your camp thus far.  You hadn't really noticed it getting that much colder, but the chill this morning is biting through your [armor].  A shiver wracks your body, and your thoughts on the odd snowfall are interrupted by another loud call."
                +"\n\nDetermined to shut whatever is making such a racket up, you trudge off through the cold, crisp blanket towards where you think the sound is coming from.  You crest a small hill and are greeted with another peculiar image.  Faintly visible against the snow, what appears to be a very pale harpy woman lays on her back, beating her pure-white wings against the ground and sweeping her legs back and forth against the freshly-fallen powder.  She caws and shrieks happily, apparently too caught up in... whatever it is she's doing to notice you.");
        EngineCore.menu();
        EngineCore.addButton(0, "Talk", talkToXmasChicken);
        EngineCore.addButton(4, "Leave", leaveXmasChicken);

        //[Leave]
        function leaveXmasChicken():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Too exasperated by the plain absurdity of the situation to deal with it, you bury your face in your hands and decide to leave her to it.  Maybe some imps will shut her up for you.  You head back to camp with her piercing cries following you all the way, and prepare for the day ahead.  Her cries fade a while later; the snow thaws and the air warms soon after.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //[Talk]
        function talkToXmasChicken():void {
            EngineCore.clearOutput();
            EngineCore.outputText("Figuring you should at least try asking her to pipe down, you continue your approach.  She finally takes notice of your footsteps crunching the snow beside her and goes still and silent for a moment as she looks up at you.  Now that you're closer, you can make out some more of her features against the snowy ground.  She wears a light dress, almost as pale as her skin and the snow around her, thin enough that you can just see her perky nipples through its white fabric.  A shiver of your own makes you wonder why she's wearing something like that on a day like this.  The thick, fluffy-looking feathers of her wings even manage to stand out as somehow even whiter than the frosty backdrop of the snow.  A faint, silvery glow seems to radiate from her, but it's probably just a trick of the light against the snowfall."
                    +"\n\nYou watch her lie there quietly for a moment before she goes back to happily cooing as loudly as ever and flapping about on the ground.  Fed up, you finally ask her what she thinks she's doing out here.  She looks up quizzically for a moment and tells you matter-of-factly that she's making shapes in the snow, and returns to her task dutifully and noisily.  You bury your face in your hands, unsure how to deal with this.  You ask her why exactly she's doing that."
                    +"\n\nThe harpy looks up and opens her mouth for a moment, but stops herself to think.  \"<i>Well, I was dancing in the snow because I was so happy to see it.  Then I slipped and fell, so I started doing this instead.</i>\"  Thinking again.  \"<i>Oh!  Right, I can't get up.  My wings won't fold right for that.  Too big.</i>\"  Apparently expecting you to be satisfied, she gets back to it.  Forced to yell over her resumed deafening shrieks of joy, you tell her you can help her up if she'll quiet down.  She contemplates your offer for a second, then extends a hand."
                    +"\n\nDespite the apparent thickness of her plumage, she's rather light, and you easily pull her to her feet.  Err, talons.  She seems grateful, beaming a smile at you.  You're just happy that she's shut up.  \"<i>Thanks!  I guess I should repay you somehow.  ");
            //(if male)
            if (player.gender == 1) EngineCore.outputText("How's a blowjob sound to you?");
            //(if female)
            else if (player.gender == 2) EngineCore.outputText("How about I eat you out?");
            //(if herm)
            else EngineCore.outputText("How about I give you a few minutes to do whatever you want with my mouth?");
            EngineCore.outputText("</i>\"  You raise an eyebrow, not entirely sure what to make of her suddenly lascivious nature.  It's certainly quite a change.  She giggles.  \"<i>Oh, don't be surprised.  Where do you think we are");
            //(if sillymode)
            if (EngineCore.silly()) EngineCore.outputText(", scrub");
            EngineCore.outputText("?</i>\"");
            EngineCore.menu();
            EngineCore.addButton(4, "Decline", declineChickenBlowjobs);
            EngineCore.addButton(0, "Accept", acceptChristmasBJs);

            //[Decline]
            function declineChickenBlowjobs():void {
                EngineCore.clearOutput();
                EngineCore.outputText("The harpy squints at you suspiciously.  \"<i>What do you mean, 'no thanks?'  Nobody says that around here!</i>\"  She rolls her eyes and sighs in an obviously exaggerated manner, then turns tail and flaps off into the distance.  You head back to camp, quite looking forward to the silence.  The air warms and the snow thaws soon after you return, leaving no trace of its presence but a few spots of slushy mud.");
                EngineCore.doNext(EventParser.playerMenu);
            }

            //[Accept]
            function acceptChristmasBJs():void {
                //(male)
                if (player.gender == 1) {
                    acceptChristmasManBJ()
                }
                else if (player.gender == 2) {
                    acceptChristmasWomanBJ();
                }
                else {
                    EngineCore.clearOutput();
                    EngineCore.outputText("Would you like her to service your male parts or lady bits?");
                    EngineCore.menu();
                    EngineCore.addButton(0, "Man Parts", acceptChristmasManBJ);
                    EngineCore.addButton(1, "Lady Bits", acceptChristmasWomanBJ);
                }
            }

            function acceptChristmasManBJ():void {
                EngineCore.clearOutput();
                var x:int = player.cockThatFits(80);
                if (x < 0) x = player.biggestCockIndex();
                //(if cock >= ridonkulous)
                if (player.cockArea(x) >= 80) {
                    EngineCore.outputText("You free your [cock " + (x + 1) + "] from your [armor], signaling your acceptance.  Your monster flops free, and the harpy grabs at her throat reflexively when she looks at it.  She glances up to you with wide eyes and back down at it.  \"<i>A-a promise is a promise, but...</i>\"");
                    EngineCore.outputText("\n\nShe turns and flees with a few terrified flaps of her wings.  You sigh, covering your enormous prick once more.  At least you won't have to deal with her pesky shrieking any more.  The air warms and the snow thaws soon after you return, leaving no trace of its presence but a few spots of slushy mud.");
                    player.dynStats("lus", 10);
                    EngineCore.doNext(EventParser.playerMenu);
                    return;
                }
                //(else if cock would please Goldilocks) (area<= 30 or some shit i dunno whatever the standard is)
                else {
                    EngineCore.outputText("You free your [cock " + (x + 1) + "] from your [armor], signaling your acceptance.  The immediate rush of cold air that greets it makes you hope she won't be wasting any time.  The pale harpy woman squeals at the sight, raising her hands to her chin and practically bouncing in place.  In a flash she's on her knees, stroking and licking at your meat until it's hard in front of her face.  Her hot breath against your shaft has you more than ready for the sanctuary from the biting cold.  She eyes your erect prick");
                    if (player.cockTotal() > 1) EngineCore.outputText("s");
                    EngineCore.outputText(" almost hungrily, licking her lips before swiftly engulfing almost its entire length in her mouth.  Her expert technique astounds you; you certainly didn't expect her to have any idea what she was doing but she's able to take you nearly to the base of your shaft in one motion.");

                    EngineCore.outputText("\n\nThe heat of her throat against your sensitive flesh is such a relief that you lose your balance.  You gasp air and place a hand on the back of her head, partly to steady yourself and partly to bring her closer in.  Not meeting resistance, you pull her against you until her full lips are wrapped around the very base of your [cock " + (x + 1) + "].  She smiles around its girth and slowly slides her head back, dragging the tip of her tongue along its length and leaving you covered in her glistening saliva.  The freezing temperature elicits another sharp intake of air, but the painful sensation is forgotten as she starts to bob back and forth, taking you in so deeply and so quickly that it's impossible to think of much but the warm comfort of her mouth.  ");
                    //(if only one cock)
                    if (player.cockTotal() == 1) EngineCore.outputText("She grabs onto your hips, enabling herself to move all the quicker.");
                    //(if two cocks)
                    else if (player.cockTotal() == 2) EngineCore.outputText("With her other hands she starts to work the shaft of the second cock, pumping in time with the motions of her head.");
                    //(if 3+ cocks)
                    else EngineCore.outputText("She grabs onto two of your other erect cocks with her hands and begins pumping away at them in time with the motions of her head.");

                    EngineCore.outputText("\n\nHer fellating tongue and pursed lips are more than enough to make up for the uncomfortable temperature; the nip of the cold is forgotten as pleasure clouds your mind.  At the pace she's going, you near the edge in no time at all.  You try to warn her, but climax takes you before you can get out more than a pant.  Caught up in the bliss, you hold her close against you as you empty your hot load into the harpy's receptive throat.");
                    //(if cum output is low-moderate)
                    if (player.cumQ() < 250) EngineCore.outputText("  She closes her eyes and looks quite contented while she swallows your spunk.");
                    //(else if cum output is high)
                    else if (player.cumQ() < 1000) EngineCore.outputText("  Semen gushes out of you for what seems like forever, but the harpy doesn't seem to mind.  She closes her eyes and looks quite contented while she swallows your still-torrenting spunk.");
                    //(else if cum output is ridonkulous)
                    else EngineCore.outputText("  Though at first she looks like she'll be able to handle it, the river of semen exploding from the rip of your cock doesn't stop.  Her eyes widen as the almost unending torrent of spunk fills her, rushing down her throat and into her belly.  You can almost see her bloating with the stuff before it starts to spill back out, dripping white from her lips around your shaft.");
                    //(if multicock)
                    if (player.cockTotal() > 1) EngineCore.outputText("  Your cum sprays over her, coating her skin and plumage in a white to rival their own.  Strands of your semen dripping and running over her hardly even stand out on her bright body.");
                    EngineCore.outputText("  When you finish, you let the harpy go.  She looks just as satisfied as you are.  A trail of cum and saliva still connects your [cockHead " + (x + 1) + "] to her; she breaks it with a lick of her lips and gives your softening member a longing glance before standing up, panting from exertion.");

                    EngineCore.outputText("\n\nThe happy girl suddenly hugs you as you're in the process of putting your prick back into your [armor].  The silvery glow around her pale skin looks stronger now, so strong that you're almost sure you can see it.  \"<i>Oh, thank you!</i>\" she starts, but quickly composes herself.  \"<i>For, um, helping me.  Up.</i>\"  She lets go and backs away from you.  \"<i>I've gotta be going though, see you around!  Enjoy the weather!</i>\"  With that, she wings off into the skies.  She lands atop a nearby tree, arms outstretched in an odd pose.  The silvery glow surrounding her is still visible, even at a distance.  You shake your head and return to camp, wondering who in the world that was.  Not long after you return, the air warms once more and the snow melts, leaving the ground a slushy mess in spots.");
                }
                player.orgasm();
                EngineCore.doNext(EventParser.playerMenu);
            }

            function acceptChristmasWomanBJ():void {
                EngineCore.clearOutput();
                EngineCore.outputText("You nod, signaling your acceptance of her offer.  The pale harpy squeals happily, bringing her hands to her chin and practically bouncing with joy.  You open your [armor] and in a flash she's kneeling with her head between your thighs.  Her hot breath against your soft flesh feels wonderful against the chill of the air.  The eager girl wastes no time in getting to work, rubbing your [clit] with two of the fingers on one hand and gently stroking your labia with the others.  Her pressure increases with the warm, comfortable feelings of arousal that her touches bring you."
                        +"\n\nIt's not long before she has you dripping and tingling down there with a need for more involved attention.  Apparently satisfied with your wetness, she grabs your thighs and pulls her face in against your crotch.  Her smooth, thick tongue runs over your lower lips, pushing you just a little further each time.  Its sudden flick into your sex is enough to elicit a sharp gasp, and you palm the back of her head almost by instinct as a shudder wracks your body.  Your gentle coos and sighs of pleasure blend into moans as she eats your [vagina] more and more fervently, her tongue probing you for the softest, most sensitive spots of your inner walls.  Your mind seems to float now, carried by waves of sexual need.  You need to cum, you need her to give you more.  Pressing her more forcefully against you now, any thoughts of her comfort vanish from your head as you run your fingers through her thick blond hair."
                        +"\n\nThe harpy gets the message and attacks your needy cunt with an almost-violent intensity.  A yelp escapes you despite yourself, but she holds you close and keeps it up unrelentingly.  Your vision nearly fogs with lusty sensation.  You roll your head back and close your eyes, drifting away on the sea of arousal building inside of your body.  At the pace she's going and with her expert technique, it's not long before that sea overflows into orgasm.  Your thoughts blank as the muscles of your [cunt] clench, your juices spraying into the mouth of the harpy.  She drinks them thirstily, tongue still lapping away as you slowly come down from your climax.  You finally let the woman go, and she removes herself from between your legs almost reluctantly while you bathe in the afterglow."
                        +"\n\nShe suddenly embraces you as you readjust your [armor].  The silvery glow around her pale skin looks stronger now, so strong that you're almost sure you can see it.  \"<i>Oh, thank you!</i>\" she starts, but quickly composes herself.  \"<i>For, um, helping me.  Up.</i>\"  She lets go and backs away from you.  \"<i>I've gotta be going though, see you around!  Enjoy the weather!</i>\"  With that, she wings off into the skies.  She lands atop a nearby tree, arms outstretched in an odd pose.  The silvery glow surrounding her is still visible, even at a distance.  You shake your head and return to camp, wondering who in the world that was.  Not long after you return, the air warms once more and the snow melts, leaving the ground a slushy mess in spots.");
                //(end female)
                player.orgasm();
                EngineCore.doNext(EventParser.playerMenu);
            }
        }
    }

    public static function encounterKamiTheChristmasRoo():void {
        //3. nRage's Kanga herm lovin
        //Xmas 'Roo Romping.
        //Character:
        //Kami, the hermaphrodite Kangaroo-morph.
        //Location:
        //The Bakery
        //Requirements:
        //Should work with Centaurs, Nagas and bipeds of all genders. 100% repeatable encounter.
        //Scenes:
        //Anal (giving), anal (receiving), blowjob (giving) and a dual dick scene (also giving.) Too big cocks or tentacle-dicked characters can still give the blowjob. All scenes done. Woooooooo.)
        if (flags[kFLAGS.KAMI_ENCOUNTER] == 0) {
            EngineCore.outputText("You enter the Tel Adre bakery with the intention of sampling some of the local confectionaries.  This time around, you're surprised to find that the place is adorned with wintery, festive decor of all shapes and sizes - even a pine tree hangs around, with gifts delicately placed underneath.   The place is packed, and you allow a curvaceous kangaroo-morph waitress to escort you to your table.  You don't remember seeing her here before, and you're certain you'd never forget a chest like hers.  The girl's heaving, E-cups press against her dainty red and white waitress uniform as she sorts your table.  She manages to catch you off-guard, realizing the objects of your interest and blushing profusely. The waitress scurries off before you have chance to apologize, her hips wiggling almost exaggeratedly as she goes.\n\n");
            //[Player must select an action, out of eating cakes etc, Rubi or the kangaroo waitress. Description provided below.]
            //To normal Bakery menu!
        }
        else {
            EngineCore.outputText("You enter the Tel'Adre bakery, the building adorned with wintery decor of all shapes and sizes.  A pine tree lies at the back, decorated with fancy gifts.  The place is livelier than usual, with the local civilians scrabbling around to buy delicacies at the counter up front.  You approach the hungry mob to investigate, identifying the commotion to be a caused by a particularly appetizing pudding dessert.  You smack your lips at the festive treat, your building hunger interrupted by a delicate, familiar voice.  \"<i>Hey there! I see you're eyeing the pudding I made!  You want some?</i>\"  The young 'roo waitress shouts across the group of feisty Tel'Adrians, waving to get your attention.  \"<i>You might wanna snatch one up before these guys do!  35 gems!  I'm gonna go ahead and take a break  - would you be interested in burning off some steam with me, doll?</i>\"\n\n");
        }
    }

    public static function approachKamiTheChristmasRoo():void {
        //Short Explanation:
        //The player enters the bakery and encounters a Kangaroo herm who hands them a 'present'. Inside there's a note offering the player sex. The player can choose to take her up on the offer and except her 'xmas present' or not. Also please note that the player is free to enter the bakery and interact with Kami again after smexing her the first time or try again after being an ass and denying her during the initial encounter. Turns out she's actually the chick responsible for making the Xmas pud (because she's so damn good at it.)
        EngineCore.clearOutput();
        if (flags[kFLAGS.KAMI_ENCOUNTER] == 1) {
            //[Player chooses 'Kami']
            EngineCore.outputText("You give Kami a nod, heading out back as she punches out for a quick break.  The waitress is out quicker than you expect, already ripping out of her red and white uniform to expose her hungry phallus.  \"<i>I'm not gonna lie, doll, you wouldn't BELIEVE how frisky working in this outfit has gotten me.</i>\"  You eye over her bodacious figure, planning your course of action.  You can tell she's been sampling her own lust-inducing cakes, and as impossible as it sounds, she looks far more hornier than usual.");
            //[Player gets the 4 options again]
            //Give Anal (Requires cock and no naga or centaur legs.)
            //Receive Anal (Again, no naga or centaur legs.)
            //Blow Job
            //Double-Dick Fuck (requires at least 2 cocks)
            EngineCore.menu();
            if (player.hasCock() && player.cockThatFits(70) >= 0) EngineCore.addButton(0, "Give Anal", giveKamiTheChristmasRooAnal);
            EngineCore.addButton(1, "Receive Anal", takeItRooButtStyle);
            EngineCore.addButton(2, "Give BJ", KamiBlowJob);
            if (player.cockTotal() > 1 && player.cockThatFits(70) >= 0 && player.cockThatFits2(70) >= 0) EngineCore.addButton(3, "Doube-Fuck", KamiDoubleDickFuck);
        }
        else {
            EngineCore.outputText("You summon the buxom waitress over, getting a much better view of her gentle face now that she's found the time to sit and talk with you.  With hazelnut-brown eyes, a gorgeous set of lips and tousled blonde hair, her faux-rebellious look is the icing on the festive cake for this busty waitress, her cute little santa hat being the strawberry on top.  Smooth, olive skin runs halfway down her meaty thighs before fading into soft fur, while her frail forearms follow the same pattern. Her huge kangaroo tail wags idly throughout your conversation, and you've gained a pretty good rhythm whilst engaging her in it. Determined to make things go well, you pause to pull out a charming one-liner when her index finger meets your ");
            if (player.femininity >= 75) EngineCore.outputText("feminine ");
            else if (player.femininity <= 25) EngineCore.outputText("masculine ");
            EngineCore.outputText("lips abruptly."
                    +"\n\n\"<i>Stop.  Stay right here.  I'll be right back.</i>\""
                    +"\n\nThe kanga girl rises and walks into the bakery storage room, appearing again only seconds later with a medium-sized present in her hands.  You'd almost be curious about it, but an even more intriguing 'surprise' catches your eyes directly beneath it in the form of a massive, protruding and honestly, quite blatant, wet bulge that presses against her garments gloriously.  Apparently this waitress is packing a little something extra."
                    +"\n\nShe places the present in your lap, then scoots backwards to await your response.  You notice her legs twitching agitatedly in anticipation, presumably from the lubricants dripping from between her well-formed thighs.  She's pretty damn aroused right now, by the looks of it.  You decide to open the present at once, opening the lid to reveal... a small, folded note.  You give the kangaroo girl one last glance before you thumb the little message open to see what the fuss is about.");
            EngineCore.outputText("\n\nThe note reads: \"<i>\<i>Hey there " + player.mf("stud", "babe") + "\</i>.  My name's Kami.  Wanna come out the back and fuck?  It can be my special present to you.</i>\"  She signed it with a winking smiley face");
            if (EngineCore.silly()) EngineCore.outputText(" and found space to scrawl a little penis in one corner. Clever");
            EngineCore.outputText("."
                    +"\n\nWow, well, that's pretty blunt.  What should you do now?");
            //[Present options, 'Let's go!' and 'Leave']
            EngineCore.menu();
            EngineCore.addButton(0, "Let's Go", chooseLetsGoKami);
            EngineCore.addButton(4, "Leave", skipOutAfterOpeningKamisBox);
        }

        //[Player chooses 'Leave']
        function skipOutAfterOpeningKamisBox():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You politely decline Kami's sexual advances, apologizing before making a turn for the door. You begin to wonder why you didn't buy anything at the bakery.");
            //[Return to Tel Adre, KamiEnc = 1]
            flags[kFLAGS.KAMI_ENCOUNTER] = 1;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //[Player chooses 'Let's go!']
        function chooseLetsGoKami():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You decide to give Kami exactly what she wants - 'tis the season for giving, after all!  You grin approvingly before heading out into the back alley, taking your time to stare at her wobbling ass."
                    +"\n\nOnce outside, Kami confirms your suspicions by immediately ripping down her tight skirt, sighing softly as her impressive member flops free from her lacy black thong. You wonder how she managed to hide it so effectively with the virtually non-existent piece of lingerie."
                    +"\n\n\"<i>Ah, so much better!  Come here and ravish me, hon.</i>\" She moans enticingly, stroking her self-made lubricant along her growing thickness."
                    +"\n\nYou gaze over the situation.  How should you handle this?");

            //[Player given 4 options: 
            //Give Anal (Requires none-tentacle cock and no naga or centaur legs.)
            //Receive Anal (Again, no naga or centaur legs.)
            //Blow Job
            //Double-Dick Fuck (requires at least 2 cocks)
            //Note: I don't know much about vaginal or anal capacities so just give her general ones similar to Izma or Urta. ]
            EngineCore.menu();
            if (player.hasCock() && player.cockThatFits(70) >= 0) EngineCore.addButton(0, "Give Anal", giveKamiTheChristmasRooAnal);
            EngineCore.addButton(1, "Receive Anal", takeItRooButtStyle);
            EngineCore.addButton(2, "Give BJ", KamiBlowJob);
            if (player.cockTotal() > 1 && player.cockThatFits(70) >= 0 && player.cockThatFits2(70) >= 0) EngineCore.addButton(3, "DoubleFuck", KamiDoubleDickFuck);
        }

        //[Player chooses 'Give Anal']
        function giveKamiTheChristmasRooAnal():void {
            EngineCore.clearOutput();
            var x:int = player.cockThatFits(70);
            EngineCore.outputText("You head briskly towards the voluptuous waitress, rearing her around by the wrists and pressing her against the wall.  \"<i>H-Hey, wait!</i>\" Kami yelps, but you sense excitement in her delicate plea."
                    +"\n\nIntent on being the dominant partner, you spit on one of your fingers and slide it into her tight asshole at once, prepping it for your oncoming invasion.  Freeing just enough room in your garments for your own member to breathe, you waste no time at all in aligning your fuck-stick underneath her thick kangaroo tail and right between her rosy asscheeks. Kami invites you into her ass as seductively as she can, swaying her ample thighs and massaging her pucker against your cock-head aggressively.  \"<i>Be at least a bit gentle, doll,</i>\"  she coos seductively in your ear, giving you the green light for a full-on pounding as your cock sinks into her heart-shaped butt and unleashes hell."
                    +"\n\nKami squeals between each of your dominating thrusts");
            //[If player has balls]
            if (player.balls > 0) EngineCore.outputText(", your balls slapping against her with every push");
            EngineCore.outputText(".  \"<i>Anh! No! Ah!</i>\"  She winces between each thrust, your [hips] doing little to help as they pick up the pace.  You continue pounding her ass for as long as you can, briefly releasing her wrists to give her bubble-butt a hard smack.  Kami's passage is warm and moist with your pre, and it isn't long before you find your cock sliding in and out of your slut's snug ass-tunnel as if it was made for you.  Eventually, Kami's vice-like grip on your " + player.cockDescript(x) + " loosens, and she begins lose herself to your dominating display.  Swaying her head side to side in enjoyment, you fuck her raw and hard - her hat bobbing up and down in a manner as hypnotising as her jiggling flesh.  You pull her to the ground to give her your final few thrusts before you churn out your spunk, falling over her and weakly bucking like some manner of beast.");

            EngineCore.outputText("\n\n\Kami squeals excitedly as she reaches her own climax underneath you, tugging rapidly on her precum-soaked herm cock, milking it like crazy onto the ground beneath her.  You can feel her dripping fem-sex mesh against your own [sack] as you empty into her tight passage.");

            //{If cum quantity = light, medium}
            if (player.cumQ() < 1000) EngineCore.outputText("  \"<i>Mmm... just like that, babe,</i>\" Kami moans submissively, her asshole clenching one last time before you pull out and climb off your satiated conquest, your " + player.cockDescript(x) + " still dripping creamy white spunk.");
            //{if cum quantity ≧ heavy}
            else
                EngineCore.outputText("  One of Kami's hands flies from her dick to her suddenly swollen belly as your mighty seed gushes forth.  The unexpectedly heavy girl sinks further into the ground, your load swishing back up and loosening her tunnel around you and forcing you to remove your still-spewing " + player.cockDescript(x) + " before something unfortunate happens.  Semen starts tumbling out as soon as you dismount your kangaroo conquest, but judging by the slow pace, she's going to look heavily pregnant for a while.");

            EngineCore.outputText("\n\n\Replacing your clothes, you give Kami one last glance over before you leave.  She's lying happily encumbered on the floor, covered in a combination of your fluids.  She'll probably be good to head home later - that is, if she can still walk.");
            //[Player heads back to camp, An hour passes, Lust is reduced to zero and KamiEnc = 1]
            flags[kFLAGS.KAMI_ENCOUNTER] = 1;
            player.orgasm();
            player.dynStats("sen", -2);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //[Player selects 'Receive Anal']
        function takeItRooButtStyle():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You wink at the stacked waitress, turning around and planting your [chest] against the alley wall submissively.  Quickly removing your [armor], you turn to give your advancing lover a smile - but you're quickly caught off guard by the kangaroo girl's phallus plunging towards and into your [butt] at full speed.");
            player.buttChange(24, true, true, false);

            EngineCore.outputText("\n\n\"<i>Oh shit!</i>\" she cries, her plump hips pistoning into your [asshole] recklessly.  You estimate at least eight inches of her meaty member are inside with the first few thrusts alone, not including however many she's already trying to squeeze in. You feel her thick tail brush along your thighs, shivering as she whispers into your ear. \"<i>I'm going to pump you so full of cum, you'll be out of commission for weeks, doll.</i>\"   You try to focus your attention on absorbing her powerful thrusts, gradually easing into it as her lubricants soften up your hot passage.  Eventually, at least 14 inches of pure cock slams deep into your pucker. With every buck, her balls ricochet off ");
            if (player.balls > 0) EngineCore.outputText("your own");
            //[Else if have vagina]
            else if (player.hasVagina()) EngineCore.outputText("your pussy");
            //[Else if neither]
            else EngineCore.outputText("your taint");
            EngineCore.outputText(".  Each time, the waitress fondles your form with her eager hands.  "
                    +"\n\n");
            //[If player has pussy] 
            if (player.hasVagina()) EngineCore.outputText("Your cunt oozes in return, envious of the tenderized hole above it.  ");
            EngineCore.outputText("You dedicate a few more minutes to soaking up every moment of her animalistic romping, savoring the feeling of a hung rod in your punished posterior.  Your climax quickly comes to loom over you, however, the potent, ");
            if (player.hasCock()) EngineCore.outputText("prostate");
            else EngineCore.outputText("ass");
            EngineCore.outputText("-numbing sensations at your rear becoming too much to bear.  Slamming back into Kami's pole one last time, you breathe a shuddered sigh of relief as your orgasm takes over, the sensation spreading throughout your entire body like electricity.");
            //[If male]
            if (player.hasCock()) EngineCore.outputText("  Your pent-up cock ejaculates there and then, shamelessly gushing sloppy semen against the wall in front of you.");
            //[If female]
            if (player.gender == 3) EngineCore.outputText("  Meanwhile, y");
            else if (player.hasVagina()) EngineCore.outputText("Y");
            if (player.hasVagina()) EngineCore.outputText("our eager pussy buckles in arousal, gushing fem-juices on the floor below you.");
            EngineCore.outputText("  You're truly spent."
                    +"\n\nKami, on the other hand, needs a tad more encouragement.  She desperately diddles her unused slit for as long as she can take it, her own belated orgasm finally erupting messily into your asshole moments later.  \"<i>Oh doll, I - ungh - needed that more than anything.  If you come back before the end of winter, we should definitely try this again.</i>\"  You give a thumbs up in approval of Kami's idea, turning around to head back to camp. Before you go, however, you take the opportunity to get a good squeeze of her ample tits, quickly taking off with complete satisfaction.");
            //[Player heads back to camp, An hour passes, Asshole tightness is reduced, Lust is reduced to zero and KamiEnc = 1]
            player.orgasm();
            player.dynStats("sen", 1);
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            flags[kFLAGS.KAMI_ENCOUNTER] = 1;
        }

        //[Player selects 'Blow Job']
        function KamiBlowJob():void {
            EngineCore.clearOutput();
            //[If player is none-Naga]
            if (!player.isNaga()) EngineCore.outputText("You get down on your knees");
            //[Else if is Naga]
            else EngineCore.outputText("You steer your serpentine half into position, leaning your upper body within arms reach of Kami's wanting member.  You reach out");
            EngineCore.outputText(" and grab the thick rod impulsively with your hand, all 14 inches of the slick tool in your firm grasp.  Kami giggles in approval as you take the first few licks of the phallus, jerking your hand up and down its length slowly.  \"<i>Mmm... someone knows what they're doing.</i>\"  You spit on the head of her thick cock, smearing the improvised lubricant all over her girth generously, her digitigrade legs crossing and twitching agitatedly in response.  \"<i>Oh god hurry up and put it in your mouth already!</i>\"  You grin at her impatience, teasing her tip a bit longer before finally knuckling down.  Her first few inches slide in with much resistance, fresh saliva coating the shaft and easing her in against your tonsils smoothly and without fuss."
                    +"\n\nThe reaction you get from her, however, is much more spontaneous - Kami's kangaroo toes curl out while she moans enthusiastically.  The joy of having her length engulfed by your tight throat is painted plain on her face as much as you are buried into her crotch.  Throttling your head forward, Kami groans.  Her warm precum already starts to spill against your bottom lip, a little spooge dribbling out sloppily every time you pull back.  You reach behind her large member and spear her two holes with a finger each, drilling your two digits inside her erogenous pockets with lustful intent.  \"<i>W- oh god!</i>\"  She cries, your stimulation apparently too much for her to handle. Kami's tight pucker clamps down hard as her fem-sex and cock erupt simultaneously, soaking cum against both your active finger and the back of your throat."
                    +"\n\nYou gulp down her load without a sweat, pulling your fingers free from Kami's wetness. You allow Kami's soft, delicate lips to envelope and smother your own, giving her a taste of her man-milk in return.  You give her a seductive wink before finally pulling away to put on your garments, but Kami insists on your attention to apologize.  \"<i>Hey, uh, sorry for cumming so early there - if it's any consolation, that was amazing!  Next time you should be the one taking charge, doll.</i>\"  You beam at Kami, the waitress pecking you on the cheek before you head back to camp.");
            if (player.hasCock()) EngineCore.outputText("  You think you might still need to find an outlet for that itch of yours, with [eachCock] still erect and needing release.");
            player.dynStats("lus", 20 + player.lib / 10 + player.sens / 10);
            //[Player heads back to camp, An hour passes, Lust = + 40 and KamiEnc = 1]
            flags[kFLAGS.KAMI_ENCOUNTER] = 1;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        function KamiDoubleDickFuck():void {
            //[Player selects 'Double-Dick Fuck']
            var x:int = player.cockThatFits(70);
            var y:int = player.cockThatFits2(70);
            EngineCore.clearOutput();
            EngineCore.outputText("You chuckle heartily - of course you're going to ravish her!  How ridiculous to assume otherwise.  In a split second, you've already grabbed her by her arms, forcing her back against the wall.  Kami passionately yelps, but her eagerness to grind against your growing package reveals her true intentions."
                    +"\n\nTaking the initiative, you hold the waitress by the throat whilst you free room in your [armor] for your succulent snatch-hungry sausages.  Wasting no time at all, you align your rock-hard rods underneath her huge phallus and directly at her needy orifices, moving your hands underneath her legs and lifting her slightly to add leverage for yourself.  Kami pants in anticipation, gently pressing herself against your cockheads in an attempt to entice you.  Ever the tease, you notice the waitress gasp between her delectable lips.  \"<i>Are you gonna put those fine-ass rods to use, or do I have to do it myself?</i>\"  Not about to disappoint, you push into her, penetrating the soft confines of her pussy before reaching into her tight little ass, slowly but steadily plunging further and further inside until your needy tools can't reach any further.  \"<i>F-Fuck!  Drill me hard!</i>\" she cries desperately."
                    +"\n\nRearing out slower than you had entered, her hips support yourself as you dive your way back in, slowly speeding up the frequency of your thrusts each time.  As you aggressively pump into your new kanga-slut, you force the waitress to press further against the alleyway wall behind her, her arms spreading out while her pillowy chest is squished against the brick.");
            EngineCore.outputText("\n\n\"<i>I could do this all goddamn day!</i>\"  Kami screams, your wicked thrashing leaving her pelvis moist with sheer bliss.  You can already feel your own orgasm approaching, so with due haste you grab Kami's ample bust and pick up your thrusts energetically, ramming your cocks home with as much speed as you can muster.  Your ass-engorged " + player.cockDescript(x) + " cums first, packing Kami's tight hole with your sticky seed, shortly followed by your other " + player.cockDescript(y) + " giving her delicate-yet-punished pussy the same treatment.");

            EngineCore.outputText("\n\nKami is only seconds behind, her figure leaning forward into your arms and spasming up against you in a sexual seizure.  \"<i>Oh my god!</i>\"  The 'roo girl squeals, her tongue lolling out in intense arousal as her 14 inch cock spurts its pent-up frustration all over your abdomen.  You can feel the fur on her thighs standing briefly on end as she coils them around you, the sensation gradually fading away slowly as her frantic panting slows down."
                    +"\n\nYou gather your thoughts for a second, exhausted from the actual ordeal.  You slowly put back your [armor] while sharing an appreciative farewell to the now-satiated waitress - of who is panting so profusely she can't even return the gesture.");
            //[Player heads back to camp, An hour passes, Lust is reduced to zero and KamiEnc = 1]
            player.orgasm();
            player.dynStats("sen", -3);
            flags[kFLAGS.KAMI_ENCOUNTER] = 1;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }
    }

    public static function getWinterPudding():void {
        //[Player enters bakery, Date must be at least 15 Dec and KamiEnc must be 0]
        EngineCore.clearOutput();
        if (player.gems < 35) {
            EngineCore.outputText("Sadly, the pudding isn't free, and it looks like you don't have the 35 gems you'd need to try a bite!");
            EngineCore.doNext(SceneLib.telAdre.bakeryScene.bakeryuuuuuu);
            return;
        }
        player.gems -= 35;
        EngineCore.statScreenRefresh();
        EngineCore.outputText("You opt for a slice of the tasty treat - you've only got until the festivities wade away, so you might as well take one now!  Do you eat the treat or save it for later?\n\n");
        EngineCore.menu();
        EngineCore.addButton(0, "Eat", CoC.instance.mutations.winterPudding, player, true, null, "Eat the delicious Winter Pudding.");
        EngineCore.addButton(1, "Take", SceneLib.inventory.takeItem, consumables.W_PDDNG, SceneLib.telAdre.bakeryScene.bakeryuuuuuu, null, "Bring the pudding with you.");
        //doNext(telAdre.bakeryScene.bakeryuuuuuu);
    }

    public static function polarPete():void {
        //4. Donto's Polar Pete
        //Random Holiday plains encounter
        EngineCore.clearOutput();
        EngineCore.outputText("As you travel through the plains, something seems to be off the further you continue to walk.  Soon your breath mists in front of your mouth, and you hug yourself as the temperature seems to drop.  As you look up, flakes of pure white fall from above.  The ground at your feet is littered with frost and dusted with snow, and you feel a chill run up your spine as you adjust to the colder weather. Something unnatural seems to be affecting the area."
                +"\n\nWith a crunch of snow, you turn your head to see a large figure in the distance.  The flurry of snowfall blurs your vision, though it seem to be getting closer.  Once it's close enough, you can make out what it is."
                +"\n\nWalking towards you is a rather large man - from far away he seemed to simply be a tall human, but as he gets closer you can tell something is off.  He is hairy, very much so, as his body is covered in short white fur.  Rounded ears peek out of his crown of white hair, the color matching his rugged, short boxed beard.  A smile on his lips at the sight of you, his muscled arms heft a large sack hung over his shoulder.  The strange man seems unperturbed by the weather, perhaps because he is wearing a large crimson coat lined with white fur and matching pants.  His big black boots crunch the snow underfoot."
                +"\n\n\"<i>Happy holiday!</i>\" His deep voice bellows out to you, and despite your unease, the strange male gives off a sense of... jolliness.  You can't help but feel a bit happier simply looking at him - he certainly seems happy to see you."
                +"\n\n\"<i>I had hoped to run into someone like you on my trip.  I've got a lot of stops to make, many gifts to give.</i>\"  His arm sets the large sack down in the snow next to himself.  You take a closer look and can make out square bulges in the large brown bag.  \"<i>My name's Polar Pete,</i>\" he says, his lips curling into a confident grin."
                +"\n\n\"<i>And for you, I have a very special package, just for the good boys and girls.</i>\"  His large furred hand lewdly cups over his groin, making his bulge more pronounced as he stretches the fabric of his pants.  You can see the girth of his 'candy cane' hanging limp over his heavy sack.  His eyes give you a lurid gaze, an expectant twinkle in his eyes.  \"<i>Come over and unwrap it.</i>\"  His low voice makes goosebumps crawl over your skin.");
        //Open options Leave, Unwrap
        EngineCore.menu();
        EngineCore.addButton(0, "Unwrap", unwrapPolarPete);
        EngineCore.addButton(4, "Leave", leaveDisFukkinPolarBear);

        //Unwrap
        function unwrapPolarPete():void {
            EngineCore.clearOutput();
            EngineCore.outputText("The temptation too strong, you walk closer to Pete.  Sinking down to your knees before him as he adjusts his hips to your level.  Your hands on his crimson pants, pulling them down with bated breath.  His dark ebony length flops free, long and swollen with heat before your nose. Your hand rubs along it's smooth black surface coaxing a pleased groan from Pete."
                    +"\n\n\"<i>Give my south pole a good shining,</i>\" he purrs.  You lift up the rapidly swelling candy cane to get a good look at Pete's shaved sack.  Your face leans forward to lick your tongue over Pete's balls, his musky scent fresh on your lips.  Pete must have been walking a long time with little breaks, you can taste a small amount of sweat on his loins, his scent heavy with neglect and need."
                    +"\n\nYour eyes look up to see his head tilted back, his mouth open wide as he bellows out a guttural groan.  You continue to spit shine the festive man's sack, the cold air contrasting with the warmth of his loins and your mouth.  The warmth of your saliva lingers as your lips brush over the base of his black length, and you give the stiff cock a few strokes with your hand.  You take a moment to feel just how long Pete has gotten, he's so thick you can't completely wrap your fingers around him."
                    +"\n\nYour tongue runs along the long black cock, reaching the cockhead to kiss it with your lips.  His foreskin folds over most of his cockhead, the tip peeking out with a pearl of milky white at it's slit.  The scent of peppermint mixes with his musk, you catch the precum with your tongue, letting out a pleased hum as you taste sweet minty freshness."
                    +"\n\nPete's hand nestles in your [hair], egging you on insistently.  You slip your tongue under his foreskin, swirling it under the flap of skin, tasting a strong tang of sweat and musk.  The teasing of his cockhead makes his moans all the louder, his candy cane fully erect in your grip and dripping with precum."
                    +"\n\n\"<i>I got something more for a perfect little cocksucker, work real hard and it's all yours.</i>\"  Pete smiles, his half lidded gaze on you.  With his words, you wrap your warm lips around his girth, taking the minty cock into your mouth as your tongue continues to slither over the drooling cockhead.  Your hands pumping along the smooth black shaft as you suckle on his cock, his heavy sack swaying as his hips rock, nudging his length to thrust gently into your hot mouth."
                    +"\n\nSoon his length is bumping the back of your throat, you snake your tongue along the underside of his shaft as he shoves his fat cock down your throat.  He gives a jolly chuckle as he takes the reins.  His hands move your head along his slick ebony cock, his hips pressing to your face.  He takes a few steps forward, before beginning to thrust at a rapid pace, his boots planted firm in the cold snow as he begins to fuck your face."
                    +"\n\nPanting heavily as his groin rams your face, his fat black sack slapping your chin.  His massive candy cane opens your jaw wide, plunging down your throat as he stretches the silken walls of your insides.  Your throat visibly bulges from the outside as his giant pole plows into your mouth, every inch of his dark dick glistens with your spit mixed with his creamy, mint flavored spunk."
                    +"\n\n\"<i>Your 'chimney' is so tight and hot, perfect for me to go down.</i>\"  He stares down at you, laughing heartily as he slows his pace.  He watches his black cock slide along your lips, the tight ring of your mouth slurping up his dick, milking it as it tugs and squeezes his stiff flesh."
                    +"\n\n\"<i>Open wide for your present,</i>\" he grunts, pulling his cock free as your spit still clings to it, his large hand jerking himself off as you hold your face poised and ready.  With a satisfied groan he unloads his christmas cheer all over your face, the snow white load spilling over your cheeks, clinging to your body with a heat that warms your cold body.  He fires a few ropes into your open mouth, the liquid creamy and minty at the same time.  It slides over your tongue as you swallow the thick spunk.  It warms your belly as Pete gives you a pleased grin."
                    +"\n\n\"<i>That's the holiday spirit.</i>\"  He winks at you slyly.  \"<i>You've been real... good this year [name].</i>\"  You blink as he calls you by name, wondering how he knows it as he rummages through his large sack.  Pete pulls out a gigantic candy cane, bigger than any you've ever seen.  He grins at you as he holds it in one hand, nudging the long straight end to press to your lips."
                    +"\n\n\"<i>It's a special treat just for you.  Go on, use that wonderful mouth of yours,</i>\" he eggs you on as you comply.  The strange candy cane doesn't feel normal at all, Pete has to angle it to nudge your lips as it isn't as stiff as normal candy.  As you wrap your lips around the thick sugary treat it feels flexible in your lips.  The sweet peppermint flavor washes over your tongue along with something else.  You can't quite pick out what it is, but something mixed in with the special candy is making your skin hot against the cold weather."
                    +"\n\n\"<i>Yes, that's it. Don't be shy now.</i>\"  Pete gives a jolly laugh as he starts pushing more past your lips.  You give a muffled moan, your lips wrapped tight around the giant confection.  The heat in your body grows, and your loins began to ache.");
            if (player.hasCock()) EngineCore.outputText("  [EachCock] grows stiff and soaks your [armor] with precum.");
            //(if vagina) 
            if (player.hasVagina()) EngineCore.outputText("  Your [vagina] grows moist, dripping eager juices and soaking your [armor].");

            EngineCore.outputText("\n\n\"<i>Oh ho ho ho, seems like you're really enjoying your gift.  Let ol' Polar Pete lend you a hand,</i>\" he says with a twinkle in his eyes as he lays you down in the snow, his free hand stripping you of your [armor].  Despite the cold you can only sigh in relief, your skin so hot it feels like you could melt the ice and snow with ease.  Pete begins to thrust the massive candy cane into your mouth, the flexible treat dipping down inside your throat with ease."
                    +"\n\n\"<i>Looks like I missed a spot to cram in my Holiday cheer,</i>\" Pete snickers as his free hand pulls apart your [legs] and feels up your [butt].  His fingers rubbing over your [asshole].  He brings his hand to his spit and cum slick cock, and smears the slurry all over his fingers before loosening up your [asshole].  He thrusts his digits in time with the giant candy cane jammed down your throat.  You groan in pleasure helplessly, the addictive candy melting in your mouth and glazing your throat in sweet, arousing goodness."
                    +"\n\nYou shut your eyes in bliss, and before you know it, Polar Pete slips between your [legs].  His south pole is pushing into your loosened pucker.  \"<i>Oh ho ho..</i>\" he groans as his smooth ebony length slips past your rim and stretches your inner walls.  He leaves the candy cane stuffed in your mouth as he begins to slap his hips against your [butt].  You moan and squirm as Polar Pete goes to town on your [asshole], the warm sticky precum lubing you up as he sinks in further."
                    +"\n\nHis entire length hilting in you again and again, both your holes stuffed with Polar Pete's gifts.  He rubs his south pole all over your inner confines, angling his thrusts to grind and smear his warm seed against every inch of your chimney.  Your ass cheeks jiggle as his hips ram into them, coaxing muffled moans from your gagged mouth.");
            player.buttChange(25, true, true, false);

            EngineCore.outputText("\n\n\"<i>Mmm, I'll definitely have to go down your chimney every year.  You're so very good,</i>\" he pants, clouds of mist fogging his face as he exhales deep breaths in the cold air.  He suddenly takes on a brutal pace, the sound of flesh slapping flesh filling your ears as he leans forward and begins to pound away at you with refocused intent.");
            //[(if cock) 
            if (player.hasCock()) EngineCore.outputText("  His continued ramming of your prostate mixed with the addictive candy crammed in your mouth sends you over the edge, [eachCock] shooting out ropes of snow white all over your chest.  Pete eyes you over with a lurid gaze, your face covered in his cum and your body covered in your own.");
            else if (player.hasVagina()) EngineCore.outputText("  Your [vagina] quivers, the rough thrusting into your [asshole] mixed with the addictive candy in your mouth sending you over the edge.  With a low muffled moan your mound spills your lust over your groin, dripping down to lube Pete's thrusts as well as your [legs].  Pete gives you a lurid gaze.");

            EngineCore.outputText("\n\nWatching you writhe in pleasure filled bliss, Pete pounds away at you with a few sharp thrusts.  His ballsack nestles in between your ass cheeks as he buries as much of his south pole into you as possible.  With his ebony cock twitching and unloading into you, he groans loudly, and he pumps your stomach full of his creamy Holiday cheer.  You feel a bit bloated as your stomach bulges.  Pete pulls out as his hot minty spunk spills from your abused [asshole]."
                    +"\n\n\"<i>You've been very good, but it's time for me to go.  Many more people I need to see, so many gifts to hand out,</i>\" Pete chuckles as he pulls the candy cane from your mouth.  He lets you slowly get up and get dressed as he zips up his pants and tucks away the massive candy cane in his pack.  You finish dressing as Pete rummages through his large leather sack for a few moments before producing a box wrapped in brightly colored paper."
                    +"\n\n\"<i>A little something extra to remember me by.  I'll be keeping an eye out for you next year.</i>\"  He gives you a sly wink as he places the box in your hand.  With that he lifts up his sack and walks off, no doubt to continue his gift giving journey.  You look at the box a moment, unwrapping it to find a crystal bottle filled with a familiar white liquid inside.  You uncork the bottle to smell the familiar minty scent.  You begin wonder why would someone bottle their own seed and give it as a present, though you shrug it off and take the bottle with you as you return to camp.\n\n");

            //Lust sated
            //end encounter
            //Receive \"<i>Peppermint White</i>\"
            player.orgasm();
            SceneLib.inventory.takeItem(consumables.PEPPWHT, SceneLib.camp.returnToCampUseOneHour);
        }

        //Leave
        function leaveDisFukkinPolarBear():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You've decided not to trust the stranger, with a nod of your head you walk away from the man.  \"<i>Wait!  Before you go...</i>\" he speaks as he moves his massive sack in front of himself with a huff.  He leans forward, his upper body rummaging through the sack before reappearing.  He hands you a brightly wrapped gift."
                    +"\n\n\"<i>A little something from me,</i>\" he says with a bright smile.  Despite your hesitation, something about this gesture seems genuine.  You nod your head taking the gift from him and leaving after a simple word of thanks.  You unwrap the gift after returning to a normal climate, inside you find a small crystal bottle filled with a white liquid that looks strangely familiar.  Popping the cork and smelling the contents fills your nose with the refreshing scent of mint. It smells delicious, though you resist the temptation and cork the bottle again.  You take it with you back to camp.\n\n");
            //Receive \"<i>Peppermint White</i>\"
            SceneLib.inventory.takeItem(consumables.PEPPWHT, SceneLib.camp.returnToCampUseOneHour);
        }
        flags[kFLAGS.POLAR_PETE_YEAR_MET] = date.fullYear;
    }

    public static function nieveHoliday():Boolean {
        return date.month == 11 || date.month == 0;
    }

    public static function snowLadyActive():void {
        //5. Third's Nieve
        //Winter Snowfall
        //Accessible after sleeping as long as it's Winter (December - February)
        //Creation!
        //Accessed from \"<i>Snow</i>\" at the Lover or Stash menu.
        EngineCore.clearOutput();
        EngineCore.hideMenus();
        EngineCore.outputText("A chill pervades the air as you awaken, making you shiver.  You open your eyes blearily, looking around the camp, until your gaze falls onto a solid white patch of earth. Its bright, glittering white actually hurts your eyes for a second, as you're so used to the dark, hellish red that surrounds you."
                +"\n\nYou stand up from your bedroll and walk towards the shimmering patch of white.  Could this be some sort of trap, laid by the demons?  What could it possibly be? As you approach you realize the white is not only on the ground... it's falling from the sky."
                +"\n\n<b>Snow!</b>");

        EngineCore.outputText("\n\nYou dash into the frosty area, delighting in the familiar crunch of snow underfoot.  More snowflakes float down, landing on your " + player.skinFurScales() + " and melting immediately.  For just a moment, you feel like a kid again, twirling and spinning in the flurry, sticking your tongue out and tasting the flakes, you swear you can almost smell the fresh baked winter delights of your village.  As the nostalgic feeling fades, you hear a slight jingling in the air, far off in the distance, followed by a hearty, jolly laugh.");

        EngineCore.outputText("\n\nYou lay down in the snow, waving your arms and legs to make a quick snow angel as you think about all the things you could do with this holiday gift.  You think back to your childhood, and kids making snowmen after a fresh snowfall."
                +"\n\nSitting up in the glittering field of white, you figure you've got enough here to make a decently sized snowman.  For materials... sticks for the arms, of course, are freely available around you, and you're certain you've got a few old rags around for a scarf.  For the eyes, all the kids in Ingnam used coal, but you figure gems would also work. The nose, you think to yourself, would be the trickiest, where to find a carrot in this place?"
                +"\n\nThinking over the logistics of the snowman, you head back into the camp proper.");

        //(Adds \"<i>Snow</i>\" to the Stash or Lover menu)
        EngineCore.outputText("\n\n('Snow' added to the <b>Items</b> menu!)");
        flags[kFLAGS.NIEVE_STAGE] = 1;
        EngineCore.doNext(EventParser.playerMenu);
    }

    public static function nieveBuilding():void {
        EngineCore.clearOutput();
        //First Step: The Body
        if (flags[kFLAGS.NIEVE_STAGE] == 1) {
            //Consumes an hour of time.
            //This determines the sex of Nieve once she's complete.
            EngineCore.outputText("You head back over to the snowy patch by your camp.  The crunch of snow again makes you feel just a little nostalgic, and you think of drinking hot cocoa topped with marshmallows.  With a smile on your face, you set about rolling up the soft powder-like crystals into a huge ball.  It takes some effort, but after a while you're left with a large ball of snow, which will serve as the perfect base."
                    +"\n\nYou set yourself to making the second section, the torso.  It takes less time, but then you have to haul it up onto the base without it falling apart.  You take your time, though, and everything goes smoothly."
                    +"\n\nFinally, the head.  You make yet another small ball of tightly packed snow and place it upon the tower, and stand back to look at your creation.  You grab a couple sticks nearby and grab a piece of torn cloth from your camp, placing them all on the snowman to make arms and a scarf.  It's a pretty good piece of work."
                    +"\n\nSuddenly, a naughty thought strikes you. You could probably make this snowman into a snowwoman if you wanted to.");
            EngineCore.menu();
            EngineCore.addButton(0, "Snowwoman", nieveSnowWoman);
            EngineCore.addButton(1, "Snowman", nieveSnowMan);
            //[Snowwoman] [Snowman] 
        }
        //Second Step: Eyes & Mouth
        //Alters Nieve's eyes in scenes
        else if (flags[kFLAGS.NIEVE_STAGE] == 2) {
            EngineCore.outputText("You approach your snow" + nieveMF("man", "woman") + " again, looking it over.");
            EngineCore.outputText("\n\nIt still needs eyes and a mouth.  Coal is the best option, but who knows how common that is around here?  Gems, you decide, are an acceptable stand-by.  It'd probably take 9 gems to complete, two for the eyes and seven for the mouth.");
            //[Coal (Only available if PC has coal)] [Gems]
            EngineCore.menu();
            if (player.hasItem(consumables.COAL___)) EngineCore.addButton(0, "Coal", nieveCoalEyes);
            EngineCore.addButton(1, "Gems", nieveGemEyes);
            EngineCore.addButton(4, "Back", SceneLib.camp.returnToCampUseOneHour);
        }
        //Fourth Step: The Nose
        else if (flags[kFLAGS.NIEVE_STAGE] == 3) {
            EngineCore.outputText("You approach your nearly finished snowman. To others, it might be a perfectly acceptable creation, but not to you. It needs a carrot to finish it off.");
            //(If PC has the carrot) 
            if (player.hasKeyItem("Carrot") >= 0) {
                EngineCore.outputText("\n\nLuckily, you've got the perfect one, courtesy of Whitney's farm.  You quickly wash it up and snip the tail end of it off before sticking it right into the center of the snowman's face.  Nostalgia flows over you as you stand back to admire your handiwork.  You feel as if you've brought a little of Ingnam into this strange land, a little bit of cheer into this desolate landscape."
                        +"\n\nYou enjoy the presence of your new snowman creation for a while, and then return to your camp with a little smile laid out on your face.");
                flags[kFLAGS.NIEVE_STAGE] = 4;
                player.removeKeyItem("Carrot");
                EngineCore.outputText("\n\n(Removed Key Item: Carrot)");
            }
            //(Else) 
            else {
                EngineCore.outputText("Unfortunately, you've yet to find one in your adventures.  You suppose you'll have to look more carefully.  Who knows, there might be a farm right under your nose.");
            }
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }
        else {
            EngineCore.outputText("Your snowman is done!  There's nothing more to add to it.  It looks mighty fine however, and just looking at it brings a nostalgia-fueled smile to your lips.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //Coal
        //Add to previous text if possible?
        function nieveCoalEyes():void {
            EngineCore.clearOutput();
            player.consumeItem(consumables.COAL___);
            EngineCore.outputText("Luckily, you happen to have two lumps of coal."
                    +"\n\nYou split the coal into smaller chunks, and place them evenly around the Snowman's face, creating a nice, vacant smile.  It still needs a nose, however, and for that, you'll need a carrot.  Perhaps there's a farm nearby, or maybe you could buy one somewhere?");
            flags[kFLAGS.NIEVE_MOUTH] = "coal";
            flags[kFLAGS.NIEVE_STAGE] = 3;
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //Gems
        //Add to previous text if possible?
        function nieveGemEyes():void {
            EngineCore.clearOutput();
            if (player.gems >= 9) {
                EngineCore.outputText("Taking a handful of gems out of your pouch, you spread them evenly around the Snowman's face, giving it a nice, vacant smile.  It still needs a nose, however, and for that, you'll need a carrot.  Perhaps there's a farm nearby?");
                player.gems -= 9;
                EngineCore.statScreenRefresh();
                flags[kFLAGS.NIEVE_MOUTH] = "gems";
                flags[kFLAGS.NIEVE_STAGE] = 3;
            }
            //Too broke to use the gems option? What the fuck is wrong with you?
            else {
                EngineCore.outputText("You open up your pouch, and frown.  Unfortunately, you don't have enough gems to create the eyes and mouth. With a sigh you march your broke ass back to camp.");
            }
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //Snowwoman
        function nieveSnowWoman():void {
            EngineCore.clearOutput();
            //Add to existing text if possible, rather than a new window?
            EngineCore.outputText("You grin mischievously to yourself and set about making two more balls of powdery snow.  It takes less time than any of the others, and before you know it you've attached two icy-breasts to the snowman.  They aren't terribly big, any heavier and you're sure they'd fall off, but they get the point across."
                    +"\n\nYour snowwoman still needs a face, of course, but you'll leave that until later.  For now, you head back into the main part of camp.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            flags[kFLAGS.NIEVE_STAGE] = 2;
            flags[kFLAGS.NIEVE_GENDER] = 2;
        }

        //Snowman
        //Add to existing text if possible, rather than a new window?
        function nieveSnowMan():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You decide to leave it as is. Not everything has to have breasts, of course, even in Mareth."
                    +"\n\nYour snowman still needs a face, of course, but you'll leave that until later.  For now, you head back into the main part of camp.");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            flags[kFLAGS.NIEVE_STAGE] = 2;
            flags[kFLAGS.NIEVE_GENDER] = 1;
        }
    }

    public static function findACarrot():void {
        EngineCore.clearOutput();
        EngineCore.outputText("As you explore the farm, you come across several rows of green plants.  Getting closer, you recognize them... carrots!  You pull one of them from the ground.  It's expectedly dirty, but bright orange, and straight enough to be the perfect nose for your snowman."
                +"\n\nWhitney passes by, and you ask if you can take the carrot.  She just shrugs, \"<i>Sure, hun.  I need to clear out that crop to make room for more peppers anyhow.</i>\""
                +"\n\nYou stash the carrot away with a smile.  You've got a nose for your snowman!");
        EngineCore.outputText("\n\n(Gained Key Item: Carrot)");
        player.createKeyItem("Carrot", 0, 0, 0, 0);
        EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
    }

    public static function nieveMF(Man:String = "", Woman:String = ""):String {
        if (flags[kFLAGS.NIEVE_GENDER] == 1) return Man;
        else return Woman;
    }

    public static function nieveComesToLife():void {
        EngineCore.clearOutput();
        flags[kFLAGS.NIEVE_STAGE] = 5;
        EngineCore.outputText("You awaken with a shiver.  A chill is in the air again, and in the distance you can make out a jolly laugh and jingling bells.  You bolt upright, looking in the direction of the snow pile, expecting a new flurry.  Sadly, there doesn't seem to be any new snow, nor is any coming down.  Frowning, you stand and approach the snow drift."
                +"\n\nThere's nothing to indicate any visitors through the night...  Except, wait...  Your snow" + nieveMF("", "wo") + "man is gone!  Did someone destroy it while you slept?"
                +"\n\nCreeping closer to the snow pile, you believe you may have found the culprit.  A pale blue humanoid, and thoroughly unclothed, shape lies in the soft white expanse, right where your snowman used to be.");
        if (flags[kFLAGS.NIEVE_GENDER] == 1) EngineCore.outputText("  It appears to be male, judging by the modestly sized cock sprouting from its loins.");
        else EngineCore.outputText("  It appears to be female, judging by the modestly sized tits on its chest, and the lack of a penis, which is quite a feat in Mareth.");
        EngineCore.outputText("  Pure white hair spills down from its head, almost blending in with the surrounding snow."
                +"\n\nYou ready your [weapon] and give the naked body a poke with your [foot].  " + nieveMF("He", "She") + " opens one eye with confusion, then the other."
                +"\n\nA soft, \"<i>Whaaa?</i>\" escapes " + nieveMF("his", "her") + " lips.  \"<i>Where am I?</i>\" " + nieveMF("He", "She") + " brings a pale blue hand to " + nieveMF("his", "her") + " head as " + nieveMF("he", "she") + " surveys the red, blighted landscape surrounding you.  \"<i>This isn't home.</i>\""
                +"\n\nResponding cautiously, in the event this is all an elaborate trick set up by some demon, you ask who " + nieveMF("he", "she") + " is, and where " + nieveMF("he", "she") + "'s from."
                +"\n\n" + nieveMF("His", "Her") + " eyes, ");
        if (flags[kFLAGS.NIEVE_MOUTH] == "gems") EngineCore.outputText("glittering purple");
        else EngineCore.outputText("coal black");
        EngineCore.outputText(" orbs, fall on you, as if registering you for the first time.  Then a hint of recognition hits " + nieveMF("him", "her") + ".  \"<i>Oh!  [Master]!  You're my [master]!</i>\"  In a flash " + nieveMF("he", "she") + "'s standing, looking pleased as punch, with " + nieveMF("his", "her") + " hands clasped excitedly in front of " + nieveMF("himself", "herself") + "."
                +"\n\nNow it's your time to look confused.  You again ask this strange person who they are, and where " + nieveMF("he", "she") + "'s from."
                +"\n\n\"<i>Oh! I'm from,</i>\" " + nieveMF("he", "she") + " frowns.  \"<i>I... I can't remember its name anymore.  The rumors must be true, then.  Once you leave it, you can't remember it.</i>\"  " + nieveMF("He", "She") + " sighs mournfully.  \"<i>I can remember snow as far as the eye could see.  Great icy cliffs, like shiny blue and white mountains.  An immense factory making toys.  But I can't remember faces, or names...</i>\""
                +"\n\nYou feel sorry for " + nieveMF("him", "her") + ", cut off from " + nieveMF("his", "her") + " home both physically and mentally, but what does this all have to do with you?"
                +"\n\n\"<i>Yes!  Right!  I'm an Ice Spirit, my name's Nieve!</i>\" " + nieveMF("he", "she") + " says, happily extending an arm.  You introduce yourself and shake the pale blue hand warily, noting the flesh is cold to the touch, but not painfully so.  \"<i>When winter rolls around, and snow falls, we get sent out to random people around the world.  It's our duty to help out in any way... especially sexually.  This, ah, this is my first time out.  You're my first [master].</i>\""
                +"\n\nYou raise an eyebrow.  That's new.  You were just sent a love slave, no strings attached?"
                +"\n\nNieve looks around the red landscape, " + nieveMF("his", "her") + " gaze eventually settling on your camp.  \"<i>It's so different here.  Is this where you live?</i>\""
                +"\n\nYou nod, though you say you're actually from a village named Ingnam, and explain your mission here in Mareth.  Nieve nods in rapt attention."
                +"\n\n\"<i>Wow.  That's great.  You're like a champion or something.  So, Champion,</i>\" " + nieveMF("he", "she") + " begins, \"<i>Do you want me to stay?</i>\"");
        //[Y/N]
        EngineCore.menu();
        EngineCore.addButton(0, "Yes", yesKeepNieve);
        EngineCore.addButton(1, "No", noNoKeepNieve);

        //Yes of course, what do you look like, an idiot?
        function yesKeepNieve():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You actually laugh at the question.  Of course you want " + nieveMF("him", "her") + " to stay!");
            //[Silly mode: 
            if (EngineCore.silly()) EngineCore.outputText("  A free follower, no worries about buying worthless dye or raising their affection?  Fuck yeah, you'll take " + nieveMF("him", "her") + "!");
            EngineCore.outputText("  " + nieveMF("He", "She") + " doesn't seem to be a threat, and indeed seems sincere in the fact that " + nieveMF("he", "she") + " was sent here to be your lover."
                    +"\n\nNieve beams at you, \"<i>You won't regret it, [name]!  Just give me a little while to set up a cozy place here... then we can get cozy.</i>\""
                    +"\n\nYou return to your camp proper with a goofy smirk on your face.\n\n(<b>Nieve is now available in the Lovers menu.</b>)");
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }

        //No, because I'm an idiot.
        function noNoKeepNieve():void {
            EngineCore.clearOutput();
            EngineCore.outputText("You shake your head.  Of course not!  While " + nieveMF("he", "she") + " certainly seems like a nice person on the surface, you can't help but think that's just the tip of the iceberg.  For all you know, " + nieveMF("he", "she") + "'s a frigid bitch underneath, a trap set by the demons to lure you into a false sense of security.  Clever bastards, you conclude.  They certainly know the best way to serve revenge, but you won't have any of it."
                    +"\n\nNieve looks disappointed, but nods understandably.  \"<i>I was told not everyone accepts us.  Perhaps I'll find someone more hospitable next year.</i>\"  You shrug, giving " + nieveMF("him", "her") + " the cold shoulder."
                    +"\n\nIn a blinding flash of light, Nieve is gone, and all that remains is the snowman you built.  You can feel the temperature begin to rise, and know that in a matter of hours, there won't be anything left of this icy wonderland.");
            flags[kFLAGS.NIEVE_STAGE] = -1;
            flags[kFLAGS.NIEVE_GENDER] = 0;
            flags[kFLAGS.NIEVE_MOUTH] = "";
            EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
        }
    }

    public static function nieveCampDescs():void {
        //6:00
        if (CoC.instance.model.time.hours == 6) EngineCore.outputText("Nieve is sitting cross-legged in the snowdrift, munching on what looks to be icicles.  As you watch, " + nieveMF("he", "she") + " reaches down into the glittering powder surrounding " + nieveMF("him", "her") + " and produces another one.");
        //7:00
        else if (CoC.instance.model.time.hours == 7) EngineCore.outputText("Nieve is giggling and laughing as a fresh flurry flutters down on " + nieveMF("him", "her") + ".  You wonder idly if " + nieveMF("he", "she") + "'s causing it to happen.");
        //8:00
        else if (CoC.instance.model.time.hours == 8) EngineCore.outputText("Nieve is sitting in the white wintery wonderland, carefully constructing a snowman.  It strikes you as strange, and almost masturbatory in a way.  " + nieveMF("He", "She") + " spots you and gives you a wave and a smile.  For a moment, you think the snowman has too, but you eventually conclude it's your imagination.");
        //9:00
        else if (CoC.instance.model.time.hours == 9) EngineCore.outputText("Nieve is sprawled out in the icy field, creating a series of snow angels without a care in the world.  When " + nieveMF("he", "she") + " catches sight of you, she gives a friendly wave, then dives back into the snow.");
        //10:00
        else if (CoC.instance.model.time.hours == 10) EngineCore.outputText("Nieve, the ice spirit, sits quietly at the edge of the snowdrift, looking out at the landscape beyond.  When " + nieveMF("he", "she") + " sees you looking, " + nieveMF("he", "she") + " gives a somber wave.");
        //11:00
        else if (CoC.instance.model.time.hours == 11) EngineCore.outputText("Nieve is in your camp, poking around your supplies and water barrels. You notice " + nieveMF("he", "she") + " seems a little uncomfortable to be away from " + nieveMF("his", "her") + " snowdrift.");
        //12:00
        else if (CoC.instance.model.time.hours == 12) EngineCore.outputText("Nieve is carefully compressing snowballs in " + nieveMF("his", "her") + " little camp.  To your surprise, " + nieveMF("he", "she") + " picks one up and begins eating it like you would an apple.  When " + nieveMF("he", "she") + " catches you looking mid-bite, " + nieveMF("he", "she") + " gives you a grin with her mouth full, " + nieveMF("his", "her") + " cheeks puffed out.");
        //13:00
        else if (CoC.instance.model.time.hours == 13) EngineCore.outputText("Nieve is sitting cross-legged, in the middle of what appears to be an argument with a snowman " + nieveMF("he", "she") + "'s just made.");
        //14:00
        else if (CoC.instance.model.time.hours == 14) EngineCore.outputText("Nieve is in " + nieveMF("his", "her") + " usual spot, seemingly deep in concentration.  Around " + nieveMF("him", "her") + " snow begins to fall slowly, then quicker and quicker, whipping " + nieveMF("his", "her") + " hair around wildly.  Although strangely, the air is still where you are.");
        //15:00
        else if (CoC.instance.model.time.hours == 15) EngineCore.outputText("\n\nNieve the ice spirit is whirling around " + nieveMF("his", "her") + " area, practicing with what appears to be a translucent blue spear.  " + nieveMF("He", "She") + " jabs and thrusts, spins and swipes.  " + nieveMF("He", "She") + " may be new to Mareth, but you've got to hand it to " + nieveMF("him", "her") + ", it looks like " + nieveMF("he", "she") + " could take care of " + nieveMF("him", "her") + "self.");
        //16:00
        else if (CoC.instance.model.time.hours == 16) EngineCore.outputText("\n\nNieve is at first nowhere to be seen.  Then you see " + nieveMF("his", "her") + " head pop out of a snowdrift.  " + nieveMF("He", "She") + " looks around quickly, then leaps into the air, diving head first into another pile of the powdery stuff.");
        //17:00
        else if (CoC.instance.model.time.hours == 17) EngineCore.outputText("\n\nNieve appears to have constructed a firepit constructed from translucent blue logs and rocks.  A vivid blue flame roars in the pit, over which Nieve appears to be roasting... marshmallows?  As you watch " + nieveMF("he", "she") + " peels the burnt black skin off a marshmallow, gobbles it down, and begins roasting the rest.");
        //18:00
        else if (CoC.instance.model.time.hours == 18) EngineCore.outputText("\n\nNieve seems to be working on a spear, sharpening it with a jagged piece of ice.  When " + nieveMF("he", "she") + " catches sight of you " + nieveMF("he", "she") + " waves and gives a friendly smile.");
        //19:00
        else if (CoC.instance.model.time.hours == 19) EngineCore.outputText("\n\nNieve is sitting at the edge of " + nieveMF("his", "her") + " icy expanse, staring off at the distant mountains.  You wonder if " + nieveMF("he", "she") + "'s looking for home.");
        //20:00
        else if (CoC.instance.model.time.hours == 20) EngineCore.outputText("\n\nNieve is, surprisingly, outside of " + nieveMF("his", "her") + " cold camp.  " + nieveMF("He", "She") + "'s dancing along the battered, parched ground, calling down snow.  Wherever a flake hits, it's immediately devoured by the thirsty earth.  Is Nieve perhaps trying to... water the ground?");
        //21:00
        else EngineCore.outputText("\n\nYou can hear Nieve sleeping soundly from within a small ice-fort.");
    }

    public static function approachNieve():void {
        EngineCore.clearOutput();
        EngineCore.outputText("You wave at Nieve, getting " + nieveMF("his", "her") + " attention and calling for " + nieveMF("him", "her") + ".  The icy spirit-" + nieveMF("man", "woman") + " happily walks over, smiling.  " + nieveMF("He", "She") + " takes " + nieveMF("his", "her") + " time, allowing you to take in " + nieveMF("his", "her") + " naked body.");

        EngineCore.outputText("\n\nThe ice spirit is about five foot ten inches tall.  " + nieveMF("His", "Her") + " skin is a pale blue that reminds you of a frozen-over lake.  Between " + nieveMF("his", "her") + " thighs, " + nieveMF("he", "she") + " sports " + nieveMF("a dark blue human-like cock that appears to be about 9 inches long", "a pair of dark blue pussy lips") + ".");
        //[Silly Mode:]
        if (EngineCore.silly()) EngineCore.outputText("  And you presume a butthole nestled between " + nieveMF("his", "her") + " cheeks, right where it belongs.");
        EngineCore.outputText("  " + nieveMF("His", "Her") + " stomach is flat and toned, " + nieveMF("as is his chest", "and she possesses a pair of perky B-cup breasts") + ". " + nieveMF("His", "Her") + " face is the same pale blue as the rest of " + nieveMF("his", "her") + " body, though it is off-set by " + nieveMF("his", "her") + " glittering, ");
        if (flags[kFLAGS.NIEVE_MOUTH] == "coal") EngineCore.outputText("dusky black");
        else EngineCore.outputText("vibrant purple");
        EngineCore.outputText(" eyes and pure white hair, which " + nieveMF("barely goes past his ears", "tumbles down past her shoulders") + ".  Much of " + nieveMF("his", "her") + " body glimmers with a fine layer of powdered snow or ice."
                +"\n\nNieve stops, gives you a friendly hug, and asks, \"<i>What can I do for you, [Master]?</i>\"");
        EngineCore.menu();
        EngineCore.addButton(0, "Sex", nieveSexMenu);
        EngineCore.addButton(4, "Back", SceneLib.camp.campLoversMenu);

        //Sex Menu
        function nieveSexMenu():void {
            EngineCore.clearOutput();
            EngineCore.outputText("What will you do with your oh-so-cool lover?");
            if (player.lust < 33) EngineCore.outputText("  You aren't quite turned on enough for normal fucking.");
            EngineCore.menu();
            if (flags[kFLAGS.NIEVE_GENDER] == 2) EngineCore.addButton(0, "Lick Her", lickNieve);
            if (flags[kFLAGS.NIEVE_GENDER] == 1) EngineCore.addButton(0, "Suck Him", suckNieveOff);
            //Fuck Her
            //Female Nieve
            //Must have a penis or at least a 3.5 inch clit
            //Nieve's capacity is about 130.
            if ((player.hasCock() || (player.hasVagina() && player.clitLength >= 3.5)) && player.lust >= 33) {
                if (flags[kFLAGS.NIEVE_GENDER] == 2) EngineCore.addButton(1, "Fuck Her", fuckNieve);
            }
            //Get Fucked by Gurumash
            //Male Nieve
            //Any Gender
            //Nieve's cock is 9x1.5
            if (flags[kFLAGS.NIEVE_GENDER] == 1 && player.lust >= 33) EngineCore.addButton(1, "Get Fucked", nieveFucksYou);
            EngineCore.addButton(14, "Back", SceneLib.camp.campLoversMenu);

            //Lick Her
            //Obviously for Female Nieve.
            function lickNieve():void {
                EngineCore.clearOutput();
                EngineCore.outputText("You explain your intentions and how you'd like to be the one to give her pleasure.  She looks rather surprised at first, but then she smiles.  \"<i>You want to go down... on me?</i>\"  You nod and she giggles, \"<i>That would be wonderful!</i>\""
                        +"\n\nYou grab Nieve around the waist, pulling her close for a kiss.  Your tongue explodes into her mouth, as she offers very little resistance.  It feels rather like you're kissing an icecube than a mouth, albeit a soft, fleshy icecube.  Your lips tingle from the cold as you break the kiss."
                        +"\n\nNieve lays down in the icy field and spreads her legs invitingly, but you don't go for the prize just yet.  Instead you start at her neck, letting your lips latch on to her pale blue skin.  Your warm lips touching her cold, frosty flesh actually causes steam to rise before your very eyes.  With a bit of a smirk, you begin kissing down her body, entertained by the little tufts of steam that rise from every smooch.  You make your way to a nipple and take it into your mouth.  It feels a little like an icecube, hard, wet and cold."
                        +"\n\nSoon your lips leave the nipple, traveling downwards once more.  Down to her belly button, which you nuzzle for just a moment, and then down further.  You avoid going straight for the vagina again, instead letting your lips caress her thighs, all the way down to her calves.  Switching over to the other leg, you work your way up the calf, up the thigh, and then you finally plant a kiss right on her frosty pussy.  Nieve giggles and squirms a little as you work your lips over her nethers.  You quickly locate the clitoris, an icy nub glittering like a diamond, and begin licking, kissing and rubbing it.");
                if (!EngineCore.silly()) {
                    EngineCore.outputText("\n\nNieve lets out little gasps and sighs as you assault her clit with your tongue.  Not content to leave it at that, you dive in to her frigid, slick cunt, lapping and licking.  ");
                    //(Normal/Snake Tongue: 
                    if (!player.hasLongTongue()) EngineCore.outputText("It doesn't get far, but elicits squeals of surprise and pleasure from your elemental slave who's already grasping at the snow surrounding her for support.");
                    //Demon Tongue: 
                    else EngineCore.outputText("Her eyes widen as you snake your impressive tongue into her. She grunts and squeals with pleasure, hands grasping piles of snow, wishing they were bedsheets.");
                    EngineCore.outputText("  After a minute of this, you realize you've lost the feeling in your tongue!  Pulling it back into your mouth, you find it warms back up quickly, and then you're at it again."
                            +"\n\nNot quite willing to let your precious tongue go numb like that again, you focus your attention on her clitoris and all the little sensitive spots along the inner thighs.  While your mouth is drawing her attention elsewhere, you carefully bury two fingers knuckle deep into her frozen fuckhole."
                            +"\n\n\"<i>Oh!</i>\" she exclaims, her head bolting up to look in your direction.  \"<i>Oohh.  Fuck that's nice,</i>\" she smirks down at you.  The finger-tongue combined assault leaves her writhing in the snow, and she reflexively attempts to back away.  You stare up at her for a second and grab hold of her hips with your free hand, commanding her to sit still with your most authoritative voice.  Nieve lets out a \"<i>meep</i>\" and ceases her squirming... at least for a minute.  After that, her legs and arms are trembling from barely contained pleasure, but she does her best to remain where she is."
                            +"\n\nRight when you're about to go back down, Nieve says, \"<i>I... I can't take it anymore!</i>\" She sits up, throws her legs around your neck, and in one swift motion you find yourself on your back");
                    if (player.isTaur()) EngineCore.outputText(", or as close to it with your body,");
                    EngineCore.outputText(" with Nieve straddling your face.  \"<i>Mm, this is much better.  Now you wanted to lick me, [Master]? So... lick,</i>\" she whispers, lowering her chilly cunt down onto your face."
                            +"\n\nYou try to protest, but all that comes out is a muffled \"<i>Mmmrrrfffgggll!</i>\"  To her credit, Nieve looks a little embarrassed, but shakes her head.  \"<i>This is the only way I can control myself.  Now unless you want to be stuck here all day, [Master], I suggest you put that mouth to work.</i>\""
                            +"\n\nNot wanting to be buried under this avalanche of quim any longer than you have to, you steel yourself and get to work.  Nieve herself makes it all the more difficult by undulating with every lick, grinding her cunt against your face as she lets out quivering moans.  You grasp onto her thighs with each arm to keep her as still as possible while you eat her out."
                            +"\n\nThankfully, it doesn't take long. You first notice Nieve's legs tensing up, then her back straightens and her frosted muff begins to tremble and quake around your tongue.  Her grinding grows more and more erratic, until finally she's had enough.  Her powder blue legs squeeze your head, holding you fast while her whole body seems to spasm.  Her back arches, her fingers clamp down on your head, gripping your hair.  From her mouth emits an unearthly, and intensely erotic moan of utter relief.  Oddly, you think you hear BELLS echoing from her throat, but it's hard to tell, being neck-deep in elemental pussy."
                            +"\n\nTo top it all off, at the same time a gush of glacial girl-spunk spills out onto your face.  You can't help but taste some of it, and you are pleasantly surprised to find it has a strong minty flavor.  You lap at the juices, at least until Nieve finally falls forward, completely spent.  Gratefully, you inhale properly, getting a good whiff of fem-cum and spearmint mingling in the air."
                            +"\n\nWith a smirk, you get to your feet and survey the situation.  Nieve has collapsed, face down in the icy powder, and there are two rather oddly shaped snow angels.  The smirk turns into a grin as you wipe the juices from your face and head back to camp, leaving Nieve to recover.");
                    player.dynStats("lus", 10 + player.lib / 10, "scale", false);
                }
                //Silly Mode:
                else {
                    EngineCore.outputText("\n\nAfter a moment you pause awkwardly.  Nieve lets out half a moan, then raises her head and looks down at you, nestled in her crotch.  There is an embarrassingly long pause, eventually broken by the ice woman's voice, \"<i>Your tongue is stuck to me, isn't it.</i>\""
                            +"\n\nAnother pause. You let out a muffled \"<i>Yeth,</i>\" and Nieve sighs."
                            +"\n\nIt takes you the better part of an hour to crawl your way back to the camp proper, you on your hands and knees, tongue stuck firmly to the icy love button.  It's a bit like being walked on a leash, and you find the whole ordeal utterly embarrassing and degrading, but quite arousing.  After the two of you manage your way over to a water barrel");
                    //(no Kid A: 
                    if (flags[kFLAGS.ANEMONE_KID] != 1) EngineCore.outputText(", Nieve takes a ladle full of water and pours it onto her snatch");
                    //Kid A: 
                    else EngineCore.outputText(", your little anemone spawn giggles and laughs at your predicament before finally ladling some water onto your lover's snatch");
                    EngineCore.outputText(", effectively allowing you to pull your tongue away."
                            +"\n\nThe both of you thoroughly flustered, Nieve returns to the winter paradise and you go back to your duties.");
                    player.dynStats("lus", -5 - player.sens / 5);
                }
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }

            //Suck Him by Kinathis
            //For male Nieve
            //Any gender
            function suckNieveOff():void {
                EngineCore.clearOutput();
                EngineCore.outputText("Looking your chilly companion up and down, you inspect " + nieveMF("his", "her") + " snowy features.  The ice spirit's chiseled body and well defined features look like they were cut by a master sculptor.  The wintery spirit notices your critical gaze, shifting to stand tall and look his best for you. Smirking at his actions you can't help but notice his body react to your intimate stare; the dark blue flesh between his legs rising as if it sensed your sexual intent.  Chuckling, you step forward, your hand reaching down to cup the cold swelling cock in your warm hand.  The sheer heat of your touch on Nieve's sensitive, shivery manhood pulls a gasp from him, the spirit now realising just what you're after.");
                EngineCore.outputText("\n\nLeaning in you give him a squeeze as you whisper to him, telling the glacial being that you're going to 'thaw his icicle'.  Your words draw a purple blush from his blue cheeks but you can clearly tell he is happy to get such attention from you.  \"<i>You want to pleasure me?  I... I'm honored you want to give me pleasure like this [master], thank you, so much,</i>\" he says as his cold hands slip around you.  Squeezing down, you start to stroke the chilly cock slowly, gently massaging Nieve until his body is ready for you.  Under your soothing, heated touch he soon rises to full attention, the thick shaft achingly hard in your hand as you keep stroking.  Being made of snow and ice, it seems your friend is more than a little sensitive to the heat of your body.  If he likes your hands this much, you're sure he will love your hot, wet mouth."
                        +"\n\nKneeling down, you look up with a grin before you inhale and blow across the frosty flesh, the soft hot air making him gasp as his hands slide onto your head.  Letting out a snicker at his reaction, you lean in.  Taking his thick member in both hands, you stroke and squeeze it as you take a deep breath, inhaling the spirit's chilly scent of wintery mint.  The oddly fresh scent is almost as relaxing as it is arousing and compelling you to get an even deeper breath of the soothing smell.  Leaning in even more, you press your face against his flesh, taking deep breaths as you push your nose and mouth against Nieve's cold apple sized-balls.  Your hot tongue flicks out to lick those refreshing fertile nuts, his flesh starting to hiss as puffs of steam rise from his snowy skin as a crisp cloud bursts from your arctic associate \"<i>So... So hot...</i>\" he says with a gasp, his hands running through your [hair] as he basks in the pleasure you give him."
                        +"\n\nEven as you lick and suck on his frozen balls your hands stroke and work the shivery shaft swiftly, the heat of your hands melting flakes of snow and frosty pre into a slick lube for your passionately pleasurable work.  Licking up from those tasty testis, you draw your tongue up the base of Nieve's glacial girth, your lips and mouth stopping only to kiss the thick cool cumvein running up the length you seek to pleasure.  Slurping and sucking your way to the top you plant a deep kiss right on the crown of Nieve's carnal column.  As your tongue slides across the bulging mushroom-like head, drawing pleasure filled moans and gasps from Nieve, you get a taste of him, the frosty spirit actually tasting chilly, refreshing and like mint with just a ghost of sweetness to him.  The unique flavor spurs your oral attentions and makes the act even more delicious for you."
                        +"\n\nWith Nieve enjoying you so much and with such a pleasant taste to his body you can't help but dig right in.  Licking all over the tip, you sink down, taking his icy spear deep into your hot, wet mouth.  Your tongue lashes out, licking all over the bulging blue beast inside you.  Your hands massage those chilly, orifice clogging balls as you suck and lick your wintry lover.  Unable to help himself, Nieve grips your head, moaning into the air as he pulls you in.  You help him deeper inside you to get at more of your sweet heat and pleasure.  Bobbing your head up and down you suck his cool minty meat down, taking him deeper and deeper until he presses against your throat, the bulbous tip pressing against your warm flesh before slithering down your throat like the minty sausage it is."
                        +"\n\n\"<i>Ooohhh... Oh so, sooo hot yesssss,</i>\" he hisses out, the scented steam flowing from your mouth like mist as you violate his frozen fuckstick.  The spine tingling pleasure you're giving is clear as pure ice on your lovers face, his cheeks flushed violet, a dazed look of bliss in his eyes as he holds your head in his hands.  From the look of sweet desperate pleasure you can tell he's growing closer and closer to the edge of his eye crossing abyss.  Seeing your snowbound spirit getting so close makes you smile and close your eyes, working harder to bring the wintery friend ever more enjoyment.  Going as deep as you can, your face soon presses against his pelvis as you suck him down like a pro.  Clenching your throat, you swallow around the frigid throbbing member, forcing that big blue dick into a tight hot embrace that makes him let out a deep throaty groan of pure delight."
                        +"\n\nSucking as hard as you can, you slither your tongue around the length inside your mouth, licking everywhere you can in spite of having your mouth full already.  Cupping those swollen balls in your hands you gently fondle them, massaging them tenderly even as they lurch and swell, their icy payload ready to burst and gush into your mouth already.  Giving you only seconds notice, the pleasure filed gasps warn you of the impending orgasm.  Letting out a long moan of pure ecstasy Nieve blows his minty load inside your mouth.  Pulse after pulse, burst after thick burst of creamy minty cum flows over your tongue and down your throat.  With each gush your tongue is overwhelmed by the strong minty flavor, the thick stuff gushing down your throat to pool inside your stomach.  With his body presumably made from ice and snow, you're unsure as to where he is keeping all this minty cream, more and more gushing until your belly swells just a little under the chilling amount.  Shivering from the icy cum in your tummy you slowly pull back, sucking the last streams of pearly seed from your wintery lover before popping off."
                        +"\n\nLetting out a deep sigh you grin and look up, wanting to see the look on Nieve's face.  The iceborn man looks like he couldn't be happier, a silly smile on his face as he looks down at you.  \"<i>Oh [Master]... that was amazing, I've never met someone so skilled before.  I hope you're not too cold now,</i>\" he says with a hint of worry, knowing that his body and by extension, his cum, must be quite cold.  Reassuring him you tell your frosty friend you're fine and that he actually tasted pretty good. Looking quite pleased Nieve helps you up before sweeping you up into a squeezing hug.  \"<i>Thank you so much for this, but next time let me do you though, you need to be pleasured as well,</i>\" the elemental spirit says gently before helping you get cleaned up and ready for your adventures.");
                player.dynStats("lus", 10 + player.lib / 10, "scale", false);
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }

            //Fuck Her
            //Female Nieve
            //Must have a penis or at least a 3.5 inch clit
            //Nieve's capacity is about 130.
            //Note for fen/gats: In the interest of fairness, I just wanna say that this scene was unfinished at the time the contest closed.
            function fuckNieve():void {
                EngineCore.clearOutput();
                var x:int = -1;
                if (player.hasCock()) {
                    x = player.cockThatFits(130);
                    if (x <= 0 && player.hasVagina() && player.clitLength >= 3.5 && Utils.rand(2) == 0) {
                        x = -1;
                    } else x = player.smallestCockIndex();
                }
                EngineCore.outputText("You look your naked, icy lover up and down, thinking of all the things you could do to her.  She raises a white eyebrow at you curiously while you take in her statuesque form.  A thin layer of frost covers her flesh, giving her pale blue skin a sparkling, shimmering appearance.  You find yourself getting aroused at all the potentialities.  Your " + cockClit(x) + " rises to attention as you ponder it, and with a smirk, you finally settle on something.");

                EngineCore.outputText("\n\nFirst you disrobe, tossing your clothes aside, and order Nieve onto her knees.  She does so immediately, and without needing to be told what to do, she leans in and grasps your " + cockClit(x) + " with one hand.  Like the rest of her, Nieve's hands are freezing cold, and though it's a strange sensation at first, it's not at all painful or uncomfortable.  \"<i>Allow me, [Master],</i>\" she says, licking the tip of your " + cockClit(x) + " with a wet, cold \"<i>schlick</i>\" that makes you shiver.");

                EngineCore.outputText("\n\nNot wasting any time, she takes the whole tip into her mouth, swirling her tongue around it with practiced ease.");
                //(If small cock/clit (<6): 
                if (x >= 0) {
                    if (player.cocks[x].cockLength < 6) EngineCore.outputText("  \"<i>It's so cute, [Master],</i>\" Nieve says while catching a breath, \"<i>Like a little toy cock.</i>\"");
                    //If overly large (>130): 
                    else if (player.cocks[x].cockLength >= 24) EngineCore.outputText("  She has to take a breath almost immediately, saying, \"<i>By the fat man's beard this thing is huge.  You must make the rest of this world jealous.</i>\"");
                    else EngineCore.outputText("  \"<i>Mmm,</i>\" she smacks her lips and takes a quick breath, \"<i>Such a nice example of a candycane right here.  Let's go in for another taste.</i>\"");
                }
                else {
                    if (player.clitLength < 6) EngineCore.outputText("\"<i>It's so cute, [Master],</i>\" Nieve says while catching a breath, \"<i>Like a little toy cock.</i>\"");
                    else if (player.clitLength >= 24) EngineCore.outputText("  She has to take a breath almost immediately, saying, \"<i>By the fat man's beard this thing is huge.  You must make the rest of this world jealous.</i>\"");
                    else EngineCore.outputText("  \"<i>Mmm,</i>\" she smacks her lips and takes a quick breath, \"<i>Such a nice example of a candycane right here.  Let's go in for another taste.</i>\"");
                }
                EngineCore.outputText("  And with that she dives back down onto your " + cockClit(x) + ".  Her head bobs and bows, giving the sensation of an icecube running up and down your ");
                if (x >= 0) EngineCore.outputText("dick");
                else EngineCore.outputText("clit");
                EngineCore.outputText(" at great speed.");

                //(Variable depending on dick-type)
                if (x >= 0) {
                    //(Human) 
                    if (player.cocks[x].cockType == CockTypesEnum.HUMAN) EngineCore.outputText("  Your normal, unaltered cock seems to take on a slight blue tint, although you can confirm it's not going numb.  Quite the contrary, it seems to be getting more sensitive as Nieve's lips roll over it.");
                    //(Equine) 
                    else if (player.cocks[x].cockType == CockTypesEnum.HORSE) EngineCore.outputText("  Nieve fawns over your horsecock like a cultist praying to a god.  She sucks and kisses, running the tip of her tongue all along the sides until she reaches the sheathe, and then right back up the other side.");
                    //(Canine) 
                    else if (player.hasKnot(x)) {
                        EngineCore.outputText("  Nieve eyes the knot on your cock as though it were a challenge.  She inches down your shaft, getting ever closer.");
                        //(Cocksize >40)
                        if (player.cockArea(x) >= 40) EngineCore.outputText("  Eventually, though, she admits defeat and goes back to working your shaft, though she eyes that knot from time to time with no small amount of anger.");
                        //(Cocksize <40) 
                        else EngineCore.outputText("  It takes her a few good minutes, but eventually she works her way down and takes the entire knot into her mouth.  She raises her hands in triumph and lets out a \"<i>Mmmmrrrrrpphhh!</i>\" before pulling back for a breath, inadvertently exposing your wet hard cock to the cold, wintery air.");
                    }
                    /*Cock types
                    0 - human
                    1 - horse
                    2 - dog
                    3 - demon
                    4 - tentacle?
                    5 - CAT
                    6 - Lizard/Naga?
                    7 - ANEMONE!
                    8 - ugliest wang ever (kangaroo)
                    9 - dragon
                    */
                    //(Demonic)
                    else if (player.cocks[x].cockType == CockTypesEnum.DEMON) EngineCore.outputText("  Your purple, demonic shaft pulses and throbs, seemingly immune to the unnatural cold of Nieve's mouth. Seemingly oblivious to its nature, Nieve slavers over each nodule, giving every ridge and bump a kiss and more than just a lick.");
                    //(Tentacle) 
                    else if (player.cocks[x].cockType == CockTypesEnum.TENTACLE) EngineCore.outputText("  Nieve does not seem put off by your tentacle cock in the least, in fact she confesses, \"<i>It reminds me of a comic I read before coming here.</i>\"  As she fawns over your cock, you're certain you hear whispers of \"<i>Oh, you sexy tentacle beast...</i>\" coming from her mouth when she gets her breath.");
                    //(Feline) 
                    else if (player.cocks[x].cockType == CockTypesEnum.CAT) EngineCore.outputText("  Though the barbs on your cock are soft and pliable, they reflexively harden up after Nieve's tongue washes over them.  She doesn't pay particular attention to the barbs, but she does seem rather careful not to get one hooked on her lip.");
                    //(Lizard)
                    else if (player.cocks[x].cockType == CockTypesEnum.LIZARD) EngineCore.outputText("  Nieve fawns over your scaled and ridged reptilian cock, slurping and smooching up and down its length. It seems a bit more resistant to the biting cold of Nieve's mouth, which is lucky when she backs off, exposing your entire wet, frigid length to the wintery air surrounding you.");
                    //(Anemone) 
                    else if (player.cocks[x].cockType == CockTypesEnum.ANEMONE) EngineCore.outputText("  Nieve giggles whenever one of your wriggling tentacles stings her, seemingly immune to its effects, and kisses it back.  Soon after she devours your whole length, delighted to feel the sting of your cock in the back of her throat.");
                    //(Kangaroo) 
                    else if (player.cocks[x].cockType == CockTypesEnum.KANGAROO) EngineCore.outputText("  It takes Nieve a little while to catch on that your cock isn't quite human, and by the time she figures it out, she mutters, \"<i>Huh, that's strange... I thought kangaroos had balls above the cock,</i>\" before shrugging and getting back to work.");
                    //(If you add dicks later, placeholder text:) 
                    else EngineCore.outputText("  Nieve works on your mutant cock, spending time working every unique little facet of it.");
                }
                //(Clitoris) 
                else {
                    EngineCore.outputText("  Nieve nuzzles and lavishes your elongated love button, showering it with attention. \"<i>I didn't know clits could get this big,</i>\" she says with wonder in her voice. \"<i>");
                    if (player.clitLength < 5) EngineCore.outputText("It's just like a little cock");
                    else if (player.clitLength < 9) EngineCore.outputText("It's just like a cock");
                    else EngineCore.outputText("I bet even men get jealous of this bad girl");
                    EngineCore.outputText(".</i>\"");
                }
                EngineCore.outputText("\n\nEventually you just can't handle anymore and your body tenses.  Your legs lock up, " + cockClit(x) + " trembling, back arching slightly. Nieve notices this and latches on to the tip just in time as an orgasm rocks your body.");
                if (x >= 0) EngineCore.outputText("  Your " + cockClit(x) + " quivers and spurts cum directly into Nieve's eager mouth, who gulps it down as if she were drinking direct from the tap.");
                EngineCore.outputText("\n\nAs you come down from your little orgasmic high, you glance down at the ice woman, ");
                if (x < 0 || player.cumQ() <= 250) EngineCore.outputText("who has a bit of cum dribbling down her chin");
                else if (player.cumQ() <= 400) EngineCore.outputText("who has a steady stream of cum pouring from her mouth");
                else if (player.cumQ() < 600) EngineCore.outputText("who is patting her stomach as though she'd just had a large meal");
                else if (player.cumQ() < 1000) EngineCore.outputText("whose stomach appears slightly distended from the amount of cum you've poured into her");
                else EngineCore.outputText("whose stomach is rather large, like a pregnant woman's, from the sheer amount of cum you've pumped into her gullet");
                EngineCore.outputText(".  With a smirk, you tell her it's not over yet.  That was just the appetizer.");

                EngineCore.outputText("\n\nWith a command Nieve falls backwards into the white, glittering powder and spreads her legs, revealing her deep blue nethers, wet and slick despite the intense cold of her body.  With a smile spreading across your face, you get down onto your knees between hers, and rub the head of your " + cockClit(x) + " against her icy cavern.  A chill runs down it and up your spine, but you ignore it. You tease and taunt Nieve's cunt, flicking her joy buzzer ");
                if (x >= 0) EngineCore.outputText("with your " + player.cockDescript(x) + "");
                else EngineCore.outputText("with yours");
                EngineCore.outputText(", and just slipping the tip in before pulling out.  You do this until your snowbound lover is biting her lip, squirming with barely contained pleasure.");

                EngineCore.outputText("\n\nRight as she begins to open her mouth, to beg you to just stop it and fuck her, you slip your " + cockClit(x) + " in ");
                //(if too big: 
                if (x >= 0) {
                    if (player.cockArea(x) >= 130) EngineCore.outputText("at least as far as it will go, ");
                }
                EngineCore.outputText("with a wet \"<i>schluck.</i>\"  The words coming out of her mouth are lost in a loud \"<i>ooohhhh</i>\" as her eyes roll backwards, closely followed by her head.  Her wet pussy grips you tightly, giving you a strange tingling sensation.  Your hot rod combined with her arctic nethers actually causes some steam to rise up, and you're a little captivated to see more tufts of steam rise with every slow, gentle thrust you make."
                        +"\n\nDeciding to take this to the next level, you take hold of Nieve's legs and lift so that her ankles rest on your shoulders.  You give a soft grunt, moving your grip down to her firm buttocks now raised in the air, and plow away once more.  ");
                if (x >= 0) {
                    //((cocksize 3/Clit 3)
                    if (player.cockArea(x) <= 7) EngineCore.outputText("Your meager penis isn't much, but at this angle you manage to hit all the right places.  Soon Nieve is wriggling around, eyes staring up at you, urging you on faster and faster.");
                    //(Cocksize 30/Clit 12) 
                    else if (player.cockArea(x) <= 30) EngineCore.outputText("At this angle you manage to hit all the right places.  Soon Nieve is wriggling around, eyes tightly shut as she whispers dirty words you can't even make out.");
                    //(Cocksize 70/Clit 24)
                    else if (player.cockArea(x) <= 70) EngineCore.outputText("Nieve's cunt feels like an icy vice on your oversized cock, but even so, you manage to hit all the right places.  Soon she is wriggling around, eyes tightly shut as she pants for breath.");
                    //(Cocksize 130+/Clit 48+)
                    else EngineCore.outputText("Though you can't fit your entire " + cockClit(x) + " inside, you are amazed at how much she takes.  Her pale blue stomach bulges with every thrust.  Soon Nieve is wriggling, her eyes slightly open as she bites her lip in ecstasy.");
                }
                else {
                    if (player.clitLength <= 4) EngineCore.outputText("Your meager clit isn't much, but at this angle you manage to hit all the right places.  Soon Nieve is wriggling around, eyes staring up at you, urging you on faster and faster.");
                    else if (player.clitLength <= 12) EngineCore.outputText("At this angle you manage to hit all the right places.  Soon Nieve is wriggling around, eyes tightly shut as she whispers dirty words you can't even make out.");
                    else if (player.cockArea(x) <= 24) EngineCore.outputText("Nieve's cunt feels like an icy vice on your oversized clitty, but even so, you manage to hit all the right places.  Soon she is wriggling around, eyes tightly shut as she pants for breath.");
                    //(Cocksize 130+/Clit 48+)
                    else EngineCore.outputText("Though you can't fit your entire " + cockClit(x) + " inside, you are amazed at how much she takes.  Her pale blue stomach bulges with every thrust.  Soon Nieve is wriggling, her eyes slightly open as she bites her lip in ecstasy.");
                }
                EngineCore.outputText("\n\nNieve's body tenses underneath you while a deep, \"<i>Ohhh yes!</i>\" rolls from her lips languidly.  She bites her deep blue lip, stifling any more cries.  Her already tight, bitingly cold quim grips you tighter causing your entire body to shiver.  Her arms extend out into the snow, twitching wildly.  Her legs, meanwhile, can't decide whether they want to grip your neck or bow outwards.  As the orgasm crashes over her body you know you can't hold out much longer either."
                        +"\n\nThe icy cold chill of her snatch helps to prolong the inevitable. You manage to send Nieve over the edge at least once more, leaving her a tangled mess of limbs, one arm grasping her hair, the other furiously buried between her legs. But with one final thrust you're pushed over the edge as well as a warm tingling sensation overtakes your body.");
                //((Clitfucking?)
                if (x < 0) EngineCore.outputText("  Your [clit] suddenly feels suddenly warm, like every nerve ending inside were on fire. It aches and pulses with the rest of your body, as though it were a little cock longing to cum.");
                else {
                    EngineCore.outputText("  Your " + cockClit(x) + " aches and pulses with need before ");
                    if (player.cumQ() < 100) EngineCore.outputText("spilling its meager offering into the ice spirit's womb");
                    else if (player.cumQ() < 250) EngineCore.outputText("ejecting streams of white hot jizz into the ice spirit's hungry snatch");
                    else if (player.cumQ() < 400) EngineCore.outputText("painting the ice spirit's insides with your cream until some begins to pour out");
                    else if (player.cumQ() < 700) EngineCore.outputText("arcs of pearly white cum shoot forth, filling the ice spirit's womb so much her belly visibly inflates");
                    else EngineCore.outputText("erupting inside, filling the ice spirit up with so much of your hot cum so much that she looks visibly pregnant");
                    EngineCore.outputText(".");
                }
                EngineCore.outputText("\n\nExhausted, you slump backwards, splaying out in the snow.  You leave your anatomy to work itself out for now, just savoring the afterglow and catching your breath as much as you can.  Nieve, however, seems to have other things in mind.  She pulls away from you, twists around, and gets on her hands and knees between your legs."
                        +"\n\n\"<i>So messy, [Master],</i>\" she notes with a smile.  \"<i>Allow me to clean you up.</i>\"  Her cool mouth descends on your member, licking and sucking away all of your juices and hers, leaving you spotless.  She seems to delight in the flavor, and once she's done, she leans in and gives you a big, sloppy kiss that tastes more like mint than anything else.  She then cuddles up next to you, her cold body somehow comforting, until you've recuperated enough to head back to the camp proper.");
                player.orgasm();
                player.dynStats("sen", -2);
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }

            //Get Fucked by Gurumash
            //Male Nieve
            //Any Gender
            //Nieve's cock is 9x1.5
            function nieveFucksYou():void {
                EngineCore.clearOutput();
                EngineCore.outputText("Your arrival to Nieve's part of the camp elicits a friendly smile from the ice man.  He notices the longing in your eyes with a grin, and speaks in a gentle, yet low tone, \"<i>[Master], you seem to need help from me...</i>\""
                        +"\n\nTo which you nod, ");
                if (player.cor < 50) EngineCore.outputText("telling him that you find his form... appeasing to say the least, and would like to know how his 'parts' are working properly.");
                else EngineCore.outputText("leting your creation know that you are interested in 'how' it can please you, giving him no room to imagine what you're insinuating you then tell him bluntly that you want him to fuck you like the plaything he is.");

                EngineCore.outputText("\n\nNieve bows subserviently, then moves closer to you, doing the work of disrobing you like he's practiced at it.  He caresses your [chest] and [nipples] as he nibbles on your neck and ears, the cool kisses and touches feeling electric in the contrasting warmth of the air, causing you to shiver in delight at his surprisingly experienced movements.");
                //{Silly Mode:}
                if (EngineCore.silly()) EngineCore.outputText("   He did say that his kind were effectively love slaves, and boy does this prove it!");
                //[if (hasVagina = true) 
                if (player.hasVagina()) EngineCore.outputText("  Your [vag] is a sodden box so soon after he started, and you start to want more, much more!");
                //[if (hasCock = true) 
                if (player.hasCock()) EngineCore.outputText("  Your [cock biggest] is also rock hard in a short while and you quickly desire some more stimulation from your icy love slave.");

                //[(if PC has vagina or large enough tits) \"<i>So [master],</i>\" He says pulling back slightly, \"<i>Where would you like me to put this?</i>\"][(if anal is the only option, automatically selected) \"<i>Well I guess I know where to put this huh?</i>\" He says coyly.]
                //[Anal][Vaginal][(tits >3) Tit-Fuck]
                EngineCore.menu();
                EngineCore.addButton(0, "Anal", takeNieveAnal);
                if (player.hasVagina()) EngineCore.addButton(1, "Vaginal", takeNieveVaginal);

                //Anal
                function takeNieveAnal():void {
                    EngineCore.clearOutput();
                    EngineCore.outputText("You let you wintery lover know just where you want his blue member, turning around and setting yourself up on all fours as you grab your [butt] on both sides with your hands, spreading your cheeks to expose your [asshole] quite vulgarly. He needs no further invitation as he moves to match his face to your dirty hole.  You feel the pristine chill of his breath cover your nethers, making you tremble.  Already hot and horny from his foreplay earlier, you wait anxiously for what seems like minutes until he probes your hole with his tongue, lathering your [butthole] with his cool lubing saliva, the temperature making you quaver even more as you enjoy the ice play his tongue is giving you."
                            +"\n\nAfter a few exciting minutes, he pulls away as you look at him from over your shoulder.  You take a little time to admire your creation and how perfectly sculpted his body is when his nine-inch member thrusts into your anus in one quick thrust, causing an enraptured squeal to come from your mouth.  Thoughtfully, Nieve waits a few moments to allow your hole to get familiar with his sizable member before ever-so slowly thrusting into you.  You enjoy the ride for what it's worth, since even though almost every penis you've encountered in this land has been bigger, there's something unique about his frozen phallus that you can't get enough of.  You finish the thought, only to be wakened from your internal monologue to the increasing rhythm of the polar penetration he's giving you.");
                    player.buttChange(9, true, true, false);

                    EngineCore.outputText("\n\nHe continues increasing the tempo until you're both rutting like animals, the lewd squelches coming from the pounding fill the environment as you start to feel a warming sensation in your ass.  The unusually loud squelches tell you he's leaking some precum as the frigid phallus drives into your [asshole] like a perverted slip 'n slide.");
                    //[if (hasCock = true) 
                    if (player.hasCock()) EngineCore.outputText("  Nieve then bends forward while keeping his pace to give you a reach-around.  Grabbing your own [cock biggest] in one hand, he starts to pump it to the speed of his thrusts, torturing you with the extra-stimulation in such a good way.");
                    //[if (hasVagina = true)
                    else if (player.hasVagina()) EngineCore.outputText("  As Nieve continues to pound away, he places one hand on your sopping wet cunt and begins to finger you in time with his assault, making you lust-drunk with the stimulation as he finger bangs you.");

                    EngineCore.outputText("\n\nNieve continues to grunt as he prods and plunges into your ");
                    //if (silly mode) 
                    if (EngineCore.silly()) EngineCore.outputText("pooper");
                    else EngineCore.outputText("[asshole]");
                    EngineCore.outputText(" as you feel an oncoming climax.  Nieve, furiously impaling you with his long and cold cock, comes first, and in one final thrust drives his penis as deeply as possible, flooding your bowels with a crisp current of cum as his body rocks from the orgasm.  You join him in the throes of ecstasy as soon as his jizz hits your inner walls");
                    if (player.gender > 0) {

                        //[if (hasCock = true) 
                        if (player.hasCock()) {
                            EngineCore.outputText(", "
                                    +"while your body undulates and seizes as cum starts to spew forth from [eachCock]");
                            //(normal volume: 
                            if (player.cumQ() < 200) EngineCore.outputText(", as you cum, you leave a small puddle on the floor below you");
                            else if (player.cumQ() < 500) EngineCore.outputText(", as you cum you start to dress your arms and hands with your own cream as you shoot your stuff out onto the floor");
                        }
                        //[if (hasVagina = true)
                        if (player.hasVagina()) EngineCore.outputText(".  Your soaking vagina makes your body quake and shudder as you orgasm, splashing your femcum all over Nieve and the ground");
                    }
                    EngineCore.outputText("."
                            +"\n\nYou both rest in that position, Nieve still trickling cum into you even though he stopped moving minutes ago.  You turn your head to look at him and notice his face a few inches from yours.  It's clear that at the moment he's barely conscious, and you shift a bit to kiss him, thanking him for a job well done.  After a little while you both recover, redress, and silently go back to business.  Looking back at him as you leave, you know you want to do it again real soon.");
                    player.orgasm();
                    player.dynStats("sen", -2);
                    EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
                }

                //Vaginal
                function takeNieveVaginal():void {
                    EngineCore.clearOutput();
                    EngineCore.outputText("You're already wet from the foreplay, and it shows.  Moreso, Nieve notices, with a grin similar to the one he gave you earlier.  The look on his face suggests he knows what you want, he's just merely waiting for his [master] to give the word.");

                    //if (corruption < 50)
                    if (player.cor < 50) EngineCore.outputText("\n\nYou give him a dirty look, asking if he's going to make you say it.  \"<i>I do not know what it is you mean, [master],</i>\" he whistles complacently, giving you a sideways glance.  Frustration sets in your mind at the sheer smugness your love slave just exhibited, so much so that you blurt out that you just want him to fuck your cunt like the stud he is.");
                    //if (corruption > 50) 
                    else EngineCore.outputText("\n\nYou ask your toy if he's playing coy, to which he merely gives you another sidelong glance.  You then grab him by the chin and force him to look into your eyes, barely an inch away from each others faces.  You whisper that he's going to empty those pretty blue balls of his directly into your womb, and he'd better get started.  Right.  Now.");

                    EngineCore.outputText("\n\nNieve obliges with a, \"<i>Yes ma'am!</i>\" quickly laying you on your back");
                    //[if (hasBalls = true) 
                    if (player.balls > 0) EngineCore.outputText(", gently moving your [balls] out of the way in the process");
                    EngineCore.outputText(".  He slams his nine inch blue rod balls deep into your sodden box.  A loud squelch fills the air at the penetration, giving Nieve the go ahead to start in top gear, pistoning in and out at a hurried pace.");
                    //[if (hasCock = true)
                    if (player.hasCock()) EngineCore.outputText("  During the pounding Nieve grabs your dangling [cock biggest] and starts to pump it in time with his own thrusts, quite eager to please his [master].  Every time your feminine half cums, so does your male half, splashing its happy seed into the valley that your combined bodies have made.");
                    //[if (isLactating = true) 
                    if (player.lactationQ() >= 100) EngineCore.outputText("  Your ice man reaches out with a free hand to caress your [chest], twiddling his fingers around your delicate [nipples]. After some rough pulling and flicking, pounding away all the while, he feels milk dribble onto his hand.  He catches a quick glance of the liquid before diving head-first to suckle on your milk faucets, drinking heavily of your cream as he's about to give you his.");
                    EngineCore.outputText("\n\nYou enjoy the ride and then some, as his phallus hammers away at your cunt, desperate to feed your womb with his seed.  He caresses, fondles and nibbles all parts of your body, quickly stimulating one area after the other to freshen the feeling again and again... and again.  Everytime you come, he pounds a little slower and harder, grunting heavier as you try to wring him dry of all his dickmilk, wanting desperately to feel full of it.");
                    player.cuntChange(9, true, true, false);

                    EngineCore.outputText("\n\nOne last time you cum, and this time so does he, his cock barreling deep inside, the head kissing the entrance of your womb as it spills forth that crisp current of cool cum, bloating your womb with the sheer amount.  The cold sensation combined with the cum's chemical reaction in your womb send you into a drooling euphoria as you throw your head back in tumultuous screams of rapture.  You can barely see at the bottom of your vision your pregnant-sized belly and rest your head back, blissfully unaware of anything else in the world except this feeling."
                            +"\n\nYou come to your senses after what seems a couple of hours, Nieve resting peacefully on and still connected. He seems to have passed out and is pleasantly resting his head on your [chest].  You lay there, still flushed and warm from your recent activity despite the ice cold body on you.  You feel comfortable enough to doze off again."
                            +"\n\nAnother hour passes and you wake up clean and dressed, laying next to Nieve.  You noticed he's probably been watching you for the last several minutes.  You get up, pat yourself off, then with one hand tussle his snow-white hair, while uttering the words, \"<i>Good boy.</i>\"");
                    player.orgasm();
                    player.dynStats("sen", -2);
                    EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
                }
            }

            function cockClit(number:int = 0):String {
                if (player.hasCock() && number >= 0 && number < player.cockTotal()) return player.cockDescript(number);
                else return Appearance.clitDescription(player);
            }
        }
    }

    public static function nieveIsOver():void {
        EngineCore.clearOutput();
        EngineCore.hideMenus();
        //Nieve Not Completed
        if (flags[kFLAGS.NIEVE_STAGE] < 5) {
            EngineCore.outputText("You wake up with a yawn and a stretch. It feels just like any other day, though a bit warmer.  Quite a bit warmer in fact.  It feels like winter's grasp on Mareth has slipped, and it's entering Spring.  Curiously, you glance over towards the snow which had been recently deposited in your camp, and note it's melting away before your eyes."
                    +"\n\nOh well, not a huge loss, you figure.  It was fun while it lasted.");
            flags[kFLAGS.NIEVE_STAGE] = 0;
        }
        //Nieve Completed
        else {
            EngineCore.outputText("You wake up with a yawn and a stretch.  It feels just like any other day, though a bit warmer.  Quite a bit warmer in fact.  It feels like winter's grasp on Mareth has slipped, and it's entering Spring.  You consider the fact absently at first, but then you stop dead in your tracks.  What about Nieve?!"
                    +"\n\nYou turn to " + nieveMF("his", "her") + " winter wonderland, relief washing over you as you see it's still there, but note that it is diminishing.  You rush over, watching the parched landscape claiming the slushy terrain bit by bit.  Nieve sits in the middle, looking up at the sky with a worried look on " + nieveMF("his", "her") + " face.  " + nieveMF("His", "Her") + " normally glittering skin now shines with sweat, not frost. Beads of perspiration roll down " + nieveMF("his", "her") + " body and into a worryingly large puddle at " + nieveMF("his", "her") + " feet."
                    +"\n\n\"<i>Ah, [Master], you're here. I was concerned we might not have been able to talk before... before I go home,</i>\" " + nieveMF("he", "she") + " says sadly.  You question " + nieveMF("him", "her") + ", why does " + nieveMF("he", "she") + " have to go home? You've seen " + nieveMF("him", "her") + " make snow before, why can't " + nieveMF("he", "she") + " just sustain " + nieveMF("him", "her") + "self like that?  Nieve justs shakes " + nieveMF("his", "her") + " head, \"<i>I'm afraid it doesn't work like that.  My kind can only exist outside our homeland during the winter season.  Any further, and we simply melt away.</i>\"  " + nieveMF("He", "She") + " sighs sorrowfully, and you take " + nieveMF("his", "her") + " hand.  It's strangely warm, like the body temperature of a human, not at all " + nieveMF("his", "her") + " usual frigid touch."
                    +"\n\nA familiar jingling fills the air, and you both look down to see Nieve's legs replaced by a large ball of melting snow and ice.  Clearly not wanting to think about it, " + nieveMF("he", "she") + " throws " + nieveMF("his", "her") + " arms around you and pulls you into a hug.  \"<i>I just want to say,</i>\" " + nieveMF("he", "she") + " whispers into your ear.  \"<i>You were the best master I could have hoped for.  And...</i>\" " + nieveMF("he", "she") + " pauses, tears forming in " + nieveMF("his", "her") + " eyes, \"<i>And I'll mi--...</i>\"  " + nieveMF("His", "Her") + " voice drifts off.  When you break the hug to look at " + nieveMF("him", "her") + ", to urge " + nieveMF("him", "her") + " to continue, only the lifeless eyes of the snowman you first created stare back at you."
                    +"\n\nEverything about it looks the exact same... except for a sparkling, teardrop shaped icicle which hangs from the eye.  As you inspect it, it comes dislodged, falling and landing on your shoulder.  A final tear shed by Nieve, the ice spirit."
                    +"\n\nYou pick up the frozen tear, which doesn't appear to be melting at all, and clutch it tightly.");
            if (player.cor < 50) EngineCore.outputText("  You even tear up yourself, sad to see such a good friend leave, and so abruptly.");
            //Corruption >50: 
            else EngineCore.outputText("  You even feel a little sad yourself, it's such a pity to see a good, obedient fucktoy leave.");
            EngineCore.outputText("  The snowman collapses on itself, melting away before your very eyes.  In a matter of hours, this entire area will be nothing but a dried up, dehydrated desert once more.  But as the jingling fades out into the distance, you vow to hold on to the tear."
                    +"\n\nThe tear of Nieve.");
            if (player.cor < 50) EngineCore.outputText("\n\nThe tear of a friend.");
            if (player.hasKeyItem("Nieve's Tear") < 0) {
                EngineCore.outputText("\n\n(<b>Gained Key Item: Nieve's Tear</b>)");
                player.createKeyItem("Nieve's Tear", 1, 0, 0, 0);
            }
            flags[kFLAGS.NIEVE_STAGE] = 0;
        }
        EngineCore.doNext(EventParser.playerMenu);
    }

    public static function returnOfNieve():void {
        EngineCore.clearOutput();
        EngineCore.outputText("As you awake in the morning you find yourself shivering slightly.  A cool breeze sweeps over your camp, while in the distance jingling bells can be heard.  How odd.  You haven't heard bells like that since..."
                +"\n\nYour heart skips a beat."
                +"\n\n<i>You haven't heard bells like that since Nieve left you</i>."
                +"\n\nYou quickly glance around the campsite until your eyes fall upon a glittering patch of white: fresh fallen snow.  The pure white almost hurts your eyes against the hellish red of the surrounding landscape.  You make a mad dash into the snow, which comes up to your ankles.  Little snowflakes continue to drift slowly down as the jingling noise fades away into nothingness.  But you can't see anything...  No familiar snow " + nieveMF("man", "woman") + " to greet you.  Perhaps Nieve really is gone forever?"
                +"\n\nYou sink down into the snow, clutching Nieve's tear close and remember " + nieveMF("his", "her") + " last words to you.  \"<i>You were the best master I could have hoped for.</i>\"  The voice rings through your head. \"<i>And...  And I’ll mi--...</i>\"  Though " + nieveMF("he", "she") + " was cut off, you knew what " + nieveMF("he", "she") + " was saying."
                +"\n\n\"<i>I miss you too,</i>\" you whisper to the tear, before closing your fist around it.  Your vision blurs as your own eyes begin to tear up."
                +"\n\nThere really is nothing left of " + nieveMF("him", "her") + ".  Nothing but this lost fragment.  An echo of a friend.");
        //[Next]
        EngineCore.menu();
        EngineCore.addButton(0, "Next", fixNieve);

        function fixNieve():void {
            if (flags[kFLAGS.NIEVE_GENDER] == 0) {
                EngineCore.clearOutput();
                EngineCore.outputText("(There was an error with stat tracking that cleared Nieve's stats out at the end of last year's event. <b>What gender do you want Nieve to be?</b>)");
                EngineCore.menu();
                EngineCore.addButton(0, "Male", fixNieveGender, 1);
                EngineCore.addButton(1, "Female", fixNieveGender, 2);
            }
            else if (flags[kFLAGS.NIEVE_MOUTH] == "" || flags[kFLAGS.NIEVE_MOUTH] == 0) {
                EngineCore.clearOutput();
                EngineCore.outputText("(There was an error with stat tracking that cleared Nieve's stats out at the end of last year's event. <b>What were Nieve's eyes and mouth made out of?</b>)");
                EngineCore.menu();
                EngineCore.addButton(0, "Gems", fixNieveMouth, 0);
                EngineCore.addButton(1, "Coal", fixNieveMouth, 1);
            }
            else nieveReturnsPartII();

            function fixNieveMouth(arg:int = 1):void {
                if (arg == 0) flags[kFLAGS.NIEVE_MOUTH] = "gems";
                else flags[kFLAGS.NIEVE_MOUTH] = "coal";
                fixNieve();
            }

            function fixNieveGender(arg:int = 1):void {
                flags[kFLAGS.NIEVE_GENDER] = arg;
                fixNieve();
            }

            function nieveReturnsPartII():void {
                EngineCore.clearOutput();
                EngineCore.outputText("You sigh, resigning yourself to your companion's fate.  However, as you rise from the snow to return to camp, you hear a soft, muffled voice.  Perplexed, you crawl forward in the snow, frantically seeking out the source."
                        +"\n\nThat's when you see it, a small mound of snow, practically invisible among the white mass surrounding it.  You plunge your hands into the freezing cold stuff and find something solid.  Something large.  Something about the size of a person.  You move to pull the person up and forward, but it doesn't take much."
                        +"\n\nThe figure moves on its own, bursting from its snowy blanket.  All you catch is a brief flash of blue before the creature wraps its arms around you in a tight hug.  You can make out soft sobbing from the person... One glance down is all you need to confirm your suspicions.  That frozen, blue skin and pert squeezable ass.  It's definitely Nieve."
                        +"\n\n\"<i>Oh master!</i>\" " + nieveMF("he", "she") + " cries, breaking the hug to look you in the eyes.  " + nieveMF("His", "Her") + " ");
                if (flags[kFLAGS.NIEVE_MOUTH] == "coal") EngineCore.outputText("coal black");
                else EngineCore.outputText("glittering purple");
                EngineCore.outputText(" eyes shine with crystallizing tears, not entirely unlike the ones " + nieveMF("he", "she") + " left with you on your last meeting.  \"<i>I'm so glad to be back!  I was worried I would be sent somewhere else, but I had so much fun here, and I told the big man that, and then Winter came and I wasn't sure you were still here, and then it turned out I might have gone to someone else, but oh my goodness I'm so happy I came back!</i>\" Nieve belts out without pause for breath before wrapping " + nieveMF("his", "her") + " arms around you once again."
                        +"\n\nYou hold " + nieveMF("him", "her") + " close, thankful to whoever this \"big man\" is for sending Nieve back to you."
                        +"\n\n\"<i>I... I can still only stay the winter, at least for now, but it's something, right?</i>\" the snow spirit says, clasping your hand in theirs."
                        +"\n\nYou nod.  You'll take what you can get, even if it is such a brief moment.  The two of you share stories, well, you share stories while Nieve listens with rapt attention, for the next hour or so.  It's been a long time since you've seen each other, and there's a lot to catch up on...");
                flags[kFLAGS.NIEVE_STAGE] = 5;
                EngineCore.doNext(SceneLib.camp.returnToCampUseOneHour);
            }
        }
    }

    public static function isEaster():Boolean {
        return SceneLib.plains.bunnyGirl.isItEaster();
    }

    public static function isHalloween():Boolean {
        return ((date.date >= 28 && date.month == 9) || (date.date < 2 && date.month == 10) || flags[kFLAGS.ITS_EVERY_DAY] > 0);
    }

    public static function isLunarNewYear():Boolean {
        return ((date.date >= 21 && date.month == 0) || (date.date < 20 && date.month == 1) || flags[kFLAGS.ITS_EVERY_DAY] > 0);
    }

    /*Credits
    Fenoxo- for providing the game in which this scene might go into
    Kinathis - The \"<i>Suck Him</i>\" scene
    Gurumash - The \"<i>Get Fucked</i>\" scene
    Third - Everything else
    Pyro - The \"<i>Goodbye</i>\" outline*/
}
}
