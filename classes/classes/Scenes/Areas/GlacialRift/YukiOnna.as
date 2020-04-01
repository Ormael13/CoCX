/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class YukiOnna extends Monster
	{
		public function IcyKiss():void {
			outputText("Suddenly the Yuki Onna flies down and forcefully pulls you into a kiss. At first you’re confused but you quickly shove her away in panic as you begin freezing from the inside. She giggles as she takes back to the air, leaving you aroused and colder at the same time. Your lungs feel like they’re freezing, only accelerating your demise! ");
			player.createStatusEffect(StatusEffects.FrozenLung, 2, 0.03, 0, 0);
			var kissdmg:Number = this.inte + this.wis + this.lib;
			player.takeIceDamage(kissdmg, true);
			var kisslust:Number = (inte / 5) + rand(10);
			kisslust = Math.round(kisslust);
			player.dynStats("lus", kisslust, "scale", false);
		}
		
		public function IceArmor():void {
			outputText("With the Yuki Onna’s ice armor gone, she encases herself in a new layer taunting you to try and hit her.");
			createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
			createStatusEffect(StatusEffects.IceArmor, 5, 0, 0, 0);
		}
		
		public function ConeOfCold():void {
			outputText("The Yuki onna inhales then breathes a cone of ice magic out. The howling blast freezes you solid, encasing you in a thick layer of ice! ");
			var conedmg:Number = (this.str + this.spe + this.tou) * 5;
			player.takeIceDamage(conedmg, true);
			player.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		
		public function IcySpear():void {
			outputText("The Yuki Onna runs you through with her icy spear. The tip isn't as deadly as a metal weapon but the cold pierces you outright, leaving you with frostburns. ");
			var damage:Number = 0;
			damage += eBaseDamage();
			player.takePhysDamage(damage, true);
			var frostburnPlayer:Number = (this.str + this.spe + this.tou) * 2;
			player.takeIceDamage(frostburnPlayer, true);
			if (player.hasStatusEffect(StatusEffects.FrostburnDoT)) {
				player.addStatusValue(StatusEffects.FrostburnDoT,1,1);
				player.addStatusValue(StatusEffects.FrostburnDoT,3,1);
			}
			else player.createStatusEffect(StatusEffects.FrostburnDoT,4,0.02,0,0);
		}
		
		override protected function performCombatAction():void
		{
			if (!hasStatusEffect(StatusEffects.AbilityCooldown1) && !monsterIsStunned()) IceArmor();
			else {
				var choice:Number = rand(4);
				if (choice < 2) IcySpear();
				if (choice == 2) {
					if (player.hasStatusEffect(StatusEffects.Stunned)) IcyKiss();
					else ConeOfCold();
				}
				if (choice == 3) {
					if (player.hasStatusEffect(StatusEffects.FrozenLung)) IcySpear();
					else IcyKiss();
				}
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.glacialRift.yukionnaScene.winAgainstYukiOnna();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.glacialRift.yukionnaScene.loseToYukiOnna();
		}
		
		public function YukiOnna() 
		{
			this.a = "a ";
			this.short = "Yuki Onna";
			this.imageName = "yuki-onna";
			this.long = "You are fighting a Yuki Onna, a spiteful ice spirit who steals away the warmth of others. She look just like a human if not for her deathly pale skin, bluish lips and cold bluish nails. She flies in the air, dancing from side to side like falling snow, an icy spear in her hand ready to impale you at the first opportunity. The blizzard mirrors her anger, plummeting your body and blinding you somewhat. Defeating her with all these conditions is going to be a challenge.";
			// this.plural = false;
			this.createVagina(false, 1, 1);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 56;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.setBaseOnly({color:"pale blue"});
			this.hairColor = "silver white";
			this.hairLength = 25;
			initStrTouSpeInte(85, 10, 140, 195);
			initWisLibSensCor(165, 140, 50, 15);
			this.weaponName = "Icy spear";
			this.weaponVerb="pummel";
			this.weaponAttack = 34;
			this.armorName = "Snowy Kimono";
			this.armorDef = 0;
			this.armorMDef = 0;
			this.bonusHP = 450;
			this.bonusLust = 10;
			this.lust = 25 + rand(15);
			this.lustVuln = 0.46;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 40;
			this.gems = 55 + rand(20);
			this.drop = new WeightedDrop()
					.add(armors.BLIZZ_K, 1)
					.add(headjewelries.SNOWFH, 1)
					.add(consumables.QWHITED, 1)
					.add(consumables.SNOWW_D, 5)
					.add(consumables.WHITEIS, 5)					
					.add(null, 5);
			this.wings.type = Wings.LEVITATION;
			this.wings.desc = "levitation";
			//this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			this.createStatusEffect(StatusEffects.AbilityCooldown1, 8, 0, 0, 0);
			this.createStatusEffect(StatusEffects.IceArmor, 5, 0, 0, 0);
			this.createStatusEffect(StatusEffects.Flying, 50, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.IceNature, 0, 0, 0, 0);
			this.createPerk(PerkLib.IcyFlesh, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}