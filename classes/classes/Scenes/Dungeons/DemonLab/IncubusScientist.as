/**
 * ...
 * @author Candian Snas
 */
package classes.Scenes.Dungeons.DemonLab {
import classes.Monster;
import classes.PerkLib;
import classes.CockTypesEnum;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.internals.WeightedDrop;

public class IncubusScientist extends Monster {

    public function IncubusScientist() {
        this.a = "";
        this.short = "incubus Scientist";
        this.long = "This demon is clad in a heavy-looking lab coat, and wears a strange pistol at his hip. Weedy and thin, he doesn't look like he's much of a fighter, but the anger in his gaze is a clear indicator of his intent. He wears an odd contraption on his left hand,"
        this.createCock(18, 2);
        this.createCock(18, 2, CockTypesEnum.DEMON);
        this.balls = 2;
        this.ballSize = 1;
        this.cumMultiplier = 3;
        // this.hoursSinceCum = 0;
        createBreastRow(0);
        initStrTouSpeInte(150, 100, 130, 300);
        initWisLibSensCor(105, 190, 110, 100);
        this.tallness = 84 + rand(7);
        this.weaponName = "gun";
        this.weaponVerb = "shot";
        this.weaponAttack = 86;
        this.armorName = "skin";
        this.armorDef = 28;
        this.armorMDef = 13;
        this.bonusHP = 500;
        this.bonusLust = 350;
        this.level = 50;
        this.additionalXP = 250;
        this.gems = rand(30) + 150;
		this.drop = new WeightedDrop().add(consumables.LETHITE, 2).add(jewelries.RPOWRNG, 1);
        this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
        this.createPerk(PerkLib.OverMaxHP, 50, 0, 0, 0);
        checkMonster();
    }

    private function ForHisNeutralSpecialHeWieldsAGun():void {
        outputText("The demon scientist lines you up in his sights, pulling the trigger several times.")
        //Miss:
        //Determine if evaded
        if (player.getEvasionRoll()) {
            outputText("You dodge the bullets, and they fly past, taking small chunks out of the stone wall behind you.");
        }
        else {
            var damage:Number = 0;
			damage += Math.round((inte + wis + spe + 90 + rand(10) + (player.newGamePlusMod() * 3)) * 10);
            outputText("You can’t even see the projectile as it flies, striking you in the [chest].");
            player.takePhysDamage(damage * 2);
        }
    }

    public var ShieldHits:int;
    private var ShieldCooldown:Number;

    private function ShieldsUp():void {
        outputText("You notice the demon touch something in his lab coat. A thin veil of blue energy forms around him, and he smirks. “<i>Break this, you primitive!</i>”\n\n");
        ShieldHits = 4;
    }

    //TODO: hook these two functions somehow
    public function ShieldsHitMelee():void {
        outputText("Your [weapon] slams hard into the blue light, sliding off it with a shower of sparks.\n\n");
        --ShieldHits;
        if (ShieldHits == 3) {
            outputText("The shield is firm, it’s like hitting a wall!\n\n");
        } else if (ShieldHits == 2) {
            outputText("The light bends to your attack, but springs right back into place.\n\n");
        } else if (ShieldHits == 1) {
            outputText("The shield flashes red, and the demon scientist takes a half-step back, the ferocity of your strike seeming to get to him.\n\n");
        } else if (ShieldHits == 0) {
            ShieldCooldown = 3;
            outputText("You drive your [weapon] through the shield. The demon’s eyes are wide, and he inhales sharply. He presses the button in his coat, but no shield comes back into place. Smoke rises from his coat, and he plants his feet, grinding his teeth.\n\n");
        }
    }

    public function ShieldsHitRanged():void {
        outputText("Your [weapon] slams hard into the blue light, sliding off it with a shower of sparks.\n\n");
        --ShieldHits;
        if (ShieldHits == 3) {
            outputText("Your [projectile] strikes the demon scientist, but he doesn’t even seem to notice the strike. He laughs, raising his pistol and taking another shot at you.\n\n");
            createStatusEffect(StatusEffects.Attacks, 1, 0, 0, 0);
        } else if (ShieldHits == 2) {
            outputText("Your [projectile] strikes the demon scientist, but his shield flashes, blocking the attack. He frowns, raising his pistol and taking another shot at you.\n\n");
            createStatusEffect(StatusEffects.Attacks, 1, 0, 0, 0);
        } else if (ShieldHits == 1) {
            outputText("Your [projectile] strikes the demon scientist's shield, which is visibly cracking'. He sweats, raising his pistol and taking another shot at you.\n\n");
            createStatusEffect(StatusEffects.Attacks, 1, 0, 0, 0);
        } else if (ShieldHits == 0) {
            ShieldCooldown = 3;
            outputText(" The shield shatters, and your [projectile] lands. He looks down at the [projectile] in his gut.\n\n");
        }
    }

    private function serum():void {
        outputText("The demon scientist reaches into his lab coat, pulling out a hypodermic needle.\n"
            + "“<i>The side effects are nasty...but I need the power now.</i>” He sticks himself, and he inhales sharply. He doesn’t look any different, but as he cocks his weapon, you notice the vein pulsing on his forehead. He’s way faster now!");
        buff("Serum").addStats({"spe": 200, "str": -100, "int": -100});
        createPerk(PerkLib.Evade, 0, 0, 0, 0);
        createPerk(PerkLib.ImprovedEvade, 0, 0, 0, 0);
        createPerk(PerkLib.GreaterEvade, 0, 0, 0, 0);
    }

    override public function midAttackSeal():Boolean{
        if (ShieldHits > 0) {
            ShieldsHitMelee();
            return false;
        }
        return true;
    }

    override public function defeated(hpVictory:Boolean):void {
        if (DungeonAbstractContent.dungeonLoc == DungeonAbstractContent.DUNGEON_LAB_ENTRANCE) SceneLib.dungeons.demonLab.AfterFirstFight();
        else cleanupAfterCombat();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment();
    }

    override protected function performCombatAction():void {
        if (ShieldCooldown > 0) --ShieldCooldown;
		if (ShieldCooldown == 0 && ShieldHits == 0) ShieldsUp();
        if (HP < maxHP() * 0.6) {
            serum();
            return;
        }
        ForHisNeutralSpecialHeWieldsAGun();
    }
}
}