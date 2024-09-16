/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Caves
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.Monsters.DarkElfs;
import classes.internals.*;

	public class DarkElfRangerCaves extends DarkElfs
	{
		public function DarkElfRangerCaves()
		{
			this.a = "the ";
			this.short = "dark elf ranger";
			this.imageName = "dark elf";
			this.long = "This woman with dark skin has long pointed ears. You suspect her to be a dark elf and fighting underground on her own turf you are almost worried more of her kind would join the battle. Regardless, she’s dangerous and seems well equipped.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 50, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY + 1;
			this.butt.type = Butt.RATING_JIGGLY;
			this.lowerBody = LowerBody.ELF;
			this.bodyColor = "dark";
			this.hairColor = "silver";
			this.hairLength = 13;
			initStrTouSpeInte(115, 190, 250, 125);
			initWisLibSensCor(125, 78, 88, 80);
			this.weaponName = "dagger";
			this.weaponVerb= "stab";
			this.weaponAttack = 5;
			this.weaponRangeName = "elven bow";
			this.weaponRangeVerb= "shoot";
			this.weaponRangeAttack = 35;
			this.armorName = "elven black armor";
			this.armorDef = 15;
			this.armorMDef = 15;
			this.bonusLust = 214;
			this.lustVuln = .7;
			this.lust = 50;
			this.level = 48;
			this.gems = rand(10) + 20;
			this.drop = new WeightedDrop().
					add(useables.EBONBLO,1/20).
					add(weaponsrange.BOWLIGH,1)/*.
					add(consumables.ELFEARS,4)*/;
			checkMonster();
		}
	}
}
