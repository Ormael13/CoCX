package classes.Scenes.Dungeons.HelDungeon
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.Scenes.SceneLib;

public class HarpyMob extends Monster
	{
		public function harpyHordeAI():void {
			if(rand(3) == 0) harpyHordeLustAttack();
			else if(rand(3) > 0) harpyHordeClawFlurry();
			else harpyHordeGangBangAttack();
		}
		
		//ATTACK ONE: Claw Flurry
		public function harpyHordeClawFlurry():void {
			outputText("The harpies lunge at you, a veritable storm of talons and claws raining down around you.  You stumble back, trying desperately to deflect some of the attacks, but there are simply too many to block them all!  Only a single harpy in the brood seems to be holding back...\n");
			//(Effect: Multiple light attacks)
			createStatusEffect(StatusEffects.Attacks, 3 + rand(3),0,0,0);
			eAttack();
		}
		
		//ATTACK TWO: Gangbang
		public function harpyHordeGangBangAttack():void {
			outputText("Suddenly, a pair of harpies grabs you from behind, holding your arms to keep you from fighting back! Taking advantage of your open state, the other harpies leap at you, hammering your chest with punches and kicks - only one hangs back from the gang assault.\n\n");
			player.createStatusEffect(StatusEffects.HarpyBind,0,0,0,0);
			//(PC must struggle:
			harpyHordeGangBangStruggle(false);
		}
		
		public function harpyHordeGangBangStruggle(clearDisp:Boolean = true):void {
			if(clearDisp) clearOutput();
			//Success: 
			if((rand(10) == 0 && player.str/5 + rand(20) >= 23) || player.hasPerk(PerkLib.FluidBody)) {
				player.removeStatusEffect(StatusEffects.HarpyBind);
				outputText("With a mighty roar, you throw off the harpies grabbing you and return to the fight!");
			}
			//Failure: 
			//If fail:
			else {
				var damage:Number = 80 + rand(40);
				outputText("You struggle in the harpies' grasp, but can't quite get free.  The brood continues to hammer away at your defenseless self. ");
				damage = player.takePhysDamage(damage, true);
			}
		}
		
		//ATTACK THREE: LUSTY HARPIES!
		public function harpyHordeLustAttack():void {
			outputText("The harpies back off for a moment, giving you room to breathe - only to begin a mini strip-tease, pulling off bits of clothing to reveal their massive asses and hips or bearing their small, perky tits.  They caress themselves and each other, moaning lewdly.  Distracted by the burlesque, you don't notice a lipstick-wearing harpy approach you until it's too late!  She plants a kiss right on your lips, ");
			if(player.findPerk(PerkLib.LuststickAdapted) >= 0) outputText("doing relatively little thanks to your adaptation");
			else {
				outputText("sending shivers of lust up your spine");
				player.dynStats("lus", 5);
				if(player.hasCock()) player.dynStats("lus", 15);
			}
			outputText(".");
			player.dynStats("lus", 10);
		}
		
		override protected function performCombatAction():void
		{
			harpyHordeAI();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.dungeons.heltower.pcDefeatsHarpyHorde();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (player.isGargoyle()) SceneLib.dungeons.heltower.gargoyleBadEndPhoenixTower();
			else SceneLib.dungeons.heltower.pcLosesToHarpyHorde();
		}
		
		public function HarpyMob()
		{
			this.a = "the ";
			this.short = "harpy horde";
			this.imageName = "harpymob";
			this.long = "You are surrounded by a wing of particularly large and muscular harpies, perhaps a dozen of them in total.  All of them are clad in simple brown shifts that give them good camouflage in the mountains, and are using their talon-like claws as weapons against you. While not a great threat to a champion of your ability individually, a whole brood of them together is... something else entirely.";
			this.plural = true;
			this.pronoun1 = "they";
			this.pronoun2 = "them";
			this.pronoun3 = "their";
			this.createVagina(false, VaginaClass.WETNESS_SLAVERING, VaginaClass.LOOSENESS_GAPING_WIDE);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_STRETCHED;
			this.ass.analWetness = AssClass.WETNESS_SLIME_DROOLING;
			this.tallness = rand(8) + 70;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE;
			this.lowerBody = LowerBody.HARPY;
			this.skin.setBaseOnly({color:"red"});
			this.skinDesc = "feathers";
			this.hairColor = "black";
			this.hairLength = 15;
			initStrTouSpeInte(85, 100, 160, 50);
			initWisLibSensCor(50, 80, 45, 50);
			this.weaponName = "claw";
			this.weaponVerb="claw";
			this.weaponAttack = 37;
			this.armorName = "armor";
			this.armorDef = 20;
			this.armorMDef = 2;
			this.bonusHP = 1000;
			this.bonusLust = 100;
			this.lust = 20;
			this.lustVuln = .2;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 28;
			this.gems = rand(25)+140;
			this.additionalXP = 50;
			this.tailType = Tail.HARPY;
			this.drop = NO_DROP;
			this.createPerk(PerkLib.EnemyGroupType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
