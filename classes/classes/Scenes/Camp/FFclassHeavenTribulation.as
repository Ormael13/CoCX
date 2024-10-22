/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class FFclassHeavenTribulation extends GclassHeavenTribulation
	{
		override protected function performCombatAction():void
		{
			if (!player.hasStatusEffect(StatusEffects.HeavenTribulationCR)) player.createStatusEffect(StatusEffects.HeavenTribulationCR,1,1,1,0);
			else player.addStatusValue(StatusEffects.HeavenTribulationCR,1,1);
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 7) HP = 0;
			else {
				if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 4) tribulationLustfullThunderStrike();
				else tribulationThunderStrike();
			}
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
			campscene.HeavenTribulationThunderDoom();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 7) campscene.FFclassHTsurvived();
			else campscene.FFclassHTbeaten();
		}
		
		public function FFclassHeavenTribulation() 
		{
			this.a = "the ";
			this.short = "FF class Heaven Tribulation";
			this.imageName = "FF class Heaven Tribulation";
			this.long = "You're currently facing the FF class Heavenly Tribulation: a gathering of jet-black clouds that unleashes a wrathful storm to test any soul cultivator daring to break through to the Soul King stage.";
			this.plural = false;
			initStrTouSpeInte(10, 600, 10, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.lustVuln = 0.01;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = NO_DROP;
			this.level = 102;
			this.bonusHP = 12000;
			this.bonusLust = 122;
			this.createStatusEffect(StatusEffects.Flying, 16, 0, 0, 0);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			checkMonster();
		}
	}
}