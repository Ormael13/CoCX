package classes.Scenes.NPCs
{
	import classes.CoC;
	import classes.Cock;
	import classes.Monster;
	import classes.PerkLib;
import classes.StatusAffects;

/**
	 * ...
	 * @author ...
	 */
	public class Izma extends Monster 
	{

		//[Special Attacks]
		private function IzmaSpecials1():void {
			//Blind dodge change
			if(findStatusAffect(StatusAffects.Blind) >= 0 && rand(3) < 2) {
				outputText("Izma attempts to close the distance with you, but misses completely because of her blindness.\n", false);
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("Izma attempts to get close, but you manage to side-step her before she can lay her gauntleted hands on you.\n", false);
				return;
			}
			//Determine if evaded
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Izma attempts to get close, but you manage to side-step her before she can lay her gauntleted hands on you.\n", false);
				return;
			}
			//("Misdirection"
			if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Izma attempts to get close, but you put Raphael's teachings to use and side-step the sharkgirl, confusing her with your movements.\n", false);
				return;
			}
			//Determine if cat'ed
			if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("Izma attempts to get close, but you manage to side-step her before she can lay her gauntleted hands on you.\n", false);
				return;
			}
			outputText("Izma rushes you with impressive speed, striking a few precise locations on your joints with her fingertips before leaping back.  It doesn't hurt, but you feel tired and sore. \"<i>Pressure points...</i>\" she laughs, seeing your confused expression.", false);
			//(Fatigue damage)
			game.fatigue(20+rand(20));
		}

		private function IzmaSpecials2():void {
			//Blind dodge change
			if(findStatusAffect(StatusAffects.Blind) >= 0 && rand(3) < 2) {
				outputText("Izma blindly tries to clinch with you, but misses completely.\n", false);
				return;
			}
			//Determine if dodged!
			if(player.spe - spe > 0 && int(Math.random()*(((player.spe-spe)/4)+80)) > 80) {
				outputText("Izma tries to clinch you, but you use your speed to keep just out of reach.\n", false);
				return;
			}
			//Determine if evaded
			if(player.findPerk(PerkLib.Evade) >= 0 && rand(100) < 10) {
				outputText("Izma tries to clinch with you, but she didn't count on your skills in evasion.  You manage to sidestep her at the last second.\n", false);
				return;
			}
			//("Misdirection"
			if(player.findPerk(PerkLib.Misdirection) >= 0 && rand(100) < 10 && player.armorName == "red, high-society bodysuit") {
				outputText("Izma ducks and weaves forward to clinch with you, but thanks to Raphael's teachings, you're easily able to misguide her and avoid the clumsy grab.\n", false);
				return;
			}
			//Determine if cat'ed
			if(player.findPerk(PerkLib.Flexibility) >= 0 && rand(100) < 6) {
				outputText("Izma tries to lock you in a clinch, but your cat-like flexible makes it easy to twist away from her grab.\n", false);
				return;
			}
			var damage:Number = 0;
			damage = Math.round(130 - rand(player.tou+player.armorDef));
			if(damage < 0) damage = 0;
			outputText("Izma ducks and jinks, working to close quarters, and clinches with you. Unable to get your weapon into play, you can only ", false);
			if(player.armorDef >= 10 || damage == 0) {
				//(armor-dependent Health damage, fullplate, chain, scale, and bee chitin armor are unaffected, has a chance to inflict 'Bleed' damage which removes 2-5% of health for the next three turns if successful)
				damage = player.takeDamage(damage);
				outputText("writhe as she painfully drags the blades of her glove down your back", false);
				player.createStatusAffect(StatusAffects.IzmaBleed,3,0,0,0);
			}
			else outputText("laugh as her blades scape uselessly at your armor-clad back", false);
			outputText(" before breaking her embrace and leaping away. (" + damage + ")", false);
		}
		private function IzmaSpecials3():void {
			outputText("Rather than move to attack you, Izma grins at you and grabs her breasts, massaging them as she caresses her long penis with one knee. Her tail thrashes and thumps the sand heavily behind her as she simulates an orgasm, moaning loudly into the air. The whole display leaves you more aroused than before.", false);
			//(lust gain)
			game.dynStats("lus", (20 + player.lib/5));
		}

		private function IzmaAI():void {
			var choice:Number = rand(5);
			if(choice <= 1) eAttack();
			if(choice == 2) {
				if(player.fatigue >= 80) choice = 3;
				else IzmaSpecials1();
			}
			if(choice == 3) {
				if(player.armorDef >= 10 && rand(3) == 0) IzmaSpecials2();
				else choice = 4;
			}
			if(choice == 4) IzmaSpecials3();
			combatRoundOver();
		}

		override public function eAttack():void
		{
			outputText("Izma slides up to you, throws a feint, and then launches a rain of jabs at you!\n", false);
			super.eAttack();
		}

		override protected function performCombatAction():void
		{
			var choice:Number = rand(5);
			if (choice <= 1) eAttack();
			if (choice == 2) {
				if (player.fatigue >= 80) choice = 3;
				else IzmaSpecials1();
			}
			if (choice == 3) {
				if (player.armorDef >= 10 && rand(3) == 0) IzmaSpecials2();
				else choice = 4;
			}
			if (choice == 4) IzmaSpecials3();
			combatRoundOver();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			game.izmaScene.defeatIzma();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\n\"<i>Gross!</i>\" Izma cries as she backs away, leaving you to recover alone.");
				game.cleanupAfterCombat();
			} else {
				game.izmaScene.IzmaWins();
			}
		}

		public function Izma()
		{
			init01Names("", "Izma", "izma", "Izma the tigershark stands a bit over 6' tall, with orange skin bearing horizontal stripes covering most of her body.  Her silver-white hair cascades past her shoulders, draping over an impressive pair of DD-cup breasts barely restrained by a skimpy black bikini top.  Under the knee-length grass skirt below them rustles her beastly fifteen-inch penis and four-balled sack; you catch occasional glimpses of them as she moves.  She's tucked her usual reading glasses into her locker at the moment.");
			init02Male(new Cock(15,2.2),4,3);
			init02Female(VAGINA_WETNESS_SLICK,VAGINA_LOOSENESS_LOOSE,45);
			init03BreastRows("DD");
			init04Ass(ANAL_LOOSENESS_NORMAL,ANAL_WETNESS_DRY,30);
			init05Body("5'5",HIP_RATING_CURVY,BUTT_RATING_NOTICEABLE);
			init06Skin("striped orange");
			init07Hair("silver",20);
			init08Face();
			init09PrimaryStats(80,90,85,65,75,25,40);
			init10Weapon("clawed gauntlets","clawed punches",45);
			init11Armor("bikini and grass skirt",8);
			init12Combat(330,20,.20,Monster.TEMPERMENT_RANDOM_GRAPPLES);
			init13Level(15,rand(5) + 1);
			initX_Specials();


		}
		
	}

}