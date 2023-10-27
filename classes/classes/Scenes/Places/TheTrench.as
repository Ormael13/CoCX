/**
 * ...
 * @author Sylabt & Ohaxer
 */
package classes.Scenes.Places 
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Races.ArigeanRace;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.SceneLib;

public class TheTrench extends BaseContent implements TimeAwareInterface {
	
	public function TheTrench() 
	{
		EventParser.timeAwareClassAdd(this);
	}

	//Implementation of TimeAwareInterface
		public function timeChange():Boolean {
			return false;
		}

		public function timeChangeLarge():Boolean {
			if (player.hasStatusEffect(StatusEffects.ArigeanInfected) && model.time.hours == 23) {
				var arigeanProgress:Number = 0;
				var arigeanProgressOncePerNight:Number = 0;
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 0) {
					outputText("\nYour rest is brief as you awaken, your body being racked with immense pain as you find that you cannot move your body, the pain becomes nearly unbearable as you fall unconscious.\n");
					outputText("When you wake up, you inspect yourself and find that <b>you seem to be as human as when you first came to this place.</b>\n");
					transformations.HairHuman.applyEffect(false);
					if (player.arms.type != Arms.ARMORED_FOREARMS) player.arms.type = Arms.HUMAN;
					player.eyes.type = Eyes.HUMAN;
					player.antennae.type = Antennae.NONE;
					transformations.FaceHuman.applyEffect(false);
					if (player.lowerBody != LowerBody.ARMORED_LEGS) player.lowerBody = LowerBody.HUMAN;
					player.legCount = 2;
					player.wings.type = Wings.NONE;
					player.tailType = Tail.NONE;
					player.tailRecharge = 0;
					player.horns.count = 0;
					player.horns.type = Horns.NONE;
					player.ears.type = Ears.HUMAN;
					transformations.SkinPlain.applyEffect(false);
					player.tongue.type = Tongue.HUMAN;
					player.gills.type = Gills.NONE;
					player.rearBody.type = RearBody.NONE;
					if (player.hasCock()) {
						player.killCocks(-1, false);
						transformations.CockHuman().applyEffect();
					}
					if (player.hasVagina() && player.vaginaType() != VaginaClass.HUMAN) player.vaginaType(0);
					player.removeStatusEffect(StatusEffects.Uniball);
					player.removeStatusEffect(StatusEffects.BlackNipples);
					player.removeStatusEffect(StatusEffects.GlowingAsshole);
					player.removeStatusEffect(StatusEffects.GlowingNipples);
					player.addStatusValue(StatusEffects.ArigeanInfected, 1, 1);
					arigeanProgressOncePerNight += 1;
					arigeanProgress += 1;
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 1 && arigeanProgress == 0 && arigeanProgressOncePerNight == 0) {
					if (player.skinColor != "albino") {
						outputText("\nYou awaken drowsy with a wave of nausea hitting you hard, and you leave your tent to vomit, as you return to your tent, you find that your skin looks very, very pale. You assume that’s it just because you just vomited, and went back to sleep. When you wake up you find that <b>your skin is now albino</b>, but why? You ask yourself...\n");
						arigeanProgressOncePerNight += 1;
						player.skinColor = "albino";
						arigeanProgress += 1;
					}
					player.addStatusValue(StatusEffects.ArigeanInfected, 1, 1);
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 2 && arigeanProgress == 0 && arigeanProgressOncePerNight == 0) {
					outputText("\nYou awaken with a quickly escalating pain right above your ass, and you both hear and feel something burst out from within you, as you look back you see two black, eyeless eel-like creatures writhing behind you, and you quickly move to attempt to toss it away from your body. As you grip one of the creature’s necks you find it's attached to you right where your tailbone ends, one of the startled creature's heads bites your arm with it's lipless maw only for you both to hiss in pain. You go to nurse your wound as you realize you <b>now have a parasitic organism attached to you.</b>");
					if (EvangelineFollower.EvangelineCuringArigeanInfection == 0) outputText(" Perhaps it would be best to try and find a way to remove this thing from your body before your situation gets any worse.\n");
					if (EvangelineFollower.EvangelineCuringArigeanInfection == 1) outputText(" You can’t help but feel relieved at the reappearance of your tail-like partner, would it hurt to let it stay for a bit?\n");
					if (EvangelineFollower.EvangelineCuringArigeanInfection == 2) outputText(" You can’t help but tightly embrace one of the heads into a hug as a few tears fall from your eyes, oh how you missed them.\n");
					transformations.TailArigeanGreen.applyEffect(false);
					player.addStatusValue(StatusEffects.ArigeanInfected, 1, 1);
					arigeanProgressOncePerNight += 1;
					arigeanProgress += 1;
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 3 && arigeanProgress == 0 && arigeanProgressOncePerNight == 0) {
					if (player.arms.type != Arms.ARMORED_FOREARMS && player.lowerBody != LowerBody.ARMORED_LEGS) {
						if (player.lowerBody != LowerBody.ARMORED_LEGS) {
							outputText("\nYour sleep is disturbed with a particularly strong soreness coming from your knees, and as you move to see if you injured your knees, you find you are completely unable to move your legs. A burning sensation seems to spread from your toes up to your thighs as the skin seems to thicken and turn black, gaining a slight gloss reflected by the moonlight. After the ordeal, you attempt to bend your knees or move your feet, and with a loud <i>crack</i> as well as a sharp stab of pain you find some of the covering has given way around your joints allowing you to move freely again. With a few experimental hits, you find you <b>now have armored legs.</b>\n");
							transformations.LowerBodyArigean.applyEffect(false);
						}
						if (player.arms.type != Arms.ARMORED_FOREARMS) {
							outputText("\nHowever it doesn’t seem to stop there, a multitude of stabbing pains seem to randomly come from your forearms as black metal fragments like those on your legs break through your skin with a decent amount of blood. A small investigation proves they offer a decent amount of protection from blows, It seems <b>you now have natural bracers.</b>\n");
							transformations.ArmsArigean.applyEffect(false);
						}
						arigeanProgressOncePerNight += 1;
						arigeanProgress += 1;
					}
					player.addStatusValue(StatusEffects.ArigeanInfected, 1, 1);
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 4 && arigeanProgress == 0 && arigeanProgressOncePerNight == 0) {
					if (!InCollection(player.hairColor, ArigeanRace.ArigeanHairColors)) player.hairColor = randomChoice(ArigeanRace.ArigeanHairColors);
					outputText("\nYour restful slumber is cut short as you awaken to a tingling sensation across your scalp and a mild burning sensation across your body, the latter of which seems to mostly subside within a few seconds save for your nethers and mouth. Upon further inspection, at the nearby stream, you discover the inside of your mouth and tongue has become a dark blue, and your hair has become " + player.hairColor + " color. Meanwhile, you look down to see what exactly has changed. ");
					outputText((player.hasCock()?"You find your penis still looks human except for the tip which has taken on a light blue color":"")+(player.gender == 3?" and looking under y":"Y")+(player.hasVagina()?"ou find the lips of your seemingly normal muff has taken on the same light blue color your mouth has":"")+". The presence of the dark sky reminds you it’s still late into the night and a champion needs their sleep should they wish to get anything done, and with that in mind you head back off to bed.\n");
					if (player.hasVagina()) transformations.VaginaArigean().applyEffect(false);
					if (player.hasCock()) transformations.CockArigean().applyEffect(false);
					transformations.TongueArigean.applyEffect(false);
					transformations.FaceArigean.applyEffect(false);
					transformations.EarsElven.applyEffect(false);
					player.addStatusValue(StatusEffects.ArigeanInfected, 1, 1);
					arigeanProgressOncePerNight += 1;
					arigeanProgress += 1;
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 5 && arigeanProgress == 0 && arigeanProgressOncePerNight == 0) {
					outputText("\nYou awaken again to a sharp pain coming from your abdomen however it quickly fades into soreness and ");
					player.addStatusValue(StatusEffects.ArigeanInfected, 1, 1);
					if (player.femininity < 90) player.femininity = 90;
					arigeanProgressOncePerNight += 1;
					arigeanProgress += 1;
					if (player.gender == 2) outputText("eventually stops, however you think it might be best to stay up to see if any other monstrous transformation is going to be brought upon you. Nothing happens and you eventually drift back off into a deep rest.\n");
					else {
						doNext(nightSixChoice);
                        return true;
					}
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 6 && player.statusEffectv2(StatusEffects.ArigeanInfected) == 1 && arigeanProgress == 0 && arigeanProgressOncePerNight == 0) {
					outputText("\nAs you open your eyes you find you are standing somewhere pitch black with the feeling of running water at your feet, and you decide it might be a better choice to kneel down so you can get a better sense of your surroundings. Slowly your visibility of the area starts to return as you swiftly realize it’s not pitch black as you thought it was, and you had momentarily gone blind, but upon further looking at your reflection on the water’s your attention is immediately drawn to your eyes, which seem to be giving off a soft nearly otherworldly glow and almost seem to be entirely white if it weren’t for that glow. After idly loitering in the surprisingly soothing stream, you realize it’s one, extremely dark, and two you're seemingly doing nothing in the stream near the camp for no good reason so you decide to head back. ");
					outputText("And as you step onto the solid ground you feel something churn in your guts, it seems your parasite is now ready for combat... combat? You hear a loud blast as a streak of scorching magic seems to fly out of one of the mouths of your new parasitic friend as if to emphasize that intrusive thought. You think it might be best to return to bed and away from the carnage of a destroyed tree, but not before long a strong wave of anxiety seems to grip at your heart, and a desire to return to that strange woman at the ocean who you now seem to resemble, after all <b>as a new type Ne-Class Arigean, it should be your duty to report to your superior....</b> wait... where did that thought come from?\n");
					dynStats("cor", 10);
					transformations.EyesArigean.applyEffect(false);
					player.createPerk(PerkLib.MiracleMetal, 0, 0, 0, 0);
					player.removeStatusEffect(StatusEffects.ArigeanInfected);
				}
				if (player.statusEffectv1(StatusEffects.ArigeanInfected) == 6) player.addStatusValue(StatusEffects.ArigeanInfected, 2, 1);
			}
			return false;
		}
		//End of Interface Implementation

public function nightSixChoice():void {
	outputText("your facial features tingle as they start to change, quickly gaining the appearance of that of a woman, your voice quickly follows suit as you gasp at a sudden pain coming from the change of your figure, and an itch builds up from your now soft chest that you can’t help but scratch at furiously, the itch soon begins to turn to pleasure as your chest slowly swells out into a pair of perfectly plump breasts. After trying to catch your breath and take in your new form you can’t help but moan and spasm as a warm wetness seems to leak from your nether region, and as you look down you realize…\n\n");
	menu();
	addButton(1, "Dick", nightSixChoiceDick);
	addButton(3, "No Dick", nightSixChoiceNoDick);
}
private function nightSixChoiceDick():void {
	outputText("A look down between your now thicker covered thighs reveals your dick is still there"+(player.hasBalls()?" however your balls seem to have disappeared":"")+". What catches your attention however is a wet vertical slit underneath your cock, you experimentally take two fingers and slowly open your new light blue folds, and can’t help but moan from a sudden wave of pleasure and heat that radiates up your spine, forcibly arching your back.");
	nightSixChoiceEnding();
}
private function nightSixChoiceNoDick():void {
	outputText("It’s gone! A look down between your now thicker covered thighs reveals your dick"+(player.hasBalls()?" and balls":"")+" has been replaced with a moist vertical slit, you experimentally use two fingers to open your new light blue folds, and can’t help but moan from a sudden wave of pleasure and heat that radiate up your spine flushing your face blue.");
	player.killCocks( -1, false);
	nightSixChoiceEnding();
}
private function nightSixChoiceEnding():void {
	player.balls = 0;
    player.ballSize = 1;
	if (!player.hasVagina()) transformations.VaginaArigean().applyEffect();
	if (player.hasPerk(PerkLib.BroBody)) player.removePerk(PerkLib.BroBody);
	if (player.hasPerk(PerkLib.BroBrains)) player.removePerk(PerkLib.BroBrains);
	if (player.breastRows[0].breastRating < 2) player.breastRows[0].breastRating = 2;
	outputText(" You head back to sleep opting to deal with the problems of your new body later and when you're more awake.\n");
	doNext(playerMenu);
}
public function graydaEncounterTheTrench():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
public function graydaEncounterTheTrenchYes():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
public function graydaEncounterTheTrenchFlee():void {
	clearOutput();
	outputText("You shake your head, you assume this thing is trying to charm you. You run back to the camp, but to your surprise, she doesn’t give chase. Instead, she simply sighs and goes into the water...perhaps she wasn’t trying to charm you?\n\n");
}/*
public function graydaEncounterTheTrench():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
public function graydaEncounterTheTrench():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}*/
	}
}