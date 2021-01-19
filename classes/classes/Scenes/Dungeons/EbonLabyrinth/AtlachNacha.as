/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.EbonLabyrinth 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class AtlachNacha extends Monster
	{
		
		
		
		
		public function AtlachNacha()
		{
			this.a = " ";
			this.short = "Atlach Nacha";
			this.long = "";
			this.tallness = 12 * 6;
			this.createCock(24, 5, CockTypesEnum.DEMON);
			this.createBreastRow(0);
			this.balls = 2;
			this.ballSize = 4;
			this.hoursSinceCum = 9999;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			initStrTouSpeInte(240, 310, 190, 210);
			initWisLibSensCor(80, 160, 40, 100);
			this.weaponName = "spear";
			this.weaponAttack = 38;
			this.weaponVerb = "lunge";
			this.armorName = "chitin";
			this.armorDef = 120;
			this.armorMDef = 20;
			this.bonusHP = 100000;
			this.bonusLust = 270;
			this.gems = 200 + rand(80);
			this.additionalXP = 1500;
			this.level = 70;
			this.lustVuln = 0.45;
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.drop = NO_DROP;
			this.checkMonster();
		}
	}
}