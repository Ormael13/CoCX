package classes.Scenes.Dungeons.DemonLab {
/**
 * ...
 * @author ...
 */

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;

public class ProjectNightwalker extends Monster {
    
	override public function defeated(hpVictory:Boolean):void {
        SceneLib.dungeons.demonLab.afterNightwalkerFight();
    }

    override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
        SceneLib.dungeons.demonLab.BadEndExperiment();
    }
	
	public function ProjectNightwalker() {
        this.a = "";
		this.short = "Project Nightwalker";
		this.imageName = "succubusgardener";
		this.long = "This pale temptress floats above the ground, black batlike wings silently flapping to keep her aloft. As you get closer, she rises, just out of melee range. You’ll have to find some other way to deal with her, unless you can fly.";
		this.createVagina(false, 3, 3);
		this.createBreastRow(Appearance.breastCupInverse("FF"));
		this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
		this.ass.analWetness = AssClass.WETNESS_DRY;
		this.tallness = 8 * 12;
		this.hips.type = Hips.RATING_AVERAGE;
		this.butt.type = Butt.RATING_TIGHT;
		this.weaponName = "tentacles";
		this.weaponVerb = "lash";
		this.weaponAttack = 30;
		this.armorName = "tentaclothes";
		this.armorDef = 18;
		this.armorMDef = 3;
		initStrTouSpeInte(100, 195, 110, 100);
		initWisLibSensCor(100, 150, 60, 100);
		this.bonusHP = 2500;
		this.bonusLust = 250;
		this.fatigue = 0;
		this.gems = 200 + rand(50);
		this.level = 40;
		this.lustVuln = 0;
		this.drop = NO_DROP;
		this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
		this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
		this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
		this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
		this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);
		this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);
		this.createPerk(PerkLib.Diehard, 0, 0, 0, 0);
		this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
		this.createPerk(PerkLib.OverMaxHP, 40, 0, 0, 0);//v1 = enemy lvl
		checkMonster();
    }
}
}