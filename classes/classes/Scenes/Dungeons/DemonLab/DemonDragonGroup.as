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
 * @author ...
 */
public class DemonDragonGroup extends Monster {

    public function DemonDragonGroup() {
        this.a = "the ";
        this.short = "Dragon Demons";
        //this.imageName = "goblinwarrior";
        this.long = "Five crimson-scaled beings stand in front of you. Four are female, D-cup breasts and drooling cunts fully exposed. Small demonic horns jut from their foreheads, and their scaled tails are black and red, with a slight spade at the end. They grin at you, reptilian eyes wide with anticipation as they bob from side to side on taloned feet. In their hands are thin steel spears, and as they eye you, undisguised lust in their eyes. The final draconic being stands a half-foot taller than the next largest dragonoid, barrel-chested and heavily armoured, wielding a sword over eight feet long, he takes a step towards you. Bull-like horns on the top of his head glint in the firelight, and his scent, like burnt semen, washes over you.";
        this.plural = true;
        if (player.hasCock()) this.long += "\n\n  While the four dragonesses seem interested in your manmeat, the male seems angered by the attention you seem to be getting";
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
        initStrTouSpeInte(375, 280, 220, 112);
        initWisLibSensCor(100, 445, 105, 100);
        this.weaponName = "spears and claws";
        this.weaponVerb = "slash";
        this.weaponAttack = 272;
        this.armorName = "scales";
        this.armorDef = 106;
        this.armorMDef = 59;
        this.bonusHP = 2400;
        this.bonusLust = 690;
        this.lust = 50;
        this.lustVuln = 0.44;
        this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
        this.level = 50;
        this.gems = rand(50) + 75;
        this.drop = new WeightedDrop().add(useables.D_SCALE, 5).add(useables.LETHITE, 2).add(jewelries.POWRRNG, 1);
        this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
        this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);

        checkMonster();
    }

    //TODO: use!
    private function PentaFireBreath():void {
        //multi-hit fire breath. Not completely avoidable.
        var damage:Number = ((inte + wis) * 1.2) + rand(80);
        outputText("The draconic demonesses fan out, spears held in front of them. As you swivel your eyes between them, you notice that one of them is inhaling deeply, nostrils beginning to glow. Your eyes widen as you feel the air around you warm up. The dragoness moans, sending a veritable wall of flames at you. \n");

        //Miss:
        //TODO: PLEASE FIX THE REPITITION OR I WILL EAT YOUR SOUL!!!
        //Determine if evaded
        if (player.hasPerk(PerkLib.Evade) && rand(100) < 10) {
            outputText("Using your talent for evasion, you manage to sidestep the worst of the flames, only to have another burst fly at you a split second later. And another. And another. You cover your eyes, only to see a final, larger burst of blue flame headed your way.");
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage * 0.7, true);
        }
        //("Misdirection"
        else if (player.hasPerk(PerkLib.Misdirection) && rand(100) < 10 && (player.armorName == "red, high-society bodysuit" || player.armorName == "Fairy Queen Regalia")) {
            outputText("Using your talent for misdirection, you manage to sidestep the worst of the flames, only to have another burst fly at you a split second later. And another. And another. You cover your eyes, only to see a final, larger burst of blue flame headed your way.");
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage * 0.7, true);
        }
        //Determine if cat'ed
        else if (player.hasPerk(PerkLib.Flexibility) && rand(100) < 6) {
            outputText("Using your cat-like flexibility, you manage to bend your spine, dodging the first burst cleanly. A second, then third are launched, at different angles, and you contort, your extremely flexible body allowing you to narrowly evade the worst of the flames. This seems to interest the draconic male, his eyes lighting up. You're not sure you like the look he's giving you.");
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage / 2, true);
            player.takeFireDamage(damage * 0.7, true);
        } else {
            damage = Math.round(90 + rand(10) + (player.newGamePlusMod() * 30));
            outputText("You try to avoid the flames, but you're too slow!  The inferno slams into you, setting you alight!  You dive to one side, but as you do, another jet of burning flames wash over you, sending you staggering back. All five dragons unleash their burning breath in sequence.");
            player.takeFireDamage(damage, true);
            player.takeFireDamage(damage, true);
            player.takeFireDamage(damage, true);
            player.takeFireDamage(damage, true);
            player.takeFireDamage(damage * 1.2, true);
            outputText("\n");
        }
    }

    //TODO: use!
    public function DragonDemonHaremTease():void {
        outputText("The four demonic dragonesses look at each other, flicking their long tongues out. The male steps back, bringing one hand to his tapered draconic cock, while the two closest dragonesses lean in, holding their spears with their flexible tails as they make out in front of him. Their sloppy kisses send drool down their cleavage, and they rub the male’s extended cock with their thighs. Distracted by the lewd display, you notice that the other two are rubbing their ribbed spear shafts across their muffs, moaning as they bite their lips. ")
        outputText("<i>“Wouldn’t you rather join us?”</i> One of the outer women coos. <i>“Put down your weapon. That’s all you’d need to do.”</i> ")
        player.dynStats("lus", Math.round(120 + (player.lib * 1.4)));
    }

    //TODO: use!
    public function ComboDragonStrike():void {
        clearOutput();
        outputText("All five dragonoids spread their wings, the armoured male flying straight towards you, the other four flying to the sides, flanking you with disturbing ease. With a cry of elation, the draconic succubi stab at you with their spears. \n\n");
        createStatusEffect(StatusEffects.Attacks, 2 + rand(2), 0, 0, 0);
        //if four attacks land
        //outputText("As the four dragon women impale you, spear heads stuck in your flesh, the larger male roars, swinging his giant sword down towards your shoulder. \n\n");
        //createStatusEffect(StatusEffects.Attacks, 1);
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.FSpreaderVictory();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment();
    }

}

}