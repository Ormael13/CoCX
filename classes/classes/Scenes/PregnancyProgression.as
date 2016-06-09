package classes.Scenes 
{
	import classes.*;
	import classes.GlobalFlags.*;
	
	public class PregnancyProgression extends BaseContent
	{
		public function PregnancyProgression() {}
		
		public function updatePregnancy():Boolean {
			var displayedUpdate:Boolean = false;
			var pregText:String = "";
			if ((player.pregnancyIncubation <= 0 && player.buttPregnancyIncubation <= 0) ||
				(player.pregnancyType == 0 && player.buttPregnancyType == 0)) {
				return false;
			}
			//Cancel Heat
			if (player.inHeat) {
				outputText("\nYou calm down a bit and realize you no longer fantasize about getting fucked constantly.  It seems your heat has ended.\n", false);
				//Remove bonus libido from heat
				dynStats("lib", -player.statusEffectv2(StatusEffects.Heat));
				if (player.lib < 10) player.lib = 10;
				statScreenRefresh();
				player.removeStatusEffect(StatusEffects.Heat);
				displayedUpdate = true;
			}
			if (player.pregnancyIncubation == 1) {
				if (player.fertility < 15) player.fertility++;
				if (player.fertility < 25) player.fertility++;
				if (player.fertility < 40) player.fertility++;
				if (player.findStatusEffect(StatusEffects.Birthed) < 0) player.createStatusEffect(StatusEffects.Birthed,1,0,0,0);
				else {
					player.addStatusValue(StatusEffects.Birthed,1,1);
					if (player.findPerk(PerkLib.BroodMother) < 0 && player.statusEffectv1(StatusEffects.Birthed) >= 10) {
						outputText("\n<b>You have gained the Brood Mother perk</b> (Pregnancies progress twice as fast as a normal woman's).\n", false);
						player.createPerk(PerkLib.BroodMother,0,0,0,0);
					}
				}
			}
			if (player.pregnancyIncubation > 0 && player.pregnancyIncubation < 2) player.knockUpForce(player.pregnancyType, 1);
			//IF INCUBATION IS VAGINAL
			if (player.pregnancyIncubation > 1) {
				if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) {
					displayedUpdate = getGame().bog.phoukaScene.phoukaPregUpdate();
				}
				if (player.pregnancyType == PregnancyStore.PREGNANCY_SAND_WITCH) {
					displayedUpdate = getGame().dungeons.desertcave.sandPregUpdate();
				}
				if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA) {
					displayedUpdate = getGame().urtaPregs.urtaPregooUpdates();
				}
				//Cotton Pregnancy! - 350 days long
				if (player.pregnancyType == PregnancyStore.PREGNANCY_COTTON) {			
					if (player.pregnancyIncubation == 320) {
						outputText("\n<b>You realize your belly has gotten bigger. Maybe you should cut back on all the strange food.  Though you do have odd cravings for oats and grain.</b>\n", false);
						displayedUpdate = true;
					}
					else if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended. You are probably pregnant. The strong hankerings for oats and grains give you a very obvious clue as to who the 'father' might be.</b>\n", false);
						displayedUpdate = true;	
					}
					else if (player.pregnancyIncubation == 225) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  You stroke the orb and wonder with a half-grin if you'll have a daughter who takes after her 'daddy'.</b>\n");
						displayedUpdate = true;	
					}
					else if (player.pregnancyIncubation == 165) {
						outputText("\n<b>The sudden impact of a tiny kick from inside your womb startles you.  Moments later it happens again, making you gasp.  The baby inside you really must be equine in nature; she's already got quite a wicked kick on her.</b>\n");
						displayedUpdate = true;	
					}
					else if (player.pregnancyIncubation == 105) {
						outputText("\n<b>You're already as big as any pregnant woman back home. Considering that what you're carrying is technically a foal, you wonder just how much bigger you're going to get...</b>\n");
						displayedUpdate = true;	
					}
					else if (player.pregnancyIncubation == 80) {
						outputText("\n<b>Your swollen stomach would bring queries about the possibility of twins back in Ingnam.  However, you can only feel one strong heart beating away inside your stretched midriff.  Cotton's foal is definitely growing up healthy...\n\nYou're glad, but a little worried about giving birth.</b>\n");
						displayedUpdate = true;	
					}
					else if (player.pregnancyIncubation == 50) {
						outputText("\n<b>Your belly is painfully distended and swollen; you feel like you're going to burst before you get much bigger.  You find yourself pacing around restlessly in the night, like the expectant mares back in the village.  You're anxious to finally give birth, as much to get this heavy baby out of you as to finally be able to cuddle your child.</b>\n");
						displayedUpdate = true;	
					}
					//Tits
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						displayedUpdate = true;
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
				//Imp Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_IMP) {			
					if (player.pregnancyIncubation == 336) {
						outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended.   You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ", false);
						if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>", false);
						if (player.cor >= 75) outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						outputText("\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>The sudden impact of a kick from inside your womb startles you.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your belly is painfully distended, ", false);
						if (player.cor < 40) outputText("making it difficult to function.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.</b>", false);
						outputText("\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ", false);
						if (player.cor < 40) outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n", false);
						if (player.cor >= 40 && player.cor < 75) outputText("You estimate you'll give birth in the next few days.</b>\n", false);
						if (player.cor >= 75) outputText("You find yourself daydreaming about birthing demons repeatedly, each time being re-impregnated by your hordes of lusty adolescent children.</b>\n", false);
						displayedUpdate = true;
					}
				}
				//Minotaur Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_MINOTAUR) {			
					if (player.pregnancyIncubation == 336) {
						outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ", false);
						if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>", false);
						if (player.cor >= 75) outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						outputText("\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>The sudden impact of a kick from inside your distended womb startles you.  Moments later it happens again, making you gasp and stagger.  Whatever is growing inside you is strong.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your belly is painfully distended and overswollen with the offspring of some huge beast, ", false);
						if (player.cor < 40) outputText("making it difficult to function.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>", false);
						outputText("\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						displayedUpdate = true;
						outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever beast is inside your overstretched womb seems to appreciate the attention, and stops its incessant squirming.  ", false);
						if (player.cor < 40) outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n", false);
						if (player.cor >= 40 && player.cor < 75) outputText("You estimate you'll give birth in the next few days.</b>\n", false);
						if (player.cor >= 75) outputText("You find yourself daydreaming about birthing some huge monstrous beast, and raising it to fuck your wet pussy over and over.</b>\n", false);
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						displayedUpdate = true;
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
				//Centaur Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_CENTAUR || player.pregnancyType == PregnancyStore.PREGNANCY_KELT) {		
					if (player.pregnancyIncubation == 350) {
						outputText("\n<b>You realize your belly has gotten bigger. Maybe you should cut back on all the strange food.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended. You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  Somehow, you don't feel worried. Only content.</b>\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>The pregnancy is moving much faster than you expected. It's already as big as the belly of any pregnant woman back home.  However, a feeling of warm satisfaction fills you.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your belly is painfully distended and overswollen with the offspring of some huge beast, making it difficult to function.</b>\n", false);
						dynStats("spe", -1, "lib", .5, "sen", .5, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your stomach is easily the size of a beach ball, and still growing ever further. Strangely, you don't feel hindered. In fact, you feel like running...</b>\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>It seems impossible for your pregnant belly to grow any larger, but you are at your happiest yet, satisfied that somehow, you are fulfilling your role. It feels right to be pregnant, and you can't wait to get knocked up again afterwards.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						displayedUpdate = true;
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("<b>\nYou realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("<b>\nYour breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("<b>\nYour breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
				//Bunny tf preggoz
				if (player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
					if (player.pregnancyIncubation == 800) {
						outputText("\nYour womb gurgles strangely.\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 785) {
						//outputText("\n<b>An unexpected change occurs, no doubt brought on by the bunny's eggs inside you!</b>", false);
						getGame().mutations.neonPinkEgg(true,player);
						outputText("\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 776) {
						outputText("\nYour womb feels full and bloated.\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 765) {
						//outputText("\n<b>An unexpected change occurs, no doubt brought on by the bunny's eggs inside you!</b>", false);
						getGame().mutations.neonPinkEgg(true,player);
						outputText("\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation <= 745 && player.pregnancyIncubation > 400) {
						outputText("\n<b>After dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your womb have dissolved.</b>\n", false);
						displayedUpdate = true;
						player.knockUpForce(); //Clear Pregnancy
					}
					//BREAK - REAL PREGNANCY BELOW THIS:
					if (player.pregnancyIncubation == 198) {
						outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe there's some truth to what the bunny-girl said.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 178) {
						outputText("\n<b>Your belly is getting more noticeably distended.   You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 156) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ", false);
						if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("You find yourself wondering what giving birth to bunny-girls is like.</b>", false);
						if (player.cor >= 75) outputText("You dreamily wonder if you could find a bunny willing to put more than two eggs inside you at once.</b>", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						outputText("\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 140) {
						outputText("\n<b>The sudden impact of a kick from inside your womb startles you, and it's immediately followed by a second on the other side.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your belly is painfully distended, ", false);
						if (player.cor < 40) outputText("making it difficult to function.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth so you'll be able to get pregnant again.</b>", false);
						outputText("\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ", false);
						if (player.cor < 40) outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n", false);
						if (player.cor >= 40 && player.cor < 75) outputText("You estimate you'll give birth in the next few days.</b>\n", false);
						if (player.cor >= 75) outputText("You find yourself daydreaming about birthing bunnies repeatedly, each time being re-impregnated with dozens of eggs from your lusty adolescent children.</b>\n", false);
						displayedUpdate = true;
					}
				}
				//Marblz Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_MARBLE) {			
					if (player.pregnancyIncubation == 336) {
						outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ", false);
						if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>", false);
						if (player.cor >= 75) outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						outputText("\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>The sudden impact of a kick from inside your distended womb startles you.  Moments later it happens again, making you gasp and stagger.  Whatever is growing inside you is strong.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your belly is distended and overswollen with your offspring, ", false);
						if (player.cor < 40) outputText("making it difficult to function.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth, so you can get fill your womb with a new charge.</b>", false);
						outputText("\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever child is inside your overstretched womb seems to appreciate the attention, and stops its incessant squirming.\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32  || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 85) {
						//A small scene for very late in the pregnancy, its breast growth for the little cowgirl.  This scene should be a few days before birth, so the milk doesn't stop before the cowgirl is born.
						outputText("\n<b>Your belly has become heavily pregnant; at the same time, ", false);
						//If (PC has flat breasts) 
						if (player.biggestTitSize() <= 0) {
							outputText("your chest has begun to feel a bit odd.  Your run your hands over it to find that your breasts have grown to around C-cups at some point when you weren't paying attention!  ", false);
							player.breastRows[0].breastRating = 3;
						}
						else if (player.biggestTitSize() <= 1 && player.mf("m", "f") == "f") {
							outputText("your breasts feel oddly tight in your top.  You put a hand to them and are startled when you find that they've grown to C-cups!  ", false);
							player.breastRows[0].breastRating = 3;
						}
						else if (player.biggestTitSize() <= 10) {
							outputText("your breasts feel oddly full.  You grab them with your hands, and after a moment you're able to determine that they've grown about a cup in size.  ", false);
							player.breastRows[0].breastRating++;
						}
						else {
							outputText("your breasts feel a bit odd.  You put a hand on your chest and start touching them.  ", false);
						}
						if (player.biggestLactation() < 1) {
							outputText("You gasp slightly in surprise and realize that you've started lactating.", false);
							player.boostLactation(player.breastRows.length);
						} 
						else {
							outputText("A few drips of milk spill out of your breasts, as expected.  Though, it occurs to you that there is more milk coming out than before.", false);
							player.boostLactation(player.breastRows.length * .25);
						}
						outputText("</b>\n", false);
					}
				}
				//Jojo Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_JOJO) {
					if (player.pregnancyIncubation == 336) {
						outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n", false);
						if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) { //Bimbo Jojo, stage 1
							outputText("\nJoy notices you examining your belly and strolls over, playfully poking it with her finger. \"<i>Somebody's getting chubby; maybe you and I need to have a little more fun-fun to help you work off those calories, hmm?" + getGame().joyScene.joyHasCockText(" Or maybe I'm just feeding you too much...") + "</i>\" She teases" + getGame().joyScene.joyHasCockText(", patting her " + getGame().joyScene.joyCockDescript()) + ".\n");
						}
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n", false);
						if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 2
							outputText("\nA pair of arms suddenly wrap themselves around you, stroking your belly. \"<i>Like, don't worry, [name]; I love you even if you are getting fat. Actually... this little pot belly of yours is, like, kinda sexy, y'know?</i>\" Joy declares.\n");
							outputText("\nYou roll your eyes at Joy's teasing but appreciate her support all the same.\n");
						}
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 3
							outputText("\n<b>You have no doubt that you're pregnant now,</b> and from your recent urges to eat cheese and nuts, as well as the lusty thoughts that roam your head, you can already imagine who the father is...\n");
							outputText("\nJoy shakes her head. \"<i>Wow, you just keep getting, like, fatter and fatter, don't you, [name]? S'funny, though... I never thought of myself as, like, a chubby chaser before, but that belly of yours really gets me, y'know, hot 'n' bothered.</i>\" She comments.\n");
							outputText("\nYou sigh, almost laughing... sometimes Joy's inability to see the obvious is cute, sometimes it's just funny and sometimes both. You tell her to quit being silly, it's quite obvious by now that you're pregnant and she's the father, by the way.\n");
							outputText("\nJoy stares at you, silent and dumbfounded. Moments of silence pass by... you wonder if maybe you've broken her. Then, suddenly. \"<i>Yahoo!</i>\" She screams, and performs a backflip, dancing around with both arms pumping in the air before suddenly rushing towards you and throwing your arms around you, barely remembering to be gentle to avoid squishing your vulnerable belly. \"<i>I'm gonna be a daddy-mommy!</i>\" She shouts in glee.\n");
							outputText("\nJoy's erm... joy... is infectious and you find yourself smiling at her happy reaction.\n");
							if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 70 && !camp.marbleFollower()) {
								outputText("\nThen her face falls in realisation. \"<i>Crap! I gotta get that nursery built, like, now!</i>\" She yells. She gives your belly a loud, wet kiss, then runs off into the scrub, muttering to herself about what she needs to get.\n");
								flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 69;
							}
						}
						else {
							outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ", false);
							if (getGame().monk > 0) {
								if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
								if (player.cor >= 40 && player.cor < 75) outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>", false);
								if (player.cor >= 75) outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>", false);
							}
							else {
								outputText("</b>");
							}
						}
						outputText("\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 4
							outputText("\nIf there was ever any doubt you were carrying only one child before, it has long been forgotten. <b>Your belly is bigger than any woman's back in your village, and the children within are seemingly restless! They kick you all the time; it is clear they inherited Joy's energy, but it's starting to get bothersome.</b> You sigh as you take a seat to rest a bit as the babies inside you kick.\n");
							outputText("\nThis would, of course, be less tiresome if you didn't have to lug around a third mouse as well... A smooch on your belly signals Joy's arrival into the scene.\n");
							outputText("\nThe bimbo mouse smiles up at you, rubbing her cheek against your gravid midriff. \"<i>Aw... how are Joyjoy's little ones today? Are you being good to your mommy?</i>\" She coos.\n");
							outputText("\nYou tell her they've been very active lately, you barely get a moment's rest as they keep kicking inside your belly.\n");
							outputText("\nShe frowns and then stares at your belly. \"<i>Naughty little babies! Stop kicking mommy! You wouldn't be kicking like this inside mommy Joy's tummy, now would you?</i>\" She states, unconcerned about the fact she is trying to chastise her unborn offspring.\n");
							outputText("\nYou chuckle at the bimbo mouse's antics. Somehow the whole scene is uplifting, and you feel a bit less tired by your pregnancy.\n");
							if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] == 69 && !camp.marbleFollower()) {
								outputText("\nThe mouse turns to walk away, but stops before doing so and looks at you. \"<i>Oh, right! I, like, totally forgot; the nursery's all done now. Our little babies will have a cosy nest to play in when they finally, y'know, come out.</i>\" She states, full of pride at her achievements - both knocking you up and getting a nursery done.\n");
								flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 70;
							}
						}
						else {
							outputText("\n<b>The sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.</b>\n", false);
						}
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 && player.pregnancyType == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 5
							outputText("\nYou're mildly annoyed at your squirming tummy, it seems your children have taken a liking to scurrying about inside you. The other mildly annoying thing, is Joy's attachment to your huge pregnant belly. It would seem that the bimbo mouse is as eager to see the children as the children inside you are eager to come out and play.\n");
							outputText("\n\"<i>Like, [name], when are the babies gonna come out and play? I wanna hold my cute little squeakies already!</i>\" Joy pouts, stamping her foot in irritation at the wait for you to give birth.\n");
							outputText("\nYou tell her that she'll just have to wait, you want them out too. It's getting heavy.\n");
							outputText("\nJoy pouts, \"<i>But I want them to come out now!</i>\" She whines, then she heaves a heavy sigh. \"<i>Alright, I guess it'll be, like, worth the wait...</i>\" She looks at your " + player.breastDescript(0) + " and develops a sly expression. \"<i>Like... some nice creamy milk would make me feel better...</i>\" She wheedles.\n");
							outputText("\n");
							if (player.findPerk(PerkLib.Feeder) >= 0) outputText("You grin at Joy's idea, but you can't simply mash her against your breasts and nurse her without some teasing first.");
							outputText("You tell Joy that she can have some, but she has to ask nicely, like a good girl.\n");
							outputText("\nThe bimbo mouse presses her hands together and gives you a winning smile, eyes wide with an uncharacteristic innocence. \"<i>Like, [name], will you please let your little Joyjoy suck on your " + player.breastDescript(0) + " and drink all the yummy mommy-milk she can hold? Puh-lease?</i>\" She begs.\n");
							outputText("\nYou expose your breasts and open your arms in invitation.\n");
							outputText("\nJoy squeaks in glee and rushes into your embrace, rubbing her " + (getGame().jojoScene.pregnancy.isPregnant ? "swollen " : "") + "belly against your baby-filled stomach and nuzzling your player.breastDescript excitedly. She wastes no time in slurping on your nipplesdescript until they are painfully erect, then sucks the closest one into her mouth and starts suckling as if her life depends on it.\n");
							outputText("\nBy the time Joy's had her fill, your babies have calmed down a little. It seems like being close to Joy might have actually helped calm the little mice down. Joy yawns and nuzzles your " + player.breastDescript(0) + ".\n");
							outputText("\n\"<i>Mmm... Sooo good.</i>\" Joy murmurs, then burps softly. \"<i>I feel, like, so sleepy now...</i>\" She mumbles, yawning hugely, then reluctantly she pushes herself off of you and starts stumbling away in the direction of her bed" + (player.lactationQ() >= 750 || player.findPerk(PerkLib.Feeder) >= 0 ? ", her belly audibly sloshing from all the milk you let her stuff herself with" : "") + ".\n");
							outputText("\nYou sigh, glad to finally have a moment to rest.\n");
						}
						else {
							outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n", false);
						}
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your belly is painfully distended and overswollen with wriggling offspring, ", false);
						if (player.cor < 40) outputText("making it difficult to function.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>", false);
						outputText("\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever is inside your overstretched womb seems to appreciate the attention and stops its incessant squirming.  ", false);
						if (player.cor < 40) outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n", false);
						if (player.cor >= 40 && player.cor < 75) outputText("You estimate you'll give birth in the next few days.</b>\n", false);
						if (player.cor >= 75) outputText("You find yourself daydreaming about birthing hundreds of little babies, and lounging around while they nurse non-stop on your increasingly sensitive breasts.</b>\n", false);				
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}	
				//Amily Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) {
					if (player.pregnancyIncubation == 336) {
						outputText("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some mixed nuts. And maybe a little cheese, too.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 280) {
						outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>There is no question you're pregnant; your belly is already as big as that of any pregnant woman back home.", false);
						if (flags[kFLAGS.AMILY_FOLLOWER] == 1) outputText("  Amily smiles at you reassuringly. \"<i>We do have litters, dear, this is normal.</i>\"", false);
						outputText("</b>", false);
						outputText("\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>The sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>You feel (and look) hugely pregnant, now, but you feel content. You know the, ah, 'father' of these children loves you, and they will love you in turn.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>You jolt from the sensation of squirming inside your swollen stomach. Fortunately, it dies down quickly, but you know for a fact that you felt more than one baby kicking inside you.</b>\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>The children kick and squirm frequently. Your bladder, stomach and lungs all feel very squished. You're glad that they'll be coming out of you soon.</b>\n", false);				
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
				//Shark Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA) {
					if (player.pregnancyIncubation == 275) {
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) outputText("\n<b>You wake up feeling kind of nauseous.  Izma insists that you stay in bed and won't hear a word otherwise, tending to you in your sickened state.  When you finally feel better, she helps you up.  \"<i>You know, " + player.short + "... I think you might be pregnant.</i>\" Izma says, sounding very pleased at the idea. You have to admit, you do seem to have gained some weight...</b>\n", false);
						else outputText("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some fish.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 250) {
						outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) outputText("\n<b>Your stomach is undeniably swollen now, and you feel thirsty all the time. Izma is always there to bring you water, even anticipating your thirst before you recognize it yourself. She smiles all the time now, and seems to be very pleased with herself.", false);
						else outputText("\n<b>There is no question you're pregnant; your belly is getting bigger and for some reason, you feel thirsty ALL the time.", false);
						outputText("</b>", false);
						outputText("\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 180) {
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) outputText("\n<b>There is no denying your pregnancy, and Izma is head-over-heels with your 'beautifully bountiful new body', as she puts it. She is forever finding an excuse to touch your bulging stomach, and does her best to coax you to rest against her. However, when you do sit against her, she invariably starts getting hard underneath you.</b>\n", false);
						else outputText("\n<b>There is no denying your pregnancy.  Your belly bulges and occasionally squirms as your growing offspring shifts position.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) outputText("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling. Izma is always on hand now, it seems, and she won't dream of you fetching your own food or picking up anything you've dropped. She's always dropping hints about how you should try going around naked for comfort's sake. While you are unwilling to do so, you find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n", false);
						else outputText("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling.  You find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n", false);
						dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) outputText("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in. Izma makes no secret of her pleasure and informs you that you should deliver soon.</b>\n", false);
						else outputText("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in.  The time for delivery will probably come soon.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
							displayedUpdate = true;
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
					}
				}
				//SPOIDAH Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_SPIDER || player.pregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) {	
					if (player.pregnancyIncubation == 399) {
						outputText("\n<b>After your session with the spider, you feel much... fuller.  There is no outward change on your body as far as you can see but your womb feels slightly tingly whenever you move.  Hopefully it's nothing to be alarmed about.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 275) {
						outputText("\n<b>Your belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 250) {
						outputText("\n<b>Your belly looks a little pudgy", false);
						if (player.thickness > 60 && player.tone < 40) outputText(" even for you", false);
						outputText(", maybe you should cut back on all the food you've been consuming lately?</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>Your belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>A hot flush works its way through you, and visions of aroused ", false);
						if (player.pregnancyType == PregnancyStore.PREGNANCY_SPIDER) outputText("spider-morphs ", false);
						else outputText("driders ", false);
						outputText("quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and mated with over and over, violated by a pack of horny males, each hoping to father your next brood.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?</b>\n", false);
						dynStats("lib", 1, "sen", 1, "lus", 20);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.", false);
						if (player.cor < 50) outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.", false);
						outputText("</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
							displayedUpdate = true;
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
					}
				}
				//Goo Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_GOO_GIRL) {	
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your slime-packed belly is reassuring in its own way.  You can't wait to see how it feels to have the slime flowing and gushing through your lips, stroking you intimately as you birth new life into this world.", false);
						if (player.cor < 50) outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.", false);
						outputText("</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 82 || player.pregnancyIncubation == 16) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
							displayedUpdate = true;
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
					}
				}
				if (player.pregnancyType == PregnancyStore.PREGNANCY_EMBER) {
					//Pregnancy notes: Egg Laying 
					if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
						if (player.pregnancyIncubation == 330) pregText = "Your belly has swollen, becoming larger - proof that Ember's seed did its work.  The dragon seems to be constantly checking you out, as if looking for the signs of weight gain.";
						if (player.pregnancyIncubation == 250) pregText = "Your belly grows ever bigger, making your pregnancy noticeable; your belly also feels somewhat solid.  Ember casts pleased glances in your direction, whenever " + getGame().emberScene.emberMF("he","she") + " thinks you're not looking.";
						if (player.pregnancyIncubation == 170) {
							pregText = "You've grown a lot.  Anyone is able to tell that you're pregnant with a single glance; and by the shape, you have no doubt that there's an egg in your womb; a big one.";
							//(If Corruption < 40)
							if (player.cor < 40) pregText += "  Part of you didn't really want to get knocked up, but it's for a good cause.  Besides, Ember looks very cute, trying to hide " + getGame().emberScene.emberMF("his","her") + " happiness whenever " + getGame().emberScene.emberMF("he","she") + " glances at your belly...";
							//(If Corruption >= 40)
							else if (player.cor < 75) pregText += "  Considering the size of the egg, you hope it doesn't hurt when your child comes out.  You hope Ember will help you through this.";
							//(If Corruption >= 75)
							else pregText += "  You think dreamily about the wild sex that helped conceive this little one.  Ember is such a great fuck.  Really, you're doing this world a favor by bringing more of Ember's offspring into it.";
						}
						if (player.pregnancyIncubation == 120) pregText = "Though you're sure that this is the time when a regular baby would start moving about, your own belly simply sits there, heavy and full.  You'd be worried if you didn't remember that Ember hatched from an egg.  Sometimes; a delightful, refreshing, chill spreads from your belly throughout your body; making you feel invigorated, ready for anything.";
						if (player.pregnancyIncubation == 90) pregText = "You've somehow grown even larger, the egg's outline appearing through your tummy.  By now, you're quite bothered with how difficult it's getting to move.  Ember constantly shadows you around the camp, making sure you're all right, although if you ever question " + getGame().emberScene.emberMF("him","her") + " " + getGame().emberScene.emberMF("he","she") + "'ll just say you're both going in the same direction.";
						if (player.pregnancyIncubation == 60) {
							pregText = "The egg inside your belly seems to grow heavier each day that passes.  ";
							//(If Corruption < 40)
							if (player.cor < 40) pregText += "It's quite a burden that you're carrying.  Still, it's a worthwhile sacrifice to make in order to restore Ember's race.";
							//(If Corruption >= 40)
							else if (player.cor < 75) pregText += "You wonder how much longer you have to wait.  This egg is quite burdensome.  Part of you is scared of its size, the other part is delighted to have produced such a big egg.";
							//If Corruption >= 75)
							else pregText += "You're eager to give birth, just so you can get impregnated again.  Particularly because that means more wild sex with Ember.";
						}
						if (player.pregnancyIncubation == 30) {
							pregText = "You rub your hands over your ripe belly, lost in the sensations of motherhood.  ";
							dynStats("sen", 5, "lus", (5+player.sens/20));
							//If Corruption < 40
							if (player.cor < 40) pregText += "Despite your initial reluctance, you've come to find a very real pleasure in being pregnant.  You hope Ember will want to have more children in the future...";
							//(If Corruption >= 40)
							else if (player.cor < 75) pregText += "You smile, knowing you'll have your egg in your hands the next few days.  A part of you is almost sad that you'll be empty, but you can always entice Ember into getting you pregnant again.";
							//(If Corruption >= 75)
							else {
								pregText += "You find yourself daydreaming about giving birth, your belly swollen huge - bigger than it currently is - and the orgasmic sensation of many large, round eggs sliding out of your [vagina].\n\nYou start to absently rub yourself as you envision eggs by the dozens coming from within you; you shall be mothergod for a whole new race of dragons...";
								dynStats("lus", 35);
							}
							pregText += "\n\nEmber interrupts your musings with a question.  \"<i>How are you feeling? Do you need me to get you anything?</i>\"";
							pregText += "\n\nThe dragon's question is uncharacteristic of " + getGame().emberScene.emberMF("him","her") + ".  Still, you do appreciate the attention you're getting, and so you ask Ember to fetch you some food and water.  The speed with which Ember dashes off to fulfill your requests is truly impressive!  In short moments Ember is back with a piece of roasted meat and a skin of water.";
							pregText += "\n\nAs you eat and drink your fill, Ember uses one wing to shield you off the sun.  You're starting to really enjoy all the attention, but seeing Ember give up on " + getGame().emberScene.emberMF("his","her") + " usual antics is still very weird.";
						}
					}
					//Pregnancy Notes: Live Birth 
					else {
						if (player.pregnancyIncubation == 330) pregText = "Your belly is a bit swollen - either you're eating too much or Ember's seed really did the job.";
						if (player.pregnancyIncubation == 250) pregText = "Your belly grows ever bigger, making your pregnancy noticeable.  Ember shoots you quick looks, trying to hide " + getGame().emberScene.emberMF("his","her") + " smirk of success every time " + getGame().emberScene.emberMF("he","she") + " does.  You smirk right back at " + getGame().emberScene.emberMF("him","her") + ", and occasionally make a subtle show of your gravid form, just to see " + getGame().emberScene.emberMF("him","her") + " get turned on by the sight.";
						if (player.pregnancyIncubation == 170) {
							pregText = "You've grown a lot, anyone is able to tell that you're pregnant with a single glance.  ";
							//If Corruption < 40
							if (player.cor < 40) pregText += "Part of you didn't really want to get knocked up.  However, Ember's look of satisfaction whenever " + getGame().emberScene.emberMF("he","she") + " gazes your way is rewarding despite that.  Plus, it is for a good cause.  You smirk in satisfaction - with a couple of dragons at your beck and call, things will look very different indeed.";
							//If Corruption >= 40
							else if (player.cor < 75) pregText += "You grin, savoring the strange, erotic sensations from the life inside your burgeoning womb and the promise of motherhood.  Mmm, if it feels this good, maybe you should \"<i>encourage</i>\" Ember to get you pregnant again.";
							else pregText += "You think dreamily about the wild sex that helped conceive this little one.  Ember is such a great fuck. Really, you're doing this world a favor by bringing more of Ember's offspring into it.";
						}
						if (player.pregnancyIncubation == 120) {
							pregText = "Every once in awhile, you feel a kick from inside your bulging belly.  Right now, it's really kicking up a storm, and so you decide to sit down and take it easy.  You keep rubbing your belly, hoping to calm your child down and make it stop battering your innards.";
							pregText += "\n\nEmber approaches you, and casually asks, \"<i>So... is it kicking already?</i>\"";
							pregText += "\n\nYou admit that it is, stroking your stomach.  Casually, you ask if Ember would maybe like to touch your belly, wondering if " + getGame().emberScene.emberMF("he","she") + " will be able to bring " + getGame().emberScene.emberMF("him","her") + "self to do it.";
							pregText += "\n\n\"<i>Yes! Of course!</i>\" Ember replies";
							if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) pregText += ", blush at " + getGame().emberScene.emberMF("his","her") + " own over-enthusiastic reply";
							pregText += ".  You just smile encouragingly at the dragon " + getGame().emberScene.emberMF("-boy","herm") + " and lean back slightly, sticking out your gravid midriff in open encouragement to its " + getGame().emberScene.emberMF("father","mother") + " to try and connect with " + getGame().emberScene.emberMF("his","her") + " unborn child.";
							pregText += "\n\nEmber sets a clawed hand on your belly, careful not to hurt you with " + getGame().emberScene.emberMF("his","her") + " claws.  Slowly " + getGame().emberScene.emberMF("he","she") + " rubs your belly, until " + getGame().emberScene.emberMF("he","she") + " feels a small kick and smiles in glee.  You smile at the look of joy on " + getGame().emberScene.emberMF("his","her") + " face, even as " + getGame().emberScene.emberMF("he","she") + " realizes what " + getGame().emberScene.emberMF("he","she") + "'s doing and embarrassedly mumbles an excuse and walks away.";
						}
						if (player.pregnancyIncubation == 90) {
							pregText = "You stop for a moment and sit down on a nearby rock.  Your belly feels much heavier than usual, and just walking about has become a chore.  Ember takes notice of your tiredness and quickly closes the distance between you two.  \"<i>[name], are you feeling all right?</i>\"";
							pregText += "\n\nYou tell " + getGame().emberScene.emberMF("him","her") + " that you are, just worn out.  It's not easy carrying " + getGame().emberScene.emberMF("his","her") + " child, after all.";
							pregText += "\n\nEmber sighs in relief.  \"<i>Good, is there anything I can do for you?</i>\"";
							pregText += "\n\nYou tap your lips thoughtfully, mulling it over.  ";
							//(Low Corruption)
							if (player.cor <= 33) pregText += "There really isn't anything you feel like you need right now... maybe some water?  Or maybe you could have Ember help you to your " + camp.homeDesc() + " for a quick rest?";
							//(Medium Corruption)
							else if (player.cor <= 66) pregText += "You wonder if you should take advantage of Ember - you've certainly been feeling a little on edge lately, and besides " + getGame().emberScene.emberMF("he","she") + " did say 'anything'.  You ponder this for a while longer.";
							//High Corruptio
							else pregText += "You  already thought up a perfect way for this sexy dragon to help you, but it's best not to rush.  It's not everyday that Ember says " + getGame().emberScene.emberMF("he","she") + "'ll do 'anything' for you.  A quick jab on your belly from your unborn child makes you recoil a bit though.  Maybe it would be better to wait until this little one is out of you, just so you can have another.  You ponder what to ask of " + getGame().emberScene.emberMF("him","her") + " a while longer.";
							pregText += "\n\nFinally, you decide there really isn't anything Ember can help you with, and tell " + getGame().emberScene.emberMF("him","her") + " so.  Though " + getGame().emberScene.emberMF("he","she") + " had better be ready to do " + getGame().emberScene.emberMF("his","her") + " part when the baby is born and needs caring.";
							if (flags[kFLAGS.EMBER_GENDER] == 1 && flags[kFLAGS.EMBER_MILK] > 0) pregText += "  You can't resist smirking and patting one of your shemale dragon's bountiful breasts, noting that maybe you should let him do all the breast-feeding.";
							
							pregText += "\n\n";
							if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) pregText += "Ember blushes.  ";
							pregText += "\"<i>O-of course I'll do my part.  If you don't need me for anything, I'll be going then.</i>\" " + getGame().emberScene.emberMF("He","She") + " turns on " + getGame().emberScene.emberMF("his","her") + " heels and walks away.  You watch " + getGame().emberScene.emberMF("him","her") + " go, pat yourself on the stomach, then painstakingly hoist yourself back upright and go on your way.";
						}
						if (player.pregnancyIncubation == 60) {
							pregText = "Besides being so huge you'd probably be asked if you were having twins back in Ingnam, your belly has grown stupidly heavy, ";
							if (player.cor <= 33) pregText += "making you wonder more than ever if it really was a good idea to get pregnant with a dragon.  True, Ember looks ready to burst with pride at your fruitful bounty, but you feel ready to just plain burst yourself.";
							else if (player.cor <= 66) pregText += "and you wonder how much longer you have to wait.  Despite being a bit bothersome, you're pleased your child is growing into a healthy, hopefully sexy, dragon; like its father.";
							else pregText += "and you're eager to give birth, so you can get impregnated again.  Particularly because that means more rowdy fucking from Ember.";
						}
						if (player.pregnancyIncubation == 30) {
							pregText = "You rub your hands over your gloriously full, ripe belly, lost in the sensations of motherhood.  ";
							if (player.cor <= 33) pregText += "Despite your initial reluctance, you've come to find a very real pleasure in being pregnant.  You hope Ember will want to have more children in the future.";
							else if (player.cor <= 66) pregText += "You smile, knowing you'll meet your child in the next few days.  A part of you is almost sad that you'll be empty, but you can always entice Ember into getting you pregnant again.";
							else pregText += "You find yourself daydreaming about being the revered mother-queen of a huge army of dragons, visions of magnificent, sexy, scaly beasts sweeping across the land conquering it in your honor, offering up tribute to the ever-ripe womb that brought them forth; rolling around, as the musk of their fucking fills the air.  The image is so delicious you don't want to wake up from your fantasy.";
						}
					}
					if (pregText != "") {
						outputText("\n" + pregText + "\n");
						displayedUpdate = true;
					}
				}
				//Pregnancy 4 Satyrs
				if (player.pregnancyType == PregnancyStore.PREGNANCY_SATYR) {
					//Stage 1: 
					if (player.pregnancyIncubation == 150) {
						outputText("\n<b>You find that you're feeling quite sluggish these days; you just don't have as much energy as you used to.  You're also putting on weight.</b>\n");
						displayedUpdate = true;
					}
					//Stage 2: 
					if (player.pregnancyIncubation == 125) {
						outputText("\n<b>Your belly is getting bigger and bigger.  Maybe your recent urges are to blame for this development?</b>\n");
						displayedUpdate = true;
					}
					//Stage 3: 
					if (player.pregnancyIncubation == 100) {
						outputText("\n<b>You can feel the strangest fluttering sensations in your distended belly; it must be a pregnancy.  You should eat more and drink plenty of wine so your baby can grow properly.  Wait, wine...?</b>\n");
						displayedUpdate = true;
					}
					//Stage 4: 
					if (player.pregnancyIncubation == 75) {
						outputText("\n<b>Sometimes you feel a bump in your pregnant belly.  You wonder if it's your baby complaining about your moving about.</b>\n");
						displayedUpdate = true;
					}
					//Stage 5: 
					if (player.pregnancyIncubation == 50) {
						outputText("\n<b>With your bloating gut, you are loathe to exert yourself in any meaningful manner; you feel horny and hungry all the time...</b>\n");
						displayedUpdate = true;
						//temp min lust up +5
					}
					//Stage 6: 
					if (player.pregnancyIncubation == 30) {
						outputText("\n<b>The baby you're carrying constantly kicks your belly in demand for food and wine, and you feel sluggish and horny.  You can't wait to birth this little one so you can finally rest for a while.</b>\n");
						displayedUpdate = true;
						//temp min lust up addl +5
					}
				}
				//BASILISK Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_BASILISK || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT) {	
					if (player.pregnancyIncubation == 185) {
						outputText("\n<b>Your belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 160) {
						outputText("\n<b>Your belly looks a little pudgy", false);
						if (player.thickness > 60 && player.tone < 40) outputText(" even for you", false);
						outputText(", maybe you should cut back on all the food you've been consuming lately?</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 140) {
						outputText("\n<b>Your belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 110) {
						outputText("\n<b>Your belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.", false);
						if (player.cor < 50) outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.", false);
						outputText("</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
							displayedUpdate = true;
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
							displayedUpdate = true;
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
							displayedUpdate = true;
						}
					}
				}
				//Anemone Pregnancy
				if (player.pregnancyType == PregnancyStore.PREGNANCY_ANEMONE) {			
					if (player.pregnancyIncubation == 240) {
						outputText("\n<b>You feel something shifting and moving inside you.  You start to think you might be pregnant.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 210) {
						outputText("\n<b>The fluttering of sensation inside you is getting stronger and more frequent.  At times it even feels as if the inner lining of your womb is tingling.</b>\n", false);
						dynStats("lus", (5+player.lib/20));
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 185) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ", false);
						if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("Considering the possible fathers, you hope it isn't that big.</b>", false);
						if (player.cor >= 75) outputText("You think dreamily about the cocks that have recently been fucking you, and hope that your offspring inherit such a divine pleasure tool.</b>", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						outputText("\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 154) {
						outputText("\n<b>The sudden impact of a strong movement from inside your womb startles you.</b>\n", false);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your larger, squirming belly makes your pregnancy obvious for those around you", false);
						if (player.hasVagina()) outputText(" and keeps your " + player.vaginaDescript(0) + " aroused from the constant tingling in your womb", false);
						outputText(".</b>\n", false);
						dynStats("lus", (10+player.lib/20));
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>Your belly is noticeably distended, ", false);
						if (player.cor < 40) outputText("and constantly shifts and wriggles.  What manner of beast are you bringing into the world?</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.</b>", false);
						outputText("\n", false);
						dynStats("spe", -3, "lib", 1, "sen", 1, "lus", (5 + player.lib / 20));
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ", false);
						if (player.cor < 40) outputText("Afterwards you feel somewhat disgusted with yourself, but horny.</b>\n", false);
						if (player.cor >= 40 && player.cor < 75) outputText("You estimate you'll give birth in the next few days.  You hope the birth is as erotically charged as the pregnancy has been.</b>\n", false);
						if (player.cor >= 75) outputText("You find yourself daydreaming  about birthing cilia-covered worms, orgasming each time their thousands of stingers brush by your clit and fill it full of sensation-enhancing drugs.</b>\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", (10+player.lib/20));
						displayedUpdate = true;
					}
				}
				//Hellhound Pregnancy!
				if (player.pregnancyType == PregnancyStore.PREGNANCY_HELL_HOUND) {			
					if (player.pregnancyIncubation == 290) {
						outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 240) {
						outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n", false);
						displayedUpdate = true;	
					}
					if (player.pregnancyIncubation == 216) {
						outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ", false);
						if (player.cor < 40) outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>", false);
						if (player.cor >= 75) outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>", false);
						outputText("\n", false);
						dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 180) {
						outputText("\n<b>There is a strange heat within your belly, it makes you a little tired.</b>\n", false);
						dynStats("tou", -1);
						displayedUpdate = true;				
					}
					if (player.pregnancyIncubation == 120) {
						outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  With each day you can feel the heat within you growing.</b>\n", false);
						displayedUpdate = true;
						dynStats("tou", -1);
					}
					if (player.pregnancyIncubation == 72) {
						outputText("\n<b>The heat within doesn't drain you as much as it used to, instead giving you an odd strength.</b>", false);
						outputText("\n", false);
						dynStats("str", 1,"tou", 1);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 48) {
						outputText("\n<b>You can feel two large lumps pushing against your womb together ", false);
						if (player.cor < 40) outputText("making it difficult to function.</b>", false);
						if (player.cor >= 40 && player.cor < 75) outputText("and you wonder how much longer you have to wait.</b>", false);
						if (player.cor >= 75) outputText("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>", false);
						outputText("\n", false);
						dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 32 || player.pregnancyIncubation == 64 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
				//Frog Eggs
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
					if (player.pregnancyIncubation == 8) {
						//Egg Maturing
						if (player.hasVagina()) {
							outputText("\nYour gut churns, and with a squelching noise, a torrent of transparent slime gushes from your [vagina].  You immediately fall to your knees, landing wetly amidst the slime.  The world around briefly flashes with unbelievable colors, and you hear someone giggling.\n\nAfter a moment, you realize that it’s you.");
							//pussy:
							if (player.hasVagina()) outputText("  Against your [vagina], the slime feels warm and cold at the same time, coaxing delightful tremors from your [clit].");
							//[balls:
							else if (player.balls > 0) outputText("  Slathered in hallucinogenic frog slime, your balls tingle, sending warm pulses of pleasure all the way up into your brain.");
							//genderless: 
							else outputText("  Your [vagina] begins twitching, aching for something to push through it over and over again.");
							outputText("  Seated in your own slime, you moan softly, unable to keep your hands off yourself.");
							dynStats("lus=", player.maxLust(), "resisted", false);
							displayedUpdate = true;
						}
						else {
							outputText("\nYour gut churns, but after a moment it settles. Your belly does seem a bit bigger and more gravid afterward, like you're filling up with fluid without any possible vent. You suddenly wonder if losing your pussy was such a great idea.");
							displayedUpdate = true;
						}
					}
				}
				//Minerva Pregnancy
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA) {
					if (player.pregnancyIncubation == 216) {
						outputText("<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 144) {
						outputText("<b>Your distended belly shows obvious signs of pregnancy.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 72) {
						outputText("<b>Your belly is getting larger.  You feel like you're housing a twin.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 24) {
						outputText("<b>Your belly is as big as it can get.  You have a feeling that you'll give birth to a twin soon.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 144 || player.pregnancyIncubation == 72 || player.pregnancyIncubation == 85 || player.pregnancyIncubation == 150) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
				//Behemoth Pregnancy
				else if (player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) {
					if (player.pregnancyIncubation == 1152) {
						outputText("<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.  However, you have a feel that it's going to be a very long pregnancy.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 864) {
						outputText("<b>Your distended belly shows obvious signs of pregnancy.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 576) {
						outputText("<b>Your belly is getting larger.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 288) {
						outputText("<b>Your belly is as big as it can get.  You have a feeling that you'll give birth to a behemoth soon.</b>");
						displayedUpdate = true;
					}
					if (player.pregnancyIncubation == 1024 || player.pregnancyIncubation == 768 || player.pregnancyIncubation == 512 || player.pregnancyIncubation == 256) {
						//Increase lactation!
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
							outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n", false);
							player.boostLactation(.5);
						}
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
							outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n", false);
							player.boostLactation(.5);
						}				
						//Lactate if large && not lactating
						if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
							outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n", false);
							player.boostLactation(1);
						}
						//Enlarge if too small for lactation
						if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
						//Enlarge if really small!
						if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
							outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n", false);
							player.growTits(1, 1, false, 3);
						}
					}
				}
			}
			//IF INCUBATION IS ANAL
			if (player.buttPregnancyIncubation > 1) {
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
					if (player.buttPregnancyIncubation == 8) {
						//Egg Maturing
						outputText("\nYour gut churns, and with a squelching noise, a torrent of transparent slime gushes from your ass.  You immediately fall to your knees, landing wetly amidst the slime.  The world around briefly flashes with unbelievable colors, and you hear someone giggling.\n\nAfter a moment, you realize that it’s you.");
						//pussy:
						if (player.hasVagina()) outputText("  Against your [vagina], the slime feels warm and cold at the same time, coaxing delightful tremors from your [clit].");
						//[balls:
						else if (player.balls > 0) outputText("  Slathered in hallucinogenic frog slime, your balls tingle, sending warm pulses of pleasure all the way up into your brain.");
						//[cock:
						else if (player.hasCock()) outputText("  Splashing against the underside of your " + player.multiCockDescriptLight() + ", the slime leaves a warm, oozy sensation that makes you just want to rub [eachCock] over and over and over again.");
						//genderless: 
						else outputText("  Your asshole begins twitching, aching for something to push through it over and over again.");
						outputText("  Seated in your own slime, you moan softly, unable to keep your hands off yourself.");
						dynStats("lus=", player.maxLust(), "resisted", false);
						displayedUpdate = true;
					}
				}
				//Pregnancy 4 Satyrs
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) {
					//Stage 1: 
					if (player.buttPregnancyIncubation == 150) {
						outputText("\n<b>You find that you're feeling quite sluggish these days; you just don't have as much energy as you used to.  You're also putting on weight.</b>\n");
						displayedUpdate = true;
					}
					//Stage 2: 
					if (player.buttPregnancyIncubation == 125) {
						outputText("\n<b>Your belly is getting bigger and bigger.  Maybe your recent urges are to blame for this development?</b>\n");
						displayedUpdate = true;
					}
					//Stage 3: 
					if (player.buttPregnancyIncubation == 100) {
						outputText("\n<b>You can feel the strangest fluttering sensations in your distended belly; it must be a pregnancy.  You should eat more and drink plenty of wine so your baby can grow properly.  Wait, wine...?</b>\n");
						displayedUpdate = true;
					}
					//Stage 4: 
					if (player.buttPregnancyIncubation == 75) {
						outputText("\n<b>Sometimes you feel a bump in your pregnant belly.  You wonder if it's your baby complaining about your moving about.</b>\n");
						displayedUpdate = true;
					}
					//Stage 5: 
					if (player.buttPregnancyIncubation == 50) {
						outputText("\n<b>With your bloating gut, you are loathe to exert yourself in any meaningful manner; you feel horny and hungry all the time...</b>\n");
						displayedUpdate = true;
						//temp min lust up +5
					}
					//Stage 6: 
					if (player.buttPregnancyIncubation == 30) {
						outputText("\n<b>The baby you're carrying constantly kicks your belly in demand for food and wine, and you feel sluggish and horny.  You can't wait to birth this little one so you can finally rest for a while.</b>\n");
						displayedUpdate = true;
						//temp min lust up addl +5
					}
				}
				//DRIDAH BUTT Pregnancy!
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) {	
					if (player.buttPregnancyIncubation == 199) {
						outputText("\n<b>After your session with the drider, you feel so nice and... full.  There is no outward change on your body, aside from the egg-packed bulge of your belly, but your " + player.assholeDescript() + " tingles slightly and leaks green goop from time to time. Hopefully it's nothing to be alarmed about.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 180) {
						outputText("\n<b>A hot flush works its way through you, and visions of aroused driders quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and packed completely full of eggs, stuffing your belly completely with burgeoning spheres of love.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?</b>\n", false);
						dynStats("lib", 1, "sen", 1, "lus", 20);
						displayedUpdate = true;				
					}
					if (player.buttPregnancyIncubation == 120) {
						outputText("\n<b>Your belly is bulging from the size of the eggs growing inside you and gurgling just about any time you walk.  Green goo runs down your " + player.legs() + " frequently, drooling out of your pregnant asshole.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 72) {
						outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.", false);
						outputText("</b>\n", false);
						displayedUpdate = true;
					}
				}
				//Bee Egg's in butt pregnancy
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BEE_EGGS) {
					if (player.buttPregnancyIncubation == 36) {
						outputText("<b>\nYou feel bloated, your bowels shifting uncomfortably from time to time.</b>\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 20) {
						outputText("<b>\nA honey-scented fluid drips from your rectum.</b>  At first it worries you, but as the smell fills the air around you, you realize anything with such a beautiful scent must be good.  ", false);
						if (player.cockTotal() > 0) outputText("The aroma seems to permeate your very being, slowly congregating in your ", false);
						if (player.cockTotal() == 1) {
							outputText(player.cockDescript(0), false);
							if (player.countCocksOfType(CockTypesEnum.HORSE) == 1) outputText(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your " + player.cockDescript(0) + " is twitching and dripping, the flare swollen and purple.  ", false);
							if (player.dogCocks() == 1) outputText(", each inhalation making it thicker, harder, and firmer.  You suck in huge lungfuls of air, desperate for more, until your " + player.cockDescript(0) + " is twitching and dripping, its knot swollen to the max.  ", false);
							if (player.countCocksOfType(CockTypesEnum.HUMAN) == 1) outputText(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your " + player.cockDescript(0) + " is twitching and dripping, the head swollen and purple.  ", false);
							//FAILSAFE FOR NEW COCKS
							if (player.countCocksOfType(CockTypesEnum.HUMAN) == 0 && player.dogCocks() == 0 && player.countCocksOfType(CockTypesEnum.HORSE) == 0) outputText(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air until your " + player.cockDescript(0) + " is twitching and dripping.  ", false);
						}
						if (player.cockTotal() > 1) outputText("groin.  Your " + player.multiCockDescriptLight() + " fill and grow with every lungful of the stuff you breathe in.  You suck in great lungfuls of the tainted air, desperate for more, your cocks twitching and dripping with need.  ", false);
						outputText("You smile knowing you couldn't stop from masturbating if you wanted to.\n", false);
						dynStats("int", -.5, "lus", 500);
						displayedUpdate = true;
					}
				}
				//Sand Tarps in butt pregnancy
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP || player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) {
					if (player.buttPregnancyIncubation == 36) {
						//(Eggs take 2-3 days to lay)
						outputText("<b>\nYour bowels make a strange gurgling noise and shift uneasily.  You feel ");
						if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) outputText(" bloated and full; the sensation isn't entirely unpleasant.");
						else {
							outputText("increasingly empty, as though some obstructions inside you were being broken down.");
							player.buttKnockUpForce(); //Clear Butt Pregnancy
						}
						outputText("</b>\n");
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 20) {
						//end eggpreg here if unfertilized
						outputText("\nSomething oily drips from your sphincter, staining the ground.  You suppose you should feel worried about this, but the overriding emotion which simmers in your gut is one of sensual, yielding calm.  The pressure in your bowels which has been building over the last few days feels right somehow, and the fact that your back passage is dribbling lubricant makes you incredibly, perversely hot.  As you stand there and savor the wet, soothing sensation a fantasy pushes itself into your mind, one of being on your hands and knees and letting any number of beings use your ass, of being bred over and over by beautiful, irrepressible insect creatures.  With some effort you suppress these alien emotions and carry on, trying to ignore the oil which occasionally beads out of your " + player.assholeDescript() + " and stains your [armor].\n");
						dynStats("int", -.5, "lus", 500);
						displayedUpdate = true;
					}
				}
				//Bunny TF buttpreggoz
				if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
					if (player.buttPregnancyIncubation == 800) {
						outputText("\nYour gut gurgles strangely.\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 785) {
						getGame().mutations.neonPinkEgg(true,player);
						outputText("\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 776) {
						outputText("\nYour gut feels full and bloated.\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 765) {
						getGame().mutations.neonPinkEgg(true,player);
						outputText("\n", false);
						displayedUpdate = true;
					}
					if (player.buttPregnancyIncubation == 745) {
						outputText("\n<b>After dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your ass have dissolved.</b>\n", false);
						displayedUpdate = true;
						player.buttKnockUpForce(); //Clear Butt Pregnancy
					}
				}
			}
			//Give birth to either a faerie or a phouka
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) {
					getGame().bog.phoukaScene.phoukaPregBirth();
					displayedUpdate = true;
					player.knockUpForce(); //Clear Pregnancy
				}
			//Give birf if its time... to ANAL EGGS
			if (player.buttPregnancyIncubation == 1 && player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
				getGame().bog.frogGirlScene.birthFrogEggsAnal();
				displayedUpdate = true;
				player.buttKnockUpForce(); //Clear Butt Pregnancy
			}
			//Give birf if its time... to ANAL EGGS
			if (player.buttPregnancyIncubation == 1 && player.buttPregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) {
				getGame().swamp.corruptedDriderScene.birthSpiderEggsFromAnusITSBLEEDINGYAYYYYY();
				displayedUpdate = true;
				player.buttKnockUpForce(); //Clear Butt Pregnancy
			}
			//Bive birf to dragons
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_EMBER) {
				getGame().emberScene.giveBirthToEmberKids();
				displayedUpdate = true;
				player.knockUpForce(); //Clear Pregnancy
			}
			//GIVE BIRF TO TRAPS
			if (player.buttPregnancyIncubation == 1 && player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) {
				getGame().desert.sandTrapScene.birfSandTarps();
				player.buttKnockUpForce(); //Clear Butt Pregnancy
				if (player.buttRating < 17) {
					//Guaranteed increase up to level 10
					if (player.buttRating < 13) {
						player.buttRating++;
						outputText("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.\n", false);
					}
					//Big butts only increase 50% of the time.
					else if (rand(2) == 0){
						player.buttRating++;
						outputText("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.\n", false);				
					}
				}
				displayedUpdate = true;
			}	
			//Give birth (if it's time) to beeeeeeez
			if (player.buttPregnancyIncubation == 1 && player.buttPregnancyType == PregnancyStore.PREGNANCY_BEE_EGGS) {
				outputText("\n", false);
				outputText("There is a sudden gush of honey-colored fluids from your ass.  Before panic can set in, a wonderful scent overtakes you, making everything ok.  ", false);
				if (player.cockTotal() > 0) outputText("The muzzy feeling that fills your head seems to seep downwards, making your equipment hard and tight.  ", false);
				if (player.vaginas.length > 0) outputText("Your " + player.vaginaDescript(0) + " becomes engorged and sensitive.  ", false);
				outputText("Your hand darts down to the amber, scooping up a handful of the sticky stuff.  You wonder what your hand is doing as it brings it up to your mouth, which instinctively opens.  You shudder in revulsion as you swallow the sweet-tasting stuff, your mind briefly wondering why it would do that.  The stuff seems to radiate warmth, quickly pushing those nagging thoughts away as you scoop up more.\n\n", false);
				outputText("A sudden slip from below surprises you; a white sphere escapes from your anus along with another squirt of honey.  Your drugged brain tries to understand what's happening, but it gives up, your hands idly slathering honey over your loins.  The next orb pops out moments later, forcing a startled moan from your mouth.  That felt GOOD.  You begin masturbating to the thought of laying more eggs... yes, that's what those are.  You nearly cum as egg number three squeezes out.  ", false);
				if (player.averageLactation() >= 1 && player.biggestTitSize() > 2) outputText("Seeking even greater sensation, your hands gather the honey and massage it into your " + player.breastDescript(0) + ", slowly working up to your nipples.  Milk immediately begins pouring out from the attention, flooding your chest with warmth.  ", false);
				outputText("Each egg seems to come out closer on the heels of the one before, and each time your conscious mind loses more of its ability to do anything but masturbate and wallow in honey.\n\n", false);
				outputText("Some time later, your mind begins to return, brought to wakefulness by an incredibly loud buzzing...  You sit up and see a pile of dozens of eggs resting in a puddle of sticky honey.  Most are empty, but a few have hundreds of honey-bees emptying from them, joining the massive swarms above you.  ", false);
				if (player.cor < 35) outputText("You are disgusted, but glad you were not stung during the ordeal.  You stagger away and find a brook to wash out your mouth with.", false);
				if (player.cor >= 35 && player.cor < 65) outputText("You are amazed you could lay so many eggs, and while the act was strange there was something definitely arousing about it.", false);
				if (player.cor >= 65 && player.cor < 90) outputText("You stretch languidly, noting that most of the drugged honey is gone.  Maybe you can find the Bee again and remember to bottle it next time.", false);
				if (player.cor >= 90) outputText("You lick your lips, savoring the honeyed residue on them as you admire your thousands of children.  If only every night could be like this...\n", false);
				player.buttKnockUpForce(); //Clear Butt Pregnancy
				player.orgasm();
				dynStats("int", 1, "lib", 4, "sen", 3);
				if (player.buttChange(20, true)) outputText("\n", false);
				if (player.buttRating < 17) {
					//Guaranteed increase up to level 10
					if (player.buttRating < 13) {
						player.buttRating++;
						outputText("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
					}
					//Big butts only increase 50% of the time.
					else if (rand(2) == 0){
						player.buttRating++;
						outputText("\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);				
					}
				}
				outputText("\n", false);
				displayedUpdate = true;
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA && player.pregnancyIncubation == 1) {
				displayedUpdate = true;
				getGame().urtaPregs.PCGivesBirf();
				player.knockUpForce(); //Clear Pregnancy
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_SAND_WITCH && player.pregnancyIncubation == 1) {
				displayedUpdate = true;
				getGame().dungeons.desertcave.birthAWitch();
				player.knockUpForce(); //Clear Pregnancy
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA && player.pregnancyIncubation == 1) {
				displayedUpdate = true;
				//Located in izma.as!
				getGame().izmaScene.pcPopsOutASharkTot();
				player.knockUpForce(); //Clear Pregnancy
			}
			//SPOIDAH BIRF
			if (player.pregnancyType == PregnancyStore.PREGNANCY_SPIDER && player.pregnancyIncubation == 1) {
				player.knockUpForce(); //Clear Pregnancy
				displayedUpdate = true;
				getGame().swamp.maleSpiderMorphScene.spiderPregVagBirth();
			}
			//DRIDER BIRF
			if (player.pregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS && player.pregnancyIncubation == 1) {
				player.knockUpForce(); //Clear Pregnancy
				displayedUpdate = true;
				getGame().swamp.corruptedDriderScene.driderPregVagBirth();
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_COTTON && player.pregnancyIncubation == 1) {
				player.knockUpForce(); //Clear Pregnancy
				displayedUpdate = true;
				getGame().telAdre.cotton.birthingCottonsKids();
			}
			//GOO BIRF
			if (player.pregnancyType == PregnancyStore.PREGNANCY_GOO_GIRL && player.pregnancyIncubation == 1) {
				player.knockUpForce(); //Clear Pregnancy
				displayedUpdate = true;
				getGame().lake.gooGirlScene.gooPregVagBirth();
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_BASILISK && player.pregnancyIncubation == 1) {
				player.knockUpForce(); //Clear Pregnancy
				displayedUpdate = true;
				getGame().highMountains.basiliskScene.basiliskBirth();
			}
			//Satyr vag preg
			if (player.pregnancyType == PregnancyStore.PREGNANCY_SATYR && player.pregnancyIncubation == 1) {
				player.knockUpForce(); //Clear Pregnancy
				displayedUpdate = true;
				getGame().plains.satyrScene.satyrBirth(true);
			}
			//Satyr butt preg
			if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation == 1) {
				player.buttKnockUpForce(); //Clear Butt Pregnancy
				displayedUpdate = true;
				getGame().plains.satyrScene.satyrBirth(false);
			}
			if (player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT && player.pregnancyIncubation <= 2) {
				if (model.time.hours != 5 && model.time.hours != 6) {
					player.knockUpForce(player.pregnancyType, 3); //Make sure eggs are only birthed early in the morning
				}
				else {
					player.knockUpForce(); //Clear Pregnancy
					displayedUpdate = true;
					getGame().bazaar.benoit.popOutBenoitEggs();
				}
			}
			//Give birf if its time... to FROG EGGS
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
				getGame().bog.frogGirlScene.layFrogEggs();
				displayedUpdate = true;
				player.knockUpForce(); //Clear Pregnancy
			}
			//BASILISK BIRF
			//Bunbun birfs
			if (player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY && player.pregnancyIncubation == 1) {
				outputText("\n", false);
				displayedUpdate = true;
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ", false);
					player.createVagina();
					player.genderCheck();
				}
				outputText("A dangerous rumble comes from your womb, signaling that it's time to birth your body's cargo at last.  Your " + player.legs() + " wobble unsteadily as your strength ebbs with every gush that erupts  from your now-broken water until you collapse on your " + player.buttDescript() + ", grunting and groaning.  At first it goes slow – there's just a few small contractions that are more strange than anything else, rippling down your " + player.vaginaDescript(0) + " and squirting out more of your pregnancy's fluid.  All too soon the tempo kicks up, and you feel something starting to stretch you wider and wider.\n\n", false);
				
				outputText("You heave and push, instinctively driven to flex muscles you didn't even know you had to speed the super human labor you've entered into.  ", false);
				if (player.vaginalCapacity() < 60) outputText("It hurts a little as your cervix starts to stretch wide", false);
				else outputText("It actually feels kind of nice as your cervix is stretched wide", false);
				outputText(", but somehow your body accommodates the forced dilation without too much discomfort.  It's soon forgotten as you feel your " + player.vaginaDescript(0) + " pushed into a large sphere, stretched around the inhuman form of your child as it squirms and writhes inside you on its path to freedom.  You grunt and flex, watching with disbelief as a tiny, rabbit-eared form slides from your slick canal into the grass, the process leaving your " + player.chestDesc() + " heaving with unexpected pleasure.\n\n", false);
				
				outputText("The whole process starts over again – there's another one!  By now your well-stretched pussy is oozing both the birthing fluids and your own lubricants, and the second bunny-child slides down to bump into its sibling with ease.  You shake and shudder, groaning and spasming as you nearly cum from the stimulation, but in the end you're left panting and horny.  The two bunnies look like miniature people except for their ears, tails, and fuzzy legs.  Your children lick themselves clean before hopping up onto your " + player.chestDesc() + " and suckling your nipples for a while", false);
				if (player.lactationQ() > 500) outputText(", growing fat from all the milk", false);
				outputText(".  At last they finish, and with one last nuzzle, your strange bunny-children go hopping off, doubtless to find more of their own kind.\n\n", false);
				
				outputText("You sink into restful unconsciousness, marveling at how stretchy and sensitive your " + player.vaginaDescript(0) + " feels now.", false);
				player.cuntChange(60,true,true,false);
				player.boostLactation(.01);
				//Boost capacity
				if (player.vaginalCapacity() < 300) {
					if (player.findStatusEffect(StatusEffects.BonusVCapacity) < 0) player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
					player.addStatusValue(StatusEffects.BonusVCapacity, 1, 10);
				}
				player.knockUpForce(); //Clear Pregnancy
				player.orgasm();
				dynStats("lib", 1, "sen", 10, "cor", -2);
			}
			//Anemone birfs
			//Anemone Pregnancy
			if (player.pregnancyType == PregnancyStore.PREGNANCY_ANEMONE && player.pregnancyIncubation == 1) {
				outputText("\n", false);
				displayedUpdate = true;
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ", false);
					player.createVagina();
					player.genderCheck();
				}
				outputText("Your " + player.armorName + " feels damp around the groin and you reach down to check the area.  The  " + player.vaginaDescript(0) + " you feel is dilated and slick with unusual wetness; your water must have broken!\n\n", false);
				
				outputText("Hurriedly you strip off your gear and sit down with your back against a rock.  Focusing yourself, you attempt to prepare for labor; you try to remember your recent partners and worry about what kind of monstrous infant you might have to force out of your " + player.vaginaDescript(0) + ".  The first contraction comes and you push as hard as you can, to be rewarded with the feeling of something sliding out between your labia.  You attempt a few more pushes but nothing further seems forthcoming; curious, you look down at your crotch only to discover a blue stalk sticking proudly out of your vagina!\n\n", false);
				
				if (flags[kFLAGS.ANEMONE_KID] > 0) {
					outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + player.clitDescript() + "!   It writhes and slips out of your pain-wracked hands, leaving them tingling.  As you lie there, stunned, it begins to inch back toward your " + player.vaginaDescript(0)+ ".  Footfalls sound next to you, and a blue hand picks up the squirming, cilliated creature.  Kid A gives you a shy smile, then turns to her barrel.  A quick splash and a filled waterskin later, she heads toward the stream, toting your grub-like offspring.");
					player.cuntChange(20,true,true,false);
					outputText("\n\nExhausted by the birth but with a burden lifted from your mind, you slip into a grateful doze.");
					player.knockUpForce(); //Clear Pregnancy
					return true;
				}
				else if (player.countCocksOfType(CockTypesEnum.ANEMONE) > 0 && player.cor < 25 && flags[kFLAGS.ANEMONE_KID] == 0) {
					outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + player.clitDescript() + " makes you lock up and nearly takes away your consciousness, and with " + player.multiCockDescript() + " in the way, you can't get any leverage on the pull at all!  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + player.vaginaDescript(0)+ ".  Searching about weakly with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; shocked into sense, you look at the absurd creature.  You raise your arm to slap at it, but something stays your hand.  As if sensing your hesitation, it stands upright and holds itself at attention for inspection.  It would be easy to knock it away... and yet, the unprepossessing little thing looks so proud that you can't quite bring yourself to do so.");
					outputText("\n\nYou scoop the diminutive anemone up and look around for somewhere wet to put it.  The stream is too far, the lake doubly so; you'd never make it to either, as sick as you feel from yanking viciously on your clitoris.  Driven to last resorts, you lurch over to the water barrel in your camp and, wrenching the lid off, drop the blue stalk unceremoniously inside.  Exhausted by the shock and pain of the ordeal, you slump down beside the barrel and slip into a doze...");
					player.cuntChange(20,true,true,false);
					outputText("\n");
					player.createStatusEffect(StatusEffects.CampAnemoneTrigger,0,0,0,0);
					player.knockUpForce(); //Clear Pregnancy
					return true;
				}
				//[(if pc has 0-9 existing cocks)
				else if (player.cockTotal() < 10) {
					outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + player.clitDescript() + "!  The small anemone and you both lay there twitching, but it recovers its bearings first; through your haze of pain you watch it flexing its body, wedging the head under itself, and elevating the base.", false);
					player.cuntChange(20,true,true,false);
					
					outputText("\n\nBeset by a panic, you watch as the strange thing sets butt-end down on your pubic mound and adheres", false);
					//[(if cocks)
					if (player.cockTotal() > 0) outputText(" below your " + player.multiCockDescriptLight(), false);
					outputText(". A sharp pinch lances through the nerves in your groin and sends your hands to it reflexively.  This smaller pain, coupled with the adrenaline and dopamine that have finally chased the fog from your head, is enough to pull your thoughts into focus for another attempt to remove your strange, parasitic offspring.  You shift your grip and pull a few more times, but the thing doesn't budge.  The handling of it only serves to make the stalk thicken and become stiff; gradually you notice that you're feeling the sensation of your own pulling not from the skin at the point of attachment but from the stalk itself, and this realization is accompanied by the ring of tentacles opening and pulling back to reveal the crown of a penis!  <b>You have a new anemone-penis!</b>", false);
					//[(dick slot 1 exists)
					if (player.cockTotal() > 0) outputText("  The tentacles writhe around, rubbing against your " + player.multiCockDescriptLight(), false);
					//(doesn't exist)
					else outputText("  The tentacles curl inwards, rubbing on the head of your new blue pecker", false);
					player.createCock((4+rand(3)),1.2);
					player.cocks[player.cockTotal()-1].cockType = CockTypesEnum.ANEMONE;
					outputText(" and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress " + player.sMultiCockDesc() + " sensually, leaving behind a tingling trail of vibrant pleasure", false);
					//[(if no dick1 and no balls)
					if (player.totalCocks() == 1 && player.balls == 0) outputText("; you feel a pressure build below the shaft, near your asshole", false);
					outputText(".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ", false);
					if (player.cumQ() < 100) outputText("glob", false);
					else if (player.cumQ() < 500) outputText("squirt", false);
					else outputText("spray", false);
					outputText(" of semen shoots from your new penis and lands on your ", false);
					//[(if boobs)
					if (player.biggestTitSize() >= 1) outputText(player.allBreastsDescript() + " and ", false);
					outputText("stomach", false);
					//[(dick1 exists)
					if (player.cockTotal() > 1) outputText(", followed in short order by white squirts from " + player.sMultiCockDesc() + " remaining", false);
					outputText(".  Your " + player.vaginaDescript(0) + " quivers and pulses as well, adding ", false);
					if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) outputText("a trickle", false);
					else if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText("a squirt", false);
					else outputText("nearly a cupful of fluid", false);
					outputText(" from your female orgasm to the puddle on the ground below your ass.\n\n", false);
					//(gain 1 nemo-dick, reduce lust to min)]
					player.genderCheck();
					player.orgasm();
					dynStats("lib", 2, "sen", 5);
				}
				//[(if PC has 10 existing cocks) && no kid
				else {
					outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + player.clitDescript() + " makes you lock up and nearly takes away your consciousness, robbing your pull of force.  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + player.vaginaDescript(0)+ ".  Casting about with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; renewed, you slap at it, trying to knock the little creature away.  Several weak hits land on it, and, almost as if irritated, the tentacles seize on your labia and pull the stalk back toward your crotch and thence into your pussy.  Next you feel the thing shift and flatten itself against your insides, then a pinch on your vaginal walls where the little anemone presses on them.  This can't be good.");
					player.cuntChange(20,true,true,false);
								
					//OLD TXToutputText("The anemone writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back into your " + player.vaginaDescript(0)+ ".  As the tentacled crown brushes past your lips a venomous heat fills your crotch - you feel the thing shift and flatten itself against your insides, then a pinch on your vaginal walls where the little anemone was pressing on them.  This can't be good.\n\n", false);

					outputText("\n\nPush as you might, you can't get it to peek back out even the slightest bit.  What's worse, the heat isn't subsiding, as the tentacles are now lodged inside your pussy!  Prodding and pulling at your " + player.vaginaDescript(0) + " is only worsening the effect; " + player.sMultiCockDesc() + " and your clitoris harden as you attempt to retrieve your invader.  Your probes get weaker and weaker as your vagina spasms to each stroke of your insides; each time you touch the creature, the sensation is being transmitted right back to your nerves.  Eventually you push yourself to accidental orgasm; your " + player.vaginaDescript(0) + " quivers around your fingers and your " + player.multiCockDescriptLight() + " does the best ejaculation it can manage with hardly any warmup time and no direct stimulation.  Even after the orgasm ends, the tentacles continue to torment your groin.  <b>You are VERY horny with this thing inside you... though you can't reach it, maybe there's a way to crowd it out?</b>\n\n", false);
					//(reduce lust to min, increased minimum lust by 30 until halfway through PC's next pregnancy)]
					player.orgasm();
					dynStats("lib", 2, "sen", 5);
					if (player.findStatusEffect(StatusEffects.AnemoneArousal) < 0) player.createStatusEffect(StatusEffects.AnemoneArousal,0,0,0,0);
				}		
				player.knockUpForce(); //Clear Pregnancy
				outputText("Exhausted by the 'birth' and the climax, you slip into a doze.\n", false);
			}
			//Give birth if it's time (to an imp!)
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_IMP) {
				outputText("\n", false);
				//Add imp birth status - used to control frequency of night imp gangbag
				if (player.findStatusEffect(StatusEffects.BirthedImps) >= 0) player.addStatusValue(StatusEffects.BirthedImps,1,1);
				else player.createStatusEffect(StatusEffects.BirthedImps,1,0,0,0);
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.  ", false);
					player.createVagina();
					player.genderCheck();
				}		
				outputText("A sudden gush of fluids erupts from your vagina - your water just broke.  You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.  ", false);
				if (player.cor < 50) outputText("You rue the day you encountered that hateful imp.  ", false);
				outputText("The pain begins to subside as your delivery continues... replaced with a building sensation of pleasure.  Arousal spikes through you as the contractions intensify, and as you feel something pass you have a tiny orgasm.\n\nYet you feel more within you, and the contractions spike again, pushing you to orgasm as you pass something else.  It repeats, over and over, nearly a dozen times you birth and orgasm.  After an eternity of procreation and pleasure, you sense your ordeal is over and collapse, unconscious.", false);
				
				
				if (player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) player.vaginas[0].vaginalLooseness++;
				//50% chance
				if (player.vaginas[0].vaginalLooseness < VAGINA_LOOSENESS_GAPING_WIDE && rand(2) == 0) {
					player.vaginas[0].vaginalLooseness++;
					outputText("\n\n<b>Your cunt is painfully stretched from the ordeal, permanently enlarged.</b>", false);
				}
				
				player.knockUpForce(); //Clear Pregnancy
				outputText("\n\nWhen you wake you find a large number of tiny imp tracks... and a spattering of cum on your clothes and body.  They must be born fully-formed.", false);
				if (player.averageLactation() > 0 && player.averageLactation() < 5) {
					outputText("  Your breasts won't seem to stop dribbling milk, lactating more heavily than before.", false);
					player.boostLactation(.5);
				}
				//Lactate if large && not lactating
				if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.averageLactation() == 0) {
					outputText("  As you ponder the implications, <b>you realize your breasts have been slowly lactating</b>.  You wonder how much longer it will be before they stop.", false);
					player.boostLactation(1);
				}
				player.boostLactation(.01);
				//Enlarge if too small for lactation
				if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
					outputText("  <b>Your breasts have grown to C-cups!</b>", false);
					player.growTits(1, 1, false, 3);
				}
				//Enlarge if really small!
				if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
					outputText("  <b>Your breasts have grown to B-cups!</b>", false);
					player.growTits(1, 1, false, 3);
				}
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
				if (player.gender == 1) player.gender = 3;
				if (player.gender == 0) player.gender = 2;
				player.orgasm();
				dynStats("tou", -2, "spe", 2, "lib", 1, "sen", .5, "cor", 7);
				if (player.buttRating < 10 && rand(2) == 0) {
					player.buttRating++;
					outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
				}
				else if (player.hipRating < 10) {
					player.hipRating++;
					outputText("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
				}
				outputText("\n", false);
				displayedUpdate = true;
			}
			//Give birth if it's time (to a cowgirl!)
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_MARBLE) {
				if (prison.prisonLetter.deliverChildWhileInPrison()) return displayedUpdate;
				player.knockUpForce(); //Clear Pregnancy
				player.boostLactation(.01);
				if (player.vaginas.length == 0) {
					outputText("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold a vagina.\n", false);
					player.createVagina();
					player.genderCheck();
				}	
				//If you like terrible outcomes
				if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 100) {
					outputText("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble doesn't seem to be around right now, so you can do nothing but push.\n\n", false);

					outputText("You push and heave with all your might, little else going through your mind. You somehow register when the head comes out, and soon the shoulders along with the rest of the body follow.  You lean back and pant for a while before feeling a pair of hands grab a hold of you. They slowly and clumsily feel up your body before finding your " + player.chestDesc() + " and a mouth quickly closes down on a " + player.nippleDescript(0) + ".  You sigh softly, and drift off to sleep.", false);
					player.cuntChange(20,true,true,false);
					
					outputText("\n\nEventually you feel a hand on your face, and open your eyes to see Marble looking down at you.  \"<i>Sweetie, are you all right?  Why aren't you pregnant anymore?  Where is our child?</i>\" You stand up and look around.  There is no sign of the baby you were carrying; the child seems to have left after finishing its drink. You never even got to see its face...\n\n", false);
					
					outputText("Marble seems to understand what happened, but is really disappointed with you, \"<i>Sweetie, why couldn't you wait until after I'd finished the nursery...?</i>\"", false);
					//Increase PC's hips as per normal, add to birth counter
				}
				else {

					outputText("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble rushes over and sees that it's time for you to give birth, so she picks you up and supports you as you continue pushing the child out of your now-gaping " + player.vaginaDescript(0) + ".", false);
					//50% chance of it being a boy if Marble has been purified
					if (flags[kFLAGS.MARBLE_PURIFIED] > 0 && rand(2) == 0)
					//it's a boy!
					{
						outputText("\n\nFor the next few minutes, you can’t do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It’s a son of mine!</i>\" she tells you, but you can barely hear her due to the focus you’re putting into the task of bringing this child out.", false);
						outputText("\n\nYou give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you’ve pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small bull boy cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a boy that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when he came out.", false);
						outputText("\n\nShe helps you stand up and gives you the little boy to suckle for yourself.", false);
						outputText("\n\nYou put the child to your breast and let him drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It’s a really good feeling, isn’t it?</i>\"  You can’t help but nod in agreement.  After a minute the little boy has had enough and you put him into the nursery.", false);
					
						outputText("The little boy is already starting to look like he is a few years old; he’s trotting around on his little hoofs.", false);
						//Increase the size of the PC’s hips, as per normal for pregnancies, increase birth counter
						if (player.hipRating < 10) {
							player.hipRating++;
							outputText("After the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
						}
						if (flags[kFLAGS.MARBLE_BOYS] == 0)
						//has Marble had male kids before?
						{
							outputText("You notice that Marble seems to be deep in thought, and you ask her what is wrong.  She starts after a moment and says, \"<i>Oh sweetie, no, it's nothing really.  I just never thought that I'd actually be able to father a son is all.  The thought never occurred to me.", false);
						}
						//Add to marble-kids:
						flags[kFLAGS.MARBLE_KIDS]++;
						flags[kFLAGS.MARBLE_BOYS]++; //increase the number of male kids with Marble
					}
					else // end of new content
					//it's a girl!
					{
						player.cuntChange(20,true,true,false);
						outputText("\n\nFor the next few minutes, you can't do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It's a daughter of mine!</i>\" she tells you, but you can barely hear her due to the focus you're putting into the task of bringing this child out.\n\n", false);
						outputText("You give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you've pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small cowgirl cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a girl that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when she came out.\n\n", false);
						outputText("She helps you stand up and gives you the little girl to suckle for yourself.  ", false);
						if (player.statusEffectv4(StatusEffects.Marble) >= 20) {
							outputText("As the child contentedly drinks from your " + player.nippleDescript(0) + ", Marble tells you, \"<i>Sweetie, somehow I know that our kids won't have to worry about the addictive milk.  It will only make them healthy and strong.</i>\"  You nod at her and put the child into the nursery.  ", false);
						} 
						else {
							outputText("You put the child to your breast and let her drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It's a really good feeling, isn't it?</i>\"  You can't help but nod in agreement.  After a minute the little girl has had enough and you put her into the nursery.\n\n", false);
						}
						outputText("The little girl is already starting to look like she is a few years old; she's trotting around on her little hooves.", false);
						//Add to marble-kids:
						flags[kFLAGS.MARBLE_KIDS]++;
					}
					//Increase the size of the PC's hips, as per normal for pregnancies, increase birth counter
					if (player.hipRating < 10) {
						player.hipRating++;
						outputText("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
					}
				}
				outputText("\n", false);
				displayedUpdate = true;
			}
			//Give birth if it's time (to a minotaur!)
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_MINOTAUR) {
				if (player.vaginas.length == 0) {
					outputText("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n", false);
					player.createVagina();
					player.genderCheck();
				}
				player.boostLactation(.01);		
				//Main Text here
				outputText("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it bulges and shifts as another living being moves independently inside you. Instinctively, you spread your legs as you feel the creature press outward, parting your cervix.\n\nYou try to push with your vaginal muscles, but you feel the creature moving more of its own volition. Your lips part as a pair of black-furred hands grip your vulva and begin to spread them and pull. You cry out in agony as your hips are widened forcefully by the passing mass of the being exiting your womb. A bovine face appears, mercifully lacking in horns. Shoulders follow, muscles already rippling on the newborn's form. A thick barrel chest follows, narrow, masculine hips and powerful bovine legs and hooves.\n\nFinally the worst is over as the toddler-sized minotaur gets to his feet, apparently already able to stand and walk.  He clops around your legs and over to your upper body, and takes hold of one of your milk-swollen breasts. He wraps his bestial lips around your nipple and begins to suckle, relieving the pressure on the milk-swollen jug.\n\n", false);
				outputText("He suckles and suckles and suckles, leaving you to wonder just how much milk you were actually holding, but even as you wonder this, your eyes grow wide as the newborn minotaur begins to grow. He gains inches at a time, his horns starting to grow from his skull, his muscles rippling and thickening, his cock lengthening, his balls swelling. He reaches four feet tall, but keeps growing, soon then five feet tall, starting to resemble more and more the monster who sired him. Finally, he pulls off your breasts, and finishes his milk-inspired growth spurt at six feet tall, looking practically full grown. His one gesture of gratitude for being brought into the world is a slobbery lick at your cheek, then he turns and runs off towards the mountain, leaving you to recover from the ordeal.  You swiftly pass out.\n\n", false);
				player.knockUpForce(); //Clear Pregnancy
				if (player.averageLactation() > 0 && player.averageLactation() < 5) {
					outputText("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.", false);
					player.boostLactation(1);
				}
				player.cuntChange(120, true,true,false);
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
				if (player.gender == 1) player.gender = 3;
				if (player.gender == 0) player.gender = 2;
				player.orgasm();
				dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
				displayedUpdate = true;
				//Hip and butt increase
				if (player.buttRating < 12 && rand(2) == 0) {
					player.buttRating++;
					outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
				}
				else if (player.hipRating < 15) {
					player.hipRating++;
					outputText("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
				}
				player.knockUpForce(); //Clear Pregnancy
				outputText("\n", false);
				//326 Number of sons grown
				//327 Number of sons pending
				//328 growup countdown
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00327]++;
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] == 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] = 150;		
			}
			//Amily failsafe - converts PC with pure babies to mouse babies if Amily is corrupted
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) 
			{
				if (flags[kFLAGS.AMILY_FOLLOWER] == 2 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00170] > 0) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
			}
			//Amily failsafe - converts PC with pure babies to mouse babies if Amily is with Urta
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) 
			{
				if (flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
			}
			//Amily failsafe - converts PC with pure babies to mouse babies if PC is in prison.
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) 
			{
				if (prison.inPrison) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
			}
			//Give birth if it's time (to an AMILY BITCH mouse!)
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) {
				player.boostLactation(.01);
				outputText("\n", false);
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.  ", false);
					player.createVagina();
					player.genderCheck();
				}
				//FUCKING BIRTH SHIT HERE.
				getGame().amilyScene.pcBirthsAmilysKidsQuestVersion();
				player.cuntChange(60, true, true, false);
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
				player.orgasm();
				dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
				displayedUpdate = true;
				outputText("\n", false);
				player.knockUpForce(); //Clear Pregnancy
			}
			//Give birth if it's time (to a mouse!)
			if (player.pregnancyIncubation == 1 && (player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_JOJO)) {
				player.boostLactation(.01);
				outputText("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n\n", false);
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.  ", false);
					player.createVagina();
					player.genderCheck();
				}		

				//Main Text here
				if (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (getGame().monk < 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) && !prison.inPrison) {
					if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
						kGAMECLASS.joyScene.playerGivesBirthToJoyBabies();
						return true;
					}
					else kGAMECLASS.jojoScene.giveBirthToPureJojoBabies();
				}
				else {
					outputText("Pain shoots through you as they pull open your cervix forcefully. You grip the ground and pant and push as the pains of labor overwhelm you. You feel your hips being forceably widened by the collective mass of the creatures moving down your birth canal. You spread your legs wide, laying your head back with groans and cries of agony as little white figures begin to emerge from between the lips of your abused pussy. Large innocent eyes, even larger ears, cute little muzzles, long slender pink tails all appear as the figures emerge. Each could be no larger than six inches tall, but they seem as active and curious as if they were already developed children. \n\n", false);
					outputText("Two emerge, then four, eight... you lose track. They swarm your body, scrambling for your chest, and take turns suckling at your nipples. Milk does their bodies good, making them grow rapidly, defining their genders as the girls grow cute little breasts and get broader hips and the boys develop their little mouse cocks and feel their balls swell. Each stops suckling when they reach two feet tall, and once every last one of them has departed your sore, abused cunt and drunk their fill of your milk, they give you a few grateful nuzzles, then run off towards the forest, leaving you alone to recover.\n", false);
				}
				player.knockUpForce(); //Clear Pregnancy
				if (player.averageLactation() > 0 && player.averageLactation() < 5) {
					outputText("Your [chest] won't seem to stop dribbling milk, lactating more heavily than before.", false);
					player.boostLactation(.5);
				}
				player.cuntChange(60, true,true,false);
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
				if (player.gender == 1) player.gender = 3;
				if (player.gender == 0) player.gender = 2;
				player.orgasm();
				dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
				displayedUpdate = true;
				//Butt increase
				if (player.buttRating < 14 && rand(2) == 0) {
					if (player.buttRating < 10) {
						player.buttRating++;
						outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);				
					}
					//Big butts grow slower!
					else if (player.buttRating < 14 && rand(2) == 0) {
						player.buttRating++;
						outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
					}
				}
				outputText("\n", false);
			}
			//Centaur Baby!
			if (player.pregnancyIncubation == 1 && (player.pregnancyType == PregnancyStore.PREGNANCY_CENTAUR || player.pregnancyType == PregnancyStore.PREGNANCY_KELT)) {
				outputText("\nYou blink, feeling a sudden ache of need radiating from your massive stomach. You can't even get off the ground, it is so heavy... you simply lie on your side, panting with desire, as the convulsions start. New life moves beneath your stomach, ready to be born, and it is time to do your part.\n\n", false);
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.  ", false);
					player.createVagina();
					player.genderCheck();
				}		
				//Main Text here
				player.boostLactation(.01);
				outputText("Perhaps strangely, there is no pain, just a steady, rhythmic compulsion that directs you to breathe steadily and spread your legs as wide as possible. You hardly have to push at all, as the child - no, your child, begins pressing against the walls of your womb, searching for escape. It finds it, and begins the arduous task of squeezing through your cervix, making you gasp with barely concealed pleasure.  It doesn't even hurt; there's only a dull little whisper of happiness followed by a tide of satisfaction.\n\n", false);
				outputText("The head comes first, and your first thought is relief as you see the face of a small, elfin child.  She's slick with afterbirth and pushing her way free. But the greater part is to come.  She pulls her body free, easily twice as large as her human torso. Soft downy fur with long, spindly legs and a bristly tail... she is a centaur! You help as best as you can, proud of your achievement, but are too exhausted by the ordeal. Your newfound daughter does most of the work.\n\n", false);
				outputText("She cannot stand, at first, and stumbles over her own shaky legs in a cute, innocent way. She appears to be a six-year old girl, stuck on top of the body of a young foal, and your heart goes out to her involuntarily. She manages to stand at last, wobbling uncertainly, and moves immediately towards your prone form. Knowing her needs, you reveal a breast to her, and she nickers affectionately before latching on, drinking hungrily from your heavily lactating teat.\n\n", false);
				outputText("She drinks endlessly, and seems more alive and stronger with every gulp. Hours pass in quiet, motherly bliss as she drains your breastmilk first from one breast, then the other. Her little stomach bulges slightly, but she does not stop, and you do not want her to. Even with the strange, soothing effect of the pregnancy wearing off, you feel nothing but affection for this child.\n\n", false);
				outputText("By the time she is finished, the centaur girl is obviously stronger, able to stand and move about on her own. She explores her new body, jumping and prancing happily, while you lay back and watch, too exhausted to join her. Suddenly, though, her ears perk up, as she looks towards the horizon urgently. She hesitates just long enough to plant a sweet kiss on your cheek, then dashes off, smiling broadly. Exhausted, you are unable to follow... but that comforting sensation returns.  Somehow, you sense she will be all right.", false);
				player.knockUpForce(); //Clear Pregnancy
				if (player.averageLactation() > 0 && player.averageLactation() < 5) {
					outputText("  Your " + player.allBreastsDescript() + " won't seem to stop dribbling milk, lactating more heavily than before.", false);
					player.boostLactation(.5);
				}
				outputText("  ", false);
				player.cuntChange(100, true);
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
				if (player.gender == 1) player.gender = 3;
				if (player.gender == 0) player.gender = 2;
				player.orgasm();
				dynStats("str", -1,"tou", -4, "spe", 2, "lib", 1, "sen", .5);
				displayedUpdate = true;
				//Butt increase
				if (player.buttRating < 14 && rand(2) == 0) {
					if (player.buttRating < 10) {
						player.buttRating++;
						outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);				
					}
					//Big butts grow slower!
					else if (player.buttRating < 14 && rand(2) == 0) {
						player.buttRating++;
						outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
					}
				}
				player.knockUpForce(); //Clear Pregnancy
				outputText("\n", false);
			}
			//Give birth if it's time (to a hellhound!)
			if (player.pregnancyIncubation == 1 && player.pregnancyType == PregnancyStore.PREGNANCY_HELL_HOUND) {
				outputText("\nYou are suddenly awoken by the heat inside your womb suddenly flaring up rather intensely.  It gives you a sudden charge of energy and you feel a strong need to stand up.  You can feel the two heads moving inside of you and you know that a hellhound will soon be born.  Guided by your instincts, you spread your legs and squat down, but wonder how exactly you are going to pass a creature with two heads?\n\n", false);
				if (player.vaginas.length == 0) {
					outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n\n", false);
					player.createVagina();
					player.genderCheck();
				}		
				outputText("Hearing a hiss, you look down to see drops of water hitting the ground and instantly turning to steam.  There is unnatural heat filling you, it's hot enough to boil water; but thanks to the creature inside you, you're barely feeling a thing!  More energy fills you and you begin to push down on the child within in earnest.  The process is painful, but satisfying; you feel like you could push out a mountain with the energy you have right now.  Within a minute, you can feel the heads emerge.  The heads are quickly followed by the rest of the body and you catch your hellhound child in your hands and lift it up to look at it.\n\n", false);
				outputText("You can see the distinctive dog heads are wrapped around each other and yipping softly; a hint of flame can sometimes be seen inside their mouths.  Its cute paws are waving in the air looking for purchase, but the rest of its body looks entirely human except for the double dicks, and it even has your skin color.  Its mouths are aching for nutrition, and you realize that your breasts are filled with what this pup needs and pull it to your chest.  Each head quickly finds a nipple and begins to suckle.  Having finished the birthing, you contentedly sit back down and bask in the feeling of giving milk to your child, or is it children?\n\n", false);
				outputText("You sit there in a state of euphoria for some time.  It's not until the child in front of you starts to become uncomfortably hot and heavy, that you are brought back to reality.  You look down to see that the hellhound pup has grown to three times its original size and even sprouted the distinctive layer of tough black fur.  The beast is licking contentedly at your breasts instead of sucking.  It was the now-full flames in its mouth that had broken your reverie, but before you get a real grasp of what had happened, the hellhound pulls away from you and gives you a few quick happy barks before turning around and running off into the wilds, dropping down onto four legs just before disappearing from view.  You feel the unnatural strength you gained during the birth fade away, and you fall into a deep contented sleep.\n\n", false);
				player.boostLactation(.01);
				//Main Text here
				player.knockUpForce(); //Clear Pregnancy
				if (player.averageLactation() > 0 && player.averageLactation() < 5) {
					outputText("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.  ", false);
					player.boostLactation(.5);
				}
				player.cuntChange(60, true);
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) player.vaginas[0].vaginalWetness++;
				if (player.gender == 1) player.gender = 3;
				if (player.gender == 0) player.gender = 2;
				player.orgasm();
				dynStats("str", -1,"tou", -1, "spe", 2, "lib", 1, "sen", .5);
				displayedUpdate = true;
				//Butt increase
				if (player.buttRating < 14 && rand(2) == 0) {
					if (player.buttRating < 10) {
						player.buttRating++;
						outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);				
					}
					//Big butts grow slower!
					else if (player.buttRating < 14 && rand(2) == 0) {
						player.buttRating++;
						outputText("\n\nYou notice your " + player.buttDescript() + " feeling larger and plumper after the ordeal.", false);
					}
				}
				outputText("\n", false);
			}
			//Give birth to sirens.
			if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA && player.pregnancyIncubation == 1) {
				if (prison.prisonLetter.deliverChildWhileInPrison()) return displayedUpdate;
				if (player.vaginas.length == 0) {
					outputText("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n", false);
					player.createVagina();
					player.genderCheck();
				}
				kGAMECLASS.highMountains.minervaScene.minervaPurification.playerGivesBirth();
				if (player.hipRating < 10) {
					player.hipRating++;
					outputText("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
				}
				player.knockUpForce(); //Clear Pregnancy
				outputText("\n", false);
			}
			//Give birth to behemoth.
			if (player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH && player.pregnancyIncubation == 1) {
				if (prison.prisonLetter.deliverChildWhileInPrison()) return displayedUpdate;
				if (player.vaginas.length == 0) {
					outputText("\nYou feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n", false);
					player.createVagina();
					player.genderCheck();
				}
				kGAMECLASS.volcanicCrag.behemothScene.giveBirthToBehemoth();
				if (player.hipRating < 10) {
					player.hipRating++;
					outputText("\n\nAfter the birth your " + player.armorName + " fits a bit more snugly about your " + player.hipDescript() + ".", false);
				}
				player.knockUpForce(); //Clear Pregnancy
				outputText("\n", false);
			}
			//Egg status messages
			if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS && player.pregnancyIncubation > 0) {
				if (player.vaginas.length == 0) {
					player.removeStatusEffect(StatusEffects.Eggs);
					outputText("\n<b>Your pregnant belly suddenly begins shrinking, until it disappears.</b>\n", false);
					player.knockUpForce(); //Clear Pregnancy
					displayedUpdate = true;
				}			
				//Birth scenes
				if (player.pregnancyIncubation == 1) {
					outputText("\n", false);
					if (player.vaginas.length == 0) {
						outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  <b>You look down and behold a new vagina</b>.\n\n", false);
						player.createVagina();
						player.genderCheck();
					}		
					//Small egg scenes
					if (player.statusEffectv2(StatusEffects.Eggs) == 0) {
						//light quantity
						if (player.statusEffectv3(StatusEffects.Eggs) < 10) {
							outputText("You are interrupted as you find yourself overtaken by an uncontrollable urge to undress and squat.   You berate yourself for giving in to the urge for a moment before feeling something shift.  You hear the splash of fluid on the ground and look down to see a thick greenish fluid puddling underneath you.  There is no time to ponder this development as a rounded object passes down your birth canal, spreading your feminine lips apart and forcing a blush to your cheeks.  It plops into the puddle with a splash, and you find yourself feeling visibly delighted to be laying such healthy eggs.   Another egg works its way down and you realize the process is turning you on more and more.   In total you lay ", false);
							outputText(eggDescript(), false); 
							outputText(", driving yourself to the very edge of orgasm.", false);
							dynStats("lus=", player.maxLust(), "resisted", false);
						}
						//High quantity
						else {
							outputText("A strange desire overwhelms your sensibilities, forcing you to shed your " + player.armorName + " and drop to your hands and knees.   You manage to roll over and prop yourself up against a smooth rock, looking down over your pregnant-looking belly as green fluids leak from you, soaking into the ground.   A powerful contraction rips through you and your legs spread instinctively, opening your " + player.vaginaDescript(0) + " to better deposit your precious cargo.   You see the rounded surface of an egg peek through your lips, mottled with strange colors.   You push hard and it drops free with an abrupt violent motion.  The friction and slimy fluids begin to arouse you, flooding your groin with heat as you feel the second egg pushing down.  It slips free with greater ease than the first, arousing you further as you bleat out a moan from the unexpected pleasure.  Before it stops rolling on the ground, you feel the next egg sliding down your slime-slicked passage, rubbing you perfectly as it slides free.  You lose count of the eggs and begin to masturbate, ", false);
							if (player.clitLength > 5) outputText("jerking on your huge clitty as if it were a cock, moaning and panting as each egg slides free of your diminishing belly.  You lubricate it with a mix of your juices and the slime until ", false);
							if (player.clitLength > 2 && player.clitLength <= 5) outputText("playing with your over-large clit as if it were a small cock, moaning and panting as the eggs slide free of your diminishing belly.  You spread the slime and cunt juice over it as you tease and stroke until ", false);
							if (player.clitLength <= 2) outputText("pulling your folds wide and playing with your clit as another egg pops free from your diminishing belly.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself until ", false); 
							outputText("you quiver in orgasm, popping out the last of your eggs as your body twitches nervelessly on the ground.   In total you lay " + eggDescript() + ".", false);
							player.orgasm();
							dynStats("resisted", false);
						}
					}
					//Large egg scene
					else {
						outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your " + player.armorName + " before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ", false);
						if (player.vaginas[0].vaginalLooseness < VAGINA_LOOSENESS_LOOSE) outputText("stretching your tight cunt painfully, the lips opening wide ", false);
						if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness <= VAGINA_LOOSENESS_GAPING_WIDE) outputText("temporarily stretching your cunt-lips wide-open ", false);
						if (player.vaginas[0].vaginalLooseness > VAGINA_LOOSENESS_GAPING_WIDE) outputText("parting your already gaping lips wide ", false);
						outputText("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ", false);
						if (player.clitLength > 5) outputText("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ", false);
						if (player.clitLength > 2 && player.clitLength <= 5) outputText("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ", false);
						if (player.clitLength <= 2) outputText("your " + player.vaginaDescript(0) + " by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ", false);
						outputText("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ", false);
						if (player.statusEffectv3(StatusEffects.Eggs) >= 11) outputText("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your " + player.vaginaDescript(0) + " as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ", false);
						outputText("\n\nYou gaze down at the mess, counting " + eggDescript() + ".", false);
						player.orgasm();
						dynStats("resisted", false);
					}
					outputText("\n\n<b>You feel compelled to leave the eggs behind, ", false);
					if (player.findStatusEffect(StatusEffects.AteEgg) >= 0) outputText("but you remember the effects of the last one you ate.\n</b>", false);
					else outputText("but your body's intuition reminds you they shouldn't be fertile, and your belly rumbles with barely contained hunger.\n</b>", false);
					player.cuntChange(20, true);
					player.createStatusEffect(StatusEffects.LootEgg,0,0,0,0);
					displayedUpdate = true;
					player.knockUpForce(); //Clear Pregnancy
				}
			}
			return displayedUpdate;
		}

		public function eggDescript(plural:Boolean = true):String {
			var descript:String = "";
			if (player.findStatusEffect(StatusEffects.Eggs) >= 0) {
				descript += num2Text(player.statusEffectv3(StatusEffects.Eggs)) + " ";
				//size descriptor
				if (player.statusEffectv2(StatusEffects.Eggs) == 1) descript += "large ";
				/*color descriptor
				0 - brown - ass expansion
				1 - purple - hip expansion
				2 - blue - vaginal removal and/or growth of existing maleness
				3 - pink - dick removal and/or fertility increase.
				4 - white - breast growth.  If lactating increases lactation.
				5 - rubbery black - 
				*/
				if (player.statusEffectv1(StatusEffects.Eggs) == 0) descript += "brown ";
				if (player.statusEffectv1(StatusEffects.Eggs) == 1) descript += "purple ";
				if (player.statusEffectv1(StatusEffects.Eggs) == 2) descript += "blue ";
				if (player.statusEffectv1(StatusEffects.Eggs) == 3) descript += "pink ";
				if (player.statusEffectv1(StatusEffects.Eggs) == 4) descript += "white ";
				if (player.statusEffectv1(StatusEffects.Eggs) == 5) descript += "rubbery black ";
				//EGGS
				if (plural) descript += "eggs";
				else descript += "egg";
				return descript;
			}
			CoC_Settings.error("");
			return "EGG ERRORZ";
		}
		
	}

}