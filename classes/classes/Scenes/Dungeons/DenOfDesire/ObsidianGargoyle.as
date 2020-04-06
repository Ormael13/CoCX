/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.DenOfDesire 
{
import classes.*;
import classes.Scenes.Monsters.AbstractGargoyle;
import classes.Scenes.SceneLib;
import classes.internals.ChainedDrop;

public class ObsidianGargoyle extends AbstractGargoyle
	{
		public function moveLustBlast():void {
			if (hasStatusEffect(StatusEffects.Uber)) {
				if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FrozenSolid) || hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf) || hasStatusEffect(StatusEffects.EmbraceVampire) || hasStatusEffect(StatusEffects.StunnedTornado) || hasStatusEffect(StatusEffects.Pounce)) {
					outputText("Your interruption cause the gargoyle to choke in disbelief on whatever ability it was readying!");
					removeStatusEffect(StatusEffects.Uber);
				}
				else {
					if (statusEffectv1(StatusEffects.Uber) == 0) {
						addStatusValue(StatusEffects.Uber, 1, 1);
						outputText("The gargoyle is still masturbating. It looks like she's about to cum both ways. Perhaps you should stop her before she do?");
					}
					else {
						removeStatusEffect(StatusEffects.Uber);
						outputText("The gargoyle cums, black corruption oozing out of her pussy and dick. To your horror these fluids are alive, with a mind of their own and flow toward you, moving up to your skin and disappearing inside of you. You feel extremely aroused as images of depraved sexual fantasies enter your mind.");
						player.dynStats("lus", player.maxLust() * 0.5);
					}
				}
			}
			else {
				outputText("The gargoyle starts to fiercely masturbate both fingering her pussy and stroking her rock hard cock at the same time. She's likely preparing something dangerous.");
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
		}
		
		public function moveDevourMagic():void {
			if (hasStatusEffect(StatusEffects.DevourMagic)) {
				if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FrozenSolid)) {
					outputText("Liadri would write text for this situation... eventualy.");
				}
				else {
					outputText("You feel your magical energy being forcefully drawn out of you, coming out as a bluish aura that rushes straight into the Gargoyle waiting mouth. She take it in like a breath of fresh air, looking healthier as she feasts on your magic. The gargoyle licks her lips like she just had an excellent meal.");
					var devour:Number = 0;
					if (player.fatigue + 200 > player.maxFatigue()) {
						devour += player.maxFatigue() - player.fatigue;
						player.fatigue = player.maxFatigue();
					}
					else {
						devour += 200;
						player.fatigue += 200;
					}
					if (player.mana < 200) {
						devour += player.mana;
						player.mana = 0;
					}
					else {
						devour += 200;
						player.mana -= 200;
					}
					if (player.soulforce < 200) {
						devour += player.soulforce;
						player.soulforce = 0;
					}
					else {
						devour += 200;
						player.soulforce -= 200;
					}
					devour *= 2.5;
					HP += devour;
				}
				removeStatusEffect(StatusEffects.DevourMagic);
			}
			else {
				outputText("The gargoyle opens her mouth wide as if she was about to orgasm but nothing in particular happened, save for the fact you now feel the rooms energy start to flow towards her. Whatever she is doing you need to stop her now!");
				createStatusEffect(StatusEffects.DevourMagic, 0, 0, 0, 0);
			}
		}
		
		public function moveGargoyleTailSlamAttack():void {
			if (player.getEvasionRoll()) {
				outputText("The gargoyle hammers her tail down on you attempting to crush you under its mace like tip. You dodge out of the way as her tail crashes on the floor, leaving a small crater where you stood a mere second ago.");
			}
			else GargoyleTailSlamAttack();
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Uber)) {
				moveLustBlast();
			}
			if (hasStatusEffect(StatusEffects.DevourMagic)) {
				moveDevourMagic();
			}
			else {
				var choice:Number = rand(6);
				if (choice == 0) eAttack();
				if (choice == 1) GargoyleStoneClawAttack();
				if (choice == 2) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown1)) GargoyleStoneClawAttack();
					else moveGargoyleTailSlamAttack();
				}
				if (choice == 3) {
					if (hasStatusEffect(StatusEffects.AbilityCooldown2)) GargoyleStoneClawAttack();
					else GargoyleWingBuffetAttack();
				}
				if (choice == 4) moveDevourMagic();
				if (choice == 5) moveLustBlast();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.denofdesire.defeatedObsidianGargoyle();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.denofdesire.defeatedByObsidianGargoyle();
		}
		
		public function ObsidianGargoyle() 
		{
			this.a = "the ";
			this.short = "obsidian gargoyle";
			this.imageName = "obsidian gargoyle";
			this.long = "This gargoyle looks like a vile and corrupted version of the other gargoyle you met. Clearly created using a modified ritual, the face of the guardian is half lost in an expression of constant mind breaking pleasure, its eyes only focusing long enough on you that you can figure just what obscene things it plans to do with your body. Down between its legs, a nightmarish 18 inch rock hard cock throbs constantly and the slit right under it drips constantly, oozing jet black corrupted fluids.";
			this.pronoun1 = "her";
			this.createCock(18,3,CockTypesEnum.UNDEFINED);
			this.balls = 2;
			this.ballSize = 1;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 120;
			initStrTouSpeInte(150, 120, 90, 10);
			initWisLibSensCor(10, 10, 10, 50);
			this.drop = new ChainedDrop()
					.add(consumables.E_PEARL, 1);
			this.level = 28;
			this.bonusHP = 2500;
			this.additionalXP = 500;
			this.lustVuln = 0;
			this.weaponName = "stone claws";
			this.weaponVerb = "claw-slash";
			this.weaponAttack = 75;
			this.armorName = "stone";
			this.armorDef = 75;
			this.armorMDef = 25;
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.Sentience, 0, 0, 0, 0);
			checkMonster();
		}
	}
}