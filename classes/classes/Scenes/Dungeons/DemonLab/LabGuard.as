package classes.Scenes.Dungeons.DemonLab {
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.CockTypesEnum;
import classes.Items.DynamicItems;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.WeightedDrop;

/**
 * ...
 * @author Canadian Snas
 */

public class LabGuard extends Monster {
    public function LabGuard() {
        this.a = "the ";
        this.short = "Demon Guards";
        this.imageName = "demonmob";
        this.long = "This horde of demons are heavily armed with a mixture of shields, spears, swords and whips. There’s a line of heavily armoured warriors in front, but behind them, a line of scrawny incubuses wielding odd firearms stand. Behind them, a line of succubi crouches, but you can feel the lust magic from here. Unlike your typical mob of demons, this bunch are fairly normal in proportion, with no ludicrously oversized body parts. Horns, demonic heels and various animalistic body parts are on display, but the look in these demons' eyes tell you that they're not here for pleasure...Right now.";
        this.plural = true;
        this.pronoun1 = "they";
        this.pronoun2 = "them";
        this.pronoun3 = "their";
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
        initStrTouSpeInte(170, 290, 280, 40);
        initWisLibSensCor(40, 150, 80, 100);
        this.weaponName = "claws";
        this.weaponVerb = "weapons";
        this.weaponAttack = 89;
        this.armorName = "demonic skin";
        this.armorDef = 85;
        this.armorMDef = 60;
        this.bonusHP = 1700;
        this.bonusLust = 287;
        this.lust = 20;
        this.level = 57;
        this.gems = rand(60) + 200;
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
        this.createPerk(PerkLib.OverMaxHP, 57, 0, 0, 0);
        checkMonster();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.AfterLabGuardsVictory();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment(); //TODO
    }

    public var shieldWall:Boolean = false;

    private function CorShields():void {
        if (DemonLab.TyrantFollower) {
            outputText("The shieldwall demons brace themselves for impact, but your Drider lover whoops, her massive, armoured frame slamming into the wall, sending demon soldiers scattering every which way.\n\n");
        } else {
            outputText("You see the demons in front crouching, planting their shields and readying counterattacks. Melee combat seems to be unadvised, unless you want to end up a pincushion!\n\n");
            shieldWall = true;
        }
    }

    private function CorVolley():void {
        if (DemonLab.KihaFollower) {
            outputText("As the ranged weapons begin to poke out from behind the demonic horde, your dragoness lover takes to the air, unleashing a massive blast of flame. Screams and explosions erupt from the demonic lines, and many of those that weren’t hit are either blinded, or shoot instinctively at your dragoness. Kiha swerves in midair, taking no visible hits as she flies back towards more friendly airspace.\n\n");
        } else {
            outputText("The rangers in the middle of the demon’s formation cackle loudly, and you realise, as the warriors in front crouch, that there are a lot of guns aimed at you. ");
            if (player.shield.isNothing) {
                outputText("The hail of bullets is too much to dodge entirely! You duck and weave, but some find their mark.");
                player.takePhysDamage(int(spe * 25) - rand(player.touStat.core.value) - player.armorDef);
            } else {
                outputText("You cover yourself with [shield], but some of the bullets find their mark.");
                player.takePhysDamage(int(spe * 20) - rand(player.touStat.core.value) - player.armorDef);
            }
            outputText("\n\n")
        }
    }

    private function CorSupport():void {
        if (DemonLab.DivaFollower) {
            outputText("A suggestive giggle fills the air, and you notice several demons retreating from the front lines, pulled back into their succubi allies. However, before they can have more than a moment’s relief, Diva swoops down from the ceiling, picking up a succubus in her hands and chomping down on the unfortunate demon’s neck. Unlike her usual, sensual bites, this is a savage chomp, straight to the jugular. Diva spins in midair, throwing the bleeding demon down into the horde, disrupting the temptress’ attempts to heal their allies. Several blasts of various magics shoot from the demons in retaliation, but your nimble Draculina is already gone, her wings carrying her out of the magic’s range. ");
            outputText("“<i>Tremble in fear, demon scum!</i>” She calls haughtily. “<i>Fear what thou hast wrought!</i>”");
        } else {
            outputText("You hear a little chuckle, a demonic laugh that sends the [skin] on the back of your neck crawling. You see the demonic soldiers you’d just injured being pulled back behind the front, and you can hear gasps, moans and whispers, oddly as loud as the sounds of battle. Your vision blurs for a moment, and you can feel a throbbing in your groin. The sounds fade, leaving you flushed, and the soldiers who’d been pulled back are elbowing their way to the front, faces red, dicks or clits engorged, and a smile on each ‘healed’ face. You notice many of the injuries they’ve sustained are gone. ");
            addHP(inteligencescalingbonus() * 4);
            player.takeLustDamage(5 + (player.lib / 10) + (player.cor / 10) + rand(10), true);
        }
        outputText("\n\n");
    }

    private function FrontlineAttack():void {
        outputText("A half-dozen demons break formation, frontline warriors advancing fast. They stab and slash, coming from multiple angles, different weapons and heights whipping towards you.");
        if (player.getEvasionRoll()) {
            outputText("Weaving like a leaf in the storm" + (player.shield.isNothing ? "" : ", blocking several strikes with your [shield]") + ", you somehow manage to avoid harm.")
        } else {
            outputText("Unable to block so many different attacks, they open some injuries on your [skin].");
            for (var i:int = 0; i < 3 + rand(2); ++i)
                eOneAttack(true);
        }
    }

    private function SeductionAttack():void {
        outputText("A jeer rises from the horde in front of you, and a thin line of succubi take places beside the heavily armed warriors. You brace yourself for an attack, but it doesn’t come. As one, the line of scantily clad demonesses slide their thongs, bikini bottoms, whatever they happened to be wearing, aside, showing you a smorgasbord of pussy. Some start fingering themselves, dripping cunts drooling their love juices to the ground, while others with more…masculine endowments begin openly stroking themselves. No few get their asses slapped by their fellows, and a few of the armoured incubi find themselves carrying a naked succubus, as the temptresses rub their crotches up and down the cold metal. ");
        outputText("Moans, wet slaps, and the deep purr of male satisfaction fill the air, but underneath, you can hear faint whispers from multiple demons, both male and female, as their smouldering eyes fix on you, and you alone. ");
        outputText("“<i>Come join us.</i>” they whisper.");
        if (player.hasCock()) outputText(" You can all but feel your [cock] jamming into the tight passage of a succubus, her walls pressing around you, milking your rod for all the slut’s worth. You can feel your hands around her neck, forcing the bitch to wail as you ravage her cunt, forcing her lips wide as you spurt your load inside…");
        if (player.hasVagina()) outputText(" Your labia quivers at the sight, your knees shake as you can all but feel the throbbing rods inside you, veins pulsing. Warmth spreads to your womb as you can feel the twitch, as the demon’s sperm erupts into…");
        outputText(" You shake yourself, [weapon] lashing at the two demons who broke formation, arms wide as if to embrace you. They flee back to the lines, but you can feel your arousal growing, the pink mists of lust magic in the air around you. ");
        player.takeLustDamage(200 + (player.lib / 8) + (player.cor / 4) + rand(10), true);
    }

    private function ThrownWeapons():void {
        outputText("The demons in the front line duck, and your eyes widen as succubi and incubi alike unleash a barrage of thrown weapons. Spears, axes, throwing knives, rocks, even a dildo or two, thrown from the back. One bounces off your forehead, leaving a sticky splatter. ");
        for (var i:int = 0; i < 10; ++i) {
            if (rand(2) == 0)  eOneAttack(true);
            else player.takeLustDamage(10 + (player.lib / 20) + (player.cor / 20) + rand(10), true);
        }
    }

    override public function preMeleeDmg(damage:Number):Number{
        //Lab Guard tanking
        if (shieldWall && !hasStatusEffect(StatusEffects.Stunned)) {
            eOneAttack(true);
            if (Math.round(player.HP) <= Math.round(player.minHP())) {
                doNext(SceneLib.combat.endHpLoss);
                return damage;
            }
            damage /= 2;
        }
        return damage;
    }

    override protected function performCombatAction():void {
        if (shieldWall) shieldWall = false;
        CorShields();
        CorVolley();
        CorSupport();
        var choice0:Number = rand(2);
        switch (choice0) {
            case 0:
                FrontlineAttack();
                break;
            case 1:
                SeductionAttack();
                break;
            case 2:
                ThrownWeapons();
                break;
        }
    }
}
}