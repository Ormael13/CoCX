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
		
		public function tribulationThunderStrike():void {
			var ThDa:Number = player.statusEffectv2(StatusEffects.HeavenTribulationCR);
			outputText("A bolt of crimson lightning lances down towards you, burning the very air as it travels.");
			if (hasStatusEffect(StatusEffects.Dig)) outputText("It strikes the ground above you, and you feel a slight tingle as the power disperses into the ground around you.");
			else if (player.hasStatusEffect(StatusEffects.EverywhereAndNowhere) || player.hasStatusEffect(StatusEffects.ShadowTeleport)) outputText("But due to your current state it's unable to even touch you.");
			else {// || player.hasStatusEffect(StatusEffects.Displacement) || hasStatusEffect(StatusEffects.InvisibleOrStealth)
				var THUNDER:Number = (750 * player.statusEffectv2(StatusEffects.HeavenTribulationCR));
				var body_choice:Array = ["head", "arm", "[leg]", "[face]"];//, "[wings]", "[tail]"
				outputText("It hits you directly in your "+randomChoice(body_choice)+". ");
				player.takeLightningDamage(THUNDER, true);//750-1,500-3,000-6,000-12,000-24,000-48,000-96,000
				if (ThDa > 3) {
					if (rand(2) == 0) player.takeFireDamage((THUNDER / 4), true);
					else player.takeWindDamage((THUNDER / 4), true);
				}
				if (ThDa > 4) {
					if (rand(2) == 0) player.takeWindDamage((THUNDER / 8), true);
					else player.takeAcidDamage((THUNDER / 8), true);
				}
				player.addStatusValue(StatusEffects.HeavenTribulationCR,2,ThDa);
			}
		}

		// True strike cuz Tribulation
		override public function playerAttackedCheck():Boolean{
			return false;
		}

		override protected function performCombatAction():void
		{
			if (!player.hasStatusEffect(StatusEffects.HeavenTribulationCR)) player.createStatusEffect(StatusEffects.HeavenTribulationCR,1,1,0,0);
			else player.addStatusValue(StatusEffects.HeavenTribulationCR,1,1);
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 4) HP = 0;
			else tribulationThunderStrike();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void {
			campscene.HeavenTribulationThunderDoom();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.statusEffectv1(StatusEffects.HeavenTribulationCR) >= 4) campscene.HclassHTsurvived();
			else campscene.HclassHTbeaten();
		}
		
		public function HclassHeavenTribulation() 
		{
			this.a = "the ";
			this.short = "H class Heaven Tribulation";
			this.imageName = "H class Heaven Tribulation";
			this.long = "You're currently facing the H class Heaven Tribulation. A gathering of jet black clouds that sends down lightning to test any soul cultivator dreaming to break to Soul Sprite stage.";
			this.plural = false;
			initStrTouSpeInte(10, 150, 10, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = NO_DROP;
			this.level = 27;
			this.bonusHP = 3000;
			this.bonusLust = 47;
			this.weaponName = "tribulation thunder";
			this.weaponVerb = "strike down";
			this.weaponAttack = 1;
			this.armorName = "tribulation clouds";
			this.armorDef = 0;
			this.armorMDef = 0;
			this.createStatusEffect(StatusEffects.Flying, 10, 0, 0, 0);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			checkMonster();
		}
	}
}