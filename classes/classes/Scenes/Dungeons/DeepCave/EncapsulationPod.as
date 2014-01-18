package classes.Scenes.Dungeons.DeepCave
{
	import classes.CoC;
	import classes.Creature;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author Fake-Name
	 */

	// This doesn't work, because there is some obnoxious issues with the fact that we only have one instance of monster at any time, and static evaluation
	// of the game leads the compiler to not know if setDescriptionForPlantPot() is available, therefore resulting in an error

	public class EncapsulationPod extends Monster
	{

		override protected function performCombatAction():void
		{
			game.encapsulationPodAI();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.encapsulationVictory();
		}

		override public function get long():String {
			//[Round 1 Description]
			var _long:String;
			if(hasStatusAffect("Round") < 0) _long = "You're totally trapped inside a pod!  The walls are slimy and oozing moisture that makes the air sickeningly sweet.  It makes you feel a little dizzy.  Tentacles are climbing up your " + game.player.legs() + " towards your crotch, doing their best to get under you " + game.player.armorName + ".  There's too many to try to pull away.  You're only chance of escape is to create a way out!";
			//[Round 2 Description]
			else if(statusAffectv1("Round") == 2) {
				_long = "You're still trapped inside the pod!  By now the walls are totally soaked with some kind of viscous slime.  The smell of it is unbearably sweet and you have to put a hand against the wall to steady yourself.  Warm tentacles are curling and twisting underneath your armor, caressing every ";
				if(player.skinType == SKIN_TYPE_FUR) _long += "furry ";
				if(player.skinType == SKIN_TYPE_SCALES) _long += "scaley ";
				_long += "inch of your " + player.legs() + ", crotch, and " + game.assDescript() + ".";
			}
			//[Round 3 Description]
			else if(statusAffectv1("Round") == 3) {
				_long = "You're trapped inside the pod and being raped by it's many tentacles!   The pooling slime is constantly rising, and in a few moments it will have reached your groin.  The viscous sludge makes it hard to move and the smell of it is making it even harder to think or stand up.  The tentacles assaulting your groin don't stop moving for an instant, and in spite of yourself, some part of you wants them to make you cum quite badly.";
			}
			//[Round 4 Description]
			else {
				_long = "You're trapped inside the pod and being violated from by tentacles from the shoulders down!  The slime around your waist is rising even faster now.  It will probably reach ";
				if(player.biggestTitSize() >= 1) _long += "the underside of your " + game.allBreastsDescript();
				else _long += "your chest";
				_long += " in moments.  You're being fucked by a bevy of tentacles while your nipples are ";
				if(!player.hasFuckableNipples()) _long += "fondled ";
				else _long += "fucked ";
				_long += "by more of the slippery fungal protrusions.  It would be so easy to just relax back in the fluid and let it cradle you while you're pleasured.  You barely even smell the sweet, thought-killing scent from before, but you're hips are rocking on their own and you stumble every time you try to move.  Your resistance is about to give out!";
			}
			//[DAMAGE DESCRIPTS – Used All Rounds]
			//[Greater than 80% Life]
			if(HPRatio() > 0.8) {
				_long += "  The pulsing luminescence continues to oscillate in a regular rhythm.  You haven't done enough damage to the thing to effect it in the slightest.";
			}
			//[Greater than 60% Life]
			else if(HPRatio() > 0.6) {
				_long += "  Your attacks have turned a part of the wall a sickly black color, and it no longer glows along with the rest of your chamber.";
			}
			//[Greater than 40% Life] 
			else if(HPRatio() > 0.4) {
				_long += "  You've dented the wall with your attacks.  It's permanently deformed and bruised solid black from your struggles.  Underneath the spongy surface you can feel a rock-solid core that's beginning to give.";
			}
			//Greater than 20% Life] 
			else if(HPRatio() > 0.2) {
				_long += "  You have to blink your eyes constantly because the capsule's bio-luminescent lighting is going nuts.  The part of the wall you're going after is clearly dead, but the rest of your fungal prison is flashing in a crazy, panicked fashion.";
			}
			//[Greater than 0% Life]
			else {
				_long += "  You can see light through the fractured wall in front of you!  One more solid strike should let you escape!";
			}
			return _long;
		}

		public function EncapsulationPod()
		{
			init01Names("the ", "pod", "pod", "");
			init02Genderless();
			init03BreastRows([0,0]);
			init04Ass();
			init05Body(120,HIP_RATING_SLENDER,BUTT_RATING_BUTTLESS);
			init06Skin("purple",SKIN_TYPE_PLAIN,"covering");
			init07Hair("black",0);
			init08Face();
			init09PrimaryStats(90,1,1,1,1,1,100);
			init10Weapon("","");
			init11Armor("pod");
			init12Combat(450,10,0,TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(12,1,80);
			init14FixedDrop(weapons.JRAPIER);
			initX_Specials(special1,special2,special3);
		}

	}

}