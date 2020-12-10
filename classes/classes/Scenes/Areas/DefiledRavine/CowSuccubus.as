/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.DefiledRavine 
{
	import classes.*;
	import classes.internals.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.BodyParts.Horns;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Monsters.AbstractSuccubus;
	import classes.Scenes.Areas.BlightRidge.DemonScene;
	
	use namespace CoC;
	
	public class CowSuccubus extends AbstractSuccubus
	{
		
		public function CowSuccubus() 
		{
			this.a = "the ";
			this.short = "milky succubus";
			this.imageName = "milkysuccubus";
			this.long = "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 300, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("Z"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = 84;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.skinTone = "blue";
			this.hairColor = "black";
			this.hairLength = 13;
			initStrTouSpeInte(130, 100, 180, 120);
			initWisLibSensCor(120, 150, 60, 100);
			this.weaponName = "whip";
			this.weaponVerb="whipping";
			this.weaponAttack = 34;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 22;
			this.armorMDef = 2;
			this.bonusHP = 700;
			this.bonusLust = 241;
			this.lust = 40;
			this.lustVuln = .3;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 31;
			this.gems = rand(40)+50;
			this.additionalXP = 100;
			this.drop = NO_DROP;
			this.horns.type = Horns.COW_MINOTAUR;
			this.horns.count = 2;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			//this.special1 = kissAttack;	- potem sprawdzić czy bdą przydatne i zatrzymane czy combat ai dla moba je zastąpi
			//this.special2 = seduceAttack;
			//this.special3 = whipAttack;
			this.drop = new WeightedDrop().
					add(consumables.BIMBOLQ, 1).
					add(weapons.WHIP, 2).
					//add(consumables., 6).	- for lacta bovinba milk (like mino cum)
					add(consumables.LABOVA_, 8).
					add(consumables.SUCMILK, 10);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
	}
}