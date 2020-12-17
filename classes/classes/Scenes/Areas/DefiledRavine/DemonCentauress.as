/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DefiledRavine 
{
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.CockTypesEnum;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.SceneLib;

	public class DemonCentauress extends Monster
	{
		
		public function DemonCentauress() 
		{
			this.a = "the ";
			this.short = "herm centaur";
			this.imageName = "hermcentaur";
			this.long = "She's every bit a centaur - horse body, hooves, fur, and everything - about eight feet tall and equally well endowed.  Heaving, jiggly DD-cups jut proudly from her chest, unrestrained and bare to the world, thick nipples capping them like majestic, sexual crowns.  Under her belly, a thick equine cock slaps wetly against her fur with every step, heavy balls dangling behind.  A solid black horns juts from her forehead, a testament to the demonic corruption flowing through this woman's veins.  Her gleaming fire-orange hair and pale, freckled skin look like something you would see on an innocent maid, not a bestial altar of corrupted decadence.";
			this.tallness = 12 * 8;
			this.createBreastRow(Appearance.breastCupInverse("DD"));
			this.createVagina(false, 4, 5); 
			this.createCock(30, 4, CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 3;
			this.hips.type = Hips.RATING_FERTILE;
			this.butt.type = Butt.RATING_EXPANSIVE;
			initStrTouSpeInte(210, 210, 120, 120);
			initWisLibSensCor(120, 140, 40, 100);
			this.weaponName = "fists";
			this.weaponAttack = 30;
			this.weaponVerb = "punch";
			this.armorName = "wraps";
			this.armorDef = 26;
			this.armorMDef = 6;
			this.bonusHP = 1800;
			this.bonusLust = 221;
			this.gems = 300 + rand(90);
			this.level = 41;
			this.lustVuln = 0.6;
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.drop = NO_DROP;
			this.checkMonster();
		}
	}
}