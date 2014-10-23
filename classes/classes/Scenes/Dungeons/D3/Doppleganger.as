package classes.Scenes.Dungeons.D3 
{
	import classes.BreastRowClass;
	import classes.Cock;
	import classes.Monster;
	import classes.VaginaClass;
	/**
	 * ...
	 * @author Gedan
	 */
	public class Doppleganger extends Monster
	{
		private var _roundCount:int = 0;
		
		public function Doppleganger() 
		{
			this.a = "the ";
			this.capitalA = "The ";
			this.short = "doppleganger";
			this.imageName = "doppleganger";
			this.plural = false;
			
			this.tallness = player.tallness;
			this.balls = player.balls;
			this.hoursSinceCum = player.hoursSinceCum;
			
			hipRating = player.hipRating;
			buttRating = player.buttRating;
			lowerBody = player.lowerBody;
			skinDesc = player.skinDesc;
			initStrTouSpeInte(player.str, player.tou, player.spe, player.inte);
			initLibSensCor(player.lib, player.sens, player.cor);
			faceType = player.faceType;
			skinType = player.skinType;
			
			this.weaponName = player.weaponName;
			this.weaponAttack = player.weaponAttack;
			this.weaponVerb = player.weaponVerb;
			
			this.armorDef = player.armorDef;
			this.armorName = player.armorName;
			
			this.level = player.level;
			
			this.ass.analLooseness = player.ass.analLooseness;
			this.ass.analWetness = player.ass.analWetness;
			
			if (player.cocks.length > 0)
			{
				for (var i:int = 0; i < player.cocks.length; i++)
				{
					this.createCock((player.cocks[i] as Cock).cockLength, (player.cocks[i] as Cock).cockThickness, (player.cocks[i] as Cock).cockType);
				}
			}
			
			if (player.vaginas.length > 0)
			{
				this.createVagina();
				(this.vaginas[0] as VaginaClass).vaginalLooseness = player.vaginas[0].vaginalLooseness;
				(this.vaginas[0] as VaginaClass).vaginalWetness = player.vaginas[0].vaginalWetness;
			}
			
			this.breastRows = [];
			
			for (i = 0; i < player.breastRows.length; i++)
			{
				this.createBreastRow();
				var tbr:BreastRowClass = this.breastRows[i];
				var sbr:BreastRowClass = player.breastRows[i];
				
				tbr.breastRating = sbr.breastRating;
				tbr.breasts = sbr.breasts;
				tbr.fuckable = sbr.fuckable;
				tbr.lactationMultiplier = sbr.lactationMultiplier;
				tbr.milkFullness = sbr.milkFullness;
				tbr.nipplesPerBreast = sbr.nipplesPerBreast;
			}
			
			checkMonster();
		}
		
		override public function get long():String
		{
			var str:String = "";
			
			str += "You are fighting the doppelganger. " + player.mf("He", "She") +" is a ";
			str += String(Math.floor(player.tallness / 12) + " foot " + player.tallness % 12 + " inch tall";
			str += player.race() + ", with " + player.bodyType() + ".";
			
			str += player.mf("His", "Her") + " face is " + player.faceDesc() + ", which is";
			
			if (player.femininity < 20) str += " strikingly masculine";
			else if (player.femininity < 40) str += " fairly masculine";
			else if (player.femininity < 60) str += " androgynous";
			else if (player.femininity < 80) str += " quite pretty";
			else str += " sweepingly feminine";
			
			str += ". "  + player.mf("His", "Her") + " " + player.hairDescript() + " is parted by";
			
			switch(player.earType)
			{
				case EARS_HORSE:
					str += " a pair of horse-like ears";
					break;
				case EARS_FERRET:
					str += " a small pair of rounded ferret ears";
					break;
				case EARS_DOG:
					str += " a pair of dog ears";
					break;
				case EARS_COW:
					str += " a pair of round, floppy cow ears";
					break;
				case EARS_ELFIN:
					str += " a large pair of pointy ears";
					break;
				case EARS_CAT:
					str += " a pair of cute, fuzzy cat ears";
					break;
				case EARS_LIZARD:
				case EARS_DRAGON:
					str += " a pair of rounded protrusions with small holes";
					break;
				case EARS_BUNNY:
					str += " a pair of floppy rabbit ears";
					break;
				case EARS_FOX:
					str += " a pair of large, adept fox ears";
					break;
				case EARS_RACCOON:
					str += " a pair of vaugely egg-shaped, furry racoon ears";
					break;
				case EARS_MOUSE:
					str += " a pair of large, dish-shaped mouse ears";
					break;
				default:
					str += " a pair of non-descript ears";
					break;
			}
			
			str += ". " + player.mf("He", "She") + " keeps exploring the area around " + player.mf("his", "her") +" mouth with " + player.mf("his", "her") +" tongue with a horribly acquisitive, sensual interest.";
			str += " " + player.mf("He", "She") + " moves around on " + player.mf("his", "her") +" " + player.legs() + " with a twitchy jerkiness, " + player.mf("his", "her") + " " + game.hipDescript() + " swinging and tightening.";
			if (player.tailType != 0) str += " " + player.mf("His", "Her") + " tail flicks this way and that.";
			str += " " + player.mf("He", "She") + " wields the exact same " + player.weaponName + " you do, and is dressed in the mirror image of your " + player.armorName +  ". ";
			if (player.biggestTitSize() >= 2) str += "It’s difficult not to notice the way the mirror image of your " + player.breastDescript(player.biggestTitRow) + " ebbs and heaves within it.";
			
			return str;
		}
		
	}

}