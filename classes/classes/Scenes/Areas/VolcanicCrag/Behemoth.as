package classes.Scenes.Areas.VolcanicCrag 
{
	import classes.*;
	import classes.internals.WeightedDrop;
	import classes.GlobalFlags.kFLAGS;
	
	public class Behemoth extends Monster
	{
		public function tailWhip():void {
			outputText("The behemoth charges at you, pivoting to swing his spiked tail as his muscles flex.  ");
			if (player.getEvasionRoll()) {
				outputText("Luckily, you leap back in time to dodge and he lets out a low chuckle.  \"Not bad,\" he says, and it's hard not to flush at his husky voice.");
				combatRoundOver();
				return;
			}
			else {
				outputText("You're too slow and the impact leaves you bruised and bleeding, the spines scraping your body.  You're lucky it's not deeper, but that really hurts!  <b>Your defense has been reduced!</b>  ");
				var damage:int = str + level;
				damage = player.reduceDamage(damage)
				player.takeDamage(damage, true);
			}
			if (findStatusEffect(StatusEffects.TailWhip) >= 0) addStatusValue(StatusEffects.TailWhip, 1, 5);
			else createStatusEffect(StatusEffects.TailWhip, 5, 0, 0, 0);
			combatRoundOver();
		}
		
		public function tease():void {
			outputText("\"Want a piece of this?\" the behemoth says, and you avert your eyes as he flips up his loincloth, his huge cock alluring under the red silk and gold chains.");
			game.dynStats("lus", 10 + (player.cor / 10) + (player.lib / 10));
			combatRoundOver();
		}
		
		override public function defeated(hpVictory:Boolean):void {
			game.volcanicCrag.behemothScene.winAgainstBehemoth();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			if (pcCameWorms){
				outputText("\n\nYour opponent doesn't seem to care.");
				doNext(game.combat.endLustLoss);
			} else {
				game.volcanicCrag.behemothScene.loseToBehemoth();
			}
		}
		
		public function Behemoth() 
		{
			this.a = "the ";
			this.short = "Behemoth";
			this.imageName = "behemoth";
			this.long = "Before you stands a hulking behemoth, about nine feet tall, with a feline face and long forward-pointing horns that leave him looking even larger. The hair on his head is black, though it quickly transitions into a blond mane that follows along his back and to his tail, and the rest of his muscular body is covered with purple fur. Dark spines protrude from his back, and though he carries no weaponry and wears only an elegant red loincloth, his fierce claws leave him plenty intimidating.";
			// this.plural = false;
			this.createCock(18, 2.5, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 3;
			this.cumMultiplier = 25;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = 9*12;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.skinTone = "purple";
			this.skinType = SKIN_TYPE_FUR;
			this.hairColor = "black";
			this.hairLength = 8;
			this.earType = EARS_ELFIN;
			this.faceType = FACE_CAT;
			this.horns = 7;
			this.hornType = HORNS_DRACONIC_X2
			this.lowerBody = LOWER_BODY_TYPE_CAT
			this.tailType = TAIL_TYPE_BEHEMOTH
			initStrTouSpeInte(125, 100, 80, 105);
			initLibSensCor(35, 15, 15);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 30;
			this.armorName = "loincloth";
			this.armorDef = 4;
			this.bonusHP = 800;
			this.lust = 15;
			this.lustVuln = 0.3;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 25;
			this.gems = 60 + rand(30);
			this.drop = NO_DROP;
			this.special1 = tailWhip;
			this.special2 = tease;
			//this.special3 = aerialRave;
			checkMonster();
		}
		
	}

}
