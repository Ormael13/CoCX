/**
 * @author Doc_Vermin
 * Ported to CoCX by Svalkash.
 */
package classes.Scenes.Areas.DefiledRavine {
import classes.*;
import classes.BodyParts.*;
import classes.GlobalFlags.*;
import classes.Items.DynamicItems;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class DemonSoldier extends Monster {
    private static const SEED_COCK_OFFSET:int = 13579;
    private static const SEED_TITS_OFFSET:int = 73591;
    private static const SEED_SKIN_OFFSET:int = 28640;

    private static const SKIN_COLORS_LIST:Array = ["red", "crimson", "blue", "pale blue", "purple", "pink", "pale", "fair", "dark"];

    private var demonGender:int = 0;

    private static const DEMON_GENDER_GENDERLESS:int = 0; //Only a failsafe.
    private static const DEMON_GENDER_MALE:int = 1;
    private static const DEMON_GENDER_FEMALE:int = 2;
    private static const DEMON_GENDER_HERM:int = 3;
    private static const DEMON_GENDER_CUNTBOY:int = 4;
    private static const DEMON_GENDER_SHEMALE:int = 5;
    private static const DEMON_GENDER_MALEHERM:int = 6;

    public function demonTitle(variant:int = 0):String {
        //Variant 0 = no prefix. Variant 1 = 'a'. Variant 2 = 'the',
        var txt:String = "";
        if (variant == 1) txt += ((this.demonGender == 1 || this.demonGender == 3) ? "an" : "a") + " ";
        if (variant == 2) txt += "the ";
        switch (this.demonGender) {
            case 0:
                txt += (variant == 2 ? "neuter demon" : "demonic neuter");
                break;
            case 1:
                txt += "incubus";
                break;
            case 2:
                txt += "succubus";
                break;
            case 3:
                txt += "omnibus";
                break;
            case 4:
                txt += (variant == 2 ? "cuntboy demon" : "demonic cuntboy");
                break;
            case 5:
                txt += (variant == 2 ? "shemale demon" : "demonic shemale");
                break;
            case 6:
                txt += (variant == 2 ? "maleherm demon" : "demonic maleherm");
                break;
            default:
                txt += "demon";
        }
        return txt;
    }

    public function generateAppearance():void {

        var seed:int = rand(1000000); //This goes from 000000 to 999999.

        //Sexual endowment choice
        switch (seed % 3) {
            case 0: //Male
                this.createCock(((seed + Math.floor(seed / 132) + SEED_COCK_OFFSET) % 8) + 8, 2.5, CockTypesEnum.DEMON);
                this.balls = 2;
                this.ballSize = 1;
                if (this.biggestCockLength() >= 12) this.ballSize++;
                break;
            case 1: //Female
                this.createVagina(false, 4, 2);
                this.balls = 0;
                this.ballSize = 0;
                break;
            case 2: //Hermaphrodite
                this.createCock(((seed + Math.floor(seed / 132) + SEED_COCK_OFFSET) % 8) + 8, 2.5, CockTypesEnum.DEMON);
                this.createVagina(false, 4, 2);
                this.balls = 2;
                this.ballSize = 1;
                if (this.biggestCockLength() >= 12) this.ballSize++;
                break;
            default: //Genderless, ABORT!
                this.balls = 0;
                this.ballSize = 0;
        }
        //Boob choice
        switch (rand(2)) {
            case 0: //Tits!
                this.createBreastRow(3 + ((seed + Math.floor(seed / 62) + SEED_TITS_OFFSET) % 7), 1);
                break;
            case 1: //No or small tits!
                this.createBreastRow(0, 1);
                break;
            default: //Failsafe
                this.createBreastRow(0, 1);
        }
        //Skin colour!

        this.bodyColor = SKIN_COLORS_LIST[(seed + Math.floor(seed / 94) + SEED_SKIN_OFFSET) % SKIN_COLORS_LIST.length];
        //Now set gender!
        if (this.hasBreasts()) { //Feminine with tits
            if (this.hasCock() && this.hasVagina()) this.demonGender = DEMON_GENDER_HERM;
            else if (this.hasCock()) this.demonGender = DEMON_GENDER_SHEMALE;
            else if (this.hasVagina()) this.demonGender = DEMON_GENDER_FEMALE;
        } else { //Masculine without tits
            if (this.hasCock() && this.hasVagina()) this.demonGender = DEMON_GENDER_MALEHERM;
            else if (this.hasCock()) this.demonGender = DEMON_GENDER_MALE;
            else if (this.hasVagina()) this.demonGender = DEMON_GENDER_CUNTBOY;
        }
        //Set pronouns.
        switch (this.demonGender) {
            case DEMON_GENDER_MALE:
            case DEMON_GENDER_MALEHERM:
            case DEMON_GENDER_CUNTBOY:
                this.pronoun1 = "he";
                this.pronoun2 = "him";
                this.pronoun3 = "his";
                break;
            case DEMON_GENDER_FEMALE:
            case DEMON_GENDER_HERM:
            case DEMON_GENDER_SHEMALE:
                this.pronoun1 = "she";
                this.pronoun2 = "her";
                this.pronoun3 = "her";
                break;
            default: //Normally never happens, failsafe nonetheless.
                this.pronoun1 = "it";
                this.pronoun2 = "its";
                this.pronoun3 = "its";
        }
        //Adjust image.
        switch (this.demonGender) {
            case DEMON_GENDER_GENDERLESS:
                this.imageName = "demon";
                break;
            case DEMON_GENDER_MALE:
                this.imageName = "demon-male"
                break;
            case DEMON_GENDER_FEMALE:
                this.imageName = "demon-female";
                break;
            case DEMON_GENDER_HERM:
                this.imageName = "demon-herm";
                break;
            case DEMON_GENDER_CUNTBOY:
                this.imageName = "demon-cuntboy"
                break;
            case DEMON_GENDER_SHEMALE:
                this.imageName = "demon-shemale"
                break;
            case DEMON_GENDER_MALEHERM:
                this.imageName = "demon-maleherm"
                break;
        }
    }

    override public function mf(male:String, female:String):String {
        switch (this.demonGender) {
            case DEMON_GENDER_MALE:
            case DEMON_GENDER_MALEHERM:
            case DEMON_GENDER_CUNTBOY:
                return male;
            case DEMON_GENDER_FEMALE:
            case DEMON_GENDER_HERM:
            case DEMON_GENDER_SHEMALE:
                return female;
            default:
                return male;
        }
    }

    //Demon Physical Attack.
    private function demonPhysicalAttack():void {
        var attackChooser:int = rand(6);
        if (player.hasStatusEffect(StatusEffects.Blind) || this.fatigueLeft() < 10) attackChooser = rand(4); //Don't re-apply blind.
        //Scimitar Strike, small damage to HP
        if (attackChooser < 3) {
            outputText("The Demon slashes at you with " + this.mf("his", "her") + " scimitar. ");
            if (player.getEvasionRoll()) {
                outputText("You duck and side-step every slash of the Demon's sword.");
            } else {
                outputText("You fail to avoid in time and the bladed weapon strikes you! ");
                player.takePhysDamage(this.str + this.weaponAttack + 10 + rand(30), true);
            }
        }
        //Flurry, moderate damage to HP
        else if (attackChooser < 4) {
            outputText("The Demon prepares to assault you with a flurry of blows!");
            if (player.getEvasionRoll()) {
                outputText("You manage to evade the Demon's frenzied flurry of blows.");
            } else {
                this.createStatusEffect(StatusEffects.Attacks, 2, 0, 0, 0);
                this.eAttack();
            }
            this.fatigue += 10;
        }
        //Tail Whip, blind chance
        else if (attackChooser < 6) {
            if (player.getEvasionRoll()) {
                outputText("The Demon tries to blind you by flinging dirt into your eyes with " + this.mf("his", "her") + " tail, but you turn your head aside just in time! ");
            } else {
                outputText("The Demon whips " + this.mf("his", "her") + " tail along the ground towards you, flinging a cloud of grit and dirt at your eyes, <b>temporarily blinding you</b>! ");
                player.createStatusEffect(StatusEffects.Blind, 2 + rand(3), 0, 0, 0);
            }
            this.fatigue += 10;
        }
    }

    //Demon Tease Attack.
    private function demonTeaseAttack():void {
        //Pick your poison
        var teaseChooser:int = rand(4);
        if (teaseChooser == 0 && (hasStatusEffect(StatusEffects.TensionReleased) || this.fatigueLeft() < 15)) teaseChooser = 1 + rand(3);
        if (teaseChooser == 1 && this.fatigueLeft() < 10) teaseChooser = 2 + rand(2);
        //Genital tease
        if (teaseChooser == 0 && this.fatigueLeft() < 15 && !this.hasStatusEffect(StatusEffects.TensionReleased)) {
            //Dick tease
            if (this.hasCock() && (rand(2) == 0 || !this.hasVagina())) {
                outputText("The Demon runs " + this.mf("his", "her") + " hands down " + this.mf("his", "her") + " body as " + this.mf("he", "she") + " sensuously arches " + this.mf("his", "her") + " back. " + this.mf("He", "She") + " simultaneously grasps " + this.mf("his", "her") + " bulging demon-dick with both hands and plunges a length of " + this.mf("his", "her") + " tail into " + this.mf("his", "her") + " puckered anus, pressing down on " + this.mf("his", "her") + " prostate as " + this.mf("he", "she") + " pumps hard at " + this.mf("his", "her") + " infernal shaft. A low, reverberating moan bursts forth from the creature as powerful jets of infernal spunk spurt from " + this.mf("his", "her") + " piss-hole, [if (attack hits) “ splashing you from head to toe, the sickly-sweet smell engendering an all-too-familiar warmth in you. “][if (attack misses) “ missing you by a hair's breadth, splashing harmlessly onto the ground.");
            }
            //Pussy tease
            if (this.hasVagina()) {
                outputText("The Demon turns " + this.mf("his", "her") + " back on you, bending over to present " + this.mf("his", "her") + " toned butt-cheeks and plump, drooling pussy-lips to you. " + this.mf("He", "She") + " stuffs as much of " + this.mf("his", "her") + " tail as " + this.mf("he", "she") + " can into " + this.mf("his", "her") + " sopping fuck-hole, pumping in and out of {him/her}self while reaching between " + this.mf("his", "her") + " legs and mercilessly molesting " + this.mf("his", "her") + " pierced clit. " + this.mf("He", "She") + " It yanks out " + this.mf("his", "her") + " fem-spunk slicked tail as an inhuman shriek is released simultaneously with a shower of girl-cum squirted in your direction.[if(attack hits) “ You are soaked through, and the air is permeated with a sickly-sweet smell, engendering an all-too-familiar warmth in you. “][if(attack misses) “ " + this.mf("He", "She") + " It misses you by a hair's breadth, splashing harmlessly onto the ground. “]");
            }
            this.fatigue += 15;
            this.lust -= 30;
            this.createStatusEffect(StatusEffects.TensionReleased, 3, 0, 0, 0); //Add 3-turn cooldown
        }
        //Lust strike
        else if (teaseChooser == 1 && this.fatigueLeft() >= 10) {
            outputText("The Demon seems to be chanting under " + this.mf("his", "her") + " breath and closes " + this.mf("his", "her") + " eyes in concentration as " + this.mf("he", "she") + " points " + this.mf("his", "her") + " sword at you. Suddenly, ribbons of what appear to be pink smoke leap from the tip of the blade towards you, [If(attack hits) “ striking you squarely in the chest, causing an irresistible surge in your sexual desire. “][If(attack misses) “ narrowly missing you as you dodge to the side. “]");
            this.fatigue += 10;
        }
        //Tongue tease
        else if (teaseChooser == 2) {
            outputText("The Demon undulates " + this.mf("his", "her") + " body in a sinuous, seductive motion. As " + this.mf("he", "she") + " does so, " + this.mf("his", "her") + " long, wriggling demonic tongue slips out of " + this.mf("his", "her") + " mouth and begins to writhe across " + this.mf("his", "her") + " body; the squirming rope of flesh explores every exposed inch of the Demon's own skin, finally entwining {him/her}self with the Demon's genitailia, irrisistably drawing your eye to the slimy, pink tip as it probes every fold and drooling hole between the infernal beast's knee and navel. [If(attack hits)The obscene display is highly arousing to you.][if(attack misses) “ [if(corruption < 50) “ This unwholesome display leaves you more disgusted than anything else. “][If(corruption => 50) “ It's a moderately entertaining display, but frankly, you've seen better. “] “]");
        }
        //Leap tease
        else if (teaseChooser == 3) {
            outputText("Flicking " + this.mf("his", "her") + " wings out to full extension, the Demon gives them a hard pump as " + this.mf("he", "she") + " leaps toward you, propelling {him/her}self through the air. [If(attack hits)  “ Spreading " + this.mf("his", "her") + " legs mid-air, the creature attempts a kind of reverse leapfrog, rubbing " + this.mf("his", "her") + " groin across your face as " + this.mf("he", "she") + " passes over you, smearing you with " + this.mf("his", "her") + " hellish sex-juices. [If(isTaur = true) “ The Demon very nearly ends up straddling you equine hind-quarters, but nimbly vaults off again, landing behind you and forcing you to wheel around to face your demonic adversary. “][If(isTaur = false) “ The hellish beast lands behind you, forcing you to wheel around to face your adversary. “] The inescapable odour of the demon-slime coating your face causes you to become aroused. “][If(attack misses) “ You manage to duck and dive to the side, dodging the incoming Demon. Rolling back to your feet you wheel around to face your opponent. “]");
        }
        player.takeLustDamage(5 + (player.lib / 10) + (player.cor / 15) + rand(10), true);
    }

    //Demon Lust Spell. 2-part, avoid or take large lust damage!
    private function demonLustSpell():void {
        //First part: Charge it up.
        if (!hasStatusEffect(StatusEffects.Uber)) {
            outputText("The Demon begins to make a series of mystic gestures as a tiny ball of glowing, pink energy begins to swell in front of the creature.");
            this.createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
        }
        //Second part: Unleash!
        else {
            outputText("The Demon places both hands, wrists together with palms splayed, behind the ever-growing energy ball, and makes a shoving motion towards you! ");
            if (Combat.playerWaitsOrDefends()) { //Used Wait to avoid!
                outputText("Your preparedness from waiting definitely helped you in this situation. You just about succeed in flinging yourself out of the way of the ball of pure lust-energy, much to the chagrin of the Demon.");
            } else { //Didn't use Wait? Get hit!
                outputText("The pink energy washes over you, greatly inflaming your lusts.");
                player.takeLustDamage(10 + (player.lib / 8) + (player.cor / 10) + rand(20), true);
            }
            this.fatigue += 25;
            this.removeStatusEffect(StatusEffects.Uber);
        }
    }

    override public function doAI():void {
        if (hasStatusEffect(StatusEffects.Stunned)) {
            if (!handleStun()) return;
        }
        if (hasStatusEffect(StatusEffects.Fear)) {
            if (!handleFear()) return;
        }
        if (this.hasStatusEffect(StatusEffects.TensionReleased)) { //Cooldown on genital tease.
            this.changeStatusValue(StatusEffects.TensionReleased, 1, statusEffectv1(StatusEffects.TensionReleased) - 1);
            if (statusEffectv1(StatusEffects.TensionReleased) <= 0) removeStatusEffect(StatusEffects.TensionReleased);
        }
        if (this.hasStatusEffect(StatusEffects.Uber)) {
            demonLustSpell();
            return;
        }
        var chooser:int = rand(10);
        if (chooser < 2) {
            if (fatigueLeft() >= 25) demonLustSpell();
            else eAttack(); //No fatigue left
        } else if (chooser < 6) demonPhysicalAttack();
        else if (chooser < 10) demonTeaseAttack();
        else eAttack();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.defiledravine.demonSoldierScene.victoryOverSoldier(hpVictory);
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.defiledravine.demonSoldierScene.defeatedBySoldier(hpVictory);
    }

    public function DemonSoldier() {
        generateAppearance();
        this.a = "the ";
        this.short = "Demon Soldier";
        this.imageName = "demon";

        this.long = "You are fighting " + (this.demonGender == DEMON_GENDER_MALEHERM ? "what, at first appears to be a manly Incubus, but a glimpse of drooling, demonic snatch reveals to be an unusually masculine Omnibus" : this.demonTitle(1)) + ", which appears to be some form of soldier, as " + this.mf("he", "she") + "'s wearing a suit of bronze armour... of a sort: "
        this.long += "a helmet with holes cut for the creature's horns; a sculpted breastplate with a stylised 'L' in the middle of it and jeweled nipples (naturally) and a pair of armoured bracers and shin-guards, etched with scenes of orgiastic debauchery. ";
        if (rand(3) == 0) {
            this.long += "A ragged, off-white and stained loincloth covers the demon's crotch in spite of " + this.mf("his", "her") + " corrupted nature. Judging from the looks, it looks like it's barely doing its job and already features a damp spot.";
        } else {
            this.long += "Apart from various piercings and items of jewelry the Demon is completely naked under " + this.mf("his", "her") + " armour, leaving ";
            if (this.hasCock() && this.hasVagina()) this.long += "both " + this.mf("his", "her") + " sets of infernal genitailia";
            else if (this.hasCock()) this.long += this.mf("his", "her") + " pulsating cock";
            else if (this.hasVagina()) this.long += this.mf("his", "her") + "slavering pussy";
            else this.long += this.mf("his", "her") + "oddly blank crotch"; //Failsafe
            this.long += " fully exposed to view. ";
        }
        this.long += "\n\nThe " + this.demonTitle(0) + " holds " + this.mf("his", "her") + " weapon, a serrated-edged scimitar, with a practiced familiarity which speaks of martial skill, and regards you with an unmistakable, predatory lust.";

        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.tallness = rand(31) + 54;
        this.hips.type = Hips.RATING_BOYISH;
        this.butt.type = Butt.RATING_TIGHT;
        this.hairColor = "black";
        this.hairLength = 5;
        this.wings.type = Wings.BAT_LIKE_LARGE;
        this.tail.type = Tail.DEMONIC;
        this.horns.type = Horns.DEMON;
        this.horns.count = 2;
        initStrTouSpeInte(160, 160, 180, 140);
        initWisLibSensCor(120, 160, 90, 100);
        this.weaponName = "claws";
        this.weaponVerb = "claw-slash";
        this.armorName = "leathery skin";
        this.lust = 40;
        this.level = 50;
        this.bonusHP = this.level * 25;
        this.weaponAttack = 45;
        this.armorDef = 60;
        this.armorMDef = 35;
        this.createPerk(PerkLib.WeaponNormalDoubleAttack, 0, 0, 0, 0);
        this.createPerk(PerkLib.Evade, 0, 0, 0, 0);
        this.gems = rand(5) + 5;
        this.randomDropChance = 0.1;
        this.randomDropParams = {
            rarity: DynamicItems.RARITY_CHANCES_LESSER
        };
        this.drop = new WeightedDrop(consumables.LETH1TE, 2).add(consumables.LETH2TE, 1);
        if (this.demonGender == DEMON_GENDER_CUNTBOY || this.demonGender == DEMON_GENDER_MALE)
            (this.drop as WeightedDrop).add(consumables.INCUBID, 6).add(consumables.BROBREW, 2);
        if (this.demonGender == DEMON_GENDER_SHEMALE || this.demonGender == DEMON_GENDER_FEMALE)
            (this.drop as WeightedDrop).add(consumables.SUCMILK, 6).add(consumables.BIMBOLQ, 2);
        this.special1 = demonTeaseAttack;
        this.special2 = demonLustSpell;
        this.special3 = demonPhysicalAttack;
        checkMonster();
    }

}

}
