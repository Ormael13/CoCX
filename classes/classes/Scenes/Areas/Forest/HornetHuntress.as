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
import classes.Scenes.Areas.Forest.HornetGirl;
import classes.Scenes.Combat.CombatAbilities;

	public class HornetHuntress extends HornetGirl {
		
		public function hornetJavelinAttack2():void {
			if(CombatAbilities.EAspectAir.isActive()) {
				outputText("The "+short+" pulls a javelin from behind her and throws it at you, but it's stopped by the wind wall.");
				CombatAbilities.EAspectAir.advance(true);
			}
			if(player.getEvasionRoll()) {
				outputText("The "+short+" pulls a long, dark wooden javelin from over her shoulder.  Her arm strikes forward, launching the missile through the air.  The spear flashes through the distance towards your vulnerable form.  Even as you see doom sailing towards you, a primal instinct to duck pulls you down, and you feel the wind from the massive missile as it passes close to your ear.");
			}
			else if(player.armorDef > 10 && rand(2) == 0) {
				outputText("The "+short+" pulls a long, dark wooden javelin from over her shoulder.  Her arm strikes forward, launching the missile through the air.  The spear flashes through the air but hits at an angle, sliding off your [armor] without doing any damage.  It disappears behind you.");
			}
			else if(player.hasPerk(PerkLib.Resolute) && player.tou >= 75) {
				outputText("You resolutely ignore the spear, brushing the blunted tip away when it hits you.\n");
			}
			else {
				outputText("The "+short+" pulls a long, dark wooden javelin from over her shoulder.  Her arm strikes forward, launching the missile through the air.  The javelin flashes through the intervening distance, slamming into your chest.");
				if (player.buff("wasp paralyze venom").isPresent()) {
					outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
					player.buff("hornet paralyze venom").addStats( {"str":-4, "spe":-8, "tou":-4} ).withText("hornet paralyze venom").combatPermanent();
				} else {
					outputText("  It's getting much harder to move, you're not sure how many more javelin hits like that you can take!");
					player.buff("hornet paralyze venom").addStats( {"str":-4, "spe":-8, "tou":-4} ).withText("hornet paralyze venom").combatPermanent();
				}
				var damage:int = 0;
				damage += ((str * 12) + rand(240));
				player.takePhysDamage(damage, true);
			}
		}
		
		public function hornetSpearAttack():void {
			outputText("The " + short + " lunges at you, jabbing with her spears.  You dodge the first attack easily, ");
			var evade:String = player.getEvasionReason();
			if (evade == EVASION_EVADE) {
				outputText("and you anticipate the upcoming spear strikes, dodging her attacks thanks to your incredible evasive ability!");
				return;
			}
			else if (evade == EVASION_FLEXIBILITY) {
				outputText("and you use your incredible flexibility to barely fold your body and avoid her attacks!");
				return;
			}
			else if (evade == EVASION_MISDIRECTION) {
				outputText("and you use technique from Raphael to sidestep and completely avoid her barrage of attacks!");
				return;
			}
			else if (evade == EVASION_SPEED || evade != null) {
				outputText("and you successfully dodge her barrages of spear attacks!");
				return;
			}
			else if (hasStatusEffect(StatusEffects.Blind) && rand(3) > 0) {
					outputText("and step away as you watch the " + short + "'s blind attacks strike only air. ");
					return;
				}
			else
			{
				outputText("but she follows through with a spear strike, tearing into your " + (player.armor.name == "nothing" ? "" : "[armorName] and the underlying") + " flesh. ");
				if (player.buff("hornet paralyze venom").isPresent()) {
					outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
					player.buff("hornet paralyze venom").addStats( {"str":-15, "spe":-15, "tou":-10} ).withText("hornet paralyze venom").combatPermanent();
				} else {
					outputText("  It's getting much harder to move, you're not sure how many more stings like that you can take!");
					player.buff("hornet paralyze venom").addStats( {"str":-15, "spe":-15, "tou":-10} ).withText("hornet paralyze venom").combatPermanent();
				}
				var damage:int = 0;
				damage += ((str * 15) + rand(300));
				player.takePhysDamage(damage, true);
			}
		}

		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice == 0) hornetStingAttack();
			if (choice == 1) hornetSpearAttack();
			if (choice == 2) hornetJavelinAttack2();
			if (choice >= 3) eAttack();
		}
		
		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.riverdungeon.defeatedByStingerWomen();
		}
		
		public function HornetHuntress() 
		{
			super();
			if (player.hasStatusEffect(StatusEffects.RiverDungeonA)) {
				this.short = "mist hornet huntress";
				this.long = "A mist hornet huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, thick black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.  Her body covers nearly not visible network of faint purple vein-like lines.";
				initStrTouSpeInte(340, 560, 380, 270);
				initWisLibSensCor(270, 380, 300, -100);
				this.weaponAttack = 100;
				this.armorDef = 500;
				this.armorMDef = 250;
				this.bonusHP = 2000;
				this.bonusLust = 744;
				this.level = 64;
				this.gems = rand(29) + 24;
				this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
				this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
						.add(consumables.BEEHONY, 1 / 3)
						.add(useables.PCSHARD, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			else {
				this.short = "hornet huntress";
				this.long = "A hornet huntress buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, thick black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
				initStrTouSpeInte(50, 100, 50, 35);
				initWisLibSensCor(35, 90, 75, -100);
				this.weaponAttack = 10;
				this.armorDef = 25;
				this.armorMDef = 10;
				this.bonusHP = 100;
				this.bonusLust = 181;//lib+sens+lvl
				this.level = 16;
				this.gems = rand(30) + 12;
				this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 4)
						.add(consumables.W__BOOK, 1 / 3)
						.add(consumables.BEEHONY, 1 / 2)
						.elseDrop(useables.B_CHITN);
			}
			this.a = "a ";
			createBreastRow(Appearance.breastCupInverse("EE_BIG"));
			checkMonster();
		}
		
	}

}