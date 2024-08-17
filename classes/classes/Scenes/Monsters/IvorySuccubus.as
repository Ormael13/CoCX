/**
 * @author kitteh660.
 * Ported from UEE to CoCX by Svalkash
 * Succubus, one of the classic encounters from Unnamed Text Game, now modified to be up to modern standards, with new fight.
 */
package classes.Scenes.Monsters {
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Items.DynamicItems;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class IvorySuccubus extends AbstractSuccubus {

    public function succubusBarrage():void {
        outputText("The succubus looks like as if she's running towards you. ");
        if (getEvasionRoll()) {
            outputText("With your efforts in running, you manage to run until she stops giving chase.");
        } else {
            var damage:int;
            outputText("Despite your sprint, it closes the distance and leaps on you, tearing and scratching. ");
            if (rand((player.str / 3) + 10) < ((str / 3) + 10)) {
                outputText("You try to shake her off, but she's too powerful and rains painful scratches and blows before pushing you onto the ground. You get up and get back to fighting. ");
                damage = (30 + str + weaponAttack);
            } else {
                outputText("You bring your strength to bear and throw her off with only minor injuries. ");
                damage = (Math.floor((15 + str) / 2) + weaponAttack);
            }
            player.takePhysDamage(damage, true);
        }
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.ivorySuccubusScene.loseToSuccubus();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.ivorySuccubusScene.winAgainstSuccubus();
    }

    public function IvorySuccubus() {
        this.a = "the ";
        this.short = "ivory succubus";
        this.imageName = "ivorysuccubus";
        this.long = "The succubus before you is a typical example of a lusty demon. Two horns protrude from her forehead, a pair of wings sprout from her back, and a spaded tail swishes about. She's completely nude, leaving her G-cup breasts and moist pussy open for you to see. From time to time, you can see her jiggling ass clearly inviting you. She doesn't appear to be wielding anything.";
        this.flyer = true;
		this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
        this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("G"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_NORMAL;
        this.createStatusEffect(StatusEffects.BonusACapacity, 30, 0, 0, 0);
        this.tallness = 35 + rand(4);
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "ivory";
        this.hairColor = "black";
        this.hairLength = 4;
        initStrTouSpeInte(205, 220, 185, 92);
        initWisLibSensCor(135, 175, 115, 100);
        this.weaponName = "fists";
        this.weaponVerb = "punch";
        this.weaponAttack = 70;
		this.armorName = "skin";
		this.armorDef = 120;
		this.armorMDef = 20;
		this.bonusLust = 317;
        this.lust = 50;
        this.level = 27;
        this.gems = rand(5) + 5;
        this.randomDropChance = 0.1;
        this.randomDropParams = {
            rarity: DynamicItems.RARITY_CHANCES_LESSER
        };
        this.drop = new WeightedDrop().add(consumables.INCUBID, 1)
            .add(consumables.SUCMILK, 1)
            .add(consumables.SDELITE, 1);
        this.special1 = kissAttack;
        this.special2 = seduceAttack;
        this.special3 = succubusBarrage;
		this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
		this.createPerk(PerkLib.OverMaxHP, 27, 0, 0, 0);
        checkMonster();
    }
}
}
