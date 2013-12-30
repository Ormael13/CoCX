package classes.Monsters
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */


	public class DemonPack extends Monster
	{


		override protected function performCombatAction():void
		{
			//Demon pack has different AI
			game.eventParser((rand(2) == 0) ? special1 : special2);
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (hpVictory) {
				outputText("You strike out and the last of the demons tumbles to the ground with a thud. You stand there for a second surrounded by dead or unconscious demons feeling like a god of battle. Then you realize that if a god of battle does exist he lives on a demonic plane like this, so to avoid insulting him you take your hands off your hips and your " + player.legs() + " off the head of the demon leader before you start to search the bodies.", true);
				game.stats(0, 0, 0, 0, 0, 0, 1, 0);
			} else {
				outputText("The demons stop attacking, and reach out to touch your body. Some are already masturbating like it's the only thing in the world and you know that right now, if you wanted to, you could make each and every one of them fuck you.");
			}
			if(hasStatusAffect("phyllafight") >= 0) {
				game.doNext(game.consolePhylla);
			} else if (hpVictory){
				game.eventParser(5007);
			} else {
				outputText("  Do you rape them?", true);
				game.doYesNo(5045, 5007);
			}
		}

		public function DemonPack(mainClassPtr:*)
		{
			super(mainClassPtr);
			trace("DemonPack Constructor!");
			init01Names("the ", "demons", "demonmob", "The group is composed of roughly twenty tan-skinned demons, mostly humanoid in shape with many and varied corruptions across the mob. You see demonic high heels, twisting horns and swinging cocks of all shapes and sizes. There even seems to be a bull head in there somewhere. You also make out plenty of breasts ranging from tiny ones to a pair that requires a second person to carry them, and with those breasts a wide range of pussies, dripping and dry, sometimes nestled below some form of demonic dick.  The small tribe carries no weapons and what little clothing they wear is well-shredded, except for one hefty male wearing a cloak of what appears to be snakeskin across his broad shoulders." + (mainClassPtr.silly() ? "  You spot an odd patch that reads, \"<i>41st Engineer Company: Vaginal Clearance</i>\" on his shoulder." : ""),true);
			init02Male([new Cock(18,2),new Cock(18,2,CockTypesEnum.DEMON)],2,1,3);
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_SLIME_DROOLING);
			init05Body(rand(8) + 70,HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("red");
			init07Hair("black",15);
			init08Face();
			init09PrimaryStats(80,10,10,5,50,60,20);
			init10Weapon("claws","claw");
			init11Armor("demonic skin");
			init12Combat(200,30,1,TEMPERMENT_LOVE_GRAPPLES);
			init13Level(6,rand(25)+10);
			initX_Specials(5043,5044);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Horns(HORNS_DEMON);
		}

	}

}