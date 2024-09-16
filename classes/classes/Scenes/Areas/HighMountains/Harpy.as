package classes.Scenes.Areas.HighMountains
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class Harpy extends Monster
	{

//*Note, special attack one is an idea based on Ceraph.
//About the attack that raises your Lust to 100 if you
//don't "wait" when she unleashes it. Alright, I
//basically used the idea, sorry. But it's a neat idea
//so it should be fitting, right? Or you could just
//dump it out altogether. It'd cause severe damage,
//in the 150 region if you don't wise up.*

		protected function harpyUberCharge():void
		{
			//(Harpy special attack 1, part one)
			if (!hasStatusEffect(StatusEffects.Uber)) {
				createStatusEffect(StatusEffects.Uber, 0, 0, 0, 0);
				outputText("Flapping her wings frantically, she flies away from you and gains height, hanging in the light before you.  She lets out a shrill and terrifying cry, narrowing her eyes as she focuses in on you!");
			}
			//(Harpy special attack 1, part two if PC does anything but "Wait")
			else {
				if (!Combat.playerWaitsOrDefends()) {
					outputText("The harpy lets out a terrible cry and drops, reaching an almost impossible speed as she dives down at you.  Her eyes are narrowed like a true bird of prey.  You were too busy with your own attack to avoid it!  Her claws surge down and pierce your [armor] like paper, driving hard into the flesh beneath and making you cry out in pain.  The harpy dumps you onto the ground, your wounds bleeding profusely. ");
					var damage:Number = (str + weaponAttack + 320 + rand(20)) * (1 + (player.newGamePlusMod() / 2));
					player.takePhysDamage(damage, true);
					removeStatusEffect(StatusEffects.Uber);
				}
				else {
					outputText("You stand firm and ready yourself as the crazed harpy hovers above you. Letting out an ear-splitting cry she dives at you with her claws extended, reaching an incredible speed before she levels out.  The harpy is heading right for you!  Thanks to your ready position, you manage to dive aside just as the harpy reaches you.  She clips you slightly, spinning you as you dive for the ground.  You hit the ground hard, but look up in time to see her make a rough, graceless landing.  Her body rolls until it reached a standstill.  The enraged harpy drags herself up and takes flight once more!  ");
					player.takePhysDamage(100 + rand(10), true);
					removeStatusEffect(StatusEffects.Uber);
					HP -= 20;
				}
			}
		}

		//(Harpy special attack 2, lust increase)
		protected function harpyTease():void
		{
			outputText("The harpy charges at you carelessly, her body striking you with the full weight of her motherly hips.  The pair of you go crashing backwards onto the ground.  You grapple with her weighty ass, trying your best not to think dirty thoughts, but the way she's maniacally flapping and writhing her curvy body against you makes it impossible! After a brief, groping wrestle on the ground, she pushes you away and takes flight again.");
			player.takeLustDamage((25 + rand(player.effectiveSensitivity() / 4)), true);
		}

		public function hasUber():Boolean {
			return hasStatusEffect(StatusEffects.Uber)
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.mountain.harpyScene.harpyVictoryuuuuu();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nYour foe doesn't seem disgusted enough to leave...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.mountain.harpyScene.harpyLossU();
			}
		}

		override protected function outputPlayerDodged(dodge:int):void
		{
			outputText("With another deranged cry the harpy dives at you, swinging her razor-sharp talons through the air with the grace of a ballerina. Your quick reflexes allow you to dodge every vicious slash she makes at you.\n");
		}

		override public function outputAttack(damage:int):void
		{
			if (damage <= 0) {
				outputText("The harpy dives at you with her foot-talons, but you deflect the attack, grasp onto her leg, and swing her through the air, tossing her away from you before she has a chance to right herself.");
			} else {
				outputText("The harpy surges forward, bringing her razor-sharp claws down on you, tearing at all the exposed flesh she can reach! <b>([font-damage]" + damage + "[/font])</b>");
			}
		}

		public function Harpy(noInit:Boolean=false)
		{
			if (noInit) return;
			trace("Harpy Constructor!");
			this.a = "the ";
			this.short = "harpy";
			this.imageName = "harpy";
			this.long = "You are fighting a tall, deranged harpy. She appears very human, about six feet six inches tall but covered in a fine layer of powder-blue down. Her arms are sinewy and muscular, with a long web connecting them to her ample hips, covered in stringy blue feathers to aid her flight. A larger pair of powdery-blue wings also protrudes from her shoulder blades, flapping idly. She appears quite deranged as she circles you, approaching and backing away erratically. Her face is quite beautiful, with fine lilac makeup adorning the features of a handsome woman, and her lips are traced with rich golden lipstick. As she circles you, squawking frantically and trying to intimidate you, your eyes are drawn to her slender torso and small, pert breasts, each the size of a small fruit and covered in a layer of the softest feathers which ripple and move with the gusts from her wings. As astounding as her breasts are, her egg-bearing hips are even more impressive.  They're twice as wide as her torso, with enormous, jiggling buttocks where her huge, meaty thighs are coming up to meet them. Her legs end in three-pronged talons; their shadowy black curves glinting evilly in the light.";
			// this.plural = false;
			this.flyer = true;
			this.createVagina(false, VaginaClass.WETNESS_SLICK, VaginaClass.LOOSENESS_GAPING_WIDE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 40, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("B"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,20,0,0,0);
			this.tallness = 6*12+6;
			this.hips.type = Hips.RATING_INHUMANLY_WIDE;
			this.butt.type = Butt.RATING_EXPANSIVE;
			this.lowerBody = LowerBody.HARPY;
			this.skin.setBaseOnly({color:"pink"});
			this.skinDesc = "feathers";
			this.hairColor = "blue";
			this.hairLength = 16;
			initStrTouSpeInte(390, 300, 510, 210);
			initWisLibSensCor(240, 270, 120, 60);
			this.weaponName = "talons";
			this.weaponVerb="slashing talons";
			this.weaponAttack = 225;
			this.armorName = "feathers";
			this.armorDef = 500;
			this.armorMDef = 100;
			this.bonusHP = 2000;
			this.bonusLust = 448;
			this.lust = 10;
			this.lustVuln = .6;
			this.level = 58;
			this.gems = 45 + rand(10);
			this.drop = new ChainedDrop().add(armors.W_ROBES,1/10)
					.add(consumables.SKYSEED,1/5)
					.elseDrop(consumables.GLDSEED);
			if (player.hasPerk(PerkLib.LuststickAdapted)) {
				(this.drop as ChainedDrop).add(consumables.LUSTSTK, 1/3)
			}
			this.wings.type = Wings.HARPY;
			this.abilities = [
				{ call: eAttack, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: harpyTease, type: ABILITY_TEASE, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: harpyUberCharge, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY]},
				{ call: harpyUberCharge, type: ABILITY_PHYSICAL, range: RANGE_MELEE, tags:[TAG_BODY], condition: hasUber, weight: Infinity}
			];
			this.createStatusEffect(StatusEffects.Flying,50,0,0,0);
			checkMonster();
		}

	}

}
