/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.*;

	public class Veronika extends Monster
	{
		private function veronikaAttack1():void {
			wrath -= 30;
			var damage:Number = 0;
			damage += eBaseStrengthDamage();
			damage *= 2;
			outputText(capitalA + short + " lift it weapon with all her strenght and smash it on your head. ");
			if(damage > 0) damage = player.takePhysDamage(damage, true);
			statScreenRefresh();
			outputText("\n");
		}
		
		override protected function performCombatAction():void
		{
			var choice:Number = rand(3);
			if (choice < 2) {
				if (wrath >= 30) veronikaAttack1();
				else eAttack();
			}
			if (choice == 2) eAttack();
		}
		
		public function Veronika() 
		{
			this.a = "the ";
			this.short = "nekomata";
			this.imageName = "veronika";
			this.long = "You are fighting a nekomata.";
			createVagina(true,VaginaClass.WETNESS_NORMAL,VaginaClass.LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			createBreastRow(Appearance.breastCupInverse("I"));//all god(ess) of war heralds if female would end up with K cup and been bit taller than race standars i think xD
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 92;
			this.hips.type = Hips.RATING_CURVY + 4;
			this.butt.type = Butt.RATING_JIGGLY + 1;
			this.skinTone = "light";
			this.hairColor = "red";//or crimson (red)?
			this.hairLength = 39;
			//if (flags[kFLAGS.RANGIKU_LVL_UP] < 1) {
				initStrTouSpeInte(110, 120, 100, 200);
				initWisLibSensCor(200, 250, 200, 50);
				this.weaponName = "dual large axes";
				this.weaponVerb="cleaves";
				this.weaponAttack = 26;
				this.armorName = "black robe";
				this.armorDef = 21;
				this.armorMDef = 7;
				this.bonusHP = 100;
				this.level = 15;
			//}
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().
					//add(armors.CHBIKNI,1/20).
					//add(weapons.SCIMITR,1/20).
					add(consumables.SALAMFW,0.7);
			this.arms.type = Arms.SALAMANDER;
			this.lowerBody = LowerBody.SALAMANDER;
			this.tailType = Tail.SALAMANDER;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Berzerker, 0, 0, 0, 0);
			this.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}