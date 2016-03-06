package classes.Scenes.Areas.VolcanicCrag 
{
	import classes.*;
	import classes.internals.WeightedDrop;
	import classes.GlobalFlags.kFLAGS;
	
	public class Behemoth extends Monster
	{
		public function tailWhip():void {
			outputText("The behemoth charges at you with his spiked tail raised!  ");
			if (player.getEvasionRoll()) {
				outputText("You manage to dodge in time to avoid his swinging tail!");
				combatRoundOver();
				return;
			}
			else {
				outputText("You weren't aware of that and his tail hits you!  <b>Your defense has been reduced!</b>  ");
				var damage:int = str + level;
				damage = player.reduceDamage(damage)
				player.takeDamage(damage, true);
			}
			if (findStatusEffect(StatusEffects.TailWhip) >= 0) addStatusValue(StatusEffects.TailWhip, 1, 5);
			else createStatusEffect(StatusEffects.TailWhip, 5, 0, 0, 0);
			combatRoundOver();
		}
		
		public function tease():void {
			outputText("The behemoth lifts his loincloth to reveal his large prick and waves his cock left and right.  You blush from looking at his cock.");
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
			this.long = "The behemoth before you stands nine feet tall and is obviously a male.  His face is fairly cat-like and long horns protrude from his head, pointing forward.  His hair is black with blonde mane that runs across the top and back of his head and the entire length of his tail.  He's purple and muscular all over with spikes protruding from his upper back.  His cock is estimated to be eighteen inches long and 2½ inches thick when erect.  All he's wearing is a silken red loincloth tied together with gilded chains.  He doesn't appear to be wielding any form of weaponry but his claws look deadly.";
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