package classes.Scenes.Monsters 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.SceneLib;
import classes.internals.*;
	
	public class FeralImps extends Monster
	{
		public function clawAttack():void {
			outputText("The imp warlord charges at you with his claws ready! ");
			if (player.getEvasionRoll()) {
				outputText("You manage to avoid his claws thanks to your reaction!");
				return;
			}
			else {
				outputText("The imp manages to swipe you!  You let out a cry in pain. ");
				var damage:int = rand(50) + str + weaponAttack;
				if (damage < 20) damage = 20;
				player.takePhysDamage(damage, true);
			}
		}

		public function doubleAttack():void {
			outputText("The imp warlord charges at you with his claws ready and sword raised! ");
			if (player.getEvasionRoll()) {
				outputText("You manage to dodge his deadly attack!");
				return;
			}
			else {
				outputText("The imp manages to slash you with his sword and his deadly claws!");
				var damage:int = rand(50) + str + weaponAttack;
				if (damage < 20) damage = 20; //Min-cap damage.
				if (damage >= 50) {
					outputText("You let out a cry in pain and you swear you could see your wounds bleeding. ");
					player.createStatusEffect(StatusEffects.IzmaBleed, 2, 0, 0, 0);
				}
				else {
					outputText("Thankfully the wounds aren't that serious. ");
				}
				player.takePhysDamage(damage, true);
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			SceneLib.impScene.impVictory2();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.impScene.impRapesYou();
		}
		
		//flags[kFLAGS.FERAL_EXTRAS] >>> 1 - feral imp, 2 - feral imp lord, 3 - feral imp warlord, 4 - feral imps
		public function FeralImps() 
		{
			if (flags[kFLAGS.FERAL_EXTRAS] == 1) {
				this.a = "the ";
				this.short = "imp";
				this.imageName = "imp";
				this.long = "An feral imp is short, only a few feet tall.  An unkempt mane of shaggy black hair hangs from his head, parted by two short curved horns.  His eyes are solid black, save for tiny red irises which glow with evil intent.  His skin is bright red, and unencumbered by clothing or armor, save for a small loincloth at his belt, and he's extremely well-muscled.  His feet are covered by tiny wooden sandals, and his hands tipped with sharp claws.  A pair of tiny but functional wings occasionally flap from his back.";
				this.plural = false;
				this.tallness = rand(24) + 25;
				initStrTouSpeInte(36, 5, 10, 7);
				initWisLibSensCor(7, 45, 45, 100);
				this.weaponName = "claws";
				this.weaponVerb = "claw-slash";
				this.weaponAttack = 2;
				this.armorName = "leathery skin";
				this.armorDef = 1;
				this.armorMDef = 0;
				this.bonusLust = 30;
				this.lust = 40;
				this.level = 1;
				this.gems = rand(5) + 5;
				this.special1 = clawAttack;
			}
			if (flags[kFLAGS.FERAL_EXTRAS] == 2) {
				this.a = "the ";
				this.short = "imp lord";
				this.imageName = "implord";
				this.long = "The feral imp lord has an angular face, complete with curved nose and burnt red skin typical of imps.  He has no hair on his head, leaving his cold, wrath-clouded, black eyes unobstructed.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller then the average imp, being nearly four feet tall, and grotesque overdeveloped muscles.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works its way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nThe feral imp lord, like most feral imps wear very little clothing; only a simple loincloth and satchel hang from his waist.  You also note that the imp has two barbell piercings in his nipples. The creature doesn't seem to have any weapons, aside from his sharp black finger nails.";
				this.plural = false;
				this.tallness = rand(14) + 40;
				this.lowerBody = LowerBody.HOOFED;
				initStrTouSpeInte(110, 20, 25, 22);
				initWisLibSensCor(22, 55, 35, 100);
				this.weaponName = "fist";
				this.weaponVerb="punch";
				this.weaponAttack = 15;
				this.armorName = "leathery skin";
				this.armorDef = 5;
				this.armorMDef = 1;
				this.bonusHP = 100;
				this.bonusLust = 30;
				this.lust = 30;
				this.lustVuln = .65;
				this.level = 7;
				this.gems = rand(15) + 25;
				this.special1 = clawAttack;
			}
			if (flags[kFLAGS.FERAL_EXTRAS] == 3) {
				this.a = "the ";
				this.short = "imp warlord";
				this.imageName = "impwarlord";
				this.long = "The greater feral imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has a black hair on his head and his eyes are deep black.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller than the average feral imp, being nearly four feet tall, and with grotesque overgrown muscles.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works its way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nUnlike most feral imps, he is wearing a metal chestplate and bracers for protection. He doesn't appear to be wearing anything other than his armor and loincloth.  He wields a sword in his right hand and he doesn't appear to wield anything in his left hand, suggesting that he also attacks with his claws.";
				this.plural = false;
				this.tallness = rand(14) + 40;
				this.lowerBody = LowerBody.HOOFED;
				initStrTouSpeInte(160, 41, 45, 36);
				initWisLibSensCor(36, 71, 35, 100);
				this.weaponName = "sword";
				this.weaponVerb="slash";
				this.weaponAttack = 30;
				this.armorName = "platemail";
				this.armorDef = 17;
				this.armorMDef = 1;
				this.bonusHP = 350;
				this.bonusLust = 30;
				this.lust = 30;
				this.lustVuln = .4;
				this.level = 16;
				this.gems = rand(20) + 40;
				this.special1 = clawAttack;
				this.special2 = doubleAttack;
			}
			if (flags[kFLAGS.FERAL_EXTRAS] == 4) {
				
			}
			this.createCock(4, 1, CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skinTone = "red";
			this.hairColor = "black";
			this.hairLength = 5;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.drop = new WeightedDrop().
					add(consumables.LABOVA_,2).
					add(consumables.MINOBLO,1).
					add(consumables.SUCMILK,3).
					add(consumables.INCUBID,3).
					add(consumables.IMPFOOD,4).
					add(jewelries.POWRRNG,1);
			this.wings.type = Wings.IMP;
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}