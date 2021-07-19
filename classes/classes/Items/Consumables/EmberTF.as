/**
 * Ormael - 28.07.2017
 */
package classes.Items.Consumables
{
import classes.BaseContent;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;

public class EmberTF extends BaseContent
{

	public function EmberTF() {
		super();
	}

public function dragonTFeffects(drakesHeart:Boolean = false):void {
	var changes:int = 0;
	var changeLimit:int = 2;
	if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist)) changeLimit++;
	if (player.hasPerk(PerkLib.Enhancement)) changeLimit++;
	if (player.hasPerk(PerkLib.Fusion)) changeLimit++;
	if (player.hasPerk(PerkLib.Enchantment)) changeLimit++;
	if (player.hasPerk(PerkLib.Refinement)) changeLimit++;
	if (player.hasPerk(PerkLib.Saturation)) changeLimit++;
	if (player.hasPerk(PerkLib.Perfection)) changeLimit++;
	if (player.hasPerk(PerkLib.Creationism)) changeLimit++;
	if (player.hasPerk(PerkLib.EzekielBlessing)) changeLimit++;
	if (player.hasPerk(PerkLib.TransformationResistance)) changeLimit--;
	//Temporary storage
	var temp:Number = 0;
	if (player.blockingBodyTransformations()) changeLimit = 0;
	//Gain Dragon Dick
	if (changes < changeLimit && player.dragonCocks() < player.cockTotal() && rand(3) == 0) {
		temp = 0;
		var choices:Array = [];
		var select:int;
		temp = player.cockTotal();
		//Build an array of all the locations for TF'able cocks.
		while (temp > 0) {
			temp--;
			if (player.cocks[temp].cockType != CockTypesEnum.DRAGON) choices[choices.length] = temp;
		}
		//Randomly choose one of those locations
		select = choices[rand(choices.length)];
		outputText("\n\nYour " + player.cockDescript(select) + " tingles as pins and needles sweep across it.  You pull open your [armor] to watch as it changes; the tip elongates and tapers, like a spear; a series of ridges form along the shaft, giving it an almost segmented look, and a prominent knot swells at its base.  You can't resist stroking it, until it begins dripping pre; ");
		if (player.sens >= 50) outputText("however, it's not until you press on your new, sensitive knot that you manage to blow your load and enjoy the last few spasms of pleasure as it finally finishes changing.");
		else outputText("but you sternly rein in your hands and tuck them into your armpits as the arousing changes run their course.");
		outputText("  <b>You now have a dragon penis.</b>");
		//lose lust if sens>=50, gain lust if else
		dynStats("lus", 10)
		player.addCurse("sen", 10, 1);
		changes++;
		//Apply the TF
		player.cocks[select].cockType = CockTypesEnum.DRAGON;
		player.cocks[select].knotMultiplier = 1.3;
	}
	//-Existing horns become draconic, max of 4, max length of 1'
	if (player.horns.type != Horns.DRACONIC_X4_12_INCH_LONG && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(5) == 0) {
		//No dragon horns yet.
		if (player.horns.type != Horns.DRACONIC_X2 && player.horns.type != Horns.DRACONIC_X4_12_INCH_LONG && player.horns.type != Horns.ORCHID) {
			//Already have horns
			if (player.horns.count > 0) {
				//High quantity demon horns
				if (player.horns.type == Horns.DEMON && player.horns.count > 4) {
					CoC.instance.transformations.HornsDraconicQuadruple.applyEffect();
        }	else {
					CoC.instance.transformations.HornsDraconicDual.applyEffect();
				}
				changes++;
			}
			//No horns
			else {
				//-If no horns, grow a pair
				CoC.instance.transformations.HornsDraconicDual.applyEffect();
        changes++;
			}
		}
		//ALREADY DRAGON
		else {
			if (player.horns.type == Horns.DRACONIC_X2) {
				if (player.horns.count < 12) {
					if (rand(2) == 0) {
						outputText("\n\nYou get a headache as an inch of fresh horns escapes from your pounding skull.");
						player.horns.count += 1;
					}
					else {
						outputText("\n\nYour head aches as your horns grow a few inches longer.  They get even thicker about the base, giving you a menacing appearance.");
						player.horns.count += 2 + rand(4);
					}
					if (player.horns.count >= 12) outputText("  <b>Your horns settle down quickly, as if they're reached their full size.</b>");
					changes++;
				}
				//maxxed out, new row
				else {
					//--Next horns growth adds second row and brings length up to 12\"
					CoC.instance.transformations.HornsDraconicQuadruple.applyEffect();
          changes++;
				}
			}
		}
	}
	//Gain Dragon Ears
	if (changes < changeLimit && rand(3) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.ears.type != Ears.DRAGON) {
		outputText("\n\n");
		CoC.instance.transformations.EarsDraconic.applyEffect();
		changes++;
	}
	//Gain Dragon Eyes
	if (player.ears.type == Ears.DRAGON && player.eyes.type != Eyes.DRACONIC && rand(3) == 0 && changes < changeLimit) {
    outputText("\n\n");
    CoC.instance.transformations.EyesDraconic.applyEffect();
		changes++;
	}
	//Gain Dragon Tongue
	if (changes < changeLimit && rand(3) == 0 && player.lowerBody != LowerBody.GARGOYLE && player.tongue.type != Tongue.DRACONIC) {
		outputText("\n\n");
    CoC.instance.transformations.TongueDraconic.applyEffect();
    changes++;
		//Note: This type of tongue should be eligible for all things you can do with demon tongue... Dunno if it's best attaching a boolean just to change the description or creating a whole new tongue type.
	}
	//(Pending Tongue Masturbation Variants; if we ever get around to doing that.)
	//Gain Dragon Head OR Dragon Fangs
	if (changes < changeLimit && rand(3) == 0 && player.tongue.type == Tongue.DRACONIC && player.lowerBody != LowerBody.GARGOYLE && (player.faceType != Face.DRAGON || player.faceType != Face.DRAGON_FANGS)) {
		if (player.faceType != Face.DRAGON) {
			outputText("\n\n");
      CoC.instance.transformations.FaceDragon.applyEffect();
		}
		else {
			outputText("\n\n");
      CoC.instance.transformations.FaceDragonFangs.applyEffect();
		}
        changes++;
	}
	var dragon_coat_color:Array = ["red", "golden", "metallic golden", "metallic silver", "silver", "snow white", "green", "blue", "bronzed", "black", "midnight"];
	//Gain Dragon Scales
	if (player.hasPartialCoat(Skin.DRAGON_SCALES) && changes < changeLimit && rand(3) == 0) {
		player.coatColor = randomChoice(dragon_coat_color);
		outputText("\n\n");
		CoC.instance.transformations.SkinDragonScales().applyEffect();
		changes++;
	}
	if (!player.hasDragonScales() && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
		var color:String;
		if (rand(10) == 0) {
			color = randomChoice("purple","silver");
		} else {
			color = randomChoice("red","green","white","blue","black");
		}
		player.coatColor = color;
		outputText("\n\n");
		CoC.instance.transformations.SkinDragonScales(Skin.COVERAGE_LOW).applyEffect();
		changes++;
	}
	//Gain Dragon Legs
	if (player.lowerBody != LowerBody.DRAGON && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
		//(if drider)
		if (player.isDrider()) outputText("\n\nA disquieting feeling ripples through your arachnid abdomen, and you find yourself losing control of your body from the waist down.  Your spidery legs flail madly as your abdomen visibly swells, chitin cracking ominously as the pressure builds up inside of you... and then explodes!  You wipe the gore from your face in disgust, wondering why you feel no pain.  Rolling over, you see that, caked with spider-slime, you now have a new pair of legs, human-like save for the scales and the bestial paws that serve as feet.  <b>You now have dragon feet.</b>");
		//(If naga)
		else if (player.isNaga()) outputText("\n\nYou fall on your face to the ground, hissing and screeching in pain - it feels like someone has grabbed the tip of your tail, pulled it viciously straight, and is now splitting it up the middle with a knife!  Paralyzed from the waist down, you claw desperately at the earth to try and alleviate the pain, and can only think to thank your lucky stars when it fades away.  Looking down where your tail was, though the scales remain, you realize you've become a biped again, your new feet sporting bestial claws on their toes.  <b>You now have dragon feet.</b>");
		//(If Goo)
		else if (player.isGoo()) outputText("\n\nA strange tingling sensation fills you, and you watch as your gooey blob of a body begins to ripple and shudder; you try to make it stop, but you can't control it.  Before your eyes, it shapes itself into the appearance of legs, the colored slime growing denser and thicker, the surface membrane texturing itself to look like scales.  Before you've quite realized what's happened, the slime has set like water freezing, leaving you with humanoid legs once again, though tipped with claws and very reptilian in appearance.  <b>You now have dragon feet.</b>");
		//(If hoofed legs)
		else if (player.lowerBody == LowerBody.HOOFED) outputText("\n\nYou bellow in pain as your legs break and reform and your hooves seem to suddenly explode, the bones within twisting themselves into monstrous three-toed appendages, more like those of some terrible lizard-thing than anything else. <b>You now have dragon feet.</b>");
		//(if centaur)
		else if (player.isTaur()) outputText("\n\nYou cry out as spasms of pain suddenly rip through your quadrupedal body, bringing you crashing onto the ground.  Words cannot define the agony as muscles and bones twist and shift and collapse violently.  When it's all over, you stagger upright, finding yourself standing on two legs again.  Though covered in scales and with the paws of some monster lizard instead of feet, they otherwise look like your old human legs.  <b>You now have dragon feet.</b>");
		//(if scylla)
		else if (player.isScylla()) {
			outputText("\n\nSomething weird happens in your tentacles as your limbs coil into two pillars of flesh and fuse together, your ");
			if (player.gender == 1) outputText("[vagina]");
			if (player.gender == 3) outputText(" and ");
			if (player.cocks.length > 0) outputText("[cock]");
			outputText(" moving back up between your leg to where it used to be. Bones starts to form in your limb and, before you know it, you are staring at a pair of normal human legs. The changes does not end there however.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>\n\n");
		}
		//(if alraune)
		else if (player.isAlraune()) outputText("\n\nYour petals all withers and fall off as your pitch and flower turn to dust leaving you with normal human legs. The changes does not stop there however.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>");
		//(If non-hoofed legs)
		else outputText("\n\nYou scream in agony as you feel the bones in your feet suddenly break and restructure themselves, toes fusing together, bone swelling out of the merged masses of flesh.  When the pain is over, you realize that you still stand atop human-looking legs, but your feet have become like those of some bipedal reptilian killer, with powerful claws meant for gripping the ground. <b>You now have dragon feet.</b>");
        CoC.instance.mutations.setLowerBody(LowerBody.DRAGON);
        player.legCount = 2;
		changes++;
	}
	//Arms
	if (player.arms.type != Arms.DRACONIC && player.lowerBody == LowerBody.DRAGON && changes < changeLimit && rand(3) == 0) {
		outputText("\n\n");
		CoC.instance.transformations.ArmsDraconic.applyEffect();
    changes++;
	}
	//Gain Dragon Tail
	if (player.tailType != Tail.DRACONIC && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
		//(If no tail)
		if (player.tailType == Tail.NONE) outputText("\n\nA sudden dull, throbbing pain in your [butt] forces your hands to it; you can feel an ominous lump over your tail bone, swelling bigger and bigger with every heartbeat.  All of a sudden, it seems to explode, jutting out and around until it hovers near your ankles, the skin under your flesh hard and scaly.  <b>You now have a dragon tail flicking at your back, flexible as a whip.</b>");
		//(If tail)
		else outputText("\n\nAn icy sensation fills your behind as your tail suddenly goes curiously numb.  Twisting your head around, you watch as it melts and transforms into a reptilian appendage, long and flexible, its tip adorned with wicked spikes.  <b>You now have a dragon tail.</b>");
        CoC.instance.mutations.setTailType(Tail.DRACONIC);
        changes++
	}
	/*
	//9999 - prolly not gonna do this!
	Tail Slam Attack Effects:
	Deals ⅓ normal damage, but pierces 30 defense (stacks with perks) and has a (strength / 2) chance of stunning the opponent that turn.
	Note: Dunno how much defense critters usually have, but this is meant as a surprise attack of sorts, so it pierces a good amount of it.
	Tail Slam Attack Description:
	You spin around quickly, whipping your tail spikes at [enemy].
	Hit: Your tail slams against it/" + emberMF("him","her") + " with brutal force, the spikes on the tip extending to puncture flesh.
	Miss: Unfortunately, you lose your sense of depth as you whirl, and the tip swings harmlessly through the air in front of your target.
	*/
	//Grow Dragon Wings
	if (player.wings.type != Wings.DRACONIC_HUGE && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
		if (player.wings.type == Wings.NONE) {
			outputText("\n\n");
			CoC.instance.transformations.WingsDraconicSmall.applyEffect();
    }
		//(If Small Dragon Wings Present)
		else if (player.wings.type == Wings.DRACONIC_SMALL) {
			outputText("\n\n");
			CoC.instance.transformations.WingsDraconicLarge.applyEffect();
    }
		//even larger dragon wings ^^
		else if (player.wings.type == Wings.DRACONIC_LARGE) {
			outputText("\n\n");
			CoC.instance.transformations.WingsDraconicHuge.applyEffect();
    }
		//(If other wings present)
		else {
			outputText("\n\n");
			CoC.instance.transformations.WingsDraconicSmall.applyEffect();
    }
		changes++;
	}
	//Get Dragon Breath (Tainted version)
	//Can only be obtained if you are considered a dragon-morph, once you do get it though, it won't just go away even if you aren't a dragon-morph anymore.
	if (player.dragonScore() >= 4 && changes < changeLimit && !player.hasPerk(PerkLib.DragonFireBreath)) {
		outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
		outputText("\n\nIt seems " + (drakesHeart ? "the flower" : "Ember's dragon blood") + " has awaked some kind of power within you... your throat and chest feel very sore, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon fire breath!</b>)");
		player.createPerk(PerkLib.DragonFireBreath, 0, 0, 0, 0);
        if (SceneLib.emberScene.emberAffection() >= 75 && !drakesHeart) outputText("\n\nEmber immediately dives back in to soothe your battered throat and mouth with another kiss.");
        changes++;
	}
	if (player.dragonScore() >= 4 && changes < changeLimit && !player.hasPerk(PerkLib.DragonIceBreath)) {
		outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
		outputText("\n\nIt seems " + (drakesHeart ? "the flower" : "Ember's dragon blood") + " has awaked some kind of power within you... your throat and chest feel very cold, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon ice breath!</b>)");
		player.createPerk(PerkLib.DragonIceBreath, 0, 0, 0, 0);
        if (SceneLib.emberScene.emberAffection() >= 75 && !drakesHeart) outputText("\n\nEmber immediately dives back in to soothe your battered throat and mouth with another kiss.");
        changes++;
	}
	if (player.dragonScore() >= 4 && changes < changeLimit && !player.hasPerk(PerkLib.DragonLightningBreath)) {
		outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
		outputText("\n\nIt seems " + (drakesHeart ? "the flower" : "Ember's dragon blood") + " has awaked some kind of power within you... your throat and chest feel like it was electrocuted, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon lightning breath!</b>)");
		player.createPerk(PerkLib.DragonLightningBreath, 0, 0, 0, 0);
        if (SceneLib.emberScene.emberAffection() >= 75 && !drakesHeart) outputText("\n\nEmber immediately dives back in to soothe your battered throat and mouth with another kiss.");
        changes++;
	}
	if (player.dragonScore() >= 4 && changes < changeLimit && !player.hasPerk(PerkLib.DragonDarknessBreath)) {
		outputText("\n\nYou feel something awakening within you... then a sudden sensation of choking grabs hold of your throat, sending you to your knees as you clutch and gasp for breath.  It feels like there's something trapped inside your windpipe, clawing and crawling its way up.  You retch and splutter and then, with a feeling of almost painful relief, you expel a bellowing roar from deep inside of yourself... with enough force that clods of dirt and shattered gravel are sent flying all around.  You look at the small crater you have literally blasted into the landscape with a mixture of awe and surprise.");
		outputText("\n\nIt seems " + (drakesHeart ? "the flower" : "Ember's dragon blood") + " has awaked some kind of power within you... your throat and chest feel very... strange and you can't put a finger what this feeling exactly is, however; you doubt you can force out more than one such blast before resting.  (<b>Gained Perk: Dragon darkness breath!</b>)");
		player.createPerk(PerkLib.DragonDarknessBreath, 0, 0, 0, 0);
        if (SceneLib.emberScene.emberAffection() >= 75 && !drakesHeart) outputText("\n\nEmber immediately dives back in to soothe your battered throat and mouth with another kiss.");
        changes++;
	}
	//grow up to 11 feet tall
	if (changes < changeLimit && rand(2) == 0 && player.tallness < 132) {
		temp = rand(5) + 3;
		//Slow rate of growth after some tresholds
		if (player.tallness >= 120) temp = Math.floor(temp / 3.5);
		if (player.tallness >= 96 && player.tallness < 120) temp = Math.floor(temp / 2);
		//Never 0
		if (temp == 0) temp = 1;
		if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
		if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
		if (temp == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
		player.tallness += temp;
		changes++;
	}
	if (player.dragonScore() >= 4 && rand(3) == 0 && player.gender > 0) {
		outputText("\n\nA sudden swell of lust races through your ");
		if (player.hasCock()) {
			outputText(cockDescript(0));
			if (player.hasVagina()) outputText(" and ");
		}
		if (player.hasVagina()) outputText(vaginaDescript());
        outputText(", making you wish " + (drakesHeart ? "you had a dragon to go with." : "Ember hadn't run you off") + ".  All you can think about now is fucking " + (drakesHeart ? "a dragon-morph" : SceneLib.emberScene.emberMF("him", "her")) + "; ");
        if (player.hasCock() && flags[kFLAGS.EMBER_GENDER] >= 2) {
			if (drakesHeart) {
				outputText("filling a womb with your seed and fertilizing those eggs");
			}
			else {
				outputText("filling her womb with your seed and fertilizing her eggs");
				if (player.hasVagina() && flags[kFLAGS.EMBER_GENDER] == 3) outputText(" even while ");
			}
		}
		if (player.hasVagina() && (flags[kFLAGS.EMBER_GENDER] == 3 || flags[kFLAGS.EMBER_GENDER] == 1)) {
			outputText("taking that hard, spurting cock inside your own " + vaginaDescript(0));
		}
		outputText("... too late, you realize that <b>" + (drakesHeart ? "the flower" : "Ember's blood") + " has sent your draconic body into ");
		if (player.hasCock() && (flags[kFLAGS.EMBER_GENDER] >= 2 || drakesHeart) && (rand(2) == 0 || !player.hasVagina())) { //If hermaphrodite, the chance is 50/50.
			outputText("rut");
			player.goIntoRut(false);
			changes++;
		}
		else {
			outputText("heat");
			player.goIntoHeat(false);
			changes++;
		}
		outputText("</b>.");
	}
	if (changes == 0) outputText("\n\nRemarkably, " + (drakesHeart ? "the flower" : "Ember's blood") + " has no effect.  Maybe next time?");
	flags[kFLAGS.TIMES_TRANSFORMED] += changes;
}
}
}
