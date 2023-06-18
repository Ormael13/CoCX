package classes.Transformations.Transformations {
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.EventParser;
import classes.PerkLib;
import classes.Races;
import classes.StatusEffects;
import classes.Transformations.*;
import classes.Items.MutationsHelper;

public class WarningTransformations extends MutationsHelper {
//======================================================================================================================
//                                                                                                                    ==
//   ██       ██  █████  ██████  ███    ██ ██ ███    ██  ██████  ███████                                              ==
//   ██       ██ ██   ██ ██   ██ ████   ██ ██ ████   ██ ██       ██                                                   ==
//   ██  ███  ██ ███████ ██████  ██ ██  ██ ██ ██ ██  ██ ██   ███ ███████                                              ==
//   ██ ██ ██ ██ ██   ██ ██   ██ ██  ██ ██ ██ ██  ██ ██ ██    ██      ██                                              ==
//   ████   ████ ██   ██ ██   ██ ██   ████ ██ ██   ████  ██████  ███████                                              ==
//                                                                                                                    ==
//======================================================================================================================

    public static const BAD_END_COOLDOWN:int = 6;

    public const CaninePepperWarning:PossibleEffect = new SimpleEffect("Transformation Warning for Kanga Fruit",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                if (!player.hasStatusEffect(StatusEffects.TFWarning) || player.getStatusValue(StatusEffects.TFWarning, 1) != Races.DOG.id) {
                    player.removeStatusEffect(StatusEffects.TFWarning);
                    player.createStatusEffect(StatusEffects.TFWarning, Races.DOG.id, 0, BAD_END_COOLDOWN, 0);
                } else {
                    player.changeStatusValue(StatusEffects.TFWarning, 3, BAD_END_COOLDOWN);
                    player.addStatusValue(StatusEffects.TFWarning, 2, 1);
                }

                var isBadEnd: Boolean = player.getStatusValue(StatusEffects.TFWarning, 2) >= 3;
                if (isBadEnd) {
                    if (rand(2) == 0) {
                        desc += "";
                        if (player.hasPerk(PerkLib.MarblesMilk)) desc += "As you swallow the pepper, you note that the spicy hotness on your tongue seems to be spreading. Your entire body seems to tingle and burn, making you feel far warmer than normal, feverish even. Unable to stand it any longer you tear away your clothes, hoping to cool down a little. Sadly, this does nothing to aid you with your problem. On the bright side, the sudden feeling of vertigo you've developed is more than enough to take your mind off your temperature issues. You fall forward onto your hands and knees, well not really hands and knees to be honest. More like paws and knees. That can't be good, you think for a moment, before the sensation of your bones shifting into a quadrupedal configuration robs you of your concentration. After that, it is only a short time before your form is remade completely into that of a large dog, or perhaps a wolf. The distinction would mean little to you now, even if you were capable of comprehending it. ";
                        else desc += "All you know is that there is a scent on the wind, it is time to hunt, and at the end of the day you need to come home for your milk.";
                    } else desc += "All you know is that there is a scent on the wind, and it is time to hunt.";
                } else {
                    desc += "Eating the pepper, you realize how dog-like you've become, <b>and you wonder what else the peppers could change...</b>";
                }

                if (doOutput) outputText(desc);
                if (isBadEnd) EventParser.gameOver();
            },
            function(): Boolean {
                return player.hasFullCoatOfType(Skin.FUR) && player.faceType == Face.DOG && player.ears.type == Ears.DOG && player.lowerBody == LowerBody.DOG && player.tailType == Tail.DOG && !player.hasPerk(PerkLib.TransformationResistance);
            }
    );

    public const KangaFruitWarning:PossibleEffect = new SimpleEffect("Transformation Warning for Kanga Fruit",
            // apply
            function (doOutput:Boolean):void {
                var desc: String = "";

                if (!player.hasStatusEffect(StatusEffects.TFWarning) || player.getStatusValue(StatusEffects.TFWarning, 1) != Races.KANGAROO.id) {
                    player.removeStatusEffect(StatusEffects.TFWarning);
                    player.createStatusEffect(StatusEffects.TFWarning, Races.KANGAROO.id, 0, BAD_END_COOLDOWN, 0);
                } else {
                    player.changeStatusValue(StatusEffects.TFWarning, 3, BAD_END_COOLDOWN);
                    player.addStatusValue(StatusEffects.TFWarning, 2, 1);
                }
                player.buff("KangaFruit")
                        .addStats( { "int.mult": -0.1 })
                        .withText("Kanga Fruit")
                        .forHours(BAD_END_COOLDOWN);

                var isBadEnd: Boolean = player.getStatusValue(StatusEffects.TFWarning, 2) >= 10;
                if (isBadEnd) {
                    desc += "While you gnaw on the fibrous fruit, your already vacant mind continues to empty, leaving nothing behind but the motion of your jaw as you slowly chew and swallow your favorite food.  Swallow.  Chew.  Swallow.  You don't even notice your posture worsening or your arms shortening.  Without a single thought, you start to hunch over but keep munching on the food in your paws as if were the most normal thing in the world.  Teeth sink into one of your fingers, leaving you to yelp in pain.  With the last of your senses, you look at your throbbing paw to notice you've run out of kanga fruit!";
                    desc += "[pg]Still hungry and licking your lips in anticipation, you sniff in deep lungfuls of air.  There's more of that wonderful fruit nearby!  You bound off in search of it on your incredibly muscular legs, their shape becoming more and more feral with every hop.  Now guided completely by instinct, you find a few stalks that grow from the ground.  Your belly rumbles, reminding you of your hunger, as you begin to dig into the kanga fruits...";
                    desc += "[pg]Losing more of what little remains of yourself, your body is now entirely that of a feral kangaroo and your mind has devolved to match it.  After you finish the handful of fruits you found, you move on in search for more of the tasty treats.  Though you pass by your camp later on, there's no memory, no recognition, just a slight feeling of comfort and familiarity.  There's no food here so you hop away.";
                } else {
                    desc += "While chewing, your mind becomes more and more tranquil.  You find it hard to even remember your mission, let alone your name.  <b>Maybe more kanga fruits will help?</b>";
                }

                if (doOutput) outputText(desc);
                if (isBadEnd) EventParser.gameOver();
            },
            function(): Boolean {
                return transformations.ArmsHuman.isPresent() && transformations.HairHuman.isPresent() &&transformations.EyesHuman.isPresent() &&  transformations.FaceKangaroo.isPresent() && transformations.LowerBodyKangaroo.isPresent() && transformations.TailKangaroo.isPresent() && transformations.EarsKangaroo.isPresent() && player.hasFullCoatOfType(Skin.FUR) && transformations.GillsNone.isPresent() && !player.hasPerk(PerkLib.TransformationResistance);
            }
    );
}
}
