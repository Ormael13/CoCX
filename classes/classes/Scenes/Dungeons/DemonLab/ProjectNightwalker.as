package classes.Scenes.Dungeons.DemonLab {
/**
 * ...
 * @author Canadian Snas
 */

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.internals.WeightedDrop;

public class ProjectNightwalker extends Monster {
    private var _biteCounter:int = 0;
    private var _inDungeon:Boolean;
    private var plantBite:Boolean;
    private var slimeBite:Boolean;
    private var stoneBite:Boolean;

    private function courtesansCall():void {
        outputText("Despite yourself, your eyes blur, red seeping into your vision. A hot flash courses through your body, and you feel a strong urge to bare your neck, to let this creature of the night feed. One bite couldn’t hurt…Right?[pg]");
        var lustMult:Number = 1;
        lustMult += _biteCounter;
        if (player.hasStatusEffect(StatusEffects.IzmaBleed)) lustMult += player.statusEffectv1(StatusEffects.IzmaBleed);
        player.takeLustDamage(lustMult*25, true);
    }

    private function neckbite():void {
        outputText("The vampiress lands, fragile-looking feet bare against the ground. Her eyes glint, and your head pounds. You grasp your temples, hearing a batlike screech pulse through your mind. You stagger, vision blurring as black mist billows around you.[pg]");
        if (player.isGargoyle()) {
            outputText("[Themonster] tries to bite you but quickly steps back holding a hand to her mouth with a surprised yelp of clear pain. You smirk amused... did she seriously try to bite in your stone skin?");
            stoneBite = true;
            takePhysDamage(maxHP() * .1);
        } else if (player.isAlraune()) {
            outputText("[Themonster] tries to bite you but just as her fang pierces your skin she shoves you off and starts spitting.[pg]"
                    + "\"<i>Plant?! You taste like the sun!</i>\"She wails, covering her mouth with one hand.");
            plantBite = true;
            takePhysDamage(maxHP() * .05);
        } else if (player.isSlime()) {
            outputText("You feel a jiggling where your neck had once been, and you tighten your slimy body around the intruding thing sticking into you. You snap out of the mental attack, and you quickly notice that the stupid cunt tried to bite you, and now has her head stuck inside your slimy body. She manages to pull free from your grip, her hair dripping with your slime, and gags, retching as she returns to her original spot.[pg]");
            slimeBite = true;
            addCurse("spe", 50);
        } else {
            addHP(maxHP() * .1);
            var dam:int = this.str * 3;
            for (var i:int = 0; i < _biteCounter; i++) {
                dam += dam * .50;
            }
            _biteCounter++;
            outputText("Suddenly, you feel crimson pain in the back of your neck. You snap out of… whatever that was, and hear her voice behind you.[pg]");
            outputText("“<i>Shh… Sate me, little bloodbag, and I will sate you…mmm…</i>”[pg]");
            outputText("Like hell! You struggle, throwing her off. She giggles, letting go of you and flying back to her original position. As her fangs leave your skin, you can feel the warm pulse of your heartbeat in your neck, your own blood trickling down. Despite yourself, you can feel the warmth spreading to your groin.");
            dam = Math.round(dam);
            player.takePhysDamage(dam);
            player.takeLustDamage(120 + rand(14), true);
        }
    }

    private function faceSitting():void {
        outputText("The Nightwalker spreads her batlike wings, body a blur as she rockets towards you, feet-first.");
        var evade:String = player.getEvasionReason();
        if (evade != null) {
            outputText("\n\nYou duck your head under the rush, catching a whiff of blood as she rockets past. “<i>Oh, sweet blood, you’re only making my meal…sweeter.</i>”");
        } else {
            outputText("You try to block her kick, but at the last minute, she twists nimbly, her leg missing your head. Too late, your eyes widen as her swollen lips collide with your mouth. She wraps her legs around your head as the impact knocks you to the ground. Dazed, you can hear her muffled, high-pitched giggling as her muff seems to clamp down on your lips. Her surprisingly soft ass-cheeks jiggle as you struggle, blocking you from breathing properly. What air you are getting reeks, like blood and semen.");
            player.createStatusEffect(StatusEffects.Straddle, 0, 0, 0, 0);
        }
    }

    public function faceSittingDescript():void {
        if (player.isGargoyle()) {
            outputText("The crazy bitch is latched onto your face, thinking she’s getting something done. While the old you might have had a problem, having her vulva pressed firmly against your lips, this lack of clean air doesn’t affect you now.");
        } else {
            outputText("You’re struggling to breathe, as the crazy lady is hanging onto your head. Her pussy is literally in your face, and you can occasionally see her clit as she clamps down, filling your every breath with the stench of blood. ");
        }
        outputText("<b>All you can do is try to struggle free!</b>");
    }

    public function struggleFaceSitting(wait:Boolean = false):void {
        if (wait) {
            outputText("She thrusts her crotch into your face, burying your face into her snatch. The scent of blood and semen is overpowering, suffocating you as she clams her legs even tighter around your head.");
            player.takeLustDamage(this.lib, true);
            return;
        }
        if (player.isGargoyle()) {
            outputText("You calmly reach up, breaking her leglock with your stony strength. She sputters, but you get a hold of her ankle, throwing her onto the ground. Before the bitch can react, you slam yourself down onto her, elbow-first. You land one punch, then a second, with your stony fists, before she manages to squirm out from underneath you. Getting to her feet, she wipes the blood off her nose. “<i>...Ow.</i>”");
            takePhysDamage(player.str);
            player.removeStatusEffect(StatusEffects.Straddle);
        }
        else if (player.hasPerk(PerkLib.DragonFireBreath) || player.hasPerk(PerkLib.PhoenixFireBreath) || player.hasPerk(PerkLib.FireLord)) {
            outputText("As you grab at the Nightwalker’s ass, trying to push her off your face, you suddenly have a…rather crude idea. If this bitch wants you to breathe her in, you will…but she won’t like it. You inhale deeply, the stench of blood making you gag, but you feel the heat rising within your chest.[pg]");
            outputText("“<i>Yes… Breathe it in, bloodbag. It’ll be over soon…</i>” You grab her thighs, clamping down yourself. She giggles, but her laughter is cut short as you begin to exhale. “<i>Oh, wait, NooooOOOOO!!</i>” Your breath fills the inside of the Nightwalker, and the stench of burning meat fills your nostrils.[pg]");
            outputText("Her scream is guttural, starting out as a blood curdling shriek, but as you break her now limp leglock, grabbing her throat and slamming her into the ground, it dies out to a pained whimper. Her eyes can’t even focus through the sudden pain, and her entire body is shaking. You step back, readying your [weapon], but it’s obvious she’s no longer a threat.[pg]");
            outputText("The nightwalker bitch is broken, the skin around her inner thighs burnt and cracked. Her legs spasm, and every time they move, she lets out a new cry of pain. Her wings flutter against the ground, but it’s obvious that each movement brings her fresh agony.[pg]");
            outputText("You bring down your [weapon], ending the woman’s pain for good"+(player.hasVagina()?", shuddering at the thought of how that must have felt. It was her fault, but… Still… Your own quim itches in sympathy":"")+".[pg]");
            takeFireDamage(maxHP());
            player.removeStatusEffect(StatusEffects.Straddle);
            doNext(SceneLib.combat.endHpVictory);
        }
        //fail
        else if((rand(10) > 0 && player.str100/5 + rand(20) < 23)|| player.hasPerk(PerkLib.FluidBody)) {
            outputText("You bring your arms up, trying to break the crazy vampiress’s grip on your face, but her latex leggings are surprisingly durable, and slippery, preventing you from getting a good grip.")
            player.takeLustDamage(this.lib);
        }
        //success
        else {
            outputText("You grunt in anger, bending your body as quickly as you can. You slam the Nightwalker into the ground, and you can feel her legs loosen around your neck. With a roar of effort, you get a hold of her ankles, break her grip on your face, and throw the crazed blood-lady face-first into the ground. She whips to her feet, beautiful face marred with scratches. Her red eyes flash with anger, and she glares. “<i>You’re going to regret that.</i>”");
            takePhysDamage(this.str);
            player.removeStatusEffect(StatusEffects.Straddle);
        }
    }

    public function clawSwipe():void {
        outputText("The vampire-bitch bares her fangs, rocketing towards you. You brace yourself, but she banks away, turning and wheeling in midair. You have to pivot and move, just to keep her in your field of view![pg]");
        if (player.getEvasionRoll()) {
            outputText("You’re able to keep her in your sight, and you narrowly avoid her claws each time she passes.");
        } else {
            outputText("Unable to move quick enough, she slips your sight, and lands a slash from behind. As you turn, she’s already gone, and you feel a burst of pain from your other side. She giggles, and you see her hovering back where she’d started, licking her fingers greedily.");
            player.takeDamage(this.str + this.weaponAttack);
            player.takeDamage(this.str + this.weaponAttack);
            player.takeDamage(this.str + this.weaponAttack);
            player.takeDamage(this.str + this.weaponAttack);
            player.createOrAddStatusEffect(StatusEffects.IzmaBleed ,1,3);
        }
    }

    override protected function performCombatAction():void {
        if (rand(4) == 0) courtesansCall();
        if (plantBite) {
            outputText("[Themonster] keeps spitting as though she cant get the taste of your blood out of her mouth.");
            takePhysDamage(maxHP() * .05);
        }
        randomiseAction();
    }

    private function randomiseAction():void {
        var choice:Number = rand(6);
        switch (choice) {
            case 0:
            case 1:
            case 2:
                if (plantBite || stoneBite || slimeBite) randomiseAction();
                else neckbite();
                break;
            case 3:
                faceSitting();
                break;
            case 4:
                clawSwipe();
                break;
            default:
                eAttack();
        }
    }

    public override function isFlying():Boolean {
        return !hasStatusEffect(StatusEffects.Stunned);
    }

    override public function defeated(hpVictory:Boolean):void {
        if (inDungeon) SceneLib.dungeons.demonLab.afterNightwalkerFight();
		else {
            outputText("The Vampire falls, blood spilling from her fatal wounds. Seemingly entranced by the flowing crimson, the creature licks it, then sinks its fangs deep into its own flesh. You watch, horrified, as it looks at you and laughs, crimson tears dripping from her fangs…and pooling in the injury, pouring out onto the ground.[pg]");
            outputText("“<i>Blood for me...Blood for me!</i>” It looks at you, as if amused greatly, before biting itself again and again, pulling the fangs out each time. Sickened by the foul creature’s behavior, you walk up to it, taking its head and feeling the sickening pop as you snap its neck. You head back towards your camp, the sickening laughter of the deranged creature still ringing in your ears.");
            cleanupAfterCombat();
        }
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        if (inDungeon) SceneLib.dungeons.demonLab.BadEndExperiment();
        else {
            if (plantBite || stoneBite || slimeBite) outputText("The vampire strolls up to you, giving you one last harsh kick in the face as you black out.\n");
            else outputText("The Vampire strolls up to you, grabbing you by your shoulders and sinking her fangs into you, draining you until you pass out.\n");
            cleanupAfterCombat();
        }
    }

    public function ProjectNightwalker() {
        this.a = "the ";
        this.short = "Nightwalker";
        this.long = "This pale temptress floats above the ground, black batlike wings silently flapping to keep her aloft. As you get closer, she rises, just out of melee range. You’ll have to find some other way to deal with her, unless you can fly.";
        this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = (5 * 12) + 6;
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.bodyColor = "pale";
        this.hairColor = "blonde";
        this.hairLength = 16;
        this.level = 85;
        initStrTouSpeInte(500, 450, 550, 420);
        initWisLibSensCor(150, 900, 400, 20);
        this.weaponName = "claw";
        this.weaponVerb = "swipe";
        this.weaponAttack = 100;
        this.armorName = "dress";
        this.armorDef = 110;
        this.armorMDef = 110;
        this.wings.type = Wings.BAT_LIKE_LARGE;
        this.bonusHP = 5000;
        this.bonusLust = 1360;
        this.lustVuln = 0.8;
        this.level = 60;
        this.gems = rand(50) + 75;
        this.drop = new WeightedDrop().add(consumables.VAMPBLD, 5).add(jewelries.POWRRNG, 1);
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
        this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
        if (inDungeon) this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
        checkMonster();
    }
}
}