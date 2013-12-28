package classes.Monsters 
{
	import classes.Cock;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
		
	public class IncubusMechanic extends Monster {
		public function IncubusMechanic(mainClassPtr:*) {
			super(mainClassPtr);
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
			initX_Specials(11035,11036);
			initX_Tail(TAIL_TYPE_DEMONIC);
			initX_Wings(WING_TYPE_BAT_LIKE_TINY,"tiny hidden");
		}
	}
}