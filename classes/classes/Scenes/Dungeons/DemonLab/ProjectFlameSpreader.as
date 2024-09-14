package classes.Scenes.Dungeons.DemonLab {
/**
 * ...
 * @author Canadian Snas
 */

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.KihaFollower;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.internals.WeightedDrop;

public class ProjectFlameSpreader extends Monster {

    private function flameAttack():void {
        outputText("The Flamespreader flaps her wings, launching her body towards you. Her spear, blade adorned with violent pink and red runes, sends heat through your body as it draws near. She stabs at you twice, following it up with a burst of flame to cover her retreat.");
        var damage:Number = ((str + tou) * 1.2);
        player.takePhysDamage(damage + rand(50), true);
        player.takePhysDamage(damage + rand(50), true);
        player.takeFireDamage(damage/2, true);
    }

    private function tease():void {
        outputText("The demoness plants her spear’s blade in the ground. Two wide, curved guards on either side of the shaft sit about a foot off the ground, and she plants her shapely ass onto it, wrapping her scaly, spade-tipped tail around the shaft. Leaning into her spear, she moans, sliding the shaft between her average-sized breasts. You see the spear dampen, the shaft slicken with her juices.");
        player.takeLustDamage(50 + (player.cor / 5) + (player.lib / 5), true);
    }

    private function feralAttack():void {
        outputText("The demoness roars, throwing her spear at you with all her might! Distracted by the spear, you narrowly dodge, only to see her flying at you, head-first. Claws bared, she takes several swipes at you, then follows up with her taloned feet! A blur of leathery wings and glinting claws, she opens several wounds in your [skin] ");
        var damage:Number = str ;

        if (rand(3) == 0) player.takePhysDamage(damage+ rand(50), true);
        if (rand(3) == 0) player.takePhysDamage(damage+ rand(50), true);
        if (rand(3) == 0) player.takePhysDamage(damage+ rand(50), true);
        if (rand(3) == 0) player.takePhysDamage(damage+ rand(50), true);
        if (rand(3) == 0) {
            outputText("The dust blown up by her wings gets in your eyes, blinding you.");
            player.createStatusEffect(StatusEffects.Blind, 0, 0, 0, 0);
        }
    }

    override protected function performCombatAction():void {
        randomiseAction();
    }

    private function randomiseAction():void {
        var choice:Number = rand(4);
        switch (choice) {
            case 0: flameAttack();
                break;
            case 1: tease();
                break;
            case 2: feralAttack();
                break;
            default:
                eAttack();
        }
    }

    public override function isFlying():Boolean {
        return !hasStatusEffect(StatusEffects.Stunned);
    }

    override public function defeated(hpVictory:Boolean):void {
        outputText("[pg]While the area around you is scorched by the Flamespreader’s breath, you walk over to the injured creature as it lies on its back. It wiggles its shapely ass, presenting itself to you. It still shoots fire from its mouth, and you take no chances. You bring your [weapon] down onto the Flamespreader’s head, ending its life. As the light fades from its eyes, the malice seems to fade, and the sinister smile becomes something more genuine.[pg]");
        outputText("“<i>Thank…</i>” The creature can’t say anything more...But you know what it was going to say.[pg]");
        if (flags[kFLAGS.PLAYER_COMPANION_1] == "Kiha")
            outputText("You turn back to see Kiha looking down at the creature, a mixture of sadness and anger on her face. She hefts her axe, and without a word, she cleaves a small tree in two. Wordlessly, you and your dragoness carry the body back to the village, where she already has a grave marked. Kiha nods in thanks, and you leave her, heading back to camp.");
        else
            outputText("You close the creature’s eyes and head back to camp.");
        KihaFollower.FlameSpreaderKillCount++;
        cleanupAfterCombat();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        outputText("[pg]You fall back from a particularly brutal blow. The flamespreader walks slowly over, licking her lips.");
		if (flags[kFLAGS.PLAYER_COMPANION_1] == "Kiha" || flags[kFLAGS.PLAYER_COMPANION_2] == "Kiha" || flags[kFLAGS.PLAYER_COMPANION_3] == "Kiha") outputText(" Kiha roars, swinging her axe at the slutty dragoness, but she too is weakened from the fight, and the flamespreader easily parries. She knocks Kiha out with a single strike, and looms over you.");
		outputText("[pg]“<i>How…delicious.</i>” She looms over you, her cunt drooling and C cups bouncing slightly with each step.[pg]");
		if (player.hasCock()) {
			outputText("The flamespreader uses her talons to bare your [cock]. You try to move, but she plants one talon on your chest, leaning heavily on it.[pg]");
			outputText("“<i>No…You’re my toy now.</i>” She grabs your neck, and begins to choke the life out of you! You struggle, grabbing her arms, but you’re too weak to resist as she wraps her tail around your neck, "+(player.isNaked()?"":"removing your [armor] ")+"drawing a thin line down your chest with a single talon.[pg]");
			outputText("You begin to black out, spots filling your vision. You feel the scaly noose around your neck loosen, and you breathe, gasping for air…only to stop, stunned, as the demon-dragoness slams herself onto your [cock].[pg]");
			outputText("“<i>Not bad. Shame it’s wasted on a weakling like you.</i>” You open your mouth to respond, but she chokes you again, planting her feet on either side of your hips while her tail remains firmly around your neck. Despite yourself, her slender body is arousing, and you can see everything.[pg]");
			outputText("Now properly situated, the dragoness begins pumping herself up and down your [cock], while you fade in and out of consciousness. At some point, you feel yourself twitching, the weight upon your pelvis begins to lift.[pg]");
			outputText("“<i>Mm…I wish all of Mareth could put up a fight like that.</i>” You hear, before the flamespreader flies off. You can barely even keep your eyes open, and you faint again.[pg]");
		}
		else outputText("She dives towards your groin, but to her displeasure, finds no cock there. She scoffs, shaking her head. “<i>Useless cunt</i>” , she mutters. You try to stand, but she ruthlessly kicks you across the face. You lie back, dazed, only to see the rapidly approaching shadow of her taloned foot again.[pg]");
		cleanupAfterCombat();
    }

    public function ProjectFlameSpreader() {
        this.a = "the ";
        this.short = "Flamespreader";
        this.long = "[Themonster] has dusky brown skin, red scales from calf to neck, and slender curves. You look at her face, with draconic fangs, demonic horns and reptilian eyes. Flames jet from her nose with every breath, and she shifts her weight from side to side. She’s an odd mix of dragon and demon, with wide, womanly hips. She plants her spear, wings flapping.";
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = (6 * 12);
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.bodyColor = "red";
        this.hairColor = "black";
        this.hairLength = 16;
        this.level = 85;
        initStrTouSpeInte(700, 650, 750, 420);
        initWisLibSensCor(150, 1200, 500, 20);
        this.weaponName = "spear";
        this.weaponVerb = "stab";
        this.weaponAttack = 100;
        this.armorName = "scales";
        this.armorDef = 110;
        this.armorMDef = 80;
        this.wings.type = Wings.BAT_LIKE_LARGE;
        this.bonusHP = 5000;
        this.bonusLust = 800;
        this.lustVuln = 0.8;
        this.level = 85;
        this.gems = rand(50) + 75;
        this.drop = new WeightedDrop().add(useables.D_SCALE, 5).add(jewelries.POWRRNG, 1);
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
		this.createPerk(PerkLib.EnemyDragonType, 0, 0, 0, 0);
        checkMonster();
    }
}
}