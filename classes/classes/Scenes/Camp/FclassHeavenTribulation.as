/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class FclassHeavenTribulation extends GclassHeavenTribulation
	{
		override protected function performCombatAction():void
		{
			if (!player.hasStatusEffect(StatusEffects.HeavenTribulationCR)) player.createStatusEffect(StatusEffects.HeavenTribulationCR,1,1,1,0);
			else player.addStatusValue(StatusEffects.HeavenTribulationCR,1,1);
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 6) HP = 0;
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
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 6) campscene.FclassHTsurvived();
			else campscene.FclassHTbeaten();
		}
		
		public function FclassHeavenTribulation() 
		{
			this.a = "the ";
			this.short = "F class Heaven Tribulation";
			this.imageName = "F class Heaven Tribulation";
			this.long = "You're currently facing the F class Heavenly Tribulation: a gathering of jet-black clouds that unleashes a wrathful storm to test any soul cultivator daring to break through to the Soul Overlord stage.";
			this.plural = false;
			initStrTouSpeInte(10, 450, 10, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.lustVuln = 0.01;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = NO_DROP;
			this.level = 78;
			this.bonusHP = 9000;
			this.bonusLust = 98;
			this.createStatusEffect(StatusEffects.Flying, 14, 0, 0, 0);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			checkMonster();
		}
	}
}