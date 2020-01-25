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
import classes.StatusEffects.Combat.ParalyzeVenomDebuff;
import classes.internals.ChainedDrop;

	public class HornetGirl extends Monster {
		
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
				outputText("but she follows through with a spear strikes, tearing into your " + (player.armor.name == "nothing" ? "" : "[armorName] and the underlying") + " flesh. ");
				var paralyze:ParalyzeVenomDebuff = player.statusEffectByType(StatusEffects.ParalyzeVenom) as ParalyzeVenomDebuff;
				if (paralyze) {
					outputText("  It's getting much harder to move, you're not sure how many more stings like that you can take!");
				} else {
					paralyze = new ParalyzeVenomDebuff();
					player.addStatusEffect(paralyze);
					outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
				}
				var attacks:int = 2;
				var damage:int = 0;
				while (attacks > 0) {
					damage += ((str * 1.5) + rand(65));
					attacks--;
				}
				player.takePhysDamage(damage, true);
				paralyze.increaseHornet2();
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
				outputText("Searing pain lances through you as " + a + short + " manages to sting you!  You stagger back a step and nearly trip, flushing hotly.  ");
				outputText("Oh no!  You've been injected with some kind of aphrodisiac.  You've got to keep focused, you can't think about... fucking... ");
				if (player.gender == 1) outputText("or dripping honey-slicked cunts beckoning you. ");
				if (player.gender == 2) outputText("planting your aching sex over her face while you lick her sweet honeypot. ");
				if (player.gender == 3) outputText("or cocks, tits, and puffy nipples. ");
				player.dynStats("lus", 75);
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
				outputText("Searing pain lances through you as " + a + short + " manages to sting you!  You stagger back a step and nearly trip, finding it hard to move yourself.");
				var paralyze:ParalyzeVenomDebuff = player.statusEffectByType(StatusEffects.ParalyzeVenom) as ParalyzeVenomDebuff;
				if (paralyze) {
					outputText("  It's getting much harder to move, you're not sure how many more stings like that you can take!");
				} else {
					paralyze = new ParalyzeVenomDebuff();
					player.addStatusEffect(paralyze);
					outputText("  You've fallen prey to paralyzation venom!  Better end this quick!");
				}
				paralyze.increaseHornet1();
			}
			if (player.lust >= player.maxLust())
				doNext(SceneLib.combat.endLustLoss);
			else doNext(EventParser.playerMenu);
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(4);
			if (choice == 0) hornetStingAttack();
			if (choice == 1) hornetSpearAttack();
			if (choice >= 2) eAttack();
		}
		
		public function HornetGirl() 
		{
			super();
			this.a = "a ";
			this.short = "hornet girl";
			this.imageName = "beegirl";
			this.long = "A hornet girl buzzes around you, filling the air with intoxicatingly sweet scents and a buzz that gets inside your head.  She has a humanoid face with small antennae, black chitin on her quad arms and legs that looks like shiny gloves and boots, sizable breasts, and a swollen abdomen tipped with a gleaming stinger.";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = rand(14) + 59;
			this.hips.type = Hips.RATING_FERTILE + 1;
			this.butt.type = Butt.RATING_HUGE;
			this.lowerBody = LowerBody.BEE;
			this.skinTone = "yellow";
			this.hairColor = randomChoice("black","black and yellow");
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
			this.bonusLust = 20;
			this.lust = 20 + rand(40);
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 6;
			this.gems = rand(20) + 5;
			this.drop = new ChainedDrop().add(consumables.OVIELIX, 1 / 6)
					.add(consumables.W__BOOK, 1 / 4)
					.add(consumables.BEEHONY, 1 / 2)
					.elseDrop(useables.B_CHITN);
			this.antennae.type = Antennae.BEE;
			this.wings.type = Wings.BEE_LIKE_SMALL;
			this.tailType = Tail.BEE_ABDOMEN;
			this.tailVenom = 100;
			checkMonster();
		}
		
	}

}