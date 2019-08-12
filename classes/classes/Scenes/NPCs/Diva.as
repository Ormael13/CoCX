package classes.Scenes.NPCs {
import classes.Appearance;
import classes.AssClass;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.EngineCore;
import classes.Monster;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.internals.ChainedDrop;

import coc.xxc.BoundStory;

public class Diva extends Monster {
    private var _biteCounter:int = 0;
    private var finalFight:Boolean = false;
    private var _sonicScreamCooldown:int = 0;
    private var _scene:BoundStory = game.rootStory.locate("diva/combat").bind(CoC.instance.context);
    public function Diva(ff:Boolean=false) {
        this.finalFight = ff;
        var levelBonus:int = ff? 50:20;
        this.a = "";
        this.short = "Diva";
        this.long = "";
        this.createVagina(false,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
        createBreastRow(Appearance.breastCupInverse("DD"));
        this.ass.analLooseness= AssClass.LOOSENESS_NORMAL;
        this.ass.analWetness = AssClass.WETNESS_DRY;
        this.tallness = (5*12)+6;
        this.hips.type = Hips.RATING_CURVY;
        this.butt.type = Butt.RATING_NOTICEABLE;
        this.skinTone = "pale";
        this.hairColor = "blonde";
        this.hairLength = 16;
        initWisLibSensCor(4.5*levelBonus,40,50,50);
        initStrTouSpeInte(1.5*levelBonus,3*levelBonus,4*levelBonus,4.5*levelBonus);
        this.weaponName = "dive";
        this.weaponVerb = "swoop";
        this.armorName = "dress";
        this.armorDef = levelBonus;
		this.armorMDef = levelBonus;
        this.wings.type = Wings.BAT_LIKE_LARGE;
        this.bonusHP = levelBonus * 500;
        this.bonusLust = 50;
        this.lustVuln = 1;
        this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
        this.level = levelBonus;
        this.drop = new ChainedDrop(consumables.REDVIAL);
        this.createStatusEffect(StatusEffects.Flying,50,0,0,0);
        checkMonster();
    }
    override public function get long():String{
        display("battleDescript");
        return "";
    }
    override protected function performCombatAction():void{
        if(_sonicScreamCooldown > 0){_sonicScreamCooldown--;}
        if(player.hasStatusEffect(StatusEffects.NagaBind)){
            moveBite();
        } else {
            var options:Array = [moveEmbrace,moveSwoopToss];
            if(_sonicScreamCooldown == 0){options.push(moveSonicScream);}
            if(finalFight && !player.hasStatusEffect(StatusEffects.Blind)){options.push(moveDarkness);}
            if(attackSucceeded()){options[rand(options.length)]();}
        }
    }
    private function display(ref:String,locals:*=null):void{
        _scene.display(ref,locals);
    }
    public override function isFlying():Boolean{
        return !hasStatusEffect(StatusEffects.Stunned);
    }
    public function handlePlayerSpell(spell:String=""):void{
        if(spell == "whitefire" && player.hasStatusEffect(StatusEffects.Blind)){
            player.removeStatusEffect(StatusEffects.Blind);
            display("moves/darkness/dispell");
        }
        if(spell == "blind" && this.hasStatusEffect(StatusEffects.Blind)){
            display("scenes/blinded");
            this.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
        }
    }

    //region Moves
    private function moveEmbrace():void{
        if(rand(120) >= (player.spe > 80)? player.spe:80){
            player.createStatusEffect(StatusEffects.NagaBind,0,0,0,0);
            display("moves/embrace/hit");
        } else {
            display("moves/embrace/miss");
        }
    }
    public function moveBite():void{/*
        if (player.isGargoyle()) {
			display("moves/biteGargoyle");
			var dam1:int = 10;
			takePhysDamage(dam1);
		}
		else if (player.isAlraune()) {
			display("moves/bitePlant");
			var dam2:int = 10;
			takePhysDamage(dam2);
		}
		else{*/
			addHP(maxHP() * .2);
			var dam:int = this.str * 2;
			for(var i:int = 0; i < _biteCounter;i++){
				dam += dam * .50;
			}
			_biteCounter++;
			display("moves/bite");
			dam = Math.round(dam);
			player.takePhysDamage(dam);
			player.takeLustDamage(2 + rand(4));
		//}
    }
    private function moveSwoopToss():void{
        display("moves/swoopToss");
        var dam:int = 50;
		dam += this.str;
        dam += rand((140 - player.tallness) * .25);
        player.takePhysDamage(dam);
    }
    private function moveDarkness():void{
        display("moves/darkness",{$final:finalFight});
        if (!player.hasPerk(PerkLib.BlindImmunity)) player.createStatusEffect(StatusEffects.Blind,999,0,0,0);
    }
    private function moveSonicScream():void{
        display("moves/sonicScream",{$final:finalFight});
        player.createStatusEffect(StatusEffects.Stunned,2,0,0,0);
        _sonicScreamCooldown=6;
    }
    //endregion

    //region scenes
    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        DivaScene.instance.moonlightSonata(true);
        cleanupAfterCombat();
    }
    override public function defeated(hpVictory:Boolean):void{
        if(finalFight){
            display("scenes/defeated/final/intro");
            EngineCore.addButton(0,"Yes",finalChoice,0);
            EngineCore.addButton(1,"No", finalChoice,1);
            EngineCore.addButton(2,"Never",finalChoice,2);
        }
        else{/*
            if (player.isGargoyle() || player.isAlraune()) {
				display("scenes/defeated/combatGargPlant");
				cleanupAfterCombat();
			}
			else{*/
				display("scenes/defeated/normal");
				DivaScene.instance.status++;
				cleanupAfterCombat();
			//}
        }
        game.flushOutputTextToGUI();
        function finalChoice(choice:int):void{
            EngineCore.clearOutput();
            if(choice == 0){
                DivaScene.instance.status = -1;
                display("scenes/defeated/final/yesChoice");
            }
            else if(choice == 1){
                display("scenes/defeated/final/noChoice");
            }
            else{
                DivaScene.instance.status = -2;
                display("scenes/defeated/final/neverChoice");
            }
            cleanupAfterCombat();
        }
    }
    //endregion
}
}
