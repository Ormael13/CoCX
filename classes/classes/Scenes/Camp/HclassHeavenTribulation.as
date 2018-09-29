/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class HclassHeavenTribulation extends Monster
	{
		public var campscene:CampScenes = new CampScenes();
		
	//	override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
	//		game.impScene.impGangabangaEXPLOSIONS(true);
	//	}	//bad end here - thunderdome death ^^
		//Clara.as for countdown meter
		override public function defeated(hpVictory:Boolean):void
		{
			campscene.HclassHTbeaten();
		}
		
		public function HclassHeavenTribulation() 
		{
			this.a = "the ";
			this.short = "H class Heaven Tribulation";
			this.imageName = "H class Heaven Tribulation";
			this.long = "You're currently facing H class Heaven Tribulation. A small gathering of thinder clouds that sends down thunders to test any soul cultivator dreaming to break to Soul Sprite stage.";
			this.plural = false;
			initStrTouSpeInte(20, 20, 10, 10);
			initLibSensCor(10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = new ChainedDrop()
					.add(useables.GOLCORE, 1/4);
			this.level = 10;
			this.bonusHP = 230;
			this.additionalXP = 100;
			this.weaponName = "tribulation thunder";
			this.weaponVerb = "strike down";
			this.weaponAttack = 20 + (5 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "tribulation clouds";
			this.armorDef = 0;
			this.armorMDef = 0;
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			this.str += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 2 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 140;
			checkMonster();
		}
		
	}

}