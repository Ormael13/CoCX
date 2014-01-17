package classes.Scenes.Dungeons.Factory
{
	import classes.CoC;
	import classes.Cock;
	import classes.Items.Armors.LustyMaidensArmor;
	import classes.Monster;
	import classes.CockTypesEnum;
		
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
			init01Names("the ", "incubus mechanic", "incubusmechanic", "The demon before you is clad only in cut-off denim overalls.  Covered in stains of oil and other strange fluids, they appear to be in pretty rough shape.  There is a large hole ripped in the crotch, allowing the demon's foot-long member to hang free.  His skin is light purple and perfect, contrasting with the slovenly appearance of his clothing.  His face is rugged and handsome, topped with a simple black ponytail and two large horns that sprout from his forehead like twisted tree-trunks.  He wears a narrow goatee on his chin that is kept skillfully braided.  A cocky smile always seems to grace his features, giving him an air of supreme confidence.");
			init02Male(new Cock(12,1.75,CockTypesEnum.DEMON),2,2,3);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(9) + 70,HIP_RATING_AMPLE,BUTT_RATING_TIGHT,LOWER_BODY_TYPE_DEMONIC_CLAWS);
			init06Skin("light purple");
			init07Hair("black",12);
			init08Face(faceType,earType,tongueType,eyeType);
			init09PrimaryStats(65,40,45,85,80,70,80);
			init10Weapon("claws","claw",10,"",150);
			init11Armor("demonic skin",10);
			init12Combat(150,50,.5,Monster.TEMPERMENT_LOVE_GRAPPLES);
			init13Level(8,rand(25)+10);
			init14FixedDrop(consumables.GROPLUS);
			initX_Specials(11035,11036);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Wings(WING_TYPE_BAT_LIKE_TINY,"tiny hidden");
		}
	}
}