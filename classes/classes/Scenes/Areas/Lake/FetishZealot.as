package classes.Scenes.Areas.Lake
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

public class FetishZealot extends Monster
	{

		private static const RELIGIOUS_CLOTHES:String = "religious clothes";
		private static const PIRATE_CLOTHES:String = "pirate clothes";
		private static const MILITARY_CLOTHES:String = "military clothes";
		private static const LEATHER_CLOTHES:String = "leather clothes";
		private static const STUDENTS_CLOTHES:String = "student's clothes";

		override public function combatRoundUpdate():void
		{
			super.combatRoundUpdate();
			var changed:Boolean = false;
			//Fetish Zealot Update!
			switch (rand(5)) {
				case 0:
					//Religious outfit!
					if (armorName != RELIGIOUS_CLOTHES) {
						long = "The "+this.short+" is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none of them included the large slit at the front that lets his above average sized human dick stick out of the front.";
						this.armorName = RELIGIOUS_CLOTHES;
						changed = true;
					}
					break;
				case 1:
					//Pirate Outfit
					if (armorName != PIRATE_CLOTHES) {
						this.armorName = PIRATE_CLOTHES;
						long = "You are faced with one of the strangest things you have ever seen in your life.  A stereotypical pirate, who has not replaced his hand with a hook, but rather a collection of sex toys.  You can see at least two dildos, a fleshlight, and numerous other toys that you're incapable of recognizing.";
						changed = true;
					}
					break;
				case 2:
					//Military Uniform
					if (armorName != MILITARY_CLOTHES) {
						long = "In front of you is someone wearing a green military uniform.  They obviously aren't in any military you've ever heard of, as on his shoulder he has emblazoned <i>FF Army Sex Instructor</i>.  It seems you are his latest recruit...";
						this.armorName = MILITARY_CLOTHES;
						changed = true;
					}
					break;
				case 3:
					//Leather fetish shiiiiite
					if (armorName != LEATHER_CLOTHES) {
						long = "The "+this.short+" has taken on an appearance that seems more suitable for the level of perversion he exudes.  He is wearing a full-body suit of leather, with a cock case over his crotch; you can clearly see a large zipper on it.  The zipper handle is far bigger than you think is absolutely necessary.";
						this.armorName = LEATHER_CLOTHES;
						changed = true;
					}
					break;
				case 4:
					//Student
					if (armorName != STUDENTS_CLOTHES) {
						long = "The "+this.short+" seems to have taken on the appearance of a young adult wearing a student uniform of sorts; of course, this isn't any less perverted than any of the other costumes this man wears.  This one includes a number of loose straps that you're certain would cause large sections of his clothes to fall off if somebody pulled on them.";
						this.armorName = STUDENTS_CLOTHES;
						changed = true;
					}

					break;
			}
			//Talk abouts it mang!
			if(changed) outputText("The "+this.short+"'s clothing shifts and twists, until he is wearing " + armorName + ".\n\n");
			lust += lustVuln * 5;
		}

//Special1: Tease
	//See Costumes section for text
	private function zealotSpecial1():void {
		//Costumes
		//This foe periodically switches between outfits; this determines what text is displayed when they use tease.
		
		//Perverted religious costume;
		if(armorName == RELIGIOUS_CLOTHES) {
			//The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.
			outputText("The "+this.short+" cries out \"<i>Child, are you ready to present your offering to the holy rod?</i>\" while indicating his cock sliding between his robes.  The whole scene leaves you distracted for a few moments and significantly aroused.");
		}
		//A pirate costume;
		if(armorName == PIRATE_CLOTHES) {
			//You are faced with one of the strangest things you have ever seen in your life.  A stereotypical pirate, who has not replaced his hand with a hook, but rather a collection of sex toys.  You can see at least two dildos, a fleshlight, and numerous other toys that you're incapable of recognizing.
			outputText("The "+this.short+" turns to the side holding his prosthetic towards you and doing something that sends the devices spinning and clicking.  <i>So that's how that would work...</i> you find yourself thinking for a few moments before realizing that he had both distracted and aroused you.");
		}
		//Military attire;
		if(armorName == MILITARY_CLOTHES) {
			//In front of you is someone wearing a green military uniform.  They obviously aren't in any military you've ever heard of, as on his shoulder he has emblazoned <i>FF Army Sex Instructor</i>.  It seems you are his latest Recruit...
			outputText("He suddenly barks, \"<i>Let's see those genitals, soldier!</i>\" ");
			//[player is corrupt]
			if(player.cor > 50) outputText("You eagerly cry out \"<i>Yes, sir!</i>\" and show yourself off to the best of your ability.  The whole act is extremely arousing.");
			//[player is not corrupt]
			else outputText("You have no idea why, but you promptly display yourself in the most provocative way possible.  After a moment you realize what you're doing and quickly stop, flushed with embarrassment and arousal.");
		}
		//Gimp gear;
		if(armorName == LEATHER_CLOTHES) {
			//The Zealot has taken on an appearance that seems more suitable for the level of perversion he exudes.  He is wearing a full-body suit of leather, with a cock case over his crotch; you can clearly see a large zipper on it.  The zipper handle is far bigger than you think is absolutely necessary.
			outputText("The "+this.short+" turns around and gives you a full view of his tight leather clad body.  He smacks his ass and says \"<i>You like what you see, don't you " + player.mf("stud","slut") + "?</i>\"  You can't help but be incredibly aroused by the scene.");
		}
		//Well dressed and well groomed student in uniform;
		if(armorName == STUDENTS_CLOTHES) {
			//The Zealot seems to have taken on the appearance of a young adult wearing a student uniform of sorts; of course, this isn't any less perverted than any of the other costumes this man wears.  This one includes a number of loose straps that you're certain would cause large sections of his clothes to fall off if somebody pulled on them.
			outputText("The "+this.short+" student looks at you a little shyly and sticks a pencil in his mouth while pushing a hand in front of his groin, trying to hide a rather obvious bulge.  The whole scene is rather cute, and you feel incredibly aroused afterwards.");
		}
		var mlt:Number = 20;
		if (flags[kFLAGS.FETISH_FOLLOWER_SUBTYPE] == 2) mlt -= 15;
		if (flags[kFLAGS.FETISH_FOLLOWER_SUBTYPE] == 4) mlt -= 10;
		player.takeLustDamage((7+rand(player.lib/mlt+player.cor/mlt)), true);
	}
	//Special2: Lust transfer spell, it becomes more and
	//more likely that he will use this power as his lust gets
	//higher, but he can use it at any time (like the cultist).
	private function zealotSpecial2():void {
		outputText("The "+this.short+" suddenly cries out and extends his arms towards you; your mind is suddenly overwhelmed with a massive wave of arousal as images of every kind of fetish you can imagine wash over you, all blended together.  After a moment you are able to recover, but you notice that the "+this.short+" doesn't seem to be as aroused as before.");
		player.takeLustDamage(lust/2, true);
		lust /= 2;
	}

		override protected function postAttack(damage:int):void
		{
			if (damage > 0){
				outputText("\nYou notice that some kind of unnatural heat is flowing into your body from the wound");
				if (player.inte > 50) outputText(", was there some kind of aphrodisiac on the knife?");
				else outputText(".");
				player.takeLustDamage((player.lib / 10 + 10), true);
			}
			super.postAttack(damage);
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.lake.fetishZealotScene.zealotDefeated();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe "+this.short+" ignores the perverse display and continues on as if nothing had happened...");
				player.orgasm();
				doNext(SceneLib.lake.fetishZealotScene.zealotLossRape);
			} else {
				SceneLib.lake.fetishZealotScene.zealotLossRape();
			}
		}

		public function FetishZealot()
		{
			trace("FetishZealot Constructor!");
			if (flags[kFLAGS.FETISH_FOLLOWER_SUBTYPE] == 1) {
				this.short = "fetish zealot";
				this.long = "The zealot is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
				initStrTouSpeInte(87, 95, 70, 10);
				initWisLibSensCor(10, 85, 100, 100);
				this.weaponAttack = 15;
				this.armorDef = 20;
				this.armorMDef = 10;
				this.bonusLust = 195;
				this.level = 10;
				this.gems = 10+rand(15);
			}
			if (flags[kFLAGS.FETISH_FOLLOWER_SUBTYPE] == 2) {
				this.short = "fetish priest";
				this.long = "The priest is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
				initStrTouSpeInte(690, 710, 800, 100);
				initWisLibSensCor(100, 800, 820, 100);
				this.weaponAttack = 340;
				this.armorDef = 1000;
				this.armorMDef = 500;
				this.bonusHP = 10000;
				this.bonusLust = 1724;
				this.level = 104;
				this.gems = 110+rand(10);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.FETISH_FOLLOWER_SUBTYPE] == 4) {
				this.short = "fetish inquisitor";
				this.long = "The inquisitor is clad in a bizarre set of religious robes.  They are similar to what you've seen on other religious leaders from home, but none that included the large slit at the front that lets his above average sized human dick stick out the front.";
				initStrTouSpeInte(240, 345, 260, 60);
				initWisLibSensCor(60, 315, 330, 100);
				this.weaponAttack = 120;
				this.armorDef = 300;
				this.armorMDef = 150;
				this.bonusHP = 2000;
				this.bonusLust = 688;
				this.level = 43;
				this.gems = 30+rand(10);
				this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			}
			this.a = "the ";
			this.imageName = "fetishzealot";
			// this.plural = false;
			this.createCock(7,1.5);
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_LOOSE;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,40,0,0,0);
			this.tallness = 6*12;
			this.hips.type = Hips.RATING_BOYISH + 1;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "tan";
			this.hairColor = "black";
			this.hairLength = 4;
			this.weaponName = "wavy dagger";
			this.weaponVerb="stab";
			this.armorName = RELIGIOUS_CLOTHES;
			this.lust = 25;
			this.lustVuln = 0.75;
			this.drop = new WeightedDrop().add(armors.C_CLOTH,1)
					.add(consumables.L_DRAFT,2)
					.add(weapons.L_DAGGR,1);
			this.special1 = zealotSpecial1;
			this.special2 = zealotSpecial2;
			checkMonster();
		}

	}

}
