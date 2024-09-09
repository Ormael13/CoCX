/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.Monsters
{

import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.IMutations.IMutationsLib;
import classes.Scenes.Combat.Combat;
import classes.Scenes.NPCs.KihaFollower;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Magnar extends Monster
	{
		public var maxDominationLevel: int = 0;
		public var halfBlind: Boolean = false;
		public var cantFly: Boolean = false;

		public function heatWave():void {
			outputText("The blue flame from the massive demon’s maw vanishes… but you can feel the heat rising.  ");
			createStatusEffect(StatusEffects.Uber, 5, 0, 0, 0);
			if (player.immuneToBurn()) {
				outputText("You don’t care overmuch, but your guests retreat from the creature, cringing away from the heat. ");
			} else if (player.hasStatusEffect(StatusEffects.FieryBand)) {
				outputText("The cool metal of Kiha’s wedding band seems to spread through your body, chasing the heat away. Your guests, however, don’t have a dragon-bride giving them such protection. ");
			} else {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(3),0.03,0,0);
			}
			outputText("\n\n");
		}

		public function darkMaul():void {
			outputText("With a glint in his red, reptilian eyes, the giant flaps his wings, coming at you, maul raised.");
			var damage:Number = 0;
			damage += (((weaponAttack + str + 275) * 24) - rand(player.touStat.core.value) - player.armorDef);
			if (hasStatusEffect(StatusEffects.Hypermode)) damage *= 10;
			if (player.getEvasionRoll())
			{
				outputText("  You throw yourself to one side, and with a heavy slam, you feel the mace crack the ground where you had once stood.");
			}
			else
			{
				outputText("  You try to dodge, but the demon adjusts his arc, landing a solid hit. Seeing stars, you reel back.");
				if (rand(100) < 40 && !player.hasPerk(PerkLib.Resolute)) {
					outputText("The impact from the shield has left you with a concussion. <b>You are stunned.</b> ");
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				player.takePhysDamage(damage, true);
			}
		}

		public function pinDown():void {
			outputText("Magnar roars, rushing towards you. His right hand holds his massive maul, and you dodge the reckless downward swing, jumping to the left.");
			var damage:Number = 0;
			damage += (((weaponAttack + str + 175) * 12) - rand(player.touStat.core.value) - player.armorDef);
			if (player.getEvasionRoll() && !Combat.playerWaitsOrDefends()) {
				outputText("  His left hand, fingers spread out, lash down towards your neck. You see it coming at the last second, bending your knees. The attempt at a grab foiled, he rears back, kicking you in the chest. You bring a forearm up, blocking, but you’re still thrown back by the impact.");
				damage = Math.round(damage * 0.6);
				if (rand(100) < 40 && !player.hasPerk(PerkLib.Resolute)) {
					player.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
			} else {
				outputText("  But that proved to be a feint. He grabs you by the neck, massive, clawed hands sinking into your vulnerable throat. He doesn’t miss a stride, picking you up, slamming you back-first against one of the statues you’d repaired. He’s holding you up by your neck, claws sinking into your throat.");
				player.createStatusEffect(StatusEffects.MagnarPinned, 0 ,0, 0, 0);
				if (player.hasStatusEffect(StatusEffects.MagnarDominated) && player.statusEffectv1(StatusEffects.MagnarDominated) > 2) {
					player.changeStatusValue(StatusEffects.MagnarDominated, 1, 2);
				}
			}
			player.takePhysDamage(damage, true);
		}

		public function magnarPinStruggle(wait:Boolean = false):void {
			clearOutput();
			//If fail:
			if (wait) {
				outputText("You wait a while to see what this monster's plan is...\n\n");
				if (player.hasStatusEffect(StatusEffects.MagnarDominated) || (player.hasVagina() && player.tallness <= 96 && rand(5))) {
					dominate();
				}
				else if ((player.hasStatusEffect(StatusEffects.MagnarSlam) && player.statusEffectv1(StatusEffects.MagnarSlam) < 1) || (!player.hasStatusEffect(StatusEffects.MagnarSlam) && player.hasCock() && rand(5))) {
					slam();
				}
				else {
					outputText("He roars with laughter as he pushes you down, choking you all the while.");
					player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				}
			}
			else if((rand(10) > 0 && player.str100/5 + rand(20) < 23)|| player.hasPerk(PerkLib.FluidBody)) {
				outputText("You try and get out of the Magnar's grasp, but to no avail, he is simply too monstrously strong!\n\n");
				player.addStatusValue(StatusEffects.MagnarPinned,1,1);
				if (player.hasStatusEffect(StatusEffects.MagnarDominated) || (player.hasVagina() && player.tallness <= 96 && rand(5))) {
					dominate();
				}
				else if ((player.hasStatusEffect(StatusEffects.MagnarSlam) && player.statusEffectv1(StatusEffects.MagnarSlam) < 1) || (!player.hasStatusEffect(StatusEffects.MagnarSlam) && player.hasCock() && rand(5))) {
					slam();
				}
				else {
					outputText("He roars with laughter as you squirm under his mighty grip, choking you all the while.");
					player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				}
			}
			//If succeed:
			else {
				player.removeStatusEffect(StatusEffects.MagnarPinned);
				if (player.hasStatusEffect(StatusEffects.MagnarDominated) && player.statusEffectv1(StatusEffects.MagnarSlam) > 5) {
					//success stage 5+
					outputText("With your arms braced against the wall, your [breasts] bruising on the stone, and the dull warmth spreading from your womb, you know you don’t have much time until this… Overwhelming dick stops you from feeling your legs. Even now, you can feel him, his claws wrapping possessively around your [ass], his thighs moving in, to cut off your last movements. Through the pheromones filling your mind with lust, your stretching, dripping pussy and the dominating presence forcing you down, your mind latches onto a single word. \n\n" +
							"<i>Kiha.</i> \n\n" +
							"You twist your body, rotating around his shaft, the sensation sending more heat through you. You bring your legs up, planting them against his massive thighs, pushing with all your might. Taken aback by the sudden ferocity, he staggers back, and you pull yourself off his girth. You fall to the floor, but before he can regain his balance, you’re already up, black cum dripping from your [pussy], but your [weapon] in your hand. \n");
				}
				else if (player.hasStatusEffect(StatusEffects.MagnarDominated) && player.statusEffectv1(StatusEffects.MagnarSlam) >= 3){
					//success stage 3/4
					outputText("You fight through the unnatural heat coursing through you, slipping one hand free from the dragon’s clutches. Before he can grab your wrist, you roll, levering your knee up into his undercarriage. The strike isn’t that hard, but you can feel something squish, and your rapist roars. Taking advantage of his pain, you free your other arm, pushing down with both hands. You manage to create just enough room to slide yourself out from underneath his monstrous weight. You scrabble, hands and knees on the hard stone, and pull yourself off of his draconic spear with a thick schluck. ");
				}
				else {
					outputText("You spit into the giant dragon’s eye, and while he roars, you knee him in the balls. With a mighty shove, you push the now stunned demon off of you. Heart jackhammering in your chest, you roll to your feet, recovering your [weapon].");
				}
			}
		}

		public function slam():void {	//(Only option if PC is male or maleherm)
			outputText("Magnar laughs maniacally as you struggle, effortlessly keeping his grip on your neck. He pulls you in, punching you in the gut with his free hand before slamming you back into the statue. \n" +
					"Fire washes from his maw, leaving you burning… and aroused");
			if (player.hasStatusEffect(StatusEffects.MagnarSlam)) {
				outputText("You feel something give in the stone, and it crumbles, leaving your attacker off-balance. You open your mouth, biting his exposed fingers until you taste the coppery tang of blood. \n" +
						"He roars, releasing your neck and checking his hand for bite marks.\n");
				player.addStatusValue(StatusEffects.MagnarSlam,1,1);
				player.removeStatusEffect(StatusEffects.MagnarPinned);
			}
			else {
				player.createStatusEffect(StatusEffects.MagnarSlam, 0 ,0, 0, 0);
			}
		}

		public function dominate():void {	//(If this is chosen, it will be the default for the rest of the fight, only if the PC is 8ft or less and female or female herm)
			if (!player.hasStatusEffect(StatusEffects.MagnarDominated)) {
				outputText("You groan, bringing your hands to your neck as he chokes you, kicking at the demon-dragon’s legs. Your resistance brings a smile to the massive dragon’s face.\n\n");
				outputText("“Oh, little girl, I always did like them spirited… It’s what brought me to my lovely Kiha after all…” He licks his lips, ignoring your struggles… Then the world spins, your vision blurring as he slams you down, back-first, into the floor. You inhale sharply, realising he’s let go of your neck, but before you can do anything, you feel rock-hard scaly arms wrap around your wrists, and an oppressive weight on your stomach.\n\n");
				outputText("His face is right in yours, you realise, his weight pinning you down. Your heart pounds, adrenaline spiking your pulse. You feel something warm and hard brush your inner thigh… You know what it is. You look down anyways, and you see a massive, tapered dragon dick, already hard, rubbing against you.\n\n");
				outputText("“Perhaps we can come to an agreement… I’ll take your wife to be… and you as well, little champion… Should you please me.” ")
				if (player.racialScore(Races.DRAGON, false) >= 4)
					if (!player.goIntoHeat(true))
						if(!player.hasStatusEffect(StatusEffects.TemporaryHeat)) player.createStatusEffect(StatusEffects.TemporaryHeat,0,10,0,0);
				player.createStatusEffect(StatusEffects.MagnarDominated, 0 ,0, 0, 0);
			}
			if (player.statusEffectv1(StatusEffects.MagnarDominated) > maxDominationLevel) maxDominationLevel++;
			//Fail stage 1 if have aromor
			if (player.statusEffectv1(StatusEffects.MagnarDominated) == 1) {
				if (!player.armor.isNothing || !player.lowerGarment.isNothing) {
					if (!player.armor.isNothing ) outputText("The massive dragon-demon ignores your struggles and cries, ripping off the lower half of your [armor]. You look up into his eyes, spots flashing on your vision as he bears down, tapered dragon dong rubbing your inner thigh. ");
					if (!player.lowerGarment.isNothing) outputText("  Your [lowergarment] is slid to one side by his draconid erection, exposing your now flushing lips to the world.");
					//(DoT, Lust damage, lose your armor and lower garment for the rest of the fight)
					player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				} else	//play next scene direcly if no armor equipped
					player.addStatusValue(StatusEffects.MagnarDominated,1,1);
			}
			//Fail stage 2 (or no armor)
			if (player.statusEffectv1(StatusEffects.MagnarDominated) == 2) {
				outputText("You thrash, trying to free your arms, but as you look up, you can see the twisted dragon’s grin growing even larger. He forces your legs apart with his, clearly he’s done this before. Now spread-eagled on the floor, your [breasts] heave, you pull, but you’re helpless to resist. His teeth spread into a chilling grin, he lines that tapered, scaly dick up with your cunt.");
				//(Still grappled, lust damage, -SPD)");
				player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				player.addCurse("spe.mult", 0.10,1);
			}
			//Fail stage 3
			else if (player.statusEffectv1(StatusEffects.MagnarDominated) == 3) {
				outputText("The first few inches of his dragon-cock slide inside your [pussy]. You gasp at the shock, but he works his way deeper inside you, scaled shaft scraping your folds. With one smooth thrust, he bottoms out inside you, stretching your stomach and sending slivers of pain up your back. Heedless of your struggles, he starts pistoning in and out of your cunt. \n\n" +
							"You wail, that massive, throbbing cock sending a heady mixture of pleasure and pain through you. His laughter fills your ears, and as you wriggle, trying to get your hips out from under him, he leans in, spewing fire from his mouth and bathing your upper body in heat… But the fire doesn’t burn you. Your [nipples] perk up, your heartbeat races… His breath is turning you on, your already hard clit aching for release.");
				//(Lust damage, lust DoT, -SPD)
				player.takeLustDamage(player.effectiveSensitivity() / 10 + 2, true);
				player.addCurse("spe.mult", 0.10,1);
			}
			//Fail stage 4
			else if (player.statusEffectv1(StatusEffects.MagnarDominated) == 4) {
				outputText("You can feel that scaled cock twitch, the knot at its base enlarging. You try to get your [legs] beneath you, to push back, but as you do, he laughs menacingly, using your own momentum to flip you over, smashing your [tits] and [head] against the stone floor. Holding your [legs] up, driving your face into the ground, the dominant demon bears down, driving his massive cock deep into your quivering folds. You roll your hips, trying to dislodge him, but he’s too deep inside you, and all you earn is a smack on your [ass], sending even more slivers of pain and pleasure through your head.");
				//"(Lots of lust damage) \n");
				player.createStatusEffect(StatusEffects.DemonSeed, 5, 0, 0, 0);
				player.takeLustDamage(player.effectiveSensitivity() / 3, true);
				player.dynStats("cor", 1);
			}
			//fail stage 5
			else if (player.statusEffectv1(StatusEffects.MagnarDominated) == 5) {
				outputText("You can feel he’s close, your moans of effort sounding more like a bitch in heat. Suddenly, your pussy fills with warmth, your well-fucked folds writhing as the dragon’s cum fills you. You kick, trying to dislodge yourself, but he saw that coming. Your head spins as he picks you up, still impaled on his cock, and he jams a clawed finger into your button. Between the sudden heat in your pussy and this sudden stimulation, you’re too disoriented to put up much of a fight as he slams you into the wall, [legs] still in the air, your [breasts] against the hard stone. He slams your pussy, hard enough to send your head into the stone, and you brace yourself instinctively.");
				//"[massive lust damage, Lust DoT, reduced SPD and STR] \n");
				player.addStatusValue(StatusEffects.DemonSeed, 1, 8);
				player.takeLustDamage(player.effectiveSensitivity(), true);
				player.addCurse("spe.mult", 0.10,1);
				player.addCurse("str.mult", 0.10,1);
				player.dynStats("cor", 1);
			}
			//fail stage 6+
			else if (player.statusEffectv1(StatusEffects.MagnarDominated) > 5){
				outputText("His cum dripping from your pussy, heat slowly turning your muscles slack, all you can do is endure, your arms shaking as you try to stop him from bashing your skull into the wall with how hard he’s fucking you. You can barely feel your legs, but strangely, your pussy can’t stop shaking. You look back, and your hips are bucking on their own. Oh gods, are you enjoying this?");
				//"(Lust damage)\n");
				player.addStatusValue(StatusEffects.DemonSeed, 1, 8);
				player.takeLustDamage(player.effectiveSensitivity() / 3, true);
				player.dynStats("cor", 1);
			}
			player.addStatusValue(StatusEffects.MagnarDominated,1,1);
			var damage:int = int((str) - rand(player.tou) - player.armorDef);
			player.takePhysDamage(damage, true);	//He is choking and violently pounding you into the wall after all
		}

		public function searingSpurn():void {
			outputText("The dragon-demon’s entire body clenches, and he roars with rage, black flames erupting from between his scales. Bloodshot eyes glare at you, and his teeth glow with a violet light. His muscles visibly expand, and his forehead… pulses. Not just the vein, but his entire forehead seems to visibly shudder with each movement. \n" +
					//"\n(+80% STR, -40% INT/WIS, +40% SPD, activates a flame aura that reduces INT and SPD, but does only a small amount of damage)" +
					"“Deal with this, pretender!” he cackles.\n\n");
			outputText("The flame burns, black and violet fire sinking into the church around you. Your head spins, and you feel lightheaded, the flames slackening your muscles and slowing your mind. ");
			createStatusEffect(StatusEffects.Hypermode, 4, 10, 0, 0);
			addCurse("str.mult", -0.80);
			addCurse("int.mult", 0.40,3);
			addCurse("wis.mult", 0.40,3);
			addCurse("spe.mult", -0.40,3);
			addCurse("str.mult", 0.30,1);
			addCurse("spe.mult", 0.30,1);

			if (!player.immuneToBurn()) {
				if (player.hasStatusEffect(StatusEffects.BurnDoT)) player.addStatusValue(StatusEffects.BurnDoT, 1, 1);
				else player.createStatusEffect(StatusEffects.BurnDoT,SceneLib.combat.debuffsOrDoTDuration(3),0.02,0,0);
			}
		}
		
		override protected function performCombatAction():void
		{
			if (hasStatusEffect(StatusEffects.Uber)) {
				addStatusValue(StatusEffects.Uber, 1, -1);
				if (statusEffectv1(StatusEffects.Uber) <= 0)
					removeStatusEffect(StatusEffects.Uber);
			}
			else heatWave();
			var choice:Number = rand(3);
			if (player.hasStatusEffect(StatusEffects.MagnarPinned) && player.hasStatusEffect(StatusEffects.MagnarDominated))
				choice = 2;
			if (hp100 < 65 && !hasStatusEffect(StatusEffects.Hypermode)) {
				searingSpurn();
				return;
			}
			if (halfBlind && rand(3) == 0) {
				outputText("[Themonster] seems to have trouble finding you, putting one hand over his injured eye, resting the other on his massive hammer.");
				return;
			}
			if (choice == 0) eAttack();
			if (choice == 1) darkMaul();
			if (choice == 2) pinDown();
		}

		public function finalDominationScore():void {
			if (player.hasStatusEffect(StatusEffects.MagnarDominated)) {
				player.changeStatusValue(StatusEffects.MagnarDominated, 1, maxDominationLevel);
			}
		}
		
		override public function defeated(hpVictory:Boolean):void
		{
			finalDominationScore();
			if (KihaFollower.DergKidnapped == 1) {
				SceneLib.kihaFollower.KihaRescueVictory();
			} else {
				SceneLib.kihaFollower.KihaWeddingVictory();
			}
		}

		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			finalDominationScore();
			SceneLib.kihaFollower.KihaWeddingDefeat();
		}
		
		public function Magnar()
		{
			this.a = "";
			this.short = "Magnar";
			this.imageName = "magnar";
			this.long = "This giant is the apex of the Flamespreader project. Wings armored with steel, chiselled body and immense strength, if his warhammer is anything to judge by. He fights naked, chiselled abs and dragon-dick belied by the crazed look in his crimson, reptilian eyes.";
			initStrTouSpeInte(540, 540, 400, 190);
			initWisLibSensCor(190, 400, 200, 100);
			if (KihaFollower.DergKidnapped == 1) {
				if (KihaFollower.MagnarState == 1) {
					cantFly = true;
					this.long += " You managed to cut off one of his wings before the fight started, putting him off balance and preventing him from flying.";
				}
				else if (KihaFollower.MagnarState == 2) {
					halfBlind = true;
					this.long += " You managed to sneak in some poisoned wine and even stabbed out one of his eyes before the fight started, it should be much easier than last time!";
					this.createStatusEffect(StatusEffects.PoisonDoT, 3, 0, 0, 0);
				}
				this.weaponAttack = 200;
				this.armorDef = 100;
				this.armorMDef = 750;
				this.bonusHP = 1700;
				this.bonusLust = 600;
				this.level = 85;
				this.createPerk(PerkLib.OverMaxHP, 85, 0, 0, 0);
			}
			else {
				this.weaponAttack = 250;
				this.armorDef = 120;
				this.armorMDef = 90;
				this.bonusHP = 2000;
				this.bonusLust = 800;
				this.level = 100;
				this.createPerk(PerkLib.OverMaxHP, 100, 0, 0, 0);
			}
			this.additionalXP = 300;
			this.createCock(24,4);
			this.balls = 2;
			this.ballSize = 5;
			this.cumMultiplier = 1;
			this.hoursSinceCum = 1000;
			createBreastRow(0);
			this.ass.analLooseness = AssClass.LOOSENESS_TIGHT;
			this.ass.analWetness = AssClass.WETNESS_DRY;
			this.tallness = 12 * 12;
			this.hips.type = Hips.RATING_AVERAGE;
			this.butt.type = Butt.RATING_TIGHT;
			this.bodyColor = "black";
			this.hairColor = "black";
			this.hairLength = 0;
			this.weaponName = "warhammer";
			this.weaponVerb = "hit";
			this.armorName = "scales";
			this.lust = 10;
			this.lustVuln = 0.33;
			this.gems = 50 + rand(50);
			this.drop = new ChainedDrop().add(useables.D_SCALE,0.2);
			this.createPerk(PerkLib.EnemyBossType, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyTrueDemon, 0, 0, 0, 0);
			this.createPerk(PerkLib.EnemyHugeType, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			this.createPerk(PerkLib.JobBarbarian, 0, 0, 0, 0);
			this.createPerk(PerkLib.RefinedBodyI, 0, 0, 0, 0);
			this.createPerk(PerkLib.TankI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Resolute, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicStrength, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicToughness, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicSpeed, 0, 0, 0, 0);
			this.createPerk(PerkLib.EpicLibido, 0, 0, 0, 0);
			this.createPerk(PerkLib.LegendaryStrength, 0, 0, 0, 0);
			this.createPerk(PerkLib.LegendaryToughness, 0, 0, 0, 0);
			this.createPerk(PerkLib.LegendarySpeed, 0, 0, 0, 0);
			this.createPerk(PerkLib.LegendaryLibido, 0, 0, 0, 0);
			this.createPerk(PerkLib.Regeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
			this.createPerk(PerkLib.InhumanDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.DemonicDesireI, 0, 0, 0, 0);
			this.createPerk(PerkLib.Lifeline, 0, 0, 0, 0);
			this.createPerk(PerkLib.ImprovedLifeline, 0, 0, 0, 0);
			this.createPerk(PerkLib.BasicTranquilness, 0, 0, 0, 0);
			this.createPerk(PerkLib.ImprovedTranquilness, 0, 0, 0, 0);
			this.createPerk(PerkLib.AdvancedTranquilness, 0, 0, 0, 0);
			this.createPerk(PerkLib.HalfStepToImprovedTranquilness, 0, 0, 0, 0);
			this.createPerk(PerkLib.HalfStepToAdvancedTranquilness, 0, 0, 0, 0);
			this.createPerk(PerkLib.HalfStepToSuperiorTranquilness, 0, 0, 0, 0);
			this.createPerk(IMutationsLib.LizanMarrowIM, 3, 0, 0, 0);
			IMutationsLib.LizanMarrowIM.acquireMutation(this, "none");
			checkMonster();
		}
	}
}
