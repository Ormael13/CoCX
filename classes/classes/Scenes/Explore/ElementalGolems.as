/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Explore 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.WeaponLib;
import classes.Scenes.Monsters.AbstractGargoyle;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class ElementalGolems extends AbstractGargoyle
	{
		private function concussiveBlow():void
		{
			outputText("The giant raises his hammer for an obvious downward strike. His marble muscles flex as he swings it downward. You're able to hop out of the way of the clearly telegraphed attack, but nothing could prepare you for the shockwave it emits as it craters the ground. ");
			if (rand(2) == 0 && !player.hasStatusEffect(StatusEffects.Stunned)) {
				outputText("<b>The vibrations leave you rattled and stunned. It'll take you a moment to recover!</b> ");
				player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			}
			else outputText("You shake off the vibrations immediately. It'll take more than that to stop you! ");
			//Light magic-type damage!
			var damage:Number = (150 * ((inte/player.inte) / 4));
			damage = player.takePhysDamage(damage, true);
		}
		
		private function dirtKick():void
		{
			outputText("The animated sculpture brings its right foot around, dragging it through the gardens at a high enough speed to tear a half score of bushes out by the root. A cloud of shrubbery and dirt washes over you!");
			if (rand(2) == 0 && !player.hasStatusEffect(StatusEffects.Blind) && !player.isImmuneToBlind()) {
				player.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
				outputText(" <b>You are blinded!</b>");
			}
			else outputText(" You close your eyes until it passes and resume the fight!");
		}
		
		private function backhand():void
		{
			//Knocks you away and forces you to spend a turn running back to do melee attacks.
			outputText("The marble golem's visage twists into a grimace of irritation, and it swings its hand at you in a vicious backhand.");
			var damage:Number = int ((str + weaponAttack) - rand(player.touStat.core.value) - player.armorDef);
			//Dodge
			if (damage <= 0 || (player.getEvasionRoll())) outputText(" You slide underneath the surprise swing!");
			else
			{
				//Get hit
				outputText(" It chits you square in the chest.");
				if (player.hasPerk(PerkLib.ShieldWard) && rand (2) == 0) {
					outputText(" The momentum sends you flying through the air. You land with a crunch against a wall. <b>You'll have to run back to the giant to engage it in melee once more.</b> ");
					player.createStatusEffect(StatusEffects.KnockedBack, 0, 0, 0, 0);
					this.createStatusEffect(StatusEffects.KnockedBack, 0, 0, 0, 0); // Applying to mob as a "used ability" marker
				}
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		private function overhandSmash():void
		{
			//High damage, lowish accuracy.
			outputText("Raising its hammer high overhead, the giant swiftly brings its hammer down in a punishing strike!");
			
			var damage:Number = 175 + int((str + weaponAttack) - rand(player.touStat.core.value) - player.armorDef);
			if (damage <= 0 || rand(100) < 25 || player.getEvasionRoll()) outputText(" You're able to sidestep it just in time.");
			else
			{
				//Hit
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" The concussive strike impacts you with bonecrushing force. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		private function disarm():void
		{
			outputText("The animated statue spins its hammer around, striking at your [weapon] with its haft.");
			//Avoid
			if (player.getEvasionRoll() || (player.hasPerk(PerkLib.ShieldWard) && rand (2) == 0)) outputText(" You manage to hold onto your equipment, for now.");
			//Oh noes!
			else
			{
				outputText(" Your equipment flies off into the bushes! You'll have to fight another way. ");
				player.createStatusEffect(StatusEffects.Disarmed, 50, 0, 0, 0);
				this.createStatusEffect(StatusEffects.Disarmed, 0, 0, 0, 0);
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ATTACK] = player.weaponAttack;
				player.setWeapon(WeaponLib.FISTS);
//				player.weapon.unequip(player,false,true);
			}
		}
		private function cycloneStrike():void
		{
			//Difficult to avoid, moderate damage.
			outputText("Twisting back, the giant abruptly launches into a circular spin. Its hammer stays low enough to the ground that its circular path is tearing a swath of destruction through the once pristine garden, and it's coming in your direction!");
			var damage:Number = (200 + int((str + weaponAttack) - rand(player.touStat.core.value) - player.armorDef)) / (rand(2) + 2);
			//Avoid
			if (damage <= 0 || player.getEvasionRoll()) outputText(" By the grace of the gods, you somehow avoid the spinning hammer.");
			else
			{
				//Hit
				if (hasStatusEffect(StatusEffects.Provoke)) damage = Math.round(damage * statusEffectv2(StatusEffects.Provoke));
				outputText(" You're squarely struck by the spinning hammer. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		public function moveDevourMagic():void {
			if (hasStatusEffect(StatusEffects.DevourMagic)) {
				if (!monsterIsStunned()) {
					outputText("You feel your magical energy being forcefully drawn out of you, coming out as a bluish aura that rushes straight into the Gargoyle waiting mouth. She take it in like a breath of fresh air, looking healthier as she feasts on your magic. The gargoyle licks her lips like she just had an excellent meal.");
					var devour:Number = 0;
					if (player.fatigue + 250 > player.maxOverFatigue()) {
						devour += player.maxOverFatigue() - player.fatigue;
						player.fatigue = player.maxOverFatigue();
					}
					else {
						devour += 250;
						player.fatigue += 250;
					}
					if (player.mana < 250) {
						devour += player.mana;
						player.mana = 0;
					}
					else {
						devour += 250;
						player.mana -= 250;
					}
					if (player.soulforce < 250) {
						devour += player.soulforce;
						player.soulforce = 0;
					}
					else {
						devour += 250;
						player.soulforce -= 250;
					}
					devour *= 3;
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
			if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 3) {
				if (hasStatusEffect(StatusEffects.Provoke)) {
					if (!this.hasStatusEffect(StatusEffects.KnockedBack)) this.backhand();
					else if (!this.hasStatusEffect(StatusEffects.Disarmed) && player.weaponName != "fists") this.disarm();
					else {
						var opts1:Array = [];
						if (!player.hasStatusEffect(StatusEffects.Blind) && !player.hasStatusEffect(StatusEffects.Stunned)) opts1.push(dirtKick);
						if (!player.hasStatusEffect(StatusEffects.Blind) && !player.hasStatusEffect(StatusEffects.Stunned)) opts1.push(concussiveBlow);
						opts1.push(cycloneStrike);
						opts1.push(cycloneStrike);
						opts1.push(overhandSmash);
						opts1[rand(opts1.length)]();
					}
				}
				else {
					if (this.HPRatio() < 0.7 && !this.hasStatusEffect(StatusEffects.KnockedBack)) this.backhand();
					else if (this.HPRatio() < 0.4 && !this.hasStatusEffect(StatusEffects.Disarmed) && player.weaponName != "fists") this.disarm();
					else {
						var opts:Array = [];
						if (!player.hasStatusEffect(StatusEffects.Blind) && !player.hasStatusEffect(StatusEffects.Stunned)) opts.push(dirtKick);
						if (!player.hasStatusEffect(StatusEffects.Blind) && !player.hasStatusEffect(StatusEffects.Stunned)) opts.push(concussiveBlow);
						opts.push(cycloneStrike);
						opts.push(cycloneStrike);
						opts.push(overhandSmash);
						opts[rand(opts.length)]();
					}
				}
			}
			else if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 2) {
				if (hasStatusEffect(StatusEffects.DevourMagic)) {
					moveDevourMagic();
				}
				else {
					var choice1:Number = rand(4);
					if (choice1 == 0) eAttack();
					if (choice1 == 1) {
						if (hasStatusEffect(StatusEffects.AbilityCooldown1)) GargoyleStoneClawAttack();
						else moveGargoyleTailSlamAttack();
					}
					if (choice1 == 2) {
						if (hasStatusEffect(StatusEffects.AbilityCooldown2)) GargoyleStoneClawAttack();
						else GargoyleWingBuffetAttack();
					}
					if (choice1 == 3) moveDevourMagic();
				}
			}
			else {
				eAttack();
				var choice:Number = rand(4);
				if (choice == 0) {
					eAttack();
					eAttack();
				}
				if (choice == 1) {
					eAttack();
					eAttack();
					eAttack();
				}
				if (choice == 2) {
					eAttack();
					if (player.hasStatusEffect(StatusEffects.Stunned)) {
						eAttack();
						eAttack();
						eAttack();
					}
					else {
						GargoyleTailSlamAttack();
					}
				}
				if (choice == 3) {
					if (player.hasStatusEffect(StatusEffects.IzmaBleed)) {
						eAttack();
						eAttack();
						eAttack();
						eAttack();
						eAttack();
					}
					else {
						GargoyleTailSlamAttack();
					}
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 3) SceneLib.exploration.elementalGolemBeaten3();
			else if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 2) SceneLib.exploration.elementalGolemBeaten2();
			else SceneLib.exploration.elementalGolemBeaten1();
		}
		
		public function ElementalGolems() 
		{
			if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 3) {
				this.short = "living statue golem";
				this.imageName = "livingstatue";
				this.long = "This animated as golem marble statue shows numerous signs of wear and tear, but remains as strong and stable as the day it was carved. Its pearly, white skin is pockmarked in places from age, yet the alabaster muscles seem to move with almost liquid grace. You get the impression that the statue was hewn in the days before the demons, then brought to life shortly after. It bears a complete lack of genitalia - an immaculately carved leaf is all that occupies its loins. It wields a hammer carved from the same material as the rest of it.";
				initStrTouSpeInte(260, 300, 50, 80);
				initWisLibSensCor(80, 10, 10, 100);
				this.tallness = 184;
				this.createBreastRow(0, 1);
				initGenderless();
				this.level = 57;
				this.bonusHP = 3000;
				this.weaponName = "stone greathammer";
				this.weaponVerb = "smash";
				this.weaponAttack = 120;
				this.armorName = "cracked stone";
				this.armorDef = 100;
				this.armorMDef = 100;
				this.additionalXP = 1000;
				createPerk(PerkLib.Resolute, 0, 0, 0, 0);
				this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			}
			else if (player.statusEffectv1(StatusEffects.ElementalPearlGolems) == 2) {
				this.short = "obsidian gargoyle";
				this.imageName = "obsidian gargoyle";
				this.long = "This gargoyle looks like a vile and corrupted version of the gargoyle. Clearly created using a modified ritual, the face of the guardian is half lost in an expression of constant mind breaking pleasure, its eyes only focusing long enough on you that you can figure just what obscene things it plans to do with your body. Down between its legs, a nightmarish 18 inch rock hard cock throbs constantly and the slit right under it drips constantly, oozing jet black corrupted fluids.";
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
				initStrTouSpeInte(140, 110, 90, 10);
				initWisLibSensCor(10, 10, 10, 0);
				this.level = 33;
				this.bonusHP = 2000;
				this.additionalXP = 500;
				this.weaponName = "stone claws";
				this.weaponVerb = "claw-slash";
				this.weaponAttack = 65;
				this.armorName = "stone";
				this.armorDef = 65;
				this.armorMDef = 35;
				this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			}
			else {
				this.short = "guardian quasi-gargoyle";
				this.imageName = "guardian quasi-gargoyle";
				this.long = "You're currently fighting guardian quasi-gargoyle. It's six feet tall without any sexual characteristics, it stone body covered in cracks, with rudimental wings and fully formed mace tail, using bare stone fists to smash you. In cracks at it shoulders there are large elemental shards.";
				this.createBreastRow(0, 1);
				initGenderless();
				initStrTouSpeInte(30, 40, 30, 20);
				initWisLibSensCor(20, 10, 10, 0);
				this.tallness = 72;
				this.weaponName = "stone fists";
				this.weaponVerb = "smash";
				this.weaponAttack = 16;
				this.armorName = "slight cracked stone";
				this.armorDef = 16;
				this.armorMDef = 16;
				this.bonusHP = 100;
				this.level = 9;
				this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			}
			this.a = "the ";
			this.lustVuln = 0.01;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
	}
}