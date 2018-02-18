/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.internals.ChainedDrop;

public class RyuBiHuman extends Monster
	{
		
		public function RyuBiHuman() 
		{
			this.a = " ";
			this.short = "RyuBi";
			this.imageName = "ryubihuman";
			this.long = "You are currently 'battling' RyuBi in human form, in a playfight.  At least, that was the intention.  The way she lashes her tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(100, 90, 80, 90);
			initWisLibSensCor(90, 50, 35, 50);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 36;
			this.armorName = "scales";
			this.armorDef = 54;
			this.bonusHP = 600;
			this.bonusLust = 10;
			this.lust = 20;
			this.lustVuln = .25;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 21;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().add(useables.D_SCALE, 0.2);//zamienić na worek of spirit stones ^^
			this.horns.type = Horns.DRACONIC_X4_12_INCH_LONG;
			this.horns.count = 4;
			this.tailType = Tail.DRACONIC;
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGigantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}