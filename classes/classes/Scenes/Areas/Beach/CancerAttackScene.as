/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Areas.Beach 
{
import classes.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.display.SpriteDb;

public class CancerAttackScene extends BaseContent
	{
		
		public function CancerAttackScene()
		{
		}

        private function sprite():void {
			if (monster.hasCock()) spriteSelect(SpriteDb.s_crabboy);
			else spriteSelect(SpriteDb.s_crabgirl);
        }

		public function encounter():void {
			clearOutput();
			var isFemale:Boolean = rand(2) == 0;
			monster = new CancerAttack(isFemale);
			sprite();
			if (player.lowerBody == LowerBody.CANCER) {
				outputText("As you explore the beach you begin to feel the sand rumble under your feet… just what the hell is going on?\n\n" +
						"You indeed are answered shortly afterward as a huge pincers surge out of the sand beneath you and try to grab you, " +
						"however your large chitinous lower body proves to big for the pincer of your attacker which simply dig itself up to see what is going on. " +
						"At the other end of the pincer which attempted to grab you is the massive chitinous body of a cancer, still partially covered in sand, " +
						"a smaller form atop it with the physiognomy of a young human from the waist up. It would seem [monster he] is a "+(isFemale ? "female":"male")+". " +
						"[monster He] looks at you with the classic gaze devoid of emotion and flatly declares [monster his] intentions.\n\n" +
						"<i>\"Hey... you are hunting in my ground go away.\"</i>\n\n" +
						"Annoyed you declare equally flatly that you are not hunting as much as exploring the beach and that you have full right to go wherever you want. " +
						"The other cancer legs and pincers move in annoyance to pass on the message [monster his] face won’t, " +
						"it sure didn’t like getting disturbed over nothing but now that you are here and ruined [monster his] ambush [monster he] might as well just deal with it. " +
						"You stutter an apology in the same way and proceed to skitter away. " +
						"This exchange actually proved somewhat enlightening for you in a way as you manage to keep some interesting social experience from this.");
				doNext(camp.returnToCampUseOneHour);
			} else if (player.lowerBody == LowerBody.GOO) {
				outputText("As you explore the beach you begin to feel the sand rumble under your feet… just what the hell is going on?\n\n" +
						"You indeed are answered shortly afterward as a huge pincers surge out of the sand before you and try to grab you! " +
						"It does indeed grab you for a second before you just simply slide out of its grip thanks to your fluid form. " +
						"At the other end of the pincer that tried to hold you is the massive chitinous body of a crab, still partially covered in sand, " +
						"a smaller form atop it with the physiognomy of a young human from the waist up. " +
						"[monster He] looks at you with a gaze devoid of emotion and flatly declares.\n\n" +
						"<i>\"Damn It… had to be a slime… not worth the effort.\"</i>\n\n" +
						"[monster His] flat tone and somewhat blank stare couldn’t make this sentence sound more boring. " +
						"The cancer simply digs back in its hole out of your reach. A victory is a victory though and in its haste to escape the crab person left gems on the ground" +
						" wich you hastily take before leaving. That and you do gain the experience that crabs aren’t fans of things with a fluid body.");
				doNext(camp.returnToCampUseOneHour);
			} else {
				outputText("As you explore the beach you begin to feel the sand rumble under your feet… just what the hell is going on?\n\n" +
						"You indeed are answered shortly afterward as a huge pincers surge out of the sand before you and try to grab you ");
				if (player.spe < 150) {
					outputText("wich it does manage to. You begin to struggle as the rest of the creature’s body moves out of the sand and you are lifted up into the air along with the pincer. " +
							"At the other end of the pincer that tried to hold you is the massive chitinous body of a crab, still partially covered in sand, " +
							"a smaller form atop it with the physiognomy of a young human from the waist up. " +
							"[monster He] looks at you with a gaze devoid of emotion and flatly declares.\n\n" +
							"<i>\"Ah…so I caught a [man].\"</i>\n\n" +
							"Despite [monster his] flat tone and somewhat blank stare it's clear that what [monster he] intends to do with you will result into nothing good.\n\n" +
							"<i>\"Don’t struggle… the mating will be both swift and nice.\"</i>\n\n" +
							"You sure would struggle but the way [monster he]’s squeezing you right now left you gasping for air and begging for mercy. " +
							"Gosh, [monster he]’s totally going to have [monster his] way with you.");
					doNext(rape);
				} else {
					outputText("Thankfully your peerless reflexes allows you to move out of range just in time. " +
							"The creature follows you as it moves out of the sand, revealing the massive chitinous body of a crab, a smaller form atop it with the physiognomy of a young "+(isFemale ? "woman":"men")+" from the waist up. " +
							"[monster He] looks at you with a gaze devoid of emotion and flatly declares.\n\n" +
							"<i>\"Ah…so I caught a [man].\"</i>\n\n" +
							"Despite [monster his] flat tone and somewhat blank stare it's clear that what [monster he] intends to do with you will result into nothing good.\n\n" +
							"<i>\"Don’t struggle… the mating will be both swift and nice.\"</i>\n\n" +
							"At that [monster he] passively lick [monster his] lip. Yea no way you are letting [monster him] do that! ");
					startCombat(monster);
				}
			}
		}

        public function rape():void {
            clearOutput();
            // the scene
            if (monster.hasCock())
                maleRape();
            else
                femaleRape();
            //
			cleanupAfterCombat();

            //SCENES
            //==========================================================================================
            function maleRape():void {
                outputText("The cancer looks at you for a full minute, considering your body before smiling, " +
                        "though his eyes retain the same blank expression as before, making the smile even more awkward.\n\n" +
                        "<i>\"I’m going to enjoy this…\"</i>\n\n" +
                        "He grabs you with his pincer and pulls you closer. The mandibles at the junction between his human and crab body part to reveal a frothing penis. " +
                        "Wow you didn’t expect from the look of his face that he was getting off already, or maybe it's how he is at all times?");
                if (!player.hasVagina() || rand(2) == 0 && sceneHunter.uniHerms) {
                    outputText("He moves you all the way to him");
                    if (!player.isNaga() && !player.lowerBody != LowerBody.MELKIE && !player.lowerBody != LowerBody.GOO) outputText(" and proceeds to pull one of your legs away with his free pincer");
                    outputText("  slowly and forcefully shoving you onto his cock like a sleeve. You gasp as he begins to use you like a sex toy denying your movement in favor of simply sliding you up and down his cock. " +
                            "It’s still sex, albeit not on your terms. This guy is controlling the entire encounter, spearing you at his leisure.");
                    if (player.looseness() < 2) outputText(" Thankfully, his rod isn’t too small, or you wouldn’t be getting any pleasure from this. To be honest, you’ve even begun to enjoy yourself despite the situation.");
                    outputText("\n\n<i>\"Ahhh… cumming…\"</i>\n\n" +
                            "Unsurprisingly, even his orgasmic expression is barely different from his normal pleasured one but you can feel in his bodily movement and the massive bubbling splash in your hole that he's enjoying himself. " +
                            "Your pussy also did achieve orgasm through yours was way louder than his. " +
                            "Satisfied with this, he simply drops you on the sand, still in the afterglow, and digs himself back into the hole he came from. " +
                            "Still panting, you proceed to slowly redress as you make your way back to camp.");
                    player.sexReward("cum","Vaginal");
                }
                else {
                    outputText("He turns you over and pulls you all the way to him slowly and forcefully shoving his cock into your butt hole. You gasp as he begins to use you like a sex toy denying your movement in favor of simply sliding you up and down his cock. " +
                            "This guy is controlling the entire event, spearing and stretching you at his leisure. He barely relent a minute later so to speak.\n\n" +
                            "<i>\"Ahhh… cumming…\"</i>\n\n" +
                            "Unsurprisingly, even his orgasmic tone is barely different from his normal pleasured one but you can feel in his bodily movement and the massive bubbling splash in your hole that he's enjoying himself. Satisfied with this he simply let you fall prone on the sand and dig himself back into the hole he came from. Ugh what a bugger. " +
                            "You proceed to slowly redress as you make your way back to camp.\n");
                    player.sexReward("cum","Anal");
                }
            }

            function femaleRape():void {
                clearOutput();
                if (!player.hasVagina() && !player.hasCock()){
                    outputText("The cancer looks at you for a full minute and considers your body for a moment before shrugging." +
                            "<i>\"Know what? I’m not interested anymore. See ya.\"</i>\n\n" +
                            "Wait... seriously, [monster he] let you off like that? [monster He]’s gives this little of a fuck that [monster he] won't even bother raping you? " +
                            "Something tells you this luck won’t last and so you hurry and scram");
                    if (silly()) outputText(" while the cancer discusses with a man in a black suit how [monster he]'s not paid enough by producer Liadri to perform a proper raping job");
                    outputText(".")
                } else {
                    outputText("The cancer looks at you for a full minute and considers your body for a moment before smiling, " +
                            "except her eyes kept the same blank expression of earlier which makes the small smile only more awkward.\n\n" +
                            "<i>\"I’m going to enjoy this…\"</i>\n\n" +
                            "She grabs you in her pincer and pulls you closer. The mandibula at the junction between her human and cancer body parting away to reveal a literally foaming pussy. " +
                            "Wow you didn’t expect from the look of her face that she was this wet already. " +
                            "She pulls you all the way to her, hugging your body with her human arms as she forcefully shoves your nethers against her wet, frothing hole. " +
                            "You consider for a moment to deny her then realise she's still holding you in her pincer which means you could probably crush you at a moment's notice if she wanted.");
                    if (player.hasVagina() && (!player.hasCock() || !sceneHunter.uniHerms || rand(2) == 0)) {
                        outputText(" You gently begin to rub your pussy against the girl's bubbling mess making her gasp in delight. " +
                                "Thankfully, she controls her pincers well enough not to squeeze you to death during the mating session, something you’re very relieved about. " +
                                "Her pussy keeps gushing every time you rub yourself against her, and to be honest, you’ve begun to enjoy yourself despite your predicament.\n\n" +
                                "<i>\"Ahhh… cumming…\"</i>\n\n" +
                                "Unsurprisingly even her orgasmic expression is barely different from her normal pleasured one but you can feel in her bodily movement and the massive bubbling splash on your bottom half that she's enjoying herself. " +
                                "Your own pussy also did achieve orgasm through yours was way louder than hers. " +
                                "Satisfied with this, she simply drops you on the sand, still in the afterglow, and digs herself back into the hole she came from. " +
                                "Still panting, you proceed to slowly redress as you make your way back to camp.\n")
                        player.sexReward("vaginalFluids","Vaginal");
                    } else if (player.hasCock()) {
                        outputText("You gently begin to insert your hardening cock inside the girl bubbling mess making her gasp in delight, her pussy squeezing your cock like a vice. " +
                                "She thankfully controls her pincers and pussy well enough not to squeeze you to death while in the middle of a mating session something you are very relieved off. " +
                                "Aware that staying immobile could spell something very bad for you you proceed to methodically fuck her bubbling hole something she rewards by weakening the death grip of her claw on you merely holding you in place now. " +
                                "Her cunt gushes everytime you insert yourself in her, and to be honest, you have begun to enjoy yourself as well despite your predicament.\n\n" +
                                "<i>\"Ahhh… cumming…\"</i>\n\n" +
                                "Unsurprisingly even her orgasmic expression is barely different from her normal pleasured one but you can feel in her bodily movement and the massive bubbling splash on your bottom half that she's enjoying herself. " +
                                "Your penis also does achieve orgasm, your cum mixing in with her foam as you fertilize her hole thoroughly, though your own moan was way louder than hers. " +
                                "Satisfied with this, she simply drops you on the sand, still in the afterglow, and digs herself back into the hole she came from. Still panting, you proceed to slowly redress as you make your way back to camp.")
                        player.sexReward("vaginalFluids","Dick");
                    }
                }
            }
        }

		public function defeat():void {
			clearOutput();
			outputText("The cancer, defeated, escapes by digging [monster his] way underground. Wow, what a sore loser!");
			if (silly()) outputText("You ought to tell this stupid show producer miss Liadri about how her crabs dig their escapes instead of calmly letting themselves be raped!");
			cleanupAfterCombat();
		}
	}
}