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
			this.long = "You are currently battling female soul cultivator.";
			//this.long = "You are currently 'battling' RyuBi in human form, in a playfight.  At least, that was the intention.  The way she lashes her tail along the ground, with claws spread and teeth bared ferociously, makes you wonder.";
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
			this.hairLength = 45;//obscenely long, >= 40 a mniej niż tallness
			initStrTouSpeInte(100, 90, 80, 90);
			initWisLibSensCor(90, 50, 35, 50);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 36;
			this.armorName = "scales";
			this.armorDef = 54;
			this.armorMDef = 54;
			this.bonusHP = 600;
			this.bonusLust = 175;//lib+sens+lvl
			this.lust = 20;
			this.lustVuln = .25;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 90;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().
					add(consumables.BAGOCA1, 1).
					add(consumables.BAGOCA2, 0.7).
					add(consumables.BAGOCA3, 0.4);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyGodType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}