package classes.Scenes.Areas.GlacialRift 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.Scenes.SceneLib;
import classes.internals.WeightedDrop;

public class Yeti extends Monster
	{
		public var tempSpeedLoss:Number = 0;
		
		public function yetiClawAndPunch():void {
			if (player.getEvasionRoll()) {
				outputText("The yeti beast charges at you, though his claws only strike at air as you move nimbly over the ice flooring beneath you. The beast lets out an annoyed snarl.")
			}
			else {
				if (hasStatusEffect(StatusEffects.Blind) && rand(3) > 0) {
					outputText("The yeti furiously charges at you but blind as he is, he ends up running into the wall face-first instead. ");
					var yetiDamage:Number = 30 + rand(50);
					HP -= yetiDamage;
					outputText("The beast takes <b><font color=\"#080000\">" + yetiDamage + "</font></b> damage. ");
					if (rand(2) == 0) {
						outputText("<b>He is now stunned.</b>");
						createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
					}
					return;
				}
				outputText("Like a white blur the yeti charges you, striking at you with his claws and slashing over your [armor] before a fist collides with your side, sending you sliding over the icy floor. ");
				var damage:Number = str + 25 + rand(50);
				player.takePhysDamage(damage, true);
			}
		}
		public function yetiTackleTumble():void {
			if (player.getEvasionRoll()) {
				//yeti takes moderate damage
				outputText("Sensing the beast’s intentions as you hear the cracking of ice under his feet, you dart to the side as the beast launches at you. With wide eyes, the ice yeti collides face first into the wall of the cave with a yelped growl. It rubs its face as it glares at you. ");
				var yetiDamage:Number = 30 + rand(50);
				HP -= yetiDamage;
				outputText("The beast takes <b><font color=\"#080000\">" + yetiDamage + "</font></b> damage.");
			}
			else {
				//take heavy damage
				outputText("The beast’s hind claws dig into the ice before his giant furred body launches at you and he collides with you in a brutal tackle. The pair of you are sent rolling around on the floor as you trade blows with the furred beast, and then he lifts you up and tosses you aside, your body hitting the ice walls with a groan. You shakily get to your feet. ");
				var damage:Number = str + 50 + rand(150);
				player.takePhysDamage(damage, true);				
			}
		}
		public function yetiSnowball():void {
			if (player.getEvasionRoll()) {
				outputText("The beast steps back, magic condensing mist into ice within his hand. With narrow eyes you ready your body, and as soon as the ball of frost is whipped at you, you dart to the side avoiding it. The ice shatters uselessly against the wall, the ice yeti looking quite annoyed in your direction. ");
			}
			else {
				if (hasStatusEffect(StatusEffects.Blind) && rand(3) > 0) {
					outputText("The beast takes a step back, mist forming into a ball in his clenched fist. It condenses into a ball before your eyes, and with a growl the beast whips it at you. Blind as he is, the ball ends up missing you and hitting the wall instead.");
					return;
				}
				outputText("The beast takes a step back, mist forming into a ball in his clenched fist. It condenses into a ball before your eyes, and with a growl the beast whips it at you. The ball slams into your [armor] and explodes into frost, you hiss at the sting. The frost is also restricting your movement. ");
				var damage:Number = (str / 2) + rand(20);
				if (player.findPerk(PerkLib.FromTheFrozenWaste) >= 0 || player.findPerk(PerkLib.ColdAffinity) >= 0) damage *= 0.1;
				if (player.findPerk(PerkLib.FireAffinity) >= 0) damage *= 3;
				damage = Math.round(damage);
				player.takeMagicDamage(damage, true);
				tempSpeedLoss += 10;
				player.dynStats("spe", -10);
			}
			//take slight damage, reduce speed
			//nothing
		}
		public function yetiTease():void {
			//lust increased
			if (rand(player.lib + player.cor) >= 30 && rand(3) > 0) {
				outputText("You stare the beast down, though it looks like he’s distracted, with a hand dipping down to fondle his own ballsack. As your eyes follow it, you see a girthy red tip peeking out of his sheath, looking slick and releasing a wisp of steam in the air. Watching something so lewd has brought warmth to your body in this frozen cave, and you begin to wonder if his intentions are to eat or fuck you.");
				player.dynStats("lust", 20 + rand(10));
			}
			else outputText("The beast before you seems a bit distracted, a hand dipping to fondle his ballsack, but you keep your focus fixed on the monsters face, unwilling to let your guard waver for even a moment.");
		}
		
		override protected function performCombatAction():void
		{
			var chooser:Number = 0;
			chooser = rand(10);
			if (chooser < 2) eAttack();
			if (chooser >= 2 && chooser < 4) yetiClawAndPunch(); //40% chance
			if (chooser >= 4 && chooser < 7) yetiTackleTumble(); //30% chance
			if (chooser >= 7 && chooser < 9) yetiTease(); //20% chance
			if (chooser >= 9) yetiSnowball(); //10% chance
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			player.dynStats("spe", tempSpeedLoss);
			SceneLib.glacialRift.yetiScene.winAgainstYeti();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			player.dynStats("spe", tempSpeedLoss);
			SceneLib.glacialRift.yetiScene.loseToYeti();
		}
		
		public function Yeti() 
		{
			this.a = "a ";
			this.short = "yeti";
			this.imageName = "yeti";
			this.long = "You are fighting an ice yeti, a savage of the north built to endure and hunt in the unforgiving cold. Every inch of its body is covered in a thick white pelt, though you can still make out the definition of bulging muscles from underneath. Its face is beastial, with narrow slitted eyes, and a pressed in feline nose all over a large maw of sharp, jagged teeth. It’s a menacing sight to behold. It standing about eight feet tall, with long tree trunk wide limbs ending in claws sharp enough to dig into thick ice. There’s no question about gender; it’s obviously a male. A large, thick sheath  protects his manhood from the freezing weather, and below are a pair of baseball sized testicles, held tight against his warm body by a heavy, furred ballsack.";
			// this.plural = false;
			this.createCock(12, 1.5, CockTypesEnum.HUMAN);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 2;
			createBreastRow(Appearance.breastCupInverse("flat"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_NORMAL;
			this.tallness = 8*12;
			this.hips.type = Hips.RATING_BOYISH;
			this.butt.type = Butt.RATING_TIGHT;
			this.skin.growFur({color:"light"});
			this.hairColor = "white";
			this.hairLength = 8;
			initStrTouSpeInte(140, 160, 80, 50);
			initWisLibSensCor(40, 40, 20, 45);
			this.weaponName = "fists";
			this.weaponVerb="punch";
			this.weaponAttack = 36;
			this.armorName = "thick fur";
			this.armorDef = 30;
			this.bonusHP = 1000;
			this.bonusLust = 10;
			this.lust = 10;
			this.lustVuln = 0.4;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 37;
			this.gems = 45 + rand(30);
			this.drop = new WeightedDrop()
					.add(consumables.YETICUM, 1)
					.add(null, 2);
			this.createStatusEffect(StatusEffects.GenericRunDisabled, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.FireVulnerability, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyBeastOrAnimalMorphType, 0, 0, 0, 0);
			checkMonster();
		}
		
	}

}
