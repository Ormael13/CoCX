
package classes.Scenes.Monsters {
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.CockTypesEnum;
import classes.Monster;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.WeightedDrop;
import classes.lists.BreastCup;

/**
 * @author kitteh660.
 * Ported from UEE to CoCX by Svalkash
 * Mimic, one of the classic encounters from Unnamed Text Game, now modified to be up to modern standards, with new fight.
 */
public class Mimic extends Monster {

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.mimicScene.mimicTentacle2();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.mimicScene.killTheMimic();
    }


    private function mimicBite():void {
        outputText("The creature lashes out at you, attempting to bite you! ");
        if (player.getEvasionRoll()) {
            outputText("Thankfully you're quick enough to avoid its gaping maw!");
        } else {
            outputText("Ow! The mouth rends your arm and it hurts like hell! ");
            var damage:int = (10 + (str / 2) + rand(str / 3)) * (1 + (player.newGamePlusMod() * 0.3));
            player.takePhysDamage(damage, true);
        }
    }

    override protected function performCombatAction():void {
        if (player.hasStatusEffect(StatusEffects.KnockedBack)) outputText("The creature sits tight, being unable to reach you.");
        else if (rand(2) == 0) eAttack();
        else mimicBite();
    }

    public function Mimic(type:int) {
        this.a = "the ";
        this.short = "mimic";
        switch (type) {
            case 0:
                this.imageName = "mimic-stone";
                this.long = "This strange monster originally disguised as a huge block of grey stone covered in bizarre runes and symbols. Its surface appears to be grey and made of stone. There is a gaping maw with hundreds of teeth inside and a huge tongue lashing about.";
                break;
            case 1:
                this.imageName = "mimic-boob";
                this.long = "This strange monster originally disguised as a huge breast. Its surface appears to be pale, reminiscent of skin. There is a gaping maw where its nipple should be with hundreds of teeth inside and a tiny whippy tongue lashing about. Milky saliva seems to be leaking from its nightmarish mouth.";
                break;
            case 2:
                this.imageName = "mimic-cock";
                this.long = "This strange monster originally disguised as a huge penis. Its surface appears to be pale, reminiscent of skin. There is a gaping maw where its urethra should be with hundreds of teeth inside and a tiny whippy tongue lashing about. There are dozens of tentacles sprouting from its shaft.";
                break;
            case 3:
                this.imageName = "mimic-chest";
                this.long = "This strange monster originally disguised as a wooden chest. Its surface appears to be brown and made of wood. There is a gaping maw where the box and lid meet, with hundreds of teeth inside and a huge tongue lashing about.";
                break;
            default:
                this.imageName = "mimic";
        }
        if (type == 2)
            this.createCock(80, 16, CockTypesEnum.HUMAN);
        else
            this.initedGenitals = true;
        this.balls = 0;
        this.ballSize = 0;
        if (type == 1)
            createBreastRow(BreastCup.JACQUES00);
        else
            createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = rand(24) + 25;
        this.hips.type = Hips.RATING_BOYISH;
        this.butt.type = Butt.RATING_TIGHT;
        if (type == 3)
            this.bodyColor = "brown";
        if (type == 1 || type == 2)
            this.bodyColor = "light";
        else
            this.bodyColor = "gray";
        this.hairColor = "none";
        this.hairLength = 0;
        this.pronoun1 = "it";
        this.pronoun2 = "it";
        this.pronoun3 = "its";
        this.weaponName = "mouth";
        this.weaponVerb = "bite";
        if (type == 3) {
			initStrTouSpeInte(50, 115, 5, 10);
			initWisLibSensCor(50, 35, 35, 100);
			this.weaponAttack = 30 + player.level;
            this.armorName = "wooden surface";
            this.armorDef = 60;
			this.armorMDef = 60;
			this.bonusHP = 100;
			this.bonusLust = 81;
			this.level = 11;
        }
        if (type == 2 || type == 1) {
            initStrTouSpeInte(60, 200, 5, 20);
			initWisLibSensCor(100, 95, 95, 100);
			this.weaponAttack = 40 + player.level;
            this.armorName = "flesh";
            this.armorDef = 10;
			this.armorMDef = 10;
			this.bonusHP = 250;
			this.bonusLust = 315;
			this.level = 25;
        } else {
            initStrTouSpeInte(30, 95, 5, 5);
			initWisLibSensCor(45, 45, 45, 100);
			this.weaponAttack = 20 + player.level;
            this.armorName = "stone surface";
            this.armorDef = 180;
			this.armorMDef = 180
			this.bonusHP = 50;
			this.bonusLust = 96;
			this.level = 6;
        }
        this.lust = 10;
        this.lustVuln = 0.01;
        this.gems = rand(20) + 21;
        this.drop = new WeightedDrop()
            .add(consumables.PPHILTR, 4)
            .add(consumables.NUMBOIL, 4)
            .add(consumables.HUMMUS_, 3)
            .add(consumables.INCUBID, 1)
            .add(consumables.SUCMILK, 1)
            .add(consumables.REDUCTO, 1);
        this.special1 = mimicBite;
        checkMonster();
    }

}

}
