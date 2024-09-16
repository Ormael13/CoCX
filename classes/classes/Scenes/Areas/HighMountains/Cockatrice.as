package classes.Scenes.Areas.HighMountains {
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.internals.WeightedAction;
import classes.internals.WeightedDrop;

/**
 * ...
 * @author ...
 * Ported from UEE to CoCX by Svalkash.
 */
public class Cockatrice extends Monster {
    public var spellCostCompulsion:int = 20;
    public var spellCostTailSwipe:int = 25;
    public var spellCostSandAttack:int = 15;

    //special 1: cockatrice compulsion attack
    //(Check vs. Intelligence/Sensitivity, loss = recurrent speed loss each
    //round, one time lust increase):
    private function compulsion():void {
        if (fatigue > (100 - spellCostCompulsion)) {
            // Normal attack because too fatigued
            eAttack();
            return;
        }
        outputText("The cockatrice opens its beak and, staring at you, utters words in its melodic tongue. The song wraps around your mind,"
            + " working and burrowing at the edges of your resolve, suggesting, compelling,"
            + " then demanding you to look into the cockatrice’s eyes.  ");
        //Success:
        if (player.inte / 5 + rand(20) < 24 + player.newGamePlusMod() * 5) {
            //Immune to Basilisk?
            if (player.hasPerk(PerkLib.BasiliskResistance)) {
                outputText("You can't help yourself... you glimpse the cockatrice’s lightning blue eyes. However, no matter how much you look"
                    + " into the eyes, you do not see anything wrong. All you can see is the cockatrice."
                    + " The cockatrice curses as he finds out that you're immune!");
            } else {
                outputText("You concentrate, but can’t help but look into those lightning blue orbs. You look away quickly, but you can picture"
                    + " them in your mind’s eye, staring in at your thoughts, making you feel sluggish and unable to coordinate."
                    + " Something about the helplessness of it feels so good... you can’t banish the feeling that really,"
                    + " you want to look in the cockatrice’s eyes forever, for it to have total control over you.");
                player.takeLustDamage(Math.round(player.maxLust() * 0.03), true);
                //apply status here
                player.buff("Basilisk Slow").addStats( {"spe":-20} ).withText("Basilisk Slow").combatPermanent();
                player.createStatusEffect(StatusEffects.BasiliskCompulsion, 0, 0, 0, 0);
                flags[kFLAGS.BASILISK_RESISTANCE_TRACKER] += 2;
            }
        }
        //Failure:
        else {
            outputText("You concentrate, focus your mind and resist the cockatrice’s musical compulsion.");
        }
        fatigue += spellCostCompulsion;
    }

    //Special 2: cockatrice sand attack (blinds for 2-4 turns, 50% chance of success on hit):
    private function sandAttack():void {
        if (fatigue > (100 - spellCostSandAttack)) {
            // Normal attack because too fatigued
            eAttack();
            return;
        }
        outputText("The cockatrice " + (rand(2) == 0 ? "unfurls his wings, flapping them hard against the ground. He whips up a flurry of loose"
            + " dirt and rocks, directing it at you as he soars above you." : "sweeps his tail along the ground, whipping up a flurry of loose"
            + " dirt and small rocks. With a swift movement he then swipes across at you, flinging debris in your direction.") + " ");
        if (player.spe / 5 + rand(20) < 28 + player.newGamePlusMod() * 5) { // dodge chance here
            if (rand(2) == 0) {
                // Hit
                outputText("The dirt and rocks engulf you, causing you to try to cover your eyes. You fail to move fast enough,"
                    + " dirt getting in your eyes, making them stream with tears and temporarily blinding you.");
                player.createStatusEffect(StatusEffects.Blind, 2 + rand(3), 0, 0, 0);
            } else {
                // Miss
                outputText("The dirt and rocks engulf you, causing you to cover your eyes."
                    + " You manage to cover them fast enough to block out the dirt, it showering you for a while before it settles again.");
            }
        } else {
            // Fail
            outputText("You thankfully manage to avoid the attack entirely, the mess of dust and dirt going wide of you.");
        }
        fatigue += spellCostSandAttack;
    }

    //Special 3: basilisk tail swipe (Small physical damage):
    private function tailSwipe():void {
        if (fatigue > (100 - spellCostTailSwipe)) {
            // Normal attack because too fatigued
            eAttack();
            return;
        }
        outputText("The cockatrice suddenly whips its tail at you, swiping your " + player.feet() + " from under you!  You quickly stagger upright, being sure to hold the creature's feet in your vision.  ");
        if (player.takePhysDamage(int((str + 20) - Math.random()*(player.tou+player.armorDef)), true) == 0)
            outputText("The fall didn't harm you at all.  ");
        fatigue += spellCostTailSwipe;
    }

    //Tease attack
    private function cockaTease():void {
        if (rand(2) == 0) {
            outputText("The cockatrice turns around slowly, looking over his shoulder as he slowly lifts his tail to reveal his tight rump."
                + " He rubs his clawed fingers over the taut flesh of his feathered cheeks, before his tail cracks against one cheek"
                + " like a whip. You can’t help but flush at his brazen display.");
        } else {
            outputText("The cockatrice casually leans against a nearby rock, a scaled finger trailing down his lithe stomach and tracing around"
                + " the edge of his genital slit as he looks to the distance. As the tip of his thick purple member starts to peek out he"
                + " looks over at you with a smouldering gaze, cocking his head to the side as if beckoning you to ‘come play’."
                + " You seriously consider his offer as you feel your loins burn with desire.");
        }
        player.takeLustDamage(12 + rand(player.lib / 8), true);
    }

    //basilisk physical attack: With lightning speed, the basilisk slashes you with its index claws!
    //Noun: claw

    override protected function performCombatAction():void {
        var actionChoices:WeightedAction = new WeightedAction()
            .add(sandAttack, 40)
            .add(cockaTease, 40)
            .add(tailSwipe, 30)
            .add(eAttack, 20);

        if (!player.hasStatusEffect(StatusEffects.BasiliskCompulsion) && !hasStatusEffect(StatusEffects.Blind))
            actionChoices.add(compulsion, 65);

        actionChoices.exec();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.highMountains.cockatriceScene.defeatCockatrice();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        clearOutput();
        if (hpVictory) {
            player.HP = 1;
            outputText("Your wounds are too great to bear, and you fall unconscious.");
        }

        if (pcCameWorms) {
            outputText("\n\nThe cockatrice smirks, but waits for you to finish...");
            doNext(SceneLib.combat.endLustLoss);
        } else {
            SceneLib.highMountains.cockatriceScene.loseToCockatrice();
        }
    }

    public function Cockatrice() {
        this.a = "the ";
        this.short = "cockatrice";
        this.imageName = "cockatrice";
        this.long = "The cockatrice before you stands at about 6 foot 2. The harpy/basilisk hybrid hops from one clawed foot to the other,"
            + " its turquoise neck ruff puffed out. From the creatures flat chest and tight butt, you assume that it must be male."
            + " He watches you, his electric blue eyes glinting as his midnight blue tail swishes behind him. Every so often he lunges"
            + " forward, beak open before revealing it was a feint. He is wielding his sharp claws as a weapon and is shielded only by his"
            + " exotic plumage and cream scaled belly."
            + " Every so often he spreads his large feathered wings in an attempt to intimidate you."
            + " His lizard-like feet occasionally gouge into the rubble of the plateau, flinging it up as he shifts his stance. ";
        this.createCock(8, 2, CockTypesEnum.LIZARD);
        this.balls = 2;
        this.ballSize = 2;
        this.cumMultiplier = 4;
        createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 30, 0, 0, 0);
        this.tallness = 6 * 12 + 2;
        this.hips.type = Hips.RATING_AMPLE;
        this.butt.type = Butt.RATING_TIGHT;
        this.hairType = Hair.FEATHER;
        this.bodyColor = "midnight blue";
        this.skinType = Skin.SCALES;
        this.hairColor = "blue";
        this.hairLength = 2;
        initStrTouSpeInte(615, 700, 735, 280);
        initWisLibSensCor(260, 375, 345, -40);
        this.weaponName = "talons";
        this.weaponVerb = "claw";
        this.weaponAttack = 450;
        this.armorName = "scales and feathers";
        this.armorDef = 1000;
		this.armorMDef = 500;
        this.armorPerk = "";
        this.armorValue = 70;
        this.bonusHP = 7000;
		this.bonusLust = 811;
        this.lust = 30;
        this.lustVuln = .5;
        this.level = 91;
        this.gems = rand(50) + 210;
        this.drop = new WeightedDrop()
            .add(consumables.REPTLUM, 35)
            .add(consumables.GLDSEED, 35)
            //.add(consumables.TOTRICE, 20) //same.
            .add(null, 10);
        //Requires importing Cockatrice transformatives and transformation itself
        /*
        this.lowerBody = LowerBody.COCKATRICE;
        this.faceType = Face.COCKATRICE;
        this.tongue.type = Tongue.LIZARD;
        this.ears.type = Ears.COCKATRICE;
        this.eyes.type = Eyes.COCKATRICE;
        this.tail.type = Tail.COCKATRICE;
        */
        this.tail.recharge = 0;
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
		this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
        this.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
        checkMonster();
    }
}
}
