package classes.Monsters
{
	import classes.Appearance;
	import classes.Cock;
	import classes.CockTypesEnum;
	import classes.Monster;

	/**
	 * ...
	 * @author ...
	 */
	public class CorruptedDrider extends Monster
	{

		override protected function performCombatAction():void
		{
			mainClassPtr.driderAI();
		}

		public function CorruptedDrider(mainClassPtr:*)
		{
			super(mainClassPtr);

			var hairColor:String = Appearance.randomChoice("red", "orange", "green");
			var skinTone:String = Appearance.randomChoice("yellow", "purple", "red", "turquoise");

			var pierced:Boolean = rand(2)==0;
			init01Names("the ", "corrupted drider", "corrupteddrider",
					"This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, D-cup breasts with their shiny black nipples.  "+(pierced?"Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ":"")+"On her face and forehead, a quartet of lust-filled, " + skinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + hairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and " + hairColor + " stripes - a menacing display if ever you've seen one.");
			init02Male(new Cock(9,2,CockTypesEnum.DEMON));
			init02Female(VAGINA_WETNESS_DROOLING, VAGINA_LOOSENESS_GAPING, 70);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_TIGHT,ANAL_WETNESS_DRY,70);
			init05Body("10'",HIP_RATING_CURVY+2,BUTT_RATING_LARGE+1,LOWER_BODY_TYPE_DRIDER_LOWER_BODY);
			init06Skin(skinTone,SKIN_TYPE_PLAIN);
			init07Hair(hairColor,24);
			init08Face();
			init09PrimaryStats(100,50,70,100,80,50,90);
			init10Weapon("claws","claw",30);
			init11Armor("carapace",55,"",70);
			if (pierced) {
				this.nipplesPierced = 1;
				init12Combat(325,35,.25,TEMPERMENT_RANDOM_GRAPPLES);
				init13Level(15,rand(10) + 30)
			} else {
				init12Combat(250,30,.4,TEMPERMENT_RANDOM_GRAPPLES);
				init13Level(14,rand(10) + 20);
			}
		}

	}

}