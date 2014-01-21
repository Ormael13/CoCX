package classes.Scenes.Areas.Swamp
{
	import classes.Appearance;
	import classes.Cock;
	import classes.CockTypesEnum;

	/**
	 * ...
	 * @author ...
	 */
	public class CorruptedDrider extends AbstractSpiderMorph
	{

		//Drider kiss!
		public function driderKiss():void {
			var temp:int;
			outputText("The corrupted drider closes in on your web-bound form, cooing happily at you while you struggle with the sticky fibres.\n\n", false);
			//Blind dodge change
			if(hasStatusAffect("Blind") >= 0 && rand(3) < 2) {
				outputText("She's too blind to get anywhere near you.\n", false);
			}
			//Dodge
			else if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("Somehow, you manage to drag yourself out of the way.  She sighs and licks her lips.  \"<i>", false);
				temp = rand(4);
				if(temp == 0) outputText("I just wanted to give my delicious morsel a kiss...</i>\"\n", false);
				else if(temp == 1) outputText("Why won't you let me kiss you?</i>\"\n", false);
				else if(temp == 2) outputText("Mmm, do you have to squirm so much, prey?</i>\"\n", false);
				else outputText("Just look at my glossy, dripping lips.  Imagine how great it would feel to have them locked against you.  Why resist?</i>\"\n", false);
			}
			//Determine if evaded
			else if(player.hasPerk("Evade") >= 0 && rand(100) < 10) {
				outputText("Somehow, you manage to evade her lusty attack.  She sighs and licks her lips.  \"<i>", false);
				temp = rand(4);
				if(temp == 0) outputText("I just wanted to give my delicious morsel a kiss...</i>\"\n", false);
				else if(temp == 1) outputText("Why won't you let me kiss you?</i>\"\n", false);
				else if(temp == 2) outputText("Mmm, do you have to squirm so much, prey?</i>\"\n", false);
				else outputText("Just look at my glossy, dripping lips.  Imagine how great it feel to have them locked against you.  Why resist?</i>\"\n", false);
			}
			//("Misdirection"
			else if(player.hasPerk("Misdirection") >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("You manage to misdirect her lusty attack, avoiding it at the last second.  She sighs and licks her lips.  \"<i>", false);
				temp = rand(4);
				if(temp == 0) outputText("I just wanted to give my delicious morsel a kiss...</i>\"\n", false);
				else if(temp == 1) outputText("Why won't you let me kiss you?</i>\"\n", false);
				else if(temp == 2) outputText("Mmm, do you have to squirm so much, prey?</i>\"\n", false);
				else outputText("Just look at my glossy, dripping lips.  Imagine how great it feel to have them locked against you.  Why resist?</i>\"\n", false);
			}
			//Determine if cat'ed
			else if(player.hasPerk("Flexibility") >= 0 && rand(100) < 6) {
				outputText("You manage to twist your cat-like body out of the way at the last second, avoiding it at the last second.  She sighs and licks her lips.  \"<i>", false);
				temp = rand(4);
				if(temp == 0) outputText("I just wanted to give my delicious morsel a kiss...</i>\"\n", false);
				else if(temp == 1) outputText("Why won't you let me kiss you?</i>\"\n", false);
				else if(temp == 2) outputText("Mmm, do you have to squirm so much, prey?</i>\"\n", false);
				else outputText("Just look at my glossy, dripping lips.  Imagine how great it feel to have them locked against you.  Why resist?</i>\"\n", false);
			}
			
			else if(player.hasStatusAffect("Drider Kiss") < 0) {
				//(HIT? + 10 lust)
				game.dynStats("lus", 10);
				outputText("Before you can move, she's right on top of you, leaning ", false);
				if(player.tallness < 72) outputText("down", false);
				else outputText("over", false);
				outputText(" to plant a sloppy, wet kiss upon your lips.  Her glossy lip-venom oozes everywhere, dribbling down your collective chins and sliding into your mouth.  You shudder, trying to resist, but your tongue betrays you.  It slides between her moist, puffy entrance, lapping at her venom and making love to her tongue.", false);
				if(player.lust <= 99) outputText("  Somehow, you work up the willpower to back away, but your body slowly begins to burn hotter and harder, afflicted with a slowly-building lust.", false);
				player.createStatusAffect("Drider Kiss",0,0,0,0);
			}
			//Get hit 2nd time) 
			else {
				player.addStatusValue("Drider Kiss",1,1);
				if(player.statusAffectv1("Drider Kiss") == 1) {
					//(HIT? + 15 lust)
					game.dynStats("lus", 15);
					outputText("Again, the drider ties your mouth up in her syrupy lip-lock, seeming to bind your mouth as effectively as her webs bind your body.  Her sweet venom bubbles and froths at the corners of the oral embrace, dripping over her many-breasted bosom and your " + player.chestDesc() + ".", false);
					if(player.hasCock()) outputText("  " + SMultiCockDesc() + " spews a rope of pre-cum into your " + player.armorName + ", desperate to get out and fuck.", false);
					if(player.hasVagina()) outputText("  Fem-cum dribbles down your " + player.legs() + " while your " + player.clitDescript() + " gets so hard you think it'll explode.", false);
					outputText("  This time, the drider is the one to break the kiss.  She asks, \"<i>Are you ready, my horny little morsel?</i>\"\n", false);
					if(player.lust <= 99) outputText("You shake your head 'no' and stand your ground!\n", false);
				}
				//(Get hit 3rd+ time)
				else {
					outputText("This time you barely move.  Your body is too entranced by the idea of another venom-laced kiss to resist.  Glorious purple goo washes into your mouth as her lips meet yours, sealing tight but letting your tongue enter her mouth to swirl around and feel the venom drip from her fangs.  It's heavenly!  Your " + player.skin() + " grows hot and tingly, and you ache to be touched so badly.  Your " + nippleDescript(0) + "s feel hard enough to cut glass, and a growing part of you admits that you'd love to feel the drider's chitinous fingers pulling on them.", false);
					//(HIT? + 20 lust)
					game.dynStats("lus", 20);
					if(player.hasCock() || player.hasVagina()) {
						outputText("  The moisture in your crotch only gets worse.  At this point, a ", false);
						if(player.wetness() < 3 && player.cumQ() < 200) outputText("small", false);
						else if(player.wetness() < 5 && player.cumQ() < 500) outputText("large", false);
						else outputText("massive", false);
						outputText(" wet stain that reeks of your sheer sexual ache has formed in your " + player.armorName + ".", false);
						if(player.lust <= 99) outputText("  Amazingly, you resist her and pull back, panting for breath.", false);
					}
				}
			}
			combatRoundOver();
		}
		
		public function driderMasturbate():void {
			//-Masturbate - (Lowers lust by 50, raises PC lust)
			lust -= 30;
			game.dynStats("lus", (10+player.lib/20));
			outputText("The spider-woman skitters back and gives you a lusty, hungry expression.  She shudders and moans, \"<i>Mmm, just watch what you're missing out on...</i>\"\n\n", false);
			outputText("As soon as she finishes, her large clit puffs up, balloon-like.  A second later, it slides forward, revealing nine inches of glossy, girl-spunk-soaked shaft.  Nodules ring the corrupted penis' surface, while the tiny cum-slit perched atop the tip dribbles heavy flows of pre-cum.  She pumps at the fleshy organ while her other hand paws at her jiggling breasts, tugging on the hard ", false);
			if(nipplesPierced > 0) outputText("pierced ", false);
			outputText("nipple-flesh.  Arching her back in a lurid pose, she cries out in high-pitched bliss, her cock pulsing in her hand and erupting out a stream of seed that lands in front of her.\n\n", false);
			
			outputText("The display utterly distracts you until it finishes, and as you adopt your combat pose once more, you find your own needs harder to ignore, while hers seem to be sated, for now.\n", false);
			combatRoundOver();
		}

		override protected function performCombatAction():void
		{
			game.spriteSelect(77);
			if (lust > 70 && rand(4) == 0) driderMasturbate();
			//1/4 chance of silence if pc knows spells
			else if (game.hasSpells() && player.hasStatusAffect("Web-Silence") < 0 && rand(4) == 0) {
				spiderSilence();
			}
			//1/4 chance of disarm
			else if (player.hasStatusAffect("Disarmed") < 0 && player.weaponName != "fists" && rand(4) == 0) {
				spiderDisarm();
			}
			//Always web unless already webbed
			else if (player.spe >= 2 && (player.hasStatusAffect("Web") < 0 || rand(2) == 0)) {
				spiderMorphWebAttack();
			}
			//Kiss!
			else driderKiss();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.swamp.corruptedDriderScene.defeatDriderIntro();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe drider licks her lips in anticipation...");
				doNext(game.endLustLoss);
			} else {
				game.swamp.corruptedDriderScene.loseToDrider();
			}
		}

		public function CorruptedDrider()
		{

			var hairColor:String = randomChoice("red", "orange", "green");
			var skinTone:String = randomChoice("yellow", "purple", "red", "turquoise");

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
			init14WeightedDrop()
					.add(consumables.B_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null,4);
		}

	}

}