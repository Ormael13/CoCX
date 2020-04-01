/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.GlacialRift 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.WeaponLib;
	import classes.CoC;
	import classes.BodyParts.*;
	
	public class YukiOnnaScene extends BaseContent 
	{
		
		public function YukiOnnaScene() 
		{
		}
		
		public function encounterYukiOnna():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.MetYukiOnna)) {
				if (player.yukiOnnaScore() >= 14 && player.hasPerk(PerkLib.IcyFlesh)) {
					outputText("As you explore the glacial rift the weather begins to take a turn for the worse, your visibility dimming out until you can barely see a few meters ahead of yourself. You begin considering going back to camp when a sweet female voice begins to sing amidst the blizzard. You know this song, melancholic, tragic even and something stirs you to fellow the song to its source, a Yuki Onna enjoying the blizzard standing next to a cliff, her snowish white silk like hair floating softly in the wind. She turns to you smiling, waving you to come closer.\n\n");
					outputText("\"<i>Why hello there snow sister. I just can't find anything to warm me up and I have been singing for hours, so how about we had some sisterly bonding, just you and I?</i>\"\n\n");
					outputText("You catch her meaning right away, smiling coyly in approval as you toss your equipment to the snow bank on the side. Who needs a bed really? The snow is comfy enough and it's certainly not like you or her is gonna die from the cold, though others might.\n\n");
					outputText("She gently pulls you against her, your cold skins deliciously rubbing against one another. The contact of the snow is like a gentle velvet glove and when you both plunge into it the sensation of it molding to your entwined shape like a well made bed, something you hadn't had since Ingnam. It isn't warm nor cold, it's just the right temperature for your frigid forms.\n\n");
					outputText("She slides a hand between you, resting it against the underside of your left breast. You sigh at the caress replicating by tasting the curve of her tight with your right hand. Encouraged, she pulls you with her other hand into a soft wet kiss, your bluish tongue meeting with hers as her hand cups your breast, making you moan inside her mouth. Unsatisfied with these simple moves, you grind your pussy lips against hers, enjoying the building heat between your two labias. ");
					outputText("Her motion follows yours, cold snow falling softly around and on the both of you as you make sisterly love to one another. This contrast between hot and cold is only all the more pleasurable to your frozen bodies.\n\n");
					outputText("The experience is delightful but why stop there? You snap your fingers and use your snow control power to craft a well sized double ended dildo out of slippery ice. Satisfied with the shape you slide it between your two holes, enjoying the penetration as your pussy smacks against hers. You cry out in delight as the hastily crafted sex toy slides from your pussy depths to hers. ");
					outputText("After a few minutes of this delicious experience, your paired orgasm now imminent, the both of you let out a banshee like scream as your cunts drenches the snowy mat below.\n\n");
					outputText("Highly satisfied you depose a loving kiss on your partner's lips before dressing up and heading back to camp.\n\n");
					player.sexReward("Default","Default",true,false);
					doNext(camp.returnToCampUseOneHour);
				}
				else {
					outputText("As you explore the glacial rift the weather begins to take a turn for the worse your visibility diming out until you can barely see a few meters ahead of yourself. You begin considering going back to camp when a sweet female voice begins to sing amidst the blizzard. The song is melancholic, tragic even and something stirs you to fellow the song to its source, a young human woman who appear to be lost in the blizzard next to a cliff, her snowish white silk like hair floating softly in the wind. ");
					outputText("She turns to you smiling, waving you to come closer. Fool me once shame on you, fool me twice shame on me, this girl is clearly a Yuki Onna and knowing how your last escapade went you would be well advised to ready yourself for combat here and now yet… do you really want to? Her song feel so captivating, it would be so easy to succumb to it again.\n\n");
					menu();
					addButton(1, "Yes", encounterYukiOnnaYes2);
					addButton(3, "No", encounterYukiOnnaNo2);
				}
			}
			else {
				player.createStatusEffect(StatusEffects.MetYukiOnna, 1, 0, 0, 0);
				outputText("As you explore the glacial rift the weather begins to take a turn for the worse, your visibility dimming out until you can barely see a few meters ahead of yourself. You begin considering going back to camp when a sweet female voice begins to sing amidst the blizzard. The song is melancholic, tragic even and something stirs you to fellow the song to its source, a young human woman who appear to be lost in the blizzard next to a cliff, her snowish white silk like hair floating softly in the wind. She turns to you smiling, waving you to come closer.\n\n");
				outputText("\"<i>Did you like my song? Quite refreshing is it not? Visitors are rare in the rift so I spend my free time singing.</i>\"\n\n");
				outputText("You admit she sings well, is she a locale? You did not expect to see a human here least of all because this place is what could pass as one of the worst on Mareth.\n\n");
				outputText("\"<i>Why now, my family has been living here for generations though right now I live alone. I should insist you follow me up to my home for tea, you look like you could use some rest.</i>\"\n\n");
				encounterYukiOnna2();
			}
		}
		public function encounterYukiOnna2():void {
			outputText("Of course you will follow her if only to make sure the local wildlife doesn't tear her to shreds on her way back home. You finally spot a cozy house with a fireplace in the distance. ");
			outputText("She heads through the front door and you follow her in. It's not that much warmer inside but you put the fault on having been in the blizzard too long which is why you can't seem to get receptive to the heat. She sits you down in a chair next to the not so warm fireplace and gets to pouring you a cup of tea. To your absolute disappointment the tea has obviously ran cold like everything else in this house. The girl apologizes right away and the two of you begin to talk.\n\n");
			outputText("After a while you don't know exactly how or when you did move but you are now laying down on a silky white couch");
			if (player.wis < 100) {
				player.createStatusEffect(StatusEffects.Disarmed, 50, 0, 0, 0);
				flags[kFLAGS.PLAYER_DISARMED_WEAPON_ID] = player.weapon.id;
				player.setWeapon(WeaponLib.FISTS);
				outputText(" half stripped out of your gear");
			}
			outputText(" with her against you ready for a kiss.\n\n");
			if (player.wis > 30) {
				outputText(" Do you let her?");
				menu();
				addButton(1, "Yes", encounterYukiOnnaYes);
				addButton(3, "No", encounterYukiOnnaNo);
			}
			else doNext(encounterYukiOnnaYes);
		}
		public function encounterYukiOnnaYes():void {
			clearOutput();
			outputText("She pulls you in and as your two mouths connect you drift pleasantly through mind numbing pleasure. The kiss is wonderful so why is everything around you feeling so cold… desperate for bodily warmth you try and rub yourself against your partner but it only makes it worse. You're literally chilling to death as if all heat was stripped away from you. You’re starting to feel sleepy so you close your eyes, savoring the chilly tingling sensation, how easy it would be to just let go and lose yourself to the cold.\n\n");
			if (player.gender == 1) {
				outputText("You eventually lose consciousness abandoning yourself fully to the kiss.\n\n");
				outputText("You wake up somewhere else familiar. This is Yu’s cave and you are sleeping right next to a bonfire. Yu isn't far either, watching on you.\n\n");
				outputText("\"<i>Dummy [name] nearly got killed. Yu found [name] out in the blizzard sleeping in the snow and colder than death.</i>\"\n\n");
				outputText("You recall your past few hours to the yeti who sigh.\n\n");
				outputText("\"<i>This be handiwork of a Yuki Onna, bad spirits. Invite peoples in their lair all friendly then drains all warmth of life from them. Yu find victims daily.</i>\"\n\n");
				outputText("You feel like you nearly died for that matter so Yu finding you was timely indeed. You thank her for the save.\n\n");
				outputText("\"<i>Yu did nothing big. If [name] want for heart warmth though [name] should ask Yu, not sketchy girl in blizzard.</i>\"\n\n");
				outputText("You will remember that one.\n\n");
				if (player.tou > 30) player.tou -= 30;
				else player.tou = 1;
			}
			else {
				if (rand(3) == 0) player.skinTone = "snow white";
				else {
					if (rand(2) == 0) player.skinTone = "pale blue";
					else player.skinTone == "glacial white";
				}
				player.skinAdj = "cold";
				outputText("At first it felt horribly cold like you were dying, then the sensation began to fade as you finally felt yourself getting warmer. Or is it truly that you are getting warmer in the first place? Seeking to feel more you pull her closer and she rewards you by gently sliding a finger into your folds. You gasp in her mouth, taking a deep breath of fresh cold air. Cold? Hot? You no longer really care as you are too lost in this smooth little world just between you and her. Her pale white skin touching yours, making you shiver exquisitely. ");
				outputText("You help her out, sliding your own hand in her ice cold pussy, barely feeling yourself anymore. Her mouth part ways with yours, a crystal clear strand of saliva breaking between you as she heads down to one of your cold hardened nipples and starts to suckle it out, her tongue flicking the tip and giving your chest some well needed attention. The contrast between cold and hot slowly dies out, eventually replaced by chilling pleasure, one of her cold delicate hands cupping your chest as you begin grinding your pussy against hers, ");
				outputText("the pair of you moaning in delight as you approach your respective climax. The world around you seems to lose all color, bleaching to the color of white snow as you finally cum. The light fades as you slowly lose consciousness in your partner's arms, the last of your strength abandoning you. You barely remember her kissing you one last time and telling you sweet dreams as you lose to the black curtain entirely.\n\n");
				if (player.statusEffectv1(StatusEffects.MetYukiOnna) == 1 || player.statusEffectv1(StatusEffects.MetYukiOnna) == 3) outputText("You wake up in a very different place from where you remember laying down. The bed is still there partially covered with a snowy blanket but the hearth looks like it hasn't been used in years. There is a hole in the roof explaining where the snow came from and what isn't buried by snow is covered with a thin layer of dust like the place has been abandoned for years.\n\n");
				else outputText("You wake up on the same snowcovered bed you slept in last night. Truth be told you are somewhat confused because despite the delicious experience, you fully expected to die. It's a mystery how you didn't die all things considered since your form has literally been buried under a thin blanket of snow for several hours now.\n\n");
				outputText("You are stark naked yet despite this feel nothing… no cold… no warmth in a room in which obviously you should be freezing to death. A few thin strands of white is visible before your eyes and you move it away, realising seconds later that those strands is your hair. Looking at your hand, you are surprised by the paleness of your "+player.skinTone+" skin... like that of a chilled corpse. Placing your hand on your chest, you don't feel the beating of your own heart either.. as if it had frozen along with the rest. ");
				outputText("You still breathe, drawing air in and out, yet the air coming out is cold and creates none of the warm cloud a living being should make when breathing at such temperatures. Your feet are naked yet the snow feels pleasant underneath them."+(player.gender == 3 ? " Whatever male asset you had is gone from your nether as well… you’re definitely fully female now.":"")+" You don't feel cold despite the ambient temperature yet… you yearn for the warmth of others, the warmth that you lost, this is all so unfair. ");
				outputText("You desperately need to fill this empty void within you with something... anything. Surely they will share it if you ask nicely and if they don't... you will simply have to steal it from them.\n\n");
				outputText("As if to mirror your growing jealous indignation the snow around you becomes agitated, turning into a small indoor blizzard which only calms down once you do. You need to feel warmth again no matter what and it doesn't matter if everyone around you has to freeze to death in order to satisfy YOUR needs. <b>Your soul has frozen over, you have become a Yuki Onna in body and heart.</b>\n\n");
				CoC.instance.mutations.setFaceType(Face.YUKI_ONNA);
				CoC.instance.mutations.setLowerBody(LowerBody.YUKI_ONNA);
				if (player.legCount != 2) player.legCount = 2;
				CoC.instance.mutations.setArmType(Arms.YUKI_ONNA);
				CoC.instance.mutations.setEyeTypeAndColor(Eyes.HUMAN,"light purple");
				CoC.instance.mutations.setHairType(Hair.SNOWY);
				if (rand(3) == 0) player.hairColor = "snow white";
				else {
					if (rand(2) == 0) player.hairColor = "silver white";
					else player.hairColor = "platinum blonde";
				}
				if (player.hairLength < 25) player.hairLength = 25;
				CoC.instance.mutations.setWingType(Wings.LEVITATION, "levitation");
				CoC.instance.mutations.setRearBody(RearBody.GLACIAL_AURA);
				if (player.skin.base.pattern != Skin.PATTERN_NONE) {
					player.skin.base.pattern = Skin.PATTERN_NONE;
					player.skin.base.adj = "";
				}
				if (!player.hasPerk(PerkLib.ColdAffinity)) player.createPerk(PerkLib.ColdAffinity, 0, 0, 0, 0);
				player.createPerk(PerkLib.DeadMetabolism, 0, 0, 0, 0);
				player.createPerk(PerkLib.IcyFlesh, 0, 0, 0, 0);
				player.femininity = 100;
			}
			if (CoC.instance.inCombat) cleanupAfterCombat();
			else doNext(camp.returnToCampUseEightHours);
		}
		public function encounterYukiOnnaYes2():void {
			outputText("You decide to accept the treacherous girl’s invitation despite knowing how it will end. Or perhaps you hope for a different conclusion?\n\n");
			outputText("\"<i>Did you like my song? Quite refreshing is it not? Visitors are rare in the rift so I spend my free time singing.</i>\"\n\n");
			outputText("You admit she sings well, is she a locale? You did not expect to see a human here least of all because this place is what could pass as one of the worst on Mareth.\n\n");
			outputText("\"<i>Why now, my family has been living here for generations though right now I live alone. I should insist you follow me up home for tea you look like you could use some rest.</i>\"\n\n");
			encounterYukiOnna2();
		}
		public function encounterYukiOnnaNo():void {
			player.addStatusValue(StatusEffects.MetYukiOnna, 1, 1);
			outputText("\n\nThere's something horribly wrong about her! Starting with the fact that she stood alone in the blizzard, in a kimono nonetheless. Then the fact everything in the house was colder than outside despite the clear presence of a fire. Even the bed is cold! And her body.. geeze her skin is colder than ice!\n\n");
			outputText("You shove her off as she is about to kiss you and ready yourself for a fight. She smirks, realising you are up to her scheme.\n\n");
			outputText("\"<i>Why now, we have a smart one right here. You almost fell for it but I guess it's impossible to hit the mark every time.</i>\"\n\n");
			outputText("The scene changes radically as she speaks, the house is now in shambles, the fire hearth long dead, the ground covered with snow just as the bed you were laying on. There's even a hole in the roof from which snow drops every now and then.\n\n");
			outputText("\"<i>Why couldn't you just stay down in the bed and enjoy yourself a minute longer. I wanted to keep this easy and fast but you had to sniff me out. Guess there's no helping it anymore. If you won't lay still on your own then I will beat you down until you do so.</i>\"\n\n");
			outputText("Howling winds circle the room as the girl floats into the air, her formerly pale skin bleaching to the complexion of a frozen corpse, her lips bluish and her eyes cold and cruel. An icy spear finally forms in her hands, sharp and deadly.\n\n");
			outputText("\"<i>Winter is coming!</i>\"\n\n");
			startCombat(new YukiOnna());
		}
		public function encounterYukiOnnaNo2():void {
			outputText("Yea no that icy bitch can burn!"+(player.weaponName != "fists" ? " You draw your [weapon] ready for battle and signify your intent to fight.":"")+" The Yuki Onna notices it and smile.\n\n");
			outputText("\"<i>Oh.. a survivor? Guess someone botched up. Please allow me to correct the mistake.</i>\"\n\n");
			outputText("The climate suddenly turn to an all out snowstorm as the Yuki Onna lift from the ground.\n\n");
			startCombat(new YukiOnna());
		}
		
		public function loseToYukiOnna():void {
			clearOutput();
			if (player.statusEffectv1(StatusEffects.MetYukiOnna) == 1) {
				outputText("Her relentless attacks put a definitive end to any resistance you had left, forcing you back into the snow covered bed.");
				if (player.gender == 2 || player.gender == 3) {
					outputText(" Sensing that you are terrified she gently shushes you, placing a finger on your trembling lips.\n\n");
					outputText("\"<i>Don't be scared little sister.. it will be sweeter than sugar, and pleasant like a cool breeze during summer. I am kind and caring to cute girls I meet. This is more than what can be said for males.</i>\"\n\n");
					outputText("This assuage your worries if only a little and allow you to relax in her embrace.");
				}
				outputText("\n\n");
				encounterYukiOnnaYes();
			}
			else {
				outputText("Defeated by (lust)your growing lust (damage)the ravaging cold (End of cut)you pass out somewhat terrified to think of what will happen to you.\n\n");
				outputText("After awhile you wake up still dizzy. You don't know exactly how or when you did move but you are now laying down on a silky white couch, in some beautiful and cozy house, fully stripped out of your gear and with the Yuki Onna snuggling against you, ready for a kiss. Even if you wanted to try and get out of this situation you are still to weak from the battle to fight back.");
				if (player.gender == 2 || player.gender == 3) {
					outputText(" Sensing that you are terrified she gently shushes you, placing a finger on your trembling lips.\n\n");
					outputText("\"<i>Don't be scared little sister.. it will be softer than snow, and pleasant like a cool breeze during summer. I am kind and caring to cute girls I meet.</i>\"\n\n");
					outputText("This assuage your worries if only a little and allow you to relax in her embrace.");
				}
				outputText("\n\n");
				encounterYukiOnnaYes();
			}
		}
		
		public function winAgainstYukiOnna():void {
			menu();
			outputText("In defeat the Yuki Onna screams before vanishing in the intensifying blizzard covers her escape as the world around you turns white with snow, ice and sleet. This said she doesn't leave without warning, likely you will meet her again sooner or later.\n\n");
			outputText("\"<i>This is just a setback! The wolf god be my witness I will freeze your soul sooner or later.</i>\"\n\n");
			outputText("Eventually the storm finally calms down, leaving you somewhat alive and fine in the middle of the rift. You head back to camp, satisfied with having defeated your opponent and truth be told, with how freezing you are right now, the last thing on your mind is sex, least of all with a ice spirit bent on doing you harm.\n\n");
			if (player.statusEffectv1(StatusEffects.MetYukiOnna) == 2) player.addStatusValue(StatusEffects.MetYukiOnna, 1, 1);
			player.lust = player.minLust();
			cleanupAfterCombat();
		}
		
	}

}