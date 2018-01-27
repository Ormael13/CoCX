/**
 * ...
 * @author Zakanard
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.internals.WeightedDrop;

use namespace CoC;
	
	public class Aiko extends Monster
	{
		
		public function Aiko() 
		{
			this.a = "";
			this.short = "Aiko";
			this.imageName = "aiko";
			this.long = "Aiko stands before you, 5 foot 4 tall. She has a head of short silver-blonde hair that ends above her shoulders, parted by two large, furry fox ears. Seven luxurious fox tails sway behind her, the silky fur shimmering as they move. She wears a set of revealing robes, neatly pressed and hung off her features with care, her D-cup breasts bound by a cloth chest wrap that is just a little too tight. She wields a longbow almost as tall as she is that she can summon and dismiss with a snap of her fingers, and stares you down with a determined fire in her glittering blue eyes.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 20, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 64;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.skinTone = "pale";
			this.skin.base.pattern = Skin.PATTERN_MAGICAL_TATTOO;
			this.hairColor = "silver-blonde";
			this.hairLength = 5;
			initStrTouSpeInte(40, 40, 170, 200);
			initWisLibSensCor(150, 60, 65, flags[kFLAGS.AIKO_CORRUPTION]);
			this.weaponName = "claws";
			this.weaponVerb="punch";
			this.weaponAttack = 8;
			this.weaponRangeName = "longbow";
			this.weaponRangeVerb = "shoot";
			this.weaponRangeAttack = 30;
			this.armorName = "robes";
			this.armorDef = 5;
			this.bonusHP = 120;
			this.bonusLust = 20;
			this.lust = 20;
			this.lustVuln = 0.9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 35;
			this.drop = new WeightedDrop().
					add(armors.ARCBANG,1).
					add(consumables.FOXJEWL,4);
			this.tailType = Tail.FOX;
			checkMonster();
		}
	}
}