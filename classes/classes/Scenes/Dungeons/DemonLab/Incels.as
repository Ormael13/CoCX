package classes.Scenes.Dungeons.DemonLab {
/**
 * ...
 * @author CanadianSnas
 */

import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.WeightedDrop;

public class Incels extends Monster {

    public function Incels() {
        this.a = "the ";
        this.short = "Incels";
        //this.imageName = "goblinwarrior";
        this.long = "This group of monstrous creatures slaver from their mouths, long black claws jutting from their hands. They’re not uniform in most aspects of their appearance…but the glassy eyes, perpetually open mouths and stiff movements give them a terrifying uniformity. They stare, unblinking, not at your eyes, face or [weapon], but at your loins. They seem to instinctively know you’re not one of them. ";
        this.plural = true;
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 30, 0, 0, 0);
        this.tallness = 104 + rand(7);
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.hairLength = 2;
        this.horns.count = 2;
        initStrTouSpeInte(275, 400, 390, 30);
        initWisLibSensCor(40, 945, 50, 100);
        this.weaponName = "black claws";
        this.weaponVerb = "slash";
        this.weaponAttack = 100;
        this.armorName = "skin";
        this.armorDef = 81;
        this.armorMDef = 59;
        this.bonusHP = 1400;
        this.bonusLust = 990;
        this.lust = 50;
        this.lustVuln = 0.44;
        this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
        this.level = 40;
        this.gems = rand(50) + 75;
        //I don't know how to add regeneration, physical resistance, or the lust to damage special ability I want them to have.
        this.drop = new WeightedDrop().add(useables.D_SCALE, 5).add(useables.LETHITE, 2).add(jewelries.POWRRNG, 1);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.ToughHide, 0, 0, 0, 0);
        this.createPerk(PerkLib.WeaponClawsClawTraining, 0, 0, 0, 0);

        checkMonster();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.IncelVictory();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment(); //TODO
    }


    private function IncelRush():void {
        outputText("The creatures rush at you, their blackened nails flashing. Sheer numbers weigh against you, and the creatures land strike after strike!");
        var r:int = rand(6);
        //TODO: how do Attacks work?
        createStatusEffect(StatusEffects.Attacks, r, 0, 0, 0);
        if (r == 0) {
            outputText("You see the creatures massing for their attack. Before they can surround you, you kick one of the banquet tables over, delaying their charge long enough for you to put some distance between you and the horde. ")
        }
    }

    private function DraftSupportStart():void {
        outputText("You notice the pink gas spilling from the lab as it washes over the horde. The reaction is immediate, the animalistic creatures letting out wails of anger, some even scratching at their bodies as if to rid themselves of the effects. As the gas washes over you, blood rushes to your cheeks.")
        player.dynStats("lus", Math.round(60 + (player.lib * 1.1)));
        //add lust to the incels
    }

    private function RipAndTearUntilYourDone():void {
        outputText("The mass of frenzied creatures grab hold of you. One takes an arm, another bites at you with sharp fangs. You struggle, but as soon as you throw one off you, another takes its place, and more are piling on, burying you under a tidal wave of flesh! You are buried under the incels’ writhing mass, and they’re still trying to tear you apart!");
        player.createStatusEffect(StatusEffects.Pounced, 2, 0, 0, 0);
    }

    //TODO: use it!
    private function RipStruggle():void {
        player.removeStatusEffect(StatusEffects.Pounced);
        if ((rand(player.str) > this.str / 2) || player.hasPerk(PerkLib.FluidBody)) RipBreakOut();
        else RipCont();
    }

    private function RipCont():void {
        outputText("The horde rips at your body, scratches and bites coming at you from every side. You try to escape, but for every hold you break, another claw comes in to grab you.")
        createStatusEffect(StatusEffects.Attacks, 3, 0, 0, 0);
    }

    private function RipBreakOut():void {
        outputText("You manage to get your elbow into the mouth of one particularly tenacious creature, and it recoils, headbutting another by accident. The two begin fighting, and the flailing starts a miniature brawl between the Sexless freaks. You feel the weight on you lessening, and you heave, sending two more of the creatures tumbling. You scramble, pulling yourself out, but as you do, the creatures refocus on you, almost immediately. \n\n");
    }

    override protected function performCombatAction():void {
        clearOutput();
        DraftSupportStart();
        var choice0:Number = rand(2);
        switch (choice0) {
            case 0:
                IncelRush();
                break;
            case 1:
                RipAndTearUntilYourDone();
                break;
        }
    }
}

}