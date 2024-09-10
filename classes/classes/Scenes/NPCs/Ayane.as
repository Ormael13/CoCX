package classes.Scenes.NPCs {
import classes.Scenes.Areas.Forest.*;
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Stats.Buff;
import classes.internals.*;

public class Ayane extends Kitsune {

    private function foxfireStorm():void {
        outputText("“<i>Try and dodge this!!</i>”\n"
            + "\n"
            + "Seven distinct blue fireballs appear from all directions floating toward you.");
        var damage:int = (this.inte + this.wis) * 3 + rand(50);
        if (player.hasStatusEffect(StatusEffects.Blizzard)) {
            player.addStatusValue(StatusEffects.Blizzard, 1, -1);
            damage *= 0.2;
        }
        for (var i:int = 0; i < 7; ++i)
            if (player.getEvasionRoll()) outputText("  You avoid the foxfire barely feeling it's tingling against your skin!");
            else {
                outputText(" The foxfire sears your skin, but leaves you strangely aroused.");
                player.takeFireDamage(damage, true);
                player.takeLustDamage(30 + player.effectiveSensitivity() / 5, true);
            }
    }

    private function dispel():void {
        outputText("“<i>Done enhancing yourself? Because I’m canceling all of this magic anyway.</i>”\n"
            + "\n"
            + "She waves her staff tracing a swift arcane glyph. To your dismay, all ongoing enchantments you've casted spontaneously end.");
        player.removeStatusEffect(StatusEffects.ChargeWeapon);
        player.removeStatusEffect(StatusEffects.ChargeRWeapon);
        player.removeStatusEffect(StatusEffects.ChargeArmor);
        player.statStore.removeBuffs("Might");
        player.statStore.removeBuffs("Blink");
    }

    private var kissCooldown:int = 0;

    private function drainingKiss():void {
        kissCooldown = 8;
        outputText("The kitsune appears out of nowhere and attempts to grab you!");

        if (player.getEvasionRoll())
            outputText("You manage to avoid her embrace just in time. She gives you a disappointed expression then backs off into the ambient darkness. ");
        else {
            outputText("Unable to dodge in time she wraps her arms around you and forces a kiss. To your horror you feel your mystical energy being sapped away! She breaks the embrace and back off licking her lips.\n"
                + "\n"
                + "“<i>Mmm, delicious.</i>”");
            player.mana -= player.maxMana() * 0.3;
            player.soulforce -= player.maxSoulforce() * 0.3;
            if (player.mana < 0) player.mana = 0;
            if (player.soulforce < 0) player.soulforce = 0;
            HP += maxHP() * 0.1;
            if (HP > maxOverHP()) HP = maxOverHP();
        }
    }

    private var healCooldown:int = 0;

    private function heal():void {
        healCooldown = 8;
        outputText("“<i>That hurt a lot, you know! Thankfully, I’m an expert at healing magic.</i>”\n"
            + "\n"
            + "She draws a sign with her staff and you watch in frustration as some of her wounds close.");
        HP += maxHP() * 0.2;
        if (HP > maxOverHP()) HP = maxOverHP();
    }

    private function illusion():void {
        if (!player.hasPerk(PerkLib.TrueSeeing) && !player.hasPerk(PerkLib.SixthSense)) {
            outputText("The fox cast a spell and to your utter confusion the entire scenery changes. You are naked in a bedroom and a full harem of fox women are surrounding you, flaunting their assets. Before you can defend yourself they all pounce on you attacking you in all sensual ways possible. You break out of the insidious daydream just in time to see the real fox about to disarm and rape you. You shove her away still aroused by the vision.\n"
                + "\n"
                + "“<i>How prude! Many would kill to experience what you just saw.</i>”");
            createStatusEffect(StatusEffects.Illusion, 0, 0, 0, 0);
            player.takeLustDamage(40 + player.effectiveSensitivity() / 4, true);
            statStore.addBuff("spe", 40, "KitsuneIllusion", {rate: Buff.RATE_ROUNDS, ticks: 5});
        } else {
            outputText("The fox casts a spell, but your magical sight easily pierces their forming illusion!");
        }
    }

    override protected function performCombatAction():void {
        //Ayane periodically appears and disappears around the player. At random at the start of the round Ayane may be hidden or visible. If she’s hidden all attack but tease will fail
        if (rand(2) == 0 && !player.hasPerk(PerkLib.TrueSeeing) && !player.hasPerk(PerkLib.SixthSense)) {
            this.createStatusEffect(StatusEffects.MonsterInvisible, 0, 0, 0, 0);
            outputText("No matter how much you try you can’t see the kitsune in the direct vicinity. She doesn’t keep you waiting for long, however, and strikes you from stealth.\n\n");
        } else this.removeStatusEffect(StatusEffects.MonsterInvisible);
        if (kissCooldown > 0) --kissCooldown;
        if (healCooldown > 0) --healCooldown;
        //pick move
        var moves:Array = [foxFireAttack, foxfireStorm, drainingKiss];
        if (HP < maxOverHP()) {
            if (kissCooldown == 0) moves.push(drainingKiss);
            if (healCooldown == 0) moves.push(heal);
        }
        if (!player.hasStatusEffect(StatusEffects.Sealed))
            moves.push(kitsuneSealAttack);
        if (!player.hasStatusEffect(StatusEffects.KitsuneTailTangle)) moves.push(kitsuneEntwine);
        if (!hasStatusEffect(StatusEffects.Illusion)) moves.push(illusion);
        if (player.hasStatusEffect(StatusEffects.ChargeWeapon) || player.hasStatusEffect(StatusEffects.ChargeArmor) || player.statStore.hasBuff("Might") || player.statStore.hasBuff("Blink")) moves.push(dispel);
        moves[rand(moves.length)]();
    }

    override public function defeated(hpVictory:Boolean):void {
        SceneLib.ayaneFollower.fightWin();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        if (pcCameWorms) {
            outputText("\n\n[Themonster] recoils before running off, no longer interested in you...");
            cleanupAfterCombat();
        } else SceneLib.ayaneFollower.fightLose();
    }

    public function Ayane() {
        super("white");
        if (flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] > 0) {
            this.a = "";
            this.short = "Ayane";
        } else {
            this.a = "a ";
            this.short = "mysterious seven-tailed kitsune";
        }
        this.imageName = "ayane";
        this.long = "You are fighting [themonster]. She isn’t exactly playing fair as she attacks in a hit-and-run fashion by jumping out of nowhere before retreating back to safety behind the cover of stealth. That and her mischievous laughter only annoys you all the more. Last you checked she has tan skin and her fur is white like snow. She wears a white and purple kimono with a large red ribbon in her hair.  Aside from her magic she fights using a mage staff.";
        initStrTouSpeInte(100, 114, 210, 320);
        initWisLibSensCor(210, 90, 115, -10);
        this.weaponAttack = 12;
        this.armorDef = 50;
        this.armorMDef = 150;
        this.bonusHP = 500;
        this.bonusLust = 245;
        this.level = 40;
        this.bodyColor = "tan";
        this.hairColor = "white";
        this.lustVuln = 0.8;
        this.gems = rand(60) + 80;
        this.drop = new WeightedDrop().add(consumables.FOXJEWL, 1);
        checkMonster();
    }

}

}
