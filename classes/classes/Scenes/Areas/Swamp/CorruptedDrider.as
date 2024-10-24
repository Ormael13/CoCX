package classes.Scenes.Areas.Swamp
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.LowerBody;
import classes.Scenes.SceneLib;
import classes.internals.*;

/**
	 * ...
	 * @author ...
	 */
	public class CorruptedDrider extends AbstractSpiderMorph
	{
		
		//Drider kiss!
		public function driderKiss():void {
			var temp:int;
			outputText("The corrupted drider closes in on your web-bound form, cooing happily at you while you struggle with the sticky fibers.\n\n");
			//Dodge
			if(player.getEvasionRoll()) {
				outputText("Somehow, you manage to drag yourself out of the way.  She sighs and licks her lips.  \"<i>");
				temp = rand(4);
				if(temp == 0) outputText("I just wanted to give my delicious morsel a kiss...</i>\"\n");
				else if(temp == 1) outputText("Why won't you let me kiss you?</i>\"\n");
				else if(temp == 2) outputText("Mmm, do you have to squirm so much, prey?</i>\"\n");
				else outputText("Just look at my glossy, dripping lips.  Imagine how great it would feel to have them locked against you.  Why resist?</i>\"\n");
			}
			else if(!player.hasStatusEffect(StatusEffects.DriderKiss)) {
				//(HIT? + 10 lust)
				player.dynStats("lus", 100);
				outputText("Before you can move, she's right on top of you, leaning ");
				if(player.tallness < 72) outputText("down");
				else outputText("over");
				outputText(" to plant a sloppy, wet kiss upon your lips.  Her glossy lip-venom oozes everywhere, dribbling down your collective chins and sliding into your mouth.  You shudder, trying to resist, but your tongue betrays you.  It slides between her moist, puffy entrance, lapping at her venom and making love to her tongue.");
				if(player.lust <= (0.9 * player.maxLust())) outputText("  Somehow, you work up the willpower to back away, but your body slowly begins to burn hotter and harder, afflicted with a slowly-building lust.");
				player.createStatusEffect(StatusEffects.DriderKiss,0,0,0,0);
			}
			//Get hit 2nd time) 
			else {
				player.addStatusValue(StatusEffects.DriderKiss,1,1);
				if(player.statusEffectv1(StatusEffects.DriderKiss) == 1) {
					//(HIT? + 15 lust)
					player.dynStats("lus", 15);
					outputText("Again, the drider ties your mouth up in her syrupy lip-lock, seeming to bind your mouth as effectively as her webs bind your body.  Her sweet venom bubbles and froths at the corners of the oral embrace, dripping over her many-breasted bosom and your [chest].");
					if(player.hasCock()) outputText("  " + SMultiCockDesc() + " spews a rope of pre-cum into your [armor], desperate to get out and fuck.");
					if(player.hasVagina()) outputText("  Fem-cum dribbles down your [legs] while your [clit] gets so hard you think it'll explode.");
					outputText("  This time, the drider is the one to break the kiss.  She asks, \"<i>Are you ready, my horny little morsel?</i>\"\n");
					if(player.lust <= (0.9 * player.maxLust())) outputText("You shake your head 'no' and stand your ground!\n");
				}
				//(Get hit 3rd+ time)
				else {
					outputText("This time you barely move.  Your body is too entranced by the idea of another venom-laced kiss to resist.  Glorious purple goo washes into your mouth as her lips meet yours, sealing tight but letting your tongue enter her mouth to swirl around and feel the venom drip from her fangs.  It's heavenly!  Your [skin] grows hot and tingly, and you ache to be touched so badly.  Your " + nippleDescript(0) + "s feel hard enough to cut glass, and a growing part of you admits that you'd love to feel the drider's chitinous fingers pulling on them.");
					//(HIT? + 20 lust)
					player.dynStats("lus", 200);
					if(player.hasCock() || player.hasVagina()) {
						outputText("  The moisture in your crotch only gets worse.  At this point, a ");
						if(player.wetness() < 3 && player.cumQ() < 200) outputText("small");
						else if(player.wetness() < 5 && player.cumQ() < 500) outputText("large");
						else outputText("massive");
						outputText(" wet stain that reeks of your sheer sexual ache has formed in your [armor].");
						if(player.lust <= (0.9 * player.maxLust())) outputText("  Amazingly, you resist her and pull back, panting for breath.");
					}
				}
			}
		}
		
		public function driderMasturbate():void {
			//-Masturbate - (Lowers lust by 50, raises PC lust)
			lust -= (50 + (10 * player.newGamePlusMod()));
			player.dynStats("lus", (20+player.lib/10));
			outputText("The spider-woman skitters back and gives you a lusty, hungry expression.  She shudders and moans, \"<i>Mmm, just watch what you're missing out on...</i>\"\n\n");
			outputText("As soon as she finishes, her large clit puffs up, balloon-like.  A second later, it slides forward, revealing nine inches of glossy, girl-spunk-soaked shaft.  Nodules ring the corrupted penis' surface, while the tiny cum-slit perched atop the tip dribbles heavy flows of pre-cum.  She pumps at the fleshy organ while her other hand paws at her jiggling breasts, tugging on the hard ");
			if(nipplesPierced > 0) outputText("pierced ");
			outputText("nipple-flesh.  Arching her back in a lurid pose, she cries out in high-pitched bliss, her cock pulsing in her hand and erupting out a stream of seed that lands in front of her.\n\n");
			outputText("The display utterly distracts you until it finishes, and as you adopt your combat pose once more, you find your own needs harder to ignore, while hers seem to be sated, for now.\n");
		}

		override protected function performCombatAction():void
		{
			if (lust > 70 && rand(4) == 0) driderMasturbate();
			//1/4 chance of silence if pc knows spells
			else if (player.hasSpells() && !player.hasStatusEffect(StatusEffects.WebSilence) && rand(4) == 0) {
				spiderSilence();
			}
			//1/4 chance of disarm
			else if (!player.hasStatusEffect(StatusEffects.Disarmed) && player.weaponName != "fists" && rand(4) == 0) {
				spiderDisarm();
			}
			//Always web unless already webbed
			else if (player.spe >= 2 && (!player.buff("Web").isPresent() || rand(2) == 0)) {
				spiderMorphWebAttack();
			}
			//Kiss!
			else driderKiss();
		}

		override public function defeated(hpVictory:Boolean):void
		{
			if (player.hasStatusEffect(StatusEffects.SoulArenaGauntlet)) SceneLib.hexindao.gauntletchallange2fight4();
			else SceneLib.swamp.corruptedDriderScene.defeatDriderIntro();
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			if (pcCameWorms){
				outputText("\n\nThe drider licks her lips in anticipation...");
				doNext(SceneLib.combat.endLustLoss);
			} else {
				SceneLib.swamp.corruptedDriderScene.loseToDrider();
			}
		}

		public function CorruptedDrider()
		{
			var hairColor:String = randomChoice("red", "orange", "green");
			var skinTone:String = randomChoice("yellow", "purple", "red", "turquoise");
			var pierced:Boolean = rand(2)==0;
			this.a = "the ";
			this.short = "corrupted drider";
			this.imageName = "corrupteddrider";
			this.long = "This particular spider-woman is a drider - a creature with a humanoid top half and the lower body of a giant arachnid.  From a quick glance, you can tell that this one has fallen deeply to corruption.  She is utterly nude, exposing her four well-rounded, DD-cup breasts with their shiny black nipples.  "+(pierced?"Gold piercings and chains link the curvy tits together, crossing in front of her four mounds in an 'x' pattern.  ":"")+"On her face and forehead, a sextet of lust-filled, " + skinTone + " eyes gaze back at you.  Behind her, the monster-girl's " + hairColor + " hair drapes down her back like a cloak.  The drider's lips seem to shine with a light all their own, and a steady trickle of purple, reflective fluid beads and drips from them.  At her waist, there's a juicy looking snatch with a large, highly visible clit.  From time to time it pulsates and grows, turning part-way into a demon-dick.  Her spider-half has eight spindly legs with black and " + hairColor + " stripes - a menacing display if ever you've seen one.";
			// this.plural = false;
			this.createCock(9,2,CockTypesEnum.DEMON);
			this.createVagina(false, VaginaClass.WETNESS_DROOLING, VaginaClass.LOOSENESS_GAPING);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 70, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("DD"));
			createBreastRow(Appearance.breastCupInverse("DD"));
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.createStatusEffect(StatusEffects.BonusACapacity,70,0,0,0);
			this.tallness = 10*12;
			this.hips.type = Hips.RATING_CURVY + 2;
			this.butt.type = Butt.RATING_LARGE + 1;
			this.lowerBody = LowerBody.DRIDER;
			this.hairColor = hairColor;
			this.hairLength = 24;
			initStrTouSpeInte(330, 225, 210, 300);
			initWisLibSensCor(300, 240, 150, 100);
			this.weaponName = "claws";
			this.weaponVerb="claw";
			this.weaponAttack = 90;
			this.armorName = "carapace";
			this.armorDef = 600;
			this.armorMDef = 60;
			this.armorPerk = "";
			this.armorValue = 70;
			if (pierced && !player.hasStatusEffect(StatusEffects.SoulArenaGauntlet)) {
				this.nipplesPierced = 1;
				this.bonusHP = 800;
				this.bonusLust = 430;
				this.lust = 35;
				this.lustVuln = .25;
				this.level = 40;
				this.gems = rand(15) + 35;
			} else {
				this.bonusHP = 700;
				this.bonusLust = 428;
				this.lust = 30;
				this.lustVuln = .4;
				this.level = 38;
				this.gems = rand(15) + 25;
			}
			this.drop = new WeightedDrop().add(consumables.B_GOSSR,5)
					.add(useables.T_SSILK,1)
					.add(null, 4);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			if (player.hasStatusEffect(StatusEffects.TGRandomnMob)) this.createPerk(PerkLib.EnemyEliteType, 0, 0, 0, 0);
			checkMonster();
		}

	}

}