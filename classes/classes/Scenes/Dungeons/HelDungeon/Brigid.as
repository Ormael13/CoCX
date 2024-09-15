package classes.Scenes.Dungeons.HelDungeon
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.Scenes.SceneLib;

public class Brigid extends Monster
	{

		//Attack One: Hot Poker, Right Up Your Ass!
		private function brigidPoke():void {
			outputText("Brigid stalks forward with confidence, her shield absorbing your defensive blows until she's right on top of you. She bats your [weapon] aside and thrashes you with her hot poker, scalding your [skin] and sending you reeling. ");
			//(Effect: Heavy Damage)
			var damage:Number = Math.round((str + weaponAttack) - rand(player.tou) - player.armorDef);
			if (damage < 30) damage = 30;
			damage = Math.round(damage);
			damage = player.takeFireDamage(damage, true);
		}

		//Attack Two: SHIELD BOP! OOM BOP!
		private function brigidBop():void {
			outputText("The harpy feints at you with her poker; you dodge the blow, but you leave yourself vulnerable as she spins around and slams her heavy shield into you, knocking you off balance. ");
			//(Effect: Stagger/Stun)
			var damage:Number = 5;
			damage = player.takePhysDamage(damage, true);
			if(player.hasPerk(PerkLib.Resolute)) outputText("  Of course, your resolute posture prevents her from accomplishing much.");
			else player.createStatusEffect(StatusEffects.Stunned,0,0,0,0);
		}

		//Attack Three: Harpy Ass Grind GO!
		private function BrigidAssGrind():void {
			outputText("Brigid grins as she approaches you.  She handily deflects a few defensive blows and grabs you by the shoulders.  She forces you onto your knees and before you can blink, has turned around and smashed your face into her ass!  \"<i>Mmm, you like that, don'tcha?</i>\" she growls, grinding her huge, soft ass across your face, giving you an up-close and personal feel of her egg-laying hips.");
			player.takeLustDamage(30, true);
		}
		override protected function performCombatAction():void
		{
			if(player.hasStatusEffect(StatusEffects.Stunned)) {
				player.removeStatusEffect(StatusEffects.Stunned);
				if(rand(2) == 0) BrigidAssGrind();
				else brigidPoke();
				return;
			}
			if(rand(3) == 0) BrigidAssGrind();
			else if(rand(2) == 0) brigidBop();
			else brigidPoke();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.brigidScene.pcDefeatsBrigid();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.isGargoyle()) SceneLib.dungeons.heltower.gargoyleBadEndPhoenixTower();
			else SceneLib.brigidScene.pcDefeatedByBrigid();
		}

		public function Brigid()
		{
			this.a = "";
			this.short = "Brigid the Jailer";
			this.imageName = "brigid";
			this.long = "Brigid is a monster of a harpy, standing a foot taller than any other you've seen. She's covered in piercings, and her pink-dyed hair is shaved down to a long mohawk. She's nude, save for the hot poker in her right hand and the shield in her left, which jingles with every step she takes thanks to the cell keys beneath it.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_LOOSE);
			if (LowerBody.HARPY > 0) {
				this.createStatusEffect(StatusEffects.BonusVCapacity, LowerBody.HARPY, 0, 0, 0);
			}
			createBreastRow(Appearance.breastCupInverse("D"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = rand(8) + 82;
			this.hips.type = Hips.RATING_AMPLE + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.bodyColor = "red";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(140, 110, 140, 50);
			initWisLibSensCor(50, 70, 45, 0);
			this.weaponName = "poker";
			this.weaponVerb="burning stab";
			this.weaponAttack = 34;
			this.armorName = "armor";
			this.armorDef = 24;
			this.armorMDef = 2;
			this.bonusHP = 1000;
			this.bonusLust = 144;
			this.lust = 20;
			this.lustVuln = .25;
			this.level = 29;
			this.gems = rand(37)+210;
			this.additionalXP = 150;
			this.wings.type = Wings.FEATHERED_LARGE;
			this.tailType = Tail.DEMONIC;
			this.horns.type = Horns.DEMON;
			this.horns.count = 2;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.ShieldWielder, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
