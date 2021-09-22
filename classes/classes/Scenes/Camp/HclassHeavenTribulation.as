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
			outputText("One of crimson red bolts of lightning change it course leaving clouds and heaving toward the ground below. ");
			if (hasStatusEffect(StatusEffects.Dig)) outputText("But not finding target at the ground it hopelessly hits it leaving burn mark.");
			else if (player.hasStatusEffect(StatusEffects.EverywhereAndNowhere)) outputText("But due to your current state it's unable to deal any harm.");
			else {// || player.hasStatusEffect(StatusEffects.Displacement) || hasStatusEffect(StatusEffects.InvisibleOrStealth)
				var THUNDER:Number = (200 * player.statusEffectv2(StatusEffects.HeavenTribulationCR));
				var body_choice:Array = ["head", "arm", "[leg]", "[face]"];//, "[wings]", "[tail]"
				outputText("It hits you directly in your "+randomChoice(body_choice)+". <b>(<font color=\"#800000\">" + THUNDER + "</font>)</b>");
				player.HP -= THUNDER;//200-600-1,400-3,000-6,200-12,600-25,400-52,000
				player.addStatusValue(StatusEffects.HeavenTribulationCR,2,ThDa);
			}
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
			this.long = "You're currently facing H class Heaven Tribulation. A gathering of jet black clouds that sends down thunders to test any soul cultivator dreaming to break to Soul Sprite stage.";
			this.plural = false;
			initStrTouSpeInte(10, 10, 10, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.lustVuln = 0;
			this.tallness = 144;
			this.createBreastRow(0, 1);
			initGenderless();
			this.drop = NO_DROP;
			this.level = 24;
			this.bonusHP = 20;
			this.bonusLust = 30;
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