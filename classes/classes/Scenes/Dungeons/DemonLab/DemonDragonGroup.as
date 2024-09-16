package classes.Scenes.Dungeons.DemonLab {
import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.WeightedDrop;

/**
 * ...
 * @author Canadian Snas
 */
public class DemonDragonGroup extends Monster {

    public function DemonDragonGroup() {
        this.a = "the ";
        this.short = "Dragon Demons";
        //this.imageName = "goblinwarrior";
        this.long = "Five crimson-scaled beings stand in front of you. Four are female, D-cup breasts and drooling cunts fully exposed. Small demonic horns jut from their foreheads, and their scaled tails are black and red, with a slight spade at the end. They grin at you, reptilian eyes wide with anticipation as they bob from side to side on taloned feet. In their hands are thin steel spears, and as they eye you, undisguised lust in their eyes. The final draconic being stands a half-foot taller than the next largest dragonoid, barrel-chested and heavily armoured, wielding a sword over eight feet long, he takes a step towards you. Bull-like horns on the top of his head glint in the firelight, and his scent, like burnt semen, washes over you.";
        this.plural = true;
        if (player.hasCock()) this.long += "\n\nWhile the four dragonesses seem interested in your manmeat, the male seems angered by the attention you seem to be getting";
        this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
        //this.createCock ();
        this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
        createBreastRow(Appearance.breastCupInverse("D"));
        this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.createStatusEffect(StatusEffects.BonusACapacity, 30, 0, 0, 0);
        this.tallness = 104 + rand(7);
        this.hips.type = Hips.RATING_AMPLE + 2;
        this.butt.type = Butt.RATING_LARGE;
        this.bodyColor = "crimson";
        this.hairColor = "black";
        this.hairLength = 4;
        this.horns.type = Horns.DRACONIC_X2;
        this.horns.count = 2;
        this.tailType = Tail.DRACONIC;
        this.wings.type = Wings.DRACONIC_LARGE;
        initStrTouSpeInte(375, 290, 220, 112);
        initWisLibSensCor(100, 445, 105, 100);
        this.weaponName = "spears and claws";
        this.weaponVerb = "slash";
        this.weaponAttack = 312;
        this.armorName = "scales";
        this.armorDef = 156;
        this.armorMDef = 99;
        this.bonusHP = 2400;
        this.bonusLust = 610;
        this.lust = 50;
        this.lustVuln = 0.44;
        this.level = 60;
        this.gems = rand(50) + 75;
        this.drop = new WeightedDrop().add(useables.D_SCALE, 5).add(consumables.LETH1TE, 3).add(consumables.LETH2TE, 2).add(jewelries.POWRRNG, 1);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
        this.createPerk(PerkLib.MonsterRegeneration, 2, 0, 0, 0);
		this.createPerk(PerkLib.EnemyDragonType, 0, 0, 0, 0);
        if (inDungeon) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
        checkMonster();
    }

    public function meleeResponse():void {
        // when you use melee, chance is reduced to 50% if you’re flying
        if (!player.isFlying() || rand(2) == 0) {
            outputText("You rush towards the corrupted dragonoids, but before you can get near them, three of the succubi-dragons take a half-step forward, letting a sound somewhere between a moan and a belch escape their lips. A wall of flame erupts in your path. ");
            if (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity)) outputText("You laugh, the dragon’s breath feeling like a warm breeze. You barrel through the flame.")
            else player.takeFireDamage(((inte + wis) * 1.2) + rand(80), true);
            outputText("\n\n");
        }
    }

    private function PentaFireBreath():void {
        var damage:Number = (inte + wis) * 3 * player.newGamePlusMod() + 900 + rand(100);
        outputText("The draconic demonesses fan out, spears held in front of them. As you swivel your eyes between them, you notice that one of them is inhaling deeply, nostrils beginning to glow. Your eyes widen as you feel the air around you warm up. The dragoness moans, sending a veritable wall of flames at you.\n");
        if (player.getEvasionRoll()) {
            outputText("You manage to sidestep the worst of the flames, only to have another burst fly at you a split second later. And another. And another. You cover your eyes, only to see a final, larger burst of blue flame headed your way. ");
            damage /= 2;
        } else {
            outputText("You try to avoid the flames, but you're too slow!  The inferno slams into you, setting you alight!  You dive to one side, but as you do, another jet of burning flames wash over you, sending you staggering back. All five dragons unleash their burning breath in sequence. ");
        }
        player.takeFireDamage(damage, true);
        player.takeFireDamage(damage, true);
        player.takeFireDamage(damage, true);
        player.takeFireDamage(damage, true);
        player.takeFireDamage(damage * 1.2, true);
    }

    public function DragonDemonHaremTease():void {
        outputText("The four demonic dragonesses look at each other, flicking their long tongues out. The male steps back, bringing one hand to his tapered draconic cock, while the two closest dragonesses lean in, holding their spears with their flexible tails as they make out in front of him. Their sloppy kisses send drool down their cleavage, and they rub the male’s extended cock with their thighs. Distracted by the lewd display, you notice that the other two are rubbing their ribbed spear shafts across their muffs, moaning as they bite their lips.\n\n")
        outputText("<i>“Wouldn’t you rather join us?”</i> One of the outer women coos. <i>“Put down your weapon. That’s all you’d need to do.”</i> ")
        player.takeLustDamage(Math.round(120 + (player.lib * 2)), true);
    }

    public function ComboDragonStrike():void {
        outputText("You realise what they’re trying to do, and before they can trap you, you rush one of the draconic women, narrowly dodging her spear and slamming your [weapon] into her face. Formation broken, the women fly back towards their leader, spears now bristling defensively. ");
        var hit:int = 0;
        for (var i:int = 0; i < 4; ++i) {
            if (!player.getEvasionRoll()) {
                eOneAttack(true);
                ++hit;
            }
        }
        if (hit == 0) {
            outputText("\nYou realise what they’re trying to do, and before they can trap you, you rush one of the draconic women, narrowly dodging her spear and slamming your [weapon] into her face. Formation broken, the women fly back towards their leader, spears now bristling defensively.");
        } else if (hit == 4) {
            outputText("\nAs the four dragon women impale you, spearheads stuck in your flesh, the larger male roars, swinging his giant sword down towards your shoulder. ");
            player.takePhysDamage(eBaseDamage() * 3);
        }
    }

    override public function midAttackSeal():Boolean{
        meleeResponse();
        return true;
    }

    override protected function performCombatAction():void {
        var choice0:Number = rand(2);
        switch (rand(3)) {
            case 0:
                ComboDragonStrike();
                break;
            case 1:
                DragonDemonHaremTease();
                break;
            case 2:
                PentaFireBreath();
                break;
        }
    }

    override public function defeated(hpVictory:Boolean):void {
        if (inDungeon) SceneLib.dungeons.demonLab.FSpreaderVictory();
		else cleanupAfterCombat();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        if (inDungeon) SceneLib.dungeons.demonLab.BadEndExperiment();
		else cleanupAfterCombat();
    }

}

}