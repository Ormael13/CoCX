package classes.Monsters
{
	import classes.CoC;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;

	/**
	 * Holli (combat id 69)
	 * @author ...
	 */
	public class Helspawn extends Monster
	{

		override public function doAI():void
		{
			game.helSpawnAI();
		}


		override public function defeated(hpVictory:Boolean):void
		{
			game.beatUpYourDaughter();
		}


		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			game.loseSparringToDaughter();
		}

		public function Helspawn()
		{
			var weapon:String = game.flags[kFLAGS.HELSPAWN_WEAPON];
			init01Names("", game.flags[kFLAGS.HELSPAWN_NAME], "hollispawn",
					game.flags[kFLAGS.HELSPAWN_NAME] + " is a young salamander, appearing in her later teens.  Clad in " +
							(game.flags[kFLAGS.HELSPAWN_PERSONALITY] >= 50 ?
									"a slutty scale bikini like her mother's, barely concealing anything" :
									"a short skirt, thigh-high boots, and a sky-blue blouse, in stark contrast to her mother’s sluttier attire") +
							", she stands about six feet in height, with a lengthy, fiery tail swishing menacingly behind her. She's packing a " +
							{
								'bow': "recurve bow, using blunted, soft-tipped arrows",
								'scimitar': "scimitar, just like her mom's, and holds it in the same berzerk stance Helia is wont to use",
								'scimitar and shield': "scimitar and shield, giving her a balanced fighting style"
							}[ weapon] +
							".  Pacing around you, the well-built young warrior intently studies her mentor's defenses, readying for your next attack.");
			init02Female(VAGINA_WETNESS_NORMAL, VAGINA_LOOSENESS_NORMAL, 85);
			init03BreastRows("E+");
			init04Ass(ANAL_LOOSENESS_VIRGIN,ANAL_WETNESS_DRY,85);
			init05Body(90,HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1);
			init06Skin("dusky");
			init07Hair("red",13);
			init08Face(faceType,earType,tongueType,eyeType);
			init09PrimaryStats(50,50,65,40,35,55,20);
			init10Weapon(weapon,{'bow': "blunted arrow", 'scimitar': "slash", 'scimitar and shield': "slash"}[weapon],20);
			init11Armor("",12,"",50);
			init12Combat(175,30,.55,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(12,10 + rand(5));
			initX_Tail(TAIL_TYPE_LIZARD,0,0);
			this.createStatusAffect("keen", 0, 0, 0, 0);
		}

	}

}