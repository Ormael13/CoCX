package classes.Scenes.Monsters 
{
	import classes.*;
	import classes.internals.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kFLAGS;
	
	public class ImpWarlord extends Imp
	{
		public function clawAttack():void {
			outputText("The imp warlord charges at you with his claws ready! ");
			if (player.getEvasionRoll()) {
				outputText("You manage to avoid his claws thanks to your reaction!");
				combatRoundOver();
				return;
			}
			else {
				outputText("The imp manages to swipe you!  You let out a cry in pain. ");
				var damage:int = rand(50) + str + weaponAttack;
				damage = player.reduceDamage(damage);
				if (damage < 20) damage = 20;
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}

		public function doubleAttack():void {
			outputText("The imp warlord charges at you with his claws ready and sword raised! ");
			if (player.getEvasionRoll()) {
				outputText("You manage to dodge his deadly attack!");
				combatRoundOver();
				return;
			}
			else {
				outputText("The imp manages to slash you with his sword and his deadly claws!");
				var damage:int = rand(50) + str + weaponAttack;
				damage = player.reduceDamage(damage);
				if (damage < 20) damage = 20; //Min-cap damage.
				if (damage >= 50) {
					outputText("You let out a cry in pain and you swear you could see your wounds bleeding. ");
					player.createStatusEffect(StatusEffects.IzmaBleed, 2, 0, 0, 0);
				}
				else {
					outputText("Thankfully the wounds aren't that serious. ");
				}
				player.takeDamage(damage, true);
			}
			combatRoundOver();
		}

		
		override public function defeated(hpVictory:Boolean):void
		{
			game.flags[kFLAGS.DEMONS_DEFEATED]++;
			game.impScene.defeatImpLord();
		}

		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			game.impScene.loseToAnImpLord();
		}
		
		public function ImpWarlord() 
		{
			super(true);
			this.a = "the ";
			this.short = "imp warlord";
			this.imageName = "impwarlord";
			this.long = "The greater imp has an angular face, complete with curved nose and burnt red skin typical of imps.  He has a black hair on his head and his eyes are deep black.  Just above his long pointed ears are two curved bovine horns.  While still short, he's much taller than the average imp, being nearly four feet tall, and extremely well-muscled.  A pair of powerful wings extends out from his shoulders, however, you suspect he wouldn't be able to fly for long due to his extreme bulk.  A thick coating of fur starts at his well toned hips and works its way down his powerful legs.  His legs end in a pair of oddly jointed, demonic hooves.  His demonic figure is completed by a thin tail that has an arrowhead shaped tip.\n\nUnlike most imps, he is wearing a metal chestplate and bracers for protection. He doesn't appear to be wearing anything other than his armor and loincloth.  He wields a sword in his right hand and he doesn't appear to wield anything in his left hand, suggesting that he also attacks with his claws.";
			// this.plural = false;
			// Imps now only have demon dicks.
			// Not sure if I agree with this, I can imagine the little fuckers abusing the
			// shit out of any potions they can get their hands on.
			this.createCock(rand(2) +11,2.5,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 1;
			this.cumMultiplier = 3;
			this.hoursSinceCum = 20;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_NORMAL;
			this.tallness = rand(14) + 40;
			this.hipRating = HIP_RATING_BOYISH;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_HOOFED;
			this.skinTone = "red";
			initStrTouSpeInte(80, 65, 85, 56);
			initLibSensCor(55, 35, 100);
			this.weaponName = "sword";
			this.weaponVerb="slash";
			this.weaponAttack = 20;
			this.armorName = "platemail";
			this.armorDef = 17;
			this.bonusHP = 350;
			this.lust = 30;
			this.lustVuln = .4;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 16;
			this.gems = rand(20) + 40;
			this.drop = new WeightedDrop().
					add(consumables.MINOBLO,2).
					add(consumables.LABOVA_,2).
					add(consumables.INCUBID,12).
					add(consumables.SUCMILK,12).
					add(jewelries.POWRRNG,1);
			this.wingType = WING_TYPE_IMP;
			this.special1 = lustMagicAttack;
			this.special2 = clawAttack;
			checkMonster();
		}
		
	}

}