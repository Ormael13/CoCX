/**
 * Created by aimozg on 18.01.14.
 */
package classes.Scenes.Quests.UrtaQuest
{
	import classes.Monster;
	import classes.Scenes.Monsters.Goblin;

	public class GoblinBroodmother extends Goblin
	{
		override public function defeated(hpVictory:Boolean):void
		{
			game.clearOutput();
			outputText("The goblin broodmother is defeated!  You find a bottle of succubi milk on her.  That stuff is banned in Tel'Adre - and for good reason, but it might come in handy.  You pocket the foul fluid for now.");
			outputText("  You could use her for a quick, willing fuck to sate your lusts before continuing on.  Do you?");
			game.menu();
			game.addButton(0,"Fuck",game.urtaQuest.winFuckAGoblinBroodmotherAsUrta);
			game.addButton(4,"Leave",game.urtaQuest.nagaPleaseNagaStoleMyDick);
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.urtaQuest.urtaLosesToGoblin();
		}

		public function GoblinBroodmother()
		{
			super(true);
			init01Names("the ", "goblin broodmother", "goblin", "Thanks to their corruption, it's almost impossible to discern a goblin's age by their appearance, but it's quite obvious that this one is no horny young slut looking for her first dozen or so studs.  Standing before you is an obvious veteran breeder, a proud motherwhore who doubtlessly has a sizable tribe of slutty daughters somewhere not too far away.  Maybe three and a half feet tall, she has vibrant yellow skin - a rare shade, for goblins - and a wild mane of flamboyant neon pink and neon blue striped hair that falls down her back, her long, pointed ears barely visible amongst it.  Her many pregnancies have rendered her absurdly voluptuous. I-cup tits wobble absurdly in the air before her, their jiggling expanse so big that it's a wonder she can reach out to her blatant, teat-like purple nipples. Broodmother hips flare out from her waist, making her sashay from side to side with every step. A gloriously round and luscious bubble-butt, big enough to be DD-cup tits if it were on somebody's chest, jiggles enticingly with every motion.  Lewd leather straps fight to contain her exaggerated boobs and ass, serving more to house clinking pouches and bottles than to provide any protection of her modesty.  Piercings stud her lips, nose, eyebrows, ears, nipples and clit, and her fiery red eyes smoulder as she seductively licks her lips at you.\n\nYour treacherous horse-cock aches to bury itself into this ripe, ready slut, but you have to be strong - you rather doubt she'll let you go with a single fuck, even if you are incapable of giving her the babies she craves...");
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_NORMAL, 40);
			init03BreastRows("E");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,30);
			init05Body(35 + rand(4),HIP_RATING_AMPLE+2,BUTT_RATING_LARGE);
			init06Skin("dark green");
			init07Hair("purple",4);
			init08Face();
			init09PrimaryStats(50,30,35,100,70,20,70);
			init10Weapon("fists","tiny punch",20);
			init11Armor("leather straps");
			init12Combat(300,50,0.5,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(10,rand(5) + 5);
			init14WeightedDrop().
					add(consumables.GOB_ALE,5).
					addMany(1,consumables.L_DRAFT,
							consumables.PINKDYE,
							consumables.BLUEDYE,
							consumables.ORANGDY,
							consumables.PURPDYE,1);
			initX_Specials(goblinDrugAttack,goblinTeaseAttack);
		}
	}
}
