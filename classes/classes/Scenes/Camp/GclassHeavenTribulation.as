/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kFLAGS;
	
	public class GclassHeavenTribulation extends HclassHeavenTribulation
	{
		public function tribulationLustfullThunderStrike():void {
			var ThDa:Number = player.statusEffectv2(StatusEffects.HeavenTribulationCR);
			var ThLu:Number = player.statusEffectv3(StatusEffects.HeavenTribulationCR);
			outputText("The clouds above you writhe as brilliant pink and crimson light builds. With a roar, red and pink bolts of lightning lance down toward you, burning the very air as they travel.");
			if (hasStatusEffect(StatusEffects.Dig)) outputText("It strikes the ground near you, and you feel a slight tingle as the power disperses into the earth around you.");
			else if (player.hasStatusEffect(StatusEffects.EverywhereAndNowhere) || player.hasStatusEffect(StatusEffects.ShadowTeleport)) outputText("But due to your current state, it's unable to touch you.");
			else {// || player.hasStatusEffect(StatusEffects.Displacement) || hasStatusEffect(StatusEffects.InvisibleOrStealth)
				var THUNDER:Number = (750 * player.statusEffectv2(StatusEffects.HeavenTribulationCR));
				var LUSTFULL:Number = (125 * player.statusEffectv3(StatusEffects.HeavenTribulationCR));
				var body_choice:Array = ["head", "arm", "[leg]", "[face]"];//, "[wings]", "[tail]"
				LUSTFULL = Math.round(LUSTFULL * player.lustPercent() * 0.01);
				outputText("It hits you directly in your "+randomChoice(body_choice)+". <b>([font-damage]" + THUNDER + "[/font])([font-lust]" + LUSTFULL + "[/font])</b>");
				player.HP -= THUNDER;//200-600-1,400-3,000-6,200-12,600-25,400-52,000
				player.lust += LUSTFULL;
				player.addStatusValue(StatusEffects.HeavenTribulationCR,2,ThDa);
				player.addStatusValue(StatusEffects.HeavenTribulationCR,3,ThLu);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (!player.hasStatusEffect(StatusEffects.HeavenTribulationCR)) player.createStatusEffect(StatusEffects.HeavenTribulationCR,1,1,1,0);
			else player.addStatusValue(StatusEffects.HeavenTribulationCR,1,1);
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 5) HP = 0;
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
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 5) campscene.GclassHTsurvived();
			else campscene.GclassHTbeaten();
		}
		
		public function GclassHeavenTribulation() 
		{
			this.a = "the ";
			this.short = "G class Heaven Tribulation";
			this.imageName = "G class Heaven Tribulation";
			this.long = "You're currently facing the G-class Heaven Tribulation: a gathering of jet-black clouds that unleashes a heavenly storm to test any soul cultivator daring to break through to the Soul Elder stage.";
			this.plural = false;
			initStrTouSpeInte(10, 300, 10, 10);
			initWisLibSensCor(10, 10, 10, 0);
			this.lustVuln = 0.01;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = NO_DROP;
			this.level = 54;
			this.bonusHP = 6000;
			this.bonusLust = 74;
			this.createStatusEffect(StatusEffects.Flying, 12, 0, 0, 0);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			checkMonster();
		}
	}
}