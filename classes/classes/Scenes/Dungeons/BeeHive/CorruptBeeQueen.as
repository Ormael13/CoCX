/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.BeeHive 
{
import classes.*;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;
import classes.StatusEffects.Combat.BasiliskSlowDebuff;

	public class CorruptBeeQueen extends BeeGuards {
		
		public static function beeQueenSpeed(player:Player,amount:Number = 0):void {
			var cqse:BasiliskSlowDebuff = player.createOrFindStatusEffect(StatusEffects.BasiliskSlow) as BasiliskSlowDebuff;
			cqse.applyEffect(amount);
		}
		
		public function corruptBeeQueenEggCannon():void {
			outputText("The queen points her massive abdomen toward you, her eyes glazed in pleasure as it begins shooting loads of eggs and corrupted fluids. ");
			//Miss:
			if (rand(20) + 1 + player.spe / 20 > 17) outputText("They missed you.");
			//Hit:
			else {
				outputText("The attack leaves you extremely aroused and somewhat sticky with her honey. ");
				player.dynStats("lus", 80 + rand(40));
				beeQueenSpeed(player,10);
			}
		}
		
		public function corruptBeeQueenCommandingVoice():void {
			outputText("Her mighty voice rings in the room and in your head as she psychically assaults you.\n\n");
			outputText("\"<i>I am the queen and I order you to zzzubmit to your dezzzire and become my zzzlave! OBEY!!!</i>\"\n\n");
			outputText("Her order arouses you although you manage to resist most of its compelling effect. ");
			player.dynStats("lus", 120 + rand(60));
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
			createBreastRow(Appearance.breastCupInverse("G"));
			this.createCock(50,6,CockTypesEnum.DEMON);
			this.tallness = rand(14) + 108;
			initStrTouSpeInte(70, 220, 110, 75);
			initWisLibSensCor(75, 195, 155, 0);
			this.weaponAttack = 15;
			this.armorDef = 50;
			this.armorMDef = 20;
			this.bonusHP = 1500;
			this.bonusLust = 390;
			this.lustVuln = .4;
			this.level = 40;
			this.gems = rand(45) + 40;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
					.add(consumables.W__BOOK, 1 / 3)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.OverMaxHP, 40, 0, 0, 0);
			checkMonster();
		}
		
	}

}