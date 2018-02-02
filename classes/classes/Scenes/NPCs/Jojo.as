package classes.Scenes.NPCs
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;

public class Jojo extends Monster
	{

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.jojoScene.defeatedJojo(hpVictory);
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.jojoScene.loseToJojo();
		}
		
		override protected function performCombatAction():void {
			if (JojoScene.monk > 1 && rand(2) == 0)
				selfCorruption(); //Shouldn't do any self corruption at monk one. Otherwise a 50/50 chance
			else eAttack();
		}
		
		private function selfCorruption():void {
			switch (JojoScene.monk) {
				case 2:
					outputText("Jojo looks lost in thought for a moment, and fails to attack.  ");
					lust += 4;
					break;
				case 3:
					outputText("Jojo blushes as he fights you, distracted by a stray thought.  You think you see a bulge in the loose cloth of his pants.  ");
					lust += 8;
					break;
				case 4:
					outputText("Jojo stumbles, shakes his head, and pulls one of his hands away from the stiff tent in his pants.  ");
					lust += 10;
					break;
				default:
					outputText("Jojo frantically jerks his " + cockDescriptShort(0) + ", stroking the " + cockDescriptShort(0) + " as it leaks pre-cum at the sight of you.  ");
					lust += 15;
			}
			
			if (lust >= 100) {
				doNext(SceneLib.combat.endLustVictory);
				return;
			}
			else if (lust >= 85)
				outputText("The mouse is panting and softly whining, each movement seeming to make his bulge more pronounced.  You don't think he can hold out much longer.  ");
			else if (lust >= 70)
				outputText("The mouse is having trouble moving due to the rigid protrusion from his groin.  ");
			else if (lust >= 60)
				outputText("The mouse's eyes constantly dart over your most sexual parts, betraying his lust.  ");
			else if (lust > 50)
				outputText("The mouse's skin remains flushed with the beginnings of arousal.  ");
			doNext(EventParser.playerMenu);
		}
		
		public function Jojo()
		{
			trace("Jojo Constructor!");
			this.a = "";
			this.short = "Jojo";
			this.imageName = "jojo";
			this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He wears loose white clothes wrapped in prayer beads and tattered prayer papers.";
			// this.plural = false;
			this.createCock(7.5,1.8);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 4*12;
			this.hips.type = Hips.RATING_SLENDER;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"white"});
			this.skinDesc = "fur";
			this.hairColor = "white";
			this.hairLength = 2;
			initStrTouSpeInte(45, 50, 75, 64);
			initWisLibSensCor(64, 15, 40, JojoScene.monk * 15);
			this.weaponName = "paw";
			this.weaponVerb="punch";
			this.weaponAttack = 5;
			this.armorName = "robes";
			this.armorDef = 1;
			this.lust = 15;
			this.lustVuln = .9;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 10;
			this.gems = rand(15) + 7;
			this.special1 = selfCorruption;
			//Create jojo sex attributes
			//Variations based on jojo's corruption.
			if(JojoScene.monk == 3) {
				this.lust += 30;
				this.cocks[0].cockThickness += .2;
				this.cocks[0].cockLength += 1.5;
				this.bonusLust = 10;
				if(player.gender == 1 || player.gender == 3) this.ass.analLooseness = 2;
			}
			if(JojoScene.monk == 4) {
				this.lust += 40;
				this.cocks[0].cockThickness += .5;
				this.cocks[0].cockLength += 3.5;
				this.bonusLust = 20;
				if(player.gender == 1 || player.gender == 3) this.ass.analLooseness = 3;
			}
			if(JojoScene.monk == 5) {
				this.lust += 50;
				this.cocks[0].cockThickness += 1;
				this.cocks[0].cockLength += 5.5;
				this.str -= 20 + (4 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.tou += 30 + (6 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.cor += 10;
				this.HP += 60 + (60 * flags[kFLAGS.NEW_GAME_PLUS_LEVEL]);
				this.bonusLust = 30;
				if(player.gender == 1 || player.gender == 3) this.ass.analLooseness = 4;
				this.long = "Jojo is an anthropomorphic mouse with immaculate white fur.  Though he stands only four feet tall, he is covered in lean muscle and moves with incredible speed.  He's naked, with a large tainted throbbing member bouncing at attention.  A fuzzy sack with painfully large looking balls dangles between his legs.";
			}
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}
