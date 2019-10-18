/**
 * ...
 * @author Zakanard
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Butt;
import classes.BodyParts.Hips;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.*;

	public class Yamata extends Monster
	{
		//Corrupted Yamata Attacks
		private function yamataBasic():void
		{
			var x:int = rand(4);
			var damage:int;
			if (x==0)
			{
				outputText("Rushing toward you, Yamata drops down low, then leaps up into a wide swing. You flinch as you see the tip of her blade glide across your skin, but she dances away at the last second, leaving behind an angry red wound that hurts like hell, but is far from life-threatening. <i>“Oh yeah, scream for me baby!”</i> The realization that she’s toying with you is practically infuriating!  ");
				damage = int(str/2) + rand(15);
			} else if (x == 1) {
				outputText("You back away as Yamata goes into the offensive, doing your best to dodge her attacks. The tip of her blade grazes you a few times, and the shallow wounds they leave behind hurt far worse than they really should. She raises the blade to her lips and gently licks it, grinning vindictively at you. You’re certain now that Yamata is just trying to inflict as much pain as possible before finishing you off.  ");	
				damage = int(str/2) + rand(35);	
			} else if (x == 2) {
				outputText("Yamata digs her heels into the ground, taunting you with a crude gesture. Her serpentine hair suddenly lashes forward, morphing before your eyes into countless blades! Thankfully, she seems to purposely avoid anything vital, but the grazing cuts they leave behind hurt terribly. <i>“Ahahahaha! Doesn’t it just make you HARD?!”</i>  ");
				damage = int(str) - rand(25);
				player.takeLustDamage(7);
				flags[kFLAGS.YAMATA_MASOCHIST]++;
			} else {
				outputText("With a quick whipping motion, Yamata’s serpentine hair lashes toward you, splitting into thousands of thin strands that whip against your flesh. Pain lances through your body wherever they touch, but the intense tingling sends blood boiling to your loins involuntarily.  ");
				damage = int(str/2) + rand(50);
				player.takeLustDamage(12);
				flags[kFLAGS.YAMATA_MASOCHIST]++;
			}
			
			player.takePhysDamage(damage, true);
			yamataSodomasochistApply(damage);
			if (!player.hasStatusEffect(StatusEffects.IzmaBleed)) player.createStatusEffect(StatusEffects.IzmaBleed, 2, 0, 0, 0);
			else player.addStatusValue(StatusEffects.IzmaBleed, 1, 1);
		}
		
		private function yamataDarkFoxfire():void 
		{
			outputText("Yamata moves her fingers through the air in a circle, conjuring up a corrupted purple flame. She twists her upper body into a batter’s stance and strikes it with the flat of her blade, making the fireball rocket toward you like a missile, bursting on impact! The flames burn intensely as they engulf you, but the more it burns, the more you start to LIKE it.  ");
			player.takeFireDamage(int(str/2) + rand(15), true);
			//if masochist, take more damage
			(player.hasPerk(PerkLib.Masochist) ?  player.takeLustDamage(15 + player.sens/10) : player.takeLustDamage((10 + player.sens/10)*2));
			flags[kFLAGS.YAMATA_MASOCHIST]++;
		}
		
		private function yamataNightmare():void
		{
			outputText("You can hear a whispering voice clouding the edges of your mind, and begin to shrink back as darkness begins to close in on you. As the all-consuming blackness fills your field of vision, you are beset on all sides by unimaginable horrors too terrifying to describe! You feel yourself falling deeper and deeper into a void of despair, but somehow you know that you could end all the suffering if you would only submit yourself to Yamata...  ");
			//Resist: - successfully resisting deals small health & lust damage to Yamata
			var resist:int = 0;
			resist = (player.inte < 80 ? Math.round(player.inte/70*25) : 25);
			if (player.findPerk(PerkLib.Whispered) >= 0) 
				resist += 30;
			else 
				outputText("Some small part of you knows this can’t be real, but you’re too terrified to act right now! ");
			if (player.findPerk(PerkLib.HistoryReligious) >= 0 && player.cor <= 20)
				resist += 15 - player.corAdjustedDown();
			if (rand(100) < resist) {
				outputText("\n\nSummoning up every last ounce of courage you have, you push back the illusions with your mind! Yamata reels a bit, clutching her forehead in pain, but only grins at you. <i>“That all you got, hero?”</i>");				
				if (player.hasStatusEffect(StatusEffects.Fear))
					player.removeStatusEffect(StatusEffects.Fear);
			} else {
				outputText("You know that none of this could be real, but you are too terrified to act this round!");
				if (player.hasStatusEffect(StatusEffects.Fear))
					addCombatBuff("spe", -12);
				else
					createStatusEffect(StatusEffects.Fear, 0, 0, 0, 0);
				addCombatBuff("spe", -18);
			}
		}
		
		private function yamataLustAttack():void
		{
			outputText("Before your eyes, Yamata dives to the ground, her hair lengthening and wrapping around her lower body in a slick serpentine shape. Like black lightning she rears up, spiralling around you like a crazed serpent. As she winds her way around your body, she drags her nails along your flesh, running her tongue over the fresh scratches as she snaps away from you. You shudder a little, equal parts disturbed and aroused.\n\n"
			+"The eight serpents that make up Yamata’s hair suddenly slam into you, latching onto you with their fangs and lifting you into the air. As you squirm in their grip, one of them dives into your [armor], and with a look of horror you feel it "
			+(player.hasCock()? "engulfing your [cock] whole, sinking fangs into the base and filling your groin with corrupted fire!"+(player.hasVagina()?" Another of her snakes impale your [vagina], filling your womb with corrupted fire!":""):"impaling your [vagina], filling your womb with corrupted fire!")
			+"\n\nShe roughly tosses you to the ground, smirking as you struggle to your feet, lust burning in your loins.  ");
			
			var lustDmg:int = 15 + player.sens / 3 + player.lib/5;
			player.takeLustDamage(lustDmg, true);
			if (player.hasCock()) player.dynStats("cor", 1);
			if (player.hasVagina()) player.dynStats("cor", 1);
			player.takeFireDamage(15+rand(26), true);
			yamataSodomasochistApply(lustDmg+5);
			flags[kFLAGS.YAMATA_MASOCHIST]++;
		}

		private function yamataIllusionLust():void
		{
			var lustDmg:int = 10 + player.sens / 5;
			outputText("Yamata splits herself into a series of illusions that quickly surround you! You try to find the real one but you're too slow! A fireball comes from the side, blasting you with broiling corrupted flames!  ");
			player.takeFireDamage(int(str/2) + rand(15), true);
			if (player.hasStatusEffect(StatusEffects.Fear))
				switch (rand(3)) {
					case 0:
						outputText("\n\nYou attack Yamata, but her figure was just an illusion! She appears behind you and her hair lengthens rapidly, one of the snake-hair serpents lashes out and bites into your ankle, injecting a burst of corrupted flames directly into you!");
						lustDmg += 4;
						player.dynStats("cor", 1);
						flags[kFLAGS.YAMATA_MASOCHIST]++;
						break;
					case 1:
						outputText("\n\n<i>“This is my realm... and in my realm... you get to feel good...”</i> her strange words entice you as you widen your eyes, you try to hit her but you always seem to miss. A mischievous grin comes from her figure as you feel something rubbing your crotch, is one of her tails! Oh damn, it feels so good!  ");
						player.takeLustDamage(lustDmg);
						break;
					case 2:
						outputText("\n\nYamata turns around, brushing her tails to the side to expose her ample hindquarters, showing off her juicy-looking cheeks. Her display sends blood rushing to your groin, making you lick your lips eagerly.\n\n"
						+"Yamata pauses for a moment, placing a hand on her taut abs and sliding her fingers downward slowly, gazing deep into your eyes. Her tails fan out around her, curling around her limbs seductively, and she gives you a flirtatious leer as she watches your body tremble with desire.  ");
						player.takeLustDamage(lustDmg*2);
						break;
						
					default:
						outputText("This is a bug, please report it - yamataIllusionLust");
						break;
				}
			outputText("\n\nYamata takes a moment to stretch out her limber body, thrusting out her bound chest as she stretches her arms toward the sky. She twirls around, head slightly askew, and then bows forward to give you a good angle at her cleavage, packed tightly into her chest wrap, all the while with a sickly grin on her face.\n\n"
			+"<i>“Why dont you just surrender already? We can have so much fun in my torture devices, it will feel so good! We might even have some fun on the side if you scream prettily enough, hehehe.”</i> Yamata whispers sultrily, running a hand along her tails and making them fan out around her seductively.\n\n");
			if (flags[kFLAGS.YAMATA_MASOCHIST]>60) {
				outputText("You find yourself giving it a moments thought before pulling yourself beck to the present. What is she doing to you?!  ");
				lustDmg += 5;
			}
			if (flags[kFLAGS.YAMATA_MASOCHIST]>80) {
				outputText(" Though come to think of it, her proposition might not be so bad...  ");
				lustDmg += 3;
				flags[kFLAGS.YAMATA_MASOCHIST]++;
			}
			player.takeLustDamage(lustDmg, true);
		}
		
		private function yamataEntwine():void
		{
			outputText("Yamata’s hair whips toward you with a blinding speed, each of the snakes sinking its fangs into a different part of you and lifting you into the air. <I>“You’re MINE!”</I> she yells, bringing you in close as her hair begins to constrict around you. You can feel the bite wounds begin to tingle, and look in horror as you see that each of the snakes is injecting her corrupted purple flames directly into your body! If you can’t escape soon, you’ll be reduced to a gibbering masochistic heap in no time!\n\n"
			+"You are bound by Yamata’s snake-like hair. The only thing you can do is try to struggle free!\n\n"
			+"As the venomous flames course through your system, you start to become more and more turned on by the thought of being abused and degraded...  ");
			
			player.dynStats("cor", 2);
			player.addCombatBuff('str',-10);
			player.addCombatBuff('spe',-10);
			var damage:int = 40+25/(rand(3)+1);
			player.takeLustDamage(rand(6) + 10, true);
			player.takePhysDamage(damage, true);
			yamataSodomasochistApply(damage);
			this.createStatusEffect(StatusEffects.YamataEntwine, 0, 0, 0, 0);
		}
		
		public function entwineStruggle():void
		{
			clearOutput();
			outputText("You struggle against Yamata’s grip with every ounce of strength you can muster, desperately trying to free yourself.\n\n");
			var brokeFree:Boolean;			
			if ((rand(player.str) > (this.str / 4)*3) || rand(5)==0 || player.hasPerk(PerkLib.FluidBody)) {
				brokeFree = true;
			}
			if (brokeFree) {
				entwineEscape();
			} else {
				outputText("You thrash about fruitlessly, your struggles only getting you even more entangled in her serpentine hair. Yamata cackles evilly, reaching out to drag her nails across your chest, crooning about all the myriad torments she’ll subject you to when you’re her loyal slave. Still fighting against her");
				if (player.str < 90)
					outputText(" immense");
				else
					outputText(" impressive"); 
				outputText(" strength, in an attempt to free yourself from her corrupting embrace, without success.");
				var damage:int = 25 + rand(15);
				player.takePhysDamage(damage, true);
				yamataSodomasochistApply(damage);
				player.takeLustDamage(rand(6) + 10, true);
				player.dynStats("cor", 1);
				performCombatAction();
			}
		}
		
		private function entwineEscape():void
		{
			outputText("You lash out with reserves of strength you didn’t know you had, tearing yourself away from her with a few stray hairs clinging to your body still as you tumble away. As you move back into a defensive stance, Yamata looks incredulously at the frayed clump of hair where you broke free from her, then shouts, “You fucking did it now! I’m gonna carve you to ribbons!” In spite of her threats, her hair seems to repair itself, easily growing back into its monstrous snake form.\n\n");
			player.removeStatusEffect(StatusEffects.YamataEntwine);
			outputText("<b>You feel relief as Yamata's serpents finally release their hold, though you can still feel their corruption pulsing in your veins.</b>\n\n");
		}
		
		public function entwineWait():void
		{
			clearOutput();
			outputText("You don't see the point of struggling against such a powerful foe, letting Yamata have her fun. The snakes entangling you continue to pump their foul fires into you and it is turning you on just watching them do so! The pain bocomes more pleasurable the longer you are subjected to it!");
			player.dynStats("cor", 1);
			flags[kFLAGS.YAMATA_MASOCHIST] += 2;
			performCombatAction();
		}
				
		private function foxfireCanon1():void
		{
			outputText("Yamata’s hair snakes begin to fan themselves out, curling toward you with their jaws unhinged and open wide. They seem to be drawing in energy as bright balls of purple flame begin to build up in each of their mouths. It looks like Yamata is charging up for something big!");
			this.createStatusEffect(StatusEffects.YamataCanon, 0, 0, 0, 0);
		}
		
		private function foxfireCanon2():void
		{
			var totaldmg:int = 0;
			if (flags[kFLAGS.IN_COMBAT_USE_PLAYER_WAITED_FLAG] == 1) {
				outputText("The air is suddenly filled with missiles of corrupted flame as each of the eight snake heads launches its own projectile at you! Thankfully you were prepared for it, and easily dip, duck, and dive through all of the flaming missiles, emerging unscathed.");
			} else {
				var hits:int = rand(9);
				outputText("The air is suddenly filled with missiles of corrupted flame as each of the eight snake heads launches its own projectile at you! You do your best to block or dodge them all, but your previous actions this round have put you at a slight disadvantage.\n\n");
				if(hits == 0) {
					outputText("You somehow manage to emerge unscathed, but the effort of avoiding or deflecting them all has put a strain on your muscles!");
					player.fatigue += 10;
				} else {
					outputText(hits + (hits>1?" fireballs rocket":" fireball rockets")+" into you with deadly force! As the corrupted flames wash over you, you start to enjoy the pain, gripping yourself in masochistic pleasure!  ");
					for(var i:int = 0; i < hits; i++) {
						var x:int = rand(10)+5;
						player.dynStats("cor", 1);
						player.takeFireDamage(x*2, true);
						player.takeLustDamage(x/2, true);
						totaldmg += x*2;
					}
				}
			}
			if (totaldmg > 0) yamataSodomasochistApply(totaldmg);
			this.removeStatusEffect(StatusEffects.YamataCanon);
		}
		
		private function yamataMiss():void
		{
			outputText("You neatly dodge Yamata’s wild attack, backing up and holding up your [weapon] defensively. <i>“Haha! I love it when my prey has some fight in them!”</i>");
		}
		
		private function yamataSodomasochistApply(dmg:int):void
		{
			outputText("\n\nYamata delights in the pain being caused...  ");
			this.takeLustDamage(int(dmg/2), true);
			this.dynStats("str", dmg/25, "spe", -dmg/30);
		}
		
		//<Masochism Aura> Passive ability
		//Due to her heavily-corrupted state, Yamata emits an aura that subtly influences anyone who fights against her to become a masochist, causing their lust to rise every time they are hurt. This effect is compounded even more if the PC is already a masochist.

		//<Frenzy> Passive ability
		//Yamata’s Lust has a direct effect on her combat effectiveness. As her Lust rises, she receives a %increase to her Strength while incurring a %penalty to her Speed, representing an increase in her recklessness and lack of self-control.
		
		private function kitsuneSealAttack():void
		{
			var resist:int = 0;
			if (player.inte < 30) resist = Math.round(player.inte);
			else resist = 30;
			if (player.findPerk(PerkLib.Whispered) >= 0) resist += 20;
			if ((player.findPerk(PerkLib.HistoryReligious) >= 0 || player.findPerk(PerkLib.PastLifeReligious) >= 0) && player.cor < 20) resist += 20 - player.cor;
			var select:int = rand(7);
			//Attack:
			if (select == 0) {
				outputText("The kitsune playfully darts around you, grinning coyly.  She somehow slips in under your reach, and before you can react, draws a small circle on your chest with her fingertip.  As you move to strike again, the flaming runic symbol she left on you glows brightly, and your movements are halted mid-swing.");
				outputText("\n\n\"<i>Naughty naughty, you should be careful with that.</i>\"");

				outputText("\n\nDespite your best efforts, every time you attempt to attack her, your muscles recoil involuntarily and prevent you from going through with it.  <b>The kitsune's spell has sealed your attack!</b>  You'll have to wait for it to wear off before you can use your basic attacks.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 0, 0, 0);
			}
			else if (select == 1) {
				//Tease:
				outputText("You are taken by surprise when the kitsune appears in front of you out of nowhere, trailing a fingertip down your chest.  She draws a small circle, leaving behind a glowing, sparking rune made of flames.  You suddenly find that all your knowledge of seduction and titillation escapes you.  <b>The kitsune's spell has sealed your ability to tease!</b>  Seems you won't be getting anyone hot and bothered until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 1, 0, 0);
			}
			//Spells:
			else if (select == 2) {
				outputText("\"<i>Oh silly, trying to beat me at my own game are you?</i>\"  the kitsune says with a smirk, surprising you as she appears right in front of you.  She traces a small circle around your mouth, and you find yourself stricken mute!  You try to remember the arcane gestures to cast your spell and find that you've forgotten them too.  <b>The kitsune's spell has sealed your magic!</b>  You won't be able to cast any spells until it wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 2, 0, 0);
			}
			//Items:
			else if (select == 3) {
				outputText("\"<i>Tsk tsk, using items?  That's cheating!</i>\"  the kitsune says as she appears right in front of you, taking you off guard.  Her finger traces a small circle on your pouch, leaving behind a glowing rune made of crackling flames.  No matter how hard you try, you can't seem to pry it open.  <b>The kitsune's spell has sealed your item pouch!</b>  Looks like you won't be using any items until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 3, 0, 0);
			}
			//Run:
			else if (select == 4) {
				outputText("\"<i>Tsk tsk, leaving so soon?</i>\"  the kitsune says, popping up in front of you suddenly as you attempt to make your escape.  Before you can react, she draws a small circle on your chest with her fingertip, leaving behind a glowing rune made of crackling blue flames.  You try to run the other way, but your [legs] won't budge!\n\n\"<i>Sorry baby, you'll just have to stay and play~.</i>\" she says in a singsong tone, appearing in front of you again.  <b>The kitsune's spell prevents your escape!</b>  You'll have to tough it out until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 4, 0, 0);
			}
			//P.Special:
			else if (select == 5) {
				outputText("You jump with surprise as the kitsune appears in front of you, grinning coyly.  As she draws a small circle on your forehead with her fingertip, you find that you suddenly can't remember how to use any of your physical skills!");
				outputText("\n\n\"<i>Oh no darling, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The kitsune's spell has sealed your physical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 5, 0, 0);
			}
			//M.Special:
			else {
				outputText("You jump with surprise as the kitsune appears in front of you, grinning coyly.  As she draws a small circle on your forehead with her fingertip, you find that you suddenly can't remember how to use any of your magical skills!");
				outputText("\n\n\"<i>Oh no darling, </i>I'm<i> the one with all the tricks here.</i>\"");
				outputText("\n\n<b>The kitsune's spell has sealed your magical skills!</b>  You won't be able to use any of them until the spell wears off.");
				player.createStatusEffect(StatusEffects.Sealed, 4, 6, 0, 0);
			}
			if (resist >= rand(100)) {
				outputText("\n\nUpon your touch, the seal dissipates, and you are free of the kitsune's magic!  She pouts in disappointment, looking thoroughly irritated, but quickly resumes her coy trickster facade.");
				player.removeStatusEffect(StatusEffects.Sealed);
			}
		}
		
		override protected function handleFear():Boolean
		{
			removeStatusEffect(StatusEffects.Fear);
			outputText("Yamata shudders in delight for a moment, then looks your way with a clear head.  \"<i>I love that! You should do it more often!</i>\"\n");
			return true;
		}

		override protected function handleBlind():Boolean
		{
			outputText("<i>“Your fancy tricks wont work on me Champion, I see right through them.”</i> Your blinding attack simply fades away before her magic.")
			return true;
		}
		
		override protected function performCombatAction():void
		{
			
			//basic attack has 2x chance unless arcane archer active
			var moves:Array;
				moves = [yamataBasic, yamataDarkFoxfire, yamataNightmare, yamataBasic, yamataIllusionLust, yamataLustAttack, kitsuneSealAttack];
			if (player.getEvasionRoll()) {
				moves = [yamataMiss];
			}
			if (this.hasStatusEffect(StatusEffects.YamataCanon)) {
				foxfireCanon2();
			}
			else if (rand(15) == 0) {
				foxfireCanon1();
			}
			else if (rand(10) == 0 && !this.hasStatusEffect(StatusEffects.YamataEntwine)) {
				yamataEntwine();
			}
			else {
				moves[rand(moves.length)]();
			}
		}

		override public function defeated(hpVictory:Boolean):void
		{
			SceneLib.aikoScene.yamataLoses();
		}
		
		override public function won(hpVictory:Boolean, pcCameWorms:Boolean):void
		{
			SceneLib.aikoScene.yamataWins();
		}

		public function Yamata() 
		{
			this.a = "";
			this.short = "Yamata";
			this.imageName = "yamata";
			this.long = "Yamata stands before you, grinning psychotically as her nine fox tails flare out behind her. Her jet black hair twists and writhes in the air, forming eight serpentine heads that snap at anything within reach. A pair of demonic horns curves up in front of her ears, and she is wielding a cursed black sword that resembles an oversized billhook bathed in demonic power. Just looking at her for too long causes strange thoughts to enter your mind, urging you to submit to her and become her loyal masochistic pet. You’ll have to keep your wits about you, or you might start enjoying the pain!";
			this.createVagina(false, VaginaClass.WETNESS_WET, VaginaClass.LOOSENESS_LOOSE);
			this.createStatusEffect(StatusEffects.BonusVCapacity, 8000, 0, 0, 0);
			createBreastRow(Appearance.breastCupInverse("E"));
			this.ass.analLooseness = AssClass.LOOSENESS_NORMAL;
			this.ass.analWetness = AssClass.WETNESS_MOIST;
			this.createStatusEffect(StatusEffects.BonusACapacity,200,0,0,0);
			this.tallness = 69;
			this.hips.type = Hips.RATING_AMPLE;
			this.butt.type = Butt.RATING_AVERAGE+1;
			this.skinTone = "light tan";			//might need to change to russet
			this.hairColor = "black";
			this.hairLength = 22;
			initStrTouSpeInte(120, 140, 270, 200);
			initWisLibSensCor(200, 120, 130, 100);
			this.weaponName = "Muramasa";
			this.weaponVerb = "slash"
			this.armorName = "tight chest wrap and baggy pants";
			this.armorDef = 16;
			this.bonusHP = 2400;
			this.lust = 25;
			this.bonusLust = 150;
			this.lustVuln = 0.35;
			this.temperment = TEMPERMENT_LUSTY_GRAPPLES;
			this.level = 60;
			this.gems = rand(20) + 30;
			this.drop = new WeightedDrop(consumables.MYSTJWL, 1);
			this.tail.type = Tail.FOX;
			this.tail.count = 9;
			checkMonster();
		}
	}
}