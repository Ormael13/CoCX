/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Ashlands
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class HellCat extends Monster
	{
		public var spellCostArouse:int = 6;
		
		public function castArouse():void {
			outputText("She makes a series of arcane gestures, drawing on her lust to inflict it upon you! ");
			var lustDamage:int = (inte / 5) + rand(10);
			player.takeLustDamage(lustDamage);
			mana -= spellCostArouse;
		}
		
		public function hellcatFireball():void
		{
			var damage:int = (inte * 1.1) + rand(25);
			damage = Math.round(damage);
			outputText("The hellcat holds out her hand, a fireball forming in her palm. She launches the ball of molten heat towards you.");
			player.takeFireDamage(damage, true);
		}
		
		public function hellcatInfernalClaw():void
		{
			outputText("The hellcat growls at you, unsheathing her claws. She crouches, her claws beginning to glow with orange-red heat. The smell of molten iron fills the air as she pounces at you, claws outstretched. ");
			var firedamage:int = (inte * 0.45) + rand(10);
			firedamage = Math.round(firedamage);
			player.takeFireDamage(firedamage, true);
			if (!player.immuneToBurn()) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(3),0.05,0,0);
			}
			var physdamage:Number = 0;
			physdamage += eBaseDamage();
			player.takePhysDamage(physdamage, true);
			if (!player.immuneToBleed()) {
				if (player.hasStatusEffect(StatusEffects.Hemorrhage)) player.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
				else player.createStatusEffect(StatusEffects.Hemorrhage, SceneLib.combat.debuffsOrDoTDuration(3), 0.05, 0, 0);
			}
			outputText(" Reeling in pain, you begin to bleed and burn at the same time.");
		}
		
		public function hellcatFelineCurse():void
		{
			outputText("The hellcat incants a curse. Your head reels as the world around you appears to expand. You fall, unable to balance as your [legs] give way. After a few seconds, you open your eyes, trying to rub them...but your arm isn't moving properly. You look down and see...fuzzy paws. Cat paws. To your growing horror, you realize what she did. You're now a housecat!");
			player.createStatusEffect(StatusEffects.Polymorphed, 3, 0, 0, 0);
			createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(4);
			switch (choice) {
				case 0:
					if ((mana - spellCostArouse) >= 0) castArouse();
					else eAttack();
					break;
				case 1:
					hellcatFireball();
					break;
				case 2:
					hellcatInfernalClaw();
					break;
				case 3:
					if (!hasStatusEffect(StatusEffects.AbilityCooldown1)) hellcatFelineCurse();
					else eAttack();
					break;
				default:
					eAttack();
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.ashlands.hellcatScene.DefeatedHellCat();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.ashlands.hellcatScene.DefeatedByHellCat();
		}
		
		public function HellCat()
		{
			this.a = "the ";
			this.short = "hellcat";
			this.imageName = "hellcat";
			this.long = "Your opponent is a Hellcat, a fire witch with cat-like features. She would look like a standard catgirl if not for her ashen skin, fiery hair and blazing tail. Fire seeps up from the side corner of her ember-like black sclera eyes which glow with the dark promise of burning passion. The catgirl caster is clearly in heat and plans to vent it on you. Aside from her black hooded cape, she wears nothing to hide her modesty, displaying her D cup breasts, drooling pussy and hardening cat cock for you to enjoy.";
			// this.plural = false;
			this.createCock(10,2.5,CockTypesEnum.CAT);
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 7*12+6;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.tailType = Tail.BURNING;
			this.bodyColor = "ashen";
			this.hairColor = "midnight black";
			this.hairLength = 13;
			initStrTouSpeInte(70, 70, 150, 210);
			initWisLibSensCor(140, 145, 50, 70);
			this.weaponName = "claws";
			this.weaponVerb="slash";
			this.weaponAttack = 2;
			this.armorName = "hooded cape";
			this.armorDef = 3;
			this.armorMDef = 50;
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 222;
			this.bonusLust = 241;
			this.lust = 20;
			this.lustVuln = .1;
			this.level = 46;
			this.gems = rand(55) + 40;
			this.drop = new WeightedDrop().addMany(5,
					consumables.W_FRUIT,
					weapons.H_WAND,
					null)
					.add(shields.NEKONOM, 1);
			this.createPerk(PerkLib.FireNature, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
