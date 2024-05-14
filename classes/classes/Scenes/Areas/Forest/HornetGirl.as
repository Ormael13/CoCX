/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.Forest
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.GlobalFlags.*;
import classes.Scenes.SceneLib;
import classes.Scenes.Combat.CombatAbilities;
import classes.internals.ChainedDrop;

	public class HornetGirl extends Monster {

		public function hornetJavelinAttack():void {
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
					player.buff("hornet paralyze venom").addStats( {"str":-2, "spe":-4, "tou":-2} ).withText("hornet paralyze venom").combatPermanent();
				} else {
					outputText("  It's getting much harder to move, you're not sure how many more javelin hits like that you can take!");
					player.buff("hornet paralyze venom").addStats( {"str":-2, "spe":-4, "tou":-2} ).withText("hornet paralyze venom").combatPermanent();
				}
				var damage:int = 0;
				damage += ((str * 2.5) + rand(100));
				player.takePhysDamage(damage, true);
			}
		}
		
		public function hornetStingAttack():void {
			//Blind dodge change
			if (hasStatusEffect(StatusEffects.Blind)) {
				outputText(capitalA + short + " completely misses you with a blind sting!!");
				return;
			}
			//Determine if dodged!
			if (player.spe - spe > 0 && int(Math.random() * (((player.spe - spe) / 4) + 320)) > 320) {
				if (player.spe - spe < 32) outputText("You narrowly avoid " + a + short + "'s stinger!");
				if (player.spe - spe >= 32 && player.spe - spe < 80) outputText("You dodge " + a + short + "'s stinger with superior quickness!");
				if (player.spe - spe >= 80) outputText("You deftly avoid " + a + short + "'s slow attempts to sting you.");
				return;
			}
			//determine if avoided with armor.
			if (player.armorDef >= 40 && rand(4) > 0) {
				outputText("Despite her best efforts, " + a + short + "'s sting attack can't penetrate your armor.");
				return;
			}
			//Sting successful!  Paralize or lust?
			//Lust 50% of the time
			if (rand(2) == 0) {
				outputText("Searing pain lances through you as " + a + short + " manages to sting you multiple times!  You stagger back a step and nearly trip, flushing hotly.  ");
				outputText("Oh no!  You've been injected with some kind of aphrodisiac.  You've got to keep focused, you can't think about... fucking... ");
				if (player.gender == 1) outputText("or dripping honey-slicked cunts beckoning you. ");
				if (player.gender == 2) outputText("planting your aching sex over her face while you lick her sweet honeypot. ");
				if (player.gender == 3) outputText("or cocks, tits, and puffy nipples. ");
				player.takeLustDamage(20, true);
				if (player.lust > player.lust100 * 0.6) {
					outputText(" You shake your head and struggle to stay focused,");
					if (player.gender == 1 || player.gender == 3) outputText(" but it's difficult with the sensitive bulge in your groin.");
					if (player.gender == 2) outputText(" but can't ignore the soaking wetness in your groin.");
					if (player.sens > 50) outputText("  The sensitive nubs of your nipples rub tightly under your [armor].");
				}
				else outputText(" You shake your head and clear the thoughts from your head, focusing on the task at hand.");
				if (!player.hasStatusEffect(StatusEffects.lustvenom)) player.createStatusEffect(StatusEffects.lustvenom, 0, 0, 0, 0);
			}
			//Paralise the other 50%!
			else {
				outputText("Searing pain lances through you as " + a + short + " manages to sting you multiple times!  You stagger back a step and nearly trip, finding it hard to move yourself.");
				if (player.buff("hornet paralyze venom").isPresent()) {
					outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
					player.buff("hornet paralyze venom").addStats( {"str":-10, "spe":-20, "tou":-10} ).withText("hornet paralyze venom").combatPermanent();
				} else {
					outputText("  It's getting much harder to move, you're not sure how many more stings like that you can take!");
					player.buff("hornet paralyze venom").addStats( {"str":-10, "spe":-20, "tou":-10} ).withText("hornet paralyze venom").combatPermanent();
				}
			}
			if (player.lust >= player.maxOverLust() && !SceneLib.combat.tyrantiaTrainingExtension())
				doNext(SceneLib.combat.endLustLoss);
			else doNext(EventParser.playerMenu);
		}

		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice == 0) hornetStingAttack();
			if (choice == 1) eAttack();//hornetSpearAttack();
			if (choice >= 2) eAttack();
		}

		public function HornetGirl()
		{
			super();
			this.a = "a ";
			this.short = "hornet girl";
			this.imageName = "beegirl";
			this.long = "A hornet girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, thick black chitin on her arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_FERTILE + 1;
			this.butt.type = Butt.RATING_HUGE;
			this.lowerBody = LowerBody.BEE;
			this.bodyColor = "yellow";
			this.hairColor = randomChoice("black","black and white");
			this.hairLength = 6;
			initStrTouSpeInte(30, 50, 30, 20);
			initWisLibSensCor(20, 60, 55, 0);
			this.weaponName = "chitin-plated fist";
			this.weaponVerb="armored punch";
			this.weaponAttack = 4;
			this.armorName = "chitin";
			this.armorDef = 12;
			this.armorMDef = 2;
			this.bonusHP = 40;
			this.bonusLust = 121;//lib+sens+lvl
			this.lust = 20 + rand(40);
			this.lustVuln = 0.9;
			this.level = 6;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 6)
					.add(consumables.W__BOOK, 1 / 4)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae.type = Antennae.BEE;
			this.wings.type = Wings.BEE_SMALL;
			this.tailType = Tail.BEE_ABDOMEN;
			this.tailVenom = 100;
			checkMonster();
		}

	}

}
