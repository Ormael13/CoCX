/**
 * ...
 * @author Ormael & Pyromania
 */
package classes.Scenes.Dungeons.RiverDungeon 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.*;

use namespace CoC;

	public class Vegot extends Monster
	{
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatVegot();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByVegot();
		}
		
		override public function get long():String {
			var str:String = "";
			str += "You are fighting Vegot. He appears to be an adult raiju and proclaims himself to be the king.\n\n";
			str += "His face is cold with icy blue eyes that stare at you intently. The fur that coats his head and parts of his body is white and erratic, like rushing static, ending with a light blue tip.\n\n";
			str += "He wears an ice-encrusted crown adorned over his head. The crown is black, like charcoal, yet the glints of frost give it a glittery glow.\n\n";
			str += "He wears little clothing across his toned frame. A fur cape, similar to the fur covering his arms cloaks his back. Ornate spaulders are linked together and weave into his cloak through a series of ice-like chains.\n\n";
			str += "He wears a fur vest, parting to reveal his torso. The raiju wears no pants, his legs coated only by his fur.\n\n";
			str += "Wrapped around his neck is an amulet, seemingly a font of magical power. The amulet has a large jewel that hangs between his pectorals. It shines with a frosty crust, yet pulses faintly with electricity.\n\n";
			str += "Wielded in his arms is a longsword that he swings seamlessly. It's seemingly completely made of ice, but the interior shines with the spark of electricity. The weapon crackles occasionally with a pulse of electricity, ready to discharge a freezing cut as well as several amps of power.";
			return str;
		}

		public function Vegot() 
		{
			this.a = "";
			this.short = "Vegot";
			this.long = "";
			this.createCock(30,5);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 120;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "light";
			this.hairColor = "red";
			this.hairLength = 13;
			initStrTouSpeInte(130, 195, 230, 200);
			initWisLibSensCor(200, 290, 210, 80);
			this.weaponAttack = 54;
			this.weaponName = "Frostlight";
			this.weaponVerb="slash";
			this.armorName = "vest";
			this.armorDef = 32;
			this.armorMDef = 60;
			this.bonusHP = 300;
			this.bonusLust = 543;
			this.lust = 30;
			this.lustVuln = .8;
			this.level = 43;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 65 + rand(30);
			this.drop = new ChainedDrop().
					add(consumables.VOLTTOP,1).
					add(consumables.ALCTHUN,0.7).
					add(useables.ELSHARD, 0.5);
			this.wings.type = Wings.THUNDEROUS_AURA;
			this.rearBody.type = RearBody.RAIJU_MANE;
			this.arms.type = Arms.RAIJU;
			this.lowerBody = LowerBody.RAIJU;
			this.tailType = Tail.RAIJU;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.JobBrawler, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobCourtesan, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyFeralType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.UniqueNPC, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}