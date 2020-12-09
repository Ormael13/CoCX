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
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Lily extends AbstractSpiderMorph//drider cumdump slave from swamp area
	{
		
		/*
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.swamp.corruptedDriderScene.defeatDriderIntro();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe drider licks her lips in anticipation...");
				doNext(SceneLib.combat.endLustLoss);
			}
			else SceneLib.swamp.corruptedDriderScene.loseToDrider();
		}
		*/
		public function Lily() 
		{
			if (flags[kFLAGS.LILY_STATUS] < 1) {
				initStrTouSpeInte(110, 75, 70, 100);
				initWisLibSensCor(100, 80, 50, 90);
				this.weaponAttack = 30;
				this.armorDef = 60;
				this.armorMDef = 6;
				this.bonusHP = 400;
				this.bonusLust = 152;
				this.level = 22;
			}
			this.a = "";
			this.short = "Lily";
			this.imageName = "corrupteddrider";
			this.long = "Lily is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  "+(LilyFollower.LilyPierced ? "Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ":"")+"On her face and forehead, a sextet of lust-filled, " + LilyFollower.LilySkinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + LilyFollower.LilyHairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  Her spider-half has eight spindly legs with black and " + LilyFollower.LilyHairColor + " stripes - a menacing display if ever you've seen one.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 70, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,70,0,0,0);
			this.tallness = 10*12;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DRIDER;
			this.hairColor = LilyFollower.LilyHairColor;
			this.hairLength = 24;
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.armorName = "carapace";
			this.armorPerk = "";
			this.armorValue = 70;
			if (LilyFollower.LilyPierced) this.nipplesPierced = 1;
			this.lust = 35;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.gems = rand(15) + 35;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}