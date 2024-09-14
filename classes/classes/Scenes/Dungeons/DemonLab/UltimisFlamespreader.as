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
import classes.internals.SaveableState;
import classes.internals.WeightedDrop;

public class UltimisFlamespreader extends Monster {
    private var gunner1Alive:Boolean;
    private var gunner2Alive:Boolean;

    private function flameAttack():void {
        outputText("Swooping in, the giant Dragon spits blue fire. The area around you erupts into heat and light. ");
        var damage:Number = ((str + tou) * 1.2);
        player.createOrAddStatusEffect(StatusEffects.OnFire, 1, 2);
        player.takeFireDamage(damage, true);
    }

    private function swipe():void {
        outputText("The creature swoops down, and you brace yourself for fire, dodging to one side as it opens its massive maw. However, that was a feint, and the giant being instead adjusts to your dodge, its massive front limb swinging down and raking its massive claws across your entire body.");
        var damage:Number = ((str + tou) * 1.5);
        player.takePhysDamage(damage, true);
    }

    private function nom():void {
        var damage:Number = ((str + tou) * 1.5);
        outputText("Still engulfed in the fire, you are distracted enough for the dragon to land, FAR closer than you want.\n\n");
        if (player.getEvasionRoll()) {
            outputText("You throw yourself to the ground, narrowly avoiding a claw, but the creature still has one limb with easy access. Just in time you see the teeth come flashing down and roll out of the way, but still get bached by [themonster]'s snout.");
            player.takePhysDamage(damage/2, true);
        } else {
            outputText("You throw yourself to the ground, narrowly avoiding a claw, but the creature still has one limb with easy access. The teeth come flashing down, and as the pain wracks you, the creature picks you up in its jaw, squeezing down as if to bite you in half!");
            player.takePhysDamage(damage, true);
            player.createStatusEffect(StatusEffects.DragonsNom, 0, 0, 0, 0);
        }
    }
    public function struggleNom(wait:Boolean):void {
        if (!wait || (rand(10) > 0 && player.str100/5 + rand(20) < 23)|| player.hasPerk(PerkLib.FluidBody)) {
            outputText("You jam your [weapon] into a sensitive spot between the creature’s tongue and lower mouth. It roars in pain, throwing you skywards. You see Kiha, her mighty axe keeping two spears at bay, before you realise what just happened.");
            if (player.canFly()) {
                outputText("You glide back to the ground, readying your [weapon] and staring the creature down. ");
            } else {
                outputText("You fall down, landing with a bone-bruising impact. The dragon’s already moving back towards you, and you force yourself to your [feet]. As bad as you feel, this isn’t over yet. ")
                player.takePhysDamage(200, true);
            }
            player.removeStatusEffect(StatusEffects.DragonsNom);
        } else {
            if (!wait) outputText("You struggle, slamming your [weapon] into the creature’s snout, but it doesn’t let go. ");
            outputText("It lets out a mighty roar through its still clenching teeth, the intensity of its fire breath solely focused on your body. Your [armor] is breaking, and you can smell your own flesh burning!");
            var damage:Number = ((str + tou) * 1.5);
            player.createOrAddStatusEffect(StatusEffects.OnFire, 1, 2);
            player.takeFireDamage(damage, true);
        }
    }

    private function gunnersAttack():void {
        outputText("The "+(gunner2Alive?"two demons":"demon")+" on the Dragon’s back "+(gunner2Alive?"open":"opens")+" fire, spewing bullet after bullet at you. ");
        var attacks:int = (gunner2Alive?10:5);
        while (attacks-->0)
            if (rand(5) == 0) player.takePhysDamage(str/4+rand(50), true);
    }

    override protected function performCombatAction():void {
        if (gunner1Alive) gunnersAttack();
        if (HP < maxHP()*.5 && gunner2Alive) {
            outputText("\nYou smirk a little as one of the demons’ eyes widen, the gun mounted next to him smoking. Suddenly, it explodes, sending a wave of shrapnel and debris tumbling off the makeshift platform.\n");
            gunner2Alive = false;
        } else if (HP < maxHP()*.4 && gunner1Alive) {
            outputText("\nThe second gunner lets out a cry of anguish as his gun too, starts smoking. He hurls himself off the dragon’s back, but it sees him out of the corner of its eye, swiping at the luckless demon with his claw. Sent tumbling by the impact, you watch as the demon hits the ground head-first.\n");
            gunner1Alive = false;
            outputText("[Themonster] shakes the platform free from its shoulders now that it is empty. <b>The dragon’s scales harden, moving closer together with an odd clicking noise.</b>\n");
            this.armorDef *= 2;
			this.armorMDef *= 2;
        }
        randomiseAction();
    }

    private function randomiseAction():void {
        var choice:Number = rand(6);
        switch (choice) {
            case 0:
            case 1:
            case 2: flameAttack();
                break;
            case 3: swipe();
                break;
            case 4: if (!player.hasStatusEffect(StatusEffects.OnFire)) randomiseAction(); 
                nom();
                break;
            default:
                eAttack();
        }
    }

    public override function isFlying():Boolean {
        return !hasStatusEffect(StatusEffects.Stunned);
    }

    override public function defeated(hpVictory:Boolean):void {
        outputText("The massive creature roars in agony. Unable to fly any more, it makes an emergency landing, hitting the ground with its left talons first. Unable to withstand such an impact, you hear the bones break. Shooting flame from its mouth, the crippled dragon flails its wings, trying to lever itself upright, to continue the fight. [pg]");
        outputText("You hear a soft thump beside you as Kiha comes in to land, folding her crimson wings and taking a pensive look at the massive beast. [pg]");
        outputText("“<i>…Good work.</i> Kiha’s words are plain, but her voice is calm, almost reverent. “<i>...Are you okay?</i>” You nod, putting a hand on her shoulder, but Kiha shakes you off. “<i>Come on. Don’t leave it like this.</i>” [pg]");
        outputText("The two of you make short work of the crippled beast, and you turn to Kiha, jokingly asking if she wants to go get the shovels. Her eyes widen, and she puts a hand over her maw. Clearly holding back a laugh, Kiha puts her best ‘serious’ face on. [pg]");
        outputText("“<i>Idiot, there is no way I’m trying to bury that.</i>” You ask her if the great warrior Kiha has finally met a task too much for her, and her mouth twitches, briefly forming a small smile. “<i>Please. That’s how the village elders tried to get us to do extra chores. You’ll need to try harder than that.</i>” [pg]");
        outputText("The two of you head back to camp, leaving the draconic beast behind. Kiha seems distracted, looking up at the sky as if a second one could pop out of thin air. You tell Kiha that the beast you killed must have taken a lot of resources. You doubt they’d try it again, considering how easily the two of you killed it.[pg]");
        outputText("“<i>Always looking up, aren’t you?</i>” Kiha shakes her head. “<i>Come on, let’s go home.</i>”[pg]");
        KihaFollower.FlameSpreaderBossKilled = true;
        cleanupAfterCombat();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        outputText("With one last swipe the Dragon sends you to oblivion.");
        cleanupAfterCombat();
    }

    public function desc():String {
        var desc:String = "The dragon in front of you is a veritable wall of scales and flesh, easily nine meters tall. Despite its size, it hovers off the ground with ease, wings sending gusts of wind through the surrounding area. The creature doesn’t even look humanoid anymore, its proportions more in line with the myths from your homeland. [pg]";
        if (HP > maxHP()*.5) desc += "Two demon soldiers sit on the massive Dragon’s shoulders, each with a large gun of some sort, and a LOT of bullets.";
        else if (HP > maxHP()*.4) desc += "One demon soldier sits on one of the massive Dragon's shoulder with a large gun of some sort, the other gun having exploded.";
        else desc += "Both large guns on the massive Dragon's shoulders have exploded, sending the demons who manned them flying to their doom. ";
        return desc;
    }

    public function UltimisFlamespreader() {
        //_inDungeon = inDungeon;
        gunner1Alive = true;
        gunner2Alive = true;
        this.a = "the ";
        this.short = "Ultimis Flamespreader";
        this.long = desc();
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = (50*12);
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.bodyColor = "red";
        this.hairColor = "black";
        this.hairLength = 16;
        initStrTouSpeInte(950, 1200, 1000, 420);
        initWisLibSensCor(200, 1600, 500, 20);
        this.weaponName = "tail";
        this.weaponVerb = "swipe";
        this.weaponAttack = 300;
        this.armorName = "scales";
        this.armorDef = 150;
        this.armorMDef = 100;
        this.wings.type = Wings.DRACONIC_HUGE;
        this.bonusHP = 50000;
        this.bonusLust = 8000;
        this.lustVuln = 0.8;
        this.level = 85;
        this.gems = rand(50) + 75;
        this.drop = new WeightedDrop().add(useables.D_SCALE, 5).add(jewelries.POWRRNG, 1);
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
		this.createPerk(PerkLib.EnemyDragonType, 0, 0, 0, 0);
        this.createPerk(PerkLib.EnemyColossalType, 0, 0, 0, 0);
        checkMonster();
    }
}
}