package classes.Transformations.Transformations {
import classes.BodyParts.Tail;
import classes.Transformations.*;
import classes.Items.MutationsHelper;
import classes.Scenes.Metamorph;

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
            "Your reflexes feel much faster. Experimentally, you make a grab at a fly on a nearby rock and quickly snatch it out of the air. A compulsion to stuff it in your mouth and eat it surfaces, but you resist the odd desire. Why would you ever want to do something like that?"
    );

    public const MutagenTouSpider:PossibleEffect = new MutagenEffect("Mutagen Bonus TOU (spider)",
            "tou",
            1,
            "Stretching languidly, you realize you're feeling a little tougher than before, almost as if you had a full-body shell of armor protecting your internal organs. How strange. You probe at yourself, and while your [skinfurscales] doesn't feel much different, the underlying flesh does seem tougher."
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

    public const MutagenSpdCat: PossibleEffect = new StatChangeEffect("Mutagen Spd Cat",
            // apply effect
            function (doOutput: Boolean): void {
                var desc: String = "";

                if (player.spe <= 30) {
                    desc += "You feel... more balanced, sure of step. You're certain that you've become just a little bit faster.";
                    MutagenBonus("spe", 2);
                } else if (player.spe <= 60) {
                    desc += "You stumble as you shift position, surprised by how quickly you move. After a moment or two of disorientation, you adjust. You're certain that you can run faster now.";
                    MutagenBonus("spe", 1);
                } else {
                    desc += "You pause mid-step and crouch. Your leg muscles have cramped up like crazy. After a few moments, the pain passes and you feel like you could chase anything down.";
                    MutagenBonus("spe", 0.5);
                }

                if (doOutput) outputText(desc);
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
            }
    );
}
}
