package classes.Monsters 
{
	import classes.Appearance;
	import classes.Cock;
	import classes.Monster;
	import classes.CockTypesEnum;
	import classes.GlobalFlags.kFLAGS;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Kelt extends Monster 
	{
		
		public function Kelt(mainClassPtr:*) 
		{
			super(mainClassPtr);
			var breakLevel2:Boolean = mainClassPtr.flags[kFLAGS.KELT_BREAK_LEVEL] == 2;
			init01Names("","Kelt","kelt","Kelt has changed for the worse since your first meeting.  Gone is his muscular, barrel chest.  In its place is a softer frame, capped with tiny boobs - remnants of your last treatment.  His jaw is fairly square and chiselled (though less than before).  From the waist down, he has the body of a horse, complete with fairly large pair of balls and a decent-sized dong.  Both are smaller than they used to be, however.  He has his bow strung and out, clearly intent on defending himself from your less than gentle touches."+(breakLevel2?"Kelt is looking less and less like the burly centaur from before, and more and more like a woman.  He looks more like an odd, androgynous hybrid than the beautiful woman you had turned him into.  He currently sports roughly B-cup breasts and a smallish, miniature horse-cock.  There's barely any hair on his human body, aside from a long mane of hair.  Each treatment seems to be more effective than the last, and you can't wait to see what happens after you tame him THIS time.":""));
			init02Male(new Cock(breakLevel2?12:24,3.5,CockTypesEnum.HORSE),2,2+rand(13),1.5,mainClassPtr.player.ballSize * 10);
			init03BreastRows(breakLevel2?"B":"A");
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY,50);
			init05Body(84,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_CENTAUR);
			init06Skin("tan");
			init07Hair(Appearance.randomChoice("black","brown"),3);
			init08Face();
			init09PrimaryStats(60,70,40,20,40,25,55);
			init10Weapon("fist","punch",10);
			init11Armor("tough skin",4);
			init12Combat(200,40,0.83,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(6,rand(5) + 5);
			initX_Tail(TAIL_TYPE_HORSE);
			initX_Specials();

		}
		
	}

}