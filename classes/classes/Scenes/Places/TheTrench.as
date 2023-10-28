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
import classes.internals.Utils;
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
	if (player.hasPerk(PerkLib.FutaForm)) player.removePerk(PerkLib.FutaForm);
	if (player.hasPerk(PerkLib.FutaFaculties)) player.removePerk(PerkLib.FutaFaculties);
	if (player.breastRows[0].breastRating < 2) player.breastRows[0].breastRating = 2;
	outputText(" You head back to sleep opting to deal with the problems of your new body later and when you're more awake.\n");
	doNext(playerMenu);
}
public function graydaEncounterTheTrench():void {
	clearOutput();
	outputText("After sailing quite a far from shore distance from shore a bold idea you would never even consider trying crosses your mind, walking on water. The idea seems absurd at first however you recall that strange woman being able to walk on the water’s surface, surely you should be able to do the same seeing as you're now the same race. You start with carefully hanging your legs off the boat and slowly step down as if you were just getting off the boat onto land, and surprisingly you find yourself standing on the water instead of in it.\n\n");
	outputText("You carefully take a few steps forward before getting a hang of walking on the somewhat shaky surface, and before long you find yourself running around without a care in the world. However after having your fun you decide it would be best to head back to camp, but you can’t seem to find your boat anywhere, after a bit of wandering a thick layer of fog seems to come out of nowhere and sudden panic floods your system, you could be attacked from any direction including from underneath. But why should you be afraid of anything out here? Clearly they should be afraid of an apex creature like yourself! You shake your head, such... overconfidence could get you killed, or much worse...\n\n");
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
	addButton(2, "Food Stand", theTrenchFoodStand);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}
private function theTrenchMain():void {
	clearOutput();
	theTrenchMain1();
	menu();
	addButton(2, "Food Stand", theTrenchFoodStand);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}
private function theTrenchMain1():void {
	outputText("The left path seems to lead into multiple different rooms which serve as shared quarters between several individuals per room. While most of the rooms seem to be unoccupied or hosting sleeping Arigeans, you can hear the chatting of a couple individuals behind some of the closed doors.\n\n");
	outputText("The right path seems to lead to a market area which contains multiple different shops or services. It seems like you could find replacement equipment here should you ever happen to lose the clothing Grayda gifted you. A heavenly smell of roasted meat seems to waft from some sort of food shop from down there.\n\n");
	outputText("The central path leads down towards a common area in which you can see several Arigeans lounging, reading or simply just conversing with each other. You can see Grayda holding a few papers while talking with two Arigeans who possess a red and black coloring, which seems to be a uncommon coloring many of the individuals here possess.\n\n");
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
	addButton(2, "CJ", theTrenchFoodStandCoelacanthJerky).hint("Coelacanth Jerky");
	addButton(3, "SII", theTrenchFoodStandSoftIronIngot).hint("Soft Iron Ingot");
	addButton(14, "Back", theTrenchMain);
}
private function theTrenchFoodStandCoelacanthJerky():void {
	outputText("\"<i>Coelacanth normally don’t taste very great, but they are slow, big and get some nice flavoring with a bit of salt. 5 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.C_JERKY), theTrenchFoodStand);
}
private function theTrenchFoodStandSoftIronIngot():void {
	outputText("\"<i>Ah, soft iron~ My personal favorite! You’ll find it’s soft and easy to chew on the go, and your body will go straight to work on healing itself with the extra nutrients, it’s also pretty decent stomach filler too! 70 gems each.</i>\"\n\n");
	doYesNo(Utils.curry(theTrenchFoodStandBuy,consumables.SIINGOT), theTrenchFoodStand);
}
public function theTrenchFoodStandBuy(itype:ItemType):void {
	clearOutput();
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, theTrenchFoodStand);
}
private function theTrench():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
public function theTrench111():void {
	clearOutput();
	outputText("\"<i></i>\"\n\n");
}
	}
}