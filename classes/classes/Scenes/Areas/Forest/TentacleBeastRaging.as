package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Places.HeXinDao;
import classes.Scenes.SceneLib;
import classes.internals.*;
	
public class TentacleBeastRaging extends Monster
	{
		private function tentaclePhysicalAttack():void {
			outputText("The shambling horror throws its tentacles at you with a murderous force.\n");
			var temp:int = int((str + weaponAttack) - Math.random()*(player.tou) - player.armorDef);
			if(temp < 0) temp = 0;
			//Miss
			if(temp == 0 || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80)) {
				outputText("However, you quickly evade the clumsy efforts of the abomination to strike you.");
			}
			//Hit
			else {
				outputText("The tentacles crash upon your body mercilessly. ");
				player.takePhysDamage(temp, true);
			}
		}
		private function tentaclePhysicalAttackWrath():void {
			outputText("The shambling horror throws its tentacles at you with a crazy and uncontroled manner.\n");
			var temp:int = int(((str + weaponAttack) * 2) - Math.random()*(player.tou) - player.armorDef);
			if (temp < 0) temp = 0;
			this.wrath -= 200;
			//Miss
			if(temp == 0 || (player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80)) {
				outputText("However, you quickly evade the clumsy efforts of the abomination to strike you.");
			}
			//Hit
			else {
				outputText("The tentacles crash upon your body mercilessly. ");
				player.takePhysDamage(temp, true);
			}
		}
		
		override protected function performCombatAction():void
		{
			this.wrath += 100;
			if (this.wrath >= 200) tentaclePhysicalAttackWrath();
			else  tentaclePhysicalAttack();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			player.removeStatusEffect(StatusEffects.TentacleBadEndCounter); //clear counter
			if (hpVictory) {
				outputText("The creature lets out an ear-piercing screech as it collapses upon itself. Its green coloring quickly fades to brown as the life drains from it, leaving you victorious.", true);
				sceneHunter.print("Maybe lust-defeat would leave more opportunities?");
				EngineCore.awardAchievement("Tentacle Beast Slayer", kACHIEVEMENTS.GENERAL_TENTACLE_BEAST_SLAYER);
			}
			else {
				outputText("The tentacle beast's mass begins quivering and sighing, the tentacles wrapping around each other and feverishly caressing each other.  It seems the beast has given up on fighting.");
			}
			if (hpVictory) SceneLib.forest.tentacleBeastScene.choiceofaction();
			else SceneLib.forest.tentacleBeastScene.tentacleVictory();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (hpVictory) {
				outputText("Overcome by your wounds, you turn to make a last desperate attempt to run...\n\n");
				SceneLib.forest.tentacleBeastScene.tentacleLossRape();
			} else {
				outputText("You give up on fighting, too aroused to resist any longer.  Shrugging, you walk into the writhing mass...\n\n");
				doNext(SceneLib.forest.tentacleBeastScene.tentacleLossRape);
			}
		}
		
		public function TentacleBeastRaging() 
		{
			this.a = "the ";
			this.short = "raging tentacle beast";
			this.imageName = "tentaclebeast";
			this.long = "You see the massive, shambling and growling angry form of the tentacle beast before you.  Appearing as a large shrub, it shifts its bulbous mass and reveals a collection of unnaturaly twisted thorny tendrils and deformed cephalopodic limbs.";
			// this.plural = false;
			this.createCock(40,1.5);
			this.createCock(60,1.5);
			this.createCock(50,1.5);
			this.createCock(20,1.5);
			this.balls = 0;
			this.ballSize = 0;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			this.pronoun1 = "it";
			this.pronoun2 = "it";
			this.pronoun3 = "its";
			this.createBreastRow(0,0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_BUTTLESS;
			this.skin.setBaseOnly({color:"green"});
			this.skinDesc = "bark";
			this.hairColor = "green";
			this.hairLength = 1;
			initStrTouSpeInte(31, 25, 10, 20);
			initWisLibSensCor(15, 90, 20, 100);
			this.weaponName = "whip-tendril";
			this.weaponVerb="thorny tendril";
			this.weaponAttack = 3;
			this.armorName = "rubbery skin";
			this.armorDef = 5;
			this.armorMDef = 0;
			this.bonusHP = 40;
			this.bonusWrath = 100;
			this.bonusLust = 122;
			this.lust = 10;
			this.lustVuln = 0.8;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 11;
			this.gems = rand(7)+3;
			this.drop = new WeightedDrop().addMany(1,consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.HEALHERB,
					consumables.MOONGRASS,
					consumables.SNAKEBANE,
					consumables.IRONWEED,
					consumables.BLADEFERN);
			this.tailType = Tail.DEMONIC;
			this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}