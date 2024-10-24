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
import classes.IMutations.IMutationsLib;
import classes.Scenes.NPCs.Grayda;
import classes.internals.Utils;
import classes.Races.ArigeanRace;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

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
	if (player.hasPerk(PerkLib.FutaForm)) player.removePerk(PerkLib.FutaForm);
	if (player.hasPerk(PerkLib.FutaFaculties)) player.removePerk(PerkLib.FutaFaculties);
	if (player.breastRows[0].breastRating < 2) player.breastRows[0].breastRating = 2;
	outputText(" You head back to sleep opting to deal with the problems of your new body later and when you're more awake.\n");
	doNext(playerMenu);
}
public function graydaEncounterTheTrench():void {
	clearOutput();
	outputText("After sailing quite a far from shore distance from shore a bold idea you would never even consider trying crosses your mind, walking on water. The idea seems absurd at first however you recall that strange woman being able to walk on the water’s surface, surely you should be able to do the same seeing as you're now the same race. You start with carefully hanging your legs off the boat and slowly step down as if you were just getting off the boat onto land, and surprisingly you find yourself standing on the water instead of in it.\n\n");
	outputText("You carefully take a few steps forward before getting a hang of walking on the somewhat shaky surface, and before long you find yourself running around without a care in the world. However, after having your fun you decide it would be best to head back to camp, but you can’t seem to find your boat anywhere, after a bit of wandering a thick layer of fog seems to come out of nowhere and sudden panic floods your system, you could be attacked from any direction including from underneath. But why should you be afraid of anything out here? Clearly they should be afraid of an apex creature like yourself! You shake your head, such... overconfidence could get you killed, or much worse...\n\n");
	outputText("\"<i>So, you’ve come back.</i>\" A calm voice speaks, originating somewhere behind you.\n\n");
	outputText("You quickly move to face the speaker, and place a hand on your weapon readying yourself for combat, but you can’t seem to draw your weapon, afterall it would be disrespectful to draw a weapon on your superior… You grip at your head as you wonder where these strange thoughts have been coming from, but for now it’s best to pay attention to your potential opponent. It appears to be the strange woman from before.\n\n");
	outputText("\"<i>Relax, I mean you no harm.</i>\" Her posture seems more relaxed then when you first encountered her, and you can’t help but feel at ease in her presence. She places both of her hands on her staff, \"<i>I'm sorry for violating you like that… And stealing your gems, it was uncalled for. However, I don’t regret infecting you, as you might even grow to like having such a form.</i>\"\n\n");
	outputText("A small tinge of fear seems to trickle down your spine at her words, something about her seems far too serene, is it possible she’s cast some sort of charm on you?\n\n");
	outputText("\"<i>So ‘recruit’ will you follow me? I know this may seem sudden, but there is someplace I wish to show you, and I’ll be able to properly compensate you there.</i>\"\n\n");
	outputText("She presents you her open hand, most likely to lead you to where she wishes to take you. You feel compelled to accept her offer, but something in the back of your mind is telling you that this is wrong, and you should not follow her under any circumstance. <b>Do you take her hand?</b>\n\n");
	menu();
	addButton(1, "Yes", graydaEncounterTheTrenchYes);
	addButton(3, "Flee", graydaEncounterTheTrenchFlee);
}
private function graydaEncounterTheTrenchYes():void {
	clearOutput();
	outputText("You take her hand, and she responds by firmly grasping yours in turn, and begins to lead the way somewhere deeper into the fog.\n\n");
	outputText("\"<i>Stay close behind me, and try to pay attention to where we’re going.</i>\" She orders while maintaining a steady pace with you in hand. Eventually she stops in what seems to be the center of the veil of fog, and releases her grip on your hand before diving into the depths.\n\n");
	outputText("You take a deep breath, and hesitantly dive after her. She seems to be leading you straight down towards a crack on the ocean floor, and it isn’t until a few minutes down it do two things dawn on you, not only have you stopped holding your breath, but are also somehow breathing, and despite the lack of light this far down the trench you are still able to see clear as day. Suddenly she stops in front of what looks like a cave opening before turning around to make sure you're still behind her, and together you enter the cave surfacing into what looks like a giant chamber that still possesses breathable air.\n\n");
	outputText("\"<i>Your clothes are wet… Would you like some dry ones?</i>\" She gestures to your now sodden [armor]. Notably her one piece, cloak and boots don’t seem soaked at all with water rolling off their surfaces.\n\n");
	outputText("You attempt to explain that it won’t be necessary, but before you can say anything she takes off through a carved doorway on your left, leaving you alone to inspect the chamber as you wait. You notice there are a few carved doorways around the chamber, all of them seem to be decently lit with some sort of soft white light, a commotion can be heard from the door on your right meaning you and that woman are not the only ones who are currently here. Before long she emerges from the door on your left with a small sack, and what looks like a neatly folded set of black clothing.\n\n");
	outputText("\"<i>Here, this uniform should be worth the same value as the gems I took from you, and this should prove to be more water-proof than your current equipment.</i>\" She hands you your items before continuing. \"<i>I'm afraid if you lose these clothes you’ll have to pay for new ones. We can’t afford to keep giving out equipment just because someone lost theirs.</i>\" She says in a stern tone.\n\n");
	outputText("\"<i>We?</i>\"\n\n");
	outputText("\"<i>There are others of our kind here.</i>\" She pauses for a moment to make sure her glowing yellow eyes are locked with your green, only now do you realize her above average height. \"<i>Our kind are on the verge of extinction, In all of Mareth I estimate our numbers to not even be in the triple digits, this place is just one of two shelters to offer safety for our kind from the rampant corruption on the surface, and from the other horrors that stalk the seas. We hope to form a proper society but… the land walkers are less than accepting of our kind, most fail to understand our kind, after all. Perhaps you might not understand yet, but in time I trust you will.</i>\" ");
	outputText("She takes a few steps to the door on the right before continuing with a small smile. \"<i>You are free to rest here for as long as you choose, rooms with beds are on the left, small supply shops are to the right, and the center door is the commons. I also have a few jobs open should you wish to contribute, welcome to the trench…</i>\" The small smile she wears quickly turns blank \"<i>I don’t believe i’ve caught your name.</i>\"\n\n");
	outputText("\"<i>[name]</i>\"\n\n");
	outputText("\"<i>Welcome [name]. Im Grayda, the one who is currently acting leader of those here.</i>\"\n\n");
	outputText("<b>You have unlocked The Trench in Places menu!</b>\n\n");
	player.createStatusEffect(StatusEffects.Trench, 0, 0, 0, 0);
	flags[kFLAGS.THE_TRENCH_ENTERED] = 1;
	explorer.stopExploring();
	SceneLib.inventory.takeItem(armors.ANE_UNI, theTrenchMain);
}
private function graydaEncounterTheTrenchFlee():void {
	clearOutput();
	outputText("You shake your head, you assume this thing is trying to charm you. You run back to the camp, but to your surprise, she doesn’t give chase. Instead, she simply sighs and goes into the water...perhaps she wasn’t trying to charm you?\n\n");
	endEncounter();
}
public function theTrenchEntrance():void {
	clearOutput();
	outputText("Following the path Grayda showed you, you navigate yourself through the dark underwater chasm, and soon find yourself within the small community lovingly named ‘The Trench’. It’s a series of rooms carved out of the stone walls of the underwater cave, notably divided into three different sections which serve different purposes. A few plants seem to line some of the walls which produce a soft, white light, and a general feeling of safety and passiveness seems to fill you at the thought of other Arigeans being around.\n\n");
	theTrenchMain1();
	menu();
	addButtonIfTrue(0, "Quarters", theTrenchQuarters, "It's still too early to go to sleep.", isNightTime, "Turn yourself in for the night.");
	addButton(1, "Equipment shop", theTrenchEquipmentShop);
	addButton(2, "Food Stand", theTrenchFoodStand);
	addButtonIfTrue(3, "Grayda", theTrenchGraydaQuestNPC, "She's currently in your camp.", flags[kFLAGS.THE_TRENCH_ENTERED] < 15);
	addButton(4, "Loiter", theTrenchLoiter);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}
private function theTrenchMain():void {
	clearOutput();
	theTrenchMain1();
	menu();
	addButtonIfTrue(0, "Quarters", theTrenchQuarters, "It's still too early to go to sleep.", isNightTime, "Turn yourself in for the night.");
	addButton(1, "Equipment shop", theTrenchEquipmentShop);
	addButton(2, "Food Stand", theTrenchFoodStand);
	addButtonIfTrue(3, "Grayda", theTrenchGraydaQuestNPC, "She's currently in your camp.", flags[kFLAGS.THE_TRENCH_ENTERED] < 15);
	addButton(4, "Loiter", theTrenchLoiter);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}
private function theTrenchMain1():void {
	outputText("The left path seems to lead into multiple different rooms which serve as shared quarters between several individuals per room. While most of the rooms seem to be unoccupied or hosting sleeping Arigeans, you can hear the chatting of a couple individuals behind some of the closed doors.\n\n");
	outputText("The right path seems to lead to a market area which contains multiple different shops or services. It seems like you could find replacement equipment here should you ever happen to lose the clothing Grayda gifted you. A heavenly smell of roasted meat seems to waft from some sort of food shop from down there.\n\n");
	outputText("The central path leads down towards a common area in which you can see several Arigeans lounging, reading or simply just conversing with each other. You can see Grayda holding a few papers while talking with two Arigeans who possess a red and black coloring, which seems to be a uncommon coloring many of the individuals here possess.\n\n");
}
private function theTrenchQuarters():void {
	clearOutput();
	outputText("Grayda did give you permission to rest here as long as you needed, surely she wouldn’t mind if you slept in one of the empty rooms for a bit? Walking down the path on your left eventually leads you to a series of doors, some open, some closed, checking each of the rooms as you pass you notice that there seems to be an unoccupied room near the end of the hallway.\n\n");
	if (rand(10) == 0) {
		outputText("Standing in the doorway you count roughly 5 individuals all lying on the floor in minimal clothing, almost piled on top of each other, much to your surprise they aren’t having an orgy, but instead are all sleeping curled up together, is this a common occurrence here? However you soon realize you’ve been spacing off staring at the scene, and a feeling of drowsiness is dragging at your eyelids as they begin to feel heavy, surely they wouldn’t mind one more joining in, right?\n\n");
		outputText(""+(player.isNaked() ? "Y":"Stripping off your [armor] into a neat pile y")+"ou kneel down while carefully, quietly and deftly move to place your head upon a soft pair of thighs as you slowly rest your body on the floor. Luckily for you this doesn’t visibly wake anyone up, and you allow yourself to fall into a deep comfortable sleep as you feel a pair of arms wrap around you from behind.\n\n");
		outputText("Waking up a couple of hours later, you realize you somehow got yourself in the center of the pile, with one individual seeming intertwined with you, and face first in your cleavage. You remorsefully, but gently pry yourself free from the pile and redress before heading back off to camp.\n\n");
	}
	else {
		outputText("Standing at the doorway you see that the room is somewhat furnished, only possessing a set of beds and a table with chairs near the center, however other that it’s empty with no signs of anyone having claimed it for their own. Closing the door behind you, you walk towards one of the beds, and begin dressing out of your [armor] leaving it folded on the table.\n\n");
		outputText("Giving your body a few stretches, you collapse onto the bed, and retreat into the covers your ");
		if (player.tailType == Tail.ARIGEAN_PRINCESS) outputText("large extra mouth hanging off the bed due to its massive size");
		else if (player.tailType == Tail.ARIGEAN_RED || player.tailType == Tail.ARIGEAN_YELLOW) outputText("symbiotic friend wrapping itself around your waist to stay close to the warmth your body offers");
		else outputText("parasitic partner partner wrapping itself around your waist to stay close to the warmth your body offers");
		outputText(", and before long you’ve drifted off to the sweet bliss of sleep.\n\n");
	}
	camp.cheatSleepUntilMorning();
	doNext(theTrenchMain);
}
private function theTrenchEquipmentShop():void {
	clearOutput();
	if (player.statusEffectv3(StatusEffects.Trench) == 0) {
		outputText("You follow the right path down to where most of the shops are, what catches your attention however is a small building with a large amount of crates resting outside the exterior. If you were to take a guess, this is where you can buy new equipment.\n\n");
		outputText("Entering the shop you're greeted with the sight of a woman carrying a large crate with a pair of oversized gauntlets, placing the crate down, and simply ripping off the lid before grabbing a few spears and carrying them with her somewhere towards the back. Returning up to the front, her glowing red eyes make direct contact with yours before she marches up to you.\n\n");
		outputText("\"<i>I don’t believe... i’ve seen you before… Are you new here?</i>\" her voice is calm and spaced in sections, but just like her face, doesn’t seem to hold very much emotion. \"<i>Let me… make one thing clear… we don’t give out… free replacements… resources are too strict…</i>\"\n\n");
		player.addStatusValue(StatusEffects.Trench, 3, 1);
	}
	outputText("You ask the shopkeeper what her selection is.\n\n");
	outputText("\"<i>Here is what’s… in stock…</i>\"\n\n");
	menu();
	addButton(0, "AN-CU", theTrenchEquipmentShopArigeanNeClassUniform).hint("Arigean Ne-Class Uniform");
	addButton(1, "A.Club", theTrenchEquipmentShopArigeanClub).hint("Arigean Club");
	addButton(2, "A.Spear", theTrenchEquipmentShopArigeanSpear).hint("Arigean Spear");
	addButtonIfTrue(3, "P.Regalia", theTrenchEquipmentShopPrincessRegalia, "Req. finished Coronbation quest.", player.tailType == Tail.ARIGEAN_PRINCESS);
	addButton(14, "Back", theTrenchMain);
}
private function theTrenchEquipmentShopArigeanNeClassUniform():void {
	outputText("\"<i>This uniform is waterproof… and should fit your… body type well too. You might find… that it will help… with some of your… more natural abilities. i’ll provide… one for 720 gems… we don’t make them… here and rely on… supplies from the north.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchEquipmentShopBuy,armors.ANE_UNI), theTrenchEquipmentShop);
}
private function theTrenchEquipmentShopArigeanClub():void {
	outputText("\"<i>Don't look at me… funny… we all need something... when our mana drops...below... I'll part with it… for 880 gems.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchEquipmentShopBuy,weapons.ARICLUB), theTrenchEquipmentShop);
}
private function theTrenchEquipmentShopArigeanSpear():void {
	outputText("\"<i>A weapon is… a weapon… you’ll find it hits… much harder the lower… your magical energy is… I can provide one for...  1040 gems… as it’s a spear… it should pierce armor… and flesh quite easily.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchEquipmentShopBuy,weapons.ARI_SPR), theTrenchEquipmentShop);
}
private function theTrenchEquipmentShopPrincessRegalia():void {
	outputText("\"<i>Princess… did you lose your… regalia? Don’t worry… we can request… a new one to… be made… but it won’t… be cheap... prepare… yourself for a scolding… from your fellow princesses… up north…</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchEquipmentShopBuy,armors.P_REGAL), theTrenchEquipmentShop);
}
public function theTrenchEquipmentShopBuy(itype:ItemType):void {
	clearOutput();
	if(player.gems >= itype.value){
		player.gems -= itype.value;
		statScreenRefresh();
		inventory.takeItem(itype, theTrenchEquipmentShop);
	}
	else{
		outputText("You can't afford this!")
		doNext(theTrenchEquipmentShop);
	}

}
private function theTrenchFoodStand():void {
	clearOutput();
	outputText("Attracted to the smell of cooked meat, you allow your nose to lead the way to the marketing section.");
	if (player.statusEffectv2(StatusEffects.Trench) == 0) {
		outputText(" Thanks to the efforts of your nose, and additional partner, you find your way to the source, which is a stand housing various hanging meats, and a few metal ingots presented in a fashion one might expect to find fruit, however the owner of the shop doesn’t seem to be currently present.\n\n");
		outputText("Or at first sight it doesn't! A massive woman with giant chitin-like clawed hands turns from her current activity of cutting a section of meat to you. Her glowing red eyes, single horn and red vein like markings on her skin do an effective job at intimidating you, however her and her plus one both seem to be missing the natural armor your kind normally possess, and her skin lacking any sort of muscle definition.\n\n");
		outputText("\"<i>Ah~ has my cooking attracted a new customer?</i>\" she sits down on her knees to attempt to be at the same level as you. \"<i>Awww, you're sooo cute! Are you new around here? I surely would have remembered a cute face like yours~</i>\" one of her pale, clawed hands seems to reach and gently pinch your cheek.\n\n");
		outputText("\"<i>I actually was wondering what you serve here?</i>\" you attempt to say as you struggle to remove her talons from your cheeks.\n\n");
		outputText("\"<i>Ah! I sell freshly hunted meats, seafood and metal ingots!</i>\"\n\n");
		outputText("\"<i>Metal?</i>\"\n\n");
		outputText("\"<i>You haven’t tried it yet? Metals are quite critical for an Arigean to remain healthy, you shouldn’t have any issues chewing it up, and digesting it too.</i>\" As if to put emphasis on her point, she picks up what looks like an iron ingot before taking a large bite out of it, and swallowing while showing you a toothy smile. \"<i>See? Perfectly safe.</i>\"");
		player.addStatusValue(StatusEffects.Trench, 2, 1);
	}
	outputText("\n\n\"<i>So what can I get you cutie?</i>\"\n\n");
	menu();
	addButton(0, "SF", theTrenchFoodStandCoelacanthJerky).hint("Stomiidae fillet");
	addButton(1, "CS", theTrenchFoodStandCalamariSteak).hint("Calamari Steak");
	addButton(2, "CJ", theTrenchFoodStandCoelacanthJerky).hint("Coelacanth Jerky");
	addButton(5, "SII", theTrenchFoodStandSoftIronIngot).hint("Soft Iron Ingot");
	addButton(6, "LBB", theTrenchFoodStandLightBronzeBar).hint("Light Bronze Bar")
	addButton(7, "EAI", theTrenchFoodStandEbonbloomAlloyIngot).hint("Ebonbloom Alloy Ingot")
	addButton(14, "Back", theTrenchMain);
}
private function theTrenchFoodStandStomiidaeFillet():void {
	outputText("\"<i>Stomiidae aren’t very big, But they are easy for us to catch down here, and even if they are a bit freaky, they do taste good! 10 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.SFILLET), theTrenchFoodStand);
}
private function theTrenchFoodStandCalamariSteak():void {
	outputText("\"<i>Squid seem to like hiding down here during the daylight, so while finding them is easy, catching them can be a bit tricky. 15 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.C_STEAK), theTrenchFoodStand);
}
private function theTrenchFoodStandCoelacanthJerky():void {
	outputText("\"<i>Coelacanth normally don’t taste very great, but they are slow, big and get some nice flavoring with a bit of salt. 5 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.C_JERKY), theTrenchFoodStand);
}
private function theTrenchFoodStandSoftIronIngot():void {
	outputText("\"<i>Ah, soft iron~ My personal favorite! You’ll find it’s soft and easy to chew on the go, and your body will go straight to work on healing itself with the extra nutrients, it’s also pretty decent stomach filler too! 70 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.SIINGOT), theTrenchFoodStand);
}
private function theTrenchFoodStandLightBronzeBar():void {
	outputText("\"<i>Light Bronze? It’s a bit chewy, but with the extra nutrients your body should have an easy time resisting illness, and poisons! Apparently it can also help you shrug off magical attacks, but they still hurt. 120 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.L_B_BAR), theTrenchFoodStand);
}
private function theTrenchFoodStandEbonbloomAlloyIngot():void {
	outputText("\"<i>mmm~ Ebonbloom~ it’s pretty hard to come by, so it’s mixed in with other metals to make a decent amount for processing to be consumed. It’s tough, and bitter at first, but has a pretty amazing aftertaste, and does wonders for you and your symbiote friend! 200 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.EAINGOT), theTrenchFoodStand);
}
public function theTrenchFoodStandBuy(itype:ItemType):void {
	clearOutput();
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, theTrenchFoodStand);
}
private function theTrenchGraydaQuestNPC():void {
	clearOutput();
	outputText("You walk through the commons and approach Grayda, who turns her attention towards you, as the two she was talking to wander off to fulfill whatever tasks they've been assigned.\n\n");
	outputText("\"<i>Is there something I can help you with [name]?</i>\" her glowing yellow eyes inquisitively looking you over.\n\n");
	menu();
	addButton(1, "Appearance", theTrenchGraydaQuestNPCAppearance);
	addButton(2, "Talk", theTrenchGraydaQuestNPCTalk);
	addButton(3, "Missions", theTrenchGraydaQuestNPCMissions);
	addButton(14, "Back", theTrenchMain);
}
private function theTrenchGraydaQuestNPCAppearance():void {
	clearOutput();
	outputText("Grayda is a 6ft 3in Arigean Countess, and currently the one in charge of the individuals of ‘The Trench’. Her height is increased even further by the large hat-like symbiote which rests on her waist-long white hair, four light gray tentacles hang limply from the organism. Her two glowing yellow eyes are often filled with a steadfast, or determined gleam. Her face, adorned with near albino skin, normally retains a neutral look.\n\n");
	outputText("Grayda’s body is nearly identical to that of a human’s, save for her legs which are covered up to her hips in natural, black metal armor. Her proportions are fairly normal for what one would expect from a human with a pair of C cup breasts, however her body does seem to have some muscle definition. She normally wears what appears to be a white one-piece swimsuit, a pair of gloves, boots and a dark gray cloak which is attached to a jaw-like piece of collar armor.\n\n");
	outputText("A soft, black, and yellow haze seems to occasionally be exhaled from her symbiotic partner, which clings to her skin. It intensifies when she’s angered or in combat, effectively giving her a protective layer of mist to help mask her movement, and appearance.\n\n");
	outputText("She confidently wields a dark metal staff with a bladed end, effectively allowing her to have a weapon to defend herself for close quarters, and to help cast spells.\n\n");
	outputText("\"<i>[name]? Are you alright? You’re spacing off again.</i>\"\n\n");
	doNext(theTrenchGraydaQuestNPC);
}
private function theTrenchGraydaQuestNPCTalk():void {
	clearOutput();
	outputText("You ask Grayda if she wouldn’t mind answering some of your questions.\n\n");
	outputText("\"<i>I don’t have any tasks that I need to complete currently, so I don’t mind. What would you like to discuss?</i>\"\n\n");
	menu();
	addButton(1, "Arigeans", theTrenchGraydaQuestNPCTalkArigeans);
	addButton(2, "Coloring", theTrenchGraydaQuestNPCTalkColoring);
	addButton(3, "Magic", theTrenchGraydaQuestNPCTalkMagic);
	addButton(6, "Her", theTrenchGraydaQuestNPCTalkHer);
	addButton(7, "Outsiders", theTrenchGraydaQuestNPCTalkOutsiders);
	addButton(8, "North", theTrenchGraydaQuestNPCTalkNorth);
	addButton(14, "Back", theTrenchGraydaQuestNPC);
}
private function theTrenchGraydaQuestNPCTalkArigeans():void {
	clearOutput();
	outputText("\"<i>So you wish to know more about our kind? Very well, I will divulge what I know, but there is still much I don’t even know.</i>\" She walks over to a nearby table and pulls out a chair gesturing for you to sit with her.\n\n");
	outputText("\"<i>So let’s start with the basics, Arigeans are not one being, but two, surely you know this by now. however you and your ‘Partner’ will have an effect on each other, by now you’ve noticed the more obvious physical ones that allow you to be a better host, but there are more subtle ones which may not be so apparent yet.</i>\"\n\n");
	outputText("\"<i>Could you be more blunt?</i>\"\n\n");
	outputText("\"<i>Your body and ‘Partner’ may still be undergoing unpredictable changes, This is why Arigeans are so diverse in appearance.</i>\"\n\n");
	outputText("Looking back on the Arigeans you’ve seen so far, or even the ones currently in the commons, it would explain the wide diversity. There’s even one who’s ‘Partner’ looks like a giant naga tail with a mouth attached to the end. \"<i>Where do Arigeans originate from? Surely not Mareth since their numbers are so low.</i>\"\n\n");
	outputText("She rests her chin on her hand as she closes her eyes for a few moments. \"<i>This would be something I don’t know, maybe one of the two princesses up north would. What I do know however is that they do originate from Mareth.</i>\"\n\n");
	doNext(theTrenchGraydaQuestNPCTalk);
	advanceMinutes(5);
}
private function theTrenchGraydaQuestNPCTalkColoring():void {
	clearOutput();
	outputText("You’ve noticed how many individuals here seem to share a red coloring while she herself has a yellow coloring, is there a reason for this?\n\n");
	outputText("\"<i>Colors signify rank, the higher rank an Arigean is, the stronger, and more durable they are. Higher ranks tend to be able to order around lower ranks, if I ");
	if (player.tailType == Tail.ARIGEAN_GREEN) outputText("were to ask you to give me a massage, you would probably feel compelled to fulfill that order.");
	if (player.tailType == Tail.ARIGEAN_RED) outputText("were to order you to strip and patrol the trench nude, you would most likely fulfill that order without hesitation.");
	if (player.tailType == Tail.ARIGEAN_YELLOW) outputText("could order you to do something, but since we’re the same rank, it would be entirely up to your choice.");
	outputText("</i>\"\n\n");
	outputText("\"<i>How many ranks are there?</i>\"\n\n");
	outputText("\"<i>There’s Recruits which possess green markings, Elites who possess red markings, Countesses who are marked yellow, and princesses who are marked blue, and often take on exotic forms.</i>\"\n\n");
	outputText("\"<i>Princesses?</i>\"\n\n");
	outputText("\"<i>Princesses are like leaders for our race, and while they are the strongest, and most durable of our kind, not everyone is naturally capable of becoming one, and fewer are strong enough to reach the point where they would become one. However, with such strengths come many drawbacks, mainly one’s humanity as they permanently fuse with their symbiote. Becoming a princess is something one must do willingly, as it can’t be forced.</i>\"\n\n");
	doNext(theTrenchGraydaQuestNPCTalk);
	advanceMinutes(5);
}
private function theTrenchGraydaQuestNPCTalkMagic():void {
	clearOutput();
	outputText("You ask how Arigeans are able to naturally use magic despite them not casting or chanting any spells.\n\n");
	outputText("She summons one of her bird-like constructs, which fizzles as it perches itself on her finger, before being unable to hold it’s shape any longer and fizzling out of existence. \"<i>It varies depending on your type, however universally it’s not as refined as the magic the Land Walkers use. you see, my magic works first by a mental reconstruction within my brain, which then gets made real with mana by my Symbiote, it will then process…</i>\"\n\n");
	outputText("\"<i>I don’t know what you're saying!</i>\"\n\n");
	outputText("\"<i>It’s unstable as it’s made of raw mana, and like an illusion that can cause harm. Normally they don’t last for very long, so there’s only so far you can strike from with it. However, it seems yours works completely different, as it’s just an unstable bolt of raw uncontrolled mana.</i>\" Without much of a warning, she reaches for one of your "+(player.tailType == Tail.ARIGEAN_GREEN ? "parasite":"symbiote")+"’s heads, (and holds it steady with a firm grasp.\n\n");
	outputText("Her hands quickly get to work scratching the underside of the head, which earns squirming from your other, and a moan from you, however, this goes seemingly unnoticed as she quickly gets the result she wanted from one of your ‘tails’, which was a weak huff of raw mana.\n\n");
	outputText("\"<i>Seems like you might be capable of more, but I'm not sure if I can help you with that at all.</i>\" She releases her grasp as your ‘partner’ quickly retreats behind you.\n\n");
	doNext(theTrenchGraydaQuestNPCTalk);
	advanceMinutes(5);
}
private function theTrenchGraydaQuestNPCTalkHer():void {
	clearOutput();
	outputText("You ask what she was like before she became an Arigean.\n\n");
	if (player.tailType == Tail.ARIGEAN_GREEN) outputText("\"<i>...Recruit, I am not like the beings of the surface, down here it is considered highly rude to indulge oneself in other people’s lives only after the first meeting, I forgive you as you most likely have not known, but do not do this again until we know each other better, recruit.</i>\"\n\n");
	if (player.tailType == Tail.ARIGEAN_RED) outputText("\"<i>mmm…</i>\" she shuffles a bit as she puts a hand under her chin. This is clearly a subject she doesn’t enjoy remembering, or talking about. \"<i>I… Was simply someone who was at the wrong place, at the wrong time. Nothing more.</i>\"\n\n");
	if (player.tailType == Tail.ARIGEAN_YELLOW) {
		outputText("\"<i>I… guess you’ve been around long enough for me to put some trust in you, just give me a moment. I don’t find this easy.</i>\" Taking a seat, she pulls out a flask and takes a small sip from it before re-hiding it somewhere in her cloak. \"<i>Déanann alcól rudaí i gcónaí níos fearr… much better.</i>\"\n\n");
		outputText("You take a seat by her, and patiently wait for her to start her story of what she was like before.\n\n");
		outputText("\"<i>Let’s see…</i>\" she seems to almost space out, lost in thought. \"<i>Me and my sister used to be a part of a line of sailors, and we used to live a calm life almost entirely free from the corruption that plagued the land. However… our peace could not last forever, and the threat of being found by demons was becoming too great to ignore, so we stockpiled supplies, and tried to sail away from the mainland with a few close friends, family, and anyone who was willing to contribute.</i>\"\n\n");
		outputText("Her glowing yellow eyes seem to dim to a low amber as she grabs, and takes another sip from her concealed flask. \"<i>It was all going well, we had enough supplies to last us a while… until a violent storm started hounding at our ship, and left us in a very poor condition, but that wasn’t the worst of it. One of those fanatic ‘Sea Witches’ attempted to attack our boat while turning us against each other.</i>\"\n\n");
		outputText("Her eyes lose all of their glow, leaving them as nothing but milky white with a faint brown coloring where her irises should be, and a frown appears on her face as watery drops start to fall from her eyes. \"<i>I… was knocked overboard during the attack, and in my weakened state was unable to stay above the water.. Before I was about to pass out from a lack of air, this...</i>\" she pats the hat-like organism on her head in an affectionate manner. \"<i>It saved me from drowning by allowing me to breathe again… however there were no remains among the wreckage of the ship when I checked it. Meaning almost everyone I knew was most likely dead or turned into more fanatics.</i>\"\n\n");
		outputText("She takes a long gulp of whatever the continents of the flask were, before returning the empty container to her cloak for a final time, a flush of blue on her cheeks makes it quite obvious as to what the contents were. \"<i>I'm not sure how long I stayed there, unable to move… to live with the reality that was forced upon me… eventually I couldn't remain conscious and collapsed from exhaustion. However, when I woke up, I was somewhere different, as well as something I wasn't before, but the thing that mattered most to me was the desire to grow stronger. I wanted revenge, I would become a one-woman army if it meant finally being able to catch the one who caused so much ruin in a day.</i>\"\n\n");
		outputText("She leans back into her chair and takes a deep breath before continuing. \"<i>But that was all so long ago, and I was much too young to have a proper understanding of how the world works. So for now, my duty is leading those here and keeping them safe.</i>\" Her eyes regain their glow as she seems to return to her normal attitude.\n\n");
	}
	doNext(theTrenchGraydaQuestNPCTalk);
	advanceMinutes(5);
}
private function theTrenchGraydaQuestNPCTalkOutsiders():void {
	clearOutput();
	outputText("You ask Grayda about why they seem so secretive and aggressive when it comes to outsiders.\n\n");
	outputText("\"<i>There are… various reasons as to why we don’t mix too well with the beings on the surface, but it mainly comes from mutual distrust. Surface dwellers seem quick to sell each other out or betray each other if it benefits them, however, this lack of mistrust stems both ways as the surface dwellers seem quick to associate us with the demons due to our… unique appearance. That and our appetites can be seen as a hindrance to the safety of the land walkers.</i>\"\n\n");
	outputText("\"<i>Would peace ever be possible?</i>\"\n\n");
	outputText("She closes her eyes as she takes a moment to think. \"<i>Maybe, but there will certainly always be friction. After all, the only reason why so many races seem to be working together currently is because of the demons. If they were dealt with or simply succeeded in corrupting everything, I could guarantee there would still be conflict regardless.</i>\"\n\n");
	outputText("\"<i>Are there any other races down in the depths of Mareth?</i>\"\n\n");
	outputText("\"<i>Certainly, however, our encounters rarely ever end with both sides pleased. Especially Mindbreakers. A princess might have no problem dealing with them, but most of our kind are quite vulnerable to mental trickery, and they seem hellbent on removing us from the picture. That doesn’t mean we’re intent on shutting ourselves off from other races; however, some of our more friendly hunters even trade with a few daring individuals who don’t seem afraid of us.</i>\"\n\n");
	doNext(theTrenchGraydaQuestNPCTalk);
	advanceMinutes(5);
}
private function theTrenchGraydaQuestNPCTalkNorth():void {
	clearOutput();
	outputText("You keep hearing mention of something up north, is there something there?\n\n");
	outputText("\"<i>That would be our other and primary settlement, most of the individuals here moved from our primary settlement by order of the princesses to help keep us spaced out in case one of our settlements were discovered and attacked.</i>\" She holds up her staff with both hands to give you a clear look at it. \"<i>Most of our tools or clothing are actually made over there, and transported here as we don’t currently have any craftsmen.</i>\"\n\n");
	outputText("Now that you think about it, how did the Arigeans come to create a settlement in the first place?\n\n");
	outputText("\"<i>Most arigeans became outcasts from their original places due to others fearing they were becoming demons, eventually enough of the ‘first generation’ of arigeans gathered up and formed a settlement that started to slowly grow, however, we are a target to other races which lurk in the abysses of Mareth.</i>\"\n\n");
	outputText("\"<i>First-generation?</i>\"\n\n");
	outputText("\"<i>I don’t have any tasks that I need to complete currently, so I don’t mind. What would you like to discuss?</i>\"\n\n");
	outputText("She presents a small smile with a slight chuckle. \"<i>Unfortunately this is something I don’t know much about, and it could even just be a bit of arigean folklore. Apparently, the first few arigeans all shared one thing in common, they were all infected by the same woman nicknamed ‘The First’.</i>\"\n\n");
	outputText("The glow of her eyes seems to intensify with a childlike glee before she continues. \"<i>Rumor has it that she was the reincarnated form of a warrior who died at sea, she was also apparently the first-ever Arigean, some even claim the first princess, but no one has ever had a proper meeting with her. Some have claimed to have seen her stalking the depths at night, but she manages to escape every time someone gets too close to get a proper look at her. The only thing most see are her empty blue eyes, glowing in the distance and the faint outline of a woman.</i>\" Her eyes seem to dim to their normal brightness before she attempts to regain her professional stance. \"<i>However, those are just rumors, and nothing else. If there was a first arigean, she’s probably content hiding in silence or is long gone.</i>\"\n\n");
	doNext(theTrenchGraydaQuestNPCTalk);
	advanceMinutes(5);
}
private function theTrenchGraydaQuestNPCMissions():void {
	clearOutput();
	outputText("\"<i>[name] I have a few jobs available if you feel like contributing.</i>\"\n\n");
	menu();
	if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 2) {
		if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 3) addButtonDisabled(0, "Getting Stronger", "You already finished Training Quest 1.");
		else {
			if (player.hasItem(useables.IMPSKLL, 3, true) && player.hasItem(useables.GOBOEAR, 4, true)) addButton(0, "Getting Stronger", theTrenchGraydaQuestNPCMissionsGettingStronger).hint("Training Quest 1");
			else addButtonDisabled(0, "Getting Stronger", "You still need to gather 3 imp skulls and 4 goblin ears.");
		}
	}
	else addButton(0, "Getting Stronger", theTrenchGraydaQuestNPCMissionsGettingStronger).hint("Training Quest 1");
	if (player.level >= 6 && flags[kFLAGS.THE_TRENCH_ENTERED] >= 3) {
		if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 4) {
			if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 5) addButtonDisabled(1, "Proving Yourself", "You already finished Promotion Quest 1.");
			else {
				if (player.hasItem(useables.SEVTENT, 2, true)) addButton(1, "Proving Yourself", theTrenchGraydaQuestNPCMissionsProvingYourself).hint("Promotion Quest 1");
				else addButtonDisabled(1, "Proving Yourself", "You still need to gather 2 severed tentacles.");
			}
		}
		else addButton(1, "Proving Yourself", theTrenchGraydaQuestNPCMissionsProvingYourself).hint("Promotion Quest 1");
	}
	else addButtonDisabled(1, "???", "Req. to finish previous mission and have lvl 6+.");
	if (player.level >= 12 && flags[kFLAGS.THE_TRENCH_ENTERED] >= 5) {
		if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 6) {
			if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 7) addButtonDisabled(2, "Continued Improvement", "You already finished Training Quest 2.");
			else {
				if (player.hasItem(useables.THHTONG, 4, true) && player.hasItem(useables.MINOHOR, 3, true)) addButton(2, "Continued Improvement", theTrenchGraydaQuestNPCMissionsContinuedImprovement).hint("Training Quest 2");
				else addButtonDisabled(2, "Continued Improvement", "You still need to gather 4 hellhound tongues and 3 minotaur horns.");
			}
		}
		else addButton(2, "Continued Improvement", theTrenchGraydaQuestNPCMissionsContinuedImprovement).hint("Training Quest 2");
	}
	else addButtonDisabled(2, "???", "Req. to finish previous mission and have lvl 12+.");
	if (player.level >= 18 && flags[kFLAGS.THE_TRENCH_ENTERED] >= 7) {
		if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 8) addButtonDisabled(3, "Final Appraisal", "You already finished Training Quest 3.");
		else addButton(3, "Final Appraisal", theTrenchGraydaQuestNPCMissionsFinalAppraisal).hint("Training Quest 3");
	}
	else addButtonDisabled(3, "???", "Req. to finish previous mission and have lvl 18+.");
	if (player.level >= 24 && flags[kFLAGS.THE_TRENCH_ENTERED] >= 8) {
		if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 11) addButtonDisabled(4, "Tracking the Monstrosity", "You already finished Promotion Quest 2.");
		else if (flags[kFLAGS.THE_TRENCH_ENTERED] == 9) addButtonDisabled(4, "Tracking the Monstrosity", "You still tracking enemy.");
		else addButton(4, "Tracking the Monstrosity", theTrenchGraydaQuestNPCMissionsTrackingTheMonstrosity).hint("Promotion Quest 2");
	}
	else addButtonDisabled(4, "???", "Req. to finish previous mission and have lvl 24+.");
	if (player.level >= 30 && flags[kFLAGS.THE_TRENCH_ENTERED] >= 12) {
		if (player.hasItem(useables.EBONBLO, 4) && player.hasItem(useables.S_INGOT, 1) && player.hasKeyItem("Liquid Diamond")) addButton(10, "Coronation", theTrenchGraydaQuestNPCMissionsCoronationFinalPart1).hint("IF YOU CLICK THIS BUTTON CHARACTER WILL BECOME PERNAMENTLY ARIGEAN PRINCESS!!!");
		else if (flags[kFLAGS.THE_TRENCH_ENTERED] >= 13 && flags[kFLAGS.THE_TRENCH_ENTERED] < 14) addButtonDisabled(10, "Coronation", "You still need to find: Four Ebonblooms, a Silver ingot and ‘Liquid Diamond’.");
		else addButton(10, "Coronation", theTrenchGraydaQuestNPCMissionsCoronation);
	}
	else addButtonDisabled(10, "???", "Req. to have lvl 30+ and special event triggering at the camp.");
	addButton(14, "Back", theTrenchGraydaQuestNPC);
}
private function theTrenchGraydaQuestNPCMissionsGettingStronger():void {
	clearOutput();
	if (flags[kFLAGS.THE_TRENCH_ENTERED] == 2 && player.hasItem(useables.IMPSKLL, 3, true) && player.hasItem(useables.GOBOEAR, 4, true)) {
		outputText("Grayda looks at the Trophies in your hand and nods.\n\n");
		outputText("\"<i>Well done, [name], you proved you are capable of fighting.</i>\"\n\n");
		player.destroyItems(useables.IMPSKLL, 3, true);
		player.destroyItems(useables.GOBOEAR, 4, true);
		flags[kFLAGS.THE_TRENCH_ENTERED] = 3;
	}
	else {
		outputText("\"<i>[name], as you are a recruit, I must test you to see if you are capable of fighting for our race. Go to the surface and bring back some trophies from well-earned kills. Three imp skulls and four goblin ears should do.</i>\"\n\n");
		flags[kFLAGS.THE_TRENCH_ENTERED] = 2;
	}
	doNext(theTrenchGraydaQuestNPCMissions);
}
private function theTrenchGraydaQuestNPCMissionsProvingYourself():void {
	clearOutput();
	if (flags[kFLAGS.THE_TRENCH_ENTERED] == 4 && player.hasItem(useables.SEVTENT, 2, true)) {
		outputText("You hand the trophies over, which Grayda returns with one of her rare smiles. \"<i>Well done, Recruit! I think you deserve a nice drink as a reward for your efforts.</i>\" She brandishes a bottle with deep crimson contents from seeming somewhere behind her cloak and gently swishes it side to side for emphasis as she offers you.\n\n");
		outputText("You slowly take the offered drink. Although it is suspicious, it’s most likely just wine, and it would be rude to decline such a generous offer from your superior. You pop the cork off as a very sweet scent enters your nose, tempting you to take a sip. But before you give in, you can’t help but give her a questioning glance.\n\n");
		outputText("\"<i>Go on. Drink up.</i>\"\n\n");
		outputText("And without a second thought, you take an experimental sip to find… It's extremely sweet! And the taste is very addicting. Before long you’ve downed the whole bottle with a heat building at your cheeks, Did Grayda always have a twin? ");
		outputText("And were you always this close to the floor, wait… did Grayda... drug you? Before you're able to continue your train of thought you lose your balance and allow the dark to swallow you up.\n\n");
		outputText("You open your eyes, only to be greeted by a blast of light and a throbbing migraine… where are you? You're laying down somewhere, but where?\n\n");
		outputText("\"<i>Finally awake are we?</i>\"\n\n");
		outputText("\"<i>...Yes ma’am.</i>\" are the words that nearly automatically leave your mouth as you slowly attempt to prop yourself up, besides feeling hungover… something feels very wrong. The other person in the unfamiliar room with you is none other than Grayda herself, sitting in a chair reading a book of some sort.\n\n");
		outputText("\"<i>Well I'll leave you to get dressed, surely you don’t plan to sleep any longer than you already have, right? Your equipment should be at the foot of the bed.</i>\" and with that, she leaves the somewhat decently decorated room.\n\n");
		outputText("Only now looking down do you notice that you're completely naked, but that’s not the only thing that draws your attention. A thick black and red haze seems to lightly cling to your skin, it seems to originate from the mouths of your symbiotic partner which has gained red highlights during your time asleep, ");
		outputText("but that doesn’t seem to be all as your skeletal tail has gained a matching color scheme as your symbiotic partner, and a nearby mirror shows your eyes now glow the same color.\n\n");
		outputText("Whatever was in that drink must’ve altered you in such a way, but surely it’s not bad? You feel stronger and more durable than ever! But a voice within you is screaming that something is wrong, but what? And the hangover certainly isn’t helping you figure out what it is.\n\n");
		outputText("Deciding you’ve lingered long enough, you re-equip your gear and leave what you can only assume is Grayda’s room. You could ask her directly what exactly it is she’s done to you, but something about that just feels disrespectful. This definitely seems to be an improvement after all.\n\n");
		transformations.TailArigeanRed.applyEffect(false);
		transformations.RearBodyArigeanAuraRed.applyEffect(false);
		player.destroyItems(useables.SEVTENT, 2, true);
		flags[kFLAGS.THE_TRENCH_ENTERED] = 5;
		player.eyes.colour = "red";
		advanceMinutes(90);
	}
	else {
		outputText("\"<i>I have another task for you Recruit, I need you to hunt down two Tentacle beasts and bring back their severed tentacles as proof. I want to test how clever you are at hunting larger prey, and I promise a nice reward should you return with proof of your victories.</i>\"\n\n");
		flags[kFLAGS.THE_TRENCH_ENTERED] = 4;
	}
	doNext(theTrenchGraydaQuestNPCMissions);
}
private function theTrenchGraydaQuestNPCMissionsContinuedImprovement():void {
	clearOutput();
	if (flags[kFLAGS.THE_TRENCH_ENTERED] == 6 && player.hasItem(useables.THHTONG, 4, true) && player.hasItem(useables.MINOHOR, 3, true)) {
		outputText("Showing your newly acquired ‘prizes’ to Grayda, she returns them with a nod.\n\n");
		outputText("\"<i>Well done Elite, it seems you're still well on the path of improvement.</i>\"\n\n");
		player.destroyItems(useables.THHTONG, 4, true);
		player.destroyItems(useables.MINOHOR, 3, true);
		flags[kFLAGS.THE_TRENCH_ENTERED] = 7;
	}
	else {
		outputText("\"<i>There you are Recruit or should I say Elite? Now that you’ve had some time to adjust to your new form, I want to see how much you’ve improved. Bring me 4 hellhound tongues and 3 minotaur horns, as proof of your conquests.</i>\"\n\n");
		flags[kFLAGS.THE_TRENCH_ENTERED] = 6;
	}
	doNext(theTrenchGraydaQuestNPCMissions);
}
private function theTrenchGraydaQuestNPCMissionsFinalAppraisal():void {
	clearOutput();
	outputText("\"<i>Elite, I can see you’ve drastically improved from the first day we’ve met, and I want to see firsthand how strong you’ve gotten. Win or lose it doesn’t matter, I just want to taste your mettle. Let me know when you're ready to spar.</i>\"\n\n");
	menu();
	addButton(1, "Later", theTrenchGraydaQuestNPCMissions);
	addButton(3, "Spar", theTrenchGraydaQuestNPCMissionsFinalAppraisal2);
}
private function theTrenchGraydaQuestNPCMissionsFinalAppraisal2():void {
	spriteSelect(SpriteDb.s_grayda);
	outputText("\"<i>Very well, we’ll move to the surface for our spar. I don’t want you holding back in the slightest, So show me your full force!</i>\"\n\n");
	startCombat(new Grayda());
}
private function theTrenchGraydaQuestNPCMissionsTrackingTheMonstrosity():void {
	clearOutput();
	if (flags[kFLAGS.THE_TRENCH_ENTERED] == 10) {
		outputText("\"<i>Welcome back Elite, I assume you’ve finished your assignment?</i>\"\n\n");
		outputText("You tell Grayda of the encounter and how she should no longer be a threat to others or herself.\n\n");
		outputText("\"<i>Well done, I understand killing another Arigean might be hard. But you did a good deed putting her out of her misery.</i>\" She seems to take a moment to look at the slightly blue sunburn you’ve gotten from the ordeal. \"<i>Oh yes! Your reward.</i>\" She fishes a Clear glass bottle with amber yellow contents from somewhere inside her cloak, offering it to you.\n\n");
		outputText("Grabbing the bottle, popping off the lid, you almost take a sip before remembering what happened last time Grayda offered you a mystery drink. \n\n");
		outputText("\"<i>Don’t worry, i’ll catch you if you fall. That drink should also make you considerably Stronger.</i>\"\n\n");
		outputText("Well seeing as it didn’t exactly harm you in any way last time. What’s the worst that could happen besides making you stronger? Besides, the scent is quite tempting. Oh wait, it’s already all gone… and here comes your friend, the cold floor.\n\n");
		outputText("As you come back to your consciousness, you don’t even try to open your eyes. You can already feel the intense migraine after all, but after a few minutes of waiting you experimentally open an eye. Seeing as your eye doesn’t sting from the brightness, you decide to quickly open both only to be greeted by the sight of your naked body, and Grayda reading a book while sitting to your side. Gah does your head hurt.\n\n");
		outputText("\"<i>Awake? You were out quite a bit longer this time.</i>\" She hasn’t even seemed to look up from her book. \"<i>I’ll leave you to get dressed.</i>\" Swiftly closing the book and getting up to leave, she immediately stops before closing the door behind her. \"<i>Congratulations on your promotion Countess, you’ve certainly earned the title.</i>\"\n\n");
		outputText("Countess? Does this mean you're now on equal footing as Grayda? From the looks of it you now are. Your highlights seemed to have taken on an amber yellow hue matching those that Grayda possesses, if you were to look in a mirror you would guess that your eyes would have followed the same trend. But maybe that’s enough procrastinating for now, from the sounds of it you’ve been out for a while, and others might be worried for how long you’ve been gone.\n\n");
		outputText("Closing Grayda’s door you find that you’ve accidentally torn off the handle… whoops~ it seems you're now much stronger than you look. Hopefully she’s not too upset by it~\n\n");
		flags[kFLAGS.THE_TRENCH_ENTERED] = 11;
		transformations.TailArigeanYellow.applyEffect(false);
		transformations.RearBodyArigeanAuraYellow.applyEffect(false);
		player.eyes.colour = "yellow";
		advanceMinutes(90);
	}
	else {
		outputText("\"<i>Elite I have a more challenging task for you, if you feel up for it. I promise a very generous reward in return if you're successful.</i>\" Her breath seems heavier than normal and a few scrapes can be seen on her bare arms.\n\n");
		outputText("Curious, you ask what she needs you to get done. It looks like she just got out of a fight with something.\n\n");
		outputText("\"<i>A few months ago, one of our surface hunters disappeared. At first I just assumed she got caught up in another adventure and would be back soon, but she never came back. Well, I was partially right with that guess. Earlier what… I could only assume that at some point, attempted to enter the trench. She was raving like a lunatic and masturbating furiously, she had clearly succumbed to the wretched demons... I was almost able to finish her off, and put her out of her misery, but she fled. I need you to find her, and end her suffering before she is able to harm anyone else.</i>\"\n\n");
		outputText("You ask if there could be any way of easily tracking her. She could’ve gone anywhere.\n\n");
		outputText("\"<i>She couldn’t have gone far. You should start with checking the nearby beaches.</i>\"\n\n");
		flags[kFLAGS.THE_TRENCH_ENTERED] = 9;
	}
	doNext(theTrenchGraydaQuestNPCMissions);
}
private function theTrenchGraydaQuestNPCMissionsCoronation():void {
	clearOutput();
	outputText("As you walk through the base and up to Grayda, multiple Arigeans steer clear of you as if they were able to pick up on your unhappy attitude from the recent agitation.\n\n");
	outputText("\"<i>Can I help you [name]?</i>\" Grayda’s eyes seem to be trying to get a read and maybe a guess as to why you seem so agitated.\n\n");
	outputText("You explain how you’ve been experiencing an intense, painful itching in your eyes and how you noticed the occasional color shift. Grayda’s eyes seem to widen at the last part of your explanation as that sudden itch seems to strike as if to emphasize your situation.\n\n");
	outputText("She roughly takes you by the hand, and very quickly drags you through the halls with you eventually ending up in her room which still seems to be missing the door handle. She quickly shuts the door once you’re inside and shoving you onto her bed as she quickly gets to work on inspecting one of your eyes, forcing your eyelid open.\n\n");
	outputText("You're not sick or something, are you?\n\n");
	outputText("Grayda stays silent for a few agonizing moments before showing you a gentle smile. \"<i>No, you're not ill. It’s just your body’s way of saying that you're ready to become a princess.</i>\" She finishes her sentence with giving you a light pat on the back.\n\n");
	outputText("What?\n\n");
	outputText("\"<i>An Arigean Princess, they’re natural born leaders for our kind, but not just anyone can become one and fewer can reach the point where their bodies are ready. And I won’t lie to you, if you choose to go down this path there is no turning back.</i>\" You find it shocking how her tone went from so friendly to serious at the end there.\n\n");
	outputText("She straightens her back before continuing. \"<i>If you choose to go down this path you’ll bear the burden of leading our kind. This is a choice only you can make however, and I know this might be sudden, but would you be willing to go through with this?</i>\"\n\n");
	menu();
	addButton(1, "No", theTrenchGraydaQuestNPCMissionsCoronationNo);
	addButton(3, "Yes", theTrenchGraydaQuestNPCMissionsCoronationYes).hint("IT LEADS TO PERNAMENT TRANSFORMATION AFTER FINISHING THIS QUEST. ARE YOU SURE YOU WANT CONTINUE?");
}
private function theTrenchGraydaQuestNPCMissionsCoronationNo():void {
	clearOutput();
	outputText("You might need more time to think about this. It’s all too sudden, and a bit overwhelming.\n\n");
	outputText("\"<i>I understand [name]. Please take your time with this decision as it’s quite a big one.</i>\"\n\n");
	doNext(theTrenchGraydaQuestNPCMissions);
}
private function theTrenchGraydaQuestNPCMissionsCoronationYes():void {
	clearOutput();
	outputText("You tell her you feel honored by this opportunity and would love to.\n\n");
	outputText("\"<i>You're certain? There is no going back after this.</i>\"\n\n");
	outputText("You tell her yes you're absolutely sure this is what you want to do. Now, what do you need to do?\n\n");
	outputText("She turns and opens a drawer of the dresser behind her, Grabbing a rope, what looks like a bottle of ink, and a quill. \"<i>I'm going to have to ask that you dress down.</i>\"\n\n");
	outputText("Sliding out of your equipment, you lay back on her bed. You have to be honest, you certainly weren’t expecting to be doing this.\n\n");
	outputText("She gives you a deadpan expression before speaking in her usual serious tone. \"<i>We’re not mating. Now stand up with your arms out before I forcibly beat some sense into you.</i>\"\n\n");
	outputText("Obliging with her request, you follow her instructions as she proceeds to wrap the rope around your hips before marking the rope somewhere where it meets behind you. She repeats this process 3 more times around your waist, chest, and boobs before writing something down on a piece of paper, and putting it into a glass bottle. She grabs another piece of paper, writing a few things down on it, and then handing it to you. It seems to be a list.\n\n");
	outputText("\"<i>Since this is your coronation we’re preparing for, I'm going to need you to grab a few items required for the ceremony. You’ll be needing Four Ebonblooms, a Silver ingot, and something called ‘Liquid Diamond’. You should try looking in caves for the ebonblooms, and Jeweler for the Silver ingot. Unfortunately, I don’t know how to obtain ‘Liquid Diamond’, you can try your luck with merchants however, I doubt surface dwellers have much of a use for it anyway.</i>\"\n\n");
	outputText("She’s just about to leave with the bottled message before stopping at the door. \"<i>And two things; The princesses up north will be here for your coronation. And whatever you don’t drink the Liquid Diamond under any circumstance, it’s poisonous when consumed raw.</i>\" And with those final warnings, she leaves you to get dressed. It seems like you’ve got quite the event to plan for.\n\n");
	flags[kFLAGS.THE_TRENCH_ENTERED] = 13;
	doNext(theTrenchGraydaQuestNPCMissions);
}
private function theTrenchGraydaQuestNPCMissionsCoronationFinalPart1():void {
	clearOutput();
	player.removeKeyItem("Liquid Diamond");
	player.destroyItems(useables.S_INGOT, 1);
	player.destroyItems(useables.EBONBLO, 4);
	outputText("Grayda seems to be waiting for you as you surface into the underwater abode with the required items you were asked to fetch.\n\n");
	outputText("\"<i>There you are. They’ve just arrived, but before we go to meet them I'm going to have to ask you to follow me.</i>\" Only now have you noticed the strange parcel she seems to be holding, but before you can ask about it, she’s already taken you by the hand and started dragging you.\n\n");
	outputText("Eventually, you both end up back in Grayda’s room, with Grayda herself placing the box on her bed before carefully cutting it open to reveal a white and black dress with multiple black metal plates attached at various different parts.\n\n");
	outputText("Taking the still folded dress, she offers it to you. \"<i>This is yours now. Please put it on before we go meet them, I’ll be waiting for you outside, but first, could you hand me the items you gathered?</i>\" Giving her the things she had you go around gathering, she leaves, allowing you to dress in private.\n\n");
	outputText("Surprisingly it fits extremely well, practically hugging your skin save for the areas which are exposed. It opens up in the front starting at your collar and ending above your navel, framed with a darker black cloth. A few stripes around the white dress are black and move are patterned in intricate ways. The sides of your shoulders are also uncovered, and framed by black stripes. The dress seems to have gloves attached to it's sleeves, one being black and the other being fingerless and white. Your dress ends in a skirt with various black, metal stars which seem to act as decorative protection. ");
	outputText("Around your arms are a pair of loose-fitting metal armbands with a crown-like shape. A few more pieces seem to be left in the box which aren’t attached to the dress, which seems to be a black, metal, lower face mask as well as a black tiara with stars on the side. Deciding it would be best to equip these as well, you do so, and finally exit the room with Grayda standing outside as promised.\n\n");
	outputText("Her eyes seem to roam over your body before she speaks. \"<i>It looks good on you, now come on I think we’ve wasted enough time. Please allow me to lead the way.</i>\"\n\n");
	outputText("Following her closely behind you both eventually end up in the commons, which seems to be extremely busy currently. If you were to take a guess you’d say everyone who lives here is currently present and maybe a couple more. However, the pair in the center back draw your attention due to their blue coloring, and intimidating presence. Coincidentally that’s just where Grayda is leading you to.\n\n");
	outputText("She hands you a sack containing the items you gathered before whispering something in your ear. \"<i>You see that pedestal between those two in the center back? You're going to mix those items you gathered in the bowl there, and drink it up after talking to them, Clear</i>\"\n\n");
	outputText("You tell her that yes you understand and proceed to greet the two in the back. The one on the left seems to possess extremely long white hair and a long white dress to match, and a few black metal shards seem to stick out of various parts of her body, completely covering her right eye, the other seemingly judging you for every action you do.\n\n");
	outputText("The other on the right seems to be wearing a tight-fitting dress which shows off her busty figure. Two symbiotic partners seem to sprout from the rear of her hips, acting extremely similar to your own. Her white hair seems to cover her left eye, and she also is adorned with a strange, lopsided, crest-like crown. Her eye seem to be practically bathing in every inch of skin you show.\n\n");
	outputText("\"<i>So you're the new blood Grayda was talking about? You must be something special to rise through the ranks this quickly.</i>\" The one on the right bluntly remarks in an aggressive tone.\n\n");
	outputText("\"<i>Aww, go easy on the girl. She’s about to become a princess, after all, surely she has more experience than you're giving her credit for.</i>\"\n\n");
	outputText("\"<i>Very well then ‘Princess’. Let’s get this over with.</i>\" She gestures you forth to the bowl on the pedestal.\n\n");
	outputText("Now you just mix up what you gathered, right? That doesn’t sound all too hard. Noticeably all the chatter in the room goes silent as you proceed to start creating the supposed mixture, starting with the liquid diamond, then sprinkling in the ebonblooms, which seem to quickly erode and caused the liquid to take on a dark gray, and lastly the silver ingot which almost immediately dissolves while turning the fluid into a bioluminescent blue. Strangely enough, the liquid smells scentless if not a bit smokey.\n\n");
	outputText("You carefully and slowly lift the bowl and proceed to start consuming the contents. At first, it tastes almost indescribably pleasant, however once it’s all down a burning sensation grips at your throat as you start to breathe heavily. You lean on the pedestal for support as that burning feeling seems to spread throughout your entire body as it devolves into an unbearable, bone-breaking pain, and you quickly start losing your senses one by one before blacking out from the pain.\n\n");
	outputText("W-where? Where are you? Are the only thoughts you are able to muster as you look around the ruined barracks. Oh right, you were resting in your assigned room with your ‘sisters’ A-6 and D-4 before an explosion went off somewhere outside. If you were to take a guess, You got knocked unconscious while your ‘siblings’ went off to fight whatever the threat was. After all, that’s the reason why you, your ‘sisters’ and the other Árthach Homunculi were created.\n\n");
	outputText("Exiting your designated resting place, you're greeted by the sight of your beloved city rapidly flooding, clearly whatever fight happened was one you already lost. Collapsing to your knees you can’t help, but just stare at the sight of your falling city. It was your duty to protect its walls and it's people, and you’ve already failed without even being given a chance.\n\n");
	outputText("You slam your armored fist into the ground, cracking the stone. This can’t be it, can it? Surely there are still survivors out there who need help, and what about your dear sisters? Surely they didn’t all perish, but what’s the point of trying to get them to safety if you're all trapped miles below the ocean?\n\n");
	outputText("You slap yourself in the face with both of your hands. Get a grip on yourself B-8! Something about this situation seems very wrong, the entire city is absolutely silent, and you’ve yet to see a single body anywhere. Maybe they were able to get to safety? But then why would your sisters just leave you behi-\n\n");
	outputText("Suddenly a powerful blast hits you square in the back, knocking you off the ground, and slamming you into a nearby wall with a sickening crunch as a piece of debris falls off the building onto your ribs, your body doesn’t want to respond to orders as you and your armored extra limbs just lay limply on the ground as pain fills your every nerve. A slick tentacle seems to lift your broken body, and facing you towards your aggressor.\n\n");
	outputText("Where this humanoid creature’s legs would be, instead are a mass of tentacles, and instead of hair, possesses many tentacles with more eyes than any being should have. Her curvy figure seems to sway as she lightly shakes your broken form around.\n\n");
	outputText("\"<i>My my my, it seems we almost missed one.</i>\" Her voice seems to taunt you as she seems to move one of her tentacles towards your metal adorned ear. \"<i>I'm going to have fun breaking you~</i>\" and before you can even resist it’s plunged into your mind.\n\n");
	outputText("She proceeds to fuck both your body and mind for what feels like hours, all the while you're in some delirious haze as your mouth sings words that aren’t yours after each of the countless orgasms your quickly corrupting body experiences. Eventually, your internal injuries and presumably many broken bones become too much for your body to handle, and your heart slowly comes to a halt.\n\n");
	outputText("\"<i>Eh? Did I play with my toy too hard? Dammit! I didn’t even get to wrap her into the fold.</i>\" She tosses your limp, cold body to the side.\n\n");
	outputText("It hurts… so much…\n\n");
	outputText("Your consciousness slowly comes to halt as your body feels like it’s overloading with foul otherworldly magic. However, before you slip into the dark, you're able to see a light blue glow emanating from where your heart used to beat, spreading an icy cold sensation to every part it touches.\n\n");
	if (player.hasPerk(PerkLib.RacialParagon)) flags[kFLAGS.APEX_SELECTED_RACE] = Races.ARIGEAN;
	IMutationsLib.ArigeanAssociationCortexIM.trueMutation = true;
	player.removeAllRacialMutation();
	player.tailType = Tail.ARIGEAN_PRINCESS;
	player.rearBody.type = RearBody.ARIGEAN_PINCER_LIMBS;
	player.eyes.type = Eyes.ARIGEANPRINCESS;
	player.eyes.colour = "blue";
	player.createPerk(PerkLib.AlteredAnima, 0, 0, 0, 0);
	player.createPerk(PerkLib.ArigeanKnowledge, 0, 0, 0, 0);
	player.createPerk(PerkLib.TransformationImmunity2, 8, 0, 0, 0);
	doNext(theTrenchGraydaQuestNPCMissionsCoronationFinalPart2);
}
private function theTrenchGraydaQuestNPCMissionsCoronationFinalPart2():void {
	clearOutput();
	outputText("\"<i>...Princ-... tartin… sti…</i>\"\n\n");
	outputText("Your senses feel like their beginning to come back to you. You feel like you’ve been wrapped in a blanket, and it sounds like a voice seems to be calling out to you.\n\n");
	outputText("\"<i>Awww, can’t I cuddle her for just a bit longer?</i>\"\n\n");
	outputText("\"<i>I would prefer if you allowed her some space, Princess.</i>\"\n\n");
	outputText("Was that Grayda? Maybe you should try opening your eyes to see what’s going on. But you feel so warm and cozy, you could stay here for an eternity.\n\n");
	outputText("\"<i>Alice? What in the twelve hells are you doing with her?!</i>\" a rather coarse and aggressive voice seems to have entered the room, something about it seems somewhat familiar, but everything still feels hazy and surreal.\n\n");
	outputText("\"<i>Am I not allowed to have a little fun with the new-blood? It feels like having a little sister, just look how cute she is!</i>\" you can feel her lightly pinch your cheek.\n\n");
	outputText("The situation feels like it’s becoming much more real. This isn’t a blanket wrapped around you! It’s someone! Opening your eyes you notice at least 3 other people in the room; The princess with the crown who seems to be wrapped around your smaller body, Grayda who seems to be trying to get you out of the grasps of the said princess, and the princess who’s missing an eye, she seems to have her other princess quite literally by the tail.\n\n");
	outputText("\"<i>W-Wait! Let go of my tail! I swear I’ll stop!</i>\"\n\n");
	outputText("\"<i>If you're going to act like a cuddle slut then expect to be treated like a cuddle slut</i>\" She yanks her companion by the tail, causing her to fall off the bed and onto the floor.\n\n");
	outputText("\"<i>N-No please! I'm sorry! No WA-</i>\" her screams are cut short as she’s dragged out of the room with the door slamming behind her, leaving only you and Grayda.\n\n");
	outputText("Grayda turns her yellow orbs from the door onto you before speaking. \"<i>How are you feeling, my princess?</i>\"\n\n");
	outputText("You can’t help but repeat the last word of her sentence. Princess?\n\n");
	outputText("Her eyes seem to slightly widen. \"<i>Have you forgotten about what has occurred? You were named the new southern Princess of the trench. Surely you’ve noticed by now how you’ve changed.</i>\"\n\n");
	outputText("To be honest, your memory of the event feels quite hazy, but you suppose that more has to do with you blacking out. But looking over your body a feeling of shock and awe overtakes you at the new glorious changes. Your tails seem to have merged into an intimidating extra lipless maw with bioluminescent blue highlights, it looks as though it can be easily rested upon. A pair of crab-like claws sprout from near the base of your tail which are coated in a black metal armor. It seems your aura has dissipated, but your extra maw seems to occasionally exhale a dark blue haze every so often. On top of your body feeling sore, it also feels significantly stronger, but your head feels like it’s been split in half and taped together.\n\n");
	outputText("\"<i>If you’d like, my princess, I could share my room with you until we make your own private chambers.</i>\"\n\n");
	outputText("Here? You pause for a moment as you try to think of how to explain this to her. Your currently duty-bound to guarding a portal to your homeland on the surface, you, by all means, can’t leave it unguarded.\n\n");
	outputText("Before Grayda can even begin to speak, a pair of disheveled princesses re-enter the room. With the more bubbly of the pair speaking up first.\n\n");
	outputText("\"<i>You're also from another world?</i>\" she pauses before closing her eyes and humming for a couple of seconds before snapping her fingers. \"<i>This could be a perfect opportunity for us to get a decent piece of territory on the surface! Grayda! You are to act as the new-blood's loyal retainer and join her on the surface to establish a decent settlement!</i>\"\n\n");
	outputText("\"<i>W-Wait isn’t this a bit sudden? What of the Arigeans here? Who will lead them?</i>\"\n\n");
	outputText("The other princess seems to catch on to her companion's train of thought. \"<i>Don’t worry. We’ll assign another Countess to overlook those here. Now get going, we’ll handle the ordeals here, and new-blood! This is an opportunity to prove yourself.</i>\" Before you can protest their sudden orders, they are already gone.\n\n");
	outputText("Grayda turns toward you before letting out a short sigh. \"<i>My apologies Princess, but it seems I’ll be staying with you for a while. Would you mind if I asked if you could help me pack?</i>\"\n\n");
	outputText("One long walk later and a few stops has you successfully returned to camp with Grayda in tow. Mayhaps it would be a good idea to show her around, and introduce her to everyone?\n\n");
	if (player.hasStatusEffect(StatusEffects.PureCampJojo) && flags[kFLAGS.JOJO_BIMBO_STATE] != 3) {
		outputText("Before you can even continue with that thought, you feel something land and hit you square in the chest, effectively stealing the air from your very lungs.\n\n");
		outputText("\"<i>[name]? I'm so sorry! Are you alright?</i>\" Jojo seems to have been your aggressor, but honestly, you're still in a bit of shock from the sudden attack.\n\n");
		outputText("You gently tell him that you're alright and try to give him a smile, but he’s looking at you as if you just told him the grass was purple.\n\n");
		outputText("He gives you a wary look before speaking. \"<i>Very well [name]... but you reek of corruption. I would suggest joining me in meditating soon.</i>\" And with the small mouse boy leaves.\n\n");
		outputText("\"<i>Is this a common occurrence?</i>\" Grayda seemed to be quite bewildered by the sudden series of events that just occurred.\n\n");
		outputText("You give her a light smile and tell her it happens every so often.\n\n");
	}
	outputText("After giving her a tour of the camp, and attempting to calm those shocked by your sudden change of appearance, as well as introducing Grayda to the various inhabitants. You both eventually end up in your place of rest.\n\n");
	outputText("\"<i>My Princess, unfortunately, I am not so gifted when it comes to creating shelter, would you mind if I stayed here? I’ll use my own bedroll.</i>\" She pats the rather large bag she’s been carrying around for emphasis.\n\n");
	outputText("You suppose you could, after all, she’s been so generous and kind towards you already.\n\n");
	outputText("\"<i>Thank you, my Princess. Now if you don’t mind, I'm going to start unpacking.</i>\"\n\n");
	outputText("You take that as your cue to leave and give her a small wave before attending to your other duties for the day.\n\n");
	outputText("\n\n(<b>Grayda has been added to the Followers menu!</b>)\n\n");
	outputText("\n\n<b>As if remembering something Grayda pulls a shining shard from her inventory and hands it over to you as a gift. You acquired a Radiant shard!</b>");
	if (player.hasKeyItem("Radiant shard") >= 0){
		player.addKeyValue("Radiant shard",1,+1);
	}
	else player.createKeyItem("Radiant shard", 1,0,0,0);
	flags[kFLAGS.THE_TRENCH_ENTERED] = 15;
	SceneLib.inventory.takeItem(armors.P_REGAL, camp.returnToCampUseTwelveHours);
}
private function theTrenchLoiter():void {
	clearOutput();
	outputText("Looking around the commons, you decide there shouldn’t be much harm in just relaxing for a while. Finding a nearby table and chair, you sit down, fold your arms and rest your head in them as you shut your eyes for a bit. However, the chattering of individuals seems to draw your attention, surely they wouldn’t mind if you listened in, right? "+(player.tailType == Tail.ARIGEAN_PRINCESS ? "Afterall it wouldn’t hurt to know what’s on your subject’s minds. ":"")+"Your ears twitch as you strain your hearing, determined to hear your surroundings.\n\n");
	var option:Number = rand(4);
	switch (option) {
        case 0:
            outputText("\"<i>Claire... what are you doing?..</i>\"\n\n");
            outputText("\"<i>C'mon! Please!</i>\"\n\n");
            outputText("\"<i>Stop... humping my leg...</i>\"\n\n");
            outputText("\"<i>C'mon! I need you!</i>\"\n\n");
            outputText("\"<i>Wait... or... I'm going to... penalize you further...</i>\"\n\n");
            outputText("\"<i>W-Wait! Let go of my horn!</i>\"\n\n");
            outputText("\"<i>Why should I?.. It seems I always… need to be forceful… to get my point… across.</i>\"\n\n");
            outputText("\"<i>P-Please stop s-stroking it! N-Not out he- GAHH!</i>\"\n\n");
            break;
        case 1:
            outputText("\"<i>Claire… you were an oni… before… right?</i>\"\n\n");
            outputText("\"<i>Yep, that’s right! Is something the matter? Or are you just curious?</i>\"\n\n");
            outputText("\"<i>You don’t strike me… as very oni-like.</i>\"\n\n");
            outputText("\"<i>What are you talking about, I'm very oni-like! I’ve still got a horn, i'm big, and very t-”</i>\"\n\n");
            outputText("\"<i>I mean you don’t… act like one… your very gentle and… soft</i>\"\n\n");
            outputText("\"<i>Well… i guess you're not wrong with that, but everyone is built differently~</i>\"\n\n");
            outputText("\"<i>Everyday you continue to… confuse me</i>\"\n\n");
            outputText("\"<i>Hehe, now give me a hug!</i>\"\n\n");
            outputText("\"<i>Wait… not again!.. I can’t breathe when… you do this!</i>\"\n\n");
            break;
        case 2:
            outputText("\"<i>Hey Camellia? You were a bee-girl before, right? What was that like?</i>\"\n\n");
            outputText("\"<i>It was… fine i suppose… it was a fairly… simple life… of course it didn’t… last forever.</i>\"\n\n");
            outputText("\"<i>Did something happen?</i>\"\n\n");
            outputText("\"<i>I got infected… and then exiled… the queen feared that… what i was ill… with, was contagious.</i>\"\n\n");
            outputText("\"<i>Birds of a feather, stick together ey!</i>\"\n\n");
            outputText("\"<i>You were... an exile?</i>\"\n\n");
            outputText("\"<i>Hehe… I think that’s a story for another time.</i>\"\n\n");
            break;
        case 3:
            outputText("\"<i>So are you going… to tell me how… you became an Arigean?</i>\"\n\n");
            outputText("\"<i>Mmm, I suppose I could, but I wanna be top tonight!</i>\"\n\n");
            outputText("\"<i>Very… well.</i>\"\n\n");
            outputText("\"<i>Hehe~ this is gonna be so fun!</i>\"\n\n");
            outputText("\"<i>Now your end of… the deal.</i>\"\n\n");
            outputText("\"<i>Alright, I used to live in a tribe, but I was always on thin ice with them due to being born with albinism. Eventually, they got sick of me and threw me out. A little bit after, I lost a fight and got infected, now I'm here.</i>\"\n\n");
            outputText("\"<i>You don’t sound bothered… by this.</i>\"\n\n");
            outputText("\"<i>I find life like this a lot better than before, besides I never liked them anyway.</i>\"\n\n");
            outputText("\"<i>I suppose being an… Arigean is a lot… better than how life… was previously.</i>\"\n\n");
            outputText("\"<i>C’mon! Let’s go have some fun now!</i>\"\n\n");
            outputText("\"<i>Wait… I'm not done eating.</i>\"\n\n");
            outputText("\"<i>Too bad!</i>\"\n\n");
            break;
        default:
            outputText("\"<i>Too bad!</i>\"\n\n");
            break;
    }
	outputText("Maybe that’s enough listening in on others for now.\n\n");
	doNext(theTrenchMain);
	advanceMinutes(5);
}
public function theTrench111():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
	}
}