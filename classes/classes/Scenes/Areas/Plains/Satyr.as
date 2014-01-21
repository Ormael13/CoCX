package classes.Scenes.Areas.Plains
{
	import classes.CoC;
	import classes.Appearance;
	import classes.Cock;
	import classes.GlobalFlags.kFLAGS;
	import classes.Monster;
	import classes.CockTypesEnum;
	
	/**
	 * ...
	 * @author aimozg
	 */
	public class Satyr extends Monster 
	{
		//Attacks (Z)
		private function satyrAttack():void {
			outputText("The satyr swings at you with one knuckled fist.  ");
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0 && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you with a blind punch!\n", false);
			}
			//Evade: 
			else if(combatMiss() || combatEvade() || combatFlexibility() || combatMisdirect()) {
				outputText("He snarls as you duck his blow and it swishes harmlessly through the air.");
			}
			else {
				var damage:Number = int((str + weaponAttack) - rand(player.tou));
				if(damage > 0) {
					damage = player.takeDamage(damage);
					outputText("It feels like you just got hit with a wooden club! (" + damage + ")");
				}
				else outputText("You successfully block it.");
			}
			combatRoundOver();
		}
				
		private function satyrBate():void {
			outputText("He glares at you, panting while his tongue hangs out and begins to masturbate.  You can nearly see his lewd thoughts reflected in his eyes, as beads of pre form on his massive cock and begin sliding down the erect shaft.");
			//(small Libido based Lust increase, and increase lust)
			game.dynStats("lus", (player.lib/5)+4);
			lust += 5;
			combatRoundOver();
		}
		
		internal function satyrCharge():void {
			outputText("Lowering his horns, the satyr digs his hooves on the ground and begins snorting; he's obviously up to something.  ");
			if(hasStatusAffect("Blind") >= 0 && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you due to blindness!\n", false);
			}
			else if(combatMiss()) {
				outputText("He charges at you with a loud bleat, but you nimbly dodge and strike a vicious blow with your [weapon] in return that sends him crashing into the ground, hollering in pain. (5)");
				HP -= 5;
			}
			else if(combatEvade()) {
				outputText("He charges at you with a loud bleat, but using your evasive skills, you nimbly dodge and strike a vicious blow with your [weapon] in return that sends him crashing into the ground, hollering in pain. (5)");
				HP -= 5;
			}
			else if(combatFlexibility()) {
				outputText("He charges at you with a loud bleat, but using your flexibility, you nimbly dodge and strike a vicious blow with your [weapon] in return that sends him crashing into the ground, hollering in pain. (5)");
				HP -= 5;
			}
			else if(combatMisdirect()) {
				outputText("He charges at you with a loud bleat, but using your misdirecting skills, you nimbly dodge and strike a vicious blow with your [weapon] in return that sends him crashing into the ground, hollering in pain. (5)");
				HP -= 5;
			}
			else {
				var damage:Number = int((str + weaponAttack) - rand(player.tou));
				if(damage > 0) {
					damage = player.takeDamage(damage);
					outputText("He charges at you with a loud bleat, catching you off-guard and sending you flying into the ground.");
					if(player.hasPerk("Resolute") < 0) {
						outputText("  The pain of the impact is so big you feel completely dazed, almost seeing stars.");
						player.createStatusAffect("Stunned",0,0,0,0);
					}
					//stun PC + hp damage if hit, hp damage dependent on str if miss
					outputText(" (" + damage + ")");
				}
				else outputText("He charges at you, but you successfully deflect it at the last second.");
			}
			combatRoundOver();
		}
			
		private function bottleChug():void {
			outputText("He whips a bottle of wine seemingly from nowhere and begins chugging it down, then lets out a bellowing belch towards you.  The smell is so horrible you cover your nose in disgust, yet you feel hot as you inhale some of the fetid scent.");
			//(damage PC lust very slightly and raise the satyr's lust.)
			game.dynStats("lus", (player.lib/5));
			lust += 5;
			combatRoundOver();
		}
		
		//5:(Only executed at high lust) 
		private function highLustChugRape():void {
			outputText("Panting with barely-contained lust, the Satyr charges at you and tries to ram you into the ground.  ");
			if(hasStatusAffect("Blind") >= 0 && rand(3) < 1) {
				outputText(capitalA + short + " completely misses you due to blindness!\n", false);
			}
			else if(combatMiss() || combatFlexibility() || combatMisdirect() || combatEvade()) {
				outputText("As he charges you, you grab him by the horns and spin around, sending him away.");
			}
			else {
				outputText("You fall with a <b>THUD</b> and the Satyr doesn't even bother to undress you before he begins rubbing his massive cock on your body until he comes, soiling your [armor] and " + player.skinFurScales() + " with slimy, hot cum.  As it rubs into your body, you shiver with unwanted arousal.");
				//large-ish sensitivity based lust increase if hit.)(This also relieves him of some of his lust, though not completely.)
				lust -= 50;
				game.dynStats("lus", (player.sens/5+20));
			}
			combatRoundOver();
		}
		
		override protected function performCombatAction():void
		{
			if(lust >= 75 && rand(2) == 0) highLustChugRape();
			else if(lust < 75 && rand(2) == 0) {
				if(rand(2) == 0) satyrBate();
				else bottleChug();
			}
			else if(hasStatusAffect("Charged") < 0) satyrCharge();
			else {
				satyrAttack();
				removeStatusAffect("Charged");
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.plains.satyrScene.defeatASatyr();
		}


		override public function won(hpVictory:Boolean,pcCameWorms:Boolean):void
		{
			if (pcCameWorms) {
				outputText("\n\nThe satyr laughs heartily at your eagerness...");
				doNext(game.endLustLoss);
			} else {
				game.plains.satyrScene.loseToSatyr();
			}
		}

		public function Satyr()
		{
			init01Names("a ", "satyr", "satyr", "From the waist up, your opponent is perfectly human, save his curling, goat-like horns and his pointed, elven ears.  His muscular chest is bare and glistening with sweat, while his coarsely rugged, masculine features are contorted into an expression of savage lust.  Looking at his waist, you notice he has a bit of a potbelly, no doubt the fruits of heavy drinking, judging by the almost overwhelming smell of booze and sex that emanates from him.  Further down you see his legs are the coarse, bristly-furred legs of a bipedal goat, cloven hooves pawing the ground impatiently, sizable manhood swaying freely in the breeze.");
			var ballSize:Number = 2 + rand(13);
			init02Male(new Cock(rand(13) + 14,1.5 + rand(20)/2,CockTypesEnum.HUMAN),2, ballSize,1.5,player.ballSize * 10);
			init03BreastRows(0);
			init04Ass(ANAL_LOOSENESS_STRETCHED,ANAL_WETNESS_NORMAL,20);
			init05Body(rand(37) + 64,HIP_RATING_AVERAGE,BUTT_RATING_AVERAGE+1,LOWER_BODY_TYPE_HOOFED);
			init06Skin("tan");
			init07Hair(randomChoice("black","brown"),3+rand(20));
			init08Face(FACE_COW_MINOTAUR);
			init09PrimaryStats(75,70,110,70,60,35,45);
			init10Weapon("fist","punch");
			init11Armor("thick fur");
			init12Combat(300,20,0.30,Monster.TEMPERMENT_LUSTY_GRAPPLES);
			init13Level(14,rand(25) + 25);
			init14ChainedDrop().add(consumables.INCUBID,1/2);
			initX_Tail(TAIL_TYPE_COW);

		}
		
	}

}