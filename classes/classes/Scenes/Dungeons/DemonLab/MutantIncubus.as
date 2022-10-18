package classes.Scenes.Dungeons.DemonLab {
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.Items.DynamicItems;
import classes.Items.WeaponLib;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.WeightedDrop;

/**
 * ...
 * @author ...
 */
public class MutantIncubus extends Monster {

    public function MutantIncubus() {
        this.a = "the ";
        this.short = "Mutant Incubus";
        this.imageName = "demonmob";
        this.long = "You're fighting a mutant Incubus. The right side of his face is noticeably larger than the left, and his eye glows with a sickening purple light, not unlike the eyes of the Driders you’ve met in the swamp. He wears two blades, one at each hip, with an oddly pink, circular guard. He also has a tail, but instead of the usual spadelike tip, his tail ends in a vicious looking stinger, dripping with venom. ";
        this.plural = false;
        this.pronoun1 = "he";
        this.pronoun2 = "him";
        this.pronoun3 = "his";
        this.createCock(18, 2);
        this.createCock(18, 2, CockTypesEnum.DEMON);
        this.balls = 2;
        this.ballSize = 1;
        this.cumMultiplier = 3;
        // this.hoursSinceCum = 0;
        this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
        createBreastRow(0);
        this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
        this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
        this.tallness = rand(8) + 70;
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "red";
        this.hairColor = "black";
        this.hairLength = 15;
        initStrTouSpeInte(100, 150, 200, 340);
        initWisLibSensCor(140, 350, 80, 100);
        this.weaponName = "claws";
        this.weaponVerb = "stab";
        this.weaponAttack = 40;
        this.armorName = "demonic skin";
        this.armorDef = 85;
        this.armorMDef = 60;
        this.bonusHP = 400;
        this.bonusLust = 575;
        this.lust = 20;
        this.level = 45;
        this.gems = rand(60) + 20;
        this.randomDropChance = 0.1;
        this.randomDropParams = {
            rarity: DynamicItems.RARITY_CHANCES_LESSER
        };
        this.drop = new WeightedDrop().addMany(1,
            consumables.SUCMILK,
            consumables.INCUBID,
            consumables.OVIELIX,
            consumables.B__BOOK);

        this.tailType = Tail.DEMONIC;
        this.horns.type = Horns.DEMON;
        this.horns.count = 2;
        this.createPerk(PerkLib.EnemyLargeGroupType, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
        this.createPerk(PerkLib.OverMaxHP, 45, 0, 0, 0);
        checkMonster();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.AfterFirstFight();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment(); //TODO
    }

    private function BladeFlurry():void {
        clearOutput();
        outputText("The mutant Incubus rushes towards you, blades outstretched. \n\n");
        //Miss:
        //Determine if evaded
        if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
            outputText("Using your talent for evasion, you manage to sidestep the creature's clumsy charge.");
        }
        //("Misdirection"
        else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
            outputText("Using your talent for misdirection, you manage to sidestep the creature's clumsy charge.");
        }
        //Determine if cat'ed
        else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
            outputText("Using your cat-like flexibility, you manage to bend your spine backwards. Throwing yourself into a sideways flip, you manage to sidestep the creature's clumsy charge.");
        } else {
            outputText("You try to dodge, but the creature’s fist is too fast, hitting you square in the chest. You’re sent tumbling back.");
            eOneAttack();
            outputText("As it keeps charging through, a few of the drider’s legs come down onto your prone frame, trampling you. ");
            eOneAttack();
            eOneAttack();
            outputText("\n");
        }
    }

    private function HandStab():void {
        clearOutput();
        outputText(capitalA + short + " steps in, stabbing at your chest with one blade. You move, but it was a feint! His other rapier is headed right towards your [weapon] hand.  ");
        //Blind dodge change
        if (hasStatusEffect(StatusEffects.Blind) && rand(3) < 2) {
            outputText("The Incubus's blind stab misses outright.");
        }
        //Determine if dodged!
        else if (player.speedDodge(this) > 0) {
            outputText("You pull your weapon back and the stab whiffs, hitting nothing but air.");
        }
        //Determine if evaded
        else if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
            outputText("You pull your weapon back evasively and the stab goes wide, missing entirely!");
        }
        //Shield Ward
        else if (player.hasPerk(PerkLib.ShieldWard) && rand(2) == 0) {
            outputText("You intercept the Incubus's blade with your shield.");
        } else if (player.weaponName == "spiked gauntlet" || player.weaponName == "hooked gauntlets" || player.weapon == weapons.AETHERD) {
            outputText("The rapier hits your ");
            if (player.weaponName == "spiked gauntlet") outputText("gauntlet, but your armored hand is too tough for the rapier to pierce.\n");
            else outputText("gauntlet, but your armored hand is too tough for the rapier to pierce\n");
        } else {
            outputText("You don't react fast enough, the rapier piercing your hand! You let out a cry of pain, dropping your [weapon] to the ground. You can't give this slippery incubus the opening and pick it up, and your hand is bleeding from the attack.");
            player.createStatusEffect(StatusEffects.Disarmed, 50, 0, 0, 0);
            flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
            player.setWeapon(WeaponLib.FISTS);
            player.createStatusEffect(StatusEffects.IzmaBleed, 2, 0, 0, 0);
        }
    }

    override protected function performCombatAction():void {
        if (rand(2) == 0) HandStab();
        else BladeFlurry();
    }
}

}