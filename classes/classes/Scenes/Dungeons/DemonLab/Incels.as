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
        this.level = 40;
        this.gems = rand(50) + 75;
        //I don't know how to add regeneration, physical resistance, or the lust to damage special ability I want them to have.
        this.drop = new WeightedDrop().add(useables.D_SCALE, 5).add(useables.LETHITE, 2).add(jewelries.POWRRNG, 1);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.ToughHide, 0, 0, 0, 0);
        this.createPerk(PerkLib.WeaponClawsClawTraining, 0, 0, 0, 0);
        this.createPerk(PerkLib.MonsterRegeneration, 10, 0, 0, 0); //HP regen
        this.createStatusEffect(StatusEffects.DefendMonsterVer, 50, 0.6, 0, 0); //phys resist?

        checkMonster();
    }

    //For every 20 Lust damage they take, they gain a 5% bonus to the damage they deal. This is additive, not multiplitive.
    private var damageMult:Number = 1.0;

    public override function eBaseDamage():Number {
        return super.eBaseDamage() * damageMult;
    }

    private function restoreLust():void {
        damageMult += lust * 0.0025;
        lust = 0;
    }

    override public function defeated(hpVictory:Boolean):void {
        //immune to lust
        if (!hpVictory) {
            restoreLust();
            SceneLib.combat.enemyAIImpl();
            return;
        }
        SceneLib.dungeons.demonLab.IncelVictory();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment();
    }

    private function IncelRush():void {
        clearOutput();
        outputText("The creatures rush at you, their blackened nails flashing. Sheer numbers weigh against you, and the creatures land strike after strike!");
        var hit:int = 0;
        for (var i:int = 0; i < 6; ++i) {
            if (player.getEvasionRoll()) {
                eOneAttack(true);
                ++hit;
            }
        }
        if (hit == 0) {
            outputText("You see the creatures massing for their attack. Before they can surround you, you kick one of the banquet tables over, delaying their charge long enough for you to put some distance between you and the horde. ");
        }
    }

    // idk if there's a better implementation, but let's keep it simple for now?
    public var dsTurnCounter:int = 0;

    // In doAI to avoid stun checks.
    public function DraftSupportCheck():void {
        ++dsTurnCounter;
        if (dsTurnCounter == 4) DraftSupportStart();
        else if (dsTurnCounter > 4) DraftSupportContinue();
    }

    private function DraftSupportStart():void {
        outputText("You notice the pink gas spilling from the lab as it washes over the horde. The reaction is immediate, the animalistic creatures letting out wails of anger, some even scratching at their bodies as if to rid themselves of the effects. As the gas washes over you, blood rushes to your cheeks.");
        lustDraftTick();
    }

    public function DraftSupportContinue():void {
        outputText("Lustdraft gas continues to wash over the battlefield, weakening your knees and sending the horde in front of you into a frenzy. You need to end this fight as fast as possible!");
        lustDraftTick();
    }

    public function lustDraftTick():void {
        player.takeLustDamage(Math.round(60 + (player.lib * 1.1)), true);
        damageMult += (60 + (lib * 1.1)) * 0.025; //idk how much lust to give them
    }

    private function RipAndTearUntilYourDone():void {
        outputText("The mass of frenzied creatures grab hold of you. One takes an arm, another bites at you with sharp fangs. You struggle, but as soon as you throw one off you, another takes its place, and more are piling on, burying you under a tidal wave of flesh!");
        player.createStatusEffect(StatusEffects.Pounced, 2, 0, 0, 0);
    }

    public function RipStruggle():void {
        if (rand(player.str) > (this.str / 10) * (1 + player.getStatusValue(StatusEffects.Pounced, 1)) || player.hasPerk(PerkLib.FluidBody)) RipBreakOut();
        else RipCont();
        SceneLib.combat.enemyAIImpl();
    }

    public function RipWait():void {
        RipCont();
        SceneLib.combat.enemyAIImpl();
    }

    private function RipCont():void {
        if (player.getStatusValue(StatusEffects.Pounced, 1) > 0)
            player.addStatusValue(StatusEffects.Pounced, 1, -1);
        clearOutput();
        outputText("The horde rips at your body, scratches and bites coming at you from every side. You try to escape, but for every hold you break, another claw comes in to grab you.");
        eOneAttack(true);
        eOneAttack(true);
        eOneAttack(true);
    }

    private function RipBreakOut():void {
        player.removeStatusEffect(StatusEffects.Pounced);
        clearOutput();
        outputText("You manage to get your elbow into the mouth of one particularly tenacious creature, and it recoils, headbutting another by accident. The two begin fighting, and the flailing starts a miniature brawl between the Sexless freaks. You feel the weight on you lessening, and you heave, sending two more of the creatures tumbling. You scramble, pulling yourself out, but as you do, the creatures refocus on you, almost immediately.");
        takePhysDamage(eBaseDamage());
    }

    override protected function performCombatAction():void {
        if (!player.hasStatusEffect(StatusEffects.Pounced) && rand(2) == 0) RipAndTearUntilYourDone();
        else IncelRush();
    }
}

}