/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Forest 
{
import classes.*;
import classes.GlobalFlags.*;
import classes.internals.ChainedDrop;
import classes.Scenes.SceneLib;
import classes.Scenes.Areas.Forest.WaspGirl;

	public class WaspHuntress extends WaspGirl {
		
		public function waspBarrageOfDarts2():void {
			outputText("The "+short+" launches a barrage of darts in your direction! ");
			if (player.buff("wasp paralyze venom").isPresent()) {
				outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
				player.buff("wasp paralyze venom").addStats( {"str":-4, "spe":-4, "tou":-8} ).withText("wasp paralyze venom").combatPermanent();
			} else {
				outputText("  It's getting much harder to move, you're not sure how many more darts like that you can take!");
				player.buff("wasp paralyze venom").addStats( {"str":-4, "spe":-4, "tou":-8} ).withText("wasp paralyze venom").combatPermanent();
			}
			var damage:int = 0;
			damage += ((str * 2) + rand(40));
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
			player.takePhysDamage(damage, true);
		}
		
		public function waspSpearAttack():void {
			outputText("The " + short + " lunges at you, jabbing with her spears.  You dodge the first attack easily, ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE)
				outputText("and you anticipate the upcoming spear strikes, dodging her attacks thanks to your incredible evasive ability!");
			else if (evade == EVASION_FLEXIBILITY)
				outputText("and you use your incredible flexibility to barely fold your body and avoid her attacks!");
			else if (evade == EVASION_MISDIRECTION)
				outputText("and you use technique from Raphael to sidestep and completely avoid her barrage of attacks!");
			else if (evade == EVASION_SPEED || evade != null)
				outputText("and you successfully dodge her barrages of spear attacks!");
			else if (hasStatusEffect(StatusEffects.Blind) && rand(3) > 0)
					outputText("and step away as you watch the " + short + "'s blind attacks strike only air. ");
			else {
				outputText("but she follows through with a spear strike, tearing into your " + (player.armor.name == "nothing" ? "" : "[armorName] and the underlying") + " flesh. ");
				if (player.buff("wasp paralyze venom").isPresent()) {
					outputText("You've fallen prey to paralyzation venom!  Better end this quick! ");
					player.buff("wasp paralyze venom").addStats( {"str":-15, "spe":-15, "tou":-30} ).withText("wasp paralyze venom").combatPermanent();
				} else {
					outputText("It's getting much harder to move, you're not sure how many more stings like that you can take! ");
					player.buff("wasp paralyze venom").addStats( {"str":-15, "spe":-15, "tou":-30} ).withText("wasp paralyze venom").combatPermanent();
				}
				var damage:int = 0;
				damage += ((str * 2.5) + rand(50));
				player.takePhysDamage(damage, true);
				player.takePhysDamage(damage, true);
			}
		}

		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) waspStingAttack();
			if (choice == 1) waspSpearAttack();
			if (choice == 2) waspBarrageOfDarts2();
			if (choice >= 3) eAttack();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByStingerWomen();
		}
		
		public function WaspHuntress() 
		{
			super();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.short = "mist wasp huntress";
				this.long = "A mist wasp huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her slim quad arms and legs that looks like shiny gloves and boots, sizable breasts, and an abdomen tipped with a gleaming stinger.  Her body covers nearly not visible network of faint purple vein-like lines.";
				initStrTouSpeInte(280, 380, 520, 300);
				initWisLibSensCor(300, 390, 300, -100);
				this.weaponAttack = 62;
				this.armorDef = 275;
				this.armorMDef = 125;
				this.bonusHP = 600;
				this.bonusLust = 742;
				this.level = 62;
				this.gems = rand(27) + 22;
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
						.add(consumables.BEEHONY, 1 / 3)
						.add(useables.PCSHARD, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			else {
				this.short = "wasp huntress";
				this.long = "A wasp huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her slim quad arms and legs that looks like shiny gloves and boots, sizable breasts, and an abdomen tipped with a gleaming stinger.";
				initStrTouSpeInte(88, 88, 137, 93);
				initWisLibSensCor(93, 119, 97, -100);
				this.weaponAttack = 31;
				this.armorDef = 42;
				this.armorMDef = 21;
				this.bonusHP = 300;
				this.bonusLust = 264;//lib+sens+lvl
				this.level = 48;
				this.gems = rand(38) + 24;
				this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
						.add(consumables.W__BOOK, 1 / 3)
						.add(consumables.BEEHONY, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			this.a = "a ";
			createBreastRow(Appearance.breastCupInverse("DD_BIG"));
			checkMonster();
		}
		
	}

}