// Consumable by Furrin GOk
package classes.Items.Consumables {
import classes.Appearance;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GeneticMemories.CockMem;
import classes.Races.AntRace;
import classes.CoC_Settings;
import classes.CockTypesEnum;
import classes.Player;
import classes.Items.Consumable;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.CoC;

public class HoneydewCake extends Consumable {
	public function HoneydewCake() {
		super("HDewCake", "HDewCake", "a cake flavored with honeydew", 6, "A very sweet cake beloved by Antmorphs.";
        }
	public override function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		//Temporary storage
		var temp2:Number = 0;
		var temp3:Number = 0;
		player.slimeFeed();
		clearOutput();
		outputText("You scarf down the sweet cake, feeling a bit of a sugar high.");
		//Strength up to 125
		if ((player.str < player.strStat.max && player.str < 125)&& (changes < changeLimit && rand(3) == 0)) {
			changes++;
            player.trainStat("str", +1, 125);
			outputText("\n\nAfter eating the cake, your muscles suddenly feel sore, as though you just lifted heavy weights. You're probably stronger.");
		}
		//Toughness up to 125
		if ((player.tou < player.touStat.max && player.tou < 125) && (changes < changeLimit && rand(3) == 0)) {
			outputText("\n\nAfter eating the cake, a soreness starts building up in your arms, as though you just blocked a boxer's punches. As it goes away, you feel like you've gotten tougher.");
            player.trainStat("tou", +1, 200);
			changes++;
		}
        if (player.inte > 50 && changes < changeLimit && rand(3) == 0) {
            outputText("\n\nYou feel a dull sensation in your brain. You may not be as intelligent as you used to be.");
            player.addCurse("int", 3);
            changes++;
        }
        if (player.wis > 50 && changes < changeLimit && rand(3) == 0) {
            outputText("\n\nYou suddenly feel like you're in a haze for a second. You may not be a wise as you used to be.")
            player.addCurse("wis", 3);
            changes++;
        }
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Antcock!
		if (changes < changeLimit && rand(3) == 0 && player.insectCocks() < player.cocks.length) {
            var choices:Array = [];
            counter = player.cockTotal();
            while (counter > 0) {
                counter--;
                //Add non-insect locations to the array
                if (player.cocks[counter].cockType != CockTypesEnum.INSECT) choices[choices.length] = counter;
            }
            if (choices.length != 0) {
                var select:int = choices[rand(choices.length)];
                transformations.CockInsect(select).applyEffect();
                changes++;
            }
        }
        //Ant Legs
        if (player.lowerBody != LowerBody.ANT && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyAnt().applyEffect();
			player.MutagenBonus("spe", 3);
			changes++;
		}
        //oviposition 
        if (changes < changeLimit && player.hasCoatOfType(Skin.CHITIN) && !player.hasPerk(PerkLib.AntOvipositor) && player.tailType == Tail.ANT_ABDOMEN && rand(2) == 0) {
            outputText("[pg]An odd swelling starts in your insectile abdomen, somewhere along the underside.  Curling around, you reach back to your extended, bulbous ant part and run your fingers along the underside.  You gasp when you feel a tender, yielding slit near the end.  As you probe this new orifice, a shock of pleasure runs through you, and a tubular, tan, semi-hard appendage drops out, pulsating as heavily as any sexual organ.  <b>The new organ is clearly an ovipositor!</b>  A few gentle prods confirm that it's just as sensitive; you can already feel your internals changing, adjusting to begin the production of unfertilized eggs.  You idly wonder what laying them with your new ant ovipositor will feel like...");
            outputText("[pg](<b>Perk Gained:  Ant Ovipositor - Allows you to lay eggs in your foes!</b>)");
            player.createPerk(PerkLib.AntOvipositor, 0, 0, 0, 0);
            changes++;
        }
		//Ant Abdomen
		if (player.lowerBody == LowerBody.ANT && player.tailType != Tail.GARGOYLE && player.tailType != Tail.ANT_ABDOMEN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.TailAnt.applyEffect();
			changes++;
		}
        //Wings
        if (!InCollection(player.wings.type, Wings.GARGOYLE_LIKE_LARGE, Wings.ANT_LARGE) && changes < changeLimit && rand(4) == 0) {
            //Grow bigger ant wings or convert bee wings into ant
            if (player.wings.type == Wings.ANT_SMALL || player.wings.type == Wings.BEE_LARGE) {
                outputText("[pg]");
                transformations.WingsAntLarge.applyEffect();
            }
         //Grow small ant wings if player has none or small bee wings.
         else if (player.wings.type == Wings.NONE || player.wings.type == Wings.BEE_SMALL) {
              outputText("[pg]");
              transformations.WingsAntSmall.applyEffect();
            }
            //Remove old wings
            else {
                outputText("[pg]");
                transformations.WingsNone.applyEffect();
            }
            changes++;
        }
		//Chitin skin
        if (changes < changeLimit && player.hasPartialCoat(Skin.CHITIN) && player.tailType == Tail.ANT_ABDOMEN && rand(2) == 0) {
            outputText("[pg]");
            transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {colors: MantisColor}).applyEffect();
            changes++;
        }
		//(Fur/Scales fall out replaced by chitin)
        if (!player.hasCoatOfType(Skin.CHITIN) && (player.ears.type == Ears.HUMAN || player.ears.type == Ears.ELFIN) && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
			outputText("[pg]");
            transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {colors: ["pale white", "green"]}).applyEffect();
            changes++;
        }
		//Insect ears
		if (player.ears.type != Ears.INSECT && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsInsect.applyEffect();
			changes++;
		}
		//Ant face
		if (player.ears.type == Ears.INSECT && player.faceType != Face.ANT && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.FaceAnt.applyEffect();
			changes++;
		}
        //Arms
        if (player.arms.type != Arms.ANT && changes < changeLimit && rand(3) == 0) {
            outputText("[pg]");
			transformations.ArmsAnt.applyEffect();
            changes++;
        }
        //Removes horns
        if (changes < changeLimit && player.horns.count > 0 && player.horns.type != Horns.GARGOYLE && rand(3) == 0) {
            outputText("[pg]");
            transformations.HornsNone.applyEffect();
            changes++;
        }
        //Antennae
        if (changes < changeLimit && player.lowerBody != LowerBody.GARGOYLE && player.antennae.type != Antennae.ANT && Utils.rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.AntennaeAnt.applyEffect();
			changes++;
		}
		//FAILSAFE CHANGE
		if (changes == 0) {
			outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
			EngineCore.HPChange(50, true);
		}
		player.refillHunger(20);
		return false;
	}
}
}
