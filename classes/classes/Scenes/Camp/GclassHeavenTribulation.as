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
			outputText("The clouds above you writhe, a brilliant pinkish and crimson light building...With a roar, red and pink bolts of lightning lance down towards you, burning the very air as it travels.");
			if (hasStatusEffect(StatusEffects.Dig)) outputText("It strikes the ground above you, and you feel a slight tingle as the power disperses into the ground around you.");
			else if (player.hasStatusEffect(StatusEffects.EverywhereAndNowhere) || player.hasStatusEffect(StatusEffects.ShadowTeleport)) outputText("But due to your current state it's unable to even touch you.");
			else {// || player.hasStatusEffect(StatusEffects.Displacement) || hasStatusEffect(StatusEffects.InvisibleOrStealth)
				var THUNDER:Number = (750 * player.statusEffectv2(StatusEffects.HeavenTribulationCR));
				var LUSTFULL:Number = (125 * player.statusEffectv3(StatusEffects.HeavenTribulationCR));
				var body_choice:Array = ["head", "arm", "[leg]", "[face]"];//, "[wings]", "[tail]"
				LUSTFULL = Math.round(LUSTFULL * player.lustPercent() * 0.01);
				outputText("It hits you directly in your "+randomChoice(body_choice)+". <b>(<font color=\"#800000\">" + THUNDER + "</font>)(<font color=\"#ff00ff\">" + LUSTFULL + "</font>)</b>");
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
			this.long = "You're currently facing the G class Heaven Tribulation: A gathering of jet black clouds that sends down a heavenly storm to test any soul cultivator dreaming to break to Soul Elder stage.";
			this.plural = false;
			initStrTouSpeInte(10, 300, 10, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.lustVuln = 0;
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