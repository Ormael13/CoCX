package classes.Scenes.NPCs {
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

use namespace CoC;
public class Astrid extends Monster {
    public function Astrid() {
        //textual data
        //Moth Girl(s)
        //
        //Level 6 Uncommon Enemy
        //
        //HP:Low
        //Armor:None
        //Lust:Medium
        //Weakness:Fire
        //
        //(1-2 more attacks when in group fight event with astrid)
        //Appearance: A moth girl with an athletic build, C cup breasts and a cute butt. She has red eyes with white hair and fur.
        //
        this.a = "a "
        this.short = "moth"
        this.imageName = "astrid"
        this.long = "A moth girl with an athletic build, C cup breasts and a cute butt. She has red eyes with white hair and fur."
        this.level=6
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
        this.createBreastRow(Appearance.breastCupInverse("C"));
        this.createStatusEffect(StatusEffects.BonusACapacity, 20, 0, 0, 0);
        this.tallness = 4;
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.skin.color = "light";
        this.hairColor = "white";
        this.hairLength.length = 16;
        this.initStrTouSpeInte(55, 40, 70, 60);
        this.weaponName = "arms";
        this.weaponVerb="attack";
        this.weaponAttack = 10;
        this.armorName = "chitin";
        this.armorDef = 10;
        this.bonusHP = 100;
        this.lust = 30;
        this.lustVuln = 0.75;
        this.level = 6;
        this.gems = rand(15) + 5;
        this.drop = new WeightedDrop().add(consumables.MOTHDUS)
        this.wings.type = Wings.MOTH_LARGE;
        this.tailType = Tail.MOTH_ABDOMEN;
        this.tailRecharge = 0;
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        checkMonster();
    }
    //Gold Dust
    //Effect: Blinding you for 2 turns
    //Tooltip:You become blinded
    //Battle Text:The Moth Girl flaps her wings, giggling as she does so and gold dust flies towards you, causing you to go temporarily blind. (not dodgeable
    private function GoldDustAttack() {
        outputText("The Moth Girl flaps her wings, giggling as she does so and gold dust flies towards you, causing you to go temporarily blind. ");
        player.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
    }
    //Grapple
    //Effect: You are unable to do anything but struggle.
    //Tooltip:You can't attack or escape, only struggle.
    //Battle Text:She flaps her wings and grabs a hold of you, straddling you as she does.
    private function GrappleAttack() {
        outputText("She flaps her wings and grabs a hold of you, straddling you as she does.");
        player.createStatusEffect(StatusEffects.Constricted, 0, 0, 0, 0);
    }
    //
    //Lust attacks
    //Effect: your lust increases.
    //Tooltip: just a variant of the lust attack
    //Battle Text: Flying high and doing a seductive dance in the air, she is rocking her hips side to side as she moves her arms over her breasts and across her tummy and legs, looking at you with do me eyes.
    private function MothLusterAttack() {
        outputText("Flying high and doing a seductive dance in the air, she is rocking her hips side to side as she moves her arms over her breasts and across her tummy and legs, looking at you with do me eyes.");
        player.dynStats("lus", 10);
    }
    override protected function performCombatAction():void
    {
        //randomly choose which attack to proc
        var choice:Number = rand(3);
        if (choice == 0) {
            GoldDustAttack();
        } else if (choice == 1) {
            GrappleAttack();
        } else {
            MothLusterAttack();
        }
    }
    override public function defeated(hpVictory:Boolean):void
    {
        SceneLib.astridFollower.astridDefeated();
    }
    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
    {
        SceneLib.astridFollower.astridWon();
    }

}
}
