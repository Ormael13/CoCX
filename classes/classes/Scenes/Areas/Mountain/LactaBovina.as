/**
 * ...
 * @author ...
 */
package classes.Scenes.Areas.Mountain 
{

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class LactaBovina extends Monster
	{
		public function lactaBovinaBoobSlam():void {
			outputText("The cow girl runs towards you and rams her massive chest into your face. While its pillow-like nature prevents you from taking damage from this unconventional attack it leaves you more than slightly aroused.");
			player.dynStats("lus", player.lib + rand(player.lib));
		}
		public function lactaBovinaHoofs():void {
			outputText("The cow girl kicks you with her hoof. Her curvy form turns out to be deceptively muscular as the blow sends you flying back a few feet");
			if ((player.hasPerk(PerkLib.Resolute) && rand(20) == 0) || (!player.hasPerk(PerkLib.Resolute) && rand(4) == 0)) {
				outputText(", leaving you stunned");
				player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
			outputText(".");
		}
		public function lactaBovinaSwingThoseMilkJugs():void {
			outputText("The cow girl giggles and swings her massive udders from one side to another trying to catch your attention. It'd be hard not to pay attention to this spectacle.");
			player.dynStats("lus", Math.round(player.lib + rand(player.lib)*0.2));
		}
		
		override protected function performCombatAction():void {
			var choice:Number = rand(3);
			if (choice == 0) lactaBovinaBoobSlam();
			if (choice == 1) {
				if (rand(2) == 0 && !player.hasStatusEffect(StatusEffects.Stunned)) lactaBovinaHoofs();
				else eAttack();
			}
			if (choice == 2) lactaBovinaSwingThoseMilkJugs();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.mountain.lactabovinaScene.lactaBovinaVictoryRapeChoices();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.mountain.lactabovinaScene.lactaBovinaRape();
		}
		
		public function LactaBovina() 
		{
			var furColor:String = randomChoice("black","brown");
			this.a = "the ";
			this.short = "lacta bovine";
			this.imageName = "lactabovine";
			this.long = "You are fighting a Cow girl. Poor thing hasn't been milked in forever and is determined to force your mouth on her nipple or else! Her jugs are easily HH! She doesn't wield a weapon or clothes, not that any normal bra could ever contain her massive cleavage.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 100, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("HH"));
			this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.tallness = rand(27) + 69;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.skinTone = "light";
			this.hairColor = furColor;
			this.hairLength = 13;
			this.horns.type = Horns.COW_MINOTAUR;
			this.horns.count = 2;
			initStrTouSpeInte(65, 80, 50, 60);
			initWisLibSensCor(60, 50, 30, 35);
			this.weaponName = "fists";
			this.weaponVerb = "punch";
			this.weaponAttack = 26;
			this.armorName = "skin";
			this.armorDef = 40;
			this.armorMDef = 20;
			this.bonusHP = 100;
			this.bonusLust = 95;
			this.lust = 40;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.gems = rand(15) + 15;
			this.level =15;
			this.tailType = Tail.COW;
			this.drop = new WeightedDrop().
					add(necklaces.COWBELL, 12).
					add(undergarments.COW_BRA, 10).
					add(undergarments.COW_PANTY, 8).
					//add(consumables., 10).	- for lacta bovinba milk (like mino cum)
					add(consumables.PROBOVA, 4).
					add(consumables.LABOVA_, 7);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}