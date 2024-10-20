package classes.Scenes {
import classes.CoC;
import classes.CoC_Settings;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.GeneticMemories.CockMem;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.PerkLib;
import classes.PregnancyStore;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.NPCAwareContent;
import classes.Scenes.NPCs.SophieFollowerScene;
import classes.StatusEffects;
import classes.VaginaClass;

public class Pregnancy extends NPCAwareContent {
    public function Pregnancy() {}

    public function updatePregnancy():Boolean {
        var displayedUpdate:Boolean = false;
        if(player.pregnancyType == 0 && player.pregnancy2Type == 0 && player.buttPregnancyType == 0) {
            return false;
        }
        if (player.pregnancyIncubation < 2) player.knockUpForce(player.pregnancyType, 1, 0, 1);
        if (player.pregnancy2Incubation < 2) player.knockUpForce(player.pregnancy2Type, 1, 1, 1);
        if (player.buttPregnancyIncubation < 2) player.buttKnockUpForce(player.buttPregnancyType, 1, 1);
        //Cancel Heat
        if(player.inHeat) {
            EngineCore.outputText("\nYou calm down a bit and realize you no longer fantasize about getting fucked constantly.  It seems your heat has ended.\n");
            //Remove bonus libido from heat
            EngineCore.statScreenRefresh();
            player.removeStatusEffect(StatusEffects.Heat);
            displayedUpdate = true;
        }
        //IF INCUBATION IS VAGINAL
        if (player.pregnancyIncubation > 1 || player.pregnancy2Incubation > 1) {
            var wombs:Array = [];
            var womb:Object;
            if (player.pregnancyIncubation > 1) {
                womb = {};
                womb["womb"] = 0
                womb["type"] = player.pregnancyType;
                womb["incubation"] = player.pregnancyIncubation;
                wombs.push(womb);
            }
            if (player.pregnancy2Incubation > 1) {
                womb = {};
                womb["womb"] = 1
                womb["type"] = player.pregnancy2Type;
                womb["incubation"] = player.pregnancy2Incubation;
                wombs.push(womb);
            }
            for each(womb in wombs)
                displayedUpdate ||= eventVag(womb);
        }
        if(player.pregnancyIncubation == 1 && player.pregnancyType != PregnancyStore.PREGNANCY_BENOIT && player.pregnancyType != PregnancyStore.PREGNANCY_HARPY_HATCHING)
            displayedUpdate ||= birthVag();
        if(player.pregnancy2Incubation == 1 && player.pregnancy2Type != PregnancyStore.PREGNANCY_BENOIT && player.pregnancy2Type != PregnancyStore.PREGNANCY_HARPY_HATCHING)
            displayedUpdate ||= birthVag2();
        //IF INCUBATION IS ANAL
        if(player.buttPregnancyIncubation > 1)
            displayedUpdate ||= eventButt();
        if (player.buttPregnancyIncubation == 1)
            displayedUpdate ||= birthButt();
        displayedUpdate ||= birthSpecial();
        return displayedUpdate;
    }

            private function eventVag(womb:Object):Boolean {
                var displayedUpdate:Boolean = false;
                if (womb["type"] == PregnancyStore.PREGNANCY_FAERIE) {
                    displayedUpdate = SceneLib.bog.phoukaScene.phoukaPregUpdate(womb);
                }
                if (womb["type"] == PregnancyStore.PREGNANCY_SAND_WITCH) {
                    displayedUpdate = SceneLib.dungeons.desertcave.sandPregUpdate(womb);
                }
                if (womb["type"] == PregnancyStore.PREGNANCY_URTA) {
                    displayedUpdate = urtaPregs.urtaPregooUpdates(womb);
                }
                //Cotton Pregnancy! - 350 days long
                if (womb["type"] == PregnancyStore.PREGNANCY_COTTON) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(320, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten bigger. Maybe you should cut back on all the strange food.  Though you do have odd cravings for oats and grain.</b>\n");
                        displayedUpdate = true;
                    } else if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended. You are probably pregnant. The strong hankerings for oats and grains give you a very obvious clue as to who the 'father' might be.</b>\n");
                        displayedUpdate = true;
                    } else if (womb["incubation"] == sceneHunter.adjustPregEventTimer(225, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  You stroke the orb and wonder with a half-grin if you'll have a daughter who takes after her 'daddy'.</b>\n");
                        displayedUpdate = true;
                    } else if (womb["incubation"] == sceneHunter.adjustPregEventTimer(165, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a tiny kick from inside your womb startles you.  Moments later it happens again, making you gasp.  The baby inside you really must be equine in nature; she's already got quite a wicked kick on her.</b>\n");
                        displayedUpdate = true;
                    } else if (womb["incubation"] == sceneHunter.adjustPregEventTimer(105, womb["type"])) {
                        EngineCore.outputText("\n<b>You're already as big as any pregnant woman back home. Considering that what you're carrying is technically a foal, you wonder just how much bigger you're going to get...</b>\n");
                        displayedUpdate = true;
                    } else if (womb["incubation"] == sceneHunter.adjustPregEventTimer(80, womb["type"])) {
                        EngineCore.outputText("\n<b>Your swollen stomach would bring queries about the possibility of twins back in Ingnam.  However, you can only feel one strong heart beating away inside your stretched midriff.  Cotton's foal is definitely growing up healthy...\n\nYou're glad, but a little worried about giving birth.</b>\n");
                        displayedUpdate = true;
                    } else if (womb["incubation"] == sceneHunter.adjustPregEventTimer(50, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is painfully distended and swollen; you feel like you're going to burst before you get much bigger.  You find yourself pacing around restlessly in the night, like the expectant mares back in the village.  You're anxious to finally give birth, as much to get this heavy baby out of you as to finally be able to cuddle your child.</b>\n");
                        displayedUpdate = true;
                    }
                    //Tits
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        displayedUpdate = true;
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Imp Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_IMP) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(336, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended.   You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ");
                        if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
                        if (player.cor >= 75) EngineCore.outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a kick from inside your womb startles you.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is painfully distended, ");
                        if (player.cor < 40) EngineCore.outputText("making it difficult to function.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
                        if (player.cor < 40) EngineCore.outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("You estimate you'll give birth in the next few days.</b>\n");
                        if (player.cor >= 75) EngineCore.outputText("You find yourself daydreaming about birthing demons repeatedly, each time being re-impregnated by your hordes of lusty adolescent children.</b>\n");
                        displayedUpdate = true;
                    }
                }
                //Minotaur Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_MINOTAUR) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(336, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ");
                        if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
                        if (player.cor >= 75) EngineCore.outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a kick from inside your distended womb startles you.  Moments later it happens again, making you gasp and stagger.  Whatever is growing inside you is strong.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is painfully distended and overswollen with the offspring of some huge beast, ");
                        if (player.cor < 40) EngineCore.outputText("making it difficult to function.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        displayedUpdate = true;
                        EngineCore.outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever beast is inside your overstretched womb seems to appreciate the attention, and stops its incessant squirming.  ");
                        if (player.cor < 40) EngineCore.outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("You estimate you'll give birth in the next few days.</b>\n");
                        if (player.cor >= 75) EngineCore.outputText("You find yourself daydreaming about birthing some huge monstrous beast, and raising it to fuck your wet pussy over and over.</b>\n");
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        displayedUpdate = true;
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Centaur Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_CENTAUR || womb["type"] == PregnancyStore.PREGNANCY_KELT) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(350, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten bigger. Maybe you should cut back on all the strange food.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended. You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  Somehow, you don't feel worried. Only content.</b>\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>The pregnancy is moving much faster than you expected. It's already as big as the belly of any pregnant woman back home.  However, a feeling of warm satisfaction fills you.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is painfully distended and overswollen with the offspring of some huge beast, making it difficult to function.</b>\n");
                        player.dynStats("spe", -1, "lib", .5, "sen", .5, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your stomach is easily the size of a beach ball, and still growing ever further. Strangely, you don't feel hindered. In fact, you feel like running...</b>\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>It seems impossible for your pregnant belly to grow any larger, but you are at your happiest yet, satisfied that somehow, you are fulfilling your role. It feels right to be pregnant, and you can't wait to get knocked up again afterwards.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        displayedUpdate = true;
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("<b>\nYou realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("<b>\nYour breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("<b>\nYour breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Goblin Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_GOBLIN) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten bigger. Maybe you should cut back on all the strange food.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(125, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended. You are probably pregnant which for you, is great news.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(100, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy. You stroke the orb and wonder with a half-grin how much your daughter will take after you.</b>\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(75, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a tiny kick from inside your womb startles you. Moments later it happens again, making you gasp. The baby inside you really must be quite agitated.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(50, womb["type"])) {
                        EngineCore.outputText("\n<b>You're already as big as any pregnant woman back home. Well...for a goblin that is because you are quite smaller than a human to begin with.</b>\n");
                        player.dynStats("spe", -1, "lib", .5, "sen", .5, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(25, womb["type"])) {
                        EngineCore.outputText("\n<b>It seems impossible for your pregnant belly to grow any larger, but you are at your happiest yet, satisfied that somehow, you are fulfilling your role. It feels so right to be pregnant, and you can't wait to get knocked up again afterwards.</b>\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(12, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(24, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(36, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        displayedUpdate = true;
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("<b>\nYou realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("<b>\nYour breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("<b>\nYour breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                if (womb["type"] == PregnancyStore.PREGNANCY_CELESS) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(696, womb["type"])) {
                        EngineCore.outputText("\n<b>Since that day in the forest, your stomach has remained somewhat the same. You thought it would have turned back to normal by now. ");
                        if (player.hasPerk(PerkLib.UnicornBlessing)) EngineCore.outputText("Seems like she did actually manage to impregnate you without taking your virginity, doesn’t it?");
                        if (player.hasPerk(PerkLib.BicornBlessing)) {
                            EngineCore.outputText("As corrupt this child might be you still intend to bring her into the world.");
                            if (player.cor <= 10) EngineCore.outputText(" Perhaps you could actually raise her as a pure being?");
                        }
                        EngineCore.outputText("</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(480, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly has gotten bigger again and the constant craving for cereals and vegetables gives you quite the idea of who might be the cause.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(240, womb["type"])) {
                        EngineCore.outputText("\n<b>You feel small, but powerful, kicks every now and then. Your daughter clearly has quite the strong legs, it seems. You don’t know how you can tell it’s a girl, it just feels right. Moreover, you’re fairly certain she is going to be a herm like her sire.</b>\n");
                        displayedUpdate = true;
                    }
                }
                //Bunny tf preggoz
                if (womb["type"] == PregnancyStore.PREGNANCY_BUNNY || womb["type"] == PregnancyStore.PREGNANCY_LOPPE) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(800, womb["type"])) {
                        EngineCore.outputText("\nYour womb gurgles strangely.\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(785, womb["type"])) {
                        //outputText("\n<b>An unexpected change occurs, no doubt brought on by the bunny's eggs inside you!</b>");
                        CoC.instance.mutations.neonPinkEgg(true, 0, player);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(776, womb["type"])) {
                        EngineCore.outputText("\nYour womb feels full and bloated.\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(765, womb["type"])) {
                        //outputText("\n<b>An unexpected change occurs, no doubt brought on by the bunny's eggs inside you!</b>");
                        CoC.instance.mutations.neonPinkEgg(true, 0, player);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] <= sceneHunter.adjustPregEventTimer(745, womb["type"]) && womb["incubation"] > sceneHunter.adjustPregEventTimer(400, womb["type"])) {
                        EngineCore.outputText("\n<b>After dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your womb have dissolved.</b>\n");
                        displayedUpdate = true;
                        player.knockUpForce(0, 0, womb["womb"]); //Clear Pregnancy
                    }
                    //BREAK - REAL PREGNANCY BELOW THIS:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(198, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten slightly larger.  " +
                                (womb["type"] == PregnancyStore.PREGNANCY_LOPPE ? "" : "Maybe there's some truth to what the bunny-girl said.") + "</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(178, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended.   You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(156, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ");
                        if (womb["type"] != PregnancyStore.PREGNANCY_LOPPE) {
                            if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                            if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("You find yourself wondering what giving birth to bunny-girls is like.</b>");
                            if (player.cor >= 75) EngineCore.outputText("You dreamily wonder if you could find a bunny willing to put more than two eggs inside you at once.</b>");
                        } else outputText("You find yourself wondering what giving birth to bunny-girls is like.</b>");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(140, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a kick from inside your womb startles you, and it's immediately followed by a second on the other side.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is painfully distended, ");
                        if (player.cor < 40) EngineCore.outputText("making it difficult to function.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth so you'll be able to get pregnant again.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
                        if (womb["type"] != PregnancyStore.PREGNANCY_LOPPE) {
                            if (player.cor < 40) EngineCore.outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n");
                            if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("You estimate you'll give birth in the next few days.</b>\n");
                            if (player.cor >= 75) EngineCore.outputText("You find yourself daydreaming about birthing bunnies repeatedly, each time being re-impregnated with dozens of eggs from your lusty adolescent children.</b>\n");
                        } else
                            EngineCore.outputText("You estimate you'll give birth in the next few days.</b>\n");
                        displayedUpdate = true;
                    }
                }
                //Marblz Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_MARBLE) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(336, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ");
                        if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
                        if (player.cor >= 75) EngineCore.outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a kick from inside your distended womb startles you.  Moments later it happens again, making you gasp and stagger.  Whatever is growing inside you is strong.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is distended and overswollen with your offspring, ");
                        if (player.cor < 40) EngineCore.outputText("making it difficult to function.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth, so you can get fill your womb with a new charge.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever child is inside your overstretched womb seems to appreciate the attention, and stops its incessant squirming.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"])) {
                        //A small scene for very late in the pregnancy, its breast growth for the little cowgirl.  This scene should be a few days before birth, so the milk doesn't stop before the cowgirl is born.
                        EngineCore.outputText("\n<b>Your belly has become heavily pregnant; at the same time, ");
                        //If (PC has flat breasts)
                        if (player.biggestTitSize() <= 0) {
                            EngineCore.outputText("your chest has begun to feel a bit odd.  Your run your hands over it to find that your breasts have grown to around C-cups at some point when you weren't paying attention!  ");
                            player.breastRows[0].breastRating = 3;
                        } else if (player.biggestTitSize() <= 1 && player.mf("m", "f") == "f") {
                            EngineCore.outputText("your breasts feel oddly tight in your top.  You put a hand to them and are startled when you find that they've grown to C-cups!  ");
                            player.breastRows[0].breastRating = 3;
                        } else if (player.biggestTitSize() <= 10) {
                            EngineCore.outputText("your breasts feel oddly full.  You grab them with your hands, and after a moment you're able to determine that they've grown about a cup in size.  ");
                            player.breastRows[0].breastRating++;
                        } else {
                            EngineCore.outputText("your breasts feel a bit odd.  You put a hand on your chest and start touching them.  ");
                        }
                        if (player.biggestLactation() < 1) {
                            EngineCore.outputText("You gasp slightly in surprise and realize that you've started lactating.");
                            player.boostLactation(player.breastRows.length);
                        } else {
                            EngineCore.outputText("A few drips of milk spill out of your breasts, as expected.  Though, it occurs to you that there is more milk coming out than before.");
                            player.boostLactation(player.breastRows.length * .25);
                        }
                        EngineCore.outputText("</b>\n");
                    }
                }
                //Jojo Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_MOUSE || womb["type"] == PregnancyStore.PREGNANCY_JOJO) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(336, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
                        if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3) { //Bimbo Jojo, stage 1
                            EngineCore.outputText("\nJoy notices you examining your belly and strolls over, playfully poking it with her finger. \"<i>Somebody's getting chubby; maybe you and I need to have a little more fun-fun to help you work off those calories, hmm?" + joyScene.joyHasCockText(" Or maybe I'm just feeding you too much...") + "</i>\" She teases" + joyScene.joyHasCockText(", patting her " + joyScene.joyCockDescript()) + ".\n");
                        }
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
                        if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && womb["type"] == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 2
                            EngineCore.outputText("\nA pair of arms suddenly wrap themselves around you, stroking your belly. \"<i>Like, don't worry, [name]; I love you even if you are getting fat. Actually... this little pot belly of yours is, like, kinda sexy, y'know?</i>\" Joy declares.\n");
                            EngineCore.outputText("\nYou roll your eyes at Joy's teasing but appreciate her support all the same.\n");
                        }
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && womb["type"] == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 3
                            EngineCore.outputText("\n<b>You have no doubt that you're pregnant now,</b> and from your recent urges to eat cheese and nuts, as well as the lusty thoughts that roam your head, you can already imagine who the father is...\n");
                            EngineCore.outputText("\nJoy shakes her head. \"<i>Wow, you just keep getting, like, fatter and fatter, don't you, [name]? S'funny, though... I never thought of myself as, like, a chubby chaser before, but that belly of yours really gets me, y'know, hot 'n' bothered.</i>\" She comments.\n");
                            EngineCore.outputText("\nYou sigh, almost laughing... sometimes Joy's inability to see the obvious is cute, sometimes it's just funny and sometimes both. You tell her to quit being silly, it's quite obvious by now that you're pregnant and she's the father, by the way.\n");
                            EngineCore.outputText("\nJoy stares at you, silent and dumbfounded. Moments of silence pass by... you wonder if maybe you've broken her. Then, suddenly. \"<i>Yahoo!</i>\" She screams, and performs a backflip, dancing around with both arms pumping in the air before suddenly rushing towards you and throwing your arms around you, barely remembering to be gentle to avoid squishing your vulnerable belly. \"<i>I'm gonna be a daddy-mommy!</i>\" She shouts in glee.\n");
                            EngineCore.outputText("\nJoy's erm... joy... is infectious and you find yourself smiling at her happy reaction.\n");
                            if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 70 && !camp.marbleFollower()) {
                                EngineCore.outputText("\nThen her face falls in realisation. \"<i>Crap! I gotta get that nursery built, like, now!</i>\" She yells. She gives your belly a loud, wet kiss, then runs off into the scrub, muttering to herself about what she needs to get.\n");
                                flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 69;
                            }
                        } else {
                            EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ");
                            if (monk > 0) {
                                if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                                if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
                                if (player.cor >= 75) EngineCore.outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
                            } else {
                                EngineCore.outputText("</b>");
                            }
                        }
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && womb["type"] == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 4
                            EngineCore.outputText("\nIf there was ever any doubt you were carrying only one child before, it has long been forgotten. <b>Your belly is bigger than any woman's back in your village, and the children within are seemingly restless! They kick you all the time; it is clear they inherited Joy's energy, but it's starting to get bothersome.</b> You sigh as you take a seat to rest a bit as the babies inside you kick.\n");
                            EngineCore.outputText("\nThis would, of course, be less tiresome if you didn't have to lug around a third mouse as well... A smooch on your belly signals Joy's arrival into the scene.\n");
                            EngineCore.outputText("\nThe bimbo mouse smiles up at you, rubbing her cheek against your gravid midriff. \"<i>Aw... how are Joyjoy's little ones today? Are you being good to your mommy?</i>\" She coos.\n");
                            EngineCore.outputText("\nYou tell her they've been very active lately, you barely get a moment's rest as they keep kicking inside your belly.\n");
                            EngineCore.outputText("\nShe frowns and then stares at your belly. \"<i>Naughty little babies! Stop kicking mommy! You wouldn't be kicking like this inside mommy Joy's tummy, now would you?</i>\" She states, unconcerned about the fact she is trying to chastise her unborn offspring.\n");
                            EngineCore.outputText("\nYou chuckle at the bimbo mouse's antics. Somehow the whole scene is uplifting, and you feel a bit less tired by your pregnancy.\n");
                            if (flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] == 69 && !camp.marbleFollower()) {
                                EngineCore.outputText("\nThe mouse turns to walk away, but stops before doing so and looks at you. \"<i>Oh, right! I, like, totally forgot; the nursery's all done now. Our little babies will have a cosy nest to play in when they finally, y'know, come out.</i>\" She states, full of pride at her achievements - both knocking you up and getting a nursery done.\n");
                                flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 70;
                            }
                        } else {
                            EngineCore.outputText("\n<b>The sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.</b>\n");
                        }
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3 && womb["type"] == PregnancyStore.PREGNANCY_JOJO) { //Bimbo Jojo, stage 5
                            EngineCore.outputText("\nYou're mildly annoyed at your squirming tummy, it seems your children have taken a liking to scurrying about inside you. The other mildly annoying thing, is Joy's attachment to your huge pregnant belly. It would seem that the bimbo mouse is as eager to see the children as the children inside you are eager to come out and play.\n");
                            EngineCore.outputText("\n\"<i>Like, [name], when are the babies gonna come out and play? I wanna hold my cute little squeakies already!</i>\" Joy pouts, stamping her foot in irritation at the wait for you to give birth.\n");
                            EngineCore.outputText("\nYou tell her that she'll just have to wait, you want them out too. It's getting heavy.\n");
                            EngineCore.outputText("\nJoy pouts, \"<i>But I want them to come out now!</i>\" She whines, then she heaves a heavy sigh. \"<i>Alright, I guess it'll be, like, worth the wait...</i>\" She looks at your [breasts] and develops a sly expression. \"<i>Like... some nice creamy milk would make me feel better...</i>\" She wheedles.\n");
                            EngineCore.outputText("\n");
                            if (player.hasPerk(PerkLib.Feeder)) EngineCore.outputText("You grin at Joy's idea, but you can't simply mash her against your breasts and nurse her without some teasing first.");
                            EngineCore.outputText("You tell Joy that she can have some, but she has to ask nicely, like a good girl.\n");
                            EngineCore.outputText("\nThe bimbo mouse presses her hands together and gives you a winning smile, eyes wide with an uncharacteristic innocence. \"<i>Like, [name], will you please let your little Joyjoy suck on your [breasts] and drink all the yummy mommy-milk she can hold? Puh-lease?</i>\" She begs.\n");
                            EngineCore.outputText("\nYou expose your breasts and open your arms in invitation.\n");
                            EngineCore.outputText("\nJoy squeaks in glee and rushes into your embrace, rubbing her " + (jojoScene.pregnancy.isPregnant ? "swollen " : "") + "belly against your baby-filled stomach and nuzzling your breastdescript excitedly. She wastes no time in slurping on your nipplesdescript until they are painfully erect, then sucks the closest one into her mouth and starts suckling as if her life depends on it.\n");
                            EngineCore.outputText("\nBy the time Joy's had her fill, your babies have calmed down a little. It seems like being close to Joy might have actually helped calm the little mice down. Joy yawns and nuzzles your [breasts].\n");
                            EngineCore.outputText("\n\"<i>Mmm... Sooo good.</i>\" Joy murmurs, then burps softly. \"<i>I feel, like, so sleepy now...</i>\" She mumbles, yawning hugely, then reluctantly she pushes herself off of you and starts stumbling away in the direction of her bed" + (player.lactationQ() >= 750 || player.hasPerk(PerkLib.Feeder) ? ", her belly audibly sloshing from all the milk you let her stuff herself with" : "") + ".\n");
                            EngineCore.outputText("\nYou sigh, glad to finally have a moment to rest.\n");
                        } else {
                            EngineCore.outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  It's already as big as the belly of any pregnant woman back home.</b>\n");
                        }
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is painfully distended and overswollen with wriggling offspring, ");
                        if (player.cor < 40) EngineCore.outputText("making it difficult to function.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  Whatever is inside your overstretched womb seems to appreciate the attention and stops its incessant squirming.  ");
                        if (player.cor < 40) EngineCore.outputText("Afterwards you feel somewhat disgusted with yourself.</b>\n");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("You estimate you'll give birth in the next few days.</b>\n");
                        if (player.cor >= 75) EngineCore.outputText("You find yourself daydreaming about birthing hundreds of little babies, and lounging around while they nurse non-stop on your increasingly sensitive breasts.</b>\n");
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Amily Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_AMILY) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(336, womb["type"])) {
                        EngineCore.outputText("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some mixed nuts. And maybe a little cheese, too.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(280, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>There is no question you're pregnant; your belly is already as big as that of any pregnant woman back home.");
                        if (flags[kFLAGS.AMILY_FOLLOWER] == 1) EngineCore.outputText("  Amily smiles at you reassuringly. \"<i>We do have litters, dear, this is normal.</i>\"");
                        EngineCore.outputText("</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a tiny kick from inside your distended womb startles you.  Moments later it happens again, making you gasp.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>You feel (and look) hugely pregnant, now, but you feel content. You know the, ah, 'father' of these children loves you, and they will love you in turn.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>You jolt from the sensation of squirming inside your swollen stomach. Fortunately, it dies down quickly, but you know for a fact that you felt more than one baby kicking inside you.</b>\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>The children kick and squirm frequently. Your bladder, stomach and lungs all feel very squished. You're glad that they'll be coming out of you soon.</b>\n");
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Shark Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_IZMA) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(275, womb["type"])) {
                        if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) EngineCore.outputText("\n<b>You wake up feeling kind of nauseous.  Izma insists that you stay in bed and won't hear a word otherwise, tending to you in your sickened state.  When you finally feel better, she helps you up.  \"<i>You know, [name]... I think you might be pregnant.</i>\" Izma says, sounding very pleased at the idea. You have to admit, you do seem to have gained some weight...</b>\n");
                        else EngineCore.outputText("\n<b>You wake up feeling bloated, and your belly is actually looking a little puffy. At the same time, though, you have the oddest cravings... you could really go for some fish.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(250, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) EngineCore.outputText("\n<b>Your stomach is undeniably swollen now, and you feel thirsty all the time. Izma is always there to bring you water, even anticipating your thirst before you recognize it yourself. She smiles all the time now, and seems to be very pleased with herself.");
                        else EngineCore.outputText("\n<b>There is no question you're pregnant; your belly is getting bigger and for some reason, you feel thirsty ALL the time.");
                        EngineCore.outputText("</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) EngineCore.outputText("\n<b>There is no denying your pregnancy, and Izma is head-over-heels with your 'beautifully bountiful new body', as she puts it. She is forever finding an excuse to touch your bulging stomach, and does her best to coax you to rest against her. However, when you do sit against her, she invariably starts getting hard underneath you.</b>\n");
                        else EngineCore.outputText("\n<b>There is no denying your pregnancy.  Your belly bulges and occasionally squirms as your growing offspring shifts position.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) EngineCore.outputText("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling. Izma is always on hand now, it seems, and she won't dream of you fetching your own food or picking up anything you've dropped. She's always dropping hints about how you should try going around naked for comfort's sake. While you are unwilling to do so, you find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n");
                        else EngineCore.outputText("\n<b>Your stomach is swollen and gravid; you can feel the baby inside you kicking and wriggling.  You find yourself dreaming about sinking into cool, clean water, and take many baths and swims. Whatever is inside you always seems to like it; they get so much more active when you're in the water.</b>\n");
                        player.dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        if (flags[kFLAGS.IZMA_FOLLOWER_STATUS] == 1) EngineCore.outputText("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in. Izma makes no secret of her pleasure and informs you that you should deliver soon.</b>\n");
                        else EngineCore.outputText("\n<b>You dream of the water, of a life under the waves, where it's cool and wet and you are free. You spend as much time in the river as possible now, the baby inside you kicking and squirming impatiently, eager to be free of the confines of your womb and have much greater depths to swim and play in.  The time for delivery will probably come soon.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                            displayedUpdate = true;
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                    }
                }
                //SPOIDAH Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_SPIDER || womb["type"] == PregnancyStore.PREGNANCY_DRIDER_EGGS) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(399, womb["type"])) {
                        EngineCore.outputText("\n<b>After your session with the spider, you feel much... fuller.  There is no outward change on your body as far as you can see but your womb feels slightly tingly whenever you move.  Hopefully it's nothing to be alarmed about.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(275, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(250, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly looks a little pudgy");
                        if (player.thickness > 60 && player.tone < 40) EngineCore.outputText(" even for you");
                        EngineCore.outputText(", maybe you should cut back on all the food you've been consuming lately?</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>A hot flush works its way through you, and visions of aroused ");
                        if (womb["type"] == PregnancyStore.PREGNANCY_SPIDER) EngineCore.outputText("spider-morphs ");
                        else EngineCore.outputText("driders ");
                        EngineCore.outputText("quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and mated with over and over, violated by a pack of horny males, each hoping to father your next brood.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?</b>\n");
                        player.dynStats("lib", 1, "sen", 1, "lus", 20);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.");
                        if (player.cor < 50) EngineCore.outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.");
                        EngineCore.outputText("</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                            displayedUpdate = true;
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                    }
                }
                //Goo Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_GOO_GIRL) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your slime-packed belly is reassuring in its own way.  You can't wait to see how it feels to have the slime flowing and gushing through your lips, stroking you intimately as you birth new life into this world.");
                        if (player.cor < 50) EngineCore.outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.");
                        EngineCore.outputText("</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(82, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(16, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                            displayedUpdate = true;
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                    }
                }
                if (womb["type"] == PregnancyStore.PREGNANCY_EMBER) {
                    var pregText:String = "";
                    //Pregnancy notes: Egg Laying
                    if (flags[kFLAGS.EMBER_OVIPOSITION] > 0) {
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(330, womb["type"])) pregText = "Your belly has swollen, becoming larger - proof that Ember's seed did its work.  The dragon seems to be constantly checking you out, as if looking for the signs of weight gain.";
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(250, womb["type"])) pregText = "Your belly grows ever bigger, making your pregnancy noticeable; your belly also feels somewhat solid.  Ember casts pleased glances in your direction, whenever " + emberScene.emberMF("he", "she") + " thinks you're not looking.";
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(170, womb["type"])) {
                            pregText = "You've grown a lot.  Anyone is able to tell that you're pregnant with a single glance; and by the shape, you have no doubt that there's an egg in your womb; a big one.";
                            //(If Corruption < 40)
                            if (player.cor < 40) pregText += "  Part of you didn't really want to get knocked up, but it's for a good cause.  Besides, Ember looks very cute, trying to hide " + emberScene.emberMF("his", "her") + " happiness whenever " + emberScene.emberMF("he", "she") + " glances at your belly...";
                            //(If Corruption >= 40)
                            else if (player.cor < 75) pregText += "  Considering the size of the egg, you hope it doesn't hurt when your child comes out.  You hope Ember will help you through this.";
                            //(If Corruption >= 75)
                            else pregText += "  You think dreamily about the wild sex that helped conceive this little one.  Ember is such a great fuck.  Really, you're doing this world a favor by bringing more of Ember's offspring into it.";
                        }
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) pregText = "Though you're sure that this is the time when a regular baby would start moving about, your own belly simply sits there, heavy and full.  You'd be worried if you didn't remember that Ember hatched from an egg.  Sometimes; a delightful, refreshing, chill spreads from your belly throughout your body; making you feel invigorated, ready for anything.";
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(90, womb["type"])) pregText = "You've somehow grown even larger, the egg's outline appearing through your tummy.  By now, you're quite bothered with how difficult it's getting to move.  Ember constantly shadows you around the camp, making sure you're all right, although if you ever question " + emberScene.emberMF("him", "her") + " " + emberScene.emberMF("he", "she") + "'ll just say you're both going in the same direction.";
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(60, womb["type"])) {
                            pregText = "The egg inside your belly seems to grow heavier each day that passes.  ";
                            //(If Corruption < 40)
                            if (player.cor < 40) pregText += "It's quite a burden that you're carrying.  Still, it's a worthwhile sacrifice to make in order to restore Ember's race.";
                            //(If Corruption >= 40)
                            else if (player.cor < 75) pregText += "You wonder how much longer you have to wait.  This egg is quite burdensome.  Part of you is scared of its size, the other part is delighted to have produced such a big egg.";
                            //If Corruption >= 75)
                            else pregText += "You're eager to give birth, just so you can get impregnated again.  Particularly because that means more wild sex with Ember.";
                        }
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(30, womb["type"])) {
                            pregText = "You rub your hands over your ripe belly, lost in the sensations of motherhood.  ";
                            player.dynStats("sen", 5, "lus", (5 + player.sens / 20));
                            //If Corruption < 40
                            if (player.cor < 40) pregText += "Despite your initial reluctance, you've come to find a very real pleasure in being pregnant.  You hope Ember will want to have more children in the future...";
                            //(If Corruption >= 40)
                            else if (player.cor < 75) pregText += "You smile, knowing you'll have your egg in your hands the next few days.  A part of you is almost sad that you'll be empty, but you can always entice Ember into getting you pregnant again.";
                            //(If Corruption >= 75)
                            else {
                                pregText += "You find yourself daydreaming about giving birth, your belly swollen huge - bigger than it currently is - and the orgasmic sensation of many large, round eggs sliding out of your " + player.vaginaDescript(womb["womb"]) + ".\n\nYou start to absently rub yourself as you envision eggs by the dozens coming from within you; you shall be mothergod for a whole new race of dragons...";
                                player.dynStats("lus", 35, "scale", false);
                            }
                            pregText += "\n\nEmber interrupts your musings with a question.  \"<i>How are you feeling? Do you need me to get you anything?</i>\"";
                            pregText += "\n\nThe dragon's question is uncharacteristic of " + emberScene.emberMF("him", "her") + ".  Still, you do appreciate the attention you're getting, and so you ask Ember to fetch you some food and water.  The speed with which Ember dashes off to fulfill your requests is truly impressive!  In short moments Ember is back with a piece of roasted meat and a skin of water.";
                            pregText += "\n\nAs you eat and drink your fill, Ember uses one wing to shield you off the sun.  You're starting to really enjoy all the attention, but seeing Ember give up on " + emberScene.emberMF("his", "her") + " usual antics is still very weird.";
                        }
                    }
                    //Pregnancy Notes: Live Birth
                    else {
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(330, womb["type"])) pregText = "Your belly is a bit swollen - either you're eating too much or Ember's seed really did the job.";
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(250, womb["type"])) pregText = "Your belly grows ever bigger, making your pregnancy noticeable.  Ember shoots you quick looks, trying to hide " + emberScene.emberMF("his", "her") + " smirk of success every time " + emberScene.emberMF("he", "she") + " does.  You smirk right back at " + emberScene.emberMF("him", "her") + ", and occasionally make a subtle show of your gravid form, just to see " + emberScene.emberMF("him", "her") + " get turned on by the sight.";
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(170, womb["type"])) {
                            pregText = "You've grown a lot, anyone is able to tell that you're pregnant with a single glance.  ";
                            //If Corruption < 40
                            if (player.cor < 40) pregText += "Part of you didn't really want to get knocked up.  However, Ember's look of satisfaction whenever " + emberScene.emberMF("he", "she") + " gazes your way is rewarding despite that.  Plus, it is for a good cause.  You smirk in satisfaction - with a couple of dragons at your beck and call, things will look very different indeed.";
                            //If Corruption >= 40
                            else if (player.cor < 75) pregText += "You grin, savoring the strange, erotic sensations from the life inside your burgeoning womb and the promise of motherhood.  Mmm, if it feels this good, maybe you should \"<i>encourage</i>\" Ember to get you pregnant again.";
                            else pregText += "You think dreamily about the wild sex that helped conceive this little one.  Ember is such a great fuck. Really, you're doing this world a favor by bringing more of Ember's offspring into it.";
                        }
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                            pregText = "Every once in awhile, you feel a kick from inside your bulging belly.  Right now, it's really kicking up a storm, and so you decide to sit down and take it easy.  You keep rubbing your belly, hoping to calm your child down and make it stop battering your innards.";
                            pregText += "\n\nEmber approaches you, and casually asks, \"<i>So... is it kicking already?</i>\"";
                            pregText += "\n\nYou admit that it is, stroking your stomach.  Casually, you ask if Ember would maybe like to touch your belly, wondering if " + emberScene.emberMF("he", "she") + " will be able to bring " + emberScene.emberMF("him", "her") + "self to do it.";
                            pregText += "\n\n\"<i>Yes! Of course!</i>\" Ember replies";
                            if (flags[kFLAGS.EMBER_ROUNDFACE] == 1) pregText += ", blush at " + emberScene.emberMF("his", "her") + " own over-enthusiastic reply";
                            pregText += ".  You just smile encouragingly at the dragon " + emberScene.emberMF("-boy", "herm") + " and lean back slightly, sticking out your gravid midriff in open encouragement to its " + emberScene.emberMF("father", "mother") + " to try and connect with " + emberScene.emberMF("his", "her") + " unborn child.";
                            pregText += "\n\nEmber sets a clawed hand on your belly, careful not to hurt you with " + emberScene.emberMF("his", "her") + " claws.  Slowly " + emberScene.emberMF("he", "she") + " rubs your belly, until " + emberScene.emberMF("he", "she") + " feels a small kick and smiles in glee.  You smile at the look of joy on " + emberScene.emberMF("his", "her") + " face, even as " + emberScene.emberMF("he", "she") + " realizes what " + emberScene.emberMF("he", "she") + "'s doing and embarrassedly mumbles an excuse and walks away.";
                        }
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(90, womb["type"])) {
                            pregText = "You stop for a moment and sit down on a nearby rock.  Your belly feels much heavier than usual, and just walking about has become a chore.  Ember takes notice of your tiredness and quickly closes the distance between you two.  \"<i>[name], are you feeling all right?</i>\"";
                            pregText += "\n\nYou tell " + emberScene.emberMF("him", "her") + " that you are, just worn out.  It's not easy carrying " + emberScene.emberMF("his", "her") + " child, after all.";
                            pregText += "\n\nEmber sighs in relief.  \"<i>Good, is there anything I can do for you?</i>\"";
                            pregText += "\n\nYou tap your lips thoughtfully, mulling it over.  ";
                            //(Low Corruption)
                            if (player.cor <= 33) pregText += "There really isn't anything you feel like you need right now... maybe some water?  Or maybe you could have Ember help you to your " + camp.homeDesc() + " for a quick rest?";
                            //(Medium Corruption)
                            else if (player.cor <= 66) pregText += "You wonder if you should take advantage of Ember - you've certainly been feeling a little on edge lately, and besides " + emberScene.emberMF("he", "she") + " did say 'anything'.  You ponder this for a while longer.";
                            //High Corruptio
                            else pregText += "You  already thought up a perfect way for this sexy dragon to help you, but it's best not to rush.  It's not everyday that Ember says " + emberScene.emberMF("he", "she") + "'ll do 'anything' for you.  A quick jab on your belly from your unborn child makes you recoil a bit though.  Maybe it would be better to wait until this little one is out of you, just so you can have another.  You ponder what to ask of " + emberScene.emberMF("him", "her") + " a while longer.";
                            pregText += "\n\nFinally, you decide there really isn't anything Ember can help you with, and tell " + emberScene.emberMF("him", "her") + " so.  Though " + emberScene.emberMF("he", "she") + " had better be ready to do " + emberScene.emberMF("his", "her") + " part when the baby is born and needs caring.";
                            if (flags[kFLAGS.EMBER_GENDER] == 1 && flags[kFLAGS.EMBER_MILK] > 0) pregText += "  You can't resist smirking and patting one of your shemale dragon's bountiful breasts, noting that maybe you should let him do all the breast-feeding.";

                            pregText += "\n\n";
                            if (flags[kFLAGS.EMBER_ROUNDFACE] > 0) pregText += "Ember blushes.  ";
                            pregText += "\"<i>O-of course I'll do my part.  If you don't need me for anything, I'll be going then.</i>\" " + emberScene.emberMF("He", "She") + " turns on " + emberScene.emberMF("his", "her") + " heels and walks away.  You watch " + emberScene.emberMF("him", "her") + " go, pat yourself on the stomach, then painstakingly hoist yourself back upright and go on your way.";
                        }
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(60, womb["type"])) {
                            pregText = "Besides being so huge you'd probably be asked if you were having twins back in Ingnam, your belly has grown stupidly heavy, ";
                            if (player.cor <= 33) pregText += "making you wonder more than ever if it really was a good idea to get pregnant with a dragon.  True, Ember looks ready to burst with pride at your fruitful bounty, but you feel ready to just plain burst yourself.";
                            else if (player.cor <= 66) pregText += "and you wonder how much longer you have to wait.  Despite being a bit bothersome, you're pleased your child is growing into a healthy, hopefully sexy, dragon; like its father.";
                            else pregText += "and you're eager to give birth, so you can get impregnated again.  Particularly because that means more rowdy fucking from Ember.";
                        }
                        if (womb["incubation"] == sceneHunter.adjustPregEventTimer(30, womb["type"])) {
                            pregText = "You rub your hands over your gloriously full, ripe belly, lost in the sensations of motherhood.  ";
                            if (player.cor <= 33) pregText += "Despite your initial reluctance, you've come to find a very real pleasure in being pregnant.  You hope Ember will want to have more children in the future.";
                            else if (player.cor <= 66) pregText += "You smile, knowing you'll meet your child in the next few days.  A part of you is almost sad that you'll be empty, but you can always entice Ember into getting you pregnant again.";
                            else pregText += "You find yourself daydreaming about being the revered mother-queen of a huge army of dragons, visions of magnificent, sexy, scaly beasts sweeping across the land conquering it in your honor, offering up tribute to the ever-ripe womb that brought them forth; rolling around, as the musk of their fucking fills the air.  The image is so delicious you don't want to wake up from your fantasy.";
                        }
                    }
                    if (pregText != "") {
                        EngineCore.outputText("\n" + pregText + "\n");
                        displayedUpdate = true;
                    }
                }
                //Pregnancy 4 Satyrs
                if (womb["type"] == PregnancyStore.PREGNANCY_SATYR) {
                    //Stage 1:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        EngineCore.outputText("\n<b>You find that you're feeling quite sluggish these days; you just don't have as much energy as you used to.  You're also putting on weight.</b>\n");
                        displayedUpdate = true;
                    }
                    //Stage 2:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(125, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting bigger and bigger.  Maybe your recent urges are to blame for this development?</b>\n");
                        displayedUpdate = true;
                    }
                    //Stage 3:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(100, womb["type"])) {
                        EngineCore.outputText("\n<b>You can feel the strangest fluttering sensations in your distended belly; it must be a pregnancy.  You should eat more and drink plenty of wine so your baby can grow properly.  Wait, wine...?</b>\n");
                        displayedUpdate = true;
                    }
                    //Stage 4:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(75, womb["type"])) {
                        EngineCore.outputText("\n<b>Sometimes you feel a bump in your pregnant belly.  You wonder if it's your baby complaining about your moving about.</b>\n");
                        displayedUpdate = true;
                    }
                    //Stage 5:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(50, womb["type"])) {
                        EngineCore.outputText("\n<b>With your bloating gut, you are loathe to exert yourself in any meaningful manner; you feel horny and hungry all the time...</b>\n");
                        displayedUpdate = true;
                        //temp min lust up +5
                    }
                    //Stage 6:
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(30, womb["type"])) {
                        EngineCore.outputText("\n<b>The baby you're carrying constantly kicks your belly in demand for food and wine, and you feel sluggish and horny.  You can't wait to birth this little one so you can finally rest for a while.</b>\n");
                        displayedUpdate = true;
                        //temp min lust up addl +5
                    }
                }
                //BASILISK Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_BASILISK || womb["type"] == PregnancyStore.PREGNANCY_BENOIT) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(185, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(160, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly looks a little pudgy");
                        if (player.thickness > 60 && player.tone < 40) EngineCore.outputText(" even for you");
                        EngineCore.outputText(", maybe you should cut back on all the food you've been consuming lately?</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(140, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(110, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.");
                        if (player.cor < 50) EngineCore.outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.");
                        EngineCore.outputText("</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                            displayedUpdate = true;
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                    }
                }
                //Anemone Pregnancy
                if (womb["type"] == PregnancyStore.PREGNANCY_ANEMONE) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(240, womb["type"])) {
                        EngineCore.outputText("\n<b>You feel something shifting and moving inside you.  You start to think you might be pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(210, womb["type"])) {
                        EngineCore.outputText("\n<b>The fluttering of sensation inside you is getting stronger and more frequent.  At times it even feels as if the inner lining of your womb is tingling.</b>\n");
                        player.dynStats("lus", (5 + player.lib / 20), "scale", false);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(185, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  ");
                        if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("Considering the possible fathers, you hope it isn't that big.</b>");
                        if (player.cor >= 75) EngineCore.outputText("You think dreamily about the cocks that have recently been fucking you, and hope that your offspring inherit such a divine pleasure tool.</b>");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        EngineCore.outputText("\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(154, womb["type"])) {
                        EngineCore.outputText("\n<b>The sudden impact of a strong movement from inside your womb startles you.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your larger, squirming belly makes your pregnancy obvious for those around you");
                        if (player.hasVagina()) EngineCore.outputText(" and keeps your " + vaginaDescript(womb["womb"]) + " aroused from the constant tingling in your womb");
                        EngineCore.outputText(".</b>\n");
                        player.dynStats("lus", (10 + player.lib / 20), "scale", false);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is noticeably distended, ");
                        if (player.cor < 40) EngineCore.outputText("and constantly shifts and wriggles.  What manner of beast are you bringing into the world?</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth, so you can get impregnated again by corrupted or monstrous cum filling out your eager womb.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -3, "lib", 1, "sen", 1, "lus", (5 + player.lib / 20));
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>You rub your hands over your bulging belly, lost in the sensations of motherhood.  ");
                        if (player.cor < 40) EngineCore.outputText("Afterwards you feel somewhat disgusted with yourself, but horny.</b>\n");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("You estimate you'll give birth in the next few days.  You hope the birth is as erotically charged as the pregnancy has been.</b>\n");
                        if (player.cor >= 75) EngineCore.outputText("You find yourself daydreaming  about birthing cilia-covered worms, orgasming each time their thousands of stingers brush by your clit and fill it full of sensation-enhancing drugs.</b>\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", (10 + player.lib / 20));
                        displayedUpdate = true;
                    }
                }
                //Hellhound Pregnancy!
                if (womb["type"] == PregnancyStore.PREGNANCY_HELL_HOUND) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(290, womb["type"])) {
                        EngineCore.outputText("\n<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(240, womb["type"])) {
                        EngineCore.outputText("\n<b>Your belly is getting more noticeably distended and squirming around.  You are probably pregnant.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("\n<b>The unmistakable bulge of pregnancy is visible in your tummy.  It's feeling heavier by the moment.  ");
                        if (player.cor < 40) EngineCore.outputText("You are distressed by your unwanted pregnancy, and your inability to force this thing out of you.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("Considering the size of the creatures you've fucked, you hope it doesn't hurt when it comes out.</b>");
                        if (player.cor >= 75) EngineCore.outputText("You think dreamily about the monstrous cocks that have recently been fucking you, and hope that your offspring inherit such a pleasure tool.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -1, "lib", 1, "sen", 1, "lus", 2);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(180, womb["type"])) {
                        EngineCore.outputText("\n<b>There is a strange heat within your belly, it makes you a little tired.</b>\n");
                        player.dynStats("tou", -1);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        EngineCore.outputText("\n<b>Your ever-growing belly makes your pregnancy obvious for those around you.  With each day you can feel the heat within you growing.</b>\n");
                        displayedUpdate = true;
                        player.dynStats("tou", -1);
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("\n<b>The heat within doesn't drain you as much as it used to, instead giving you an odd strength.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("str", 1, "tou", 1);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(48, womb["type"])) {
                        EngineCore.outputText("\n<b>You can feel two large lumps pushing against your womb together ");
                        if (player.cor < 40) EngineCore.outputText("making it difficult to function.</b>");
                        if (player.cor >= 40 && player.cor < 75) EngineCore.outputText("and you wonder how much longer you have to wait.</b>");
                        if (player.cor >= 75) EngineCore.outputText("and you're eager to give birth, so you can get impregnated again by monstrous cocks unloading their corrupted seed directly into your eager womb.</b>");
                        EngineCore.outputText("\n");
                        player.dynStats("spe", -2, "lib", 1, "sen", 1, "lus", 4);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Frog Eggs
                else if (womb["type"] == PregnancyStore.PREGNANCY_FROG_GIRL) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(8, womb["type"])) {
                        //Egg Maturing
                        if (player.hasVagina()) {
                            EngineCore.outputText("\nYour gut churns, and with a squelching noise, a torrent of transparent slime gushes from your " + player.vaginaDescript(womb["womb"]) + ".  You immediately fall to your knees, landing wetly amidst the slime.  The world around briefly flashes with unbelievable colors, and you hear someone giggling.\n\nAfter a moment, you realize that it’s you.");
                            //pussy:
                            if (player.hasVagina()) EngineCore.outputText("  Against your " + player.vaginaDescript(womb["womb"]) + ", the slime feels warm and cold at the same time, coaxing delightful tremors from your [clit].");
                            //[balls:
                            else if (player.hasBalls()) EngineCore.outputText("  Slathered in hallucinogenic frog slime, your balls tingle, sending warm pulses of pleasure all the way up into your brain.");
                            //genderless:
                            else EngineCore.outputText("  Your " + player.vaginaDescript(womb["womb"]) + " begins twitching, aching for something to push through it over and over again.");
                            EngineCore.outputText("  Seated in your own slime, you moan softly, unable to keep your hands off yourself.");
                            player.dynStats("lus=", player.maxOverLust(), "scale", false);
                            displayedUpdate = true;
                        } else {
                            EngineCore.outputText("\nYour gut churns, but after a moment it settles. Your belly does seem a bit bigger and more gravid afterward, like you're filling up with fluid without any possible vent. You suddenly wonder if losing your pussy was such a great idea.");
                            displayedUpdate = true;
                        }
                    }
                }
                //Minerva Pregnancy
                else if (womb["type"] == PregnancyStore.PREGNANCY_MINERVA) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(216, womb["type"])) {
                        EngineCore.outputText("<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(144, womb["type"])) {
                        EngineCore.outputText("<b>Your distended belly shows obvious signs of pregnancy.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        EngineCore.outputText("<b>Your belly is getting larger.  You feel like you're housing a twin.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(24, womb["type"])) {
                        EngineCore.outputText("<b>Your belly is as big as it can get.  You have a feeling that you'll give birth to a twin soon.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(144, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(72, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Alraune Pregnancy
                else if (womb["type"] == PregnancyStore.PREGNANCY_ALRAUNE) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        if (player.isAlraune()) EngineCore.outputText("<b>You suddenly feel a change in the pitcher below your feet. It feels heavier than before.</b>");
                        else EngineCore.outputText("<b>Your belly increase in size as something not unlike pollen or nectar slowly drip out of your pussy.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(80, womb["type"])) {
                        if (player.isAlraune()) EngineCore.outputText("<b>A delicious feeling of fullness originate from the bottom of your pitcher as you begin daydreaming about children.</b>");
                        else EngineCore.outputText("<b>Some fluids not unlike pollen or nectar flow out of your vagina and you can’t help but pat your inflating belly with motherly delight. Whatever is in there is growing nicely.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(40, womb["type"])) {
                        if (player.isAlraune()) EngineCore.outputText("<b>Somehow due to the weight and delicious feeling in your pitcher you are certain you are pregnant with seeds. A soothing warmth fills you as you smile in delight of your motherhood.</b>");
                        else EngineCore.outputText("<b>Some fluids not unlike pollen or nectar flow out of your vagina and you can’t help but pat your inflating belly with motherly delight. Whatever is in there is growing nicely. Something tells you you will be giving birth soon.</b>");
                        displayedUpdate = true;
                    }
                }
                //Zenji Pregnancy
                else if (womb["type"] == PregnancyStore.PREGNANCY_ZENJI) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(700, womb["type"])) {
                        EngineCore.outputText("As you are resting at your camp, you suddenly feel a pair of fuzzy hands grasp at your shoulders. Zenji leans down and gives you a small sniff.\n\n");
                        EngineCore.outputText("\"<i>Ahaha! [name]! You're pregnant! I'm so glad we've made it dis far.</i>\" He says, caressing your face tenderly as he moves in front of you. \"<i>I need ya to know someting… I don’t tink we’ll be able to have more dan two children, it’s a bit complicated [name], but I don’t tink I am able ta give you anyting more, I’m sorry… Still, having a family wit ya is more dan anyting I could ask for.</i>\"\n\n");
                        EngineCore.outputText("You look down at your stomach and upon careful examination you realize that you are, in fact, pregnant. You smile at him and tell him you’re more than happy to have children with him.\n\n");
                        EngineCore.outputText("Zenji blushes softly, \"<i>It is a pleasure, [name], I will protect our family until de very end.</i>\" He says, hugging you gently as his tail wraps around you.");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(480, womb["type"])) {
                        EngineCore.outputText("<b>You can feel gentle kicking within your stomach. Reflexively you turn you gaze toward Zenji and he gives you a heartwarming smile in response.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(240, womb["type"])) {
                        EngineCore.outputText("Your balance shifts as the time for pregnancy draws closer. Zenji quickly rushes to your side, \"<i>Everyting okay, [name]?</i>\"\n\n");
                        EngineCore.outputText("You nod, stating that you’re not quite ready to give birth yet.\n\n");
                        EngineCore.outputText("Zenji holds you close to him, wrapping you within his strong arms, \"<i>I’ll be ready for you, [name]... We’re in dis togetha.</i>\"\n\n");
                        displayedUpdate = true;
                    }
                }
                //Behemoth Pregnancy
                else if (womb["type"] == PregnancyStore.PREGNANCY_BEHEMOTH) {
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(1152, womb["type"])) {
                        EngineCore.outputText("<b>You realize your belly has gotten slightly larger.  Maybe you need to cut back on the strange food.  However, you have a feel that it's going to be a very long pregnancy.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(864, womb["type"])) {
                        EngineCore.outputText("<b>Your distended belly shows obvious signs of pregnancy.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(576, womb["type"])) {
                        EngineCore.outputText("<b>Your belly is getting larger.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(288, womb["type"])) {
                        EngineCore.outputText("<b>Your belly is as big as it can get.  You have a feeling that you'll give birth to a behemoth soon.</b>");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] == sceneHunter.adjustPregEventTimer(1024, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(768, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(512, womb["type"]) || womb["incubation"] == sceneHunter.adjustPregEventTimer(256, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            EngineCore.outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.  You wonder just what kind of creature they're getting ready to feed.\n");
                            player.boostLactation(.5);
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            EngineCore.outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() == 0) {
                            EngineCore.outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                            EngineCore.outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                        }
                    }
                }
                //Cockatrice Pregnancy
                else if (womb["type"] == PregnancyStore.PREGNANCY_COCKATRICE) {
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(185, womb["type"])) {
                        outputText("\n<b>Your belly grumbles as if empty, even though you ate not long ago.  Perhaps with all the exercise you're getting you just need to eat a little bit more.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(160, womb["type"])) {
                        outputText("\n<b>Your belly looks a little pudgy");
                        if (player.thickness > 60 && player.tone < 40) outputText(" even for you");
                        outputText(", maybe you should cut back on all the food you've been consuming lately?</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(140, womb["type"])) {
                        outputText("\n<b>Your belly is definitely getting bigger, and no matter what you do, you can't seem to stop yourself from eating at the merest twinge of hunger.  The only explanation you can come up with is that you've gotten pregnant during your travels.  Hopefully it won't inconvenience your adventuring.</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(110, womb["type"])) {
                        outputText("\n<b>Your belly has gotten nice and big, perhaps as big as you remember the bellies of the pregnant women back home being.  The elders always did insist on everyone doing their part to keep the population high enough to sustain the loss of a champion every year.  You give yourself a little hug, getting a surge of happiness from your hormone-addled body.  Pregnancy sure is great!</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.  A sense of motherly pride wells up in your breast - you just know you'll have such wonderful babies.");
                        if (player.cor < 50) outputText("  You shudder and shake your head, wondering why you're thinking such unusual things.");
                        outputText("</b>\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(32, womb["type"]) || womb["incubation"] === sceneHunter.adjustPregEventTimer(64, womb["type"]) || womb["incubation"] === sceneHunter.adjustPregEventTimer(85, womb["type"]) || womb["incubation"] === sceneHunter.adjustPregEventTimer(150, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);

                            displayedUpdate = true;
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() === 0) {
                            outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                            displayedUpdate = true;
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
                            outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
                            outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                    }
                }
                //Quasi-Phoenix Pregnancy
                else if (womb["type"] == PregnancyStore.PREGNANCY_QUASI_PHOENIX) {
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(168, womb["type"])) {
                        outputText("\nYour stomach has grown noticeably distended, and feels hard and solid to the touch. A strange warm sensation emanates from within you; you don’t think it’s had any effect on you, but it does feel nice.\n");
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(120, womb["type"])) {
                        outputText("\n<b>You are quite visibly pregnant now, your belly round and firm, easily comparable to a woman exiting her second trimester.</b> The egg in your womb radiates heat, filling your body with its unearthly warmth. You feel tougher, hardier, like the flame in your belly is burning out weakness... But your loins are also full of a far more familiar warmth.\n");

                        player.statStore.addBuffObject({
                            "tou": 1,
                            "lib": 2
                        }, 'Quasi-Phoenix Egg', {text: 'Quasi-Phoenix Egg'});
                        player.addCurse("spe", 3);
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(72, womb["type"])) {
                        outputText("\nA gut like this on a woman back home would normally signal that she’s about to pop, but you have the feeling that the egg inside you isn’t done growing yet. The heat radiating from it is stronger than ever; you wonder if this is what a pot-bellied stove with a roaring fire feels like. You feel hardened and aroused all at once from the ever-burning flames.\n");
                        player.statStore.addBuffObject({
                            "tou": 2,
                            "lib": 3
                        }, 'Quasi-Phoenix Egg', {text: 'Quasi-Phoenix Egg'});
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(24, womb["type"])) {
                        outputText("\nSurely this huge egg can’t grow much bigger; you’re already wondering how you’re going to pass the massive thing! Your stomach looks more like you have a small child curled up inside you than a fully grown baby, and you have to move slower because of how it’s weighing you down. Despite your huge size, you feel hornier and hardier than ever, the heat from inside you literally radiating off of your swollen form and heating up everything nearby.\n");
                        player.statStore.addBuffObject({
                            "tou": 2,
                            "lib": 3
                        }, 'Quasi-Phoenix Egg', {text: 'Quasi-Phoenix Egg'});
                        displayedUpdate = true;
                    }
                    if (womb["incubation"] === sceneHunter.adjustPregEventTimer(16, womb["type"]) || womb["incubation"] === sceneHunter.adjustPregEventTimer(48, womb["type"]) || womb["incubation"] === sceneHunter.adjustPregEventTimer(86, womb["type"])) {
                        //Increase lactation!
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() >= 1 && player.biggestLactation() < 2) {
                            outputText("\nYour breasts feel swollen with all the extra milk they're accumulating.\n");
                            player.boostLactation(.5);
                            displayedUpdate = true;
                        }
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() > 0 && player.biggestLactation() < 1) {
                            outputText("\nDrops of breastmilk escape your nipples as your body prepares for the coming birth.\n");
                            player.boostLactation(.5);

                            displayedUpdate = true;
                        }
                        //Lactate if large && not lactating
                        if (player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.biggestLactation() === 0) {
                            outputText("\n<b>You realize your breasts feel full, and occasionally lactate</b>.  It must be due to the pregnancy.\n");
                            player.boostLactation(1);
                            displayedUpdate = true;
                        }
                        //Enlarge if too small for lactation
                        if (player.biggestTitSize() === 2 && player.mostBreastsPerRow() > 1) {
                            outputText("\n<b>Your breasts have swollen to C-cups,</b> in light of your coming pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                        //Enlarge if really small!
                        if (player.biggestTitSize() === 1 && player.mostBreastsPerRow() > 1) {
                            outputText("\n<b>Your breasts have grown to B-cups,</b> likely due to the hormonal changes of your pregnancy.\n");
                            player.growTits(1, 1, false, 3);
                            displayedUpdate = true;
                        }
                    }
                }
                return displayedUpdate;
            }

        private function birthVag():Boolean {
            var displayedUpdate:Boolean = false;
            if(player.fertility < 15) player.fertility++;
            if(player.fertility < 25) player.fertility++;
            if(player.fertility < 40) player.fertility++;
            if(!player.hasStatusEffect(StatusEffects.Birthed)) player.createStatusEffect(StatusEffects.Birthed,1,0,0,0);
            else {
                player.addStatusValue(StatusEffects.Birthed,1,1);
                if(!player.hasPerk(PerkLib.BroodMother) && player.statusEffectv1(StatusEffects.Birthed) >= 10) {
                    EngineCore.outputText("\n<b>You have gained the Brood Mother perk</b> (Pregnancies progress twice as fast as a normal woman's).\n");
                    player.createPerk(PerkLib.BroodMother,0,0,0,0);
                }
            }
            if(!player.hasVagina()) {
                outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold: a vagina");
                player.createVagina();
            }

            //Give birth to either a faerie or a phouka
            if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) {
                SceneLib.bog.phoukaScene.phoukaPregBirth();
                displayedUpdate = true;
                player.knockUpForce(); //Clear Pregnancy
            }
            //Bive birf to dragons
            if (player.pregnancyType == PregnancyStore.PREGNANCY_EMBER) {
                emberScene.giveBirthToEmberKids();
                displayedUpdate = true;
                player.knockUpForce(); //Clear Pregnancy
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA) {
                displayedUpdate = true;
                urtaPregs.PCGivesBirf();
                player.knockUpForce(); //Clear Pregnancy
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_SAND_WITCH) {
                displayedUpdate = true;
                SceneLib.dungeons.desertcave.birthAWitch();
                player.knockUpForce(); //Clear Pregnancy
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA) {
                displayedUpdate = true;
                //Located in izma.as!
                izmaScene.pcPopsOutASharkTot();
                player.knockUpForce(); //Clear Pregnancy
            }
            //SPOIDAH BIRF
            if (player.pregnancyType == PregnancyStore.PREGNANCY_SPIDER) {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.swamp.maleSpiderMorphScene.spiderPregVagBirth();
            }
            //DRIDER BIRF
            if (player.pregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.swamp.corruptedDriderScene.driderPregVagBirth();
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_COTTON) {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                telAdre.cotton.birthingCottonsKids();
            }
            //GOO BIRF
            if (player.pregnancyType == PregnancyStore.PREGNANCY_GOO_GIRL) {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.lake.gooGirlScene.gooPregVagBirth();
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_BASILISK) {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.mountain.basiliskScene.basiliskBirth();
            }
            //Satyr vag preg
            if (player.pregnancyType == PregnancyStore.PREGNANCY_SATYR) {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.plains.satyrScene.satyrBirth(true);
            }
            //Give birf if its time... to FROG EGGS
            if (player.pregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
                SceneLib.bog.frogGirlScene.layFrogEggs();
                displayedUpdate = true;
                player.knockUpForce(); //Clear Pregnancy
            }
            //Bunbun birfs
            if (player.pregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
                EngineCore.outputText("\n");
                displayedUpdate = true;

                EngineCore.outputText("A dangerous rumble comes from your womb, signaling that it's time to birth your body's cargo at last.  Your [legs] wobble unsteadily as your strength ebbs with every gush that erupts  from your now-broken water until you collapse on your [butt], grunting and groaning.  At first it goes slow – there's just a few small contractions that are more strange than anything else, rippling down your " + vaginaDescript(0) + " and squirting out more of your pregnancy's fluid.  All too soon the tempo kicks up, and you feel something starting to stretch you wider and wider.\n\n");

                EngineCore.outputText("You heave and push, instinctively driven to flex muscles you didn't even know you had to speed the super human labor you've entered into.  ");
                if(player.vaginalCapacity() < 60) EngineCore.outputText("It hurts a little as your cervix starts to stretch wide");
                else EngineCore.outputText("It actually feels kind of nice as your cervix is stretched wide");
                EngineCore.outputText(", but somehow your body accommodates the forced dilation without too much discomfort.  It's soon forgotten as you feel your " + vaginaDescript(0) + " pushed into a large sphere, stretched around the inhuman form of your child as it squirms and writhes inside you on its path to freedom.  You grunt and flex, watching with disbelief as a tiny, rabbit-eared form slides from your slick canal into the grass, the process leaving your " + chestDesc() + " heaving with unexpected pleasure.\n\n");

                EngineCore.outputText("The whole process starts over again – there's another one!  By now your well-stretched pussy is oozing both the birthing fluids and your own lubricants, and the second bunny-child slides down to bump into its sibling with ease.  You shake and shudder, groaning and spasming as you nearly cum from the stimulation, but in the end you're left panting and horny.  The two bunnies look like miniature people except for their ears, tails, and fuzzy legs.  Your children lick themselves clean before hopping up onto your " + chestDesc() + " and suckling your nipples for a while");
                if(player.lactationQ() > 500) EngineCore.outputText(", growing fat from all the milk");
                EngineCore.outputText(".  At last they finish, and with one last nuzzle, your strange bunny-children go hopping off, doubtless to find more of their own kind.\n\n");

                EngineCore.outputText("You sink into restful unconsciousness, marveling at how stretchy and sensitive your " + vaginaDescript(0) + " feels now.");
                player.cuntChange(60,true,true,false);
                player.boostLactation(.01);
                //Boost capacity
                if(player.vaginalCapacity() < 300) {
                    if(!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
                    player.addStatusValue(StatusEffects.BonusVCapacity, 1, 10);
                }
                player.knockUpForce(); //Clear Pregnancy
                player.orgasm();
                player.dynStats("lib", 1, "sen", 10, "cor", -2);
            }
            //Anemone birfs
            //Anemone Pregnancy
            if (player.pregnancyType == PregnancyStore.PREGNANCY_ANEMONE) {
                EngineCore.outputText("\n");
                displayedUpdate = true;

                EngineCore.outputText("Your [armor] feels damp around the groin and you reach down to check the area.  The  " + vaginaDescript(0) + " you feel is dilated and slick with unusual wetness; your water must have broken!\n\n");

                EngineCore.outputText("Hurriedly you strip off your gear and sit down with your back against a rock.  Focusing yourself, you attempt to prepare for labor; you try to remember your recent partners and worry about what kind of monstrous infant you might have to force out of your " + vaginaDescript(0) + ".  The first contraction comes and you push as hard as you can, to be rewarded with the feeling of something sliding out between your labia.  You attempt a few more pushes but nothing further seems forthcoming; curious, you look down at your crotch only to discover a blue stalk sticking proudly out of your vagina!\n\n");

                if(flags[kFLAGS.ANEMONE_KID] > 0 && flags[kFLAGS.DONT_TAKE_ANEMONES_PLEZ] == 0) {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + clitDescript() + "!   It writhes and slips out of your pain-wracked hands, leaving them tingling.  As you lie there, stunned, it begins to inch back toward your " + vaginaDescript(0)+ ".  Footfalls sound next to you, and a blue hand picks up the squirming, cilliated creature.  Kid A gives you a shy smile, then turns to her barrel.  A quick splash and a filled waterskin later, she heads toward the stream, toting your grub-like offspring.");
                    player.cuntChange(20,true,true,false);
                    EngineCore.outputText("\n\nExhausted by the birth but with a burden lifted from your mind, you slip into a grateful doze.");
                    player.knockUpForce(); //Clear Pregnancy
                    return true;
                }
                else if(player.anemoneCocks() > 0 && player.cor <= 50 + player.corruptionTolerance && flags[kFLAGS.ANEMONE_KID] == 0) {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + clitDescript() + " makes you lock up and nearly takes away your consciousness, and with " + player.multiCockDescript() + " in the way, you can't get any leverage on the pull at all!  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + vaginaDescript(0)+ ".  Searching about weakly with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; shocked into sense, you look at the absurd creature.  You raise your arm to slap at it, but something stays your hand.  As if sensing your hesitation, it stands upright and holds itself at attention for inspection.  It would be easy to knock it away... and yet, the unprepossessing little thing looks so proud that you can't quite bring yourself to do so.");
                    EngineCore.outputText("\n\nYou scoop the diminutive anemone up and look around for somewhere wet to put it.  The stream is too far, the lake doubly so; you'd never make it to either, as sick as you feel from yanking viciously on your clitoris.  Driven to last resorts, you lurch over to the water barrel in your camp and, wrenching the lid off, drop the blue stalk unceremoniously inside.  Exhausted by the shock and pain of the ordeal, you slump down beside the barrel and slip into a doze...");
                    player.cuntChange(20,true,true,false);
                    EngineCore.outputText("\n");
                    player.createStatusEffect(StatusEffects.CampAnemoneTrigger,0,0,0,0);
                    player.knockUpForce(); //Clear Pregnancy
                    return true;
                }
                //[(if pc has 0-9 existing cocks)
                else if(player.cockTotal() < 10) {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + clitDescript() + "!  The small anemone and you both lay there twitching, but it recovers its bearings first; through your haze of pain you watch it flexing its body, wedging the head under itself, and elevating the base.");
                    player.cuntChange(20,true,true,false);

                    EngineCore.outputText("\n\nBeset by a panic, you watch as the strange thing sets butt-end down on your pubic mound and adheres");
                    //[(if cocks)
                    if(player.cockTotal() > 0) EngineCore.outputText(" below your " + player.multiCockDescriptLight());
                    EngineCore.outputText(". A sharp pinch lances through the nerves in your groin and sends your hands to it reflexively.  This smaller pain, coupled with the adrenaline and dopamine that have finally chased the fog from your head, is enough to pull your thoughts into focus for another attempt to remove your strange, parasitic offspring.  You shift your grip and pull a few more times, but the thing doesn't budge.  The handling of it only serves to make the stalk thicken and become stiff; gradually you notice that you're feeling the sensation of your own pulling not from the skin at the point of attachment but from the stalk itself, and this realization is accompanied by the ring of tentacles opening and pulling back to reveal the crown of a penis!  <b>You have a new anemone-penis!</b>");
                    //[(dick slot 1 exists)
                    if(player.cockTotal() > 0) EngineCore.outputText("  The tentacles writhe around, rubbing against your " + player.multiCockDescriptLight());
                    //(doesn't exist)
                    else EngineCore.outputText("  The tentacles curl inwards, rubbing on the head of your new blue pecker");
                    player.createCock((4+rand(3)),1.2, CockTypesEnum.ANEMONE);
                    EngineCore.outputText(" and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress [eachcock] sensually, leaving behind a tingling trail of vibrant pleasure");
                    //[(if no dick1 and no balls)
                    if(player.cockTotal() == 1 && player.balls == 0) EngineCore.outputText("; you feel a pressure build below the shaft, near your asshole");
                    EngineCore.outputText(".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ");
                    if(player.cumQ() < 100) EngineCore.outputText("glob");
                    else if(player.cumQ() < 500) EngineCore.outputText("squirt");
                    else EngineCore.outputText("spray");
                    EngineCore.outputText(" of semen shoots from your new penis and lands on your ");
                    //[(if boobs)
                    if(player.biggestTitSize() >= 1) EngineCore.outputText(allBreastsDescript() + " and ");
                    EngineCore.outputText("stomach");
                    //[(dick1 exists)
                    if(player.cockTotal() > 1) EngineCore.outputText(", followed in short order by white squirts from [eachcock] remaining");
                    EngineCore.outputText(".  Your " + vaginaDescript(0) + " quivers and pulses as well, adding ");
                    if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK) EngineCore.outputText("a trickle");
                    else if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLAVERING) EngineCore.outputText("a squirt");
                    else EngineCore.outputText("nearly a cupful of fluid");
                    EngineCore.outputText(" from your female orgasm to the puddle on the ground below your ass.");
                    Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.ANEMONE));
                    //(gain 1 nemo-dick, reduce lust to min)]
                    player.orgasm();
                    player.dynStats("lib", 2, "sen", 5);
                }
                //[(if PC has 10 existing cocks) && no kid
                else {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + clitDescript() + " makes you lock up and nearly takes away your consciousness, robbing your pull of force.  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + vaginaDescript(0)+ ".  Casting about with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; renewed, you slap at it, trying to knock the little creature away.  Several weak hits land on it, and, almost as if irritated, the tentacles seize on your labia and pull the stalk back toward your crotch and thence into your pussy.  Next you feel the thing shift and flatten itself against your insides, then a pinch on your vaginal walls where the little anemone presses on them.  This can't be good.");
                    player.cuntChange(20,true,true,false);
                    EngineCore.outputText("\n\nPush as you might, you can't get it to peek back out even the slightest bit.  What's worse, the heat isn't subsiding, as the tentacles are now lodged inside your pussy!  Prodding and pulling at your " + vaginaDescript(0) + " is only worsening the effect; [eachcock] and your clitoris harden as you attempt to retrieve your invader.  Your probes get weaker and weaker as your vagina spasms to each stroke of your insides; each time you touch the creature, the sensation is being transmitted right back to your nerves.  Eventually you push yourself to accidental orgasm; your " + vaginaDescript(0) + " quivers around your fingers, and your [cocks] does the best ejaculation it can manage with hardly any warmup time and no direct stimulation.  Even after the orgasm ends, the tentacles continue to torment your groin.  <b>You are VERY horny with this thing inside you... though you can't reach it, maybe there's a way to crowd it out?</b>\n\n");
                    //(reduce lust to min, increased minimum lust by 30 until halfway through PC's next pregnancy)]
                    player.orgasm();
                    player.dynStats("lib", 2, "sen", 5);
                    if(!player.hasStatusEffect(StatusEffects.AnemoneArousal)) player.createStatusEffect(StatusEffects.AnemoneArousal,0,0,0,0);
                    player.buff("AnemoneArousal").setStat("minlustx", 0.3).withText("Anemone parasite");
                }
                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("[pg]Exhausted by the 'birth' and the climax, you slip into a doze.\n");
            }
            //Give birth to Celess
            if (player.pregnancyType == PregnancyStore.PREGNANCY_CELESS){
                player.knockUpForce(); //Clear Pregnancy
                CelessScene.instance.birthScene();
                return false;
            }
            //Birth to harpy
            if (player.pregnancyType == PregnancyStore.PREGNANCY_HARPY_EGGS){
                EngineCore.outputText("\n");
                //Large egg scene
                EngineCore.outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your [armor] before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ");
                if(player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) EngineCore.outputText("stretching your tight cunt painfully, the lips opening wide ");
                if(player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("temporarily stretching your cunt-lips wide-open ");
                if(player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("parting your already gaping lips wide ");
                EngineCore.outputText("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ");
                if(player.clitLength > 5) EngineCore.outputText("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ");
                if(player.clitLength > 2 && player.clitLength <= 5) EngineCore.outputText("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ");
                if(player.clitLength <= 2) EngineCore.outputText("your " + vaginaDescript(0) + " by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ");
                EngineCore.outputText("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ");
                if(player.statusEffectv3(StatusEffects.Eggs) >= 11) EngineCore.outputText("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your " + vaginaDescript(0) + " as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ");
                EngineCore.outputText("\n\nYou gaze down at the mess, counting " + eggDescript() + ".");
                player.orgasm();
                player.dynStats("scale", false);

                EngineCore.outputText("\n\nWhile many of your eggs are not fertile, one in particular stands out. <b>Powerful motherly instinct compels you to keep and protect this egg with your life!</b>" +
                        " This egg is your precious baby and you won't let anyone damage it least of all a big dicked demon." +
                        "\n\nWith unshakable resolve you carefully bring the egg to your nest and proceed to tenderly wrap it in clothes and material to keep it warm when you ain't there to hatch it.");
                SophieFollowerScene.HarpyEggHatching = true;
                player.cuntChange(20, true);
                player.knockUpForce(); //Clear Pregnancy
                player.knockUp(PregnancyStore.PREGNANCY_HARPY_HATCHING, PregnancyStore.PREGNANCY_HARPY_HATCHING, 1, 1); //Set Player to Hatching stage
                return false;
            }

            //Give birth to Zenji kid
            if (player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI){
                player.knockUpForce(); //Clear Pregnancy
                flags[kFLAGS.EVENT_PARSER_ESCAPE] = 1;//Do not doNext to camp, pregnancy event set ups menu - also if this flag is used can skip adding "return false/true;"
                SceneLib.zenjiScene.birthScene();
            }
            //Give birth if it's time (to an imp!)
            if (player.pregnancyType == PregnancyStore.PREGNANCY_IMP) {
                EngineCore.outputText("\n");
                //Add imp birth status - used to control frequency of night imp gangbag
                if(player.hasStatusEffect(StatusEffects.BirthedImps)) player.addStatusValue(StatusEffects.BirthedImps,1,1);
                else player.createStatusEffect(StatusEffects.BirthedImps,1,0,0,0);

                EngineCore.outputText("A sudden gush of fluids erupts from your vagina - your water just broke.  You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.  ");
                if(player.cor < 50) EngineCore.outputText("You rue the day you encountered that hateful imp.  ");
                EngineCore.outputText("The pain begins to subside as your delivery continues... replaced with a building sensation of pleasure.  Arousal spikes through you as the contractions intensify, and as you feel something pass you have a tiny orgasm.\n\nYet you feel more within you, and the contractions spike again, pushing you to orgasm as you pass something else.  It repeats, over and over, nearly a dozen times you birth and orgasm.  After an eternity of procreation and pleasure, you sense your ordeal is over and collapse, unconscious.");


                if(player.vaginas[0].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) player.vaginas[0].vaginalLooseness++;
                //50% chance
                if(player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE && rand(2) == 0) {
                    player.vaginas[0].vaginalLooseness++;
                    EngineCore.outputText("\n\n<b>Your cunt is painfully stretched from the ordeal, permanently enlarged.</b>");
                }

                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("\n\nWhen you wake you find a large number of tiny imp tracks... and a spattering of cum on your clothes and body.  They must be born fully-formed.");
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("  Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(.5);
                }
                //Lactate if large && not lactating
                if(player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.averageLactation() == 0) {
                    EngineCore.outputText("  As you ponder the implications, <b>you realize your breasts have been slowly lactating</b>.  You wonder how much longer it will be before they stop.");
                    player.boostLactation(1);
                }
                player.boostLactation(.01);
                //Enlarge if too small for lactation
                if(player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                    EngineCore.outputText("  <b>Your breasts have grown to C-cups!</b>");
                    player.growTits(1, 1, false, 3);
                }
                //Enlarge if really small!
                if(player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                    EngineCore.outputText("  <b>Your breasts have grown to B-cups!</b>");
                    player.growTits(1, 1, false, 3);
                }
                if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
                player.orgasm();
                player.dynStats("tou", -2, "spe", 2, "lib", 1, "sen", .5, "cor", 7);
                if(player.butt.type < 10 && rand(2) == 0) {
                    player.butt.type++;
                    EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                }
                else if(player.hips.type < 10) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                EngineCore.outputText("\n");
                displayedUpdate = true;
            }
            //Give birth if it's time (to a cowgirl!)
            if (player.pregnancyType == PregnancyStore.PREGNANCY_MARBLE) {
                player.knockUpForce(); //Clear Pregnancy
                player.boostLactation(.01);

                //If you like terrible outcomes
                if(flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 100) {
                    EngineCore.outputText("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble doesn't seem to be around right now, so you can do nothing but push.\n\n");

                    EngineCore.outputText("You push and heave with all your might, little else going through your mind. You somehow register when the head comes out, and soon the shoulders along with the rest of the body follow.  You lean back and pant for a while before feeling a pair of hands grab a hold of you. They slowly and clumsily feel up your body before finding your [chest] and a mouth quickly closes down on a " + nippleDescript(0) + ".  You sigh softly, and drift off to sleep.");
                    player.cuntChange(20,true,true,false);

                    EngineCore.outputText("\n\nEventually you feel a hand on your face, and open your eyes to see Marble looking down at you.  \"<i>Sweetie, are you all right?  Why aren't you pregnant anymore?  Where is our child?</i>\" You stand up and look around.  There is no sign of the baby you were carrying; the child seems to have left after finishing its drink. You never even got to see its face...\n\n");

                    EngineCore.outputText("Marble seems to understand what happened, but is really disappointed with you, \"<i>Sweetie, why couldn't you wait until after I'd finished the nursery...?</i>\"");
                    //Increase PC's hips as per normal, add to birth counter
                }
                else {

                    EngineCore.outputText("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble rushes over and sees that it's time for you to give birth, so she picks you up and supports you as you continue pushing the child out of your now-gaping " + vaginaDescript(0) + ".");
                    //50% chance of it being a boy if Marble has been purified
                    if(flags[kFLAGS.MARBLE_PURIFIED] > 0 && rand(2) == 0)
                            //it's a boy!
                    {
                        EngineCore.outputText("\n\nFor the next few minutes, you can’t do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It’s a son of mine!</i>\" she tells you, but you can barely hear her due to the focus you’re putting into the task of bringing this child out.");
                        EngineCore.outputText("\n\nYou give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you’ve pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small bull boy cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a boy that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when he came out.");
                        EngineCore.outputText("\n\nShe helps you stand up and gives you the little boy to suckle for yourself.");
                        EngineCore.outputText("\n\nYou put the child to your breast and let him drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It’s a really good feeling, isn’t it?</i>\"  You can’t help but nod in agreement.  After a minute the little boy has had enough and you put him into the nursery.");

                        EngineCore.outputText("The little boy is already starting to look like he is a few years old; he’s trotting around on his little hoofs.");
                        //Increase the size of the PC’s hips, as per normal for pregnancies, increase birth counter
                        if(player.hips.type < 10) {
                            player.hips.type++;
                            EngineCore.outputText("After the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                        }
                        if (flags[kFLAGS.MARBLE_BOYS] == 0)
                                //has Marble had male kids before?
                        {
                            EngineCore.outputText("You notice that Marble seems to be deep in thought, and you ask her what is wrong.  She starts after a moment and says, \"<i>Oh sweetie, no, it's nothing really.  I just never thought that I'd actually be able to father a son is all.  The thought never occurred to me.\"</i>");
                        }
                        //Add to marble-kids:
                        if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) {
                            flags[kFLAGS.MARBLE_KIDS] += 2;
                            flags[kFLAGS.MARBLE_BOYS] += 2;
                        }
                        else {
                            flags[kFLAGS.MARBLE_KIDS]++;
                            flags[kFLAGS.MARBLE_BOYS]++; //increase the number of male kids with Marble
                        }
                    }
                    else // end of new content
                            //it's a girl!
                    {
                        player.cuntChange(20,true,true,false);
                        EngineCore.outputText("\n\nFor the next few minutes, you can't do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It's a daughter of mine!</i>\" she tells you, but you can barely hear her due to the focus you're putting into the task of bringing this child out.\n\n");
                        EngineCore.outputText("You give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you've pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small cowgirl cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a girl that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when she came out.\n\n");
                        EngineCore.outputText("She helps you stand up and gives you the little girl to suckle for yourself.  ");
                        if(player.statusEffectv4(StatusEffects.Marble) >= 20) {
                            EngineCore.outputText("As the child contentedly drinks from your " + nippleDescript(0) + ", Marble tells you, \"<i>Sweetie, somehow I know that our kids won't have to worry about the addictive milk.  It will only make them healthy and strong.</i>\"  You nod at her and put the child into the nursery.  ");
                        }
                        else {
                            EngineCore.outputText("You put the child to your breast and let her drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It's a really good feeling, isn't it?</i>\"  You can't help but nod in agreement.  After a minute the little girl has had enough and you put her into the nursery.\n\n");
                        }
                        EngineCore.outputText("The little girl is already starting to look like she is a few years old; she's trotting around on her little hooves.");
                        //Add to marble-kids:
                        if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.MARBLE_KIDS] += 2;
                        else flags[kFLAGS.MARBLE_KIDS]++;
                    }
                    //Increase the size of the PC's hips, as per normal for pregnancies, increase birth counter
                    if(player.hips.type < 10) {
                        player.hips.type++;
                        EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                    }
                }
                EngineCore.outputText("\n");
                displayedUpdate = true;
            }
            //Give birth if it's time (to a minotaur!)
            if (player.pregnancyType == PregnancyStore.PREGNANCY_MINOTAUR) {

                player.boostLactation(.01);
                //Main Text here
                EngineCore.outputText("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it bulges and shifts as another living being moves independently inside you. Instinctively, you spread your legs as you feel the creature press outward, parting your cervix.\n\nYou try to push with your vaginal muscles, but you feel the creature moving more of its own volition. Your lips part as a pair of black-furred hands grip your vulva and begin to spread them and pull. You cry out in agony as your hips are widened forcefully by the passing mass of the being exiting your womb. A bovine face appears, mercifully lacking in horns. Shoulders follow, muscles already rippling on the newborn's form. A thick barrel chest follows, narrow, masculine hips and powerful bovine legs and hooves.\n\nFinally the worst is over as the toddler-sized minotaur gets to his feet, apparently already able to stand and walk.  He clops around your legs and over to your upper body, and takes hold of one of your milk-swollen breasts. He wraps his bestial lips around your nipple and begins to suckle, relieving the pressure on the milk-swollen jug.\n\n");
                EngineCore.outputText("He suckles and suckles and suckles, leaving you to wonder just how much milk you were actually holding, but even as you wonder this, your eyes grow wide as the newborn minotaur begins to grow. He gains inches at a time, his horns starting to grow from his skull, his muscles rippling and thickening, his cock lengthening, his balls swelling. He reaches four feet tall, but keeps growing, soon then five feet tall, starting to resemble more and more the monster who sired him. Finally, he pulls off your breasts, and finishes his milk-inspired growth spurt at six feet tall, looking practically full grown. His one gesture of gratitude for being brought into the world is a slobbery lick at your cheek, then he turns and runs off towards the mountain, leaving you to recover from the ordeal.  You swiftly pass out.\n\n");
                player.knockUpForce(); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(1);
                }
                player.cuntChange(120, true,true,false);
                if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Hip and butt increase
                if(player.butt.type < 12 && rand(2) == 0) {
                    player.butt.type++;
                    EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                }
                else if(player.hips.type < 15) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("\n");
                //326 Number of sons grown
                //327 Number of sons pending
                //328 growup countdown
                if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.MINOTAUR_SONS_CHILDREN] += 2;
                else flags[kFLAGS.MINOTAUR_SONS_CHILDREN]++;
                if(flags[kFLAGS.MINOTAUR_SONS_GROW_COUNTDOWN] == 0) flags[kFLAGS.MINOTAUR_SONS_GROW_COUNTDOWN] = 150;
            }
            //Amily failsafe - converts PC with pure babies to mouse babies if Amily is corrupted
            if (player.pregnancyType == PregnancyStore.PREGNANCY_AMILY)
            {
                if(flags[kFLAGS.AMILY_FOLLOWER] == 2 || flags[kFLAGS.AMILY_CORRUPTION] > 0) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
            }
            //Amily failsafe - converts PC with pure babies to mouse babies if Amily is with Urta
            if (player.pregnancyType == PregnancyStore.PREGNANCY_AMILY)
            {
                if(flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancyIncubation);
            }
            //Give birth if it's time (to an AMILY BITCH mouse!)
            if (player.pregnancyType == PregnancyStore.PREGNANCY_AMILY) {
                player.boostLactation(.01);
                EngineCore.outputText("\n");

                //FUCKING BIRTH SHIT HERE.
                amilyScene.pcBirthsAmilysKidsQuestVersion();
                player.cuntChange(60, true, true, false);
                if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
                displayedUpdate = true;
                EngineCore.outputText("\n");
                player.knockUpForce(); //Clear Pregnancy
            }
            //Give birth to goblins
            if (player.pregnancyType == PregnancyStore.PREGNANCY_GOBLIN) {
                player.boostLactation(.01);
                player.knockUpForce(); //Clear Pregnancy
                flags[kFLAGS.EVENT_PARSER_ESCAPE] = 1;//Do not doNext to camp, pregnancy event set ups menu - also if this flag is used can skip adding "return false/true;"
                SceneLib.camp.campScenes.goblinsBirthScene();
                return false;
            }
            //Give birth if it's time (to a mouse!)
            if ((player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_JOJO)) {
                player.boostLactation(.01);
                EngineCore.outputText("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n\n");


                //Main Text here
                if (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (monk < 0 || flags[kFLAGS.JOJO_BIMBO_STATE] == 3)) {
                    if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3) {
                        SceneLib.joyScene.playerGivesBirthToJoyBabies();
                        player.knockUpForce(); //Clear pregnancy
                        return true;
                    }
                    else SceneLib.jojoScene.giveBirthToPureJojoBabies();
                }
                else {
                    EngineCore.outputText("Pain shoots through you as they pull open your cervix forcefully. You grip the ground and pant and push as the pains of labor overwhelm you. You feel your hips being forceably widened by the collective mass of the creatures moving down your birth canal. You spread your legs wide, laying your head back with groans and cries of agony as little white figures begin to emerge from between the lips of your abused pussy. Large innocent eyes, even larger ears, cute little muzzles, long slender pink tails all appear as the figures emerge. Each could be no larger than six inches tall, but they seem as active and curious as if they were already developed children. \n\n");
                    EngineCore.outputText("Two emerge, then four, eight... you lose track. They swarm your body, scrambling for your chest, and take turns suckling at your nipples. Milk does their bodies good, making them grow rapidly, defining their genders as the girls grow cute little breasts and get broader hips and the boys develop their little mouse cocks and feel their balls swell. Each stops suckling when they reach two feet tall, and once every last one of them has departed your sore, abused cunt and drunk their fill of your milk, they give you a few grateful nuzzles, then run off towards the forest, leaving you alone to recover.\n");
                }
                player.knockUpForce(); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("Your [chest] won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(.5);
                }
                player.cuntChange(60, true,true,false);
                if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Butt increase
                if(player.butt.type < 14 && rand(2) == 0) {
                    if(player.butt.type < 10) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts grow slower!
                    else if(player.butt.type < 14 && rand(2) == 0) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                EngineCore.outputText("\n");
            }
            //Centaur Baby!
            if ((player.pregnancyType == PregnancyStore.PREGNANCY_CENTAUR || player.pregnancyType == PregnancyStore.PREGNANCY_KELT)) {
                EngineCore.outputText("\nYou blink, feeling a sudden ache of need radiating from your massive stomach. You can't even get off the ground, it is so heavy... you simply lie on your side, panting with desire, as the convulsions start. New life moves beneath your stomach, ready to be born, and it is time to do your part.\n\n");

                //Main Text here
                player.boostLactation(.01);
                EngineCore.outputText("Perhaps strangely, there is no pain, just a steady, rhythmic compulsion that directs you to breathe steadily and spread your legs as wide as possible. You hardly have to push at all, as the child - no, your child, begins pressing against the walls of your womb, searching for escape. It finds it, and begins the arduous task of squeezing through your cervix, making you gasp with barely concealed pleasure.  It doesn't even hurt; there's only a dull little whisper of happiness followed by a tide of satisfaction.\n\n");
                EngineCore.outputText("The head comes first, and your first thought is relief as you see the face of a small, elfin child.  She's slick with afterbirth and pushing her way free. But the greater part is to come.  She pulls her body free, easily twice as large as her human torso. Soft downy fur with long, spindly legs and a bristly tail... she is a centaur! You help as best as you can, proud of your achievement, but are too exhausted by the ordeal. Your newfound daughter does most of the work.\n\n");
                EngineCore.outputText("She cannot stand, at first, and stumbles over her own shaky legs in a cute, innocent way. She appears to be a six-year old girl, stuck on top of the body of a young foal, and your heart goes out to her involuntarily. She manages to stand at last, wobbling uncertainly, and moves immediately towards your prone form. Knowing her needs, you reveal a breast to her, and she nickers affectionately before latching on, drinking hungrily from your heavily lactating teat.\n\n");
                EngineCore.outputText("She drinks endlessly, and seems more alive and stronger with every gulp. Hours pass in quiet, motherly bliss as she drains your breastmilk first from one breast, then the other. Her little stomach bulges slightly, but she does not stop, and you do not want her to. Even with the strange, soothing effect of the pregnancy wearing off, you feel nothing but affection for this child.\n\n");
                EngineCore.outputText("By the time she is finished, the centaur girl is obviously stronger, able to stand and move about on her own. She explores her new body, jumping and prancing happily, while you lay back and watch, too exhausted to join her. Suddenly, though, her ears perk up, as she looks towards the horizon urgently. She hesitates just long enough to plant a sweet kiss on your cheek, then dashes off, smiling broadly. Exhausted, you are unable to follow... but that comforting sensation returns.  Somehow, you sense she will be all right.");
                player.knockUpForce(); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("  Your [allbreasts] won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(.5);
                }
                EngineCore.outputText("  ");
                player.cuntChange(100, true);
                if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -4, "spe", 2, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Butt increase
                if(player.butt.type < 14 && rand(2) == 0) {
                    if(player.butt.type < 10) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts grow slower!
                    else if(player.butt.type < 14 && rand(2) == 0) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Give birth if it's time (to a hellhound!)
            if (player.pregnancyType == PregnancyStore.PREGNANCY_HELL_HOUND) {
                EngineCore.outputText("\nYou are suddenly awoken by the heat inside your womb suddenly flaring up rather intensely.  It gives you a sudden charge of energy and you feel a strong need to stand up.  You can feel the two heads moving inside of you and you know that a hellhound will soon be born.  Guided by your instincts, you spread your legs and squat down, but wonder how exactly you are going to pass a creature with two heads?\n\n");

                EngineCore.outputText("Hearing a hiss, you look down to see drops of water hitting the ground and instantly turning to steam.  There is unnatural heat filling you, it's hot enough to boil water; but thanks to the creature inside you, you're barely feeling a thing!  More energy fills you and you begin to push down on the child within in earnest.  The process is painful, but satisfying; you feel like you could push out a mountain with the energy you have right now.  Within a minute, you can feel the heads emerge.  The heads are quickly followed by the rest of the body and you catch your hellhound child in your hands and lift it up to look at it.\n\n");
                EngineCore.outputText("You can see the distinctive dog heads are wrapped around each other and yipping softly; a hint of flame can sometimes be seen inside their mouths.  Its cute paws are waving in the air looking for purchase, but the rest of its body looks entirely human except for the double dicks, and it even has your skin color.  Its mouths are aching for nutrition, and you realize that your breasts are filled with what this pup needs and pull it to your chest.  Each head quickly finds a nipple and begins to suckle.  Having finished the birthing, you contentedly sit back down and bask in the feeling of giving milk to your child, or is it children?\n\n");
                EngineCore.outputText("You sit there in a state of euphoria for some time.  It's not until the child in front of you starts to become uncomfortably hot and heavy, that you are brought back to reality.  You look down to see that the hellhound pup has grown to three times its original size and even sprouted the distinctive layer of tough black fur.  The beast is licking contentedly at your breasts instead of sucking.  It was the now-full flames in its mouth that had broken your reverie, but before you get a real grasp of what had happened, the hellhound pulls away from you and gives you a few quick happy barks before turning around and running off into the wilds, dropping down onto four legs just before disappearing from view.  You feel the unnatural strength you gained during the birth fade away, and you fall into a deep contented sleep.\n\n");
                player.boostLactation(.01);
                //Main Text here
                player.knockUpForce(); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.  ");
                    player.boostLactation(.5);
                }
                player.cuntChange(60, true);
                if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[0].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -1, "spe", 2, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Butt increase
                if(player.butt.type < 14 && rand(2) == 0) {
                    if(player.butt.type < 10) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts grow slower!
                    else if(player.butt.type < 14 && rand(2) == 0) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                EngineCore.outputText("\n");
            }
            //Give birth to sirens.
            if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA) {

                if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) SceneLib.mountain.minervaScene.minervaCorruption.corruptPlayerBirth();
                else SceneLib.mountain.minervaScene.minervaPurification.playerGivesBirth();

                if(player.hips.type < 10) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Give birth to alraune seeds.
            if (player.pregnancyType == PregnancyStore.PREGNANCY_ALRAUNE) {
                if (player.isAlraune()) {
                    EngineCore.outputText("\n\nWith a sudden gush of nectar you feel something slowly sliding out of you, slowly but steadily prying your body open. Something is coming out and it feels so good, to the point of leaving you spasming periodically.");
                    EngineCore.outputText("\n\nYour eyes roll inward and you feel your consciousness partially shut down from the consecutive orgasms, as you feel seeds the size of an apple each, drop one by one out of a hidden hole under your pitcher that might as well be a second pussy from how sensitive it is. One, two, three... Eventually, you lose count of the seeds as you temporarily lose the capability of rational thought. Before long the ground is littered with your seeds. Both instinct and common sense tell you they won't grow up if you just leave them there, on top of the ground, and as such you proceed to sow them in the fertile earth around your camp, promising to yourself that you will water them everyday. You can’t help but want to do this again as soon as possible.");
                }
                else if (player.isLiliraune()) {
                    EngineCore.outputText("\n\nWith a sudden gush of nectar, you feel that something, somewhere, is slowly sliding out of you, " +
                            "prying your body open with slow but steady progress. Something is coming out and it feels so good, " +
                            "causing you to periodically spasm in reaction to the crashing waves of pleasure rushing to your brain. " +
                            "Your twin sister is in no better condition and you both strongly hug each other, squeezing your breasts together, as both of you go into labor.\n\n" +
                            "\"<i>Ahhhhh sis... it’s coming!</i>\"\n\n" +
                            "\"<i>I feel it too!! Ahhh Cummiiiiing!</i>\"\n\n" +
                            "Your eyes roll inward and both of you orgasm as you feel seeds, " +
                            "each the size of an apple drop, one by one, out of a hidden hole under your pitcher that might as well be a third pussy. " +
                            "Well, you pondered how you would give birth while bathing in your pitcher and now you know. One, two, three... " +
                            "Eventually, you lose count of the seeds as your mind temporarily loses the ability to think rationally.  " +
                            "Before long the ground is covered with seeds, your seeds. Something tells you they won't grow big if you just leave them here on top of the ground, " +
                            "and as such you proceed to bury them in the fertile earth around your camp, promising yourself that you will water them every day. " +
                            "You can’t help but think that you want to do this again as soon as possible.");
                }
                else {
                    EngineCore.outputText("\n\nWith a sudden gush of nectar you feel something slowly sliding out of you, prying your body open with slow but steady progress. Something is coming out and it feels so good, causing you to periodically spasm in reaction to the crashing waves of pleasure rushing to your brain. You pussy starts gushing and you know exactly what is coming next.");
                    EngineCore.outputText("\n\nYour eyes roll inward and you lose yourself to consecutive orgasms as you feel seeds the size of an apple drop, one by one, out of your abused pussy. One, two, three... Eventually, you lose count of the seeds as your mind temporarily loses the ability of rational thought.  Before long the ground is covered with seeds which you proceed to swiftly throw away in the forest. Despite how wrong it was you can’t help but think you want to do this again as soon as possible.");
                }
                if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.ALRAUNE_SEEDS] += 10;
                else flags[kFLAGS.ALRAUNE_SEEDS] += 5;
                if (flags[kFLAGS.ALRAUNE_GROWING] < 1) flags[kFLAGS.ALRAUNE_GROWING] = 1;
                player.dynStats("lib", 1, "sen", 5);
                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Give birth to behemoth.
            if (player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH) {
                SceneLib.volcanicCrag.behemothScene.giveBirthToBehemoth();
                if(player.hips.type < 10) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                player.knockUpForce(); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Egg status messages
            if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
                EngineCore.outputText("\n");
                //Small egg scenes
                if(player.statusEffectv2(StatusEffects.Eggs) == 0) {
                    //light quantity
                    if(player.statusEffectv3(StatusEffects.Eggs) < 10) {
                        EngineCore.outputText("You are interrupted as you find yourself overtaken by an uncontrollable urge to undress and squat.   You berate yourself for giving in to the urge for a moment before feeling something shift.  You hear the splash of fluid on the ground and look down to see a thick greenish fluid puddling underneath you.  There is no time to ponder this development as a rounded object passes down your birth canal, spreading your feminine lips apart and forcing a blush to your cheeks.  It plops into the puddle with a splash, and you find yourself feeling visibly delighted to be laying such healthy eggs.   Another egg works its way down and you realize the process is turning you on more and more.   In total you lay ");
                        EngineCore.outputText(eggDescript());
                        EngineCore.outputText(", driving yourself to the very edge of orgasm.");
                        player.dynStats("lus=", player.maxOverLust(), "scale", false);
                    }
                    //High quantity
                    else {
                        EngineCore.outputText("A strange desire overwhelms your sensibilities, forcing you to shed your [armor] and drop to your hands and knees.   You manage to roll over and prop yourself up against a smooth rock, looking down over your pregnant-looking belly as green fluids leak from you, soaking into the ground.   A powerful contraction rips through you and your legs spread instinctively, opening your " + vaginaDescript(0) + " to better deposit your precious cargo.   You see the rounded surface of an egg peek through your lips, mottled with strange colors.   You push hard and it drops free with an abrupt violent motion.  The friction and slimy fluids begin to arouse you, flooding your groin with heat as you feel the second egg pushing down.  It slips free with greater ease than the first, arousing you further as you bleat out a moan from the unexpected pleasure.  Before it stops rolling on the ground, you feel the next egg sliding down your slime-slicked passage, rubbing you perfectly as it slides free.  You lose count of the eggs and begin to masturbate, ");
                        if(player.clitLength > 5) EngineCore.outputText("jerking on your huge clitty as if it were a cock, moaning and panting as each egg slides free of your diminishing belly.  You lubricate it with a mix of your juices and the slime until ");
                        if(player.clitLength > 2 && player.clitLength <= 5) EngineCore.outputText("playing with your over-large clit as if it were a small cock, moaning and panting as the eggs slide free of your diminishing belly.  You spread the slime and cunt juice over it as you tease and stroke until ");
                        if(player.clitLength <= 2) EngineCore.outputText("pulling your folds wide and playing with your clit as another egg pops free from your diminishing belly.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself until ");
                        EngineCore.outputText("you quiver in orgasm, popping out the last of your eggs as your body twitches nervelessly on the ground.   In total you lay " + eggDescript() + ".");
                        player.orgasm();
                        player.dynStats("scale", false);
                    }
                }
                //Large egg scene
                else {
                    EngineCore.outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your [armor] before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ");
                    if(player.vaginas[0].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) EngineCore.outputText("stretching your tight cunt painfully, the lips opening wide ");
                    if(player.vaginas[0].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("temporarily stretching your cunt-lips wide-open ");
                    if(player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("parting your already gaping lips wide ");
                    EngineCore.outputText("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ");
                    if(player.clitLength > 5) EngineCore.outputText("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ");
                    if(player.clitLength > 2 && player.clitLength <= 5) EngineCore.outputText("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ");
                    if(player.clitLength <= 2) EngineCore.outputText("your " + vaginaDescript(0) + " by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ");
                    EngineCore.outputText("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ");
                    if(player.statusEffectv3(StatusEffects.Eggs) >= 11) EngineCore.outputText("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your " + vaginaDescript(0) + " as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ");
                    EngineCore.outputText("\n\nYou gaze down at the mess, counting " + eggDescript() + ".");
                    player.orgasm();
                    player.dynStats("scale", false);
                }
                EngineCore.outputText("\n\n<b>You feel compelled to leave the eggs behind, ");
                if(player.hasStatusEffect(StatusEffects.AteEgg)) EngineCore.outputText("but you remember the effects of the last one you ate.\n</b>");
                else EngineCore.outputText("but your body's intuition reminds you they shouldn't be fertile, and your belly rumbles with barely contained hunger.\n</b>");
                player.cuntChange(20, true);
                player.createStatusEffect(StatusEffects.LootEgg,0,0,0,0);
                displayedUpdate = true;
                player.knockUpForce(); //Clear Pregnancy
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_COCKATRICE) {
                SceneLib.highMountains.cockatriceScene.cockatriceBirth();
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_LOPPE) {
                SceneLib.loppe.pcGivesBirthToLoppeKits();
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
            }
            if (player.pregnancyType == PregnancyStore.PREGNANCY_QUASI_PHOENIX) {
                SceneLib.highMountains.phoenixScene.phoenixBirth();
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
            }
            return displayedUpdate;
        }

        private function birthVag2():Boolean {
            var displayedUpdate:Boolean = false;
            if(player.fertility < 15) player.fertility++;
            if(player.fertility < 25) player.fertility++;
            if(player.fertility < 40) player.fertility++;
            if(!player.hasStatusEffect(StatusEffects.Birthed)) player.createStatusEffect(StatusEffects.Birthed,1,0,0,0);
            else {
                player.addStatusValue(StatusEffects.Birthed,1,1);
                if(!player.hasPerk(PerkLib.BroodMother) && player.statusEffectv1(StatusEffects.Birthed) >= 10) {
                    EngineCore.outputText("\n<b>You have gained the Brood Mother perk</b> (Pregnancies progress twice as fast as a normal woman's).\n");
                    player.createPerk(PerkLib.BroodMother,0,0,0,0);
                }
            }
            if(player.vaginas.length < 2) {
                outputText("You feel a terrible pressure in your groin... then an incredible pain accompanied by the rending of flesh.  You look down and behold: a vagina");
                player.createVagina();
            }

            //Give birth to either a faerie or a phouka
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_FAERIE) {
                SceneLib.bog.phoukaScene.phoukaPregBirth();
                displayedUpdate = true;
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            //Bive birf to dragons
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_EMBER) {
                emberScene.giveBirthToEmberKids(1);
                displayedUpdate = true;
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_URTA) {
                displayedUpdate = true;
                urtaPregs.PCGivesBirf(1);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_SAND_WITCH) {
                displayedUpdate = true;
                SceneLib.dungeons.desertcave.birthAWitch();
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_IZMA) {
                displayedUpdate = true;
                //Located in izma.as!
                izmaScene.pcPopsOutASharkTot(1);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            //SPOIDAH BIRF
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_SPIDER) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.swamp.maleSpiderMorphScene.spiderPregVagBirth();
            }
            //DRIDER BIRF
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_DRIDER_EGGS) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.swamp.corruptedDriderScene.driderPregVagBirth();
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_COTTON) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
                telAdre.cotton.birthingCottonsKids();
            }
            //GOO BIRF
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_GOO_GIRL) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.lake.gooGirlScene.gooPregVagBirth();
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_BASILISK) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.mountain.basiliskScene.basiliskBirth(1);
            }
            //Satyr vag preg
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_SATYR) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.plains.satyrScene.satyrBirth(true, 1);
            }
            //Give birf if its time... to FROG EGGS
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_FROG_GIRL) {
                SceneLib.bog.frogGirlScene.layFrogEggs(1);
                displayedUpdate = true;
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            //Bunbun birfs
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_BUNNY) {
                EngineCore.outputText("\n");
                displayedUpdate = true;

                EngineCore.outputText("A dangerous rumble comes from your womb, signaling that it's time to birth your body's cargo at last.  Your [legs] wobble unsteadily as your strength ebbs with every gush that erupts  from your now-broken water until you collapse on your [butt], grunting and groaning.  At first it goes slow – there's just a few small contractions that are more strange than anything else, rippling down your " + vaginaDescript(0) + " and squirting out more of your pregnancy's fluid.  All too soon the tempo kicks up, and you feel something starting to stretch you wider and wider.\n\n");

                EngineCore.outputText("You heave and push, instinctively driven to flex muscles you didn't even know you had to speed the super human labor you've entered into.  ");
                if(player.vaginalCapacity() < 60) EngineCore.outputText("It hurts a little as your cervix starts to stretch wide");
                else EngineCore.outputText("It actually feels kind of nice as your cervix is stretched wide");
                EngineCore.outputText(", but somehow your body accommodates the forced dilation without too much discomfort.  It's soon forgotten as you feel your " + vaginaDescript(0) + " pushed into a large sphere, stretched around the inhuman form of your child as it squirms and writhes inside you on its path to freedom.  You grunt and flex, watching with disbelief as a tiny, rabbit-eared form slides from your slick canal into the grass, the process leaving your " + chestDesc() + " heaving with unexpected pleasure.\n\n");

                EngineCore.outputText("The whole process starts over again – there's another one!  By now your well-stretched pussy is oozing both the birthing fluids and your own lubricants, and the second bunny-child slides down to bump into its sibling with ease.  You shake and shudder, groaning and spasming as you nearly cum from the stimulation, but in the end you're left panting and horny.  The two bunnies look like miniature people except for their ears, tails, and fuzzy legs.  Your children lick themselves clean before hopping up onto your " + chestDesc() + " and suckling your nipples for a while");
                if(player.lactationQ() > 500) EngineCore.outputText(", growing fat from all the milk");
                EngineCore.outputText(".  At last they finish, and with one last nuzzle, your strange bunny-children go hopping off, doubtless to find more of their own kind.\n\n");

                EngineCore.outputText("You sink into restful unconsciousness, marveling at how stretchy and sensitive your " + vaginaDescript(1) + " feels now.");
                player.cuntChange(60,true,true,false, 1);
                player.boostLactation(.01);
                //Boost capacity
                if(player.vaginalCapacity(1) < 300) {
                    if(!player.hasStatusEffect(StatusEffects.BonusVCapacity)) player.createStatusEffect(StatusEffects.BonusVCapacity,0,0,0,0);
                    player.addStatusValue(StatusEffects.BonusVCapacity, 1, 10);
                }
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                player.orgasm();
                player.dynStats("lib", 1, "sen", 10, "cor", -2);
            }
            //Anemone birfs
            //Anemone Pregnancy
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_ANEMONE) {
                EngineCore.outputText("\n");
                displayedUpdate = true;

                EngineCore.outputText("Your [armor] feels damp around the groin and you reach down to check the area.  The  " + vaginaDescript(1) + " you feel is dilated and slick with unusual wetness; your water must have broken!\n\n");

                EngineCore.outputText("Hurriedly you strip off your gear and sit down with your back against a rock.  Focusing yourself, you attempt to prepare for labor; you try to remember your recent partners and worry about what kind of monstrous infant you might have to force out of your " + vaginaDescript(1) + ".  The first contraction comes and you push as hard as you can, to be rewarded with the feeling of something sliding out between your labia.  You attempt a few more pushes but nothing further seems forthcoming; curious, you look down at your crotch only to discover a blue stalk sticking proudly out of your vagina!\n\n");

                if(flags[kFLAGS.ANEMONE_KID] > 0 && flags[kFLAGS.DONT_TAKE_ANEMONES_PLEZ] == 0) {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + clitDescript() + "!   It writhes and slips out of your pain-wracked hands, leaving them tingling.  As you lie there, stunned, it begins to inch back toward your " + vaginaDescript(1)+ ".  Footfalls sound next to you, and a blue hand picks up the squirming, cilliated creature.  Kid A gives you a shy smile, then turns to her barrel.  A quick splash and a filled waterskin later, she heads toward the stream, toting your grub-like offspring.");
                    player.cuntChange(20,true,true,false, 1);
                    EngineCore.outputText("\n\nExhausted by the birth but with a burden lifted from your mind, you slip into a grateful doze.");
                    player.knockUpForce(0, 0, 1); //Clear Pregnancy
                    return true;
                }
                else if(player.anemoneCocks() > 0 && player.cor < 25 && flags[kFLAGS.ANEMONE_KID] == 0) {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + clitDescript() + " makes you lock up and nearly takes away your consciousness, and with " + player.multiCockDescript() + " in the way, you can't get any leverage on the pull at all!  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + vaginaDescript(1)+ ".  Searching about weakly with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; shocked into sense, you look at the absurd creature.  You raise your arm to slap at it, but something stays your hand.  As if sensing your hesitation, it stands upright and holds itself at attention for inspection.  It would be easy to knock it away... and yet, the unprepossessing little thing looks so proud that you can't quite bring yourself to do so.");
                    EngineCore.outputText("\n\nYou scoop the diminutive anemone up and look around for somewhere wet to put it.  The stream is too far, the lake doubly so; you'd never make it to either, as sick as you feel from yanking viciously on your clitoris.  Driven to last resorts, you lurch over to the water barrel in your camp and, wrenching the lid off, drop the blue stalk unceremoniously inside.  Exhausted by the shock and pain of the ordeal, you slump down beside the barrel and slip into a doze...");
                    player.cuntChange(20,true,true,false, 1);
                    EngineCore.outputText("\n");
                    player.createStatusEffect(StatusEffects.CampAnemoneTrigger,0,0,0,0);
                    player.knockUpForce(0, 0, 1); //Clear Pregnancy
                    return true;
                }
                //[(if pc has 0-9 existing cocks)
                else if(player.cockTotal() < 10) {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The pain makes you lock up and nearly takes away your consciousness as its sticky surface releases its grip on your labia and " + clitDescript() + "!  The small anemone and you both lay there twitching, but it recovers its bearings first; through your haze of pain you watch it flexing its body, wedging the head under itself, and elevating the base.");
                    player.cuntChange(20,true,true,false, 1);

                    EngineCore.outputText("\n\nBeset by a panic, you watch as the strange thing sets butt-end down on your pubic mound and adheres");
                    //[(if cocks)
                    if(player.cockTotal() > 0) EngineCore.outputText(" below your " + player.multiCockDescriptLight());
                    EngineCore.outputText(". A sharp pinch lances through the nerves in your groin and sends your hands to it reflexively.  This smaller pain, coupled with the adrenaline and dopamine that have finally chased the fog from your head, is enough to pull your thoughts into focus for another attempt to remove your strange, parasitic offspring.  You shift your grip and pull a few more times, but the thing doesn't budge.  The handling of it only serves to make the stalk thicken and become stiff; gradually you notice that you're feeling the sensation of your own pulling not from the skin at the point of attachment but from the stalk itself, and this realization is accompanied by the ring of tentacles opening and pulling back to reveal the crown of a penis!  <b>You have a new anemone-penis!</b>");
                    //[(dick slot 1 exists)
                    if(player.cockTotal() > 0) EngineCore.outputText("  The tentacles writhe around, rubbing against your " + player.multiCockDescriptLight());
                    //(doesn't exist)
                    else EngineCore.outputText("  The tentacles curl inwards, rubbing on the head of your new blue pecker");
                    player.createCock((4+rand(3)),1.2, CockTypesEnum.ANEMONE);
                    EngineCore.outputText(" and you quickly become fully erect from the aphrodisiac they inject.  Over and over the tentacles caress [eachcock] sensually, leaving behind a tingling trail of vibrant pleasure");
                    //[(if no dick1 and no balls)
                    if(player.cockTotal() == 1 && player.balls == 0) EngineCore.outputText("; you feel a pressure build below the shaft, near your asshole");
                    EngineCore.outputText(".  As the venom and the rubbing work you to the edge of climax, your muscles clench and a ");
                    if(player.cumQ() < 100) EngineCore.outputText("glob");
                    else if(player.cumQ() < 500) EngineCore.outputText("squirt");
                    else EngineCore.outputText("spray");
                    EngineCore.outputText(" of semen shoots from your new penis and lands on your ");
                    //[(if boobs)
                    if(player.biggestTitSize() >= 1) EngineCore.outputText(allBreastsDescript() + " and ");
                    EngineCore.outputText("stomach");
                    //[(dick1 exists)
                    if(player.cockTotal() > 1) EngineCore.outputText(", followed in short order by white squirts from [eachcock] remaining");
                    EngineCore.outputText(".  Your " + vaginaDescript(1) + " quivers and pulses as well, adding ");
                    if(player.vaginas[1].vaginalWetness < VaginaClass.WETNESS_SLICK) EngineCore.outputText("a trickle");
                    else if(player.vaginas[1].vaginalWetness < VaginaClass.WETNESS_SLAVERING) EngineCore.outputText("a squirt");
                    else EngineCore.outputText("nearly a cupful of fluid");
                    EngineCore.outputText(" from your female orgasm to the puddle on the ground below your ass.\n\n");
                    Metamorph.unlockMetamorphEx(CockMem.getMemory(CockMem.ANEMONE));
                    //(gain 1 nemo-dick, reduce lust to min)]
                    player.orgasm();
                    player.dynStats("lib", 2, "sen", 5);
                }
                //[(if PC has 10 existing cocks) && no kid
                else {
                    EngineCore.outputText("As you take in the sight, small nodules around the tip begin to form and lengthen, until the little anemone is capped by a mop of wriggling blue-green tentacles.  Horrified, you grasp it at the base and give it a sharp pull.  The ensuing pain in your labia and " + clitDescript() + " makes you lock up and nearly takes away your consciousness, robbing your pull of force.  The anemone detaches weakly, but writhes and slips out of your pain-wracked grip, leaving your hands tingling.  As you lie there, stunned, it begins to inch back toward your " + vaginaDescript(0)+ ".  Casting about with the feelers, it touches along your thigh and searches out the entrance of your pussy.  When the tentacled crown brushes past your lips a venomous heat stirs your crotch and fills you with energy; renewed, you slap at it, trying to knock the little creature away.  Several weak hits land on it, and, almost as if irritated, the tentacles seize on your labia and pull the stalk back toward your crotch and thence into your pussy.  Next you feel the thing shift and flatten itself against your insides, then a pinch on your vaginal walls where the little anemone presses on them.  This can't be good.");
                    player.cuntChange(20,true,true,false, 1);
                    EngineCore.outputText("\n\nPush as you might, you can't get it to peek back out even the slightest bit.  What's worse, the heat isn't subsiding, as the tentacles are now lodged inside your pussy!  Prodding and pulling at your " + vaginaDescript(0) + " is only worsening the effect; [eachcock] and your clitoris harden as you attempt to retrieve your invader.  Your probes get weaker and weaker as your vagina spasms to each stroke of your insides; each time you touch the creature, the sensation is being transmitted right back to your nerves.  Eventually you push yourself to accidental orgasm; your " + vaginaDescript(0) + " quivers around your fingers, and your [cocks] does the best ejaculation it can manage with hardly any warmup time and no direct stimulation.  Even after the orgasm ends, the tentacles continue to torment your groin.  <b>You are VERY horny with this thing inside you... though you can't reach it, maybe there's a way to crowd it out?</b>\n\n");
                    //(reduce lust to min, increased minimum lust by 30 until halfway through PC's next pregnancy)]
                    player.orgasm();
                    player.dynStats("lib", 2, "sen", 5);
                    if(!player.hasStatusEffect(StatusEffects.AnemoneArousal)) player.createStatusEffect(StatusEffects.AnemoneArousal,0,0,0,0);
                    player.buff("AnemoneArousal").setStat("minlustx", 0.3).withText("Anemone parasite");
                }
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                EngineCore.outputText("Exhausted by the 'birth' and the climax, you slip into a doze.\n");
            }
            //Give birth to Celess
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_CELESS){
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                CelessScene.instance.birthScene();
                return false;
            }
            //Birth to harpy
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_HARPY_EGGS){
                EngineCore.outputText("\n");
                //Large egg scene
                EngineCore.outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your [armor] before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ");
                if(player.vaginas[1].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) EngineCore.outputText("stretching your tight cunt painfully, the lips opening wide ");
                if(player.vaginas[1].vaginalLooseness >= VaginaClass.LOOSENESS_LOOSE && player.vaginas[1].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("temporarily stretching your cunt-lips wide-open ");
                if(player.vaginas[1].vaginalLooseness > VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("parting your already gaping lips wide ");
                EngineCore.outputText("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ");
                if(player.clitLength > 5) EngineCore.outputText("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ");
                if(player.clitLength > 2 && player.clitLength <= 5) EngineCore.outputText("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ");
                if(player.clitLength <= 2) EngineCore.outputText("your " + vaginaDescript(1) + " by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ");
                EngineCore.outputText("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ");
                if(player.statusEffectv3(StatusEffects.Eggs) >= 11) EngineCore.outputText("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your " + vaginaDescript(1) + " as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ");
                EngineCore.outputText("\n\nYou gaze down at the mess, counting " + eggDescript() + ".");
                player.orgasm();
                player.dynStats("scale", false);

                EngineCore.outputText("\n\nWhile many of your eggs are not fertile, one in particular stands out. <b>Powerful motherly instinct compels you to keep and protect this egg with your life!</b>" +
                        " This egg is your precious baby and you won't let anyone damage it least of all a big dicked demon." +
                        "\n\nWith unshakable resolve you carefully bring the egg to your nest and proceed to tenderly wrap it in clothes and material to keep it warm when you ain't there to hatch it.");
                SophieFollowerScene.HarpyEggHatching = true;
                player.cuntChange(20, true, false, false, 1);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                player.knockUp(PregnancyStore.PREGNANCY_HARPY_HATCHING, PregnancyStore.PREGNANCY_HARPY_HATCHING, 1, 1); //Set Player to Hatching stage
                return false;
            }

            //Give birth to Zenji kid
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_ZENJI){
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                flags[kFLAGS.EVENT_PARSER_ESCAPE] = 1;//Do not doNext to camp, pregnancy event set ups menu - also if this flag is used can skip adding "return false/true;"
                SceneLib.zenjiScene.birthScene();
            }
            //Give birth if it's time (to an imp!)
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_IMP) {
                EngineCore.outputText("\n");
                //Add imp birth status - used to control frequency of night imp gangbag
                if(player.hasStatusEffect(StatusEffects.BirthedImps)) player.addStatusValue(StatusEffects.BirthedImps,1,1);
                else player.createStatusEffect(StatusEffects.BirthedImps,1,0,0,0);

                EngineCore.outputText("A sudden gush of fluids erupts from your vagina - your water just broke.  You grunt painfully as you feel wriggling and squirming inside your belly, muscle contractions forcing it downwards.  ");
                if(player.cor < 50) EngineCore.outputText("You rue the day you encountered that hateful imp.  ");
                EngineCore.outputText("The pain begins to subside as your delivery continues... replaced with a building sensation of pleasure.  Arousal spikes through you as the contractions intensify, and as you feel something pass you have a tiny orgasm.\n\nYet you feel more within you, and the contractions spike again, pushing you to orgasm as you pass something else.  It repeats, over and over, nearly a dozen times you birth and orgasm.  After an eternity of procreation and pleasure, you sense your ordeal is over and collapse, unconscious.");


                if(player.vaginas[1].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) player.vaginas[1].vaginalLooseness++;
                //50% chance
                if(player.vaginas[1].vaginalLooseness < VaginaClass.LOOSENESS_GAPING_WIDE && rand(2) == 0) {
                    player.vaginas[1].vaginalLooseness++;
                    EngineCore.outputText("\n\n<b>Your cunt is painfully stretched from the ordeal, permanently enlarged.</b>");
                }

                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                EngineCore.outputText("\n\nWhen you wake you find a large number of tiny imp tracks... and a spattering of cum on your clothes and body.  They must be born fully-formed.");
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("  Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(.5);
                }
                //Lactate if large && not lactating
                if(player.biggestTitSize() >= 3 && player.mostBreastsPerRow() > 1 && player.averageLactation() == 0) {
                    EngineCore.outputText("  As you ponder the implications, <b>you realize your breasts have been slowly lactating</b>.  You wonder how much longer it will be before they stop.");
                    player.boostLactation(1);
                }
                player.boostLactation(.01);
                //Enlarge if too small for lactation
                if(player.biggestTitSize() == 2 && player.mostBreastsPerRow() > 1) {
                    EngineCore.outputText("  <b>Your breasts have grown to C-cups!</b>");
                    player.growTits(1, 1, false, 3);
                }
                //Enlarge if really small!
                if(player.biggestTitSize() == 1 && player.mostBreastsPerRow() > 1) {
                    EngineCore.outputText("  <b>Your breasts have grown to B-cups!</b>");
                    player.growTits(1, 1, false, 3);
                }
                if(player.vaginas[1].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[1].vaginalWetness++;
                player.orgasm();
                player.dynStats("tou", -2, "spe", 2, "lib", 1, "sen", .5, "cor", 7);
                if(player.butt.type < 10 && rand(2) == 0) {
                    player.butt.type++;
                    EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                }
                else if(player.hips.type < 10) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                EngineCore.outputText("\n");
                displayedUpdate = true;
            }
            //Give birth if it's time (to a cowgirl!)
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_MARBLE) {
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                player.boostLactation(.01);

                //If you like terrible outcomes
                if(flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 100) {
                    EngineCore.outputText("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble doesn't seem to be around right now, so you can do nothing but push.\n\n");

                    EngineCore.outputText("You push and heave with all your might, little else going through your mind. You somehow register when the head comes out, and soon the shoulders along with the rest of the body follow.  You lean back and pant for a while before feeling a pair of hands grab a hold of you. They slowly and clumsily feel up your body before finding your [chest] and a mouth quickly closes down on a " + nippleDescript(1) + ".  You sigh softly, and drift off to sleep.");
                    player.cuntChange(20,true,true,false, 1);

                    EngineCore.outputText("\n\nEventually you feel a hand on your face, and open your eyes to see Marble looking down at you.  \"<i>Sweetie, are you all right?  Why aren't you pregnant anymore?  Where is our child?</i>\" You stand up and look around.  There is no sign of the baby you were carrying; the child seems to have left after finishing its drink. You never even got to see its face...\n\n");

                    EngineCore.outputText("Marble seems to understand what happened, but is really disappointed with you, \"<i>Sweetie, why couldn't you wait until after I'd finished the nursery...?</i>\"");
                    //Increase PC's hips as per normal, add to birth counter
                }
                else {

                    EngineCore.outputText("\nYou feel a clenching sensation in your belly and something shifts inside.  Your contractions start a few moments later and you realize that it's time for your child to be born.  You cry out mildly in pain and lie down, letting your body start to push the baby out.  Marble rushes over and sees that it's time for you to give birth, so she picks you up and supports you as you continue pushing the child out of your now-gaping " + vaginaDescript(1) + ".");
                    //50% chance of it being a boy if Marble has been purified
                    if(flags[kFLAGS.MARBLE_PURIFIED] > 0 && rand(2) == 0)
                            //it's a boy!
                    {
                        EngineCore.outputText("\n\nFor the next few minutes, you can’t do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It’s a son of mine!</i>\" she tells you, but you can barely hear her due to the focus you’re putting into the task of bringing this child out.");
                        EngineCore.outputText("\n\nYou give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you’ve pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small bull boy cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a boy that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when he came out.");
                        EngineCore.outputText("\n\nShe helps you stand up and gives you the little boy to suckle for yourself.");
                        EngineCore.outputText("\n\nYou put the child to your breast and let him drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It’s a really good feeling, isn’t it?</i>\"  You can’t help but nod in agreement.  After a minute the little boy has had enough and you put him into the nursery.");

                        EngineCore.outputText("The little boy is already starting to look like he is a few years old; he’s trotting around on his little hoofs.");
                        //Increase the size of the PC’s hips, as per normal for pregnancies, increase birth counter
                        if(player.hips.type < 10) {
                            player.hips.type++;
                            EngineCore.outputText("After the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                        }
                        if (flags[kFLAGS.MARBLE_BOYS] == 0)
                                //has Marble had male kids before?
                        {
                            EngineCore.outputText("You notice that Marble seems to be deep in thought, and you ask her what is wrong.  She starts after a moment and says, \"<i>Oh sweetie, no, it's nothing really.  I just never thought that I'd actually be able to father a son is all.  The thought never occurred to me.\"</i>");
                        }
                        //Add to marble-kids:
                        if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) {
                            flags[kFLAGS.MARBLE_KIDS] += 2;
                            flags[kFLAGS.MARBLE_BOYS] += 2;
                        }
                        else {
                            flags[kFLAGS.MARBLE_KIDS]++;
                            flags[kFLAGS.MARBLE_BOYS]++; //increase the number of male kids with Marble
                        }
                    }
                    else // end of new content
                            //it's a girl!
                    {
                        player.cuntChange(20,true,true,false, 1);
                        EngineCore.outputText("\n\nFor the next few minutes, you can't do much else but squeeze the large form inside your belly out.  Marble tries to help a little, pulling your nether lips open even further to make room for the head.  You gasp as you push the head out, and you hear Marble give a little cry of joy.  \"<i>It's a daughter of mine!</i>\" she tells you, but you can barely hear her due to the focus you're putting into the task of bringing this child out.\n\n");
                        EngineCore.outputText("You give an almighty heave and finally manage to push the shoulders out. The rest is downhill from there.  Once you've pushed the child completely out, Marble lays you down on the ground.  You rest there for a few moments, trying to catch your breath after the relatively difficult birthing.  When you finally have a chance to get up, you see that Marble has a small cowgirl cradled in her arms, suckling on her nipple.  You can hardly believe that you managed to push out a girl that big!  Marble seems to understand and tells you that the child is actually a fair bit bigger now than when she came out.\n\n");
                        EngineCore.outputText("She helps you stand up and gives you the little girl to suckle for yourself.  ");
                        if(player.statusEffectv4(StatusEffects.Marble) >= 20) {
                            EngineCore.outputText("As the child contentedly drinks from your " + nippleDescript(0) + ", Marble tells you, \"<i>Sweetie, somehow I know that our kids won't have to worry about the addictive milk.  It will only make them healthy and strong.</i>\"  You nod at her and put the child into the nursery.  ");
                        }
                        else {
                            EngineCore.outputText("You put the child to your breast and let her drink down your milk.  You sigh in contentment and Marble says, \"<i>See sweetie?  It's a really good feeling, isn't it?</i>\"  You can't help but nod in agreement.  After a minute the little girl has had enough and you put her into the nursery.\n\n");
                        }
                        EngineCore.outputText("The little girl is already starting to look like she is a few years old; she's trotting around on her little hooves.");
                        //Add to marble-kids:
                        if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.MARBLE_KIDS] += 2;
                        else flags[kFLAGS.MARBLE_KIDS]++;
                    }
                    //Increase the size of the PC's hips, as per normal for pregnancies, increase birth counter
                    if(player.hips.type < 10) {
                        player.hips.type++;
                        EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                    }
                }
                EngineCore.outputText("\n");
                displayedUpdate = true;
            }
            //Give birth if it's time (to a minotaur!)
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_MINOTAUR) {

                player.boostLactation(.01);
                //Main Text here
                EngineCore.outputText("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it bulges and shifts as another living being moves independently inside you. Instinctively, you spread your legs as you feel the creature press outward, parting your cervix.\n\nYou try to push with your vaginal muscles, but you feel the creature moving more of its own volition. Your lips part as a pair of black-furred hands grip your vulva and begin to spread them and pull. You cry out in agony as your hips are widened forcefully by the passing mass of the being exiting your womb. A bovine face appears, mercifully lacking in horns. Shoulders follow, muscles already rippling on the newborn's form. A thick barrel chest follows, narrow, masculine hips and powerful bovine legs and hooves.\n\nFinally the worst is over as the toddler-sized minotaur gets to his feet, apparently already able to stand and walk.  He clops around your legs and over to your upper body, and takes hold of one of your milk-swollen breasts. He wraps his bestial lips around your nipple and begins to suckle, relieving the pressure on the milk-swollen jug.\n\n");
                EngineCore.outputText("He suckles and suckles and suckles, leaving you to wonder just how much milk you were actually holding, but even as you wonder this, your eyes grow wide as the newborn minotaur begins to grow. He gains inches at a time, his horns starting to grow from his skull, his muscles rippling and thickening, his cock lengthening, his balls swelling. He reaches four feet tall, but keeps growing, soon then five feet tall, starting to resemble more and more the monster who sired him. Finally, he pulls off your breasts, and finishes his milk-inspired growth spurt at six feet tall, looking practically full grown. His one gesture of gratitude for being brought into the world is a slobbery lick at your cheek, then he turns and runs off towards the mountain, leaving you to recover from the ordeal.  You swiftly pass out.\n\n");
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(1);
                }
                player.cuntChange(120, true,true,false, 1);
                if(player.vaginas[1].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[1].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Hip and butt increase
                if(player.butt.type < 12 && rand(2) == 0) {
                    player.butt.type++;
                    EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                }
                else if(player.hips.type < 15) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                EngineCore.outputText("\n");
                //326 Number of sons grown
                //327 Number of sons pending
                //328 growup countdown
                if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.MINOTAUR_SONS_CHILDREN] += 2;
                else flags[kFLAGS.MINOTAUR_SONS_CHILDREN]++;
                if(flags[kFLAGS.MINOTAUR_SONS_GROW_COUNTDOWN] == 0) flags[kFLAGS.MINOTAUR_SONS_GROW_COUNTDOWN] = 150;
            }
            //Amily failsafe - converts PC with pure babies to mouse babies if Amily is corrupted
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_AMILY)
            {
                if(flags[kFLAGS.AMILY_FOLLOWER] == 2 || flags[kFLAGS.AMILY_CORRUPTION] > 0) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancy2Incubation, 1);
            }
            //Amily failsafe - converts PC with pure babies to mouse babies if Amily is with Urta
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_AMILY)
            {
                if(flags[kFLAGS.AMILY_VISITING_URTA] == 1 || flags[kFLAGS.AMILY_VISITING_URTA] == 2) player.knockUpForce(PregnancyStore.PREGNANCY_MOUSE, player.pregnancy2Incubation, 1);
            }
            //Give birth if it's time (to an AMILY BITCH mouse!)
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_AMILY) {
                player.boostLactation(.01);
                EngineCore.outputText("\n");

                //FUCKING BIRTH SHIT HERE.
                amilyScene.pcBirthsAmilysKidsQuestVersion();
                player.cuntChange(60, true, true, false, 1);
                if(player.vaginas[1].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[1].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
                displayedUpdate = true;
                EngineCore.outputText("\n");
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            //Give birth to goblins
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_GOBLIN) {
                player.boostLactation(.01);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                flags[kFLAGS.EVENT_PARSER_ESCAPE] = 1;//Do not doNext to camp, pregnancy event set ups menu - also if this flag is used can skip adding "return false/true;"
                SceneLib.camp.campScenes.goblinsBirthScene(1);
                return false;
            }
            //Give birth if it's time (to a mouse!)
            if ((player.pregnancy2Type == PregnancyStore.PREGNANCY_MOUSE || player.pregnancy2Type == PregnancyStore.PREGNANCY_JOJO)) {
                player.boostLactation(.01);
                EngineCore.outputText("\nYou wake up suddenly to strong pains and pressures in your gut. As your eyes shoot wide open, you look down to see your belly absurdly full and distended. You can feel movement underneath the skin, and watch as it is pushed out in many places, roiling and squirming in disturbing ways. The feelings you get from inside are just as disconcerting. You count not one, but many little things moving around inside you. There are so many, you can't keep track of them.\n\n");


                //Main Text here
                if (player.pregnancy2Type == PregnancyStore.PREGNANCY_JOJO && (monk < 0 || flags[kFLAGS.JOJO_BIMBO_STATE] == 3)) {
                    if (flags[kFLAGS.JOJO_BIMBO_STATE] == 3) {
                        SceneLib.joyScene.playerGivesBirthToJoyBabies();
                        player.knockUpForce(0, 0, 1); //Clear pregnancy
                        return true;
                    }
                    else SceneLib.jojoScene.giveBirthToPureJojoBabies();
                }
                else {
                    EngineCore.outputText("Pain shoots through you as they pull open your cervix forcefully. You grip the ground and pant and push as the pains of labor overwhelm you. You feel your hips being forceably widened by the collective mass of the creatures moving down your birth canal. You spread your legs wide, laying your head back with groans and cries of agony as little white figures begin to emerge from between the lips of your abused pussy. Large innocent eyes, even larger ears, cute little muzzles, long slender pink tails all appear as the figures emerge. Each could be no larger than six inches tall, but they seem as active and curious as if they were already developed children. \n\n");
                    EngineCore.outputText("Two emerge, then four, eight... you lose track. They swarm your body, scrambling for your chest, and take turns suckling at your nipples. Milk does their bodies good, making them grow rapidly, defining their genders as the girls grow cute little breasts and get broader hips and the boys develop their little mouse cocks and feel their balls swell. Each stops suckling when they reach two feet tall, and once every last one of them has departed your sore, abused cunt and drunk their fill of your milk, they give you a few grateful nuzzles, then run off towards the forest, leaving you alone to recover.\n");
                }
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("Your [chest] won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(.5);
                }
                player.cuntChange(60, true,true,false, 1);
                if(player.vaginas[1].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[1].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -2, "spe", 3, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Butt increase
                if(player.butt.type < 14 && rand(2) == 0) {
                    if(player.butt.type < 10) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts grow slower!
                    else if(player.butt.type < 14 && rand(2) == 0) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                EngineCore.outputText("\n");
            }
            //Centaur Baby!
            if ((player.pregnancy2Type == PregnancyStore.PREGNANCY_CENTAUR || player.pregnancy2Type == PregnancyStore.PREGNANCY_KELT)) {
                EngineCore.outputText("\nYou blink, feeling a sudden ache of need radiating from your massive stomach. You can't even get off the ground, it is so heavy... you simply lie on your side, panting with desire, as the convulsions start. New life moves beneath your stomach, ready to be born, and it is time to do your part.\n\n");

                //Main Text here
                player.boostLactation(.01);
                EngineCore.outputText("Perhaps strangely, there is no pain, just a steady, rhythmic compulsion that directs you to breathe steadily and spread your legs as wide as possible. You hardly have to push at all, as the child - no, your child, begins pressing against the walls of your womb, searching for escape. It finds it, and begins the arduous task of squeezing through your cervix, making you gasp with barely concealed pleasure.  It doesn't even hurt; there's only a dull little whisper of happiness followed by a tide of satisfaction.\n\n");
                EngineCore.outputText("The head comes first, and your first thought is relief as you see the face of a small, elfin child.  She's slick with afterbirth and pushing her way free. But the greater part is to come.  She pulls her body free, easily twice as large as her human torso. Soft downy fur with long, spindly legs and a bristly tail... she is a centaur! You help as best as you can, proud of your achievement, but are too exhausted by the ordeal. Your newfound daughter does most of the work.\n\n");
                EngineCore.outputText("She cannot stand, at first, and stumbles over her own shaky legs in a cute, innocent way. She appears to be a six-year old girl, stuck on top of the body of a young foal, and your heart goes out to her involuntarily. She manages to stand at last, wobbling uncertainly, and moves immediately towards your prone form. Knowing her needs, you reveal a breast to her, and she nickers affectionately before latching on, drinking hungrily from your heavily lactating teat.\n\n");
                EngineCore.outputText("She drinks endlessly, and seems more alive and stronger with every gulp. Hours pass in quiet, motherly bliss as she drains your breastmilk first from one breast, then the other. Her little stomach bulges slightly, but she does not stop, and you do not want her to. Even with the strange, soothing effect of the pregnancy wearing off, you feel nothing but affection for this child.\n\n");
                EngineCore.outputText("By the time she is finished, the centaur girl is obviously stronger, able to stand and move about on her own. She explores her new body, jumping and prancing happily, while you lay back and watch, too exhausted to join her. Suddenly, though, her ears perk up, as she looks towards the horizon urgently. She hesitates just long enough to plant a sweet kiss on your cheek, then dashes off, smiling broadly. Exhausted, you are unable to follow... but that comforting sensation returns.  Somehow, you sense she will be all right.");
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("  Your [allbreasts] won't seem to stop dribbling milk, lactating more heavily than before.");
                    player.boostLactation(.5);
                }
                EngineCore.outputText("  ");
                player.cuntChange(120, true, false, false, 1);
                if(player.vaginas[1].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[1].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -4, "spe", 2, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Butt increase
                if(player.butt.type < 14 && rand(2) == 0) {
                    if(player.butt.type < 10) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts grow slower!
                    else if(player.butt.type < 14 && rand(2) == 0) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                EngineCore.outputText("\n");
            }
            //Give birth if it's time (to a hellhound!)
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_HELL_HOUND) {
                EngineCore.outputText("\nYou are suddenly awoken by the heat inside your womb suddenly flaring up rather intensely.  It gives you a sudden charge of energy and you feel a strong need to stand up.  You can feel the two heads moving inside of you and you know that a hellhound will soon be born.  Guided by your instincts, you spread your legs and squat down, but wonder how exactly you are going to pass a creature with two heads?\n\n");

                EngineCore.outputText("Hearing a hiss, you look down to see drops of water hitting the ground and instantly turning to steam.  There is unnatural heat filling you, it's hot enough to boil water; but thanks to the creature inside you, you're barely feeling a thing!  More energy fills you and you begin to push down on the child within in earnest.  The process is painful, but satisfying; you feel like you could push out a mountain with the energy you have right now.  Within a minute, you can feel the heads emerge.  The heads are quickly followed by the rest of the body and you catch your hellhound child in your hands and lift it up to look at it.\n\n");
                EngineCore.outputText("You can see the distinctive dog heads are wrapped around each other and yipping softly; a hint of flame can sometimes be seen inside their mouths.  Its cute paws are waving in the air looking for purchase, but the rest of its body looks entirely human except for the double dicks, and it even has your skin color.  Its mouths are aching for nutrition, and you realize that your breasts are filled with what this pup needs and pull it to your chest.  Each head quickly finds a nipple and begins to suckle.  Having finished the birthing, you contentedly sit back down and bask in the feeling of giving milk to your child, or is it children?\n\n");
                EngineCore.outputText("You sit there in a state of euphoria for some time.  It's not until the child in front of you starts to become uncomfortably hot and heavy, that you are brought back to reality.  You look down to see that the hellhound pup has grown to three times its original size and even sprouted the distinctive layer of tough black fur.  The beast is licking contentedly at your breasts instead of sucking.  It was the now-full flames in its mouth that had broken your reverie, but before you get a real grasp of what had happened, the hellhound pulls away from you and gives you a few quick happy barks before turning around and running off into the wilds, dropping down onto four legs just before disappearing from view.  You feel the unnatural strength you gained during the birth fade away, and you fall into a deep contented sleep.\n\n");
                player.boostLactation(.01);
                //Main Text here
                player.knockUpForce(0,0,1); //Clear Pregnancy
                if(player.averageLactation() > 0 && player.averageLactation() < 5) {
                    EngineCore.outputText("Your breasts won't seem to stop dribbling milk, lactating more heavily than before.  ");
                    player.boostLactation(.5);
                }
                player.cuntChange(60, true, false, false, 1);
                if(player.vaginas[1].vaginalWetness == VaginaClass.WETNESS_DRY) player.vaginas[1].vaginalWetness++;
                player.orgasm();
                player.dynStats("str", -1,"tou", -1, "spe", 2, "lib", 1, "sen", .5);
                displayedUpdate = true;
                //Butt increase
                if(player.butt.type < 14 && rand(2) == 0) {
                    if(player.butt.type < 10) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts grow slower!
                    else if(player.butt.type < 14 && rand(2) == 0) {
                        player.butt.type++;
                        EngineCore.outputText("\n\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                EngineCore.outputText("\n");
            }
            //Give birth to sirens.
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_MINERVA) {

                if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10) SceneLib.mountain.minervaScene.minervaCorruption.corruptPlayerBirth(1);
                else SceneLib.mountain.minervaScene.minervaPurification.playerGivesBirth(1);

                if(player.hips.type < 10) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Give birth to alraune seeds.
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_ALRAUNE) {
                if (player.isAlraune()) {
                    EngineCore.outputText("\n\nWith a sudden gush of nectar you feel something slowly sliding out of you, slowly but steadily prying your body open. Something is coming out and it feels so good, to the point of leaving you spasming periodically.");
                    EngineCore.outputText("\n\nYour eyes roll inward and you feel your consciousness partially shut down from the consecutive orgasms, as you feel seeds the size of an apple each, drop one by one out of a hidden hole under your pitcher that might as well be a second pussy from how sensitive it is. One, two, three... Eventually, you lose count of the seeds as you temporarily lose the capability of rational thought. Before long the ground is littered with your seeds. Both instinct and common sense tell you they won't grow up if you just leave them there, on top of the ground, and as such you proceed to sow them in the fertile earth around your camp, promising to yourself that you will water them everyday. You can’t help but want to do this again as soon as possible.");
                }
                else if (player.isLiliraune()) {
                    EngineCore.outputText("\n\nWith a sudden gush of nectar, you feel that something, somewhere, is slowly sliding out of you, " +
                            "prying your body open with slow but steady progress. Something is coming out and it feels so good, " +
                            "causing you to periodically spasm in reaction to the crashing waves of pleasure rushing to your brain. " +
                            "Your twin sister is in no better condition and you both strongly hug each other, squeezing your breasts together, as both of you go into labor.\n\n" +
                            "\"<i>Ahhhhh sis... it’s coming!</i>\"\n\n" +
                            "\"<i>I feel it too!! Ahhh Cummiiiiing!</i>\"\n\n" +
                            "Your eyes roll inward and both of you orgasm as you feel seeds, " +
                            "each the size of an apple drop, one by one, out of a hidden hole under your pitcher that might as well be a third pussy. " +
                            "Well, you pondered how you would give birth while bathing in your pitcher and now you know. One, two, three... " +
                            "Eventually, you lose count of the seeds as your mind temporarily loses the ability to think rationally.  " +
                            "Before long the ground is covered with seeds, your seeds. Something tells you they won't grow big if you just leave them here on top of the ground, " +
                            "and as such you proceed to bury them in the fertile earth around your camp, promising yourself that you will water them every day. " +
                            "You can’t help but think that you want to do this again as soon as possible.");
                }
                else {
                    EngineCore.outputText("\n\nWith a sudden gush of nectar you feel something slowly sliding out of you, prying your body open with slow but steady progress. Something is coming out and it feels so good, causing you to periodically spasm in reaction to the crashing waves of pleasure rushing to your brain. You pussy starts gushing and you know exactly what is coming next.");
                    EngineCore.outputText("\n\nYour eyes roll inward and you lose yourself to consecutive orgasms as you feel seeds the size of an apple drop, one by one, out of your abused pussy. One, two, three... Eventually, you lose count of the seeds as your mind temporarily loses the ability of rational thought.  Before long the ground is covered with seeds which you proceed to swiftly throw away in the forest. Despite how wrong it was you can’t help but think you want to do this again as soon as possible.");
                }
                if (player.hasMutation(IMutationsLib.GoblinOvariesIM)) flags[kFLAGS.ALRAUNE_SEEDS] += 10;
                else flags[kFLAGS.ALRAUNE_SEEDS] += 5;
                if (flags[kFLAGS.ALRAUNE_GROWING] < 1) flags[kFLAGS.ALRAUNE_GROWING] = 1;
                player.dynStats("lib", 1, "sen", 5);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Give birth to behemoth.
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_BEHEMOTH) {
                SceneLib.volcanicCrag.behemothScene.giveBirthToBehemoth(1);
                if(player.hips.type < 10) {
                    player.hips.type++;
                    EngineCore.outputText("\n\nAfter the birth your [armor] fits a bit more snugly about your " + hipDescript() + ".");
                }
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                EngineCore.outputText("\n");
            }
            //Egg status messages
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
                EngineCore.outputText("\n");
                //Small egg scenes
                if(player.statusEffectv2(StatusEffects.Eggs) == 0) {
                    //light quantity
                    if(player.statusEffectv3(StatusEffects.Eggs) < 10) {
                        EngineCore.outputText("You are interrupted as you find yourself overtaken by an uncontrollable urge to undress and squat.   You berate yourself for giving in to the urge for a moment before feeling something shift.  You hear the splash of fluid on the ground and look down to see a thick greenish fluid puddling underneath you.  There is no time to ponder this development as a rounded object passes down your birth canal, spreading your feminine lips apart and forcing a blush to your cheeks.  It plops into the puddle with a splash, and you find yourself feeling visibly delighted to be laying such healthy eggs.   Another egg works its way down and you realize the process is turning you on more and more.   In total you lay ");
                        EngineCore.outputText(eggDescript());
                        EngineCore.outputText(", driving yourself to the very edge of orgasm.");
                        player.dynStats("lus=", player.maxOverLust(), "scale", false);
                    }
                    //High quantity
                    else {
                        EngineCore.outputText("A strange desire overwhelms your sensibilities, forcing you to shed your [armor] and drop to your hands and knees.   You manage to roll over and prop yourself up against a smooth rock, looking down over your pregnant-looking belly as green fluids leak from you, soaking into the ground.   A powerful contraction rips through you and your legs spread instinctively, opening your " + vaginaDescript(0) + " to better deposit your precious cargo.   You see the rounded surface of an egg peek through your lips, mottled with strange colors.   You push hard and it drops free with an abrupt violent motion.  The friction and slimy fluids begin to arouse you, flooding your groin with heat as you feel the second egg pushing down.  It slips free with greater ease than the first, arousing you further as you bleat out a moan from the unexpected pleasure.  Before it stops rolling on the ground, you feel the next egg sliding down your slime-slicked passage, rubbing you perfectly as it slides free.  You lose count of the eggs and begin to masturbate, ");
                        if(player.clitLength > 5) EngineCore.outputText("jerking on your huge clitty as if it were a cock, moaning and panting as each egg slides free of your diminishing belly.  You lubricate it with a mix of your juices and the slime until ");
                        if(player.clitLength > 2 && player.clitLength <= 5) EngineCore.outputText("playing with your over-large clit as if it were a small cock, moaning and panting as the eggs slide free of your diminishing belly.  You spread the slime and cunt juice over it as you tease and stroke until ");
                        if(player.clitLength <= 2) EngineCore.outputText("pulling your folds wide and playing with your clit as another egg pops free from your diminishing belly.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself until ");
                        EngineCore.outputText("you quiver in orgasm, popping out the last of your eggs as your body twitches nervelessly on the ground.   In total you lay " + eggDescript() + ".");
                        player.orgasm();
                        player.dynStats("scale", false);
                    }
                }
                //Large egg scene
                else {
                    EngineCore.outputText("A sudden shift in the weight of your pregnant belly staggers you, dropping you to your knees.  You realize something is about to be birthed, and you shed your [armor] before it can be ruined by what's coming.  A contraction pushes violently through your midsection, ");
                    if(player.vaginas[1].vaginalLooseness < VaginaClass.LOOSENESS_LOOSE) EngineCore.outputText("stretching your tight cunt painfully, the lips opening wide ");
                    else if(player.vaginas[1].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING_WIDE) EngineCore.outputText("temporarily stretching your cunt-lips wide-open ");
                    else EngineCore.outputText("parting your already gaping lips wide ");
                    EngineCore.outputText("as something begins sliding down your passage.  A burst of green slime soaks the ground below as the birthing begins in earnest, and the rounded surface of a strangely colored egg peaks between your lips.  You push hard and the large egg pops free at last, making you sigh with relief as it drops into the pool of slime.  The experience definitely turns you on, and you feel your clit growing free of its hood as another big egg starts working its way down your birth canal, rubbing your sensitive vaginal walls pleasurably.   You pant and moan as the contractions stretch you tightly around the next, slowly forcing it out between your nether-lips.  The sound of a gasp startles you as it pops free, until you realize it was your own voice responding to the sudden pressure and pleasure.  Aroused beyond reasonable measure, you begin to masturbate ");
                    if(player.clitLength > 5) EngineCore.outputText("your massive cock-like clit, jacking it off with the slimy birthing fluids as lube.   It pulses and twitches in time with your heartbeats, its sensitive surface overloading your fragile mind with pleasure.  ");
                    if(player.clitLength > 2 && player.clitLength <= 5) EngineCore.outputText("your large clit like a tiny cock, stroking it up and down between your slime-lubed thumb and fore-finger.  It twitches and pulses with your heartbeats, the incredible sensitivity of it overloading your fragile mind with waves of pleasure.  ");
                    if(player.clitLength <= 2) EngineCore.outputText("your " + vaginaDescript(0) + " by pulling your folds wide and playing with your clit.  Another egg pops free from your diminishing belly, accompanied by an audible burst of relief.  You make wet 'schlick'ing sounds as you spread the slime around, vigorously frigging yourself.  ");
                    EngineCore.outputText("You cum hard, the big eggs each making your cunt gape wide just before popping free.  You slump down, exhausted and barely conscious from the force of the orgasm.  ");
                    if(player.statusEffectv3(StatusEffects.Eggs) >= 11) EngineCore.outputText("Your swollen belly doesn't seem to be done with you, as yet another egg pushes its way to freedom.   The stimulation so soon after orgasm pushes you into a pleasure-stupor.  If anyone or anything discovered you now, they would see you collapsed next to a pile of eggs, your fingers tracing the outline of your " + vaginaDescript(0) + " as more and more eggs pop free.  In time your wits return, leaving you with the realization that you are no longer pregnant.  ");
                    EngineCore.outputText("\n\nYou gaze down at the mess, counting " + eggDescript() + ".");
                    player.orgasm();
                    player.dynStats("scale", false);
                }
                EngineCore.outputText("\n\n<b>You feel compelled to leave the eggs behind, ");
                if(player.hasStatusEffect(StatusEffects.AteEgg)) EngineCore.outputText("but you remember the effects of the last one you ate.\n</b>");
                else EngineCore.outputText("but your body's intuition reminds you they shouldn't be fertile, and your belly rumbles with barely contained hunger.\n</b>");
                player.cuntChange(20, true, false, true, 1);
                player.createStatusEffect(StatusEffects.LootEgg,0,0,0,0);
                displayedUpdate = true;
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_COCKATRICE) {
                SceneLib.highMountains.cockatriceScene.cockatriceBirth(1);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_LOPPE) {
                SceneLib.loppe.pcGivesBirthToLoppeKits(1);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
            }
            if (player.pregnancy2Type == PregnancyStore.PREGNANCY_QUASI_PHOENIX) {
                SceneLib.highMountains.phoenixScene.phoenixBirth(1);
                player.knockUpForce(0, 0, 1); //Clear Pregnancy
                displayedUpdate = true;
            }
            return displayedUpdate;
        }

        private function eventButt():Boolean {
            var displayedUpdate:Boolean = false;
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(8, player.buttPregnancyType)) {
                    //Egg Maturing
                    EngineCore.outputText("\nYour gut churns, and with a squelching noise, a torrent of transparent slime gushes from your ass.  You immediately fall to your knees, landing wetly amidst the slime.  The world around briefly flashes with unbelievable colors, and you hear someone giggling.\n\nAfter a moment, you realize that it’s you.");
                    //pussy:
                    if(player.hasVagina()) EngineCore.outputText("  Against your [vagina], the slime feels warm and cold at the same time, coaxing delightful tremors from your [clit].");
                    //[balls:
                    else if(player.hasBalls()) EngineCore.outputText("  Slathered in hallucinogenic frog slime, your balls tingle, sending warm pulses of pleasure all the way up into your brain.");
                    //[cock:
                    else if(player.hasCock()) EngineCore.outputText("  Splashing against the underside of your [cocks], the slime leaves a warm, oozy sensation that makes you just want to rub [eachCock] over and over and over again.");
                    //genderless:
                    else EngineCore.outputText("  Your asshole begins twitching, aching for something to push through it over and over again.");
                    EngineCore.outputText("  Seated in your own slime, you moan softly, unable to keep your hands off yourself.");
                    player.dynStats("lus=", player.maxOverLust(), "scale", false);
                    displayedUpdate = true;
                }
            }
            //Pregnancy 4 Satyrs
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) {
                //Stage 1:
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(150, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>You find that you're feeling quite sluggish these days; you just don't have as much energy as you used to.  You're also putting on weight.</b>\n");
                    displayedUpdate = true;
                }
                //Stage 2:
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(125, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>Your belly is getting bigger and bigger.  Maybe your recent urges are to blame for this development?</b>\n");
                    displayedUpdate = true;
                }
                //Stage 3:
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(100, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>You can feel the strangest fluttering sensations in your distended belly; it must be a pregnancy.  You should eat more and drink plenty of wine so your baby can grow properly.  Wait, wine...?</b>\n");
                    displayedUpdate = true;
                }
                //Stage 4:
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(75, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>Sometimes you feel a bump in your pregnant belly.  You wonder if it's your baby complaining about your moving about.</b>\n");
                    displayedUpdate = true;
                }
                //Stage 5:
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(50, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>With your bloating gut, you are loathe to exert yourself in any meaningful manner; you feel horny and hungry all the time...</b>\n");
                    displayedUpdate = true;
                    //temp min lust up +5
                }
                //Stage 6:
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(30, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>The baby you're carrying constantly kicks your belly in demand for food and wine, and you feel sluggish and horny.  You can't wait to birth this little one so you can finally rest for a while.</b>\n");
                    displayedUpdate = true;
                    //temp min lust up addl +5
                }
            }
            //DRIDAH BUTT Pregnancy!
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) {
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(199, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>After your session with the drider, you feel so nice and... full.  There is no outward change on your body, aside from the egg-packed bulge of your belly, but your [asshole] tingles slightly and leaks green goop from time to time. Hopefully it's nothing to be alarmed about.</b>\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(180, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>A hot flush works its way through you, and visions of aroused driders quickly come to dominate your thoughts.  You start playing with a nipple while you lose yourself in the fantasy, imagining being tied up in webs and packed completely full of eggs, stuffing your belly completely with burgeoning spheres of love.  You shake free of the fantasy and notice your hands rubbing over your slightly bloated belly.  Perhaps it wouldn't be so bad?</b>\n");
                    player.dynStats("lib", 1, "sen", 1, "lus", 20);
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(120, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>Your belly is bulging from the size of the eggs growing inside you and gurgling just about any time you walk.  Green goo runs down your [legs] frequently, drooling out of your pregnant asshole.</b>\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(72, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>The huge size of your pregnant belly constantly impedes your movement, but the constant squirming and shaking of your unborn offspring makes you pretty sure you won't have to carry them much longer.");
                    EngineCore.outputText("</b>\n");
                    displayedUpdate = true;
                }
            }
            //Bee Egg's in butt pregnancy
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BEE_EGGS) {
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(36, player.buttPregnancyType)) {
                    EngineCore.outputText("<b>\nYou feel bloated, your bowels shifting uncomfortably from time to time.</b>\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(20, player.buttPregnancyType)) {
                    EngineCore.outputText("<b>\nA honey-scented fluid drips from your rectum.</b>  At first it worries you, but as the smell fills the air around you, you realize anything with such a beautiful scent must be good.  ");
                    if(player.cockTotal() > 0) EngineCore.outputText("The aroma seems to permeate your very being, slowly congregating in your ");
                    if(player.cockTotal() == 1) {
                        EngineCore.outputText(cockDescript(0));
                        if(player.horseCocks() == 1) EngineCore.outputText(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your [cock] is twitching and dripping, the flare swollen and purple.  ");
                        if(player.dogCocks() == 1) EngineCore.outputText(", each inhalation making it thicker, harder, and firmer.  You suck in huge lungfuls of air, desperate for more, until your [cock] is twitching and dripping, its knot swollen to the max.  ");
                        if(player.normalCocks() == 1) EngineCore.outputText(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air, until your [cock] is twitching and dripping, the head swollen and purple.  ");
                        //FAILSAFE FOR NEW COCKS
                        if(player.normalCocks() == 0 && player.dogCocks() == 0 && player.horseCocks() == 0) EngineCore.outputText(", each inhalation making it bigger, harder, and firmer.  You suck in huge lungfuls of air until your [cock] is twitching and dripping.  ");
                    }
                    if(player.cockTotal() > 1) EngineCore.outputText("groin.  Your [cocks] fill and grow with every lungful of the stuff you breathe in.  You suck in great lungfuls of the tainted air, desperate for more, your cocks twitching and dripping with need.  ");
                    EngineCore.outputText("You smile knowing you couldn't stop from masturbating if you wanted to.\n");
                    player.dynStats("int", -.5, "lus", 500);
                    displayedUpdate = true;
                }
            }
            //Sand Tarps in butt pregnancy
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP || player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) {
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(36, player.buttPregnancyType)) {
                    //(Eggs take 2-3 days to lay)
                    EngineCore.outputText("<b>\nYour bowels make a strange gurgling noise and shift uneasily.  You feel ");
                    if(player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) EngineCore.outputText(" bloated and full; the sensation isn't entirely unpleasant.");
                    else {
                        EngineCore.outputText("increasingly empty, as though some obstructions inside you were being broken down.");
                        player.buttKnockUpForce(); //Clear Butt Pregnancy
                    }
                    EngineCore.outputText("</b>\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(20, player.buttPregnancyType)) {
                    //end eggpreg here if unfertilized
                    EngineCore.outputText("\nSomething oily drips from your sphincter, staining the ground.  You suppose you should feel worried about this, but the overriding emotion which simmers in your gut is one of sensual, yielding calm.  The pressure in your bowels which has been building over the last few days feels right somehow, and the fact that your back passage is dribbling lubricant makes you incredibly, perversely hot.  As you stand there and savor the wet, soothing sensation a fantasy pushes itself into your mind, one of being on your hands and knees and letting any number of beings use your ass, of being bred over and over by beautiful, irrepressible insect creatures.  With some effort you suppress these alien urges and carry on, trying to ignore the oil which occasionally beads out of your [asshole] and stains your [armor].\n");
                    player.dynStats("int", -.5, "lus", 500);
                    displayedUpdate = true;
                }
            }
            //Bunny TF buttpreggoz
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BUNNY) {
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(800, player.buttPregnancyType)) {
                    EngineCore.outputText("\nYour gut gurgles strangely.\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(785, player.buttPregnancyType)) {
                    CoC.instance.mutations.neonPinkEgg(true,0,player);
                    EngineCore.outputText("\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(776, player.buttPregnancyType)) {
                    EngineCore.outputText("\nYour gut feels full and bloated.\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(765, player.buttPregnancyType)) {
                    CoC.instance.mutations.neonPinkEgg(true,0,player);
                    EngineCore.outputText("\n");
                    displayedUpdate = true;
                }
                if(player.buttPregnancyIncubation == sceneHunter.adjustPregEventTimer(745, player.buttPregnancyType)) {
                    EngineCore.outputText("\n<b>After dealing with the discomfort and bodily changes for the past day or so, you finally get the feeling that the eggs in your ass have dissolved.</b>\n");
                    displayedUpdate = true;
                    player.buttKnockUpForce(); //Clear Butt Pregnancy
                }
            }
            return displayedUpdate;
        }

        private function birthButt():Boolean {
            var displayedUpdate:Boolean = false;
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) {
                SceneLib.bog.frogGirlScene.birthFrogEggsAnal();
                displayedUpdate = true;
                player.buttKnockUpForce(); //Clear Butt Pregnancy
            }
            //Give birf if its time... to ANAL EGGS
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_DRIDER_EGGS) {
                SceneLib.swamp.corruptedDriderScene.birthSpiderEggsFromAnusITSBLEEDINGYAYYYYY();
                displayedUpdate = true;
                player.buttKnockUpForce(); //Clear Butt Pregnancy
            }
            //GIVE BIRF TO TRAPS
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SANDTRAP_FERTILE) {
                SceneLib.desert.sandTrapScene.birfSandTarps();
                player.buttKnockUpForce(); //Clear Butt Pregnancy
                if(player.butt.type < 17) {
                    //Guaranteed increase up to level 10
                    if(player.butt.type < 13) {
                        player.butt.type++;
                        EngineCore.outputText("\nYou notice your [butt] feeling larger and plumper after the ordeal.\n");
                    }
                    //Big butts only increase 50% of the time.
                    else if(rand(2) == 0){
                        player.butt.type++;
                        EngineCore.outputText("\nYou notice your [butt] feeling larger and plumper after the ordeal.\n");
                    }
                }
                displayedUpdate = true;
            }
            //Give birth (if it's time) to beeeeeeez
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_BEE_EGGS) {
                EngineCore.outputText("\n");
                EngineCore.outputText("There is a sudden gush of honey-colored fluids from your ass.  Before panic can set in, a wonderful scent overtakes you, making everything ok.  ");
                if(player.cockTotal() > 0) EngineCore.outputText("The muzzy feeling that fills your head seems to seep downwards, making your equipment hard and tight.  ");
                if(player.vaginas.length > 0) EngineCore.outputText("Your " + vaginaDescript(0) + " becomes engorged and sensitive.  ");
                EngineCore.outputText("Your hand darts down to the amber, scooping up a handful of the sticky stuff.  You wonder what your hand is doing as it brings it up to your mouth, which instinctively opens.  You shudder in revulsion as you swallow the sweet-tasting stuff, your mind briefly wondering why it would do that.  The stuff seems to radiate warmth, quickly pushing those nagging thoughts away as you scoop up more.\n\n");
                EngineCore.outputText("A sudden slip from below surprises you; a white sphere escapes from your anus along with another squirt of honey.  Your drugged brain tries to understand what's happening, but it gives up, your hands idly slathering honey over your loins.  The next orb pops out moments later, forcing a startled moan from your mouth.  That felt GOOD.  You begin masturbating to the thought of laying more eggs... yes, that's what those are.  You nearly cum as egg number three squeezes out.  ");
                if(player.averageLactation() >= 1 && player.biggestTitSize() > 2) EngineCore.outputText("Seeking even greater sensation, your hands gather the honey and massage it into your " + breastDescript(0) + ", slowly working up to your nipples.  Milk immediately begins pouring out from the attention, flooding your chest with warmth.  ");
                EngineCore.outputText("Each egg seems to come out closer on the heels of the one before, and each time your conscious mind loses more of its ability to do anything but masturbate and wallow in honey.\n\n");
                EngineCore.outputText("Some time later, your mind begins to return, brought to wakefulness by an incredibly loud buzzing...  You sit up and see a pile of dozens of eggs resting in a puddle of sticky honey.  Most are empty, but a few have hundreds of honey-bees emptying from them, joining the massive swarms above you.  ");
                if(player.cor < 35) EngineCore.outputText("You are disgusted, but glad you were not stung during the ordeal.  You stagger away and find a brook to wash out your mouth with.");
                if(player.cor >= 35 && player.cor < 65) EngineCore.outputText("You are amazed you could lay so many eggs, and while the act was strange there was something definitely arousing about it.");
                if(player.cor >= 65 && player.cor < 90) EngineCore.outputText("You stretch languidly, noting that most of the drugged honey is gone.  Maybe you can find the Bee again and remember to bottle it next time.");
                if(player.cor >= 90) EngineCore.outputText("You lick your lips, savoring the honeyed residue on them as you admire your thousands of children.  If only every night could be like this...\n");
                player.buttKnockUpForce(); //Clear Butt Pregnancy
                player.orgasm();
                player.dynStats("int", 1, "lib", 4, "sen", 3);
                if(player.buttChange(20, true)) EngineCore.outputText("\n");
                if(player.butt.type < 17) {
                    //Guaranteed increase up to level 10
                    if(player.butt.type < 13) {
                        player.butt.type++;
                        EngineCore.outputText("\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                    //Big butts only increase 50% of the time.
                    else if(rand(2) == 0){
                        player.butt.type++;
                        EngineCore.outputText("\nYou notice your [butt] feeling larger and plumper after the ordeal.");
                    }
                }
                EngineCore.outputText("\n");
                displayedUpdate = true;
            }
            //Satyr butt preg
            if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) {
                player.buttKnockUpForce(); //Clear Butt Pregnancy
                displayedUpdate = true;
                SceneLib.plains.satyrScene.satyrBirth(false);
            }
            return displayedUpdate;
        }

    // Unusual checks that are separated for some reason
    // I'm sorry if they NEEDED
    private function birthSpecial():Boolean {
        var displayedUpdate:Boolean = false;
        if (player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT && player.pregnancyIncubation <= 2) {
            if(model.time.hours != 5 && model.time.hours != 6) {
                player.knockUpForce(player.pregnancyType, 3); //Make sure eggs are only birthed early in the morning
            }
            else {
                player.knockUpForce(); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.bazaar.benoit.popOutBenoitEggs();
            }
        }
        if (player.pregnancy2Type == PregnancyStore.PREGNANCY_BENOIT && player.pregnancy2Incubation <= 2) {
            if(model.time.hours != 5 && model.time.hours != 6) {
                player.knockUpForce(player.pregnancy2Type, 3, 1); //Make sure eggs are only birthed early in the morning
            }
            else {
                player.knockUpForce(0,0,1); //Clear Pregnancy
                displayedUpdate = true;
                SceneLib.bazaar.benoit.popOutBenoitEggs();
            }
        }
        if ((player.pregnancyType == PregnancyStore.PREGNANCY_HARPY_HATCHING && player.pregnancyIncubation <= 2) ||
                (player.pregnancy2Type == PregnancyStore.PREGNANCY_HARPY_HATCHING && player.pregnancy2Incubation <= 2)) {
            if(model.time.hours != 5 && model.time.hours != 6) {
                if (player.pregnancyType == PregnancyStore.PREGNANCY_HARPY_HATCHING) player.knockUpForce(player.pregnancyType, 3); //Make sure eggs are only birthed early in the morning
                if (player.pregnancy2Type == PregnancyStore.PREGNANCY_HARPY_HATCHING) player.knockUpForce(player.pregnancy2Type, 3, 1); //Make sure eggs are only birthed early in the morning
            }
            else if (SophieFollowerScene.HarpyEggReady) {
                if (player.pregnancyType == PregnancyStore.PREGNANCY_HARPY_HATCHING) {
                    SophieFollowerScene.HarpyKids += 1;
                    player.knockUpForce(); //Clear Pregnancy
                }
                if (player.pregnancy2Type == PregnancyStore.PREGNANCY_HARPY_HATCHING) {
                    SophieFollowerScene.HarpyKids += 1;
                    player.knockUpForce(0, 0, 1); //Clear Pregnancy
                }
                outputText("\nAs the dawn rises over Mareth your egg begins shaking of its own volition. What you have been waiting for so long is finally happening. As your child kicks the egg cover open revealing her bird leg." +
                        "\n\nWith tender care you help remove the egg shards so that she can move out without hurting herself." +
                        " Harpies are no regular birds, it's the mother's duty to help her child leave the egg harmlessly seeing as the border could leave harmful cuts on the chick." +
                        " Satisfied that your daughter successfully got out of the egg you cradle her in your wings and keep her warm while her duvet dries up." +
                        " Unlike human babies, harpie are born with feathers and thus there is no such thing as a bald chick." +
                        "\n\nAs feeding your daughter is your first priority, you spend the better part of the morning flying around looking for seeds and other things to nourish your chick." +
                        " Thankfully Mareth somewhat warped space limits the time you need to do this before your baby is actually capable of flying and feeding on her own to a few hours only." +
                        " While capable of talking and fending for herself now your kid still decides to settle nearby");
                if (SophieFollowerScene.HarpyKids > 1) outputText(" with your other daughters");
                outputText(" using a rocky cliff as her nesting ground." +
                        " Well while keeping her from trying to bug any male in your camp could be a challenge in the near future at least you can keep on watching her like the good parent you are." +
                        " Come to think about it, you blush as fantasies of getting your womb filled with a brand new egg fills your mind causing your stretched harpy pussy to drip in anticipation." +
                        " Guess it's back to milking males of their semens for you.");
                SophieFollowerScene.HarpyEggReady = false
                displayedUpdate = true;
            }
            else {
                if (player.pregnancyType == PregnancyStore.PREGNANCY_HARPY_HATCHING) player.knockUpForce(player.pregnancyType, 3); //Make sure eggs are only birthed early in the morning
                if (player.pregnancy2Type == PregnancyStore.PREGNANCY_HARPY_HATCHING) player.knockUpForce(player.pregnancy2Type, 3, 1); //Make sure eggs are only birthed early in the morning
            }
        }
        return displayedUpdate;
    }

    public function eggDescript(plural:Boolean = true):String {
        var descript:String = "";
        if(player.hasStatusEffect(StatusEffects.Eggs)) {
            descript += num2Text(player.statusEffectv3(StatusEffects.Eggs)) + " ";
            //size descriptor
            if(player.statusEffectv2(StatusEffects.Eggs) == 1) descript += "large ";
            /*color descriptor
            0 - brown - ass expansion
            1 - purple - hip expansion
            2 - blue - vaginal removal and/or growth of existing maleness
            3 - pink - dick removal and/or fertility increase.
            4 - white - breast growth.  If lactating increases lactation.
            5 - rubbery black -
            */
            var eggDesc:Array = ["brown", "purple", "blue", "pink", "white", "rubbery black"];
            descript += eggDesc[player.statusEffectv1(StatusEffects.Eggs)];
            //EGGS
            if(plural) descript += " eggs";
            else descript += " egg";
            return descript;
        }
        CoC_Settings.error("");
        return "EGG ERRORZ";
    }
}
}
