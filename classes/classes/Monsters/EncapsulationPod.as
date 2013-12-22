package classes.Monsters
{
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
		public function setDescriptionForPlantPot():void 
		{
			//[Round 1 Description]
			if(mainClassPtr.hasStatusAffect("Round") < 0) 
				this.long = "You're totally trapped inside a pod!  The walls are slimy and oozing moisture that makes the air sickeningly sweet.  It makes you feel a little dizzy.  Tentacles are climbing up your " + mainClassPtr.player.legs() + " towards your crotch, doing their best to get under you " + mainClassPtr.player.armorName + ".  There's too many to try to pull away.  You're only chance of escape is to create a way out!";
			//[Round 2 Description]
			else if(mainClassPtr.statusAffectv1("Round") == 2) {
				this.long = "You're still trapped inside the pod!  By now the walls are totally soaked with some kind of viscous slime.  The smell of it is unbearably sweet and you have to put a hand against the wall to steady yourself.  Warm tentacles are curling and twisting underneath your armor, caressing every ";
				if(mainClassPtr.player.skinType == mainClassPtr.SKIN_TYPE_FUR) this.long += "furry ";
				if(mainClassPtr.player.skinType == mainClassPtr.SKIN_TYPE_SCALES) this.long += "scaley ";
				this.long += "inch of your " + mainClassPtr.player.legs() + ", crotch, and " + mainClassPtr.player.assDescript() + ".";
			}
			//[Round 3 Description]
			else if(mainClassPtr.statusAffectv1("Round") == 3) {
				this.long = "You're trapped inside the pod and being raped by it's many tentacles!   The pooling slime is constantly rising, and in a few moments it will have reached your groin.  The viscous sludge makes it hard to move and the smell of it is making it even harder to think or stand up.  The tentacles assaulting your groin don't stop moving for an instant, and in spite of yourself, some part of you wants them to make you cum quite badly.";
			}
			//[Round 4 Description]
			else {
				this.long = "You're trapped inside the pod and being violated from by tentacles from the shoulders down!  The slime around your waist is rising even faster now.  It will probably reach ";
				if(mainClassPtr.player.biggestTitSize() >= 1) this.long += "the underside of your " + mainClassPtr.player.allBreastsDescript();
				else this.long += "your chest";
				this.long += " in moments.  You're being fucked by a bevy of tentacles while your nipples are ";
				if(!mainClassPtr.player.hasFuckableNipples()) this.long += "fondled ";
				else this.long += "fucked ";
				this.long += "by more of the slippery fungal protrusions.  It would be so easy to just relax back in the fluid and let it cradle you while you're pleasured.  You barely even smell the sweet, thought-killing scent from before, but you're hips are rocking on their own and you stumble every time you try to move.  Your resistance is about to give out!";
			}
			//[DAMAGE DESCRIPTS – Used All Rounds]
			//[Greater than 80% Life]
			if(this.HP > eMaxHP() * 0.8) {
				this.long += "  The pulsing luminescence continues to oscillate in a regular rhythm.  You haven't done enough damage to the thing to effect it in the slightest.";
			}
			//[Greater than 60% Life]
			else if(this.HP > eMaxHP() * 0.6) {
				this.long += "  Your attacks have turned a part of the wall a sickly black color, and it no longer glows along with the rest of your chamber.";
			}
			//[Greater than 40% Life] 
			else if(this.HP > eMaxHP() * 0.4) {
				this.long += "  You've dented the wall with your attacks.  It's permanently deformed and bruised solid black from your struggles.  Underneath the spongy surface you can feel a rock-solid core that's beginning to give.";
			}
			//Greater than 20% Life] 
			else if(this.HP > eMaxHP() * 0.2) {
				this.long += "  You have to blink your eyes constantly because the capsule's bio-luminescent lighting is going nuts.  The part of the wall you're going after is clearly dead, but the rest of your fungal prison is flashing in a crazy, panicked fashion.";
			}
			//[Greater than 0% Life]
			else {
				this.long += "  You can see light through the fractured wall in front of you!  One more solid strike should let you escape!";
			}
		}

		public function EncapsulationPod(mainClassPtr:*) 
		{
			super(mainClassPtr);
			init1Names("the ", "pod", "pod", "");
			init2Genderless();
			init3BreastRows();
			init4Ass();
			init5Body(120,HIP_RATING_SLENDER,BUTT_RATING_BUTTLESS);

			this.temperment = 2;
			//Uber

			//Lust attack

			//Clothing/Armor
			this.armorName = "pod";
			this.weaponName = "";
			this.weaponVerb = "";

			//Primary stats
			this.str = 90;
			this.tou = 1;
			this.spe = 1;
			this.inte = 1;
			this.lib = 1;
			this.sens = 1;
			this.cor = 100;

			this.lustVuln = 0;

			//Combat Stats
			this.bonusHP = 450;
			this.HP = eMaxHP();
			setDescriptionForPlantPot();

			this.lust = 10;

			//Level Stats
			this.level = 12;
			this.XP = totalXP() + 80;
			this.gems = 1;

			//Appearance Variables
			this.hairColor = "black";
			this.hairLength = 0;

			this.skinTone = "purple";
			this.skinDesc = "covering";

			this.wingDesc = "";

		}

	}

}