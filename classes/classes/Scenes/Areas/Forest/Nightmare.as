/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Forest 
{
	import classes.*;
	import classes.BodyParts.Butt;
	import classes.BodyParts.Ears;
	import classes.BodyParts.Face;
	import classes.BodyParts.Hips;
	import classes.BodyParts.LowerBody;
	import classes.BodyParts.Tail;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Areas.Forest.NightmareScene;
	import classes.internals.*;
	
	use namespace CoC;
	
	public class Nightmare extends Monster
	{
		public var nightmareScene:NightmareScene = new NightmareScene();
		
		public function usingCorruptionBlast():void {
			outputText("The nightmare moans in pleasure as her massive equine cock begins to pulse with an unholy purple light.\n\n");
			outputText("\"<i>Oooooh....Ahhhh yessss, cuming I’m cuuuuming! Go on and watch, bathe in my depravity!!!</i>\"\n\n");
			outputText("She lifts her forelegs as her cock shoots a deluge of cum at you, her tainted fluids soaking in your skin.\n\n");
			dynStats("cor", 50, "lust", (player.lib + this.lust) * 2, "scale", false);
			this.lust = 0;
		}
		public function usingHeal():void {
			if (hasStatusEffect(StatusEffects.Uber)) {
				removeStatusEffect(StatusEffects.Uber);
				if (hasStatusEffect(StatusEffects.Stunned) || hasStatusEffect(StatusEffects.FrozenSolid) || hasStatusEffect(StatusEffects.StunnedTornado) || hasStatusEffect(StatusEffects.Fear) || hasStatusEffect(StatusEffects.Constricted) || hasStatusEffect(StatusEffects.ConstrictedScylla) || hasStatusEffect(StatusEffects.GooEngulf) || hasStatusEffect(StatusEffects.EmbraceVampire) || hasStatusEffect(StatusEffects.Pounce)) {
					outputText("The nightmare reels in frustration as her concentration breaks under your assaults.\n\n");
				}
				else {
					outputText("The nightmare laughs gleefully as her spell reaches completion, all of her wounds closing as her body basks in unholy healing magic.\n\n");
					outputText("\"<i>It does not matter how much you wound me. These are useless before my almighty healing powers.</i>\"\n\n");
					this.HP = this.maxHP();
				}
			}
			else {
				outputText("The nightmare weaves a few signs in the air, her twin horns glowing purple as she begins to cast a powerful spell.");
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
			}
		}
		public function usingWingBuffet():void {
			outputText("The nightmare stretches her black wings and beats them a few times at you, sending a powerful gust your way. You are knocked to the ground by the assault.");
			player.createStatusEffect(StatusEffects.Stunned,1,0,0,0);
		}
		public function usingTease():void {
			switch(rand(3)) {
				case 0:
					outputText("The nightmare takes on a pose, giving you a good display of her juicy horsecunt. This animalistic scent... Her primal musk is so powerful you barely hold yourself from jumping and shoving your face inside of her hole. More than aware of her effect on you she smiles and swishes her tail side-to-side seductively.\n\n");
					outputText("\"<i>Just give in and you will get to taste it however you want.</i>\"\n\n");
					break;
				case 1:
					outputText("The nightmare moans in pleasure as her horsecock drips a strand of black precum on the ground. You watch with a mix of arousal and horror as it drips on the grass, the vegetation changing color and growing into a new lewd, mutated form of plant. She watches your gaze amused.\n\n");
					outputText("\"<i>Can you imagine all the delightful effects it would have on you?!</i>\"\n\n");
					break;
				case 2:
					outputText("The nightmare cups her indecent breasts and moans teasingly, displaying them to you with open invitation.\n\n");
					outputText("\"<i>Don’t you want to kiss them, grope them and enjoy them?");
					if (player.hasCock()) outputText(" I could even let you slide that lovely [cock] inside and make you cum all over my face.");
					outputText("</i>\"\n\n");
					break;
			}
			var teaseD:Number = 0;
			teaseD += this.lib * 0.1;
			player.dynStats("lust", teaseD, "scale", false);
		}
		public function usingTouchOfCorruption():void {
			outputText("The nightmare’s hand glows with condensed corruption as she attempts to touch you. ");
			var dodged:String = player.getEvasionReason();
			if(dodged != null) {
				switch(dodged) {
					case EVASION_SPEED:
						outputText(" [Dodge]");
						break;
					case EVASION_EVADE:
						outputText(" [Evade]");
						break;
					case EVASION_MISDIRECTION:
						outputText(" [Misdirect]");
						break;
					case EVASION_FLEXIBILITY:
						outputText(" [Flexibility]");
						break;
					case EVASION_UNHINDERED:
						outputText(" [Unhindered]");
						break;
					default:
						CoC_Settings.error();
						outputText(" <b>[ERROR]</b>");
						break;
				}
			}
			else {
				outputText("Her hand slides on your skin leaving a tingling sensation of pleasure as the area she touched glows with tainted magic forcing a moan out you.");
				player.dynStats("cor", 5, "lib", 10, "sens", 10, "lust", (player.maxLust() * 0.05), "scale", false);
			}
		}
		
		public function AuraOfDamnation():void {
			outputText("You feel yourself progressively losing your resolve and restraint as the nightmare’s aura seeps in and corrupts the core of your very being!\n\n");
			player.dynStats("cor", 5, "lib", 10, "sens", 10, "lust", 10, "scale", false);
			if (player.cor >= 100) nightmareScene.nightmareVictory();
		}
		
		override protected function performCombatAction():void
		{
			if (player.cor < 100) AuraOfDamnation();
			if (this.lust >= this.maxLust() * 0.8) usingCorruptionBlast();
			if (hasStatusEffect(StatusEffects.Uber)) {
				usingHeal();
				return;
			}
			var choice:Number = rand(4);
			if (choice == 0) usingTouchOfCorruption();
			if (choice == 1) usingTease();
			if (choice == 2) usingWingBuffet();
			if (choice == 3) usingHeal();
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			nightmareScene.nightmareDefeat();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			nightmareScene.nightmareVictory();
		}
		
		public function Nightmare() 
		{
			this.a = "the ";
			this.short = "nightmare";
			this.imageName = "nightmare";
			this.long = "This creature is anathema to everything pure and good. The very avatar of depravity, the nightmare looks at you with a lewd and all the more evil expression. She has a pair of F cup breasts and a horsecock barely smaller than that of an adult minotaur capable of defiling anything it fills. Her body screams temptation better than that of any succubus.";
			// this.plural = false;
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 48, 0, 0, 0);
			this.createCock(rand(13)+ 24,2 + rand(3),CockTypesEnum.HORSE);
			this.balls = 2;
			this.ballSize = 2 + rand(13);
			this.cumMultiplier = 1.5;
			this.hoursSinceCum = this.ballSize * 10;
			createBreastRow(Appearance.breastCupInverse("F"));
			this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 4*12;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"tawny"});
			this.hairColor = "brown";
			this.hairLength = 5;
			initStrTouSpeInte(20, 125, 120, 20);
			initWisLibSensCor(20, 125, 75, 100);
			this.weaponName = "fists";
			this.weaponVerb="punch";
			this.weaponAttack = 1;
			this.armorName = "fur";
			this.armorDef = 4;
			this.armorMDef = 20;
			this.bonusHP = 1000;
			this.bonusLust = 10;
			this.lust = 20;
			this.lustVuln = .85;
			this.level = 20;
			this.gems = 8 + rand(11);
			this.drop = NO_DROP;
			this.ears.type = Ears.HORSE;
			this.faceType = Face.HORSE;
			this.tailType = Tail.HORSE;
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			checkMonster();
		}
	}
}