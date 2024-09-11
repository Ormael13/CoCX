package classes.Scenes.Places.Boat
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.*;
import classes.display.SpriteDb;

public class SharkGirl extends Monster
	{
		//Lust-based attacks:
		private function sharkTease():void {
			game.spriteSelect(SpriteDb.s_sharkgirl);
			if(rand(2) == 0) {
				outputText("You charge at the shark girl, prepared to strike again, but stop dead in your tracks when she bends over and wiggles her toned ass towards you. It distracts you long enough for her tail to swing out and smack you to the ground. She coos, \"<i>Aw... You really do like me!</i>\" ");
				//(Small health damage, medium lust build).
				player.takePhysDamage(4+rand(4), true);
				player.takeLustDamage((10+(player.lib/20)), true);
			}
			else {
				outputText("You pull your [weapon] back, getting a running start to land another attack. The Shark girl smirks and pulls up her bikini top, shaking her perky breasts in your direction. You stop abruptly, aroused by the sight just long enough for the shark girl to kick you across the face and knock you to the ground.  She teases, \"<i>Aw, don't worry baby, you're gonna get the full package in a moment!</i>\" ");
				//(Small health damage, medium lust build)
				player.takePhysDamage(4+rand(4), true);
				player.takeLustDamage((5+(player.lib/10)), true);
			}
		}
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.boat.sharkGirlScene.sharkWinChoices();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.boat.sharkGirlScene.sharkLossRape();
			}
		}

		public function SharkGirl()
		{
			trace("SharkGirl Constructor!");
			this.a = "the ";
			this.short = "shark-girl";
			this.imageName = "sharkgirl";
			this.long = "The shark girl stands just over 5'5\", with grey skin shimmering from water droplets catching the sunlight and slender muscles built for swimming.  Her shoulder-length silver hair brushes past her pretty face and her eyes are a striking shade of red. She has rows of intimidating sharp teeth glinting in the light. A fish-like tail protrudes from her backside, wrapping around her toned legs at every opportunity. She's wearing a rather skimpy black bikini, strings done in such a way that they move around her fin; though the swimwear itself barely covers her perky breasts and tight snatch.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_NORMAL);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 15, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 5*12+5;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "gray";
			this.hairColor = "silver";
			this.hairLength = 16;
			initStrTouSpeInte(210, 180, 120, 72);
			initWisLibSensCor(72, 150, 69, -20);
			this.weaponName = "shark teeth";
			this.weaponVerb="bite";
			this.weaponAttack = 50;
			this.armorName = "tough skin";
			this.armorDef = 48;
			this.armorMDef = 4;
			this.bonusHP = 200;
			this.bonusLust = 249;
			this.lust = 40;
			this.lustVuln = .9;
			this.level = 29;
			this.gems = rand(30) + 25;
			this.drop = new WeightedDrop().
					add(consumables.L_DRAFT,3).
					add(armors.S_SWMWR,1).
					add(consumables.SHARK_T,5).
					add(null,1);
			this.abilities = [
				{call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[]},
				{call: sharkTease, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
				{call: sharkTease, type: ABILITY_TEASE, range: RANGE_RANGED, tags:[]},
			];
			//this.special1 = sharkTease;
			//this.special2 = sharkTease;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}
