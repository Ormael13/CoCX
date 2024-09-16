/**
 * ...
 * @author melchi'is first attempt at making a monster
 * special thanks to ox and everyone for helping/**
 * Ported from UEE to CoCX by Svalkash.
 */
package classes.Scenes.Areas.Forest {
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Dryad extends Monster {

    //Melee special
    public function slash():void {
        outputText("The dryad reaches for you with claw-like wooden hands!  As soon as she is close, she slashes with her claws ");
        if (player.getEvasionRoll()) {
            outputText("and you deftly avoid her claws!");
        } else {
            outputText("and tears into your flesh! ");
            player.takePhysDamage(str + weaponAttack + rand(40), true);
        }
    }

    //lust special
    public function pollen():void {
        outputText("The dryad runs her hands through her leafy hair and spins around.   \n\n Yellow and pink sparkles of pollen gently float through the air in your direction. ");
        if (player.getEvasionRoll()) {
            outputText("You cover your mouth and nose and avoid breathing in most of the pollen!");
        } else {
            outputText("You take a deep breath of the pollen!\n ");
            outputText("Your mind becomes a haze as a hot wave of arousal washes over you.");
            player.takeLustDamage(player.lib / 10 + player.sens / 10 + 10, true);
        }
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.forest.corruptedGlade.dryad.winagainstdryad();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.forest.corruptedGlade.dryad.loseTodryad();
    }

    function Dryad() {
        this.a = "the ";
        this.short = "Corrupted Dryad";
        this.imageName = "dryad";
        this.long = "The dryad before you is brimming with corruption, her hair is composed of dark brown leaves. Her skin looks to be made of corrupted wood, especially her fingers which are shaped like sharp claws. Her clothing is nothing more than leaves and straw put into a gown. Her eyes are a deep and hungry dark red. Her bark-like skin seeps a thick pink substance.  ";
        this.createVagina(false, VaginaClass.WETNESS_DRY, VaginaClass.LOOSENESS_NORMAL);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("C"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 30, 0, 0, 0);
        this.tallness = 60;
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "birch-white";
        this.hairColor = "dark brown";
        this.hairLength = 4;
        initStrTouSpeInte(95, 75, 70, 100);
        initWisLibSensCor(70, 155, 135, 90);
        this.weaponName = "claws";
        this.weaponVerb = "slash";
        this.weaponAttack = 75;
        this.armorName = "forest gown";
        this.armorDef = 180;
		this.armorMDef = 15;
        this.fatigue = 0;
        this.bonusHP = 850;
		this.bonusLust = 317;
        this.lust = 35;
        this.lustVuln = 0.4;
        this.level = 27;
        this.gems = rand(15) + 25;
        this.drop = new WeightedDrop()/*.
						add(armors.FRSGOWN, 1)*/;
        //armor is not added (yet?), but has nice texts in UEE. Maybe...?
        this.special1 = slash;
        this.special2 = pollen;
		this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
		this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
        checkMonster();
    }
}
}
