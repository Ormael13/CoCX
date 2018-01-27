/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.SceneLib;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class Diana extends Monster
	{
		public var dianaScene:DianaFollower = SceneLib.dianaScene;
		
		override public function defeated(hpVictory:Boolean):void
		{
			dianaScene.wonOverDiana();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			dianaScene.lostToDiana();
		}
		
		override public function get long():String {
			var str:String = "";
			if (game.flags[kFLAGS.DIANA_LVL_UP] >= 4) {
				str += "You are fighting a white furred 7 foot tall alicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
			}
			else if (game.flags[kFLAGS.DIANA_LVL_UP] >= 3 && game.flags[kFLAGS.DIANA_LVL_UP] < 4) {
				str += "You are fighting a white furred 6.8 foot tall unicorn with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
			}
			else {
				str += "You are fighting a white furred 6.6 foot tall horse morph with long white hair and a decently toned body. Her green eyes follows your every move, looking for an exploitable opening. She’s currently in a defensive stance, ready to strike with her staff or kick your face with her hooves at the first opportunity.";
			}
			return str;
		}
		
		public function Diana() 
		{
			if (flags[kFLAGS.DIANA_LVL_UP] == 0) {
				this.a = "the ";
				this.short = "horse morph";
				this.imageName = "whitemare";
				this.tallness = 6*12+6;
				this.hairLength = 12;
				initStrTouSpeInte(25, 25, 25, 75);
				initWisLibSensCor(25, 50, 50, 50);
				this.weaponAttack = 6;
				this.armorDef = 6;
				this.level = 3;
				this.bonusHP = 30;
				this.gems = rand(5) + 25;
				this.drop = new ChainedDrop().
					add(weapons.W_STAFF,1/10).
					add(consumables.EQUINUM,1/2);
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 1) {//lvl 6
				this.a = "the ";
				this.short = "horse morph";
				this.imageName = "whitemare";
				this.tallness = 6*12+6;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 2) {//lvl 9
				this.a = "the ";
				this.short = "unicorn";
				this.imageName = "unicornmare";
				this.tallness = 6*12+8;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 3) {//lvl 12
				this.a = "the ";
				this.short = "unicorn";
				this.imageName = "unicornmare";
				this.tallness = 6*12+8;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 4) {//lvl 15
				this.a = "the ";
				this.short = "alicorn";
				this.imageName = "diana";
				this.tallness = 7*12;
			}
			if (flags[kFLAGS.DIANA_LVL_UP] == 5) {//lvl 18
				this.a = "";
				this.short = "Diana";
				this.imageName = "diana";
				this.tallness = 7*12;
			}
			this.long = "";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_NORMAL, VaginaClass.LOOSENESS_NORMAL);
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_VIRGIN;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.hips.type = Hips.RATING_CURVY;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.HOOFED;
			this.skinTone = "pale";
			this.hairColor = "white";
			this.weaponName = "staff";
			this.weaponVerb="smack";
			this.armorName = "tough hide";
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.bonusLust = 20;
			this.tailType = Tail.HORSE;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}