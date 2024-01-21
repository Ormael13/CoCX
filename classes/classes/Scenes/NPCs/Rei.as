/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;

use namespace CoC;
	
	public class Rei extends Monster
	{
		
		public function Rei() 
		{
			this.a = "the ";
			this.short = "corrupted basic flesh golem";
			this.imageName = "corrupted basic flesh golem";
			this.long = "You're currently fighting a corrupted basic flesh golem. She's seven feet tall, her flesh covered sporadically by fragments of what must have once been a decorative set of armour. They seem to have been broken in places, but the shards of armor still provide decent protection. Several large holes in the armour were clearly made intentionally, exposing a throbbing cock and firm breasts. The golem keeps its head aligned with you, large, gaping mouth open constantly. She clutches a pair of swords in her meaty fists.";
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			//this.createVagina(true, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 200, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("C"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.createStatusEffect(StatusEffects.BonusACapacity, 200, 0, 0, 0);
			initStrTouSpeInte(120, 140, 110, 10);
			initWisLibSensCor(10, 100, 50, 100);
			this.tallness = 84;
			this.hips.type = Hips.RATING_AVERAGE + 1;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.bodyColor = "pink";
			this.weaponName = "dual swords";
			this.weaponVerb = "slash";
			this.weaponAttack = 50;
			this.armorName = "white armor";
			this.armorDef = 40;
			this.armorMDef = 20;
			this.bonusHP = 350;
			this.lust = 30;
			this.bonusLust = 185;
			this.lustVuln = .5;
			this.level = 35;
			this.additionalXP = 350;
			this.gems = rand(10)+5;
			this.tailType = Tail.DEMONIC;
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(consumables.BROBREW, 1).
					add(weapons.DDAGGER, 10).
					add(weapons.DL_AXE_, 10).
					add(weapons.DSWORD_, 10).
					add(weapons.DKATANA, 10).
					add(weapons.D_LANCE, 10);
			this.createStatusEffect(StatusEffects.LowtierMagicImmunity, 0, 0, 0, 0);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.Sentience, 0, 0, 0, 0);//flesh gargoyle perk
			this.createPerk(PerkLib.EnemyFleshConstructType, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.CheetahI, 0, 0, 0, 0);//flesh gargoyle perk
			this.createPerk(PerkLib.GoliathI, 0, 0, 0, 0);//flesh gargoyle perk
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			//this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}