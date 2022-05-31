/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
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
	
	use namespace CoC;
	
	public class Carrera extends AbstractSuccubus
	{
		
		
		override public function get long():String {
			var str:String = "";
			str += "This succubus has everything you would expect from one of her kind: a bust that would drive women wild with jealousy, hips that could melt a preacher's conviction, an ass so perfectly rounded that it seems designed to be cupped. Her turquoise hair cascades around demonic horns that gleam like polished ivory, and her red eyes greedily drink in your every motion. She is wearing skimpy dress that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.";
			return str;
		}
		
		public function Carrera() 
		{
			createBreastRow(Appearance.breastCupInverse("L"));
			this.tallness = 8*12+6;
			initStrTouSpeInte(190, 190, 190, 200);
			initWisLibSensCor(200, 240, 290, 50);
			this.weaponAttack = 5;
			this.armorDef = 10;
			this.armorMDef = 10;
            this.bonusHP = 500;
			this.bonusLust = 582;
			this.level = 52;
			this.gems = rand(15) + 10;
			this.createPerk(PerkLib.OverMaxHP, 52, 0, 0, 0);//v1 = enemy lvl
			this.a = "";
			this.short = "Carrera";
			this.imageName = "milkysuccubus";
			//this.imageName = "succubus";
			this.long = "";
			//this.long = "She stands about six feet tall and is hugely voluptuous, her impressive breasts wobble delightfully as she moves.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  She is wearing rags that cover only a tiny fraction of her body, concealing just her naughty bits to make the whole display more erotic.  She's using a leather whip as a weapon.";
			//this.long = "You are fighting a milky, cow-like succubus.  She stands about seven feet tall and is hugely voluptuous, with breasts three times the size of her head, tipped with a cluster of four obscenely teat-like nipples.  Her hips flare out into an exaggerated hourglass shape, with a long tail tipped with a fleshy arrow-head spade that waves above her spankable butt.  A small cowbell is tied at the base of the arrow-head with a cute little ribbon.  Wide, cow-like horns, easily appropriate for a minotaur, rise from her head, and she flicks bovine ears about the sides of her head whilst sashaying from side to side on demonic, high-heeled feet.  Her skin is a vibrant purple with splotches of shiny black here and there, including one large spot covering her right eye.  She's using a leather whip as a weapon.";
			//this.long = "The succubus across from you balances gracefully on her spiked heels, twirling and moving unpredictably.  Sexy dark stockings hug every curve of her perfectly shaped flesh until they disappear into her tiny miniskirt.  Her impressive breasts wobble delightfully as she moves, despite the inadequate efforts of her straining vest.  A pair of foot-long horns curve up from her otherwise perfect face and forehead, wreathed in lustrous blonde hair.  The very air around her is filled with an unidentifiable fragrance that makes you tingle and shiver.";
			//this.long = "This succubus has everything you would expect from one of her kind: a bust that would drive women wild with jealousy, hips that could melt a preacher's conviction, an ass so perfectly rounded that it seems designed to be cupped, and a smoldering visage that simultaneously entices whilst wearing a domineering grin. Her raven hair cascades around ram horns that gleam like polished ivory, and her red eyes greedily drink in your every motion. What clothing she wears is only designed to enhance her rampant sexuality, somehow making her look more naked than if she actually were.";
			//this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 30, 0, 0, 0);
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 72;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			this.skinTone = "tan";
			this.hairColor = "turquoise";
			this.hairLength = 7;
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.armorName = "skin";
			this.lustVuln = .1;
			this.lust = 30;
			this.drop = NO_DROP;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.horns.type = Horns.DEMON;
			this.horns.count = 12;
			this.wings.type = Wings.BAT_LIKE_TINY;
			this.wings.desc = "tiny hidden";
			this.tailType = Tail.DEMONIC;
			this.lowerBody = LowerBody.DEMONIC_HIGH_HEELS;
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			checkMonster();
		}
	}
}