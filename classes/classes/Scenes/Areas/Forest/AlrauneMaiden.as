/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Holidays;
import classes.internals.ChainedDrop;

public class AlrauneMaiden extends Alraune
	{
		
		public function AlrauneMaiden() 
		{
			super();
			if (Holidays.isHalloween()) {
				this.a = "";
				this.short = "Jack-O-Raune";
				this.long = "You are fighting against an Jack-O-Raune, an intelligent plant with the torso of a woman and the lower body of a giant pumpkin with snaking tentacle vines. She seems really keen on raping you.";
				this.skinTone = "pale orange";
				this.hairColor = "green";
			}
			else {
				this.a = "an ";
				this.short = "alraune maiden";
				this.long = "You are fighting against an Alraune Maiden, an intelligent plant with the torso of a woman and the lower body of a giant flower. She seems really keen on raping you.";
				this.skinTone = "light green";
				this.hairColor = "dark green";
			}
			this.imageName = "alraune";
			initStrTouSpeInte(15, 300, 15, 120);
			initWisLibSensCor(120, 200, 75, 0);
			this.armorDef = 100;
			this.armorMDef = 20;
			this.bonusHP = 500;
			this.level = 54;
			this.gems = rand(35) + 25;
			this.drop = new ChainedDrop().add(consumables.MARAFRU, 1 / 6);
				//	.add(consumables.W__BOOK, 1 / 4)
				//	.add(consumables.BEEHONY, 1 / 2)
				//	.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyPlantType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}