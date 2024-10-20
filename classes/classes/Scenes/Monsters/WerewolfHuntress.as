/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Monsters
{
import classes.Scenes.NPCs.*;
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.Scenes.SceneLib;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class WerewolfHuntress extends Monster
	{
		public function usingClawCombo():void {
			outputText("The werewolf attempts to rend you with her claws.\n");
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
			eAttack();
		}
		
		public function usingPounce():void {
			outputText("The werewolf pounces on you, pinning you to the ground as she gets in position, claws at the ready.");
			player.createStatusEffect(StatusEffects.WolfHold,0,0,0,0);
			if (player.hasPerk(PerkLib.Juggernaut) < 0 && armorPerk != "Heavy") {
				var takeD:Number;
				takeD = 8 + rand(10);
				player.takePhysDamage(takeD, true);
			}
		}
		
		public function usingRavage():void {
			outputText("The werewolf rends you with her claws.");
			var RavageDmg:Number = eBaseStrengthDamage();
			RavageDmg = Math.round(RavageDmg);
			player.takePhysDamage(RavageDmg, true);
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.werewolfFemaleScene.wonWithWerewolf();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.werewolfFemaleScene.lostToWerewolf();
		}
		
		public function WerewolfHuntress()
		{
			initStrTouSpeInte(200, 165, 200, 50);
			initWisLibSensCor(50, 100, 50, 50);
			this.weaponAttack = 36 + 2;
			this.armorDef = 200 + 10;
			this.armorMDef = 5;
			this.bonusHP = 800 + 50;
			this.bonusLust = 129 + 26;
			this.level = 50;
			this.a = "the ";
			this.short = "werewolf huntress";
			this.imageName = "luna";
			this.long = "Your opponent is a werewolf lycanthrope. While halfway human in appearance its glowing green eyes, canine ears, sharp fangs, bushy tails and claw armed paws reminds you of its bestial nature." +
					" It circles you, sniffing the air as it looks for an opportunity to maul or snap at you, supernaturally fast in its movement. As a veteran huntress, she actually is far more experienced than the regular lycanthrope.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 6*12+6;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_NOTICEABLE;
			this.skin.growFur({color:"ashen"});
			this.hairColor = "ashen";
			this.hairLength = 8;
			this.weaponName = "paws";
			this.weaponVerb="paw-slash";
			this.armorName = "fur";
			this.lust = 10;
			this.lustVuln = 0.01;
			this.gems = 5 + rand(5);
			this.drop = new WeightedDrop().
					add(null,1).
					//add(consumables.REPTLUM,2).
					add(consumables.WOLF_PP,5);
			this.createPerk(PerkLib.MonsterRegeneration, 5, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.abilities = [
				{call: usingRavage, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], weight:2 },
				{call: usingClawCombo, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{call: usingPounce, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], condition: function():Boolean { return !player.hasStatusEffect(StatusEffects.WolfHold) } },
				{call: usingRavage, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], condition: function():Boolean { return player.hasStatusEffect(StatusEffects.WolfHold) }, weight:Infinity },
			];
			checkMonster();
		}
		
	}

}