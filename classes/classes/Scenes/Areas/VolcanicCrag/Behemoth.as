package classes.Scenes.Areas.VolcanicCrag 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;

public class Behemoth extends Monster
	{
		public function tailWhip():void {
			outputText("The behemoth charges at you with his spiked tail raised!  ");
			if (player.getEvasionRoll()) {
				outputText("You manage to dodge in time to avoid his swinging tail!");
				return;
			}
			else {
				outputText("You weren't aware of that and his tail hits you!  <b>Your defense has been reduced!</b>  ");
				var damage:int = (str * 1.2) + level;
				player.takePhysDamage(damage, true);
			}
			if (hasStatusEffect(StatusEffects.TailWhip)) addStatusValue(StatusEffects.TailWhip, 1, 5);
			else createStatusEffect(StatusEffects.TailWhip, 5, 0, 0, 0);
		}
		
		public function tease():void {
			outputText("The behemoth lifts his loincloth to reveal his large prick and waves his cock left and right.  You blush from looking at his cock.");
			player.dynStats("lus", 10 + (player.cor / 10) + (player.lib / 10));
		}
		
		override public function defeated(hpVictory:Boolean):void {
			SceneLib.volcanicCrag.behemothScene.winAgainstBehemoth();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void {
			if (pcCameWorms){
				outputText("\n\nYour opponent doesn't seem to care.");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.volcanicCrag.behemothScene.loseToBehemoth();
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
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 9*12;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.base.color = "purple";
			this.skin.growFur({color:"purple"});
			this.hairColor = "black";
			this.hairLength = 8;
			this.ears.type = Ears.ELFIN;
			this.faceType = Face.CAT;
			this.horns.count = 7;
			this.horns.type = Horns.DRACONIC_X2;
			this.lowerBody = LowerBody.CAT;
			this.tailType = Tail.BEHEMOTH;
			initStrTouSpeInte(180, 130, 100, 115);
			initWisLibSensCor(100, 35, 15, 15);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 34;
			this.armorName = "loincloth";
			this.armorDef = 12;
			this.armorMDef = 2;
			this.bonusHP = 900;
			this.bonusLust = 20;
			this.lust = 15;
			this.lustVuln = 0.3;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 40;
			this.gems = 70 + rand(30);
			this.drop = NO_DROP;
			this.special1 = tailWhip;
			this.special2 = tease;
			//this.special3 = aerialRave;
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
