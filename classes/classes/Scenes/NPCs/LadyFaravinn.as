/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;

use namespace CoC;

	public class LadyFaravinn extends Monster
	{
		
		public function LadyFaravinn() 
		{
			this.a = " ";
			this.short = "Lady Faravinn";
			this.imageName = "ladyfaravinn";
			this.long = "You are currently battling Lady Faravinn. Her look is much like one of the chimeras that you meet in this realm.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,10,0,0,0);
			createBreastRow(Appearance.breastCupInverse("A"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,10,0,0,0);
			this.tallness = rand(8) + 70;
			this.hairColor = "red";//eyes: emerald
			this.hairLength = 40;//obscenely long, >= 40 a mniej niż tallness
			initStrTouSpeInte(10, 100, 10, 100);
			initWisLibSensCor(100, 10, 10, 0);
			this.bonusLust = 20;
			this.lustVuln = 0.85;
			this.level = 0;
			this.gems = 5 + rand(5);
			this.drop = NO_DROP;
			checkMonster();
		}
	}
}