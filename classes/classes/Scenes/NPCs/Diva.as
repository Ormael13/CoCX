package classes.Scenes.NPCs {
import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.EngineCore;
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.ChainedDrop;
import classes.Scenes.Combat.SpellsWhite.WhitefireSpell;
import classes.Scenes.Combat.SpellsWhite.BlindSpell;
import classes.Scenes.Combat.CombatAbility;

public class Diva extends Monster {
    private var _biteCounter:int = 0;
    private var finalFight:Boolean = false;
    private var _sonicScreamCooldown:int = 0;

    public function Diva(ff:Boolean = false) {
        this.finalFight = ff;
        var levelBonus:int = ff ? 50 : 20;
        this.a = "";
        this.short = "Diva";
        this.long = "";
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
        initWisLibSensCor(4.5 * levelBonus, 40, 50, 60);
        initStrTouSpeInte(1.5 * levelBonus, 3 * levelBonus, 4 * levelBonus, 4.5 * levelBonus);
        this.weaponName = "dive";
        this.weaponVerb = "swoop";
        this.armorName = "dress";
        this.armorDef = levelBonus;
        this.armorMDef = levelBonus;
        this.wings.type = Wings.BAT_LIKE_LARGE;
        this.bonusHP = levelBonus * 500;
        this.bonusLust = levelBonus * 8;
        this.lustVuln = 1;
        this.level = levelBonus;
        this.drop = new ChainedDrop(consumables.VAMPBLD);
        this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
        checkMonster();
    }

    override public function get long():String {
        var str:String = "Diva appears to be a vampire, the fangs and wings kind of give it away.\n"
            + "She circles above and around you, waiting for an opening while she constantly screeches.\n"
            + "Huh, she might be more bat-like that you initially thought.\n"
            + "Girl certainly has quite the pair of lungs if nothing else.\n"
            + "Her red and black dress gives her quite the villainous look while having some unfortunate consequences of it having a skirt and her being a flier.\n"
            + "Somehow, she manages to keep herself from having a rather intimate reunion with the walls despite not looking at where she is flying in favor of drooling at the sight of your neck.\n"
            + "Guess all that screeching has an actual purpose aside from annoying you.";
        if (finalFight) {
            str += "\nLooks like she got one hell of a power-up thanks to your generous blood donations. Masochism much, Champ?";
            if (EngineCore.silly()) str += "\nGit gud, scrub.";
        }
        return str;
    }

    override protected function performCombatAction():void {
        if (_sonicScreamCooldown > 0) {
            _sonicScreamCooldown--;
        }
        if (player.hasStatusEffect(StatusEffects.NagaBind)) {
            moveBite();
        } else {
            var options:Array = [moveEmbrace, moveSwoopToss];
            if (_sonicScreamCooldown == 0) {
                options.push(moveSonicScream);
            }
            if (finalFight && !player.hasStatusEffect(StatusEffects.Blind)) {
                options.push(moveDarkness);
            }
            if (attackSucceeded()) {
                options[rand(options.length)]();
            }
        }
    }

    public override function isFlying():Boolean {
        return !hasStatusEffect(StatusEffects.Stunned);
    }

    public function handlePlayerSpell(spell:String = ""):void {
        if (spell == "whitefire" && player.hasStatusEffect(StatusEffects.Blind)) {
            player.removeStatusEffect(StatusEffects.Blind);
            outputText("The room lights back as the flame dispels the shadow.");
        }
        if (spell == "blind" && this.hasStatusEffect(StatusEffects.Blind)) {
            outputText("Diva recoils in pain as the bright light strikes her like a hammer, temporarily pinning her to the ground and stunning her.");
            this.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        }
    }

    override public function postPlayerAbility(ability:CombatAbility, display:Boolean = true):void {
        if (ability is BlindSpell && hasStatusEffect(StatusEffects.Blind)) {
            if (display) {
                outputText("Diva recoils in pain as the bright light strikes her like a hammer, temporarily pinning her to the ground and stunning her.");
            }
            this.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        } else if (ability is WhitefireSpell && hasStatusEffect(StatusEffects.Blind)) {
            if (display) {
                outputText("The room lights back as the flame dispels the shadow.");
            }
        }
    }

    private function moveEmbrace():void {
        if (rand(120) >= (player.spe > 80) ? player.spe : 80) {
            player.createStatusEffect(StatusEffects.NagaBind, 0, 0, 0, 0);
            outputText("Diva suddenly dives and closes her wings and arms on you, locking you in an embrace!");
            if (EngineCore.silly()) outputText("  Bad touch, bad touch!");
        } else {
            outputText("Diva suddenly dives in attempt to close her wings and arms on you but you're faster than her and swiftly evade the grapple.");
        }
    }

    public function moveBite():void {
        if (player.isGargoyle()) {
            outputText("Diva tries to bite you but quickly step back holding a hand to her mouth with a surprised yelp of clear pain. You smirk amused... did she seriously try to bite in your stone skin?");
            takePhysDamage(maxHP() * .1);
        } else if (player.isAlraune()) {
            outputText("Diva tries to bite you but just as her fang pierces your skin she shoves you off and starts spitting."
                + "\n\n"
                + "\"<i>Puaaah what the hell did I taste just now! Your blood taste like saps and flower nectar. How disgusting!</i>\""
                + "\n\n"
                + "Well now you're kind of offended by her reaction... guess plant sap really tastes bad for her.");
            takePhysDamage(10);
        } else {
            addHP(maxHP() * .2);
            var dam:int = this.str * 2;
            for (var i:int = 0; i < _biteCounter; i++) {
                dam += dam * .50;
            }
            _biteCounter++;
            outputText("Diva bites into your neck and begins drinking her fill. The rather loud slurping noises she makes kind of ruin the mood, though. Weirdly enough you feel aroused from this despite the pain.");
            if (silly()) outputText("  You masochist, you.")
            dam = Math.round(dam);
            player.takePhysDamage(dam);
            player.takeLustDamage(2 + rand(4), true);
        }
    }

    private function moveSwoopToss():void {
        outputText("Diva makes a pass bare inches above your head, using her momentum to snatch");
        if (finalFight) outputText("and toss you across the room and into an intimate reunion between your face and the wall.");
        else outputText("you only to drop you from higher height.");
        var dam:int = 50;
        dam += this.str;
        dam += rand((140 - player.tallness) * .25);
        player.takePhysDamage(dam);
    }

    private function moveDarkness():void {
        outputText("\"<i>Let us see how thou fight without this precious light of yours!</i>\""
            + "\n\n"
            + "Diva lands, opening her wings wide as a pair of black orbs form at her fingertips. She shatters them on the ground plunging the room in complete darkness and extinguishing all light."
            + "\n\n"
            + "You will be unable to locate her correctly without a proper visual.");
        if (!player.isImmuneToBlind()) player.createStatusEffect(StatusEffects.Blind, 999, 0, 0, 0);
    }

    private function moveSonicScream():void {
        if (finalFight) outputText("Diva suddenly lets out an agonising screech which echoes through the entire room, shattering all the glass along its path and forcing you to reflexively try to cover your ears with your hands, dropping your weapons in the process and still staggering you despite your efforts. The scream is so powerful that, in addition to damaging your eardrums and fucking your balance something fierce, it also bodily throws you into a nearby wall. At least you didn’t wind up impaled on some weapon’s rack, that would be plain embarrassing.");
        else outputText("Diva gets what look like a conical item out of her bag and suddenly lets out an agonising screech which echoes through the entire room, forcing you to reflexively try to cover your ears with your hands, dropping your weapons in the process and still staggering you despite your efforts.")
        player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
        _sonicScreamCooldown = 6;
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        DivaScene.instance.moonlightSonata(true);
        cleanupAfterCombat();
    }

    override public function defeated(hpVictory:Boolean):void {
        if (finalFight) DivaScene.instance.defeatedFinalFight();
        else DivaScene.instance.defeatedFirstSecond();
    }
}
}
