/**
 * ...
 * @author Ormael
 */
package classes.Scenes.NPCs 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.internals.*;
	
	public class Rangiku extends Monster
	{
		
		override public function get long():String
		{
			var str:String = "";
			str += "You are fighting a salamander – a little over seven foot tall woman with crimson scales covering his legs, back, and forearms, with a tail swishing menacingly behind him, ablaze with a red-hot fire.  Her strawberry blonde hair accents her sapphire eyes, while her body covers black robe.  Her fists are raised to her side, looking for any hole in your guard.";
			if (hasStatusEffect(StatusEffects.Lustzerking))
			{
				str += "\n\n<b>Looking at her posture and gaze indicates that she's currently under effect of some sort of berserking state.</b>";
			}
			return str;
		}
		
		public function Rangiku() 
		{
			this.a = "the ";
			this.short = "salamander";
			this.imageName = "rangiku";
			this.long = "";
			createVagina(true,VAGINA_WETNESS_NORMAL,VAGINA_LOOSENESS_NORMAL);
			createStatusEffect(StatusEffects.BonusVCapacity,120,0,0,0);
			createBreastRow(Appearance.breastCupInverse("G"));
			this.ass.analLooseness = ANAL_LOOSENESS_TIGHT;
			this.ass.analWetness = ANAL_WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,30,0,0,0);
			this.tallness = 93;
			this.hipRating = HIP_RATING_CURVY+3;
			this.buttRating = BUTT_RATING_JIGGLY;
			this.skinTone = "light";
			this.hairColor = "strawberry blonde";
			this.hairLength = 39;
			initStrTouSpeInte(110, 120, 100, 200);
			initLibSensCor(250, 200, 50);
			this.weaponName = "fists";
			this.weaponVerb="smash";
			this.weaponAttack = 26 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorName = "black robe";
			this.armorDef = 21 + (3 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
			this.armorPerk = "";
			this.armorValue = 50;
			this.bonusHP = 100;
			this.bonusLust = 20;
			this.lust = 30;
			this.lustVuln = .35;
			this.temperment = TEMPERMENT_RANDOM_GRAPPLES;
			this.level = 15;//15-30-45-60->xx lvl progression
			this.gems = 15 + rand(8);
			this.drop = new ChainedDrop().
					//add(armors.CHBIKNI,1/20).
					//add(weapons.SCIMITR,1/20).
					add(consumables.SALAMFW,0.7);
			this.tailType = TAIL_TYPE_SALAMANDER;
			this.tailRecharge = 0;
			this.createPerk(PerkLib.IceVulnerability, 0, 0, 0, 0);
			this.str += 22 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.tou += 24 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.spe += 20 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.inte += 40 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];			
			this.lib += 50 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			this.newgamebonusHP = 3120;
			checkMonster();
		}
		
	}

}