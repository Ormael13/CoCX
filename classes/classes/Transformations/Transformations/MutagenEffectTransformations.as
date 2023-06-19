package classes.Transformations.Transformations {
import classes.BodyParts.Tail;
import classes.CockTypesEnum;
import classes.Items.MutationsHelper;
import classes.Races;
import classes.Transformations.*;

public class MutagenEffectTransformations extends MutationsHelper {
    /***
     *    ███████ ███████ ███████ ███████  ██████ ████████ ███████
     *    ██      ██      ██      ██      ██         ██    ██
     *    █████   █████   █████   █████   ██         ██    ███████
     *    ██      ██      ██      ██      ██         ██         ██
     *    ███████ ██      ██      ███████  ██████    ██    ███████
     *
     *
     */
// Template for non-tf effects and tf effects that cannot be "present" (ex. enlarge cock)
// "is possible" function is optional, default always possible
    /*
    public const NAME:PossibleEffect = new SimpleEffect("Effect name",
                // apply effect
                function (doOutput:Boolean):void {
                    var desc: String = "";

                    if (doOutput) outputText(desc);
                    apply_effect
                },
                // is possible?
                function ():Boolean {
                    return true_if_effect_can_be_applied_to_player
                }
    );
    */

    /*
        */
    public const MutagenSpeSpider:PossibleEffect = new MutagenEffect("Mutagen Bonus SPE (spider)",
            "spe",
            1.5,
            "Your reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air. A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire. Why would you ever want to do something like that?",
            function (): Boolean {
                return player.spe100 < 70;
            }
    );

    public const MutagenCurseSpeSpider:PossibleEffect = new MutagenCurse("Mutagen Curse SPE (spider)",
            "spe",
            2,
            "You feel like resting high in the trees and waiting for your unsuspecting prey to wander below so you can take them without having to exert yourself.  What an odd thought!",
            function (): Boolean {
                return player.spe100 > 80;
            }
    );

    public const MutagenTouSpider:PossibleEffect = new MutagenEffect("Mutagen Bonus TOU (spider)",
            "tou",
            1,
            "Stretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs. How strange. You probe at yourself, and while your [skinfurscales] doesn't feel much different, the underlying flesh does seem tougher.",
            function():Boolean {
                return player.str100 < 60;
            }
    );

    public const MutagenCurseStrSpider:PossibleEffect = new StatChangeEffect("Mutagen Curse STR (spider)",
            function(doOutput: Boolean): void {
                var desc: String = "";

                desc += "Lethargy rolls through you while you burp noisily.  You rub at your muscles and sigh, wondering why you need to be strong when you could just sew up a nice sticky web to catch your enemies.  ";
                if (player.isRace(Races.SPIDER, 1, false))
                    desc += "Well, maybe you should put your nice, heavy abdomen to work.";
                else desc += "Wait, you're not a spider, that doesn't make any sense!";

                if (doOutput) outputText(desc);
                player.addCurse("spe", 1, 1);
            },
            function():Boolean {
                return player.str100 > 70;
            }
    );

    public const MutagenLibSpider:PossibleEffect = new MutagenEffect("Mutagen Bonus LIB (spider)",
            "lib",
            1,
            "You suddenly feel slightly needier, and your loins stir in quiet reminder that they could be seen to. The aftertaste hangs on your tongue and your teeth. You wish there had been more."
    );

    public const SensUpSpider:PossibleEffect = new DynstatEffect("Spider sens up",
            "sen",
            +1,
            "The hairs on your arms and legs stand up straight for a few moments, detecting the airflow around you. Touch appears to be more receptive from now on."
    );

    public const VenomRechargeSpider:PossibleEffect = new SimpleEffect("Recharge spider venom",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                desc += "The spinnerets on your abdomen twitch and drip a little webbing. The entirety of its heavy weight shifts slightly, and somehow you know you'll produce webs faster now.";

                if (doOutput) outputText(desc);
                player.tailRecharge += 5;
            },
            // is possible
            function ():Boolean {
                return player.tailType == Tail.SPIDER_ADBOMEN && player.tailRecharge < 25;
            }
    );

    public const MutagenSpdCat: PossibleEffect = new StatChangeEffect("Mutagen Spd Cat",
            // apply effect
            function (doOutput: Boolean): void {
                var desc: String = "";

                if (player.spe100 <= 30) {
                    desc += "You feel... more balanced, sure of step. You're certain that you've become just a little bit faster.";
                    MutagenBonus("spe", 2);
                } else if (player.spe100 <= 60) {
                    desc += "You stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation, you adjust. You're certain that you can run faster now.";
                    MutagenBonus("spe", 1);
                } else {
                    desc += "You pause mid-step and crouch. Your leg muscles have cramped up like crazy. After a few moments, the pain passes and you feel like you could chase anything down.";
                    MutagenBonus("spe", 0.5);
                }

                if (doOutput) outputText(desc);
            },
            function(): Boolean {
                return player.spe100 < 75;
            }
    );

    public const MutagenStrCat: PossibleEffect = new StatChangeEffect("Mutagen Str Cat",
            // apply effect
            function (doOutput: Boolean): void {
                var desc: String = "";

                if (rand(2) == 0) desc += "Your muscles feel taut, like a coiled spring, and a bit more on edge.";
                else desc += "You arch your back as your muscles clench painfully. The cramp passes swiftly, leaving you feeling like you've gotten a bit stronger.";

                MutagenBonus("str", 1);
                if (doOutput) outputText(desc);
            },
            function(): Boolean {
                return player.str100 < 40;
            }
    );

    public const MutagenIntCat:PossibleEffect = new MutagenEffect("Mutagen Bonus INT (cat)",
            "int",
            2,
            "You suddenly feel more cunning and by far way smarter."
    );

    public const MutagenCurseTouCat:PossibleEffect = new MutagenCurse("Mutagen Curse TOU (cat)",
            "tou",
            2,
            "Your body seems to compress momentarily, becoming leaner and noticeably less tough.",
            function(): Boolean {
                return player.tou100 > 50;
            }
    );

    public const MutagenLibSensCat: PossibleEffect = new StatChangeEffect("Mutagen Bonus LIB & SENS (cat)",
            // apply effect
            function (doOutput: Boolean): void {
                var desc: String = "";

                //Cat dicked folks
                if (player.catCocks() > 0) {
                    var choice: int = player.findFirstCockType(CockTypesEnum.CAT);
                    desc += "You feel your " + cockDescript(choice) + " growing hard, the barbs becoming more sensitive. You gently run your hands down them and imagine the feeling of raking the insides of a cunt as you pull.  The fantasy continues, and after ejaculating and hearing the female yowl with pleasure, you shake your head and try to drive off the image.  ";
                    if (player.cor < 33) desc += "You need to control yourself better.";
                    else if (player.cor < 66) desc += "You're not sure how you feel about the fantasy.";
                    else desc += "You hope to find a willing partner to make this a reality.";
                }
                //Else –
                else {
                    desc += "A rush of tingling warmth spreads through your body as it digests the fruit.  You can feel your blood pumping through your extremities, making them feel sensitive and surprisingly sensual.  It's going to be hard to resist getting ";
                    if (player.lust > 60) desc += "even more ";
                    desc += "turned on.";
                }
                player.addCurse("sen", 1, 1);
                MutagenBonus("lib", 1);
                if (doOutput) outputText(desc);
            },
            function(): Boolean {
                return MutagenBonus("lib", 1, false);
            }
    );

    public const MutagenSpeKanga:PossibleEffect = new MutagenEffect("Mutagen Bonus SPE (kanga)",
            "spe",
            1,
            "Your legs fill with energy as you eat the kanga fruit.  You feel like you could set a long-jump record!  You give a few experimental bounds, both standing and running, with your newfound vigor.  Your stride seems longer too; you even catch a bit of air as you push off with every powerful step.",
            function (): Boolean {
                return player.spe100 < 70;
            }
    );

    public const MutagenCurseIntKanga:PossibleEffect = new StatChangeEffect("Mutagen Curse Inte (Kanga)",
            function(doOutput: Boolean): void {
                var desc: String = "";

                if (player.inte100 > 30) desc += "You feel... antsy. You momentarily forget your other concerns as you look around you, trying to decide which direction you'd be most likely to find more food in.  You're about to set out on the search when your mind refocuses and you realize you already have some stored at camp.";
                if (player.inte100 > 10) desc += "Your mind wanders as you eat; you think of what it would be like to run forever, bounding across the wastes of Mareth in the simple joy of movement.  You bring the kanga fruit to your mouth one last time, only to realize there's nothing edible left on it.  The thought brings you back to yourself with a start.";
                else desc += "You lose track of everything as you eat, staring at the bugs crawling across the ground.  After a while you notice the dull taste of saliva in your mouth and realize you've been sitting there, chewing the same mouthful for five minutes.  You vacantly swallow and take another bite, then go back to staring at the ground.  Was there anything else to do today?";

                if (doOutput) outputText(desc);
                player.addCurse("inte", 1, 1);
            }
    );





    public const VaginaTightenAndMutagenLib:PossibleEffect  = new SimpleEffect("Tighten vagina + Mutagen Bonus LIB",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                desc += "With a gasp, you feel your [vagina] tightening, making you leak sticky girl-juice. After a few seconds, it stops, and you rub on your [vagina] excitedly. You can't wait to try this out!";

                if (doOutput) outputText(desc);
                player.vaginas[0].vaginalLooseness--;
                dynStats("lus", 25, "scale", false);
                MutagenBonus("lib", 2);
            },
            // is possible
            function ():Boolean {
                return player.hasVagina() && player.looseness() > 1
            }
    );

    public const AssholeTightenAndMutagenLib:PossibleEffect = new SimpleEffect("Tighten asshole + Mutagen Bonus LIB",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                desc += "You let out a small cry as your [asshole] shrinks, becoming smaller and tighter. When it's done, you feel much hornier and eager to stretch it out again.";

                if (doOutput) outputText(desc);
                player.ass.analLooseness--;
                dynStats("lus", 25, "scale", false);
                MutagenBonus("lib", 2);
            },
            // is possible
            function ():Boolean {
                return player.ass.analLooseness > 1;
            }
    );

    public const CocksThickenAll:PossibleEffect = new SimpleEffect("Thicken all cocks",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";
                var thickened:Boolean = false;
                for (var i:int = 0; i < player.cockTotal(); i++) {
                    if (player.cocks[i].cockThickness * 5.5 < player.cocks[i].cockLength) {
                        player.cocks[i].cockThickness += .1;
                        thickened = true;
                    }
                }
                if (thickened) {
                    desc += "You can feel your [cocks] filling out in your [armor]. Pulling ";
                    if (player.cockTotal() == 1) desc += "it";
                    else desc += "them";
                    desc += " out, you look closely. ";
                    if (player.cockTotal() == 1) desc += "It's";
                    else desc += "They're";
                    desc += " definitely thicker.";
                }

                if (doOutput) outputText(desc);
            },
            // is possible
            function ():Boolean {
                return player.hasCock();
            }
    );

    public const ShrinkClit:PossibleEffect = new SimpleEffect("Shrink Clit to half size",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                desc += "Painful pricks work through your [clit], all the way into its swollen clitoral sheath.  Gods, it feels afire with pain!  Agony runs up and down its length, and by the time the pain finally fades, the feminine organ has lost half its size.";

                if (doOutput) outputText(desc);
                player.clitLength /= 2;
                dynStats("lus", 25, "scale", false);
                MutagenBonus("lib", 2);
            }
    );

    public const ShrinkBalls:Transformation = new SimpleTransformation("Shrink balls",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                desc += "Your [sack] pulls tight against your groin, vibrating slightly as it changes.  Once it finishes, you give your [balls] a gentle squeeze and discover they've shrunk.  Even with the reduced volume, they feel just as heavy."

                if (doOutput) outputText(desc);
                player.ballSize--;
                player.cumMultiplier++;
            },
            // is present
            function ():Boolean {
                return player.ballSize < 4;
            }
    );
}
}
