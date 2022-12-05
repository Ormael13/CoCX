/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Monsters 
{

	import classes.*;
	import classes.Scenes.SceneLib;
	
	public class Angel extends AbstractAngel
	{
		
		public function Angel() 
		{
			super(false);
			this.a = "the ";
			this.short = "angel";
			this.imageName = "angel";
			this.long = "You're currently fighting angel. It's looks like errie looking floating eyeball with one eye having two irises, one red and the other blue.";
			initStrTouSpeInte(20, 20, 10, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.tallness = 72;
			this.drop = NO_DROP;
			this.level = 6;
			this.bonusHP = 50;
			this.additionalXP = 50;
			this.weaponName = "stone fists";
			this.weaponVerb = "smash";
			this.weaponAttack = 10;
			this.armorName = "cracked stone";
			this.armorDef = 10;
			this.armorMDef = 2;
			this.createStatusEffect(StatusEffects.ATranscendentSoulField, 6, 6, 0, 0);
			this.createPerk(PerkLib.DieHardHP, 10, 0, 0, 0);
			this.createPerk(PerkLib.MonsterRegeneration, 1, 0, 0, 0);
			checkMonster();
		}
		
	}

}