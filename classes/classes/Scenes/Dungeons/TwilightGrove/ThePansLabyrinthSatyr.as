/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons.TwilightGrove 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Face;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class ThePansLabyrinthSatyr extends Monster
	{
		public function MaddeningTuneGo():void {
			var turn:Number = statusEffectv1(StatusEffects.MaddeningTune);
			switch (turn) {
				case 6:
					outputText("You run after the evil satyr, determined to break the illusion. However, he keeps playing and teasing you from an unknown location as you try to find him.\n\n");
					break;
				case 5:
					outputText("You keep running, your frustration only increasing as the satyr keeps eluding you, teasing you with his lunatic music.\n\n");
					break;
				case 4:
					outputText("You start hearing things. Mocking laughter and nightmarish growls echo around you as you keep chasing the satyr. This music is getting to you.\n\n");
					break;
				case 3:
					outputText("You see the satyr’s face everywhere now, mocking you and laughing at you as you are caught in the delusion of the goat man surging from the adjacent walls every now and then to assault you"+((player.hasCock() || player.biggestTitSize()>0)?"r endowments, swiftly"+(player.biggestTitSize()>0?" groping your [breast] ":"")+(player.gender>2?" and":"")+(player.hasCock()?" pulling your [cock]":"")+"":"")+". This phantom teasing is driving you through complete paranoia. You need to stop him!\n\n");
					var lustDmg:int = rand(player.lib / 10) + rand(this.lib / 5) + 5;
					lustDmg = Math.round(lustDmg);
					player.takeLustDamage(lustDmg, true);
					break;
				case 2:
					outputText("It's no longer just about the satyr, the very walls of the labyrinth have turned into tentacle plants. They assault your body constantly while the goat man’s voice mocks you, laughing at your attempt to defeat him. His face is on every wall and his cock is visible in every corner, dripping with such dirty shamelessness.\n\n");
					outputText("\"<i>Just a little longer and you will be all done.</i>\"\n\n");
					outputText("You are losing it if it goes on any longer you will break.\n\n");
					break;
				default:
					outputText("You laugh and cry hysterically… There is no hope in this labyrinth. You are surrounded, defeated and most of all, horny. You simply throw yourself at your delusions, desiring to abandon your very being fully to this horny madness.\n\n");
					break;
			}
			if (statusEffectv1(StatusEffects.MaddeningTune) == 1) SceneLib.dungeons.twilightgrove.defeatedByThePansLabyrinthSatyr();
			else addStatusValue(StatusEffects.MaddeningTune,1,-1);
		}
		
		override protected function performCombatAction():void
		{
			MaddeningTuneGo();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatThePansLabyrinthSatyr();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.dungeons.twilightgrove.defeatedByThePansLabyrinthSatyr();
		}
		
		public function ThePansLabyrinthSatyr() 
		{
			this.a = "The ";
			this.short = "Pan’s labyrinth Satyr";
			this.imageName = "satyr";
			this.long = "You are fighting a satyr flutist. While you have no visual on him you can hear him play his damned flute trying to drive you mad with lust and fear as he harasses you with his magical music.";
			// this.plural = false;
			this.createCock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = rand(37) + 64;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_AVERAGE + 1;
			this.lowerBody = LowerBody.HOOFED;
			this.bodyColor = "tan";
			this.hairColor = randomChoice("black","brown");
			this.hairLength = 3+rand(20);
			this.faceType = Face.COW_MINOTAUR;
			initStrTouSpeInte(188, 175, 275, 175);
			initWisLibSensCor(150, 180, 105, 20);
			this.weaponName = "fist";
			this.weaponVerb="punch";
			this.weaponAttack = 10;
			this.armorName = "thick fur";
			this.armorDef = 40;
			this.armorMDef = 10;
			this.bonusHP = 100;
			this.bonusLust = 324;
			this.lust = 20;
			this.lustVuln = 0.30;
			this.level = 39;
			this.gems = rand(30) + 30;
			this.drop = new ChainedDrop()
					.add(consumables.INCUBID,1/2)
					.add(weapons.SFLUTTE,1/4);
			this.tailType = Tail.GOAT;
			this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			createStatusEffect(StatusEffects.MaddeningTune,6,0,0,0);
			checkMonster();
		}
		
	}

}