/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.BeeHive
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Items.DynamicItems;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;

public class CorruptBeeQueen extends Monster {
		
		public function corruptBeeQueenEggCannon():void {
			outputText("The queen points her massive abdomen toward you, her eyes glazed in pleasure as it begins shooting loads of eggs and corrupted fluids. ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("They missed you.");
			//Hit:
			else {
				outputText("The attack leaves you extremely aroused and somewhat sticky with her honey. ");
				player.takeLustDamage(80 + rand(40), true);
				player.buff("Corrupted Queen Bee Honey").addStats( {"spe":-10} ).withText("Corrupted Queen Bee Honey").combatPermanent();
			}
		}
		
		public function corruptBeeQueenCommandingVoice():void {
			outputText("Her mighty voice rings in the room and in your head as she psychically assaults you.\n\n");
			outputText("\"<i>I am the queen and I order you to zzzubmit to your dezzzire and become my zzzlave! OBEY!!!</i>\"\n\n");
			outputText("Her order arouses you although you manage to resist most of its compelling effect. ");
			player.takeLustDamage(120 + rand(60), true);
		}
		
		public function corruptBeeQueenCrush():void {
			outputText("The queen attempts to crush you by slamming her massive abdomen on your head. ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("It missed you.");
			//Hit:
			else {
				outputText("The attack leaves you reeling in pain. ");
				var damage:Number = weaponAttack + str * 2 + rand(str);
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(5);
			if (choice == 0) corruptBeeQueenEggCannon();
			if (choice == 1) corruptBeeQueenCommandingVoice();
			if (choice == 2) corruptBeeQueenCrush();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.beehive.defeatCorruptBeeQueen();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.beehive.defeatedByCorruptBeeQueen();
		}
		
		public function CorruptBeeQueen()
		{
			super();
			this.a = "";
			this.short = "Corrupt bee queen";
			this.long = "The bee queen, now corrupted. She looks at you with depraved eyes, likely planning a very unsavory fate for you. She sports four horns and a massive 50-inch penis between her legs, constantly dripping precum.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.createCock(50,6,CockTypesEnum.DEMON);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 108;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.BEE;
			this.bodyColor = "yellow";
			this.hairColor = randomChoice("black","black and yellow");
			this.hairLength = 6;
			initStrTouSpeInte(70, 220, 110, 75);
			initWisLibSensCor(75, 195, 155, 100);
			this.weaponName = "chitin-plated fist";
			this.weaponVerb="armored punch";
			this.weaponAttack = 15;
			this.armorName = "chitin";
			this.armorDef = 50;
			this.armorMDef = 20;
			this.bonusHP = 1500;
			this.bonusLust = 390;
			this.lustVuln = .4;
			this.level = 40;
			this.gems = rand(45) + 40;
			this.randomDropChance = 0.1;
			this.randomDropParams = {
				rarity: DynamicItems.RARITY_CHANCES_LESSER
			};
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae.type = Antennae.BEE;
			this.wings.type = Wings.BEE_SMALL;
			this.tailType = Tail.BEE_ABDOMEN;
			this.tailVenom = 100;
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 40, 0, 0, 0);
			checkMonster();
		}
		
	}

}
