package classes.Scenes.Dungeons.Factory
{
	import classes.*;
	import classes.Items.Armors.LustyMaidensArmor;
	import classes.internals.*;

	public class IncubusMechanic extends Monster {

		override public function defeated(hpVictory:Boolean):void
		{
			if(player.gender == 0) {
				if (hpVictory){
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?", true);
				} else {
					outputText("You smile in satisfaction as the " + short + " collapses, masturbating happily.  Now would be the perfect opportunity to test his demonic tool...\n\nHow do you want to handle him?", true);
				}
				game.simpleChoices("Anally",11063,"Orally",11039,"",0,"",0,"Leave",game.cleanupAfterCombat);
			}
			else {
				if (hpVictory) {
					outputText("You smile in satisfaction as the " + short + " collapses, unable to continue fighting.  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do, rape him, service him, or let him take you anally?", true);
					game.dynStats("lus", 1);
					game.simpleChoices("Rape",11064,"Service Him",11039,"Anal",11063,"Nothing",game.cleanupAfterCombat,"",0);
				} else {
					outputText("You smile in satisfaction as the " + short + " collapses, masturbating happily.  Now would be the perfect opportunity to put his tool to use...\n\nWhat do you do?", true);
					var temp2:Function = null;
					if(player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") temp2 = game.createCallBackFunction2((player.armor as LustyMaidensArmor).lustyMaidenPaizuri,player,this);
					game.dynStats("lus", 1);
					game.simpleChoices("Rape",11064,"Service Him",11039,"Anal",11063,"B.Titfuck",temp2,"Nothing",game.cleanupAfterCombat);
				}
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if(pcCameWorms){
				outputText("\n\nYour foe doesn't seem to care...");
				doNext(game.endLustLoss);
			} else {
				game.eventParser(11038);
			}
		}

		public function IncubusMechanic() {
			this.a = "the ";
			this.short = "incubus mechanic";
			this.imageName = "incubusmechanic";
			this.long = "The demon before you is clad only in cut-off denim overalls.  Covered in stains of oil and other strange fluids, they appear to be in pretty rough shape.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, contrasting with the slovenly appearance of his clothing.  His face is rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He wears a narrow goatee on his chin that is kept skillfully braided.  A cocky smile always seems to grace his features, giving him an air of supreme confidence.";
			// this.plural = false;
			this.createCock(12,1.75,CockTypesEnum.DEMON);
			this.balls = 2;
			this.ballSize = 2;
			this.cumMultiplier = 3;
			// this.hoursSinceCum = 0;
			createBreastRow(0);
			this.ass.analLooseness = ANAL_LOOSENESS_STRETCHED;
			this.ass.analWetness = ANAL_WETNESS_SLIME_DROOLING;
			this.tallness = rand(9) + 70;
			this.hipRating = HIP_RATING_AMPLE;
			this.buttRating = BUTT_RATING_TIGHT;
			this.lowerBody = LOWER_BODY_TYPE_DEMONIC_CLAWS;
			this.skinTone = "light purple";
			this.hairColor = "black";
			this.hairLength = 12;
			initStrTouSpeInte(65, 40, 45, 85);
			initLibSensCor(80, 70, 80);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 10;
			this.weaponPerk = "";
			this.weaponValue = 150;
			this.armorName = "demonic skin";
			this.armorDef = 10;
			this.bonusHP = 150;
			this.lust = 50;
			this.lustVuln = .5;
			this.temperment = TEMPERMENT_LOVE_GRAPPLES;
			this.level = 8;
			this.gems = rand(25)+10;
			this.drop = new WeightedDrop(consumables.GROPLUS, 1);
			this.special1 = 11035;
			this.special2 = 11036;
			this.tailType = TAIL_TYPE_DEMONIC;
			this.wingType = WING_TYPE_BAT_LIKE_TINY;
			this.wingDesc = "tiny hidden";
			checkMonster();
		}
	}
}