/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.Monster;
	
public class Tyrantia extends Monster
	{
		private function basicAttack():void {
			outputText("The Giantess Drider stabs toward you, her phallus-spear glistening. Your body feels warmer wherever the thing touches you, blood flowing faster than usual.");
			var dmg:Number = 0;
			dmg += this.str;
			dmg += eBaseStrengthDamage() * 0.25;
			dmg += this.weaponAttack;
			player.takePhysDamage(dmg, true);
			player.takePhysDamage(dmg, true);
			player.takePhysDamage(dmg, true);
			player.dynStats("lus", (8 + int(player.lib / 20 + player.cor / 25)));
		}
		
		private function lustAura():void {
			outputText("Tyrantia’s eyes close momentarily, and a wave of energy pulses from her, in sickening pink and black waves. Lust and pain intermingled fills your senses for a split second, and she groans. The energy stops, leaving you hornier, and feeling a little dirtier, than before.");
			player.dynStats("cor", 1, "lus", (8 + int(player.lib / 20 + player.cor / 25)));
		}
		
		public function Tyrantia() 
		{
			this.a = "";
			this.short = "Tyrantia";
			this.imageName = "corrupteddrider";
			this.long = "The Drider Giantess stands off, her Dick held firmly in both hands. The spear quivers as she keeps it level, the tip and long shaft between you and her. Tyrantia’s fangs quiver, clear liquid beading on the ends. Her black lips are drawn into a tight smile, her five functioning eyes glaring, and you see the razor-sharp boot-spikes on her eight legs glinting in the sunlight. She stands 14 feet tall, and the air around her starts to darken as you approach. Maybe this wasn’t the best idea.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity,100,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,100,0,0,0);
			this.tallness = 14*12;
			this.hips.type = Hips.RATING_CURVY + 3;
			this.butt.type = Butt.RATING_JIGGLY;
			this.lowerBody = LowerBody.DRIDER;
			this.skinTone = "brown";
			this.hairColor = "red";
			this.hairLength = 24;
			initStrTouSpeInte(275, 310, 190, 150);
			initWisLibSensCor(100, 280, 150, 100);
			this.weaponName = "Dick";
			this.weaponVerb="piercing stab";
			this.weaponAttack = 90;
			this.armorName = "carapace";
			this.armorDef = 120;
			this.armorMDef = 120;
			this.bonusHP = 300;
			this.bonusLust = 488;
			this.lustVuln = .1;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 58;
			this.gems = rand(10) + 40;
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null, 4);
			this.abilities = [
				{ call: basicAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: lustAura, type: ABILITY_TEASE, range: RANGE_SELF, tags:[]},,
			]
			this.createPerk(PerkLib.EnemyHugeType,0,0,0,0);
			this.createPerk(PerkLib.TankI,0,0,0,0);
			checkMonster();
		}
		
	}

}